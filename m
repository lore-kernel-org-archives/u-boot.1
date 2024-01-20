Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E7C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:51:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A2587D50;
	Sat, 20 Jan 2024 17:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oTS9IeaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A421787D74; Sat, 20 Jan 2024 17:50:59 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B9487D50
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dc22597dbfeso2047334276.3
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705769456; x=1706374256; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/lFlV2yJzODCl/MRNWHF/CFEugNdb0lpBVXDb0jWsQg=;
 b=oTS9IeaUzSqVtBEgD/8O8gPwQ1jGDX8visjga3iLHokSEKfbYyrgzOABI/GP/CRyS1
 9RJe6VwJz6GrpzmsMNf+SzC9RcoMcVp7FH6UqIhVy7IEhy569GYr6Br3bFiUPp5CpRXN
 dpj8xpq91HVSTtHUxaBqZ7qbIB0q00wn75mx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769456; x=1706374256;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lFlV2yJzODCl/MRNWHF/CFEugNdb0lpBVXDb0jWsQg=;
 b=Y89JVbngyFSweQ0HEqdPAgAc1LuyK8ev49oyt4GRdhFaS3+ud9xu7gjVgKLUSy8tEw
 zY6bJczBVCD/AOnMqS7YdHHV77XsMoSMlgp1jHoVr9pdufBFsvQ6upJqIq8RlsHsPAM9
 C8Tbgm0FFxiETNIIptepccq/d4o1iQiGgs0ToDdgQDhVeUQA4q9zoSw2yQYbwUduEkcp
 g6z1hByRx5aH5vLbvbg/fzHCqf5PMvJbpwwtftJstlraURZHVcMjLVnAdDsUhDm1NOsE
 ngKS2NSezm+zOVVynIB6/bnyE7C9x3ObWOKaYoW5LN4grwXlYT8fD7zFRL3gCskhPHVz
 XqNw==
X-Gm-Message-State: AOJu0Yy8TEIR7yakX5hfENCrt6XBuQ2DV0QO6qA//spAnmFNwuDv97K9
 uQhIU4nqdAtpQZFz0myLfgUYgoSoAOL1QmYdw5SSjwwNOqeDjQ7rlkrzBw10ssA=
X-Google-Smtp-Source: AGHT+IFbR75V4BBPOeQhZwoXxYU9lZi/Qf14vQc1pxX26vOYfIspzqxQO7kEkrRYS0etAA72ic8LLw==
X-Received: by 2002:a81:6d94:0:b0:5f6:eb69:5e1e with SMTP id
 i142-20020a816d94000000b005f6eb695e1emr1911308ywc.57.1705769456217; 
 Sat, 20 Jan 2024 08:50:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 q138-20020a819990000000b005ebde3cfc12sm8250756ywg.17.2024.01.20.08.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:50:55 -0800 (PST)
Date: Sat, 20 Jan 2024 11:50:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, robertcnelson@gmail.com, marex@denx.de,
 n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Message-ID: <20240120165052.GB3652023@bill-the-cat>
References: <20240112124951.238098-1-rogerq@kernel.org>
 <20240112124951.238098-5-rogerq@kernel.org>
 <20240112130233.bflterluncjoyrhy@treadmill>
 <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
 <20240112131450.tpn454pfzlqlteed@urology>
 <20240112132131.GN1610741@bill-the-cat>
 <1f4ceaf6-0387-4010-bbcd-0f6970428e8c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MSH/ojGpQAlfvXHa"
Content-Disposition: inline
In-Reply-To: <1f4ceaf6-0387-4010-bbcd-0f6970428e8c@kernel.org>
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


--MSH/ojGpQAlfvXHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 01:40:00PM +0200, Roger Quadros wrote:
>=20
>=20
> On 12/01/2024 15:21, Tom Rini wrote:
> > On Fri, Jan 12, 2024 at 07:14:50AM -0600, Nishanth Menon wrote:
> >> On 15:06-20240112, Roger Quadros wrote:
> >>>
> >>>
> >>> On 12/01/2024 15:02, Nishanth Menon wrote:
> >>>> On 14:49-20240112, Roger Quadros wrote:
> >>>>> Without correct SERDES MUX and Lane control settings
> >>>>> USB0 will be broken. Set the MUX and Lane control devices
> >>>>> to be auto probed so they are configured correctly.
> >>>>>
> >>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >>>>> ---
> >>>>>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arc=
h/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >>>>> index f83caf7998..017a5a722e 100644
> >>>>> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >>>>> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> >>>>> @@ -165,6 +165,7 @@
> >>>>> =20
> >>>>>  &serdes_ln_ctrl {
> >>>>>  	bootph-all;
> >>>>> +	u-boot,mux-autoprobe;
> >>>>>  };
> >>>>> =20
> >>>>>  &serdes2_usb_link {
> >>>>> @@ -173,6 +174,7 @@
> >>>>> =20
> >>>>>  &usb_serdes_mux {
> >>>>>  	bootph-all;
> >>>>> +	u-boot,mux-autoprobe;
> >>>>>  };
> >>>>> =20
> >>>>>  &serdes_wiz2 {
> >=20
> > OK, so both of these are compatible =3D "mmio-mux", is the problem they
> > aren't probed in time or something else?
> >=20
>=20
> That's correct. They aren't probed ever. But that is because there are no
> explicit consumers for them. Since this is a platform wide configuration,
> we have been relying on the "idle-states" property and that they are auto=
-probed.

OK.  Could we borrow the "wrap" logic that drivers/led/led_gpio.c for
example does to get the probe to happen inside drivers/mux/mmio.c
instead? I feel like there might have been assumptions about grander
needs back when the framework for muxers was done that has not panned
out since.

--=20
Tom

--MSH/ojGpQAlfvXHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWr+ewACgkQFHw5/5Y0
tyzqHAv/aCbhd+UwcTxyCwjmYFdkvqzRiaN0rfwQrj7yxni8iWpdXiyECG5md6sS
IwQzxmnc/F9V4368mQDTgrbRs9PJ5REpAI+0KPLNc4ZwXP3g3PY3QHHDoqurRIRy
ybcPJm3yz6BvU9OVRuocVRM7lxwjdlTtA6YYwH6cgxh0oEn8WZOhkOdxgaWaI+JJ
MBcY5IUrb3hRr0OjHnFfTwZNo8AGMH9H/Rzeqr9xuo+zjSpfWtEDXIt5BWryTfBF
keNeUehqGB+JLP5pcpOyIgea/OURw/E2o6Q56jXIwBYzb5T9ua6wMRkhyhM1dzG2
yMQz156i7n+D06iP9VQJJzFtX7PqHuUex4B4yNSAcFu3m7jFJrkQEO+3uRCUpn4Y
UVqzRLEZjrcGP68B1ZwTcxSbcG4GNeLIwx3IJbp9u5vHi6s6FJm0Bh7jFX7I2bkw
G5TIdOgAYo9SNWOvuxg4WAE6YnAh5Xl6LgasthPkJ8727Ep/5zro5jGOCXm5aSnd
PF/vX1TT
=bHwe
-----END PGP SIGNATURE-----

--MSH/ojGpQAlfvXHa--
