Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED2EEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F4A864C1;
	Tue, 22 Aug 2023 13:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ABjJ+2Rp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 278CF864DD; Tue, 22 Aug 2023 13:22:56 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B15C864C7
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so560029466b.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703372; x=1693308172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUzmiGsM+CBVI2t21fk1UNwMwq+HMhJ7S0OUYqJCFtI=;
 b=ABjJ+2RpXg2dT0iDCSGbxu2rdFpAL5uJzaayJES657JgmwJE6S/bN8vI+oD/bJzZfH
 hCQXqYJMeq5jP9zmYjM9bq/a4dpl7PuTz6v9bh0JT1ZrvGKemdvMmuiM+TP4ChfOxiYo
 Nqdby9kdQYalAY/4I138EjTP1wSFNlMMIKHP5GwPXv06LywxQI9jjxJz07Pieatrkq6i
 X9zPbKjuUPdIxgTIsUGGOsk0Fpk31je+H1Mbnk8d1hWnITCEw/E7GGO2rnxR6bNs12Bm
 Md4pO6KpDLAIl9PEj2xsI5GqZDHpJttFogcBXJBjS22d7IIy/lfZvQE9z0Tcr+z9SgBR
 IGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703372; x=1693308172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUzmiGsM+CBVI2t21fk1UNwMwq+HMhJ7S0OUYqJCFtI=;
 b=J4u8PzVgE9JJurcUn0r7I6oDf+F4ixtSZOmlaWaZHg9b4uedhIldPY4mo4yPDLWCZZ
 YSQaMP3tFhvidb5bA0YQT37j6E5jmCzroW6dLgJeyVOEQSPnWAud2x2s1soane0zgitO
 umk/bza51iZW0HzWp22SEuijaEJH4/ebMeAEOCl8PEmBikRaKH7kB4z9LXCnJeZ2znyS
 IzR8JZDra4mlz7Im4SK95fb4UzoEt9M9Mc+BvEs8bBH17BAUT1yrgW+ClcRZmB/0Egn4
 K8nXP8m5l251RJGjcNxgD/HeWH5fcpI/RoXZ4Um5rEZyuQ4kTRohx/g2Q4YK0pAjCYgh
 1QmA==
X-Gm-Message-State: AOJu0Yxf7XjZEY+JLiTmm11g1DdxL/JOp6JoVZ3HGTUapjjw3IbhLYsh
 bnHiNH7GNJZ9Dwjxri8MGGV7PvuAFXzHUQ==
X-Google-Smtp-Source: AGHT+IHN9IZmdLIXDE5nVvUg7PJ3Ck3m3+c5QnePyYTHp63qQzl5uYQGl3yzyH55wkqpkkpXe6F4XA==
X-Received: by 2002:a17:907:7757:b0:9a1:aede:edfb with SMTP id
 kx23-20020a170907775700b009a1aedeedfbmr1762747ejc.12.1692703371895; 
 Tue, 22 Aug 2023 04:22:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 14/19] ARM: tegra20: tegra30: support EBTUPDATE on
 non-encrypted devices
Date: Tue, 22 Aug 2023 14:22:12 +0300
Message-Id: <20230822112217.4646-15-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

