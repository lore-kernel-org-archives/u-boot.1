Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E46E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 17:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE66801BF;
	Thu, 12 Dec 2024 18:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AimYxynQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BFE801DA; Thu, 12 Dec 2024 18:29:12 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8722F801B0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 18:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6efe4324f96so7237267b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 09:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734024549; x=1734629349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mK4NiAxbyda/iPFQq0MwJ8ytgEWerOZESjpggO1QKUo=;
 b=AimYxynQkBNEavlzMo/TByeNsRVriFm81lBmXCtBn4UCUBXfw3VPge/ujZ4cnGwQBh
 jFF5P686oQB9kt4U7korXFm7YNYBgKp+6CDv+WBiCyR7jqh6qU8SZgxWQ5vyESwwJCsC
 /yjgvTtvbzGbw5/umLdnLqMjLd8G4M1OnAKwcGeWdAQNtS4sE5+0sUVHl4uX+HTrpBSH
 FWWdTcLDtKjBXntsMJ3GQpkz6y+yrQ3z/Wf3Mre3iyUomByk9DdmhRIL6+9B9xYKIlnN
 yJQP+3aZCY84faWdVSX3ZdS/yAW/vSlrxPzHvkmK5a0jUpzV8ggBnFKZ0wX3cWVNP2+j
 4PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024549; x=1734629349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mK4NiAxbyda/iPFQq0MwJ8ytgEWerOZESjpggO1QKUo=;
 b=lOhFCW2BEuNc7w+BAveR7VL12ytVvlbr7qIBau5IB83xMNgSUQJxHWZ34QwFWhc63+
 CdSB5bhN+ywYR982tvl4IXCFn2PfLWdZSJ5nuikPZCL0UrW0RiK1eTyfuBQBHSAMh2EP
 mIIBRB996DwSxMrqWtZVxktTaYqsrUQMLWxaRhshPAQsHJPhDvjFX2ypIRgdAigX+XTh
 z4qMdlZh/gCUOLtk+3PM+pTJdfYaiKuskmw0vaioeFin8f7Jiq9Z1T6fUuCy2nDhaTda
 hbc1y7gPHY3PjpDJJLYlAD3R7jzGL6mEUD4eUvw7lVaNjnBfTw9UNDqBRFGVrh02y/Ub
 cqCQ==
X-Gm-Message-State: AOJu0Yz8fXVi+qXZuIiLF62RZ/X/FnSZrzwd+353nQ7MNRtCBY0hHNvD
 mhzhIWC4cUpcr7u4yoeW1VnqQgYQFi9VKtr+QY1LVqutd5PTgYFG7M0HzbpW+1KCJZTJaeTfLAN
 w4GYI1ckQF1RtUjynzOLYhrZmH340q0+mi6SYaw==
X-Gm-Gg: ASbGncttofS4QG5699aD8jreT086AWswwZUTTxtpJM+pA0d9BpxvCgB9DFJmS+kAHrW
 Et4ymdYxAuvQQRPjxINKNR8U3aYEAuXr0htZS+A==
X-Google-Smtp-Source: AGHT+IE/pEzdOAEjKbO5eGG5KANbTcXaEL0t92rJ8OH53jywyOju8UABhGEggvNa791r5VAULAgYbSTIfPuvI0RTN2Q=
X-Received: by 2002:a05:690c:6f06:b0:6ee:a81e:6191 with SMTP id
 00721157ae682-6f2752c291emr14433767b3.22.1734024549296; Thu, 12 Dec 2024
 09:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20241212151142.1562825-1-trini@konsulko.com>
 <Z1sQpA6eTeh9lbys@hera> <20241212170210.GG1505244@bill-the-cat>
 <CAC_iWjKexG6TDn8OGvyVrwUVNjDbCpCptpwtXkW1-E9hFs2Ksg@mail.gmail.com>
 <20241212172745.GH1505244@bill-the-cat>
