Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F017C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A4888C59;
	Sat, 20 Jul 2024 08:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M0YiWrtz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A690D88C37; Sat, 20 Jul 2024 08:20:50 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43D988C2F
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso17734705e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456448; x=1722061248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTdiNsFyyC/gPjxgmuax5C/HSjSdMjhxrVicEiN1Bas=;
 b=M0YiWrtz+n6ieQFpu8W3ghZ+kymMNqHhU2Q76RtvjOnryZFh502WN9pJjim8UlCQpU
 pqFCQQgostudFeKkU2AV+9dd0i5FGF15Y5HkafhpCRiDeDqjhWyC9cKocCHrtPnhZS9n
 oWmFIU/9wZk03H8b8hLZakqdhsxzaAdupHrL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456448; x=1722061248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTdiNsFyyC/gPjxgmuax5C/HSjSdMjhxrVicEiN1Bas=;
 b=okDue0Eo9qo0Mw8M3mtAGWzvHQnJ862/WSo8fOHG3kX9UcJLj7FwZY7UpQf92rpK4S
 DapJDJ7XsiLg5lWdIn11K/OGd1GDUzll7MnWLq13X3Y9D9Me20qBUf3LYqENNuZUthYL
 /wiOel4xLySEVgBPIvcLE3tejBeXMSRDS/vuiUwhSK2gNTh58nOAJ5ZpOd61BLiyQ9Gx
 h7urBPK3RUJ2TDGYl1+HbMl91A/JshKxPenfZ2jfaADiJFlDfVSxNWol9Jpqltbfgldm
 NY+g8lSCDImkn2x9P7NbLd78IjG0L42SHqX2X1lf/7wv7DYBr5/Xn06blHKrkR1/THhV
 LZCg==
X-Gm-Message-State: AOJu0Yz8+MDll2by5DftNcfzl9CFjFz7JoG9brbSKj2RmR01i22umVQV
 Eg313QvPNqo07E5fVXL+CJayITKrDEj7FHrzjBf79RUUbY8ziJ+u4vT24AfbAM8ntC4zIfqWa18
 =
X-Google-Smtp-Source: AGHT+IEOaNSQD7eqNSuF8sRxWlzQ+RKUyulDfonm6m1nLwWcbi/R5QSskla0yPiIbZ5AeCnh/v78zg==
X-Received: by 2002:adf:cc82:0:b0:368:3717:10c7 with SMTP id
 ffacd0b85a97d-369bae3c676mr354293f8f.4.1721456447877; 
 Fri, 19 Jul 2024 23:20:47 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/14] mmc: Use logging instead of pr_err()
Date: Sat, 20 Jul 2024 07:16:58 +0100
Message-Id: <20240720061706.2644229-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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
---

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

