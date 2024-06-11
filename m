Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D7AC27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AE0886D7;
	Tue, 11 Jun 2024 16:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kkIPspr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99B2886E4; Tue, 11 Jun 2024 16:09:48 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9095D8865F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5b3241373adso635830eaf.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718114985; x=1718719785; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P6SxUKRHabdRoX715cS1iCt1GuoPwevsD/KA7Nw18JQ=;
 b=kkIPspr0azwZTQQM75H3IhzAXxieWkasGxTtLGwtQm9KmvaqSnF3QfucU2zEbY3eTE
 Sx6v7ldJuj54JJ403026w7i6hgqBONnLa7ZWUEH32qz79ZriJ/0bor7urzFL2bmCtYoK
 Ua+S2qSmuYNzPBgEG1hUmBuVbKn3Y2grTtFWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718114985; x=1718719785;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6SxUKRHabdRoX715cS1iCt1GuoPwevsD/KA7Nw18JQ=;
 b=UdZky0NWpiHSPpwQyD/aFW9fyi9S9tcDns4v4XhVwWRX3v97bDvQpknA6J3Wq8xnit
 kUF7g3aKuP5zl+TOX8B9WsbcHLerSL3BMRAa0AQBxQ+fDKdq5KRVlhaCvKNQC3wpaf4T
 imwIzlwNyR+FkSmob0QuPkcy5JfykUfwrZcMydqXE/4nsmuyqpiOPp5qrpa/rDY/Ivo0
 wvOOlMVllrWszQESWTGLsS9erV+0Cg/ooSUa7rgy2lEpen9MUS0GhND16SRkTwfQh2LT
 QL9lWul1APoSWMigAK2ectaFSmVIb11a/GI22n/zfeiU5sp7qSqVqzMZ//psehThxj2E
 88ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIgTE3KZ6hwe8BkzsIZ2THk8fPUq/rPDXCTDWKJKddREJTC6nFB857vJjHpGd1EaMc08DkCNOsO3yqBN8UA4J3aCI5JQ==
X-Gm-Message-State: AOJu0Yw7/LJk9O5HsW1rQP39coRGntZI+F42S0SpUB5O678URH6H7ubg
 LlOOUBlMX/l60VDb8ZxjxfYdoVIdcRwf99SGfeUwjZaJd8T28ZMBQhWkGejgde4=
X-Google-Smtp-Source: AGHT+IFo4vmZQ1qzRbZU7Z5R3wAydN2xVhvpaiOKs62K8ATIxRNScZ9WyLNZy+p6WI7WEHqJ40X0Zw==
X-Received: by 2002:a05:6870:8984:b0:254:7645:eebf with SMTP id
 586e51a60fabf-254764630c4mr13171407fac.37.1718114984902; 
 Tue, 11 Jun 2024 07:09:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254d96e5e7fsm803139fac.26.2024.06.11.07.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:09:44 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:09:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 03/16] image: Take entry point as an output of setup_booti
Message-ID: <20240611140941.GE68077@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-3-1407e0b69678@flygoat.com>
 <4887f128-786d-4d07-8dec-79ef75e39509@gmx.de>
 <43b029fc-2910-455c-93d7-6555c65bf189@app.fastmail.com>
 <20240611135209.GB68077@bill-the-cat>
 <cdb2ba34-09c0-47f3-b72c-4099b48a6946@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6HhyscQxHo/Xzjk4"
Content-Disposition: inline
In-Reply-To: <cdb2ba34-09c0-47f3-b72c-4099b48a6946@app.fastmail.com>
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


--6HhyscQxHo/Xzjk4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 03:01:00PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=882:52=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > On Tue, Jun 11, 2024 at 02:29:38PM +0100, Jiaxun Yang wrote:
> >>=20
> >>=20
> >> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=
=8B=E5=8D=882:02=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> >> > On 22.05.24 17:34, Jiaxun Yang wrote:
> >> >> For LoongArch the start of the image is not the entry
> >> >> point to the image.
> >> >
> >> > Looking at arch/loongarch/kernel/head.S there seem to be two cases:
> >> >
> >> > * The kernel has an EFI stub (CONFIG_EFI_STUB=3Dy).
> >> >    The legacy physical entry point is available at offset 0x08 of the
> >> > header.
> >> > * The kernel has no EFI stub.
> >> >    The kernel entry point matches the start of the image.
> >> >
> >> > Where do you differentiate between the cases?
> >>=20
> >> Hi Heinrich,
> >>=20
> >> In case there is no EFI stub LoongArch would use elf format vmlinux, t=
here
> >> is no real "raw" image for us.
> >>=20
> >> bootelf can't be used at the moment as it doesn't setup FDT and other =
environments
> >> properly.
> >>=20
> >> I'm planning to implement a bootlinuxelf command for this case, as MIP=
S, LoongArch,
> >> xtensa are all using ELF as default kernel image format.
> >
> > Please note that we have CONFIG_CMD_ELF_FDT_SETUP already, so adjusting
> > things so that bootelf works for this case should be doable without a
> > new command.
>=20
> This is a little bit broken as then you'll need to bring architecture spe=
cific
> functions to bootelf to setup boot registers, initrd etc. It's fine for A=
rm64 which
> you just need to throw fdt into a location in memory but for MIPS and Loo=
ngArch=20
> you have to setup a good deal of other stuff.
>=20
> Ideally those setups should be done with bootm_run_states as what we've d=
one at
> booti, but that would be a semantic to bootelf command. I know many exist=
ing
> MIPS bare-metal applications rely on argc/argv style bootelf and I don't =
want to
> break them, thus I think a new command is necessary.

We should discuss this in its own thread, yeah. It's been a long while
since I had to bootelf something non-trivial and one of the issues is
that yes, a bunch of quiesce the system functionality wasn't done. Maybe
it's just a matter of adding a flag to bootelf to say we're booting an
OS rather than simple app and so call the normal boot os prep function
chain.

--=20
Tom

--6HhyscQxHo/Xzjk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZoWqUACgkQFHw5/5Y0
tyyoAAv/S+m9MvwdLiS1+lHQBfI0XXdPKrCgUbNwIohuWro9gKyHcyt5XrxuxB1A
IoNQ23/KRI/ACQsaOfOtNI62PmabUSE5mecNuTZ/Ch5dkDdb9ykyghWlvBQ+VFkp
2yBGeXGV4ID1hGsbbmqvIiw5UENacNIMk49/XPcWQdz9/j1waea2BPkaOPZffhYB
SDqY0qgYOeyn/LB4bblWiARfrbC/1uJ+YYxwIreGMC4yPTzfJloRc8r9NH39SWAI
TPyGz80kowkckv0BFXIkYSZ3lnhF1b2EHdpvZoIxMGVU5ttI0+jnB3rArp8OTMr+
k7nDW4Nkw+zpfaOyPEbQk95iPLNQOe6tM78OHyNantyNsfspR4f0IF3HpI87IC7+
ovY+2tQrn25bWWOdiFeGnH4UMiDelU7FwShIyhrXzrguXDOl2bwXc/Hy3pcvgr81
elOPGAy9YrBxbZHEA1wkwy5HEaEDAIt8jkMiw0bQzV7pYIdFOLwfKZ5qb9s2JU9m
eoaVhy3I
=wIec
-----END PGP SIGNATURE-----

--6HhyscQxHo/Xzjk4--
