Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC4CCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 19:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05216838F3;
	Mon, 27 Oct 2025 20:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="LjSfPHp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C57C838F8; Mon, 27 Oct 2025 20:59:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDB2838E7
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 20:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761595145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r5vPbI9WdXxjrrMMocQIBBcA1EZjhEOfAGcfgnmWMF8=;
 b=LjSfPHp/G4Jli4qcFDzY4uuw40O13+bNQXw/JwPjibjY23ma8BOiNr9Yd3C1woCe/eJH1k
 skG+A1KFiXTZIfelpzhH4UZ5uyciEHe96J5QbqFIZQzyuYURUE6sjQcYZFyJelwPCOB50v
 jE6en8NnJhvgdK2xCbV39LfO0DsdisA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-l2z0Ahv0P2WUSIGCrHujaw-1; Mon, 27 Oct 2025 15:59:04 -0400
X-MC-Unique: l2z0Ahv0P2WUSIGCrHujaw-1
X-Mimecast-MFC-AGG-ID: l2z0Ahv0P2WUSIGCrHujaw_1761595144
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-89fcdd9f931so227251685a.1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761595144; x=1762199944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r5vPbI9WdXxjrrMMocQIBBcA1EZjhEOfAGcfgnmWMF8=;
 b=NBdm8Y+QU/F3n99VGM4AOf3FUpfu6G/MmKD2N8cSOAyUAGKflGOnKqsY6pP54YOGCx
 ZAJcsxc5hQnYxja2c7cU7yUoo7mYEL2/spLZzmwavjulgwVtl2GoAJ+nBST+MNHXg4tE
 3mljxyZ3JVPSEj9O07x8U2dNx9rYkqYIkDtPpy913aJ1cx7X7ug9RrEzLbx3IC+Jqy0e
 f7Up7OJqEB+1WEMUDRkZ6ZJkMxPNYqJqhOJYx1TT/Z9CRnp/tOoJlwxlxJZBxW2UUAU8
 sL89B8S0h9dDouyMEfbkO/AIeG3pJzJAYe8SmogjT0iF1SBQEsm2B5c8g59fv1bV5nuj
 37mA==
X-Gm-Message-State: AOJu0Yxct0beQMYv5tWzwNLVhCfNQkn0S8dEe42BVnnGSp+rEWjP383+
 xMN7LrMkk6mvkkhC4LQo4CScYeNNp+lQu4dK8b4t7xCwnGHDV2CjHE46zQb9EcMiBCGU8i2tjcY
 pkYmBjLKJteSLuwFAbHli4KBoxJl3v/pD0tVRcTFKsYnC5wJodHKaXxg=
X-Gm-Gg: ASbGncsG76Ws4lrcLtWT5BRRPGqA0rrvw6QLD1hOdFJZWx/OeMJN1gRF4BMOh+JakV4
 oya/ZSsvIUhJPrthqqjya3GxofFRjtSu6pi6+IDKGAfzyzAwfKJ46An6pdURCHHVc2MY8k1sYv3
 agnQAbVwuKNhbpQt5J52H9zHXe19373TO3kR22Y3sk+Qq1ys3IzTXdqgDl7EcAF7CTcEX4FX9xX
 2PdUTJM1xBJ/17HSzx+y50q+JF542SfTgckztvomtfQPpMDxFZGQHQmU+D6SLzknLmrXrmprRiM
 eLcH7ii5uJ306xwMJQN6yuZWXf6mFuqST1GC5O2oJMY3p9oQ8uea5KmzaJqr+EyQ/6tWrg==
X-Received: by 2002:ac8:5ad0:0:b0:4c3:b7b0:3317 with SMTP id
 d75a77b69052e-4ed075cdb2emr17125401cf.42.1761595143843; 
 Mon, 27 Oct 2025 12:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/0yehY7SA4sggphrBCgih4T/4jaxAhQOxMcrUtgjnM9Y1J/TUCZ7P06+7DM83eArDCR2FDg==
X-Received: by 2002:ac8:5ad0:0:b0:4c3:b7b0:3317 with SMTP id
 d75a77b69052e-4ed075cdb2emr17125001cf.42.1761595143223; 
 Mon, 27 Oct 2025 12:59:03 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba37d72ecsm58447491cf.9.2025.10.27.12.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 12:59:02 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] Add support for OpenSSL Provider API
Date: Mon, 27 Oct 2025 13:58:23 -0600
Message-ID: <20251027195834.71109-1-ekovsky@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gLFtAqS21_CsIWHSDEHmuwdHnWSJOCB49JCdSaSsr4w_1761595144
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Mon, 27 Oct 2025 20:59:16 +0100
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

The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the
Provider API while continuing to use the existing Engine API on distros
shipping older releases of OpenSSL.

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
Changes in v2:
  - Remove default for new Kconfig option
  - Use #ifdef instead of IS_ENABLED macro
  - Remove comment after #endif
  - Remove unrelated checkpatch cleanup of 'sslErr' variable name
