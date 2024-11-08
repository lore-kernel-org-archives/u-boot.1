Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEA9D5E147
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 08:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36E558900E;
	Fri,  8 Nov 2024 09:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="Ybs0WPXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DB98904D; Fri,  8 Nov 2024 09:56:03 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4759B88F4A
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 09:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=jagan@edgeble.ai
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2cc469c62so1395819a91.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1731056156; x=1731660956;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bKf5O9De9cvimIV97eqImt+mohnT3n36D5IIfPyo93s=;
 b=Ybs0WPXqX6ltKGNz9IT0OVZmGqU2hPryBu2/9YOB/GeV4v1NI14Bg/7ZsTUpVuvapz
 mNjzH2wMKqu/gSbpEHy3yomcOJAddtVjOhRvcnTSlrVAzl2vNI1Agc904l9EHlU+t+py
 qmPuiYVcQHroGl2HbSbazrRzp1znP4sDgTcEKnoCqoPbkWOgMUNaqEgEfoC9RDrfFwQ7
 6gQ3gL4GxJKcpTI3XeuCzwDI12U7PqrgUUrQKib8twq/EVq4oUBjN/FDugtF4zM/g0jE
 zHt2osPWafU8X50BKhMg/ULjOGCd/wMlkyry4eqknwfJqgccg+Cjmo+7njyp9H0/FILa
 gZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731056156; x=1731660956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKf5O9De9cvimIV97eqImt+mohnT3n36D5IIfPyo93s=;
 b=TxlshoO/nIP7Hgop6lJ3t8OlpxecZrjhsBSIC1JXlmnQK0cakw28rQAiZpc8feEHgN
 J/LREFNQNsjaU+Ru5BVejWZhg0eNp/3MWIdle9rrkNAWvcoJkFtZY4TNdpFtAGtib1Uy
 txeP1vIzQjVZodAr/4p8iJoJ2J8yuZ+uWeTeOQNPe6yFC7lmdk+xM3ZO6MT4U0qosoe7
 /tXygUydDBt4cS7Tmv/Jiu3XjNdjlmmgOMH8PHAPneijTMSOCcHWtEe26RhclakRUVdn
 IJ6JQ+lhBqT2DafotcXlDJq6odtvnm0CLFFqHkZLZg6ObWnDEYKjajmImzpW9ev5buD1
 s4Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvhDAMhn3le/8oeTER0Np9WjFBL6Zgpo5ueLZ4VMHnq+rWorsCXaqRWkQYEGdAisOKZ7hPkAU=@lists.denx.de
X-Gm-Message-State: AOJu0YxtNSQLl3GDNBjIO6YAlh4Yx7IhifCu0QbhCuwo0LFWnupSjF8M
 BElLc24rVs5tU04z5oPx/+Jjwv6mZLEAvsKK0Fy41Puo4TL6KXpyHBddX7M0AuzUxMNv5Kbb/3I
 OIYMFr89BgpVADGv8KWJk+O9Addi+RV0tyR4TnA==
X-Google-Smtp-Source: AGHT+IH5BNxKBmkyZ3rIDNbFx7w+ByEk/Y6Iw4FNgLiuSJqk9c3Ia0dF92GW9pR+zSMZn1Zf5k0xADGgqj5TjVyYE4Y=
X-Received: by 2002:a17:90b:4b88:b0:2e2:c423:8e17 with SMTP id
 98e67ed59e1d1-2e9b16ea5bcmr2866503a91.7.1731056155694; Fri, 08 Nov 2024
 00:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20241102203746.3631481-1-jonas@kwiboo.se>
 <20241102203746.3631481-3-jonas@kwiboo.se>
 <f4f66f6c-3b96-4529-a90c-cd3a0b900a56@cherry.de>
 <cef9b291-5c27-454c-a24a-565d4510add5@kwiboo.se>
 <88812888-4583-44e1-a36f-13239b0aa4d6@rock-chips.com>
In-Reply-To: <88812888-4583-44e1-a36f-13239b0aa4d6@rock-chips.com>
From: Jagan Teki <jagan@edgeble.ai>
Date: Fri, 8 Nov 2024 14:25:44 +0530
Message-ID: <CA+VMnFxQXL3qgtQqqqhtRVeG-sj0Xgitr0VMBxNuN0qHcYFZJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, Dragan Simic <dsimic@manjaro.org>,
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

