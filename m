Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9503C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3F383409;
	Fri, 23 May 2025 19:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0467183394; Fri, 23 May 2025 19:20:35 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330F6833EB
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4M-0076pt-PU;
 Fri, 23 May 2025 17:20:30 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 10/13] board: venice: add FSA support
Date: Fri, 23 May 2025 10:20:15 -0700
Message-Id: <20250523172018.4164647-10-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The Gateworks Flexible Socket Adapters adapt common
busses such as SDIO/UART/USB/PCI to various connectors
such as M.2 B-Key, M.2 E-Key, M.2 M-Key, and MiniPCIe.

Each FSA has an EEPROM onboard describing its details as well as an
optional port-expander for configurable GPIO's.

Add support for identifying the FSA's and configuring their
details such as user description and GPIO's:
 - enable pca953x, pca954x and eeprom support for communicating
   with the I2C eeprom and gpio port expander on the FSA
 - add FSA detection support
 - add FSA gpio configuration support

Each FSA is identified in the device-tree by an alias to it's I2C
bus where an eeprom@54 node must exist as well as an gpio@20 node
for an io-expander. These nodes must be enabled so that
they can be probed to determine if they are actually present in
the system. If not present or not enabled the gpio expander can
not be used. This also requires livetree as the gpio expander
node if not present must be disabled.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/fsa.c           | 736 ++++++++++++++++++++++++++++++++
 board/gateworks/fsa.h           |  51 +++
 board/gateworks/venice/Makefile |   1 +
 board/gateworks/venice/eeprom.c |   3 +
 board/gateworks/venice/venice.c |   7 +
 configs/imx8mm_venice_defconfig |   5 +
 configs/imx8mn_venice_defconfig |   5 +
 configs/imx8mp_venice_defconfig |   5 +
 8 files changed, 813 insertions(+)
 create mode 100644 board/gateworks/fsa.c
 create mode 100644 board/gateworks/fsa.h

