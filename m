Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA73C25B7F
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 21:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FF386A02;
	Wed, 16 Aug 2023 23:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jozy5lSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE9286863; Wed, 16 Aug 2023 23:26:56 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61AC86A18
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 23:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58c5aecea4eso22500547b3.3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692221212; x=1692826012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mEWIBwBIhSMndo3kryYZe/yHqcKMTrtrU6XXMEt9l4k=;
 b=Jozy5lSRgVfCcmJv/tW/ltHDhSQCZNfViABQTRo1zw3WNo0cHvIBBEZXdARQOloyn7
 9yOZE6qBmFrvOxEgZIvxStd0LQ0KcaKqpp7g7/tUqYbMx8MQbuKnw2eOnH2Spyrw4sN/
 BUqBwyHTvr473QqlOc/S2rbXAt/YtBOn2SrW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692221212; x=1692826012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEWIBwBIhSMndo3kryYZe/yHqcKMTrtrU6XXMEt9l4k=;
 b=X58t9qLW9/OKBM1pjVnUtU3jaf4ewKOqZPXKkVLEltTJmEE5F8+p4Lf+FCUtUjx5Za
 NSQWQP4WB7WG8dT6HIr38AEqYZEnYGe+NxPaPhszWpTKUXZdbHKhBmVYe2boXf+CwCQH
 2tfM6g6OUJdCsWuhiEfu0Avp9rMFQNvzn4cNRBeunMxAjHiPMW4LQDbU21E9sdCuVAF9
 8YQTZN2yG+P6mqvb8ikruicGDkq3OD6+NSAfNk6AMLayq4Q1ZI+hkKmJrO0z+IqZU/Tu
 5pOgcdJXfA45oXB6g/QsR5DHNbCiuDc/YlCRxehjcUHdRisSOyu4Etzyj+iAc88V0/gi
 C1gQ==
X-Gm-Message-State: AOJu0YyoQz40drY842n/H3efH00/kNKF1gykL3WQd5i8OAW8ZHxC8RWK
 KliEgqyslH8Y9WffBfSooxY97A==
X-Google-Smtp-Source: AGHT+IFDay6qQA5QqFi5MWXP8qc5JiehqdbjL03jqL+WlwQhilX57bX5Biq4JIHZHG4Wn2hvyMS74w==
X-Received: by 2002:a81:a015:0:b0:589:a3ce:5c79 with SMTP id
 x21-20020a81a015000000b00589a3ce5c79mr3044535ywg.15.1692221212529; 
 Wed, 16 Aug 2023 14:26:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-83d6-b858-ec94-88d9.res6.spectrum.com.
 [2603:6081:7b00:6400:83d6:b858:ec94:88d9])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a0dcc10000000b00577139f85dfsm317666ywd.22.2023.08.16.14.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 14:26:52 -0700 (PDT)
Date: Wed, 16 Aug 2023 17:26:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
Message-ID: <20230816212650.GA1515023@bill-the-cat>
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
 <CAPnjgZ0U7x1FUDNBztecDUFdYDp=3j4kkY0RdWGzPoZ-9WU-Zg@mail.gmail.com>
 <CADg8p96k4S67og6REPt5vF9TruYP+hK+1HcDU_XiauvsF4wXjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZuOMIt7u1XcYRku4"
Content-Disposition: inline
In-Reply-To: <CADg8p96k4S67og6REPt5vF9TruYP+hK+1HcDU_XiauvsF4wXjg@mail.gmail.com>
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


--ZuOMIt7u1XcYRku4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 09:58:42AM +0530, Sughosh Ganu wrote:
> hi Simon,
>=20
> On Wed, 16 Aug 2023 at 00:09, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Tue, 15 Aug 2023 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > > The EFI capsule authentication logic in u-boot expects the public key
> > > in the form of an EFI Signature List(ESL) to be provided as part of
> > > the platform's dtb. Currently, the embedding of the ESL file into the
> > > dtb needs to be done manually.
> > >
> > > Add a target for generating a dtsi file which contains the signature
> > > node with the ESL file included as a property under the signature
> > > node. Include the dtsi file in the dtb. This brings the embedding of
> > > the ESL in the dtb into the U-Boot build flow.
> > >
> > > The path to the ESL file is specified through the
> > > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since RFC series:
> > > * Remove the default value of the config symbol.
> > > * s/include_files/dtsi_include_list
> > > * Add all the dtsi files being included as dependency for the dtb
> > >   target.
> > >
> > >  lib/efi_loader/Kconfig             |  8 ++++++++
> > >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> > >  scripts/Makefile.lib               | 18 +++++++++++++++++-
> > >  3 files changed, 36 insertions(+), 1 deletion(-)
> > >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 9989e3f384..d20aaab6db 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
> > >           Select the max capsule index value used for capsule report
> > >           variables. This value is used to create CapsuleMax variable.
> > >
> > > +config EFI_CAPSULE_ESL_FILE
> > > +       string "Path to the EFI Signature List File"
> >
> > Do we need this, or could we name it as we do with the .env file? It
> > seems confusing to have to set this for each board - it might be
> > better to have it in a defined location.
>=20
> The reason I put this is because I thought this gave the user the
> flexibility to provide the location and name of the ESL. But I suppose
> that the board directory would be a good location to expect this file.
> Then this file can have a name like capsule_pub_key,esl. Tom, what are
> your thoughts on this?

I feel like an automatic name we can guess isn't likely how this will be
used in the real world, so we should leave this as configurable.

--=20
Tom

--ZuOMIt7u1XcYRku4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTdPxcACgkQFHw5/5Y0
tyxJAQv/RARRcBfTnOBbNvyDeQMyp0yjxxJRaDPodNs11OveS3UATWpGE1G+K3YV
8Fy5dZvbwsCqwAu2uQetHwF23byvvcA6TwTOlbnj1ZPz7t6M8wL+HSo3tBuVDKJV
blGM1TDglW9XrzoOONF72fwnLo5z2Rqib4dJjiuBsOQK98yoxKX6j4YJ6w/DobQh
b7QAYbzE47TV7FCSckkeCDRZDMafTUdp8RYchwQwJkFmQi4zvWQnsh/o7cxeaq7j
UJ/1sjLF7aIi5a0DaGC729ngJYy+cI1LHbtsCLhtj8Ya6ozYf/UnY5Rhnm+F+5CJ
l01LXC6P56vUcI7vN/Cd3ez0Sc0oapY+I7jMrY2p3OTQSYmtmwg8cJeRIrOzUgvN
z/w5P9moHSC0mwkyrOzIZouL6Pjw/8AQKayn7rgLv9/XtL045EF8idSNnZet0HRM
qOQ/n9IYQC9OZX+a/w93TAwfmpWrI1/OHt4Ixx2Vz+vdBorYzR5mXEmP53+zXpO0
6Zgo212c
=37Sn
-----END PGP SIGNATURE-----

--ZuOMIt7u1XcYRku4--
