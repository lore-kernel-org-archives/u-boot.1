Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12E4C04FF8
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2457E87FF0;
	Thu, 18 Apr 2024 19:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="OyKyx2Xn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8798088688; Thu, 18 Apr 2024 19:53:48 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8008868B
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a555faf94fcso127957666b.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713462823; x=1714067623; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQwTqOmPd/85/YMa+hCIIUmTGvVLqk2cuV4wA/JTqtk=;
 b=OyKyx2XnaajtYyRGHUANkKyjsVktXsIxM0x5QEx1wrPucVXd3x+5hq+gO78nOhZC0j
 /BcF+XhbM8n0b0aSvmVe5Rrk8kEUD/tSPVzQ8gCjXcNMxrj9lIRHcrab9zlSqkQOIhqj
 wh2hbmr36q3d10FZfA/nPqOF7GzszOadtMVHNzalC1uSFjtqWUShtojIsvlM9+L6SQns
 0pMyiJgmYoqbtlgTxKR/9E+Kh3p23klNJz77k1Is1BaaKUSkCAp4z5BQ3szrn9RMYKV1
 Z0Lfprx+yTPkp8bbaOmQZvmzPNQ3hwNL5bLVMigxgtBVjiAygLZt2LiV2gQbQwcIbTcs
 8rwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713462823; x=1714067623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQwTqOmPd/85/YMa+hCIIUmTGvVLqk2cuV4wA/JTqtk=;
 b=s5wZx0bJ7NzWA/FQNI7IT6l2XZBTUspFU5G3o7DUDUqrswuTxxaDF8hp8Sezcwtloz
 h7qBUaQMGPnfLCEUrTE+IWNVn08bGwTcDRcNPICKW8EYySSEqiflTCIk7oMJ0D7FL4WK
 ZESq/7RQvLf36veYjMVeuH2FHWfBZHhX5OVWeVww5YaolaJWokpm9zyk8v8XjukvuFg4
 xiuuISCIusDKkTtqXZZxH/rHuhEi9tQeZIq8oGDHjH+tMoJo9WMdXYlLsNKi01EjaY/+
 YA8A4+q9+YcW7vgBeenAKyYavSeEsId9YG3M9vzrNiaVbRrHzRwAna7+NROwv8pjP5fj
 3Jfg==
X-Gm-Message-State: AOJu0YwYSFIyXkxu/01++2Z/cRQFBz1YxyQllWeWIz/dChan4a2hESsZ
 ujDIgQVBgJntqkABaWyaRfyottdiTHUb6yVPDVFkUTJDOiiJLuhLjM5F771L6/ez2bLhM1h/tCO
 eQZrryj1U0NgrnwpHX/6S8+JmQ90jaKg97XTZaQ==
X-Google-Smtp-Source: AGHT+IE+DkT6GE6aUXoQ8JvMwt1yA0VWObQmvlMvYi/KqP3cV++aDItGcblrbLYgwU9/7p87FKmGg6lDI9DyK/df3/k=
X-Received: by 2002:a17:906:658:b0:a55:617d:4f37 with SMTP id
 t24-20020a170906065800b00a55617d4f37mr2186520ejb.0.1713462823263; Thu, 18 Apr
 2024 10:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
In-Reply-To: <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 18 Apr 2024 10:53:31 -0700
Message-ID: <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
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

