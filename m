Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F7AC04FF6
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE178842E;
	Tue, 16 Apr 2024 21:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VIYO45yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0558C8843A; Tue, 16 Apr 2024 21:02:24 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8842688466
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b5de48126so12301326d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294128; x=1713898928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D91O7QOFKb/d7WrVd79JGmD3NySXM5oey4J4BCXMsMo=;
 b=VIYO45yb5Ctjry2KDTtrEtOrKGsrO8JBEtXT/1q/feBihXW0NSo545ZDbdhJzJwqxK
 nudwdxaV3IUM5Ar9BP1CulPj+KskYGfGvfufdZgskS0Iwg2LRcGh8Hf85s61BPfGaof4
 C6HZDJ8iCkaB6DejotB+XxoAGh5rSHOrj3ufFxA1Rzn/bY2bAA6Phc59dm2KqIQsjJpW
 fvsrZt6w9VIC9hP8bQdscwR5rDCURPsl/Z5arnL9f87LXapAcdrxcNWunhe7B9UC8jDS
 sp8pqO1wSt3d/KcC3iu7YGiki17tqgFapnjKX7A1Ikg9t7mzhoyjez3xKapU0bdODw0R
 xPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294128; x=1713898928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D91O7QOFKb/d7WrVd79JGmD3NySXM5oey4J4BCXMsMo=;
 b=Y7oYytq83rLlFDtsXdqXAj8VKr9WBiFKeukc18WUd8ZYpcdISr/IgYdFibp0KFH7Ak
 W56qA5qQVsGesY07Zcn3ByNgePJeJwZT7gt5wDUn5RgKfrPDVZgwM00i6H6z2nMNgsqU
 G6GgOJDsG2SjyC5OjkbN4itsyoTapFrWfbORWLaAL3XxNuRjb2SmdCLe4bAgVd4hovrw
 vkUWlWlKd5GFAqvOvbVlnrtLm+fD9CO2M6ystK0/H4k4CC+Ur2cF75To3lcajxv2zpxN
 Qs8Dfwo4aHF0FzsQbXRH0Ppbc34gLQc5ATd3lnr3WyBz9kcoe1UJvmG49h/dtPN2V0dR
 KLwg==
X-Gm-Message-State: AOJu0YwzIpJnc9XX/SrTlKIRUAAmi5IAgxBmrU7R7k4P28IFKY6xCFBb
 S0Mpl/+iiWOyIgcOSS8YqWBAS7YpSLw1ubZVJJuFfgCK34y5dprqHVcJ9FMTxM3SZ9tkpDji5SF
 o
X-Google-Smtp-Source: AGHT+IHAEcuEg8//TT4+XLKcXKGvEDjQ7cKm9Sa+MpiRuxQBwxIpg6rsbzLFSusN9XYaDU6JqgMfnQ==
X-Received: by 2002:a05:6214:1746:b0:69b:674a:5b41 with SMTP id
 dc6-20020a056214174600b0069b674a5b41mr10201608qvb.52.1713294127987; 
 Tue, 16 Apr 2024 12:02:07 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:07 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 18/23] lib/crypto: Port x509_cert_parser on MbedTLS
Date: Tue, 16 Apr 2024 12:00:14 -0700
Message-Id: <20240416190019.81016-19-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Integrate x509_cert_parser on top of MbedTLS x509 library.
Add API x509_populate_cert and x509_populate_pubkey for code
reusability between x509 and pkcs7 parsers.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/crypto/x509_parser.h  |  34 +++
 lib/crypto/x509_cert_parser.c | 430 ++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+)

diff --git a/include/crypto/x509_parser.h b/include/crypto/x509_parser.h
index 4cbdc1d661..6048e2fa4f 100644
--- a/include/crypto/x509_parser.h
+++ b/include/crypto/x509_parser.h
@@ -11,8 +11,36 @@
 #include <linux/time.h>
 #include <crypto/public_key.h>
 #include <keys/asymmetric-type.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <image.h>
