Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C36C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8448887E;
	Sun, 11 Aug 2024 14:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mR6eRHHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B5BB88847; Sun, 11 Aug 2024 14:29:43 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077AA8837D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81fbbd4775bso125318539f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379380; x=1723984180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0o7O7846zQLb2VYdUj/Zb/T156GJTPxjLen7mr236Qg=;
 b=mR6eRHHBxCxwrVW+pow4maCRfVjCpvRU8ELT2tRwZgBNOB2o1EfmzP9qeHmWpyNms2
 XODcqRSXV1ORBGC7z5sF3VVXUwiMqBP5mAg7VMZEkmz57tvrI4impFPG/rJQd3HFL1+4
 W21/9hKHiFA0LChsOpIHjgUTqWZgLvSTyt4xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379380; x=1723984180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0o7O7846zQLb2VYdUj/Zb/T156GJTPxjLen7mr236Qg=;
 b=gRohzJ4kPSZupLYNtw15tnRguEn4qBEfOonzyZJHYYem8yTxBZx1ZN1Ra6XVK6aYc5
 fm7PMbe4ucnZHQJJtt/QPOt+6rp5p4/nHySTNCYpTDpJGZ9Ar9mDIXm1JqHB01EINvrS
 6/r9bioY/bV7NuDihMk64i8lSyJNslOIZHirOszUW+QZOyyRgrkvOUrR/mW5Xjip5pMM
 7In3qy4repMuBktnbT78Td7AeirNaSJ0OSMUgSg9AMF9OVPw8DTGC0Vy7QbM9xmrOcpa
 0dOOEKQPJD+VvTX/2gcDYALlvt27qj+c7Ks30KxNJIdUiQO9/S6lo/JskP8uXlNK7mIQ
 BC/Q==
X-Gm-Message-State: AOJu0YzD5URkTdLLmzaVfDltLsLzSzocNwB/DEXDEjaM90ZAn4+2H7h6
 FVKTmZzrr8See+ndzvm8MDMk5VBaIdUZ5BnP/9eyd/GT3yjs4khcDSqXCtZLSX2bH5xTmYz3fLA
 =
X-Google-Smtp-Source: AGHT+IEbeAry5z1VIhgFyPJz+kSBgdxvtoXOBuUScnPUgoQZiHyRpBgnIRSZFzopJhZh6rOhzDHTxA==
X-Received: by 2002:a05:6602:3d2:b0:804:2b28:75db with SMTP id
 ca18e2360f4ac-8225ed05dd5mr872541239f.10.1723379379653; 
 Sun, 11 Aug 2024 05:29:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 07/15] mmc: Use logging instead of pr_err()
Date: Sun, 11 Aug 2024 06:29:16 -0600
Message-Id: <20240811122924.4035982-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

Use the log subsystem instead of dev, to avoid including function names
in the code.

The CONFIG_LOGF_FUNC option can be used to enable the function name.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v3:
- Fix 'enver' typo while we are here
- Put enhanced size back to decimal
- Drop unnecessary braces around 'Card did not respond' message

 drivers/mmc/mmc.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index cf8277cbed8..9644aa7aa43 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 
 		if (status & MMC_STATUS_MASK) {
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-			pr_err("Status Error: 0x%08x\n", status);
+			log_err("Status Error: %#08x\n", status);
 #endif
 			return -ECOMM;
 		}
@@ -307,7 +307,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 
 	if (timeout_ms <= 0) {
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		pr_err("Timeout waiting card ready\n");
+		log_err("Timeout waiting card ready\n");
 #endif
 		return -ETIMEDOUT;
 	}
