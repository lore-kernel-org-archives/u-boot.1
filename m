Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915CDC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E8A760A3F;
	Tue, 28 Jul 2026 18:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r1TUDI8nGGN2; Tue, 28 Jul 2026 18:51:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6010608FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264675;
	bh=geoEKv77dTfbB7j9pBMKMyP+xKx70RyiZzjSVAQSkZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=th1Hmr3fU5GLlbuFefxa4vjj1wO2v/a+Gil1aQMmzrGMyD35XSj2+OM8ar3HtPZzw
	 lyIyY3JYKLtDjLLR4WB2wjO8mid8ZNR1kga5Af7VbHq4J3LAB9wIBCSznKq5RpU7rP
	 nhkVzOmQjatMUzYTycVA+ZNeBBL6dlFKeD1/1mltnwW+Ou/WHe2BEXcQ44JEJppK2e
	 hR0xvIJSIO+pGwVyK00cNiYlQQdMH6Y+KH2S+QCwd6XankixmCkhMoq0StixVH1Q7G
	 E11BqVaYmlX36k6ndE+rnHfiVI8DvxjPEvNKGf5QUOFet2u2cyhzEdO7SgvINpFYKX
	 Dd/R8IkY2X6vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6010608FB;
	Tue, 28 Jul 2026 18:51:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B1D1A26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A38C040364
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id om2wadjeqnUx for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:51:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8F04740176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F04740176
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F04740176
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:12 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69fdcb13fdbso369226a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264670; cv=none;
 d=google.com; s=arc-20260327;
 b=NWNmxCZTLrGqSyksUHW5a50ihJE61bspP4yf4VvPKimZ2ZSPElPAUSNRr4aatGMmPP
 wpp6PrOEM+CjcDHYHZo+IbNUU59SJeLe7/WoSaGRpUxsmJ9Cd4mTdnZQkGgHotJ4duNt
 69oPYUQS9naOmMA13Tvb4k9eViPC+PJ7eQYiyj8D2mxEP1fgJ7it+rEm64uLdBY41mJr
 oDNLOGhmP+EbZBEP0WvBdtqvhSdGS8yAjXO2zQVrcv3p+HyPjoPrKJCaS+jlH3L0UDKE
 o03YhuypNhqwuJeSFdaf92Ze3jTeaz+DJQMKNqtS1rVXAHFkyM0bo+hrco22jTlt32Vp
 Zuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=geoEKv77dTfbB7j9pBMKMyP+xKx70RyiZzjSVAQSkZo=;
 fh=SRurN2QPTWsMi4Hsl8qsslgPeIZhzl0bdJ9eMM13CxY=;
 b=mS7QAlu3FdB65f5P/TFAMCZYV4ER1OQLWXKCmsgWQXsqufq368kJHslnEa2irEC0GV
 d/9QZXkrw9QsnD4YmYxUtwqR8iDWyG6afbuwpI/P0MXC2CbzfArYnuAQcwIBVfJoasx9
 tDGTVUjlreYCFaTM1Kx3YaXwmwpux0yAfFP4WqBlbdCgCz1l1wNssBK/q5g61WEoMzaQ
 pCUi1rHcIXhDWRo4vlK0TNwbGPhfJcqigPtMy8yf8p191NP+4YWWdx4b57m0JK5sM3/v
 86vik8zLI0zlIkLdnz5w4f9c+ruwyjmoVzAqetQk9950tKK1LyMw3s/DSnirvWVfZxXn
 Dt/Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264670; x=1785869470;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=geoEKv77dTfbB7j9pBMKMyP+xKx70RyiZzjSVAQSkZo=;
 b=f9Gu4g9MxVkIm0hTxychVjGyie3hpZXtLWyWN4GMyVCBFMQROhPhD+lCpp1nP4eLkN
 OpVTFP6Enl198YQc4x41Khqz3AUMDrsvyfUti7Rn7OzgLtjtfAEKa2lsRxyq6Da1P9ZC
 +Tmk8zeGrtOSReB9C8IyYBBcQLp2Uw0Gk4NwVPa6KL+HL1bDUV0I9lba4aV08gc8TnEA
 kFm1LPAE+zA3N7+4RDgKTcYLvIVpK7gLs0w/6YxKKLujdpbs12FcphmpLGfrq4LbTiog
 g7hpyrqnKAkA1oLFKg+wnirET/k3iIfBp9+jvhYhvFVWEJKD8nDk/M6mhSWzT453VK4f
 c7nA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLqEvTSz7WeHkM9gtdm/Ne7t8moMqEx9Jxe/lEdhqcfDuFtAxGF40OZmU8CrKg6VRGILuWUZM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxess0116RZ1vNukuX2AkcmitfmQ7aE9PicpLIe98vXOCbRDH74
 y/rLFVevsyjL9/mu4T0DRDuFqfQgnbCKuUVsqH/mvYnwPaPWvdwa5Gi12uS1fhBEK3/zVeQ+LnN
 nWYmEbFo46BRLW7j75IgrHcEUYuJL/7T+ifLZ2o/2VshymsWAzoM=
