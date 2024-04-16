Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF19C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A59E8843F;
	Tue, 16 Apr 2024 21:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nNN/Mtyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED55E88414; Tue, 16 Apr 2024 21:02:23 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 063C688449
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-69b44071a07so36665756d6.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294130; x=1713898930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oYVLoKeoiWaMBa5NOWYOva8HI4DRyY146SFcRbuG3g=;
 b=nNN/MtyfiGrHIw5jPtUCBD7LC9tre8BrZRHbbNU6eSyAI9VsANT2n1gU7ewBQvrZZm
 eA09QZYLek7CzuoKQ6l4vFLCVYSYgrgISYsI9m22yvZbX7CD2ZG1sPfAujjdXWA/RUvx
 vS7Pa/r6RsqLZokp59uU2TeExpdSp93A+xKDTqTOedTYxt2IGFL6BW81/iaNA7FQ3mQm
 xpKMYluy2xjsKRw864CS4A0MO6/UlClhqLljfV4wVoUiekbUHspCIeR09VI54PGGUHpv
 RVI1ZNo7RBnmDg+SKKBIJM6SLws9qQCWQNghwpDn2tSAhtj7AvkTdxW4cKGtcEak4hye
 Ja/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294130; x=1713898930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oYVLoKeoiWaMBa5NOWYOva8HI4DRyY146SFcRbuG3g=;
 b=gcRLe5jk5BIWKWaDCw+FO0JGxBV206ZrlSa6OUaBdrT4aQ8xD4ng3DRxvQ0ziGdIpQ
 Iyeq89cPllZfbAR2uW5mhB97U5N7w7YWsSonu619YOh3j9Sbyubipba7GkmeNzlqwQgG
 oOaLOUduSy8TGKLfJ4oIGewkn0JfIvEalsb9d+r0zjctXSADI0HDWiwKdf3X7NbI05BE
 nkFL5aV0Q1RQ6Z6kdv5VwljDX2scN231rX2NgQtvS46VSHUP/A4B/c385V1eUbBw0s/B
 9sRLU4qTPtoWvt/PIuEUOefy6tyMLB3HS/5Wx9mucvlKb9bg1VD+AROzQ4XekSf1DoB2
 52vg==
X-Gm-Message-State: AOJu0Yzwtf1WmAqpQZ9tJ1N8F/6LJiw5RGX1StwoONCX0mqxChMhma/U
 zb/KrqHVF37wt6x3AGTMsYXOdSKfFnETSlIbkdutI2sF2EMMKzNl58cW2EoM7HTDxgCajwcpZYO
 2
X-Google-Smtp-Source: AGHT+IHL5DTTjsQ+TnaYTJSI8TjsTJt1G99YgWUQugI5wBPDJWpQY3P0Zeo7kIY2fx1ssZFFt1Rdrw==
X-Received: by 2002:a0c:f846:0:b0:69b:ae3:ee1a with SMTP id
 g6-20020a0cf846000000b0069b0ae3ee1amr13936599qvo.65.1713294130291; 
 Tue, 16 Apr 2024 12:02:10 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:09 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 19/23] lib/crypto: port PKCS7 parser on MbedTLS
Date: Tue, 16 Apr 2024 12:00:15 -0700
Message-Id: <20240416190019.81016-20-raymond.mao@linaro.org>
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

Integrate PKCS7 parser on top of MbedTLS PKCS7 library.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/crypto/pkcs7_parser.h |  56 ++++
 lib/crypto/pkcs7_parser.c     | 482 ++++++++++++++++++++++++++++++++--
 2 files changed, 510 insertions(+), 28 deletions(-)

diff --git a/include/crypto/pkcs7_parser.h b/include/crypto/pkcs7_parser.h
index 2c45cce523..9f4549871f 100644
--- a/include/crypto/pkcs7_parser.h
+++ b/include/crypto/pkcs7_parser.h
@@ -11,6 +11,12 @@
 #include <linux/oid_registry.h>
 #include <crypto/pkcs7.h>
 #include <crypto/x509_parser.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <external/mbedtls/include/mbedtls/pkcs7.h>
+#include <external/mbedtls/library/x509_internal.h>
+#include <external/mbedtls/include/mbedtls/asn1.h>
+#include <external/mbedtls/include/mbedtls/oid.h>
+#endif
 #include <linux/printk.h>
 
 #define kenter(FMT, ...) \
