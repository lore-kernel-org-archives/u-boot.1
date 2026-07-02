Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41ADC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B614D84C7D;
	Thu,  2 Jul 2026 03:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="px73UHOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7631084C83; Thu,  2 Jul 2026 03:48:00 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA30984C79
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6a0e55e82d0so792247eaf.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956876; x=1783561676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwCnww1WvNx8tDJueBqYxKQXXHECyDKspwhbMFFGCUw=;
 b=px73UHOPmDlH2s3xPajyVDF7CnCMYJ/WgjNrpod4RcvYuIHFBbKywqX0LXJnJuMDef
 pNriQcqTPklyCsBN3gvdrLs5GPxPeeVBOz237lVl1z9lV5xtgPw9DIoAG01fWMhYwL3j
 nLDFPV7tGs21u8D5VOv27ddg1z7DXXU5gtvq8vpv14kJRIh4JTBCzCOO6C2uy8D48ELL
 1dDHGVSbkDb6aZFfvoL6tfYfSyV+6BNzcAu4LnCDWPfT0L/2dvdUSpmAKaPdQLFjE9ur
 BHc6W1LSNQETL2GF/tZMf3qFw0fGwI/u6LpM+K1oXYcKrBdPrDLCAqFnOe5tSijmKpZS
 4adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956876; x=1783561676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwCnww1WvNx8tDJueBqYxKQXXHECyDKspwhbMFFGCUw=;
 b=OuCqt/N0x+sBXFfW8tt3Hv9Mfmi90MrYADvN301PwaqdE2ZE/HpjCIWdPKQeQfn/N3
 U49UXn0QuF6SM+MZXft4Q+BaEMYoy7d+EFw1sJF4Ox/FiU9/LfyiIdCQrxBaOSDyz7nF
 XXpdBQ+VZi7XdVqFtg8agxmYUPQwf5E+UaLXvYatXJDu4Lp3OracaX+6gLKR0BTzJtO8
 ZMo4xnLgqFp1pvxD9RRcKzG1v1RK2Maz0tbR+RAuurKAnsViIKxY89F+O/ETUr5QSYQS
 xlt47Maj2OiLmsv6Rzwk59HtMrFgo6DQVwgjI68M7l63qh1mzhRZy36A4+tRe+KSpqx9
 akzw==
X-Gm-Message-State: AOJu0YwyqxDoTSPG5/iNfCYqp7i06nmM5abGYY/MozGLIzOLS1CYEpMh
 jIACZ9bGUrRt14V9FWtCiMg9WP3qrbOiDDAkcwVtIOzP7YjyadS88Z6vG252Ggg0cMM53A==
X-Gm-Gg: AfdE7cm3WjPkW3duA9W0h+RZ2wa8zcxCo3clevIVNDIRShjrWgk6o5xLNzBPugaldPm
 8oOYM/Sy/XFsAY/FDlDR5i9cQycXjWhGEcuYx4O4sTWAyLIixz+BJa2VCZZyXmts7qqADTy8FjH
 85sdJusYtLUAMXbpJ30opVjZnJMdeJMl604iktj3iUaZK12B9nFrq8+U4eod/ooOK3fb4GTsuzV
 3l0lpXGtwQKq/+OpRnYMYOLk+0aehTE5vDdD2XRXQGvRtL4RcMqV+bAsYYzu52cYnoelwNyl66G
 /96gF8F5BN1BMFOpwbFbs9i0DV/R196xPTP5j+wbGOuww0512eetsY1UN9MxwudycjV/iYD4ioA
 e8hMshV7eUK4qAR8HdAV5nCdNIj0wfB1OyZZFCptWch1PjxFPHo/njPp8R5NLgunMARDOhpfMVs
 h0mha1/bnsVSzkIZH/a3AM8ALsVvWEKj2nnbd8eUmbK60Eqp+D4Eq7ILYFzF3NNlpx2Lu08v8AK
 8H7F+d4co/orjr2TrUlgVUSAbctUmlZZCohnpk5CLuQ7Ru6KQZMtuyuIi/II5LNlDIkVjDuEURX
 pHT+EOgryVKRhv2VEuq+GoovXw==
