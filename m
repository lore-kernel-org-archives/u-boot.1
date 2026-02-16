Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6984E83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF3683D5D;
	Mon, 16 Feb 2026 22:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC13883B8A; Mon, 16 Feb 2026 22:24:21 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5460C83EF9
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs64a-000000002pd-2aMS; Mon, 16 Feb 2026 21:24:04 +0000
Date: Mon, 16 Feb 2026 21:24:00 +0000
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
Subject: [RFC PATCH 17/20] boot: bootdev: add UBI boot device
Message-ID: <bc1fb5747051cd6462bf3158250a04ea8e83b14e.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:25:02 +0100
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

Add a boot device driver for UBI (Unsorted Block Images) that enables
bootstd to scan UBI volumes for FIT images.

The driver:
- Has a hunt callback that auto-attaches UBI: walks the DT for the
  first partition with compatible = "linux,ubi", finds the matching
  MTD device, and calls ubi_part_from_mtd() to attach
- Binds directly via bootdev_bind() as a child of the top-level MTD
  device, using a distinct name ("ubibootdev") to coexist with the
  MTD bootdev
- Iterates UBI volumes using iter->part as an index
- Reads the first bytes of each volume and checks for a valid FDT
  header via fdt_check_header()
- Stores the UBI volume name in bflow->bootmeth_priv for the
  bootmeth's boot() to pass to image_loader_init_ubi()
- Returns -ESHUTDOWN when all volumes are exhausted

Like the MTD bootdev, calls bootmeth_check() first so that only
compatible bootmeths produce bootflows. Inert until bootmeth_openwrt
is extended to accept UBI bootdevs.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig       |   9 +++
 boot/Makefile      |   1 +
 boot/ubi_bootdev.c | 180 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 boot/ubi_bootdev.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 63e373cc62d..75d40744e69 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -594,6 +594,15 @@ config BOOTDEV_MTD
 	  This scans MTD partitions for uImage.FIT firmware images,
 	  enabling raw-flash boot via the OpenWrt boot method.
 
+config BOOTDEV_UBI
+	bool "UBI bootdev support"
+	depends on CMD_UBI
+	depends on BOOTSTD
+	help
+	  Enable a boot device for UBI (Unsorted Block Images).
+	  This scans UBI volumes for uImage.FIT firmware images,
+	  enabling raw-flash boot via the OpenWrt boot method.
+
 config BOOTMETH_OPENWRT
 	bool "Bootdev support for OpenWrt"
 	depends on FIT
diff --git a/boot/Makefile b/boot/Makefile
index feeed4924dd..aa7968c3932 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
 obj-$(CONFIG_$(PHASE_)BOOTDEV_MTD) += mtd_bootdev.o
+obj-$(CONFIG_$(PHASE_)BOOTDEV_UBI) += ubi_bootdev.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_OPENWRT) += bootmeth_openwrt.o
 
 obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
