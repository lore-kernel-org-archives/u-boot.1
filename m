Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D67C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 10:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0DB84659;
	Sat, 18 Jul 2026 12:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JL32n5b1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2768467B; Sat, 18 Jul 2026 12:57:10 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FE780117
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 12:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c7c61b5292so70297355ad.0
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784372225; x=1784977025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SnjKSNxE0XcL9mw8isAzngtFt7gXUh8mxnQvjykNN1I=;
 b=JL32n5b1tbd9un8N+VJe6XRqAA0ags8Sg8QezuSGtqVOQ9GFZ6zjoXqSMN7H3EmJDX
 8izZdqQYpXHDLxkvWCNWvSMy4L9lXtcYA5CO2Bxu53b51zf4ltlOTXPvWtGzfbKF0hQJ
 7kcO5nhKC2AFSQMBIVGa1zgVGi4aUtLoThI7RppiDv2AkLdb25RV2eWy4x8q0C/3QXoh
 ymihCMwlsqkRLhIyNS6GWJ3DolSTJnYHCM3y9BRkSWbee2QaPUMPuiPQDC08O6n2KnLG
 nFBE90i4oAnUaHxzCoquhSmRsc5XK6XjVw5dHFpO9H105S3Vfmx/xsbBNDFShCS5wtnZ
 mwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784372225; x=1784977025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SnjKSNxE0XcL9mw8isAzngtFt7gXUh8mxnQvjykNN1I=;
 b=sd+XP4yb7FnjV2k40CpfNdlM+HO98T/2cIPqy213YuWyZ/WBYS+kS3WH2RsyYot5rA
 iDkcb7aIu5H+u2TjjckzuZl6VhDNT65ADpntxURVA7fFOuTxcZA9Qy2w1VsG+MG59yb7
 ybqpdcwB6VG4zMw6UKeLmLqiIwKeynZ4/3sG7ZHp4pw0zBYoChspN6/gbgTmkbAhU1Pn
 4xBMcPAVdO2BiX4SCEAHqXxb6JovmytAxG47QDjuUHsmnyRI6eVHiZTITwHkNTR6UKR8
 fS9gelRjd7+ZJIYPlxe/Y6O4Xl7RD+yKvOELdHqT90rMSucdrOEcZx3ya4wFILNKh/Oc
 IwdA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro38qW6XA7tsDrFl3NHcYFaA8zbLdyWjQQzJvgg5VlnAlfccEheVs/RUGcXk2LBcF4kzPO2iT0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4ih/6RriM6yd8KZqzSy0zAJdaezS/UhrdnFHk5/KnegHFnwv2
 Ri5kDRGptpqQimHhmzL0vHyqLp96S9SQgVhuB3C4uMRRTIW3LiyrkSO5
X-Gm-Gg: AfdE7cmVWuPEmrnaRlQ2ZsnI4mA51VkE1U0yf4S2Rz8o35JLlxXebxrHQlJN/EBCzRV
 JIoHp4mggydZVpCzIx61RAX1RG422qcJb/GdnLCPHIiGrYH2FPDreBnFKSHSKH3XVN/H3VXgrUU
 D+vUs0fY46pBHOaENNwd6tX5d9O8/CiGCtdWAcdfGmyrtJOazgxXluS0ZKW1khYZlQ9kiONwGnU
 H2A575fGlDHJ+nOMvbagAVedJZQRionCtDMLlCujKKDk9byKlYj94ChI/ya2VHJBh7xZdTdMVhA
 2iYFwQ4nBB9EDZLB9lQcuVcMf+F/XDpFA0qfW8tRYQ/9qyUWt+Ef/cdMB6MdNNM1cx7k9ytjfDc
 L6oUa2tZTAXyU4GeQJUWhfUh7wJ8jQXTwhzf2uxW54SkHj4pPMAxqA4cJlUie4gyBLaiyZmL+ml
 w2EuMRvlnf9gw7KoJ7GUN8pyvJI6Cbhm57lXdMVMKoklHRFziUADcMdjRy5Q==
X-Received: by 2002:a17:902:cec8:b0:2c9:e5ff:995d with SMTP id
 d9443c01a7336-2cf3494ae23mr68930835ad.31.1784372225401; 
 Sat, 18 Jul 2026 03:57:05 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:40fa:6e6d:ed28:7c2a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29c2a48sm11859799c88.2.2026.07.18.03.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 03:57:04 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: ilias.apalodimas@linaro.org
Cc: Wojciech.Dubowik@mt.com, xypron.glpk@gmx.de, trini@konsulko.com,
 u-boot@lists.denx.de, marex@nabladev.com, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Franz Schnyder <fra.schnyder@gmail.com>,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v8] tools: mkeficapsule: Rework pkcs11 support
