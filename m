Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CA6FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFFD88DE0;
	Sat, 14 Sep 2024 03:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JUKNnfX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4156B88706; Fri, 13 Sep 2024 18:08:40 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D68887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c353f2f954so16465086d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243716; x=1726848516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I55NGZSYSDVleniWBhm7fDKalQ5dX20ag9e3FUqeHB8=;
 b=JUKNnfX/V3C7+GUaI8SV2syynaUI5uj83PEzei1be9JUjfvqL0Rq5UtUKdc4qENc3o
 aQSEqAWUeg6MPbrgtUpE7LHxkye2P3n/YDngAMmsAvVvqdYCvgAyIdE/OsYSZn/RzHvm
 JQ9S1M19AVcEJOFTXKwXcFgu0by4WzRUQJ1+xZ4GZ6iG9gfhRaAc2LqXvGjBIeTFbv33
 lsTD0ZEVM4w4fORBwpUa9B9o3SqqLFJSjE7FaXYXUSBrcbJUSZkVNOlcw9ceBUG94jXL
 /Wm/rhrHllPzRWPLTewbnlP4zb4GnEa6rtJU2wdE6lL4vbSdDcnXJHc6Hyhp4zMMTLWg
 AhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243716; x=1726848516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I55NGZSYSDVleniWBhm7fDKalQ5dX20ag9e3FUqeHB8=;
 b=jy3alzTVDv+ud1ncB5YoWpzsRjXY0Yj9vxWnzxUHM9WmMJItBJARqUVLhg+LuIrqTt
 VcK/X10VegpOxC1sGQVoD9EYcCq9YDwrUannbhC4du+bG9DL89jLa9fnGfFnP3GDhX3J
 fpMqD5I4filGwG4cz103s4LPQYJbvNJPGKbCh73cxGKngCFTC2azgkDGjH3BRqrvT7lC
 TCYq1gjJTc5sOjxM5prhonA5wP7TDrRhjrCj7J1jvgxbYFdwwzXVFg6DtlnBKoRFlGHP
 8gjPVoJnyyZpfoPow9W1svvDMuj2+aROJyW2wL0Uf6f3m6vltXJMEdlhezola50W8RHu
 FdeA==
X-Gm-Message-State: AOJu0YwFSE2HErOsH5nQdMVtLQbM2hV7HhKqruF9eE/CLPkFq5o90rGF
 hUjAWok8oFik5vgfjuNSM9dVtlj7rQ9sjjN0C5j0KMbX6dOGuLslAJVCTgxkiR8Lw7XZA6XCrW8
 b
X-Google-Smtp-Source: AGHT+IFz7EA3IsdFnxNRf3rT5GR0d3c4v9WHP7I9uLHNiJ3XaBB7yIgNHMDE8iagYrKVm9+VFgN9nA==
X-Received: by 2002:a05:6214:398c:b0:6c5:5f04:3667 with SMTP id
 6a1803df08f44-6c57353a613mr96779126d6.6.1726243716356; 
 Fri, 13 Sep 2024 09:08:36 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:08:36 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 09/27] mbedtls/external: support PKCS9 Authenticate
 Attributes
Date: Fri, 13 Sep 2024 09:03:26 -0700
Message-Id: <20240913160408.2199558-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913160408.2199558-1-raymond.mao@linaro.org>
References: <20240913160408.2199558-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Sep 2024 03:04:24 +0200
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

