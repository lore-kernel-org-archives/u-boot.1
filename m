Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5EAC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA15E84C71;
	Thu,  2 Jul 2026 03:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="purHjHec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2EA84C51; Thu,  2 Jul 2026 03:47:51 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DF084C15
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-69eb8b6bea8so635658eaf.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956867; x=1783561667; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSjktCylVTpR9L9EoybU4XT3DfZoxAP6sPBvz+oLaNw=;
 b=purHjHecfgwvGi3YCzgeLs9wo7kuyGt0lXedflzDCx0P7JnJGJdz+xF1db8qjYlPSL
 KnFq8nBpukuS6TcQAOr766kkWfiiJCG74CapgyZrl0M3odaoF6HRdM+JPq/SEs3mIfbH
 h+PrDWOsg2W+WMJqsST3Ef6vHXjmLuFLoULXY4/XoljOajh8cl5jl1+vLuhIFCXIe5zw
 GFbyDvxXAMD5w05RBaS981JwUNqoUffZaigIVnNrOHs+FVBdrQ2vFZ8AC51E/3BY69bl
 vYy2lcliiM4zEFvIw96uq2J/0Jc2syn11ZLY653iA1NxXN43rzwRmn3hhwjiNdWpA0t3
 czCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956867; x=1783561667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fSjktCylVTpR9L9EoybU4XT3DfZoxAP6sPBvz+oLaNw=;
 b=Sz2ZSyX6BTqVrq+TGMoFVUlqGrFa7EBvU1uWBq0CO7WN9DyEN5jfuUy2/hfd9FY9CL
 g6z7/Kaaa0piMdA/givj5cbVHekp0uwCG7eyiHqkH/0QPhHeHWb8g9Jj82tf7vqPaTWA
 mToz2fKPR9VF9HFQz7Xpf1Z8G1CMqh5Z0QJI1jHZs7f7/TWGe6Se/4K0pIlLzHYl7CqZ
 QzFigbsR34pHojq2DrtyzRukUk2CVHa8f8FlRpjwyiG7QLUK9GZrC8kG518NHGJtkuZj
 ia+AWRGwkcGYHItRutIjOwF0C5Rr0f1su0sYUIXh6UHVF/p/T1NrM2CTQ3Aw10S9RIu+
 MsXg==
X-Gm-Message-State: AOJu0Yyd1gr01W7uZEFfYulfuMLP0FMI7YaF8pDCGcpSLp96RQ5NLEGq
 8owJy+zq/MFcCFWS1n7EBbMUQKQ02curxMLHwOLXXW3t0JtBSZLUizhFfMelObGjjMbiog==
X-Gm-Gg: AfdE7cnyjaEsRqBNpB4ltG3u8QEb80Pyng7LeTmGo61EYEqnKSmKZ30zjQAl61h8mG1
 6Y6tI8jkHQyf2/7pakvh5Y6amq+OAuQA6UuS8I9S7gWv3ibRzoSFrA3R2wsNYIVp+Tm8uiXme9B
 ykmsZaGvE/12N3h+QnBuRXRkU31dmDYLgQGQXG/GiNJw/daRPRMOWEAwbIG3wxdWexiqiMOJZYC
 gc/C+wHF4ALQaj+2ktX2W1mSyEjH7ZQO0kuz1ZDOrRAPfnLG07WbXLYsRnJWmpp3TVeXiAANAWv
 Oi1pam01h6VZFEioeFO29A5VNiKCAZrOr8DqB29zTE1Rv6cF4kbHab2gm4V2axj2sCYhYgum5ch
 j84e8rvk9tsIpNgCMVZugfP4ZUT9pU0S6pvhl2FPorpS74snNPIrYolyy0P3zzGPeEpgMem8x8M
 XvEAmrbn4VC7jUvMdokOeCGpiYWXSb/Rq9nj/E4FGHTnQRzgyjyOGWl+Tjgs7GFSvie5FMF33r/
 0NU/nZ+7peHKXtdMpE2D9Ou7WMpyIsgxARSMIkTPYAkioUVBpOYT3/l/J+H9qOE/197mRL7WZ77
 3KqM7N94o5+kDN8=
