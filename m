Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E99C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 20:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6DF68249D;
	Thu,  3 Apr 2025 22:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N7vJxpVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B05F8249D; Thu,  3 Apr 2025 22:40:49 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2535E82140
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 22:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2902f7c2aso213233666b.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743712844; x=1744317644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+qHAJGIqu3nWxM3ToRoJGhzsXa3ifnReSjKWxswvByg=;
 b=N7vJxpVYhxnrmsSmd55Ump0ZFlTwakXPHTrLwTAydBqVrN5XehfMZ9D+tToF2ANkve
 3GOop5+Ayvh/5xM71oPQD/GmML1DNjGxOWKToMfurVObwJ6JCgYP0sqNufPAysz6P2gH
 h+fc5CKjBiilRwT7F3TchEVCzm/kNp3SGr0HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712844; x=1744317644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+qHAJGIqu3nWxM3ToRoJGhzsXa3ifnReSjKWxswvByg=;
 b=W0HjrOHnXPLgZ0EjMmx4Cx0yGqQ9r37/FnJxYs7XCdbGiy/OS6hLwTPVrkNC0TAtRf
 tHoiVhj9OTJ73AjzHOl58lUqwddB3tJFCCxisrjLk47xBYfe87dpSSnQ3CSGKLofaqKa
 zgNA0vT4tRG9+Z7i/UN2hUtlT0ymcsRBfIugxIlu7P9IhSrEQNgSEkZnVxfljkZZspZh
 R7tkzQCO2Yx8TZtmGcp553u8zUombJZ4LiwDLydxdwbU9xLOg2afJT2Z0J5Gz196Fp4a
 yqT53n968IwpMDQ7EkFqk9mj2MXjSgoS1hfdjz2QOjyY4dhCm8njhvNm5Xsjyg6yTZMJ
 PNoQ==
X-Gm-Message-State: AOJu0YxPZxLSzyRLYfZLJKGrkmKHpBu5OgoKPaLiMb+GGy79qjpteHS7
 LDrfSsnnAValNjvn8aWXrgB/ePedGqeMkuHMBPVyrZXmHbDVca7RRTGFNrrwbcFj15tc221GTfu
 jsz8ermDyVrzdFxCaUz9gOWmBhlTgXbn8/z9DKNUiuEt1dd1upQ==
X-Gm-Gg: ASbGncui5EA8cEcMTvo5h7pfTBVnSRFwCZWn1gMFAh6yXo1rZVqj054KF640UYe9/W0
 5i+1VrxNPKxkllemeeOY1DqXlpCByGpXIOSYesqyw1XIQyM3VEwuQhTdX/VR1y1Q7Or+76axI5B
 JO9y2G98jyL0T8NxwKuwfGjIKVwqYolLayXd3FVkM=
X-Google-Smtp-Source: AGHT+IEFU+A/mr4ROn3mlGlVu3yOkT0rvCCsfnEFzhDsz/T4dQLDMHP75VouBmCP0gnf5LNmPoxpjCOrvdeh4QG/5ks=
X-Received: by 2002:a17:907:7292:b0:ac7:16ef:e994 with SMTP id
 a640c23a62f3a-ac7d6ec73camr6750266b.56.1743712844339; Thu, 03 Apr 2025
 13:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
 <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
In-Reply-To: <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 09:40:29 +1300
X-Gm-Features: AQ5f1JrRP01k6CnsMPqszDBTpK2H-tuFKUvyOIGuK7ZIMU95jTKyBN4ynHMDkgs
Message-ID: <CAFLszTjGn1JGdpNAZVL6CC+pQLsOrG6gjmo8kRzjbnR_=6CMvw@mail.gmail.com>
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

On Fri, 4 Apr 2025 at 08:54, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > so that it is simpler to understand and manage.
> > > > > >
> > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > >
> > > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > > > mandatorily use bloblist to hand over everything between boot stages
> > > > > including fdt, creating OF_BLOBLIST is not necessary.
> > > >
> > > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> > > > there must be a bloblist, not that it must contain a devicetree. So I
> > > > wasn't sure about removing it.
> > > >
> > >
> > > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY is
> > > selected, we can override any fdt from board or env with the one from
> > > the bloblist.
> >
> > Yes, but we should be explicit about what is going on here. With
> > OF_BLOBLIST we indicate that the devicetree is coming from the
> > bloblist. It becomes one of the sources for devicetree, like
> > OF_SEPARATE and OF_EMBED
> >
>
> BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will be
> mandatorily used and override other fdt sources like from the board or
> env variables.

So long as you are OK with OF_BLOBLIST as well, I have no objection to
keeping BLOBLIST_PASSAGE_MANDATORY, although I don't like the name
very much. But I can see why it is called that as my standard passage
series was actually never applied. So I suppose I'll need to have
another try at that.

So to be clear, I want a separate option for devicetree, called
OF_BLOBLIST, which I can enable/disable as needed, without affecting
your option.

>
> > > Moreover, it is not just for fdt, but for everything that is being
> > > handed over from the previous boot stage using bloblist, but
> > > OF_BLOBLIST is for fdt only.
> >
> > What other things are there?
>
> All transfer entries defined in the Firmware Handoff spec should be
> handed over via bloblist, for example, TPM event logs.

OK, again no objection. I don't see any code for that though.

Regards,
SImon


>
> Regards,
> Raymond
>
> >
> > > I don't think it is a good idea to replace BLOBLIST_PASSAGE_MANDATORY
> > > with OF_BLOBLIST.
> >
> > I am OK with keeping BLOBLIST_PASSAGE_MANDATORY for now. This series
> > does not remove it.
> >
> > >
> > > > But actually, thinking about it just now, we can remove
> > > > BLOBLIST_PASSAGE_MANDATORY, since U-Boot won't make it that far if
> > > > there is no bloblist. It will die in fdtdec_setup(). Take a look and
> > > > see if you agree.
> >
> > Regards,
> > SImon
> >
> > > >
> > > > >
> > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > be resurrected to give some coverage.
> > > > > >
> > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > > >
> > > > > >
> > > > > > Simon Glass (4):
> > > > > >   bloblist: Simplify bloblist init
> > > > > >   fdt: Introduce OF_BLOBLIST
> > > > > >   bloblist: Provide access to the FDT address
> > > > > >   fdt: Obtain the FDT from bloblist without parsing it
> > > > > >
> > > > > >  arch/arm/lib/xferlist.c            |   6 +-
> > > > > >  common/bloblist.c                  | 102 ++++++++++++++++++-----------
> > > > > >  doc/develop/devicetree/control.rst |   3 +
> > > > > >  dts/Kconfig                        |   8 +++
> > > > > >  include/bloblist.h                 |  16 ++++-
> > > > > >  lib/fdtdec.c                       |  65 +++++++-----------
> > > > > >  6 files changed, 116 insertions(+), 84 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > >
> > > > Regards,
> > > > Simon
