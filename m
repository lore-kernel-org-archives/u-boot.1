Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2984C54791
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 12:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CAC87EB5;
	Sun, 10 Mar 2024 13:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="Ulx8Xy35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A699E87D84; Sun, 10 Mar 2024 11:30:28 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FCB87D1A
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 11:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.wiecaszek@googlemail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d382a78c38so40282441fa.1
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1710066623; x=1710671423; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zQMguhoN+a7QPSkCZ2ofmhCAA3WrtffvyK43s17BqL0=;
 b=Ulx8Xy35OrcaO00oOdjSd7LDoBRVfpcizIf5S8jRKXEce/svVszlZXR1Ug3XyYzd+0
 tQ4nBlAVr9TvF+M8c9RgEnQBJjoopfaeOaGh9vHwHQDaYN5ZNg9000wgPGph4jGAgjv0
 IOjEHL+/CjFvxyJu+/XwaVNRvrHgAu05bwPZYTrHWzmkBpuuaL+Xp8+WByowBzEXY8cA
 iJG6GtgskvrlbadG2y5Y4ow2XhekTHafGXAfqVfUt0y4plDf619QUgJeIbT7Qqr7tB+W
 7so5aMBgQZWDY3faRCvbABXd8KRs16pegURHLV2mZLp3k1FDkyJ9JPGwLfd3jDqP7yFX
 +2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710066623; x=1710671423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zQMguhoN+a7QPSkCZ2ofmhCAA3WrtffvyK43s17BqL0=;
 b=LyNl/BhNheP2T5DYARxQ8KHLdVazNhHL4WG4QD0COLK2EcmMN9rS/VDU4z+DXWdLWP
 KnTMfDzYeAqxy76cG+CbSjJn9dy3H7VIq8jFcBAZgChIGtiq9KXBH1cAhn20aAvpVnS/
 Enwr0ujgKMEV2zqbGO1+sWW5i1K1Vx8UilPy5BsqmihQmGNoaMtj5azPrAADmzwMkWmz
 h55PbHZ5wFDDDVJ/t/tAMAofI17oU8qzX7JIu3SV3hJLrSCqQMhRCWRQGBvwrTKxNQzo
 07oMqN/sRfcPV8cs04xdKgKG7x46ZhdZUr+hhL/d+Sh/nT9z9l4XbnHtHQrmye6wurD7
 +5Tg==
X-Gm-Message-State: AOJu0YxM9bNCYfm4vXCvc5AFpcgOwn7HkOjiFOvxCotLaN1KLVQllMRG
 Q/Fw1NfXJIW6yhpu+wvFqXciKF7fVC3k98PZ0kc45O7DeoGNc7VdWSx6go9VkZhYgw==
X-Google-Smtp-Source: AGHT+IFCOqfmDizn7V4CohmJhTih7MNR4IqGpC93zE+lAG9deYtYiyq2wGfJvuqSfcPCCAZ0YFpDMg==
X-Received: by 2002:a2e:7a0d:0:b0:2d2:e44e:a5cc with SMTP id
 v13-20020a2e7a0d000000b002d2e44ea5ccmr2007260ljc.46.1710066623182; 
 Sun, 10 Mar 2024 03:30:23 -0700 (PDT)
Received: from localhost.localdomain ([78.133.163.249])
 by smtp.googlemail.com with ESMTPSA id
 a11-20020a2e860b000000b002d2d439efa8sm611561lji.105.2024.03.10.03.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 03:30:22 -0700 (PDT)
From: Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
To: u-boot@lists.denx.de
Cc: fenghua@phytium.com.cn, Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: Check FEAT_CCIDX when parsing ccsidr_el1 register
Date: Sun, 10 Mar 2024 11:29:58 +0100
Message-ID: <20240310103003.2302-1-lukasz.wiecaszek@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 Mar 2024 13:10:19 +0100
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

Current Cache Size ID Register (ccsidr_el1) has two "flavors"
depending on whether FEAT_CCIDX is implemented or not.
When FEAT_CCIDX is implemented Associativity parameter
is coded on bits [23:3] and NumSets parameter on bits [55:32].
When FEAT_CCIDX is not implemented then Associativity parameter
is coded on bits [12:3] and NumSets parameter on bits [27:13].
Current U-Boot code does not check whether FEAT_CCIDX is implemented
and always parses ccsidr_el1 as if FEAT_CCIDX was not implemented.
This is of course wrong on systems where FEAT_CCIDX is implemented.
This patch fixes that problems and tests whether FEAT_CCIDX
is implemented or not and accordingly parses the ccsidr_el1 register.

Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
---
 arch/arm/cpu/armv8/cache.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache.S b/arch/arm/cpu/armv8/cache.S
index 3fe935cf28..c9e46859b4 100644
--- a/arch/arm/cpu/armv8/cache.S
+++ b/arch/arm/cpu/armv8/cache.S
@@ -20,6 +20,7 @@
  *
  * x0: cache level
  * x1: 0 clean & invalidate, 1 invalidate only
+ * x16: FEAT_CCIDX
  * x2~x9: clobbered
  */
 .pushsection .text.__asm_dcache_level, "ax"
@@ -29,8 +30,14 @@ ENTRY(__asm_dcache_level)
 	isb				/* sync change of cssidr_el1 */
 	mrs	x6, ccsidr_el1		/* read the new cssidr_el1 */
 	ubfx	x2, x6,  #0,  #3	/* x2 <- log2(cache line size)-4 */
+	cbz	x16, 3f			/* check for FEAT_CCIDX */
+	ubfx	x3, x6,  #3, #21	/* x3 <- number of cache ways - 1 */
+	ubfx	x4, x6, #32, #24	/* x4 <- number of cache sets - 1 */
+	b	4f
+3:
 	ubfx	x3, x6,  #3, #10	/* x3 <- number of cache ways - 1 */
 	ubfx	x4, x6, #13, #15	/* x4 <- number of cache sets - 1 */
+4:
 	add	x2, x2, #4		/* x2 <- log2(cache line size) */
 	clz	w5, w3			/* bit position of #ways */
 	/* x12 <- cache level << 1 */
@@ -74,6 +81,8 @@ ENTRY(__asm_dcache_all)
 	ubfx	x11, x10, #24, #3	/* x11 <- loc */
 	cbz	x11, finished		/* if loc is 0, exit */
 	mov	x15, lr
+	mrs	x16, s3_0_c0_c7_2	/* read value of id_aa64mmfr2_el1*/
+	ubfx	x16, x16, #20, #4	/* save FEAT_CCIDX identifier in x16 */
 	mov	x0, #0			/* start flush at cache level 0 */
 	/* x0  <- cache level */
 	/* x10 <- clidr_el1 */
-- 
2.44.0

