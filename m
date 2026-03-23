Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4391BF483D7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2F48412F;
	Mon, 23 Mar 2026 20:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="io0Wgpa0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82BF83FDC; Mon, 23 Mar 2026 20:51:11 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82AA483FDC
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so2420359a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295468; x=1774900268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U2aCKWTu4n2Tr6UorswGFqFJ8JizG+1TrZswO9Lg2o4=;
 b=io0Wgpa0quqbW3MntAFdMK3XckerUqVlENefxWMbcnpiumxF2OKk6e6XALMghZLGce
 mBpKMGlT7M4XAQFu/+6SZfw7VfWl6JgHK5as8/v4GHe3rdxFAa+KU9xjABL5hz+oQB3I
 C1ZOz5LDhftwrT3ZloSNr+hlt5+iTL5TEcd+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295468; x=1774900268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U2aCKWTu4n2Tr6UorswGFqFJ8JizG+1TrZswO9Lg2o4=;
 b=WQ24h64e2VAhPaWeCxDcEwdwS32CwXnWdV7dmr1XCPYW1jYNHM5cWNSeDkl3P55917
 U22VtrmbdU+tbt4DWovxldi6Mdt2F0akPZOKdFt11QFSqNGrEo/B+mkn4UtCcmiljaJJ
 KuuAQtc6Dg0sPcU7ppV+XvZK4nMz6PVhFb9fk/XEUTySZPqN2Zvg4dMdJarzV3iN/mVt
 /PZvcMgH2eXDUYu7XYPNtgbjjitLXmK45WULCMJc3SmudM4U9ZFJqO/pNzpol6Am5BV2
 JzlRgejbz36CWzA1JdKRDRbV97caEZyPuA820FjJm8NDAUYZH+c1qHmOEKSCHUzNb3z7
 7z+w==
X-Gm-Message-State: AOJu0YyesDHFvYBQEmd67dq6mhDj4oL5z7wFjkwnPqiyl4lkJb0RSnRm
 r4yORf9pYiu8t9O+EpDrR90O+LgybWqwSOOwACpS/kK9tG/RJV6kaoa3HsIP13juzvdVKo5afDl
 Gyu7Y2uM=
X-Gm-Gg: ATEYQzwTqsuKWkef5+Pka5/3zt5Ingdrq77j4WphE5WhGrZO5psaYPNRjQKtlWYSo6H
 FKcbepfomcSPDPWHXHele4HjLxe6qmL3hdS2DpiyaT17+YmJ4PJ7e/O1aOpjAkY+4AjzFbl0TQ1
 TJtJBxEEhicAL9SbEPO96W4vNneiWImCuOthfI4qYSMdsDcsO2PXWWj8k2L2fmyIwq8sanMvpGe
 1yNPMi7YrH5qGCsRi1Viopn6Ntd/6OlGiX8BgAoEbkLf8MIFdIu9cXQkmA8XbZKA0102QbA4/sa
 eXHtVaDUHgeWrI0rzlUFVAq3lWrVVpHV8Jkgt68BBR85YX7vbKYZ3BJf2OTA1Q9FYeWCUNh6tSW
 1KuwqXuO3d4d0KKbRINBLnjwMjq7DxgU53d8OfISTnCF74WyH6iq/+HE+z80qvZbKcNQTNcf+s4
 tyKbuK1tLfY3fHdKKOuQ85YPqrQooQhmLmZ4ibJxGVi8uN/3M6gxg+jTpRA81ZfwazRegHlgMD5
 /NoZOAiVMZ8VEyAPQuh1lTlEuHyCSE1Utw4fSghQrdY+BUuRuk5rDOeme0rpg==
X-Received: by 2002:a05:6830:44a6:b0:7d7:cce6:504d with SMTP id
 46e09a7af769-7d7eae87f56mr9897442a34.11.1774295468151; 
 Mon, 23 Mar 2026 12:51:08 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadcb757sm10388721a34.15.2026.03.23.12.51.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:51:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] env: Make more use of the ENV_SAVE_PTR macro
Date: Mon, 23 Mar 2026 13:51:05 -0600
Message-ID: <20260323195106.2362981-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320205335.3788760-1-trini@konsulko.com>
References: <20260320205335.3788760-1-trini@konsulko.com>
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

