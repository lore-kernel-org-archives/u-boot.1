Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11492C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED0688543;
	Tue, 28 May 2024 16:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f7KLbPoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F03388557; Tue, 28 May 2024 16:16:48 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BEA884D1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-79305314956so64992985a.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905805; x=1717510605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bdsl4IpYHBRb9HWFdv6bClJMsUZjqMHe42OEzajsmXw=;
 b=f7KLbPoPZx2/wM6lq0+UjeXpQ4RJtQLKKjqvwJ74yoE1tqRTBtPnFEzNlhe7pc/TBb
 +C+2Qj7AHKzom3jJn/u84n8u3rLy9ZPNTwi1Fp43mJvCL2iP8AsYXXz5J15LgjWnFDBe
 3hqu1deT4pm3shKIcHPx0QxAIVXovUFkcImu5Ezbynox4beYb2CTFt8tCksPSH8268aA
 z1Kn2b3pEAWtKohoFiqb9r8V20Sfx0mRoExATBOrlYp8vvGX3lQ9e/h81d/CPnMype5o
 Y1QG3E9+1BUJ+mHks7BTEjdcrIrVVZSD4TX9ODMG/M6tcnmsSrEXUnMrYCNL77F61lX5
 CIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905805; x=1717510605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bdsl4IpYHBRb9HWFdv6bClJMsUZjqMHe42OEzajsmXw=;
 b=ZnI14XXXh0Mbe7yJsL60v2OATRwCVHfmJNRgjzY+cHZgPbvbLffdy5l/tMyoL8gDsK
 DUGX3BygolZj+opdRUBKMJp8SYN5hGF5e6vTBZYpYNi0vZY3zvCWYtW5Q8VZu0LMi6QV
 DqQMStAhBYfpwA1ranSMwfUzECZ3iHCiK418bWTD9xtrWceJaEYA//GqUSLxpAPaZEFe
 UqMe3Xkls4NJh0p1IuL2GqdUvwa/j2xImXd3HAVbc0pgj+LKDbbCRLTYGlsEc/PvPTu7
 bD5JSyzLwe2yfn33wELDe5veOjAoTOexHGbJRgLWhcDQJznzi62rSJ1NgL+Ov2AgPk7C
 HUCw==
X-Gm-Message-State: AOJu0YywDvOfKiTKLIRJ7Ntrc1IISlGOd+QEI4fNyI2/1IXjPvPGqwqF
 BbFG5FA2Ng0YX+cwgK01FKEao/JmUTaAQyPW6q6TwjGupQgwTuIu43S/mFB+4JV9y3NQtfDNjwn
 Jsts=
X-Google-Smtp-Source: AGHT+IG9MgLMWm4sFpEKMPgPhr9tP4M1OkZuXhcB5d8Hftuvpi3gP4VA/8J6JMfiNzwVlxGpD9946A==
X-Received: by 2002:a37:ef14:0:b0:792:c3ca:6454 with SMTP id
 af79cd13be357-794ab10f746mr1311570385a.59.1716905804700; 
 Tue, 28 May 2024 07:16:44 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:16:44 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 18/25] lib/crypto: Adapt PKCS7 parser to MbedTLS
Date: Tue, 28 May 2024 07:09:29 -0700
Message-Id: <20240528140955.1960172-19-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

Previous patch has introduced MbedTLS porting layer for PKCS7 parser,
here to adjust the header and makefiles accordingly.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- Update commit message.

 include/crypto/pkcs7_parser.h | 56 +++++++++++++++++++++++++++++++++++
 lib/crypto/Makefile           |  4 ++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/crypto/pkcs7_parser.h b/include/crypto/pkcs7_parser.h
index 2c45cce5234..9f4549871f3 100644
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
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index c89cef5685c..c3fe9c9d2c0 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -48,6 +48,7 @@ $(obj)/x509.asn1.o: $(obj)/x509.asn1.c $(obj)/x509.asn1.h
 $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
 endif
 
+ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
 #
 # PKCS#7 message handling
 #
@@ -55,10 +56,11 @@ obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
 pkcs7_message-y := \
 	pkcs7.asn1.o \
 	pkcs7_parser.o
-obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
 $(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
 $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
+endif
+obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
 #
 # Signed PE binary-wrapped key handling
-- 
2.25.1

