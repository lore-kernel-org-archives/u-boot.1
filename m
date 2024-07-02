Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061D4C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBBA887B2;
	Tue,  2 Jul 2024 20:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mdLYOwxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8232887B2; Tue,  2 Jul 2024 20:28:21 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F587887B5
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-444fa363d1aso33131961cf.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944897; x=1720549697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ESb0ZfKBqnqowlNZLND+GjDAEJimvOXZqN4Hrc7VmM=;
 b=mdLYOwxhv3ne5lJVZBv0teDl9PHPJ5x96WKoerwldh4+R4zES5+6gjCVby92GSwzh3
 R6qAvsOaj2x0z1ZZrlyoAFl5VrGlJFreG/RPbaItTdinkoDnmWThQLs8F9xWrno/yrSj
 Q+i4QycBmVJp1QwPOciHn8NLPMab2KIrDjBBbK5esoNQgdzaCcazULRTavBVRLMqaegO
 bzziF2HTX/qcEQyadTCAjEFCrLyrOSM7fFDkYQlHx4YeUCRz83y0ToNRaRuP9CVeSwyw
 z59PSS+wH1ryc0CcBDtTp2xv+bam+DIHfUkKOI/d97aoTwRYtLDmUIRXT2PCM7xpJeE3
 pC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944897; x=1720549697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ESb0ZfKBqnqowlNZLND+GjDAEJimvOXZqN4Hrc7VmM=;
 b=ENxIE74i/dsGrmY6E5KXMlZK3lmYHTxNA28iKc7PZ+pMRWbmKqPtIiR/3fynZQBCHY
 zny6onmp/e6PFS5zmo+FbmcO8cFepqt+NE7Wk69mwjiypz2uc+2T2AKT58bMDQG7iIvI
 HgL20FAc+UIE+2auwzl1hY1Qh9IhiaPJJBjIgSos2Gq/9ilirmXg6KeS5FE7188u0Owj
 RMemuRQhGQcDdkI588sq+Be0eSYeqlFNoGDlwXvxZazUjtnRoYz/XFsoSdmFTw8yOvuO
 YVCYAA+CRvK961vl0X3Mwv2FtcFrPFrZ+v4cIWX7s8utVeHVGEWHk0OS7djcXlB5Qw1b
 P3qg==
X-Gm-Message-State: AOJu0YyDKxWsNifzWzfvgjYM4bDhuaCJ8xmKLueKK9ZqJ/56bP1jehgf
 dD0bdyLCt0hecL681ScnUkmJtIFth6VMNXkvvNDY5TZAC0MRElcmE8cwLPVc4YiO5DuRJ133+qR
 q
X-Google-Smtp-Source: AGHT+IGn1o8MsoqpN8DPv9q5sHXzI7vHZApDuzseZCuTlbPD+D/9yJEbFhiRYtlYUUdhrpe7CO+GLA==
X-Received: by 2002:a05:622a:10c:b0:440:5f5c:2a4f with SMTP id
 d75a77b69052e-44655787a90mr209799001cf.33.1719944896887; 
 Tue, 02 Jul 2024 11:28:16 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:28:16 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 11/29] mbedtls/external: support PKCS9 Authenticate
 Attributes
Date: Tue,  2 Jul 2024 11:22:47 -0700
Message-Id: <20240702182325.2904421-12-raymond.mao@linaro.org>
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

