Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3777DC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC527806C9;
	Thu, 23 Jan 2025 15:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tO1brF66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43693806C9; Thu, 23 Jan 2025 15:42:12 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A04801B0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8f75b31bfso10797706d6.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737643329; x=1738248129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ch5cHBvOCP0AARep2xS1DSduaU1erRK1GAGW/NBcNGs=;
 b=tO1brF66I6tfdUq8LsS2YHfRN7ACtF1HHKv0EoC3JTmYraZ7PejA8ZipsphsGrh5w6
 NUWh55/NjJwkKAIjOwpxSBYoVTe6+J7A0BCO7Dmmzft30SADpe0cjm5r3Z8qkVX7Y8Wb
 zDwrAZlH93qhu8k3apwro+v0OnT0JB5mXwdMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643329; x=1738248129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ch5cHBvOCP0AARep2xS1DSduaU1erRK1GAGW/NBcNGs=;
 b=E/qsXtJo4Zi88WCktSIDqMRROwfBZBkj5fsPwfY/WlEA64qkN9a8Nhwc+0FFarGbCw
 UyXrEchv7eS6ed1aYhiJcNW70lxrPL4qzDmNt3DZ3/gleu5vu5xlQnhWYPU+1OfyJciH
 S1jTV7PgDcOpXDLecmTPP0Z090uvrK5x65AxmkEofGWmu2t6g/31n5Kcjc4dwEgLubfX
 ItuRJVde0wUazjkWt5DeOjAltLo8UTTUh4inTIVt+6QuUSBiwLRL+S0ROESuxM2VrOp1
 q6X69vNrfs6ul67DeuUJWblVJB3WSM5q5gTwSCgZAKKpiI86mvozYMeoVwYgn2ux/Pri
 j+uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj6J+x9yG+uwLEILJHttLkJChUQWBkIf07o4DaMLKLVFxxFJK07Cw4hyJLRAj3EhEUaq7qJkc=@lists.denx.de
X-Gm-Message-State: AOJu0YzohWuger8VAK0Dx6GKpuZ+fTDE9i4W/jTu0CeLDktn0INVOSBp
 HOnvyS4WUlDXewICiEkL4gyIm98VZAQZeF6+hVHjWgxkBDpawGnFTkB7/CLu/xA=
X-Gm-Gg: ASbGncsajOOWABXWn0WQLXZATOfRzOc76nMCqYuUtXeGVOMb5DfYnPx3IXRW45NZx8I
 d56YGs4W88bntdPBgtuhy5klNKzfDDRPBenPxIer/B00J8uQj4NRxKru4tEIAp8XINyIy0JF+1A
 EQ7CN1kz2DgeBb68urAlV3suYHMT+PKuslv7Wxg2IZqNJoe9fNxhg68YeGufYLeh/HPM2L1z+6A
 09fliQlgEZvlwntMm6Yz8FnuHUO4qbE0rA113zJCQBzY2jm4lsocfPJbfLEotAq6T9QwefJNl8D
 LDU7
X-Google-Smtp-Source: AGHT+IFqEIglplLQpbl06F54/K1kIm9zCYL8aa/kKd01xiIWR3wD75Bu9RWHdoxWm5WTfl/MOIK4WQ==
X-Received: by 2002:ad4:5dcd:0:b0:6da:dc79:a3d2 with SMTP id
 6a1803df08f44-6e1b2171505mr410336916d6.5.1737643328807; 
 Thu, 23 Jan 2025 06:42:08 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd39cesm71296056d6.82.2025.01.23.06.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:42:08 -0800 (PST)
Date: Thu, 23 Jan 2025 08:42:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 19/21] py/tests: test_efi_selftest: Add test for counting
 EFI netdevices
Message-ID: <20250123144205.GJ60249@bill-the-cat>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
 <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sY4mXXApPiUN8aeC"
Content-Disposition: inline
In-Reply-To: <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
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


--sY4mXXApPiUN8aeC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 07:37:26AM -0700, Simon Glass wrote:
> Hi Adriano,
>=20
> On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > check that the number of ethernet udevices matches the number of simple
> > network protocols
> >
> > Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> > ---
> >  test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_ef=
i_selftest.py
> > index 310d8ed294..af9992a6f7 100644
> > --- a/test/py/tests/test_efi_selftest.py
> > +++ b/test/py/tests/test_efi_selftest.py
> > @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
> >      if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key'=
]):
> >          raise Exception('Failures occurred during the EFI selftest')
> >      u_boot_console.restart_uboot()
> > +
> > +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> > +@pytest.mark.buildconfigspec('cmd_dm')
> > +def test_efi_selftest_count_netdevices(u_boot_console):
> > +    """Test the EFI net device driver
> > +
> > +    u_boot_console -- U-Boot console
> > +
> > +    This function counts the number of ETH_UCLASS probed udevices
> > +    calls the EFI net device selftest to check that the EFI driver
> > +    sees the same.
> > +    """
> > +    u_boot_console.restart_uboot()
>=20
> We should avoid restarting U-Boot in a test unless there is a strong
> need. It makes things a lot slower!

Yes, if we can not reboot here that would be good.

> > +    response =3D u_boot_console.run_command('dm tree')
> > +    lines =3D response.splitlines()[2:]
> > +    ethernet_count =3D sum(1 for line in lines if line.strip().startsw=
ith('ethernet') and '[ + ]' in line)
>=20
> This test should be written in C, e.g:
>=20
> struct udevice *dev;
> int count;
> uclass_foreach_dev(dev, UCLASS_ETH)
>     if (device_active(dev))
>          count++;
>=20
> > +
> > +    u_boot_console.run_command(cmd=3D'setenv efi_selftest netdevices')
> > +    u_boot_console.run_command('bootefi selftest', wait_for_prompt=3DF=
alse)
> > +    if u_boot_console.p.expect([f'Detected {ethernet_count} active EFI=
 net devices']):
> > +        raise Exception('Failures occurred during the EFI selftest')
>=20
> Again, this should be written in C and use run_command().

No, if these are written in python already, we can leave them in python.
C is bad for strings.

--=20
Tom

--sY4mXXApPiUN8aeC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSVT0ACgkQFHw5/5Y0
tyy5lQwAqXKRH0u+QJ/XI77R64dX4J2IzP9LEWP8MxwkzSwguXhzCXxU8H3fQxQU
2XEap0mWnOulFHRSMm3vjHA5CeD92glSR2GUWkT8c0C8RDLL4a8Ug8V1u/t+m3fx
IOWS/pQ4yBvwfq8sZcmyd0x6RUN6/vx5ERsN3Ii8OCVXYXJ7mjqtaEkP5VZLmkme
3WbQzYCOla+TDkdSA8+pPCbA/VzwBDZ6q4KzXfn5KzrVKVdhR+cVF8mnuoN3XrsJ
MgnYRJpjV6Fl8sOGyiQV0Q73IHvjmobWZgkPD58/cAQzqT3rOYTG9W0AiQKD7CNz
Pbb3SmsPjDRqZbV7v4w6Dzt/5Lbm5XGR6E2z/oJvwNN282xFCvC2LvvtEe0hlfys
TwT3WeqNVG6biH9hLALcAhqkVEUyPs0y1y12aqWRew461aM1l+RvZMcSdJHqxV6m
LykM8J6AjIO5m0EzVWXxO389oT6F1nSMu1Gn7jRYyA11fO7Df7TjGTJKAbzI0VIH
o3T2dWO0
=tTTa
-----END PGP SIGNATURE-----

--sY4mXXApPiUN8aeC--
