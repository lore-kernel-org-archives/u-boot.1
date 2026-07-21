Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A22C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFD16408A9;
	Tue, 21 Jul 2026 14:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glfNqfanYE9v; Tue, 21 Jul 2026 14:14:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED03C408CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784643249;
	bh=cdVKmeahVfrqLrz59UuW60DJGKhQKMSpA9C6uCrDrB0=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=m3WtToka5PQMvLC8rqpZq/6CUa6NACX8sBq7H//fijsN4Pqpkxm+8qvB8Hgwlem4+
	 PNQbJiKR1kDFESLHoIiNvU19qpO4suCPrjUBLUdsWuVRWLXYHODeUX1qo2aEaV57Bh
	 5im4D74vxB86u4j3WM0NffbmloHcxtN9cWJ60sr+8MNLykYLwhtdRDaaiU5557VuSK
	 kIKjUe6THgV0UEypd2khDN5m/z98Qk7gNQNGIbXhvhX/MT/zKGvaUdrNvslFQ8ffuU
	 lVbqbhBJO5r7fS0JsjB3HTnwptS9zDdSV8Nv3n9QbDGzwLpYiApyqbh9XW8hfogyv1
	 ql736ZrE0X7mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED03C408CD;
	Tue, 21 Jul 2026 14:14:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 026B4109B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC84D6083B
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Xh5rkHInFxx for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:14:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A533A607F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A533A607F7
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A533A607F7
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:14:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5C884659; Tue, 21 Jul 2026 16:14:03 +0200 (CEST)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9880F803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:14:00 +0200 (CEST)
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5bf8e1edc3aso3674145e0c.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784643239; x=1785248039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cdVKmeahVfrqLrz59UuW60DJGKhQKMSpA9C6uCrDrB0=;
 b=osii1DgiElJ+3R/aPKDu1B0KvdQQScBxIpdsHLSrUgK8+hqAOLaeFcXw1rYtMpDAZJ
 tTaP9JA/A4SrG0SRKP5nWVQHWLooCoAseLazGTpug+S5oe5FxldEWhK+trzYEOkpMp+E
 uQoo5XSYdDERrNJI+yKAiaoJOwct74ZJ/2yfvqBhe+oaBk4r2Xh9imZzF6TyvlrEsel/
 1fHSsIfN9BdZM7tT936rrkQ9RBR9v+IstMHR1UVzQ2WYi84yeGdbg1hO/r5RDLeyPqdj
 UpKES3A6CEYNpj0+X8z/j1mqu1tVGtHCMof4b6GR658QCi/zLuPNddKcAyEKqGVbnzcl
 SkTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcA1vpFlAlOUUMdhUcwM7rrQcmCSOrE1JfO58exjeuQXm8czSgctuK8hi/u0TOawaYE04EMNE=@lists.denx.de
X-Gm-Message-State: AOJu0YyLMJLapepDYsDvzrcE3eNkIVx8RnOVG5gyAnCR14IfiQKIULOB
 AEwOyb9uYM6CBeQ6wxP/gc3Pxrg3Fdq6N5ldo8G/Q47JqsoTX+vr8ZsU
X-Gm-Gg: AR+sD12wqksN4QRszFj7eX48KFA7zQDh5o8/Xi5261de5vcjYpOdLf+rfR9JBxbxZxs
 5euKETSv4EZMmi5sVwCVtd+2i99GUEJDpbSLLx6k7k3ZyK+u/67nd8MVYXvrJm3HqX3AMIX8Dkf
 VDqsEcn3QlQ2t4hixkkrpVQVm7sRUgnOfiDLitaZvhsdxmKouvPG/M86GM3oRCz4KC99myd/JTA
 67VCuzb/GDYdDR+gruzluoV6U71HpN6yqB3ezkGdAUJWWaE3BFMqxlp7eAVgS1oKGZ07d6Uw+IM
 07nFFxTwxfLnNTtidoKq7qlcN7mrlTYzSmC5iv2uJDn3OQXU6xw4QbCOmxshT7E88vTPEf6R3/c
 1bX0mAQ1DZ3GxotmL8oUF1SOdXLvDDml+59VNcZpBMPfJvRBpNHEwKvPj5nuvANhQoIKe1KBSjA
 8LOkmdOk72U4WCnWnBKSoJdXiKyrFf5SVxS9CPt9m8JT1HcQogig==
