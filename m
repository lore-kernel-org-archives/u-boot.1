Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9D8C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 11:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F76182F71;
	Sun, 29 Jun 2025 13:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSs2WGqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5AA8277D; Sun, 29 Jun 2025 13:02:32 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F47C82F28
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-32b43cce9efso10474731fa.3
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194942; x=1751799742; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1K6o43dyb7jysh6I6oQ4MWrIhG+cFMiAwx7cfkhNIU=;
 b=ZSs2WGqkyxsos7NQggcTCmwjjXGnHzZ4+52B167GVtx1Ho66Hxf1FlJw7WALJE+ZXJ
 /xeF2vn3CMmE2GJwjD4Mm5lqGuE+5AXF9A+H11dVDcLhDl+RhPn6gqYn7tQfa6N4FzVy
 DjGoPHG96JY5ES9atACOJAIgypdt6OJpdpx9becoOT/86MRQRqSAtl2cKTcbGBBbHNnn
 qC9m9yolTdAaGwfXv7To4zeAXXJ5wlmDCXcUgJzWQDF2PTBQ2XhD2wfOfYJy2coKqfgt
 W+7ermYg1TIM9bKUKR9QStPZxf+HYX+4mbdw6Kx/LQFrEPqyJzTaz/VXRgzPTw8V7mYy
 a64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194942; x=1751799742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1K6o43dyb7jysh6I6oQ4MWrIhG+cFMiAwx7cfkhNIU=;
 b=GmnS0jEHaVktJhI+ycPkVGcW+u+qYV/JRfDrFmZphYdianLQTWpmdNtQ1xghxN41AQ
 6KvJVr/m1HnZq+O0ChR4uwVfFK7dtjQPretK0TDihJdXXwXcCpfm6Lq7/98HE7k4sADo
 BQZqLk60UMd7p1/LUjisW4mp7XY2wrMlxo+itgqFhUc9LMVUrnsTBqewbeaF0hQCjIxO
 XitJa/CHQVCdNLvLcF78rdIAVV7JB4I1XIkWRwDdIR01dmYVhbAAQ15MMmbkNsArKv5U
 /baVZUC+FnkZ/c3JHxePNu2KvP3Weqmv58bNUer4eJLE7Q+rx59XXN2eq0dsd0wfRGJU
 p1dA==
X-Gm-Message-State: AOJu0YwqsZ03u/ZODV+l/DC5lo+mjmUQ5HiI2gjBDvPHcMC2Sk9YmKBb
 zZQGo+UGfzyZx+bNtTeOqO29zXARGPOPYU39bjSyY0avOaNIyf2qzZ9V
X-Gm-Gg: ASbGncvCUxHZlryPDudeO6Ex3b4sUMp20PFQ5ze3sNdPu2RBl9Jjr67XcOOkJDJJFnI
 3/e/gM0hL3w3mWzrFZCc9063c8cpepSk8BuEoneqbgYsBPhmb/CEemyL+DDe8DGCw5Duc6I2HW/
 jOv1j3LXkH9BmVldEhP80aztKmEaBHVRl9FoRgS36nS+17RHPifGmoLpTv8+93pCTJFprjcdCpR
 gXGrg3FNPXzSImCyPAi7bMXRZtQ1RRcTZ639X7UlvLnf7USkbwLuQ5+fMn9aAjxAptXEsIYv52e
 ejg9X2S5BnImQuJdlmBzKypLmB1rWbs+zmUFHdr+7rIuTOsZwebT7w==
X-Google-Smtp-Source: AGHT+IFdIivaotj0wLbh2FQMbqe/aZzotTz4GfzV/sIylX5nkuHxz/lb8HYUB4nur8lo0N1aN2oJyw==
X-Received: by 2002:a05:6512:3c82:b0:553:d6fe:b9e7 with SMTP id
 2adb3069b0e04-5550b8d21eemr3343584e87.51.1751194941399; 
 Sun, 29 Jun 2025 04:02:21 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24028esm1090621e87.19.2025.06.29.04.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 04:02:20 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 6/6] ARM: tegra: Use AES engine for crypto functions
Date: Sun, 29 Jun 2025 14:02:03 +0300
Message-ID: <20250629110203.25086-7-clamor95@gmail.com>
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

