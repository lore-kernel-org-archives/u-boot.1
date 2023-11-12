Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B28EC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 14:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4E08710C;
	Sun, 12 Nov 2023 15:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="SyDdfnzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C90A8706F; Sun, 12 Nov 2023 15:22:01 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22A886F68
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-49e15724283so1469257e0c.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699798915; x=1700403715;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9c9SkltQ7QEI5GgQsgSuZMtu4/O53FdfiOcMyVThxWE=;
 b=SyDdfnzc3KBbWoE95ay2AViS6OQUQ1YvKgi5ZmK8jJZW0z7v5wJgCZkob7Ow7eYt6I
 xjJnuCEK/OmrR6SGBGZ7jyhI3rmjCDnkTUnXQ0NhwUfoji7hYFZ0UVFySumXaIcsxK5f
 aToDCI4ckuS1+Y/BBM//fKvJzdEuL0GEagLJP9c10kZIvMJLFfLAq5PnDYAffngTyHXn
 Qx3pAdDK+E6BIuNZBjec1mw6Q6WpYnn0dSPIyHE8HxBOI0Y+sKnXwCnoX6RO/j/j9eKc
 75fOmj9rOfx4kBGXKbycausUu10B3xzC2pTFQgZTpUnzHrWUjHb+K9iEAmJc0BTpXLYv
 FCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699798915; x=1700403715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9c9SkltQ7QEI5GgQsgSuZMtu4/O53FdfiOcMyVThxWE=;
 b=LTl9tuOAoXhk76dhLsPJAMzH4wtaoxZpcRmyYo9iUwiXMFeHoKSl0Ssk1wycCJEN/f
 wB/EyFnPRH0fzKI/Nzw+l6xfBNNXliT9K7XLyGuzp2f+EVLP2+UTQLwJhE7TYKnqmTF6
 6jJEcR8LOlB9puPTUL7dug03sdeZnTeeg+gtR0QDToyVDzXSNb9zF1LwDALroMxPFB07
 wl/3fF41kr1WDh2UQAn6oDhN71NcyjoFrT0NtJF7HjO587sY12jHN5ImNRu+jksvap6a
 STwP8AKBX+4xSlKZpVgm3jdLihNkdIl9+VEz+73jl4fJ8pc10XwWxTTtTqrKJumO19wZ
 dsNg==
X-Gm-Message-State: AOJu0Yz3iD2Ry6R1uM6m/1+MCI9lzpvGg/3P2fSWH38UlKyoQ+IBsoJB
 2AskQUFCZu2J60qH0Mo9/txaUH39pOhP/mtzLVw6Lg==
X-Google-Smtp-Source: AGHT+IEEH2uir6ajwnhysWDVdDyPj5wWYitUNg2RIWwErxEUVxHACwlB647Gu5YfJMasMu2EhYqxvxcaXfP+YZo5//M=
X-Received: by 2002:a05:6122:4594:b0:49a:6dc0:5a89 with SMTP id
 de20-20020a056122459400b0049a6dc05a89mr4566409vkb.5.1699798914921; Sun, 12
 Nov 2023 06:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20231111001329.537704-1-i@shantur.com>
 <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
 <CABEcMwVD_Hs5aMJZaF_Ym785yrLsw6KBxnB_E4KCD=nJASR6YQ@mail.gmail.com>
 <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
In-Reply-To: <e1fec775-6806-4fe2-af44-f930ebb62932@kwiboo.se>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 12 Nov 2023 14:21:44 +0000
Message-ID: <CABEcMwVgnRYd3bSRTY3sUsa=igTsQroEMxCtVjO8ApidigMHHQ@mail.gmail.com>
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
To: Jonas Karlman <jonas@kwiboo.se>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 u-boot@lists.denx.de
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

Hey Jonas,

> For normal generic use the full bootstd commands should not be needed,
> do you have special scripting requirements that require access to full
> bootstd commands?
>
> All rockchip boards use standard boot, this only enables full commands
> for one particular board, why is this board special? Or

This board isn't special.

>is there merit
> to imply enable of full commands for all rockchip boards?

Maybe not only on rockchip boards but all boards.

Do we need full commands in general ? - Maybe not

Then why did you need to enable full commands ?
Bootstd works when the distro used is supporting it. In my case when I
installed the distro (Armbian), EFI was installed to
/boot/efi/EFI/debian by default instead of /boot/efi/EFI/boot as
expected by Bootstd.
Bootstd couldn't find the EFI and failed to boot. In this scenario
there is no way to figure out what's going on, what bootmethods /
bootflows is bootstd able to find or try to manually boot some.
To be able to support the smallest bit of debugging you end up
building U-Boot from scratch to enable bootstd full for bootstd info
commands.
All other commands in U-boot by default come with options to display
more information ( for ex. nvme info, nvme detail, usb tree, usb info,
usb dev, fatinfo and many more ) then why is bootstd restricted?
Thus, in my opinion we should enable BOOTSTD_FULL for users to be able
to see more information.
Restricting might be beneficial for end user devices but atleast
development devices like RockPro64 should come with BOOTSTD_FULL by
default.

Kind regards,
Shantur

On Sun, Nov 12, 2023 at 12:50=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
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