diff --git a/board/gateworks/fsa.c b/board/gateworks/fsa.c
new file mode 100644
index 000000000000..1af8021057c4
--- /dev/null
+++ b/board/gateworks/fsa.c
@@ -0,0 +1,736 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 Gateworks Corporation
+ */
+
+#include <command.h>
+#include <hexdump.h>
+#include <i2c.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h> // device_remove/device_unbind
+#include <asm-generic/gpio.h>
+#include <fdt_support.h>
+#include <linux/delay.h>
+
+#include "fsa.h"
+
+static int fsa;
+static struct udevice *fsa_gpiodevs[FSA_MAX] = { NULL };
+
+/* find the ofnode of the FSA i2c bus */
+static ofnode fsa_get_ofnode(int fsa)
+{
+	char str[32];
+
+	/* by alias */
+	snprintf(str, sizeof(str), "fsa%d", fsa);
+	return ofnode_get_aliases_node(str);
+}
+
+static int fsa_get_dtnode(void *fdt, int fsa)
+{
+	char str[32];
+
+	/* by alias */
+	snprintf(str, sizeof(str), "fsa%d", fsa);
+	return fdt_path_offset(fdt, fdt_get_alias(fdt, str));
+}
+
+static const char * const fsa_gpio_config_names[] = { "NC", "", "input", "output-low",
+						      "output-high" };
+
+static const char *fsa_gpio_config_name(struct fsa_gpio_desc *desc)
+{
+	if (desc->config < ARRAY_SIZE(fsa_gpio_config_names))
+		return fsa_gpio_config_names[desc->config];
+	return NULL;
+};
+
+static char *fsa_get_gpio_desc(struct fsa_gpio_desc *desc, char *str, int sz)
+{
+	str[0] = 0;
+	if (desc->source == 0xff) {
+		snprintf(str, sz, "fsa_gpio%d : %s %s",
+			 desc->offset + 1,
+			 desc->name,
+			 fsa_gpio_config_name(desc));
+	} else if (desc->config) {
+		snprintf(str, sz, "gpio@%02x_%02d: %s %s",
+			 desc->source,
+			 desc->offset,
+			 desc->name,
+			 fsa_gpio_config_name(desc));
+	}
+	return str;
+}
+
+static void fsa_show_gpio_descs(const char *prefix, int fsa, struct fsa_board_info *board_info,
+				struct fsa_user_info *user_info)
+{
+	char str[128];
+	int i;
+
+	/* display slot specific gpios */
+	for (i = 0; i < board_info->sockgpios; i++) {
+		fsa_get_gpio_desc(&user_info->gpios[i], str, sizeof(str));
+		printf("%s%-2d: %s\n", prefix, i, str);
+	}
+	/* display io-expander specific gpios */
+	if (fsa_gpiodevs[fsa]) {
+		for (i = board_info->sockgpios;
+		     i < (board_info->sockgpios + board_info->ioexpgpios);
+		     i++) {
+			fsa_get_gpio_desc(&user_info->gpios[i], str, sizeof(str));
+			printf("%s%-2d: %s\n", prefix, i, str);
+		}
+	}
+}
+
+/* detect gpio expander by address and deal with enabling/disabling/adding gpio expander to dt */
+static int fsa_get_gpiodev(int fsa, int addr, struct udevice **devp)
+{
+	struct udevice *bus, *dev;
+	char gpio_name[32];
+	int ret;
+
+	ret = device_get_global_by_ofnode(fsa_get_ofnode(fsa), &bus);
+	if (ret)
+		return ret;
+
+	sprintf(gpio_name, "gpio@%02x", addr);
+
+	/* probe device on i2c bus */
+	ret = dm_i2c_probe(bus, addr, 0, &dev);
+	switch (ret) {
+	case -EREMOTEIO: /* chip is not present on i2c bus */
+		/* if device is in dt remove/unbind/disable it */
+		ret = device_find_child_by_name(bus, gpio_name, &dev);
+		if (ret)
+			return ret;
+		ret = ofnode_set_enabled(dev_ofnode(dev), false);
+		if (ret)
+			return ret;
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+		ret = device_remove(dev, DM_REMOVE_NORMAL);
+		if (ret)
+			return ret;
+		return ret;
+	case -ENOSYS: /* chip found but driver invalid */
+		/* if device is in not in dt add/bind it */
+		return ret;
+	case 0: /* chip responded and driver bound */
+		break;
+	}
+
+	if (devp)
+		*devp = dev;
+	return 0;
+}
+
+/* add gpio's to gpio device: GPIO device must be probed before you can manipulate it */
+static int fsa_config_gpios(int fsa, struct fsa_user_info *info, int gpios, struct udevice *dev)
+{
+	struct fsa_gpio_desc *desc;
+	struct gpio_desc gdesc;
+	struct udevice *gdev;
+	int i, ret, flags;
+	char name[32];
+
+	/* configure GPIO's */
+	for (i = 0; i < gpios; i++) {
+		desc = &info->gpios[i];
+		if (desc->config < FSA_GPIO_INPUT)
+			continue;
+		memset(&gdesc, 0, sizeof(gdesc));
+
+		if (desc->source == 0xff) {
+			/* Board specific IMX8M GPIO's: find dev of controller by line-name */
+			sprintf(name, "fsa%d_gpio%d", fsa, desc->offset + 1);
+			uclass_foreach_dev_probe(UCLASS_GPIO, gdev) {
+				ret = dev_read_stringlist_search(gdev, "gpio-line-names", name);
+				if (ret >= 0) {
+					gdesc.dev = gdev;
+					gdesc.offset = ret;
+					break;
+				}
+			}
+		} else {
+			/* port expander GPIOs */
+			gdesc.dev = dev;
+			gdesc.offset = desc->offset;
+		}
+
+		if (!gdesc.dev)
+			continue;
+
+		sprintf(name, "fsa%d_%s", fsa, desc->name);
+		switch (desc->config) {
+		case FSA_GPIO_INPUT:
+			flags = GPIOD_IS_IN;
+			break;
+		case FSA_GPIO_OUTPUT_LOW:
+			flags = GPIOD_IS_OUT;
+			break;
+		case FSA_GPIO_OUTPUT_HIGH:
+			flags = GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE;
+			break;
+		}
+		if (!dm_gpio_request(&gdesc, name))
+			dm_gpio_clrset_flags(&gdesc, GPIOD_MASK_DIR, flags);
+	}
+
+	return 0;
+}
+
+static int fsa_read_board_config(int fsa, struct fsa_board_info *info)
+{
+	struct udevice *dev;
+	int chksum;
+	int i, ret;
+	ofnode node;
+
+	/* find eeprom dev */
+	node = ofnode_find_subnode(fsa_get_ofnode(fsa), "eeprom@54");
+	if (!ofnode_valid(node))
+		return -EINVAL;
+	ret = device_get_global_by_ofnode(node, &dev);
+	if (ret)
+		return ret;
+
+	/* read eeprom */
+	ret = dm_i2c_read(dev, 0, (uint8_t *)info, sizeof(*info));
+	if (ret) {
+		dev_err(dev, "read failed: %d\n", ret);
+		return ret;
+	}
+
+	/* validate checksum */
+	for (chksum = 0, i = 0; i < (int)sizeof(*info) - 2; i++)
+		chksum += ((unsigned char *)info)[i];
+	if ((info->chksum[0] != ((chksum >> 8) & 0xff)) ||
+	    (info->chksum[1] != (chksum & 0xff))) {
+		dev_err(dev, "FSA%d EEPROM: Invalid User Config Checksum\n", fsa);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, info, sizeof(*info));
+		memset(info, 0, sizeof(*info));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fsa_read_user_config(int fsa, struct fsa_user_info *info)
+{
+	struct udevice *dev;
+	int chksum;
+	int i, ret;
+	ofnode node;
+
+	/* find eeprom dev */
+	node = ofnode_find_subnode(fsa_get_ofnode(fsa), "eeprom@55");
+	if (!ofnode_valid(node))
+		return -EINVAL;
+	ret = device_get_global_by_ofnode(node, &dev);
+	if (ret)
+		return ret;
+
+	/* read eeprom */
+	ret = dm_i2c_read(dev, 0, (uint8_t *)info, sizeof(*info));
+	if (ret) {
+		dev_err(dev, "read failed: %d\n", ret);
+		return ret;
+	}
+
+	/* validate checksum */
+	for (chksum = 0, i = 0; i < (int)sizeof(*info) - 2; i++)
+		chksum += ((unsigned char *)info)[i];
+	if ((info->chksum[0] != ((chksum >> 8) & 0xff)) ||
+	    (info->chksum[1] != (chksum & 0xff))) {
+		dev_err(dev, "FSA%d EEPROM: Invalid User Config Checksum\n", fsa);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, info, sizeof(*info));
+		memset(info, 0, sizeof(*info));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fsa_write_user_config(int fsa, struct fsa_user_info *info)
+{
+	struct udevice *bus, *dev;
+	int i, n, chunk, slave, base, ret;
+	ofnode node;
+	int chksum;
+
+	/* create checksum */
+	for (chksum = 0, i = 0; i < (int)sizeof(*info) - 2; i++)
+		chksum += ((unsigned char *)info)[i];
+	info->chksum[0] = chksum >> 8;
+	info->chksum[1] = chksum & 0xff;
+
+	/* find eeprom dev */
+	node = ofnode_find_subnode(fsa_get_ofnode(fsa), "eeprom@55");
+	ret = device_get_global_by_ofnode(node, &dev);
+	if (ret)
+		return ret;
+	bus = dev->parent;
+	base = dev_read_addr(dev);
+
+	/* write in 16byte chunks (multi-byte writes fail larger than that) */
+	chunk = 16;
+	slave = -1;
+	for (i = 0; i < sizeof(*info); i += chunk) {
+		/* select device based on offset */
+		if ((base + (i / 256)) != slave) {
+			slave = base + (i / 256);
+			ret = i2c_get_chip(bus, slave, 1, &dev);
+			if (ret) {
+				dev_err(bus, "failed to get eeprom@0x%02x: %d\n", slave, ret);
+				return ret;
+			}
+		}
+		/* select byte count */
+		n = sizeof(*info) - i;
+		if (n > chunk)
+			n = chunk;
+		ret = dm_i2c_write(dev, i % 256, (uint8_t *)info + i, n);
+		if (ret) {
+			dev_err(dev, "write failed: %d\n", ret);
+			return ret;
+		}
+		mdelay(11);
+	}
+
+	return ret;
+}
+
+static int fsa_detect(int fsa, struct fsa_board_info *board_info, struct fsa_user_info *user_info,
+		      bool gpio)
+{
+	int ret;
+
+	ret = fsa_read_board_config(fsa, board_info);
+	if (ret)
+		return ret;
+	if (user_info) {
+		ret = fsa_read_user_config(fsa, user_info);
+		if (ret)
+			return ret;
+		/* detect port expander */
+		if (gpio && !fsa_get_gpiodev(fsa, 0x20, &fsa_gpiodevs[fsa]))
+			fsa_config_gpios(fsa, user_info,
+					 board_info->sockgpios + board_info->ioexpgpios,
+					 fsa_gpiodevs[fsa]);
+	}
+
+	return ret;
+}
+
+static int ft_fixup_stringlist_elem(void *fdt, int offset, const char *prop, int elem,
+				    const char *val)
+{
+	const char *list, *end;
+	char *new, *buf;
+	int length;
+	int sz = 0;
+	int i = 0;
+	int ret;
+
+	if (offset < 0 || elem < 0 || !val) {
+		printf("%s -EINVAL\n", __func__);
+		return -EINVAL;
+	}
+
+	list = fdt_getprop(fdt, offset, prop, &length);
+
+	/* no property or invalid params */
+	if (!list || length < 0) {
+		printf("%s failed - no property\n", __func__);
+		return -EINVAL;
+	}
+
+	/* create new buffer with enough space */
+	buf = calloc(1, length + strlen(val));
+	new = buf;
+
+	/* iterate over current stringlist and build new list into buf */
+	end = list + length;
+	while (list < end) {
+		length = strnlen(list, end - list) + 1;
+		sz += length;
+		/* insert new value into buf */
+		if (elem == i) {
+			strcpy(new, val);
+			new += strlen(val) + 1;
+		} else {
+			strcpy(new, list);
+			new += length;
+		}
+		list += length;
+		i++;
+	}
+	length = new - buf;
+	ret = fdt_setprop(fdt, offset, prop, buf, length);
+	free(buf);
+	if (ret)
+		printf("%s failed %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int ft_fixup_fsa_gpio_name(void *fdt, int offset, int fsa, int gpio, const char *name)
+{
+	const char *prop = "gpio-line-names";
+	char str[32];
+
+	sprintf(str, "fsa%d_%s", fsa, name);
+
+	if (!fdt_getprop(fdt, offset, prop, NULL)) {
+		char buf[16] = { 0 };
+
+		fdt_setprop(fdt, offset, prop, &buf, sizeof(buf));
+	}
+
+	return ft_fixup_stringlist_elem(fdt, offset, prop, gpio, str);
+}
+
+static void fsa_show_details(int fsa, struct fsa_board_info *board, struct fsa_user_info *user)
+{
+	printf("FSA%d: %s\n", fsa, board->model);
+	printf("description: %s\n", user->desc);
+	printf("overlay: %s\n", user->overlay);
+	fsa_show_gpio_descs("\t", fsa, board, user);
+}
+
+int fsa_init(void)
+{
+	struct fsa_board_info board_info;
+	struct fsa_user_info user_info;
+	int fsa, ret;
+
+	for (fsa = 1; fsa < FSA_MAX; fsa++) {
+		ret = fsa_detect(fsa, &board_info, &user_info, true);
+		if (!ret)
+			printf("FSA%d:  %s %s\n", fsa, board_info.model, user_info.desc);
+	}
+
+	return 0;
+}
+
+int fsa_show(void)
+{
+	struct fsa_board_info board_info;
+	int fsa, ret;
+
+	for (fsa = 1; fsa < FSA_MAX; fsa++) {
+		ret = fsa_detect(fsa, &board_info, NULL, false);
+		if (!ret) {
+			printf("FSA%d    : %s %d %02x-%02x-%02x%02x\n", fsa,
+			       board_info.model, board_info.serial,
+			       board_info.mfgdate[0], board_info.mfgdate[1],
+			       board_info.mfgdate[2], board_info.mfgdate[3]);
+		}
+	}
+	return 0;
+}
+
+/* fixup gpio line names for fsa gpios */
+int fsa_ft_fixup(void *fdt)
+{
+	struct fsa_board_info board_info;
+	struct fsa_user_info user_info;
+	int fsa, i, ret;
+	char path[128];
+	char str[32];
+	ofnode node;
+	int off;
+
+	/* iterate over FSA's and rename gpio's */
+	for (fsa = 1; fsa < FSA_MAX; fsa++) {
+		/* disable FSA ioexp node if disabled in controlling dt */
+		off = fdt_subnode_offset(fdt, fsa_get_dtnode(fdt, fsa), "gpio@20");
+		if (off >= 0) {
+			if (!fdt_get_path(fdt, off, path, sizeof(path))) {
+				node = ofnode_path(path);
+				if (ofnode_valid(node) && !ofnode_is_enabled(node))
+					fdt_setprop_string(fdt, off, "status", "disabled");
+			}
+		}
+
+		/* detect FSA eeprom */
+		if (fsa_detect(fsa, &board_info, &user_info, false))
+			continue;
+
+		/* configure GPIO's */
+		for (i = 0; i < board_info.sockgpios + board_info.ioexpgpios; i++) {
+			if (user_info.gpios[i].config < FSA_GPIO_INPUT)
+				continue;
+
+			if (user_info.gpios[i].source == 0xff) {
+				/* Board specific IMX8M GPIO's */
+				for (off = fdt_node_offset_by_prop_value(fdt, 0,
+									 "gpio-controller", NULL,
+									 0);
+				     off >= 0;
+				     off = fdt_node_offset_by_prop_value(fdt, off,
+									 "gpio-controller", NULL,
+									 0)
+				    ) {
+					sprintf(str, "fsa%d_gpio%d", fsa,
+						user_info.gpios[i].offset + 1);
+					ret = fdt_stringlist_search(fdt, off, "gpio-line-names",
+								    str);
+					if (ret >= 0) {
+						ft_fixup_fsa_gpio_name(fdt, off, fsa, ret,
+								       user_info.gpios[i].name);
+						break;
+					}
+				}
+			} else {
+				/* port expander GPIOs */
+				off = fdt_subnode_offset(fdt, fsa_get_dtnode(fdt, fsa), "gpio@20");
+				ft_fixup_fsa_gpio_name(fdt, off, fsa, user_info.gpios[i].offset,
+						       user_info.gpios[i].name);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int do_fsa_dev(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	struct fsa_board_info board_info;
+	struct fsa_user_info user_info;
+	int i;
+
+	if (argc < 2) {
+		/* list FSAs */
+		printf("detecting FSA Adapters:\n");
+		for (i = 1; i < FSA_MAX; i++) {
+			if (!fsa_read_board_config(i, &board_info) &&
+			    !fsa_read_user_config(i, &user_info))
+				printf("FSA%d    : %s %s\n", i, board_info.model, user_info.desc);
+		}
+	} else {
+		/* select FSA */
+		fsa = simple_strtoul(argv[1], NULL, 10);
+	}
+
+	if (fsa) {
+		/* read FSA */
+		if (!fsa_read_board_config(fsa, &board_info) &&
+		    !fsa_read_user_config(fsa, &user_info)) {
+			printf("selected:\n");
+			fsa_show_details(fsa, &board_info, &user_info);
+		} else {
+			printf("FSA%d not detected\n", fsa);
+			fsa = 0;
+		}
+	} else {
+		printf("no FSA currently selected\n");
+	}
+
+	return 0;
+}
+
+static int do_fsa_desc(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	struct fsa_board_info board_info;
+	struct fsa_user_info user_info;
+
+	/* strip off leading cmd arg */
+	argc--;
+	argv++;
+
+	if (!fsa) {
+		printf("No FSA selected\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (fsa_read_board_config(fsa, &board_info) || fsa_read_user_config(fsa, &user_info)) {
+		printf("can't detect FSA%d\n", fsa);
+		return CMD_RET_USAGE;
+	}
+
+	/* set */
+	if (argc) {
+		strlcpy(user_info.desc, argv[0], sizeof(user_info.desc));
+		if (fsa_write_user_config(fsa, &user_info))
+			return CMD_RET_FAILURE;
+	}
+
+	/* show */
+	fsa_show_details(fsa, &board_info, &user_info);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_fsa_overlay(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	struct fsa_board_info board_info;
+	struct fsa_user_info user_info;
+
+	/* strip off leading cmd arg */
+	argc--;
+	argv++;
+
+	if (!fsa) {
+		printf("No FSA selected\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (fsa_read_board_config(fsa, &board_info) || fsa_read_user_config(fsa, &user_info)) {
+		printf("can't detect FSA%d\n", fsa);
+		return CMD_RET_USAGE;
+	}
+
+	/* set */
+	if (argc) {
+		strlcpy(user_info.overlay, argv[0], sizeof(user_info.overlay));
+		if (fsa_write_user_config(fsa, &user_info))
+			return CMD_RET_FAILURE;
+	}
+
+	/* show */
+	fsa_show_details(fsa, &board_info, &user_info);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_fsa_gpio(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	struct fsa_board_info board_info;
+	struct fsa_user_info user_info;
+	struct fsa_gpio_desc desc;
+	char str[64];
+	int i, j;
+
+	/* strip off leading cmd arg */
+	argc--;
+	argv++;
+
+	if (!fsa) {
+		printf("No FSA selected\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (fsa_read_board_config(fsa, &board_info) || fsa_read_user_config(fsa, &user_info)) {
+		printf("can't detect FSA%d\n", fsa);
+		return CMD_RET_USAGE;
+	}
+
+	if (!argc) {
+		/* show all gpios */
+		fsa_show_gpio_descs("\t", fsa, &board_info, &user_info);
+		return CMD_RET_SUCCESS;
+	}
+
+	if (!isdigit(argv[0][0])) {
+		printf("invalid gpio offset: %s\n", argv[0]);
+		return CMD_RET_USAGE;
+	}
+
+	memset(&desc, 0, sizeof(desc));
+	i = simple_strtoul(argv[0], NULL, 10);
+
+	if (i >= 0 && i < board_info.sockgpios) {
+		desc.offset = i;
+		desc.source = 0xff;
+	} else if (i >= board_info.sockgpios &&
+		 i < (board_info.sockgpios + board_info.ioexpgpios) &&
+		 fsa_gpiodevs[fsa]) {
+		desc.offset = i - board_info.sockgpios;
+		desc.source = 0x20;
+	} else {
+		printf("invalid index %d", i);
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc > 1) {
+		if (user_info.gpios[i].config == FSA_GPIO_NC) {
+			printf("can not alter NC gpio\n");
+			return CMD_RET_FAILURE;
+		}
+		strlcpy(desc.name, argv[1], sizeof(desc.name));
+		if (!*desc.name) {
+			printf("FSA%d %s erasing gpio %d\n", fsa, board_info.model, i);
+			memset(&user_info.gpios[i], 0, sizeof(desc));
+			if (fsa_write_user_config(fsa, &user_info))
+				return CMD_RET_FAILURE;
+			return CMD_RET_SUCCESS;
+		}
+	}
+	if (argc > 2) {
+		if (user_info.gpios[i].config == FSA_GPIO_NC) {
+			printf("can not alter NC gpio\n");
+			return CMD_RET_FAILURE;
+		}
+		for (j = 1; j < ARRAY_SIZE(fsa_gpio_config_names); j++) {
+			if (!strcasecmp(argv[2], fsa_gpio_config_names[j])) {
+				desc.config = j;
+				break;
+			}
+		};
+		if (j >= ARRAY_SIZE(fsa_gpio_config_names)) {
+			printf("invalid config type '%s\n", argv[2]);
+			return CMD_RET_FAILURE;
+		}
+	}
+
+	/* show a specific gpio */
+	if (argc == 1) {
+		printf("FSA%d %s showing gpio %d\n", fsa, board_info.model, i);
+		printf("%s\n", fsa_get_gpio_desc(&user_info.gpios[i], str, sizeof(str)));
+		return CMD_RET_SUCCESS;
+	}
+
+	/* set a specific gpio */
+	else if (argc == 3) {
+		printf("FSA%d %s updating gpio %d\n", fsa, board_info.model, i);
+		memcpy(&user_info.gpios[i], &desc, sizeof(desc));
+		if (fsa_write_user_config(fsa, &user_info))
+			return CMD_RET_FAILURE;
+		return CMD_RET_SUCCESS;
+	}
+
+	return CMD_RET_USAGE;
+}
+
+static struct cmd_tbl cmd_fsa_sub[] = {
+	U_BOOT_CMD_MKENT(dev, 1, 1, do_fsa_dev, "", ""),
+	U_BOOT_CMD_MKENT(gpio, 4, 1, do_fsa_gpio, "", ""),
+	U_BOOT_CMD_MKENT(description, 1, 1, do_fsa_desc, "", ""),
+	U_BOOT_CMD_MKENT(overlay, 1, 1, do_fsa_overlay, "", ""),
+};
+
+static int do_fsa(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	struct cmd_tbl *c;
+
+	/* strip off leading fsa arg */
+	argc--;
+	argv++;
+
+	c = find_cmd_tbl(argv[0], cmd_fsa_sub, ARRAY_SIZE(cmd_fsa_sub));
+	if (c)
+		return c->cmd(cmdtp, flag, argc, argv);
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_LONGHELP(fsa,
+		"dev [dev] - show or set current FSA adapter\n"
+		"fsa gpio - show current gpio descriptors\n"
+		"fsa gpio [<offset>]|[<offset> <source>] - show a specific gpio descriptor\n"
+		"fsa gpio [<offset> <name> <input|output-low|output-high> [source]] - set a gpio descriptor\n"
+		"fsa description [description] - show or set the FSA user description string\n"
+		"fsa overlay [overlay] - show or set the FSA overlay string\n"
+);
+
+U_BOOT_CMD(fsa, 6, 1, do_fsa,
+	   "Flexible Socket Adapter",
+	   fsa_help_text
+);
diff --git a/board/gateworks/fsa.h b/board/gateworks/fsa.h
new file mode 100644
index 000000000000..ddb64499d780
--- /dev/null
+++ b/board/gateworks/fsa.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 Gateworks Corporation
+ */
+
+#ifndef _FSA_H_
+#define _FSA_H_
+
+#define FSA_MAX	5
+
+enum fsa_gpio_cfg {
+	FSA_GPIO_NC,
+	FSA_GPIO_UNCONFIGURED,
+	FSA_GPIO_INPUT,
+	FSA_GPIO_OUTPUT_LOW,
+	FSA_GPIO_OUTPUT_HIGH,
+};
+
+struct fsa_gpio_desc {
+	u8 offset;
+	u8 config;
+	u8 source;
+	char name[13];
+};
+
+struct fsa_board_info {
+	char model[16];			/* 0x00: model string */
+	u8 mac[6];			/* 0x10: MAC base */
+	u8 macno;			/* 0x16: number of mac addrs */
+	u8 resv1;			/* 0x17: reserved */
+	u32 serial;			/* 0x18: Serial Number */
+	u8 mfgdate[4];			/* 0x1c: MFG date */
+	u8 sockgpios;			/* 0x20: number of socket gpio descriptors */
+	u8 ioexpgpios;			/* 0x21: number of io expander gpio descriptors */
+	u8 resv2[220];			/* 0x22: reserved */
+	u8 chksum[2];			/* 0xfe: */
+};
+
+struct fsa_user_info {
+	char desc[32];			/* 0x000: user description */
+	char overlay[16];		/* 0x020: dt-overlay suffice */
+	struct fsa_gpio_desc gpios[20];	/* 0x030: gpio descriptors */
+	u8 reserved[398];		/* 0x170: reserved */
+	u8 chksum[2];			/* 0x2fe: */
+};
+
+int fsa_init(void);
+int fsa_show(void);
+int fsa_ft_fixup(void *fdt);
+
+#endif // _FSA_H_
diff --git a/board/gateworks/venice/Makefile b/board/gateworks/venice/Makefile
index ab69e07ba7bb..1aaf0295d5c9 100644
--- a/board/gateworks/venice/Makefile
+++ b/board/gateworks/venice/Makefile
@@ -5,6 +5,7 @@
 #
 
 obj-y += venice.o eeprom.o
+obj-y += ../fsa.o
 
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index 41f620c90e72..49b1ad34b148 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -9,6 +9,7 @@
 #include <dm/uclass.h>
 
 #include "eeprom.h"
+#include "../fsa.h"
 
 /* I2C */
 #define SOM_EEPROM_BUSNO		0
@@ -300,6 +301,8 @@ static int eeprom_info(bool verbose)
 		       base_info.mfgdate[0], base_info.mfgdate[1],
 		       base_info.mfgdate[2], base_info.mfgdate[3]);
 	}
+	if (verbose)
+		fsa_show();
 
 	return 0;
 }
diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index 98b33624f041..9491cbd3ac22 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -14,6 +14,7 @@
 #include <asm/mach-imx/boot_mode.h>
 
 #include "eeprom.h"
+#include "../fsa.h"
 
 int board_phys_sdram_size(phys_size_t *size)
 {
@@ -75,6 +76,9 @@ int board_init(void)
 {
 	venice_eeprom_init(1);
 
+	/* detect and configure FSA adapters */
+	fsa_init();
+
 	return 0;
 }
 
@@ -221,6 +225,9 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 	/* set board model dt prop */
 	fdt_setprop_string(fdt, 0, "board", eeprom_get_model());
 
+	/* fixups for FSA adapters */
+	fsa_ft_fixup(fdt);
+
 	if (!strncmp(base_model, "GW73", 4)) {
 		pcbrev = get_pcb_rev(base_model);
 		path = fdt_get_alias(fdt, "ethernet1");
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 0f263a3ecb80..cc7dfcb1400e 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -86,6 +86,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_OF_LIST="freescale/imx8mm-venice-gw71xx-0x freescale/imx8mm-venice-gw72xx-0x freescale/imx8mm-venice-gw73xx-0x freescale/imx8mm-venice-gw7901 freescale/imx8mm-venice-gw7902 freescale/imx8mm-venice-gw7903 freescale/imx8mm-venice-gw7904 freescale/imx8mm-venice-gw75xx-0x"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
@@ -106,10 +107,14 @@ CONFIG_CLK_IMX8MM=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_MXC_GPIO=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_BLINK=y
 CONFIG_LED_GPIO=y
+CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 4fc8e146b06d..a7a838b61bb1 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -86,6 +86,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_MMC_ENV_DEV=2
@@ -103,10 +104,14 @@ CONFIG_CLK_IMX8MN=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_MXC_GPIO=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_BLINK=y
 CONFIG_LED_GPIO=y
+CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 10eac0a0c785..2e4cacf166d8 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -88,6 +88,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
 CONFIG_OF_LIST="freescale/imx8mp-venice-gw71xx-2x freescale/imx8mp-venice-gw72xx-2x freescale/imx8mp-venice-gw73xx-2x freescale/imx8mp-venice-gw74xx freescale/imx8mp-venice-gw75xx-2x freescale/imx8mp-venice-gw82xx-2x"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
@@ -104,10 +105,14 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_MXC_GPIO=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_LED=y
 CONFIG_LED_BLINK=y
 CONFIG_LED_GPIO=y
+CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
-- 
2.25.1