v1: https://lore.kernel.org/u-boot/20251017171329.255689-1-ekovsky@redhat.com/
---
 lib/aes/aes-encrypt.c |  2 +
 lib/rsa/Kconfig       |  7 ++++
 lib/rsa/rsa-sign.c    | 89 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/lib/aes/aes-encrypt.c b/lib/aes/aes-encrypt.c
index 90e1407b4f09..9595772cf58b 100644
--- a/lib/aes/aes-encrypt.c
+++ b/lib/aes/aes-encrypt.c
@@ -16,7 +16,9 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 #include <openssl/engine.h>
+#endif
 #include <uboot_aes.h>
 
 #if OPENSSL_VERSION_NUMBER >= 0x10000000L
diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
index 9033384e60a3..1bf0ac96d598 100644
--- a/lib/rsa/Kconfig
+++ b/lib/rsa/Kconfig
@@ -20,6 +20,13 @@ config SPL_RSA
 	bool "Use RSA Library within SPL"
 	depends on SPL
 
+config OPENSSL_NO_DEPRECATED
+	bool "Build U-Boot without support for OpenSSL Engine"
+	help
+	  Add support for the OpenSSL Provider API, which is the officially
+	  supported mechanism in OpenSSL 3.x and later releases for accessing
+	  hardware and software cryptography.
+
 config SPL_RSA_VERIFY
 	bool
 	depends on SPL_RSA
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 92b9d7876e52..1e874de6ba98 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -19,7 +19,43 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
+#ifdef CONFIG_OPENSSL_NO_DEPRECATED
+#include <err.h>
+#include <openssl/provider.h>
+#include <openssl/store.h>
+#else
 #include <openssl/engine.h>
+#endif
+
+#ifdef CONFIG_OPENSSL_NO_DEPRECATED
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
@@ -98,6 +134,7 @@ err_cert:
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 				  ENGINE *engine, EVP_PKEY **evpp)
 {
@@ -157,6 +194,7 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_pub_key() - read a public key
@@ -170,8 +208,10 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 static int rsa_get_pub_key(const char *keydir, const char *name,
 			   ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (engine)
 		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
+#endif
 	return rsa_pem_get_pub_key(keydir, name, evpp);
 }
 
@@ -207,6 +247,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 		return -ENOENT;
 	}
 
+#ifdef CONFIG_OPENSSL_NO_DEPRECATED
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
@@ -214,6 +285,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 	}
 	fclose(f);
 
+#endif
 	return 0;
 }
 
@@ -226,6 +298,7 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
  * @evpp	Returns EVP_PKEY object, or NULL on failure
  * Return: 0 if ok, -ve on error (in which case *evpp will be set to NULL)
  */
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 				   const char *keyfile,
 				   ENGINE *engine, EVP_PKEY **evpp)
@@ -293,6 +366,7 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 
 	return 0;
 }
+#endif
 
 /**
  * rsa_get_priv_key() - read a private key
@@ -306,9 +380,11 @@ static int rsa_engine_get_priv_key(const char *keydir, const char *name,
 static int rsa_get_priv_key(const char *keydir, const char *name,
 			    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (engine)
 		return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
 					       evpp);
+#endif
 	return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);
 }
 
@@ -325,6 +401,7 @@ static int rsa_init(void)
 	return 0;
 }
 
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 static int rsa_engine_init(const char *engine_id, ENGINE **pe)
 {
 	const char *key_pass;
@@ -380,6 +457,7 @@ static void rsa_engine_remove(ENGINE *e)
 		ENGINE_free(e);
 	}
 }
+#endif
 
 static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 			     struct checksum_algo *checksum_algo,
@@ -480,11 +558,13 @@ int rsa_sign(struct image_sign_info *info,
 	if (ret)
 		return ret;
 
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (info->engine_id) {
 		ret = rsa_engine_init(info->engine_id, &e);
 		if (ret)
 			return ret;
 	}
+#endif
 
 	ret = rsa_get_priv_key(info->keydir, info->keyname, info->keyfile,
 			       e, &pkey);
@@ -496,16 +576,21 @@ int rsa_sign(struct image_sign_info *info,
 		goto err_sign;
 
 	EVP_PKEY_free(pkey);
+
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 
 	return ret;
 
 err_sign:
 	EVP_PKEY_free(pkey);
 err_priv:
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 	return ret;
 }
 
@@ -645,11 +730,13 @@ int rsa_add_verify_data(struct image_sign_info *info, void *keydest)
 	ENGINE *e = NULL;
 
 	debug("%s: Getting verification data\n", __func__);
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (info->engine_id) {
 		ret = rsa_engine_init(info->engine_id, &e);
 		if (ret)
 			return ret;
 	}
+#endif
 	ret = rsa_get_pub_key(info->keydir, info->keyname, e, &pkey);
 	if (ret)
 		goto err_get_pub_key;
@@ -726,8 +813,10 @@ done:
 err_get_params:
 	EVP_PKEY_free(pkey);
 err_get_pub_key:
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif
 
 	if (ret)
 		return ret;
-- 
2.51.0

