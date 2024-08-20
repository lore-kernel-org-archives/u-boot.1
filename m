Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DF0C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 10:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DABD8891B;
	Tue, 20 Aug 2024 12:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ARuyxS3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B6188A08; Tue, 20 Aug 2024 12:23:45 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE7A8891B
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 12:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso1915411a12.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724149422; x=1724754222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4yGpw6d7Tf+UBurWiKfByV1A8H1SDCkkJnIlq1MABlU=;
 b=ARuyxS3jes5CfHteVpi294teibxwR0eeowxxyQarv+ucy9UUZ2uQ7nlUqM8vZ60b90
 Ws50VrLU86FHkli3Hz9kQBd1Rq6GG/GaTQ6Q+HMp8HbKlM3wl3HyFF7A+A/ptd/QXkmn
 LPC1znLTTTlsUesw3N9+DTDBvUKqQL66/JYQu09t3fJKXfksBeJV3+VIdzGQqXGuPx/b
 esElpLYKXDtPYdfCzraDM4M8mjIP8VVreXIlX6r32WRapuMz7fTWMwA3luhEeIuK4UJH
 6ndVPyZk1MRp//p1oExKzEK3qSXo3zgGYP2r7u4rB+5T6IuwJBc+u+ZQ6SsgePhDOL8z
 dOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724149422; x=1724754222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4yGpw6d7Tf+UBurWiKfByV1A8H1SDCkkJnIlq1MABlU=;
 b=Ds3npV8YDEpKnPmP3PRLLF9ykkXY22axXUETMVcOdlmBi5kFvgUUNjlP5FgImpzKiJ
 YrKUbb4y0X6P11O7LpxG6tOZqFCmseixxkWLMIunmBoHRCWj1YdpjPYgAWrVPSO2y6VU
 gHvzfyTL6xi8CRVPfutp1sVFGhuoI8RWq5ybJoOaiKwM9tir1WlxaEFbBp0aXn0Emy1E
 oHa8XNVuidOSehMrl1mlCMq2wHZnKAYS74/j1C4P78t897l0/tphfFnGbfm8BZijwzWh
 7V1UHKPFOfnEX10fQGkQP0LDaPJiskWoF2EiJf3OA4EEQwV/Ji1eoB6vxLad/mm0wjsZ
 UpHQ==
X-Gm-Message-State: AOJu0Yya3UG1VuSLePNJq2g8Wh9wuyUbx3JLRqTPeVvMxglwwQQI8IvV
 6VcEkVfFejrLwuAY50tOV95/ewgBJTcgCHV6gwscmsI4KT6Zr1Pb6OCp92to1ztLkO9rwzkiWda
 3VAy+vW9HjUKCo04U1elpaIycNuReLScSOoMSGQ==
X-Google-Smtp-Source: AGHT+IGbC6OiCRe0YseTfl7HZaxd1oVwepXXq1QhCajT4ix4tVXnygtYL2Yx2EeWOML7zKLs7Jw62hJKfa1Iavz6ssM=
X-Received: by 2002:a05:6402:26d1:b0:5be:fb2e:d334 with SMTP id
 4fb4d7f45d1cf-5bf0ac63e77mr2466562a12.12.1724149422437; Tue, 20 Aug 2024
 03:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-33-sughosh.ganu@linaro.org>
 <CAFLszTigDtzrLWzVfrVmq_Uet_GRoQWq7YVQcgerpk8XAT8BvQ@mail.gmail.com>
In-Reply-To: <CAFLszTigDtzrLWzVfrVmq_Uet_GRoQWq7YVQcgerpk8XAT8BvQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 20 Aug 2024 15:53:31 +0530
Message-ID: <CADg8p97bznk=rdyq9_vFSbobockFXwzwdbJ2JsEvDzW6ZTreWA@mail.gmail.com>
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

On Fri, 16 Aug 2024 at 02:03, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 14 Aug 2024 at 05:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Instead of printing the LMB flags as numerical values, print them as
> > strings. This makes it easier to understand what flags are associated
> > with the lmb region. Also make corresponding changes to the bdinfo
> > command's test code.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >  lib/lmb.c         | 18 ++++++++++++++++--
> >  test/cmd/bdinfo.c |  4 ++--
> >  2 files changed, 18 insertions(+), 4 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But see below
>
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 37d2a72951..5c5b3e9bb5 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -26,6 +26,19 @@ DECLARE_GLOBAL_DATA_PTR;
> >
> >  static struct lmb lmb;
> >
> > +static void print_region_flags(enum lmb_flags flags)
> > +{
> > +       uint64_t bitpos;
> > +       const char *flag_str[] = { "LMB_NONE", "LMB_NOMAP", "LMB_NOOVERWRITE" };
>
> As mentioned, LMB_NONE shouldn't be a flag. For the other two, how
> about "no-map" and "no-overwrite"?

So, you don't want any value to be shown with LMB_NONE? I guess
LMB_NONE is indicative of the fact that the region does not have any
attributes, no?

-sughosh

>
> > +
> > +       do {
> > +               bitpos = fls(flags) - 1;
> > +               printf("%s", flag_str[bitpos]);
> > +               flags &= ~(1ull << bitpos);
> > +               flags ? puts(", ") : puts("\n");
> > +       } while (flags);
> > +}
> > +
> >  static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
> >  {
> >         struct lmb_region *rgn = lmb_rgn_lst->data;
> > @@ -41,8 +54,9 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
> >                 end = base + size - 1;
> >                 flags = rgn[i].flags;
> >
> > -               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
> > -                      name, i, base, end, size, flags);
> > +               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
> > +                      name, i, base, end, size);
> > +               print_region_flags(flags);
> >         }
> >  }
> >
> > diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
> > index 7dd3f7ca5b..887defc28a 100644
> > --- a/test/cmd/bdinfo.c
> > +++ b/test/cmd/bdinfo.c
> > @@ -120,8 +120,8 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
> >                         ut_assert_nextlinen(" %s[%d]\t[", name, i);
> >                         continue;
> >                 }
> > -               ut_assert_nextline(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x",
> > -                                  name, i, base, end, size, flags);
> > +               ut_assert_nextlinen(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: ",
> > +                                  name, i, base, end, size);
> >         }
> >
> >         return 0;
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