X-Gm-Gg: AR+sD11nG6pBBhxACqXskEekGu8qWY7a6WdHAY4l3K6VprKgIJo5tMjv6epazEduwwU
 XYAoyYx4CTvLJ1Y/V93UXIK+ah9fAhe1Brd5LxlVom8AJL2P0HiJgA+8z6FzmNyc/ENh21Krg2k
 d7+0bxXa+FwEJzHfXDC7XNDBYkxr22i6Kav+jicqfq2mVgWIDtz3bir0g2O4zY0qTCWFPiMjZan
 Per7n441kOQmpzhC7BbN6nGXDydScbEsoYzpOs/gNfg9NA1ECU7Pq0pvPG6
X-Received: by 2002:a05:6402:a0d4:b0:68b:ca3c:6bbb with SMTP id
 4fb4d7f45d1cf-6a034a63674mr1944158a12.11.1785264670567; Tue, 28 Jul 2026
 11:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
 <20260726115702.15397-2-bhargavdas100@gmail.com>
In-Reply-To: <20260726115702.15397-2-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:50:58 -0600
X-Gm-Features: AUfX_mwXbEYOhCKyHmdZFL0inSX9XtnS_oBiDcRooVVwJr-cKkvmlAPGnYLiS-g
Message-ID: <CAFLszTgH3j7mcGX6=NV1sNFZCAa74TF7Yq7nFLfEfKzrJ175BQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] arm: Add RP2350 architecture support
To: bhargavdas100@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264670; x=1785869470;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=geoEKv77dTfbB7j9pBMKMyP+xKx70RyiZzjSVAQSkZo=;
 b=jExxupCWYVIDXusreov9hFoCzqi36DtidI83Uz9zqLgezxKReCFGybzb9MUy34x95V
 3vWBGW9Alk9Uh2qOgDIdLSRtEo7vDczDtLMzGcgycSZNAiwM3JJCi1kVcs/3bMibEuMH
 LZe3yinTpfIFaMW4AvbJUCQc4DVMG5fdBcQCo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jExxupCW
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

Hi Bhargav,

