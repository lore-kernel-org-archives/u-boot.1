Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60553FC6186
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 01:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E1688DCE;
	Sat, 14 Sep 2024 03:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zT2U90fF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CDE88706; Fri, 13 Sep 2024 18:08:13 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F2D887BB
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 18:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a9b72749bcso93300385a.0
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726243689; x=1726848489; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kg27/z93pufOH6hSSv5Sd7HagU0JNnECs1iTPwyDhvc=;
 b=zT2U90fFRNXarTaAyaSmWJ+QDn/bqQMnw75kpsE/tUaWRH5oaoUJK/9VdCs8UXhUQC
 9QJBAT+3GL+gzTtENCv5Qsg9+c0UE4GZ9R0ewoy2T+R9Jcr+l5TlKdPTJlZeDn18kU/5
 Hy41GGIj2oRIF/5JDmA7Fn4ZiPQbb+uALhXlUzAduziciIcaEVDPn6OnnAQStK43HMNG
 zc7yi4A935VH420F9b4htyOmvdCxiGwq5A58Ipk5GzAbBcPuhRgXeLcREn20RX58I5iG
 Ld0tafU9ZWubTWvJZAmVooOtwNylRVDUSH72Oh+Rto1Qkz1fBPNfLGibeln5tY5TZWY7
 mY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726243689; x=1726848489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kg27/z93pufOH6hSSv5Sd7HagU0JNnECs1iTPwyDhvc=;
 b=CYe4JxnbVq8YBpXNbDYGgQM0T/FpgVz59CAuaNgKvbqltH3eCp/UR/3ZlHBTZ3el0v
 3H7SdmJkwX97okakBhhytyEwUHBidZXnEmknwerKgr5JO6zBkRs7mrlM5aEuP5I160QO
 aaJ643FQb0uIHD9e+F7uGIqu4iSOVKcsOHvdP/7A3dLBs8goyfUea2bPDHBgG9oG68oX
 ffgBGNkU5Q8O8KxG2T1/xo2dtkUQZc8fT8SBtyv77p6btFehy1nJeaNZYlR31okBbcd2
 OXxaFnNSjiHfaPUfba3pqaMK0SgRlsSjl6Qxn0jC2brSnQJzsIdjDN0WvOFuMvfkpUN2
 tOiw==
X-Gm-Message-State: AOJu0YygvIAXYOc9eVozsZ61tYZJeizWelWFRmiyaq39VjDSdr9VJEFn
 TJaUArHN0y5rlOBwBQsBW20Q6w9zcSYygD86BjcuqDsoIlOTsCZLp26kcSFqoCIEKTcbzpzOYyu
 9
X-Google-Smtp-Source: AGHT+IEmfwVECBYYVFbwwoSvsXWZhz43+bV+7vdf0znH9CFDdk4sOs6vAA+NMg+fZT9wTuilWQi5mA==
X-Received: by 2002:a05:6214:5a05:b0:6c3:5de5:7e9f with SMTP id
 6a1803df08f44-6c57e2342fcmr44277526d6.47.1726243689170; 
 Fri, 13 Sep 2024 09:08:09 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534774908sm67697286d6.118.2024.09.13.09.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:08:08 -0700 (PDT)
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
 Sumit Garg <sumit.garg@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Kongyang Liu <seashell11234455@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Greg Malysa <greg.malysa@timesys.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v7 08/27] mbedtls/external: support Microsoft Authentication
 Code
Date: Fri, 13 Sep 2024 09:03:25 -0700
Message-Id: <20240913160408.2199558-9-raymond.mao@linaro.org>
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

Populate Microsoft Authentication Code from the content data
into PKCS7 decoding context if it exists in a PKCS7 message.
Add OIDs for describing objects using for Microsoft Authentication
Code.

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

 .../external/mbedtls/include/mbedtls/oid.h    | 30 ++++++++++
 .../external/mbedtls/include/mbedtls/pkcs7.h  | 10 ++++
 lib/mbedtls/external/mbedtls/library/pkcs7.c  | 60 +++++++++++++++----
 3 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