@@ -449,7 +449,7 @@ static int mmc_read_blocks(struct mmc *mmc, void *dst, lbaint_t start,
 	if (blkcnt > 1) {
 		if (mmc_send_stop_transmission(mmc, false)) {
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-			pr_err("mmc fail to send stop cmd\n");
+			log_err("mmc fail to send stop cmd\n");
 #endif
 			return 0;
 		}
@@ -500,8 +500,8 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt,
 
 	if ((start + blkcnt) > block_dev->lba) {
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		pr_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
-		       start + blkcnt, block_dev->lba);
+		log_err("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
+			start + blkcnt, block_dev->lba);
 #endif
 		return 0;
 	}
@@ -996,7 +996,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
 		return 0;
 
 	if (!ext_csd) {
-		pr_err("No ext_csd found!\n"); /* this should enver happen */
+		log_err("No ext_csd found!\n"); /* this should never happen */
 		return -ENOTSUPP;
 	}
 
@@ -1108,17 +1108,17 @@ int mmc_hwpart_config(struct mmc *mmc,
 		return -EINVAL;
 
 	if (IS_SD(mmc) || (mmc->version < MMC_VERSION_4_41)) {
-		pr_err("eMMC >= 4.4 required for enhanced user data area\n");
+		log_err("eMMC >= 4.4 required for enhanced user data area\n");
 		return -EMEDIUMTYPE;
 	}
 
 	if (!(mmc->part_support & PART_SUPPORT)) {
-		pr_err("Card does not support partitioning\n");
+		log_err("Card does not support partitioning\n");
 		return -EMEDIUMTYPE;
 	}
 
 	if (!mmc->hc_wp_grp_size) {
-		pr_err("Card does not define HC WP group size\n");
+		log_err("Card does not define HC WP group size\n");
 		return -EMEDIUMTYPE;
 	}
 
@@ -1126,8 +1126,7 @@ int mmc_hwpart_config(struct mmc *mmc,
 	if (conf->user.enh_size) {
 		if (conf->user.enh_size % mmc->hc_wp_grp_size ||
 		    conf->user.enh_start % mmc->hc_wp_grp_size) {
-			pr_err("User data enhanced area not HC WP group "
-			       "size aligned\n");
+			log_err("User data enhanced area not HC WP group size aligned\n");
 			return -EINVAL;
 		}
 		part_attrs |= EXT_CSD_ENH_USR;
@@ -1145,8 +1144,8 @@ int mmc_hwpart_config(struct mmc *mmc,
 
 	for (pidx = 0; pidx < 4; pidx++) {
 		if (conf->gp_part[pidx].size % mmc->hc_wp_grp_size) {
-			pr_err("GP%i partition not HC WP group size "
-			       "aligned\n", pidx+1);
+			log_err("GP%i partition not HC WP group-size aligned\n",
+				pidx + 1);
 			return -EINVAL;
 		}
 		gp_size_mult[pidx] = conf->gp_part[pidx].size / mmc->hc_wp_grp_size;
@@ -1157,7 +1156,7 @@ int mmc_hwpart_config(struct mmc *mmc,
 	}
 
 	if (part_attrs && ! (mmc->part_support & ENHNCD_SUPPORT)) {
-		pr_err("Card does not support enhanced attribute\n");
+		log_err("Card does not support enhanced attribute\n");
 		return -EMEDIUMTYPE;
 	}
 
@@ -1170,8 +1169,8 @@ int mmc_hwpart_config(struct mmc *mmc,
 		(ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT+1] << 8) +
 		ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT];
 	if (tot_enh_size_mult > max_enh_size_mult) {
-		pr_err("Total enhanced size exceeds maximum (%u > %u)\n",
-		       tot_enh_size_mult, max_enh_size_mult);
+		log_err("Total enhanced size exceeds maximum (%#x > %#x)\n",
+			tot_enh_size_mult, max_enh_size_mult);
 		return -EMEDIUMTYPE;
 	}
 
@@ -1204,7 +1203,7 @@ int mmc_hwpart_config(struct mmc *mmc,
 
 	if (ext_csd[EXT_CSD_PARTITION_SETTING] &
 	    EXT_CSD_PARTITION_SETTING_COMPLETED) {
-		pr_err("Card already partitioned\n");
+		log_err("Card already partitioned\n");
 		return -EPERM;
 	}
 
@@ -1875,7 +1874,7 @@ error:
 		}
 	}
 
-	pr_err("unable to select a mode\n");
+	log_err("unable to select a mode\n");
 	return -ENOTSUPP;
 }
 
@@ -2253,7 +2252,7 @@ error:
 		}
 	}
 
-	pr_err("unable to select a mode : %d\n", err);
+	log_err("unable to select a mode: %d\n", err);
 
 	return -ENOTSUPP;
 }
@@ -2921,7 +2920,8 @@ retry:
 		if (err) {
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
 			if (!quiet)
-				pr_err("Card did not respond to voltage select! : %d\n", err);
+				log_err("Card did not respond to voltage select! : %d\n",
+					err);
 #endif
 			return -EOPNOTSUPP;
 		}
@@ -2954,7 +2954,7 @@ int mmc_start_init(struct mmc *mmc)
 						   | MMC_CAP(MMC_LEGACY) |
 						   MMC_MODE_1BIT);
 			} else {
-				pr_err("bus_mode requested is not supported\n");
+				log_err("bus_mode requested is not supported\n");
 				return -EINVAL;
 			}
 		}
@@ -2974,7 +2974,7 @@ int mmc_start_init(struct mmc *mmc)
 	if (no_card) {
 		mmc->has_init = 0;
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		pr_err("MMC: no card present\n");
+		log_err("MMC: no card present\n");
 #endif
 		return -ENOMEDIUM;
 	}
@@ -3103,7 +3103,7 @@ static int mmc_probe(struct bd_info *bis)
 	uclass_foreach_dev(dev, uc) {
 		ret = device_probe(dev);
 		if (ret)
-			pr_err("%s - probe failed: %d\n", dev->name, ret);
+			log_err("%s - probe failed: %d\n", dev->name, ret);
 	}
 
 	return 0;
-- 
2.34.1

