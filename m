Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3C9C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76F2881205;
	Thu, 30 Jul 2026 18:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYwTJ0Ojeive; Thu, 30 Jul 2026 18:41:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1F0481201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785436889;
	bh=BhLfi7P8hidf47VZpURszYVyT+ZlNISHoB+DEgU951Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fIj7h9LDatGUddoLVRFEPoACdrAeVfhdpxbl5MLx9PlWA8lekmsrFmK82rLZ9wioH
	 rCq84naeOzRA2urcKYioaibBH0XD6C793irOtl3NmgpW4VuTdRvuX/vrszivCK0sad
	 YcpFYglSik3Lqi/zvgHcFR21ah/EOLLTVQ+/ruDqqKLooxZ0if0AL7vo3aBcXVKd6l
	 DJAM8NQWNteVUP7ewO6WbjX3WPvJ/wfNu7IiJAeRz0I9Qs5uBUcxxt8k7oMB0bes3c
	 nvcBornCoOFLvJHETb0XrnefhTlHGmlQ3P6a/MxKEghvBEutq/T1Zd9OO0VW8EVKEf
	 va4+9Y6CQ2WKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1F0481201;
	Thu, 30 Jul 2026 18:41:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F98127C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35A7560A6D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXD-b8PQaDTF for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:41:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2350B60A6A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2350B60A6A
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2350B60A6A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:24 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso8255f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436883; x=1786041683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BhLfi7P8hidf47VZpURszYVyT+ZlNISHoB+DEgU951Q=;
 b=BHDjoon4PMgNlstt/JevY7eAmNonq/XLqEkuOePKZDUGxELTFFTXBeooeqeZNN3hQZ
 YIqf6B1TJgKK0E7h1Nw2kQxv80e0EEgt81I4gwg/y7sOkEUMl2jABvaOqmH8SUSftCdf
 pTCqGjZa/dufW6LfGKCE14lDAuYHjiUrNCNv/0TVuedxPu1NjuwlC+pR95gAKifsYtBQ
 OyrIVRCkdm3iHasBDkDRowIl55aJde5HAa0bqdrbqrDZNH0YRs14nXceE4dtC9q5f+Rm
 V1vLwVMezTylSk3U0OWMh6sBLShUQrsKPqeoowQtQ4OXSyxv/b84zuKcRi7ZitaQJOO+
 dQoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK5me7kfm7utunIjS+vQ7qNSA9FssTrRS2ffcVWkvLuLUVIbldy8P+tbrypZNGG2CY8esb/CU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YySBvSefRgaO+lLVWSVGDIdowd6kHEZ84LhE10ofPcJNsYzLBSH
 SNrgum9U1IfSX8deteaSAQ1xrsPPUOPoQ4x41Xx7NT5/lizsqo8zCocPHmz6l0Go4tEL33xqltU
 ao2HyL8PtUQ==
X-Gm-Gg: AR+sD11TaqPGPh9x12MYuzpj/VIyV1CKzh3Y78leRxtybUoqT+hqsBbWCRDtrN8bnQt
 i/Ydl3vY+wcZ/zW0UDX2fuUH5oCa1fjg7dDb+VITn9juaalL34X8yk7FGy+ZrCrFDLZlvZhx1HO
 vS5ziunzRMsUxAMZlgNJbnFoLlA15NSN8VYvTTyASj8HkhH9chX4S4nHm4YIOkHss5Sii7fcpDC
 lgL2H/t+FjOY8s6cfyB3rlwK8VRJQNAPo86oDB57gwwPAdTlnEuv72sicUJMvW2TW1T9cxt8Vwc
 0zlokmk+kmeGOvy2t7Y0uwBXbXZyiIRmRfu//jbJYdH4msPiawdIxrZTvBljyZBQRhjdAFHIXhH
 8lMitsaFnWl+EE3Mgvid/3Yxbd5eRuYTwwOZpTXeBAbo0QNUaw59THYdd10HEoYAxUaenYg5VEO
 ipYwPUomq5e8nkIsbBzKbegkScfHof7qp4mebFpUzhjE6ZWglPFcd0TviPVoVyS29KHvQxtG7UD
 UUK0pEEsHiw4zryMhOZqwpst4BqqTDd5CGq02jZdA==
X-Received: by 2002:a05:6000:2308:b0:47f:9404:5188 with SMTP id
 ffacd0b85a97d-47fc81f3738mr5491180f8f.37.1785436882181; 
 Thu, 30 Jul 2026 11:41:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d8d37sm7919603f8f.8.2026.07.30.11.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:41:21 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 22:40:41 +0400
