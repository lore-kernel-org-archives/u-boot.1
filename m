Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173DCD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D84588DA0;
	Fri, 18 Oct 2024 18:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OeoVsvAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285B688D9F; Fri, 18 Oct 2024 18:33:11 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6AAF8657F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbd005d0f9so15442426d6.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729269188; x=1729873988; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5UQzTwmR515dzIon5srrptXRBXu8cGU2jTWwfFTaHW4=;
 b=OeoVsvAoS8eIJ8RW7ew+d4tH0dyxkX5opv0HVm79JGaodz2oiWu3VARPab6zloxRLm
 6tFeL+J44bVjsWAls1OIBkEoOuQBPZizTKiYj2/cLgpSIosezqPWxcmAI3e63r5DAMo7
 YfYzAHymORUtEsPBJGHLF/AslRASmx466yKIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729269188; x=1729873988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UQzTwmR515dzIon5srrptXRBXu8cGU2jTWwfFTaHW4=;
 b=WYKZPgaytHf87ZhKowQ9qRqfB0iAoTu8FZ7hIR3R2wXye3ZRnEwZVgyzfeSQji85WN
 dcIK/AJbt1vFm9axrU99rRTbkX0Jsnp47peVZnz30LYg2JFpPj9HWk/fd5S8sfpAhtxF
 BVDX9VSV0C26aakdsbUodtcjRFtulWPP1PCHybliIaMTfGddCAKBDDkRctQpjX38D/PV
 fzFp2uT89ckImDYeOnHHHSgenCtNBLP1xq6iaeqrE/MxeUASB+Jj5+aS1EUZy60J1Bxl
 gEKsGDlJ/DfWj7LTeL5ECvUKclQRyKMIc6hX64SQ9KmSR244PWIc/A8BN76xenstsgHC
 YPqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCJ2TOGA/EuVfIJPr6uV8VrqmNmDae+Jk0Ft9wIG9yeYSMG6yUt6MwWUfP4DN8kinYykQ4MEY=@lists.denx.de
X-Gm-Message-State: AOJu0YwWBKbOZVMxdSqeRTK+vvjlHHWOPjxEGQKbSNjse7IfyiQl/oBr
 1L6yaMnf1NQEG927kZMaz3GGew3zUFwcINC6nuXhIo2VvD5ljoClByTn4pVFSAY=
X-Google-Smtp-Source: AGHT+IHE5wpofebEZyJ018bx2Q87TRfDH3FVksopzo1LJxnwypLP5B61VXcAQ2fTHDU8bt7MSn14sQ==
X-Received: by 2002:a05:6214:3d9f:b0:6cb:fa1e:5202 with SMTP id
 6a1803df08f44-6cde14bdf0bmr37317886d6.4.1729269187823; 
 Fri, 18 Oct 2024 09:33:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde12301c4sm8351906d6.88.2024.10.18.09.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 09:33:06 -0700 (PDT)
Date: Fri, 18 Oct 2024 10:33:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
Message-ID: <20241018163303.GZ4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
 <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
 <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dnX2JHlyy7d/g8Sk"
Content-Disposition: inline
In-Reply-To: <CAFLszTjF-kg5E+sV+CkFjStmS2YyJiPa59zOWWZxd2J5yOwftA@mail.gmail.com>
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


--dnX2JHlyy7d/g8Sk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 09:01:03AM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Thu, 17 Oct 2024 at 22:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> >
> >
> > Am 18. Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium.org=
>:
> > >We want to keep track of images which are loaded, or those which could
> > >perhaps be loaded. This will make it easier to manage memory allocatio=
n,
> > >as well as permit removal of the EFI set_efi_bootdev() hack.
>=20
> I'll change this 'hack' to 'feature'.
>=20
> >
> > Please, keep in mind that files can be loaded manually, e.g. via the dh=
cp, the wget, and the loady commands. These are outside bootflows.
>=20
> Yes, this series is only going to help if bootstd is used. For ad-hoc
> use, EFI will need to rely on the above feature, at least until
> someone can think of another solution.

Perhaps I need to try and be clearer here than I might have been in the
past. The consensus among off the shelf free software operating systems
is "just give me an EFI interface". This simplifies things on their end
if regardless of architecture it's the same interface. This means that
in U-Boot we need to treat EFI as one of the primary interfaces. Not a
novelty. Not a "some people might use". It is a frequent and commonly
used feature.

--=20
Tom

--dnX2JHlyy7d/g8Sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSjbcACgkQFHw5/5Y0
tyyBGAv/QhxNGFfiRcdYfEJ1pmqWCKHWnIlodn17cMgAnssrauU3e7bkJ6wwJkqx
eBYW2WDKUlO+x4HsFq00BnJvlSDvFpLQ0ZwYOEh6s7uWiT9DINbi+X1XS5BT8zL0
QZckWWwTZgCqZAKvjQGVgEBgR1BoqPIhilBnDP3ZyLvblyJqSBmMlVPHAQTXU43D
WKcqwoo4LjEVc1w7JLcxupa7wKjPFQStDLIvt3/GCxOc3tZsHqe65dxW9z7vrbZB
5LSWqJ4Vsc2bdf7KYti3Zftqr0NLrXuqAf3+TjuPe+JdfUJrg5p+iPq4L2uwDgbU
vgeAI2dY7Zzqm83VP8e0VhpBAyimB95GSzZQBXqHjWdyEnXkuEo5+hmhud2ZLkbv
/zQ36hheozIrL25bfomh3NGRWoEnxIhQ784EaP+GIYRCtnTU/AzlwTKdPMsvDomq
8eegVsWxZ6uyghOVtfuBgSR7GYkPKMiCI5mWUDnvuIs2PafEWb16MPd7f9nq/uG5
OBuPo47c
=IdcD
-----END PGP SIGNATURE-----

--dnX2JHlyy7d/g8Sk--
