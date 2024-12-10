Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513ABE77182
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 23:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ECAF801DA;
	Wed, 11 Dec 2024 00:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="eAoj3eVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2794680207; Wed, 11 Dec 2024 00:06:32 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D3C8010E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 00:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id BFD57120011;
 Wed, 11 Dec 2024 02:06:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BFD57120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733871988;
 bh=HuUpIn+OkF5HrJjMJosmBi+77jXKNcm/vcz15LBCDYA=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=eAoj3eVCcWqXoY+UeXnNlVVvmcCKacPCnBSqginY/zK71J1YRV22wxuKQXOZmAzU6
 59WGStD9zrf+Lgu4D4aUvnMIjxhr6EK9lMYYbRANEyqSEOTYh3INGm2/nM4PhS/mzu
 vRdemYmYzEhYfazdpud6mem4eIMjtpERg/HPfmFNLhdQ5VJaA7C1tJ6NUVN1ONPZtk
 Du/v2GUwxz5IE7ezsIA56ymkDCcyvWMBcPM6XeFbWmG0JvD0Tz5+gUMbpqcu4L/KVU
 cbg+fvoj2h+jrvl13NXEyq1OI77p7dwjKGcfVLXPCOhF5Y+uo1oZH+xHs0FRNP/f7M
 RDgnLYECOqiaw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 11 Dec 2024 02:06:28 +0300 (MSK)
Date: Wed, 11 Dec 2024 02:06:27 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 "Sughosh Ganu" <sughosh.ganu@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, <kernel@salutedevices.com>,
 <evgen89bachinin@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] common: relocate fdt_blob in global_data for
 FDTSRC_EMBED case
Message-ID: <y4ncr46n6y2vhziidbuho2bagvnsjkbcvtywcr5awwjx4m27eo@nrmc3mefrjjx>
References: <20241125-of_embed_fdt_blob_garbage-v1-1-faa78e2e1ee9@salutedevices.com>
 <35slrpavqjk23bsybse752vmwsjqzk3ej6stozo3gtlbpe5pfg@3rytobz4ewik>
 <CAFLszTgEKamsa6FTnjzrEWQBLkqAR7EBbZqffx09AKgQ7ppuVA@mail.gmail.com>
 <tqejglhbc2qgqjzlmidkmscm37fxoamkkw6tyeylyfvngatrv2@ppbyancgyakr>
 <CAFLszTgQWMyrm6h4CcK0MZD4Cpauh9pYQk5coNNbmK2nNUPsDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTgQWMyrm6h4CcK0MZD4Cpauh9pYQk5coNNbmK2nNUPsDA@mail.gmail.com>
