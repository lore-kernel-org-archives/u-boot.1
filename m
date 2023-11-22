Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929FFC072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 07:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D395E875A1;
	Wed, 22 Nov 2023 08:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TKYfTlHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CE3875C0; Wed, 22 Nov 2023 08:40:50 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 491888718E
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 08:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-548ce28fd23so3792887a12.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700638847; x=1701243647; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v8Vb2voMHEJJA7glSIAV2dkvgEZ9ltrmdgPjbwshBbw=;
 b=TKYfTlHKdLtWNS20dPZo+UjSi1jKxd1CbpmO7CBoCbs2NDyS2+suSdGEgy7FeCQNo9
 fZeyxRFUQyI6SMfPr9gYfKWifvYgguRH67kTFPUcTj/lOOl1zthkSPlggO2/yC7Apb1o
 uvHHkwZiHGmzzjhgNUgq9ytsLfQ72sqypSnU5OCxFtCqR68H+U6zg97z5ZrUq1KVn9On
 nHZRkH7k4kQIw6oysd+m3p2azu3ERAXwZlz++XSKtOQpYbEhy9meNltocmcXKCJMUGsz
 HqtIgjFNlYA0heZjLuWRLGmW7WLRhTRjX7CR6hLVqcWYVBClefNpC5bQO9sK7fxr2/sV
 83zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700638847; x=1701243647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8Vb2voMHEJJA7glSIAV2dkvgEZ9ltrmdgPjbwshBbw=;
 b=oSG4KnvVMTdJMjrUVAQFPIjx76wk6+CMS+bdw2Bf9PEiYtt0NusjyqtlOPALIia7Yo
 6j66ge3N4VR+C69C8W/Zs/zrTuC+LPv2MLV6as9DEcz51qre+5WKyvHRc51fvWIsylh2
 06SSKuAOm/L/Xm8m2t4s8Pt2KOoGcxmbPGCHQQuZPHpsH0oeXoG+4aNALGUMlhM/v4Rd
 6p8QT3FL69tGFmb+d1WKq8z/1GAnhTGJ9k9kK8xU0c+bhnGUqGyeMudeTEM4/8hb0sLT
 fSwuFzJMK0A2xoRpswYWAWTBRWPIx8jZDdis8C+49AWFY/jl4GxvO26Wj4WpoOfwGESt
 DE4g==
X-Gm-Message-State: AOJu0YxgNOf1HlNbj8aJW5n/ZLPQrW3yzJFJzs9/o4W5LNikan5/RugA
 2xcTrCSDY7lpgEtT0hj/tlfd0BZ/+l04TVH3xltL2g==
X-Google-Smtp-Source: AGHT+IHwRDywHnTKfCyB19nABNCgeEwuzNaphomClxvFEICm9BhzGkNzU8XqaW9BspjrzCSpv8xkw+yfv9YJjnKRm9I=
X-Received: by 2002:a05:6402:b29:b0:53e:775e:9761 with SMTP id
 bo9-20020a0564020b2900b0053e775e9761mr1171028edb.36.1700638846733; Tue, 21
 Nov 2023 23:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
 <CAC_iWjKKas=zkMyJeNvLmcPWh2wjbE=aw_-Nugano3HYWX2+4Q@mail.gmail.com>
In-Reply-To: <CAC_iWjKKas=zkMyJeNvLmcPWh2wjbE=aw_-Nugano3HYWX2+4Q@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 22 Nov 2023 13:10:35 +0530
Message-ID: <CADg8p96mfEtCySQyXPLqKuwnYu7BPO5guoz9+0452aujgs-zsg@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

hi Ilias,

On Wed, 22 Nov 2023 at 13:06, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> On Wed, 22 Nov 2023 at 07:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > Add support for specifying the parameters needed for capsule
> > > > generation through a config file, instead of passing them through
> > > > command-line. Parameters for more than a single capsule file can be
> > > > specified, resulting in generation of multiple capsules through a
> > > > single invocation of the command.
> > > >
> > > > The config file can then be passed to the mkeficapsule tool in such
> > > > manner
> > > >
> > > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  tools/Kconfig              |  15 ++
> > > >  tools/Makefile             |   1 +
> > > >  tools/eficapsule.h         | 114 ++++++++++++
> > > >  tools/mkeficapsule.c       |  87 +++++----
> > > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> > > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > > >  create mode 100644 tools/mkeficapsule_parse.c
> > >
> > > This patch keeps coming back :-)
> > >
> > > Can we not add multiple capsules in the binman description? Why do we
> > > need a new file format? How can binman decode images produced in this
> > > way?
> >
> > So as Tom mentions, this brings parity with respect to the other
> > capsule generation tool in EDKII that generates capsules. IIRC, this
> > is something which even Xilix was interested in, and Michal had kind
> > of gone through these patches earlier. Lastly, it would be good to
> > have support in U-Boot's mkeficapsule tool for generating a single
> > capsule file with multiple payloads, and having support for this
> > functionality helps in that goal.
> >
> > Also, you might have noticed that, since your objection to the last
> > series, I have removed putting this in binman. So now, this aspect of
> > the capsule generation would only be supported through the
> > command-line invocation of the tool.
>
> I think that overall the approach is sane. mkeficapsule is currently
> supported and compiled for distros, so the multiple payload support is
> useful. If we want to add support to binman, instead of rewriting this
> in python, we could just call that tool for parsing and creating
> capsules

Given the amount of time these patches have been under review(also
number of iterations), I would request that this series be reviewed
and merged first. I think there is general consensus that there is
value to have this functionality in the mkeficapsule tool. If it is
deemed fit to support this through binman as well, that task can be
taken up separately. Thanks.

-sughosh

>
> Thanks
> /Ilias
> >
> > >
> > > Also, could we get sandbox to produce one EFI capsule as part of the
> > > normal build? I think that discussion trailed off.
> >
> > Yes, apologies for missing out on this. Slipped my mind. Would you
> > want, say, all the non-signed capsules to be generated as part of the
> > sandbox build?
> >
> > -sughosh
