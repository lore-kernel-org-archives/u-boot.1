Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6984DC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC0788400;
	Tue, 11 Jun 2024 15:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K+0pVZ1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1EB2885F6; Tue, 11 Jun 2024 15:52:17 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A670687D0A
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f9c1902459so1158185a34.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718113934; x=1718718734; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gxRQMyjCqQqeyhuA487gVf27W8CpvM/IkkXzDooX15A=;
 b=K+0pVZ1xGqzvmOq+gLqQ8S22OPqfJZrozjuE0lnHtC4G4uwI/tj6DFp0tD10OUC7h6
 keF4fAAV6t0TMNPiQF+dvii+2F1S7QUItcRM9c8PB0BJqjnsWbr3OQp5pmUSNqfWKJsI
 6GVOT2Lpga390R798eKan8I0PC+IDzDk9LHik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718113934; x=1718718734;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxRQMyjCqQqeyhuA487gVf27W8CpvM/IkkXzDooX15A=;
 b=uMyA+HZhR4+MdtcTGSQTHvISzx/5B6ETeInVlGr7YLS6I96dLOH51W6DnXnp7SkDaP
 22ZbrELGjXxR+3lxgbN4UkQgRqjS4ayWaFMx+8qCVVNseo5CyVyDFzIa+8icIJfLgn2J
 0ShH/mN3iostMNAV5dxCyj84G4nqsqx5P7a9PtZqsq+wKq5yzEY0sLQSaxBoGp994YX4
 bGChkXHlw4xgxPKtn24E8zfUUj38AOyEMtn5mnauFffK9JYKWG5DTvtBHODSbndibvu4
 u+g/yLOvfEqsFGYyP2dbKdn6udKxa6VRBnmC8/MYnfm+VzRX9PiW5DLhl7khELLCfu9A
 zvmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVISfpQKRmW/aR+osdoLsWw38Zu95W1V0eOuM7ZFryM7PI9ntkZNjDyI795EiX6Eau/axdUEEppvUglarWnPMoSeVaWBg==
X-Gm-Message-State: AOJu0Ywt9aWwpR/yTfn2S1r+lmP0z1iz1tI9j+Xllkt1DWiInXcyLqzn
 h8UAKEr9AbMfJI3PDTmnnbvaxOQjBJmeo/N8DhpsaXf3JkDVX62d3Nz0PPD8hLI=
X-Google-Smtp-Source: AGHT+IEGJNEn8S4+ZBKN43wTZVaGQSiOdPBToiuks7J7Ym6ACVi8CeBMGEO70wtTFuLrqm4DAZ8YeQ==
X-Received: by 2002:a05:6830:d2:b0:6f9:7538:b291 with SMTP id
 46e09a7af769-6f97538b386mr9335835a34.26.1718113934206; 
 Tue, 11 Jun 2024 06:52:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9d9407ba9sm495334a34.3.2024.06.11.06.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 06:52:13 -0700 (PDT)
Date: Tue, 11 Jun 2024 07:52:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 03/16] image: Take entry point as an output of setup_booti
Message-ID: <20240611135209.GB68077@bill-the-cat>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-3-1407e0b69678@flygoat.com>
 <4887f128-786d-4d07-8dec-79ef75e39509@gmx.de>
 <43b029fc-2910-455c-93d7-6555c65bf189@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kaUcg4UjlOGNd6iY"
Content-Disposition: inline
In-Reply-To: <43b029fc-2910-455c-93d7-6555c65bf189@app.fastmail.com>
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


--kaUcg4UjlOGNd6iY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:29:38PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=882:02=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> > On 22.05.24 17:34, Jiaxun Yang wrote:
> >> For LoongArch the start of the image is not the entry
> >> point to the image.
> >
> > Looking at arch/loongarch/kernel/head.S there seem to be two cases:
> >
> > * The kernel has an EFI stub (CONFIG_EFI_STUB=3Dy).
> >    The legacy physical entry point is available at offset 0x08 of the
> > header.
> > * The kernel has no EFI stub.
> >    The kernel entry point matches the start of the image.
> >
> > Where do you differentiate between the cases?
>=20
> Hi Heinrich,
>=20
> In case there is no EFI stub LoongArch would use elf format vmlinux, there
> is no real "raw" image for us.
>=20
> bootelf can't be used at the moment as it doesn't setup FDT and other env=
ironments
> properly.
>=20
> I'm planning to implement a bootlinuxelf command for this case, as MIPS, =
LoongArch,
> xtensa are all using ELF as default kernel image format.

Please note that we have CONFIG_CMD_ELF_FDT_SETUP already, so adjusting
things so that bootelf works for this case should be doable without a
new command.

--=20
Tom

--kaUcg4UjlOGNd6iY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZoVoYACgkQFHw5/5Y0
tyyMywv+PTMeHpt6Fyu0n6FCveArXw4jqpKrFeYr9cE17xcYfBkyLzLH9NR39Djz
cSbE5NVWirDBU3QmtB1QZem8Yfzp0Rm0WaL0vWs82EUSNPlad3WoFqwJ96O5oOsj
97Pn2rTYDIDeHfLrWcWe9lygzCfyMuJiEv77CpTBQEuHaQZQJ7JP7ZOA79Th3tC4
RN+PVC9FTL0JBLaNRMFRIbx8TPLpP4+HzeccpRBVoy+JwPdzMSSlarOUD2u1scAZ
zAVsrvlSgvf9z5JxxXtK5SJGD416uwGGyS3EtvynF7LWFu6EtlbEskv+2Q3CVa7a
GSvHTaJrCWHs5UeuPROSD02Q4QTDNdQrTkYtTCdLaTI1fqdpSeVOv33EL2wNo3bA
4NEJC6fvXFBQq+5wngrRldXdgiQtL542A3INDbErub4JnEfr4/IxOj/2xAbQrID/
qsl9qjLQHo+s5iJB0LG+CKjeLaIWksbTvXQvhF1R0ie00l3VBV+dqtFV7AhhpIfT
tmBN/272
=kWpZ
-----END PGP SIGNATURE-----

--kaUcg4UjlOGNd6iY--
