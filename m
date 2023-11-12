Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3B2C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 14:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4E386EC9;
	Sun, 12 Nov 2023 15:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PukvziaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A009787103; Sun, 12 Nov 2023 15:22:45 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 557BD86C39
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so5592031a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699798962; x=1700403762; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qj95Ff3/pzhfDTO61PXckU3cEp7bBY4rizbF2yPnNCE=;
 b=PukvziaShKc4XtpKc1YUQe2n/roxc1/KEMtlkizxY9DTz4cvdEqFz4nAc5u4X/UjYV
 dXBm2oHbw48sXRajflny1k3Iks4vhRhQlKLEFsX829nL/AAbYmgpYshWg3X4m16BPwxI
 8cVUWvpq84ijaolmbLzMyqZL3i3n2k8mj3G1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699798962; x=1700403762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qj95Ff3/pzhfDTO61PXckU3cEp7bBY4rizbF2yPnNCE=;
 b=IQesaXnODX6PznS+hCAxlKzLUbbXTZZKLwAxz5v6BDlTfOfL7VyGgWl8DNssiyTxCq
 MIneOpKEd9K2rWlZ9RTArh4QpJpKb2z+96P9qLq8u6Gd0qpHhrzQMdlcYfdsO4JdGX18
 lCPtIjeaf2h1Yfoegx99LK+5ANj0pByAL1dN0L+Z7WHuG71mwPHdiaza86Su5fFe6YFx
 JKPNMMDQRK9xYO59220U6q/FdMMx7giBOBO69PjE/QFRwMkuIOT9zr4z7SNrNBPMdz3w
 ZHb43oBnd3pmV8+lPsMUPDrjIKOF930VBc/uclyO7LazvjeWJqgFCksUgyvMTiMYxWvd
 NuaQ==
X-Gm-Message-State: AOJu0YwERveeRbwOUgKZJJrPelZ+XjlfLhpC2EcC0nPFuX2MAHDs5s9s
 3AkB27otqnd+hMex5VAne8Qht1BxkpMVb6KT+EP2R2yAqIppr1EyEh4WjQ==
X-Google-Smtp-Source: AGHT+IE+/a8ZKSBRC7lMumxECw4tgW+qAr/6b33mZZ/Xexos4JfrN52W7jjmhJ9jNKt1wuUFwFLss29HpV62ezfgyb4=
X-Received: by 2002:a17:906:4147:b0:9e6:59d5:71c4 with SMTP id
 l7-20020a170906414700b009e659d571c4mr2938745ejk.16.1699798961558; Sun, 12 Nov
 2023 06:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20231111001329.537704-1-i@shantur.com>
 <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
 <CABEcMwVD_Hs5aMJZaF_Ym785yrLsw6KBxnB_E4KCD=nJASR6YQ@mail.gmail.com>
 <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
In-Reply-To: <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 07:22:24 -0700
Message-ID: <CAPnjgZ18x+j11doAJtEg93ueL+ayC2HqtRm+BeG9XSNkWx-9Hw@mail.gmail.com>
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

On Sun, 12 Nov 2023 at 05:50, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Shantur,
>
> On 2023-11-12 13:34, Shantur Rathore wrote:
> > Hi Jonas,
> >
> >> The CMD_SPI is not used to interact with the SPI flash.
> >>
> >> CMD_SF is already enabled and you can use "sf probe" and any other sf
> >> related action to interact with the SPI flash on this board.
> >>
> >
> > You are right, this is not needed, thanks for correcting me.
> > I will update my patch.
> >
> >> What is the reasoning behind enabling full bootstd commands? Especiall=
y
> >> why just this board need it enabled by default.
> >>
> >> Standard boot is already fully functional, it just does not have full
> >> features commands enabled by default.
> >
> > By default standard boot only allows you to boot from the first
> > available boot device.
> > This board supports SDCard, NVME (via PCIe port), USB and network boot
> > and with BOOTSTD_FULL we can choose what to exactly boot.
> > The boot_targets environment variable only allows you to choose which
> > device to boot, not which boot method / flow to use.
> > We have ample space in SPI Flash, so why not let it have the full
> > potential of U-Boot by default.
>
> You can control boot targets using the boot_targets env var and boot
> methods using the bootmeths env var.
>
> https://docs.u-boot.org/en/latest/develop/bootstd.html#controlling-orderi=
ng
>
> For normal generic use the full bootstd commands should not be needed,
> do you have special scripting requirements that require access to full
> bootstd commands?
>
> All rockchip boards use standard boot, this only enables full commands
> for one particular board, why is this board special? Or is there merit
> to imply enable of full commands for all rockchip boards?

I suppose we do this in a lot of cases, where we enable commands and
other features on various boards. So I don't have any objection to
this. Certainly it is a pain to use bootstd for development and
debugging of booting if you cannot use the full command set.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

>
> Regards,
> Jonas
>
> >
> > Kind regards,
> > Shantur
> >
> > On Sun, Nov 12, 2023 at 10:39=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se=
> wrote:
> >>
> >> On 2023-11-11 01:13, Shantur Rathore wrote:
> >>> RockPro64 has a 16MB onboard SPI chip and current u-boot takes
> >>> around 2MB, we can enable more features.
> >>> Updating config to enable SPI commands and full BootSTD support.
> >>> ---
> >>>  configs/rockpro64-rk3399_defconfig | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-r=
k3399_defconfig
> >>> index 4cd6b76665..cad0b8a5d7 100644
> >>> --- a/configs/rockpro64-rk3399_defconfig
> >>> +++ b/configs/rockpro64-rk3399_defconfig
> >>> @@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=3Dy
> >>>  CONFIG_CMD_GPT=3Dy
> >>>  CONFIG_CMD_MMC=3Dy
> >>>  CONFIG_CMD_PCI=3Dy
> >>> +CONFIG_CMD_SPI=3Dy
> >>
> >> The CMD_SPI is not used to interact with the SPI flash.
> >>
> >> CMD_SF is already enabled and you can use "sf probe" and any other sf
> >> related action to interact with the SPI flash on this board.
> >>
> >>>  CONFIG_CMD_USB=3Dy
> >>>  # CONFIG_CMD_SETEXPR is not set
> >>>  CONFIG_CMD_TIME=3Dy
> >>>  CONFIG_CMD_BOOTSTAGE=3Dy
> >>> +CONFIG_BOOTSTD_FULL=3Dy
> >>
> >> What is the reasoning behind enabling full bootstd commands? Especiall=
y
> >> why just this board need it enabled by default.
> >>
> >> Standard boot is already fully functional, it just does not have full
> >> features commands enabled by default.
> >>
> >> Regards,
> >> Jonas
> >>
> >>>  CONFIG_SPL_OF_CONTROL=3Dy
> >>>  CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-names in=
terrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> >>>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> >>
>
