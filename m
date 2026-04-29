Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C4AFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E5C8493E;
	Wed, 29 Apr 2026 23:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="USGwrGux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2868848BE; Wed, 29 Apr 2026 20:03:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BFA3848BB
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 20:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777485796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rtUp6EUTw/L0WsomPESPwF+V+SaNbN8BDmpKNBc4ZJ4=;
 b=USGwrGuxNAgjR0ZqQcn6MSG8eG/S9kMBqaQFJTx6xVUBklUr2RNiFfHzBeC82mRimgP10d
 /2+0M4UPiAbOMo1893BEJ19Soact0CeuM8WSTG+ZarBcuj+WMPPQ+nqBND1rOtiXgp1pei
 26X03yILya6p8Y8aaSFWZUaTuGRoLLA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-gNtshNtoMfOrrMUQwfoSzQ-1; Wed, 29 Apr 2026 14:03:15 -0400
X-MC-Unique: gNtshNtoMfOrrMUQwfoSzQ-1
X-Mimecast-MFC-AGG-ID: gNtshNtoMfOrrMUQwfoSzQ_1777485794
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb21daf7ddso12719285a.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777485794; x=1778090594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtUp6EUTw/L0WsomPESPwF+V+SaNbN8BDmpKNBc4ZJ4=;
 b=lUlTpKNPeO5xurzMN+w+QKDsjiQrMERwSdDkD7wX8BfS/arNKFtfdB7SaoJsmNgG1F
 UthCa6BNR5Hx1s9Vj5qKGN9C7POJW+KLoZayo4nfdg3O9AEbXLTwPabiag7Ls0LBQAqA
 EIqdkHLKhif6n2vJgPbI+mwFwo0zb+pl0GW0DoAiriqJHL6+c3uNHPaQWA6y8aRvEGlr
 qmIDJmVBbjcnHQfJEA8+vQiWqgouOkHkLbXbBf5tf0EJMjviGHxFbbPJ4/Q5Dry8Mw4c
 76xZDWinWcA+Q620YSG93BcZeSSXBXMcKL3R0RhzgDu/6rexEP9AfLzW9mpfePj1UYo2
 u+gQ==
X-Gm-Message-State: AOJu0YxiHcN1VyBn4KMJSAyGabCxEkcWpmrDk+WDsGdvvNGcoIGEXBet
 tTU+pc+juiO2wBJLeL1eTXSlny/yTw8SCgwZw/pV6dc/5e6zwpj6/SLD7yVi6jq+oTk3g+hrSUl
 E1Di8jRZoqIsGHcgbjII/mVqgXBM1XTj9xlkShBGne7FxAOiIkJDEEPo=
X-Gm-Gg: AeBDievXvQTQ1KF4cRsOdLATth6AUCSwSIkZpkE8+Sp5oviT+MHCDsn/2HcMaKuMqH1
 cS21tidocjnlgZRKBJ+w+B1q9byf5QNZv3ktI4TCvjwChP6W/UFR/EMGwh5aQPrxZq73rPqe8Og
 +Lbnp39a50a7CyuTkXekQmPrN0ToHLo9GFkc6gxtfIXTmzA3lhyzr3w94A4owlDsiIAzWCDA/7u
 OTt/vRAigjNva6mgaurM73XW4dyu0BfOQUc8tXgmajaUA0U8j99Nza25FrCHk8ar3VcxvA8xg7B
 v72gY62puJaauRqeIpc+9wPd6eU2MECnK0kJdZtEICgQ7JJzbNoQWZH9KGD5zE5/xx6uaCl/DrL
 WYDqbyIiK1jn2mk+tH7D7y6gRsqk=
X-Received: by 2002:a05:620a:1792:b0:8eb:f3c7:2230 with SMTP id
 af79cd13be357-8f7d9501f41mr1173377085a.42.1777485794053; 
 Wed, 29 Apr 2026 11:03:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1792:b0:8eb:f3c7:2230 with SMTP id
 af79cd13be357-8f7d9501f41mr1173371985a.42.1777485793433; 
 Wed, 29 Apr 2026 11:03:13 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f94073200asm260474385a.46.2026.04.29.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:03:13 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4] Add support for OpenSSL Provider API
