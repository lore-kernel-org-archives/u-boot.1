Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B980E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0150780141;
	Fri, 13 Dec 2024 15:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D7+5yDIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA5F8012C; Fri, 13 Dec 2024 15:03:45 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965D080141
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d888c38841so14278746d6.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734098621; x=1734703421; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qevcis+SjoxBMcKIVegyFyP/SxsB6jil1Haj59ldOmY=;
 b=D7+5yDIRvR3WPtFcl3XEOVqvXqgfGuqDY7rqXuKucE+WMnZGZs573gucYXv8/tO8s5
 3y912qcq06e9canesvP+AIdCjwxFZsmNDAiY6H6EwRWUAILs+D8cvlchrWo0pIl6q7/Y
 CmWXCwHK0VcnzDjy/0E1y+7FZ8f0OPXuA1nS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734098621; x=1734703421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qevcis+SjoxBMcKIVegyFyP/SxsB6jil1Haj59ldOmY=;
 b=B/SyfRZoqj7xfUp64IbKyKude2Bz/baxjo1KeAdJZpYLn512FgEdRhISKHNnEj/uEg
 s4UObySRN08aDDvYyiIk/zi3jIegrwNkuTA26pRkhQ1SCK1MwIhttSeRYHEItr5RzcgH
 cYBOf7V+sNLdqGgKUTmZuNOqisp6n4Hkw0LbFkagrg0bYnxRmv62eBjlqSSzKWZoqlHP
 FdC4dqQGZmLKBM0XjNC7/gfR4NHlKyD6zpsTOHV8pDlyBmyQ2RQ7NUfr7suSPkSAv8KN
 Q6WjxatXBXH16xgWAOF0nxhVWOPxAjecsbXKvKeUcqjOj1+LEqGcUND66mLVwPQUwRoe
 veiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXujeXLo8Bsw3mT7uoFElN2hL10kISc09LQecOPoLshELfgWaV8MljidgYiDEY6Eyw0aTPrKPU=@lists.denx.de
X-Gm-Message-State: AOJu0YzH5xBAwUO8u8sNRXm1RypabPf6LRbzsB0CNdbFwg+aOPD77Yj5
 vkVpsptE84CRzWeepMPjv8RXSJT7rOGFh0XpEJ9O41KBUiAQJOMaI+KNriFyVP+xDgxQHxZAD2c
 5yHw=
X-Gm-Gg: ASbGncsu0xGbEW5dGreeveqfXcMldy27SGXcvYaLmJEMHqWVvcZSKSPnCQEtnzK/obq
 eZn7kcGtWBk14VszJFWnCZupoF8qv2AnYafx+cJwE6lY6QTs6YZmCdxfve74DgtJJhmV/iv1TDE
 da1FUbBUKgqq87z2L5dF37KeMeSLH9htbCCDONM26JH92wCLYtEciuuuvxB7oFv/84BtLNRV4hb
 SrCaX0XB28QCLaBonKV1t560nSkwCz6SV5Y6Y03TWVQi/bqgxUVU7Hu
X-Google-Smtp-Source: AGHT+IFebxTyqtyZRd8eW/zGOk/mkSu2c80YEkKHyYStW1DGRfdG6HefTrLZtG5GIyVSUZiZaNx9yA==
X-Received: by 2002:a05:6214:248e:b0:6d8:ada3:26d3 with SMTP id
 6a1803df08f44-6dc8ca3eafbmr48179396d6.9.1734098621299; 
 Fri, 13 Dec 2024 06:03:41 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dcc42b5df8sm4015556d6.126.2024.12.13.06.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:03:40 -0800 (PST)
Date: Fri, 13 Dec 2024 08:03:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241213140338.GR1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <Z1sQpA6eTeh9lbys@hera> <20241212170210.GG1505244@bill-the-cat>
 <CAC_iWjKexG6TDn8OGvyVrwUVNjDbCpCptpwtXkW1-E9hFs2Ksg@mail.gmail.com>
 <20241212172745.GH1505244@bill-the-cat>
 <CAC_iWjJb=nXTf0PvzmZsocD9VX77SZiRTSpTwZY-HuSucw9fEQ@mail.gmail.com>
 <CAFLszTi+kx+U-xCEBJZpJD+W8LLtJHjKYaacNmLmHsCqeYQtZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dwsSeqL9mRF354wT"
