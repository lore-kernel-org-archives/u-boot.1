Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CB3C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D128845D;
	Tue, 16 Apr 2024 21:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ppXisE2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8937588433; Tue, 16 Apr 2024 21:02:17 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F97B8844B
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78d62c1e82bso320100485a.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294121; x=1713898921; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lVh+lu6YWOQ0CdOPVEHIkqbxufsS8kAaYJSo9uaIfY=;
 b=ppXisE2z5Mgmr3t84Sr6BUzdpLa1voXHSPRkn6WeHnlyoX0/0C2DL8BuQikmhvH/MO
 auq+Ov3hHJI/ZUmGoBEj+rqkNp4dpaVC2wvmoj36IyV1+MQ8ko6hwqUAdTkVCY6isJbI
 VkHZ3HlOHlefhnR//VnQ1TSUh/ZJ10PpEBmT+gDT55134wmPdClyGTLrPj3Q+D1yio0/
 Kk8mMl/kz96Zs+VcHzqHeSialT6TbiE+G7jDaQ2Qu7BeNum/oZMXcz1fBQhrb5vTFDRl
 ia54yPEkizbGmtgkefbNBaTJOLDZSmU8zVs1eJCbCvtAh8xj8hGOhqZC7qHijoSw08Xt
 sMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294121; x=1713898921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lVh+lu6YWOQ0CdOPVEHIkqbxufsS8kAaYJSo9uaIfY=;
 b=IB7KqNGrYzElUhu1TTrr+ydR2DUB19pRJqfu1ctqb1/v9b7xR8bYuLSyfq+A9817Pa
 1T8o7+KFADuMHlKWoSLnBj11kvRnBkxbh+zdQn8gVTdmbC+bf21iOhCvvQojug/WHSxG
 TXDyIGBWXsQkoS5/aiZDMsNQdS3UZ9J6XjqRPs1ykY+JP+RQotESDTZEVIACPKWcGU06
 T0r807ueNMPx/ns9loc/U/RolnBFlRITRHfgyh3Jjjon9mqrfycK/rOlOYi6i5IqrPpo
 UlzctnRw5/qcdR5eRP+VSl3sEVGibm0tkTLKcPL+PAu6It57pyKyZV+ZmaZXgmsJLubk
 xvpw==
X-Gm-Message-State: AOJu0Yz3FKOdpxRIg/Tik7ZVrUBQcAy0RqkTOuJN+OXXK8n79LtkiVyi
 AKFhyrn9XJ1DWoLSyNz+5jQ03N6jKCJyIv+vDuU3EetpUB7Eq/tn6QewEPax9s44ILYDCd3F/hk
 3
X-Google-Smtp-Source: AGHT+IHi0XsUG4SA5xjAC7cMGYgYO7u5fyKFrW6r0CQ2tKASi2hiRE2b3b8xYjz+V+GXW3U+qsBF6A==
X-Received: by 2002:a0c:ed2b:0:b0:6a0:43e2:6b78 with SMTP id
 u11-20020a0ced2b000000b006a043e26b78mr208856qvq.63.1713294121570; 
 Tue, 16 Apr 2024 12:02:01 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:01 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 15/23] mbedtls/external: support decoding multiple signer's
 cert
Date: Tue, 16 Apr 2024 12:00:11 -0700
Message-Id: <20240416190019.81016-16-raymond.mao@linaro.org>
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

Support decoding multiple signer's cert in the signed data within
a PKCS7 message.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/mbedtls/external/mbedtls/library/pkcs7.c | 75 ++++++++++++--------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c b/lib/mbedtls/external/mbedtls/library/pkcs7.c
index da73fb341d..01105227d7 100644
--- a/lib/mbedtls/external/mbedtls/library/pkcs7.c
+++ b/lib/mbedtls/external/mbedtls/library/pkcs7.c
@@ -61,6 +61,36 @@ static int pkcs7_get_next_content_len(unsigned char **p, unsigned char *end,
     return ret;
 }
 
+/**
+ * Get and decode one cert from a sequence.
+ * Return 0 for success,
+ * Return negative error code for failure.
+ **/
+static int pkcs7_get_one_cert(unsigned char **p, unsigned char *end,
+                              mbedtls_x509_crt *certs)
+{
+    int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
+    size_t len = 0;
+    unsigned char *start = *p;
+    unsigned char *end_cert;
+
+    ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
+                               | MBEDTLS_ASN1_SEQUENCE);
+    if (ret != 0) {
+        return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CERT, ret);
+    }
+
+    end_cert = *p + len;
+
+    if ((ret = mbedtls_x509_crt_parse_der(certs, start, end_cert - start)) < 0) {
+        return MBEDTLS_ERR_PKCS7_INVALID_CERT;
+    }
+
+    *p = end_cert;
+
+    return 0;
+}
+
 /**
  * version Version
  * Version ::= INTEGER
@@ -178,11 +208,12 @@ static int pkcs7_get_certificates(unsigned char **p, unsigned char *end,
                                   mbedtls_x509_crt *certs)
 {
     int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
-    size_t len1 = 0;
-    size_t len2 = 0;
-    unsigned char *end_set, *end_cert, *start;
+    size_t len = 0;
+    unsigned char *end_set;
+    int num_of_certs = 0;
 
-    ret = mbedtls_asn1_get_tag(p, end, &len1, MBEDTLS_ASN1_CONSTRUCTED
+    /* Get the set of certs */
+    ret = mbedtls_asn1_get_tag(p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
                                | MBEDTLS_ASN1_CONTEXT_SPECIFIC);
     if (ret == MBEDTLS_ERR_ASN1_UNEXPECTED_TAG) {
         return 0;
@@ -190,38 +221,26 @@ static int pkcs7_get_certificates(unsigned char **p, unsigned char *end,
     if (ret != 0) {
         return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_FORMAT, ret);
     }
-    start = *p;
-    end_set = *p + len1;
+    end_set = *p + len;
 
-    ret = mbedtls_asn1_get_tag(p, end_set, &len2, MBEDTLS_ASN1_CONSTRUCTED
-                               | MBEDTLS_ASN1_SEQUENCE);
+    ret = pkcs7_get_one_cert(p, end_set, certs);
     if (ret != 0) {
-        return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CERT, ret);
+        return ret;
     }
 
-    end_cert = *p + len2;
+    num_of_certs++;
 
-    /*
-     * This is to verify that there is only one signer certificate. It seems it is
-     * not easy to differentiate between the chain vs different signer's certificate.
-     * So, we support only the root certificate and the single signer.
-     * The behaviour would be improved with addition of multiple signer support.
-     */
-    if (end_cert != end_set) {
-        return MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE;
-    }
-
-    if ((ret = mbedtls_x509_crt_parse_der(certs, start, len1)) < 0) {
-        return MBEDTLS_ERR_PKCS7_INVALID_CERT;
+    while (*p != end_set) {
+        ret = pkcs7_get_one_cert(p, end_set, certs);
+        if (ret != 0) {
+            return ret;
+        }
+        num_of_certs++;
     }
 
-    *p = end_cert;
+    *p = end_set;
 
-    /*
-     * Since in this version we strictly support single certificate, and reaching
-     * here implies we have parsed successfully, we return 1.
-     */
-    return 1;
+    return num_of_certs;
 }
 
 /**
-- 
2.25.1

