Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9E4C072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 07:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A4F86C31;
	Wed, 22 Nov 2023 08:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F0I4ta2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 309D786C31; Wed, 22 Nov 2023 08:36:04 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2598008F
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 08:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c72e275d96so80237901fa.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700638561; x=1701243361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tcoc0DSvSKchwZuSuUbT3hLEeDC/nV1bi2qrbGSOaw4=;
 b=F0I4ta2tkpyTRpnsZwdqjXoV1XEz76hIN355eTGhc+s/9BJCPYyWUHW+OZp6mh3yrY
 4SAepdgCY6uJI/QxG52aZQhTmZ7uhLnZqFvbFGS2xzr52EaLKarJBvTdi/sCwrQ4hlpZ
 9aIwyBoroNewf+4QNIQ+dghY+UZpq5JzgoP8BlUt6iljD0HpJUqscBsOH9K00UOn6A8H
 lQsy8AqXWq7H8us5e9pfo6ugALubAdHHqoOFq4ZPifFd0mr3+1Qcz90sdpJzlaI0FGRf
 YOH/oSWYDXbgBA9w0OQrmqmrqz6vYfhTH0PMnMZEslu1nlDkwLTcz5nvjcc3zkwUdg2R
 Y8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700638561; x=1701243361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tcoc0DSvSKchwZuSuUbT3hLEeDC/nV1bi2qrbGSOaw4=;
 b=WN0kILqd1PtAfxmm/rVvSnA02mVOeQo5qD3z6aBWDsKxOMR74ZPpoHi+NKd0/BY+kh
 6XmOSIffxyqNBAWHfv+CtwLD6oigLbJskbqBuBZ34Xy8FQ/z4OitPD+hHDMmp7bWZP8I
 GSvtsniCGBAEUnvQJ/vCWAFFH+E+GOxMDDD8fIyLnDM/nOHvZj9tV7WAH8LfAabfRYSA
 fZgsgl4dgsvxdxVDH3cvjMTWuoBl0JlWKN+YeJpUexDUTGVw3YzLcN4bziuPsss1I8sT
 6KIzRQPR+odV4Q6w7kEH8NI/U+AuxZdlJ3NE/laOGG9cZ78ya0pKTyk8RWNurKcIv2/M
 w+Eg==
X-Gm-Message-State: AOJu0Yxch7ImHP4YN2+H7pWGUlbyOAl5akThjKxU143ZqUwvbqoNh/3o
 M1BHkjieBvTFTXA6BTUhmm6yyugryFEQFw4cZnunqw==
X-Google-Smtp-Source: AGHT+IHlqG1fflLV4vtlJI+GjvWBR8fdlRz6Cebace3XbOvcpU8C6kosGPAyKJK8m9mm02r3XQhl/CiYQH2L9wLPNrk=
X-Received: by 2002:a05:651c:54a:b0:2c8:8b3a:229f with SMTP id
 q10-20020a05651c054a00b002c88b3a229fmr1251291ljp.21.1700638560827; Tue, 21
 Nov 2023 23:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
 <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
In-Reply-To: <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 Nov 2023 09:35:24 +0200
Message-ID: <CAC_iWjKKas=zkMyJeNvLmcPWh2wjbE=aw_-Nugano3HYWX2+4Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi all,

On Wed, 22 Nov 2023 at 07:23, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add support for specifying the parameters needed for capsule
> > > generation through a config file, instead of passing them through
> > > command-line. Parameters for more than a single capsule file can be
> > > specified, resulting in generation of multiple capsules through a
> > > single invocation of the command.
> > >
> > > The config file can then be passed to the mkeficapsule tool in such
> > > manner
> > >
> > >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  tools/Kconfig              |  15 ++
> > >  tools/Makefile             |   1 +
> > >  tools/eficapsule.h         | 114 ++++++++++++
> > >  tools/mkeficapsule.c       |  87 +++++----
> > >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 538 insertions(+), 31 deletions(-)
> > >  create mode 100644 tools/mkeficapsule_parse.c
> >
> > This patch keeps coming back :-)
> >
> > Can we not add multiple capsules in the binman description? Why do we
> > need a new file format? How can binman decode images produced in this
> > way?
>
> So as Tom mentions, this brings parity with respect to the other
> capsule generation tool in EDKII that generates capsules. IIRC, this
> is something which even Xilix was interested in, and Michal had kind
> of gone through these patches earlier. Lastly, it would be good to
> have support in U-Boot's mkeficapsule tool for generating a single
> capsule file with multiple payloads, and having support for this
> functionality helps in that goal.
>
> Also, you might have noticed that, since your objection to the last
> series, I have removed putting this in binman. So now, this aspect of
> the capsule generation would only be supported through the
> command-line invocation of the tool.

I think that overall the approach is sane. mkeficapsule is currently
supported and compiled for distros, so the multiple payload support is
useful. If we want to add support to binman, instead of rewriting this
in python, we could just call that tool for parsing and creating
capsules

Thanks
/Ilias
>
> >
> > Also, could we get sandbox to produce one EFI capsule as part of the
> > normal build? I think that discussion trailed off.
>
> Yes, apologies for missing out on this. Slipped my mind. Would you
> want, say, all the non-signed capsules to be generated as part of the
> sandbox build?
>
> -sughosh