Date: Sat, 18 Jul 2026 07:56:27 -0300
Message-ID: <20260718105627.625235-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Some distros like OpenEmbedded are using gnutls library
without pkcs11 support and linking of mkeficapsule will fail.
It would make maintenance of default configs a hurdle.
Add detection of pkcs11 support in gnutls so it's enabled
when available and doesn't need to be set explicitly.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
Suggested-by: Tom Rini <trini@konsulko.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v7:
- Also handle gnutls_global_deinit() and gnutls_pkcs11_deinit() - Ilias.

 tools/Makefile       |   5 ++
 tools/mkeficapsule.c | 111 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 89 insertions(+), 27 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 1a5f425ecda..e85f5a354b8 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -271,6 +271,11 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	$(LIBFDT_OBJS) \
 	mkeficapsule.o
 hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
+GNUTLS_SUPPORTS_P11KIT = $(shell pkg-config --libs gnutls --print-requires-private \
+			 2> /dev/null | grep p11-kit-1)
+ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
+HOSTCFLAGS_mkeficapsule.o += -DMKEFICAPSULE_PKCS11
+endif
 
 include tools/fwumdata_src/fwumdata.mk
 
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index ec640c57e8a..df64e1b7497 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -207,6 +207,81 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
 	return 0;
 }
 
+#ifdef MKEFICAPSULE_PKCS11
+static int pkcs11_init(void)
+{
+	const char *lib;
+	int ret;
+
+	lib = getenv("PKCS11_MODULE_PATH");
+	if (!lib) {
+		fprintf(stdout,
+			"PKCS11_MODULE_PATH not set in the environment\n");
+		return -1;
+	}
+
+	gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
+	gnutls_global_init();
+
+	ret = gnutls_pkcs11_add_provider(lib, "trusted");
+	if (ret < 0) {
+		fprintf(stdout, "Failed to add pkcs11 provider\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
+{
+	gnutls_pkcs11_obj_t *obj_list;
+	unsigned int obj_list_size = 0;
+	int ret;
+
+	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
+						 ctx->cert_file, 0);
+	if (ret < 0 || obj_list_size == 0)
+		return -1;
+
+	gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
+
+	return 0;
+}
+
+static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
+{
+	return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
+}
+
+static void pkcs11_deinit(void)
+{
+	gnutls_global_deinit();
+	gnutls_pkcs11_deinit();
+}
+#else
+static int pkcs11_init(void)
+{
+	fprintf(stderr, "Pkcs11 support is disabled\n");
+	return -1;
+}
+
+static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
+{
+	fprintf(stderr, "Pkcs11 support is disabled\n");
+	return -1;
+}
+
+static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
+{
+	fprintf(stderr, "Pkcs11 support is disabled\n");
+	return -1;
+}
+
+static void pkcs11_deinit(void)
+{
+}
+#endif
+
 /**
  * create_auth_data - compose authentication data in capsule
  * @auth_context:	Pointer to authentication context
@@ -229,9 +304,6 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
-	gnutls_pkcs11_obj_t *obj_list;
-	unsigned int obj_list_size = 0;
-	const char *lib;
 	int ret;
 	bool pkcs11_cert = false;
 	bool pkcs11_key = false;
@@ -243,19 +315,8 @@ static int create_auth_data(struct auth_context *ctx)
 		pkcs11_key = true;
 
 	if (pkcs11_cert || pkcs11_key) {
-		lib = getenv("PKCS11_MODULE_PATH");
-		if (!lib) {
-			fprintf(stdout,
-				"PKCS11_MODULE_PATH not set in the environment\n");
-			return -1;
-		}
-
-		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
-		gnutls_global_init();
-
-		ret = gnutls_pkcs11_add_provider(lib, "trusted");
+		ret = pkcs11_init();
 		if (ret < 0) {
-			fprintf(stdout, "Failed to add pkcs11 provider\n");
 			return -1;
 		}
 	}
@@ -301,14 +362,12 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load x509 certificate */
 	if (pkcs11_cert) {
-		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
-							 ctx->cert_file, 0);
-		if (ret < 0 || obj_list_size == 0) {
-			fprintf(stdout, "Failed to import crt_file URI objects\n");
+		ret =  import_pkcs11_crt(&x509, ctx);
+		if (ret < 0) {
+			fprintf(stderr, "error in import_pkcs11_crt(): %s\n",
+				gnutls_strerror(ret));
 			return -1;
 		}
-
-		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
 	} else {
 		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
 		if (ret < 0) {
@@ -320,9 +379,9 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load a private key */
 	if (pkcs11_key) {
-		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
+		ret = import_pkcs11_key(&pkey, ctx);
 		if (ret < 0) {
-			fprintf(stderr, "error in %d: %s\n", __LINE__,
+			fprintf(stderr,	"error in import_pkcs11_key(): %s\n",
 				gnutls_strerror(ret));
 			return -1;
 		}
@@ -403,10 +462,8 @@ static int create_auth_data(struct auth_context *ctx)
 	 *   gnutls_free(signature.data);
 	 */
 
-	if (pkcs11_cert || pkcs11_key) {
-		gnutls_global_deinit();
-		gnutls_pkcs11_deinit();
-	}
+	if (pkcs11_cert || pkcs11_key)
+		pkcs11_deinit();
 
 	return 0;
 }
-- 
2.43.0

