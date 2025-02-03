Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F60FC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD032800B3;
	Mon,  3 Feb 2025 21:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n2L8vXAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB78800D7; Mon,  3 Feb 2025 21:47:59 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167DA80087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6ed0de64aso421324385a.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738615675; x=1739220475; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=05Wjbd3bEQ8RyiInwVo/MUadyQd2yIoWoNsl1D/7bZ0=;
 b=n2L8vXAZ0svl1MMNzMo4rB78AaBwnZod63Oaj0UbJjvfiwAcUwWugxRHyEl3jtsAjN
 2R15D3M+NVMJCXLlnRNI0BNZi1FICv91xmr+bJrSSRbLUBZvjd6l/GDt6lq9CNZcoJmu
 wZ71KM3BeuykT+3/7Kj11clmc/lpcKV4u7B+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738615675; x=1739220475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05Wjbd3bEQ8RyiInwVo/MUadyQd2yIoWoNsl1D/7bZ0=;
 b=kO7hx1vc/dql1n6lgTWH5szmTEAy3Ygqm6vffgKWngQWLEYQ3N7No1SPPYzsKxluCk
 kGONTR+JpysWp5JotkTWrsK0T4WziH6wqnOBIuXDc/F7ZudydjqPFdpx+5Td04rj4mxl
 pafMLLtN/KVcalY0ACnHMsVvaHDn/Pg/usSU4XB50gEwwyVPAdiR4BVq2j64/q6nvppT
 ShZRuLllqFfXn2ejI49aTpLgegiEflxCAOma1VviP2TJJ8aQpj0nGfKpR09iuy5KbnhT
 J6jTp4NFCbjzd49m9tIl6NrOe0DWuvfdVXWBVR60QltFTP39aHtiBi3PDrKEg/b3RVXr
 MKEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX10XsN+frJE4U99Q7Gq7y3jedtcFEpotBtLoqr845MGsM3oYw9Qo/UIbNgw2/Q0GP2+RaN4NI=@lists.denx.de
X-Gm-Message-State: AOJu0YyEEaLjCswYPiYLDeiJLJrBXS8XPUOnd8FoLtduaGNGj12DZfZL
 93AOSWxypna42v73AW8XDvEuiKdOzg2s2zeptCX+e+cbsocNwqmVqCAIHB4GKu4=
X-Gm-Gg: ASbGncv6IpPz/GfRB2PZwm1J4E8bl9pH4ZDAB41YRIIh4ykp6oKaVDd9xsN7lkrGbEE
 jzIL0pOJkRNToW1E17XCi+Mp2gwxVByvJiRSdMZA05egCH58EqPviMZx2oZnCfqjhjM7P9p27RM
 Tx9Cot4NqZefc6bTo/3JNiuNzk1aU85do2CYVQw2iDfBU6ayfjgUaDKYRG1cECiPMpWkMwyjAs2
 WrJK1s6PRky7i30j4bIdZX3iwnBHchZnNW9swMqqZSTYBXtrDKVybjU2wSw/5g45SveoDj3e1aQ
 2QU6WxyNFkf+VBs=
X-Google-Smtp-Source: AGHT+IGR+rgpD/qjefB/FXZTn4AyKNYRoyN/PuoSPdtpwC6BIbXz3lG8z35DcvhKce4e0x8RRsTU8A==
X-Received: by 2002:a05:620a:248d:b0:7b6:cb3c:cb81 with SMTP id
 af79cd13be357-7c02eccf33bmr111458285a.18.1738615674856; 
 Mon, 03 Feb 2025 12:47:54 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0c83dbsm51675231cf.30.2025.02.03.12.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:47:54 -0800 (PST)
Date: Mon, 3 Feb 2025 14:47:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Neha Malcom Francis <n-francis@ti.com>,
 Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH RFC v2 2/8] arm: dts: k3-j784s4-binman.dtsi: Clean up and
 templatize boot binaries
Message-ID: <20250203204750.GW1233568@bill-the-cat>
References: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
 <20250106-b4-upstream-j742s2-v2-2-42d6129ce333@ti.com>
 <e815500f-e4a0-4deb-ae33-f98ca7021503@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ECritcsuwuD5t3PK"
Content-Disposition: inline
In-Reply-To: <e815500f-e4a0-4deb-ae33-f98ca7021503@ti.com>
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


