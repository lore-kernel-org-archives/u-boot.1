Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0886FC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B6B88757;
	Tue,  7 May 2024 19:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X0sVxakO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF25B887C2; Tue,  7 May 2024 19:57:56 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95423883E8
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6a0ce3e823fso21755296d6.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104673; x=1715709473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgCacqBglHJTQW/GdtqLWBlvm2S5FxWKwc5BwiM5BIA=;
 b=X0sVxakOajtoe/IkqDrnuZrDj3AvGObOPYzfEpWkGYo8sED7zylHtkDEzK3heIAbaz
 x3qUua6YlTK9jhj42i0vP6lTYxme5hYF7qNpzijlA3oz3eeM/e0fll4KRpFLfBbc+a/i
 p/FbUiErYU0CDPUVcVGfmkYHQdMeniqTTxXoBhfsWTjwDn7ypmAbNhfvAd+DLIrj6f+N
 Yk+fMsgNiOyqKMgpnCCJ43vhlhzrLKYOXmDMUBWzScj6oTZn+rYqBtWHFBrR+nfaaJjs
 5B8tGn2r0fiT+w42h8nhSHTt/kqvdLVQCbl506pPT+CQopczL+Pbeg8haALm31zdh3Uw
 lkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104673; x=1715709473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UgCacqBglHJTQW/GdtqLWBlvm2S5FxWKwc5BwiM5BIA=;
 b=IbeyNhd8lOkk0uTaq03U2wZN2jJ04lHea/idlUeZ2GZOSeUR0jjK/d1BnvYTP+OiL6
 1v2+VJHaFtwRkOnvjtVzBM48LQy1yXs8542JkDo9DXmnQ/Fjv602FmP4iJ+9iS34M5/a
 77iCuNouX1l1fHwLY47HyCYyn4GVDrxee+o0UWhYZuLa/o9zTqkxhF23tzWREyzSvW/+
 28ZxlG+Y9KYFBdJCy3Ki4MlABGi8xdHwkKMiNRIUmGT7cnkqnRpXF6q6baU362McC/0c
 DAGMYr4ae0IYZenbEn/RTdAdNAwmFD2EteKPc1/SMmTw43JeaCZkGcsCmFAlA1f/GZgE
 qgHA==
X-Gm-Message-State: AOJu0YzrbgdGzcPpb39XRIvvd65jqNz24lu3Exyv7YzoAKTEmJfHhV+Z
 mRlpGie+VZpQbs9rRuqTc0vNeG7lL1opKHVfNP92vQfnZTM1Bn4OXAs/mnDymgbSdWCA0yOw4Lw
 x
X-Google-Smtp-Source: AGHT+IFVw2tNTDGmUtJtmytKaGguCjlWr9eQVmq8sCRP3bZdSLd3iguWybtm8NF7srCrxC8CcSTvwg==
X-Received: by 2002:a05:6214:d4b:b0:6a0:a745:b2f8 with SMTP id
 6a1803df08f44-6a15145736emr7690386d6.27.1715104673265; 
 Tue, 07 May 2024 10:57:53 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:57:53 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Ilya Lukin <4.shket@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 14/28] mbedtls/external: support decoding multiple signer's
 cert
Date: Tue,  7 May 2024 10:50:56 -0700
Message-Id: <20240507175132.1456512-15-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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
Changes in v2
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

