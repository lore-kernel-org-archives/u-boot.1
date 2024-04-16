Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920E5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D5C88487;
	Tue, 16 Apr 2024 21:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zRiwvOmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA828843B; Tue, 16 Apr 2024 21:02:27 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068498844D
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6962950c6bfso36542196d6.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294132; x=1713898932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7Sw5+pGKH14O8g4QU50KPcJsvlh+h7PadUfGZWeqCw=;
 b=zRiwvOmEVbqTvYt8HMYBcRvTUYeLXKTb3aE5hUCuUsJDATxEALxx+8SR8V8APZfxWW
 od1je8mQwjk9Tfyx5uT6Inll+ZRO0diCmk5XODQUZ/1BqdK8o6qd/XGW6Bv9i3ssKkEg
 7ZynJGbuZbSijRTTmffw5tn0XffYLQptPWSVMxA6Prkv8My+QKK9+7mlWtOnqSF9m4Ld
 6Q60hse6c16q03Cm/3gjq+crStApy/f27PCHfSRL0EoVQ+HdwVZfBXbHA/LM8ZS4VgSB
 wFdvRcStcMqDcZ9PlvUiZ0Q6gSFxdCQ1hhVbw7QbWf87hjGh2fMIWitUNof0YEhQyPq4
 Bo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294132; x=1713898932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p7Sw5+pGKH14O8g4QU50KPcJsvlh+h7PadUfGZWeqCw=;
 b=PNpJR0B5YTFkDqIlH9NzpaO+G5Km50k2/o/M9izOvuxOZIpKHGKAX616kMEsCNicD4
 i47bmg9L5FxxwrE8uF9ypB3CWA6Dlt1JZURo13RvnOGiNBodHsEGWZBzNg54CplBWyAi
 TGepwj+n+jAEm+0VA1xRy3sC7RtE2/yaly73ibhxdugXF1tJMdshgPHPjce2LEdQ4ZbT
 HkLLVoo2X3UjbqwrYAfB8igwzf5DAIO483K7cHKGQEwDEQ71etnk7TeYzt2xdfEr0fPa
 j/40qQHyXUGjBOyRyFWkmI34IgHZ77izIcsnlGJzr/uAyVObuK+exODUn+9msX+I9AWJ
 0/Rg==
X-Gm-Message-State: AOJu0Yw/Zf+DO9iK4e9TWZCNu0SHzbL4sdeQo2WgbcJCvXuvnbQKoTHa
 q+VkWBWutp0BIY8W6VMuNm1eOCMSmppERhEyBKO3re/CQwcsL3gujJPygK3q3nT+MgWk9zUjjDf
 f
X-Google-Smtp-Source: AGHT+IGjf0DPNAEfBOOM4fY9lJzsZ5/fn1sZTNosBLdRx/DgnN8yC1I5vabd6Zy0j/1GqXuDeenKGw==
X-Received: by 2002:a05:6214:12dd:b0:69b:12a0:295c with SMTP id
 s29-20020a05621412dd00b0069b12a0295cmr13063419qvv.57.1713294132178; 
 Tue, 16 Apr 2024 12:02:12 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:11 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 20/23] lib/crypto: port MSCode parser on MbedTLS
Date: Tue, 16 Apr 2024 12:00:16 -0700
Message-Id: <20240416190019.81016-21-raymond.mao@linaro.org>
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

Integrate MicroSoft Authenticate Code parser on top of MbedTLS
ASN.1 decoder.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/crypto/mscode.h    |   4 ++
 lib/crypto/mscode_parser.c | 104 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
