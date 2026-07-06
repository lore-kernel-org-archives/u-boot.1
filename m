Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8305BC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C865E84979;
	Mon,  6 Jul 2026 17:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="drMaNMH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BCA8498B; Mon,  6 Jul 2026 17:07:09 +0200 (CEST)
Received: from mail-wm2-x01.google.com (mail-wm2-x01.google.com
 [IPv6:2a00:1450:4864:31::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50152846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b4e7be03so2614595e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783350426; x=1783955226; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q76ilduyiOElJosOvMfn2TxulSwzEaAJBqP/tlQaRys=;
 b=drMaNMH1iAVi90rGWunKYvD7BjlUPG4LJ5iay2wxPKzGD6ff/VpgaFUdL3xP8Ffv41
 A/LGuaCm26NK6txC3IpzIT7m9Fa19Owt0dwwAU7jCORTBUIMfmypNXvgVpGwF3zffBTT
 dXirnxh1uOerDkD3UJ2wBbC5oxW1dWsf0l0Afa0Gd+tMqYzgT3fIb1YyAFIBY1MX+6vv
 4GytJHTNbGpNAAPViqtd44tgVd3xDfe/ZBdPojY/lPGI7cJ0yGY0QeIYpR7hzTcPo+Xf
 O31IuQBbhkZKXNuKV+PVn/ENeNr7Y6YODiACDnB51nYLjMBIBcesQ/qWd7OgdrnJEqzq
 TNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350426; x=1783955226;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q76ilduyiOElJosOvMfn2TxulSwzEaAJBqP/tlQaRys=;
 b=btcOs4JzZmEfeQUkgxWz0ZenTSEXq+Sc/5wUvF5X8/x87h+zlEfnzt4lM12IUofR1Z
 TbVqtn9665Jtr1nnGkCickrJqNtXV1U4/x8PHWpNTytPMKtYYU9GdIyABbtdh5cd7D2+
 Xlxcv5QahUTKU13D8FhdhYzmLfTc53NIaY6kMfEvoZsfZXCn15rnRLWtMphYU9xT5d9+
 rxoR2Dw7GAqbb+1mP1X2kjIPxZhOXZ9OdTweu8oVveG0MpkuxGa7omqcV2Xofj+va3aY
 hgBF8k6WjQosK2f1OtoIDRTVhF8IwvG21wzP+MpK4Gy7ZqS9qw8GfYz4VskN2r0SPkNE
 BwPA==
X-Gm-Message-State: AOJu0Yxzt2l4WOuHZTbL7sgBjcOdXOWy/GlmAInIi+MUMaoWqvyo+B6J
 JxrYxDpLmhpKZ+zRRl9Ir7yYgwkXCfetihXhunaRahHuqK2ToPQnzuax1+HTbnSS0xs=
X-Gm-Gg: AfdE7cm4UWUZ+ARfWFUMoWqpN+6mGnSNFiO+b3p4nyV0/+f0h4Cj3/JMpxzZ5MHXPAF
 wQHlLniEwepYfNrDQLdHEIXlrMeu9ERNle5Bg/phQB0Zt4oY+iRRiI/zTNqezmxtrerOawQrk4T
 yfXczrMlHPL8MZCUZ19LHaQqTH6n8f8fNnnhoaAiS7wbMU7MAPDkFArZyIpO4Zle/2WKGOJsxD3
 UZZ/Wm4E5cfv23FaqXMSyT9B0C2GYdd8TBSkkXjDaBjyckwkH2z6DxAWldxuG+WIlaxn7Co/J02
 sCNoYHRjD8ASaOdRlj9MevhWkm74Dmdh0i0Vj2DaWLGDo+QSS6orGyhXgLI15xAp1FNMBACC6wq
 ysPf6IOxfTvTNvE0zxB9XslLAD27hAd6EBZ6OhPs6FHh1fN+OclnfyaUMsQcbyvQ1ryS7hFFLth
 3+3Tbb6U57gsYYCs0qqJCqtuUGyF05jQaby6faO/jdcNzGu005ZU0ng4Id
X-Received: by 2002:a05:600c:55d7:b0:493:b962:4abe with SMTP id
 5b1f17b1804b1-493df0a1785mr8197775e9.36.1783350425332; 
 Mon, 06 Jul 2026 08:07:05 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it ([95.236.170.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm281421265e9.11.2026.07.06.08.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:07:04 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 06 Jul 2026 17:06:42 +0200
Subject: [PATCH 1/4] bootstd: add a firmware-owned devicetree source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

Platforms following EBBR / Arm SystemReady IR keep the devicetree on
a firmware-owned partition, updated independently of the operating
system, rather than shipping it in the OS image or on the EFI System
Partition. U-Boot has no generic way to source the devicetree from such
a partition, so vendors carry out-of-tree machinery for it.

Add a bootstd helper, firmware_fdt_load(), that assembles the OS
devicetree from a FIT manifest carried on that partition: the FIT images
hold the base DTB and its overlays, and each FIT configuration names one
bootable combination through its 'fdt' property.

The partition is described in the control devicetree: the bootstd node
carries a 'firmware-fdt-source' phandle to a source node, a child of
the media device owning the partition, which identifies it by GPT type
UUID and/or name. The 'boot_dtb' environment variable may pin an A/B
partition number.

The error semantics are fail closed: -ENOENT strictly means "no source
configured" (the only case where callers may fall back to their normal
devicetree); once a source is configured, any assembly failure is
fatal, and downstream -ENOENT codes (missing manifest, missing FIT
configuration) are remapped so a missing or bad firmware devicetree is
never silently replaced by an unverified one. Manifest images carrying
a 'load' property are rejected so a misbuilt manifest cannot overwrite
arbitrary memory.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS                               |   3 +
 boot/Kconfig                              |  23 ++
 boot/Makefile                             |   1 +
 boot/firmware_fdt.c                       | 382 ++++++++++++++++++++++++++++++
 doc/develop/bootstd/firmware_fdt.rst      |  94 ++++++++
 doc/develop/bootstd/index.rst             |   1 +
 doc/device-tree-bindings/firmware-fdt.txt | 149 ++++++++++++
 include/firmware_fdt.h                    |  78 ++++++
 8 files changed, 731 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..00078f93a95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1002,8 +1002,10 @@ F:	boot/bootdev*.c
 F:	boot/bootflow.c
 F:	boot/bootmeth*.c
 F:	boot/bootstd.c
+F:	boot/firmware_fdt.c
 F:	cmd/bootdev.c
 F:	cmd/bootflow.c
+F:	doc/device-tree-bindings/firmware-fdt.txt
 F:	doc/develop/bootstd/
 F:	doc/usage/bootdev.rst
 F:	doc/usage/bootflow.rst
@@ -1013,6 +1015,7 @@ F:	include/bootdev.h
 F:	include/bootflow.h
 F:	include/bootmeth.h
 F:	include/bootstd.h
+F:	include/firmware_fdt.h
 F:	net/eth_bootdevice.c
 F:	test/boot/
 
diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..a93cc3e0c3c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -638,6 +638,29 @@ config BOOTMETH_EFILOADER
 
 	  This provides a way to try out standard boot on an existing boot flow.
 
+config BOOTSTD_FIRMWARE_FDT
+	bool "Source the devicetree from a firmware-owned partition"
+	depends on BOOTSTD && BLK && FIT
+	select EFI_PARTITION
+	select PARTITION_TYPE_GUID
+	select OF_LIBFDT
+	select OF_LIBFDT_OVERLAY
+	help
+	  Source the devicetree from a firmware-owned partition rather than
+	  from the EFI System Partition or U-Boot's built-in control
+	  devicetree. The partition carries a FIT manifest whose images hold
+	  the base DTB and its overlays, and whose configurations name the
+	  bootable combinations. The assembled devicetree is handed to the OS,
+	  so it can be updated as part of the firmware, independently of the
+	  operating system.
+
+	  For secure boot, sign the manifest configurations and enable
+	  FIT_SIGNATURE with a required key in the control devicetree; the
+	  standard verified-boot policy then rejects unsigned manifests.
+
+	  This is intended for platforms following EBBR / Arm SystemReady IR.
+	  Say N unless you are booting such a platform.
+
 config BOOTMETH_EFI_BOOTMGR
 	bool "Bootdev support for EFI boot manager"
 	depends on EFI_BOOTMGR
diff --git a/boot/Makefile b/boot/Makefile
index 7fb56e7ef37..8e6f0dfc8d5 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootstd-uclass.o
 
 obj-$(CONFIG_$(PHASE_)BOOTSTD_MENU) += bootflow_menu.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
+obj-$(CONFIG_$(PHASE_)BOOTSTD_FIRMWARE_FDT) += firmware_fdt.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
new file mode 100644
index 00000000000..952299f1e1b
--- /dev/null
+++ b/boot/firmware_fdt.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Firmware-owned devicetree (FDT) source.
+ *
+ * Some platforms (EBBR / Arm SystemReady IR) keep the devicetree on a
+ * firmware-owned partition rather than in the OS image or the EFI System
+ * Partition. The devicetree is carried by a FIT manifest on that partition:
+ * the FIT images hold the base DTB and its overlays, and each FIT
+ * configuration names one bootable combination through its 'fdt' property.
+ *
+ * The partition is described by the control devicetree: the bootstd node
+ * carries a 'firmware-fdt-source' phandle to a source node, a child of the
+ * media device that owns the partition, e.g.:
+ *
+ *	bootstd {
+ *		compatible = "u-boot,boot-std";
+ *		firmware-fdt-source = <&fw_fdt>;
+ *	};
+ *	&mmc0 {
+ *		fw_fdt: firmware-fdt {
+ *			compatible = "u-boot,firmware-fdt-block";
+ *			partition-type-uuid = "....";	(GPT type UUID)
+ *			partition-name = "firmware";	(optional fallback)
+ *			filename = "fdt.itb";		(optional, the default)
+ *		};
+ *	};
+ *
+ * At most two runtime values come from the environment: 'boot_dtb' may pin
+ * an A/B firmware partition and 'fw_fdt_config' may select a FIT
+ * configuration. Both only choose among combinations the firmware author
+ * shipped (and, in secure mode, signed).
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <blk.h>
+#include <dm.h>
+#include <env.h>
+#include <firmware_fdt.h>
+#include <fs.h>
+#include <image.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <part.h>
+#include <vsprintf.h>
+#include <dm/ofnode.h>
+#include <linux/libfdt.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+/* The manifest lives in a filesystem on a GPT partition of a block device */
+#define FW_FDT_COMPAT_BLOCK	"u-boot,firmware-fdt-block"
+
+/* Default manifest filename on the firmware partition */
+#define FW_FDT_FILENAME		"fdt.itb"
+
+/* Sanity cap on the manifest size */
+#define FW_FDT_MAX_SIZE		SZ_4M
+
+/**
+ * fw_fdt_get_source() - find the configured firmware-FDT source node
+ *
+ * Reads the 'firmware-fdt-source' phandle from the bootstd node.
+ *
+ * @srcp: returns the source ofnode on success
+ * Return: 0 on success, -ENOENT if no source is configured, -EINVAL if the
+ * property is present but its phandle does not resolve
+ */
+static int fw_fdt_get_source(ofnode *srcp)
+{
+	ofnode bootstd, src;
+	const void *prop;
+
+	bootstd = ofnode_by_compatible(ofnode_null(), "u-boot,boot-std");
+	if (!ofnode_valid(bootstd))
+		return -ENOENT;
+
+	prop = ofnode_get_property(bootstd, "firmware-fdt-source", NULL);
+	if (!prop)
+		return -ENOENT;
+
+	src = ofnode_parse_phandle(bootstd, "firmware-fdt-source", 0);
+	if (!ofnode_valid(src))
+		return log_msg_ret("phandle", -EINVAL);
+
+	*srcp = src;
+
+	return 0;
+}
+
+static int fw_fdt_get_checked_source(ofnode *srcp)
+{
+	int ret;
+
+	ret = fw_fdt_get_source(srcp);
+	if (ret)
+		return ret;
+
+	if (!ofnode_device_is_compatible(*srcp, FW_FDT_COMPAT_BLOCK))
+		return log_msg_ret("compat", -EOPNOTSUPP);
+
+	return 0;
+}
+
+/**
+ * fw_fdt_get_blk() - resolve the block device that owns the source node
+ *
+ * The source node is a child of its media device (e.g. &mmc0); resolve that
+ * parent to a udevice. The lookup also probes it, which the EFI boot-manager
+ * path relies on.
+ *
+ * @src: the firmware-FDT source node
+ * @descp: returns the block descriptor on success
+ * Return: 0 on success, negative on error
+ */
+static int fw_fdt_get_blk(ofnode src, struct blk_desc **descp)
+{
+	struct udevice *media, *blk;
+	ofnode parent;
+	int ret;
+
+	parent = ofnode_get_parent(src);
+	if (!ofnode_valid(parent))
+		return log_msg_ret("par", -EINVAL);
+
+	/* a source is configured: remap -ENOENT to -ENODEV to fail closed */
+	ret = device_get_global_by_ofnode(parent, &media);
+	if (ret)
+		return log_msg_ret("media", ret == -ENOENT ? -ENODEV : ret);
+
+	ret = blk_get_from_parent(media, &blk);
+	if (ret)
+		return log_msg_ret("blk", ret == -ENOENT ? -ENODEV : ret);
+
+	*descp = dev_get_uclass_plat(blk);
+
+	return 0;
+}
+
+/**
+ * fw_fdt_find_part() - find the firmware partition on @desc
+ *
+ * 'boot_dtb', if set, pins an explicit partition number. Otherwise the
+ * first partition matching every configured selector is used: when both
+ * @type_uuid and @name are configured, both must match, so a misprovisioned
+ * disk fails instead of silently selecting whichever same-type (e.g. A/B)
+ * partition comes first. At least one selector must be configured.
+ *
+ * @desc: block device to scan
+ * @type_uuid: GPT type UUID to match, or NULL
+ * @name: partition name to match, or NULL
+ * Return: partition number (>= 1), -EINVAL if 'boot_dtb' is set to an
+ * invalid partition number or no selector is configured, or -ENODEV if no
+ * partition matched
+ */
+static int fw_fdt_find_part(struct blk_desc *desc, const char *type_uuid,
+			    const char *name)
+{
+	const char *sel;
+	struct disk_partition info;
+	bool want_type = type_uuid && *type_uuid;
+	bool want_name = name && *name;
+	int p;
+
+	sel = env_get("boot_dtb");
+	if (sel && *sel) {
+		char *end;
+		ulong pin;
+
+		pin = dectoul(sel, &end);
+		if (*end || !pin || pin > MAX_SEARCH_PARTITIONS)
+			return log_msg_ret("pin", -EINVAL);
+
+		if (part_get_info(desc, pin, &info))
+			return log_msg_ret("pin", -ENODEV);
+
+		return pin;
+	}
+
+	if (!want_type && !want_name)
+		return log_msg_ret("sel", -EINVAL);
+
+	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
+		bool type_match, name_match;
+
+		if (part_get_info(desc, p, &info))
+			continue;
+
+		/* UUID text is case-insensitive (RFC 4122) */
+		type_match = !want_type ||
+			!strncasecmp(disk_partition_type_guid(&info), type_uuid,
+				     UUID_STR_LEN);
+		name_match = !want_name ||
+			!strcmp((const char *)info.name, name);
+
+		if (type_match && name_match)
+			return p;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * fw_fdt_read_fit() - read the FIT manifest into an allocated buffer
+ *
+ * @desc: block device holding the firmware partition
+ * @part: partition number
+ * @fname: manifest filename
+ * @bufp: returns the allocated buffer holding the manifest
+ * @sizep: returns the manifest size in bytes
+ * Return: 0 on success, negative on error
+ */
+static int fw_fdt_read_fit(struct blk_desc *desc, int part, const char *fname,
+			   void **bufp, ulong *sizep)
+{
+	loff_t size;
+	int ret;
+
+	ret = fs_set_blk_dev_with_part(desc, part);
+	if (ret)
+		return log_msg_ret("fs", -EIO);
+
+	ret = fs_size(fname, &size);
+	if (ret)
+		return log_msg_ret("size", -EIO);
+
+	if (!size || size > FW_FDT_MAX_SIZE)
+		return log_msg_ret("big", -E2BIG);
+
+	/* fs_size() consumed the mount */
+	ret = fs_set_blk_dev_with_part(desc, part);
+	if (ret)
+		return log_msg_ret("fs2", -EIO);
+
+	ret = fs_read_alloc(fname, size, 0, bufp);
+	if (ret)
+		return log_msg_ret("read", ret);
+
+	*sizep = size;
+
+	return 0;
+}
+
+/**
+ * fw_fdt_check_images() - reject manifests that are not self-contained
+ *
+ * @fit: the FIT manifest
+ * Return: 0 if every image is embedded and has no load address, -EINVAL
+ * otherwise
+ */
+static int fw_fdt_check_images(const void *fit)
+{
+	int images, node;
+
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0)
+		return log_msg_ret("img", -EINVAL);
+
+	fdt_for_each_subnode(node, fit, images) {
+		if (fdt_getprop(fit, node, FIT_LOAD_PROP, NULL))
+			return log_msg_ret("load", -EINVAL);
+
+		if (fdt_getprop(fit, node, FIT_DATA_OFFSET_PROP, NULL) ||
+		    fdt_getprop(fit, node, FIT_DATA_POSITION_PROP, NULL))
+			return log_msg_ret("ext", -EINVAL);
+	}
+
+	return 0;
+}
+
+/**
+ * fw_fdt_assemble() - load the manifest and assemble the devicetree
+ *
+ * @out: returns the assembled devicetree and its backing buffers
+ * @src: the (validated) firmware-FDT source node
+ * Return: 0 on success, negative on error
+ */
+static int fw_fdt_assemble(struct firmware_fdt *out, ofnode src)
+{
+	struct bootm_headers images;
+	const char *type_uuid, *part_name, *fname, *conf;
+	struct blk_desc *desc;
+	ulong data, len;
+	void *fdt;
+	int part, ret;
+
+	memset(&images, '\0', sizeof(images));
+	images.verify = 1;
+
+	fname = ofnode_read_string(src, "filename");
+	if (!fname)
+		fname = FW_FDT_FILENAME;
+
+	type_uuid = ofnode_read_string(src, "partition-type-uuid");
+	part_name = ofnode_read_string(src, "partition-name");
+
+	ret = fw_fdt_get_blk(src, &desc);
+	if (ret)
+		return ret;
+
+	part = fw_fdt_find_part(desc, type_uuid, part_name);
+	if (part < 0)
+		return log_msg_ret("part", part);
+
+	ret = fw_fdt_read_fit(desc, part, fname, &out->fit, &out->fit_size);
+	if (ret)
+		return ret;
+
+	ret = fit_check_format(out->fit, out->fit_size);
+	if (ret)
+		return log_msg_ret("fit", -EINVAL);
+
+	ret = fw_fdt_check_images(out->fit);
+	if (ret)
+		return ret;
+
+	conf = env_get("fw_fdt_config");
+
+	ret = boot_get_fdt_fit(&images, map_to_sysmem(out->fit), NULL, &conf,
+			       IH_ARCH_DEFAULT, &data, &len);
+	if (ret < 0)
+		return log_msg_ret("conf", ret);
+
+	fdt = map_sysmem(data, len);
+
+	ret = fdt_check_full(fdt, len);
+	if (ret)
+		return log_msg_ret("chk", -EINVAL);
+
+	out->fdt = fdt;
+	out->size = len;
+	out->name = fname;
+
+	return 0;
+}
+
+int firmware_fdt_load(struct firmware_fdt *out)
+{
+	ofnode src;
+	int ret;
+
+	memset(out, '\0', sizeof(*out));
+
+	ret = fw_fdt_get_checked_source(&src);
+	if (ret)
+		return ret;
+
+	ret = fw_fdt_assemble(out, src);
+	if (ret) {
+		firmware_fdt_free(out);
+
+		/*
+		 * Callers treat -ENOENT as "no source configured" and fall
+		 * back to their normal devicetree. A source IS configured
+		 * here, so remap any downstream -ENOENT (missing manifest,
+		 * missing FIT configuration, ...) to -ENODEV to keep the
+		 * failure fatal (fail closed).
+		 */
+		if (ret == -ENOENT)
+			ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+void firmware_fdt_free(struct firmware_fdt *fw)
+{
+	u8 *fit = fw->fit;
+
+	/*
+	 * The assembled devicetree either points into the manifest buffer or
+	 * is a separate allocation (made when applying overlays, or when
+	 * aligning the devicetree); free it only in the latter case.
+	 */
+	if (fw->fdt &&
+	    ((u8 *)fw->fdt < fit || (u8 *)fw->fdt >= fit + fw->fit_size))
+		free(fw->fdt);
+
+	free(fw->fit);
+	memset(fw, '\0', sizeof(*fw));
+}
diff --git a/doc/develop/bootstd/firmware_fdt.rst b/doc/develop/bootstd/firmware_fdt.rst
new file mode 100644
index 00000000000..d849e66b5db
--- /dev/null
+++ b/doc/develop/bootstd/firmware_fdt.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Firmware-owned devicetree
+=========================
+
+Some platforms following EBBR / Arm SystemReady IR treat the devicetree as
+part of the firmware: it lives on a firmware-owned partition and is updated
+independently of the operating system, instead of being shipped in the OS
+image or on the EFI System Partition. U-Boot must read that devicetree,
+assemble it (base plus overlays) and hand it to the OS.
+
+The :c:func:`firmware_fdt_load` helper (``CONFIG_BOOTSTD_FIRMWARE_FDT``)
+provides this. It is consumed by both EFI launch paths so the firmware-owned
+devicetree is installed regardless of how the EFI application is started:
+
+  - the per-device EFI bootmeth (``bootmeth_efi``), and
+  - the EFI boot manager (``efi_bootmgr_run()``).
+
+In each case the assembled devicetree is installed into the EFI configuration
+table via :c:func:`efi_install_fdt`, exactly like any other source, so the OS
+cannot tell where it came from.
+
+This is a generic replacement for vendor-specific firmware-devicetree
+commands.
+
+The manifest
+------------
+
+The firmware partition carries a FIT manifest (by default ``fdt.itb``). Its
+images hold the base DTB and any overlays, and each of its configurations
+names one bootable combination through the standard ``fdt`` property::
+
+    configurations {
+        default = "conf-panel";
+        conf-panel {
+            fdt = "fdt-base", "fdt-panel";
+        };
+    };
+
+The helper selects a configuration, verifies it, loads the base devicetree
+and applies the listed overlays in order (via :c:func:`boot_get_fdt_fit`, the
+same code path ``bootm`` uses). The manifest describes and carries the
+devicetree as one artefact, updated atomically with it.
+
+Images in the manifest must be self-contained flat devicetrees: images that
+carry a ``load`` address and manifests using external data are rejected. With
+``FIT_SIGNATURE`` enabled, node and configuration names must not contain
+``@``.
+
+Configuration
+-------------
+
+The manifest location is described in the control devicetree (see
+``doc/device-tree-bindings/firmware-fdt.txt``): the ``bootstd`` node carries
+a ``firmware-fdt-source`` phandle to a ``u-boot,firmware-fdt-block`` node,
+which is a child of the media device that owns the partition and identifies
+it by GPT type UUID and/or name, with an optional ``filename`` for the
+manifest path.
+
+Two optional environment variables select among what the manifest ships:
+``boot_dtb`` pins a partition number (A/B firmware partitions) and
+``fw_fdt_config`` names the FIT configuration to use (defaulting to the
+manifest's ``default`` configuration).
+
+If no source is configured, the helper returns ``-ENOENT`` and the caller
+falls back to its normal devicetree source (ESP / built-in control FDT). If a
+source is configured but cannot be assembled, the error is fatal for that EFI
+launch path; this prevents a bad or unauthenticated firmware devicetree from
+being silently replaced by another devicetree source.
+
+A firmware-owned devicetree is the complete, authoritative devicetree: no
+other devicetree source is layered on top of it. In particular,
+extension-board overlays (``extension_scan()``) are intentionally not
+applied, since modifying the assembled (and, in secure mode, signed)
+devicetree would defeat the authenticated-combination model. Boards using
+extension boards should ship each supported combination as a manifest
+configuration and select it with ``fw_fdt_config``.
+
+Secure boot
+-----------
+
+Signing a FIT configuration authenticates the whole combination: the base,
+the overlay set and its ordering are the signed unit, and a tampered selector
+can only pick among combinations the firmware author pre-signed. Sign the
+manifest and inject the public key into U-Boot's control devicetree as
+usual::
+
+    mkimage -f fdt.its -k keys -K u-boot.dtb -r fdt.itb
+
+With ``CONFIG_FIT_SIGNATURE`` enabled and a required key in the control
+devicetree, verification is enforced by the standard verified-boot policy:
+an unsigned or tampered manifest is rejected and, because a configured source
+never falls back, the boot fails closed rather than booting an unverified
+devicetree.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index ec74fc2fb9d..a7cd4c47261 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -14,4 +14,5 @@ Standard Boot
    cros
    rauc
    script
+   firmware_fdt
    sandbox
diff --git a/doc/device-tree-bindings/firmware-fdt.txt b/doc/device-tree-bindings/firmware-fdt.txt
new file mode 100644
index 00000000000..9b7cf2aff59
--- /dev/null
+++ b/doc/device-tree-bindings/firmware-fdt.txt
@@ -0,0 +1,149 @@
+U-Boot firmware-owned devicetree source (firmware-fdt)
+======================================================
+
+Some platforms (EBBR / Arm SystemReady IR) keep the devicetree on a
+firmware-owned partition, updated independently of the operating system,
+rather than shipping it in the OS image or the EFI System Partition. The
+partition carries a FIT manifest: its images hold the base DTB and any
+overlays, and each of its configurations names one bootable combination
+through the standard 'fdt' property. U-Boot selects a configuration,
+verifies it per the usual verified-boot policy, assembles the devicetree
+(base plus overlays, in order) and installs it via the EFI configuration
+table.
+
+This binding describes where that manifest lives. The source is referenced
+from the bootstd node and described by a node that is a child of the media
+device (UCLASS_MMC, ...) that owns the partition.
+
+
+bootstd node
+------------
+
+Optional property:
+
+firmware-fdt-source:
+   phandle to the firmware-fdt source node to use
+
+
+firmware-fdt source node
+------------------------
+
+Required properties:
+
+compatible:
+   "u-boot,firmware-fdt-block" - the manifest lives in a filesystem on a
+   GPT partition of a block device (the parent media device)
+
+The partition is selected by the 'boot_dtb' environment variable, if set,
+which pins a partition number (for A/B firmware partitions). Otherwise the
+first partition matching every configured selector is used: when both
+'partition-type-uuid' and 'partition-name' are present, both must match (so
+a misprovisioned disk fails closed instead of silently selecting whichever
+same-type partition comes first).
+
+At least one of 'partition-type-uuid' or 'partition-name' must be present.
+
+Optional properties:
+
+partition-type-uuid:
+   GPT partition type UUID (string, case-insensitive) identifying the
+   firmware partition. When A/B firmware partitions share a type UUID,
+   'partition-name' disambiguates between them.
+
+partition-name:
+   GPT partition name (string) identifying the firmware partition. Used to
+   disambiguate, or as a fallback when 'partition-type-uuid' is absent.
+
+filename:
+   Path of the FIT manifest on the partition (default: "fdt.itb").
+
+
+Environment
+-----------
+
+Two optional environment variables select among what the manifest ships:
+
+   boot_dtb        pin a specific partition number (A/B firmware partitions)
+   fw_fdt_config   name of the FIT configuration to use; when unset the
+                   manifest's default configuration (or the best compatible
+                   match, with FIT_BEST_MATCH) is used
+
+Both values only choose among combinations the firmware author shipped; with
+signed configurations a tampered value cannot select an unsigned combination.
+
+
+The manifest
+------------
+
+The manifest is a standard FIT image. Every image must be a flat devicetree
+('type = "flat_dt"') without a load address (images carrying a 'load'
+property are rejected), self-contained (no external data). For secure boot,
+sign the configurations and enable FIT_SIGNATURE with a required key in the
+control devicetree. Example source (.its):
+
+	/dts-v1/;
+	/ {
+		description = "Firmware-owned devicetree";
+		#address-cells = <1>;
+
+		images {
+			fdt-base {
+				description = "base board devicetree";
+				data = /incbin/("board.dtb");
+				type = "flat_dt";
+				arch = "arm64";
+				compression = "none";
+				hash-1 { algo = "sha256"; };
+			};
+			fdt-panel {
+				description = "panel overlay";
+				data = /incbin/("panel.dtbo");
+				type = "flat_dt";
+				arch = "arm64";
+				compression = "none";
+				hash-1 { algo = "sha256"; };
+			};
+		};
+
+		configurations {
+			default = "conf-panel";
+			conf-panel {
+				fdt = "fdt-base", "fdt-panel";
+				signature-1 {
+					algo = "sha256,rsa2048";
+					key-name-hint = "fw";
+					sign-images = "fdt";
+				};
+			};
+			conf-base {
+				fdt = "fdt-base";
+				signature-1 {
+					algo = "sha256,rsa2048";
+					key-name-hint = "fw";
+					sign-images = "fdt";
+				};
+			};
+		};
+	};
+
+Note: with FIT_SIGNATURE enabled, node and configuration names must not
+contain the '@' character.
+
+
+Example
+-------
+
+	bootstd {
+		compatible = "u-boot,boot-std";
+
+		firmware-fdt-source = <&fw_fdt>;
+	};
+
+	&mmc0 {
+		fw_fdt: firmware-fdt {
+			compatible = "u-boot,firmware-fdt-block";
+			partition-type-uuid =
+				"384e979b-eb76-435a-a3a6-1a071dbad91d";
+			partition-name = "firmware";
+		};
+	};
diff --git a/include/firmware_fdt.h b/include/firmware_fdt.h
new file mode 100644
index 00000000000..269e6e741f2
--- /dev/null
+++ b/include/firmware_fdt.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Firmware-owned devicetree (FDT) source for EFI boot.
+ *
+ * Some platforms (EBBR / Arm SystemReady IR) keep the devicetree on a
+ * firmware-owned partition rather than in the OS image or the EFI System
+ * Partition. This provides a single helper that locates that partition,
+ * assembles the devicetree from the FIT manifest it carries, and returns the
+ * result so the caller can install it via the EFI configuration table
+ * (efi_install_fdt()).
+ *
+ * The same helper is intended to be consumed by both the per-device EFI
+ * bootmeth and the EFI boot manager, so firmware-owned DT provenance is
+ * honoured regardless of which path launches the EFI application.
+ */
+
+#ifndef __FIRMWARE_FDT_H
+#define __FIRMWARE_FDT_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/**
+ * struct firmware_fdt - an assembled, firmware-owned devicetree
+ *
+ * @fdt: pointer to the assembled devicetree in memory
+ * @size: size of the assembled devicetree, in bytes
+ * @name: manifest filename it was assembled from (for diagnostics)
+ * @fit: internal: buffer holding the FIT manifest
+ * @fit_size: internal: size of the FIT manifest, in bytes
+ *
+ * All memory is owned by the helper: release it with firmware_fdt_free()
+ * once the devicetree has been consumed (installed or copied).
+ */
+struct firmware_fdt {
+	void *fdt;
+	ulong size;
+	const char *name;
+	void *fit;
+	ulong fit_size;
+};
+
+#if CONFIG_IS_ENABLED(BOOTSTD_FIRMWARE_FDT)
+/**
+ * firmware_fdt_load() - assemble the devicetree from a firmware partition
+ *
+ * Assemble the devicetree (the base DTB with its overlays applied, as
+ * described by the FIT manifest on the configured firmware partition) and
+ * return it in @out, ready to hand to the OS.
+ *
+ * @out: returns the assembled devicetree on success
+ * Return: 0 on success; -ENOENT if no source is configured (the caller may
+ *	   fall back to its normal devicetree); another negative errno if a
+ *	   configured source fails to assemble (the caller must fail, never
+ *	   fall back)
+ */
+int firmware_fdt_load(struct firmware_fdt *out);
+
+/**
+ * firmware_fdt_free() - release the memory behind an assembled devicetree
+ *
+ * Safe to call on a zeroed or already-freed @fw.
+ *
+ * @fw: the assembled devicetree to release
+ */
+void firmware_fdt_free(struct firmware_fdt *fw);
+#else
+static inline int firmware_fdt_load(struct firmware_fdt *out)
+{
+	return -ENOSYS;
+}
+
+static inline void firmware_fdt_free(struct firmware_fdt *fw)
+{
+}
+#endif
+
+#endif /* __FIRMWARE_FDT_H */

-- 
2.55.0

