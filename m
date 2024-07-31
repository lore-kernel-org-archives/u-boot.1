Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634CEC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D820E88A68;
	Wed, 31 Jul 2024 19:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bd+3CP7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B41788A6C; Wed, 31 Jul 2024 19:29:50 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8221286FB1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a1df0a9281so377199485a.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722446986; x=1723051786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGclOb4Urj7+KJsJUHm4ZA4oraBSI2eqNsBfyxl0mxw=;
 b=Bd+3CP7c4e9OtJ0XIwJPsgwlmNPIoiwOH04MFbn4i7ldHoUVjcEsDkhUF8v0K9/q7Y
 uxXQ9j89H9+kYxcRaXvbGam1DKHYjKYNK4jcFM0ea5CWB17UqCCGUSokZHPVEI0ufOYK
 uJJ/cgbh7n5lSyZVmNdKY8T22aergtaCe3l/Zuq7A4qwyPA/1JH4BTS2Vy6/IsGTIuQw
 nmW4bjNPF4aSaX5HLG8CWr42B3gq4eLy61ZvIW7wZTdWA/hMdi0vNPiDTtCbSlk8/wgy
 fbQvweCx1Vk2gfZARiNaJU9+6wkiRiuKoEnGgRsXvNbo7eLo5RC0sMRY9ex5nn8O0ow0
 eWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446986; x=1723051786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGclOb4Urj7+KJsJUHm4ZA4oraBSI2eqNsBfyxl0mxw=;
 b=Ra2bXzRhK96jBq8x/4wQR+6fHXF02Y2HHY2rE93UYvT9C2bdpKEzpX3Gue4eWSDR33
 y03tMNZeEMWlRwnH7JqPd0btsdgLkK5HJsNsnWMMSIw1cgYbuyPEaMgfNqMie6IoyQSw
 EdcMy7hcOVeqpBJ/yesHnMSx4fatywDneqbwu9mtTdg8GdTSG23dyIkB2FqqrWBns9b/
 r4MPbEZZ5Wzvw0Ww3riPOKFcgB9WnIic2d6MVFcxbby47QlYB6D5eEsAPlQmAybzgrit
 +jsuBVU13y01wP5sLQlKZfbDDS8hhdvRFN2ZpAGiNv3+9Rt0VuGVCSVHgRV5XuZFoDDB
 Jgag==
X-Gm-Message-State: AOJu0YwO0vuCKZrJO506/WITOddTUTJ3gNv56dzZqfHMYb0YYxZMyGHt
 XWcQcWGmckdxsaGG7KlGUBB8Q8ZA8y5sSB8so1TIirVAqn04h2tVD1jLpp6yz3MXCiMMOmH1WmQ
 c8cU=
X-Google-Smtp-Source: AGHT+IFRuvRhVmytIn6S2AEd/Bjf7GlLv/N3XIMysXnxKLse687SVZAZLLAHh1sw+l9/lznS8dNz4Q==
X-Received: by 2002:a05:620a:4156:b0:79f:197d:fe88 with SMTP id
 af79cd13be357-7a1e5223f6fmr2060530485a.7.1722446986139; 
 Wed, 31 Jul 2024 10:29:46 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d73b378fsm779452485a.37.2024.07.31.10.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:29:45 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng.cn@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v5 09/27] mbedtls/external: support PKCS9 Authenticate
 Attributes
Date: Wed, 31 Jul 2024 10:25:19 -0700
Message-Id: <20240731172556.1348487-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731172556.1348487-1-raymond.mao@linaro.org>
References: <20240731172556.1348487-1-raymond.mao@linaro.org>
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

 .../external/mbedtls/include/mbedtls/oid.h    |  5 +++++
 .../external/mbedtls/include/mbedtls/pkcs7.h  | 11 +++++++++++
 lib/mbedtls/external/mbedtls/library/pkcs7.c  | 19 ++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
index 2ee982808fa..43cef99f1e3 100644
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
index 9e29b74af70..a88a5e858fc 100644
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
index 0c2436b56b7..da73fb341d6 100644
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

