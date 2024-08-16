Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BD4C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 22:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC23288C6C;
	Sat, 17 Aug 2024 00:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i3QYSoKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646D188AA9; Fri, 16 Aug 2024 23:48:49 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE1D688C4A
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6bf8b41b34dso154206d6.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723844925; x=1724449725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THfzCjRWGkt0NIUdFL9lTKF0A2Iybv+v4wQLt/Vi3pk=;
 b=i3QYSoKT28TuBYPkbfCEXZjCTP2l3bOzpb3IJj+ejVaSgK6NuhICR/VTiTWcw7Ef+i
 hs7bvzMYJ78AgbC7Sba/NxK0dTL5WkloFiPjbb603pGQ+EX85HnOUczFT3osve1AsCew
 Jm2UitTqhw/+p7MfyMEojAyrcqHPl84lQpFmwPzx2bJePklnq4xGq2DirICCmu5V4IEa
 m4yCKX3HXTs7BLdD1xRvBaVMlqR/EEdDncQycMhmE7inyu9FgWLZPxcFYcWAi4HfJTED
 Iw0YtbDNd36vlQRuCI2wduo8YLgUf1iKBuTJDbFxELV1065g0KLPdRrC0W+KPY45a1HA
 5Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723844925; x=1724449725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THfzCjRWGkt0NIUdFL9lTKF0A2Iybv+v4wQLt/Vi3pk=;
 b=foPt6i4jW5raR4knSR/Q+EXP/gNKTNvt7mBxI8IMRiFMstwR+eUOZPCiZqNt0yP5HB
 lFMCMaSUmzkfmiltcjtA7eVQk4iSiFSGXjB36ls02l/C1Wb9F/y/0Skau5nY8/XrPx81
 +6QZMKjFot/6xfmwnvvIbx2Osoao2nEXw2NIM0LVrIBYfK3Au6qb2XexTDm535O0fD91
 /+CNUmqqfGYXAFSSSxZmlKlT90EhqH8r6BNDHqu7UJUZg9VIwDhlC9612fQ5dvTXsD9D
 Ct/EiMSNM2zc57q3NRKer8CyDsaX1Myl1zCBzBPbqI84GHBFvuO38nl6DeFLiGNUzwOW
 3tJw==
X-Gm-Message-State: AOJu0YzgieEX/rL9okXP/WpYvm1y61B/xUwxJ28W+Gpk/U9W3X6fkiAE
 1bPVmdXHTBVxaA7fyAEwJuJcWxnuH4UwxPaj+j4rDifiHefBQy3cMcZfRSjvF/XeYSZAlDVm6KR
 qW0E=
X-Google-Smtp-Source: AGHT+IFQmu8iSj7WeOXCbPQ2biVQ06ckMRCXGh3DD0j8C5zcTgzmmJljEkYMv5xY0a1I57oZrI5afg==
X-Received: by 2002:a05:6214:4518:b0:6bf:6604:c876 with SMTP id
 6a1803df08f44-6bf8950a3a6mr11091636d6.32.1723844925214; 
 Fri, 16 Aug 2024 14:48:45 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:48:44 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 10/28] mbedtls/external: support PKCS9 Authenticate
 Attributes
Date: Fri, 16 Aug 2024 14:43:59 -0700
Message-Id: <20240816214436.1877263-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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
Changes in v6
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

