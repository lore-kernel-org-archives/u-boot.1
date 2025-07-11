Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8052C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12536826AA;
	Fri, 11 Jul 2025 17:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ilHhIYV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286C68277D; Fri, 11 Jul 2025 17:48:46 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0217482063
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7387f21daadso1735770a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752248923; x=1752853723; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P6uCc1jTAnMZVvq/ziwT6aY8y/6QWmIR+PyXMxyz+FE=;
 b=ilHhIYV2N1ZqhDxNnTXw7Lq8wNAOnMdgj8ZUBGKUvoQeRXBxnG8reAfeW2xlXE9//t
 cFa7QOkOzYWqr17cuf6tVccWYTMW/NocEBy1Ikq8IkUn8SPZNhYUB/1GpSC5dCwe8H2A
 CBgRISw/Zvb6pSUbAL1b+oYUQBad/0qO9F9Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752248923; x=1752853723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6uCc1jTAnMZVvq/ziwT6aY8y/6QWmIR+PyXMxyz+FE=;
 b=rnGEXjoobhqMVZv51GKnQqEhLwX2uDQnyT3tqvFk3HGJ4dg9T5oLX8JW9RRIbvwxQD
 rOkAi4SQneBuwN0Omo59XO4HQQQfnT2pkx54Mf84SUUpi+fB5NRk7lHNRD38JxsKszc8
 1U2R+fOa3pO9esPXcFu86XLRUxCxGBF9jo0l++fEKm8cHOz+WQASYhgjZCWJYTHf726s
 tfl+1OP8eq3K8Qx9t464fJpMdFaJnB37EqvRQfpPWG1ZlmJ6NhojIV/yWO656MXqctSD
 3vahPeDyrx1eRmCtER3N3pp9DiuKehN7OnVh432ro4KhFsrDuvymOUbp9t6PACVMW+g5
 n+2g==
X-Gm-Message-State: AOJu0YwH+qK/ok49GOFPvsKx4o1XQ+z2oEgVZjileBJs15EibNYbYfaU
 LXb8pRwVL8b3k7eXKUiJrINMokYnCRCbNmvdCHjAYlHqNIPsS1RJ5AIkHZwN7O4bAec=
X-Gm-Gg: ASbGncsBR1Ub/hUsgxR+AMN7K4gzVodNGn1pFHvQMDbSlwbXwuaK7VWApyOlcX7OaEm
 fNFSmFZJ4qIcWlH/hcvFbZYIXDy/lkmHl1/+FbKuFV0UrB8hoC5tgk9Th+ed8rKP4XU3YsQQWql
 aTjQ2QqSL33q4xePArHFki39aYxKNtUUjWgcnOSrM8LUO365Eb+xSKAYAbxmiKZoM3+IvGA79f5
 rp2VAtrUxU6wS+9x62z+yoUfOdujmjZOYvXbrMD9EwOEUaJau2HQ5nAniKIiZTNis+d6PlPEr2b
 lyQ2vLNKqG6A6zw0nGdaxLsJ6/rh4EyCm3X3kQq/8nDngKBYcBkJd4/DQWaqEkMcckZ08O0XG/s
 Lli5Hi2pXznd2FAi56vV4LhdFd8imMf//2EiSBe00g0KXcukTf5wwsDX4BZHlCPqHl2M=
X-Google-Smtp-Source: AGHT+IFKMjLppGESY6Kc9OZ6OeBSIVGlq4L4WksVi3vA9v2KFq14cbEi0gohl0SmzAXt5RPVeLJQ6A==
X-Received: by 2002:a05:6808:198f:b0:401:bb42:700c with SMTP id
 5614622812f47-413c4b8aff3mr6176326b6e.19.1752248922636; 
 Fri, 11 Jul 2025 08:48:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613e0406cf6sm392369eaf.1.2025.07.11.08.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:48:42 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:48:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 "Molloy, Philip" <Philip.Molloy@analog.com>
