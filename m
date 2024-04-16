Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2206C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9450A88475;
	Tue, 16 Apr 2024 21:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wx+CneDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F3E88390; Tue, 16 Apr 2024 21:02:06 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C0388390
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6962a97752eso31704956d6.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294118; x=1713898918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyhYQ6NBYyfz9zqnBMa3eX5oG/jNkZ9a/Z7bzOcLDbY=;
 b=Wx+CneDTkbhrcgsSXVE4WIS6M7NPTpnuiL1DcKxiIFHPGpfyCjQKtvtjHSv6eZfRjc
 3jFs4dD2oGds5kL1uVmPXw58ek+MT6+z3xgGv6hpKEpXZ4QQNjLJnTa7/NUa4jUsWBuN
 ORbU7lWR2Nw7cxbgZW77sQGCZeyDYUuxU5Oe69KyaFB3d5CR+aNANxvKmoBCJbfb6Tbq
 X9Vl8TZzoEArQjSVJ5zutIGb5MBS9NHGIX8njaMZhkly5Ez7kt+76w5vOgL2JV8NOLdf
 3SsPquNQqdpickpXtPovlglQwqPeSFIdn3oDLEp+bhs1nTFxKLWcxNEEcdsZv97eNNX3
 QBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294118; x=1713898918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyhYQ6NBYyfz9zqnBMa3eX5oG/jNkZ9a/Z7bzOcLDbY=;
 b=FqybEQ8byw+lv26mgz0SEHLIpcWy2+e/Gqkrz8XZfo6QoWJ0nwl3QkETQo9WzZQ7od
 uCcZNAr1JM0lecz/P11GMZMieTnu2HShatH7yVfrq/1C1cnAXaikhCoXHEoxHuUQVxfp
 bhQVWdYtvxuFk7AXceWRA2APISwQg55yCE3xCS4pPOo3I3ECwE2fNVOa3GyvaANGRZQH
 TLPpuNWqrdCtYljjXSGxYH4JaGGx7pyw8yCMNXyKno/arvprX30XZsNErf8J+LBmig85
 fRk2ixiuV3LxUyX6gTVGHbwndyIjE/bz06avMIdmNFFroFA57+1lBXYTvXnARnDaX8s4
 AtxQ==
X-Gm-Message-State: AOJu0YzMyL1zYw3+9G0RrtNjzb9BlFzYL+R4xAaHZKw40xM6sbPbm9zU
 AqsmPWfC+aK0iimyetsA+l74QLRe05QuppT8JQK5suAKc1aS7luUnvnNxAJft6ry+PXtXQwHaya
 5
X-Google-Smtp-Source: AGHT+IE60MFXlI1Y/jD307zYU6ucs0rWgULz2Vd7DJXLtUNpzHkWs8zHLarnQUEvZC3+tozFj94mSg==
X-Received: by 2002:a05:6214:4248:b0:69b:7a7:dac3 with SMTP id
 ne8-20020a056214424800b0069b07a7dac3mr12601606qvb.55.1713294117756; 
 Tue, 16 Apr 2024 12:01:57 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:57 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 13/23] mbedtls/external: support MicroSoft Authentication Code
Date: Tue, 16 Apr 2024 12:00:09 -0700
Message-Id: <20240416190019.81016-14-raymond.mao@linaro.org>
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

Populate MicroSoft Authentication Code from the content data
into PKCS7 decoding context if it exists in a PKCS7 message.
Add OIDs for describing objects using for MicroSoft Authentication
Code.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 .../external/mbedtls/include/mbedtls/oid.h    | 30 ++++++++++
 .../external/mbedtls/include/mbedtls/pkcs7.h  | 10 ++++
 lib/mbedtls/external/mbedtls/library/pkcs7.c  | 60 +++++++++++++++----
 3 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h b/lib/mbedtls/external/mbedtls/include/mbedtls/oid.h
index fdc25ebf88..2ee982808f 100644
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
index e9b482208e..9e29b74af7 100644
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
index 3aac662ba6..0c2436b56b 100644
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

