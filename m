Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300E0C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4337F87501;
	Sun, 12 Nov 2023 21:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YgLEqXni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7CB1874F2; Sun, 12 Nov 2023 21:04:01 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A140187500
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7eef0b931so43669307b3.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819434; x=1700424234; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AHcyfSX2heOUtYgXyNoK4YvoXRIuxYuO/ZXiI1j0jE=;
 b=YgLEqXniAMTHXRy2oZaYZXI9weyEBeiu7Chjsm2coc+9NGocAGi6E8UqeXPX/Zuhhm
 zdxO3NlxxWeavaYBL8GGCuJ5x1EwGPYWJ2ZzHg9b/8m7K8kV0oqv9/Or8ymr+jW8CNWk
 RlTR9bc9aHHuAGxNC/d8LYTtVWVbDoqTGqzNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819434; x=1700424234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AHcyfSX2heOUtYgXyNoK4YvoXRIuxYuO/ZXiI1j0jE=;
 b=QO8nUCSoLuXZAdrNufLSE4hufxFmeel+elbgZl8rN/9//7UdVyfV22lVYjSCE6r2xX
 zQ4cJ0C0Sd4/CwBQlMPszQ2/vaOkciI/uuNv7SbdANTRnVv9d7JA1hxALIAbzAA8kx97
 oRUFgVt3OXvo/KDy1rbKrB4xEwwJnU95YAZTfIvqorxdpX6lzKwjhjGwDSN96puQO/DF
 6zac6i9bO+okav6BfIQIKHWG3azqCYO5JcVIApiyr4wgff5AUTw8hbjSBD4KEjbzclhs
 SjIe4ZMKUVf+pVBMjJEA6H6SMc14HahhMUkGJZB449mikjszHB9D2JAWgmyyxEpvYNF4
 Kz7g==
X-Gm-Message-State: AOJu0YzUE2PZlEL20/urD/Nvm75Ti+gM1xv3T8DNCLQBEbrJl99tdbMR
 /gOs+VaE3ouh0Y7q5BzZRDWQyWaUyClc4nm2EDgvgw==
X-Google-Smtp-Source: AGHT+IGHUXwk0qPjZ6rZ5vef+PZT8cESQpYOy97MbM04WeO5MfKqS5pLafLFNnqTPM0qqEOIlgj4yCKI7TDs8SI18mc=
X-Received: by 2002:a0d:cd46:0:b0:5a7:aece:7e59 with SMTP id
 p67-20020a0dcd46000000b005a7aece7e59mr4863194ywd.50.1699819434125; Sun, 12
 Nov 2023 12:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231111001329.537704-1-i@shantur.com>
 <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
 <CABEcMwVD_Hs5aMJZaF_Ym785yrLsw6KBxnB_E4KCD=nJASR6YQ@mail.gmail.com>
 <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
 <CAPnjgZ18x+j11doAJtEg93ueL+ayC2HqtRm+BeG9XSNkWx-9Hw@mail.gmail.com>
 <8f25cd25-e090-46b4-8088-0103cf79862b@kwiboo.se>
In-Reply-To: <8f25cd25-e090-46b4-8088-0103cf79862b@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:06 -0700
Message-ID: <CAPnjgZ20XV53T1zS8cW-BYaeSvu28N46V0Q6nrf-ysJOZ0nKyQ@mail.gmail.com>
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Shantur Rathore <i@shantur.com>, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jonas,

