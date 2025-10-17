Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3860DCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 21:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838038382E;
	Fri, 17 Oct 2025 23:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ST/YS2dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4A283885; Fri, 17 Oct 2025 19:13:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE56083849
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 19:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760721228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c1Gn8T779ZJkrMKF5GXyVeIf55xA0YsVYhUnsLnDV3o=;
 b=ST/YS2djnxMHSXthQKoZKfhDmSEIm1s5CBOpiodYUeNjJRRK7vcbrcabO0xQjzSOHvRUFn
 WXpwTSKHJ97/m7A+uoZ8TqFoHS75wvsJGoxdB1Qp252JmsGsCbisHpA+/UT79tpNaFqmBq
 iA8CBWzYHiWzxj7WeJ3w4Mxb8whzybU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-7V1owxB-Pt-0FS-zryjk3A-1; Fri, 17 Oct 2025 13:13:47 -0400
X-MC-Unique: 7V1owxB-Pt-0FS-zryjk3A-1
X-Mimecast-MFC-AGG-ID: 7V1owxB-Pt-0FS-zryjk3A_1760721227
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87c1ed305b4so52573346d6.2
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 10:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760721227; x=1761326027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1Gn8T779ZJkrMKF5GXyVeIf55xA0YsVYhUnsLnDV3o=;
 b=HwhbWPLbL/fWChyXcwGmIg8ZN4HrQ9sToCYkqmYaWWdZMqmqbIVOHGckSwQWBzFB39
 XlBAo6rpTVQ5ks1raZQb42SOggODc2r9faMmksg9MiPgNxkrNwZ0uHF20N8QLTjvsYeo
 61pgUaJZLV+eiQ+4rYrYeRHlmkw/Hoy0jwkbv+1aMtU/KO0oVvWjsQ+iXwEbEqZHCuCV
 4gfxlYFm7Kf9ShIzo2JL6eFAE8qQrc6D09TXodg6ELy6RGHZAGXLygz0CEBURui8uzmY
 Z2gxKpjp0faUptCIcf/lWUrFtDINwnQ7gSNoDAww0oIGAyCwiOsrqTZx/mc4YywUopDg
 8Trg==
X-Gm-Message-State: AOJu0Yz5gHZSCB4hkiQexd/q8FyTnDQ2d/wou0cpxZGYYhBMfECRwu1i
 B8lGa4Jb3GI6ZAvJ/dlGHDa+QFn9q7NHMtK3F0FWG0SvfObSfqK1zKw98QwwuX9P3Pjz+0T6JX0
 MPt2T4yZ5cLOLvqG1MpgoyCHGzI+gJIsy8YJG9zMbQHNtt508Ay7PI1s=
X-Gm-Gg: ASbGncv/aJe2/PLRYEkmpE2DZSgt2cbrpLYZRro6dxw9CcGVEFYPTXYivgKFIWcFMOC
 yzSAc7vFgbwRE+jaxrKWpUURSbfqyjNY/c2UmEJYnQmHyUKRMXl7PX5WUTVCdo8rdRFVGT808fq
 J0pxPnYo4eag+A6CB/Kh71VpnEYSot96SFk9Vpgq7nXpBm/nn4svB2s4NNuMVpcO9tg771rHV1c
 kBsgBEAopvwFfYP1o6AX8IoFk0fSW+MQt1564OjnMSYdzmhjCyrqQHXQU2ShTexAyeLO6AtDhkq
 c9uaYbRdgsU0dQbfLhB/lkfWFqkpNrdV8TuARQZ8kWF6/5vb9pBCsd0Plr5oYgjEm3v6mA==
X-Received: by 2002:a05:6214:2aaa:b0:77d:bc4e:e0e5 with SMTP id
 6a1803df08f44-87c2070eb33mr76514926d6.14.1760721226615; 
 Fri, 17 Oct 2025 10:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF23lcqY8l9bgWQoRqrYiScd1UqozLuMd40uvrfCH5NnJbxqhU0sTClVt7vZ2SHje5KvC0QOQ==
X-Received: by 2002:a05:6214:2aaa:b0:77d:bc4e:e0e5 with SMTP id
 6a1803df08f44-87c2070eb33mr76514186d6.14.1760721226076; 
 Fri, 17 Oct 2025 10:13:46 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02d8ce5bsm2059076d6.57.2025.10.17.10.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 10:13:45 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>, Loic Poulain <loic.poulain@linaro.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] Add support for OpenSSL Provider API
