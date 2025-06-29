Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D84DC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 11:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1711D82F03;
	Sun, 29 Jun 2025 13:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HURShJjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5739D82ED0; Sun, 29 Jun 2025 13:02:27 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E7F82E67
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55502821bd2so1264366e87.2
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194939; x=1751799739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRzC5vNu9ADEpAWaTTnUIUKDLCKUmiYg2T/eD2aWgb0=;
 b=HURShJjUp2Vc//YCe7Hoe+alKl70ustbpKE8PWybntUHJDsMwnd02XS9Te+w0IoUMV
 fbYnvKHNGSTBCAq2uT5gIYdzNazZjG9nkWTQSYZAT1LB02WwtLrHPweTz5WKHP8XlXwL
 +s37y3LVqbfZUYmy9j6bNNb0XpgZnTZW0QvpXv58x4BnkDzOB4De0AIS0/XhNNgONDCb
 ZOSIduB0+w8NDQtfeqhncpPYQPhfaeLtQ28i7NMUsl/KSN/ocuWvAN1vdC/B5vgWOgxN
 tUrk/wG1O/6q9zLJhUmiTTFU/E4cNampA785TU5RyxMbB6iTRitLVsv8a3gYOxmpmynO
 FzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194939; x=1751799739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRzC5vNu9ADEpAWaTTnUIUKDLCKUmiYg2T/eD2aWgb0=;
 b=qlo0o0Zu3PluT+EQzKnVVCubuEQLi5g0kxaoRciEb6FZXl44vLfKAbtY+A6nJepsiF
 /V5sLZ/ErsHC1bB+3UX7p+ctuUHsIMuRrFmJuXYwM5wVSsTudw99M3ljkXN6y/6v/t/G
 gtJGE4LU6Mv81m8CqMZFXU9RYjLWISmqBpLg3DNmaatCCA4GxiMojSJ3QB0HkxLwg7KD
 vVooovznXgny1HtW+lXN9FDs53IL2aNK/WLu4tKz8Whw+0FuWXzT2aHlDOXsTnjXl2/P
 VYCMvT05Na3dlb0xrKVCweJ7nz5pSn6/4WDtHDEtCMGVIfv418vYpu8MxwjHfOCrJc7z
 skvA==
X-Gm-Message-State: AOJu0Yy6uUTi512H3MjXjNy5AtzDwD8w6QQRwMrgEaRd8MUK79KbA9G1
 J+IKtIF/pCErY2loRbCb2tHIU3unFHHfaQjMw1zukbBgqv1yxNgaIFiR
X-Gm-Gg: ASbGncusOs18EIHtkwQy8H+GbQeV10DSlRNzH4iffSZu2zLsyrptfJw40d9NEL//3j1
 rFF93E3RngLo+oEyfvQfsjn+5PN+q0yfgzWlndKr8c41gCoiRFglZdGR+vtfTxrbn4xAwOro58+
 6GsjaYK3mEh1o3JwHFDdb0WIEv1odA/Aac1/xoDGgC2+4OQxe2UdCcMUL/U7bsKt98Rbx6GsdNa
 V8qFWxP0Vq58Ltp2bys1veK+BOKmr4sW3nOHfe+3JpWiE5Tfx1IaaQyKKI7iHHBbGIv6QjsigIo
 d7x6iKiwN08tei/sNJCsMu11HdbJcYaYpQVcf1VyOXwSPdFIROPb+A==
X-Google-Smtp-Source: AGHT+IG+c4z1a0gMMzLqgyv07BpArM2ECfoXzgeXT1NlAqGOpQeDmSbi0oQfeEOmpIOmNWUIICso7w==
X-Received: by 2002:a05:6512:2388:b0:553:3383:6766 with SMTP id
 2adb3069b0e04-5550b829399mr2730062e87.19.1751194938303; 
 Sun, 29 Jun 2025 04:02:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24028esm1090621e87.19.2025.06.29.04.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 04:02:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/6] ARM: tegra: Add LP0 support for ODM production
Date: Sun, 29 Jun 2025 14:02:00 +0300
Message-ID: <20250629110203.25086-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629110203.25086-1-clamor95@gmail.com>
References: <20250629110203.25086-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Now that we have working AES engine driver we can request the warmboot code
to be encrypted and signed  with SBK if the device requires so. This
unlocks LP0 support for most devices in the wild as they use ODM Production
Secure.

We are not aware of any "ODM Production Open" device nor have access to
thus this has not been tested on one, merely added for completeness.

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 arch/arm/include/asm/arch-tegra/warmboot.h |  1 -
 arch/arm/mach-tegra/tegra20/warmboot.c     | 42 +++++++++++++---------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/warmboot.h b/arch/arm/include/asm/arch-tegra/warmboot.h