X-Received: by 2002:a05:6820:f028:b0:6a1:50eb:211e with SMTP id
 006d021491bc7-6a30d918c60mr2022322eaf.66.1782956876165; 
 Wed, 01 Jul 2026 18:47:56 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:47:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Lucas Dietrich <ld.adecy@gmail.com>
Subject: [PATCH 6/9] lib: ecdsa: support additional curve sizes
Date: Wed,  1 Jul 2026 19:46:56 -0600
Message-ID: <20260702014724.1534351-6-james.hilliard1@gmail.com>
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

U-Boot's ECDSA FIT code is tied closely to prime256v1 and secp384r1.
Hardware verifiers may support a wider set of curves, and FIT public key
properties need to preserve the fixed coordinate width of those curves.

Add common curve-size handling for secp224r1, prime256v1, secp384r1 and
secp521r1. Use fixed-width big-endian byte arrays when writing libcrypto
BIGNUM values into the control FDT so non-32-bit-aligned coordinates such
as secp521r1 are encoded correctly.

Register the corresponding host and target ECDSA algorithm names and clean
up the libcrypto signing context so raw signatures are owned and freed
consistently on error paths.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 doc/mkimage.1                  |   3 +
 doc/usage/fit/signature.rst    |   3 +-
 include/u-boot/ecdsa.h         |  16 ++++
 include/u-boot/fdt-libcrypto.h |   6 +-
 lib/ecdsa/Kconfig              |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c    | 141 +++++++++++++++++++++------------
 lib/ecdsa/ecdsa-verify.c       |  39 +++++----
 lib/fdt-libcrypto.c            |  59 +++-----------
 tools/image-sig-host.c         |   7 ++
 9 files changed, 152 insertions(+), 124 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 9a2d07cee75..b6ba88dd314 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -459,7 +459,10 @@ lb.
 rsa2048
 rsa3072
 rsa4096
+ecdsa224
 ecdsa256
+ecdsa384
+secp521r1
 .TE
 .RE
 .
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..4f35f44bc8a 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -132,7 +132,8 @@ rsa,n0-inverse
 For ECDSA the following are mandatory:
 
 ecdsa,curve
-    Name of ECDSA curve (e.g. "prime256v1")
+    Name of ECDSA curve, such as "secp224r1", "prime256v1",
+    "secp384r1", or "secp521r1"
 
 ecdsa,x-point
     Public key X coordinate as a big-endian multi-word integer
diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index f0ac0f327e9..e8b01cd0258 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include <image.h>
+#include <string.h>
 
 /**
  * crypto_algo API impementation for ECDSA;
@@ -64,8 +65,23 @@ int ecdsa_verify(struct image_sign_info *info,
 		 uint8_t *sig, uint sig_len);
 /** @} */
 
+#define ECDSA224_BYTES	(224 / 8)
 #define ECDSA256_BYTES	(256 / 8)
 #define ECDSA384_BYTES	(384 / 8)
 #define ECDSA521_BYTES	((521 + 7) / 8)
 
+static inline unsigned int ecdsa_curve_size(const char *curve_name)
+{
+	if (!strcmp(curve_name, "secp224r1"))
+		return 224;
+	else if (!strcmp(curve_name, "prime256v1"))
+		return 256;
+	else if (!strcmp(curve_name, "secp384r1"))
+		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
+
+	return 0;
+}
+
 #endif
