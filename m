Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D4C5516E
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2723940CF6;
	Thu, 30 Jul 2026 18:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kQyor5qr9pFN; Thu, 30 Jul 2026 18:41:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C274B40D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785436890;
	bh=4LKKhsUpKOTjRkfiEGMyBYR6Kmlpo9RooAX0V7RmNXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VKe3NtUlfim2eCF++6rxaDIu2gaEEdNPSx6gR7vtpGgexdyfqJVx9iqZgVMEpR2Iw
	 Owcqn4Z9G4X7LpLN2KvsIamrHDQaPCl2Ser8L9hxg/HsPrjzEJR4lgmOnVxoLF59fT
	 oC9wF41EtkwCbj32eUIktHVgCFvWL3qn6pTtlCpMMK25mEEcYunGLYAkhnt0hg7PNT
	 Kb4D5g7yX3ntac4/rnKRPHgoxUJYN5DJZoBJ7rfLXLwcp//JCUFVsRU/CldJc+h55Y
	 v/Y6Lyz3ctnkZz3caclGRNUqd9QcacGCcvGlkAye32jSMlK+1CJEhUyZHuwJdmMKRc
	 Udozia5CN1+zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C274B40D28;
	Thu, 30 Jul 2026 18:41:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D4F8352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 034AE811FD
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QT4XY763OjXe for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:41:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 43B1A811E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43B1A811E9
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43B1A811E9
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:26 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f7854678bso19827f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436884; x=1786041684;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4LKKhsUpKOTjRkfiEGMyBYR6Kmlpo9RooAX0V7RmNXI=;
 b=ABkjH6b8/mtYqm/NiMokK2RrIWtb6fUoK36EOQwWTomNdA+TTprJlhNdGYwoLCy3Ld
 LLniJctw9NYGMfQ3HN3XWmwYS4eGsh9KZJiHbRDqGlNRT10lAuu1jOTKT8kDG6GPtocr
 K4sqoWsH1vbl+A5QswWN/vMDle5u9cosgzaUv5nzyVjEph1e2oT8r1Tjvh3DA55Rfs9W
 CmDMo63ZCGIGHx5iVw/FYT8Eqwjvj+5Hj40vUFJ3lnSBQgZDDG4d7qLTjG1o4f7iF1ta
 e2EUr4fnucKBJ6vTFfef6IGZY2EqH5QC8hHkGfN8QQkfD5HU53BwPx114DN3vGQejEMD
 9Lsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMF4Tc2QMLe6DLN2U5pmnLZ7uBhMHYj7Jl38hnmmzDsrEn2X8HJ+k84/SvF7dabgRU9e7xbO8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwJan6cZZNstGYETcArBbBA3M2wXrLM7IZxJEkiSulVYwEYTsjD
 h/tgUBwO5HlTb7C7XtWZr4DY2bHHeGGEc+BtF3yoGfn/uR7UGhYB2Rmr/nUpmq26be8zljXIEPn
 jKextAV8Iug==
X-Gm-Gg: AR+sD11H+RcCxDDSoM29eToL1POyzJ4cQHoDcrrelfUPr9U2CXWNOm6ImlAsbpJxqEx
 bqRoLwEQZhbboPWlxDT8IsKvx3e9vZy6MqezAvLSMyELdfcRbuM6zR11Od0gpEg2Iw5Fccvq0Rs
 D+F6cEOIsv1Y5+n8zELS0iUGVhQS2fnjp2KJzXYKbmkCUTjBajbbqzukcAsmHZ0KOsihjq9MQpt
 6KitNw2ZoPoPXR2vcL1Dhhgyp9cpeEGR+pacQ3w3qXxfSxdM2XPPsbNGgs2suIPYwsnIPDGSpm/
 yg8uFR1EEnkYXDewfAuXKsRdFhsZ15PgnJo9cBJTBoUYdWTAk/SW2htaOiI/qsgxKuSmpaMeXsJ
 Wbe0iOWXGggT4M0C5gBbxffcd30IDdReDV/SwKyPSNv/9OTlZj6kCEhki7+PqXNv9d+rnSilIW2
 L1p4KT8qN2ObT+xHkECyW6f2raNMHjP/Hri7G/dFvXyH5xVrvDKd2VwpfJ15Gf3nCTdhYzp00Ew
 /hnT1Jec3YY3OpMGeUOLzdYFyxS92nJDReYnXbENw==
X-Received: by 2002:a05:6000:240f:b0:47f:95e8:2ebf with SMTP id
 ffacd0b85a97d-47fc81ecf9emr5869355f8f.12.1785436883863; 
 Thu, 30 Jul 2026 11:41:23 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d8d37sm7919603f8f.8.2026.07.30.11.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:41:23 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 22:40:42 +0400
