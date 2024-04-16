Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D903AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B60EE88444;
	Tue, 16 Apr 2024 21:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W9UYNL8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D952D8844E; Tue, 16 Apr 2024 21:02:16 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589038840D
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-696315c9da5so41494156d6.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294119; x=1713898919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDcoGpme0i20x+e7NX8RnuWSv8WiO3PY0LNW0U/aXNA=;
 b=W9UYNL8YAM2xn1Q1QLLde98Qwpict6o1aAVJCEk8SSa31M/THpHaUCuO3ULw7cKLjV
 sLOmKVIPhqlS2gMw/7xzZWiUE88du2I2+d/+VA/ddzJ7I7DAvBOMLNfudIvfL6bk+rBh
 SDQTGH86Lh3/IJulHiwm8VpRb4xSX2likFusuhJOBcFMQ6PhN/t6u3t6k88diT2SoR76
 h87Z32dL28woIDEHU0QmjjIZztFHwMzeluPTOqn+Zrua3NwqhfTkqNtCNGzdnkr40nIm
 OSEcmi3Ej8nv/PQr4FCtpG434MbLETiVSOsRH+3LQAtMzuqtEh5IBTEcm+7UysU8j/42
 a8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294119; x=1713898919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDcoGpme0i20x+e7NX8RnuWSv8WiO3PY0LNW0U/aXNA=;
 b=g9wX9KL3aJPVye+67tATZ/jPBQlcNofcExet0v+CK0STvH65OdDdOetqIDCe0nEXrC
 okTOSVn/l/+Jle3yJQdbXbNW+dYcLUbgiIHFvfLIRHqHDknr7KZ3ShZ4KyXQp4FQHr9/
 aWJ+V70I8MiJwYRGQ9njdqQX4HzmLolBRgvcows3mD2Lqk1L+1/cmN9CaPF6bwknnLia
 qqv7swaL4iQILnbsXVeazgwZxl6vJ50YHknkLuxqu5nhTYILB/HEbxEF+fRIbSsvk3kJ
 qLYeT+03EBPGXvX/wAzwRwOT2lgJ1Oslb8XMWR5AZFTT+TeN6ldDCPy1sKQvRASkFuM7
 9ICw==
X-Gm-Message-State: AOJu0Yy6vBuYwTAlyo5ksJvD6Ryq9PpP14/Qq/euHaQoPDeHMY7GvVPR
 feZdjqL8PE/bXtwgzP18pkoYFIqnzKozwnkjkS9KXu584im8/euKdHYU8nHbIH0xtEogmFUEQFc
 Y
X-Google-Smtp-Source: AGHT+IGhwK11X9g3GJjT8hrOAuDOU0X5Go7tjZtGLmr93K9VEs4YSzovwN4otH+Giod0ciB5vqtZXg==
X-Received: by 2002:a05:6214:138c:b0:69b:3334:dc3a with SMTP id
 pp12-20020a056214138c00b0069b3334dc3amr13360760qvb.12.1713294119675; 
 Tue, 16 Apr 2024 12:01:59 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:59 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 14/23] mbedtls/external: support PKCS9 Authenticate Attributes
Date: Tue, 16 Apr 2024 12:00:10 -0700
Message-Id: <20240416190019.81016-15-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Populate PKCS9 Authenticate Attributes from signer info if it exists
in a PKCS7 message.
Add OIDs for describing objects using for Authenticate Attributes.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 .../external/mbedtls/include/mbedtls/oid.h    |  5 +++++
 .../external/mbedtls/include/mbedtls/pkcs7.h  | 11 +++++++++++
 lib/mbedtls/external/mbedtls/library/pkcs7.c  | 19 ++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
index 2ee982808f..43cef99f1e 100644
--- a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
+++ b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
@@ -238,6 +238,11 @@
 #define MBEDTLS_OID_RSA_SHA_OBS         "\x2B\x0E\x03\x02\x1D"
 
 #define MBEDTLS_OID_PKCS9_EMAIL         MBEDTLS_OID_PKCS9 "\x01" /**< emailAddress AttributeType ::= { pkcs-9 1 } */
