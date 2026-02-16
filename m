Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC32E83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E4E83D5D;
	Mon, 16 Feb 2026 22:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3030883AA9; Mon, 16 Feb 2026 22:22:13 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A1983CB5
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs62T-000000002eB-2MMy; Mon, 16 Feb 2026 21:21:53 +0000
Date: Mon, 16 Feb 2026 21:21:49 +0000
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
Subject: [RFC PATCH 04/20] boot: image-loader: add MTD backend
Message-ID: <b2ad68da753c0e0a87db8c6f928e1176a50efbe1.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:22:55 +0100
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

Add an MTD storage backend for the image_loader framework.

image_loader_init_mtd() takes the name of an MTD partition, resolves
it via get_mtd_device_nm(), and installs a .read() callback that
translates byte-offset reads into mtd_read() calls.

On NAND devices, the read callback implements bad-block skipping:
when a read straddles a bad block, the block is silently skipped and
reading continues at the next good block. This matches the convention
used by the mtd command and OpenWrt's mtd utilities.

For NOR devices, reads are passed straight through to mtd_read()
without bad-block logic.

The .cleanup callback releases the MTD device reference (via
put_mtd_device()) and frees the private context, ensuring safe
teardown between consecutive boot attempts.

Gated by CONFIG_IMAGE_LOADER_MTD (depends on DM_MTD && IMAGE_LOADER).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/Kconfig            |   8 ++++
 boot/Makefile           |   1 +
 boot/image-loader-mtd.c | 103 ++++++++++++++++++++++++++++++++++++++++
 include/image-loader.h  |  14 ++++++
 4 files changed, 126 insertions(+)
 create mode 100644 boot/image-loader-mtd.c

diff --git a/boot/Kconfig b/boot/Kconfig
index e94b52288a3..23848a0f57e 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1195,6 +1195,14 @@ config IMAGE_LOADER_BLK
 	  USB, etc.) using the image_loader framework. Partitions can
 	  be identified by number or name.
 
+config IMAGE_LOADER_MTD
+	bool "MTD backend for image loader"
+	depends on IMAGE_LOADER && DM_MTD
+	help
+	  Allows loading images from MTD partitions (SPI-NOR, SPI-NAND,
+	  parallel NAND, etc.) using the image_loader framework.
+	  NAND bad blocks are skipped transparently.
+
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
 	select CMDLINE
diff --git a/boot/Makefile b/boot/Makefile
index ac006bbaa82..1dde16db694 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
 
 obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
 obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
+obj-$(CONFIG_IMAGE_LOADER_MTD) += image-loader-mtd.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
diff --git a/boot/image-loader-mtd.c b/boot/image-loader-mtd.c
new file mode 100644
index 00000000000..0aa1163e2db
--- /dev/null
+++ b/boot/image-loader-mtd.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MTD backend for image_loader
+ *
+ * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <image-loader.h>
+#include <malloc.h>
+#include <mtd.h>
+#include <log.h>
+#include <linux/err.h>
+
+struct image_loader_mtd_priv {
+	struct mtd_info *mtd;
+};
+
+static int image_loader_mtd_read(struct image_loader *ldr, ulong src,
+				 ulong size, void *dst)
+{
+	struct image_loader_mtd_priv *priv = ldr->priv;
+	struct mtd_info *mtd = priv->mtd;
+	loff_t phys = src;
+	size_t retlen;
+	int ret;
+
+	if (mtd_can_have_bb(mtd)) {
+		/*
+		 * NAND — walk from the beginning of the device, skipping
+		 * bad blocks, to translate the logical byte offset @src
+		 * into a physical byte offset. The actual read with
+		 * further bad-block skipping is handled by
+		 * mtd_read_skip_bad().
+		 */
+		loff_t off = 0;
+		ulong logical = 0;
+
+		while (logical < src) {
+			loff_t block_start = off & ~(loff_t)(mtd->erasesize - 1);
+			ulong block_remain, chunk;
+
+			if (off >= mtd->size) {
+				log_err("image_loader_mtd: offset past end of device\n");
+				return -EINVAL;
+			}
+
+			if (mtd_block_isbad(mtd, block_start)) {
+				off = block_start + mtd->erasesize;
+				continue;
+			}
+
+			block_remain = mtd->erasesize - (ulong)(off - block_start);
+			chunk = min(block_remain, (ulong)(src - logical));
+			off += chunk;
+			logical += chunk;
+		}
+
+		phys = off;
+	}
+
+	ret = mtd_read_skip_bad(mtd, phys, size, &retlen, dst);
+	if (ret)
+		return ret;
+
+	return (retlen == size) ? 0 : -EIO;
+}
+
+static void image_loader_mtd_cleanup(struct image_loader *ldr)
+{
+	struct image_loader_mtd_priv *priv = ldr->priv;
+
+	put_mtd_device(priv->mtd);
+	free(priv);
+}
+
+int image_loader_init_mtd(struct image_loader *ldr, const char *name)
+{
+	struct image_loader_mtd_priv *priv;
+	struct mtd_info *mtd;
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm(name);
+	if (IS_ERR_OR_NULL(mtd)) {
+		log_err("image_loader_mtd: MTD device \"%s\" not found\n",
+			name);
+		return -ENODEV;
+	}
+
+	priv = malloc(sizeof(*priv));
+	if (!priv) {
+		put_mtd_device(mtd);
+		return -ENOMEM;
+	}
+
+	priv->mtd = mtd;
+
+	ldr->read = image_loader_mtd_read;
+	ldr->cleanup = image_loader_mtd_cleanup;
+	ldr->priv = priv;
+
+	return 0;
+}
diff --git a/include/image-loader.h b/include/image-loader.h
index 1a9048ba482..7ccf901d37d 100644
--- a/include/image-loader.h
+++ b/include/image-loader.h
@@ -158,4 +158,18 @@ void *image_loader_map_to(struct image_loader *ldr, ulong img_offset,
 int image_loader_init_blk(struct image_loader *ldr, const char *ifname,
 			  const char *dev_part_str);
 
+/**
+ * image_loader_init_mtd() - Initialise loader for an MTD partition
+ *
+ * Resolves the MTD device by @name via get_mtd_device_nm(), then
+ * installs a .read() callback that translates byte-offset reads into
+ * mtd_read() calls. On NAND devices, bad blocks are transparently
+ * skipped.
+ *
+ * @ldr:	The image loader to initialise
+ * @name:	MTD device/partition name
+ * Return: 0 on success, negative errno on failure
+ */
+int image_loader_init_mtd(struct image_loader *ldr, const char *name);
+
 #endif /* __IMAGE_LOADER_H */
-- 
2.53.0