On Fri, 8 Nov 2024 at 09:10, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Jonas,
>
> On 2024/11/7 22:29, Jonas Karlman wrote:
> > Hi Quentin,
> >
> > On 2024-11-07 13:01, Quentin Schulz wrote:
> >> Hi Jonas,
> >>
> >> On 11/2/24 9:37 PM, Jonas Karlman wrote:
> >>> Implement checkboard() to print current SoC model used by a board,
> >>> e.g. one of:
> >>>
> >>>     SoC:   RK3582 v1
> >>>     SoC:   RK3588 v0
> >>>     SoC:   RK3588 v1
> >>>     SoC:   RK3588S v0
> >>>     SoC:   RK3588S v1
> >>>     SoC:   RK3588S2 v1
> >>>
> >>> when U-Boot proper is running.
> >>>
> >>>     U-Boot 2025.01-rc1 (Nov 02 2024 - 20:19:01 +0000)
> >>>
> >>>     Model: Generic RK3588S/RK3588
> >>>     SoC:   RK3588S2 v1
> >>>     DRAM:  8 GiB
> >>>
> >>> Information about the SoC model, variant and version is read from OTP.
> >>>
> >>> Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
> >>> where checkboard() is called.
> >>>
> >>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>> ---
> >>> v2:
> >>> - Update commit message
> >>> - Update code comments
> >>> - Drop generic-rk3588_defconfig change
> >>> ---
> >>>    arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
> >>>    arch/arm/mach-rockchip/rk3588/rk3588.c | 58 ++++++++++++++++++++++++++
> >>>    2 files changed, 62 insertions(+)
> >>>
> >>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> >>> index 09d8b311cec5..8880d162b11c 100644
> >>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> >>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> >>> @@ -69,6 +69,10 @@
> >>>     bootph-all;
> >>>    };
> >>>
> >>> +&otp {
> >>> +   bootph-some-ram;
> >>> +};
> >>> +
> >>>    &pcfg_pull_down {
> >>>     bootph-all;
> >>>    };
> >>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> >>> index e2dac2a5b806..f9da7a6f1477 100644
> >>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> >>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> >>> @@ -4,6 +4,8 @@
> >>>     * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
> >>>     */
> >>>
> >>> +#include <dm.h>
> >>> +#include <misc.h>
> >>>    #include <spl.h>
> >>>    #include <asm/armv8/mmu.h>
> >>>    #include <asm/arch-rockchip/bootrom.h>
> >>> @@ -178,3 +180,59 @@ int arch_cpu_init(void)
> >>>     return 0;
> >>>    }
> >>>    #endif
> >>> +
> >>> +#define RK3588_OTP_CPU_CODE_OFFSET         0x02
> >>> +#define RK3588_OTP_SPECIFICATION_OFFSET            0x06
> >>> +#define RK3588_OTP_CPU_VERSION_OFFSET              0x1c
> >>> +
> >>> +int checkboard(void)
> >>> +{
> >>> +   u8 cpu_code[2], specification, package, cpu_version;
> >>> +   struct udevice *dev;
> >>> +   char suffix[3];
> >>> +   int ret;
> >>> +
> >>> +   ret = uclass_get_device_by_driver(UCLASS_MISC,
> >>> +                                     DM_DRIVER_GET(rockchip_otp), &dev);
> >>> +   if (ret) {
> >>> +           debug("%s: could not find otp device, ret=%d\n", __func__, ret);
> >> We should probably start using log_debug instead?
> > I guess we should?, not sure why there is two different and what the
> > difference is. Have typically only ever used debug() or printf(), so I
> > just went with what was used in the code copied from board.c.
> >
> >> I guess with #define LOG_CATEGORY LOGC_ARCH
> >>
> >> at the top?
> > I can give it a try, what/how is the log category used for?
> >
> > My simple debug workflow is just to add a '#define LOG_DEBUG' at top of
> > a file when I want some more debug info.
> >
> >>> +           return 0;
> >>> +   }
> >>> +
> >>> +   /* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> >>> +   ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> >> This will fail if CONFIG_MISC=n which is neither selected nor implied
> >> for RK3588.
> > Good catch, did not test that scenario, will fix in a v3.
> >
> >> I tested on multiple RK3588 Jaguar, and the commercial (RK3588) grade
> >> ones all showed RK3588 v0.
> >>
> >> The one industrial grade (RK3588J) showed RK3588J v1.
> > Thanks for confirming this works on a J-variant.
> >
> >> I'm really not sure what this version number is for. If even Kever
> >> doesn't know what it means, I am not sure it makes sense to print it?
> > For rk356x there is some special handling for cpu-version <> 0 in vendor
> > code, and DT describe a cpu-version nvmem cell, so thought it could be
> > useful debug information. However it may just cause more confusion since
> > there is no clear information on what the different cpu-version mean.
> >
> > Will drop the cpu-version information in a v3.
>
> Yes, this cpu-version does not help users, I think it may be one of the
> silicon version(
>
> The process may change in foundry), package version(change in package
> factory),

Apart from package number chip versions like RK3588, RK3588J and
RK3588M would be much beneficial when we boot multi-dtb from SPL and
load the respective silicon dtb in u-boot proper. So, chip numbers,
temperature (if possible) are useful like imx chips supported so far.

Thanks,
Jagan.