Previously software based AES encryption was used with previously known
device specific keys (SBK), now that we have AES driver we can simply
delegate this to the engine without prior knowledge of the key (assuming
it is still loaded).

Signed-off-by: Ion Agorria <ion@agorria.com>
---
 arch/arm/include/asm/arch-tegra/crypto.h |  41 +++--
 arch/arm/mach-tegra/Kconfig              |   2 +
 arch/arm/mach-tegra/crypto.c             | 184 ++++++-----------------
 arch/arm/mach-tegra/tegra124/bct.c       |  20 +--
 arch/arm/mach-tegra/tegra20/bct.c        |  20 +--
 arch/arm/mach-tegra/tegra30/bct.c        |  20 +--
 6 files changed, 84 insertions(+), 203 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/crypto.h b/arch/arm/include/asm/arch-tegra/crypto.h
index 73e8365a57d..930bc842039 100644
--- a/arch/arm/include/asm/arch-tegra/crypto.h
+++ b/arch/arm/include/asm/arch-tegra/crypto.h
@@ -10,40 +10,33 @@
 #define TEGRA_AES_SLOT_SBK		0
 
 /**
- * Sign a block of data
+ * sign_data_block - Sign a block of data
  *
- * \param source	Source data
- * \param length	Size of source data
- * \param signature	Destination address for signature, AES_KEY_LENGTH bytes
+ * @source		Source data
+ * @length		Size of source data in bytes
+ * @signature		Destination address for signature, AES_KEY_LENGTH bytes
+ * Return:		0 on success, negative value on failure
  */
 int sign_data_block(u8 *source, unsigned int length, u8 *signature);
 
 /**
- * Sign an encrypted block of data
+ * encrypt_data_block - Encrypt a block of data
  *
- * \param source	Source data
- * \param length	Size of source data
- * \param signature	Destination address for signature, AES_KEY_LENGTH bytes
- * \param key		AES128 encryption key
+ * @source		Source data
+ * @dest		Destination data
+ * @length		Size of source data in bytes
+ * Return:		0 on success, negative value on failure
  */
-int sign_enc_data_block(u8 *source, unsigned int length, u8 *signature, u8 *key);
+int encrypt_data_block(u8 *source, u8 *dest, unsigned int length);
 
 /**
- * Encrypt a block of data
+ * decrypt_data_block - Decrypt a block of data
  *
- * \param source	Source data
- * \param length	Size of source data
- * \param key		AES128 encryption key
+ * @source		Source data
+ * @dest		Destination data
+ * @length		Size of source data in bytes
+ * Return:		0 on success, negative value on failure
  */
-int encrypt_data_block(u8 *source, unsigned int length, u8 *key);
-
-/**
- * Decrypt a block of data
- *
- * \param source	Source data
- * \param length	Size of source data
- * \param key		AES128 encryption key
- */
-int decrypt_data_block(u8 *source, unsigned int length, u8 *key);
+int decrypt_data_block(u8 *source, u8 *dest, unsigned int length);
 
 #endif /* #ifndef _CRYPTO_H_ */
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index c3c352eceb1..32cdfebfc01 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -17,7 +17,9 @@ config TEGRA_CLKRST
 
 config TEGRA_CRYPTO
 	bool "Tegra AES128 crypto module"
+	select DM_AES
 	select AES
+	select TEGRA_AES
 
 config TEGRA_GP_PADCTRL
 	bool
diff --git a/arch/arm/mach-tegra/crypto.c b/arch/arm/mach-tegra/crypto.c
index 49e6a45243a..1005c815b36 100644
--- a/arch/arm/mach-tegra/crypto.c
+++ b/arch/arm/mach-tegra/crypto.c
@@ -4,164 +4,68 @@
  * (C) Copyright 2010 - 2011 NVIDIA Corporation <www.nvidia.com>
  */
 
+#include <dm.h>
 #include <log.h>
 #include <linux/errno.h>
 #include <asm/arch-tegra/crypto.h>
 #include "uboot_aes.h"
 
