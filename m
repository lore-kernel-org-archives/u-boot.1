Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06253E83836
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A09D83E36;
	Mon, 16 Feb 2026 22:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B710283D0F; Mon, 16 Feb 2026 22:22:57 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D168063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs63A-000000002i5-1qz3; Mon, 16 Feb 2026 21:22:36 +0000
Date: Mon, 16 Feb 2026 21:22:32 +0000
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
Subject: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
Message-ID: <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:23:05 +0100
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

Add a UBI volume storage backend for the image_loader framework.

image_loader_init_ubi() takes a volume name, ensures the UBI device
is attached (auto-attaching if needed), and installs a .read() callback
wrapping ubi_volume_read().

Auto-attach works by scanning the device tree for the first MTD
partition with compatible = "linux,ubi", then calling ubi_part() on
that partition. The partition name is resolved using the same
precedence as the MTD partition parser: the "label" property first,
then "name", then the node name. Since U-Boot only supports a single
attached UBI device at a time, only the first matching partition is
used. If a UBI device is already attached, the auto-attach step is
skipped.

UBI handles bad-block management and wear leveling internally, so the
read callback is a straightforward passthrough. Note that
ubi_volume_read() returns positive errno values; the wrapper negates
them for the image_loader convention.

Gated by CONFIG_IMAGE_LOADER_UBI (depends on CMD_UBI && IMAGE_LOADER).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig            |   8 +++
 boot/Makefile           |   1 +
 boot/image-loader-ubi.c | 112 ++++++++++++++++++++++++++++++++++++++++
 include/image-loader.h  |  13 +++++
 4 files changed, 134 insertions(+)
 create mode 100644 boot/image-loader-ubi.c

diff --git a/boot/Kconfig b/boot/Kconfig
index 23848a0f57e..89832014af6 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1203,6 +1203,14 @@ config IMAGE_LOADER_MTD
 	  parallel NAND, etc.) using the image_loader framework.
 	  NAND bad blocks are skipped transparently.
 
+config IMAGE_LOADER_UBI
+	bool "UBI volume backend for image loader"
+	depends on IMAGE_LOADER && CMD_UBI
+	help
+	  Allows loading images from UBI volumes using the image_loader
+	  framework. Auto-attaches the UBI device from the device tree
+	  if not already attached.
+
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
 	select CMDLINE
diff --git a/boot/Makefile b/boot/Makefile
index 1dde16db694..7d1d4a28106 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
 obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
 obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
 obj-$(CONFIG_IMAGE_LOADER_MTD) += image-loader-mtd.o
+obj-$(CONFIG_IMAGE_LOADER_UBI) += image-loader-ubi.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
diff --git a/boot/image-loader-ubi.c b/boot/image-loader-ubi.c
new file mode 100644
index 00000000000..64901a13378
--- /dev/null
+++ b/boot/image-loader-ubi.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UBI volume backend for image_loader
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <dm/ofnode.h>
+#include <image-loader.h>
+#include <log.h>
+#include <malloc.h>
+#include <mtd.h>
+#include <ubi_uboot.h>
+
+struct image_loader_ubi_priv {
+	char *vol_name;
+};
+
+/**
+ * ubi_auto_attach() - attach UBI if not already attached
+ *
+ * If no UBI device is currently attached, walk the device tree for the
+ * first MTD partition node with compatible = "linux,ubi", find the
+ * corresponding MTD device by matching flash_node, and attach UBI to
+ * it via ubi_part_from_mtd().
+ *
+ * Since U-Boot only supports a single attached UBI device at a time,
+ * only the first matching partition is used.
+ *
+ * Return: 0 on success or if already attached, negative errno on failure
+ */
+static int ubi_auto_attach(void)
+{
+	struct mtd_info *mtd;
+	ofnode node;
+
+	/* Already attached? */
+	if (ubi_devices[0])
+		return 0;
+
+	mtd_probe_devices();
+
+	ofnode_for_each_compatible_node(node, "linux,ubi") {
+		mtd_for_each_device(mtd) {
+			if (ofnode_equal(mtd->flash_node, node))
+				goto found;
+		}
+	}
+
+	log_err("image_loader_ubi: no MTD device for \"linux,ubi\" node\n");
+	return -ENODEV;
+
+found:
+	if (ubi_part_from_mtd(mtd)) {
+		log_err("image_loader_ubi: failed to attach UBI on \"%s\"\n",
+			mtd->name);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int image_loader_ubi_read(struct image_loader *ldr, ulong src,
+				 ulong size, void *dst)
+{
+	struct image_loader_ubi_priv *priv = ldr->priv;
+	int ret;
+
+	ret = ubi_volume_read(priv->vol_name, dst, src, size);
+	/* ubi_volume_read() returns positive errno values on error */
+	return ret ? -ret : 0;
+}
+
+static void image_loader_ubi_cleanup(struct image_loader *ldr)
+{
+	struct image_loader_ubi_priv *priv = ldr->priv;
+
+	free(priv->vol_name);
+	free(priv);
+}
+
+int image_loader_init_ubi(struct image_loader *ldr, const char *vol_name)
+{
+	struct image_loader_ubi_priv *priv;
+	int ret;
+
+	ret = ubi_auto_attach();
+	if (ret)
+		return ret;
+
+	if (!ubi_find_volume(vol_name)) {
+		log_err("image_loader_ubi: volume \"%s\" not found\n",
+			vol_name);
+		return -ENODEV;
+	}
+
+	priv = malloc(sizeof(*priv));
+	if (!priv)
+		return -ENOMEM;
+
+	priv->vol_name = strdup(vol_name);
+	if (!priv->vol_name) {
+		free(priv);
+		return -ENOMEM;
+	}
+
+	ldr->read = image_loader_ubi_read;
+	ldr->cleanup = image_loader_ubi_cleanup;
+	ldr->priv = priv;
+
+	return 0;
+}
diff --git a/include/image-loader.h b/include/image-loader.h
index 7ccf901d37d..a036e98982f 100644
--- a/include/image-loader.h
+++ b/include/image-loader.h
@@ -172,4 +172,17 @@ int image_loader_init_blk(struct image_loader *ldr, const char *ifname,
  */
 int image_loader_init_mtd(struct image_loader *ldr, const char *name);
 
+/**
+ * image_loader_init_ubi() - Initialise loader for a UBI volume
+ *
+ * Ensures a UBI device is attached (auto-attaching from the device
+ * tree if needed), verifies the named volume exists, then installs a
+ * .read() callback wrapping ubi_volume_read().
+ *
+ * @ldr:	The image loader to initialise
+ * @vol_name:	UBI volume name
+ * Return: 0 on success, negative errno on failure
+ */
+int image_loader_init_ubi(struct image_loader *ldr, const char *vol_name);
+
 #endif /* __IMAGE_LOADER_H */
-- 
2.53.0
