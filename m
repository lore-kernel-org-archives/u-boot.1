Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B9CC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645BA84AE6;
	Thu,  9 Jul 2026 00:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WUVI0s7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F336584AD0; Thu,  9 Jul 2026 00:06:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CAE084AE6
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548373; bh=ZJkEoDQDYLwoId0ufD3Yi1OPijbvOXXYhyx9qneZ8+E=;
 b=WUVI0s7zTmKgD2jwQlZcGRhTYywrWANhYA4MNlVL44zFl1tEYh6FC5GzdqUP3A2DDcXfLyUgm
 mJRHct6akHva1tt1SnQCJ0xa6JVVJI2zJXawUnayzWvigeosG3gU//lP1Lmq+lTDLMIYPqFWU9/
 j2TJfVQ7ptnrW8We2Tbs9qjinrtXWp6B94rCfQbV82qmt3+ToV/X2qxLxqsD3LIeW19fM+j/BIx
 R6T52CzA8OAk8SOjaJW6xNerD8/CQ3qwybghfxO6tVqY3s1aPkCGXOejdfbj4zdc1kiZqMitarq
 iQwN+xF35Zyoox4EEtWyz4XAdwIvXo0QM3jcNL1ek3qQ==
X-Forward-Email-ID: 6a4ec9d32402b3ca75f90510
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/11] spl: Use CONFIG_IS_ENABLED() for LIBCOMMON_SUPPORT
 checks
Date: Wed,  8 Jul 2026 22:05:37 +0000
Message-ID: <20260708220540.3368825-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
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

Use CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) instead of directly checking
CONFIG_SPL_LIBCOMMON_SUPPORT when guarding printf/log calls to depend on
correct xPL_LIBCOMMON_SUPPORT symbol. Also change to use IS_ENABLED()
for the XPL_BUILD symbol checks for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 boot/common_fit.c        |  2 +-
 common/spl/spl_usb.c     |  2 +-
 drivers/mmc/mmc-uclass.c |  4 ++--
 drivers/mmc/mmc.c        | 16 ++++++++--------
 drivers/mmc/mmc_legacy.c |  4 ++--
 include/spl.h            |  6 +++---
 lib/hang.c               |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/boot/common_fit.c b/boot/common_fit.c
index fd434fe28e19..9dcec1cd7d7d 100644
--- a/boot/common_fit.c
+++ b/boot/common_fit.c
@@ -53,7 +53,7 @@ int fit_find_config_node(const void *fdt)
 	     node = fdt_next_subnode(fdt, node)) {
 		name = fdt_getprop(fdt, node, FIT_DESC_PROP, &len);
 		if (!name) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 			printf("%s: Missing FDT description in DTB\n",
 			       __func__);
 #endif
diff --git a/common/spl/spl_usb.c b/common/spl/spl_usb.c
index 932da56ab6db..365d57063c9d 100644
--- a/common/spl/spl_usb.c
+++ b/common/spl/spl_usb.c
@@ -31,7 +31,7 @@ int spl_usb_load(struct spl_image_info *spl_image,
 	}
 
 	if (err) {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 		printf("%s: usb init failed: err - %d\n", __func__, err);
 #endif
 		return err;
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 698530088fe7..ffb5e9800fb5 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -318,7 +318,7 @@ struct mmc *find_mmc_device(int dev_num)
 	ret = blk_find_device(UCLASS_MMC, dev_num, &dev);
 
 	if (ret) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 		printf("MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
@@ -390,7 +390,7 @@ void mmc_do_preinit(void)
 	}
 }
 
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct udevice *dev;
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 2e5655606564..f24a66c389a9 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -328,7 +328,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 			break;
 
 		if (status & MMC_STATUS_MASK) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 			log_err("Status Error: %#08x\n", status);
 #endif
 			return -ECOMM;
@@ -341,7 +341,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 	}
 
 	if (timeout_ms <= 0) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 		log_err("Timeout waiting card ready\n");
 #endif
 		return -ETIMEDOUT;
