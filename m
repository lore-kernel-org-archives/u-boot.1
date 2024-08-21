Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF462C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA311882BE;
	Wed, 21 Aug 2024 16:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cfrAJDuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F688843A; Wed, 21 Aug 2024 16:37:05 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55151882BE
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a45bso2240954a12.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724251023; x=1724855823; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dxCiKbxuQnm3bl5Yvifj7p4gKFXYn/xQ2jtuJPuBG/o=;
 b=cfrAJDuYMwe1Sg2kYJAqhoKXui9mzYeGkk6vFSQj7xS7X4Jizo6UtaN0Bcp9iAUFns
 CjtYlQMdytN5FaiTg/Arb7LgErhK2I97xuqitaLppvcCTwJNpfxDCJ/JSdKAkTqzqn4G
 EtIWA+pWR5ydylDXMvsd0rImjs6MpjfiqfxRT4SEkJci4ba68yFhjT0x+xCOEpik4ntx
 nkV2j4ul/LWzlBgfcfa5oQmiGJ8XxhziYDugyxqbuopywLoFB28D53OwY2fcsfkx3rhi
 ddJmBlgrCywKkfr4GFItb1+UD2hRbYwQ8nV1HOnKjQvnzL3odowg/0diBiaAZqALOi1V
 /tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724251023; x=1724855823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dxCiKbxuQnm3bl5Yvifj7p4gKFXYn/xQ2jtuJPuBG/o=;
 b=T8d+W36X56PtWg70tv+5/j00iDuha9s7phkmHvGud5A/SoHJ4BDmO0zyURHi0oip5k
 sNa96ZFPenWd6A/kurqEEW1/no0p86Kr98PkjUEbsGWYTZPsm5l5hpcdtnABEeSyKi0W
 HpLNGlMSaPSoRUi73zCawT/51N3T66HWEVFf9wSGNZLWOIM1ZweqdICmnY/0gNYnkvPg
 yH0B1IpcBnSyBRvc9jZtCzohfVNHeD1qhbyXnEHGpDn2pq+0Et7Q+1pxy3SV4eklZpOw
 s3+ML9YmaGle6E9aUyS7KVnQwY0hQmJhf+rpJ0HYGr9qNc8F8JxSDCcfasMSiivqCO6v
 HZ8w==
X-Gm-Message-State: AOJu0YxtOppkz31Ep/TeQlt1WL7pbBHuWneLD/D8ZOSWI5LrLJFZR44f
 eG0oJtgyp3d9B98N2LNo66RAaw9GJ50HkgVtPrWYx/hdzsxi1Ib0Nh52ImUmiEYOHYVStnj9Fse
 W3YMkZ1uvP/Z7/hPFAQ7dhD2CXfbV3WZOsqHwgA==
X-Google-Smtp-Source: AGHT+IE5l/75R5xY1LSIqVLOuzTmLsX2vL9iiPG+fmGzTDooGjCth2ZLupW2L6XbHAzowflJNV2aCRMd5++nnf4DQT0=
X-Received: by 2002:a05:6402:34c7:b0:5be:cdda:1c6b with SMTP id
 4fb4d7f45d1cf-5bf1f290399mr2463219a12.31.1724251022574; Wed, 21 Aug 2024
 07:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-33-sughosh.ganu@linaro.org>
 <CAFLszTigDtzrLWzVfrVmq_Uet_GRoQWq7YVQcgerpk8XAT8BvQ@mail.gmail.com>
 <CADg8p97bznk=rdyq9_vFSbobockFXwzwdbJ2JsEvDzW6ZTreWA@mail.gmail.com>
 <CAFLszTgs9kur8AU8_CpHSvZ2FZCqXAptH_2rtgb62aWvpkQKNQ@mail.gmail.com>
 <CADg8p94cD7BOHb4H_vy-doRnytqK9zA12mdiHhRvHrGUKEw=SQ@mail.gmail.com>
 <CAFLszTgMULKqa7H1ZeD-O3h7Oh3uu50V9wkbnh9N8HdX_ni1Kw@mail.gmail.com>
In-Reply-To: <CAFLszTgMULKqa7H1ZeD-O3h7Oh3uu50V9wkbnh9N8HdX_ni1Kw@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 21 Aug 2024 20:06:50 +0530
Message-ID: <CADg8p95GykgY_N4eZpK2=+ygVyT4oV9OZ-zqif7M6JLR29uzzA@mail.gmail.com>
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

On Wed, 21 Aug 2024 at 19:30, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 21 Aug 2024 at 01:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Tue, 20 Aug 2024 at 04:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 16 Aug 2024 at 02:03, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Wed, 14 Aug 2024 at 05:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > Instead of printing the LMB flags as numerical values, print them as
> > > > > > strings. This makes it easier to understand what flags are associated
> > > > > > with the lmb region. Also make corresponding changes to the bdinfo
> > > > > > command's test code.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since V1: New patch
> > > > > >
> > > > > >  lib/lmb.c         | 18 ++++++++++++++++--
> > > > > >  test/cmd/bdinfo.c |  4 ++--
> > > > > >  2 files changed, 18 insertions(+), 4 deletions(-)
> > > > >
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > But see below
> > > > >
> > > > > >
> > > > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > > > index 37d2a72951..5c5b3e9bb5 100644
> > > > > > --- a/lib/lmb.c
> > > > > > +++ b/lib/lmb.c
> > > > > > @@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
> > > > > >
> > > > > >  static struct lmb lmb;
> > > > > >
> > > > > > +static void print_region_flags(enum lmb_flags flags)
> > > > > > +{
> > > > > > +       uint64_t bitpos;
> > > > > > +       const char *flag_str[] = { "LMB_NONE", "LMB_NOMAP", "LMB_NOOVERWRITE" };
> > > > >
> > > > > As mentioned, LMB_NONE shouldn't be a flag. For the other two, how
> > > > > about "no-map" and "no-overwrite"?
> > > >
> > > > So, you don't want any value to be shown with LMB_NONE? I guess
> > > > LMB_NONE is indicative of the fact that the region does not have any
> > > > attributes, no?
> > >
> > > That's my understanding, yes. This could be a later cleanup I suppose,
> > > but since you are adding flags, you may as well remove this one.
> >
> > Maybe I am not getting your point. But we have the flags member in the
> > struct lmb_region, and a region without any flags set will have a
> > value of 0. And we are calling that LMB_NONE. So, if we consider the
> > boot_fdt_reserve_region() function, we need to pass a flags argument
> > to the function. And a value of 0 would mean LMB_NONE. Is it not
> > instructive to show a value of 0 as LMB_NONE(okay, maybe not in
> > uppercase), instead of having to just print 0? Not printing anything
> > is a little confusing imo.
>
> But then why set LMB_NONE to BIT(0)? That has the value of 1 and
> suggests it is useful in some way.
>
> You could just leave it as zero. I don't see why having no flags is
> confusing, but you can print 'none' if you like.

This is precisely what I am doing in the latest version(3) that I have
sent. Thanks.

-sughosh
