Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620B3C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DBE87F4E;
	Thu, 16 May 2024 13:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LFP1jzio";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508D087FF2; Thu, 16 May 2024 13:51:30 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B384587C40
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f0f252db4dso38357a34.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715860286; x=1716465086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W29O8AhBFnM3aVRRC+y0jut1R0HOMv4xXIbcczOnaRk=;
 b=LFP1jzioI3uuaLujL8A1B9cvS6f9YAZ0DLi4SCcxRqDqzPlNqb4HGKpzFQ+AWrYVe8
 TTVE/MhXPeTd+KZUvN3t7QvYhEiM+MnpPSSVHdsRb/DwlhYzgTXxgljzWKOX7p4b3R5b
 QxniHQsal/8SPhJveog8uNOPJLFhL4xThyhzL9NY5DC6D8f+xdVomY7gmyV/ulsu3K1I
 pS4iXHK/mMM7lB44Tw3rZ53akQo3q7TkcgRNbc3xBstxh9C2CeuDKH4/MMzAzOqqcqMO
 nm7ENeoItwAaTDzSGzvS1swd7LyGcyeN0OyFEHiuKkTgJznNa2Gl1jZcoeCokH6Tj2Pq
 z8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715860286; x=1716465086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W29O8AhBFnM3aVRRC+y0jut1R0HOMv4xXIbcczOnaRk=;
 b=alcRa2He0PT3ci9oc4+a7ZAQb+X/VkBnofUCi7U5CHx6Xwh1pIVimKUAlWjLhyz8Ek
 pLHxAq1eoNHSsdyDzIYTxdcEFzGaLOI6aoWV4NKCW7w/6JKOyYKXTvDpnofWgdOro6RJ
 L0usz6RFXsYDjT9/8jDfVEt5jocnTMCRiDIfC3UDgp6PqckX5sv/wWp74oAXo73Pp/MF
 vBUm+NnifaOsBchPU94Xc5RFD18TFTgrt25pSB0BXf+H66fVY61a5dQh718xCx6gmwx8
 C547Wzar+zyuhAco5KS5S8D2CoKr1ajpS0PTQH8n93DSNfMzi/qKZauxrc1CYl/KuEYn
 tiGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ2HbAoUqHUQeJvlgJd3DbNgIXyia6nf7AECgviJvGhTxDM2BBUqb21UOoOlQNmskoko9txXO97Ue9sg1DkSIc1E2Gpw==
X-Gm-Message-State: AOJu0Yz9qyXzqYJQsBI+qYAf9J9JH7BAKRTpIkLWCiatDvSa8qnXzM8J
 BLZk3FVLxa12GYlL9wVxg795b6n7TzWP2ysMearafVMXyP6kuPu7J5n30wJRL780Jzm15u4SENj
 nB0LzCIlIy04iVj+NgXaQw4luKns=
X-Google-Smtp-Source: AGHT+IHNi2xUXp+VicEuvQaXAhNgTEeUYX5BORHWUGhwmVRaw22DwAjhA5zXw0GxEsoyctAFs6fHJHjxygVMqjJsS4o=
X-Received: by 2002:a05:6870:b149:b0:23d:8e24:7234 with SMTP id
 586e51a60fabf-24172fb6251mr22683112fac.54.1715860286395; Thu, 16 May 2024
 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-10-anand@edgeble.ai>
 <1c5c0be5-eb49-4af9-be29-e4ab95e9f8be@cherry.de>
 <CANAwSgS3Fd91FqQkfKHxVBYJ8-2LSdY4z4Tmx31UY7Bhd9K37g@mail.gmail.com>
 <1529741c-f09f-42c4-9bd2-e59b1c2828c2@cherry.de>
In-Reply-To: <1529741c-f09f-42c4-9bd2-e59b1c2828c2@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 16 May 2024 17:21:09 +0530
Message-ID: <CANAwSgRsnZ6OsFcD2=tNrxoBft30XrxzbMyQzGPpWnkGdgzr5w@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] rockchip: RK3588: Enable display cpuinfo support
 on all boards
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Andy Yan <andyshrk@163.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, John Clark <inindev@gmail.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 u-boot@lists.denx.de
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

Hi Quentin