X-Received: by 2002:a05:6820:1610:b0:6a0:d9a3:fba4 with SMTP id
 006d021491bc7-6a309964088mr2378441eaf.14.1782956867197; 
 Wed, 01 Jul 2026 18:47:47 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:47:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 3/9] boot: image: add FIT decrypt-to-buffer helper
Date: Wed,  1 Jul 2026 19:46:53 -0600
Message-ID: <20260702014724.1534351-3-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702014724.1534351-1-james.hilliard1@gmail.com>
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
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

FIT cipher support currently allocates the output buffer inside the AES
helper. SPL often needs to decrypt directly into a caller-selected buffer,
for example a load buffer or a scratch buffer used before decompression.

Add a decrypt_to callback to the FIT cipher algorithm and wire it up for
AES. The existing allocating decrypt path becomes a wrapper around the new
helper.

When DM_AES is enabled, try the first UCLASS_AES provider before using the
software AES fallback in U-Boot proper. Return AES device errors to the
caller instead of hiding them with a software fallback after the device has
accepted the operation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/image-cipher.c   | 38 +++++++++++++++--
 boot/image-fit.c      |  7 +++-
 include/image.h       | 39 +++++++++++++++--
 include/u-boot/aes.h  | 10 +++++
 lib/Makefile          |  2 +-
 lib/aes/aes-decrypt.c | 98 ++++++++++++++++++++++++++++++++++++-------
 6 files changed, 170 insertions(+), 24 deletions(-)

diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index 9d389f26cea..93b3dd3c637 100644
--- a/boot/image-cipher.c
+++ b/boot/image-cipher.c
@@ -25,6 +25,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	},
 	{
@@ -36,6 +37,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	},
 	{
@@ -47,6 +49,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	}
 };
@@ -70,6 +73,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 				   int cipher_noffset)
 {
 	const void *fdt = gd_fdt_blob();
+	int key_len, iv_len;
 	const char *node_name;
 	char node_path[128];
 	int noffset;
@@ -94,7 +98,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 		return -1;
 	}
 
-	info->iv = fdt_getprop(fit, cipher_noffset, "iv", NULL);
+	info->iv = fdt_getprop(fit, cipher_noffset, "iv", &iv_len);
 	info->ivname = fdt_getprop(fit, cipher_noffset, "iv-name-hint", NULL);
 
 	if (!info->iv && !info->ivname) {
@@ -136,20 +140,28 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 	}
 
 	/* read key */
-	info->key = fdt_getprop(fdt, noffset, "key", NULL);
+	info->key = fdt_getprop(fdt, noffset, "key", &key_len);
 	if (!info->key) {
 		printf("Can't get key in cipher node '%s'\n", node_path);
 		return -1;
 	}
+	if (key_len != info->cipher->key_len) {
+		printf("Bad key length in cipher node '%s'\n", node_path);
+		return -1;
+	}
 
 	/* read iv */
 	if (!info->iv) {
-		info->iv = fdt_getprop(fdt, noffset, "iv", NULL);
+		info->iv = fdt_getprop(fdt, noffset, "iv", &iv_len);
 		if (!info->iv) {
 			printf("Can't get IV in cipher node '%s'\n", node_path);
 			return -1;
 		}
 	}
+	if (iv_len != info->cipher->iv_len) {
+		printf("Bad IV length for cipher in image '%s'\n", node_name);
+		return -1;
+	}
 
 	return 0;
 }
@@ -173,3 +185,23 @@ int fit_image_decrypt_data(const void *fit,
  out:
 	return ret;
 }