Content-Disposition: inline
In-Reply-To: <CAFLszTi+kx+U-xCEBJZpJD+W8LLtJHjKYaacNmLmHsCqeYQtZw@mail.gmail.com>
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


--dwsSeqL9mRF354wT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 08:38:32PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 12 Dec 2024 at 10:29, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 12 Dec 2024 at 19:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 12, 2024 at 07:08:34PM +0200, Ilias Apalodimas wrote:
> > > > On Thu, 12 Dec 2024 at 19:02, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Dec 12, 2024 at 06:34:44PM +0200, Ilias Apalodimas wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, Dec 12, 2024 at 09:11:41AM -0600, Tom Rini wrote:
> > > > > > > Introduce an option to control if we expect that a prior stag=
e has
> > > > > > > created a bloblist already and thus it is safe to scan the ad=
dress. We
> > > > > > > need to have this be configurable because we do not (and cann=
ot) know if
> > > > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or som=
e special
> > > > > > > on-chip memory and so it may or may not be safe to read from =
this
> > > > > > > address this early.
> > > > > >
> > > > > > Yes this patch makes instead of making the OF_SEPARATE implicit=
ly take
> > > > > > priority
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > ---
> > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > > > >  lib/fdtdec.c   | 11 +++--------
> > > > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > > > > index e8d89bf6eb9d..e8febad0f212 100644
> > > > > > > --- a/common/Kconfig
> > > > > > > +++ b/common/Kconfig
> > > > > > > @@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
> > > > > > >       is set up in the first part of U-Boot to run (TPL, SPL =
or U-Boot
> > > > > > >       proper), and this sane bloblist is used for subsequent =
phases.
> > > > > > >
> > > > > > > +config BLOBLIST_PRIOR_STAGE
> > > > > > > +   bool "Bloblist was created in a stage prior to U-Boot"
> > > > > > > +   default y
> > > > > > > +   depends on BLOBLIST_FIXED
> > > > > > > +   help
> > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was=
 created
> > > > > > > +     before U-Boot is started.
> > > > > > > +
> > > > > > >  config BLOBLIST_SIZE_RELOC
> > > > > > >     hex "Size of bloblist after relocation"
> > > > > > >     default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> > > > > > > @@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
> > > > > > >
> > > > > > >  endchoice
> > > > > > >
> > > > > > > +config SPL_BLOBLIST_PRIOR_STAGE
> > > > > > > +   bool "Bloblist was created in a stage prior to SPL"
> > > > > > > +   default y
> > > > > > > +   depends on SPL_BLOBLIST_FIXED
> > > > > > > +   help
> > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was=
 created before
> > > > > > > +     U-Boot SPL is started.
> > > > > > > +
> > > > > > >  endif # SPL_BLOBLIST
> > > > > > >
> > > > > > >  if TPL_BLOBLIST
> > > > > > > @@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
> > > > > > >
> > > > > > >  endchoice
> > > > > > >
> > > > > > > +config TPL_BLOBLIST_PRIOR_STAGE
> > > > > > > +   bool "Bloblist was created in a stage prior to TPL"
> > > > > > > +   default y
> > > > > > > +   depends on TPL_BLOBLIST_FIXED
> > > > > > > +   help
> > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was=
 created before
> > > > > > > +     U-Boot TPL is started.
> > > > > > > +
> > > > > > >  endif # TPL_BLOBLIST
> > > > > > >
> > > > > > >  if VPL_BLOBLIST
> > > > > > > @@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
> > > > > > >
> > > > > > >  endchoice
> > > > > > >
> > > > > > > +config VPL_BLOBLIST_PRIOR_STAGE
> > > > > > > +   bool "Bloblist was created in a stage prior to VPL"
> > > > > > > +   default y
> > > > > > > +   depends on VPL_BLOBLIST_FIXED
> > > > > > > +   help
> > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was=
 created before