Subject: [PATCH 5/5] lib: math64: sync <linux/math64.h> with Linux v7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-math64-resync-v1-5-8792d9119d49@flipper.net>
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11915; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=lqQTaYVn2qyTPdVYAPFje7Z3POLB/M05tZU/HpuU/dk=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlzzqqsMMn7UHFjFf8/Z9SipQupUmHy1U1Ku+U7L0ef
 ySwgzO6YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKk26GdkmHr9VV16Fvfa7Z0/l0Qyfc3Z+H3lHmO+0B+HM8+ITz70p4/hn0VwD4d
 M8YQTtp2WNseLXL80fjqi8k/v8LrQ/pub74lH8gAA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785436884; x=1786041684;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4LKKhsUpKOTjRkfiEGMyBYR6Kmlpo9RooAX0V7RmNXI=;
 b=TzcM0NEkBx5wR2Zf04kCB7etTOjuhdKc6e3t3x6DNE7HIGOfRtzQE1kRUlLBo2a/T0
 IuoyNbGvmHAOqItjxLJnjdwP4lqFzERLq7EQFW5bzPXTh/KbJ+Ib9ycZ1tPVdRo8seEa
 RKxSb+sHSBv/29Jf9WXkwvoqQhGZglAlTtd0nbfXOOsG7yl6GX+tDWE4fcE5cBeGBDsE
 dVJFmquAP59RIvDcMgbY180Fsq6WoBCwI1hRsLusu34O5mw8t39/X9wHg/oyQrtXOrDN
 RSmBdNDLwHKPE11Yy2lA8U1VsZZk4gBAXjou9f5lVJoepG39m0oliW4IxUPrFn9KmdZZ
 kMkw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=TzcM0NEk
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

U-Boot's copy was last synced with Linux in 2017 by commit 0342e335ba88
("lib: div64: sync with Linux"). Since then it has only been touched
twice locally, and both times in ways that increased the divergence
rather than tracking upstream. Take the file from the v7.1 tag.

The immediate motivation is DIV64_U64_ROUND_UP(). Commit 3adc17f60bf8
("lib: div64: Add support for round up of div64_u64") added it inside
the #if BITS_PER_LONG == 64 branch, whereas Linux defines it
unconditionally after that block. Any 32-bit user therefore fails to
compile:

  error: implicit declaration of function 'DIV64_U64_ROUND_UP';
  did you mean 'DIV_ROUND_UP'?

This has been surfaced while reworking fractional PLL logic for Rockchip
RK3588/RK3576, which unexpectedly failed to compile on 32-bit variants [1].

Newly available as a result: DIV64_U64_ROUND_UP() on 32-bit,
DIV_U64_ROUND_UP(), DIV64_U64_ROUND_CLOSEST(), DIV_U64_ROUND_CLOSEST(),
DIV_S64_ROUND_CLOSEST(), roundup_u64(), add_u64_u32() and
mul_s64_u64_shr(), plus upstream's kernel-doc for everything that was
already here and __always_inline on mul_u64_u32_shr()/mul_u64_u64_shr().

