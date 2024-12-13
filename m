Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F56E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 03:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E0580141;
	Fri, 13 Dec 2024 04:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OBoMV3QN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F378018E; Fri, 13 Dec 2024 04:38:47 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1448C80085
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so2243148a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 19:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734061124; x=1734665924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9wQy+4DGCVnjFnG81cHuCzAdorGZpFO7FjgIOdEPA/A=;
 b=OBoMV3QNFTXTitEVaZTjxg1+4INCrwIXMXfeKJ+dr8NmJWj/Bq1QpnCKYSEmcLXLH1
 i6boTYE8/8CdkbUyuvVvQqRhSvuq+70SGXzKtBI1sPcfd1dPsFcoMq4XS4Rtu8ckV73P
 zy95cHUf4diLMGqxmrApdDT42BnupRANNU28Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734061124; x=1734665924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9wQy+4DGCVnjFnG81cHuCzAdorGZpFO7FjgIOdEPA/A=;
 b=iKk5zwV85SS+tQgmnheCTZMXRX9GzWnjufGAnavzkN0eiggRPhbjHVyDzXFOY2H5Ej
 oZ6elavnunCLNlkcHvAvyrzV/68xxCEdku+Aij97fgAimugrnctGzFv6eT7xk8r5Xl1u
 rxfAze+9W2ZPSI2NkqQCOJpv4tR/dYXSZziPFG9cblM5FQkMHfCcGEEpQ3LCrTsVLvFf
 qxJ4LD4INAjCtBPewj2qPohe/o92agTSOIWt+xSpk3hPoObrC9aU/r54/7G5ysM/s3rd
 CngMVxAlYNtyYSTFltnk0MxojZx5hfzjAldfSD4Wb36S4v+H220y2tAKRWGV929AGtBq
 W7EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT49D5T2OMzto6jBJqoTXQkZemKpp3NISlFp69f7VWrR9UbC4VMr4j2e5VPgVQl5Y+d3iWB2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwuNtLsrf4k8bqri0EQWFinGzDOadRByW4KERIRittFjKS7IXkS
 JJlrjiZA1YrqiziIcSTp9kJBWh82q4GR/mRqgTL8fGizPpYzLSpRQ1jPM956yDPxgY0ETiakBxI
 f+bmY62Jn523KoXYa4SBs3IXo5VS1LXObYObjdJL5FH5sCxo=
X-Gm-Gg: ASbGncsg1Yj5tkmAxXHnMWLZcmjzyPmsLWoDizlcXRCzA8KUEh4JMyF3yjnL1Ge1pRh
 +14hfQLDUAnI1W+7QxFGSfwjLdm9dNAModxzctVc=
X-Google-Smtp-Source: AGHT+IHwenmezynZ2rVh5UPOkUlhJ8pKRpL8vj6PU9J6cwOSs1sKw5Hwo7wm+FrAlaIUKUlGIZHM+11KQOyRBoRUZo0=
X-Received: by 2002:a17:907:3d86:b0:aa6:8a1b:8b77 with SMTP id
 a640c23a62f3a-aab7793eb22mr101257666b.22.1734061124493; Thu, 12 Dec 2024
 19:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20241212151142.1562825-1-trini@konsulko.com>
 <Z1sQpA6eTeh9lbys@hera> <20241212170210.GG1505244@bill-the-cat>
 <CAC_iWjKexG6TDn8OGvyVrwUVNjDbCpCptpwtXkW1-E9hFs2Ksg@mail.gmail.com>
 <20241212172745.GH1505244@bill-the-cat>
 <CAC_iWjJb=nXTf0PvzmZsocD9VX77SZiRTSpTwZY-HuSucw9fEQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJb=nXTf0PvzmZsocD9VX77SZiRTSpTwZY-HuSucw9fEQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 20:38:32 -0700
