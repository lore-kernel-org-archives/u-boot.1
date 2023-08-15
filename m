Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F582C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 20:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D23869A1;
	Tue, 15 Aug 2023 22:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T8AZGl4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B09869A1; Tue, 15 Aug 2023 22:24:20 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53607869A0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 22:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58c4f61ca12so18706917b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 13:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692131056; x=1692735856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bwp4AKRFWEkiaGNVyZfN6PnCgAGLeV159qkHDAifCUE=;
 b=T8AZGl4vfkWd7oYeTH2TGcB6660lgyTODvd3wg+ep7juH27zqs8v5xB1NPETFSI6Rm
 aIN6HTHkLftKYc2KJA62dX3gJpjClwoIBepixElkQWHenp1498waEkk8060x/YCyrT46
 D2mYept5KwGDRPQanDJU+YVTKmDNKGaX3koO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131056; x=1692735856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bwp4AKRFWEkiaGNVyZfN6PnCgAGLeV159qkHDAifCUE=;
 b=jpJcc4a40hnn0KDktxUF9cWxiHSdufLMFdvwHaS0Yhqy85TbypksrOlIwkNISGYLAF
 pjiUNumg0Gr4kRVtMs9lgXI3dU32UYWVdH/+C6SmeT+0fWDSgY2878D2101So38cwBhO
 pLXMckI4CDfFoKPM6Pxd61bAwvNjmrdMav9J5Rn8lzeuuVveI5qEo9xeCcsMy/Jsw1RO
 G9t08YsgCvI43nUKUmKaoO+nLwkI7sWprSEkVbncfLbJPgl1bHAKMb6sWzvJAz2HL9Ws
 wFfZOYlGjTjHSVL5PkHzRbyMl8zF8t9J805eQMilSXW4PJjretRDB4x2cS9uOwXIy+It
 EErw==
X-Gm-Message-State: AOJu0YxtTOnmlwM3WfDanITlLwX4r82uRMGrCMtu3aTQUzIaZeRsdCL6
 9dTXy/nI9VY8/7oCEv3q9vs1+w==
X-Google-Smtp-Source: AGHT+IF+aAztWqrGRs8baYebCeJW5bqIuQSJqoH/axRktS2cJHzsDsziqIK1V9SR3uGPlDbWm5TxMw==
X-Received: by 2002:a0d:e843:0:b0:561:cb45:d7de with SMTP id
 r64-20020a0de843000000b00561cb45d7demr14624113ywe.31.1692131056062; 
 Tue, 15 Aug 2023 13:24:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 r69-20020a0de848000000b00589a5bbeb43sm3588451ywe.117.2023.08.15.13.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:24:15 -0700 (PDT)
Date: Tue, 15 Aug 2023 16:24:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] buildman: Allow more results while building
Message-ID: <20230815202414.GF3630934@bill-the-cat>
References: <20230803185957.1769543-1-sjg@chromium.org>
 <20230815144234.GJ3630934@bill-the-cat>
 <CAPnjgZ0C3Qpauto980cmPZoBkem_OVUOzusxRfRgDkJQeVOgJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lTuN9L40HONkb21L"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0C3Qpauto980cmPZoBkem_OVUOzusxRfRgDkJQeVOgJA@mail.gmail.com>
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


--lTuN9L40HONkb21L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 12:39:37PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 15 Aug 2023 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 03, 2023 at 12:59:55PM -0600, Simon Glass wrote:
> >
> > > The -v option enables display of build results while building, instea=
d of
> > > needing to do a separate summary step later (or in another terminal).=
 But
> > > this resets the build results after each commit, so that all errors a=
re
> > > reported fresh, without trying to diff them against previous errors
> > > already shown.
> > >
> > > Drop this reset, as an experiment, so see if this is useful.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  tools/buildman/builder.py | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> > > index ecbd368c47a..5ee2b5959b2 100644
> > > --- a/tools/buildman/builder.py
> > > +++ b/tools/buildman/builder.py
> > > @@ -536,7 +536,6 @@ class Builder:
> > >              if self._verbose:
> > >                  terminal.print_clear()
> > >                  boards_selected =3D {target : result.brd}
> > > -                self.reset_result_summary(boards_selected)
> > >                  self.produce_result_summary(result.commit_upto, self=
=2Ecommits,
> > >                                            boards_selected)
> > >          else:
> >
> > Nope, this doesn't change any of the output I see in how I usually do my
> > world builds.
>=20
> For me it allows using -S and -B during the build phase, and seeing some =
output.
>=20
> However, the patch is not correct...it is just a concept. I should
> have marked it as RFC.

Well, take a look at
https://gist.github.com/trini/2e88e94743821586ef742a936c45c389 and if
you can think of things that'll make the output between lines 53 and 458
clearer / smaller that's what I'm looking for.

--=20
Tom

--lTuN9L40HONkb21L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTb3u4ACgkQFHw5/5Y0
tyzLiAv+ME6D7rxu4RPRGMzSO5VQb8B9b585dURb77332W2ZcuyE0ee5Z8v65c4K
zNRtJJfC+WXcCqvDNE++HWXFdS/HAs+fpWCBnm1BJ4K+bJzbZps68MpMQs8f10tl
0i3MzMHsoaoSpnvuo2GlBVFxiD8okmBneHMyntDZK1uk2sP7plkEljeWEpScCVUE
WLFIjZOJlzM5hq8MuqLzZwc8ksnho8NyC8YUZA7ewRPH4k2nOpHCdpqVQV+zUGGW
BMu1PXaaipb8O0ZOvP9pFiJbWIPlmLM1xHET9QpMUlPrvHOUewnYuwIJbP0tPMdG
lFCQEv+HmjmlMZBIgZkZAsEoivaA7mcNwmX4mEo7OYnDuRzIyl3tfzhqBuVm88zB
3E0wfM+YqU6naxZ69bfmH1dYseqPb33cAzj22sZtzTI88/5aOsKra+ZSh6ireOsi
KEHxSejgfAA0AoOkfcZ3/L/83PNzJ3ZuiTU8qaraXrwLua0yZr8M7Gm4pbs1mSJf
59+Do97k
=PWMt
-----END PGP SIGNATURE-----

--lTuN9L40HONkb21L--
