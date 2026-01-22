Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0713D6CFA1
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 19:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65848839DF;
	Thu, 22 Jan 2026 20:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W7YXlyPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8658C83AB0; Thu, 22 Jan 2026 20:10:50 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96240838FA
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 20:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40429b1d8baso402434fac.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769109046; x=1769713846; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QY0/HRvU9qdR4itj3ZxJrR2VKnEd3LJqcvlGyblE4CM=;
 b=W7YXlyPuW395SVC2MXDBIayoPuUCeVVWVv/2QHcuz6EDdpN5fPmVWzh1416PICWJjf
 4ZXhMyqstOu0f12ZXsj2zSISMKWK7iN6j6TZ8gvx98+0P2UQOfgbu+YbBm1TeeUiWrla
 Z3DOb4IPMDsZHWcPnzRjFAR7Oeltbz1X0Cpcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769109046; x=1769713846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QY0/HRvU9qdR4itj3ZxJrR2VKnEd3LJqcvlGyblE4CM=;
 b=U3VG0Guzwy6lJAToh3DMNLnyo/kO6zqMii+1+0lbEvPskSzHDQKiqu/+tfiky+6Mym
 VnGUlqPae3fr3Ve3DmGaYnsng+VmVPa5FSm0HO73glfG7qio4gqVUdTqpnQwQG0GcjBW
 qAm6gWJirGswoNvflbcjIrw1K6bQ/Id0KSB+vjOBwVFBFg/6ox1GIb+ACSd0brqVgTl2
 QEgb9g6+gkX1gZRmZmameyGviugiIxNymN15VBoDvEg4CYWwNa2Ob5bXYTAYasJHrhqA
 awgkQ5Km5+OaO/4hjGP8whtDM70Iyw4uSy9tehIPC9PsM9iAs0/QeQQsokJgRyxJ4aIO
 A7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXejjzcAVviqVLJ/weKy+eGacq6BuldSSYoxX6Xgg3nnWpByDcRi14pAV/3aG9hN9PZ1YSo40=@lists.denx.de
X-Gm-Message-State: AOJu0YzmEAI5K+NoT0at/bRVhNYVUu0VWkOjGsh+i6Xd/dURCgqm46M7
 kOgw8E8cfiUSuhCtU0KQyk26+dobmMJGvb48+mSG8tn/Wr3hUWPG+a3MqkUaT1KdB60=
X-Gm-Gg: AZuq6aJc6sZG/xdEYrUHaLdNzDVoYKwpeEU591kDVFKcovMvdUfAEkSkvqf9RsMbql/
 ip/GhAlVqaNCq42iL9ZimJJ7uODVJwPJIT3fYrKyqmXOmAR8Aa7KGbmrnuwBtszWBK8oS11P+aq
 rDnrcd+E2JuNtJho8L9sLggUrcLn7FlRDqlHcJbuvWc+UHugsBFYSNpu6iBVKGW8sLNMHqb38xh
 xiFOxOJJ+VBi3icjdfvGHPXxWkBv4xuKEbC58JiGoxOZeWWlbVITNrR21Y+CaHUv16LZvTyPEaA
 LnJin3t3DttlMVusLONFZ18FysB7s4GOLXV7fLXL0fQIA7GY9V9fIwprU3WvP5phJ83UGQrNG3P
 dDqb5UvwITSwFYETcbU7d7NAGXxEx9RSw+8SyuQ63sfzbK9fusNNWZsPAQ4wBFGSPoV4FgKXZ2V
 24J5JoHJqUBKz1A2PGsjL1LnFl8R3g+J6oHQMBn77vOwxtdyW1n1YFmQq0gGvcVjcsdaDBlnqha
 +7RBfgG8nsTbEtSHn51mR6HA8UnAT73aIjVBpQCDSWBm2rtMg==
X-Received: by 2002:a05:6870:2209:b0:3f5:5d85:80bb with SMTP id
 586e51a60fabf-408ab82f8acmr373084fac.49.1769109045594; 
 Thu, 22 Jan 2026 11:10:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-408afc0397csm8095fac.17.2026.01.22.11.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 11:10:44 -0800 (PST)