Message-ID: <CAFLszTi+kx+U-xCEBJZpJD+W8LLtJHjKYaacNmLmHsCqeYQtZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 12 Dec 2024 at 10:29, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 19:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 07:08:34PM +0200, Ilias Apalodimas wrote:
> > > On Thu, 12 Dec 2024 at 19:02, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Dec 12, 2024 at 06:34:44PM +0200, Ilias Apalodimas wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, Dec 12, 2024 at 09:11:41AM -0600, Tom Rini wrote:
> > > > > > Introduce an option to control if we expect that a prior stage has
> > > > > > created a bloblist already and thus it is safe to scan the address. We
> > > > > > need to have this be configurable because we do not (and cannot) know if
> > > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > > > > > on-chip memory and so it may or may not be safe to read from this
> > > > > > address this early.
> > > > >
> > > > > Yes this patch makes instead of making the OF_SEPARATE implicitly take
> > > > > priority
> > > > >
> > > > > >
> > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > ---
> > > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > > >  lib/fdtdec.c   | 11 +++--------
> > > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > > > index e8d89bf6eb9d..e8febad0f212 100644
> > > > > > --- a/common/Kconfig
> > > > > > +++ b/common/Kconfig
> > > > > > @@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
> > > > > >       is set up in the first part of U-Boot to run (TPL, SPL or U-Boot
> > > > > >       proper), and this sane bloblist is used for subsequent phases.
> > > > > >
> > > > > > +config BLOBLIST_PRIOR_STAGE
> > > > > > +   bool "Bloblist was created in a stage prior to U-Boot"
> > > > > > +   default y
> > > > > > +   depends on BLOBLIST_FIXED
> > > > > > +   help
> > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created
> > > > > > +     before U-Boot is started.
> > > > > > +
> > > > > >  config BLOBLIST_SIZE_RELOC
> > > > > >     hex "Size of bloblist after relocation"
> > > > > >     default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> > > > > > @@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
> > > > > >
> > > > > >  endchoice
> > > > > >
> > > > > > +config SPL_BLOBLIST_PRIOR_STAGE
> > > > > > +   bool "Bloblist was created in a stage prior to SPL"
> > > > > > +   default y
> > > > > > +   depends on SPL_BLOBLIST_FIXED
> > > > > > +   help
> > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> > > > > > +     U-Boot SPL is started.
> > > > > > +
> > > > > >  endif # SPL_BLOBLIST
> > > > > >
> > > > > >  if TPL_BLOBLIST
> > > > > > @@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
> > > > > >
> > > > > >  endchoice
> > > > > >
> > > > > > +config TPL_BLOBLIST_PRIOR_STAGE
> > > > > > +   bool "Bloblist was created in a stage prior to TPL"
> > > > > > +   default y
> > > > > > +   depends on TPL_BLOBLIST_FIXED
> > > > > > +   help
> > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> > > > > > +     U-Boot TPL is started.
> > > > > > +
> > > > > >  endif # TPL_BLOBLIST
> > > > > >
> > > > > >  if VPL_BLOBLIST
> > > > > > @@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
> > > > > >
> > > > > >  endchoice
> > > > > >
> > > > > > +config VPL_BLOBLIST_PRIOR_STAGE
> > > > > > +   bool "Bloblist was created in a stage prior to VPL"
> > > > > > +   default y
> > > > > > +   depends on VPL_BLOBLIST_FIXED
> > > > > > +   help
> > > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> > > > > > +     U-Boot VPL is started.
> > > > > > +
> > > > > >  endif # VPL_BLOBLIST
> > > > > >
> > > > > >  endmenu
> > > > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > > > index b06559880296..29bddab4150c 100644
> > > > > > --- a/lib/fdtdec.c
> > > > > > +++ b/lib/fdtdec.c
> > > > > > @@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
> > > > > >     int ret = -ENOENT;
> > > > > >
> > > > > >     /*
> > > > > > -    * If allowing a bloblist, check that first. There was discussion about
> > > > > > -    * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > > > > > -    *
> > > > > > -    * The necessary test is whether the previous phase passed a bloblist,
> > > > > > -    * not whether this phase creates one.
> > > > > > +    * Only scan for a bloblist and then if that bloblist contains a device
> > > > > > +    * tree if we have been configured to expect one.
> > > > > >      */
> > > > > > -   if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > > > > -       (xpl_prev_phase() != PHASE_TPL ||
> > > > > > -        !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > > > > +   if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {
> > > > >
> > > > > Without wider context I am not sure but if that check can fold in
> > > > > bloblist_maybe_init() and return -X if the config isn't enabled, it's going
> > > > > to be easier to read
> > > >
> > > > Hmm. We'd have:
> > > >         if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> > > >             !(ret = bloblist_maybe_init()) {
> > > >                 /* We have a bloblist, see if it has FDT */
> > >
> > > I mean move the check inside bloblist_maybe_init()
> >
> > As we talked about on IRC, no, because the "maybe" in that function
> > means "find or create". So the expected usage here is that we have
> > platforms that create the bloblist in SPL (post DRAM init) and use that
> > with the HANDOFF mechanism to pass information to full U-Boot.
> >
>
> Yes thanks
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

I am struggling to see how this is different from the patch I sent a year ago

https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.221671-1-sjg@chromium.org/

Is it just a rebase and a rename?

Regards,
Simon
