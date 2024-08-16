Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A493C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D898F88C02;
	Sat, 17 Aug 2024 00:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xXZoxFWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D7388C14; Fri, 16 Aug 2024 23:51:59 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6333688498
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf7a2035d9so16218866d6.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845108; x=1724449908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlTB+AsXE9vLoLqTekAjztL6YAahVOntBD+jDN2RPGY=;
 b=xXZoxFWKTog9tVjL60HCFliJ/56mCtbs4Ctl2lSQnbEjVNVHC51dpcJ7MgQIsDEP/J
 0tBPvNS+pi4CDDwtWDY9kYLE47xLxb7AeXl9HBt6xHdXyjAf/IIiR7XAT+9uC9dzq6Y9
 EjXF83FIJZZuqTL2EtO0n7ImMAegjLt6VrStplaAT80QyjbFWA0S7tCjBx4B4k/312PB
 a/C+pIc/XMqtUBKZsdZhaicIvi6qrBUjRoi8BY2LeZDOZb+FUOclpyOGQW2qHLKjkeMn
 y/Feki/Q8B7YCSaNuMIhSmt70/90phiHewoHot92WhRzVxpAS/L7sT3a3mM0YzgJvi8B
 nkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845108; x=1724449908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlTB+AsXE9vLoLqTekAjztL6YAahVOntBD+jDN2RPGY=;
 b=WjSNioC5hEeqYpOWDLOQNAi2bRupEwKLSIkkkRoBlpJU9es2drxCVZN/Gs5pJAO5XF
 4X3F9Pl1a1Vbor2li60D5Oe+o31b1xV0HYTtTq0Tct3uuYtevYmKDUjrJ2zEf9kDoeNA
 2pV/atL5cTG4FGQOA+4f9D/BNabgfwc3u40myF7ucrcK9BVYxUc/1gUgP8Kn6xSXRybf
 aqECipUyk5eEMxy/CjOlgqjTe+AK6p8QL98csxoVEJdSfxHh5Mnfl74NAkn59nDQBarc
 AXzmZyYnnj9/d67oFxBZ4UAZtIXGo0MxPnjg/wCgRPg08bkSf+x+IS/OgVB2yCI+m5Xb
 0SeQ==
X-Gm-Message-State: AOJu0YwOFQNb2d+/A1FAVk/O/rdm1o6xoCWYxLs39Rli0R7HZsewFMmW
 DYrJUoP5FczMho+lwcuFJLEz8lEV+GDEdN23VNKN8dXysI+tEB6kXC0lmLsOcr7il2hANXS8KQS
 x2jo=
X-Google-Smtp-Source: AGHT+IHqtrcVvgQZYDxv2j05ATDMlRdj71e4SS19m4jjmzEpV265spDdDsVJvz1V2pQeqDvu+EPEPA==
X-Received: by 2002:a05:6214:2508:b0:6b5:d73d:9196 with SMTP id
 6a1803df08f44-6bf6de4d1c6mr170669756d6.22.1723845108400; 
 Fri, 16 Aug 2024 14:51:48 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:51:47 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>, Anand Moon <linux.amoon@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 18/28] mbedtls: add X509 cert parser porting layer
Date: Fri, 16 Aug 2024 14:44:07 -0700
Message-Id: <20240816214436.1877263-19-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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

Add porting layer for X509 cert parser on top of MbedTLS X509
library.
Introduce _LEGACY and _MBEDTLS kconfigs for X509 cert parser legacy
and MbedTLS implementations respectively.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Move the porting layer to MbedTLS dir.
Changes in v3
- None.
Changes in v4
- Introduce _LEGACY and _MBEDTLS kconfigs for X509 cert parser legacy
  and MbedTLS implementations respectively.