+#define MBEDTLS_OID_PKCS9_CONTENTTYPE   MBEDTLS_OID_PKCS9 "\x03" /**< contentType AttributeType ::= { pkcs-9 3 } */
+#define MBEDTLS_OID_PKCS9_MESSAGEDIGEST MBEDTLS_OID_PKCS9 "\x04" /**< messageDigest AttributeType ::= { pkcs-9 4 } */
+#define MBEDTLS_OID_PKCS9_SIGNINGTIME   MBEDTLS_OID_PKCS9 "\x05" /**< signingTime AttributeType ::= { pkcs-9 5 } */
+#define MBEDTLS_OID_PKCS9_SMIMECAP      MBEDTLS_OID_PKCS9 "\x0f" /**< smimeCapabilites AttributeType ::= { pkcs-9 15 } */
+#define MBEDTLS_OID_PKCS9_SMIMEAA       MBEDTLS_OID_PKCS9 "\x10\x02\x0b" /**< smimeCapabilites AttributeType ::= { pkcs-9 16 2 11} */
 
 /* RFC 4055 */
 #define MBEDTLS_OID_RSASSA_PSS          MBEDTLS_OID_PKCS1 "\x0a" /**< id-RSASSA-PSS ::= { pkcs-1 10 } */
diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
index 9e29b74af7..a88a5e858f 100644
--- a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
+++ b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
@@ -102,6 +102,16 @@ typedef enum {
 }
 mbedtls_pkcs7_type;
 
+/*
+ * Authenticate Attributes for MicroSoft Authentication Code using in U-Boot
+ * Secure Boot
+ */
+typedef struct mbedtls_pkcs7_authattrs {
+    size_t data_len;
+    void *data;
+}
+mbedtls_pkcs7_authattrs;
+
 /**
  * Structure holding PKCS #7 signer info
  */
@@ -113,6 +123,7 @@ typedef struct mbedtls_pkcs7_signer_info {
     mbedtls_x509_buf MBEDTLS_PRIVATE(alg_identifier);
     mbedtls_x509_buf MBEDTLS_PRIVATE(sig_alg_identifier);
     mbedtls_x509_buf MBEDTLS_PRIVATE(sig);
+    mbedtls_pkcs7_authattrs authattrs;
     struct mbedtls_pkcs7_signer_info *MBEDTLS_PRIVATE(next);
 }
 mbedtls_pkcs7_signer_info;
diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c b/lib/mbedtls/external/mbedtls/library/pkcs7.c
index 0c2436b56b..da73fb341d 100644
--- a/lib/mbedtls/external/mbedtls/library/pkcs7.c
+++ b/lib/mbedtls/external/mbedtls/library/pkcs7.c
@@ -288,6 +288,7 @@ static int pkcs7_get_signer_info(unsigned char **p, unsigned char *end,
     unsigned char *end_signer, *end_issuer_and_sn;
     int asn1_ret = 0, ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
     size_t len = 0;
+    unsigned char *tmp_p;
 
     asn1_ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
                                     | MBEDTLS_ASN1_SEQUENCE);
@@ -349,7 +350,23 @@ static int pkcs7_get_signer_info(unsigned char **p, unsigned char *end,
         goto out;
     }
 
-    /* Assume authenticatedAttributes is nonexistent */
+    /* Save authenticatedAttributes if present */
+    if (*p < end_signer &&
+        **p == (MBEDTLS_ASN1_CONTEXT_SPECIFIC | MBEDTLS_ASN1_CONSTRUCTED | 0)) {
+        tmp_p = *p;
+
+        ret = mbedtls_asn1_get_tag(p, end_signer, &len,
+                                   MBEDTLS_ASN1_CONTEXT_SPECIFIC |
+                                   MBEDTLS_ASN1_CONSTRUCTED | 0);
+        if (ret != 0) {
+            goto out;
+        }
+
+        signer->authattrs.data = tmp_p;
+        signer->authattrs.data_len = len + *p - tmp_p;
+        *p += len;
+    }
+
     ret = pkcs7_get_digest_algorithm(p, end_signer, &signer->sig_alg_identifier);
     if (ret != 0) {
         goto out;
-- 
2.25.1