X-Received: by 2002:a05:6122:4085:b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-5c1b6646347mr5877668e0c.4.1784643239054; 
 Tue, 21 Jul 2026 07:13:59 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a801:a24:fdfe:648c:2808:d17c])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1e6c71300sm15053018e0c.0.2026.07.21.07.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 07:13:58 -0700 (PDT)
To: xypron.glpk@gmx.de
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 quentin.schulz@cherry.de, marex@nabladev.com, dwmw2@infradead.org,
 Wojciech.Dubowik@mt.com, fra.schnyder@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v9] tools: mkeficapsule: Rework pkcs11 support
Date: Tue, 21 Jul 2026 11:13:50 -0300
Message-ID: <20260721141350.45800-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784643239; x=1785248039; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cdVKmeahVfrqLrz59UuW60DJGKhQKMSpA9C6uCrDrB0=;
 b=amUGtrNfb3q2y7Rn1W+3TLDiO1l/mkL7phsiuAoendF40XmSDTk9gROwA2dajKSrYV
 Y0eKBxSfWDbL0xuLhTryh4/rKx4KOwzhzYGM7S7BmI4hVGHB0u+jgGFHHZDKVZZMkkj1
 4x5iF2IyIUM19ST9O8sdd4D7aQ2mUj7rwao6dqYU3JH9uFZhHAo+ThOSNBya8TFsYWwD
 LrmXFJBVdl1nq6CO0xSq5BeLwSl1OH06vw1ISUuV1bQ7NanVbtVi6vYWs9FNsoxPTMM0
 O6FvySXMSHOoKWYwOB8QAOTOgNZdW1MyN5GqEP//8nv3GvOwqwIPzs+Fi4kzafp+WGGh
 vBCw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=amUGtrNf
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="amUGtrNf"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Some distributions, such as OpenEmbedded, build GnuTLS without
PKCS #11 support, which causes mkeficapsule to fail at link time.

Detect whether GnuTLS was built with p11-kit support and enable
PKCS #11 functionality only when available. Emit a build warning
when mkeficapsule is built without this functionality.

When PKCS #11 is available, rely on GnuTLS and p11-kit for automatic
provider discovery, allowing PKCS #11 URIs to be used without the
PKCS11_MODULE_PATH environment variable.

Document the use of PKCS #11 URIs for private keys and certificates.

Suggested-by: Tom Rini <trini@konsulko.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Sorry for the resend. I forgot to CC the list.

Only built-tested.

Changes since v8:
- Removed Quentin's and Simon's review tags due to the significant changes
  introduced in this version.
- Warn when mkeficapsule is built without PKCS#11 support.
- Rely on GnuTLS and p11-kit for automatic PKCS#11 provider discovery,
  removing PKCS11_MODULE_PATH and manual initialization/deinitialization.
- Improve user-facing errors for PKCS#11 certificate and key imports.
- Document the use of PKCS#11 URIs in mkeficapsule.1 and the UEFI
  documentation.
- Remove PKCS11_MODULE_PATH from the SoftHSM test to verify automatic
  provider discovery through GnuTLS and p11-kit.

 doc/develop/uefi/uefi.rst | 13 ++++++
 doc/mkeficapsule.1        | 25 ++++++++--
 tools/Makefile            |  9 ++++
 tools/binman/ftest.py     |  3 +-
 tools/mkeficapsule.c      | 98 +++++++++++++++++++++++----------------
 5 files changed, 102 insertions(+), 46 deletions(-)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 3ca22b572a92..cf7f638f2c23 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -597,6 +597,19 @@ and used by the steps highlighted below.
       [--fit | --raw | --guid <guid-string] \
       <image_blob> <capsule_file_name>
 
