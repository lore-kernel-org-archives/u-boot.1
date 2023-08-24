Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BB3C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D34E869B1;
	Thu, 24 Aug 2023 21:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cUgMkt0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3830E869E1; Thu, 24 Aug 2023 21:27:04 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E24586504
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5009969be25so229646e87.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905221; x=1693510021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUzmiGsM+CBVI2t21fk1UNwMwq+HMhJ7S0OUYqJCFtI=;
 b=cUgMkt0cA/1Y5M2uWB6iiWnGrTCKrAcIrN5vsiRuOmKdtloo0pfOgFg6UUmdpuV37/
 KgKI8m3w350tuyB9Gz1tXpXp7vitfP7ijzfJrQPRowqvUmTZ7tIuB00ZTaitOrK6CE6H
 KJYAzU0f6SyB0LDmkscnVe5ThQMcHSHNFvroKDWXOfrmIkNG7FzBuwfWcluKQA9T0gxs
 ydfw4kIcI+1V58wxmDSMbmHGi2M8R6c+yru3FJn6ULdLKL8lKFV2uIUFA17LbEACA1nV
 FyddWs5oQXMj0NT3ndMtjCLkofGlOGGwYbi5FeF8gO8zYPyd2TjCCBwkY2Me/phvn5RQ
 4hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905221; x=1693510021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUzmiGsM+CBVI2t21fk1UNwMwq+HMhJ7S0OUYqJCFtI=;
 b=j72w9OEEAWjWIN/OoHJyL2EJqUAoHStvqp8V3uWbcNiSIw3w+YMJvHG7ZXXnD+H7kB
 H9ZRSSmHChUkcMzHkPQjWffVCBhh1vin5dqooFE8SsaxfZmPBEkO6rvxZ0U+c8NEqKIC
 /o5+ypXmV4QpjiP/W7LZmOOdHf17SUg60lcK3qEXF78YielvTz+giCKogl2s9QNSvNps
 uQwqLRz588q++EvuQnXnsMmFmZDKneZq5UyCZ2L4HcRwRE5WRKd6DAPF7m2dkpHGl4EN
 aT7iglxVDsfeQsCqjm2zMm0U/YkqRY9OtelkJF9ZETlhwiQqsBSOhQeXdjB74IhHRGDn
 jSag==
X-Gm-Message-State: AOJu0YyvnAuqt4DnJUEEqOebw2gMxodpFpDw4Bn3CcWbZJbjvJ8zqzy0
 RI2wWldLNkePlsIVfqmRntE=
X-Google-Smtp-Source: AGHT+IHodbKHuk5uiZBqUhXIVeOvSQSM6XOoylw3hqiB2MQBTLm+GsBv/XAMBsX6hhnyiNXWv1ZdJQ==
X-Received: by 2002:a05:6512:3e1a:b0:4f8:661f:60a4 with SMTP id
 i26-20020a0565123e1a00b004f8661f60a4mr14522274lfv.41.1692905220781; 
 Thu, 24 Aug 2023 12:27:00 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:27:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 13/16] ARM: tegra20: tegra30: support EBTUPDATE on
 non-encrypted devices
Date: Thu, 24 Aug 2023 22:26:00 +0300
Message-Id: <20230824192603.240104-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Re-crypt support was extended to devices without burnt SBK. In case
SBK is not set, place from where it is read is filled with zeroes.
This patch adds support for ebtupdate function to detect nosbk device
and avoid crypto operations for it.

Tested-by: Maksim Kurnosenko <asusx2@mail.ru>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/mach-tegra/tegra20/bct.c | 30 ++++++++++++++++++++----------
 arch/arm/mach-tegra/tegra30/bct.c | 30 ++++++++++++++++++++----------
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra20/bct.c b/arch/arm/mach-tegra/tegra20/bct.c
index 5eb48990b6..b2c44f3d23 100644
--- a/arch/arm/mach-tegra/tegra20/bct.c
+++ b/arch/arm/mach-tegra/tegra20/bct.c
@@ -11,6 +11,9 @@
 #include "bct.h"
 #include "uboot_aes.h"
 