User-Agent: NeoMutt/20231006
X-Originating-IP: [172.28.224.238]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189752 [Dec 10 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; lore.kernel.org:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/10 21:49:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/10 21:49:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/10 16:39:00 #26956987
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hello Simon,

On Thu, Dec 05, 2024 at 10:57:36AM -0700, Simon Glass wrote:
> Hi Evgeny,
> 
> On Wed, 4 Dec 2024 at 12:57, Evgeny Bachinin
> <eabachinin@salutedevices.com> wrote:
> >
> > Hello Simon,
> > please, see below
> >
> > On Tue, Dec 03, 2024 at 08:55:15AM -0700, Simon Glass wrote:
> > > Hi Evgeny,
> > >
> > > On Fri, 29 Nov 2024 at 03:03, Evgeny Bachinin
> > > <eabachinin@salutedevices.com> wrote:
> > > >
> > > > Hello, dear reviewers!
> > > >
> > > > It was my 1st attempt to use b4-tool and it did not list all relevant
> > > > reviewers.
> > > >
> > > > So, let me manually CC relevant stakeholders/maintainers.
> > > > Please, take a look on the fix of bug/vulnerability
> > > >
> > > > P.S. If you wish, advise me, please, whether I need to re-send with
> > > > updated CC list or just publish v2.
> > > >
> > > > On Mon, Nov 25, 2024 at 12:15:07PM +0300, Evgeny Bachinin wrote:
> > > > > Patch resolves two kind of bugs, one of which is vulnerability related
> > > > > to KASLR.
> > > > >
[...]
> > > > > +
> > > > > +     /*
> > > > > +      * For CONFIG_OF_EMBED case the FDT is embedded into ELF, available by
> > > > > +      * __dtb_dt_begin. After U-boot ELF self-relocation to RAM top address
> > >
> > > U-Boot


Fixed in follow up patch series [1]


> > >
> > > > > +      * it is worth to update fdt_blob in global_data
> > > > > +      */
> > > > > +     if (IS_ENABLED(CONFIG_OF_EMBED))
> > > > > +             gd->fdt_blob = dtb_dt_embedded();
> > > > > +
> > > > >  #ifdef CONFIG_EFI_LOADER
> > > > >       /*
> > > > >        * On the ARM architecture gd is mapped to a fixed register (r9 or x18).
> > > > >
> > > > > ---
> > > > > base-commit: cca05617a8f585f3a98a8fa82f75cc68a530d771
> > > > > change-id: 20241119-of_embed_fdt_blob_garbage-ea729a8236e1
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Evgeny Bachinin <EABachinin@salutedevices.com>
> > >
> > > Note that OF_EMBED is a development feature[1], for debugging with
> > > JTAG, etc.
> >
> >
> > Yes, that's right.
> >
> >   Due to the legacy, it's ok for us (for now) when dtb is inside U-Boot
> > ELF. We are migrating from Amlogic vendor source code base into
> > upstream one and chose more obvious and fast way (OF_EMBED), available
> > and workable both in vendor's (old) U-Boot and in upstream one.
> > One day, we will get rid of OF_EMBED, being fully on mainline
> > sources...
>
> I am surprised that OF_EMBED is faster. It really shouldn't make any difference.
>

Oh, sorry for misleading (I'm not about performance).

Under "faster" I meant the speed of adaptation the approach with
OF_EMBED both on Vendor and mainline U-Boots. We had to externally pass
the dtb into build system via EXT_DTB (in Vendor U-Boot), but,
unfortunately, the Vendor U-Boot (basing on 2015.01) can't use EXT_DTB
without OF_EMBED=y.


> >
> > Nevertheless, option exists and it is not prohibited for usage. And as
> > my patch reveals there were bugs, one of which led to KASLR disabled
> > on real production board.
> >
> >
> > > Which board is this?
> >
> > Our production device is based on Amlogic SoC A113X (AXG family) and
> > is not public. The closest board is S400 [1].
> >
> >
> > > Also, you should normally disable relocation (with gd->flags
> > > GD_FLG_SKIP_RELOC) when using OF_EMBED, since the code ends up
> > > elsewhere, which is a pain when debugging.
> >
> > Thank you for your advise! I'll take it into account.
> >
> >
> > > This macro is for use by fdtgrep...perhaps I should have added an
> > > underscore at the end to make that clear.
> >
> > Sorry, did not grasp your comment.
> > What macro?
> > P.S I tried to guess you talked about FDTSRC_EMBED or OF_EMBED, but
> > anyway I can't relate them with fdtgrep by seeking in repo.
> 
> Oh I mean fdtdec
> 
> >
> >
> > > So please add a function in
> > > fdtdec to handle this, calling it from initr_reloc_global_data(),
> > > perhaps.
> >
> > Have I understood you right?
> > You meant to move initialization of fdt_blob by dtb_dt_embedded() into
> > a separate function something like this:
> > ```
> > diff --git a/common/board_r.c b/common/board_r.c
> > index abe2395346..424954ea67 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -159,7 +159,7 @@ static int initr_reloc_global_data(void)
> >          * it is worth to update fdt_blob in global_data
> >          */
> >         if (IS_ENABLED(CONFIG_OF_EMBED))
> > -               gd->fdt_blob = dtb_dt_embedded();
> > +               fdtdec_setup_embed()
> >
> >  #ifdef CONFIG_EFI_LOADER
> >         /*
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index 6865f78c70..484954a262 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1664,6 +1664,12 @@ static void setup_multi_dtb_fit(void)
> >         }
> >  }
> >
> > +void fdtdec_setup_embed(void)
> > +{
> > +       gd->fdt_blob = dtb_dt_embedded();
> > +       gd->fdt_src = FDTSRC_EMBED;
> > +}
> > +
> >  int fdtdec_setup(void)
> >  {
> >         int ret = -ENOENT;
> > @@ -1698,8 +1704,7 @@ int fdtdec_setup(void)
> >                         gd->fdt_blob = fdt_find_separate();
> >                         gd->fdt_src = FDTSRC_SEPARATE;
> >                 } else { /* embed dtb in ELF file for testing / development */
> > -                       gd->fdt_blob = dtb_dt_embedded();
> > -                       gd->fdt_src = FDTSRC_EMBED;
> > +                       fdtdec_setup_embed();
> >                 }
> >         }
> > ```
> 
> Yes that's right...it keeps the access to dtb_dt_embedded() within fdtdec
> 

Thank you for idea.
Have been done in the follow up patch-series [1]

Links:
[1] https://lore.kernel.org/u-boot/20241211-dtb_dt_embedded_within_fdtdec-v1-0-7840469f0084@salutedevices.com/T/#m7324a6dce4bc3804978073017617a4e9cf6843fa

-- 
Best Regards,
Evgeny Bachinin
