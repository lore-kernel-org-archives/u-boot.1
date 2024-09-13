Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48480FA3737
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 09:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A577B88DB2;
	Fri, 13 Sep 2024 11:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OmILV3kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 588C888B27; Fri, 13 Sep 2024 11:57:27 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA32C88BBE
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso349663966b.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1726221440; x=1726826240;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vW7qJEHzB7K7Vuq5gSZygAenGvtTILGG5LHRpzHYU+k=;
 b=OmILV3kjWn2i36juzU1HJR8rMgXFo+d+aH6+95BwysxenXyH528XNl8pYZV+Ta1sGF
 yHS2flXurlNOOmqlva9rPjFmbCEWC4zvfZI/3upgAwVRj9Df0xgsP1bKrlpqFgy6rstK
 dD1KCiyTjIPKY8QgotuUMFFwfiylF36pm33lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726221440; x=1726826240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vW7qJEHzB7K7Vuq5gSZygAenGvtTILGG5LHRpzHYU+k=;
 b=ca/F5x+Wt2WwDNb4XGl4IM1zlj7ZTdocs36OSaNehlGVwTtbc+J8KyD/HumjWK6uvl
 XJkCTX+0IlRfSbY/1e8HXzfxb7e5IcGKj/g1kgHG1cfVBWkfmPfGVvcMm/E/uuu/DO/o
 8YKSusiVuZD5Z35ai2D8Jdw+fTjdhuuvi3GJnfvQzCRWYO6oK3LSNeO9U7KTu1kEOhoN
 ucUIQ3qszxl/yzhvqkTS/VKGQGflf+zc9j+HlKrrpgORZc1l2O/RNpQl1hyD5o+UThqp
 b0RuojgpQ9qhcev58GyVZ7DijiVR4GQmmbogkqpb8mBadj0bSeowRyw6LzyopPVfHnEM
 N0Xw==
X-Gm-Message-State: AOJu0Yx34MDr/PAv9A2rdf4W0k744s8zYN9sJMQ43ejVdJjeyb/Dzf+G
 MjGqgkxN3qNDy1Z6y3iHyfhl2CDv22jZ1sWxZBDdRjKgUlD9omFJWe24Qy1w8FAhk5BlEbcL7wi
 Lkao=
X-Google-Smtp-Source: AGHT+IGyHDaO62g7DVROfDb5NyovZrcsWIfGi/0tIR9eGvPqXZKxEb0qHEXcVAXLRX15nDiE5mKEQQ==
X-Received: by 2002:a17:907:6e8f:b0:a7a:acae:340b with SMTP id
 a640c23a62f3a-a902a8f7d52mr575358666b.31.1726221439869; 
 Fri, 13 Sep 2024 02:57:19 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 02:57:19 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/26] lib: div64: sync with Linux
Date: Fri, 13 Sep 2024 11:55:59 +0200
Message-ID: <20240913095622.72377-18-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
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

From: Michael Trimarchi <michael@amarulasolutions.com>

Sync with Linux commit fc4a0db4149af ("Merge tag '6.5'").

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 include/linux/math64.h | 110 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index eaa9fd5b9685..82bd7472a32c 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_MATH64_H
 #define _LINUX_MATH64_H
 
