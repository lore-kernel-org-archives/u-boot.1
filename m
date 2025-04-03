Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4212BC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 18:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172D482139;
	Thu,  3 Apr 2025 20:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b8cZ9/r+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD1082140; Thu,  3 Apr 2025 20:13:04 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A63E8212F
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 20:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so1181860a91.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743703980; x=1744308780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4LK1gkxgLzmEh++/CMaR8zctgJYSTpnpTH+CPpbhFYg=;
 b=b8cZ9/r+ifRoxdIs6HTWEulHrFzRYwRXmHU9QPt0zS1xHouXt38+/uaFToWltzJ/CU
 2DEfUaoY/+bubiZxhcAGfffPHfLWtaCF0hOxz6/lKiAUegrj6xLc1nAkgGI4TN3YOBl9
 zTvmmVEFl852jArYxqs2eU/uqaNOmO9UFwGe2XtaV2/rlh5zMUDUvxpAtipF8RaAJYIS
 ZWib2YqiE43FO0oJfnwgnsPEvPojg/dmFK+MNtgVSdjjA/LxKEYdJfTyFiQ9woSR7WqJ
 iDz7HY0NKw6DlQPYULXNZxTvMp+1izRjcRNfmXxal+sh+8RhGLcmx3pia7D71IgqWJco
 dHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703980; x=1744308780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4LK1gkxgLzmEh++/CMaR8zctgJYSTpnpTH+CPpbhFYg=;
 b=r+nGEwSorlwxCqKFfODIhKL7rx94rKSqhRRiT0f0NKtmt2ln3ZGXKbg59BbqqD447/
 Y9nQeClCabHurYxvlGEz8GZ9piPKE0TaG0K1k+BdajznzDaPfRIEX9O4iDX7AyOiRQpT
 kmh1YhKNiBkZBYacimyb7QyzHzCvPx7Xk6Sx3SSgBWc4UQn9/5XLQpjPCyf5gBvL/4hf
 DOtZegGTzcpD8+DirPMQDeJheNaz48X96sjACJKH04Fe5TcOYjr0uJjGDJQ51xHu86u2
 LgTM1RkRvj55q0i1ervJKIMWaOQ/nKZGmvW/nd7s/EDBLZEOMCKBJtGF2SGj96diPAs4
 XO8g==
X-Gm-Message-State: AOJu0Yy8vepFNxYRW3bw1AfPy5gY8ypcI2ZFUfA9H1L1LKKZGy8fTG/G
 wV0M/EmJZt6R9TGGKKF6yiTuKUq7fGrCZzVvzKTyjmq4zcQK+G/nR5gd75sHECt0kCC4JV/eU5G
 O98iWl25XsmSAlj/wSiVpk0SRzDHdil3cMVXS0ZSx39ah1gwKdXc=
X-Gm-Gg: ASbGncuOlOiZzcWd4JZYZ/ywfqlqn3JCtxZokum+W1HTn3vCFqpbT1MWgEetjAo2OqR
 71X3BBOOuQoC5az3nZD1AoyOHyRV7iKg7QHQRsZjjeLopiXyQzbVni22N/WFfro/o4V//yKWih+
 cy3AGCyZ6IpWIiRg2Sq6NuxlP6Gck=
X-Google-Smtp-Source: AGHT+IEqagcKTPFwZdT36vDhcKFAliK2/xzLk34kMFcrZrOupe1RYi7GH+1PoueiVdWBpwFGD1UJpq73VgB7zhutHMs=
X-Received: by 2002:a17:90b:51cf:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-306a4856ec7mr703739a91.1.1743703980528; Thu, 03 Apr 2025
 11:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
In-Reply-To: <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 3 Apr 2025 14:12:48 -0400
X-Gm-Features: AQ5f1Jo-5HxJ6RVvCgLIAKMpIab0ooNXhvVkBxEQ9mnZ5Rx2kbjPShVp1TjccMM
Message-ID: <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, mason1920 <mason1920@use.startmail.com>
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

On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The bloblist code took what I consider to be a wrong turn a year or so
> > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > so that it is simpler to understand and manage.
> > >
> > > - Unwind some of the nesting in bloblist_init()
> > > - Avoid needing to init the bloblist just to get the FDT
> > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > >
> > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > mandatorily use bloblist to hand over everything between boot stages
> > including fdt, creating OF_BLOBLIST is not necessary.
>
> Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> there must be a bloblist, not that it must contain a devicetree. So I
> wasn't sure about removing it.
>

See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY is
selected, we can override any fdt from board or env with the one from
the bloblist.
Moreover, it is not just for fdt, but for everything that is being
handed over from the previous boot stage using bloblist, but
OF_BLOBLIST is for fdt only.
I don't think it is a good idea to replace BLOBLIST_PASSAGE_MANDATORY
with OF_BLOBLIST.

Regards,
Raymond

> But actually, thinking about it just now, we can remove
> BLOBLIST_PASSAGE_MANDATORY, since U-Boot won't make it that far if
> there is no bloblist. It will die in fdtdec_setup(). Take a look and
> see if you agree.
>
> >
> > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > CI at some point. In the meantime, the standard passage series[1] could
> > > be resurrected to give some coverage.
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > >
> > >
> > > Simon Glass (4):
> > >   bloblist: Simplify bloblist init
> > >   fdt: Introduce OF_BLOBLIST
> > >   bloblist: Provide access to the FDT address
> > >   fdt: Obtain the FDT from bloblist without parsing it
> > >
> > >  arch/arm/lib/xferlist.c            |   6 +-
> > >  common/bloblist.c                  | 102 ++++++++++++++++++-----------
> > >  doc/develop/devicetree/control.rst |   3 +
> > >  dts/Kconfig                        |   8 +++
> > >  include/bloblist.h                 |  16 ++++-
> > >  lib/fdtdec.c                       |  65 +++++++-----------
> > >  6 files changed, 116 insertions(+), 84 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
>
> Regards,
> Simon
