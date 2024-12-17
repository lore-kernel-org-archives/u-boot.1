Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF07CE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 23:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4823680295;
	Wed, 18 Dec 2024 00:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJoY5bZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FDF80243; Wed, 18 Dec 2024 00:42:44 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AC180239
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 00:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so9678889a12.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734478962; x=1735083762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fqRAqoHXsdQ7mtM4Kidjs4SMMrDMm2VrCWejM5J/9Eg=;
 b=GJoY5bZuflL3ciDY9qzMKOO/QlzCfnz7CkzgaytFL6+E/Ps5nyybYr508xEydrgfuw
 6OhJ+agufKXlkcHz7JHOVA1nbkxwcN+bPEgFEwmu7bEDSl83/CustQt3FkWyZVz8Sna/
 uts0kb2wMWflDOWp9hIpW13A+2ryYO97gaTVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734478962; x=1735083762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fqRAqoHXsdQ7mtM4Kidjs4SMMrDMm2VrCWejM5J/9Eg=;
 b=hUiZkC2wGSJs5E/j3IBMi2OqjhIBHgXHmmyLUvnfjWxFcZcctrIFr1eM4IVI95IeAL
 uisaHYn0fdUi4xnWp65JuzWPSKV2ar/e04t5U3VboqiGgVaJEgaSlsozE1PY+pkd18ux
 4BMgwqTTy+J3LHp3s3Q8Y9phe2W4PzKRSPvOZdYJqfpz1GotPxniO8Zc9Q+XtFS8rbVi
 0HWGT9r2gx2HXVmgr37ux2weunyyVaQ0dPeQe+Q1vFHYx+C2hoYTDmltL5HASKONkbwv
 v+9MMmltP1rvT9fuCdyrG0jawF6Ub/6j9zAE9I5dGP/Tfxaw436tfNheZIEvbDYQqDWk
 tfMA==
X-Gm-Message-State: AOJu0YzIbgCAHg3/nHaEnu6RWMeWmY/rj50a+ZcK0iRRYSjt22UeWBru
 GYdiUz3sNc5mS9FoXgEMiQ2tSVpWv+VkyGCLF6FWroL/KpWcfIRPg7xYZqQGGS22OzUysuGx2cE
 mWY5MUy23DrYMrAJqds/C4s7G7tuhFNX1D0GGlUtnq9FAJhY=
X-Gm-Gg: ASbGnct+AGe4G/8nZ5LhvB6eemO9GdTlrO+Fe4b/TLhMTflGJlORWV2bHjFwzelvolt
 il1mbCqmwCuPEcIDbVD3awUEiyA8ehnSpqvDzo70=
X-Google-Smtp-Source: AGHT+IHVIEcqtn9bHnB7K8KCuEva0G4Z5f7i73RXGgvXmS79JkOsl0dLEaj7gfr0/GOrSFrnqvnmbeMVEwGsDXvROWw=
X-Received: by 2002:a17:906:309a:b0:aa6:691f:20a9 with SMTP id
 a640c23a62f3a-aabf46f0e6amr53556666b.4.1734478962094; Tue, 17 Dec 2024
 15:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20241217132616.3708573-1-sjg@chromium.org>
 <20241217142016.GK1505244@bill-the-cat>
 <CAFLszTjfxxseCJUvUXPgZQWQYNrL+yT3u8qZ9OieJHxaC=dfDg@mail.gmail.com>
 <20241217195348.GQ1505244@bill-the-cat>
In-Reply-To: <20241217195348.GQ1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 16:42:30 -0700
Message-ID: <CAFLszTgaLn-xO104gw2meFTHBfVdWjPu+AiSXkYcSLM=uYWdrA@mail.gmail.com>
Subject: Re: [PATCH] buildman: Add a way to build a particular target
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>
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

Hi Tom,

On Tue, 17 Dec 2024 at 12:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 12:45:29PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 17 Dec 2024 at 07:20, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 06:26:16AM -0700, Simon Glass wrote:
> > >
> > > > At present buildman only supports building the default target. Generally
> > > > this is what is wanted, but in some cases boards erroneously have a
> > > > different target for product extra files.
> > > >
> > > > Add a --target option to help. Also add a comment indicating which
> > > > letters are free for new options.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > How do you use this? It would be nice to be able to do "--target
> > > u-boot-initial-env" for example for converting and verifying the
> > > conversion of boards to plain text environment. Except the list of
> > > artifacts that are kept isn't updated with that string as well. And
> > > FWIW, is this for a case not solved by CONFIG_BUILD_TARGET?
> >
> > It's related to the problem where colibri-imx8 doesn't actually build
> > an image with the default boot target.
>
> I don't recall if there's a good reason for imx8 not setting
> CONFIG_BUILD_TARGET to something, but that sounds like how to solve this
> problem. "make all" should work, normally.

Even if it did, the build fails the first time. It just needs to be fixed/

>
> > But yes, we could add more things to buildman, e.g. it could output
> > the initial env as a file for later parsing.
>
> Well, your patch supports that, if I read it right. It just doesn't save it.

Yes, it would be pretty easy to provide a flag that builds that
target, runs the executable and puts the environment in a file.

Regards,
Simon