The file is otherwise a verbatim copy of v7.1. Four deviations:

 - The includes. U-Boot has no <linux/math.h>, no <asm/div64.h> and no
   <vdso/math64.h>. do_div() comes from U-Boot's <div64.h>,
   BITS_PER_LONG from <linux/bitops.h>, and abs64() from
   <linux/kernel.h>, which is where U-Boot keeps the rest of what
   upstream puts in <linux/math.h>.

 - mul_s64_u64_shr() uses abs64() rather than abs(), because U-Boot's
   abs() evaluates its argument as int for anything that is not a long.

 - mul_u64_add_u64_div_u64() and the mul_u64_u64_div_u64() and
   mul_u64_u64_div_u64_roundup() macros built on it are not ported.
   They would need ~110 lines of lib/math/div64.c brought along, plus a
   u128 type and OPTIMIZER_HIDE_VAR(), and U-Boot has no users for them
   yet.

 - abs_diff(), added locally by commit f1f4a1d1d835 ("compat: math64:
   add abs_diff()"), is kept. Upstream has it in <linux/math.h>.

Build tested for evb-rk3288-rk808 (32-bit LE), generic-rk3576 (64-bit
LE), malta (32-bit BE, which is what compiles the __BIG_ENDIAN union
paths in mul_u64_u64_shr() and mul_u64_u32_div()), sandbox and
tools-only, with both gcc and clang. All six DIV*_ROUND_* macros plus
roundup_u64(), mul_s64_u64_shr(), add_u64_u32() and abs_diff() were
additionally instantiated on 32-bit ARM to confirm they now resolve.

Closes: https://patchwork.ozlabs.org/project/uboot/patch/20260723-rk3588-fracpll-v2-2-382d113f3a80@flipper.net/#3731361 [1]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/linux/math64.h | 182 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 171 insertions(+), 11 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index eb560e3183a9..78c184eb85be 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -1,8 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_MATH64_H
 #define _LINUX_MATH64_H
 
 #include <div64.h>
 #include <linux/bitops.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 
 #if BITS_PER_LONG == 64
@@ -12,6 +14,11 @@
 
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
@@ -24,6 +31,11 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 
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
@@ -33,6 +45,11 @@ static inline s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 
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
@@ -42,17 +59,22 @@ static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 
 /**
  * div64_u64 - unsigned 64bit divide with 64bit divisor
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 64bit divisor
+ *
+ * Return: dividend / divisor
  */
 static inline u64 div64_u64(u64 dividend, u64 divisor)
 {
 	return dividend / divisor;
 }
 
-#define DIV64_U64_ROUND_UP(ll, d)	\
-	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
-
 /**
  * div64_s64 - signed 64bit divide with 64bit divisor
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 64bit divisor
+ *
+ * Return: dividend / divisor
  */
 static inline s64 div64_s64(s64 dividend, s64 divisor)
 {
@@ -92,10 +114,14 @@ extern s64 div64_s64(s64 dividend, s64 divisor);
 
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
@@ -107,6 +133,10 @@ static inline u64 div_u64(u64 dividend, u32 divisor)
 
 /**
  * div_s64 - signed 64bit divide with 32bit divisor
+ * @dividend: signed 64bit dividend
+ * @divisor: signed 32bit divisor
+ *
+ * Return: dividend / divisor
  */
 #ifndef div_s64
 static inline s64 div_s64(s64 dividend, s32 divisor)
@@ -128,17 +158,28 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 }
 #endif
 
+#ifndef add_u64_u32
+/*
+ * Many a GCC version also messes this up.
+ * Zero extending b and then spilling everything to stack.
+ */
+static inline u64 add_u64_u32(u64 a, u32 b)
+{
+	return a + b;
+}
+#endif
+
 #if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
 
 #ifndef mul_u64_u32_shr
-static inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
+static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 {
 	return (u64)(((unsigned __int128)a * mul) >> shift);
 }
 #endif /* mul_u64_u32_shr */
 
 #ifndef mul_u64_u64_shr
-static inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
+static __always_inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
 {
 	return (u64)(((unsigned __int128)a * mul) >> shift);
 }
@@ -147,18 +188,14 @@ static inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
 #else
 
 #ifndef mul_u64_u32_shr
-static inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
+static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 {
-	u32 ah, al;
+	u32 ah = a >> 32, al = a;
 	u64 ret;
 
-	al = a;
-	ah = a >> 32;
-
 	ret = mul_u32_u32(al, mul) >> shift;
 	if (ah)
 		ret += mul_u32_u32(ah, mul) << (32 - shift);
-
 	return ret;
 }
 #endif /* mul_u64_u32_shr */
@@ -209,6 +246,27 @@ static inline u64 mul_u64_u64_shr(u64 a, u64 b, unsigned int shift)
 
 #endif
 
+#ifndef mul_s64_u64_shr
+static inline u64 mul_s64_u64_shr(s64 a, u64 b, unsigned int shift)
+{
+	u64 ret;
+
+	/*
+	 * Extract the sign before the multiplication and put it back
+	 * afterwards if needed.
+	 *
+	 * Note: Linux uses abs() here, which U-Boot's abs() cannot do:
+	 * it evaluates its argument as int for anything that is not a long.
+	 */
+	ret = mul_u64_u64_shr(abs64(a), b, shift);
+
+	if (a < 0)
+		ret = -((s64) ret);
+
+	return ret;
+}
+#endif /* mul_s64_u64_shr */
+
 #ifndef mul_u64_u32_div
 static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 {
@@ -238,6 +296,108 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
 }
 #endif /* mul_u64_u32_div */
 
+/*
+ * Not ported from Linux: mul_u64_add_u64_div_u64() and the
+ * mul_u64_u64_div_u64() / mul_u64_u64_div_u64_roundup() macros built on it.
+ * They need ~110 lines of lib/math/div64.c brought along, plus a u128 type
+ * and OPTIMIZER_HIDE_VAR(), and U-Boot has no users for them yet. Port the
+ * lot when the first one turns up.
+ */
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
+ * DIV_U64_ROUND_UP - unsigned 64bit divide with 32bit divisor rounded up
+ * @ll: unsigned 64bit dividend
+ * @d: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round up.
+ *
+ * Return: dividend / divisor rounded up
+ */
+#define DIV_U64_ROUND_UP(ll, d)		\
+	({ u32 _tmp = (d); div_u64((ll) + _tmp - 1, _tmp); })
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
+
+/**
+ * roundup_u64 - Round up a 64bit value to the next specified 32bit multiple
+ * @x: the value to up
+ * @y: 32bit multiple to round up to
+ *
+ * Rounds @x to the next multiple of @y. For 32bit @x values, see roundup and
+ * the faster round_up() for powers of 2.
+ *
+ * Return: rounded up value.
+ */
+static inline u64 roundup_u64(u64 x, u32 y)
+{
+	return DIV_U64_ROUND_UP(x, y) * y;
+}
+
+/*
+ * U-Boot addition, not present in Linux's <linux/math64.h>: Linux keeps
+ * abs_diff() in <linux/math.h>, which U-Boot does not have. Its other
+ * contents live in <linux/kernel.h> here, but abs_diff() was added to this
+ * header instead, so leave it be rather than move it around.
+ */
+
 /**
  * abs_diff - return absolute value of the difference between the arguments
  * @a: the first argument

-- 
2.54.0

