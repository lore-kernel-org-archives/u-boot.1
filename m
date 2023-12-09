Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44058C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7628755D;
	Sat,  9 Dec 2023 21:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MJlEtHbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D498755D; Sat,  9 Dec 2023 21:34:29 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74B018717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso30463827b3.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702154066; x=1702758866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1Ywbc59SoGFWkh+VV0sfia63x4zQwpBPPAic/Sw2WA=;
 b=MJlEtHbL0iWGP5p95B/Wc6P3yLPXOWIvsiaQO+yyWWQ3+XbGR/y/iXzZgeYbpoMFIb
 pss2JUj3sHfH/gqOXyDuLwmysOvGrAVXnAh2yZOJvjPD0OkNvBGJf4NH6yRWsU8+tVSr
 4d+7suKKL1YCVojKDEAX7LJitIdFcAoVgogjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702154066; x=1702758866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1Ywbc59SoGFWkh+VV0sfia63x4zQwpBPPAic/Sw2WA=;
 b=eGvLh5dFyCrot06TAP7nXFV1KYJnHF2C0DK/arj+Xc4tzsvhwSXFbj4NwiaE/T8NLT
 uVKu1BpAIGBYItsOkUs01tLlqJQ3SNFOeUsyM0gMZXJlcv9ddndFJ7kHUIZzc41QURAx
 F0TpEiMIGhzJcZpa6kZ1XyGKB1nuu6ButU00oLCoRw661lD3415DjiFA+lzfhOgUjODk
 A4ysPcQU5KCS/DcCkc8IZjV+47rs8sFPfgYHiBknNG97LeMLgqDPBQWIVPJuTvwgZMi4
 aCZLB25h2IfcrJWwDTTTUI54qCESPpZgNIdcJfey3aEzV41UfRrO4Cbag8T+qNY1L0z8
 kXfg==
X-Gm-Message-State: AOJu0YzrpINnww0NgWAKMoEMAl9XzI1RpdL5htIrAmXIHAIoTfBusk97
 EvN4z+ogxWohmaCZozMjf3tYpQ==
X-Google-Smtp-Source: AGHT+IEyZcrkXpXL9l74BXAmjO+CzDcOybfima/T+7Vz3AU8/bK/Iv6I0/nsPK7l2c78Q5HtAHsxJA==
X-Received: by 2002:a81:6002:0:b0:5d7:1940:dd66 with SMTP id
 u2-20020a816002000000b005d71940dd66mr1423767ywb.60.1702154066208; 
 Sat, 09 Dec 2023 12:34:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 d64-20020a0df443000000b0059f766f9750sm1698127ywf.124.2023.12.09.12.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:34:25 -0800 (PST)
Date: Sat, 9 Dec 2023 15:34:23 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Vignesh R <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Bob McChesney <bob@electricworry.net>,
 Stephen Graf <stephen.graf@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: Add support for zBIT ZB25VQ128
Message-ID: <20231209203423.GF2513409@bill-the-cat>
References: <20231204005954.13201-1-andre.przywara@arm.com>
 <20231204005954.13201-2-andre.przywara@arm.com>
 <20231206162443.7f0692d7@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+GVDZS7k+Kz6TKJ9"
Content-Disposition: inline
In-Reply-To: <20231206162443.7f0692d7@donnerap.manchester.arm.com>
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


--+GVDZS7k+Kz6TKJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 04:24:43PM +0000, Andre Przywara wrote:
> On Mon,  4 Dec 2023 00:59:52 +0000
> Andre Przywara <andre.przywara@arm.com> wrote:
>=20
> Hi,
>=20
> > Add support for the zBIT ZB25VQ128 (128M-bit) SPI NOR flash memory chip,
> > as used on the Xunlong Orange Pi Zero 3 board.
>=20
> does anyone have any objections against this patch? I wanted to take this
> via the sunxi tree, as this blocks some board support patches.
>=20
> IIUC Linux gave up on adding rather generic entries up for each and every
> SPI NOR chip, if there is nothing special about them:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D773bbe1044
> Should we follow suit here?

And we could then start trimming the table we do have as well, to
reclaim space?

--=20
Tom

--+GVDZS7k+Kz6TKJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0z08ACgkQFHw5/5Y0
tyypGAv/fp8mDhATug2ZkhMrSnKG0/MmieE6zKWXascU7YMwIXJZb3Etpy5/SY6m
WsoXlE0MCZmgXP0UzLiCK1l9fTFDRRsuyW4Z7v4/xeijHgfuxL3qgjkLLY36sAET
ChnTS8sVqZ8k3q97+3lSpVMvfloWbAVZ2JbOd71HpGBOxRix4+4kWy0Lni61XVKi
kNGm8qHtu38puhooURH+q1JMK6z4M9lvS+WvjKwMDyVziTB62dErU4jwBbxAsHFg
xfDD/pCi4/jFbDohGmKlajo9nWz1SiObwuN0aW920b+JelXnZ3SlAqx02G3Kt8lK
IaGdKy1mm3ABFfwZosbztt8Qm5YkhYR5KecHtkpWuNWKQMeyic6U2TDAisnoDoz2
zEpbuQkoztdQQrBiHq4thOIlzEL3l+8/y7inlIG76+QeA7Zz7qz9Tw6BukSF9vTL
hHgQ1z05xeheMVRMXM1MPbwJKkvLS9c9WKxkq5Z+ZS9jGLoId1UhzBDWC/3hl37v
uZ97BSOu
=cR5C
-----END PGP SIGNATURE-----

--+GVDZS7k+Kz6TKJ9--