diff --git a/include/u-boot/fdt-libcrypto.h b/include/u-boot/fdt-libcrypto.h
index b15d8a1eaf4..d2d539f9997 100644
--- a/include/u-boot/fdt-libcrypto.h
+++ b/include/u-boot/fdt-libcrypto.h
@@ -12,16 +12,16 @@
 /**
  * fdt_add_bignum() - Write a libcrypto BIGNUM as an FDT property
  *
- * Convert a libcrypto BIGNUM * into a big endian array of integers.
+ * Convert a libcrypto BIGNUM * into a fixed-width big endian byte array.
  *
  * @blob:	FDT blob to modify
  * @noffset:	Offset of the FDT node
  * @prop_name:	What to call the property in the FDT
  * @num:	pointer to a libcrypto big number
  * @num_bits:	How big is 'num' in bits?
- * Return: 0 if all good all working, -ve on horror
+ * Return: 0 on success, negative libfdt or errno-style error on failure
  */
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits);
+		   const BIGNUM *num, int num_bits);
 
 #endif /* _FDT_LIBCRYPTO_H */
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index ca13b6bfa1f..f0c56278fb6 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -17,7 +17,7 @@ config ECDSA_VERIFY
 
 config SPL_ECDSA_VERIFY
 	bool "Enable ECDSA verification support in SPL"
-	depends on SPL
+	depends on SPL && SPL_DM
 	help
 	  Allow ECDSA signatures to be recognized and verified in SPL.
 
diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..378d53ea242 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -31,7 +31,7 @@ struct signer {
 	EVP_PKEY *evp_key;	/* Pointer to EVP_PKEY object */
 	EC_KEY *ecdsa_key;	/* Pointer to EC_KEY object */
 	void *hash;		/* Pointer to hash used for verification */
-	void *signature;	/* Pointer to output signature. Do not free()!*/
+	void *signature;	/* Pointer to raw signature buffer */
 };
 
 struct ecdsa_public_key {
@@ -50,11 +50,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->curve_name)
 		return -ENOMSG;
 
-	if (!strcmp(key->curve_name, "prime256v1"))
-		key->size_bits = 256;
-	else if (!strcmp(key->curve_name, "secp384r1"))
-		key->size_bits = 384;
-	else
+	key->size_bits = ecdsa_curve_size(key->curve_name);
+	if (!key->size_bits)
 		return -EINVAL;
 
 	key->x = fdt_getprop(fdt, node, "ecdsa,x-point", &x_len);
@@ -63,7 +60,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	if (x_len != (key->size_bits + 7) / 8 ||
+	    y_len != (key->size_bits + 7) / 8)
 		return -EINVAL;
 
 	return 0;
@@ -85,18 +83,12 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return ret;
 	}
 
-	if (!strcmp(pubkey.curve_name, "prime256v1")) {
-		nid = NID_X9_62_prime256v1;
-	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
-		nid = NID_secp384r1;
-	} else {
+	nid = OBJ_sn2nid(pubkey.curve_name);
+	if (nid == NID_undef) {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
 		return -EINVAL;
 	}
 
-	fprintf(stderr, "Loading ECDSA key: curve=%s, bits=%d\n", pubkey.curve_name,
-		pubkey.size_bits);
-
 	ec_key = EC_KEY_new_by_curve_name(nid);
 	if (!ec_key) {
 		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
@@ -111,7 +103,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = (pubkey.size_bits + 7) / 8;
 
 	uint8_t buf[1 + len * 2];
 
@@ -133,14 +125,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return -EINVAL;
 	}
 
-	fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n", node);
 	EC_POINT_free(point);
 	ctx->ecdsa_key = ec_key;
 
 	return 0;
 }
 
-static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
+static int init_ctx(struct signer *ctx)
 {
 	memset(ctx, 0, sizeof(*ctx));
 
@@ -149,11 +140,21 @@ static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -1;
 	}
 
