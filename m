Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D8DC47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 16:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB62B877EC;
	Mon, 22 Jan 2024 17:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LT7YiE3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 171FE877CC; Mon, 22 Jan 2024 17:00:42 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E544D878AD
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 17:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5ff821b9acfso28582037b3.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 08:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705939237; x=1706544037; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8BcViwHapx9WQoqaKiD55ebdS7/IYQAd6uBRUjs+QEg=;
 b=LT7YiE3Wxr1Xm0ei0Avb383u90StNhzYwHcg0rfxfA8Pc3pE/IhOZ6/dUFau6lvFwc
 rMQx0nXLP7GtzklKuncRoOn9qlii1/999FNK2wclv7O96QMbhXFrLvTvpcLc3Vmqw9pG
 CP1mvD0NHWDJObAT+veu6gXkfUcbRTu1rSxKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939237; x=1706544037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BcViwHapx9WQoqaKiD55ebdS7/IYQAd6uBRUjs+QEg=;
 b=ARzqZNULvxfHxJtFI8J2aLxR7Lu9OeQYxoeKslTjyo61/hP8f9u0Lz6T94GetPnv4E
 ETmJ8YA3axnOJFh9PjopX/goO2+G/7SSr8HPHOUm9avUzTm+ig6fcJUD18JpaIZYNCff
 RRlsRX485wMiekBF/1Q8oJYBAYei5Qr6055bk11dm+xdvSzqQj1zMTy8IRZq5zLdqmjz
 Cmto6DRsHKO1/8tFj6pp6odCkijSdzCcyrEWEoZ4hoHENWRmKX+Ix7yHpyNZbJ2Y1ck8
 ep/SQzNbjdEXnIIkgkJr+1J45CHnWP+Qv7nnOAVMk7e8PBiSZZA6dvcOupsGyIjQ2wVX
 mnJQ==
X-Gm-Message-State: AOJu0YyOov+o5hJ1oFZiN42pN8qsfj5hrmCO8Qm2Xfbbt3FlIAS8eMD5
 iX+C6OBQZkhWB51Te73HmKkErQbelWuoH272NQ6VhBm5d074+ns+MxZunzNoRVs=
X-Google-Smtp-Source: AGHT+IGnZt9WDRsUngBlAi9qsZX8wCcGx/cHSkUR3mcNA/63rD32vfRgYQ8GL2AMo7IUCeSpMzM2SQ==
X-Received: by 2002:a81:6c05:0:b0:5ff:a8da:5a5a with SMTP id
 h5-20020a816c05000000b005ffa8da5a5amr3218642ywc.5.1705939237316; 
 Mon, 22 Jan 2024 08:00:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 t15-20020a0dea0f000000b005ffce9cee9fsm1234943ywe.12.2024.01.22.08.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:00:36 -0800 (PST)
Date: Mon, 22 Jan 2024 11:00:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, robertcnelson@gmail.com, marex@denx.de,
 n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Message-ID: <20240122160034.GL3652023@bill-the-cat>
References: <20240112124951.238098-1-rogerq@kernel.org>
 <20240112124951.238098-5-rogerq@kernel.org>
 <20240112130233.bflterluncjoyrhy@treadmill>
 <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
 <20240112131450.tpn454pfzlqlteed@urology>
 <20240112132131.GN1610741@bill-the-cat>
 <1f4ceaf6-0387-4010-bbcd-0f6970428e8c@kernel.org>
 <20240120165052.GB3652023@bill-the-cat>
 <a9214eef-c398-434b-88c5-6de41df508bc@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LpINhZKfDcUWDBLg"
Content-Disposition: inline
In-Reply-To: <a9214eef-c398-434b-88c5-6de41df508bc@kernel.org>
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


--LpINhZKfDcUWDBLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 01:39:06PM +0200, Roger Quadros wrote:
>=20
>=20
> On 20/01/2024 18:50, Tom Rini wrote:
> > On Mon, Jan 15, 2024 at 01:40:00PM +0200, Roger Quadros wrote:
> >>
> >>
> >> On 12/01/2024 15:21, Tom Rini wrote:
> >>> On Fri, Jan 12, 2024 at 07:14:50AM -0600, Nishanth Menon wrote:
> >>>> On 15:06-20240112, Roger Quadros wrote:
> >>>>>
> >>>>>
> >>>>> On 12/01/2024 15:02, Nishanth Menon wrote:
> >>>>>> On 14:49-20240112, Roger Quadros wrote:
> >>>>>>> Without correct SERDES MUX and Lane control settings
> >>>>>>> USB0 will be broken. Set the MUX and Lane control devices
> >>>>>>> to be auto probed so they are configured correctly.
> >>>>>>>
> >>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >>>>>>> ---
> >>>>>>>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
> >>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/a=
rch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >>>>>>> index f83caf7998..017a5a722e 100644
> >>>>>>> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >>>>>>> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >>>>>>> @@ -165,6 +165,7 @@
> >>>>>>> =20
> >>>>>>>  &serdes_ln_ctrl {
> >>>>>>>  	bootph-all;
> >>>>>>> +	u-boot,mux-autoprobe;
> >>>>>>>  };
> >>>>>>> =20
> >>>>>>>  &serdes2_usb_link {
> >>>>>>> @@ -173,6 +174,7 @@
> >>>>>>> =20
> >>>>>>>  &usb_serdes_mux {
> >>>>>>>  	bootph-all;
> >>>>>>> +	u-boot,mux-autoprobe;
> >>>>>>>  };
> >>>>>>> =20
> >>>>>>>  &serdes_wiz2 {
> >>>
> >>> OK, so both of these are compatible =3D "mmio-mux", is the problem th=
ey
> >>> aren't probed in time or something else?
> >>>
> >>
> >> That's correct. They aren't probed ever. But that is because there are=
 no
> >> explicit consumers for them. Since this is a platform wide configurati=
on,
> >> we have been relying on the "idle-states" property and that they are a=
uto-probed.
> >=20
> > OK.  Could we borrow the "wrap" logic that drivers/led/led_gpio.c for
> > example does to get the probe to happen inside drivers/mux/mmio.c
> > instead? I feel like there might have been assumptions about grander
> > needs back when the framework for muxers was done that has not panned
> > out since.
> >=20
>=20
> We only need the MUX driver to probe if the MUX node contains the "idle-s=
tates"
> property.
>=20
> So maybe the MUX UCLASS code should be checking for that instead of/along=
 with
> the custom u-boot,mux-autoprobe property?
>=20
> How does this look?
>=20
> diff --git a/drivers/mux/mux-uclass.c b/drivers/mux/mux-uclass.c
> index c98576ceb8..8833888ded 100644
> --- a/drivers/mux/mux-uclass.c
> +++ b/drivers/mux/mux-uclass.c
> @@ -318,7 +318,8 @@ int dm_mux_init(void)
>  		return ret;
>  	}
>  	uclass_foreach_dev(dev, uc) {
> -		if (dev_read_bool(dev, "u-boot,mux-autoprobe")) {
> +		if (dev_read_bool(dev, "u-boot,mux-autoprobe") ||
> +		    dev_read_bool(dev, "idle-states")) {
>  			ret =3D device_probe(dev);
>  			if (ret)
>  				log_debug("unable to probe device %s\n",

I would just drop "u-boot,mux-autoprobe" as TI platforms are the only
users of this uclass and mmio driver, iirc.

--=20
Tom

--LpINhZKfDcUWDBLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWukRsACgkQFHw5/5Y0
tyyFlgv/e02QXcfmeC8vAmclMnhAO36BzKLbNBjHHfkvdse3xdrP9n8iKvs0+EAe
bUFLlbG36dHz+Hk8Ocye9fKuP6aVVuxey4zKhnX/F6pU0dGBs4GUhPsVfMjkLsIN
4B3puy429GIKAANsFYMXpR2NZVmG9/QIdqCJDy1evTXtPYB15bc+uqyevQXYLnfa
ki8CcUX2/zwhfF+CPiUNKZhXjBVUk+9Z+hgovzQcw3MEfImIcF6gqO9MRrJlKYaH
ijZohq0A1E+jdH/UG3TVIA4lIDAAMMgknUYr8voESO5RARrlsOPIx/0MhedBLvZJ
LcPH5bBS+qBg44N6r2b62aVIOPpymL+u0TXVuzamJE8gWSXosRLfZqG864v0DL5p
XIe8hi2E4baoLCvaP4WPC9WtXXIhPEXsmJ3FUwudBRgoMNSziOWUEiEKsX60Ps/G
lNZusUYpfGM8in4R0aN7XYQsqhtnmd5iYtdaNRTfHiKW2mI1MgoxOl7ANKzs2iSL
i9w4X/XD
=isrC
-----END PGP SIGNATURE-----

--LpINhZKfDcUWDBLg--