With commit 82b2f4135719 ("env_internal.h: add alternative ENV_SAVE_PTR
macro") we introduced the ENV_SAVE_PTR macro but as explained in the
commit message, left full conversion for a later time. This commit
makes more progress on that front by doing the remaining easy
conversions to the new macro.

Signed-off-by: Tom Rini <trini@konsulko.com>

Changes in v2:
- Reduce the number of conversions, some didn't work as expected once
  CMD_SAVEENV was actually disabled.
- Finish converting UBI

Cc Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 env/eeprom.c  | 2 +-
 env/nvram.c   | 2 +-
 env/onenand.c | 2 +-
 env/scsi.c    | 4 +---
 env/ubi.c     | 4 +---
 5 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/env/eeprom.c b/env/eeprom.c
index b290b1013e1c..f4cc29093768 100644
--- a/env/eeprom.c
+++ b/env/eeprom.c
@@ -175,5 +175,5 @@ U_BOOT_ENV_LOCATION(eeprom) = {
 	.location	= ENVL_EEPROM,
 	ENV_NAME("EEPROM")
 	.load		= env_eeprom_load,
-	.save		= env_save_ptr(env_eeprom_save),
+	.save		= ENV_SAVE_PTR(env_eeprom_save),
 };
diff --git a/env/nvram.c b/env/nvram.c
index d49cd0f337a0..18f0a0aa1fbf 100644
--- a/env/nvram.c
+++ b/env/nvram.c
@@ -65,6 +65,6 @@ U_BOOT_ENV_LOCATION(nvram) = {
 	.location	= ENVL_NVRAM,
 	ENV_NAME("NVRAM")
 	.load		= env_nvram_load,
-	.save		= env_save_ptr(env_nvram_save),
+	.save		= ENV_SAVE_PTR(env_nvram_save),
 	.init		= env_nvram_init,
 };
diff --git a/env/onenand.c b/env/onenand.c
index 8c349ef5ce6c..59b523e06c63 100644
--- a/env/onenand.c
+++ b/env/onenand.c
@@ -107,5 +107,5 @@ U_BOOT_ENV_LOCATION(onenand) = {
 	.location	= ENVL_ONENAND,
 	ENV_NAME("OneNAND")
 	.load		= env_onenand_load,
-	.save		= env_save_ptr(env_onenand_save),
+	.save		= ENV_SAVE_PTR(env_onenand_save),
 };
diff --git a/env/scsi.c b/env/scsi.c
index 207717e17b16..e56891a98993 100644
--- a/env/scsi.c
+++ b/env/scsi.c
@@ -108,8 +108,6 @@ U_BOOT_ENV_LOCATION(scsi) = {
 	.location	= ENVL_SCSI,
 	ENV_NAME("SCSI")
 	.load		= env_scsi_load,
-#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
-	.save		= env_save_ptr(env_scsi_save),
+	.save		= ENV_SAVE_PTR(env_scsi_save),
 	.erase		= ENV_ERASE_PTR(env_scsi_erase),
-#endif
 };
diff --git a/env/ubi.c b/env/ubi.c
index 59bd96feb488..e9865b45ebc6 100644
--- a/env/ubi.c
+++ b/env/ubi.c
@@ -33,7 +33,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define ENV_UBI_VOLUME_REDUND "invalid"
 #endif
 
-#ifdef CONFIG_CMD_SAVEENV
 #ifdef CONFIG_ENV_REDUNDANT
 static int env_ubi_save(void)
 {
@@ -103,7 +102,6 @@ static int env_ubi_save(void)
 	return 0;
 }
 #endif /* CONFIG_ENV_REDUNDANT */
-#endif /* CONFIG_CMD_SAVEENV */
 
 #ifdef CONFIG_ENV_REDUNDANT
 static int env_ubi_load(void)
@@ -219,6 +217,6 @@ U_BOOT_ENV_LOCATION(ubi) = {
 	.location	= ENVL_UBI,
 	ENV_NAME("UBI")
 	.load		= env_ubi_load,
-	.save		= env_save_ptr(env_ubi_save),
+	.save		= ENV_SAVE_PTR(env_ubi_save),
 	.erase		= ENV_ERASE_PTR(env_ubi_erase),
 };
-- 
2.43.0

