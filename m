Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20ABCE7717D
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 01:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82BAC80081;
	Thu, 12 Dec 2024 02:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qwNlt4s8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F156480081; Thu, 12 Dec 2024 02:17:13 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C98380079
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4676859b911so617381cf.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733966230; x=1734571030; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ut4AEbd9zqmnAol4PudIlktVYAaY+O6WZ4EezvGlBM=;
 b=qwNlt4s8T+tP54LNfHpT4ElyDV40Vum9iiPEjwTE4bFYXcS4FCKpE/Pbp/GHmoxoDN
 4IsYGwPCpS8uK8BDJEDiPFWdxYbXDRQzp7FZPTcoIvjWdNFYZwro02clIi1U+7eU9UJF
 vI/c0W8GKfxy0R4vcFubsRmnGqGkmSHjLT+ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733966230; x=1734571030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ut4AEbd9zqmnAol4PudIlktVYAaY+O6WZ4EezvGlBM=;
 b=CY3sdSBj+SPESuGh5p95WBZvly4JGoMAW6RH33rBLgFaYLNLfhvZIG7Wjh2j6sq3Db
 e0L7zSD9crS3RkXPrats8vOILDYw3AqNvGFkbkOkFHAM+kDkreB1HCs1YEeFXp8U7/4y
 aFcfHIwKzCSj0m+ogFhBuNzZD9XIeyySE8qeAk9kIl/Fx3lIx5bBOoFHPoLEh9g/uEBP
 aOXGCbTGRHugq7HqsL69YcJ2/TkiVHAMbGNxCI60x+5l5apLpPPkJHgikPm5oiMaHFta
 0M37A1hW7zFPX7KOpnzbXDZWlnynN5Bx8y7JGrUyBQfjpMvwyp1j4UjhM1VLtT6kWizH
 EHwg==
X-Gm-Message-State: AOJu0YwO70WEBm6MR7YB4KfeddIhWFcW5Zt3OAK+pmIRoSefuuFPMj54
 LgvgUVXo6HtB3qYXxZ2h5sy0gowLS1iXPOepnZ+BwncbeKkBRqqw/A7hGt2rguo=
X-Gm-Gg: ASbGncvMWRqIPjd9l0NipkE7VaZiytzir3eS50CGnnn2XOkQHuiLsR6ostBC7pD2srg
 CGcJFBm7WeJqM84SqsPkTcathWj53SDBYt4gFsrOZ6enrOfO2EhYoyRsWDlCZpybGw7UTNRaH/C
 9/TfH3T6mN9MMDCc955uqLQnLrb2gHsdWlZNhxPgpWlWf5MPB6rhCo3xyY3NiAC4lxGgXNGCFXe
 StxGQscEGfsBomo/0bu1tHP7iiIX2A2GFlMmrdQ21FyFFvD9WqxH8tJ
X-Google-Smtp-Source: AGHT+IEvU0XhArm4Kw6RHV9WkNuRKXjii854kWk33lA+lr29hX+h61EUI5l1KgZGEMktvcBM5ESlBw==
X-Received: by 2002:a05:622a:1e1a:b0:458:2405:3b79 with SMTP id
 d75a77b69052e-46796151aa5mr29954501cf.2.1733966230388; 
 Wed, 11 Dec 2024 17:17:10 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467956c5355sm5544521cf.72.2024.12.11.17.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 17:17:09 -0800 (PST)
Date: Wed, 11 Dec 2024 19:17:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v2 0/7] efi: Start to chip away at the EFI workaround
Message-ID: <20241212011705.GK2457179@bill-the-cat>
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211224955.GJ2457179@bill-the-cat>
 <CAFLszTjjO4tTSAMJxqLUTKXjynR83frsjpOV3wiNTgtv7ptDNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lUZ+py06PTzsQyP/"
Content-Disposition: inline
In-Reply-To: <CAFLszTjjO4tTSAMJxqLUTKXjynR83frsjpOV3wiNTgtv7ptDNg@mail.gmail.com>
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


--lUZ+py06PTzsQyP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 05:58:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 11 Dec 2024 at 15:50, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 11, 2024 at 03:38:15PM -0700, Simon Glass wrote:
> >
> > > At present there is a function, efi_set_bootdev(), which is used in
> > > various places to tell the EFI loader which device a file came from.
> > >
> > > With bootstd, this information is available in the bootflow.
> > >
> > > This little series provides a way for bootstd to provide the bootflow=
 to
> > > the EFI loader, so that it is able to select the correct paths.
> > >
> > > For now only the EFI bootmeth is updated.
> >
> > Hi Simon,
> >
> > I think as a general rule it would help everyone if you had no more than
> > one outstanding series per subsystem per week. This is 30 efi_loader
> > patches in 24 hours and that's _a_lot_. One could easily argue that's
> > too much. Thanks.
>=20
> Sure, I'm happy to send fewer patches. Could you go into a little more
> detail about what 'per week' means in this context. Can you give me an
> example?

Sure. No new patches, no re-spinnning patches, no re-posting patches
that touch lib/efi_loader/* until next Wednesday.

> This series has been sitting around since mid-October. It just didn't
> get reviewed / applied. I just hit a situation where I needed PXE
> booting, so I added another patch and sent a v2.

Per the changelog, you also made a few other changes in here since v1
other than picking up Ilias' tag.

Please also note that it's been not quite a week since you posted the 46
part "pxe" series, and that needs to be broken up in to something
reviewable-sized too.

--=20
Tom

--lUZ+py06PTzsQyP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdaOY4ACgkQFHw5/5Y0
tyy61gv/Yf08QE6YNthZOP4Gs/U0ZAwF4SOJ2xHO6j7G3aPP1GUyvxpisyn9Q95V
tiosbNlQAKqbhbKzcLUX84OmZziVjNk3k5TvU60wKZe2Up6uVHD1q4hT5OGsr6YM
3eLrLOY9nlE/AU2qYU2pQNTKmGhUsY70ytet+VbPr6ZaUac9rVv27MmDpTkWykUa
b7+UHvL1d0fdC9SqenadE3Kczb29z2BoRVomndrVhuXBXQ60AwygSUm7eMUYNBL0
T4w+80fHC5YnGbQ7udYg7043coFuU7es7KOUt7Fqpyi0UGc12v3FPGotYfXvZnsb
UAH07eFTzoOwL2O54KlGuM0G/KaPgUXo/yTE1y7/P0cZo8M2jbpqrqg4Ily1G0ci
TilexhGIRihcK6SUD4nA/9u8wfAgbKgI0hYagLfTgBAuPbAMZD8gkvCT38UUdkgU
cORijkn2pEvbd6jRqbgnlbHxLEWRgzCWrtfp85VfhxiptMHLjqXbz53qKBSoJnuD
TSJmyCY/
=uTLJ
-----END PGP SIGNATURE-----

--lUZ+py06PTzsQyP/--