Date: Fri, 17 Oct 2025 11:13:27 -0600
Message-ID: <20251017171329.255689-1-ekovsky@redhat.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zp6RFC7PZIuNigeRpHrNcmEXaPpY1pyMh4Q6_I3fJfE_1760721227
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Fri, 17 Oct 2025 23:49:48 +0200
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

The Engine API has been deprecated since the release of OpenSSL 3.0. End users
have been advised to migrate to the new Provider interface. Several
distributions have already removed support for engines, which is preventing
U-Boot from being compiled in those environments.

The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the Provider API
while continuing to use the existing Engine API on distros shipping older
releases of OpenSSL.

This is based on similar work contributed by Jan Stancek
updating Linux to use the Provider interface.

    commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
    Author: Jan Stancek <jstancek@redhat.com>
    Date:   Fri Sep 20 19:52:48 2024 +0300

        sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

The changes have been tested with the FIT signature verification vboot tests on
Fedora 42 and Debian 13. All 30 tests pass with both the legacy Engine library
installed and with the Provider API.

Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
---
 lib/aes/aes-encrypt.c |  2 +
 lib/rsa/Kconfig       |  8 ++++
 lib/rsa/rsa-sign.c    | 93 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 2 deletions(-)

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
index 9033384e60a3..622f06f8dba0 100644
--- a/lib/rsa/Kconfig
+++ b/lib/rsa/Kconfig
@@ -20,6 +20,14 @@ config SPL_RSA
 	bool "Use RSA Library within SPL"
 	depends on SPL
 
+config OPENSSL_NO_DEPRECATED
+	bool "Build U-Boot without support for OpenSSL Engine"
+	default n
+	help
+	  Add support for the OpenSSL Provider API, which is the officially
+	  supported mechanism in OpenSSL 3.x and later releases for accessing
+	  hardware and software cryptography.
+
 config SPL_RSA_VERIFY
 	bool
 	depends on SPL_RSA
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 92b9d7876e52..9ebbcdfd52f3 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -19,15 +19,51 @@
 #include <openssl/err.h>
 #include <openssl/ssl.h>
 #include <openssl/evp.h>
+#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
+#include <err.h>
+#include <openssl/provider.h>
+#include <openssl/store.h>
+#else
 #include <openssl/engine.h>
+#endif // CONFIG_OPENSSL_NO_DEPRECATED
+
+#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
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
+#endif // CONFIG_OPENSSL_NO_DEPRECATED
 
 static int rsa_err(const char *msg)
 {
-	unsigned long sslErr = ERR_get_error();
+	unsigned long ssl_err = ERR_get_error();
 
 	fprintf(stderr, "%s", msg);
 	fprintf(stderr, ": %s\n",
-		ERR_error_string(sslErr, 0));
+		ERR_error_string(ssl_err, 0));
 
 	return -1;
 }
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
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
 
 /**
  * rsa_get_pub_key() - read a public key
@@ -170,8 +208,10 @@ static int rsa_engine_get_pub_key(const char *keydir, const char *name,
 static int rsa_get_pub_key(const char *keydir, const char *name,
 			   ENGINE *engine, EVP_PKEY **evpp)
 {
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (engine)
 		return rsa_engine_get_pub_key(keydir, name, engine, evpp);
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
 	return rsa_pem_get_pub_key(keydir, name, evpp);
 }
 
@@ -207,6 +247,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
 		return -ENOENT;
 	}
 
+#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
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
 
+#endif // CONFIG_OPENSSL_NO_DEPRECATED
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
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
 
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
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
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
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
 
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
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
 
 	ret = rsa_get_priv_key(info->keydir, info->keyname, info->keyfile,
 			       e, &pkey);
@@ -496,16 +576,21 @@ int rsa_sign(struct image_sign_info *info,
 		goto err_sign;
 
 	EVP_PKEY_free(pkey);
+
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
 
 	return ret;
 
 err_sign:
 	EVP_PKEY_free(pkey);
 err_priv:
+#ifndef CONFIG_OPENSSL_NO_DEPRECATED
 	if (info->engine_id)
 		rsa_engine_remove(e);
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
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
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
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
+#endif // !CONFIG_OPENSSL_NO_DEPRECATED
 
 	if (ret)
 		return ret;
-- 
2.51.0

