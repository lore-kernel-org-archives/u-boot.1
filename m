Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B94C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 10:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E853788193;
	Thu, 16 May 2024 12:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="apoZc8df";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802348825A; Thu, 16 May 2024 12:13:04 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F21880DB
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-23d621abfb7so209046fac.1
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715854380; x=1716459180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c21U4cNFAc/TKqMOIgqlR1vpVtukKwKEiswOtukqbcA=;
 b=apoZc8dfcpmvWzqRxKMeTjfCBQNkup7suXtiToTKiTA9I1N/xI0IKfp3jJ2oCCei0f
 RMqryhWoClAmwIhxN9RkA4CxLT1jkADkObGIeR9QRth5yKjzR+81dg8SekYAhF5n03+9
 l7Om57HHEIQOE4ev10pCm9oPfcB5sFtxW7NfTqcU7e5syBXCpBDbxRQt+v8iPiPabh+/
 ovbmL8Xxdm/46rQpGjioQGILcgXO1UwvunuTovrTpSScbR2fceT4rYt9+Hwh8x1IRA1j
 z8HmOzktd6HyDtgyU5zG3pMKKTo6PaOr0Itm3E8NXWIDAGvq47Ez6MeGy3tWRPc2Wf6d
 47MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715854380; x=1716459180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c21U4cNFAc/TKqMOIgqlR1vpVtukKwKEiswOtukqbcA=;
 b=khxk2QuFV0EEo+T4oTBVD++LCvmoOh4BSga2LIDeorCEH54JsjIQnyhkOOKqqw9r3l
 0Cz0aF2PJtn7dHAB+VHwB47udb1O2RGcWQvQX0elHzyMiAm9dtGoA78Y1azPN1fXMy58
 TvVfiH+T0nZDGFFVXSwxHKOMBb+d4Fh1UxRQKAoQsV8+91pTAWNduogJzR71zhbYPaSu
 OpCtJH/dCGGxHfNVKZIFW0eKMEPdx9JksoRKvTDjqi9ki0npnNBmri15C9dqux23JyU3
 QegZgSH7FzfTBkdDxAWr4P5J+dtm+Hy5rIZMHR9aR8BT7XpLb/ZmDjt/kpqTeqRJJUPB
 fQ4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD2gClnUVQVKakIEeNCA8T0aLskTl8dFOGMxKWeh1YtFqWid5XA03givg0cV27EUK2/+CtOyhxfil9bOPuzDPXxPZSaQ==
X-Gm-Message-State: AOJu0YyCdpaOVjlqS1f1bppOwyahqwstNDleHy9L8+m3En0P4ULha+gS
 AAnnYbHUAPQeBc7MWRukHq5H0CnQEFsTVvF+8D84twr6+RKvTVMXMNa4+MoMTvhARHnqlgP5Xi3
 aC+Cio5DHXl+MSM1UQv4PkPFR0GA=
X-Google-Smtp-Source: AGHT+IHHvoPU/3c/jFfFvAH8g/H7RzNxhnu5SbtuVIH7HlByCs9oJLkCy6GcAootDGI21K9Ib2/RQK2+2RAJw3AQoWA=
X-Received: by 2002:a05:6871:a913:b0:23d:b3b9:de0 with SMTP id
 586e51a60fabf-2417198c4e9mr8701992fac.10.1715854380540; Thu, 16 May 2024
 03:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-10-anand@edgeble.ai>
 <1c5c0be5-eb49-4af9-be29-e4ab95e9f8be@cherry.de>
In-Reply-To: <1c5c0be5-eb49-4af9-be29-e4ab95e9f8be@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 16 May 2024 15:42:44 +0530
Message-ID: <CANAwSgS3Fd91FqQkfKHxVBYJ8-2LSdY4z4Tmx31UY7Bhd9K37g@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] rockchip: RK3588: Enable display cpuinfo support
 on all boards
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Andy Yan <andyshrk@163.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, John Clark <inindev@gmail.com>, 
 Jagan Teki <jagan@edgeble.ai>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>, 
 Joshua Riek <jjriek@verizon.net>, u-boot@lists.denx.de
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

