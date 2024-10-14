Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C538D18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A14D6891CF;
	Mon, 14 Oct 2024 23:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jNMedAHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9E987DC7; Mon, 14 Oct 2024 23:48:50 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB958885D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7afc847094fso372057585a.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728942527; x=1729547327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/l7uQllsFYuHdCDsNs+8Z406NsbJbCcPtcp0bwBU1vg=;
 b=jNMedAHB2/OUNSn0oHdGabgYgvQMKhlUOVyf7KREfLDx4MLxV+mjNoT9bRJiYOHQGl
 6Ul8yjZ6gqafrQ9PHOlOqBp1kJPIVDVgw70JtYSRyKvQKlFqoWzrGPD+xRzWfy5ahTQb
 MLoY2o5RveIXY5lPLC/5Hpc4c04Z6EO7Icynk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942527; x=1729547327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/l7uQllsFYuHdCDsNs+8Z406NsbJbCcPtcp0bwBU1vg=;
 b=JUlj2OLELoV6Bo12s76J+qS+WBuMNAb0kjE63TpsG8YaUWOn5C7y2C3znHVlOYb3T9
 3FGC7jlTZV8yyVpBAzHdwm+jZdD+NwtuHgYoOEFUqPFXYAFwLT9SDl3ruziMuf6IQny5
 5nNSOkVTXsxL4Jm0YdESkFuvLbcCjqnRQdk+TjJ8fN3dv2z/cDcqRYiLkGG1x4mRNrX+
 GkS532Zo9npRctokxT+x8hAttRaplbbr5ygCElyLBjsxslEMOLXJsEwrJmQx2qO6xS4l
 O8kHO3hGNAUviqxPSN+x+su4S6ERUM+8kBxopkhsCe1FsLg2QLBPCOb0/7W/6S+AD6hY
 KeZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd7HQOVeVfwd5uUbIg9i2olIf9Jud/Vg6P7JOCWBrbM+/scmpqRVxG1nLuAFw799vqJHPT4Jk=@lists.denx.de
X-Gm-Message-State: AOJu0YxG3QsFAcFKbciTao3RVRfDNPWTObJPPYQ/tGuxRmJVZKzaJlwA
 ZS7BCW3x/skqTHnW1v+yCN0MXEGNJNcmW1ucP4Kx6/2QNk7WftjpqifZzTBPD7A=
X-Google-Smtp-Source: AGHT+IGXCHeZX/0E0B9mZWiVSZcRnpFc9onQlTenRmo05oQjQiYJTcdZzyi7n4LFPL+aPAz3FQGYsQ==
X-Received: by 2002:a05:620a:179f:b0:7af:ceb5:e730 with SMTP id
 af79cd13be357-7b11a35f61emr2204667585a.15.1728942527118; 
 Mon, 14 Oct 2024 14:48:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11498a1ccsm457826385a.135.2024.10.14.14.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:48:46 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:48:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
Message-ID: <20241014214841.GD53053@bill-the-cat>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
 <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
 <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
 <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v53cbCptu6w4lE5y"
Content-Disposition: inline
In-Reply-To: <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
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


--v53cbCptu6w4lE5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:35:12PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass wrote:
> > > > > > > Hi Sughosh,
> > > > > > >
> > > > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@lina=
ro.org> wrote:
> > > > > > > >
> > > > > > > > Use the LMB API's for allocating and freeing up memory. Wit=
h this, the
> > > > > > > > LMB module becomes the common backend for managing non U-Bo=
ot image
> > > > > > > > memory that might be requested by other modules.
> > > > > > > >
> > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > ---
> > > > > > > > Changes since V2:
> > > > > > > > * Use map_to_sysmem() to get the user-visible address to be=
 shared
> > > > > > > >   with the lmb API's for sandbox.
> > > > > > > >
> > > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------=
------------
> > > > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > > > >
> > > > > > > When efi_init_obj() is called, it should be able to add the l=
mb memory
> > > > > > > to its own tables. There is no need to worry about lmb after =
that,
> >
> > Saying "There is no need to worry about lmb after that" is not true.
> > Invoking the "env" command for example will have efi_init_obj() be
> > called, among the others that Heinrich listed. And to possibly refute
> > a next issue, that is intentional so that efivars, the standard
> > mechanism used by an OS to talk with the firmware can be available to
> > U-Boot, if I recall things correctly.
> >
> > My understanding of your assumption is that you believe that once the
> > EFI_LOADER subsystem has started work on a payload we're just a few call
> > chains away from the OS being started and runtime services aside U-Boot
> > being done.
> >
> > My understanding of how things are used today is that this is incorrect.
>=20
> What I am getting at is that once we have called that function we know
> we are booting an EFI app or using an EFI feature in preparation for
> doing so. Let's start there. Is that correct?

No, it is not correct.

--=20
Tom

--v53cbCptu6w4lE5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNkbkACgkQFHw5/5Y0
tyz54wv/dgBeysDvvmwYnq/A/wpvOA3YZCBPbv5QUfQU99e4Oh2hm2GrJ/FlB5nH
D/Qf5o3HjbN63/fHZOC5qz0j0DXMM7slOwJ7z4/DkfxN61ZPZeM90opSeV89JJ6E
FDtc4DxivA3VuTD0cAArgwO169c1aFG6ICoFkc9f4rsGB9ekuXKVkz2KrYvL7qEu
zqXSH8LlgQO9sscmqn2U075w8tVbcGPrlSz3XlLaQx5ep19gHUno37ZIuNzYu1ar
RNWhov2j8HP2W/LrKz3r//fBqmO95+wOxmQFCus7CU7vSg8B5WwA6sm4bb/Ct74A
3QS4pFMQd3LGK0dC0ok6qrbfrRp5KvwP3MH+eNKSZcN6ZZJV4epW2iUwZsVIq+XO
JvuO2pY4GN4tzo1Lih4Atav2KI023pQTj+rudwLvpkZD+ukdmU+sxOc4pcBc2gkA
L4SyhGKcDbdtn3Kf6+aVDx3C1i5GuvUfEC3TRbwcH0Ug/N2hd954AwX4eFSyyeTj
pW/JNF1M
=xxvg
-----END PGP SIGNATURE-----

--v53cbCptu6w4lE5y--