index 402f93aac48..4352f1dc5e8 100644
--- a/arch/arm/include/asm/arch-tegra/warmboot.h
+++ b/arch/arm/include/asm/arch-tegra/warmboot.h
@@ -119,7 +119,6 @@ union scratch3_reg {
 int warmboot_save_sdram_params(void);
 
 int warmboot_prepare_code(u32 seg_address, u32 seg_length);
-int sign_data_block(u8 *source, u32 length, u8 *signature);
 void wb_start(void);	/* Start of WB assembly code */
 void wb_end(void);	/* End of WB assembly code */
 
diff --git a/arch/arm/mach-tegra/tegra20/warmboot.c b/arch/arm/mach-tegra/tegra20/warmboot.c
index 059388f7231..3fd39fe3c1a 100644
--- a/arch/arm/mach-tegra/tegra20/warmboot.c
+++ b/arch/arm/mach-tegra/tegra20/warmboot.c
@@ -19,6 +19,7 @@
 #include <asm/arch-tegra/pmc.h>
 #include <asm/arch-tegra/fuse.h>
 #include <asm/arch-tegra/warmboot.h>
+#include <asm/arch-tegra/crypto.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -182,25 +183,36 @@ int warmboot_save_sdram_params(void)
 	return 0;
 }
 
-static void determine_crypto_options(int *is_encrypted, int *is_signed,
-				     int *use_zero_key)
+static void determine_crypto_options(int *is_encrypted, int *is_signed)
 {
 	switch (tegra_fuse_get_operation_mode()) {
+	case MODE_ODM_PRODUCTION_SECURE:
+		*is_encrypted = 1;
+		*is_signed = 1;
+		break;
+	case MODE_ODM_PRODUCTION_OPEN:
 	case MODE_PRODUCTION:
 		*is_encrypted = 0;
 		*is_signed = 1;
-		*use_zero_key = 1;
 		break;
 	case MODE_UNDEFINED:
 	default:
 		*is_encrypted = 0;
 		*is_signed = 0;
-		*use_zero_key  = 0;
 		break;
 	}
 }
 
-static int sign_wb_code(u32 start, u32 length, int use_zero_key)
+static int encrypt_wb_code(u8 *source, u8 *destination, u32 length)
+{
+	source += offsetof(struct wb_header, random_aes_block);
+	destination += offsetof(struct wb_header, random_aes_block);
+	length -= offsetof(struct wb_header, random_aes_block);
+
+	return encrypt_data_block(source, destination, length);
+}
+
+static int sign_wb_code(u32 start, u32 length)
 {
 	int err;
 	u8 *source;		/* Pointer to source */
@@ -222,10 +234,9 @@ int warmboot_prepare_code(u32 seg_address, u32 seg_length)
 	struct wb_header *dst_header;	/* Pointer to dest WB header */
 	int is_encrypted;		/* Segment is encrypted */
 	int is_signed;			/* Segment is signed */
-	int use_zero_key;		/* Use key of all zeros */
 
 	/* Determine crypto options. */
-	determine_crypto_options(&is_encrypted, &is_signed, &use_zero_key);
+	determine_crypto_options(&is_encrypted, &is_signed);
 
 	/* Get the actual code limits. */
 	length = roundup(((u32)wb_end - (u32)wb_start), 16);
@@ -273,18 +284,15 @@ int warmboot_prepare_code(u32 seg_address, u32 seg_length)
 	dst_header->entry_point = NV_WB_RUN_ADDRESS;
 	dst_header->code_length = length;
 
-	if (is_encrypted) {
-		printf("!!!! Encryption is not supported !!!!\n");
-		dst_header->length_insecure = 0;
-		err = -EACCES;
-		goto fail;
-	} else
-		/* copy the wb code directly following dst_header. */
-		memcpy((char *)(dst_header+1), (char *)wb_start, length);
+	if (is_encrypted)
+		encrypt_wb_code((u8 *)wb_start, (u8 *)dst_header,
+				length + sizeof(struct wb_header));
+	else
+		/* copy the wb code directly following dst_header */
+		memcpy((char *)(dst_header + 1), (char *)wb_start, length);
 
 	if (is_signed)
-		err = sign_wb_code(seg_address, dst_header->length_insecure,
-				   use_zero_key);
+		err = sign_wb_code(seg_address, dst_header->length_insecure);
 
 fail:
 	if (err)
-- 
2.48.1

