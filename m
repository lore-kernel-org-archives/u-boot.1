Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBE1FC6185
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4356988E33;
	Sat, 14 Sep 2024 03:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHXP+QIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1052D88706; Fri, 13 Sep 2024 18:13:41 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3B5887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6c354415c19so18043006d6.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726244017; x=1726848817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PtfLcatc/ItdtnK+X3AX6pTG6m5eeui6NMusP5KHOs=;
 b=mHXP+QIud30G5LZ/TMlF6LUZDJRNkgpGqPBjaz7AE+gAlUL0n0e4iB+gPfXSRiOf4H
 MXKcjc3Bb8PSh5FtHUHH7fKemiY9kqf01cb9t350YLCANyQUmd9DjQJbKsTzKkZat1Fh
 qM9XN04NipHTxcPlWhYDnz9fUt5yRhwXOOYSYAyFy54AkOcXKYvqb4ZnGJ6XHt4FrWHJ
 NahwwsZsW8/B7Cnr0iwoPjSe4VOX4P3TPIAFrkouErbaUpst1rqkKjKqVUYlFqMjwlXq
 Jlaon79NCukhu61dYREL5EvcnBP6e657hBEDkdd0PX7KIHnK4i32e/XnQxgUvE8q9VfD
 PUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726244017; x=1726848817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PtfLcatc/ItdtnK+X3AX6pTG6m5eeui6NMusP5KHOs=;
 b=Dht3fG5Hx6o8c0T+FfgOK3IGcK45wL5pCPP/3+hoJgbM2EoG5Z/VDuHSKFxx1CK1QH
 gDi5OTFL90+bYqsZUIx7Suk4uEU5FfdXg5GowvoSACvGl7NMO0W1XbMQKPXILYuFw7WZ
 iIZsB6m/3viliUaDL9aDdhuL3XpdTvaSBMp97z6gNPG8XZF87twlNS9q7M2YVyLxSYeL
 MWp6nNv/yUfLNwbZcecouuAx7sPlxXof0gzDzxToRQBJ2asQcaT+W82nnSkf4CJO/Axs
 cN5XeUkZm2upoHP+N2rgnD1HqULyIf3hJu5/+cTbfWyGxlfhO33lGgH3Hfcig++snUgQ
 nk4Q==
X-Gm-Message-State: AOJu0YzGD2LWd+XPQOtFMOAoFNljS16yZa5puX5qdqBntsGqYVNDxd5D
 w49HGYeg1gzxgwi9rnhkjGeRkDBjv/ipmNCgm+pFvcrwyEICEod5lc+An+4ayqD7C73Q81CoECs
 9
X-Google-Smtp-Source: AGHT+IE8d5abBoWsrjBacms/NdFxHE7XGWgTQPXnPM6ytDcpEQtdaFr+WOjZA9ZKOuMzsvDzdswBcg==
X-Received: by 2002:a05:6214:3907:b0:6c5:2fce:4904 with SMTP id
 6a1803df08f44-6c57355e7bamr121785226d6.12.1726244017607; 
 Fri, 13 Sep 2024 09:13:37 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:13:37 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 20/27] lib/crypto: Adapt PKCS7 parser to MbedTLS
Date: Fri, 13 Sep 2024 09:03:37 -0700
Message-Id: <20240913160408.2199558-21-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
Changes in v4
- Control building legacy library via '_LEGACY' Kconfig.
Changes in v5
- Correct header file include directories.
Changes in v6
- None.
Changes in v7
- None.

 include/crypto/pkcs7_parser.h | 56 +++++++++++++++++++++++++++++++++++
 lib/crypto/Makefile           |  7 +++--
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/crypto/pkcs7_parser.h b/include/crypto/pkcs7_parser.h
index 2c45cce5234..469c2711fa6 100644
--- a/include/crypto/pkcs7_parser.h
+++ b/include/crypto/pkcs7_parser.h
@@ -11,6 +11,12 @@
 #include <linux/oid_registry.h>
 #include <crypto/pkcs7.h>
 #include <crypto/x509_parser.h>
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <mbedtls/pkcs7.h>
+#include <library/x509_internal.h>
+#include <mbedtls/asn1.h>
+#include <mbedtls/oid.h>
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
index 4302f197297..7129315393f 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -50,15 +50,16 @@ $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
 # PKCS#7 message handling
 #
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
-pkcs7_message-y := \
+pkcs7_message-y := pkcs7_helper.o
+pkcs7_message-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER_LEGACY) += \
 	pkcs7.asn1.o \
-	pkcs7_helper.o \
 	pkcs7_parser.o
-obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
 $(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
 $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
 
+obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
+
 #
 # Signed PE binary-wrapped key handling
 #
-- 
2.25.1

