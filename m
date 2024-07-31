Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC5AC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FB688AA7;
	Wed, 31 Jul 2024 19:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j3lR/72v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D6C88AAF; Wed, 31 Jul 2024 19:33:23 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65CAB8841E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-70942ebcc29so3469083a34.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722447199; x=1723051999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWesPdYQPn6R05tLrpI4DCWh7FpOWGmVSVtjPR6xGtg=;
 b=j3lR/72v7O7N74XOKMiIeNX+gWja5FlRxkdfPurvwbrMVxLcJBr3MgKR/KdgAHmyBm
 JLXsR5VLCKV9pSimyw+rBRm0smFAQ/35/isF+tXXezJCJArp/leB4qDnRhLTaFTl3y4Z
 g3VWKy2mqGH8bEKWhIfEDCfOwPSXo0ZPhG4DieqZYBPW7/iBoqwre36gnr/r6gHrpGE4
 R/CKp5RWnn62mU+ruqik+KWyBCPWTiyybBg4hk9SWKlNUTYro4YokT6pLZNUp9ddIv+D
 KjYAUHzyBm1gApj8NS0hLXGM3Tko6NSGJCaxJeoN61XPOIydcFilOCJD/m6/O1NHUIgg
 RMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447199; x=1723051999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWesPdYQPn6R05tLrpI4DCWh7FpOWGmVSVtjPR6xGtg=;
 b=QfY75oqTjNarS2OCwd90AotIIIEz1SxvrKzFFIqtgKfIu+pxUw+/d4vBSP4F738nhG
 uTztIoxKGNz5Im4g8BMZ53yNKxK2E7ce5O6gSlmhxDpsoLmlewLWvE9z1SfnHTQj3G+6
 4GTyhzZEGN/anuTVy36QtNVGdawl3MElcploZcFL7UP2EvB4cYa+5D8H7VzuBdJhTXp5
 oCQsFavhVeJxZCkQgmsGtppGHgjOgBjJTKf2dTYYy/DH581BuVFdgolrxha5PbqLc/KK
 sTspgVvPMonk7ViKub/Qkyl5btNARnEBd9Vjy9EqLmou5tDHkDts/w+iCddU4hJHBinK
 mOVg==
X-Gm-Message-State: AOJu0Yw+BEcThD5AY+9sJ/ZETxA36hL2Eq0XnF6sfw4d5i4KfMzQqDlz
 wrziaJsVHFr1mYzhXIoCKqUaKsHj5S4U3Z659WitOiML9YQ4jrHFqL33ieOdey1T/AjChU4BFui
 3IGE=
X-Google-Smtp-Source: AGHT+IGiUsarw0UkvLp7IvBdjTfqPMSdCM27OOtTeK42dfm/rdyly1H1U1ZLEYqcdrPtdyqirez9hw==
X-Received: by 2002:a05:6830:2655:b0:709:4b8d:af4 with SMTP id
 46e09a7af769-7094b8d0e68mr16361061a34.5.1722447198781; 
 Wed, 31 Jul 2024 10:33:18 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:33:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 19/27] mbedtls: add PKCS7 parser porting layer
Date: Wed, 31 Jul 2024 10:25:29 -0700
Message-Id: <20240731172556.1348487-20-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

Add porting layer for PKCS7 parser on top of MbedTLS PKCS7 library.
Introduce _LEGACY and _MBEDTLS kconfigs for PKCS7 parser legacy and
MbedTLS implementations respectively.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
- Fix EFI Capsule CI test failures.
Changes in v3
- None.
Changes in v4
- Introduce _LEGACY and _MBEDTLS kconfigs for PKCS7 parser legacy and
  MbedTLS implementations respectively.
- Move common functions to helper.
- Fix an unnecessary pointer casting.
Changes in v5
- Refactored MbedTLS makefile.

 lib/mbedtls/Kconfig        |  18 ++
 lib/mbedtls/Makefile       |   3 +-
 lib/mbedtls/pkcs7_parser.c | 506 +++++++++++++++++++++++++++++++++++++
 3 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/pkcs7_parser.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 66de9d1c15f..4a65f6ab488 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -120,6 +120,7 @@ config LEGACY_CRYPTO_CERT
 	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
+	select PKCS7_MESSAGE_PARSER_LEGACY if PKCS7_MESSAGE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -142,6 +143,14 @@ config X509_CERTIFICATE_PARSER_LEGACY
 	  This option chooses legacy certificate library for X509 certificate
 	  parser.
 
+config PKCS7_MESSAGE_PARSER_LEGACY
+	bool "PKCS#7 message parser with legacy certificate library"
+	depends on X509_CERTIFICATE_PARSER_LEGACY
+	select ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for PKCS7 message
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
@@ -260,6 +269,7 @@ config MBEDTLS_LIB_X509
 	select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
+	select PKCS7_MESSAGE_PARSER_MBEDTLS if PKCS7_MESSAGE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -282,6 +292,14 @@ config X509_CERTIFICATE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for X509 certificate
 	  parser.
 