+If ``mkeficapsule`` was built with PKCS #11 support, the private key and
+certificate arguments can instead be PKCS #11 URIs. GnuTLS automatically
+discovers PKCS #11 providers configured through p11-kit. For example:
+
+.. code-block:: console
+
+    $ mkeficapsule --monotonic-count 1 \
+      --private-key 'pkcs11:token=U-Boot;object=capsule-key;type=private' \
+      --certificate 'pkcs11:token=U-Boot;object=capsule-cert;type=cert' \
+      --index 1 --instance 0 \
+      [--fit | --raw | --guid <guid-string] \
+      <image_blob> <capsule_file_name>
+
 Anti-rollback Protection
 ************************
 
diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index ed296730eeb9..dfa9b805ca32 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -108,12 +108,12 @@ With signing,
 are all mandatory.
 
 .TP
-.BI "-p\fR,\fB --private-key " private-key-file
-Specify signer's private key file in PEM
+.BI "-p\fR,\fB --private-key " private-key-file-or-URI
+Specify the signer's private key as a PEM file or PKCS #11 URI.
 
 .TP
-.BI "-c\fR,\fB --certificate " certificate-file
-Specify signer's certificate file in EFI certificate list format
+.BI "-c\fR,\fB --certificate " certificate-file-or-URI
+Specify the signer's certificate as a PEM file or PKCS #11 URI.
 
 .TP
 .BI "-m\fR,\fB --monotonic-count " count
@@ -124,6 +124,23 @@ at every firmware update.
 .B "-d\fR,\fB --dump-sig"
 Dump signature data into <capsule-file-name>.p7 file
 
+.SH "PKCS #11"
+If
+.B mkeficapsule
+was built with PKCS #11 support, a PKCS #11 URI can be used in place of the
+private key or certificate filename. PKCS #11 providers configured through
+p11-kit are discovered automatically by GnuTLS.
+
+For example:
+
+.EX
+mkeficapsule --monotonic-count 1 \\
+  --private-key 'pkcs11:token=U-Boot;object=capsule-key;type=private' \\
+  --certificate 'pkcs11:token=U-Boot;object=capsule-cert;type=cert' \\
+  --index 1 --instance 0 --guid <guid-string> \\
+  <image-blob> <capsule-file>
+.EE
+
 .SH "GUIDGEN OPTIONS"
 
 .TP
diff --git a/tools/Makefile b/tools/Makefile
index 1a5f425ecdaa..c156af9fc5e9 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -271,6 +271,15 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	$(LIBFDT_OBJS) \
 	mkeficapsule.o
 hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
+ifeq ($(CONFIG_TOOLS_MKEFICAPSULE),y)
+GNUTLS_SUPPORTS_P11KIT = $(shell pkg-config --libs gnutls --print-requires-private \
+			 2> /dev/null | grep p11-kit-1)
+ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
+HOSTCFLAGS_mkeficapsule.o += -DMKEFICAPSULE_PKCS11
+else
+$(warning Building mkeficapsule without PKCS#11 support)
+endif
+endif
 
 include tools/fwumdata_src/fwumdata.mk
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac15..d8f4d4ab2439 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7588,8 +7588,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIsNotNone(softhsm2_lib)
 
         with unittest.mock.patch.dict('os.environ',
-                                      {'SOFTHSM2_CONF': softhsm2_conf,
-                                       'PKCS11_MODULE_PATH': softhsm2_lib}):
+                                      {'SOFTHSM2_CONF': softhsm2_conf}):
                 softhsm2_util.run_cmd('--init-token', '--free', '--label',
                                       'U-Boot token', '--pin', '1111',
                                       '--so-pin', '222222')
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index ec640c57e8a5..b81c295f91e5 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -81,8 +81,8 @@ static void print_usage_mkeficapsule(void)
 		"\t-i, --index <index>         update image index\n"
 		"\t-I, --instance <instance>   update hardware instance\n"
 		"\t-v, --fw-version <version>  firmware version\n"
