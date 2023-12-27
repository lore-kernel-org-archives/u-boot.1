Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA44C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA79878DB;
	Wed, 27 Dec 2023 08:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RWjKAqRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB37878DB; Wed, 27 Dec 2023 08:55:49 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 963AE878E7
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6803466a1ccso10212036d6.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703663742; x=1704268542; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xe02f8gts957zQmo3qHZ8/LkcgZ6iqzFKUr+psTGqHs=;
 b=RWjKAqRCuBbIuh9BqKIO5joktXSYamjfHqMKsk8HDotg2jmMQ6oKjXt4TZZ9nUXaki
 iyedduBSogZypgD3c/aa0gcCf9FoXTBky2m9NNsgYha9DAsl8NNYDmZpafhJh4I1cTCY
 dubFVWYhMTeJ7wrxkF8QH4xFZqInagcIrw1Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703663742; x=1704268542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xe02f8gts957zQmo3qHZ8/LkcgZ6iqzFKUr+psTGqHs=;
 b=r63ZnxyAF+Kt/eQhtZv/N94Bontjx7LNbSjt7i1h9Lg2wce7CYmCSMHAGg4gABKTsg
 cqv3rLOkEYLtI8HpLXcXSFz46l1gg2L37D+DgBl4BZsS5r1+3/eSUVp5zZvWz+L734dA
 YfMtieVq94ArnNbrH8wgq8Z2E8fjWG6w5IXaK+n6Gnb4eDWY4xXiC3newOkN9+5ci/jr
 Jue+cTaHe8nbGxcUhCU5xt2KGq7utmnPoYmxNXIVdhbKGhcFfwpeyUo0jRnZZBFceAdA
 5fXxGuS9RAowS6D1DrfbLcdKQ8vXw41xxO3yCTvJEHd/YA9HuLF4+rkGQRmq9ciRt80U
 kRIg==
X-Gm-Message-State: AOJu0Ywpe3PeQukjstBBOWcgRYVZVx45bcY8uMic4KQbDofHVAhH9QiG
 YZvUQqvHufKTKRosD2jt0LouabpFSn/UboLYZWgGGoVZU+/b
X-Google-Smtp-Source: AGHT+IHSplKOn7j58iJ/D9umh9JsoR3PeRP1B8K/Ii0L//2a9Nnq/8C5jVEfdyOXsexdegjHzjZVYMcCGY4/E8b4bEI=
X-Received: by 2002:a05:6214:dc1:b0:67f:1f0c:b30e with SMTP id
 1-20020a0562140dc100b0067f1f0cb30emr13030206qvt.32.1703663742784; Tue, 26 Dec
 2023 23:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-4-sumit.garg@linaro.org>
 <CAFLszTiPbM-fofbNaTO3vtTWNTOee_pO7-_obKxmP=oChD-8oA@mail.gmail.com>
 <CAFA6WYO=2Ba7FsXh7=Eg_J77w=sVmxOC-_=XNQH4JaquQoBPSQ@mail.gmail.com>
In-Reply-To: <CAFA6WYO=2Ba7FsXh7=Eg_J77w=sVmxOC-_=XNQH4JaquQoBPSQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 07:55:32 +0000
Message-ID: <CAFLszTgeHGyVXs0HChZwRjtaJT8YBft11hs98vopQyR9f_YH4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sumit,

On Tue, Dec 26, 2023 at 10:09=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Tue, 26 Dec 2023 at 15:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Fri, Dec 22, 2023 at 6:12=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > Allow u-boot to build DTB from a different directory tree such that
> > > *-u-boot.dtsi files can be included from a common location. Currently
> > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > location.
> > >
> > > This is needed for platform owners to start building DTB files from
> > > devicetree-rebasing directory but still being able to include
> > > *-u-boot.dtsi files.
> > >
> >
> > This is a v2 patch but I don't see a change log?
>
> I usually prefer to keep change logs in the cover letter [1].
>
> [1] https://lore.kernel.org/all/20231222061208.3009970-1-sumit.garg@linar=
o.org/
>

As a reviewer I much prefer to see the changes with the patch. If you
use patman you can have both, I suppose.

> >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> > >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >

Regards,
Simon