-static u8 zero_key[16];
-
-#define AES_CMAC_CONST_RB 0x87  /* from RFC 4493, Figure 2.2 */
-
-enum security_op {
-	SECURITY_SIGN		= 1 << 0,	/* Sign the data */
-	SECURITY_ENCRYPT	= 1 << 1,	/* Encrypt the data */
-	SECURITY_DECRYPT	= 1 << 2,	/* Dectypt the data */
-};
-
-/**
- * Shift a vector left by one bit
- *
- * \param in	Input vector
- * \param out	Output vector
- * \param size	Length of vector in bytes
- */
-static void left_shift_vector(u8 *in, u8 *out, int size)
+int sign_data_block(u8 *source, unsigned int length, u8 *signature)
 {
-	int carry = 0;
-	int i;
-
-	for (i = size - 1; i >= 0; i--) {
-		out[i] = (in[i] << 1) | carry;
-		carry = in[i] >> 7;	/* get most significant bit */
+	struct udevice *dev;
+	int ret;
+
+	/* Only one AES engine should be present */
+	ret = uclass_get_device(UCLASS_AES, 0, &dev);
+	if (ret) {
+		log_err("%s: failed to get tegra_aes: %d\n", __func__, ret);
+		return ret;
 	}
-}
-
-/**
- * Sign a block of data, putting the result into dst.
- *
- * \param key			Input AES key, length AES128_KEY_LENGTH
- * \param key_schedule		Expanded key to use
- * \param src			Source data of length 'num_aes_blocks' blocks
- * \param dst			Destination buffer, length AES128_KEY_LENGTH
- * \param num_aes_blocks	Number of AES blocks to encrypt
- */
-static void sign_object(u8 *key, u8 *key_schedule, u8 *src, u8 *dst,
-			u32 num_aes_blocks)
-{
-	u8 tmp_data[AES128_KEY_LENGTH];
-	u8 iv[AES128_KEY_LENGTH] = {0};
-	u8 left[AES128_KEY_LENGTH];
-	u8 k1[AES128_KEY_LENGTH];
-	u8 *cbc_chain_data;
-	unsigned int i;
 
-	cbc_chain_data = zero_key;	/* Convenient array of 0's for IV */
+	ret = dm_aes_select_key_slot(dev, 128, TEGRA_AES_SLOT_SBK);
+	if (ret)
+		return ret;
 
-	/* compute K1 constant needed by AES-CMAC calculation */
-	for (i = 0; i < AES128_KEY_LENGTH; i++)
-		tmp_data[i] = 0;
-
-	aes_cbc_encrypt_blocks(AES128_KEY_LENGTH, key_schedule, iv,
-			       tmp_data, left, 1);
-
-	left_shift_vector(left, k1, sizeof(left));
-
-	if ((left[0] >> 7) != 0) /* get MSB of L */
-		k1[AES128_KEY_LENGTH - 1] ^= AES_CMAC_CONST_RB;
-
-	/* compute the AES-CMAC value */
-	for (i = 0; i < num_aes_blocks; i++) {
-		/* Apply the chain data */
-		aes_apply_cbc_chain_data(cbc_chain_data, src, tmp_data);
-
-		/* for the final block, XOR K1 into the IV */
-		if (i == num_aes_blocks - 1)
-			aes_apply_cbc_chain_data(tmp_data, k1, tmp_data);
-
-		/* encrypt the AES block */
-		aes_encrypt(AES128_KEY_LENGTH, tmp_data,
-			    key_schedule, dst);
-
-		debug("sign_obj: block %d of %d\n", i, num_aes_blocks);
-
-		/* Update pointers for next loop. */
-		cbc_chain_data = dst;
-		src += AES128_KEY_LENGTH;
-	}
+	return dm_aes_cmac(dev, source, signature,
+			   DIV_ROUND_UP(length, AES_BLOCK_LENGTH));
 }
 
-/**
- * Decrypt, encrypt or sign a block of data (depending on security mode).
- *
- * \param key		Input AES key, length AES128_KEY_LENGTH
- * \param oper		Security operations mask to perform (enum security_op)
- * \param src		Source data
- * \param length	Size of source data
- * \param sig_dst	Destination address for signature, AES128_KEY_LENGTH bytes
- */
-static int tegra_crypto_core(u8 *key, enum security_op oper, u8 *src,
-			     u32 length, u8 *sig_dst)
+int encrypt_data_block(u8 *source, u8 *dest, unsigned int length)
 {
-	u32 num_aes_blocks;
-	u8 key_schedule[AES128_EXPAND_KEY_LENGTH];
-	u8 iv[AES128_KEY_LENGTH] = {0};
-
-	debug("%s: length = %d\n", __func__, length);
-
-	aes_expand_key(key, AES128_KEY_LENGTH, key_schedule);
-
-	num_aes_blocks = (length + AES128_KEY_LENGTH - 1) / AES128_KEY_LENGTH;
-
-	if (oper & SECURITY_DECRYPT) {
-		/* Perform this in place, resulting in src being decrypted. */
-		debug("%s: begin decryption\n", __func__);
-		aes_cbc_decrypt_blocks(AES128_KEY_LENGTH, key_schedule, iv, src,
-				       src, num_aes_blocks);
-		debug("%s: end decryption\n", __func__);
-	}
-
-	if (oper & SECURITY_ENCRYPT) {
-		/* Perform this in place, resulting in src being encrypted. */
-		debug("%s: begin encryption\n", __func__);
-		aes_cbc_encrypt_blocks(AES128_KEY_LENGTH, key_schedule, iv, src,
-				       src, num_aes_blocks);
-		debug("%s: end encryption\n", __func__);
-	}
-
-	if (oper & SECURITY_SIGN) {
-		/* encrypt the data, overwriting the result in signature. */
-		debug("%s: begin signing\n", __func__);
-		sign_object(key, key_schedule, src, sig_dst, num_aes_blocks);
-		debug("%s: end signing\n", __func__);
+	struct udevice *dev;
+	int ret;
+
+	/* Only one AES engine should be present */
+	ret = uclass_get_device(UCLASS_AES, 0, &dev);
+	if (ret) {
+		log_err("%s: failed to get tegra_aes: %d\n", __func__, ret);
+		return ret;
 	}
 
-	return 0;
-}
+	ret = dm_aes_select_key_slot(dev, 128, TEGRA_AES_SLOT_SBK);
+	if (ret)
+		return ret;
 
-/**
- * Tegra crypto group
- */
-int sign_data_block(u8 *source, unsigned int length, u8 *signature)
-{
-	return tegra_crypto_core(zero_key, SECURITY_SIGN, source,
-				 length, signature);
+	return dm_aes_cbc_encrypt(dev, (u8 *)AES_ZERO_BLOCK, source, dest,
+				  DIV_ROUND_UP(length, AES_BLOCK_LENGTH));
 }
 
-int sign_enc_data_block(u8 *source, unsigned int length, u8 *signature, u8 *key)
+int decrypt_data_block(u8 *source, u8 *dest, unsigned int length)
 {
-	return tegra_crypto_core(key, SECURITY_SIGN, source,
-				 length, signature);
-}
+	struct udevice *dev;
+	int ret;
+
+	/* Only one AES engine should be present */
+	ret = uclass_get_device(UCLASS_AES, 0, &dev);
+	if (ret) {
+		log_err("%s: failed to get tegra_aes: %d\n", __func__, ret);
+		return ret;
+	}
 
-int encrypt_data_block(u8 *source, unsigned int length, u8 *key)
-{
-	return tegra_crypto_core(key, SECURITY_ENCRYPT, source,
-				 length, NULL);
-}
+	ret = dm_aes_select_key_slot(dev, 128, TEGRA_AES_SLOT_SBK);
+	if (ret)
+		return ret;
 
-int decrypt_data_block(u8 *source, unsigned int length, u8 *key)
-{
-	return tegra_crypto_core(key, SECURITY_DECRYPT, source,
-				 length, NULL);
+	return dm_aes_cbc_decrypt(dev, (u8 *)AES_ZERO_BLOCK, source, dest,
+				  DIV_ROUND_UP(length, AES_BLOCK_LENGTH));
 }
diff --git a/arch/arm/mach-tegra/tegra124/bct.c b/arch/arm/mach-tegra/tegra124/bct.c
index a71aa87fce1..26004188444 100644
--- a/arch/arm/mach-tegra/tegra124/bct.c
+++ b/arch/arm/mach-tegra/tegra124/bct.c
@@ -8,12 +8,10 @@
 #include <log.h>
 #include <vsprintf.h>
 #include <asm/arch-tegra/crypto.h>
+#include <asm/arch-tegra/fuse.h>
 #include "bct.h"
 #include "uboot_aes.h"
 
-/* Device with "sbk burned: false" will expose zero key */
-const u8 nosbk[AES128_KEY_LENGTH] = { 0 };
-
 /*
  * @param  bct		boot config table start in RAM
  * @param  ect		bootloader start in RAM
@@ -25,29 +23,25 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	struct nvboot_config_table *bct_tbl = NULL;
 	u8 ebt_hash[AES128_KEY_LENGTH] = { 0 };
 	u8 bct_hash[AES128_KEY_LENGTH] = { 0 };
-	u8 sbk[AES128_KEY_LENGTH] = { 0 };
 	u8 *sbct = bct + UBCT_LENGTH;
 	bool encrypted;
 	int ret;
 
 	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
 
-	memcpy(sbk, (u8 *)(bct + UBCT_LENGTH + SBCT_LENGTH),
-	       NVBOOT_CMAC_AES_HASH_LENGTH * 4);
-
-	encrypted = memcmp(&sbk, &nosbk, AES128_KEY_LENGTH);
+	encrypted = tegra_fuse_get_operation_mode() == MODE_ODM_PRODUCTION_SECURE;
 
 	if (encrypted) {
-		ret = decrypt_data_block(sbct, SBCT_LENGTH, sbk);
+		ret = decrypt_data_block(sbct, sbct, SBCT_LENGTH);
 		if (ret)
 			return 1;
 
-		ret = encrypt_data_block(ebt, ebt_size, sbk);
+		ret = encrypt_data_block(ebt, ebt, ebt_size);
 		if (ret)
 			return 1;
 	}
 
-	ret = sign_enc_data_block(ebt, ebt_size, ebt_hash, sbk);
+	ret = sign_data_block(ebt, ebt_size, ebt_hash);
 	if (ret)
 		return 1;
 
@@ -60,12 +54,12 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	bct_tbl->bootloader[0].length = ebt_size;
 
 	if (encrypted) {
-		ret = encrypt_data_block(sbct, SBCT_LENGTH, sbk);
+		ret = encrypt_data_block(sbct, sbct, SBCT_LENGTH);
 		if (ret)
 			return 1;
 	}
 
-	ret = sign_enc_data_block(sbct, SBCT_LENGTH, bct_hash, sbk);
+	ret = sign_data_block(sbct, SBCT_LENGTH, bct_hash);
 	if (ret)
 		return 1;
 
diff --git a/arch/arm/mach-tegra/tegra20/bct.c b/arch/arm/mach-tegra/tegra20/bct.c
index b647b6b26d2..7a8c2990757 100644
--- a/arch/arm/mach-tegra/tegra20/bct.c
+++ b/arch/arm/mach-tegra/tegra20/bct.c
@@ -8,12 +8,10 @@
 #include <log.h>
 #include <vsprintf.h>
 #include <asm/arch-tegra/crypto.h>
+#include <asm/arch-tegra/fuse.h>
 #include "bct.h"
 #include "uboot_aes.h"
 
-/* Device with "sbk burned: false" will expose zero key */
-const u8 nosbk[AES128_KEY_LENGTH] = { 0 };
-
 /*
  * @param  bct		boot config table start in RAM
  * @param  ect		bootloader start in RAM
@@ -24,7 +22,6 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 {
 	struct nvboot_config_table *bct_tbl = NULL;
 	u8 ebt_hash[AES128_KEY_LENGTH] = { 0 };
-	u8 sbk[AES128_KEY_LENGTH] = { 0 };
 	u8 *bct_hash = bct;
 	bool encrypted;
 	int ret;
@@ -33,22 +30,19 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 
 	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
 
-	memcpy(sbk, (u8 *)(bct + BCT_LENGTH),
-	       NVBOOT_CMAC_AES_HASH_LENGTH * 4);
-
-	encrypted = memcmp(&sbk, &nosbk, AES128_KEY_LENGTH);
+	encrypted = tegra_fuse_get_operation_mode() == MODE_ODM_PRODUCTION_SECURE;
 
 	if (encrypted) {
-		ret = decrypt_data_block(bct, BCT_LENGTH, sbk);
+		ret = decrypt_data_block(bct, bct, BCT_LENGTH);
 		if (ret)
 			return 1;
 
-		ret = encrypt_data_block(ebt, ebt_size, sbk);
+		ret = encrypt_data_block(ebt, ebt, ebt_size);
 		if (ret)
 			return 1;
 	}
 
-	ret = sign_enc_data_block(ebt, ebt_size, ebt_hash, sbk);
+	ret = sign_data_block(ebt, ebt_size, ebt_hash);
 	if (ret)
 		return 1;
 
@@ -61,12 +55,12 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	bct_tbl->bootloader[0].length = ebt_size;
 
 	if (encrypted) {
-		ret = encrypt_data_block(bct, BCT_LENGTH, sbk);
+		ret = encrypt_data_block(bct, bct, BCT_LENGTH);
 		if (ret)
 			return 1;
 	}
 
-	ret = sign_enc_data_block(bct, BCT_LENGTH, bct_hash, sbk);
+	ret = sign_data_block(bct, BCT_LENGTH, bct_hash);
 	if (ret)
 		return 1;
 
diff --git a/arch/arm/mach-tegra/tegra30/bct.c b/arch/arm/mach-tegra/tegra30/bct.c
index 250009ea8d8..92350969488 100644
--- a/arch/arm/mach-tegra/tegra30/bct.c
+++ b/arch/arm/mach-tegra/tegra30/bct.c
@@ -8,12 +8,10 @@
 #include <log.h>
 #include <vsprintf.h>
 #include <asm/arch-tegra/crypto.h>
+#include <asm/arch-tegra/fuse.h>
 #include "bct.h"
 #include "uboot_aes.h"
 
-/* Device with "sbk burned: false" will expose zero key */
-const u8 nosbk[AES128_KEY_LENGTH] = { 0 };
-
 /*
  * @param  bct		boot config table start in RAM
  * @param  ect		bootloader start in RAM
@@ -24,7 +22,6 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 {
 	struct nvboot_config_table *bct_tbl = NULL;
 	u8 ebt_hash[AES128_KEY_LENGTH] = { 0 };
-	u8 sbk[AES128_KEY_LENGTH] = { 0 };
 	u8 *bct_hash = bct;
 	bool encrypted;
 	int ret;
@@ -33,22 +30,19 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 
 	ebt_size = roundup(ebt_size, EBT_ALIGNMENT);
 
-	memcpy(sbk, (u8 *)(bct + BCT_LENGTH),
-	       NVBOOT_CMAC_AES_HASH_LENGTH * 4);
-
-	encrypted = memcmp(&sbk, &nosbk, AES128_KEY_LENGTH);
+	encrypted = tegra_fuse_get_operation_mode() == MODE_ODM_PRODUCTION_SECURE;
 
 	if (encrypted) {
-		ret = decrypt_data_block(bct, BCT_LENGTH, sbk);
+		ret = decrypt_data_block(bct, bct, BCT_LENGTH);
 		if (ret)
 			return 1;
 
-		ret = encrypt_data_block(ebt, ebt_size, sbk);
+		ret = encrypt_data_block(ebt, ebt, ebt_size);
 		if (ret)
 			return 1;
 	}
 
-	ret = sign_enc_data_block(ebt, ebt_size, ebt_hash, sbk);
+	ret = sign_data_block(ebt, ebt_size, ebt_hash);
 	if (ret)
 		return 1;
 
@@ -61,12 +55,12 @@ static int bct_patch(u8 *bct, u8 *ebt, u32 ebt_size)
 	bct_tbl->bootloader[0].length = ebt_size;
 
 	if (encrypted) {
-		ret = encrypt_data_block(bct, BCT_LENGTH, sbk);
+		ret = encrypt_data_block(bct, bct, BCT_LENGTH);
 		if (ret)
 			return 1;
 	}
 
-	ret = sign_enc_data_block(bct, BCT_LENGTH, bct_hash, sbk);
+	ret = sign_data_block(bct, BCT_LENGTH, bct_hash);
 	if (ret)
 		return 1;
 
-- 
2.48.1

