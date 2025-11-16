Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D41CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 09:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBBDB838A5;
	Sun, 16 Nov 2025 10:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Od2u2EVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E89683959; Sun, 16 Nov 2025 10:56:09 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC21836D1
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 10:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-640b06fa959so6029536a12.3
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763286966; x=1763891766; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C9cO6EcgEwcBsL0k250wBBWSRBRCY4KYFplvyLljofg=;
 b=Od2u2EVfDNoMi22wOXy0InrPQmORD+Vma0ZS5DyE91E2v//d2rl8WN5TqB5l5IUIsd
 WHbMp9yvfL4mJo/iet/CgrV3vtHPglGI2sxGO+LdTtrkRuyCf9B7FoSfU7fSvDTNMWYN
 0btFX+VsXqsO6IfPyUYBKlb3Mmmav7tbv+k1D68PWydgKCln+8TepKBnVJrrFBVN3r6O
 41OMwIrSCZFil3GiKBDFLxxNTeQxJpc044YEfThejXLnvfzD/esdvk0nzF/K1ukCggqm
 VHgGaElUKpg9xo4vgB09wUJRxE2nlz0nkIU0Z224ITXcCYhNvEM4/gjtY29Jp4CJh4Ur
 jWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763286966; x=1763891766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9cO6EcgEwcBsL0k250wBBWSRBRCY4KYFplvyLljofg=;
 b=FJggk2ZDMTSiddWOF0F467NK1EISznwqFmRPPHnMyysTeLJwDbaqAvY/aofXH/vAF9
 EsUbhqjpTIpnVKEMCGR7fOnFcJvVoU5hpuYBwgBafwIVc8ALeQecJhqe0vvm6qX8npuQ
 1HbHa1to6AyUMc+ELKCjdNILa1mWVl4q8UQUzovbb4xfcL3CSg9nXzWSpM/0i+mqFLrg
 MSPT/PUlKM7NBZ4iyDCjZ0zWTVRffzJHTCNkJwmEBkwU7uIghZYWY6p03EFJJlBCSzZD
 Ym/6WATks4G61/CC8bnyY+dDaYsBGSmhTmV/iU5HEhLAjl/jvYQXemVUMHfPXgpiizfI
 O8xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVxBS5QQJ6v82iEf63fZkUq7mYEoQM+G41SiLFC0+EPlZamRgI1mSi1J0lYtNq4yIHZf2WeQQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzwrxgYmvuN2Dn+b6fhdklfq7fTkImDttsexHKkGEmsBp8i5+cX
 NjQ8SfAulaS8TCAy5S565uYODW+yHF3ABjhaq4DvmSt5hmibstqKMPzXWL+CrHn+1x0EZpmOOsu
 g0iTAzLOEB2lAjmu/d893lW+eASmj1yM=
X-Gm-Gg: ASbGnculBFxDGwlpMuil88fbCq/yugQ00I3oHesdpG9G4SF91K5NXvlOmzj9AwuPBEN
 rWmvyJf4yPXcxd1AS8UCupk43qY7sYu6OeymHhlZDEXnya5S8Uum53pPNM1gM8YGDnHqpEKa2LA
 oiUjDTS5VOveElNgizVrOY+n9mjcZpm0gupQCLlPfn/ZOBAaBBwAni4VnovU3PWspAdzyzENtPD
 iWXYWmo7JcUPWr2A0eE4OJSoqs2oEPc7+7GYF6Jcr8Mdpg6wjRDkIeOPihhQBThpg1X9zN8RZsN
 7U6QcFZiIl7V5zk9nwdApJH0RMBx7vEf78yDJZYxmj0U6xewFEe6DM+++kPnWMXEnyjwpdF6ZvN
 pWLjDdq3OGl6LNDFV1PMX61Xl29mfUzNOukGAVKDfj45ddb8S
X-Google-Smtp-Source: AGHT+IGHa4FU8GXNkCuTHL3FD/Q22BoHwgXZBB0oSimGGS8z7RKNlWd4QbREwO1v2XgdT/OcRGu8ed3h+n10FPQeXw0=
X-Received: by 2002:a05:6402:2392:b0:643:8301:d10e with SMTP id
 4fb4d7f45d1cf-6438301d4bfmr1520959a12.19.1763286966256; Sun, 16 Nov 2025
 01:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20251116014531.2133243-1-jonas@kwiboo.se>
In-Reply-To: <20251116014531.2133243-1-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 16 Nov 2025 09:55:55 +0000
X-Gm-Features: AWmQ_bk-I3Gu6BG0-mDVAaUSAe1L16G7wTozDDbPRyl7guPnr0EZGjJ4cQCr-HU
Message-ID: <CALeDE9OzWUNOmsgQ+S5PRCSQmXne=YBXwSZmXP-AtgmY=RQe+A@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3588: Map SCMI shared memory area as
 non-cacheable
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hey Jonas,

> The SCMI shared memory area is no longer automatically marked as
> non-cacheable after the commit a5a0134570c8 ("firmware: scmi: Drop
> mmu_set_region_dcache_behaviour() misuse").
>
> This change in behavior cause Rockchip RK3588 boards to fail boot with:
>
>   SoC:   RK3588
>   DRAM:  8 GiB
>   scmi-over-smccc scmi: Channel unexpectedly busy
>   scmi_base_drv scmi-base.0: getting protocol version failed
>   scmi-over-smccc scmi: failed to probe base protocol
>   initcall_run_r(): initcall initr_dm() failed
>   ### ERROR ### Please RESET the board ###
>
> Update the memory mapping on RK3588 to mark the SCMI shared memory area
> as non-cacheable to fix the SCMI shared memory based transport issue
> that prevented RK3588 boards from booting.

Will the other newer rockchips rk356x devices which use SCMI need this fix too?

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/mach-rockchip/rk3588/rk3588.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c01a40020896..55d2caab4fec 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -63,7 +63,20 @@ static struct mm_region rk3588_mem_map[] = {
>         {
>                 .virt = 0x0UL,
>                 .phys = 0x0UL,
> -               .size = 0xf0000000UL,
> +               .size = 0x10f000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +                        PTE_BLOCK_INNER_SHARE
> +       }, {
> +               /* SCMI shared memory area must be mapped as non-cacheable. */
> +               .virt = 0x10f000UL,
> +               .phys = 0x10f000UL,
> +               .size = 0x1000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +                        PTE_BLOCK_INNER_SHARE
> +       }, {
> +               .virt = 0x110000UL,
> +               .phys = 0x110000UL,
> +               .size = 0xefef0000UL,
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>                          PTE_BLOCK_INNER_SHARE
>         }, {
> --
> 2.51.2
>
