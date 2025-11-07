Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5298ECCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 23:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D333183D52;
	Sat,  8 Nov 2025 00:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="AoQpMXeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CE583E40; Sat,  8 Nov 2025 00:30:13 +0100 (CET)
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28B483D0C
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 00:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alexeymin@minlexx.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G+j+BdFGnekXI2xV/j8JdsG0H3bYWPbSSA0BIQ1fjBo=; b=AoQpMXeXBOozElFlmZl2kylrjc
 kyz6k77WmgVuNDijVCT4GMKPKR3lPSk83dA5QrD6bWGWLao5xWowyltbYyHVyF5vjqjRxzipnOU8m
 5UuZ+Gck7dGRXfQytUXJtQ5nnZ0k02JOEMoJHnAwsa7aI0qFjgWs8U45CpggIS5S3gTg=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1vHVuC-00000001MkX-0Lrq; Sat, 08 Nov 2025 02:30:08 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, ~postmarketos/upstreaming@lists.sr.ht,
 Alexey Minnekhanov <alexeymin@minlexx.ru>
Subject: [PATCH] mach-snapdragon: capsule_update: Fix eMMC detection for
 non-UFS devices
Date: Sat,  8 Nov 2025 02:29:35 +0300
Message-ID: <20251107232935.283843-1-alexeymin@minlexx.ru>
X-Mailer: git-send-email 2.51.0
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

Currently (since 2026.01-rc) on all SDM630/660 based devices this is
printed, after observing long boot delay (several seconds) before
executing preboot commands:

 QCOM-FMP: Failed to find boot partition

find_target_partition() function incorrectly assumes that eMMC is always
at number 0. In general you can't rely on device numbering to determine if
particular block device is eMMC or SD-card, because it depends on how
aliases are defined in device tree "chosen" node. Some SoCs have MMC
numbers starting at 1, not 0; so mmc1 is eMMC, mmc2 is SD-card.

Make eMMC detection reliable by using IS_SD() macro from mmc.h header.
Using this method target boot partition can be found successfully.
With debug prints enabled, this is printed:

 QCOM-FMP: skipped SD-Card (devnum 2)
 QCOM-FMP: Capsule update target: boot (disk 1:60)
 QCOM-FMP: DFU string: 'mmc 0=u-boot.bin part 1 60'

Without debug prints nothing is printed, no error about failure to find
boot partition.

Fixes: fe80a5f80095 ("mach-snapdragon: CapsuleUpdate: support all boot methods")
Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
---
 arch/arm/mach-snapdragon/capsule_update.c | 28 +++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index 3699d91852d..586682434b7 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -13,6 +13,7 @@
 #include <efi.h>
 #include <efi_loader.h>
 #include <malloc.h>
+#include <mmc.h>
 #include <scsi.h>
 #include <part.h>
 #include <linux/err.h>
@@ -80,6 +81,23 @@ static enum ab_slot get_part_slot(const char *partname)
 	return SLOT_NONE;
 }
 
+/* Shamelessly copied from lib/efi_loader/efi_device_path.c @ 33 */
+/*
+ * Determine if an MMC device is an SD card.
+ *
+ * @desc	block device descriptor
+ * Return:	true if the device is an SD card
+ */
+static bool is_sd(struct blk_desc *desc)
+{
+	struct mmc *mmc = find_mmc_device(desc->devnum);
+
+	if (!mmc)
+		return false;
+
+	return IS_SD(mmc) != 0U;
+}
+
 /*
  * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
  * the slot status, and prioritizing the uefi partition over xbl if found.
@@ -109,19 +127,21 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
 		if (device_get_uclass_id(dev) != UCLASS_BLK)
 			continue;
 
+		desc = dev_get_uclass_plat(dev);
+
 		/* If we have a UFS then don't look at any other block devices */
 		if (have_ufs) {
 			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
 				continue;
+		}
 		/*
-		 * If we don't have UFS, then U-Boot must be on the eMMC which is always the first
-		 * MMC device.
+		 * If we don't have UFS, then U-Boot must be on the eMMC
 		 */
-		} else if (dev->parent->seq_ > 0) {
+		else if (IS_ENABLED(CONFIG_MMC) && is_sd(desc)) {
+			log_debug("skipped SD-Card (devnum %d)\n", desc->devnum);
 			continue;
 		}
 
-		desc = dev_get_uclass_plat(dev);
 		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
 			continue;
 		for (partnum = 1;; partnum++) {
-- 
2.51.0

