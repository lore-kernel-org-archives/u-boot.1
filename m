Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D44DC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 20:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ACB68777C;
	Mon, 11 Dec 2023 21:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LE7yE0QU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77C587790; Mon, 11 Dec 2023 21:53:33 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4167C86308
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 21:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d8ddcc433fso36886637b3.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702328009; x=1702932809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yiRV0Dr48LmhuA4nS3iIYMx7eKymxr0hBJqMIZMgyYs=;
 b=LE7yE0QUSOTEe1rjxNM5enw5sugI/9tlq/mqeSyI/ptZAT5iaxUA+348QsAjQMLTez
 qlsoLHbqspv1XI3ozh21UnnbqrwLJ8gmAhoCuvZFbs8NjEPMNogjAkg9i8SfGjQQrK4B
 ggosPuKPXYxgVPkhXgs3WLuwyY1P6ObY++kdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702328009; x=1702932809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiRV0Dr48LmhuA4nS3iIYMx7eKymxr0hBJqMIZMgyYs=;
 b=rJG2YgFsvIEMV+cbCnutErRtlr42MKgYgkVotJM5TYaTW3V7DgWehli1Lmx14KJP5m
 mlqss3HcSaSQknHv0hviGdLLJID/+81m9AKIdhQvrmy34kmLuhH2ZBOniUREAHrbkUxu
 6ErFs/EHuuZ4Bce7rN87g/troxu5i/laJKMKbI4HJrIQxSOYE4GGx6eGIkyZwLPKfePf
 k5iabTmf4f+Cn+o/xL1ocIS7/L4RbLYFC2DcTxmpDAlSIwyL65fuoXnY1gS+kXXKl+ci
 s2+pTzIkUoeHMQnKXOE4hK8LcYDFNBa9gZUHvDn+cFi7HTh3BENn3UqF007xRqdqHDNk
 qkWg==
X-Gm-Message-State: AOJu0YzZY7REcHpMrk3Q8QTEGHp5RLo2t8KTBCnNd0pt2EU8PD8mEkFQ
 yXBHXXEGxrxV2mZY0jiv+w7eQg==
X-Google-Smtp-Source: AGHT+IGbDcIasCstNFt/6XtT8jgW2QmCy2KsMD6YHk1/X+CBlOHKCLo33HMH/JkNiX1Dz5cFgy4Ifw==
X-Received: by 2002:a0d:e901:0:b0:5d7:1940:8ddc with SMTP id
 s1-20020a0de901000000b005d719408ddcmr2322705ywe.67.1702328008896; 
 Mon, 11 Dec 2023 12:53:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fa42-ae3b-3aac-d543.res6.spectrum.com.
 [2603:6081:7b00:6400:fa42:ae3b:3aac:d543])
 by smtp.gmail.com with ESMTPSA id
 j124-20020a819282000000b005d3500ea9fasm3267419ywg.10.2023.12.11.12.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 12:53:28 -0800 (PST)
Date: Mon, 11 Dec 2023 15:53:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jagan@amarulasolutions.com
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
Message-ID: <20231211205326.GX2513409@bill-the-cat>
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
 <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l04RieoeQfWjukUc"
Content-Disposition: inline
In-Reply-To: <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--l04RieoeQfWjukUc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 08:42:19PM +0000, Shantur Rathore wrote:
> Hi,
>=20
> On Mon, Nov 13, 2023 at 11:24=E2=80=AFAM Shantur Rathore <i@shantur.com> =
wrote:
> >
> > Add smbios information for Pine64 RockPro64 board and enable in
> > config
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >  Changes
> >  v4: Change PINE64 to Pine64
> >  v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
> >
> >  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 ++++++++++++++++++++++
> >  configs/rockpro64-rk3399_defconfig        |  2 ++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/r=
k3399-rockpro64-u-boot.dtsi
> > index 732727d9b0..089732524a 100644
> > --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > @@ -9,6 +9,28 @@
> >         chosen {
> >                 u-boot,spl-boot-order =3D "same-as-spl", &spi_flash, &s=
dmmc, &sdhci;
> >         };
> > +
> > +        smbios {
> > +                compatible =3D "u-boot,sysinfo-smbios";
> > +                smbios {
> > +                        system {
> > +                                manufacturer =3D "Pine64";
> > +                                product =3D "RockPro64";
> > +                        };
> > +
> > +                        baseboard {
> > +                                manufacturer =3D "Pine64";
> > +                                product =3D "RockPro64";
> > +                        };
> > +
> > +                        chassis {
> > +                                manufacturer =3D "Pine64";
> > +                                product =3D "RockPro64";
> > +                        };
> > +                };
> > +        };
> > +
> > +
> >  };
> >
> >  &sdhci {
> > diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3=
399_defconfig
> > index 4cd6b76665..affb6137e0 100644
> > --- a/configs/rockpro64-rk3399_defconfig
> > +++ b/configs/rockpro64-rk3399_defconfig
> > @@ -90,6 +90,8 @@ CONFIG_BAUDRATE=3D1500000
> >  CONFIG_DEBUG_UART_SHIFT=3D2
> >  CONFIG_SYS_NS16550_MEM32=3Dy
> >  CONFIG_ROCKCHIP_SPI=3Dy
> > +CONFIG_SYSINFO=3Dy
> > +CONFIG_SYSINFO_SMBIOS=3Dy
> >  CONFIG_SYSRESET=3Dy
> >  CONFIG_USB=3Dy
> >  CONFIG_USB_XHCI_HCD=3Dy
> > --
> > 2.40.1
> >
>=20
> Can this please be merged if no changes are required?
>=20
> [0] - https://patchwork.ozlabs.org/project/uboot/patch/20231113112309.730=
323-1-i@shantur.com/

Yes, we should just defer this and pickup the SMBIOS series that Ilias
has posted.

--=20
Tom

--l04RieoeQfWjukUc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV3dsMACgkQFHw5/5Y0
tyyHGgv/fY9w90u9tXn1cmIzJsK0gZ75dd1OiDltDEcHIjvuP7PJX8A8TbDPiYzA
MC4511AAH3gzN3v/Xmk7Bfj57CPnaWKGNsCz8CiF5/ZBeQaFKvwA+ZnxxrODQpZK
hhmdL8PDF121r7jEbM1gf9WKrVjDYAycEhn+CAdSLiULO+iuusXC92jh4FYzY4S+
l6pntRPBW7kt1OG13UHfEfCKkBQ9gwmdwYUSAoNol/6IVTQo4E0HGZnCgHtL0W9t
hf/Ta7BdV9YjzBhKiEoa2b7fU1WOa43hzLHeA8oQqUopIuWggqpHm07aDIamP1HY
dOkbZzzF9tG9kJG38x/vhs0SRSGv5jN8ctkwNu8i3jsEa88OUzKgh33ih9m/XtAA
MquA9ghqWeti5rPUhmnA+WOniCaCpcCvPwbjLek0IyFvoYvckJZ2ORSeuAOozJas
2PJ/yiJPs4PTcqzODDLz7Gp+DW2tduZVcY7XYeqmxeAOYZAQhnX+/zKjrhuuUkLc
g6WUcXOG
=zGzc
-----END PGP SIGNATURE-----

--l04RieoeQfWjukUc--
