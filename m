Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC67C04FFF
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C3488469;
	Tue, 16 Apr 2024 21:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o61rdjWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D2248843A; Tue, 16 Apr 2024 21:02:23 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270F988443
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78d62c1e82bso320120585a.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294134; x=1713898934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VG7xM5uy0Ztr+Ts3LgatprgvDv5uYdLpfy+2EUr7rU8=;
 b=o61rdjWSgAVdwOa6Tu1ZGXfJM6FNZ6+dU3FAasZdfk8mVL6tI3bwPxxZDAcLRrJ0IO
 rg4yQIJqrgqzIY5Lf6VnLpXbrWykSTEnyZZXy5gumvALF1qrpWTb11RHozt4QX+RUcB0
 ci8bQzREaWS+844UFCKy5DeQ3to5Y5dXb0yb7cqxw/HyqScj3mW6p0aK7XMxOI2QDUwj
 TqthMFCmfG1a2QJxMDDhxIy2N2SkXc7jMkfH+8/H+kEOHdf79GXYSnqKxAofjHy0kF4j
 vsOHdvlDvmScTXY9hhhiQ6oVIJZ2oi4zzN7cJcYSvYbjcKb7Rgc10R7hAaZg/rWLHDIC
 2Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294134; x=1713898934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VG7xM5uy0Ztr+Ts3LgatprgvDv5uYdLpfy+2EUr7rU8=;
 b=hMfo/+mFjpmwLivuajNveDbLjlk0hmDO4Ja40xRyYHYvCZ4s2LgNo1m/9/MbbmOChd
 /X3xNxYKtHdk975zmP0yT2GIQnsvJ8DLr/2fxkOft9VmBn5CvKpyjg/WLlQ37aVe3qXG
 YszpryOceonmQjbecFviTZNSqzYBspKVVQLm97xq2kCARNsATMrHYSJe7GB6PMYLvtCI
 2kzMFdOMic0LzgAlyRX80rTrXEIImdOvithQgFDryUuFY+cOlp60iVLyDZhOYeB7YPlO
 IhwtatbSAmlns/J8Q8j5oo01WgiNbSlx4/vviQ9y4VzZY2cxCyT7ZHNHB5t/8PFRS9CC
 vbbw==
X-Gm-Message-State: AOJu0YxMzo9tlJP7XPKpGdBrp43oApfBEwBwiOtc6QUBO2R8/iqQlDkV
 EgScvSauotqMJkstMos3Ya/++nr4OdPye6ibUQiZ2ClI9buSMdzuW0etv+4FVXjnaO2CCiDzUSu
 e
X-Google-Smtp-Source: AGHT+IE8vMpGFgTiiHfhRJbYSt6eg/gN7TNUJ+WO8dXr8/AT3Wr3JGtLsf6fUxZCvMnvODgYBpdVLw==
X-Received: by 2002:a05:6214:5613:b0:699:45f8:dbf1 with SMTP id
 mg19-20020a056214561300b0069945f8dbf1mr14328882qvb.22.1713294133783; 
 Tue, 16 Apr 2024 12:02:13 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:02:13 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 21/23] lib/crypto: remove dependence on ASN1 decoder
Date: Tue, 16 Apr 2024 12:00:17 -0700
Message-Id: <20240416190019.81016-22-raymond.mao@linaro.org>
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

When building with MbedTLS,  we are using MbedTLS to decode ASN1 data
for x509, pkcs7 and mscode. So we can remove the dependence on ASN1
decoder when MBEDTLS_LIB_X509 is enabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/crypto/Makefile | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bec1bc95a6..00fbda05ae 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -31,6 +31,11 @@ endif
 # X.509 Certificate handling
 #
 obj-$(CONFIG_$(SPL_)X509_CERTIFICATE_PARSER) += x509_key_parser.o
+ifdef CONFIG_MBEDTLS_LIB_X509
+x509_key_parser-y := \
+	x509_cert_parser.o \
+	x509_public_key.o
+else
 x509_key_parser-y := \
 	x509.asn1.o \
 	x509_akid.asn1.o \
@@ -43,27 +48,37 @@ $(obj)/x509_cert_parser.o: \
 
 $(obj)/x509.asn1.o: $(obj)/x509.asn1.c $(obj)/x509.asn1.h
 $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
+endif
 
 #
 # PKCS#7 message handling
 #
 obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
+ifdef CONFIG_MBEDTLS_LIB_X509
+pkcs7_message-y := \
+	pkcs7_parser.o
+else
 pkcs7_message-y := \
 	pkcs7.asn1.o \
 	pkcs7_parser.o
-obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
 $(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
 $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
+endif
+obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
 
 #
 # Signed PE binary-wrapped key handling
 #
 obj-$(CONFIG_$(SPL_)MSCODE_PARSER) += mscode.o
-
+ifdef CONFIG_MBEDTLS_LIB_X509
+mscode-y := \
+	mscode_parser.o
+else
 mscode-y := \
 	mscode_parser.o \
 	mscode.asn1.o
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+endif
-- 
2.25.1