-		"\t-p, --private-key <privkey file>  private key file\n"
-		"\t-c, --certificate <cert file>     signer's certificate file\n"
+		"\t-p, --private-key <file|URI>  private key file or PKCS#11 URI\n"
+		"\t-c, --certificate <file|URI>  certificate file or PKCS#11 URI\n"
 		"\t-m, --monotonic-count <count>     monotonic count\n"
 		"\t-d, --dump-sig              dump signature to <output file>.p7\n"
 		"\t-A, --fw-accept  firmware accept capsule, requires GUID, no image blob\n"
@@ -207,6 +207,58 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
 	return 0;
 }
 
+#ifdef MKEFICAPSULE_PKCS11
+static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
+{
+	gnutls_pkcs11_obj_t *obj_list;
+	unsigned int obj_list_size = 0;
+	int ret;
+
+	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
+						 ctx->cert_file, 0);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to import PKCS#11 certificate: %s\n",
+			gnutls_strerror(ret));
+		return ret;
+	}
+	if (!obj_list_size) {
+		fprintf(stderr,
+			"Failed to import PKCS#11 certificate: no matching object\n");
+		return -1;
+	}
+
+	gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
+
+	return 0;
+}
+
+static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
+{
+	int ret;
+
+	ret = gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
+	if (ret < 0)
+		fprintf(stderr, "Failed to import PKCS#11 private key: %s\n",
+			gnutls_strerror(ret));
+
+	return ret;
+}
+#else
+static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
+{
+	fprintf(stderr,
+		"Cannot import PKCS#11 certificate: support is disabled\n");
+	return -1;
+}
+
+static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
+{
+	fprintf(stderr,
+		"Cannot import PKCS#11 private key: support is disabled\n");
+	return -1;
+}
+#endif
+
 /**
  * create_auth_data - compose authentication data in capsule
  * @auth_context:	Pointer to authentication context
@@ -229,9 +281,6 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
-	gnutls_pkcs11_obj_t *obj_list;
-	unsigned int obj_list_size = 0;
-	const char *lib;
 	int ret;
 	bool pkcs11_cert = false;
 	bool pkcs11_key = false;
@@ -242,24 +291,6 @@ static int create_auth_data(struct auth_context *ctx)
 	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
 		pkcs11_key = true;
 
-	if (pkcs11_cert || pkcs11_key) {
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
-		if (ret < 0) {
-			fprintf(stdout, "Failed to add pkcs11 provider\n");
-			return -1;
-		}
-	}
-
 	if (!pkcs11_cert) {
 		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
 		if (ret < 0)
@@ -301,14 +332,9 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load x509 certificate */
 	if (pkcs11_cert) {
-		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
-							 ctx->cert_file, 0);
-		if (ret < 0 || obj_list_size == 0) {
-			fprintf(stdout, "Failed to import crt_file URI objects\n");
+		ret = import_pkcs11_crt(&x509, ctx);
+		if (ret < 0)
 			return -1;
-		}
-
-		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
 	} else {
 		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
 		if (ret < 0) {
@@ -320,12 +346,9 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load a private key */
 	if (pkcs11_key) {
-		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
-		if (ret < 0) {
-			fprintf(stderr, "error in %d: %s\n", __LINE__,
-				gnutls_strerror(ret));
+		ret = import_pkcs11_key(&pkey, ctx);
+		if (ret < 0)
 			return -1;
-		}
 	} else {
 		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
 						     0, 0);
@@ -403,11 +426,6 @@ static int create_auth_data(struct auth_context *ctx)
 	 *   gnutls_free(signature.data);
 	 */
 
-	if (pkcs11_cert || pkcs11_key) {
-		gnutls_global_deinit();
-		gnutls_pkcs11_deinit();
-	}
-
 	return 0;
 }
 
-- 
2.43.0

