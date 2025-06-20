Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D4C7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 18:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D6182BA1;
	Fri, 20 Jun 2025 20:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wx4HCG9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C463682BA1; Fri, 20 Jun 2025 20:54:32 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994CD80C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 20:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-60402c94319so1163342eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750445669; x=1751050469; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zr2H8eppeLTBC/0lBYluBRzooNse3vDbMmpcqWqw77o=;
 b=Wx4HCG9+sX0S6lCvS8ckFPvnDCSG7uIqEd2iwJ+NR/42hWd1ngdIqVtghxxhw+jnY7
 QurpOnGkolSbY+UT6M3GyVcrwurfVT94GzUi4jjXvYc4I/8Q+tSLCgLUJfHpo0A7CRQd
 HtHHhifqevAuz3d5QXS5p1BzGUJ0DGLJhrKsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750445669; x=1751050469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr2H8eppeLTBC/0lBYluBRzooNse3vDbMmpcqWqw77o=;
 b=TGt+2ewNTGMMvRln1gTKfsWlIJjkbO2Cp4zMEHx6uQ91xv9aIkBGdchkm/GI8Ht87T
 VgjKK+g79e/ZC7k7a0PsuGxJKHIwfCUm7mipdV7JRrQEvYLWsnqXABqMHD+FWYqINdwW
 AHEJ+VhcD9ZWXnO98CelMiJu9H7Uh14Wkn4j6g9jS87r1hfgp205h3xDs6Yu0aCD2Ink
 DkeX9I7MAH82fAn8BUKdrXRvRI0PhHgVI6V9R4/kpFr72CM4KPSgaYRk6ICDL5SanmPx
 xJ/bysDxWW69HpehdqTckEAOiU7YggDSVRIlzibDRDHrk9M6v3niUJETa2t08FB8Yozg
 owow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtgdsi+5lj9FtpdihUC3WIpuCLaz3Lmc/IN4d48yniKsQr2BwO90Kr1ANC8ay1hTSHkZjDqBI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywfib5wABUknz/yP9oC6WKUYqdZWpaaIM6KQH0pcJvtk+TKwz6O
 C7sIoB0c1MDu910JAFx6AytdsGN57LTDMb/YydW5pF25ruLx5SDt6AIfux87A2Za5gA=
X-Gm-Gg: ASbGnctDejGfqZPOpzw3GMEQw8ETrKjqmVGJehMlayuG5Pg1imPa3qEHN7wP89OtSQ7
 oCaPC621eQ5nbRbIB4eKH1gJPG5cgDb5ZwtpgAGusnIWorRDmF1Z30IbYR+erHZZ4rW+wC6onat
 6RcJC6ybn3yfANM6Uh42I97eOW8nmiCIiohDLJLM29IDHws4YBm9AYY54HC/BokbJM6//A/Y3gD
 5pEYvKa6SW42ZY0qaemH1MFvIXpEfdTkx9FYfTlG+1z2AgVA96CRYbWtfsm9hczZi/6hcA+84im
 W5c/oNQeWMuD1LrKRSPNALdWpn3l3k8Xdqq8vlPMLYd4Z34x2wDZAgxlA3cv8V0MNHpzJVJv/vU
 cdD5pkFsX/YcGOhHZIjXp3Ko=
X-Google-Smtp-Source: AGHT+IEX7PCdkfzwsO/Qp1ECQqu89ANITajdHOJNrZrLjrX68XH1aaOtftxvfRPoClvVUWcm2uCJiA==
X-Received: by 2002:a05:6820:1986:b0:611:3eb5:7291 with SMTP id
 006d021491bc7-6115b8a100amr2939757eaf.1.1750445669308; 
 Fri, 20 Jun 2025 11:54:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6ca9b3sm318442eaf.11.2025.06.20.11.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 11:54:28 -0700 (PDT)
