Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAA4D74EED
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 15:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6250083B0B;
	Fri, 23 Jan 2026 16:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UyX5yioM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4D6883B0B; Fri, 23 Jan 2026 16:50:11 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DCB83B03
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 16:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-66103641d76so514734eaf.1
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769183404; x=1769788204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4y3bbK29pR+8VwU5oSx48ImOUWc0Ywls6e5bnq9C+SA=;
 b=UyX5yioMm5Rec06tYAyVfa2dLq7oRDBopVYYKyzGgi1KAG3cF8nw+Wo8S33j9/8Vye
 LQYfvSsafFI66CB3fyq4F1lIEyt6pC+jH0XBeWM6aq+hMguvuChACiXaMw3MM3xMlgMQ
 VGYn3ASHj0MHuxbfFI2qjRknXP8iJbM9ksUi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769183404; x=1769788204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4y3bbK29pR+8VwU5oSx48ImOUWc0Ywls6e5bnq9C+SA=;
 b=d1IXTNK/7T1Hitqj4/Xbm+R9qS7Gl5qMxz2QQpqxb38ulj9aLIPmbeunQ5NGn7SsLk
 DYgSKXJlrlVt0WQeUFDeIS0SJ597OyFJdsf+mIJ3kAy5AwW/iz39sj7lHW3ax+gJdp2v
 ENbSufDWOkp9II2pfijdzlxcip0dqPehRe23LfvVaFYsMrflXpoZDDs4MCwOgH3haGl/
 1OUX9rzJUL/aGR0LLR+sjgUnVBl3kQ+3kksD6TNYFgw2/63oPgF9zCm9CXMgQdhjLsfX
 Hd523a09NHt85heHxRFcrLgaAxiiNYAboVEiAj04qTm3w6m4K2vciCPouAxbRIwri/Mc
 bI+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuZfvt8ETkHzUH/dcovpLZEZy9wwCH/tyDECYpWza8QrT1bnwuiFNmunoxU0Qy4XxM0xDzzNI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8e1WWrYVqRSBuXrGTf7/ZorGjyNX0Wt1Pjwymz+EOtsngJYAC
 ti/OEiFSjuSq/4a9WVtHiZHyhLwmzZHfkkOx1wXgDs5Glr72Jw3lmYXmhpTVn4Ss72E=
X-Gm-Gg: AZuq6aJTjyhI+CvNQGRdS6Mnw8SuvuE9c3rRa3bcyzPMzI2uZDdRR/fARjoeYPQAHGf
 VZwPugIguxJ6gKkwhS8VVLLSLXDoBVX5BODrfwnfT/SLw06OR4M8bc27XplLGcEvHhARBybCBqm
 tsNe/FJGG1FCwMgO2jI8XtlSjSpZYIq/yschO2Skpc1hAxL0GH+p5LOSGd5ajGOA1RwdK++j2Uz
 RJ6nSAc1Mjm8/Tby2CKIWYPkBRGjSxmlNnJZqBAkumygbib6r9ILomDjC2OMqVSskSWzgxsxxsN
 RBp6dpolSkDHFvpETEErzalBUG2+oZE9ZNvTj5LCOMvZVst5UHNO8Glu7wrGQuM/jrctNYuLwPw
 v0ehJeGZQKkO2Mkfmlb3Sm1enTSLJXH/bik1tEmC5hd1/ZFbDmglegvl9Z2FMl2NQiouRRXqG2+
 zTJadjddnZzVPlrUmu/WkAkf4HJdkG5gUpWNvBT2a/Ut+EuEhZHdEb3ZyYr/TCZcVxkJFPstBK7
 CQus+C8rg93yp1qddwLVsPnZa1kuqbCaKhraiM=
X-Received: by 2002:a05:6820:490e:b0:65d:62d:b6be with SMTP id
 006d021491bc7-662caad73e8mr1373887eaf.7.1769183404276; 
 Fri, 23 Jan 2026 07:50:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408afc0386dsm1753194fac.16.2026.01.23.07.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:50:03 -0800 (PST)
Date: Fri, 23 Jan 2026 09:50:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260123155000.GM3416603@bill-the-cat>
References: <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122194239.GF3416603@bill-the-cat>
 <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
 <20260122232407.GG3416603@bill-the-cat>
 <CAOMZO5ADFCbzyv3whDo_w=hEwe9i1hhMZ-X+UEu8132pkFnqJg@mail.gmail.com>
 <CAOMZO5CLQZ3i+Eit5csv6E+az-_g2eOHfCr-whQTPeg06WtqEg@mail.gmail.com>
 <20260123142708.GH3416603@bill-the-cat>
 <CAOMZO5CoN-6UVuX8GsmfQHHPs1N=29t4khWOEaeJCN-RjyQynw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JLcp2NCMHtRzbQAR"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CoN-6UVuX8GsmfQHHPs1N=29t4khWOEaeJCN-RjyQynw@mail.gmail.com>
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


--JLcp2NCMHtRzbQAR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:45:01PM -0300, Fabio Estevam wrote:
> On Fri, Jan 23, 2026 at 11:27=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > So this:
> >
> > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> > index d780a5060774..dcc201c30482 100644
> > --- a/arch/arm/cpu/u-boot-spl.lds
> > +++ b/arch/arm/cpu/u-boot-spl.lds
> > @@ -50,8 +50,8 @@ SECTIONS
> >         .rel.dyn : {
> >                 __rel_dyn_start =3D .;
> >                 *(.rel*)
> > -               __rel_dyn_end =3D .;
> >                 . =3D ALIGN(8);
> > +               __rel_dyn_end =3D .;
> >         }
> >
> >         _image_binary_end =3D .;
> >
> > Will shift the dtb location lower and __rel_dyn_end 4 bytes higher.
> > Which is probably fine.
>=20
> This change fixes rv1126, but still fails on rv1103:
>=20
> sonoff-ihost-rv1126_defconfig:
>=20
> $ cat spl/u-boot-spl.map | grep __bss_end
>                 0x000000000000b468                __bss_end =3D .
>                 0x0000000000000050                __bss_size =3D
> (__bss_end - __bss_start)
>=20
> $ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
> 000016d0  af 98 00 00 15 15 00 00  d0 0d fe ed 4e 99 00 00  |............=
N...|
> 00001d20  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG..=
=2E...|
> 0000b460  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 0d 95  |............=
=2E...|
>=20
> dtb is correctly found at 0xb468.
>=20
> omega4-rv1103_defconfig:
>=20
> $ cat spl/u-boot-spl.map | grep __bss_end
>                 0x0000000000015f18                __bss_end =3D .
>                 0x0000000000000264                __bss_size =3D
> (__bss_end - __bss_start)
>=20
> $ hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
> 000029f0  d0 0d fe ed 00 29 05 db  8a 18 03 d2 43 6a 1b ba  |.....)......=
Cj..|
> 00015f10  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |............=
=2E...|
>=20
> dtb is not found at 0x15f18.

Keep looking then please, thanks.

--=20
Tom

--JLcp2NCMHtRzbQAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXOYpQAKCRAr4qD1Cr/k
Cq32AP9Ag5oxAUFcmISctNLCIv8Nk7d9xveQoayP+npkOJKeygD/QES8lOVnrsk7
mQiDJ3aQ3PVg1Pp1+oGuTHfe/KeD6gY=
=h/RW
-----END PGP SIGNATURE-----

--JLcp2NCMHtRzbQAR--
