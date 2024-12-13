Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34975E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5676D8012C;
	Fri, 13 Dec 2024 15:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nJp4OZ2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 706C180137; Fri, 13 Dec 2024 15:28:51 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C7D80104
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6edb82f85so223696285a.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734100127; x=1734704927; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1QlKkb7/jg+2EMw+IPiUQKIa5FHGBR/1x+phwjwG4Yk=;
 b=nJp4OZ2qEalBm42apr6kjx4DNax03emIcrBFSgr2u8jAyCu+KxxqF/WHyZ0i8WC8J7
 lwD4/mxdjVobWCSo2pC8MKeXM+E6uKADu0as4qqFk59/wnXP10k/TYQP996ayIoLf71p
 L1M2Mywb7lZwv2T7hXBEKFVshDmXJDRSKdcpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100127; x=1734704927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QlKkb7/jg+2EMw+IPiUQKIa5FHGBR/1x+phwjwG4Yk=;
 b=rguxD6GDfuizqAOFpR7aKRt8N5eEHvsZIY4sz5bqzP8Mp/bF+JpvClEROIdfZHT/IW
 XkUxztX27+elFjB35MDJFWbQ3qqM74qVQxjH/pN8PWO08Io2MvGLT3HM5ZpGy/htUKUy
 h6D/pDxaQcFOKaEXs8mwZTDtwqzUVPvTQv7zTUvT3XoBfSk7COAqwbFiBfVAP/8r8XZy
 LorIdBB+tx7IWMRKhSzGGqI8w8VEOcRWVtYNuDZUN8LHwqj/fbuK8vEb4UTWggNTQPHx
 5yQKdBx9ZRYkSl5x+usnDory83c6Qkvx0Z/GST7U6uTKikEQ4mfeOJ0P/dGFv7dChknF
 EDLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyavHiQUkdynbSFVyGqP61F4lqFw0Q8aChRoyN7Wv+pGjQTwIcuDmTG0aAAGXI7FM50FGVpVA=@lists.denx.de
X-Gm-Message-State: AOJu0YxiF1T7j8XIg4+/q6uRwpD9U5g3bqSyNB3p+saNh64jCHKgKotU
 rJsarOE8ZnduzG7GAhVQ9GGPta3Ee1++IjB15sTWT8DeBWY1JhuyuV3xrzxp1g4aCSjabO9w5W3
 7GlU=
X-Gm-Gg: ASbGncvFjEUgj0azIMXUhCyW1386wtxT9GwRMsAVqbt7+0U/SVZMt9gDhSMbEscSsFP
 IHCmQyZw1jNV53bM5ibE7ZxSefzQZ9bCx6RF5+WqJ98EcBCryNjMud4SCJfedjgaBpmZCXEDE3F
 itm/pZP71I3iz4uyIoSb2l1NrOO+8nAz2Bsy8Ww+xQufRKF5ekU+viUwq67Ku2VDbMgQRhakbjw
 CyBxdD3P0fm4q6b4lYENdTwFHYe81lhZQIKlSU0LLZkJuiQ0/a8X2uW
X-Google-Smtp-Source: AGHT+IHsNgjDCHpU08ZNDBCuoMuuM6iGfuviN5qO4qjWykqa/iTOcnTCokx4NgaG4ZyALyyijk+sLw==
X-Received: by 2002:a05:622a:580f:b0:467:6fa1:9e2a with SMTP id
 d75a77b69052e-467a57fb30cmr54148901cf.40.1734100127310; 
 Fri, 13 Dec 2024 06:28:47 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46761e8c79bsm57507691cf.49.2024.12.13.06.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:28:46 -0800 (PST)
Date: Fri, 13 Dec 2024 08:28:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
Message-ID: <20241213142843.GT1505244@bill-the-cat>
References: <20241212151142.1562825-1-trini@konsulko.com>
 <Z1sQpA6eTeh9lbys@hera> <20241212170210.GG1505244@bill-the-cat>
 <CAC_iWjKexG6TDn8OGvyVrwUVNjDbCpCptpwtXkW1-E9hFs2Ksg@mail.gmail.com>
 <20241212172745.GH1505244@bill-the-cat>
 <CAC_iWjJb=nXTf0PvzmZsocD9VX77SZiRTSpTwZY-HuSucw9fEQ@mail.gmail.com>
 <CAFLszTi+kx+U-xCEBJZpJD+W8LLtJHjKYaacNmLmHsCqeYQtZw@mail.gmail.com>
 <20241213140338.GR1505244@bill-the-cat>
 <CAFLszThj0trbN4wyCcVge18eYe8Qbw0Xt6CzUt4MmF+Smm-=1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0dOdDaUsM8OoUu6J"