index fdc25ebf885..2ee982808fa 100644
--- a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
+++ b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
@@ -352,6 +352,36 @@
 #define MBEDTLS_OID_PKCS12_PBE_SHA1_RC2_128_CBC     MBEDTLS_OID_PKCS12_PBE "\x05" /**< pbeWithSHAAnd128BitRC2-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 5} */
 #define MBEDTLS_OID_PKCS12_PBE_SHA1_RC2_40_CBC      MBEDTLS_OID_PKCS12_PBE "\x06" /**< pbeWithSHAAnd40BitRC2-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 6} */
 
+/*
+ * MicroSoft Authenticate Code OIDs
+ */
+#define MBEDTLS_OID_PRIVATE_ENTERPRISE              MBEDTLS_OID_INTERNET "\x04\x01" /* {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) */
+#define MBEDTLS_OID_MICROSOFT                       "\x82\x37"  /* {microsoft(311)} */
+/*
+ * OID_msIndirectData: (1.3.6.1.4.1.311.2.1.4)
+ * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 4(4)}
+ */
+#define MBEDTLS_OID_MICROSOFT_INDIRECTDATA  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
+    "\x02\x01\x04"
+/*
+ * OID_msStatementType: (1.3.6.1.4.1.311.2.1.11)
+ * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 11(11)}
+ */
+#define MBEDTLS_OID_MICROSOFT_STATETYPE  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
+    "\x02\x01\x0b"
+/*
+ * OID_msSpOpusInfo: (1.3.6.1.4.1.311.2.1.12)
+ * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 12(12)}
+ */
+#define MBEDTLS_OID_MICROSOFT_SPOPUSINFO  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
+    "\x02\x01\x0b"
+/*
+ * OID_msPeImageDataObjId: (1.3.6.1.4.1.311.2.1.15)
+ * {iso(1) identified-organization(3) dod(6) internet(1) private(4) enterprise(1) microsoft(311) 2(2) 1(1) 15(15)}
+ */
+#define MBEDTLS_OID_MICROSOFT_PEIMAGEDATA  MBEDTLS_OID_PRIVATE_ENTERPRISE MBEDTLS_OID_MICROSOFT \
+    "\x02\x01\x0f"
+
 /*
  * EC key algorithms from RFC 5480
  */
diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
index e9b482208e6..9e29b74af70 100644
--- a/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
+++ b/lib/mbedtls/external/mbedtls/include/mbedtls/pkcs7.h
@@ -132,12 +132,22 @@ typedef struct mbedtls_pkcs7_signed_data {
 }
 mbedtls_pkcs7_signed_data;
 
+/* Content Data for MicroSoft Authentication Code using in U-Boot Secure Boot */
+typedef struct mbedtls_pkcs7_conten_data {
+    int data_type;  /* Type of Data */
+    size_t data_len;    /* Length of Data */
+    size_t data_hdrlen; /* Length of Data ASN.1 header */
+    void *data;     /* Content Data */
+}
+mbedtls_pkcs7_conten_data;
+
 /**
  * Structure holding PKCS #7 structure, only signed data for now
  */
 typedef struct mbedtls_pkcs7 {
     mbedtls_pkcs7_buf MBEDTLS_PRIVATE(raw);
     mbedtls_pkcs7_signed_data MBEDTLS_PRIVATE(signed_data);
+    mbedtls_pkcs7_conten_data content_data;
 }
 mbedtls_pkcs7;
 
diff --git a/lib/mbedtls/external/mbedtls/library/pkcs7.c b/lib/mbedtls/external/mbedtls/library/pkcs7.c
index 3aac662ba69..0c2436b56b7 100644
--- a/lib/mbedtls/external/mbedtls/library/pkcs7.c
+++ b/lib/mbedtls/external/mbedtls/library/pkcs7.c
@@ -29,6 +29,13 @@
 #include <time.h>
 #endif
 
+enum OID {
+    /* PKCS#7 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-7(7)} */
+    MBEDTLS_OID_DATA = 13,          /* 1.2.840.113549.1.7.1 */
+    /* Microsoft Authenticode & Software Publishing */
+    MBEDTLS_OID_MS_INDIRECTDATA = 24,        /* 1.3.6.1.4.1.311.2.1.4 */
+};
+
 /**
  * Initializes the mbedtls_pkcs7 structure.
  */
