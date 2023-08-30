Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6397BC83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 07:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7121586516;
	Wed, 30 Aug 2023 09:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q5+xnlVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8924D8651A; Wed, 30 Aug 2023 09:25:19 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25BE986514
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 09:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-500bb392ab7so4461964e87.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693380315; x=1693985115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=50DhdoCtvcJeUGQ/wIlnAWV7cfipYLY9mThJ6NVMbNs=;
 b=q5+xnlVAS8PXS2UnQpscAn+IWWp58EWZLC4XD3ALgHyoFmTzzYiG44FVH3ZRmEB4I8
 3r9nTFgEsK6OSL5XxLF3jttY/uaaclOUyQR8yaloLiN0b1Z/MvZxcw1GAq+tw2v6ZHJ2
 TL+V3S4x31uGYd5GFnWfcym+4rCmlks5KQr+GQBUslsf/KSiRMXj3J3UmdFgdfwi0bU9
 2iRkhzRBtaHDloKYYo0Q3232StE7tZaEv2sHEEv2WB9kcMPm81DFcgiKf8/5C5yTzSBt
 GwQq5JwTyp1DDAwY2Cnl+ZchJnCRC/ZbzV88rkXWhiPMu6d98UnJBZeChRlKfUkk04gU
 Tplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693380315; x=1693985115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50DhdoCtvcJeUGQ/wIlnAWV7cfipYLY9mThJ6NVMbNs=;
 b=fEFnNFWUxsRYsKT0sLLcD19cg2h3+lNHmOgPhfvwjrOGUoLRiFaM1DRrSoaxtpVsrY
 oBor1wAEFt9hZyJZJkdeGDddNIh3H/PpvovU0LvoZFBbQFrZK94hUlaL4M5YXjh5l99N
 SH53W4BWCfGIbsgDaBPFyivip/8aOUd6mTLYCMGTSqnLRb/wkXvkcZoT1LMgXT05mgAk
 Gou7A3+zOFHVc2CjuA9vsxgac8CW8DG3i89V7I5C6mArwo/RHzc3zTf6sDiQvC3iSf+/
 i+6l45iXhyo9FRBKyYTehGdn5jHV9306Ij48hcZFW7odGySzxMCX/OLZYWQFSs/kLm54
 G1eQ==
X-Gm-Message-State: AOJu0YwCADqZ2ITY7lRHKAavPScuJOs6pmDAcCRIej1qqr4ZUty3aeh7
 3D+kSYoIlHsnOj0B4CX3YmyFGaw29XalsCkgliDt7g==
X-Google-Smtp-Source: AGHT+IHsbCzgAaLManqRfFIFFFTDX6yv36W9P+GJlcpUdBKarEDpCifAg5vZBXYsJZH1y+t3IWzqHeBlzHP/8BrgkAE=
X-Received: by 2002:a05:6512:39d0:b0:500:808c:91f7 with SMTP id
 k16-20020a05651239d000b00500808c91f7mr920922lfu.13.1693380315291; Wed, 30 Aug
 2023 00:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
 <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
 <20230828183936.GN3953269@bill-the-cat>
In-Reply-To: <20230828183936.GN3953269@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Aug 2023 10:24:39 +0300
Message-ID: <CAC_iWj+d_xLKJS_KHYEExSQb2MuU0K9BYeLDbnHSdp8wF7W+Pw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
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

Hi Tom

On Mon, 28 Aug 2023 at 21:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 29, 2023 at 12:04:53AM +0530, Sughosh Ganu wrote:
> > hi Simon,
> >
> > On Mon, 28 Aug 2023 at 23:25, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Add a document explaining the need for removal of non-compliant
> > > > devicetree nodes and properties. Also describe in brief, the macros
> > > > that can be used for this removal.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++++++
> > > >  1 file changed, 64 insertions(+)
> > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> > > >
> > > > diff --git a/doc/develop/devicetree/dt_non_compliant_purge.rst b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > new file mode 100644
> > > > index 0000000000..c3a8feab5b
> > > > --- /dev/null
> > > > +++ b/doc/develop/devicetree/dt_non_compliant_purge.rst
> > > > @@ -0,0 +1,64 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0+
> > > > +
> > > > +Removal of non-compliant nodes and properties
> > > > +=============================================
> > > > +
> > > > +The devicetree used in U-Boot might contain nodes and properties which
> > > > +are specific only to U-Boot, and are not necessarily being used to
> > > > +describe hardware but to pass information to U-Boot. An example of
> > > > +such a property would be the public key being passed to U-Boot for
> > > > +verification.
> > >
> > > It has nothing to do with describing hardware. The DT can describe
> > > other things too. See the /options node, for example.
> > >
> > > Please don't bring this highly misleading language into U-Boot.
> >
> > Please point out what is misleading in the above paragraph. What is
> > being emphasised in the above paragraph is that certain nodes and
> > properties in the devicetree are relevant only in u-boot, and not the
> > kernel. And this is precisely what the devicetree maintainers are
> > saying [1].
> >
> > >
> > > > +
> > > > +This devicetree can then be passed to the OS. Since certain nodes and
> > > > +properties are not really describing hardware, and more importantly,
> > > > +these are only relevant to U-Boot, bindings for these cannot be
> > > > +upstreamed into the devicetree repository. There have been instances
> > > > +of attempts being made to upstream such bindings, and these deemed not
> > > > +fit for upstreaming.
> > >
> > > Then either they should not be in U-Boot, or there is a problem with
> > > the process.
> > >
> > > > Not having a binding for these nodes and
> > > > +properties means that the devicetree fails the schema compliance tests
> > > > +[1]. This also means that the platform cannot get certifications like
> > > > +SystemReady [2] which, among other things require a devicetree which
> > > > +passes the schema compliance tests.
> > > > +
> > > > +For such nodes and properties, it has been suggested by the devicetree
> > > > +maintainers that the right thing to do is to remove them from the
> > > > +devicetree before it gets passed on to the OS [3].
> > >
> > > Hard NAK. If we go this way, then no one will ever have an incentive
> > > to do the right thing.
> > >
> > > Please send bindings for Linaro's work, instead. If something is
> > > entirely U-Boot-specific, then it can go in /options/u-boot but it
> > > still must be in the dt-schema.
> >
> > Please re-read the document including the last link [1]. If you go
> > through that entire thread, you will notice that this is precisely
> > what Linaro was trying to do here -- upstream the binding for the
> > fwu-mdata node. It is only based on the feedback of the devicetree
> > maintainers that this patchset was required.
> >
> > -sughosh
> >
> > [1] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/#t
>
> Please note that this right here, that the explanation of why we need to
> delete this node, not being a bright shiny visible object is one of the
> big problems with this patchset and implementation. It cannot be
> footnotes in email threads as to why such-and-such node/property isn't
> upstream, it needs to be documented and visible in the code base /
> documentation and an obvious you must do this for future cases.

I thought we agreed that deleting nodes that won't be accepted
upstream is the right approach since that would break the systemready
2.0 compatibility.

Yes, it can't be footnotes or hidden links, but this is totally
different than what I am reading on this thread.

Thanks
/Ilias
>
> --
> Tom
