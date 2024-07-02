Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7475FC3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C6387D33;
	Tue,  2 Jul 2024 20:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y3AuA/os";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D801687D33; Tue,  2 Jul 2024 20:28:42 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520C287D0A
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-446449e5df5so22112071cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944919; x=1720549719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBkO6mof8pqrxXImXrRflCZDqdhmog3oVk6n6ue+ohc=;
 b=y3AuA/osFTd52E6ctsUtIX/+sTiMeF657swBqV6U6C9NhEfuYIbtQZOnGqhATsDOCL
 Tmc7RKBvey88K1tYuXIUdbptKBRViwo/eORNWMQQ1PjOLeKEB+rAzqdhZDj6AGL+DxmQ
 fX2S6Cb1fGnVWkKJlj9735qJCDpA8kTQ6RvhVwIX3jkNXU7iXX3e+K/QzMd0ngdN7M2d
 Mdx0BodgQIkSLtM39WAiepIpP4/tKVQv0SXNa48homMTe7h9YEfoZHPtHJcaOomx1Q7Q
 M32jgnF7ZInOg5xMEAd0deSfo0PyMpUjEBLfaIXr2JFo2CuTzGB+pS5GdxTOIqikgEy6
 wZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944919; x=1720549719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBkO6mof8pqrxXImXrRflCZDqdhmog3oVk6n6ue+ohc=;
 b=dSwOQmTVilmbAKnETkjK5/jU3aVaXXhZ81zpVUirEDqhDAHs8HTL93DZ7Pj5qj4XOf
 i2ugtZxqiwKYfOP1DIqnLB+xFaI5Ic51phcAHEZApHA22La1IH9EUJKTxDD6w8Er+R/F
 +0c86RQRoQYuAB3T1jsU97qbR6p03ADL3vMT1MGZ8ZSh3GgFuMl4YHBzADioWiOOxXky
 eOgdqRPglf+5yb/4pdEqQAAS+g2YDt7vecpzf9ow/lLaq0UpjQcMCQKaZUaLnScosK9T
 fy4B9196brXTGDG0Z+clKHNimXYw+Aal/QtMygPwnGpOBbTwW3bIiXOWKg9A7/UoytAc
 7cqQ==
X-Gm-Message-State: AOJu0YyHbj2G3cgTOMEueY3JkGgDg41WZsU4rlKqduthMTH1Ez6hP6LY
 nBN1FRqJRLvd4Ol6DwySLjED+p2RRVejiBN8RgbnUrb6sepVeVbLAM+vY5NKrYGCYUJb3tQYitG
 Q
X-Google-Smtp-Source: AGHT+IE35BNGirDYVUxIkU3E+9wXQOUsPtiTumnnSGxDFMOk2sdKY/beGrF5x/AVzT2MCgYeqLzifw==
X-Received: by 2002:ac8:5803:0:b0:441:5994:fd40 with SMTP id
 d75a77b69052e-44662e54497mr98296161cf.61.1719944918974; 
 Tue, 02 Jul 2024 11:28:38 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:28:38 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 12/29] mbedtls/external: support decoding multiple signer's
 cert
Date: Tue,  2 Jul 2024 11:22:48 -0700
Message-Id: <20240702182325.2904421-13-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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

The PR for this patch is at:
https://github.com/Mbed-TLS/mbedtls/pull/9001

For enabling EFI loader PKCS7 features with MbedTLS build,
we need this patch on top of MbedTLS v3.6.0 before it is merged into
the next MbedTLS LTS release.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.
Changes in v3
- Update commit message.
Changes in v4
- None.

 lib/mbedtls/external/mbedtls/library/pkcs7.c | 75 ++++++++++++--------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c b/lib/mbedtls/external/mbedtls/library/pkcs7.c
index da73fb341d6..01105227d7a 100644
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