@@ -483,7 +483,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 
 	if (blkcnt > 1) {
 		if (mmc_send_stop_transmission(mmc, false)) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 			log_err("mmc fail to send stop cmd\n");
 #endif
 			return 0;
@@ -534,7 +534,7 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 		return 0;
 
 	if ((start + blkcnt) > block_dev->lba) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 		log_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
 			start + blkcnt, block_dev->lba);
 #endif
@@ -2769,8 +2769,8 @@ static int mmc_startup(struct mmc *mmc)
 	bdesc->blksz = mmc->read_bl_len;
 	bdesc->log2blksz = LOG2(bdesc->blksz);
 	bdesc->lba = lldiv(mmc->capacity, mmc->read_bl_len);
-#if !defined(CONFIG_XPL_BUILD) || \
-		(defined(CONFIG_SPL_LIBCOMMON_SUPPORT) && \
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || \
+		(CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) && \
 		!CONFIG_IS_ENABLED(USE_TINY_PRINTF))
 	sprintf(bdesc->vendor, "Man %06x Snr %04x%04x",
 		mmc->cid[0] >> 24, (mmc->cid[2] & 0xffff),
@@ -3028,7 +3028,7 @@ retry:
 		err = mmc_send_op_cond(mmc);
 
 		if (err) {
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 			if (!quiet)
 				log_err("Card did not respond to voltage select! : %d\n",
 					err);
@@ -3083,7 +3083,7 @@ int mmc_start_init(struct mmc *mmc)
 #endif
 	if (no_card) {
 		mmc->has_init = 0;
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 		log_err("MMC: no card present\n");
 #endif
 		return -ENOMEDIUM;
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index 8f8ba34be717..d29c611011bf 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -44,7 +44,7 @@ struct mmc *find_mmc_device(int dev_num)
 			return m;
 	}
 
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 	printf("MMC Device %d not found\n", dev_num);
 #endif
 
@@ -93,7 +93,7 @@ void mmc_list_add(struct mmc *mmc)
 	list_add_tail(&mmc->link, &mmc_devices);
 }
 
-#if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 void print_mmc_devices(char separator)
 {
 	struct mmc *m;
diff --git a/include/spl.h b/include/spl.h
index 45dd44e03d13..98d1a8fda409 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -792,7 +792,7 @@ struct spl_boot_device {
  * @load_image: Function to call to load image
  */
 struct spl_image_loader {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 	const char *name;
 #endif
 	uint boot_device;
@@ -809,7 +809,7 @@ struct spl_image_loader {
 /* Helper function for accessing the name */
 static inline const char *spl_loader_name(const struct spl_image_loader *loader)
 {
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 	const char *name;
 	name = spl_board_loader_name(loader->boot_device);
 	return name ?: loader->name;
@@ -828,7 +828,7 @@ static inline const char *spl_loader_name(const struct spl_image_loader *loader)
  * _boot_device is the BOOT_DEVICE_... value
  * _method is the load_image function to call
  */
-#ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
+#if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
 #define SPL_LOAD_IMAGE_METHOD(_name, _priority, _boot_device, _method) \
 	SPL_LOAD_IMAGE(_boot_device ## _priority ## _method) = { \
 		.name = _name, \
diff --git a/lib/hang.c b/lib/hang.c
index f3c3c896f0ab..42c5722740a3 100644
--- a/lib/hang.c
+++ b/lib/hang.c
@@ -22,7 +22,7 @@
  */
 void hang(void)
 {
-#if !defined(CONFIG_XPL_BUILD) || \
+#if !IS_ENABLED(CONFIG_XPL_BUILD) || \
 		(CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) && \
 		 CONFIG_IS_ENABLED(SERIAL))
 	puts("### ERROR ### Please RESET the board ###\n");
-- 
2.54.0