Date: Fri, 20 Jun 2025 12:54:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] board: samsung: e850-96: Fix MMC devices in EFI
Message-ID: <20250620185425.GM216500@bill-the-cat>
References: <20250620022556.10363-1-semen.protsenko@linaro.org>
 <20250620142058.GJ216500@bill-the-cat>
 <CAPLW+4=JkVWoNaK5f98fRXOLZOQWc462U=EaDfYsXGmYBDbYnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hn7jWGg54TfV49af"
Content-Disposition: inline
In-Reply-To: <CAPLW+4=JkVWoNaK5f98fRXOLZOQWc462U=EaDfYsXGmYBDbYnA@mail.gmail.com>
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


--hn7jWGg54TfV49af
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 01:36:09PM -0500, Sam Protsenko wrote:
> On Fri, Jun 20, 2025 at 9:21=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Jun 19, 2025 at 09:25:54PM -0500, Sam Protsenko wrote:
> >
> > > Avoid using MMC in board_init() to make sure disk objects are created=
 in
> > > EFI subsystem later.
> > >
> > > If it's still possible, please take this series for 2025.07, as it ma=
kes
> > > EFI functional on E850-96 board.
> > >
> > > Sam Protsenko (2):
> > >   configs: e850-96: Enable BOARD_LATE_INIT
> > >   board: samsung: e850-96: Load LDFW in board_late_init()
> > >
> > >  board/samsung/e850-96/e850-96.c | 9 +++++++++
> > >  configs/e850-96_defconfig       | 1 +
> > >  2 files changed, 10 insertions(+)
> >
> > These should be one patch and also I think you want to disable
> > CONFIG_BOARD_INIT ?
> >
>=20
> Thanks for the review! I'll send v2 in an hour. But I wasn't able to
> find CONFIG_BOARD_INIT option:
>=20
>     $ find . -name Kconfig* -exec grep -Hn "\bBOARD_INIT" {} \;
>=20
> initcall_run_r() seems to always call board_init() for ARM and other
> architectures:
>=20
>     #if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV) || \
>         CONFIG_IS_ENABLED(SANDBOX)
>         INITCALL(board_init);    /* Setup chipselects */
>     #endif
>=20
> Interesting thought though. I did a brief analysis, and it looks like
> there are 79 boards which have empty board_init() because it's not
> possible to disable it at the moment:
>=20
>     $ grep -Pzrl "\bboard_init\(void\)\n{\n.*return 0;\n}\n" board/ | wc =
-l
>     79
>=20
> Do you think U-Boot could benefit from having such an option?

Yes, it looks like we need to clean the code up to match what we have in
Kconfig now, thanks!

--=20
Tom

--hn7jWGg54TfV49af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhVrl0ACgkQFHw5/5Y0
tyypZwwAqbUEFB8KWwejQo6thmV/C4Pp14vVBLfqwEjnMs+tTk/RBXf1seCTMIXb
GlARjFf1v6yaZwa9D9+MySr9PdPrOEkVRsFYGBNBli1n1M0s5RpIrE/yp5eMbsmW
8rsBRYfqtIkfMKvB39gkIq0Db+nENAjQe88ENVj1qt8Opr6YVjdhERU8UwRIOvEn
IrBPsQU38Q6hqy2ySV0wWlStrHtpn2wzrEBdhzJq46/LxnX5C07j6IMd2VtmkHet
it/Ab4gh//RYR1nqEK75/hylIF9s7LI4txZyn7ek/IqOvIMNrx9gf4uJMilG1Alb
ElRB6BOBz9f+m7gIigJQtYZ3TzQ7H+qoM+9PlQ6DghxLs4TjmBafBYFNOBF1Hw8U
GE7QICXVmbxbnN9ZKOT//CichyOXcp2Cnioqh2sekMsuiYfu9QQ9TBta+ji5r6vB
1aMMhefVUCvlzjLESsFfNDtBO/PUHt5tgYYnVKa34LZ2UVyhSQvnkZDDCm+DSx0V
4JmI/sdG
=pczN
-----END PGP SIGNATURE-----

--hn7jWGg54TfV49af--
