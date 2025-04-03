Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6273AC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 18:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0668215F;
	Thu,  3 Apr 2025 20:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OiuX3ZVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A80182139; Thu,  3 Apr 2025 20:18:20 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA02B8215D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 20:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac289147833so184682966b.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743704296; x=1744309096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=itu0c/dj1Bqpisf+2G9EvlD3Hz0yC/l2MPhmTY5hcFM=;
 b=OiuX3ZVfwFIiqnIUluN91pZD1a7W79hT9YqzcC+cA0AyRm9/RM1Zpkt1146nTDhCcc
 BCi9+N9ulJ7xoKpQSRcwaxT5CNNE0mJPcTQlBFFNEPKp36qmlMe2Z7Mrhtaqnlap0x4c
 aRDI3MTy9+CzNqMmqSEW+aWlqJ1+u9hoe/EWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743704296; x=1744309096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=itu0c/dj1Bqpisf+2G9EvlD3Hz0yC/l2MPhmTY5hcFM=;
 b=GR7587FkAr9GoiaYYj9RVm0lu/B2gaezLs9FpfvPzo05l4RkoAgenvpq5dKmE7HPLl
 KzbuNx4yadFuTaEvcT8L9m2w+w55BSlQBdyCeaK9q5gDZN3MeveArgZDogga6ojkRDkw
 0he0vz1mjyO1U0Xnr+yTAE2+fO+/dG5IHiEPXqVBiJUOndNg7klvA3Orv/NGkvLOWoVJ
 zOnnZiSDWEPuBJpcQl+JbUmWNmPPkd6xXxfPyldxxeUbzVtr+VOi/rIXHkjyP3YX2pMA
 qAK6DDgZBXg4mjy2N9AQSBiy9PoKllcrz21rUsnKu+yfb1a/apWafYNORkaKE5ZIRBw6
 NGag==
X-Gm-Message-State: AOJu0YwyDrEzmlmkcBVvq05jXfzmMFiRg+wAkcGbGoDjMooNiToHAHKI
 R25DSy1I7QK0eSkzpOto14GvmwPPvp5O/0sne1YYLABs7k50mqa2ZhC+VzvEzsAm5jVbOR/vL6R
 MivgUvsXWLgcLVan7QErv9qisERsbQutAyS0n
X-Gm-Gg: ASbGnctgAI6+12Z8YxFYdidVv1XF1crAZASvoFdotL6RjQSNAIxr8S6T8s9HsuIMJKC
 1aXgRnwxmsh3PTmTKPYNOCqhgQvysgL6bWw4QnBxppiKQHZ8xSOcQFGZqT1HwocXrQ5qDB8PZ5T
 wrZHMZVdct0WuoziC+74KGTj7QEvFx
X-Google-Smtp-Source: AGHT+IG1cZ6WphpO8o+OGg6iL+T+D0pv75BzmcKLl74Fj3I61CO7kKCB+u10Y3h0ocE63idDYWMUGxIq8eEJ2mpYWrE=
X-Received: by 2002:a17:907:3e1f:b0:ac3:446d:141 with SMTP id
 a640c23a62f3a-ac7d1bcf83bmr43857266b.47.1743704295680; Thu, 03 Apr 2025
 11:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
In-Reply-To: <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 07:18:03 +1300
X-Gm-Features: AQ5f1Jqp_uGt-gXLXrrElrGowKN99wHTc0pxmEm9XZbvciGdJIG2FEf8JGBnFbg
Message-ID: <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Raymond Mao <raymond.mao@linaro.org>
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

Hi Raymond,

On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > so that it is simpler to understand and manage.
> > > >
> > > > - Unwind some of the nesting in bloblist_init()
> > > > - Avoid needing to init the bloblist just to get the FDT
> > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > >
> > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > mandatorily use bloblist to hand over everything between boot stages
> > > including fdt, creating OF_BLOBLIST is not necessary.
> >
> > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> > there must be a bloblist, not that it must contain a devicetree. So I
> > wasn't sure about removing it.
> >
>
> See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY is
> selected, we can override any fdt from board or env with the one from
> the bloblist.

Yes, but we should be explicit about what is going on here. With
OF_BLOBLIST we indicate that the devicetree is coming from the
bloblist. It becomes one of the sources for devicetree, like
OF_SEPARATE and OF_EMBED

> Moreover, it is not just for fdt, but for everything that is being
> handed over from the previous boot stage using bloblist, but
> OF_BLOBLIST is for fdt only.

What other things are there?

> I don't think it is a good idea to replace BLOBLIST_PASSAGE_MANDATORY
> with OF_BLOBLIST.

I am OK with keeping BLOBLIST_PASSAGE_MANDATORY for now. This series
does not remove it.

>
> > But actually, thinking about it just now, we can remove
> > BLOBLIST_PASSAGE_MANDATORY, since U-Boot won't make it that far if
> > there is no bloblist. It will die in fdtdec_setup(). Take a look and
> > see if you agree.

Regards,
SImon

> >
> > >
> > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > be resurrected to give some coverage.
> > > >
> > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > >
> > > >
> > > > Simon Glass (4):
> > > >   bloblist: Simplify bloblist init
> > > >   fdt: Introduce OF_BLOBLIST
> > > >   bloblist: Provide access to the FDT address
> > > >   fdt: Obtain the FDT from bloblist without parsing it
> > > >
> > > >  arch/arm/lib/xferlist.c            |   6 +-
> > > >  common/bloblist.c                  | 102 ++++++++++++++++++-----------
> > > >  doc/develop/devicetree/control.rst |   3 +
> > > >  dts/Kconfig                        |   8 +++
> > > >  include/bloblist.h                 |  16 ++++-
> > > >  lib/fdtdec.c                       |  65 +++++++-----------
> > > >  6 files changed, 116 insertions(+), 84 deletions(-)
> > > >
> > > > --
> > > > 2.43.0
> > > >
> >
> > Regards,
> > Simon
