Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCBBE7D266
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421BC86C13;
	Tue, 26 Sep 2023 10:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC6586D22; Tue, 26 Sep 2023 10:45:28 +0200 (CEST)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7CC86BCE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng@tinylab.org
X-QQ-mid: bizesmtp88t1695717894t9kaoh9d
Received: from pek-vx-bsp2.wrs.com ( [60.247.85.88])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Sep 2023 16:44:52 +0800 (CST)
X-QQ-SSF: 01200000000000F0I000000A0000000
X-QQ-FEAT: +ynUkgUhZJktoozAW/1eYvKvIEKkek9hI4JvmQRbgD53vqit1ki6v8zOwcmzj
 IiMtOqmmyqltGyRYt7uhRI15eN/jnjVbC5W979jO826PtpBQ0nCWyxQubldiox59C+cIwBC
 +csdmKmTO1WpSE9M9ZtgcvYhJC6wA8I4WZyouGTFec+yd0hlxURMeOlw84ib+JxJwhVyWzg
 TuEGbUeiB+H87JUg6EKrAH/8K23kV/VEgRnNzhhUtCSioWe9vNwAvr5OOXqf9evupum89ML
 tMOHLmjdyYXKYwOzlBCUACc5e8XdFPw0enFbBKiKQyZ06Q6RS1ew2KyQexGRL/GITtunWut
 BnMnU9Q2Y0FcO4pah0sz/DKjw8GK0FT5WhwSa3W
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13357566477694781299
From: Bin Meng <bmeng@tinylab.org>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 01/15] blk: Use a macro for the typical block size
Date: Tue, 26 Sep 2023 16:43:31 +0800
Message-Id: <20230926084346.2237483-2-bmeng@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926084346.2237483-1-bmeng@tinylab.org>
References: <20230926084346.2237483-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
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

Avoid using the magic number 512 directly.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
---

 common/usb_storage.c     | 4 ++--
 drivers/ata/dwc_ahsata.c | 3 ++-
 drivers/ata/fsl_sata.c   | 3 ++-
 drivers/ata/sata_mv.c    | 3 ++-
 drivers/ata/sata_sil.c   | 3 ++-
 drivers/block/blkmap.c   | 2 +-
 drivers/block/host_dev.c | 2 +-
 drivers/mmc/mmc-uclass.c | 2 +-
 drivers/nvme/nvme.c      | 2 +-
 include/blk.h            | 2 ++
 10 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/common/usb_storage.c b/common/usb_storage.c