Content-Disposition: inline
In-Reply-To: <CAFLszThj0trbN4wyCcVge18eYe8Qbw0Xt6CzUt4MmF+Smm-=1A@mail.gmail.com>
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


--0dOdDaUsM8OoUu6J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 07:15:09AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 13 Dec 2024 at 07:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 08:38:32PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 12 Dec 2024 at 10:29, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Thu, 12 Dec 2024 at 19:27, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Dec 12, 2024 at 07:08:34PM +0200, Ilias Apalodimas wrote:
> > > > > > On Thu, 12 Dec 2024 at 19:02, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Dec 12, 2024 at 06:34:44PM +0200, Ilias Apalodimas wr=
ote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, Dec 12, 2024 at 09:11:41AM -0600, Tom Rini wrote:
> > > > > > > > > Introduce an option to control if we expect that a prior =
stage has
> > > > > > > > > created a bloblist already and thus it is safe to scan th=
e address. We
> > > > > > > > > need to have this be configurable because we do not (and =
cannot) know if
> > > > > > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or=
 some special
> > > > > > > > > on-chip memory and so it may or may not be safe to read f=
rom this
> > > > > > > > > address this early.
> > > > > > > >
> > > > > > > > Yes this patch makes instead of making the OF_SEPARATE impl=
icitly take
> > > > > > > > priority
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > ---
> > > > > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > > > > ---
> > > > > > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > > > > > >  lib/fdtdec.c   | 11 +++--------
> > > > > > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > > > > > > index e8d89bf6eb9d..e8febad0f212 100644
> > > > > > > > > --- a/common/Kconfig
> > > > > > > > > +++ b/common/Kconfig
> > > > > > > > > @@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
> > > > > > > > >       is set up in the first part of U-Boot to run (TPL, =
SPL or U-Boot
> > > > > > > > >       proper), and this sane bloblist is used for subsequ=
ent phases.
> > > > > > > > >
> > > > > > > > > +config BLOBLIST_PRIOR_STAGE
> > > > > > > > > +   bool "Bloblist was created in a stage prior to U-Boot"
> > > > > > > > > +   default y
> > > > > > > > > +   depends on BLOBLIST_FIXED
> > > > > > > > > +   help
> > > > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR=
 was created
> > > > > > > > > +     before U-Boot is started.
> > > > > > > > > +
> > > > > > > > >  config BLOBLIST_SIZE_RELOC
> > > > > > > > >     hex "Size of bloblist after relocation"
> > > > > > > > >     default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_A=
LLOC
> > > > > > > > > @@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
> > > > > > > > >
> > > > > > > > >  endchoice
> > > > > > > > >
> > > > > > > > > +config SPL_BLOBLIST_PRIOR_STAGE
> > > > > > > > > +   bool "Bloblist was created in a stage prior to SPL"
> > > > > > > > > +   default y
> > > > > > > > > +   depends on SPL_BLOBLIST_FIXED
> > > > > > > > > +   help
> > > > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR=
 was created before
> > > > > > > > > +     U-Boot SPL is started.
> > > > > > > > > +
> > > > > > > > >  endif # SPL_BLOBLIST
> > > > > > > > >
> > > > > > > > >  if TPL_BLOBLIST
> > > > > > > > > @@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
> > > > > > > > >
> > > > > > > > >  endchoice
> > > > > > > > >
> > > > > > > > > +config TPL_BLOBLIST_PRIOR_STAGE
> > > > > > > > > +   bool "Bloblist was created in a stage prior to TPL"
> > > > > > > > > +   default y
> > > > > > > > > +   depends on TPL_BLOBLIST_FIXED
> > > > > > > > > +   help
> > > > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR=
 was created before
> > > > > > > > > +     U-Boot TPL is started.
> > > > > > > > > +
> > > > > > > > >  endif # TPL_BLOBLIST
> > > > > > > > >
> > > > > > > > >  if VPL_BLOBLIST
> > > > > > > > > @@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
> > > > > > > > >
> > > > > > > > >  endchoice
> > > > > > > > >
> > > > > > > > > +config VPL_BLOBLIST_PRIOR_STAGE
> > > > > > > > > +   bool "Bloblist was created in a stage prior to VPL"
> > > > > > > > > +   default y
> > > > > > > > > +   depends on VPL_BLOBLIST_FIXED
> > > > > > > > > +   help
> > > > > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR=
 was created before