On Sun, 12 Nov 2023 at 07:53, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2023-11-12 15:22, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Sun, 12 Nov 2023 at 05:50, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Shantur,
> >>
> >> On 2023-11-12 13:34, Shantur Rathore wrote:
> >>> Hi Jonas,
> >>>
> >>>> The CMD_SPI is not used to interact with the SPI flash.
> >>>>
> >>>> CMD_SF is already enabled and you can use "sf probe" and any other s=
f
> >>>> related action to interact with the SPI flash on this board.
> >>>>
> >>>
> >>> You are right, this is not needed, thanks for correcting me.
> >>> I will update my patch.
> >>>
> >>>> What is the reasoning behind enabling full bootstd commands? Especia=
lly
> >>>> why just this board need it enabled by default.
> >>>>
> >>>> Standard boot is already fully functional, it just does not have ful=
l
> >>>> features commands enabled by default.
> >>>
> >>> By default standard boot only allows you to boot from the first
> >>> available boot device.
> >>> This board supports SDCard, NVME (via PCIe port), USB and network boo=
t
> >>> and with BOOTSTD_FULL we can choose what to exactly boot.
> >>> The boot_targets environment variable only allows you to choose which
> >>> device to boot, not which boot method / flow to use.
> >>> We have ample space in SPI Flash, so why not let it have the full
> >>> potential of U-Boot by default.
> >>
> >> You can control boot targets using the boot_targets env var and boot
> >> methods using the bootmeths env var.
> >>
> >> https://docs.u-boot.org/en/latest/develop/bootstd.html#controlling-ord=
ering
> >>
> >> For normal generic use the full bootstd commands should not be needed,
> >> do you have special scripting requirements that require access to full
> >> bootstd commands?
> >>
> >> All rockchip boards use standard boot, this only enables full commands
> >> for one particular board, why is this board special? Or is there merit
> >> to imply enable of full commands for all rockchip boards?
> >
> > I suppose we do this in a lot of cases, where we enable commands and
> > other features on various boards. So I don't have any objection to
> > this. Certainly it is a pain to use bootstd for development and
> > debugging of booting if you cannot use the full command set.
>
> I have no particular objection either, I just want to understand the
> need, and if this is something we should apply to more boards.
>
> For RK35xx family of devices I have tried to ensure all boards have
> similar commands and features enabled, at least for the features the
> board support. So my thought now is if we should imply this Kconfig
> option for ROCKCHIP_RK3568 and ROCKCHIP_RK3588.

Yes, I understand...I happen to use rockpro64 for things so often find
myself enabling various options. I enabled bootstage a while back to
help with boot timing.

>
> Use of different features is also rather annoying for a distro that
> wants to support a broad range of devices of a soc family, and U-Boot
> for boards of the same soc family behave differently.

Indeed. We need the basics supported on all boards and distros need to
be careful not to use commands that are not widely enabled.

Regards,
Simon


>
> Regards,
> Jonas
>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Regards,
> > Simon
> >
> >>
> >> Regards,
> >> Jonas
> >>
> >>>
> >>> Kind regards,
> >>> Shantur
> >>>
> >>> On Sun, Nov 12, 2023 at 10:39=E2=80=AFAM Jonas Karlman <jonas@kwiboo.=
se> wrote:
> >>>>
> >>>> On 2023-11-11 01:13, Shantur Rathore wrote:
> >>>>> RockPro64 has a 16MB onboard SPI chip and current u-boot takes
> >>>>> around 2MB, we can enable more features.
> >>>>> Updating config to enable SPI commands and full BootSTD support.
> >>>>> ---
> >>>>>  configs/rockpro64-rk3399_defconfig | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64=
-rk3399_defconfig
> >>>>> index 4cd6b76665..cad0b8a5d7 100644
> >>>>> --- a/configs/rockpro64-rk3399_defconfig
> >>>>> +++ b/configs/rockpro64-rk3399_defconfig
> >>>>> @@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=3Dy
> >>>>>  CONFIG_CMD_GPT=3Dy
> >>>>>  CONFIG_CMD_MMC=3Dy
> >>>>>  CONFIG_CMD_PCI=3Dy
> >>>>> +CONFIG_CMD_SPI=3Dy
> >>>>
> >>>> The CMD_SPI is not used to interact with the SPI flash.
> >>>>
> >>>> CMD_SF is already enabled and you can use "sf probe" and any other s=
f
> >>>> related action to interact with the SPI flash on this board.
> >>>>
> >>>>>  CONFIG_CMD_USB=3Dy
> >>>>>  # CONFIG_CMD_SETEXPR is not set
> >>>>>  CONFIG_CMD_TIME=3Dy
> >>>>>  CONFIG_CMD_BOOTSTAGE=3Dy
> >>>>> +CONFIG_BOOTSTD_FULL=3Dy
> >>>>
> >>>> What is the reasoning behind enabling full bootstd commands? Especia=
lly
> >>>> why just this board need it enabled by default.
> >>>>
> >>>> Standard boot is already fully functional, it just does not have ful=
l
> >>>> features commands enabled by default.
> >>>>
> >>>> Regards,
> >>>> Jonas
> >>>>
> >>>>>  CONFIG_SPL_OF_CONTROL=3Dy
> >>>>>  CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-names =
interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parent=
s"
> >>>>>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> >>>>
> >>
>
