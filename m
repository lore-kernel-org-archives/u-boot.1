Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693B2E83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A7683EEF;
	Mon, 16 Feb 2026 22:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C584783E61; Mon, 16 Feb 2026 22:24:10 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2C783B8A
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs64P-000000002oy-2mGR; Mon, 16 Feb 2026 21:23:53 +0000
Date: Mon, 16 Feb 2026 21:23:50 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
Cc: John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: [RFC PATCH 16/20] boot: bootdev: add MTD boot device
Message-ID: <01cc9fe77706bfec2c7806f95d93c84678d06a91.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:24:18 +0100
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

Add a boot device driver for MTD (Memory Technology Devices) that
enables bootstd to scan MTD partitions for FIT images.

Add a mtd_bootdev_hunt() callback that:
- Calls mtd_probe_devices() once to probe all MTD devices (both
  UCLASS_MTD and UCLASS_SPI_FLASH) and parse their partitions
- Iterates the MTD subsystem device list and binds an mtd_bootdev for
  any top-level MTD device that has partitions but is not in UCLASS_MTD
  (those already get their bootdev from mtd_post_bind)
- Uses bootdev_bind() directly since sf_bootdev may already occupy the
  standard bootdev child slot

The MTD bootdev calls bootmeth_check() at the start of get_bootflow()
so that only compatible bootmeths (those that accept MTD bootdevs)
produce bootflows. Until bootmeth_openwrt's check() is extended to
accept MTD bootdevs, this driver is inert — each commit compiles and
introduces no regressions independently.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig             |   9 +++
 boot/Makefile            |   1 +
 boot/mtd_bootdev.c       | 150 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/mtd-uclass.c |  15 ++++
 4 files changed, 175 insertions(+)
 create mode 100644 boot/mtd_bootdev.c

diff --git a/boot/Kconfig b/boot/Kconfig
index d8c7b8360ac..63e373cc62d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -585,6 +585,15 @@ config BOOTMETH_CROS
 
 	  Note that only x86 devices are supported at present.
 
+config BOOTDEV_MTD
+	bool "MTD bootdev support"
+	depends on DM_MTD
+	depends on BOOTSTD
+	help
+	  Enable a boot device for MTD (Memory Technology Devices).
+	  This scans MTD partitions for uImage.FIT firmware images,
+	  enabling raw-flash boot via the OpenWrt boot method.
+
 config BOOTMETH_OPENWRT
 	bool "Bootdev support for OpenWrt"
 	depends on FIT
diff --git a/boot/Makefile b/boot/Makefile
index 7b42358eb0c..feeed4924dd 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
+obj-$(CONFIG_$(PHASE_)BOOTDEV_MTD) += mtd_bootdev.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_OPENWRT) += bootmeth_openwrt.o
 
 obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