> > > > > > > > > +     U-Boot VPL is started.
> > > > > > > > > +
> > > > > > > > >  endif # VPL_BLOBLIST
> > > > > > > > >
> > > > > > > > >  endmenu
> > > > > > > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > > > > > > index b06559880296..29bddab4150c 100644
> > > > > > > > > --- a/lib/fdtdec.c
> > > > > > > > > +++ b/lib/fdtdec.c
> > > > > > > > > @@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
> > > > > > > > >     int ret =3D -ENOENT;
> > > > > > > > >
> > > > > > > > >     /*
> > > > > > > > > -    * If allowing a bloblist, check that first. There wa=
s discussion about
> > > > > > > > > -    * adding an OF_BLOBLIST Kconfig, but this was reject=
ed.
> > > > > > > > > -    *
> > > > > > > > > -    * The necessary test is whether the previous phase p=
assed a bloblist,
> > > > > > > > > -    * not whether this phase creates one.
> > > > > > > > > +    * Only scan for a bloblist and then if that bloblist=
 contains a device
> > > > > > > > > +    * tree if we have been configured to expect one.
> > > > > > > > >      */
> > > > > > > > > -   if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > > > > > > > -       (xpl_prev_phase() !=3D PHASE_TPL ||
> > > > > > > > > -        !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > > > > > > > +   if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {
> > > > > > > >
> > > > > > > > Without wider context I am not sure but if that check can f=
old in
> > > > > > > > bloblist_maybe_init() and return -X if the config isn't ena=
bled, it's going
> > > > > > > > to be easier to read
> > > > > > >
> > > > > > > Hmm. We'd have:
> > > > > > >         if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> > > > > > >             !(ret =3D bloblist_maybe_init()) {
> > > > > > >                 /* We have a bloblist, see if it has FDT */
> > > > > >
> > > > > > I mean move the check inside bloblist_maybe_init()
> > > > >
> > > > > As we talked about on IRC, no, because the "maybe" in that functi=
on
> > > > > means "find or create". So the expected usage here is that we have
> > > > > platforms that create the bloblist in SPL (post DRAM init) and us=
e that
> > > > > with the HANDOFF mechanism to pass information to full U-Boot.
> > > > >
> > > >
> > > > Yes thanks
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >
> > > I am struggling to see how this is different from the patch I sent a =
year ago
> > >
> > > https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.22167=
1-1-sjg@chromium.org/
> > >
> > > Is it just a rebase and a rename?
> >
> > Well, no. I came up with this after debugging the failure on Bob / Kevin
> > via Gitlab. This in fact allows for the device tree to NOT come from the
> > bloblist.
>=20
> Yes that was the point of my patch, to allow me to disable OF_BLOBLIST

The entire reason that you needed that was never ever explained or
someone would have told you to move the bloblist to IRAM instead of DDR.
Instead we went round and round about something else.

> > The biggest problem with the "OF_BLOBLIST" thread from last
> > year is that your explanation of the problem doesn't match the problem
> > you have.
>=20
> At this point I am worried you might be one of those people who is never =
wrong.

If so, I'll be sure to continue to enjoy your company.

> > What's really tragically funny now is that Jonas' add TPL to Bob/Kevin
> > and init DRAM there means that we don't need this series for that
> > platform and only Coral is still doing the likely ill-advised thing of
> > saying the bloblist exists in DRAM without ensuring that DRAM will have
> > been initialized already.
>=20
> At least someone is enjoying all this. The whole thing is a bad memory
> and makes me sick to think of it.

I mean in the Shakespeareian sense. None of us are enjoying it.

--=20
Tom

--0dOdDaUsM8OoUu6J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdcRJgACgkQFHw5/5Y0
tyxjnQv+Pt08J8RsY1us4uMCIQKQTYK3gIPkM9sMskavH/PMcmJYEyhmOnHu+/vJ
q2NDxlvDq01j+FTlQ0DwBx4yykvLj+yBrCZxT05vjrsVv8lHiWCvL8j70AKrR/q/
Y4fCN7AW2dyDSwwp4p/LcUiXqqHgA6iw8vUO8G3nkjkIkfrtP2o25rZ7ksJaRDsn
fzd3AOR2ju/4kqCdRaS4Zdfl3ChicG2FbDK2ZQrlscCK5uUqAkavYYWsFTFNptJI
jViUF7dXxba2LdrVKsjTTaEcMbf47r9nY6dFJnuNWj1o8qwifbi2nPBirzl8S19u
zOAIFo9wsqwnQ16ky7/xaE6uBSxp9evyBfF4j4hX3ns7f8s48ZzIPi2v8BAiQK1Y
OVV9b4/cNkApekbgd01ZaZU2duHnORrTyG1UdyMhbwCdTCMu0Q2UaNHCjxaeGvHR
T+pRHH6vc25J2PYcVIgqAU2LntvBR07eZe+3fckatO4mttERh2okZi8NGtVFq2AM
BXw93dEr
=bbaf
-----END PGP SIGNATURE-----

--0dOdDaUsM8OoUu6J--
