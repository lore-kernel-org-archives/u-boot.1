Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C0FCA5FB1
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6C183A6A;
	Tue, 20 Jan 2026 17:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NKaSCnyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5058283A8D; Tue, 20 Jan 2026 17:46:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3A483A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 17:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768927587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cAEJZF+QDDHpnAM/5fZ8D39esiLr4s6IwFfLjsvzafQ=;
 b=NKaSCnyGcohoJFNdWLwcJAy9CXSKGGC7bwj0Ncb4GgN0KvJiD5iMxcNpayCIXcp++FAo/v
 OeVAp/RLMFxxhvj3/nVTNvJJ6KOC92ibajYvi5vOXIguwqMxXVdSkWTpOG9cWpnYRuTI8y
 CkTVCx/+Z+W/d0vYiOfwKJ0tNA0yZ2E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-eLtWLmd9Oo666Du7wsZhDA-1; Tue, 20 Jan 2026 11:46:26 -0500
X-MC-Unique: eLtWLmd9Oo666Du7wsZhDA-1
X-Mimecast-MFC-AGG-ID: eLtWLmd9Oo666Du7wsZhDA_1768927586
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a316ddbacso130763396d6.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 08:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768927586; x=1769532386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAEJZF+QDDHpnAM/5fZ8D39esiLr4s6IwFfLjsvzafQ=;
 b=S/OzKs8dMp+dlFE8X08C9jpY5CV/aZwKUXBtYy63fvdfNH+B66+LmHZJw9k4T/98nI
 SCuru16QLs4+7P6L4OmpnZPBf829voU+xoUTGAVNwpLu7j480gNMiKLmlnp7UvWGpfyi
 0+z3YBPC0FwWnqDKkeriIA7GbIV7sUgWX9RAlb9Jn0dxa60i7SEP8gCXbiTVw89Jx0HF
 8ipUXOJ1fosBxNdYxAd0jBaqj9Im0bRdkCZGRYwpCpqJOI5wtRXDB37YYZrQ4fg3F+vm
 OzvjCKQtcHpx3Jcdk+wd2Z+UH3JpzDgybaQLa4i5GYAnX8gsf2TwT7mRir6bjyd6NytB
 Wq6Q==
X-Gm-Message-State: AOJu0YyBC5LzOaQZ0oXu1lO0v7yMEYi65mVM7G+kyztmQq5BQ6TVqrU1
 LeneLX7LzSpGO1+sIb8/2W6NWZZNjSHtvyq9NlZSLmbTxuu/xLkPoJD2TlCUAefhJSIfc7fFm9d
 WdVGQQEgRFFXnrqUKaVqQR4Bhx6uHWXeDi+S9IjmqnLhrUn+a84cJaTE=
X-Gm-Gg: AZuq6aKtH/UD6inSgy5gE74hgKtcoiWkZXswrMCAimjIoQtJF6+w8IP1Q4Pt3Uvsf2N
 61/WBWUXEcDf2ewa3klBzqqvFUrt7BfHjx0mY94IcOOJydaCKT5JkhPykWBv7hsZEZweYNVINbf
 9iFJ+dW2VLaNzJHS/DgcVMkmdZmaW0w4s3HpcnksgX0hbjOlvWXu1AQlN8NfFeAr+xy9ayrvTED
 AtXTXHHvosq1HJ+qG/jNrkxeabxgUcb4R6Wa/rBMqLLSSrgfB5JJrMe8s+GTqXMCIH97ykHRpB3
 iJP6kS6ukIy/hw1u5aqgreKw+lny+kuJNIkVwAJOVRr+aU0/wh//H6rfX2082lcj5Ytp6l6PSXJ
 wJEW1
X-Received: by 2002:a05:6214:414:b0:888:8096:a09c with SMTP id
 6a1803df08f44-8942ddcc5d3mr193398456d6.62.1768927585655; 
 Tue, 20 Jan 2026 08:46:25 -0800 (PST)
X-Received: by 2002:a05:6214:414:b0:888:8096:a09c with SMTP id
 6a1803df08f44-8942ddcc5d3mr193398106d6.62.1768927585160; 
 Tue, 20 Jan 2026 08:46:25 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8942e6ad8b0sm111143026d6.28.2026.01.20.08.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 08:46:24 -0800 (PST)
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3] Add support for OpenSSL Provider API
Date: Tue, 20 Jan 2026 09:45:20 -0700
Message-ID: <20260120164524.253188-1-ekovsky@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -cLAdNroXNqhIS7hpoEKg_lMhjmNwhg56AX8MnOCXMw_1768927586
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Tue, 20 Jan 2026 17:51:18 +0100
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

Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---
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
 lib/aes/aes-encrypt.c |  4 +-
 lib/rsa/rsa-sign.c    | 95 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 2 deletions(-)

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
index 0e38c9e802fd..31269db65950 100644
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
@@ -98,6 +138,7 @@ err_cert:
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 				  ENGINE *engine, EVP_PKEY **evpp)
 {
@@ -157,6 +198,7 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_pub_key() - read a public key
@@ -170,8 +212,10 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 static int rsa_get_pub_key(const char *keydir, const char *name,
 			   ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifdef USE_PKCS11_ENGINE
 	if (engine)
 		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
+#endif
 	return rsa_pem_get_pub_key(keydir, name, evpp);
 }
 
@@ -207,6 +251,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
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
@@ -214,6 +289,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 	}
 	fclose(f);
 
+#endif
 	return 0;
 }
 
@@ -226,6 +302,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 				   const char *keyfile,
 				   ENGINE *engine, EVP_PKEY **evpp)
@@ -293,6 +370,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_priv_key() - read a private key
@@ -306,9 +384,11 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
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
 
@@ -325,6 +405,7 @@ static int rsa_init(void)
 	return 0;
 }
 
+#ifdef USE_PKCS11_ENGINE
 static int rsa_engine_init(const char *engine_id, ENGINE **pe)
 {
 	const char *key_pass;
@@ -380,6 +461,7 @@ static void rsa_engine_remove(ENGINE *e)
 		ENGINE_free(e);
 	}
 }
+#endif
 
 static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 			     struct checksum_algo *checksum_algo,
@@ -480,11 +562,13 @@ int rsa_sign(struct image_sign_info *info,
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
@@ -496,16 +580,21 @@ int rsa_sign(struct image_sign_info *info,
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
 
@@ -645,11 +734,13 @@ int rsa_add_verify_data(struct image_sign_info *info, void *keydest)
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
@@ -726,8 +817,10 @@ done:
 err_get_params:
 	EVP_PKEY_free(pkey);
 err_get_pub_key:
+#ifdef USE_PKCS11_ENGINE
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 
 	if (ret)
 		return ret;
-- 
2.52.0