index 551058b96e..c214fc87e4 100644
--- a/include/crypto/mscode.h
+++ b/include/crypto/mscode.h
@@ -9,6 +9,10 @@
 #ifndef __UBOOT__
 #include <crypto/hash_info.h>
 #endif
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+#include <external/mbedtls/include/mbedtls/asn1.h>
+#include <external/mbedtls/include/mbedtls/oid.h>
+#endif
 
 struct pefile_context {
 #ifndef __UBOOT__
diff --git a/lib/crypto/mscode_parser.c b/lib/crypto/mscode_parser.c
index 90d5b37a6c..167304def5 100644
--- a/lib/crypto/mscode_parser.c
+++ b/lib/crypto/mscode_parser.c
@@ -18,11 +18,113 @@
 #else
 #include "verify_pefile.h"
 #endif
+#if !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 #include "mscode.asn1.h"
+#endif
 
 /*
  * Parse a Microsoft Individual Code Signing blob
+ *
+ * U.P.SEQUENCE {
+ *    U.P.OBJECTIDENTIFIER 1.3.6.1.4.1.311.2.1.15 (SPC_PE_IMAGE_DATA_OBJID)
+ *    U.P.SEQUENCE {
+ *       U.P.BITSTRING NaN : 0 unused bit(s);
+ *       [C.P.0] {
+ *          [C.P.2] {
+ *             [C.P.0] <arbitrary string>
+ *          }
+ *       }
+ *    }
+ * }
+ * U.P.SEQUENCE {
+ *    U.P.SEQUENCE {
+ *       U.P.OBJECTIDENTIFIER <digest algorithm OID>
+ *       U.P.NULL
+ *    }
+ *    U.P.OCTETSTRING <PE image digest>
+ * }
+ *
  */
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
+
+int mscode_parse(void *_ctx, const void *content_data, size_t data_len,
+		 size_t asn1hdrlen)
+{
+	struct pefile_context *ctx = _ctx;
+	unsigned char *p = (unsigned char *)content_data;
+	unsigned char *end = (unsigned char *)content_data + data_len;
+	size_t len = 0;
+	int ret;
+	unsigned char *inner_p;
+	size_t seq_len = 0;
+
+	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	inner_p = p;
+	ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len, MBEDTLS_ASN1_OID);
+	if (ret)
+		return ret;
+
+	/* Sanity check on the PE Image Data OID (1.3.6.1.4.1.311.2.1.15) */
+	if (MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_MICROSOFT_PEIMAGEDATA, inner_p, len))
+		return -EINVAL;
+
+	p += seq_len;
+	ret = mbedtls_asn1_get_tag(&p, end, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	ret = mbedtls_asn1_get_tag(&p, p + seq_len, &seq_len,
+				   MBEDTLS_ASN1_CONSTRUCTED |
+				   MBEDTLS_ASN1_SEQUENCE);
+	if (ret)
+		return ret;
+
+	inner_p = p;
+
+	/*
+	 * Check if the inner sequence contains a supported hash
+	 * algorithm OID
+	 */
+	ret = mbedtls_asn1_get_tag(&inner_p, inner_p + seq_len, &len, MBEDTLS_ASN1_OID);
+	if (ret)
+		return ret;
+
+	if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_MD5, inner_p, len))
+		ctx->digest_algo = "md5";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA1, inner_p, len))
+		ctx->digest_algo = "sha1";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA224, inner_p, len))
+		ctx->digest_algo = "sha224";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA256, inner_p, len))
+		ctx->digest_algo = "sha256";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA384, inner_p, len))
+		ctx->digest_algo = "sha384";
+	else if (!MBEDTLS_OID_CMP_RAW(MBEDTLS_OID_DIGEST_ALG_SHA512, inner_p, len))
+		ctx->digest_algo = "sha512";
+
+	if (!ctx->digest_algo)
+		return -EINVAL;
+
+	p += seq_len;
+	ret = mbedtls_asn1_get_tag(&p, end, &len, MBEDTLS_ASN1_OCTET_STRING);
+	if (ret)
+		return ret;
+
+	ctx->digest = p;
+	ctx->digest_len = len;
+
+	return 0;
+}
+
+#else	/* !CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
+
 int mscode_parse(void *_ctx, const void *content_data, size_t data_len,
 		 size_t asn1hdrlen)
 {
@@ -36,6 +138,8 @@ int mscode_parse(void *_ctx, const void *content_data, size_t data_len,
 	return asn1_ber_decoder(&mscode_decoder, ctx, content_data, data_len);
 }
 
+#endif	/* CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
+
 /*
  * Check the content type OID
  */
-- 
2.25.1