diff --git a/boot/mtd_bootdev.c b/boot/mtd_bootdev.c
new file mode 100644
index 00000000000..8a3304be988
--- /dev/null
+++ b/boot/mtd_bootdev.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MTD boot device
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <bootdev.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <dm.h>
+#include <malloc.h>
+#include <mtd.h>
+#include <linux/libfdt.h>
+
+static int mtd_bootdev_get_bootflow(struct udevice *dev,
+				    struct bootflow_iter *iter,
+				    struct bootflow *bflow)
+{
+	struct udevice *parent = dev_get_parent(dev);
+	struct mtd_info *mtd, *part;
+	u8 buf[40];
+	size_t retlen;
+	char dname[60];
+	int n = 0;
+	int ret;
+
+	ret = bootmeth_check(bflow->method, iter);
+	if (ret)
+		return log_msg_ret("chk", ret);
+
+	/* Find the top-level MTD device matching our parent */
+	mtd_for_each_device(mtd) {
+		if (!mtd_is_partition(mtd) && mtd->dev == parent)
+			break;
+	}
+	if (!mtd || mtd->dev != parent)
+		return log_msg_ret("mtd", -ESHUTDOWN);
+
+	/* Count partitions so the scanning framework knows the bound */
+	list_for_each_entry(part, &mtd->partitions, node)
+		n++;
+	if (n)
+		iter->max_part = n - 1;
+
+	n = 0;
+
+	/* Walk to the iter->part'th sub-partition */
+	list_for_each_entry(part, &mtd->partitions, node) {
+		if (n == iter->part)
+			goto found;
+		n++;
+	}
+	return -ESHUTDOWN;
+
+found:
+	ret = mtd_read(part, 0, sizeof(buf), &retlen, buf);
+	if (ret || retlen < sizeof(buf))
+		return log_msg_ret("rd", -EIO);
+
+	if (fdt_check_header(buf))
+		return log_msg_ret("fdt", -ENOENT);
+
+	/* Device-style name and partition index for bootflow list display */
+	snprintf(dname, sizeof(dname), "%s.part_%x", dev->name, iter->part);
+	bflow->name = strdup(dname);
+	bflow->part = iter->part;
+	bflow->fname = strdup(part->name);
+	bflow->bootmeth_priv = strdup(part->name);
+	bflow->state = BOOTFLOWST_MEDIA;
+
+	return bootmeth_read_bootflow(bflow->method, bflow);
+}
+
+static int mtd_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_4_SCAN_FAST;
+
+	return 0;
+}
+
+struct bootdev_ops mtd_bootdev_ops = {
+	.get_bootflow	= mtd_bootdev_get_bootflow,
+};
+
+static const struct udevice_id mtd_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-mtd" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtd_bootdev) = {
+	.name		= "mtd_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &mtd_bootdev_ops,
+	.bind		= mtd_bootdev_bind,
+	.of_match	= mtd_bootdev_ids,
+};
+
+/**
+ * mtd_bootdev_hunt() - probe MTD devices and bind bootdevs
+ *
+ * Call mtd_probe_devices() to ensure all MTD devices (including SPI NOR
+ * flash via CONFIG_SPI_FLASH_MTD) are probed and their partitions parsed.
+ *
+ * UCLASS_MTD devices already get an mtd_bootdev via mtd_post_bind().
+ * This creates mtd_bootdev instances for other MTD devices (e.g. SPI NOR
+ * in UCLASS_SPI_FLASH) that have partitions but would otherwise lack one.
+ * bootdev_bind() is used directly because sf_bootdev may already occupy
+ * the standard bootdev child slot.
+ */
+static int mtd_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	struct mtd_info *mtd;
+	struct udevice *bdev;
+
+	mtd_probe_devices();
+
+	mtd_for_each_device(mtd) {
+		/* Only top-level MTD devices, not partitions */
+		if (mtd_is_partition(mtd))
+			continue;
+
+		/* Must have a DM device */
+		if (!mtd->dev)
+			continue;
+
+		/* UCLASS_MTD devices already have mtd_bootdev from post_bind */
+		if (device_get_uclass_id(mtd->dev) == UCLASS_MTD)
+			continue;
+
+		/* Only interested in MTD devices that have partitions */
+		if (list_empty(&mtd->partitions))
+			continue;
+
+		bootdev_bind(mtd->dev, "mtd_bootdev", "mtdbootdev", &bdev);
+	}
+
+	return 0;
+}
+
+BOOTDEV_HUNTER(mtd_bootdev_hunter) = {
+	.prio		= BOOTDEVP_4_SCAN_FAST,
+	.uclass		= UCLASS_MTD,
+	.drv		= DM_DRIVER_REF(mtd_bootdev),
+	.hunt		= mtd_bootdev_hunt,
+};
diff --git a/drivers/mtd/mtd-uclass.c b/drivers/mtd/mtd-uclass.c
index 720bd824c4d..0c637d3f5ec 100644
--- a/drivers/mtd/mtd-uclass.c
+++ b/drivers/mtd/mtd-uclass.c
@@ -5,11 +5,25 @@
 
 #define LOG_CATEGORY UCLASS_MTD
 
+#include <bootdev.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <errno.h>
 #include <mtd.h>
 
+static int mtd_post_bind(struct udevice *dev)
+{
+	if (CONFIG_IS_ENABLED(BOOTDEV_MTD)) {
+		int ret;
+
+		ret = bootdev_setup_for_dev(dev, "mtd_bootdev");
+		if (ret)
+			return log_msg_ret("bd", ret);
+	}
+
+	return 0;
+}
+
 /*
  * Implement a MTD uclass which should include most flash drivers.
  * The uclass private is pointed to mtd_info.
@@ -18,5 +32,6 @@
 UCLASS_DRIVER(mtd) = {
 	.id		= UCLASS_MTD,
 	.name		= "mtd",
+	.post_bind	= mtd_post_bind,
 	.per_device_auto	= sizeof(struct mtd_info),
 };
-- 
2.53.0