+
+int fit_image_decrypt_data_to(const void *fit,
+			      int image_noffset, int cipher_noffset,
+			      const void *data_ciphered, size_t size_ciphered,
+			      void *data_unciphered, size_t *size_unciphered)
+{
+	struct image_cipher_info info;
+	int ret;
+
+	ret = fit_image_setup_decrypt(&info, fit, image_noffset,
+				      cipher_noffset);
+	if (ret < 0)
+		return ret;
+
+	if (!info.cipher->decrypt_to)
+		return -ENOSYS;
+
+	return info.cipher->decrypt_to(&info, data_ciphered, size_ciphered,
+				       data_unciphered, size_unciphered);
+}
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 044a40e1910..dac8b35f338 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1030,7 +1030,7 @@ int fit_image_get_data_size(const void *fit, int noffset, int *data_size)
  *
  * @fit: pointer to the FIT image header
  * @noffset: component image node offset
- * @data_size: holds the data-size property
+ * @data_size: holds the data-size-unciphered property
  *
  * returns:
  *     0, on success
@@ -1040,10 +1040,13 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 				       size_t *data_size)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, "data-size-unciphered", NULL);
+	val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
 	if (!val)
 		return -ENOENT;
+	if (len != sizeof(*val))
+		return -EINVAL;
 
 	*data_size = (size_t)fdt32_to_cpu(*val);
 
diff --git a/include/image.h b/include/image.h
index 9c8a746d576..5edbf8fdc33 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1862,11 +1862,40 @@ int fit_image_check_sig(const void *fit, int noffset, const void *data,
 			size_t size, const void *key_blob, int required_keynode,
 			char **err_msgp);
 
-int fit_image_decrypt_data(const void *fit,
-			   int image_noffset, int cipher_noffset,
-			   const void *data, size_t size,
+/**
+ * fit_image_decrypt_data() - Decrypt a FIT image payload
+ *
+ * @fit:		FIT image
+ * @image_noffset:	Offset of the image node to decrypt
+ * @cipher_noffset:	Offset of the cipher node for the image
+ * @data:		Encrypted image payload
+ * @size:		Size of encrypted image payload
+ * @data_unciphered:	Returns allocated decrypted payload
+ * @size_unciphered:	Returns size of decrypted payload
+ * Return: 0 on success, <0 on error
+ */
+int fit_image_decrypt_data(const void *fit, int image_noffset,
+			   int cipher_noffset, const void *data, size_t size,
 			   void **data_unciphered, size_t *size_unciphered);
 
+/**
+ * fit_image_decrypt_data_to() - Decrypt a FIT image payload to a buffer
+ *
+ * @fit:		FIT image
+ * @image_noffset:	Offset of the image node to decrypt
+ * @cipher_noffset:	Offset of the cipher node for the image
+ * @data:		Encrypted image payload
+ * @size:		Size of encrypted image payload
+ * @data_unciphered:	Destination buffer for decrypted payload. The caller
+ *			must provide at least @size bytes.
+ * @size_unciphered:	Returns size of decrypted payload
+ * Return: 0 on success, <0 on error
+ */
+int fit_image_decrypt_data_to(const void *fit,
+			      int image_noffset, int cipher_noffset,
+			      const void *data, size_t size,
+			      void *data_unciphered, size_t *size_unciphered);
+
 /**
  * fit_region_make_list() - Make a list of regions to hash
  *
@@ -1960,6 +1989,10 @@ struct cipher_algo {
 	int (*decrypt)(struct image_cipher_info *info,
 		       const void *cipher, size_t cipher_len,
 		       void **data, size_t *data_len);
+
+	int (*decrypt_to)(struct image_cipher_info *info,
+			  const void *cipher, size_t cipher_len,
+			  void *data, size_t *data_len);
 };
 
 int fit_image_cipher_get_algo(const void *fit, int noffset, char **algo);
diff --git a/include/u-boot/aes.h b/include/u-boot/aes.h
index acbc50b9e6f..6d81af3780d 100644
--- a/include/u-boot/aes.h
+++ b/include/u-boot/aes.h
@@ -34,6 +34,9 @@ int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
 		      void **data, size_t *size);
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size);
 #else
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
@@ -41,6 +44,13 @@ int image_aes_decrypt(struct image_cipher_info *info,
 {
 	return -ENXIO;
 }
+
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size)
+{
+	return -ENXIO;
+}
 #endif /* IMAGE_ENABLE_DECRYPT */
 
 #endif
diff --git a/lib/Makefile b/lib/Makefile
index d0ffabc2b47..c69a928e6d8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_ARCH_AT91) += at91/
 obj-$(CONFIG_OPTEE_LIB) += optee/
 
 obj-$(CONFIG_AES) += aes.o