On Thu, 16 May 2024 at 16:13, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 5/16/24 12:12 PM, Anand Moon wrote:
> > Hi Quentin
> >
> > On Thu, 16 May 2024 at 14:52, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Anand,
> >>
> >> This is patch 9/9 but somehow I didn't receive any other patch, nor did
> >> the mailing list? c.f.
> >> https://lists.denx.de/pipermail/u-boot/2024-May/thread.html and
> >> https://lore.kernel.org/u-boot/. Are you registered on the ML?
> >>
> >
> > Thanks for your  review comments.
> >
> > Something went wrong with git sendmail,
> > Your message have not reached my email client (gmail)
> >
>
> A mail server rejected the mail to edgeble.ai domain (both you and
> Jagan) /me shrugs.
>

Yeah, something went wrong. It's Gmail server or u-boot mail server blocked
I don't know the reason for this.

Remove me and Jagan (edgeble.ai) for now as of now.

> >> On 5/16/24 10:59 AM, Anand Moon wrote:
> >>> Imply DISPLAY_CPUINFO Kconfig options to support on all RK3588s and
> >>> RK3588 boards, Its used to determine the reset cause of the board.
> >>>
> >>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> >>> index 2e9c71138e..1b5cc34f99 100644
> >>> --- a/arch/arm/mach-rockchip/Kconfig
> >>> +++ b/arch/arm/mach-rockchip/Kconfig
> >>> @@ -366,6 +366,7 @@ config ROCKCHIP_RK3588
> >>>        imply SCMI_FIRMWARE
> >>>        imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> >>>        imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> >>> +     imply DISPLAY_CPUINFO
> >>
> >> This is unnecessary, it's already defaulting to y if building for ARM
> >> boards: https://elixir.bootlin.com/u-boot/latest/source/common/Kconfig#L596
> >>
> > See below...
> >> I also don't think this is SO useful that we need to enable it on all
> >> rk3588 boards? But also, doesn't hurt, so... whatever I guess :) ?
> >>
> >> While looking at the code, I think we can remove the ifdef in
> >> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/cpu-info.c#L47
> >> because this file is anyway only compiled when CONFIG_DISPLAY_CPUINFO is
> >> set, c.f.
> >
> > Oops I missed this changes, my bad
> > I will dop my changes over here.
> >
> >> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/Makefile#L30
> >>
> > On Rockchip SoC CONFIG_DISPLAY_CPUINFO is been disable on most of the
> > configs files.
> >
> > -# CONFIG_DISPLAY_CPUINFO is not set
> >
> > My changes are related to determine the reset cause of the board and
> > display the results.
> > its only enable on selected SoC hence I have to used this logic.
> >
>
> It's enabled for all Aarch64/Aarch32 SoCs by default. People explicitly
> disabled them in their own defconfig, either because the first person
> who added a board based on rk3588 didn't know or didn't care and
> everybody just copied it as a base, or because they don't care about
> it/don't want it.
>
My series focuses on determining the reset cause of the boards
Do we need to enable this feature ?

We are not compiling DISPLAY_CPUINFO for all for RK3568 and RK3588
But with the following changes enable this to be built for SPL_BUILD ( patch v5)
in this series. wow it is built for all SoC.

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index c07bdaee4c..6722e7c9ea 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -25,7 +25,7 @@ obj-y += boot_mode.o
 obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
 endif

-ifeq ($(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
 endif

> In any case, you only need to change the defconfigs, nothing else.
>
> > U-Boot 2024.07-rc2-00397-g0370324feb-dirty (May 16 2024 - 13:11:14 +0530)
> >
> > SoC: Rockchip rk3568
> > Reset cause: POR         <-----------
> > Model: Radxa ROCK3 Model A
> > DRAM:  8 GiB (effective 7.7 GiB)
> > PMIC:  RK8090 (on=0x40, off=0x00)
> > Core:  344 devices, 31 uclasses,
> >  >> which also means...
> >>
> >> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/include/asm/arch-rockchip/cru.h#L35
> >> should probably be ifdef'ed
> >>
> >> which means...
> >>
> >> https://elixir.bootlin.com/u-boot/latest/source/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c#L64
> >> should probably also be ifdef'ed (but the config is enabled already
> >> (well... it wouldn't compile otherwsie), so I guess this is fine?).
> >
> > This code changes will not affect this feature by default its enable
> > on RK3399 boards.
> >
>
> Yes, but if you disable it, it won't compile anymore. (I'm not asking
> you to fix anything I've reported here though).
>
Ok I will check this.
> Cheers,
> Quentin
Thanks
-Anand
