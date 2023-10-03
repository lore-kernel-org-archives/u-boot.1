Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7296BE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F274A87280;
	Tue,  3 Oct 2023 08:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ndf5M2SD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035EC87468; Tue,  3 Oct 2023 08:37:11 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B08987272
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5041d6d8b10so642456e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315025; x=1696919825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUzmiGsM+CBVI2t21fk1UNwMwq+HMhJ7S0OUYqJCFtI=;
 b=ndf5M2SDB4UifOoC6X7qSkHXPpYbeS0acjOIjSOwoj1xwU4DHKBtzrHhG+ML75wL1w
 zpAuUPMV3qUlInDt42zTWFtKeRtYFLo0FRn2IzssfuCaZVa3Oki2ALVfw05gl6AAOUey
 /nzH/GzudXQS1Dz0boG4V+PUxPLvOxcZr8zEYAWfPz1h/Hw3iCU2eL2tL7kKrZVt2AII
 YMWV27L72ceVQxBoB5NZg6XgTFkQB1pt68DiKBbsMtQDg5Y6Ye6qy9gEpcentocA08FP
 8TxFIoCGx9KDwv6UqbAIDaVjrjGmMJM7HTox7w/3IZC9xBJf0EJRjxZJafC6eVV+lWuY
 qmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315025; x=1696919825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUzmiGsM+CBVI2t21fk1UNwMwq+HMhJ7S0OUYqJCFtI=;
 b=W9UkNfVSArfnMUqMfd1qcWHRdbHIS110NP7+lVqJ/6Cb0v/4/8Q/S/9FUjBc8g24v9
 JxEu9uZLAcuYfv6O7yJUlp/ivQ6spa+GPo2IK2slTNdD6Cnax/xNNSv66AO0fC2Az3zN
 AledFEDSqgZ31pfk93jMlyINrAI4IL41wTbiNxy/nAMnyDjxUDXhWqPBNVR7xrfK4iy9
 m2nQX4t/ucaeZsXW8RMZTbYCL4us0zPh+ip11JaVwL3Yyy3MotVOwuIl6QHhj0MxWRuX
 CvyB3sua01h/OnumJW2JBsnEZD3P+tLY6a9dg/hy5kXTt57cTWMzkyj0GG6QTH0WteRq
 /f8A==
X-Gm-Message-State: AOJu0YxheSq3nyOisL2RYvxqMUZ5vA1fgw9WshPJhGdWEi+MVmxMOTDZ
 gMBkirZ2ZXQXfgbrbGHaBfs=
X-Google-Smtp-Source: AGHT+IHWtRYIZWOcnaQKlQm9dZt3UXTyEcQoNC5VtxTm9hNWlivzBXFKKcdP1d0U9O0XmkVSmTtorA==
X-Received: by 2002:a05:6512:224b:b0:504:7dc9:671a with SMTP id
 i11-20020a056512224b00b005047dc9671amr12869707lfu.69.1696315025428; 
 Mon, 02 Oct 2023 23:37:05 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:05 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 13/16] ARM: tegra20: tegra30: support EBTUPDATE on
 non-encrypted devices
Date: Tue,  3 Oct 2023 09:36:44 +0300
Message-Id: <20231003063647.42770-14-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

