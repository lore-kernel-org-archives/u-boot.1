Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB759C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 07:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B60884CA;
	Wed, 21 Aug 2024 09:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y5T1l9b2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3549F88B2A; Wed, 21 Aug 2024 09:48:44 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBFBF884CA
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5bb85e90ad5so4854587a12.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724226521; x=1724831321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fdeDWvHrSqr5rjphEi5VlkslloOZNgRLiZvWGb/P+bg=;
 b=Y5T1l9b22oiBqFUI97RBtFuRmrrqCnh8TcFkL+JJdLk1WZfFUbC5lH7PAE4LjloaUl
 GrBx8CoYuCHqiC+qowFoUBOxeJkIAcLwFw2GXRDuGbRlecokSvMKlkEQgzorZfMIzGSU
 seYmyl2k4qnTQF2dsyhuCVJDdL9/9SI/+j/h7eN+NlEHR0slQZN2eZdlqlvKUgUX4YLn
 yqvBbeHUOOD05SciyBt4q0pvV9b6lxKExPBFGI7rGXCWs3nR0vgZQxPgfm7CVC4QINBT
 Fr4euN+2Ty1torxPpi+qi4i0172CccEFlZ4WTst1IZ9KP/o1t5M7RecCv0QmAR+YOFkm
 EHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724226521; x=1724831321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fdeDWvHrSqr5rjphEi5VlkslloOZNgRLiZvWGb/P+bg=;
 b=mt0sLlBTv/Hr8Okp4Py+gVP8c9JhRvWB2fRuEHQMJ3Ydaa9HKAtfeEet6/FRNuwvNL
 KDNixYjdnxfaqC/QteGVbEWj8NZKz7i2rHFontK0OGYzW3iNCFERtqBIBLlaaUKkpcOw
 AQaHRDkmqeKTvBxDx1LpE90kPsp9MDqx+pKS+69o4BTwpmJ19pdeXhsEjPNH+tsnMoB8
 3Foj4KooeqrI1X5KP+X9hQ+dQnvjqxHAj+bq4QxseZdAGBIpN1BYMlWixPF5OCgPeE4h
 og6vV84Bq/Q+LWcoX2o6Wat8+QBBaab+WAoJwrB76NQk/e3RRBbp/zdcPrVnTl207CAv
 UMNg==
X-Gm-Message-State: AOJu0YzmAdOu98BGoadxG0ypZNBoQG/oHAVwuFHf54JaMbYjb3CP8Pr/
 k+zFMh1qbN8CrXITnv9cTTyxYRhhsZETVRnBxE9V2sy6KBrZ4QtGTzGRA3X8e1cYAzDoUB+N0Y7
 +okzgsKlYCZVC6xKKct90ckD0FuDssgyk2oa7cA==
X-Google-Smtp-Source: AGHT+IEUfnzKwpHelO4DTAxf0AafWB9o1E/uTXOhbBctigvOYSmntAcf19sWbsAabuM7mbZPCX1DFNI8sM3wmhJtqlE=
X-Received: by 2002:a05:6402:430c:b0:5bf:c8:774 with SMTP id
 4fb4d7f45d1cf-5bf1f0dab77mr936570a12.15.1724226521065; Wed, 21 Aug 2024
 00:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-33-sughosh.ganu@linaro.org>
 <CAFLszTigDtzrLWzVfrVmq_Uet_GRoQWq7YVQcgerpk8XAT8BvQ@mail.gmail.com>
 <CADg8p97bznk=rdyq9_vFSbobockFXwzwdbJ2JsEvDzW6ZTreWA@mail.gmail.com>
 <CAFLszTgs9kur8AU8_CpHSvZ2FZCqXAptH_2rtgb62aWvpkQKNQ@mail.gmail.com>
In-Reply-To: <CAFLszTgs9kur8AU8_CpHSvZ2FZCqXAptH_2rtgb62aWvpkQKNQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 21 Aug 2024 13:18:29 +0530
Message-ID: <CADg8p94cD7BOHb4H_vy-doRnytqK9zA12mdiHhRvHrGUKEw=SQ@mail.gmail.com>
Subject: Re: [PATCH v2 32/32] lmb: add logic to print lmb flag strings
To: Simon Glass <sjg@chromium.org>
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

On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 20 Aug 2024 at 04:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 16 Aug 2024 at 02:03, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Wed, 14 Aug 2024 at 05:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Instead of printing the LMB flags as numerical values, print them as
> > > > strings. This makes it easier to understand what flags are associated
> > > > with the lmb region. Also make corresponding changes to the bdinfo
> > > > command's test code.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1: New patch
> > > >
> > > >  lib/lmb.c         | 18 ++++++++++++++++--
> > > >  test/cmd/bdinfo.c |  4 ++--
> > > >  2 files changed, 18 insertions(+), 4 deletions(-)
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > But see below
> > >
> > > >
> > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > index 37d2a72951..5c5b3e9bb5 100644
> > > > --- a/lib/lmb.c
> > > > +++ b/lib/lmb.c
> > > > @@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
> > > >
> > > >  static struct lmb lmb;
> > > >
> > > > +static void print_region_flags(enum lmb_flags flags)
> > > > +{
> > > > +       uint64_t bitpos;
> > > > +       const char *flag_str[] = { "LMB_NONE", "LMB_NOMAP", "LMB_NOOVERWRITE" };
> > >
> > > As mentioned, LMB_NONE shouldn't be a flag. For the other two, how
> > > about "no-map" and "no-overwrite"?
> >
> > So, you don't want any value to be shown with LMB_NONE? I guess
> > LMB_NONE is indicative of the fact that the region does not have any
> > attributes, no?
>
> That's my understanding, yes. This could be a later cleanup I suppose,
> but since you are adding flags, you may as well remove this one.

Maybe I am not getting your point. But we have the flags member in the
struct lmb_region, and a region without any flags set will have a
value of 0. And we are calling that LMB_NONE. So, if we consider the
boot_fdt_reserve_region() function, we need to pass a flags argument
to the function. And a value of 0 would mean LMB_NONE. Is it not
instructive to show a value of 0 as LMB_NONE(okay, maybe not in
uppercase), instead of having to just print 0? Not printing anything
is a little confusing imo.

-sughosh

>
> [..]
>
> Regards,
> Simon