@@ -18,7 +24,54 @@
 #define kleave(FMT, ...) \
 	pr_devel("<== %s()"FMT"\n", __func__, ##__VA_ARGS__)
 
+/* Backup the parsed MedTLS context that we need */
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+struct pkcs7_mbedtls_ctx {
+	void *content_data;
+};
+
+struct pkcs7_sinfo_mbedtls_ctx {
+	void *authattrs_data;
+	void *content_data_digest;
+};
+#endif
+
+/*
+ * MbedTLS integration Notes:
+ *
+ * MbedTLS PKCS#7 library does not originally support parsing MicroSoft
+ * Authentication Code which is used for verifying the PE image digest.
+ *
+ * 1.	Authenticated Attributes (authenticatedAttributes)
+ *	MbedTLS assumes unauthenticatedAttributes and authenticatedAttributes
+ *	fields not exist.
+ *	See MbedTLS function 'pkcs7_get_signer_info' for details.
+ *
+ * 2.	MicroSoft Authentication Code (mscode)
+ *	MbedTLS only supports Content Data type defined as 1.2.840.113549.1.7.1
+ *	(MBEDTLS_OID_PKCS7_DATA, aka OID_data).
+ *	1.3.6.1.4.1.311.2.1.4 (MicroSoft Authentication Code, aka
+ *	OID_msIndirectData) is not supported.
+ *	See MbedTLS function 'pkcs7_get_content_info_type' for details.
+ *
+ * But the EFI loader assumes that a PKCS#7 message with an EFI image always
+ * contains MicroSoft Authentication Code as Content Data (msg->data is NOT
+ * NULL), see function 'efi_signature_verify'.
+ *
+ * MbedTLS patch "0002-support-MicroSoft-authentication-code-in-PKCS7-lib.patch"
+ * is to support both above features by parsing the Content Data and
+ * Authenticate Attributes from a given PKCS#7 message.
+ *
+ * Other fields we don't need to populate from MbedTLS, which are used
+ * internally by pkcs7_verify:
+ * 'signer', 'unsupported_crypto', 'blacklisted'
+ * 'sig->digest' is used internally by pkcs7_digest to calculate the hash of
+ * Content Data or Authenticate Attributes.
+ */
 struct pkcs7_signed_info {
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+	struct pkcs7_sinfo_mbedtls_ctx *mbedtls_ctx;
+#endif
 	struct pkcs7_signed_info *next;
 	struct x509_certificate *signer; /* Signing certificate (in msg->certs) */
 	unsigned	index;
@@ -55,6 +108,9 @@ struct pkcs7_signed_info {
 };
 
 struct pkcs7_message {
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+	struct pkcs7_mbedtls_ctx *mbedtls_ctx;
+#endif
 	struct x509_certificate *certs;	/* Certificate list */
 	struct x509_certificate *crl;	/* Revocation list */
 	struct pkcs7_signed_info *signed_infos;
diff --git a/lib/crypto/pkcs7_parser.c b/lib/crypto/pkcs7_parser.c
index d5efa828d6..3c819d934e 100644
--- a/lib/crypto/pkcs7_parser.c
+++ b/lib/crypto/pkcs7_parser.c
@@ -27,7 +27,9 @@
 #else
 #include "pkcs7_parser.h"
 #endif
+#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 #include "pkcs7.asn1.h"
+#endif
 
 MODULE_DESCRIPTION("PKCS#7 parser");
 MODULE_AUTHOR("Red Hat, Inc.");
@@ -52,6 +54,352 @@ struct pkcs7_parse_context {
 	bool		expect_skid;
 };
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+
+static void pkcs7_free_mbedtls_ctx(struct pkcs7_mbedtls_ctx *ctx)
+{
+	if (ctx) {
+		kfree(ctx->content_data);
+		kfree(ctx);
+	}
+}
+
+static void pkcs7_free_sinfo_mbedtls_ctx(struct pkcs7_sinfo_mbedtls_ctx *ctx)
+{
+	if (ctx) {
+		kfree(ctx->authattrs_data);
+		kfree(ctx->content_data_digest);
+		kfree(ctx);
+	}
+}
+
+/*
+ * Parse Authenticate Attributes
+ * TODO: Shall we consider to integrate decoding of authenticate attribute into
+ *	 MbedTLS library?
+ *
+ * Structure of the data:
+ *
+ * [C.P.0] {
+ *    U.P.SEQUENCE {
+ *       U.P.OBJECTIDENTIFIER <contentType_OID>
+ *       U.P.SET {
+ *          U.P.OBJECTIDENTIFIER <msIndirectData_OID>
+ *       }
+ *    }
+ *    U.P.SEQUENCE {
+ *       U.P.OBJECTIDENTIFIER <signingTime_OID>
+ *       U.P.SET {
+ *          U.P.UTCTime <signingTime>
+ *       }
+ *    }
+ *    U.P.SEQUENCE {
+ *       U.P.OBJECTIDENTIFIER <messageDigest_OID>
+ *       U.P.SET {
+ *          U.P.OCTETSTRING <messageDigest>
+ *       }
+ *    }
+ *    U.P.SEQUENCE {
+ *       U.P.OBJECTIDENTIFIER <S/MIME capabilities_OID>
+ *       U.P.SET {
+ *          U.P.SEQUENCE {
+ *             [...]
+ *          }
+ *       }
+ *    }
+ * }
+ */
+static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
+			   struct pkcs7_signed_info *sinfo)
+{
+	unsigned char *p = (unsigned char *)aa;
+	unsigned char *end = (unsigned char *)aa + aa_len;
+	size_t len = 0;
+	int ret;
+	unsigned char *inner_p;
+	size_t seq_len = 0;
+
+	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+				   MBEDTLS_ASN1_CONTEXT_SPECIFIC |
+				   MBEDTLS_ASN1_CONSTRUCTED);
+	if (ret)
+		return ret;
+
+	while (!mbedtls_asn1_get_tag(&p, end, &seq_len,
+				     MBEDTLS_ASN1_CONSTRUCTED |
+				     MBEDTLS_ASN1_SEQUENCE)) {
+		inner_p = p;
+		ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+					   MBEDTLS_ASN1_OID);
+		if (ret)
+			return ret;
+
+		if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_CONTENTTYPE, inner_p, len)) {
+			inner_p += len;
+			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+						   MBEDTLS_ASN1_CONSTRUCTED |
+						   MBEDTLS_ASN1_SET);
+			if (ret)
+				return ret;
+
+			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+						   MBEDTLS_ASN1_OID);
+			if (ret)
+				return ret;
+
+			if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_INDIRECTDATA,
+						inner_p, len))
+				return -EINVAL;
+
+			if (__test_and_set_bit(sinfo_has_content_type, &sinfo->aa_set))
+				return -EINVAL;
+		} else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_MESSAGEDIGEST, inner_p,
+						len)) {
+			inner_p += len;
+			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+						   MBEDTLS_ASN1_CONSTRUCTED |
+						   MBEDTLS_ASN1_SET);
+			if (ret)
+				return ret;
+
+			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+						   MBEDTLS_ASN1_OCTET_STRING);
+			if (ret)
+				return ret;
+
+			sinfo->msgdigest = inner_p;
+			sinfo->msgdigest_len = len;
+
+			if (__test_and_set_bit(sinfo_has_message_digest, &sinfo->aa_set))
+				return -EINVAL;
+		} else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_SIGNINGTIME, inner_p,
+						len)) {
+			mbedtls_x509_time st;
+
+			inner_p += len;
+			ret = mbedtls_asn1_get_tag(&inner_p, p + seq_len, &len,
+						   MBEDTLS_ASN1_CONSTRUCTED |
+						   MBEDTLS_ASN1_SET);
+			if (ret)
+				return ret;
+
+			ret = mbedtls_x509_get_time(&inner_p, p + seq_len, &st);
+			if (ret)
+				return ret;
+			sinfo->signing_time = x509_get_timestamp(&st);
+
+			if (__test_and_set_bit(sinfo_has_signing_time, &sinfo->aa_set))
+				return -EINVAL;
+		} else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS9_SMIMECAP, inner_p,
+						len)) {
+			if (__test_and_set_bit(sinfo_has_smime_caps, &sinfo->aa_set))
+				return -EINVAL;
+
+			if (msg->data_type != OID_msIndirectData &&
+			    msg->data_type != OID_data)
+				return -EINVAL;
+		} else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_SPOPUSINFO, inner_p,
+						len)) {
+			if (__test_and_set_bit(sinfo_has_ms_opus_info, &sinfo->aa_set))
+				return -EINVAL;
+		} else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_STATETYPE, inner_p,
+						len)) {
+			if (__test_and_set_bit(sinfo_has_ms_statement_type, &sinfo->aa_set))
+				return -EINVAL;
+		}
+
+		p += seq_len;
+	}
+
+	if (ret && ret !=  MBEDTLS_ERR_ASN1_OUT_OF_DATA)
+		return ret;
+
+	msg->have_authattrs = true;
+
+	/*
+	 * Skip the leading tag byte (MBEDTLS_ASN1_CONTEXT_SPECIFIC |
+	 * MBEDTLS_ASN1_CONSTRUCTED) to satisfy pkcs7_digest() when calculating
+	 * the digest of authattrs.
+	 */
+	sinfo->authattrs = aa + 1;
+	sinfo->authattrs_len = aa_len - 1;
+
+	return 0;
+}
+
+static int x509_populate_content_data(struct pkcs7_message *msg,
+				      mbedtls_pkcs7 *pkcs7_ctx)
+{
+	struct pkcs7_mbedtls_ctx *mctx;
+
+	if (!pkcs7_ctx->content_data.data ||
+	    !pkcs7_ctx->content_data.data_len)
+		return 0;
+
+	mctx = kzalloc(sizeof(*mctx), GFP_KERNEL);
+	if (!mctx)
+		return -ENOMEM;
+
+	mctx->content_data = kmemdup(pkcs7_ctx->content_data.data,
+				     pkcs7_ctx->content_data.data_len,
+				     GFP_KERNEL);
+	if (!mctx->content_data) {
+		pkcs7_free_mbedtls_ctx(mctx);
+		return -ENOMEM;
+	}
+
+	msg->data = mctx->content_data;
+	msg->data_len = pkcs7_ctx->content_data.data_len;
+	msg->data_hdrlen = pkcs7_ctx->content_data.data_hdrlen;
+	msg->data_type = pkcs7_ctx->content_data.data_type;
+
+	msg->mbedtls_ctx = mctx;
+	return 0;
+}
+
+static int x509_populate_sinfo(struct pkcs7_message *msg,
+			       mbedtls_pkcs7_signer_info *mb_sinfo,
+			       struct pkcs7_signed_info **sinfo)
+{
+	struct pkcs7_signed_info *signed_info;
+	struct public_key_signature *s;
+	mbedtls_md_type_t md_alg;
+	struct pkcs7_sinfo_mbedtls_ctx *mctx;
+	int ret;
+
+	signed_info = kzalloc(sizeof(*signed_info), GFP_KERNEL);
+	if (!signed_info)
+		return -ENOMEM;
+
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s) {
+		ret = -ENOMEM;
+		goto out_no_sig;
+	}
+
+	mctx = kzalloc(sizeof(*mctx), GFP_KERNEL);
+	if (!mctx) {
+		ret = -ENOMEM;
+		goto out_no_mctx;
+	}
+
+	/*
+	 * Hash algorithm:
+	 *
+	 * alg_identifier =	digestAlgorithm (DigestAlgorithmIdentifier)
+	 *			MbedTLS internally checks this field to ensure
+	 *			it is the same as digest_alg_identifiers.
+	 * sig_alg_identifier =	digestEncryptionAlgorithm
+	 *			(DigestEncryptionAlgorithmIdentifier)
+	 *			MbedTLS just saves this field without any actions.
+	 * See function pkcs7_get_signer_info() for reference.
+	 *
+	 * Public key algorithm:
+	 * No information related to public key algorithm under MbedTLS signer
+	 * info. Assume that we are using RSA.
+	 */
+	ret = mbedtls_oid_get_md_alg(&mb_sinfo->alg_identifier, &md_alg);
+	if (ret)
+		goto out_err_sinfo;
+	s->pkey_algo = "rsa";
+
+	/* Translate the hash algorithm */
+	switch (md_alg) {
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
+		goto out_err_sinfo;
+	}
+
+	/*
+	 * auth_ids holds AuthorityKeyIdentifier, aka akid
+	 * auth_ids[0]:
+	 *	[PKCS#7 or CMS ver 1] - generated from "Issuer + Serial number"
+	 *	[CMS ver 3] - generated from skid (subjectKeyId)
+	 * auth_ids[1]: generated from skid (subjectKeyId)
+	 *
+	 * Assume that we are using PKCS#7 (msg->version=1),
+	 * not CMS ver 3 (msg->version=3).
+	 */
+	s->auth_ids[0] = asymmetric_key_generate_id(mb_sinfo->serial.p,
+						    mb_sinfo->serial.len,
+						    mb_sinfo->issuer_raw.p,
+						    mb_sinfo->issuer_raw.len);
+	if (!s->auth_ids[0]) {
+		ret = -ENOMEM;
+		goto out_err_sinfo;
+	}
+
+	/* skip s->auth_ids[1], no subjectKeyId in MbedTLS signer info ctx */
+
+	/*
+	 * Encoding can be pkcs1 or raw, but only pkcs1 is supported.
+	 * Set the encoding explicitly to pkcs1.
+	 */
+	s->encoding = "pkcs1";
+
+	/* Copy the signature data */
+	s->s = kmemdup(mb_sinfo->sig.p, mb_sinfo->sig.len, GFP_KERNEL);
+	if (!s->s) {
+		ret = -ENOMEM;
+		goto out_err_sinfo;
+	}
+	s->s_size = mb_sinfo->sig.len;
+	signed_info->sig = s;
+
+	/* Save the Authenticate Attributes data if exists */
+	if (!mb_sinfo->authattrs.data || !mb_sinfo->authattrs.data_len)
+		goto no_authattrs;
+
+	mctx->authattrs_data = kmemdup(mb_sinfo->authattrs.data,
+				       mb_sinfo->authattrs.data_len,
+				       GFP_KERNEL);
+	if (!mctx->authattrs_data) {
+		ret = -ENOMEM;
+		goto out_err_sinfo;
+	}
+	signed_info->mbedtls_ctx = mctx;
+
+	/* If authattrs exists, decode it and parse msgdigest from it */
+	ret = authattrs_parse(msg, mctx->authattrs_data,
+			      mb_sinfo->authattrs.data_len,
+			      signed_info);
+	if (ret)
+		goto out_err_sinfo;
+
+no_authattrs:
+	*sinfo = signed_info;
+	return 0;
+
+out_err_sinfo:
+	pkcs7_free_sinfo_mbedtls_ctx(mctx);
+out_no_mctx:
+	public_key_signature_free(s);
+out_no_sig:
+	kfree(signed_info);
+	return ret;
+}
+
+#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
+
 /*
  * Free a signed information block.
  */
