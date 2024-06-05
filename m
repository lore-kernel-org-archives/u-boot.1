Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F8DC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36653831A2;
	Wed,  5 Jun 2024 11:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ojTg3N6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A38188303; Wed,  5 Jun 2024 11:36:18 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C62879F3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso4078372a12.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717580174; x=1718184974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Es6SaXIZURA7bU8Kbs9X2C4kjrtdoVvqsoDMlVFZDc=;
 b=ojTg3N6o4smrB98iD+uzNeF7pwpNxw9/gPxvbrdaVDOFc1XCv3cM/BkbbwjjiKr8kM
 y9RoKQOgGRSA/sC0Ff0cKcMo3hfZhSc+OCKfJ2XsPqwljK088oF/BjrWXPekmSLhtOtr
 4Amuk8fXUd0VZ3k5dEIpnblgFUw3Qzj1uBFqRno5dD5bvq/TJl7moxIBAG81yEoj7Ryd
 /1xIujxamgHXja4JuzGqnINmERQdlksoO0rMQMwmVy+hQQCqpi6YdoIrxtWzc4UlU+3d
 YmPMBlzPjx8rAwizav7ZaJyRphQ/fDgdGPiRv0/8la5wOo3UxL2vyzm2VvdID/XTlN2L
 oJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717580174; x=1718184974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Es6SaXIZURA7bU8Kbs9X2C4kjrtdoVvqsoDMlVFZDc=;
 b=Pb1m5yVc+11mGRxZywxbl8/OMRbKP4pcgnffbfJdLDk3qe05Nj6x6daAosJopCTR7g
 iSg8SAsRlhPVPgggIFx/ePjuwBRcH4cWvzkJvTGhBgM8egSnKO9K8XVkf5sezL+1T9Zr
 zdxYxDPfRqZGT7A0nUcf97RqKwuZAG2vXou03WlLc4ixOLn8TI5iNwa4PFfyu6NCalgs
 b7X1D/qsN7EOssZRTEodp8RAlgVC+1kTIug0+rVjaj+HXN3fkKOFV7fxQmmA7ieHmLP1
 adXC2jcFIC7h+ThRWHKdbTUgtGh3KzwVCpgdP+I/Szxa0ZcrBpj5TTBCqft94GoNtaYd
 5bRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ7Xwv95AOkorwiHkBwxhYuvkfh/XoE9o4VDm+Y/ZY0IodnFcxkwlpMotrgCgjYHR4ZuFQu8hl+M8IhSddzqaQesQA1w==
X-Gm-Message-State: AOJu0Yyb9azTW24aATvUG5oJLN0s87y4eaegObz3WHG2I+M9gEsJkAhj
 QonSI4t8a+t3ESnFw2RJSd5wfQVyN7geDYYBO0+VL/Jxhtr3P3d8xB4fAyOqxArcfqnql6yNeNj
 rHMG/ol7KpUgKdF0zp+ctDzGOs4pEPp/VTX9lYA==
X-Google-Smtp-Source: AGHT+IHfy7HDkp2XwbTYxmRdcw+NCvdf4XogTU+COT//bAtemHeGAWqLtkHu2HHQlqv4DAf73bE02bdxiSw0w0r7c9c=
X-Received: by 2002:a17:90a:d196:b0:2c2:299b:15c6 with SMTP id
 98e67ed59e1d1-2c27db6b5b8mr1842270a91.40.1717580173882; Wed, 05 Jun 2024
 02:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
 <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
 <ZmAwMGCXZQbhoK0P@smile.fi.intel.com>
In-Reply-To: <ZmAwMGCXZQbhoK0P@smile.fi.intel.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 12:35:37 +0300
Message-ID: <CAC_iWj+PpUurGLqMw42ALHV6fOLnSwscG4KB2k-55eO2HuLwCQ@mail.gmail.com>
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

On Wed, 5 Jun 2024 at 12:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jun 04, 2024 at 05:50:08PM -0400, Raymond Mao wrote:
> > On Tue, 4 Jun 2024 at 16:17, Andy Shevchenko <
> > andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
>
> ...
>
> > > > This patch series requires mbedtls git repo to be added as a
> > > > subtree to the main U-Boot repo via:
> > > >
> > > > $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > > >       https://github.com/Mbed-TLS/mbedtls.git \
> > > >       v3.6.0 --squash
> > >
> > > Is this approach maintainable?
> > > I don't remember if we have similar in Linux kernel, for example.
> > > (There are few candidates like compression algorithms that are usually
> > > being
> > >  hosted elsewhere)
>
> No answer?

subtrees is what was decided on OF_UPSRTEAM as well. If you have a
better idea feel free to propose it, but for the sake of conformance
we are better off doing the same thing on every external tree we pull
in

>
> > > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > > we need to convert the CRLF endings to LF and do a commit manually:
> > > >
> > > > $ git add --renormalize .
> > > > $ git commit
>
> ...
>
> > > >  lib/mbedtls/mbedtls_def_config.h | 4262 ++++++++++++++++++++++++++++++
> > >
> > > This is ridiculously HUGE! This is unreviewable. Moreover, this is even
> > > hard to
> > > configure by the user! Can you rather make it modular and maybe create a
> > > separate documentation for the most important options (I do not believe one
> > > needs _all_ of them to be set / tuned)?
> > >
> > > This is a file from MbedTLS and follows its own style.
> > And this is how MbedTLS is configured - with all features listed in a
> > config file and
> > commenting out the unused features with "//").
> > The modification here is just to control those existing options with
> > Kconfigs.
>
> And why should we blindly follow this nonsense?

It's easier to follow up future changes tbh. But I do agree the config
file is huge. Perhaps splitting in 2 files is going to be easier
mbedtls_def_config.h -> contains all the options that rarely need
tuning, which I assume is the majority of the header
mbedtls_usef_config.h -> contains the imporant options, crypto,
checksum algorithms etc

Thoughts?

Regards
/Ilias
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
