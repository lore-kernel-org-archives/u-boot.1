Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5939DC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 19:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9848215D;
	Thu,  3 Apr 2025 21:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nZOBmfvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A996982162; Thu,  3 Apr 2025 21:54:37 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFAC82139
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 21:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3014678689aso1107328a91.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743710073; x=1744314873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPJAmVGp9h6oCgeKB5dW2b1OOn0Et8ZXbMxPIv6DUQ8=;
 b=nZOBmfvwCAradI4I+UzVt/Oa3td4n0d/eV56IklZTF6QPc54tKhWVc3TeUxzDBHkYl
 ic3dnk+mtTVQREfVnuRa4udeo5kRZ64JpxJerhMCfVCCHEhfmMGXBJh/QfjyqYqc0iPO
 YNDRFhx+Grcq1HvnApmXNCTj/W2zVY4WOBdFm5tdOeM9ywTgf+Xx36FRm3fxnN2u8dOz
 iDp6KkKNwMfVeSnUtiSf0v8JS8PtLis+WImo77cjpVr1b8E8214BD+HF4JgLWPsLCV+t
 xobPQvBRUQMdml0yILewnthMRWIAu8O4ilP936fIOYOVpmJAienCb6mEPvcDxDQriyIP
 uGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743710073; x=1744314873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPJAmVGp9h6oCgeKB5dW2b1OOn0Et8ZXbMxPIv6DUQ8=;
 b=Gb7tKwASVHErP2z2Hau4+kS9xS8knk7KAa4PGZ2at8MBRNU7OstZQH91IWfzncOh5X
 zUSJfW6ADNM8miuVPWSWYaKVVV9SDrgzh6d6Oe5OCzaKvxwt7k06llWB9GtMjfve7vCX
 xV70Sr4Prt6ep1348b1FzG1m85W88JtbAr9IyA43tx/+bX3MqyNQ+ajbyVmOlJpWcI3/
 3HK16T/AnPXd6rlfC2oZ3XuzlAQtJR8gIadJfZQtwqTVjiiGnQeCX0AcU7UqTTTNwkn0
 9Qs1Yv9A1IPszsD2QSZuje0jM3TrfwYI5DwM9Wts04U+kINca8/pEHEOsePFCggxlfbn
 FsPQ==
X-Gm-Message-State: AOJu0YyaChw3urc9mZDXetiCa3fEhZ712BoJap+jQZlbGREdEBxvZoiq
 zWeGWQjdvUhq+hCdGFZeIqkM+5qIghAHVdghOwufGPfzFZDNNRomH4blMB/mxlfPAAhSVL6iYYe
 pwi9z/kWBhCmMHJI/wOT0h8oo3F802zJ7eSHAfQ==
X-Gm-Gg: ASbGncsrkJMP2ssgNu2qViWCPQmtF/yiRGr/v4BgNSSceUhmJD8SOy54bQeI15gxibZ
 IIt0i2P9kVUC/kmPAecqjwslabKzk1fNTMPM+w4lFj9wBjhszCxGn5bYiKQol377DDO9QnUrRc2
 dpHgSj0wKPc1Of4FFBD+b0pMhi5aY=
X-Google-Smtp-Source: AGHT+IF2MnWF9Hnm3fgM157EaTfOci0RT7taw8js0c4mtqjmxTstpwj40fGghdfjJ1VU5QREOrU0QBB5STo8e7yk9lg=
X-Received: by 2002:a17:90b:2748:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-306a476d313mr1536826a91.0.1743710073309; Thu, 03 Apr 2025
 12:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
 <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
 <CAEfUkU+OHK3GdqROVFe4J0=OoRsw_u7znef6iLuibY4vsLOBkQ@mail.gmail.com>
 <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
In-Reply-To: <CAFLszTgjKXK6adB2fa3S4o+AAm1Amyg5WdJ9EuOg4xoXBFLeCg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 3 Apr 2025 15:54:22 -0400
X-Gm-Features: AQ5f1JponVkdcPogmijxneay1X6dpIoUqYtbBO5JlhEm8aMHM2o7SuRxy5nQSdM
Message-ID: <CAEfUkULg0bzG564_vo43Bta5C4_EirZNt39ncgua0VFjd1C-tw@mail.gmail.com>
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

On Thu, 3 Apr 2025 at 14:18, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Fri, 4 Apr 2025 at 07:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 3 Apr 2025 at 13:57, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > so that it is simpler to understand and manage.
> > > > >
> > > > > - Unwind some of the nesting in bloblist_init()
> > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > >
> > > > We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> > > > mandatorily use bloblist to hand over everything between boot stages
> > > > including fdt, creating OF_BLOBLIST is not necessary.
> > >
> > > Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
> > > there must be a bloblist, not that it must contain a devicetree. So I
> > > wasn't sure about removing it.
> > >
> >
> > See my comments to your [2/4] patch, if BLOBLIST_PASSAGE_MANDATORY is
> > selected, we can override any fdt from board or env with the one from
> > the bloblist.
>
> Yes, but we should be explicit about what is going on here. With
> OF_BLOBLIST we indicate that the devicetree is coming from the
> bloblist. It becomes one of the sources for devicetree, like
> OF_SEPARATE and OF_EMBED
>

BLOBLIST_PASSAGE_MANDATORY indicates the fdt from bloblist will be
mandatorily used and override other fdt sources like from the board or
env variables.

> > Moreover, it is not just for fdt, but for everything that is being
> > handed over from the previous boot stage using bloblist, but
> > OF_BLOBLIST is for fdt only.
>
> What other things are there?

All transfer entries defined in the Firmware Handoff spec should be
handed over via bloblist, for example, TPM event logs.

Regards,
Raymond

>
> > I don't think it is a good idea to replace BLOBLIST_PASSAGE_MANDATORY
> > with OF_BLOBLIST.
>
> I am OK with keeping BLOBLIST_PASSAGE_MANDATORY for now. This series
> does not remove it.
>
> >
> > > But actually, thinking about it just now, we can remove
> > > BLOBLIST_PASSAGE_MANDATORY, since U-Boot won't make it that far if
> > > there is no bloblist. It will die in fdtdec_setup(). Take a look and
> > > see if you agree.
>
> Regards,
> SImon
>
> > >
> > > >
> > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > be resurrected to give some coverage.
> > > > >
> > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > >
> > > > >
> > > > > Simon Glass (4):
> > > > >   bloblist: Simplify bloblist init
> > > > >   fdt: Introduce OF_BLOBLIST
> > > > >   bloblist: Provide access to the FDT address
> > > > >   fdt: Obtain the FDT from bloblist without parsing it
> > > > >
> > > > >  arch/arm/lib/xferlist.c            |   6 +-
> > > > >  common/bloblist.c                  | 102 ++++++++++++++++++-----------
> > > > >  doc/develop/devicetree/control.rst |   3 +
> > > > >  dts/Kconfig                        |   8 +++
> > > > >  include/bloblist.h                 |  16 ++++-
> > > > >  lib/fdtdec.c                       |  65 +++++++-----------
> > > > >  6 files changed, 116 insertions(+), 84 deletions(-)
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
> > >
> > > Regards,
> > > Simon