Subject: Re: [PATCH 10/10] MAINTAINERS: Update ADI entries for new boards
Message-ID: <20250711154839.GJ6424@bill-the-cat>
References: <20250602194507.15159-1-malysagreg@gmail.com>
 <20250602194507.15159-11-malysagreg@gmail.com>
 <20250605171248.GB1382132@bill-the-cat>
 <CABdDSeVrA-XyDhEHC6p_vvaQwM+Dh5xE6Ct=+VXjcd0Tq_8_6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PY95QWoLl4yv2HoV"
Content-Disposition: inline
In-Reply-To: <CABdDSeVrA-XyDhEHC6p_vvaQwM+Dh5xE6Ct=+VXjcd0Tq_8_6w@mail.gmail.com>
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


--PY95QWoLl4yv2HoV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 03:14:12PM -0400, Greg Malysa wrote:
> Hi Tom,
>=20
> On Thu, Jun 5, 2025 at 1:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Mon, Jun 02, 2025 at 03:44:48PM -0400, Greg Malysa wrote:
> >
> > > This adds missing maintainers entries for the ADI SC5xx defconfigs.
> > >
> > > Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> > > Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> > > Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> > > Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> > > Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> > > ---
> > >
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index d62dd35a385..cee5f1a9271 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -631,6 +631,7 @@ F:        arch/arm/dts/sc5*
> > >  F:   arch/arm/include/asm/arch-adi/
> > >  F:   arch/arm/mach-sc5xx/
> > >  F:   board/adi/
> > > +F:   configs/sc5*
> > >  F:   doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
> > >  F:   doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
> > >  F:   doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
> >
> > This doesn't also catch the other drivers and so forth added. Perhaps
> > the "N: " regex syntax would be helpful here, to make adding all of
> > those as well easier? Thanks.
>=20
> Thanks for the feedback, I'll review the names again before v2 and
> look for any missed entries. Our names are a bit inconsistent: some
> adi, some adsp, some include sc5xx and some do not. In v2 of this
> series we could rename the defconfigs to adhere to a useful, specific
> naming convention, and then follow up by renaming drivers across
> different subsystems in a separate series so that we can have one N:
> line and catch them all. Do you have any tips on tracking down files
> that are missed? Using scripts/get_maintainer.pl with a list of what I
> think the files are could work but I won't know if I forgot something
> that way :-). Is there a particular way to invoke it that checks all
> files, perhaps, and reports on files that are missing supporters?

Sadly it's a manual process.

--=20
Tom

--PY95QWoLl4yv2HoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxMlcACgkQFHw5/5Y0
tywLMQv/URhi2QSxRFxXWtZJVsmGotcp2PkkD826PexFtnxhYCpMShGTNQhhGEtm
wDS8NjMXhVdyux9qHrMJ0BSh0uqYRPCWneBizTVmO9mP84A+8wX4P4S0pR5k/nto
W/jeN+BLz2yRcmCZkbX6vKxj7RUU7G2gEFiWLzivl79llLB/OLa2FMCh0c2ggm9H
vXJL3W++7QrMmFP+NDskNgsDpStx6nA/QxGOSnedI1/J01dezKNM9hqqUdiRygwa
3VqxvYxEpC2vf1+Y0RfFLnTAxef7as84crE2yrMobCgSerXHtTpNYYOCKMoenJ+X
4cqdF7chRJUPOec2G4rM+dH9A4qB3QILaH3xQQLs2H0n7Q37PvBRZSpwA2DJfsv6
0XCockE7cULBpPT6693ANuHjGupReGP+WUoQE7EcSzkPC8o/cHeinzqWecbMiZDt
vXfajjCUjoqTPzYOEPTQkTCFxJvZ0GNXt4hbIuse6iO2eG39TqzPJymou41yC7Iv
n6Y6hI29
=xE/h
-----END PGP SIGNATURE-----

--PY95QWoLl4yv2HoV--
