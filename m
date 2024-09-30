Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE68CE8349
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 14:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 650C188D9B;
	Mon, 30 Sep 2024 16:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DJ4f7FZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3825D88E1A; Mon, 30 Sep 2024 16:11:04 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112B788AA7
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 16:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c3f12d3930so38172806d6.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727705461; x=1728310261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4gbSJqWubYjjKaD/ycJXqBiYPmbKM3Uom9mUCwNd4f8=;
 b=DJ4f7FZIllUq0p6Mwl7rHChkUVHrNV5Bi5XsrjbxfpAvhcTvz//OPI5Ic6csJU5reJ
 QCBoBng6r98uIlQ7gChd80iDio00gYb3X3mthMTjC2nl4gAMdrUbxLXmkwEIFwlLt40X
 88bcw6vDKsgqnsfAty5qU/imcZ5VM1IYhq+Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727705461; x=1728310261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4gbSJqWubYjjKaD/ycJXqBiYPmbKM3Uom9mUCwNd4f8=;
 b=vgkB13TPdUIjn7VkfLK2Aat0Q0aDy2FmaWt7Y7XELJvt9oKqzwoOP9Z/Ov/jB9k0FG
 Yvfnt4JA++TfjcN9oHNHxIHZlnMPS5TUO58Z8ZTP9jPVM/kYJalcO6pZpMvxoVsU+Zd8
 yERGTStVLtyHo4ITI68usCjomjaSmaVceMbwDMESZJ/R74JCkBMObIQ+lU/mGMaGk5Xo
 MwOwFlNWDuHrbIlN9o2LfIRVSXfXLO3XEhhLeToDrOeELFNBmWZmura48PAA3C0bpqVj
 NFnR0S7vkt4Ui4YcRu2sUDRkTMSTuAYNWd17o4wDZXb4kNMZ9BrCs8mKq81vrD4Idsvs
 cXdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgmJrASIh1n60iPkwckpiFFuz9/MDY7S1LMu4ciLJwkbK+eqTO9VCfWmnQGF2dCdtNXc+RIJU=@lists.denx.de
X-Gm-Message-State: AOJu0YxkXxQZorNxPTnn6D7gCfstO5rsFkMHmsB82Z8Nu04I6uOTrBF5
 kMzZzgBbzIQt7+pFF+0nXpyeS/HZxusyNoB8Xaccdv8T2/0yIzY2N1ij2IW7cf6z5DwScH1h3ym
 4hSqSn+4c+50nsSE8Agc9bJozJ+49H5LK/cFF
X-Google-Smtp-Source: AGHT+IGQsWYTP3N1cSx3yUd+VxW+7qVrE8rKm/AxqGgq6OSHFZTP6FS/bVMF2yzvapCaLhgjRzuU1/d3W9NU4+q6H0Q=
X-Received: by 2002:a05:6214:4613:b0:6cb:4a06:2e01 with SMTP id
 6a1803df08f44-6cb4a06309dmr165395466d6.16.1727705460859; Mon, 30 Sep 2024
 07:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
 <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
 <20240927204046.GW4252@bill-the-cat>
 <CAOMZO5DAUD3WR5z8ZxPkVhnv_2VZpYaHRziEvZ7MHvwooNS8Jg@mail.gmail.com>
 <CAFLszTiUQBJvaU_bhUYdsujo-oeeT8RCDguu+pYQ9YEppqqALg@mail.gmail.com>
 <20240930004623.GA5579@bill-the-cat> <ZvqJJ7DOhxpEBgXl@zoo11.em.health.ge.com>
In-Reply-To: <ZvqJJ7DOhxpEBgXl@zoo11.em.health.ge.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 08:10:49 -0600
Message-ID: <CAFLszThuGsiQeQXaL6jtHezj_JAQ+TwJTco_8C=qDTiu0sLFOg@mail.gmail.com>
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

Hi Brian,

On Mon, 30 Sept 2024 at 07:01, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> On Sun, Sep 29, 2024 at 06:46:23PM -0600, Tom Rini wrote:
> > On Sun, Sep 29, 2024 at 04:49:17PM -0600, Simon Glass wrote:
> > > Hi Fabio,
> > >
> > > On Sun, 29 Sept 2024 at 14:53, Fabio Estevam <festevam@gmail.com> wrote:
> > > >
> > > > Hi Simon, Marek, and Tom,
> > > >
> > > > On Fri, Sep 27, 2024 at 5:47???PM Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > > Please can you coordinate with Marek as we need to sort out the test
> > > > > > coverage for this etype, before adding more functionality. I did a
> > > > > > starting point, now in -next, which should help.
> > > > >
> > > > > Well, when someone has both time and understanding of the tools and the
> > > > > frameworks, we can expand the automatic tests while still having
> > > > > functional testing as people use the feature.
> > > >
> > > > Do you think this patch should be applied as is? Could the tests be
> > > > handled later?
> > > >
> > > > Please let me know.
> > >
> > > Who is going to handle the tests later and when?
> >
> > Someone, once how to write and run the tests is documented. That's a
> > big hurdle this private thread has shown, to me at least.
> >
> > --
> > Tom
>
> Hi,
>
> I fixed a minor issue in the patch, and sent a revised version.
>
> Seems that you don't have the testing quite defined yet, so I don't know
> what I can contribute there. Maybe something can be done with the CSF
> parser to check that the signing works correctly?

Just to be clear, the testing is fully defined...this is actually the
only entry type which doesn't have a proper test. Every other user was
able to add a test. The goal here isn't really to check that external
tools are working (they should have their own tests), more to check
that Binman is doing the right thing.

I will get some sort of patch out by tomorrow morning to help this process.

>
> However, I think this feature is quite benign, and it would be great to
> get some functional testing in for this feature, as Tom said. For us,
> this is an important feature, so we have done extensive testing
> internally to verify that it works.

I fully understand that...but of course without an automated test in
Binman it may break at any moment, as Binman continues to be expanded.

BTW, minor code-style things: U-Boot's Python code uses single quotes
and the line limit is 80cols.

Regards,
Simon