@@ -449,7 +456,7 @@ cleanup:
  *      signerInfos SignerInfos }
  */
 static int pkcs7_get_signed_data(unsigned char *buf, size_t buflen,
-                                 mbedtls_pkcs7_signed_data *signed_data)
+                                 mbedtls_pkcs7 *pkcs7)
 {
     unsigned char *p = buf;
     unsigned char *end = buf + buflen;
@@ -457,6 +464,7 @@ static int pkcs7_get_signed_data(unsigned char *buf, size_t buflen,
     size_t len = 0;
     int ret = MBEDTLS_ERR_ERROR_CORRUPTION_DETECTED;
     mbedtls_md_type_t md_alg;
+    mbedtls_pkcs7_signed_data *signed_data = &pkcs7->signed_data;
 
     ret = mbedtls_asn1_get_tag(&p, end, &len, MBEDTLS_ASN1_CONSTRUCTED
                                | MBEDTLS_ASN1_SEQUENCE);
@@ -493,25 +501,57 @@ static int pkcs7_get_signed_data(unsigned char *buf, size_t buflen,
     if (ret != 0) {
         return ret;
     }
-    if (MBEDTLS_OID_CMP(MBEDTLS_OID_PKCS7_DATA, &content_type)) {
+
+    /*
+     * We should only support 1.2.840.113549.1.7.1 (PKCS7 DATA) and
+     * 1.3.6.1.4.1.311.2.1.4 (MicroSoft Authentication Code) that is for
+     * U-Boot Secure Boot
+     */
+    if (!MBEDTLS_OID_CMP(MBEDTLS_OID_PKCS7_DATA, &content_type)) {
+        pkcs7->content_data.data_type = MBEDTLS_OID_DATA;
+    } else if (!MBEDTLS_OID_CMP(MBEDTLS_OID_MICROSOFT_INDIRECTDATA,
+                                &content_type)) {
+        pkcs7->content_data.data_type = MBEDTLS_OID_MS_INDIRECTDATA;
+    } else {
         return MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO;
     }
 
     if (p != end_content_info) {
+        unsigned char *tmp_p = p;
+
         /* Determine if valid content is present */
         ret = mbedtls_asn1_get_tag(&p,
                                    end_content_info,
                                    &len,
-                                   MBEDTLS_ASN1_CONSTRUCTED | MBEDTLS_ASN1_CONTEXT_SPECIFIC);
+                                   MBEDTLS_ASN1_CONSTRUCTED |
+                                   MBEDTLS_ASN1_CONTEXT_SPECIFIC);
+        if (ret != 0 || p + len != end_content_info) {
+            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO,
+                                     ret);
+        }
+
+        /*
+         * U-Boot Secure Boot needs to calculate the digest of MicroSoft
+         * Authentication Code during verifying an EFI image.
+         * Thus we need to save the context of Content Data.
+         */
+        pkcs7->content_data.data_hdrlen = p - tmp_p;
+        /* Parse the content data from a sequence */
+        ret = mbedtls_asn1_get_tag(&p, end_content_info, &len,
+                                   MBEDTLS_ASN1_CONSTRUCTED |
+                                   MBEDTLS_ASN1_SEQUENCE);
         if (ret != 0) {
-            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO, ret);
+            /* TODO: Other Content Data formats are not supported at the moment */
+            return MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE;
+        } else if (p + len != end_content_info) {
+            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO,
+                                     ret);
         }
+
+        pkcs7->content_data.data = p;
+        pkcs7->content_data.data_len = len;
+
         p += len;
-        if (p != end_content_info) {
-            return MBEDTLS_ERROR_ADD(MBEDTLS_ERR_PKCS7_INVALID_CONTENT_INFO, ret);
-        }
-        /* Valid content is present - this is not supported */
-        return MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE;
     }
 
     /* Look for certificates, there may or may not be any */
@@ -624,7 +664,7 @@ int mbedtls_pkcs7_parse_der(mbedtls_pkcs7 *pkcs7, const unsigned char *buf,
     }
 
 try_data:
-    ret = pkcs7_get_signed_data(p, len, &pkcs7->signed_data);
+    ret = pkcs7_get_signed_data(p, len, pkcs7);
     if (ret != 0) {
         goto out;
     }
-- 
2.25.1