In-Reply-To: <20241212172745.GH1505244@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 19:28:33 +0200
Message-ID: <CAC_iWjJb=nXTf0PvzmZsocD9VX77SZiRTSpTwZY-HuSucw9fEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Thu, 12 Dec 2024 at 19:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 12, 2024 at 07:08:34PM +0200, Ilias Apalodimas wrote:
> > On Thu, 12 Dec 2024 at 19:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Dec 12, 2024 at 06:34:44PM +0200, Ilias Apalodimas wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, Dec 12, 2024 at 09:11:41AM -0600, Tom Rini wrote:
> > > > > Introduce an option to control if we expect that a prior stage has
> > > > > created a bloblist already and thus it is safe to scan the address. We
> > > > > need to have this be configurable because we do not (and cannot) know if
> > > > > the address at CONFIG_BLOBLIST_ADDR is in regular DRAM or some special
> > > > > on-chip memory and so it may or may not be safe to read from this
> > > > > address this early.
> > > >
> > > > Yes this patch makes instead of making the OF_SEPARATE implicitly take
> > > > priority
> > > >
> > > > >
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Cc: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >  common/Kconfig | 32 ++++++++++++++++++++++++++++++++
> > > > >  lib/fdtdec.c   | 11 +++--------
> > > > >  2 files changed, 35 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/common/Kconfig b/common/Kconfig
> > > > > index e8d89bf6eb9d..e8febad0f212 100644
> > > > > --- a/common/Kconfig
> > > > > +++ b/common/Kconfig
> > > > > @@ -1077,6 +1077,14 @@ config BLOBLIST_SIZE
> > > > >       is set up in the first part of U-Boot to run (TPL, SPL or U-Boot
> > > > >       proper), and this sane bloblist is used for subsequent phases.
> > > > >
> > > > > +config BLOBLIST_PRIOR_STAGE
> > > > > +   bool "Bloblist was created in a stage prior to U-Boot"
> > > > > +   default y
> > > > > +   depends on BLOBLIST_FIXED
> > > > > +   help
> > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created
> > > > > +     before U-Boot is started.
> > > > > +
> > > > >  config BLOBLIST_SIZE_RELOC
> > > > >     hex "Size of bloblist after relocation"
> > > > >     default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
> > > > > @@ -1117,6 +1125,14 @@ config SPL_BLOBLIST_ALLOC
> > > > >
> > > > >  endchoice
> > > > >
> > > > > +config SPL_BLOBLIST_PRIOR_STAGE
> > > > > +   bool "Bloblist was created in a stage prior to SPL"
> > > > > +   default y
> > > > > +   depends on SPL_BLOBLIST_FIXED
> > > > > +   help
> > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> > > > > +     U-Boot SPL is started.
> > > > > +
> > > > >  endif # SPL_BLOBLIST
> > > > >
> > > > >  if TPL_BLOBLIST
> > > > > @@ -1146,6 +1162,14 @@ config TPL_BLOBLIST_ALLOC
> > > > >
> > > > >  endchoice
> > > > >
> > > > > +config TPL_BLOBLIST_PRIOR_STAGE
> > > > > +   bool "Bloblist was created in a stage prior to TPL"
> > > > > +   default y
> > > > > +   depends on TPL_BLOBLIST_FIXED
> > > > > +   help
> > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> > > > > +     U-Boot TPL is started.
> > > > > +
> > > > >  endif # TPL_BLOBLIST
> > > > >
> > > > >  if VPL_BLOBLIST
> > > > > @@ -1175,6 +1199,14 @@ config VPL_BLOBLIST_ALLOC
> > > > >
> > > > >  endchoice
> > > > >
> > > > > +config VPL_BLOBLIST_PRIOR_STAGE
> > > > > +   bool "Bloblist was created in a stage prior to VPL"
> > > > > +   default y
> > > > > +   depends on VPL_BLOBLIST_FIXED
> > > > > +   help
> > > > > +     Select this if the bloblist at CONFIG_BLOBLIST_ADDR was created before
> > > > > +     U-Boot VPL is started.
> > > > > +
> > > > >  endif # VPL_BLOBLIST
> > > > >
> > > > >  endmenu
> > > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > > index b06559880296..29bddab4150c 100644
> > > > > --- a/lib/fdtdec.c
> > > > > +++ b/lib/fdtdec.c
> > > > > @@ -1669,15 +1669,10 @@ int fdtdec_setup(void)
> > > > >     int ret = -ENOENT;
> > > > >
> > > > >     /*
> > > > > -    * If allowing a bloblist, check that first. There was discussion about
> > > > > -    * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > > > > -    *
> > > > > -    * The necessary test is whether the previous phase passed a bloblist,
> > > > > -    * not whether this phase creates one.
> > > > > +    * Only scan for a bloblist and then if that bloblist contains a device
> > > > > +    * tree if we have been configured to expect one.
> > > > >      */
> > > > > -   if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > > > > -       (xpl_prev_phase() != PHASE_TPL ||
> > > > > -        !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > > > > +   if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE)) {
> > > >
> > > > Without wider context I am not sure but if that check can fold in
> > > > bloblist_maybe_init() and return -X if the config isn't enabled, it's going
> > > > to be easier to read
> > >
> > > Hmm. We'd have:
> > >         if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> > >             !(ret = bloblist_maybe_init()) {
> > >                 /* We have a bloblist, see if it has FDT */
> >
> > I mean move the check inside bloblist_maybe_init()
>
> As we talked about on IRC, no, because the "maybe" in that function
> means "find or create". So the expected usage here is that we have
> platforms that create the bloblist in SPL (post DRAM init) and use that
> with the HANDOFF mechanism to pass information to full U-Boot.
>

Yes thanks
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> --
> Tom
