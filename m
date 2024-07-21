Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7760C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 15:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C3987FC7;
	Sun, 21 Jul 2024 17:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ngPToeKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5475187B8D; Sun, 21 Jul 2024 17:26:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB9787F82
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 17:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4267345e746so25960385e9.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721575601; x=1722180401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/NpOf0+TIzFT2Yz2W+FwaGdj1se7QQ5akgDIiRUBdY=;
 b=ngPToeKg/JQGySHytmV7MABirbedrzOgpSSXpqkhJws9vlhor5ub34kTSO7YEGW77e
 VPuAuAZJIyG4eUf/KfhnSgm3UovaBtYRlfjn625tLocUY5xHY2wcKxDzvKiliGpBv6lA
 J05SOeTx+VlIk//tCPCq6GKWqzbTsOray9Zbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721575601; x=1722180401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/NpOf0+TIzFT2Yz2W+FwaGdj1se7QQ5akgDIiRUBdY=;
 b=LEVVOO0WkVnmfQ+eUlWMrJhHIKdN9UwS9anmH0WYazn4tfZzRKskOPGecNDWa0mQlK
 bcLGfZGF11rYcTDpesqtd+j87k6NWBm2vizfi538tUGTsD0XuPL8UV8M0cqXSGAIiuR3
 9Dx+meYarGDTuFR/ZYdpdR+8V1HaU1ttk6oUtad/KVQ3jBlpoZ6LNe9LJYa78HhtQPty
 7YVnDTy73MLDY/riqH9FdOWVHroFup9mNjkBbNcEsCfLckBLAaY9Wj0OLbEjf5Yle2B+
 moNaj6164I1o8+bFELXduW3sYLXWT1l7QHO365TlyGF+1YXWhXXOHQ65Bdz+yaEXqFKY
 TqeA==
X-Gm-Message-State: AOJu0YxvmE2ddPoeFX5bKyjPJF9S4kKQcW1YBQARCupPr2kxNKyHzj9Y
 Og1wGaMg7pmM4VZ0g5qFhvFCdTbNGdnV05I0R7gXj8Xs7LwnN20VHh7pMgpPhZ+zHEnTsY6Q5Qw
 =
X-Google-Smtp-Source: AGHT+IFXH2ibGtCh32NyPdmzfGTAqkSd4LT0s45DykVb4Act6ElMvtTCSIBV/tqpoy4NrjzOFTeIAw==
X-Received: by 2002:a05:600c:4ec7:b0:426:6f15:2e4d with SMTP id
 5b1f17b1804b1-427dc51cecbmr28371425e9.9.1721575601571; 
 Sun, 21 Jul 2024 08:26:41 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427e5803bb0sm8702255e9.45.2024.07.21.08.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 08:26:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
Date: Sun, 21 Jul 2024 16:25:51 +0100
Message-Id: <20240721152600.3212917-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721152600.3212917-1-sjg@chromium.org>
References: <20240721152600.3212917-1-sjg@chromium.org>
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

(no changes since v1)

 drivers/mmc/mmc.c | 49 ++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index b18dc331f78..b0105afe5d6 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
 
 		if (status & MMC_STATUS_MASK) {
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-			pr_err("Status Error: 0x%08x\n", status);
+			log_err("Status Error: %08x\n", status);
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
+		log_err("MMC: block number " LBAF " exceeds max(" LBAF ")\n",
+			start + blkcnt, block_dev->lba);
 #endif
 		return 0;
 	}
@@ -997,7 +997,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
 		return 0;
 
 	if (!ext_csd) {
-		pr_err("No ext_csd found!\n"); /* this should enver happen */
+		log_err("No ext_csd found!\n"); /* this should enver happen */
 		return -ENOTSUPP;
 	}
 