-obj-$(CONFIG_AES) += aes/
 obj-$(CONFIG_$(PHASE_)BINMAN_FDT) += binman.o
 
 obj-$(CONFIG_FW_LOADER) += fw_loader.o
@@ -88,6 +87,7 @@ obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
+obj-$(CONFIG_$(PHASE_)FIT_CIPHER) += aes/
 obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
 obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 741102a4723..84e7a5bf3e5 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -4,37 +4,105 @@
  */
 
 #ifndef USE_HOSTCC
+#include <dm.h>
 #include <malloc.h>
 #endif
 #include <image.h>
 #include <uboot_aes.h>
 
+#ifndef USE_HOSTCC
+static int image_aes_validate_lengths(struct image_cipher_info *info,
+				      size_t cipher_len)
+{
+	if (!cipher_len || cipher_len % AES_BLOCK_LENGTH ||
+	    info->size_unciphered > cipher_len)
+		return -EINVAL;
+
+	return 0;
+}
+#endif
+
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size)
+{
+#ifndef USE_HOSTCC
+	unsigned int aes_blocks, key_len = info->cipher->key_len;
+	int ret = -ENOSYS;
+
+	ret = image_aes_validate_lengths(info, cipher_len);
+	if (ret)
+		return ret;
+
+	*size = info->size_unciphered;
+
+	if (CONFIG_IS_ENABLED(DM_AES)) {
+		struct udevice *dev;
+
+		ret = uclass_first_device_err(UCLASS_AES, &dev);
+		if (!ret) {
+			ret = dm_aes_set_key_for_key_slot(dev, key_len * 8,
+							  (u8 *)info->key, 0);
+			if (ret)
+				return ret;
+
+			ret = dm_aes_select_key_slot(dev, key_len * 8, 0);
+			if (ret)
+				return ret;
+
+			aes_blocks = cipher_len / AES_BLOCK_LENGTH;
+
+			return dm_aes_cbc_decrypt(dev, (u8 *)info->iv,
+						  (u8 *)cipher, data,
+						  aes_blocks);
+		}
+	}
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
+
+		/* First we expand the key. */
+		aes_expand_key((u8 *)info->key, key_len, key_exp);
+
+		/* Calculate the number of AES blocks to decrypt. */
+		aes_blocks = cipher_len / AES_BLOCK_LENGTH;
+
+		aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
+				       (u8 *)cipher, data, aes_blocks);
+		return 0;
+	}
+
+	return ret;
+#endif
+
+	return 0;
+}
+
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
 		      void **data, size_t *size)
 {
-#ifndef USE_HOSTCC
-	unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
-	unsigned int aes_blocks, key_len = info->cipher->key_len;
+#ifdef USE_HOSTCC
+	return 0;
+#else
+	int ret;
+
+	ret = image_aes_validate_lengths(info, cipher_len);
+	if (ret)
+		return ret;
 
 	*data = malloc(cipher_len);
 	if (!*data) {
 		printf("Can't allocate memory to decrypt\n");
 		return -ENOMEM;
 	}
-	*size = info->size_unciphered;
 
-	memcpy(&key_exp[0], info->key, key_len);
-
-	/* First we expand the key. */
-	aes_expand_key((u8 *)info->key, key_len, key_exp);
-
-	/* Calculate the number of AES blocks to encrypt. */
-	aes_blocks = DIV_ROUND_UP(cipher_len, AES_BLOCK_LENGTH);
+	ret = image_aes_decrypt_to(info, cipher, cipher_len, *data, size);
+	if (ret) {
+		free(*data);
+		*data = NULL;
+	}
 
-	aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
-			       (u8 *)cipher, *data, aes_blocks);
+	return ret;
 #endif
-
-	return 0;
 }
-- 
2.53.0