+/* Device with "sbk burned: false" will expose zero key */
+const u8 nosbk[AES128_KEY_LENGTH] = { 0 };
+
 /*
  * @param  bct		boot config table start in RAM
  * @param  ect		bootloader start in RAM
@@ -23,22 +26,27 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	u8 ebt_hash[AES128_KEY_LENGTH] = { 0 };
 	u8 sbk[AES128_KEY_LENGTH] = { 0 };
 	u8 *bct_hash = bct;
+	bool encrypted;
 	int ret;
 
 	bct += BCT_HASH;
 
+	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
+
 	memcpy(sbk, (u8 *)(bct + BCT_LENGTH),
 	       NVBOOT_CMAC_AES_HASH_LENGTH * 4);
 
-	ret = decrypt_data_block(bct, BCT_LENGTH, sbk);
-	if (ret)
-		return 1;
+	encrypted = memcmp(&sbk, &nosbk, AES128_KEY_LENGTH);
 
-	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
+	if (encrypted) {
+		ret = decrypt_data_block(bct, BCT_LENGTH, sbk);
+		if (ret)
+			return 1;
 
-	ret = encrypt_data_block(ebt, ebt_size, sbk);
-	if (ret)
-		return 1;
+		ret = encrypt_data_block(ebt, ebt_size, sbk);
+		if (ret)
+			return 1;
+	}
 
 	ret = sign_enc_data_block(ebt, ebt_size, ebt_hash, sbk);
 	if (ret)
@@ -52,9 +60,11 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	bct_tbl->bootloader[0].load_addr = CONFIG_SPL_TEXT_BASE;
 	bct_tbl->bootloader[0].length = ebt_size;
 
-	ret = encrypt_data_block(bct, BCT_LENGTH, sbk);
-	if (ret)
-		return 1;
+	if (encrypted) {
+		ret = encrypt_data_block(bct, BCT_LENGTH, sbk);
+		if (ret)
+			return 1;
+	}
 
 	ret = sign_enc_data_block(bct, BCT_LENGTH, bct_hash, sbk);
 	if (ret)
diff --git a/arch/arm/mach-tegra/tegra30/bct.c b/arch/arm/mach-tegra/tegra30/bct.c
index c56958da69..cff1a3e98d 100644
--- a/arch/arm/mach-tegra/tegra30/bct.c
+++ b/arch/arm/mach-tegra/tegra30/bct.c
@@ -11,6 +11,9 @@
 #include "bct.h"
 #include "uboot_aes.h"
 
+/* Device with "sbk burned: false" will expose zero key */
+const u8 nosbk[AES128_KEY_LENGTH] = { 0 };
+
 /*
  * @param  bct		boot config table start in RAM
  * @param  ect		bootloader start in RAM
@@ -23,22 +26,27 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	u8 ebt_hash[AES128_KEY_LENGTH] = { 0 };
 	u8 sbk[AES128_KEY_LENGTH] = { 0 };
 	u8 *bct_hash = bct;
+	bool encrypted;
 	int ret;
 
 	bct += BCT_HASH;
 
+	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
+
 	memcpy(sbk, (u8 *)(bct + BCT_LENGTH),
 	       NVBOOT_CMAC_AES_HASH_LENGTH * 4);
 
-	ret = decrypt_data_block(bct, BCT_LENGTH, sbk);
-	if (ret)
-		return 1;
+	encrypted = memcmp(&sbk, &nosbk, AES128_KEY_LENGTH);
 
-	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
+	if (encrypted) {
+		ret = decrypt_data_block(bct, BCT_LENGTH, sbk);
+		if (ret)
+			return 1;
 
-	ret = encrypt_data_block(ebt, ebt_size, sbk);
-	if (ret)
-		return 1;
+		ret = encrypt_data_block(ebt, ebt_size, sbk);
+		if (ret)
+			return 1;
+	}
 
 	ret = sign_enc_data_block(ebt, ebt_size, ebt_hash, sbk);
 	if (ret)
@@ -52,9 +60,11 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	bct_tbl->bootloader[0].load_addr = CONFIG_SPL_TEXT_BASE;
 	bct_tbl->bootloader[0].length = ebt_size;
 
-	ret = encrypt_data_block(bct, BCT_LENGTH, sbk);
-	if (ret)
-		return 1;
+	if (encrypted) {
+		ret = encrypt_data_block(bct, BCT_LENGTH, sbk);
+		if (ret)
+			return 1;
+	}
 
 	ret = sign_enc_data_block(bct, BCT_LENGTH, bct_hash, sbk);
 	if (ret)
-- 
2.39.2