+	return 0;
+}
+
+static int alloc_sig_ctx(struct signer *ctx, const struct image_sign_info *info)
+{
 	ctx->hash = malloc(info->checksum->checksum_len);
 	ctx->signature = malloc(info->crypto->key_len * 2);
 
-	if (!ctx->hash || !ctx->signature)
+	if (!ctx->hash || !ctx->signature) {
+		free(ctx->hash);
+		free(ctx->signature);
+		ctx->hash = NULL;
+		ctx->signature = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -166,8 +167,8 @@ static void free_ctx(struct signer *ctx)
 	if (ctx->evp_key)
 		EVP_PKEY_free(ctx->evp_key);
 
-	if (ctx->hash)
-		free(ctx->hash);
+	free(ctx->hash);
+	free(ctx->signature);
 }
 
 /*
@@ -203,7 +204,12 @@ static ECDSA_SIG *ecdsa_sig_from_raw(void *buf, size_t order)
 	s_buf = (uintptr_t)buf + point_bytes;
 	r = BN_bin2bn(buf, point_bytes, NULL);
 	s = BN_bin2bn((void *)s_buf, point_bytes, NULL);
-	ECDSA_SIG_set0(sig, r, s);
+	if (!r || !s || !ECDSA_SIG_set0(sig, r, s)) {
+		BN_free(r);
+		BN_free(s);
+		ECDSA_SIG_free(sig);
+		return NULL;
+	}
 
 	return sig;
 }
@@ -271,10 +277,6 @@ static int load_key_from_fdt(struct signer *ctx, const struct image_sign_info *i
 	if (!fdt)
 		return -EINVAL;
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	sig_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (sig_node < 0) {
 		fprintf(stderr, "No /signature node found\n");
@@ -331,7 +333,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	int key_len_bytes, ret;
 	char kname[1024];
 
-	memset(ctx, 0, sizeof(*ctx));
+	ret = init_ctx(ctx);
+	if (ret)
+		return ret;
 
 	if (info->fdt_blob) {
 		return load_key_from_fdt(ctx, info);
@@ -345,10 +349,6 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -EINVAL;
 	}
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	ret = read_key(ctx, kname);
 	if (ret)
 		return ret;
@@ -368,11 +368,18 @@ static int do_sign(struct signer *ctx, struct image_sign_info *info,
 {
 	const struct checksum_algo *algo = info->checksum;
 	ECDSA_SIG *sig;
+	int ret;
+
+	ret = algo->calculate(algo->name, region, region_count, ctx->hash);
+	if (ret)
+		return ret;
 
-	algo->calculate(algo->name, region, region_count, ctx->hash);
 	sig = ECDSA_do_sign(ctx->hash, algo->checksum_len, ctx->ecdsa_key);
+	if (!sig)
+		return -EIO;
 
 	ecdsa_sig_encode_raw(ctx->signature, sig, info->crypto->key_len);
+	ECDSA_SIG_free(sig);
 
 	return 0;
 }
@@ -389,10 +396,16 @@ static int ecdsa_check_signature(struct signer *ctx, struct image_sign_info *inf
 	okay = ECDSA_do_verify(ctx->hash, info->checksum->checksum_len,
 			       sig, ctx->ecdsa_key);
 	if (!okay)
-		fprintf(stderr, "WARNING: Signature is fake news!\n");
+		fprintf(stderr, "WARNING: ECDSA signature verification failed\n");
+	else if (okay < 0)
+		fprintf(stderr, "ERROR: ECDSA signature verification failed\n");
 
 	ECDSA_SIG_free(sig);
-	return !okay;
+
+	if (okay == 1)
+		return 0;
+
+	return okay < 0 ? -EIO : -EPERM;
 }
 
 static int do_verify(struct signer *ctx, struct image_sign_info *info,
@@ -400,6 +413,7 @@ static int do_verify(struct signer *ctx, struct image_sign_info *info,
 		     uint8_t *raw_sig, uint sig_len)
 {
 	const struct checksum_algo *algo = info->checksum;
+	int ret;
 
 	if (sig_len != info->crypto->key_len * 2) {
 		fprintf(stderr, "Signature has wrong length\n");
@@ -407,7 +421,9 @@ static int do_verify(struct signer *ctx, struct image_sign_info *info,
 	}
 
 	memcpy(ctx->signature, raw_sig, sig_len);
-	algo->calculate(algo->name, region, region_count, ctx->hash);
+	ret = algo->calculate(algo->name, region, region_count, ctx->hash);
+	if (ret)
+		return ret;
 
 	return ecdsa_check_signature(ctx, info);
 }
@@ -420,11 +436,16 @@ int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
 
 	ret = prepare_ctx(&ctx, info);
 	if (ret >= 0) {
-		do_sign(&ctx, info, region, region_count);
-		*sigp = ctx.signature;
-		*sig_len = info->crypto->key_len * 2;
-
-		ret = ecdsa_check_signature(&ctx, info);
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_sign(&ctx, info, region, region_count);
+		if (!ret)
+			ret = ecdsa_check_signature(&ctx, info);
+		if (!ret) {
+			*sigp = ctx.signature;
+			*sig_len = info->crypto->key_len * 2;
+			ctx.signature = NULL;
+		}
 	}
 
 	free_ctx(&ctx);
@@ -439,8 +460,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	int ret;
 
 	ret = prepare_ctx(&ctx, info);
-	if (ret >= 0)
-		ret = do_verify(&ctx, info, region, region_count, sig, sig_len);
+	if (ret >= 0) {
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_verify(&ctx, info, region, region_count,
+					sig, sig_len);
+	}
 
 	free_ctx(&ctx);
 	return ret;
@@ -453,7 +478,7 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	const char *curve_name;
 	const EC_GROUP *group;
 	const EC_POINT *point;
-	BIGNUM *x, *y;
+	BIGNUM *x = NULL, *y = NULL;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (signature_node == -FDT_ERR_NOTFOUND) {
@@ -491,42 +516,54 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
-	/* Let 'x' and 'y' memory leak by not BN_free()'ing them. */
 	x = BN_new();
 	y = BN_new();
+	if (!x || !y) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	point = EC_KEY_get0_public_key(ctx->ecdsa_key);
-	EC_POINT_get_affine_coordinates(group, point, x, y, NULL);
+	if (!EC_POINT_get_affine_coordinates(group, point, x, y, NULL)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_KEY_HINT,
 				 info->keyname);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, "ecdsa,curve", curve_name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,x-point", x, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,y-point", y, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_ALGO_PROP,
 				 info->name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	if (info->require_keys) {
 		ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
 					 info->require_keys);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
-	return key_node;
+	ret = key_node;
+
+out:
+	BN_free(x);
+	BN_free(y);
+	return ret;
 }
 
 int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..8570d35028f 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -12,22 +12,6 @@
 #include <dm/uclass.h>
 #include <u-boot/ecdsa.h>
 