diff --git a/boot/ubi_bootdev.c b/boot/ubi_bootdev.c
new file mode 100644
index 00000000000..03131a4ee1b
--- /dev/null
+++ b/boot/ubi_bootdev.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UBI boot device
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
+#include <dm/ofnode.h>
+#include <malloc.h>
+#include <mtd.h>
+#include <ubi_uboot.h>
+#include <linux/libfdt.h>
+
+static int ubi_bootdev_get_bootflow(struct udevice *dev,
+				    struct bootflow_iter *iter,
+				    struct bootflow *bflow)
+{
+	struct ubi_device *ubi;
+	struct ubi_volume *vol;
+	struct mtd_info *ubi_mtd, *top_mtd, *part;
+	char buf[40];
+	char dname[60];
+	int ubi_part_idx = 0;
+	int n = 0;
+	int i, ret;
+
+	ret = bootmeth_check(bflow->method, iter);
+	if (ret)
+		return log_msg_ret("chk", ret);
+
+	ubi = ubi_devices[0];
+	if (!ubi)
+		return log_msg_ret("ubi", -ENODEV);
+
+	/* Count volumes so the scanning framework knows the bound */
+	for (i = 0; i < ubi->vtbl_slots; i++) {
+		if (ubi->volumes[i])
+			n++;
+	}
+	if (n)
+		iter->max_part = n - 1;
+
+	n = 0;
+
+	/* Walk to the iter->part'th UBI volume */
+	for (i = 0; i < ubi->vtbl_slots; i++) {
+		vol = ubi->volumes[i];
+		if (!vol)
+			continue;
+		if (n == iter->part)
+			goto found;
+		n++;
+	}
+	return -ESHUTDOWN;
+
+found:
+	ret = ubi_volume_read(vol->name, buf, 0, sizeof(buf));
+	if (ret)
+		return log_msg_ret("rd", -EIO);
+
+	if (fdt_check_header(buf))
+		return log_msg_ret("fdt", -ENOENT);
+
+	/*
+	 * Find the MTD partition index hosting UBI so we can display
+	 * a meaningful partition number in the bootflow listing.
+	 */
+	ubi_mtd = ubi->mtd;
+	top_mtd = ubi_mtd;
+	while (top_mtd->parent)
+		top_mtd = top_mtd->parent;
+
+	n = 0;
+	list_for_each_entry(part, &top_mtd->partitions, node) {
+		if (part == ubi_mtd) {
+			ubi_part_idx = n;
+			break;
+		}
+		n++;
+	}
+
+	/* Device-style name and partition index for bootflow list display */
+	snprintf(dname, sizeof(dname), "%s.part_%x", dev->name, ubi_part_idx);
+	bflow->name = strdup(dname);
+	bflow->part = ubi_part_idx;
+	bflow->fname = strdup(vol->name);
+	bflow->bootmeth_priv = strdup(vol->name);
+	bflow->state = BOOTFLOWST_MEDIA;
+
+	return bootmeth_read_bootflow(bflow->method, bflow);
+}
+
+static int ubi_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_4_SCAN_FAST;
+
+	return 0;
+}
+
+/**
+ * ubi_bootdev_hunt() - attach UBI and bind a bootdev for it
+ *
+ * Walk the DT for the first partition with compatible = "linux,ubi",
+ * find its MTD device, attach UBI via ubi_part_from_mtd(), then bind
+ * a ubi_bootdev as a child of the top-level MTD DM device.
+ */
+static int ubi_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	struct udevice *bdev;
+	struct mtd_info *mtd;
+	ofnode node;
+	int ret;
+
+	mtd_probe_devices();
+
+	if (!ubi_devices[0]) {
+		ofnode_for_each_compatible_node(node, "linux,ubi") {
+			mtd_for_each_device(mtd) {
+				if (ofnode_equal(mtd->flash_node, node))
+					goto found;
+			}
+		}
+		return -ENOENT;
+found:
+		ret = ubi_part_from_mtd(mtd);
+		if (ret)
+			return log_msg_ret("att", -ENOENT);
+	}
+
+	/* Find the top-level MTD device for the attached UBI */
+	mtd = ubi_devices[0]->mtd;
+	while (mtd->parent)
+		mtd = mtd->parent;
+
+	if (!mtd->dev)
+		return log_msg_ret("dev", -ENODEV);
+
+	/*
+	 * Bind directly — bootdev_setup_for_dev() cannot be used here
+	 * because the MTD bootdev may already occupy the single bootdev
+	 * child slot.
+	 */
+	ret = bootdev_bind(mtd->dev, "ubi_bootdev", "ubibootdev", &bdev);
+	if (ret)
+		return log_msg_ret("bd", ret);
+
+	return 0;
+}
+
+struct bootdev_ops ubi_bootdev_ops = {
+	.get_bootflow	= ubi_bootdev_get_bootflow,
+};
+
+static const struct udevice_id ubi_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-ubi" },
+	{ }
+};
+
+U_BOOT_DRIVER(ubi_bootdev) = {
+	.name		= "ubi_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &ubi_bootdev_ops,
+	.bind		= ubi_bootdev_bind,
+	.of_match	= ubi_bootdev_ids,
+};
+
+BOOTDEV_HUNTER(ubi_bootdev_hunter) = {
+	.prio		= BOOTDEVP_4_SCAN_FAST,
+	.uclass		= UCLASS_MTD,
+	.drv		= DM_DRIVER_REF(ubi_bootdev),
+	.hunt		= ubi_bootdev_hunt,
+};
-- 
2.53.0