+config PKCS7_MESSAGE_PARSER_MBEDTLS
+	bool "PKCS#7 message parser with MbedTLS certificate library"
+	depends on X509_CERTIFICATE_PARSER_MBEDTLS
+	select ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for PKCS7 message
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index ab64365a99a..36eba07bf43 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
 obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	x509_cert_parser.o
+obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += pkcs7_parser.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
@@ -49,5 +50,5 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crl.o \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += \
+mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pkcs7.o
diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
new file mode 100644
index 00000000000..69ca784858e
--- /dev/null
+++ b/lib/mbedtls/pkcs7_parser.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PKCS#7 parser using MbedTLS PKCS#7 library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#include <log.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <crypto/public_key.h>
+#include <crypto/pkcs7_parser.h>
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
+ * There are two kinds of structure for the Authenticate Attributes being used
+ * in U-Boot.
+ *
+ * Type 1 - contains in a PE/COFF EFI image:
+ *
+ * [C.P.0] {
+ *   U.P.SEQUENCE {
+ *     U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.3 (OID_contentType)
+ *     U.P.SET {
+ *        U.P.OBJECTIDENTIFIER 1.3.6.1.4.1.311.2.1.4 (OID_msIndirectData)
+ *     }
+ *  }
+ *  U.P.SEQUENCE {
+ *     U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.5 (OID_signingTime)
+ *     U.P.SET {
+ *        U.P.UTCTime '<siging_time>'
+ *     }
+ *  }
+ *  U.P.SEQUENCE {
+ *     U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.4 (OID_messageDigest)
+ *     U.P.SET {
+ *        U.P.OCTETSTRING <digest>
+ *     }
+ *  }
+ *    U.P.SEQUENCE {
+ *        U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.15 (OID_smimeCapabilites)
+ *       U.P.SET {
+ *          U.P.SEQUENCE {
+ *             <...>
+ *          }
+ *       }
+ *    }
+ * }
+ *
+ * Type 2 - contains in an EFI Capsule:
+ *
+ * [C.P.0] {
+ *   U.P.SEQUENCE {
+ *      U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.3 (OID_contentType)
+ *      U.P.SET {
+ *         U.P.OBJECTIDENTIFIER 1.2.840.113549.1.7.1 (OID_data)
+ *      }
+ *   }
+ *   U.P.SEQUENCE {
+ *      U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.5 (OID_signingTime)
+ *      U.P.SET {
+ *         U.P.UTCTime '<siging_time>'
+ *      }
+ *   }
+ *   U.P.SEQUENCE {
+ *      U.P.OBJECTIDENTIFIER 1.2.840.113549.1.9.4 (OID_messageDigest)
+ *      U.P.SET {
+ *         U.P.OCTETSTRING <digest>
+ *      }
+ *  }
+ *}
+ *
+ * Note:
+ * They have different Content Type (OID_msIndirectData or OID_data).
+ * OID_smimeCapabilites only exists in a PE/COFF EFI image.
+ */
+static int authattrs_parse(struct pkcs7_message *msg, void *aa, size_t aa_len,
+			   struct pkcs7_signed_info *sinfo)
+{
+	unsigned char *p = aa;
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
+			/*
+			 * We should only support 1.2.840.113549.1.7.1 (OID_data)
+			 * for PKCS7 DATA that is used in EFI Capsule and
+			 * 1.3.6.1.4.1.311.2.1.4 (OID_msIndirectData) for
+			 * MicroSoft Authentication Code that is used in EFI
+			 * Secure Boot.
+			 */
+			if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_INDIRECTDATA,
+						inner_p, len) &&
+			    MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_PKCS7_DATA,
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
+/*
+ * Free a signed information block.
+ */
+static void pkcs7_free_signed_info(struct pkcs7_signed_info *sinfo)
+{
+	if (sinfo) {
+		public_key_signature_free(sinfo->sig);
+		pkcs7_free_sinfo_mbedtls_ctx(sinfo->mbedtls_ctx);
+		kfree(sinfo);
+	}
+}
+
+/**
+ * pkcs7_free_message - Free a PKCS#7 message
+ * @pkcs7: The PKCS#7 message to free
+ */
+void pkcs7_free_message(struct pkcs7_message *pkcs7)
+{
+	struct x509_certificate *cert;
+	struct pkcs7_signed_info *sinfo;
+
+	if (pkcs7) {
+		while (pkcs7->certs) {
+			cert = pkcs7->certs;
+			pkcs7->certs = cert->next;
+			x509_free_certificate(cert);
+		}
+		while (pkcs7->crl) {
+			cert = pkcs7->crl;
+			pkcs7->crl = cert->next;
+			x509_free_certificate(cert);
+		}
+		while (pkcs7->signed_infos) {
+			sinfo = pkcs7->signed_infos;
+			pkcs7->signed_infos = sinfo->next;
+			pkcs7_free_signed_info(sinfo);
+		}
+		pkcs7_free_mbedtls_ctx(pkcs7->mbedtls_ctx);
+		kfree(pkcs7);
+	}
+}
+
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
-- 
2.25.1