-/*
- * Derive size of an ECDSA key from the curve name
- *
- * While it's possible to extract the key size by using string manipulation,
- * use a list of known curves for the time being.
- */
-static int ecdsa_key_size(const char *curve_name)
-{
-	if (!strcmp(curve_name, "prime256v1"))
-		return 256;
-	else if (!strcmp(curve_name, "secp384r1"))
-		return 384;
-
-	return 0;
-}
-
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
 	int x_len, y_len;
@@ -38,9 +22,9 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		return -ENOMSG;
 	}
 
-	key->size_bits = ecdsa_key_size(key->curve_name);
+	key->size_bits = ecdsa_curve_size(key->curve_name);
 	if (key->size_bits == 0) {
-		debug("Unknown ECDSA curve '%s'", key->curve_name);
+		debug("Unknown ECDSA curve '%s'\n", key->curve_name);
 		return -EINVAL;
 	}
 
@@ -50,9 +34,10 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
-		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
-		       node, key->curve_name, key->x, x_len, key->y, y_len);
+	if (x_len != (key->size_bits + 7) / 8 ||
+	    y_len != (key->size_bits + 7) / 8) {
+		debug("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
+		      node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
 	}
 
@@ -123,6 +108,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ecdsa_verify_hash(dev, info, hash, sig, sig_len);
 }
 
