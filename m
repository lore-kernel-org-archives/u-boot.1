Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA759C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E8A1806D4;
	Wed, 15 Jan 2025 21:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RhBP0BZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 012C5806D8; Wed, 15 Jan 2025 21:20:37 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DB38033D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8e8445219so2578356d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736972433; x=1737577233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TdneqQgFAFNQVKeMQu1aWb52tAchr5qHu9EGdj9j3o4=;
 b=RhBP0BZaqueM1/BiES7V0Zp+uSD3pSMrwD36gitVfe76Hl+yJSbR92TM9Hia+qSXOU
 Xe+srvlTHj5I/t5wCkRkXuAjwuW8MyF1OB3wOZrwDEKg+B+P/M0aktWT19iTmw265fwI
 PVd4xpXmh35elzwtRXyP7vBVtkS1jzzFFfpRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736972433; x=1737577233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdneqQgFAFNQVKeMQu1aWb52tAchr5qHu9EGdj9j3o4=;
 b=lmHPlim/jVilo6toEJ3f+JsHQ8L0evQoTWv9YvVzKACNsHE95QTWY7r0Sw4heA9Itl
 hIdLx9TwE6jPH1FTNhCzPb2ss1lcj31kCD1n3H8qq1XfyRKr8nqV0uBHkBsggfRJVVfQ
 MfyH3lDA04m7F4izfyjlzXPIMeAn7ThqMvBnUvgij79g5t98SGAXSihwbU+LNQ59TqfR
 X38HMKftKFiW8FGI2QEnah+q9SmH9oZfzq+x5H+yZBpgxwhB4IXdT6uAY8VcMZV61iJu
 iiOVW2yCkrKTX1q0hRHXePnLdWR3FjEnGgUh0SBJOvTiWMhFCgSD/bnv41LvgPfG7jla
 G2pg==
X-Gm-Message-State: AOJu0YzkGxYLlrV5So3O1levulNwGwBkyYJ+dihWte2uvEem92YH8PmZ
 s0hUSKnj/YjTJE/1PhcteMnobcr3YrqTkm9M2F1U65u4o6mh32Ezf/4gqwh8rT0XSIpLyH78A5C
 h
X-Gm-Gg: ASbGncs+AcydoEAlth5o3HjmQpybI+7dQrGBLV3IcjXm/sI3tH9+HbmIRPtebh5Aite
 9Myu/5FGSzXrEYUjPlVQBVaw5dSQfNhcE/uEuZIKGB3EIKN7Z9ij2ArJ/Z1g1ObdSG4rDsHBcRd
 sFeZOcNtCnhhhnDWoM1wmg1D/j9wGXtIeHIE5dzJgSiifh8ZUpX55tAxy+FPFLsEdy1B0VVIwVP
 o9KAbVSTw65+k8FWncmIqzfKIlqOInazTFGO9/0+AogMukBtL1cGw==
X-Google-Smtp-Source: AGHT+IFSImFiRrlpiTGsm9+yy+hVwfHSvkyUb7QZ+zNMPecSuUO6kOULENIqnPkYhnVlCwg5OyzC5A==
X-Received: by 2002:ad4:5d64:0:b0:6d8:ad28:adbf with SMTP id
 6a1803df08f44-6df9b22e522mr480007256d6.20.1736972433501; 
 Wed, 15 Jan 2025 12:20:33 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade895b4sm68428816d6.101.2025.01.15.12.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:20:32 -0800 (PST)
Date: Wed, 15 Jan 2025 14:20:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
Message-ID: <20250115202029.GC3476@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-7-trini@konsulko.com>
 <2b3e1050-7cbe-4dde-a298-5efb63cb4ebd@cherry.de>
 <20250114165914.GN3476@bill-the-cat>
 <4cb564bb-8c0d-43bf-bd91-04668a1deab2@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dPcmF1U6aDob6Vgz"
Content-Disposition: inline
In-Reply-To: <4cb564bb-8c0d-43bf-bd91-04668a1deab2@cherry.de>
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


--dPcmF1U6aDob6Vgz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 06:49:45PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 1/14/25 5:59 PM, Tom Rini wrote:
> > On Tue, Jan 14, 2025 at 02:53:48PM +0100, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 12/20/24 11:22 PM, Tom Rini wrote:
> > > > Now that block drivers are all selecting the BLK symbol, there's no=
 need