--ECritcsuwuD5t3PK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 02:44:57PM -0600, Andrew Davis wrote:
> On 1/6/25 3:34 AM, Manorit Chawdhry wrote:
> > From: Neha Malcom Francis <n-francis@ti.com>
> >=20
> > Clean up templatized boot binaries for j784s4 soc. This includes
> > modifying the k3-j784s4-binman.dtsi to use SPL_BOARD_DTB,
> > BOARD_DESCRIPTION and UBOOT_BOARD_DESCRIPTION from the files that
> > include it to further reuse code.
> >=20
> > k3-j784s4-binman.dtsi will contain only templates. Only required boot
> > binaries can be built from the templates in the boards' respective
> > -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> > clear distinction between the SoC common stuff vs. what is additionally
> > needed to boot up a specific board.
> >=20
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > [ Do it only for j784s4 ]
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 123 ++++++++++++++++++++++++=
+++------
> >   arch/arm/dts/k3-j784s4-binman.dtsi     | 116 +++++++++---------------=
-------
> >   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  75 ++++++++++++++++++++
> >   3 files changed, 206 insertions(+), 108 deletions(-)
> >=20
> > diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69=
-sk-u-boot.dtsi
> > index 4a82d2fd222669c4b390d4d877bc15329eab8894..adcd89b18ba9df9c72bf2e0=
fb0600b2bc7d1658c 100644
> > --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > @@ -1,10 +1,109 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /*
> > - * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://ww=
w.ti.com/
> > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://ww=
w.ti.com/
> >    */
> > +#define SPL_BOARD_DTB "spl/dts/ti/k3-am69-sk.dtb"
> > +#define BOARD_DESCRIPTION "k3-am69-sk"
> > +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM69 board"
> > +
> >   #include "k3-j784s4-binman.dtsi"
> > +#if defined(CONFIG_CPU_V7R)
> > +
> > +&binman {
> > +	tiboot3-am69-hs {
> > +		insert-template =3D <&tiboot3_j784s4_hs>;
> > +		filename =3D "tiboot3-am69-hs-sk.bin";
>=20
> I think there might be some confusion around the name of this file.
> The format is tiboot3-<SYSFW name>-<SYSFW board config>.bin.
>=20
> <SYSFW name> is the name of the SYSFW binary that is packaged
> with this file, so should be "j784s4-hs" as this uses:
> "ti-fs-firmware-j784s4-hs-enc.bin".
>=20
> <SYSFW board config> is the name of the board configs used.
> For both TI EVMs and SK boards there is just one common board config
> we use call "evm". Other board vendors can use custom board configs,
> take Toradex for example, they have a different board config which they
> call "verdin" and they then correctly use that label for their tiboot3
> filename[0]. We should follow our own standard, use "evm" here.

And put this in writing somewhere under doc/board/ti/ as well please,
thanks!

--=20
Tom

--ECritcsuwuD5t3PK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehK2wACgkQFHw5/5Y0
tyx2fAv+JBBVsV61MjPFjMTDOt9vXzUiwNZm2W+bs3fCxtxkSm9yq3r3mvtFOV6o
2u26FrC9b71PnpZlJh9Ci9Y9kk9i2J5RXaKRxKzDZNiAt216NVMZ682pSxN+NN3R
K5FJFMOT/Md+blxTZ7ArehXBU8OsaubQVNW8mx45d0X0XeKsRLVZ2acvcX4ohaoL
hb+DL04l6GptOJN6n8yTwFXkelOgLaLnp5J/i4kFQ07yro6wUiKUHj0+YhLPUUTr
orv3mB4LKcEBvPNDp9DUkMQsTNTMySHn/N1R+t41r0pj4HSib4aZwWVv5nB7yjQm
4mw9H2Flr2s/LQfy5KVWrKgsAY4yJl425qxXAEF9H1/BfhmisrDG+TcXvOUFkmpg
k0li7Le+uy+Tt/vh4LuYMpWGHK3rFGQs/AsOSw2HeKTNQEWSWU55avCdTPFU1NHr
fZ2c5FPny0met4zi+TdviAvfr1Ue7tlFcY2Hvtv53JzgZXiqr9121E2ix6Vgt9gG
zqQC+QBB
=Zc46
-----END PGP SIGNATURE-----

--ECritcsuwuD5t3PK--