+U_BOOT_CRYPTO_ALGO(ecdsa224) = {
+	.name = "ecdsa224",
+	.key_len = ECDSA224_BYTES,
+	.verify = ecdsa_verify,
+};
+
 U_BOOT_CRYPTO_ALGO(ecdsa256) = {
 	.name = "ecdsa256",
 	.key_len = ECDSA256_BYTES,
@@ -135,6 +126,12 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(secp521r1) = {
+	.name = "secp521r1",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index ecb0344c8f6..aec516cf15b 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -5,68 +5,35 @@
  */
 
 #include <libfdt.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <u-boot/fdt-libcrypto.h>
 
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits)
+		   const BIGNUM *num, int num_bits)
 {
-	int nwords = num_bits / 32;
-	int size;
-	uint32_t *buf, *ptr;
-	BIGNUM *tmp, *big2, *big32, *big2_32;
-	BN_CTX *ctx;
+	int size = (num_bits + 7) / 8;
+	unsigned char *buf;
 	int ret;
 
-	tmp = BN_new();
-	big2 = BN_new();
-	big32 = BN_new();
-	big2_32 = BN_new();
+	if (size <= 0)
+		return -EINVAL;
 
-	/*
-	 * Note: This code assumes that all of the above succeed, or all fail.
-	 * In practice memory allocations generally do not fail (unless the
-	 * process is killed), so it does not seem worth handling each of these
-	 * as a separate case. Technicaly this could leak memory on failure,
-	 * but a) it won't happen in practice, and b) it doesn't matter as we
-	 * will immediately exit with a failure code.
-	 */
-	if (!tmp || !big2 || !big32 || !big2_32) {
-		fprintf(stderr, "Out of memory (bignum)\n");
-		return -ENOMEM;
-	}
-	ctx = BN_CTX_new();
-	if (!ctx) {
-		fprintf(stderr, "Out of memory (bignum context)\n");
-		return -ENOMEM;
-	}
-	BN_set_word(big2, 2L);
-	BN_set_word(big32, 32L);
-	BN_exp(big2_32, big2, big32, ctx); /* B = 2^32 */
-
-	size = nwords * sizeof(uint32_t);
 	buf = malloc(size);
 	if (!buf) {
 		fprintf(stderr, "Out of memory (%d bytes)\n", size);
 		return -ENOMEM;
 	}
 
-	/* Write out modulus as big endian array of integers */
-	for (ptr = buf + nwords - 1; ptr >= buf; ptr--) {
-		BN_mod(tmp, num, big2_32, ctx); /* n = N mod B */
-		*ptr = cpu_to_fdt32(BN_get_word(tmp));
-		BN_rshift(num, num, 32); /*  N = N/B */
+	if (BN_bn2binpad(num, buf, size) != size) {
+		free(buf);
+		return -EINVAL;
 	}
 
-	/*
-	 * We try signing with successively increasing size values, so this
-	 * might fail several times
-	 */
+	/* Callers may retry with a larger FDT if the property does not fit. */
 	ret = fdt_setprop(blob, noffset, prop_name, buf, size);
 	free(buf);
-	BN_free(tmp);
-	BN_free(big2);
-	BN_free(big32);
-	BN_free(big2_32);
 
-	return ret ? -FDT_ERR_NOSPACE : 0;
+	return ret;
 }
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..aeca83bd440 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -69,6 +69,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = rsa_add_verify_data,
 		.verify = rsa_verify,
 	},
+	{
+		.name = "ecdsa224",
+		.key_len = ECDSA224_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 	{
 		.name = "ecdsa256",
 		.key_len = ECDSA256_BYTES,
-- 
2.53.0