- Move common functions to helper.
Changes in v5
- Kconfig rename.
- Adjust a few inline comments.
Changes in v6
- None.

 lib/mbedtls/Kconfig            |  18 ++
 lib/mbedtls/Makefile           |   4 +-
 lib/mbedtls/x509_cert_parser.c | 447 +++++++++++++++++++++++++++++++++
 3 files changed, 468 insertions(+), 1 deletion(-)
 create mode 100644 lib/mbedtls/x509_cert_parser.c

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index dbbcdba8bc6..6a0008df71c 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -119,6 +119,7 @@ config LEGACY_CRYPTO_CERT
 	bool "legacy certificate libraries"
 	select ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER_LEGACY if X509_CERTIFICATE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -133,6 +134,14 @@ config ASYMMETRIC_PUBLIC_KEY_LEGACY
 	  This option chooses legacy certificate library for asymmetric public
 	  key crypto algorithm.
 
+config X509_CERTIFICATE_PARSER_LEGACY
+	bool "X.509 certificate parser with legacy certificate library"
+	depends on ASYMMETRIC_PUBLIC_KEY_LEGACY
+	select ASN1_DECODER_LEGACY
+	help
+	  This option chooses legacy certificate library for X509 certificate
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_LEGACY
@@ -274,6 +283,7 @@ config MBEDTLS_LIB_X509
 	bool "MbedTLS certificate libraries"
 	select ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER_MBEDTLS if X509_CERTIFICATE_PARSER
 	select SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS if \
 		SPL_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
 	help
@@ -288,6 +298,14 @@ config ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	  This option chooses MbedTLS certificate library for asymmetric public
 	  key crypto algorithm.
 
+config X509_CERTIFICATE_PARSER_MBEDTLS
+	bool "X.509 certificate parser with MbedTLS certificate library"
+	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
+	select ASN1_DECODER_MBEDTLS
+	help
+	  This option chooses MbedTLS certificate library for X509 certificate
+	  parser.
+
 if SPL
 
 config SPL_ASYMMETRIC_PUBLIC_KEY_MBEDTLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 2d2220dd4fd..ab64365a99a 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_$(SPL_)SHA512_MBEDTLS) += sha512.o
 # x509 libraries
 obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
+obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
+	x509_cert_parser.o
 
 # MbedTLS crypto library
 obj-$(CONFIG_MBEDTLS_LIB_CRYPTO) += mbedtls_lib_crypto.o
@@ -44,7 +46,7 @@ mbedtls_lib_x509-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/pk.o \
 	$(MBEDTLS_LIB_DIR)/pk_wrap.o \
 	$(MBEDTLS_LIB_DIR)/pkparse.o
-mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += \
+mbedtls_lib_x509-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/x509_crl.o \
 	$(MBEDTLS_LIB_DIR)/x509_crt.o
 mbedtls_lib_x509-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += \
diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
new file mode 100644
index 00000000000..cb42018695c
--- /dev/null
+++ b/lib/mbedtls/x509_cert_parser.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * X509 cert parser using MbedTLS X509 library
+ *
+ * Copyright (c) 2024 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <crypto/public_key.h>
+#include <crypto/x509_parser.h>
+
+static void x509_free_mbedtls_ctx(struct x509_cert_mbedtls_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	kfree(ctx->tbs);
+	kfree(ctx->raw_serial);
+	kfree(ctx->raw_issuer);
+	kfree(ctx->raw_subject);
+	kfree(ctx->raw_skid);
+	kfree(ctx);
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
+	 * Note:
+	 * ECRDSA (Elliptic Curve Russian Digital Signature Algorithm) is not
+	 * supported by MbedTLS.
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
+/*
+ * Free an X.509 certificate
+ */
+void x509_free_certificate(struct x509_certificate *cert)
+{
+	if (cert) {
+		public_key_free(cert->pub);
+		public_key_signature_free(cert->sig);
+		kfree(cert->issuer);
+		kfree(cert->subject);
+		kfree(cert->id);
+		kfree(cert->skid);
+		x509_free_mbedtls_ctx(cert->mbedtls_ctx);
+		kfree(cert);
+	}
+}
+
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
-- 
2.25.1

