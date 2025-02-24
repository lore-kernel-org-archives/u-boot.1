Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78A5C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 11:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CD9805C3;
	Mon, 24 Feb 2025 12:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="WqlPdhgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE87805C4; Mon, 24 Feb 2025 12:21:18 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160A080079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 12:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 75b0c863-f2a1-11ef-beb7-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 75b0c863-f2a1-11ef-beb7-005056992ed3;
 Mon, 24 Feb 2025 12:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=yQ5z6JX+RYl1StLDSk/T7LjeRzldHzqgY7Y2pk5pv04=;
 b=WqlPdhgXIK+VMcNn2vbmpN5y6bZ2cmC3FNZUeFNLF7fgobHG1tno0gjdFf3q2Ybyir3w/Oh+BEFck
 jq9ifYGx4IBb4Couo0wbzjj7F06X5EdgU7cTVIcIX33XXjP6IsSPy3mUaWwFe5y9pjKv92AmD8j0vA
 hVNvwWhsBLUBgVkslrYCUOm/4aywfYpMEXf3XcbV0vSTWbNxz9mnAJ7FbyweyPQ75vsIG1bmIQ0Tuc
 UIzx89a0J6L/VEChYQ1/1qOhaW80lrRavTEYYzvOB1njdZMuvJMhPVBm1MORNWT0yont+O+PueeRaK
 j0WILkSAMqIf5s7l7+bvxxNIm/s60HA==
X-KPN-MID: 33|tdpwhJwCP4O19UpgEuArbZWa9oapGpOR98qqducfzSAw3ZYaZzuduJWzuJ7ZkBt
 eSDGWq+JmK0QoZRsVzVb+p4tQ7qlDJatOyc5tWuCJddA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LLpNAWFQVNTjAoOnuHhdTRC9YT8QfKIfmrzm6bv2NuzNILbBOCPxHPczvsNtPvx
 LagZTFHz1SDgqvLBtXgF48w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 7580749c-f2a1-11ef-97ad-00505699d6e5;
 Mon, 24 Feb 2025 12:21:15 +0100 (CET)
Date: Mon, 24 Feb 2025 12:21:14 +0100
Message-Id: <87ldtvr3kl.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Sam Edwards <cfsworks@gmail.com>
Cc: trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng.cn@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, pbrobinson@gmail.com,
 richard.henderson@linaro.org, u-boot@lists.denx.de, CFSworks@gmail.com
In-Reply-To: <20250224055524.1334929-7-CFSworks@gmail.com> (message from Sam
 Edwards on Sun, 23 Feb 2025 21:55:13 -0800)
Subject: Re: [PATCH 06/17] arm: Use -mstrict-align when the MMU is off
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-7-CFSworks@gmail.com>
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

> From: Sam Edwards <cfsworks@gmail.com>
> Date: Sun, 23 Feb 2025 21:55:13 -0800

Hi Sam,

> On ARM, enabling the MMU is a prerequisite to enabling caching, which
> allows unaligned memory accesses by consolidating them into aligned
> accesses. When the MMU is disabled, however, all accesses must strictly
> adhere to the alignment rules.
> 
> Some compilers (e.g. Clang) contain optimizations that may break these
> rules on the assumption that misaligned accesses merely incur a
> performance penalty. We do not necessarily want to prevent the compiler
> from applying these optimizations where it believes there may be net
> gains, but we do need to tell it to respect the alignment requirements
> when the MMU is disabled.
> 
> Therefore, add the `-mstrict-align` compiler flag when SYS_ARM_MMU is
> not set.

The default for this option changed somewhat recently in clang for
non-Linux targets, which may explain why this wasn't an issue in the past.

One question though.  I believe there is some C code in U-Boot that
runs before the MMU gets turned on, even if SYS_ARM_MMU is set.  That
code should always be compiled with -mstrict-align.  And what about
SYS_ICACHE_OFF and SYS_DCACHE_OFF?

So I wonder if -mstrict-align should always be used for arm.  I doubt
the optimizations the compiler is doing in absence of that option
result in any measurable speedup.

> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/config.mk | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> index e0045e22271..98237b251f1 100644
> --- a/arch/arm/config.mk
> +++ b/arch/arm/config.mk
> @@ -33,6 +33,10 @@ PLATFORM_RELFLAGS	+= $(LLVM_RELFLAGS)
>  
>  PLATFORM_CPPFLAGS += -D__ARM__
>  
> +ifneq ($(CONFIG_SYS_ARM_MMU),y)
> +PLATFORM_RELFLAGS += -mstrict-align
> +endif
> +
>  ifdef CONFIG_ARM64
>  PLATFORM_ELFFLAGS += -B aarch64 -O elf64-littleaarch64
>  else
> -- 
> 2.45.2
> 
> 