Date: Thu, 22 Jan 2026 13:10:42 -0600
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
Message-ID: <20260122191042.GD3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ytfbtONEMAHuT29R"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
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


--ytfbtONEMAHuT29R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 03:47:52PM -0300, Fabio Estevam wrote:
> Hi Tom and Marek,
>=20
> On Thu, Jan 22, 2026 at 11:23=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > We did that, yes. I'm not sure what Fabio is running in to here..
>=20
> Let me share more information with you.
>=20
> The board I am working on is based on Rockchip RV1103 (ARMv7) and will
> submit it upstream soon.

Can you please share it with my off-list maybe? I'm still confused as to
where the "sram" and "sdram" parts are coming from.

> The board was booting fin last week. Yesterday, after rebasing it
> against the top of the tree U-Boot, the board no longer boots.
>=20
> The boot error is:
>=20
> Missing DTB
> spl_early_init() failed: -2
> ### ERROR ### Please RESET the board ###
>=20
> After running "git bisect", I found Tom's commit 8b0ebe054bb3 ("arm:
> Update linker scripts to ensure appended device tree is aligned") to
> be the guilty one.
>=20
> If I partially revert the arm/cpu/u-boot-spl.lds change, as shown
> below, the board boots again:
>=20
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -51,9 +51,9 @@ SECTIONS
>                 __rel_dyn_start =3D .;
>                 *(.rel*)
>                 __rel_dyn_end =3D .;
> -               . =3D ALIGN(8);
>         }
>=20
> +       . =3D ALIGN(8);
>         _image_binary_end =3D .;
>         _end =3D .;
>=20
> With Tom's commit applied (failing case), the spl/u-boot-spl.map looks
> like this:
>=20
> .rel.dyn        0x0000000000015cac        0x4
>                 0x0000000000015cac                __rel_dyn_start =3D .
>  *(.rel*)
>  .rel.iplt      0x0000000000015cac        0x0 arch/arm/cpu/armv7/start.o
>                 0x0000000000015cac                __rel_dyn_end =3D .
>                 0x0000000000015cb0                . =3D ALIGN (0x8)
>  *fill*         0x0000000000015cac        0x4
>                 0x0000000000015cb0                _image_binary_end =3D .
>                 0x0000000000015cb0                _end =3D .
>=20
> With the partial revert above (booting case):
>=20
> .rel.dyn        0x0000000000015cac        0x0
>                 0x0000000000015cac                __rel_dyn_start =3D .
>  *(.rel*)
>  .rel.iplt      0x0000000000015cac        0x0 arch/arm/cpu/armv7/start.o
>                 0x0000000000015cac                __rel_dyn_end =3D .
>                 0x0000000000015cb0                . =3D ALIGN (0x8)
>                 0x0000000000015cb0                _image_binary_end =3D .
>                 0x0000000000015cb0                _end =3D .
>=20
> Basically, in the good case, .rel.dyn is zero. In the failing case:
> .rel.dyn is 0x4 and *fill* is 0x4 as well.
>=20
> This change messes with dtb being found in SPL.
>=20
> What would be a proper fix?

Well, where is the dtb ending up in the resulting binary? The addresses
are aligned correctly, but the dtb isn't where it's supposed to be,
where is it instead? A challenge here is that I could only check the
linker script used by about half of the 32bit ARM boards
(arch/arm/mach-omap2/u-boot-spl.lds) and not the one used by the other
half (arch/arm/cpu/u-boot-spl.lds). The initial error you reported makes
me wonder if we can somehow unify these two afterall, which would be
good in general to do.

--=20
Tom

--ytfbtONEMAHuT29R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXJ2KQAKCRAr4qD1Cr/k
ChfCAP9QpvkA3VLD9WGrr0fBvwr5v+uW+ixdcEypRTatZkH4pAD7BOjAVDGneF7M
E9kLSXgxsvcCokFgip5IhyBaQ8woxwU=
=6TnQ
-----END PGP SIGNATURE-----

--ytfbtONEMAHuT29R--
