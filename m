Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BFAEB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 19:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C8C866DA;
	Mon, 14 Aug 2023 21:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="We03Cja/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4205F866DC; Mon, 14 Aug 2023 21:14:03 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3D7807F9
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 21:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d299ed34bacso8117805276.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692040440; x=1692645240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CufDOaVsFFYN1gaMbSE/QXGzzn9Y7N78d6Utv1ryzi0=;
 b=We03Cja/xJTZlkFxJNdp9JQDqzPGBHZoS2/FcNgv7B31BQQAoJIDMQx4Ls+dAbOdxL
 6SonzUZ4yf35PXKbW2UcEjvf12OpLcNBCnIibbLY6d7EwFG7SOb3myURq0q2N0UrO3/j
 t2UoUbS0BSPpSjHmE74YoKOc55hbY9K0wwfS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692040440; x=1692645240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CufDOaVsFFYN1gaMbSE/QXGzzn9Y7N78d6Utv1ryzi0=;
 b=CZqU3eL2yCpm1poE7ZxATS25Fki9kcu4asfeh3YAqLIkbaLbpGu01qUfXLnVe6agwE
 EUjHss+3Uhx9Xy+aVAkhiagYibnn3FT0DCe29deEpV+JFZMV+LwbsrQIJQJSkfatv0l+
 L5sGGN8+10SBaPSyWQVqcndVHfcrtLkY/3fYjL5d4GyWimwe9sdlrmz6XfCqQ/zbU0ds
 j3wjejmgXt8vFwLsHX61QEoDfSv0devlxAoJzI0oRTkNSN1hhGwZ+I2sP+tbRzYH9C5N
 RY1Ap8EjQa1pfUrQge3aVi85VRG23KjYWBDpfsWwxViN6W3eBEux843BKU0ElQvyPPNn
 Qwmw==
X-Gm-Message-State: AOJu0YwRiy4EnNw8PXJ0R2UlR5E6yGP1TwSoN0JxnBN/+dt1l1bTg3OT
 fIJnxVOPost0kZ98d+OEtXP/gA==
X-Google-Smtp-Source: AGHT+IGrwa87IDquravpXRSHbPt4RfLGkPJgx461YsQOJg9+GbE8BKYXGry5fJlOiCqbnJWxP24rtQ==
X-Received: by 2002:a25:b31b:0:b0:d61:44f9:5d1e with SMTP id
 l27-20020a25b31b000000b00d6144f95d1emr17331166ybj.12.1692040439762; 
 Mon, 14 Aug 2023 12:13:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 a81-20020a254d54000000b00d0069942a3esm2582860ybb.43.2023.08.14.12.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 12:13:59 -0700 (PDT)
Date: Mon, 14 Aug 2023 15:13:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [RFC PATCH 1/4] scripts/Makefile.lib: Collate all dtsi files for
 inclusion
Message-ID: <20230814191357.GF3630934@bill-the-cat>
References: <20230814090309.1548310-1-sughosh.ganu@linaro.org>
 <20230814090309.1548310-2-sughosh.ganu@linaro.org>
 <20230814150425.GW3630934@bill-the-cat>
 <CADg8p95CFpBK+5C6th6D0w4guTsjdR1bGavGEb61kVsqyxyQSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="krQE4TKUqlV2/cxX"
Content-Disposition: inline
In-Reply-To: <CADg8p95CFpBK+5C6th6D0w4guTsjdR1bGavGEb61kVsqyxyQSw@mail.gmail.com>
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


--krQE4TKUqlV2/cxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 12:12:57AM +0530, Sughosh Ganu wrote:
> hi Tom,
>=20
> On Mon, 14 Aug 2023 at 20:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Aug 14, 2023 at 02:33:06PM +0530, Sughosh Ganu wrote:
> >
> > > At the time of building a device-tree file, all the *u-boot.dtsi files
> > > are looked for, in a particular order, and the first file found is
> > > included. Then, the list of files specified in the
> > > CONFIG_DEVICE_TREE_INCLUDES symbol are included.
> > >
> > > Combine these files that are to be included into a variable, and then
> > > include all these files in one go.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  scripts/Makefile.lib | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index f5ab7af0f4..f41b16781d 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -179,10 +179,13 @@ ifdef DEVICE_TREE_DEBUG
> > >  u_boot_dtsi_options_debug =3D $(warning $(u_boot_dtsi_options_raw))
> > >  endif
> > >
> > > -# We use the first match
> > > -u_boot_dtsi =3D $(strip $(u_boot_dtsi_options_debug) \
> > > +# We use the first match to be included
> > > +include_files =3D $(strip $(u_boot_dtsi_options_debug) \
> > >       $(notdir $(firstword $(u_boot_dtsi_options))))
> > >
> > > +# The CONFIG_DEVICE_TREE_INCLUDES also need to be included
> > > +include_files +=3D $(CONFIG_DEVICE_TREE_INCLUDES)
> >
> > This is what I wanted, logic-wise, but I think include_files is too
> > vague.
>=20
> Okay. How about dtsi_include_list, or dtsi_list? If not, can you
> suggest a name which you think would be apt. Thanks.

dtsi_include_list sounds good.

--=20
Tom

--krQE4TKUqlV2/cxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTafPIACgkQFHw5/5Y0
tyzSbQv/YJWAIiv60rFFGT9lM7hLFG7it8Al+jQkcS+MlTyDPNGEOyhU5GSbeJft
6hGDoMBZ/AhASQ33v6fJBiyB/+19u4GBOo3vhE8aNcol3fzKBaD+HFlw6z57tAaI
XwtFTr7dIbcXrbDKwAtu+Th5u7f66wieGskz1PbKhA5JbBC8K6l/RAHJK6/PxXHJ
anaj7mBi3e+ubFBcmsMujRtm6kIJHSR6lvrgRtaAVrOSRb7UxS57Z4lbDfJmXeA3
v3OmxjRLaqws2giJH8NBDWQ4sdfSXCW1W+p3rBil/uKYZAyklfChzATYsBo2qQGb
pTEZYCfLXAzQezMwxbC8Rqp3uDcNoJT+yfzM8E2QigLSng7dysk5Y4mBYr2e/oGN
EhQV8HMS/dsbryYe8tudvlhNErKQB/f63F7U64Vm8F6lIiin3bp9FEn3Accw67lK
WAXhL8o/+2RvyvjumzNy21MW1XfkqW5oKZ/TYUWm+FPsucwMp5qJO9K8d+1Obz7C
vTzgmg+f
=erGG
-----END PGP SIGNATURE-----

--krQE4TKUqlV2/cxX--