index 85774220ef..35c656db0d 100644
--- a/common/usb_storage.c
+++ b/common/usb_storage.c
@@ -219,8 +219,8 @@ static int usb_stor_probe_device(struct usb_device *udev)
 
 		snprintf(str, sizeof(str), "lun%d", lun);
 		ret = blk_create_devicef(udev->dev, "usb_storage_blk", str,
-					 UCLASS_USB, usb_max_devs, 512, 0,
-					 &dev);
+					 UCLASS_USB, usb_max_devs,
+					 DEFAULT_BLKSZ, 0, &dev);
 		if (ret) {
 			debug("Cannot bind driver\n");
 			return ret;
diff --git a/drivers/ata/dwc_ahsata.c b/drivers/ata/dwc_ahsata.c
index 6a4d861bf1..b4d4e39c9b 100644
--- a/drivers/ata/dwc_ahsata.c
+++ b/drivers/ata/dwc_ahsata.c
@@ -880,7 +880,8 @@ int dwc_ahsata_scan(struct udevice *dev)
 	device_find_first_child(dev, &blk);
 	if (!blk) {
 		ret = blk_create_devicef(dev, "dwc_ahsata_blk", "blk",
-					 UCLASS_AHCI, -1, 512, 0, &blk);
+					 UCLASS_AHCI, -1, DEFAULT_BLKSZ,
+					 0, &blk);
 		if (ret) {
 			debug("Can't create device\n");
 			return ret;
diff --git a/drivers/ata/fsl_sata.c b/drivers/ata/fsl_sata.c
index 972101b29c..969bc191f8 100644
--- a/drivers/ata/fsl_sata.c
+++ b/drivers/ata/fsl_sata.c
@@ -888,7 +888,8 @@ static int fsl_ata_probe(struct udevice *dev)
 	for (i = 0; i < nr_ports; i++) {
 		snprintf(sata_name, sizeof(sata_name), "fsl_sata%d", i);
 		ret = blk_create_devicef(dev, "sata_fsl_blk", sata_name,
-					 UCLASS_AHCI, -1, 512, 0, &blk);
+					 UCLASS_AHCI, -1, DEFAULT_BLKSZ,
+					 0, &blk);
 		if (ret) {
 			debug("Can't create device\n");
 			return ret;
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 18c7a66db1..1abea0b309 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1076,7 +1076,8 @@ static int sata_mv_probe(struct udevice *dev)
 
 	for (i = 0; i < nr_ports; i++) {
 		ret = blk_create_devicef(dev, "sata_mv_blk", "blk",
-					 UCLASS_AHCI, -1, 512, 0, &blk);
+					 UCLASS_AHCI, -1, DEFAULT_BLKSZ,
+					 0, &blk);
 		if (ret) {
 			debug("Can't create device\n");
 			continue;
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index b5e150d568..43a91a7912 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -730,7 +730,8 @@ static int sil_pci_probe(struct udevice *dev)
 	for (i = sata_info.portbase; i < sata_info.maxport; i++) {
 		snprintf(sata_name, sizeof(sata_name), "sil_sata%d", i);
 		ret = blk_create_devicef(dev, "sata_sil_blk", sata_name,
-					 UCLASS_AHCI, -1, 512, 0, &blk);
+					 UCLASS_AHCI, -1, DEFAULT_BLKSZ,
+					 0, &blk);
 		if (ret) {
 			debug("Can't create device\n");
 			return ret;
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 2bb0acc20f..409aa46de2 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -390,7 +390,7 @@ int blkmap_dev_bind(struct udevice *dev)
 	int err;
 
 	err = blk_create_devicef(dev, "blkmap_blk", "blk", UCLASS_BLKMAP,
-				 dev_seq(dev), 512, 0, &bm->blk);
+				 dev_seq(dev), DEFAULT_BLKSZ, 0, &bm->blk);
 	if (err)
 		return log_msg_ret("blk", err);
 
diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
index 64422417b7..31c7814054 100644
--- a/drivers/block/host_dev.c
+++ b/drivers/block/host_dev.c
@@ -105,7 +105,7 @@ static int host_sb_bind(struct udevice *dev)
 	int ret;
 
 	ret = blk_create_devicef(dev, "sandbox_host_blk", "blk", UCLASS_HOST,
-				 dev_seq(dev), 512, 0, &blk);
+				 dev_seq(dev), DEFAULT_BLKSZ, 0, &blk);
 	if (ret)
 		return log_msg_ret("blk", ret);
 
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 0e157672ea..328456831d 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -412,7 +412,7 @@ int mmc_bind(struct udevice *dev, struct mmc *mmc, const struct mmc_config *cfg)
 	debug("%s: alias devnum=%d\n", __func__, dev_seq(dev));
 
 	ret = blk_create_devicef(dev, "mmc_blk", "blk", UCLASS_MMC,
-				 dev_seq(dev), 512, 0, &bdev);
+				 dev_seq(dev), DEFAULT_BLKSZ, 0, &bdev);
 	if (ret) {
 		debug("Cannot create block device\n");
 		return ret;
diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 20dc910d8a..c39cd41aa3 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -906,7 +906,7 @@ int nvme_init(struct udevice *udev)
 
 		/* The real blksz and size will be set by nvme_blk_probe() */
 		ret = blk_create_devicef(udev, "nvme-blk", name, UCLASS_NVME,
-					 -1, 512, 0, &ns_udev);
+					 -1, DEFAULT_BLKSZ, 0, &ns_udev);
 		if (ret)
 			goto free_id;
 
diff --git a/include/blk.h b/include/blk.h
index 2c9c7985a8..4a4365fbbf 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -20,6 +20,8 @@ typedef ulong lbaint_t;
 #define LBAF "%" LBAFlength "x"
 #define LBAFU "%" LBAFlength "u"
 
+#define DEFAULT_BLKSZ		512
+
 struct udevice;
 
 static inline bool blk_enabled(void)
-- 
2.25.1

