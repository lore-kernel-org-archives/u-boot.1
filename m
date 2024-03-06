Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63373C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 18:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE3DD879E8;
	Wed,  6 Mar 2024 19:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="E91Acv+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A8B87DF6; Wed,  6 Mar 2024 17:24:14 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA76687E63
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.wiecaszek@googlemail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d2509c66daso91963011fa.3
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1709742245; x=1710347045; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xiEdrAVrYTWIVoJCtvL/I8f58FhhO5DPSHAxXFsQkTM=;
 b=E91Acv+y3c6+4d0WIzCjBJX/V5NzUfOZfmdv68VFJfZuEQo62Py7kS9afQVaFUs8/2
 AM8fX1pKqa1DfGlthhVpB7IXI/QvCaKGnyVrn/Jk6YbVu0spjsFMF8Yj4VXYssIPd5QL
 BBIHuUlkPHCpoakBcEjUxGuXqfYWVZR1VUZtEcdTfSiAy/f5B9bz3Ak0uph4jRxHF4w0
 PeHcn4wQLwEN/PHwPXMVzFN8uqkvtYp3cs/HLl8/TIJl2U4sKdWHiX8xYFDj7fA3V9S5
 uJgfEVMq8xdabqqE2DQwZBUtqBpbNy29oTDvZRjB+4dFVw7ZjupxC1wS0RpIb7LVvr1+
 QNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709742245; x=1710347045;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xiEdrAVrYTWIVoJCtvL/I8f58FhhO5DPSHAxXFsQkTM=;
 b=CTBSoliIgOi8pE/Q00DHf2/KLVX5XXqH/kH3qvd3XMKuUS3q3E5y6OR6jBG3eRRZ26
 mLTBjLu2MGYGn6JN7aOl6gtbKsuY9SgvGdMAexJPxsTMku1jfphd83VbPDxSOpazv6Ug
 NG+vxlc62rO6CU9MlyYyDCEzQXBOq7GdBvDgDVQNWWWQI9ahVCIi4iFVevKQOzaoJtv+
 jQTl1rxAFZ0lUOOr+bhGPbG57iiyjXwxkes5Ezv9Y4qZSMJJCYU13bPwo04lFzRKnenb
 SvlxfAlTMI5wAQiLtWsAoIXbQK0ZCilugI0dVIcuokzm+6Iue4Xitmyb2/K3rTjd6SX5
 Hc9g==
X-Gm-Message-State: AOJu0Yx29P2xKx8Y82ijSZfiGkhg6Pj/a5LqDM2qEaE1P4zL4/rORTgN
 gYLiKTbN7p6+WGlFCIIETZtabvgFFYoHEFTlTN7cHW+xQHKfCaWzu2WYjQChJnUoW5wfrSbtc0f
 itWQ6IBk6n19HPheh9MEHonzFN3TC9Y0TrSo=
X-Google-Smtp-Source: AGHT+IGY5EfR5law3x3vEuNmmmdfvJdhcjCB3K3mzkWKjpWQ9xOF4K8uuIWfsbQ5CECpuUONyeUbP2/WC9kuVreM0os=
X-Received: by 2002:a2e:8716:0:b0:2d2:937d:f5fa with SMTP id
 m22-20020a2e8716000000b002d2937df5famr3498715lji.12.1709742245054; Wed, 06
 Mar 2024 08:24:05 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?xYF1a2FzeiBXacSZY2FzemVr?= <lukasz.wiecaszek@googlemail.com>
Date: Wed, 6 Mar 2024 17:23:54 +0100
Message-ID: <CAHnYusTGmUWt369vUmX3nNgkGttNd+bGJMen2=Gd7WQzZMTbRg@mail.gmail.com>
Subject: FEAT_CCIDX not tested when parsing ccsidr_el1
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 06 Mar 2024 19:20:40 +0100
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

Hello Guys,

Guided by the "Sending patches" tutorial, I would like to present a
problem I have encountered and eventually discuss whether it would be
ok to submit a patch for that issue.

The problem is in ARM arch and is related to the asm function
"__asm_dcache_level" from arch/arm/cpu/armv8/cache.S file.

<mrs x6, ccsidr_el1> line reads value of ccsidr_el1 register but does
not test against FEAT_CCIDX.
And when FEAT_CCIDX is implemented Associativity is coded on bits
[23:3] and NumSets on bits [55:32] which means that the number of
cache sets and ways is wrongly parsed and cleaning/invalidating of
cache does not work.

I have already prepared a patch for our work related product and now I
am thinking of mainstreaming that piece of work. What do you think
about that?

Briefly, patch would look like this:

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
        isb                             /* sync change of cssidr_el1 */
        mrs     x6, ccsidr_el1          /* read the new cssidr_el1 */
        ubfx    x2, x6,  #0,  #3        /* x2 <- log2(cache line size)-4 */
+       cbz     x16, 3f                 /* check for FEAT_CCIDX */
+       ubfx    x3, x6,  #3, #21        /* x3 <- number of cache ways - 1 */
+       ubfx    x4, x6, #32, #24        /* x4 <- number of cache sets - 1 */
+       b       4f
+3:
        ubfx    x3, x6,  #3, #10        /* x3 <- number of cache ways - 1 */
        ubfx    x4, x6, #13, #15        /* x4 <- number of cache sets - 1 */
+4:
        add     x2, x2, #4              /* x2 <- log2(cache line size) */
        clz     w5, w3                  /* bit position of #ways */
        /* x12 <- cache level << 1 */
@@ -74,6 +81,8 @@ ENTRY(__asm_dcache_all)
        ubfx    x11, x10, #24, #3       /* x11 <- loc */
        cbz     x11, finished           /* if loc is 0, exit */
        mov     x15, lr
+       mrs     x16, s3_0_c0_c7_2       /* read value of id_aa64mmfr2_el1*/
+       ubfx    x16, x16, #20, #4       /* save FEAT_CCIDX identifier in x16 */
        mov     x0, #0                  /* start flush at cache level 0 */
        /* x0  <- cache level */
        /* x10 <- clidr_el1 */


Best Regards,
Lukasz