@@ -1109,17 +1109,17 @@ int mmc_hwpart_config(struct mmc *mmc,
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
 
@@ -1127,8 +1127,7 @@ int mmc_hwpart_config(struct mmc *mmc,
 	if (conf->user.enh_size) {
 		if (conf->user.enh_size % mmc->hc_wp_grp_size ||
 		    conf->user.enh_start % mmc->hc_wp_grp_size) {
-			pr_err("User data enhanced area not HC WP group "
-			       "size aligned\n");
+			log_err("User data enhanced area not HC WP group size aligned\n");
 			return -EINVAL;
 		}
 		part_attrs |= EXT_CSD_ENH_USR;
@@ -1146,8 +1145,8 @@ int mmc_hwpart_config(struct mmc *mmc,
 
 	for (pidx = 0; pidx < 4; pidx++) {
 		if (conf->gp_part[pidx].size % mmc->hc_wp_grp_size) {
-			pr_err("GP%i partition not HC WP group size "
-			       "aligned\n", pidx+1);
+			log_err("GP%i partition not HC WP group-size aligned\n",
+				pidx + 1);
 			return -EINVAL;
 		}
 		gp_size_mult[pidx] = conf->gp_part[pidx].size / mmc->hc_wp_grp_size;
@@ -1158,7 +1157,7 @@ int mmc_hwpart_config(struct mmc *mmc,
 	}
 
 	if (part_attrs && ! (mmc->part_support & ENHNCD_SUPPORT)) {
-		pr_err("Card does not support enhanced attribute\n");
+		log_err("Card does not support enhanced attribute\n");
 		return -EMEDIUMTYPE;
 	}
 
@@ -1171,8 +1170,8 @@ int mmc_hwpart_config(struct mmc *mmc,
 		(ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT+1] << 8) +
 		ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT];
 	if (tot_enh_size_mult > max_enh_size_mult) {
-		pr_err("Total enhanced size exceeds maximum (%u > %u)\n",
-		       tot_enh_size_mult, max_enh_size_mult);
+		log_err("Total enhanced size exceeds maximum (%x > %x)\n",
+			tot_enh_size_mult, max_enh_size_mult);
 		return -EMEDIUMTYPE;
 	}
 
@@ -1205,7 +1204,7 @@ int mmc_hwpart_config(struct mmc *mmc,
 
 	if (ext_csd[EXT_CSD_PARTITION_SETTING] &
 	    EXT_CSD_PARTITION_SETTING_COMPLETED) {
-		pr_err("Card already partitioned\n");
+		log_err("Card already partitioned\n");
 		return -EPERM;
 	}
 
@@ -1876,7 +1875,7 @@ error:
 		}
 	}
 
-	pr_err("unable to select a mode\n");
+	log_err("unable to select a mode\n");
 	return -ENOTSUPP;
 }
 
@@ -2254,7 +2253,7 @@ error:
 		}
 	}
 
-	pr_err("unable to select a mode : %d\n", err);
+	log_err("unable to select a mode: %d\n", err);
 
 	return -ENOTSUPP;
 }
@@ -2921,8 +2920,10 @@ retry:
 
 		if (err) {
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-			if (!quiet)
-				pr_err("Card did not respond to voltage select! : %d\n", err);
+			if (!quiet) {
+				log_err("Card did not respond to voltage select! : %d\n",
+					err);
+			}
 #endif
 			return -EOPNOTSUPP;
 		}
@@ -2955,7 +2956,7 @@ int mmc_start_init(struct mmc *mmc)
 						   | MMC_CAP(MMC_LEGACY) |
 						   MMC_MODE_1BIT);
 			} else {
-				pr_err("bus_mode requested is not supported\n");
+				log_err("bus_mode requested is not supported\n");
 				return -EINVAL;
 			}
 		}
@@ -2975,7 +2976,7 @@ int mmc_start_init(struct mmc *mmc)
 	if (no_card) {
 		mmc->has_init = 0;
 #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		pr_err("MMC: no card present\n");
+		log_err("MMC: no card present\n");
 #endif
 		return -ENOMEDIUM;
 	}
@@ -3104,7 +3105,7 @@ static int mmc_probe(struct bd_info *bis)
 	uclass_foreach_dev(dev, uc) {
 		ret = device_probe(dev);
 		if (ret)
-			pr_err("%s - probe failed: %d\n", dev->name, ret);
+			log_err("%s - probe failed: %d\n", dev->name, ret);
 	}
 
 	return 0;
-- 
2.34.1

