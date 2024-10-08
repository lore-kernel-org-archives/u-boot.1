Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B322DCEFC21
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2314888E78;
	Tue,  8 Oct 2024 17:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y2DGnLYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4F688DCF; Tue,  8 Oct 2024 17:08:42 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902CD88E78
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7ae3fcec5feso600669285a.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728400119; x=1729004919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUEzrADunBHP8CGJQlO+BEnVdoNDrntV4EpkznJbisk=;
 b=Y2DGnLYdaUjIykkwXxdUv+iTP0qWEQH6I1y4/gt9F1vaBC4JkodfmHpX/4w8qFJkZ+
 OEoOh94BcddgN76ckDBufAMIozdpw9R+xxefosCQYQ9OEZx0N+8GJZCLmMpsNWwIwgl3
 FkW3qXvvXtsYjxj4vkjEMa6Uh+VkpWu0uT0zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728400119; x=1729004919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUEzrADunBHP8CGJQlO+BEnVdoNDrntV4EpkznJbisk=;
 b=rwJAuSUkGrxrtbNyivjnO6ld29zNXHruNkrHrj8zeT1UP2+7wIK1Pzpk3NodjED4SO
 +81KlQZztjcRPUShU4pn4MpHruXYcY1ukdEqGDR083RMN3K1jboXZdrDMi/pM/0rssYl
 BYy1ZBxDsaSHSqx8Zs3B/YZMyWz8Qqnjlm6SOXcAJIVBMKdJLbzwI7YdEFxMk+QW95IY
 fcOj6Wu9zN//uGUWBQTmF8ZvsJd17hzMKdT/4TqEiuhUTY70+FEaspMEtqVoD6m3/BKd
 s8JH7cscHymCCSWuI4yGaTSSn4v+Ac+j043YAoj4Hxa0FtAq+jD1YbS26AW/oR/Qk+kS
 dnqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjnsGt7zkZijJEHpMkHmido9QQAs9c4C1QtuLB/K2Qt21evFnFsLD+6fgcYSHDYNArXrhz6Ys=@lists.denx.de
X-Gm-Message-State: AOJu0YzICIjwcwLip5p7+ZPQ1FePfhqW7Lm0QqEZ3k53tgRYRZFxZiXI
 152ZmxsmExai2wQBy9RmOP4364HPFSAk0qWMgfHZzck+HfYcdGXqsWgg9lMssVw=
X-Google-Smtp-Source: AGHT+IHAKwY3fTPL18pXZU4xRlz2ZLC/0PpWsap7HAFbpq+GhjtjPTjsZWirCdpXWeeflOty/0CiTg==
X-Received: by 2002:a05:620a:4809:b0:7af:c5cf:1d32 with SMTP id
 af79cd13be357-7afc5cf5028mr370994785a.9.1728400119262; 
 Tue, 08 Oct 2024 08:08:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da75ed6besm37023391cf.75.2024.10.08.08.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 08:08:38 -0700 (PDT)
Date: Tue, 8 Oct 2024 09:08:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: Re: [PATCH] imx8: Correct the SCU API return value check
Message-ID: <20241008150834.GC14210@bill-the-cat>
References: <20241006010522.20841-1-peng.fan@oss.nxp.com>
 <CAOMZO5BPoiyicMANp5Y7283_FOhgz7SMeQoLFx=xf2XWNm-1Yw@mail.gmail.com>
 <PAXPR04MB845933A05D034E994CDB6E3F887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XKBb45rhYNZQAda4"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845933A05D034E994CDB6E3F887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--XKBb45rhYNZQAda4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 03:01:54PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] imx8: Correct the SCU API return value check
> >=20
> > On Sat, Oct 5, 2024 at 9:01=E2=80=AFPM Peng Fan (OSS)
> > <peng.fan@oss.nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The SCU API alrdeay has been converted to return Linux error code,
> > > using SCU error code is not correct here, although SC_ERR_NONE is
> > > value as 0.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >=20
> > This causes the following build failure:
> >=20
> > aarch64: + colibri-imx8x
> > 304+WARNING 'mx8qx-ahab-container.img' not found, resulting binary
> > is
> > not-functional
> > 305+arch/arm/mach-imx/imx8/cpu.c: In function
> > 'arch_auxiliary_core_up':
> > 306+arch/arm/mach-imx/imx8/cpu.c:249:9: error: 'ret' undeclared
> > (first
> > use in this function)
> > 307+ 249 | ret =3D sc_pm_set_resource_power_mode(-1, core_rsrc,
> > 307+ SC_PM_PW_MODE_ON);
> > 308+ | ^~~
> > 309+arch/arm/mach-imx/imx8/cpu.c:249:9: note: each undeclared
> > identifier is reported only once for each function it appears in
> > 310+arch/arm/mach-imx/imx8/cpu.c:262:84: error: expected ';' before
> > 'if'
> > 311+ 262 | ret =3D sc_pm_clock_enable(-1, core_rsrc, SC_PM_CLK_PER,
> > true,
> > 311+ false)
> > 312+ | ^
> > 313+ | ;
> > 314+ 263 | if (ret) {
> > 315+ | ~~
> > 316+arch/arm/mach-imx/imx8/cpu.c:260:37: error: unused variable
> > 'pd'
> > [-Werror=3Dunused-variable]
> > 317+ 260 | struct power_domain pd;
> > 318+ | ^~
> > 319+cc1: all warnings being treated as errors
> > 320+make[3]: *** [scripts/Makefile.build:257:
> > arch/arm/mach-imx/imx8/cpu.o] Error 1
> > 321+make[2]: *** [scripts/Makefile.build:398: arch/arm/mach-
> > imx/imx8]
> > 321+Error 2
> > 322+make[1]: *** [Makefile:1907: arch/arm/mach-imx] Error 2
> > 323+make: *** [Makefile:177: sub-make] Error 2
> >=20
> > Please make sure to run the patches through CI.
>=20
> Ah. I built imx8qm_mek, no issue, but seems indeed issue for
> 8qxp. I will do more test.

Before reposting all of the i.MX95 related code please at least locally
build all of the imx families, and pushing a branch through Azure CI
would be better still, thanks.

--=20
Tom

--XKBb45rhYNZQAda4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcFSuwACgkQFHw5/5Y0
tyzOXwv9HzvDmao6n1RLBreEG6tDnFeG98k4ne/KJVImfex4/enWUxTyv2ir910y
Xmzys6h/FFzaxgRC0MNfdmD1Nd64KP4yHlRoiwwEFW4lKcBKxQ4y55bYl9vy3i+T
KNTcZuH0na7PK/d8fplfwZWmGyuameaZEutu0gnz+ZbwcGfjFXqFdc+9BzrMbpuI
YEUb/6CKIdkZM6za2xom3o/vgipA2JMbNpmwENc6iQrthvU/ShaE4dxbSHM/D5LC
NGAp36YmP2QgVMXnFSVd7genXACTcAK/C0puEtst8yxPSq9c7oK5sbJ0TD6/2KVt
rD6eRs8FRFC86WfnE34NVviPdrtoiUa7kzqQkNRbWibH/f09hdEWOhDLCBtHhOxe
IoPmx0li+2mJnkwqnemuEPTxEGby3WMy4T7kYn3qVtpSu0adqGBOyrOG530+KwZR
7l4/w7VoaywYEQxcWjbWkcXf3GvSUmqOp3KlVWcIWb4M6zbqEoGtFjUOvxoO6BaE
A5wwBO7D
=Af4i
-----END PGP SIGNATURE-----

--XKBb45rhYNZQAda4--
