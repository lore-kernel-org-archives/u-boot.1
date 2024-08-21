Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD62C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E54F88DAC;
	Wed, 21 Aug 2024 16:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O6P4dzaI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D06F88A54; Wed, 21 Aug 2024 16:00:04 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F08AE88A54
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6c159150ff4so3373366d6.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248801; x=1724853601; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GE0oFyMlC5IbD4hbGgEmtjT4Q3YUcbE7/hHbqqK2sMc=;
 b=O6P4dzaIySoZ2EoXOArKgKSRZ+rZ2tzbcOsn2wLH+/YY1uxYvtC8owxSSDXHduEQ0l
 Pn/NJcgT5vl72O0cYnKJAHj2uzh79VPl5QaCbKS+VanY/knZJ0orHtkKsPr/zP5OkYNv
 xc8v49wNWGI+FABepTJ3ft8qoy5Vc6H4AU+4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248801; x=1724853601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GE0oFyMlC5IbD4hbGgEmtjT4Q3YUcbE7/hHbqqK2sMc=;
 b=LV0CtvZiO3Rzdh1bYnguOdIlV19R5RZu0/5hfMre7FeGnSN2W9OXvjHQmYVMv5qno6
 Ew+hRuanL3ak093SRSSA5I4W8HEsteonMfJ6D7veiAFzI2+0C9GakgyZrijjn9sMiDux
 GZZWVB4UIlu4+0H14Nngixebu7tm1YcHViata3Nxxalg7PvkLPTmBeOHDdGLx/axrX4L
 DQsl+KPuhYgcg4ofB35nVR6b0kTIpzNus1Qq34oFYKykfdHDgna9CkHhIA+Mjfv+tbHO
 n2AZNlJsgGGRmudpLX1CcyQWglwEZVaiD7WrgYgXiDECyZm6JDaH9OULzbL1TKqiFIEj
 L7lQ==
X-Gm-Message-State: AOJu0YyZDLHeEeQALe4zMTRQfi4O+cQMlP/dcnd5bymZBVRRyOpcbIAK
 izJmYn5hJ3AYDOWBt4PXtyS1gUzJ0L+CSS/czKZE+/+tXVfyM5GCPQg6BZZYYqQyJCpJOcuoOfq
 kNS7aUQ4kHt9XNUhqIo2m9cxLEwO1/Wkpadu9
X-Google-Smtp-Source: AGHT+IGqIY1AxyoGU92J09wb6YM9EHclAdfK+42iPzJ3ThTcARlfS3GElVyqvWzloDpN6uOlokZFHOln8WhMCC9FHLg=
X-Received: by 2002:a05:6214:3c9c:b0:6b7:a6eb:c343 with SMTP id
 6a1803df08f44-6c155e1a07fmr24651986d6.51.1724248800728; Wed, 21 Aug 2024
 07:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-33-sughosh.ganu@linaro.org>
 <CAFLszTigDtzrLWzVfrVmq_Uet_GRoQWq7YVQcgerpk8XAT8BvQ@mail.gmail.com>
 <CADg8p97bznk=rdyq9_vFSbobockFXwzwdbJ2JsEvDzW6ZTreWA@mail.gmail.com>
 <CAFLszTgs9kur8AU8_CpHSvZ2FZCqXAptH_2rtgb62aWvpkQKNQ@mail.gmail.com>
 <CADg8p94cD7BOHb4H_vy-doRnytqK9zA12mdiHhRvHrGUKEw=SQ@mail.gmail.com>
In-Reply-To: <CADg8p94cD7BOHb4H_vy-doRnytqK9zA12mdiHhRvHrGUKEw=SQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:49 -0600
Message-ID: <CAFLszTgMULKqa7H1ZeD-O3h7Oh3uu50V9wkbnh9N8HdX_ni1Kw@mail.gmail.com>
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

On Wed, 21 Aug 2024 at 01:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Tue, 20 Aug 2024 at 04:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 16 Aug 2024 at 02:03, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 14 Aug 2024 at 05:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Instead of printing the LMB flags as numerical values, print them as
> > > > > strings. This makes it easier to understand what flags are associated
> > > > > with the lmb region. Also make corresponding changes to the bdinfo
> > > > > command's test code.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V1: New patch
> > > > >
> > > > >  lib/lmb.c         | 18 ++++++++++++++++--
> > > > >  test/cmd/bdinfo.c |  4 ++--
> > > > >  2 files changed, 18 insertions(+), 4 deletions(-)
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > But see below
> > > >
> > > > >
> > > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > > index 37d2a72951..5c5b3e9bb5 100644
> > > > > --- a/lib/lmb.c
> > > > > +++ b/lib/lmb.c
> > > > > @@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
> > > > >
> > > > >  static struct lmb lmb;
> > > > >
> > > > > +static void print_region_flags(enum lmb_flags flags)
> > > > > +{
> > > > > +       uint64_t bitpos;
> > > > > +       const char *flag_str[] = { "LMB_NONE", "LMB_NOMAP", "LMB_NOOVERWRITE" };
> > > >
> > > > As mentioned, LMB_NONE shouldn't be a flag. For the other two, how
> > > > about "no-map" and "no-overwrite"?
> > >
> > > So, you don't want any value to be shown with LMB_NONE? I guess
> > > LMB_NONE is indicative of the fact that the region does not have any
> > > attributes, no?
> >
> > That's my understanding, yes. This could be a later cleanup I suppose,
> > but since you are adding flags, you may as well remove this one.
>
> Maybe I am not getting your point. But we have the flags member in the
> struct lmb_region, and a region without any flags set will have a
> value of 0. And we are calling that LMB_NONE. So, if we consider the
> boot_fdt_reserve_region() function, we need to pass a flags argument
> to the function. And a value of 0 would mean LMB_NONE. Is it not
> instructive to show a value of 0 as LMB_NONE(okay, maybe not in
> uppercase), instead of having to just print 0? Not printing anything
> is a little confusing imo.

But then why set LMB_NONE to BIT(0)? That has the value of 1 and
suggests it is useful in some way.

You could just leave it as zero. I don't see why having no flags is
confusing, but you can print 'none' if you like.

Regards,
Simon
