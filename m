Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E855C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 07:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA1B8655F;
	Thu, 31 Aug 2023 09:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ah2194b4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7089C8655E; Thu, 31 Aug 2023 09:52:44 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CE686568
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bcc846fed0so9960601fa.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693468360; x=1694073160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zq5O4lX+Vy366dnW50sDslGPIxZiv81R5mBsqKmyiE8=;
 b=Ah2194b4SU4NcEHYAZ5o3pKj/wC6kN8pAwRalXU+9d9hsPCKSRR45Xb7/pSqjMCqNx
 w9kVUcgqIRnJzlJB4XF5m7lt6tFhZ3811mwldSu6sotEUldYcAtu+1iwPi+RVhN3v227
 4yPWt0tRWLuKMz2OZFg/7yQFx+Q3kPAqDUFIslx9Lc9uKVnDxWZnN0yEcihBrt3fl/pi
 jgYpzKfJVxG7G7T8e9ihptTLm0PjHRgj62JK5HI8ueK4QPvTM1gGJ/LZSXscOekyMFU4
 uIVsAxEHsqXPnm/0F2FP/d9EhsZIrs5vXoZs31qUQCXFB06zCT0/bn5C18NRp8iDdsfq
 fFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693468360; x=1694073160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zq5O4lX+Vy366dnW50sDslGPIxZiv81R5mBsqKmyiE8=;
 b=IdhiUL7GzonmkUShq+y4elvFgyfUdCsxodZlKH1RaVo1SmXQcX/0UaZprFa6yu7MzE
 4W6s8/CLWAy/xcUbnedxmqpXwajFSvmLEbi1GDxQ8Wuwn1Y176HmMZqcjTUu8qOWEIBx
 GfLyLHv2R2nOU9Nhj23PWlmgaqq5mM/k1M0iBCo/Azngm7wmqfyerBhK5igBSHHpZMQI
 lKn0YBJhtZYjwS1Zr/C5FRurLodoPIImRvXQtKvHJdwRETiUj0BZu+++VTkjMHjrVWBx
 6TD5Jb66XEwtBBlZMCOKVMBQ3M1Xui8jE1ilkU887PxVCnhr2I8UyTHYydI4rBogB/do
 aRfA==
X-Gm-Message-State: AOJu0Yw8A9yaA14dj8/XKS+b3TxZ42l0fir+pXBktVVi61G/1ymcVBO/
 DeC2pcLIQjYMKm6OP2H8T1wkY7itk5a8hxPH8Zun3Q==
X-Google-Smtp-Source: AGHT+IGgalloddkrTAW83ZMuxuO8ANq4DXxAmUwjVO3vS9LqX+JzG7cGsPgvF14tRkf8LdZGhOjz+ptKyhF1V9Oo2tU=
X-Received: by 2002:a2e:9f50:0:b0:2bd:1d02:5026 with SMTP id
 v16-20020a2e9f50000000b002bd1d025026mr3404119ljk.15.1693468360543; Thu, 31
 Aug 2023 00:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-6-sughosh.ganu@linaro.org>
 <CAPnjgZ3AexW4vfO-A8WYGE0OD5EZnOUA7tA1QP71Bcw51QArBQ@mail.gmail.com>
 <CADg8p96zOXDaVV9CFcbeKgdZwG7pwfCp66GEY_eoYC6FCHeKZA@mail.gmail.com>
 <20230828183936.GN3953269@bill-the-cat>
 <CAC_iWj+d_xLKJS_KHYEExSQb2MuU0K9BYeLDbnHSdp8wF7W+Pw@mail.gmail.com>
 <CAPnjgZ3mobofYNB7B4nmJg8GH12FQSJ7vcEXaVydtWwSLhvfLQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3mobofYNB7B4nmJg8GH12FQSJ7vcEXaVydtWwSLhvfLQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 31 Aug 2023 10:52:04 +0300
Message-ID: <CAC_iWjKeD72f0giLUbeZZ0aP2h5kgNJw+va1o50bGx8fbqp3iQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] doc: Add a document for non-compliant DT
 node/property removal
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Thu, 31 Aug 2023 at 05:50, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 30 Aug 2023 at 01:25, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tom
> >
> > On Mon, 28 Aug 2023 at 21:39, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Aug 29, 2023 at 12:04:53AM +0530, Sughosh Ganu wrote:

[...]

> > > >
> > > > Please re-read the document including the last link [1]. If you go
> > > > through that entire thread, you will notice that this is precisely
> > > > what Linaro was trying to do here -- upstream the binding for the
> > > > fwu-mdata node. It is only based on the feedback of the devicetree
> > > > maintainers that this patchset was required.
> > > >
> > > > -sughosh
> > > >
> > > > [1] - https://lore.kernel.org/u-boot/CAL_JsqJN4FeHomL7z3yj0WJ9bpx1oSE7zf26L_GV2oS6cg-5qg@mail.gmail.com/#t
> > >
> > > Please note that this right here, that the explanation of why we need to
> > > delete this node, not being a bright shiny visible object is one of the
> > > big problems with this patchset and implementation. It cannot be
> > > footnotes in email threads as to why such-and-such node/property isn't
> > > upstream, it needs to be documented and visible in the code base /
> > > documentation and an obvious you must do this for future cases.
> >
> > I thought we agreed that deleting nodes that won't be accepted
> > upstream is the right approach since that would break the systemready
> > 2.0 compatibility.
>
> Isn't that controlled by ARM/Linaros, as are the devicetree bindings?

The device tree validation happens through the dt schema validation.
You can read a bit more here [0]

> What am I missing? Let's just fix the bindings so they can be
> accepted.

I can go through the mailing lists, but I am pretty sure you've been
trying to do this for a number of years and got pushback for many of
those bindings.  Has that changed?  Can you guarantee to all the
vendors that all the bindings will get merged and they won't have a
problem getting their boards certified?

> What we decide here will have enormous repercussions in the
> future. SoC vendors are watching to see whether they should bother to
> upstream bindings or not.

How is that remotely relevant to the discussion we have here?  If it's
hardware that the OS has to use they *will* have to upstream it,
otherwise their device won't work with upstream kernels (not that they
care, I am just pointing it out).  If it's an internal thing they need
to perform an X action in U-Boot and the OS has no interest in that
property  (e.g. the driver model nodes), they can just get rid of it.

>
> >
> > Yes, it can't be footnotes or hidden links, but this is totally
> > different than what I am reading on this thread.
>
> Regards,
> Simon

[0] https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/

Thanks
/Ilias