Date: Wed, 29 Apr 2026 12:02:45 -0600
Message-ID: <20260429180247.83091-1-ekovsky@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UGDFD6zeyMT_34bn4AhboCUDMjPQu8a3FBXg4lsMb6o_1777485794
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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

The Engine API has been deprecated since the release of OpenSSL 3.0. End
users have been advised to migrate to the new Provider interface.
Several distributions have already removed support for engines, which is
preventing U-Boot from being compiled in those environments.

Add support for the Provider API while continuing to support the existing
Engine API on distros shipping older releases of OpenSSL.

This is based on similar work contributed by Jan Stancek updating Linux
to use the Provider interface.

    commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
    Author: Jan Stancek <jstancek@redhat.com>
    Date:   Fri Sep 20 19:52:48 2024 +0300

        sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

The changes have been tested with the FIT signature verification vboot
tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
Engine library installed and with the Provider API.

Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---
Changes in v4:
- Add comment that @engine pointer is null when using pkcs11 provider
- Remove extra line break
- Add pkcs11-provider package to build dependencies
v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat.com/

Changes in v3:
- Removed Kconfig option
- Changed macro symbol from CONFIG_OPENSSL_NO_DEPRECATED to
    USE_PKCS11_PROVIDER or USE_PKCS11_ENGINE
v2: https://lore.kernel.org/u-boot/20251027195834.71109-1-ekovsky@redhat.com/

Changes in v2:
- Remove default for new Kconfig option
- Use #ifdef instead of IS_ENABLED macro
- Remove comment after #endif
- Remove unrelated checkpatch cleanup of 'sslErr' variable name
v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
---
 doc/build/gcc.rst       |   4 +-
 lib/aes/aes-encrypt.c   |   4 +-
 lib/rsa/rsa-sign.c      | 102 ++++++++++++++++++++++++++++++++++++++--
 tools/docker/Dockerfile |   1 +
 4 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 1fef718ceecb..29a6a632e7e3 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -25,8 +25,8 @@ Depending on the build targets further packages maybe needed
 
     sudo apt-get install bc bison build-essential coccinelle \
       device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
-      libgnutls28-dev libguestfs-tools libncurses-dev \
-      libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
+      libgnutls28-dev libguestfs-tools libncurses-dev libpython3-dev \
+      libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl pkcs11-provider \
       pkg-config python3 python3-asteval python3-coverage python3-filelock \
       python3-pkg-resources python3-pycryptodome python3-pyelftools \
       python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
index 90e1407b4f09..4fc4ce232478 100644
--- a/lib/aes/aes-encrypt.c
+++ b/lib/aes/aes-encrypt.c
@@ -16,7 +16,9 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
-#include <openssl/engine.h>
+#if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+# include <openssl/engine.h>
+#endif
 #include <uboot_aes.h>
 
 #if OPENSSL_VERSION_NUMBER >= 0x10000000L
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 0e38c9e802fd..f456f3c58e65 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -19,7 +19,47 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
-#include <openssl/engine.h>
+#if OPENSSL_VERSION_MAJOR >= 3
+# define USE_PKCS11_PROVIDER
+# include <err.h>
+# include <openssl/provider.h>
+# include <openssl/store.h>
+#else
+# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
+#  define USE_PKCS11_ENGINE
+#  include <openssl/engine.h>
+# endif
+#endif
+
+#ifdef USE_PKCS11_PROVIDER
+#define ERR(cond, fmt, ...)				\
+	do {						\
+		bool __cond = (cond);			\
+		drain_openssl_errors(__LINE__, 0);	\
+		if (__cond) {				\
+			errx(1, fmt, ## __VA_ARGS__);	\
+		}					\
+	} while (0)
+
+static void drain_openssl_errors(int l, int silent)
+{
+	const char *file;
+	char buf[120];
+	int e, line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	if (!silent)
+		fprintf(stderr, "At main.c:%d:\n", l);
+
+	while ((e = ERR_peek_error_line(&file, &line))) {
+		ERR_error_string(e, buf);
+		if (!silent)
+			fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+		ERR_get_error();
+	}
+}
+#endif
 
 static int rsa_err(const char *msg)
 {
@@ -94,10 +134,11 @@ err_cert:
  *
  * @keydir:	Key prefix
  * @name	Name of key
- * @engine	Engine to use
+ * @engine	Engine to use or NULL when using pkcs11 provider
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 				  ENGINE *engine, EVP_PKEY **evpp)
 {
@@ -157,21 +198,24 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_pub_key() - read a public key
  *
  * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
  * @name	Name of key file (will have a .crt extension)
- * @engine	Engine to use
+ * @engine	Engine to use or NULL when using pkcs11 provider
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
 static int rsa_get_pub_key(const char *keydir, const char *name,
 			   ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifdef USE_PKCS11_ENGINE
 	if (engine)
 		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
+#endif
 	return rsa_pem_get_pub_key(keydir, name, evpp);
 }
 
@@ -207,13 +251,44 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 		return -ENOENT;
 	}
 
+#ifdef USE_PKCS11_PROVIDER
+	EVP_PKEY *private_key = NULL;
+	OSSL_STORE_CTX *store;
+
+	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
+		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
+	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
+		ERR(1, "OSSL_PROVIDER_try_load(default)");
+
+	store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
+	ERR(!store, "OSSL_STORE_open");
+
+	while (!OSSL_STORE_eof(store)) {
+		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
+
+		if (!info) {
+			drain_openssl_errors(__LINE__, 0);
+			continue;
+		}
+		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
+			private_key = OSSL_STORE_INFO_get1_PKEY(info);
+			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
+		}
+		OSSL_STORE_INFO_free(info);
+		if (private_key)
+			break;
+	}
+	OSSL_STORE_close(store);
+
+	*evpp = private_key;
+#else
 	if (!PEM_read_PrivateKey(f, evpp, NULL, path)) {
 		rsa_err("Failure reading private key");
 		fclose(f);
 		return -EPROTO;
 	}
 	fclose(f);
