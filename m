Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEA0C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 12:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDFA87097;
	Sun, 12 Nov 2023 13:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="1KpZyz99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB13870A5; Sun, 12 Nov 2023 13:34:15 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F20548708C
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 13:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4ac05ca3935so1635330e0c.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699792451; x=1700397251;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTVfTnRdKitM40nycnLCkrC/b4ut+6fsSBt1pKAdutQ=;
 b=1KpZyz99kyH/dSQA913K76qRyrv4Wcn0Bw91yY+JZV7SILclYQOJXII1ZcTyREPyN4
 V7zNzb4bVpK4s/T3ZN/HwZtFdLhASAUWd+rtK0q8xWJDVR0F6SOocjE2TCe6xRZyTH28
 la+moVnjW1TD4nxTMwP64FQXf5HsxvkQc3K9/9F6Yh+eLpIdah1HqKRXD+TUyYocy00V
 qf/wjIHskT09ODKnH65Oe2R8GQih+masVVFyVPBK0mUV61TRGMLEpvlHfubvmuKcRlBO
 yEZF8bLclCVlsnxUeqvCytTaUXUWCCYgh9+GmBtNaoNAlbF/33FKgtCb6TDMeZO263XN
 fVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699792451; x=1700397251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTVfTnRdKitM40nycnLCkrC/b4ut+6fsSBt1pKAdutQ=;
 b=SQ5AB0d3m8LE1fsTMTPK2R+Ix8z7v9ipx7lJfxsnKLIKE34YNpCCZmtcn7DkLlyBcR
 ZdqfVY5cwFzUp3oOIKUHZdkiGK4o0x3vkpIUrjo9Ei2URCXXsSEl+Zs2j0se5pvQ/RZc
 ofD1mRrQc6ivVq+EE3wE1juHNfNh8Hg6FuR1oZlMX3l/xe7Be5xpAvbI06/nJBdzYzDG
 jlk07tz8cKi63v9aQSFatMK9wpjpZCNrK08/TVltBWlMq0VNX9st7Yb97B4EgKEyN6pl
 4EiW85ChDX3M7YToI28R/EsT1oxKmV5Q6W03pji/VTqfAQuI+fk30Dxa8/VtUyw32oLo
 d5lw==
X-Gm-Message-State: AOJu0YzTWpc+D7Cp+ZvlQX5+otfQWgLXJGV/BT/av2PeusPMOvNiJgf6
 3pwLwC/MuipDOZIuQvmh3o5hyiMO14klLdtdKh2N3A==
X-Google-Smtp-Source: AGHT+IHiY50sjbVpm4+JpTuMtIbzlZhNY31rqLzkLUity5L6+yVIgyXfOhTrsYHWtxSj8ZvY/Ml/i824igaFx8hsAgo=
X-Received: by 2002:a05:6122:5b6:b0:4ab:e352:19d8 with SMTP id
 w22-20020a05612205b600b004abe35219d8mr3284287vko.3.1699792451536; Sun, 12 Nov
 2023 04:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20231111001329.537704-1-i@shantur.com>
 <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
In-Reply-To: <d1e624f3-d761-4822-bcb4-f81ab4d78663@kwiboo.se>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 12 Nov 2023 12:34:00 +0000
Message-ID: <CABEcMwVD_Hs5aMJZaF_Ym785yrLsw6KBxnB_E4KCD=nJASR6YQ@mail.gmail.com>
Subject: Re: [PATCH] configs: rockpro64: Enable SPI command and full BOOTSTD
To: jonas@kwiboo.se
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

Hi Jonas,

> The CMD_SPI is not used to interact with the SPI flash.
>
> CMD_SF is already enabled and you can use "sf probe" and any other sf
> related action to interact with the SPI flash on this board.
>

You are right, this is not needed, thanks for correcting me.
I will update my patch.

> What is the reasoning behind enabling full bootstd commands? Especially
> why just this board need it enabled by default.
>
> Standard boot is already fully functional, it just does not have full
> features commands enabled by default.

By default standard boot only allows you to boot from the first
available boot device.
This board supports SDCard, NVME (via PCIe port), USB and network boot
and with BOOTSTD_FULL we can choose what to exactly boot.
The boot_targets environment variable only allows you to choose which
device to boot, not which boot method / flow to use.
We have ample space in SPI Flash, so why not let it have the full
potential of U-Boot by default.

Kind regards,
Shantur

On Sun, Nov 12, 2023 at 10:39=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> On 2023-11-11 01:13, Shantur Rathore wrote:
> > RockPro64 has a 16MB onboard SPI chip and current u-boot takes
> > around 2MB, we can enable more features.
> > Updating config to enable SPI commands and full BootSTD support.
> > ---
> >  configs/rockpro64-rk3399_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3=
399_defconfig
> > index 4cd6b76665..cad0b8a5d7 100644
> > --- a/configs/rockpro64-rk3399_defconfig
> > +++ b/configs/rockpro64-rk3399_defconfig
> > @@ -46,10 +46,12 @@ CONFIG_CMD_BOOTZ=3Dy
> >  CONFIG_CMD_GPT=3Dy
> >  CONFIG_CMD_MMC=3Dy
> >  CONFIG_CMD_PCI=3Dy
> > +CONFIG_CMD_SPI=3Dy
>
> The CMD_SPI is not used to interact with the SPI flash.
>
> CMD_SF is already enabled and you can use "sf probe" and any other sf
> related action to interact with the SPI flash on this board.
>
> >  CONFIG_CMD_USB=3Dy
> >  # CONFIG_CMD_SETEXPR is not set
> >  CONFIG_CMD_TIME=3Dy
> >  CONFIG_CMD_BOOTSTAGE=3Dy
> > +CONFIG_BOOTSTD_FULL=3Dy
>
> What is the reasoning behind enabling full bootstd commands? Especially
> why just this board need it enabled by default.
>
> Standard boot is already fully functional, it just does not have full
> features commands enabled by default.
>
> Regards,
> Jonas
>
> >  CONFIG_SPL_OF_CONTROL=3Dy
> >  CONFIG_OF_SPL_REMOVE_PROPS=3D"pinctrl-0 pinctrl-names clock-names inte=
rrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> >  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>
