Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A83C41535
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C07587807;
	Wed, 13 Dec 2023 20:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IXS2iJ0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501138781B; Wed, 13 Dec 2023 20:51:25 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55D487804
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db5e5647c24so7053439276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497081; x=1703101881; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyELNDL2I7aC+ysDLf9vUEcLHgWiBGKO9pgnEzSZfLM=;
 b=IXS2iJ0LtlsZtZrTUWz7hRLf17dMhj11by0aex5LzpBJlt6YZAG/p/EQg9epLmfNhS
 K5nBCrnzOKwiriGOQlNsdWdiwnArDlTmuD4FOP4NLPewsDt6z9wpySiK75b0Yl0Vlx9H
 rl9aEpAyKVTgPC2mARw8SGQXzTAMfekAliOtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497081; x=1703101881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyELNDL2I7aC+ysDLf9vUEcLHgWiBGKO9pgnEzSZfLM=;
 b=JA4Mo65ueZyf4+sGNrEHuqJHkHMsGQsbkSKbaoSU5sujF1hely6n9drXQ7D4oDo+Ic
 bOB+JdWRQOXFWJeUnHw6YZtaa9+0C600OmTNcDUeSvGHEkrCzoYB+JKKBXRrxDpskSQx
 WNMpoLslfI/6qJ7lb4Ut+/u3Ol5nG7Qu9cGdAJzoD5HYR6Ag8jhUvT11TZcY72IKJxde
 bF5bObWEboyZbogSIA9o/TzjTIwQmmxc4W6+cNZjWfP1B/sU8bfFH2I9ZneP18+EBowm
 usHxSF/00437sYbcd5Vdv04/ecPdMGGvi7J2nW7xOVSibME163w80s83LNj3XoEcRdp0
 jcMw==
X-Gm-Message-State: AOJu0YyfPMCmmhWdYy4gf8R6V6Hjz6bL255ENPJHniO9TnNvyPwuvlsV
 kTM3t3kRmzBs59KYPIz0YyH41bzOpAmmQ/oMEyADbuY3AvKIfxTayc8=
X-Google-Smtp-Source: AGHT+IFhNnY4kUFeA1bV+u35CSEIuuOVaFxvYfXvozk14FGnnDqZKHvlXt5EZSYMfHOlYc7iQgh48XV4oopFLyHVIVw=
X-Received: by 2002:a05:6902:1370:b0:dbc:ce28:9e5b with SMTP id
 bt16-20020a056902137000b00dbcce289e5bmr1394091ybb.0.1702497081290; Wed, 13
 Dec 2023 11:51:21 -0800 (PST)
MIME-Version: 1.0
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
 <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
 <20231211205326.GX2513409@bill-the-cat>
In-Reply-To: <20231211205326.GX2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:06 -0700
Message-ID: <CAPnjgZ23x6dAwq8UDvTXBikRgC3mbTfH5PV=KVF45pFPXY3cQA@mail.gmail.com>
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
To: Tom Rini <trini@konsulko.com>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, jagan@amarulasolutions.com
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

Hi Tom,

On Mon, 11 Dec 2023 at 13:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 11, 2023 at 08:42:19PM +0000, Shantur Rathore wrote:
> > Hi,
> >
> > On Mon, Nov 13, 2023 at 11:24=E2=80=AFAM Shantur Rathore <i@shantur.com=
> wrote:
> > >
> > > Add smbios information for Pine64 RockPro64 board and enable in
> > > config
> > >
> > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > ---
> > >  Changes
> > >  v4: Change PINE64 to Pine64
> > >  v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
> > >
> > >  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 +++++++++++++++++++++=
+
> > >  configs/rockpro64-rk3399_defconfig        |  2 ++
> > >  2 files changed, 24 insertions(+)
> > >
> > > diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts=
/rk3399-rockpro64-u-boot.dtsi
> > > index 732727d9b0..089732524a 100644
> > > --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > @@ -9,6 +9,28 @@
> > >         chosen {
> > >                 u-boot,spl-boot-order =3D "same-as-spl", &spi_flash, =
&sdmmc, &sdhci;
> > >         };
> > > +
> > > +        smbios {
> > > +                compatible =3D "u-boot,sysinfo-smbios";
> > > +                smbios {
> > > +                        system {
> > > +                                manufacturer =3D "Pine64";
> > > +                                product =3D "RockPro64";
> > > +                        };
> > > +
> > > +                        baseboard {
> > > +                                manufacturer =3D "Pine64";
> > > +                                product =3D "RockPro64";
> > > +                        };
> > > +
> > > +                        chassis {
> > > +                                manufacturer =3D "Pine64";
> > > +                                product =3D "RockPro64";
> > > +                        };
> > > +                };
> > > +        };
> > > +
> > > +
> > >  };
> > >
> > >  &sdhci {
> > > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-r=
k3399_defconfig
> > > index 4cd6b76665..affb6137e0 100644
> > > --- a/configs/rockpro64-rk3399_defconfig
> > > +++ b/configs/rockpro64-rk3399_defconfig
> > > @@ -90,6 +90,8 @@ CONFIG_BAUDRATE=3D1500000
> > >  CONFIG_DEBUG_UART_SHIFT=3D2
> > >  CONFIG_SYS_NS16550_MEM32=3Dy
> > >  CONFIG_ROCKCHIP_SPI=3Dy
> > > +CONFIG_SYSINFO=3Dy
> > > +CONFIG_SYSINFO_SMBIOS=3Dy
> > >  CONFIG_SYSRESET=3Dy
> > >  CONFIG_USB=3Dy
> > >  CONFIG_USB_XHCI_HCD=3Dy
> > > --
> > > 2.40.1
> > >
> >
> > Can this please be merged if no changes are required?
> >
> > [0] - https://patchwork.ozlabs.org/project/uboot/patch/20231113112309.7=
30323-1-i@shantur.com/
>
> Yes, we should just defer this and pickup the SMBIOS series that Ilias
> has posted.

I don't think it is a suitable substitute, it is just a fallback.

So I believe this patch should be applied.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