Subject: [PATCH 4/5] lib: div64: sync with Linux v7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-math64-resync-v1-4-8792d9119d49@flipper.net>
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4146; i=alchark@flipper.net;
 h=from:subject:message-id; bh=MR3z5IitAlelysHIf6HRT31SspRZcVWy/HzAzDB6Wtc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlzzp6Y4+u/671ri75X7znaVw4IcuTb/Vzw2zRI1cM3
 8v2MuwW75jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqN1YwMrx4No9tRo3prxbPfLWQP0sZuGf53t0yceHbz5rNrx60rmxm+M36aPZ
 E64J/zcs0FuSnXpqtPe3TtLgHk+d8/rj4b7Gh/lYOAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785436883; x=1786041683;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BhLfi7P8hidf47VZpURszYVyT+ZlNISHoB+DEgU951Q=;
 b=SYM+YNCxXM9nFvDsccFSOCrnHlMDWxTj4sDuWrPXU2L3LCBKKHt9paR8FAgbuGw8L8
 RuoqLRxte1Adbq/eORevjze1QV0C5kwWduIBDDxBM/TmcUPjCS0akkqzXaqgXK2XDLp1
 K2Gtx8NvU5lOYhSbSQxB5RGQaxWJRRD3aFcgKWvMiAlaeHiBHDbKPN/zwqyC5bdaF1eb
 qgdHXqJ0qjdEm6jMi7psqjfTzgOzQhm6eizYRCSB3MFCJjBPLMvzKuWhmMHoxvhrTjbZ
 C37F4O7lPuHsXc3ivY/wXIhHBXjrUIrUoShGhTxcei6uOTRVESaomo+5oGlibMV+GF1L
 NmFA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=SYM+YNCx
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

Bring the structure of this file in line with Linux v7.1
lib/math/div64.c, so that future resyncs are a near-verbatim diff. No
functional change: the compiled lib/div64.o is byte-identical before and
after, verified by comparing objdump -d output for both
evb-rk3288-rk808_defconfig (32-bit, where these out-of-line helpers are
actually built) and generic-rk3576_defconfig (64-bit).

 - Add the SPDX license identifier, as upstream did in commit
   b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier
   to files with no license").

 - Demote the kernel-doc blocks on div64_u64_rem() and div64_u64() to
   plain comments and drop the one on div64_s64() entirely, following
   upstream commit d28a1de5d112 ("math64: favor kernel-doc from header
   files"). The kernel-doc for these lands in <linux/math64.h> in a
   later patch of this series; keeping it in both places would only let
   the two copies drift apart.

 - Guard iter_div_u64_rem() with #ifndef iter_div_u64_rem, matching
   upstream, so an arch can override it the same way it can override
   the other helpers here.

Two U-Boot-local deviations are kept deliberately and are now marked as
such so that the next resync does not silently drop them:

 - __div64_32() carries a no_instrument_function attribute, needed
   because CONFIG_TRACE builds with -finstrument-functions and this
   function is reachable from tracing code via do_div().

 - The includes stay as they are. <linux/compat.h> provides U-Boot's
   no-op EXPORT_SYMBOL() in place of upstream's <linux/export.h>, and
   <linux/kernel.h> provides abs()/abs64() in place of upstream's
   <linux/math.h>, which U-Boot does not have.

The u32/u64 spelling is also left alone rather than converted to Linux's
uint32_t/uint64_t: U-Boot's <div64.h> already made the opposite choice,
and matching Linux here would make the two files inconsistent for no
benefit.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/div64.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/lib/div64.c b/lib/div64.c
index 9db7499fcd34..e3553c3956ed 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
  *
@@ -27,9 +28,9 @@
 
 #ifndef __div64_32
 /*
- * Don't instrument this function as it may be called from tracing code, since
- * it needs to read the timer and this often requires calling do_div(), which
- * calls this function.
+ * U-Boot addition, not present upstream: don't instrument this function as it
+ * may be called from tracing code, since it needs to read the timer and this
+ * often requires calling do_div(), which calls this function.
  */
 uint32_t __attribute__((weak, no_instrument_function)) __div64_32(u64 *n,
 								  u32 base)
@@ -87,7 +88,7 @@ s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
 EXPORT_SYMBOL(div_s64_rem);
 #endif
 
-/**
+/*
  * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
  * @dividend:	64bit dividend
  * @divisor:	64bit divisor
@@ -127,7 +128,7 @@ u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
 EXPORT_SYMBOL(div64_u64_rem);
 #endif
 
-/**
+/*
  * div64_u64 - unsigned 64bit divide with 64bit divisor
  * @dividend:	64bit dividend
  * @divisor:	64bit divisor
@@ -161,11 +162,6 @@ u64 div64_u64(u64 dividend, u64 divisor)
 EXPORT_SYMBOL(div64_u64);
 #endif
 
-/**
- * div64_s64 - signed 64bit divide with 64bit divisor
- * @dividend:	64bit dividend
- * @divisor:	64bit divisor
- */
 #ifndef div64_s64
 s64 div64_s64(s64 dividend, s64 divisor)
 {
@@ -190,6 +186,7 @@ EXPORT_SYMBOL(div64_s64);
  * Iterative div/mod for use when dividend is not expected to be much
  * bigger than divisor.
  */
+#ifndef iter_div_u64_rem
 u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 {
 	u32 ret = 0;
@@ -210,3 +207,4 @@ u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 	return ret;
 }
 EXPORT_SYMBOL(iter_div_u64_rem);
+#endif

-- 
2.54.0