@@ -12,6 +13,11 @@
 
 /**
  * div_u64_rem - unsigned 64bit divide with 32bit divisor with remainder
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
+ * @remainder: pointer to unsigned 32bit remainder
+ *
+ * Return: sets ``*remainder``, then returns dividend / divisor
  *
  * This is commonly provided by 32bit archs to provide an optimized 64bit
  * divide.
@@ -24,6 +30,11 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 
 /**
  * div_s64_rem - signed 64bit divide with 32bit divisor with remainder
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 32bit divisor
+ * @remainder: pointer to signed 32bit remainder
+ *
+ * Return: sets ``*remainder``, then returns dividend / divisor
  */
 static inline s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 {
@@ -33,6 +44,11 @@ static inline s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 
 /**
  * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 64bit divisor
+ * @remainder: pointer to unsigned 64bit remainder
+ *
+ * Return: sets ``*remainder``, then returns dividend / divisor
  */
 static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 {
@@ -42,6 +58,10 @@ static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 
 /**
  * div64_u64 - unsigned 64bit divide with 64bit divisor
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 64bit divisor
+ *
+ * Return: dividend / divisor
  */
 static inline u64 div64_u64(u64 dividend, u64 divisor)
 {
@@ -53,6 +73,10 @@ static inline u64 div64_u64(u64 dividend, u64 divisor)
 
 /**
  * div64_s64 - signed 64bit divide with 64bit divisor
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 64bit divisor
+ *
+ * Return: dividend / divisor
  */
 static inline s64 div64_s64(s64 dividend, s64 divisor)
 {
@@ -92,10 +116,14 @@ extern s64 div64_s64(s64 dividend, s64 divisor);
 
 /**
  * div_u64 - unsigned 64bit divide with 32bit divisor
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
  *
  * This is the most common 64bit divide and should be used if possible,
  * as many 32bit archs can optimize this variant better than a full 64bit
  * divide.
+ *
+ * Return: dividend / divisor
  */
 #ifndef div_u64
 static inline u64 div_u64(u64 dividend, u32 divisor)
@@ -107,6 +135,10 @@ static inline u64 div_u64(u64 dividend, u32 divisor)
 
 /**
  * div_s64 - signed 64bit divide with 32bit divisor
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 32bit divisor
+ *
+ * Return: dividend / divisor
  */
 #ifndef div_s64
 static inline s64 div_s64(s64 dividend, s32 divisor)
@@ -228,6 +260,24 @@ static inline u64 mul_u64_u64_shr(u64 a, u64 b, unsigned int shift)
 
 #endif
 
+#ifndef mul_s64_u64_shr
+static inline u64 mul_s64_u64_shr(s64 a, u64 b, unsigned int shift)
+{
+	u64 ret;
+
+	/*
+	 * Extract the sign before the multiplication and put it back
+	 * afterwards if needed.
+	 */
+	ret = mul_u64_u64_shr(abs(a), b, shift);
+
+	if (a < 0)
+		ret = -((s64)ret);
+
+	return ret;
+}
+#endif /* mul_s64_u64_shr */
+
 #ifndef mul_u64_u32_div
 static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 {
@@ -257,4 +307,64 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
+u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
+
+/**
+ * DIV64_U64_ROUND_UP - unsigned 64bit divide with 64bit divisor rounded up
+ * @ll: unsigned 64bit dividend
+ * @d: unsigned 64bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 64bit divisor
+ * and round up.
+ *
+ * Return: dividend / divisor rounded up
+ */
+#define DIV64_U64_ROUND_UP(ll, d)	\
+	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
+
+/**
+ * DIV64_U64_ROUND_CLOSEST - unsigned 64bit divide with 64bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 64bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 64bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV64_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u64 _tmp = (divisor); div64_u64((dividend) + _tmp / 2, _tmp); })
+
+/**
+ * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor rounded to nearest integer
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV_U64_ROUND_CLOSEST(dividend, divisor)	\
+	({ u32 _tmp = (divisor); div_u64((u64)(dividend) + _tmp / 2, _tmp); })
+
+/**
+ * DIV_S64_ROUND_CLOSEST - signed 64bit divide with 32bit divisor rounded to nearest integer
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 32bit divisor
+ *
+ * Divide signed 64bit dividend by signed 32bit divisor
+ * and round to closest integer.
+ *
+ * Return: dividend / divisor rounded to nearest integer
+ */
+#define DIV_S64_ROUND_CLOSEST(dividend, divisor)(	\
+{							\
+	s64 __x = (dividend);				\
+	s32 __d = (divisor);				\
+	((__x > 0) == (__d > 0)) ?			\
+		div_s64((__x + (__d / 2)), __d) :	\
+		div_s64((__x - (__d / 2)), __d);	\
+}							\
+)
 #endif /* _LINUX_MATH64_H */
-- 
2.43.0

