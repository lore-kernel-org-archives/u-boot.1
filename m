Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C8FC531DF
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 02:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C62788B58;
	Wed, 21 Aug 2024 04:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BZR2+Asf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DA888A64; Wed, 21 Aug 2024 04:11:26 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7903788B78
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 04:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6bf6721aae5so30497446d6.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724206282; x=1724811082; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKJF4UV63Tfe8OGUwguNGv8M3YgmrSny7m5FuJcPrcU=;
 b=BZR2+Asfq0jGuQ1fs/TnULSV8lM97FMBB+fvXjQDSZAcHsFxfddIdS7PkDw08Ey7tq
 3wTpfx+Jm5NN1qjksutTiHkytZBtyY6GM8CZh/lxAEGVhwQ7xWG+PH7QBTw3yFkSBPSw
 FCBSKuKg9Fp4whcl1sIwMEp7EUDyeFICC+wtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724206282; x=1724811082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKJF4UV63Tfe8OGUwguNGv8M3YgmrSny7m5FuJcPrcU=;
 b=ULvAU789WWxwY+3pn4kgF25iqr24qjisvxLc/Mb1isCopCCB3X5//akqsg27HpfwpH
 Pkmjh2pfNVt+BkkoxDE1LtHXCTIj0ALmDUb5Q/i4ga6MvQfF8n8enkVLAv55fn5hTbHk
 iiPulRyY550urhsrM+2Q1SAV/3/cgB7nwKSb2fSbbSZhPl7pi38p6Fm8WDeMM+ULOvg7
 dsgXYEkHsMpcY6ORWDJ7/d9F4UEEWwGdtXo/iCPlsfnFAruHDLsWIaZkdBMUhMWynuF9
 S4d050jVOWIlVw4zCgKGZjCbecrb9EBUEp0zjuSFnvthjZGD3YveZFhF7G9g3uE8pL4M
 HAtw==
X-Gm-Message-State: AOJu0YxNOTULEFsVbpXmbWijvaE/QXDdVHjrPXZpKxwSc2dbOx+0hbJz
 N5y9WPV00s3r6Ef3vxgtckRhfmo3FsB6ns/X1GQzOUmfRGd2vknHjCMLtufQtdY5qaH19MWak6b
 uaS1+X92TxH2M7/gWvm9plWu+cUt9oQfrwvDs
X-Google-Smtp-Source: AGHT+IGvdaSTt7BxYSnAOUgx2u/gU3D2S4+pxrCGttxpJTW9pQqq3EvbaPZbiexU4ibK6vaKPoxjQKLfVZSM+crQSOw=
X-Received: by 2002:a05:6214:33c2:b0:6bf:7985:f46d with SMTP id
 6a1803df08f44-6c155d55e4fmr14040196d6.12.1724206282385; Tue, 20 Aug 2024
 19:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-33-sughosh.ganu@linaro.org>
 <CAFLszTigDtzrLWzVfrVmq_Uet_GRoQWq7YVQcgerpk8XAT8BvQ@mail.gmail.com>
 <CADg8p97bznk=rdyq9_vFSbobockFXwzwdbJ2JsEvDzW6ZTreWA@mail.gmail.com>
In-Reply-To: <CADg8p97bznk=rdyq9_vFSbobockFXwzwdbJ2JsEvDzW6ZTreWA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Aug 2024 20:11:11 -0600
Message-ID: <CAFLszTgs9kur8AU8_CpHSvZ2FZCqXAptH_2rtgb62aWvpkQKNQ@mail.gmail.com>
Subject: Re: [PATCH v2 32/32] lmb: add logic to print lmb flag strings
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Tue, 20 Aug 2024 at 04:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 16 Aug 2024 at 02:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 14 Aug 2024 at 05:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Instead of printing the LMB flags as numerical values, print them as
> > > strings. This makes it easier to understand what flags are associated
> > > with the lmb region. Also make corresponding changes to the bdinfo
> > > command's test code.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1: New patch
> > >
> > >  lib/lmb.c         | 18 ++++++++++++++++--
> > >  test/cmd/bdinfo.c |  4 ++--
> > >  2 files changed, 18 insertions(+), 4 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > But see below
> >
> > >
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index 37d2a72951..5c5b3e9bb5 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
> > >
> > >  static struct lmb lmb;
> > >
> > > +static void print_region_flags(enum lmb_flags flags)
> > > +{
> > > +       uint64_t bitpos;
> > > +       const char *flag_str[] = { "LMB_NONE", "LMB_NOMAP", "LMB_NOOVERWRITE" };
> >
> > As mentioned, LMB_NONE shouldn't be a flag. For the other two, how
> > about "no-map" and "no-overwrite"?
>
> So, you don't want any value to be shown with LMB_NONE? I guess
> LMB_NONE is indicative of the fact that the region does not have any
> attributes, no?

That's my understanding, yes. This could be a later cleanup I suppose,
but since you are adding flags, you may as well remove this one.

[..]

Regards,
Simon