@@ -59,6 +407,9 @@ static void pkcs7_free_signed_info(struct pkcs7_signed_info *sinfo)
 {
 	if (sinfo) {
 		public_key_signature_free(sinfo->sig);
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+		pkcs7_free_sinfo_mbedtls_ctx(sinfo->mbedtls_ctx);
+#endif
 		kfree(sinfo);
 	}
 }
@@ -88,11 +439,85 @@ void pkcs7_free_message(struct pkcs7_message *pkcs7)
 			pkcs7->signed_infos = sinfo->next;
 			pkcs7_free_signed_info(sinfo);
 		}
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+		pkcs7_free_mbedtls_ctx(pkcs7->mbedtls_ctx);
+#endif
 		kfree(pkcs7);
 	}
 }
 EXPORT_SYMBOL_GPL(pkcs7_free_message);
 
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
+{
+	int i;
+	int ret;
+	mbedtls_pkcs7 pkcs7_ctx;
+	mbedtls_pkcs7_signer_info *mb_sinfos;
+	mbedtls_x509_crt *mb_certs;
+	struct pkcs7_message *msg;
+	struct x509_certificate **cert;
+	struct pkcs7_signed_info **sinfos;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto out_no_msg;
+	}
+
+	/* Parse the DER encoded PKCS#7 message using MbedTLS */
+	mbedtls_pkcs7_init(&pkcs7_ctx);
+	ret = mbedtls_pkcs7_parse_der(&pkcs7_ctx, data, datalen);
+	/* Check if it is a PKCS#7 message with signed data */
+	if (ret != MBEDTLS_PKCS7_SIGNED_DATA)
+		goto parse_fail;
+
+	/* Assume that we are using PKCS#7, not CMS ver 3 */
+	msg->version = 1;	/* 1 for [PKCS#7 or CMS ver 1] */
+
+	/* Populate the certs to msg->certs */
+	for (i = 0, cert = &msg->certs, mb_certs = &pkcs7_ctx.signed_data.certs;
+	     i < pkcs7_ctx.signed_data.no_of_certs && mb_certs;
+	     i++, cert = &(*cert)->next, mb_certs = mb_certs->next) {
+		ret = x509_populate_cert(mb_certs, cert);
+		if (ret)
+			goto parse_fail;
+
+		(*cert)->index = i + 1;
+	}
+
+	/*
+	 * Skip populating crl, that is not currently in-use.
+	 */
+
+	/* Populate content data */
+	ret = x509_populate_content_data(msg, &pkcs7_ctx);
+	if (ret)
+		goto parse_fail;
+
+	/* Populate signed info to msg->signed_infos */
+	for (i = 0, sinfos = &msg->signed_infos,
+	     mb_sinfos = &pkcs7_ctx.signed_data.signers;
+	     i < pkcs7_ctx.signed_data.no_of_signers && mb_sinfos;
+	     i++, sinfos = &(*sinfos)->next, mb_sinfos = mb_sinfos->next) {
+		ret = x509_populate_sinfo(msg, mb_sinfos, sinfos);
+		if (ret)
+			goto parse_fail;
+
+		(*sinfos)->index = i + 1;
+	}
+
+	mbedtls_pkcs7_free(&pkcs7_ctx);
+	return msg;
+
+parse_fail:
+	mbedtls_pkcs7_free(&pkcs7_ctx);
+	pkcs7_free_message(msg);
+out_no_msg:
+	msg = ERR_PTR(ret);
+	return msg;
+}
+#else	/* !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 /*
  * Check authenticatedAttributes are provided or not provided consistently.
  */