On Thu, 16 May 2024 at 14:52, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> This is patch 9/9 but somehow I didn't receive any other patch, nor did
> the mailing list? c.f.
> https://lists.denx.de/pipermail/u-boot/2024-May/thread.html and
> https://lore.kernel.org/u-boot/. Are you registered on the ML?
>

Thanks for your  review comments.

Something went wrong with git sendmail,
Your message have not reached my email client (gmail)

> On 5/16/24 10:59 AM, Anand Moon wrote:
> > Imply DISPLAY_CPUINFO Kconfig options to support on all RK3588s and
> > RK3588 boards, Its used to determine the reset cause of the board.
> >
> > Cc: Jagan Teki <jagan@edgeble.ai>
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > ---
> >   arch/arm/mach-rockchip/Kconfig           | 1 +
> >   configs/coolpi-4b-rk3588s_defconfig      | 1 -
> >   configs/coolpi-cm5-evb-rk3588_defconfig  | 1 -
> >   configs/evb-rk3588_defconfig             | 1 -
> >   configs/generic-rk3588_defconfig         | 1 -
> >   configs/jaguar-rk3588_defconfig          | 1 -
> >   configs/nanopc-t6-rk3588_defconfig       | 1 -
> >   configs/neu6a-io-rk3588_defconfig        | 1 -
> >   configs/neu6b-io-rk3588_defconfig        | 1 -
> >   configs/orangepi-5-plus-rk3588_defconfig | 1 -
> >   configs/orangepi-5-rk3588s_defconfig     | 1 -
> >   configs/quartzpro64-rk3588_defconfig     | 1 -
> >   configs/rock5a-rk3588s_defconfig         | 1 -
> >   configs/rock5b-rk3588_defconfig          | 1 -
> >   configs/toybrick-rk3588_defconfig        | 1 -
> >   configs/turing-rk1-rk3588_defconfig      | 1 -
> >   16 files changed, 1 insertion(+), 15 deletions(-)
> >
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > index 2e9c71138e..1b5cc34f99 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -366,6 +366,7 @@ config ROCKCHIP_RK3588
> >       imply SCMI_FIRMWARE
> >       imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
> >       imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> > +     imply DISPLAY_CPUINFO
>
> This is unnecessary, it's already defaulting to y if building for ARM
> boards: https://elixir.bootlin.com/u-boot/latest/source/common/Kconfig#L596
>
See below...
> I also don't think this is SO useful that we need to enable it on all
> rk3588 boards? But also, doesn't hurt, so... whatever I guess :) ?
>
> While looking at the code, I think we can remove the ifdef in
> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/cpu-info.c#L47
> because this file is anyway only compiled when CONFIG_DISPLAY_CPUINFO is
> set, c.f.

Oops I missed this changes, my bad
I will dop my changes over here.

> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/mach-rockchip/Makefile#L30
>
On Rockchip SoC CONFIG_DISPLAY_CPUINFO is been disable on most of the
configs files.

-# CONFIG_DISPLAY_CPUINFO is not set

My changes are related to determine the reset cause of the board and
display the results.
its only enable on selected SoC hence I have to used this logic.

U-Boot 2024.07-rc2-00397-g0370324feb-dirty (May 16 2024 - 13:11:14 +0530)

SoC: Rockchip rk3568
Reset cause: POR         <-----------
Model: Radxa ROCK3 Model A
DRAM:  8 GiB (effective 7.7 GiB)
PMIC:  RK8090 (on=0x40, off=0x00)
Core:  344 devices, 31 uclasses,

> which also means...
>
> https://elixir.bootlin.com/u-boot/latest/source/arch/arm/include/asm/arch-rockchip/cru.h#L35
> should probably be ifdef'ed
>
> which means...
>
> https://elixir.bootlin.com/u-boot/latest/source/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c#L64
> should probably also be ifdef'ed (but the config is enabled already
> (well... it wouldn't compile otherwsie), so I guess this is fine?).

This code changes will not affect this feature by default its enable
on RK3399 boards.

>
> Cheers,
> Quentin

Thanks

-Anand