On 2026-07-26T11:56:45, Bhargav Das <bhargavdas100@gmail.com> wrote:
> arm: Add RP2350 architecture support
>
> Add initial U-Boot architecture support for the RP2350 SoC.
>
> RP2350 specs:
> - CPU: Dual-core Arm Cortex-M33 or dual-core RISC-V Hazard3 @ 150MHz.
> - Memory: 520 KB on-chip SRAM, 4 MB on-board QSPI flash.
>
> Only Arm core support is added here.
>
> The architecture is added under arch/arm/mach-rp2xxx/.
>
> This patch implements early SoC bring-up:
>   - XOSC (12MHz crystal) startup
>   - PLL_SYS configuration to 150MHz
>   - CLK_REF/CLK_SYS/CLK_PERI clock switching
>   - UART1 early console init (115200 8N1)
>
> Cortex-M33 is an Armv8-M core, but U-Boot does not yet have a CPU_V8M
> architecture variant. CPU_V7M's startup and exception handling are close
> [...]
>
> arch/arm/Kconfig                          |   7 +
>  arch/arm/Makefile                         |   2 +
>  arch/arm/include/asm/arch-rp2xxx/rp2350.h | 307 ++++++++++++++++++++++++++++++
>  arch/arm/mach-rp2xxx/Kconfig              |  58 ++++++
>  arch/arm/mach-rp2xxx/Makefile             |   4 +
>  arch/arm/mach-rp2xxx/image_def.S          |  23 +++
>  arch/arm/mach-rp2xxx/rp2350.c             | 261 +++++++++++++++++++++++++
>  arch/arm/mach-rp2xxx/u-boot.lds           |  94 +++++++++
>  8 files changed, 756 insertions(+)

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -0,0 +1,261 @@
> +     disable_mpu();
> +
> +     for (i = 0; i < ARRAY_SIZE(rp2350_mpu_config); i++)
> +             mpu_config(&rp2350_mpu_config[i]);
> +
> +     enable_mpu();

This calls into arch/arm/cpu/armv7m/mpu.c, which programs the PMSAv7
MPU: it writes the region size and attributes into MPU_RASR.

The Cortex-M33 is Armv8-M and uses the PMSAv8 MPU, which as I
understand it has no RASR - regions are described with a base in
MPU_RBAR and a limit in MPU_RLAR, with attributes indexed through
MPU_MAIR0/1. So these writes do not configure the MPU as the comment
describes; I suspect the region setup is silently ineffective and the
board boots only because the default memory map is already usable. The
commit message argues CPU_V7M's startup and exception handling are
close enough, but that reasoning does not extend to the MPU register
model. Please can you either drop the MPU setup for now, or note
clearly that it is a no-op pending real Armv8-M support. What do you
think?

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -0,0 +1,261 @@
> + *   Region 0: XIP Flash  0x10000000 - executable, read-only, cacheable
> + *   Region 1: SRAM       0x20000000 - read/write, cacheable
> + *   Region 2: Peripherals 0x40000000 - read/write, device (non-cacheable)
> + */
> +
> +int print_cpuinfo(void)

he comment documents three regions, but rp2350_mpu_config[] only sets
up two (a single 512MB region covering ROM/flash/SRAM, and one for
peripherals) - please update the comment to match.

Also this block is the header for arch_cpu_init(), yet print_cpuinfo()
sits between it and the function it describes. Please move
print_cpuinfo() out so the comment sits directly above
arch_cpu_init().

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -0,0 +1,261 @@
> +     writel(0, &pll->pwr);          /* Power everything on */
> +     writel(PLL_PWR_POSTDIVPD | PLL_PWR_DSMPD, &pll->pwr); /* Keep post dividers and DSM powered down for now, only VCO on */

Does the first write actually do something useful? The second line is
also well over 80 columns - please move the comment above the
statement.

> diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
> @@ -0,0 +1,261 @@
> +     clrsetbits_le32(clk_base + 0x30, 0x3, CLK_REF_SRC_XOSC);
> +     while (!(readl(clk_base + 0x38) & BIT(CLK_REF_SRC_XOSC)))
> +             ;

The clocks code pokes bare offsets (0x30, 0x38, 0x3c, 0x44, 0x48) with
magic bit positions inline, which is hard to verify against the
datasheet. The cover letter notes struct rp2350_clocks_regs is defined
but unused; as it stands it does not even contain the
CLK_REF/CLK_SYS/CLK_PERI registers used here. Please can you extend
that struct to cover these and access them by name, or at least add
named offset/field defines in rp2350.h, rather than open-coding the
offsets?

I don't have one of these boards in my lab but I'm looking forward to it!

Regards,
Simon
