Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F860C27C44
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 14:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EED884D1;
	Tue, 28 May 2024 16:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Zmc83zwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80A2884D1; Tue, 28 May 2024 16:14:17 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3460788518
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 16:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-79476195696so53834185a.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905654; x=1717510454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MREQwXaW0lnvWg090XJR2CxjLfAsr4EqNdcsa4sZlS4=;
 b=Zmc83zwDEUZP/FrJJa8/gQQ/eXmXnKQ92EMVfMq27w5Zui07s11MQ4esBqXvpXwYAT
 M39GLr+0liDaGQgNtdy4jDMdaEx8QgIoBm3e9D/BvAH3o/jomaDVk4qVMIXapgOAUb+h
 xD9Z7potzr7Ayuy52Do8/+i7/smRAEFH069/KNRjtUEG5DqwKrp91ZQfd+dDzYZOVebf
 VNmuS285171EDchwNrZNppaibj7dtdrDsh7GdhK5/qiSr+s3o/ZP9JpRVoifwVRZhkG7
 4BgiITzdhDAKJx6bcTBAM7Wwk0Lk03CDmEQxJkrl0JJ+p07Lx/p5l/pShViahh/jYfM/
 RgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905654; x=1717510454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MREQwXaW0lnvWg090XJR2CxjLfAsr4EqNdcsa4sZlS4=;
 b=kzWD01x136VvLQgQ2B/ZaA/eyKuto+kSohZhuVbdSyBoCwPgyK6AOjqEDU8PKWmpG0
 j1KLutwQboiN2yHyClI1UE68inDRTpTMXdje2TbgHVwgf/RcXrolP3rSfnyf9sxq0fnr
 0L+BEXe71LPN1SNxbVvbLRiY7vbvgfdhFJl+dglyRPoaoVn/8QdXcHV8vrfTtAe8V/1W
 d/3L/7XQp4RztjsaEw1vohNganvHMquaLwKEVHD5SggFk0GaQOsrTJUn2ZI27B0tis4W
 IZ+G7O0khLwkxipJbGu+xCDPIpQonxwIZ7Z1NM3gKObAdiYiqMidPLW4rxld5l2XJ/Nu
 e/OA==
X-Gm-Message-State: AOJu0Yx7/nq2g8SKLdxANoha2qamhc3D6NXNhXk3tNb9tACxDd8NoLvq
 o+jnzxqFuHqpgxQpMR5nXh70LLsz7y3c95S0X+OFqOxmGxghOhQ+lwgJw08r+RMGwJimmuyRPmb
 RyiE=
X-Google-Smtp-Source: AGHT+IGRnr1FfnLTKqr5TftrKcWf+wwzcEigp81RuikwF+7wEqhJ6gAWuAdmxIydeBKsDEhvF5vbiQ==
X-Received: by 2002:a05:620a:8:b0:792:faec:3e2e with SMTP id
 af79cd13be357-794ab1248b9mr1156452485a.75.1716905653679; 
 Tue, 28 May 2024 07:14:13 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc5844sm381033685a.53.2024.05.28.07.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:14:13 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v3 11/25] mbedtls/external: support decoding multiple signer's
 cert
Date: Tue, 28 May 2024 07:09:22 -0700
Message-Id: <20240528140955.1960172-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240528140955.1960172-1-raymond.mao@linaro.org>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
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