On Thu, Apr 18, 2024 at 10:33=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 4/18/24 6:21 PM, Tim Harvey wrote:
> > On Fri, Jan 19, 2024 at 4:36=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> Linux 6.6.y with KASLR enabled would print the following message on bo=
ot:
> >> "
> >> KASLR disabled due to lack of seed
> >> "
> >> Enable the 'kaslrseed' command so a random number seed can be pulled
> >> from CAAM and inserted into the /chosen node 'kaslr-seed' property of
> >> Linux kernel DT before boot, thus letting KASLR work properly.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> ---
> >> Cc: Fabio Estevam <festevam@denx.de>
> >> Cc: Stefano Babic <sbabic@denx.de>
> >> Cc: u-boot@dh-electronics.com
> >> ---
> >>   configs/imx8mp_dhcom_pdk2_defconfig | 2 ++
> >>   configs/imx8mp_dhcom_pdk3_defconfig | 2 ++
> >>   2 files changed, 4 insertions(+)
> >>
> >> diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhco=
m_pdk2_defconfig
> >> index 4f907ce00d0..23fb6272ad5 100644
> >> --- a/configs/imx8mp_dhcom_pdk2_defconfig
> >> +++ b/configs/imx8mp_dhcom_pdk2_defconfig
> >> @@ -117,6 +117,7 @@ CONFIG_CMD_BOOTCOUNT=3Dy
> >>   CONFIG_CMD_CACHE=3Dy
> >>   CONFIG_CMD_TIME=3Dy
> >>   CONFIG_CMD_GETTIME=3Dy
> >> +CONFIG_CMD_KASLRSEED=3Dy
> >>   CONFIG_CMD_SYSBOOT=3Dy
> >>   CONFIG_CMD_UUID=3Dy
> >>   CONFIG_CMD_PMIC=3Dy
> >> @@ -223,6 +224,7 @@ CONFIG_DM_REGULATOR_PCA9450=3Dy
> >>   CONFIG_SPL_DM_REGULATOR_PCA9450=3Dy
> >>   CONFIG_DM_REGULATOR_FIXED=3Dy
> >>   CONFIG_DM_REGULATOR_GPIO=3Dy
> >> +CONFIG_DM_RNG=3Dy
> >>   CONFIG_DM_RTC=3Dy
> >>   CONFIG_RTC_M41T62=3Dy
> >>   CONFIG_CONS_INDEX=3D2
> >> diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhco=
m_pdk3_defconfig
> >> index 9972e2d96b6..0d47c12b1f9 100644
> >> --- a/configs/imx8mp_dhcom_pdk3_defconfig
> >> +++ b/configs/imx8mp_dhcom_pdk3_defconfig
> >> @@ -119,6 +119,7 @@ CONFIG_CMD_BOOTCOUNT=3Dy
> >>   CONFIG_CMD_CACHE=3Dy
> >>   CONFIG_CMD_TIME=3Dy
> >>   CONFIG_CMD_GETTIME=3Dy
> >> +CONFIG_CMD_KASLRSEED=3Dy
> >>   CONFIG_CMD_SYSBOOT=3Dy
> >>   CONFIG_CMD_UUID=3Dy
> >>   CONFIG_CMD_PMIC=3Dy
> >> @@ -228,6 +229,7 @@ CONFIG_DM_REGULATOR_PCA9450=3Dy
> >>   CONFIG_SPL_DM_REGULATOR_PCA9450=3Dy
> >>   CONFIG_DM_REGULATOR_FIXED=3Dy
> >>   CONFIG_DM_REGULATOR_GPIO=3Dy
> >> +CONFIG_DM_RNG=3Dy
> >>   CONFIG_DM_RTC=3Dy
> >>   CONFIG_RTC_M41T62=3Dy
> >>   CONFIG_CONS_INDEX=3D2
> >> --
> >> 2.43.0
> >>
> >
> > Hi Marek,
> >
> > Sorry to respond to an old thread but I ran across this when enabling
> > KALSR on my boards.
> >
> > I have noticed when you enable DM_RNG on IMX8M that SPL fails to bind
> > the driver:
> > Couldn't bind rng driver (-96)
> > SEC0:  RNG instantiated
> >
> > sec_init failed!
>
> Did you enable CAAM and ARCH_MISC_INIT on your machine, to initialize
> CAAM in SPL ?

yes

>
> > Didn't you encounter this as well? It seems to me that we may need to
> > add the ability to disable DM_RNG in the SPL unless I'm missing
> > something.
>
> No, but see above, I suspect that might be it, see also
>
> 1f908b1898bd ("ARM: imx8m: Deduplicate CAAM init with arch_misc_init()
> call")

yes, I have that same patch with
c8645e74113c6 ("configs: imx8m: Prepare imx8m-venice boards for HAB support=
")

Do you have an IMX8M board on hand to check against to see if you see
the same error in the SPL?

Fabio, if you enable CONFIG_DM_RNG on an imx8m{m,p}_evk do you get the
following in the SPL?
Couldn't bind rng driver (-96)
SEC0:  RNG instantiated

sec_init failed!

Best Regards,

Tim