> > > > > > > +     U-Boot VPL is started.
> > > > > > > +
> > > > > > >  endif # VPL_BLOBLIST
> > > > > > >
> > > > > > >  endmenu
> > > > > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > > > > index b06559880296..29bddab4150c 100644
> > > > > > > --- a/lib/fdtdec.c
> > > > > > > +++ b/lib/fdtdec.c
> > > > > > > @@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
> > > > > > >     int ret =3D -ENOENT;
> > > > > > >
> > > > > > >     /*
> > > > > > > -    * If allowing a bloblist, check that first. There was di=
scussion about
> > > > > > > -    * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > > > > > > -    *
> > > > > > > -    * The necessary test is whether the previous phase passe=
d a bloblist,
> > > > > > > -    * not whether this phase creates one.
> > > > > > > +    * Only scan for a bloblist and then if that bloblist con=
tains a device
> > > > > > > +    * tree if we have been configured to expect one.
> > > > > > >      */
> > > > > > > -   if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > > > > > -       (xpl_prev_phase() !=3D PHASE_TPL ||
> > > > > > > -        !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > > > > > +   if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {
> > > > > >
> > > > > > Without wider context I am not sure but if that check can fold =
in
> > > > > > bloblist_maybe_init() and return -X if the config isn't enabled=
, it's going
> > > > > > to be easier to read
> > > > >
> > > > > Hmm. We'd have:
> > > > >         if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> > > > >             !(ret =3D bloblist_maybe_init()) {
> > > > >                 /* We have a bloblist, see if it has FDT */
> > > >
> > > > I mean move the check inside bloblist_maybe_init()
> > >
> > > As we talked about on IRC, no, because the "maybe" in that function
> > > means "find or create". So the expected usage here is that we have
> > > platforms that create the bloblist in SPL (post DRAM init) and use th=
at
> > > with the HANDOFF mechanism to pass information to full U-Boot.
> > >
> >
> > Yes thanks
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>=20
> I am struggling to see how this is different from the patch I sent a year=
 ago
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.221671-1-=
sjg@chromium.org/
>=20
> Is it just a rebase and a rename?

Well, no. I came up with this after debugging the failure on Bob / Kevin
via Gitlab. This in fact allows for the device tree to NOT come from the
bloblist. The biggest problem with the "OF_BLOBLIST" thread from last
year is that your explanation of the problem doesn't match the problem
you have.

What's really tragically funny now is that Jonas' add TPL to Bob/Kevin
and init DRAM there means that we don't need this series for that
platform and only Coral is still doing the likely ill-advised thing of
saying the bloblist exists in DRAM without ensuring that DRAM will have
been initialized already.

--=20
Tom

--dwsSeqL9mRF354wT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdcPrIACgkQFHw5/5Y0
tyyu0wv/fnJCzjrvr2H4zb77UxV0A427z+602x6diFNuyOdCcropxUAiAvKQU801
HdWKGytNITz+81bpLxKnZ9dGRt2Hyaj+XTNZ3eoiQlK9b0wwCL87prRlhwRhc97n
SlfScbfmlNJos2juAAOXp7CLXGQ6gsis01gTZmVg8v5hOU82ZrF82EblwaAEtGLo
hvRNV64WOGpeNDu2ssRxxe1SYA8UgbTJsiK3sv/KciUNOsgq8LLLDqHIaBdvv5PD
77/XUO7iRTQvw/jtf5voiuesC0FreHC1k/KTwGB1EeWY/E3VuD7c8jnN13vh/KxD
Up4TNlDFCN1DYDoHyTDtE/dfBnt2Jo5uEXsqDcuyWFboaY2yyKUq1oxQULw19dwa
/1G0uMEF2F4qFeKK4PbEMRpvr0ieUi8Pe/Ux4R9GqgcfcvdhXbCSPHmiiHnXdxAF
C03GELJ9B57KRfj4OBBVgZ4QOvamkUFlclBJTS1EbDjdgeq+yGO5UoqE5SZJmodJ
oa4sHC/B
=rHzu
-----END PGP SIGNATURE-----

--dwsSeqL9mRF354wT--