@@ -182,34 +607,6 @@ out_no_ctx:
 }
 EXPORT_SYMBOL_GPL(pkcs7_parse_message);
 
-/**
- * pkcs7_get_content_data - Get access to the PKCS#7 content
- * @pkcs7: The preparsed PKCS#7 message to access
- * @_data: Place to return a pointer to the data
- * @_data_len: Place to return the data length
- * @_headerlen: Size of ASN.1 header not included in _data
- *
- * Get access to the data content of the PKCS#7 message.  The size of the
- * header of the ASN.1 object that contains it is also provided and can be used
- * to adjust *_data and *_data_len to get the entire object.
- *
- * Returns -ENODATA if the data object was missing from the message.
- */
-int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
-			   const void **_data, size_t *_data_len,
-			   size_t *_headerlen)
-{
-	if (!pkcs7->data)
-		return -ENODATA;
-
-	*_data = pkcs7->data;
-	*_data_len = pkcs7->data_len;
-	if (_headerlen)
-		*_headerlen = pkcs7->data_hdrlen;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
-
 /*
  * Note an OID when we find one for later processing when we know how
  * to interpret it.
@@ -698,3 +1095,32 @@ int pkcs7_note_signed_info(void *context, size_t hdrlen,
 		return -ENOMEM;
 	return 0;
 }
+#endif	/* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
+
+/**
+ * pkcs7_get_content_data - Get access to the PKCS#7 content
+ * @pkcs7: The preparsed PKCS#7 message to access
+ * @_data: Place to return a pointer to the data
+ * @_data_len: Place to return the data length
+ * @_headerlen: Size of ASN.1 header not included in _data
+ *
+ * Get access to the data content of the PKCS#7 message.  The size of the
+ * header of the ASN.1 object that contains it is also provided and can be used
+ * to adjust *_data and *_data_len to get the entire object.
+ *
+ * Returns -ENODATA if the data object was missing from the message.
+ */
+int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
+			   const void **_data, size_t *_data_len,
+			   size_t *_headerlen)
+{
+	if (!pkcs7->data)
+		return -ENODATA;
+
+	*_data = pkcs7->data;
+	*_data_len = pkcs7->data_len;
+	if (_headerlen)
+		*_headerlen = pkcs7->data_hdrlen;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
-- 
2.25.1

