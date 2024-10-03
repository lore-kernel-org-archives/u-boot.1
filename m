Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49794CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 04:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1560A89032;
	Fri,  4 Oct 2024 06:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kYagFT13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E67788C6D; Thu,  3 Oct 2024 23:56:49 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A90788CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4581ec0e00eso10080721cf.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727992606; x=1728597406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plX8z+lM00jEYmi/LyzdwvevYUziuvwO8TwHiALzRtc=;
 b=kYagFT13iDa74eL3d5IwZeYwZG18FYEvbS1+Z72/W0SIymWjIEuTEM13isly9ZqRnq
 VD1zMGd7QJiISd0BvTSeXISdQDRAgzk/aMHvsgbrBDc/dsRMWZl+LFbou0oWm+J9aB1z
 SIr+KvhrMs63yt+e/Lfy0OJsz3ewUGfdnwleU3kgmNcUH80IWWaD0Ek6GaDdj5C+0aB2
 xUoRPnuBjvoFHw3sAxuGEFiaeS0Nf1GqBS/VpMoVmQoYM1LtaFQxrkJglJQTsYTODj6T
 I0pssE04O3DZelvpaibDdF3DFpxfJz7WzEmuPuu8jylopSptTNzDlUuZEjUkcdm2yJvS
 ZcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992606; x=1728597406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plX8z+lM00jEYmi/LyzdwvevYUziuvwO8TwHiALzRtc=;
 b=jX2Zqi2ie4QLv5OelT2EdBQY+xQkWvcMhqXIs0cr9fqYfFKQ5VJUVN8RZ0VJhKWgld
 mCpVS77MWdEoUkWZaVrU5dygXQXp0JOTwPyGBgEJHq8KFMJe7JyHricbPR1wpvlnoqzq
 3cRD7xu4neZfdQVSPrqWU8PzQs7TMRZTxI8Di7itV+woG1Nyt+ERJu0ZIgYZ3ecUJp43
 WHPApnIL2fDFYg0D8MwsMS+wq2CapLYRQzUnuDZyaJT/ULBxh/so52rqqYabUhyih4Vm
 ux58gqk6k7lIcIWGeWd1FxqFamWApZEgFXLtpCHjtnJxDacYc0B0K3TR/bdkc6M22gsd
 bqwg==
X-Gm-Message-State: AOJu0YwbEcY2ELdqJWSHDow96PXqTLY/P73kNOMfnvFglh2a+4b7h7uG
 c02G3n8BJvQlGGOtwJQHkdPXGhB/7rIRHNeGS/sv3/yeiepKW/Ptr4kOGTq689BgdlaMvyTW4tD
 R
X-Google-Smtp-Source: AGHT+IFn4beaupUelTlMFIFW98h9exGoG2wv4Pa6NkT89ejPGsmcPLjtidkUZIaFbx4a6bJO6swWyg==
X-Received: by 2002:a05:622a:229b:b0:458:534f:fa06 with SMTP id
 d75a77b69052e-45d9baf4333mr9406801cf.50.1727992605877; 
 Thu, 03 Oct 2024 14:56:45 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92ddf5c4sm9001541cf.18.2024.10.03.14.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:56:45 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Anand Moon <linux.amoon@gmail.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v8 10/27] mbedtls/external: support decoding multiple signer's
 cert
Date: Thu,  3 Oct 2024 14:50:23 -0700
Message-Id: <20241003215112.3103601-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003215112.3103601-1-raymond.mao@linaro.org>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Oct 2024 06:57:18 +0200
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
Changes in v5
- None.
Changes in v6
- None.
Changes in v7
- None.
Changes in v8
- None

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

