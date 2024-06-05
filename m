Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A8C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 13:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 006D4882E8;
	Wed,  5 Jun 2024 15:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lOfsBwI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BD7882E8; Wed,  5 Jun 2024 15:31:46 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3846388261
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 15:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c2865e2a68so455186a91.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717594303; x=1718199103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O0sJ8YQwbCwKznFdVH75vE2jxmW6arhXV7HEUQPUE6g=;
 b=lOfsBwI7eWJIonl+0R6HGov9fK1hY8aEmd4FWW10V5gP5/MLf1K9RoBU/yBfgNqZdN
 ytfr48ISmbZRTJBi+1wW+AE/rUb28FERgYXHqVuGPsS1njpFqu/TlgeN2s4mpaalWKBg
 3LSLwz3WBcM76Shi2LXL1n7Ln60WDIQdQT/vtCT1ev7ZTKjMjokRXgD+kGOufRA3Vvdr
 L0JsA9BdkMWhrqGvXGaHELNY1rdXDDVJpx48AnczXt71h4z8cORnexfl9Za1ogL+2z6q
 mdWb3r+jwv1q5MoPjISFNK8H11ft+xfAhZqrGzt1wrcUnGCNTZX6h//M5esPkOwds7fV
 u8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717594303; x=1718199103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O0sJ8YQwbCwKznFdVH75vE2jxmW6arhXV7HEUQPUE6g=;
 b=vbUDP5nQvHZ0y1izIll38ugXG7F35aZNK4Q1AiqsK70tlwO2eBtVYafnlPs+jmj9rU
 eCKl+wNC/eLhxUg31luBP+NPCXqvJjZFnK5pvIcIHImz8jINc0l4xf89YjUsCBFGrLqP
 vyZzCNYIr+U+FfTsV+ucdvUV+PtHMImddBhe51mW1zFTLN4/OZMTBtgw8bJ5GPfoGLgC
 la7XGuahTdcnDyfb9tMoGPJhgvRk5nsWYDE9LcojO2aWZACiHhSWLgUNsA6BqGZDDwHd
 TNejMDfAs1wly71LFtBahZTcg3On14p3xweNGybmNbzUR22rSVqW+ncpJdcqPEnzdwM+
 3mYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW22wpfKvsa6sVwyRSvVRgHjg0y8qtih8FgTNRQkiQbxouhCyT6VIR6XnixDOUr4WGyZkxuNiWrwzgMMODfG+4q1VN4PQ==
X-Gm-Message-State: AOJu0YyUPHA4FFctOtG3RF9L9dfT5kKZ1jqt1Kt5RmoMMNG73K2Y+jKL
 fKPB9uZUM3ILdqUzsxiaFF1vPqBdcmOVakbh92QjY1ZpkYz8fzZLN2ohVrjNbr1PJPcCAKtlq3a
 sZntrb2TXrCHo4C7o626alZAPwNXkej3RAvqLgg==
X-Google-Smtp-Source: AGHT+IEZij0HZe5vfbzer+G20FzYR7GRar3cvlNuAfb+EnFx+98KbInTJ+aeYaPaAAsKrnT9awaOb+KyFyyhYg3pUxI=
X-Received: by 2002:a17:90a:df89:b0:2bd:9319:3da1 with SMTP id
 98e67ed59e1d1-2c27db19e1emr2767295a91.25.1717594302467; Wed, 05 Jun 2024
 06:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
 <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
 <ZmAwMGCXZQbhoK0P@smile.fi.intel.com>
 <CAC_iWj+PpUurGLqMw42ALHV6fOLnSwscG4KB2k-55eO2HuLwCQ@mail.gmail.com>
 <ZmA7NgxcSS315jrK@smile.fi.intel.com>
In-Reply-To: <ZmA7NgxcSS315jrK@smile.fi.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 16:30:58 +0300
Message-ID: <CAC_iWj+B+X2BQP403X6wz7dj2HHUO_j0rXb=TjAwh6zCMEgGNg@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Andy,

[...]

> > > > > Is this approach maintainable?
> > > > > I don't remember if we have similar in Linux kernel, for example.
> > > > > (There are few candidates like compression algorithms that are usually
> > > > > being
> > > > >  hosted elsewhere)
> > >
> > > No answer?
> >
> > subtrees is what was decided on OF_UPSRTEAM as well. If you have a
> > better idea feel free to propose it, but for the sake of conformance
> > we are better off doing the same thing on every external tree we pull
> > in
>
> How do they will (or already do) maintain this?
>

There's a script to do that in dts/update-dts-subtree.sh

> At least it's a good to have a few words on the choice made in the cover
> letter, so we will have no questions on it.
>
> > > > > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > > > > we need to convert the CRLF endings to LF and do a commit manually:
> > > > > >
> > > > > > $ git add --renormalize .
> > > > > > $ git commit
>
> ...
>
> > > > > >  lib/mbedtls/mbedtls_def_config.h | 4262 ++++++++++++++++++++++++++++++
> > > > >
> > > > > This is ridiculously HUGE! This is unreviewable. Moreover, this is even
> > > > > hard to
> > > > > configure by the user! Can you rather make it modular and maybe create a
> > > > > separate documentation for the most important options (I do not believe one
> > > > > needs _all_ of them to be set / tuned)?
> > > > >
> > > > > This is a file from MbedTLS and follows its own style.
> > > > And this is how MbedTLS is configured - with all features listed in a
> > > > config file and
> > > > commenting out the unused features with "//").
> > > > The modification here is just to control those existing options with
> > > > Kconfigs.
> > >
> > > And why should we blindly follow this nonsense?
> >
> > It's easier to follow up future changes tbh. But I do agree the config
> > file is huge. Perhaps splitting in 2 files is going to be easier
> > mbedtls_def_config.h -> contains all the options that rarely need
> > tuning, which I assume is the majority of the header
> > mbedtls_usef_config.h -> contains the imporant options, crypto,
> > checksum algorithms etc
> >
> > Thoughts?
>
> The problem is on who decides which are "rarely need".

Us. Sure it's going to take some time, but eventually we should be
able to isolate options that rarely need a change

> The feasible (to me) approach is to split per domain. Like you listed at the very end of your reply.
> We can also learn from managing MTA configurations, such as Exim4 where user
> may decide if they want a single file or split version.

I am not sure tbh. Let me backpaddle from my previous suggestion :).
Looking at it closer config.h is copied from mbedTLS, commenting out
features we don't want.

What we could do instead is either trim those comments out and only
define the options we need for now. That would make the patch easily
reviewable. If in the future we decide we need a more modular
approach, we can retrofit it without breaking anything.

Alternatively, we can undef the options we don't want in our header,
but I am not sure how often these change or how scalable this is going
to end up being. I prefer option #1

Regards
/Ilias

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