-
+#endif
 	return 0;
 }
 
@@ -226,6 +301,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 				   const char *keyfile,
 				   ENGINE *engine, EVP_PKEY **evpp)
@@ -293,22 +369,25 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_priv_key() - read a private key
  *
  * @keydir:	Directory containing the key (PEM file) or key prefix (engine)
  * @name	Name of key
- * @engine	Engine to use for signing
+ * @engine	Engine to use or NULL when using pkcs11 provider
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
 static int rsa_get_priv_key(const char *keydir, const char *name,
 			    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifdef USE_PKCS11_ENGINE
 	if (engine)
 		return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
 					       evpp);
+#endif
 	return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);
 }
 
@@ -325,6 +404,7 @@ static int rsa_init(void)
 	return 0;
 }
 
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_init(const char *engine_id, ENGINE **pe)
 {
 	const char *key_pass;
@@ -380,6 +460,7 @@ static void rsa_engine_remove(ENGINE *e)
 		ENGINE_free(e);
 	}
 }
+#endif
 
 static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 			     struct checksum_algo *checksum_algo,
@@ -480,11 +561,13 @@ int rsa_sign(struct image_sign_info *info,
 	if (ret)
 		return ret;
 
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id) {
 		ret = rsa_engine_init(info->engine_id, &e);
 		if (ret)
 			return ret;
 	}
+#endif
 
 	ret = rsa_get_priv_key(info->keydir, info->keyname, info->keyfile,
 			       e, &pkey);
@@ -496,16 +579,21 @@ int rsa_sign(struct image_sign_info *info,
 		goto err_sign;
 
 	EVP_PKEY_free(pkey);
+
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 
 	return ret;
 
 err_sign:
 	EVP_PKEY_free(pkey);
 err_priv:
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 	return ret;
 }
 
@@ -645,11 +733,13 @@ int rsa_add_verify_data(struct image_sign_info *info, void *keydest)
 	ENGINE *e = NULL;
 
 	debug("%s: Getting verification data\n", __func__);
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id) {
 		ret = rsa_engine_init(info->engine_id, &e);
 		if (ret)
 			return ret;
 	}
+#endif
 	ret = rsa_get_pub_key(info->keydir, info->keyname, e, &pkey);
 	if (ret)
 		goto err_get_pub_key;
@@ -726,8 +816,10 @@ done:
 err_get_params:
 	EVP_PKEY_free(pkey);
 err_get_pub_key:
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 
 	if (ret)
 		return ret;
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 73bf6cdd2c52..50e98e83dc20 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -122,6 +122,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	openssl \
 	picocom \
 	parted \
+	pkcs11-provider \
 	pkg-config \
 	python-is-python3 \
 	python3 \
-- 
2.53.0