+#include <external/mbedtls/include/mbedtls/error.h>
+#include <external/mbedtls/include/mbedtls/asn1.h>
+#endif
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+/* Backup of part of the parsing context */
+struct x509_cert_mbedtls_ctx {
+	void	*tbs;			/* Signed data */
+	void	*raw_serial;		/* Raw serial number in ASN.1 */
+	void	*raw_issuer;		/* Raw issuer name in ASN.1 */
+	void	*raw_subject;		/* Raw subject name in ASN.1 */
+	void	*raw_skid;		/* Raw subjectKeyId in ASN.1 */
+};
+#endif
+
+/*
+ * MbedTLS integration Notes:
+ *
+ * Fields we don't need to populate from MbedTLS:
+ * 'raw_sig' and 'raw_sig_size' are buffer for x509_parse_context,
+ * not needed for MbedTLS.
+ * 'signer' and 'seen' are used internally by pkcs7_verify.
+ * 'verified' is not inuse.
+ */
 struct x509_certificate {
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+	struct x509_cert_mbedtls_ctx *mbedtls_ctx;
+#endif
 	struct x509_certificate *next;
 	struct x509_certificate *signer;	/* Certificate that signed this one */
 	struct public_key *pub;			/* Public key details */
@@ -48,6 +76,12 @@ struct x509_certificate {
  * x509_cert_parser.c
  */
 extern void x509_free_certificate(struct x509_certificate *cert);
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+int x509_populate_pubkey(mbedtls_x509_crt *cert, struct public_key **pub_key);
+int x509_populate_cert(mbedtls_x509_crt *mbedtls_cert,
+		       struct x509_certificate **pcert);
+time64_t x509_get_timestamp(const mbedtls_x509_time *x509_time);
+#endif
 extern struct x509_certificate *x509_cert_parse(const void *data, size_t datalen);
 extern int x509_decode_time(time64_t *_t,  size_t hdrlen,
 			    unsigned char tag,
diff --git a/lib/crypto/x509_cert_parser.c b/lib/crypto/x509_cert_parser.c
index a0f0689118..4c5b802afa 100644
--- a/lib/crypto/x509_cert_parser.c
+++ b/lib/crypto/x509_cert_parser.c
@@ -25,8 +25,10 @@
 #else
 #include "x509_parser.h"
 #endif
+#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 #include "x509.asn1.h"
 #include "x509_akid.asn1.h"
+#endif
 
 struct x509_parse_context {
 	struct x509_certificate	*cert;		/* Certificate being constructed */
@@ -52,6 +54,270 @@ struct x509_parse_context {
 	unsigned	akid_raw_issuer_size;
 };
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+
+static void x509_free_mbedtls_ctx(struct x509_cert_mbedtls_ctx *ctx)
+{
+	if (ctx) {
+		kfree(ctx->tbs);
+		kfree(ctx->raw_serial);
+		kfree(ctx->raw_issuer);
+		kfree(ctx->raw_subject);
+		kfree(ctx->raw_skid);
+		kfree(ctx);
+	}
+}
+
+static int x509_set_cert_flags(struct x509_certificate *cert)
+{
+	struct public_key_signature *sig = cert->sig;
+
+	if (!sig || !cert->pub) {
+		pr_err("Signature or public key is not initialized\n");
+		return -ENOPKG;
+	}
+
+	if (!cert->pub->pkey_algo)
+		cert->unsupported_key = true;
+
+	if (!sig->pkey_algo)
+		cert->unsupported_sig = true;
+
+	if (!sig->hash_algo)
+		cert->unsupported_sig = true;
+
+	/* TODO: is_hash_blacklisted()? */
+
+	/* Detect self-signed certificates and set self_signed flag */
+	return x509_check_for_self_signed(cert);
+}
+
+time64_t x509_get_timestamp(const mbedtls_x509_time *x509_time)
+{
+	unsigned int year, mon, day, hour, min, sec;
+
+	/* Adjust for year since 1900 */
+	year = x509_time->year - 1900;
+	/* Adjust for 0-based month */
+	mon = x509_time->mon - 1;
+	day = x509_time->day;
+	hour = x509_time->hour;
+	min = x509_time->min;
+	sec = x509_time->sec;
+
+	return (time64_t)mktime64(year, mon, day, hour, min, sec);
+}
+
+static char *x509_populate_dn_name_string(const mbedtls_x509_name *name)
+{
+	size_t len = 256;
+	size_t wb;
+	char *name_str;
+
+	do {
+		name_str = kzalloc(len, GFP_KERNEL);
+		if (!name_str)
+			return NULL;
+
+		wb = mbedtls_x509_dn_gets(name_str, len, name);
+		if (wb < 0) {
+			pr_err("Get DN string failed, ret:-0x%04x\n",
+			       (unsigned int)-wb);
+			kfree(name_str);
+			len = len * 2; /* Try with a bigger buffer */
+		}
+	} while (wb < 0);
+
+	name_str[wb] = '\0'; /* add the terminator */
+
+	return name_str;
+}
+
+static int x509_populate_signature_params(const mbedtls_x509_crt *cert,
+					  struct public_key_signature **sig)
+{
+	struct public_key_signature *s;
+	struct image_region region;
+	size_t akid_len;
+	unsigned char *akid_data;
+	int ret;
+
+	/* Check if signed data exist */
+	if (!cert->tbs.p || !cert->tbs.len)
+		return -EINVAL;
+
+	region.data = cert->tbs.p;
+	region.size = cert->tbs.len;
+
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	/*
+	 * Get the public key algorithm.
+	 * Note: ECRDSA (Elliptic Curve RedDSA) from Red Hat is not supported by
+	 *	 MbedTLS.
+	 */
+	switch (cert->sig_pk) {
+	case MBEDTLS_PK_RSA:
+		s->pkey_algo = "rsa";
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_sig;
+	}
+
+	/* Get the hash algorithm */
+	switch (cert->sig_md) {
+	case MBEDTLS_MD_SHA1:
+		s->hash_algo = "sha1";
+		s->digest_size = SHA1_SUM_LEN;
+		break;
+	case MBEDTLS_MD_SHA256:
+		s->hash_algo = "sha256";
+		s->digest_size = SHA256_SUM_LEN;
+		break;
+	case MBEDTLS_MD_SHA384:
+		s->hash_algo = "sha384";
+		s->digest_size = SHA384_SUM_LEN;
+		break;
+	case MBEDTLS_MD_SHA512:
+		s->hash_algo = "sha512";
+		s->digest_size = SHA512_SUM_LEN;
+		break;
+	/* Unsupported algo */
+	case MBEDTLS_MD_MD5:
+	case MBEDTLS_MD_SHA224:
+	default:
+		ret = -EINVAL;
+		goto error_sig;
+	}
+
+	/*
+	 * Optional attributes:
+	 * auth_ids holds AuthorityKeyIdentifier (information of issuer),
+	 * aka akid, which is used to match with a cert's id or skid to
+	 * indicate that is the issuer when we lookup a cert chain.
+	 *
+	 * auth_ids[0]:
+	 *	[PKCS#7 or CMS ver 1] - generated from "Issuer + Serial number"
+	 *	[CMS ver 3] - generated from skid (subjectKeyId)
+	 * auth_ids[1]: generated from skid (subjectKeyId)
+	 *
+	 * Assume that we are using PKCS#7 (msg->version=1),
+	 * not CMS ver 3 (msg->version=3).
+	 */
+	akid_len = cert->authority_key_id.authorityCertSerialNumber.len;
+	akid_data = cert->authority_key_id.authorityCertSerialNumber.p;
+
+	/* Check if serial number exists */
+	if (akid_len && akid_data) {
+		s->auth_ids[0] = asymmetric_key_generate_id(akid_data,
+							    akid_len,
+							    cert->issuer_raw.p,
+							    cert->issuer_raw.len);
+		if (!s->auth_ids[0]) {
+			ret = -ENOMEM;
+			goto error_sig;
+		}
+	}
+
+	akid_len = cert->authority_key_id.keyIdentifier.len;
+	akid_data = cert->authority_key_id.keyIdentifier.p;
+
+	/* Check if subjectKeyId exists */
+	if (akid_len && akid_data) {
+		s->auth_ids[1] = asymmetric_key_generate_id(akid_data,
+							    akid_len,
+							    "", 0);
+		if (!s->auth_ids[1]) {
+			ret = -ENOMEM;
+			goto error_sig;
+		}
+	}
+
+	/*
+	 * Encoding can be pkcs1 or raw, but only pkcs1 is supported.
+	 * Set the encoding explicitly to pkcs1.
+	 */
+	s->encoding = "pkcs1";
+
+	/* Copy the signature data */
+	s->s = kmemdup(cert->sig.p, cert->sig.len, GFP_KERNEL);
+	if (!s->s) {
+		ret = -ENOMEM;
+		goto error_sig;
+	}
+	s->s_size = cert->sig.len;
+
+	/* Calculate the digest of signed data (tbs) */
+	s->digest = kzalloc(s->digest_size, GFP_KERNEL);
+	if (!s->digest) {
+		ret = -ENOMEM;
+		goto error_sig;
+	}
+
+	ret = hash_calculate(s->hash_algo, &region, 1, s->digest);
+	if (!ret)
+		*sig = s;
+
+	return ret;
+
+error_sig:
+	public_key_signature_free(s);
+	return ret;
+}
+
+static int x509_save_mbedtls_ctx(const mbedtls_x509_crt *cert,
+				 struct x509_cert_mbedtls_ctx **pctx)
+{
+	struct x509_cert_mbedtls_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	/* Signed data (tbs - The part that is To Be Signed)*/
+	ctx->tbs = kmemdup(cert->tbs.p, cert->tbs.len,
+			   GFP_KERNEL);
+	if (!ctx->tbs)
+		goto error_ctx;
+
+	/* Raw serial number */
+	ctx->raw_serial = kmemdup(cert->serial.p,
+				  cert->serial.len, GFP_KERNEL);
+	if (!ctx->raw_serial)
+		goto error_ctx;
+
+	/* Raw issuer */
+	ctx->raw_issuer = kmemdup(cert->issuer_raw.p,
+				  cert->issuer_raw.len, GFP_KERNEL);
+	if (!ctx->raw_issuer)
+		goto error_ctx;
+
+	/* Raw subject */
+	ctx->raw_subject = kmemdup(cert->subject_raw.p,
+				   cert->subject_raw.len, GFP_KERNEL);
+	if (!ctx->raw_subject)
+		goto error_ctx;
+
+	/* Raw subjectKeyId */
+	ctx->raw_skid = kmemdup(cert->subject_key_id.p,
+				cert->subject_key_id.len, GFP_KERNEL);
+	if (!ctx->raw_skid)
+		goto error_ctx;
+
+	*pctx = ctx;
+
+	return 0;
+
+error_ctx:
+	x509_free_mbedtls_ctx(ctx);
+	return -ENOMEM;
+}
+
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
+
 /*
  * Free an X.509 certificate
  */
@@ -64,11 +330,174 @@ void x509_free_certificate(struct x509_certificate *cert)
 		kfree(cert->subject);
 		kfree(cert->id);
 		kfree(cert->skid);
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+		x509_free_mbedtls_ctx(cert->mbedtls_ctx);
+#endif
 		kfree(cert);
 	}
 }
 EXPORT_SYMBOL_GPL(x509_free_certificate);
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+int x509_populate_pubkey(mbedtls_x509_crt *cert, struct public_key **pub_key)
+{
+	struct public_key *pk;
+
+	pk = kzalloc(sizeof(*pk), GFP_KERNEL);
+	if (!pk)
+		return -ENOMEM;
+
+	pk->key = kzalloc(cert->pk_raw.len, GFP_KERNEL);
+	if (!pk->key) {
+		kfree(pk);
+		return -ENOMEM;
+	}
+	memcpy(pk->key, cert->pk_raw.p, cert->pk_raw.len);
+	pk->keylen = cert->pk_raw.len;
+
+	/*
+	 * For ECC keys, params field might include information about the curve used,
+	 * the generator point, or other algorithm-specific parameters.
+	 * For RSA keys, it's common for the params field to be NULL.
+	 * FIXME: Assume that we just support RSA keys with id_type X509.
+	 */
+	pk->params = NULL;
+	pk->paramlen = 0;
+
+	pk->key_is_private = false;
+	pk->id_type = "X509";
+	pk->pkey_algo = "rsa";
+	pk->algo = OID_rsaEncryption;
+
+	*pub_key = pk;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(x509_populate_pubkey);
+
+int x509_populate_cert(mbedtls_x509_crt *mbedtls_cert,
+		       struct x509_certificate **pcert)
+{
+	struct x509_certificate *cert;
+	struct asymmetric_key_id *kid;
+	struct asymmetric_key_id *skid;
+	int ret;
+
+	cert = kzalloc(sizeof(*cert), GFP_KERNEL);
+	if (!cert)
+		return -ENOMEM;
+
+	/* Public key details */
+	ret = x509_populate_pubkey(mbedtls_cert, &cert->pub);
+	if (ret)
+		goto error_cert_pop;
+
+	/* Signature parameters */
+	ret = x509_populate_signature_params(mbedtls_cert, &cert->sig);
+	if (ret)
+		goto error_cert_pop;
+
+	ret = -ENOMEM;
+
+	/* Name of certificate issuer */
+	cert->issuer = x509_populate_dn_name_string(&mbedtls_cert->issuer);
+	if (!cert->issuer)
+		goto error_cert_pop;
+
+	/* Name of certificate subject */
+	cert->subject = x509_populate_dn_name_string(&mbedtls_cert->subject);
+	if (!cert->subject)
+		goto error_cert_pop;
+
+	/* Certificate validity */
+	cert->valid_from = x509_get_timestamp(&mbedtls_cert->valid_from);
+	cert->valid_to = x509_get_timestamp(&mbedtls_cert->valid_to);
+
+	/* Save mbedtls context we need */
+	ret = x509_save_mbedtls_ctx(mbedtls_cert, &cert->mbedtls_ctx);
+	if (ret)
+		goto error_cert_pop;
+
+	/* Signed data (tbs - The part that is To Be Signed)*/
+	cert->tbs = cert->mbedtls_ctx->tbs;
+	cert->tbs_size = mbedtls_cert->tbs.len;
+
+	/* Raw serial number */
+	cert->raw_serial = cert->mbedtls_ctx->raw_serial;
+	cert->raw_serial_size = mbedtls_cert->serial.len;
+
+	/* Raw issuer */
+	cert->raw_issuer = cert->mbedtls_ctx->raw_issuer;
+	cert->raw_issuer_size = mbedtls_cert->issuer_raw.len;
+
+	/* Raw subject */
+	cert->raw_subject = cert->mbedtls_ctx->raw_subject;
+	cert->raw_subject_size = mbedtls_cert->subject_raw.len;
+
+	/* Raw subjectKeyId */
+	cert->raw_skid = cert->mbedtls_ctx->raw_skid;
+	cert->raw_skid_size = mbedtls_cert->subject_key_id.len;
+
+	/* Generate cert issuer + serial number key ID */
+	kid = asymmetric_key_generate_id(cert->raw_serial,
+					 cert->raw_serial_size,
+					 cert->raw_issuer,
+					 cert->raw_issuer_size);
+	if (IS_ERR(kid)) {
+		ret = PTR_ERR(kid);
+		goto error_cert_pop;
+	}
+	cert->id = kid;
+
+	/* Generate subject + subjectKeyId */
+	skid = asymmetric_key_generate_id(cert->raw_skid, cert->raw_skid_size, "", 0);
+	if (IS_ERR(skid)) {
+		ret = PTR_ERR(skid);
+		goto error_cert_pop;
+	}
+	cert->skid = skid;
+
+	/*
+	 * Set the certificate flags:
+	 * self_signed, unsupported_key, unsupported_sig, blacklisted
+	 */
+	ret = x509_set_cert_flags(cert);
+	if (!ret) {
+		*pcert = cert;
+		return 0;
+	}
+
+error_cert_pop:
+	x509_free_certificate(cert);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(x509_populate_cert);
+
+struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
+{
+	mbedtls_x509_crt mbedtls_cert;
+	struct x509_certificate *cert = NULL;
+	long ret;
+
+	/* Parse DER encoded certificate */
+	mbedtls_x509_crt_init(&mbedtls_cert);
+	ret = mbedtls_x509_crt_parse_der(&mbedtls_cert, data, datalen);
+	if (ret)
+		goto clean_up_ctx;
+
+	/* Populate x509_certificate from mbedtls_x509_crt */
+	ret = x509_populate_cert(&mbedtls_cert, &cert);
+	if (ret)
+		goto clean_up_ctx;
+
+clean_up_ctx:
+	mbedtls_x509_crt_free(&mbedtls_cert);
+	if (!ret)
+		return cert;
+
+	return ERR_PTR(ret);
+}
+#else	/* !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 /*
  * Parse an X.509 certificate
  */
@@ -700,3 +1129,4 @@ int x509_akid_note_serial(void *context, size_t hdrlen,
 	ctx->cert->sig->auth_ids[0] = kid;
 	return 0;
 }
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
-- 
2.25.1