> > > > for other options to be select'ing BLK so that other required
> > > > functionality can be enabled. Remove these places.
> > > >=20
> > >=20
> > > We have multiple commands depending on the BLK symbol.
> >=20
> > Yes.
> >=20
> > > BOOTSTD also depends on it, but I assume we should be able to network=
 boot
> > > without HW block drivers?
> >=20
> > Correct. That's part of the motivation for this series (which I wasn't
> > clear enough about on its own). Without something like this series if we
> > remove the BLK dependency from BOOTSTD then some other platforms fail to
> > build or grow a bunch in size (as BOOTSTD is default y and now it's
> > enabled on those platforms).
> >=20
> > > CMD_UFETCH wouldn't be usable without those drivers as well.
> > >=20
> > > Should we do something about that by making them not depend on BLK e.=
g. use
> > > CONFIG_IS_ENABLED in the right places? Not sure if all devicess based=
 on
> > > those archs have at least one HW block driver enabled. I guess checki=
ng if
> > > all .config before and after that change are identical would help us =
figure
> > > out if this could introduce a regression?
> >=20
> > There's a few options, depending on what the command is. For CMD_UFETCH
> > it's likely that a small restructure would be needed to not try and
>=20
> My point is that I believe this patch is too hastily removing the select =
BLK
> because some symbols have "depends on BLK" and by removing the select, we
> make those symbols unselectable. This can cascade if other symbols depend=
 on
> those now unselectable symbols.
>=20
> Also, removing the select BLK from architecture/target symbols can introd=
uce
> regressions if BLK really is required?
>=20
> I think a reasonable (albeit cumbersome) solution is to migrate all those
> selects to the impacted defconfigs so that effectively no change is made =
for
> existing devices. If maintainers want to remove BLK, they could then do it
> later.
>=20
> This also makes sure that BOOTSTD and CMD_UFETCH (and others) are still
> enabled, since BLK would still be enabled, just from a different location.
> Then another patch series could remove BOOTSTD dependency on BLK by adapt=
ing
> the code, same for CMD_UFETCH (and others).
>=20
> Does this make sense? Am I missing something?

What you're missing, I believe, is that this patch exists because prior
to the first patch in the series and also going back to when BLK was
optional, if something higher level like ARCH_ROCKCHIP didn't select BLK
then it wouldn't be able to prompt about its MMC driver. This is similar
to all of the high level places that "select DM" as that used to be
meaningful but now it's not. As part of testing the series I did my
world build before/after and the only change is that as noted in the
cover letter, espresso7420 now has MMC again. Does this help? Thanks.

--=20
Tom

--dPcmF1U6aDob6Vgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeIGIYACgkQFHw5/5Y0
tyxOSQwAh3xE0SOgI9Uo2hlTQD+kY1asft1KjmypjZQB0zC0SIPbQs28vq2oDfrl
kKUXDgebcd2NURMxU+n4vjcMf+kFx2BuMsLk3lrKoOiedt8tNSn/7zh9lf9fE5m5
XAg2snZEhDrJuopjpgSGJExG3lhf+CAbiqj30DxmMh+eVMSmlc1NNN3DZ7mcbRrK
0vTMICsI0iTxaKgTG4L29cCZqxEcJUmf/QR+umABQ8gKIQGJxlHQ7xSnVBy2lVgW
Ph85GyNI5YXl30+2wB6k+w+IFn3Su91dMExNmvC0lVhpW6Ik97SLhgu0tjOrgS0v
Vq4frojCe1RhJ8CgtdikUnkB3HZtIAfqkKlrtlXJ8nEk46kMWutDETAHFAhBS3ab
GwCNJ58Rqe6VYTQlnfuP2ipuFvh8LzXIf9so8g1rPUvs+43Avoq584HESEsfVMjX
/gBYCksqvxJIfwPegWNQXN88Yeu9ptCqwDVfBWIzSbsbZ0/7hWRFI+jQ/3NRzH4P
n1eFWX2j
=PORj
-----END PGP SIGNATURE-----

--dPcmF1U6aDob6Vgz--
