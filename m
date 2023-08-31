Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAEDC83F22
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71FE98657B;
	Thu, 31 Aug 2023 04:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kxzkvqxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B1D86570; Thu, 31 Aug 2023 04:50:04 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B02986567
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5298e43bb67so612232a12.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450199; x=1694054999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cDfy/XxzEZKiU8yuFaKcYfPqqPfQ2YTrAIQclTblcOs=;
 b=kxzkvqxBgmzeUUi2w6TIctWwoXfdB+gb3Kei997TWk7CBI09CvaDl8jZZguvknUvuO
 0LA3e4qn4wxpvSxAxEDUpx59z8ExAQc2sZkJxhHibORFNpIA76etUiKChDhZCQ3KQcai
 hkBrKFrwlOVV7i4iWzEQnUIPKpxfO6qJjbEKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450199; x=1694054999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDfy/XxzEZKiU8yuFaKcYfPqqPfQ2YTrAIQclTblcOs=;
 b=jW5mrBxQceLQO/OF3gcp2Bt320QSZz9fZdnhy6TR9P8MC4Xuz6YFsKn3iRiB7ZGHbV
 xTbpmQYbSGe3Y772UyXa3oEfMXjQcJfnJo3wzVhvngNmb/hhZE2qREe+hGtG4pNZs6a+
 uzdjEheEn6K46DetMIZXcW/4hW36CMniWRQzd/uzGfRAEOWNqF6YRylZlXQcJPvX1Rfd
 77gPJxwBpWbs7DhnIDmcolQgpfd5oZKBpGs4CxugkAHJuo3GCRysfKo9sP2XFKSNWsmB
 yBmdEC8cksFnEbg7dSfccDSpNmH4gi1inlCYj8s1qdTY4f0FJCh4Dntu2UUfw40NqutS
 0mQg==
X-Gm-Message-State: AOJu0YyI67jwuxf5HZ2pVsXm55lU7r2a/ScC11V+cgZjQRhfQQJM8mGh
 lB9X6znhnmeqmSIuifjghUHlig6N6RqPWYIyjCmXBMgtFbMMmsayP90=
X-Google-Smtp-Source: AGHT+IHmGxQlFQAMFBgcAdgITfneuYVsaZpG6cwaj3VxTiEwHTCJS9UG71pgt/rPfT+FdrVvORh5szH3TRfTuheIKLU=
X-Received: by 2002:a05:6402:34d0:b0:51d:b184:efd with SMTP id
 w16-20020a05640234d000b0051db1840efdmr1422285edc.20.1693450198930; Wed, 30
 Aug 2023 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
 <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
 <20230828183936.GN3953269@bill-the-cat>
 <CAC_iWj+d_xLKJS_KHYEExSQb2MuU0K9BYeLDbnHSdp8wF7W+Pw@mail.gmail.com>
In-Reply-To: <CAC_iWj+d_xLKJS_KHYEExSQb2MuU0K9BYeLDbnHSdp8wF7W+Pw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:16 -0600
Message-ID: <CAPnjgZ3mobofYNB7B4nmJg8GH12FQSJ7vcEXaVydtWwSLhvfLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Ilias,

On Wed, 30 Aug 2023 at 01:25, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tom
>
> On Mon, 28 Aug 2023 at 21:39, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 29, 2023 at 12:04:53AM +0530, Sughosh Ganu wrote:
> > > hi Simon,
> > >
> > > On Mon, 28 Aug 2023 at 23:25, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Add a document explaining the need for removal of non-compliant
> > > > > devicetree nodes and properties. Also describe in brief, the macros
> > > > > that can be used for this removal.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++++
> > > > >  1 file changed, 64 insertions(+)
> > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > >
> > > > > diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > > new file mode 100644
> > > > > index 0000000000..c3a8feab5b
> > > > > --- /dev/null
> > > > > +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > > @@ -0,0 +1,64 @@
> > > > > +.. SPDX-License-Identifier: GPL-2.0+
> > > > > +
> > > > > +Removal of non-compliant nodes and properties
> > > > > +=============================================
> > > > > +
> > > > > +The devicetree used in U-Boot might contain nodes and properties which
> > > > > +are specific only to U-Boot, and are not necessarily being used to
> > > > > +describe hardware but to pass information to U-Boot. An example of
> > > > > +such a property would be the public key being passed to U-Boot for
> > > > > +verification.
> > > >
> > > > It has nothing to do with describing hardware. The DT can describe
> > > > other things too. See the /options node, for example.
> > > >
> > > > Please don't bring this highly misleading language into U-Boot.
> > >
> > > Please point out what is misleading in the above paragraph. What is
> > > being emphasised in the above paragraph is that certain nodes and
> > > properties in the devicetree are relevant only in u-boot, and not the
> > > kernel. And this is precisely what the devicetree maintainers are
> > > saying [1].
> > >
> > > >
> > > > > +
> > > > > +This devicetree can then be passed to the OS. Since certain nodes and
> > > > > +properties are not really describing hardware, and more importantly,
> > > > > +these are only relevant to U-Boot, bindings for these cannot be
> > > > > +upstreamed into the devicetree repository. There have been instances
> > > > > +of attempts being made to upstream such bindings, and these deemed not
> > > > > +fit for upstreaming.
> > > >
> > > > Then either they should not be in U-Boot, or there is a problem with
> > > > the process.
> > > >
> > > > > Not having a binding for these nodes and
> > > > > +properties means that the devicetree fails the schema compliance tests
> > > > > +[1]. This also means that the platform cannot get certifications like
> > > > > +SystemReady [2] which, among other things require a devicetree which
> > > > > +passes the schema compliance tests.
> > > > > +
> > > > > +For such nodes and properties, it has been suggested by the devicetree
> > > > > +maintainers that the right thing to do is to remove them from the
> > > > > +devicetree before it gets passed on to the OS [3].
> > > >
> > > > Hard NAK. If we go this way, then no one will ever have an incentive
> > > > to do the right thing.
> > > >
> > > > Please send bindings for Linaro's work, instead. If something is
> > > > entirely U-Boot-specific, then it can go in /options/u-boot but it
> > > > still must be in the dt-schema.
> > >
> > > Please re-read the document including the last link [1]. If you go
> > > through that entire thread, you will notice that this is precisely
> > > what Linaro was trying to do here -- upstream the binding for the
> > > fwu-mdata node. It is only based on the feedback of the devicetree
> > > maintainers that this patchset was required.
> > >
> > > -sughosh
> > >
> > > [1] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/#t
> >
> > Please note that this right here, that the explanation of why we need to
> > delete this node, not being a bright shiny visible object is one of the
> > big problems with this patchset and implementation. It cannot be
> > footnotes in email threads as to why such-and-such node/property isn't
> > upstream, it needs to be documented and visible in the code base /
> > documentation and an obvious you must do this for future cases.
>
> I thought we agreed that deleting nodes that won't be accepted
> upstream is the right approach since that would break the systemready
> 2.0 compatibility.

Isn't that controlled by ARM/Linaros, as are the devicetree bindings?
What am I missing? Let's just fix the bindings so they can be
accepted. What we decide here will have enormous repercussions in the
future. SoC vendors are watching to see whether they should bother to
upstream bindings or not.

>
> Yes, it can't be footnotes or hidden links, but this is totally
> different than what I am reading on this thread.

Regards,
Simon
