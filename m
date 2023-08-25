Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4BFC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286A986B39;
	Fri, 25 Aug 2023 20:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QrftrrBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22A586B6B; Fri, 25 Aug 2023 20:06:28 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF60386B5B
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50098cc8967so1921429e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692986785; x=1693591585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g9QQbdXBjgJnKmPAQFOxw/06aqHM2lfJ+AoB+w68ksY=;
 b=QrftrrByO1qD0FFLxl1CdTaDEcN+oZaoCSdKoEnr0SL0q8/yio6qocK2w1272aZ1BR
 lwhoFoK5PBxm5Et45Zr1Tc8OpyHU0yPmpPYZPeFHn/VlcdDO5Njmgd/DSIuCT5zO2RlH
 1mt0vw+QcQ8pTKCtEeI45o0rvVKCJ5RY9kUFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986785; x=1693591585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g9QQbdXBjgJnKmPAQFOxw/06aqHM2lfJ+AoB+w68ksY=;
 b=bAMp54FUsZB23wU1/Sk7ijUueW9HZsp64krgFffgKtoMOVWYtABblBXxxFM0BNzUmj
 z1YZ/pfZsnc5xUiGHmqPJA/Qsm+tlq8l9ih0MLbjIneAhjwwZg0CCbktyfuWJiUyogiK
 pJL1vBhtxh1Fw78hawUGwVmzzC5TTL7gdgm4VZd1vUvs0728e1jiKdjxhqCqe7PQEjVI
 yDo7QPoqC4fP0D/HnTG1H9b4/HrlmJaj4ib0JNrRbN2Xpe0gHYWExhXpuk+enU6Ctztq
 e1xjFjF79HbPn2IjboFjzN8G/3HBQBtTAcp0G4s6rPEyLkCRDDINyaYQrOj4qjvcCY8o
 spQw==
X-Gm-Message-State: AOJu0YyS/Kidi4TpOjrAChw4x9lCYNBxykNaxrXekMeXr6TgRoliAkqD
 Lb6cBEv+Th7DdxRhFRWplj6HtVZqi2e/bZYQ6teQh2riSC5eIIWIXyE=
X-Google-Smtp-Source: AGHT+IGy/3YVq/fOs6x57dejuUVFu+2gaFO8mqrUJSz+dMm1h3n2cuMdjldnxut/GG/j3CTr/RENJDgXgeGmjosgQdk=
X-Received: by 2002:a05:6512:1594:b0:500:9b26:9760 with SMTP id
 bp20-20020a056512159400b005009b269760mr6827908lfb.13.1692986784884; Fri, 25
 Aug 2023 11:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230825015948.780662-1-Mr.Bossman075@gmail.com>
 <20230825144859.GI3953269@bill-the-cat>
In-Reply-To: <20230825144859.GI3953269@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 12:06:10 -0600
Message-ID: <CAPnjgZ08F=mezS-cQD=6SjQO1OW9b9aZK9iA_NG0LN3WFRXH-g@mail.gmail.com>
Subject: Re: [PATCH v2] Convert CFG_SYS_UBOOT_START to Kconfig
To: Tom Rini <trini@konsulko.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>, u-boot@lists.denx.de, 
 "Andrew F . Davis" <afd@ti.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Stefan Roese <sr@denx.de>, Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Mauro Condarelli <mc5686@mclink.it>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
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

On Fri, 25 Aug 2023 at 08:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 24, 2023 at 09:59:48PM -0400, Jesse Taube wrote:
>
> > Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_*")
> > renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> > this meant that the value was no longer available to the Makefile. This
> > caused imxrt to fail to boot. All the other boards that used this
> > variable were unaffected because they were using the default value
> > which is CONFIG_TEXT_BASE.
> >
> > This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the default
> > value to CONFIG_TEXT_BASE.
> >
> > Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [snip]
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 5e2d4286ae..3883cae2ba 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -738,7 +738,24 @@ config TEXT_BASE
> >       default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >= 64
> >       hex "Text Base"
> >       help
> > -       The address in memory that U-Boot will be running from, initially.
> > +       The address in memory that U-Boot will be copied and executed from initially.
> > +
> > +config HAVE_SYS_UBOOT_START
> > +     bool "Use custom U-Boot Start"

start ?

> > +     depends on HAVE_TEXT_BASE
> > +     help
> > +       By default, the address in memory that U-Boot will be copied from (TEXT_BASE) and the
> > +       entry point are the same. Select this to start the execution of U-Boot from a different address.
> > +       This may be required if a header or vector table needs to be copied but not executed.

Nice help!

> > +
> > +config SYS_UBOOT_START
> > +     hex
> > +     depends on HAVE_TEXT_BASE
> > +     default TEXT_BASE
> > +     prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
> > +     help
> > +       If TEXT_BASE differs from the start of execution, this sets the address in memory that
> > +       U-Boot will start execution from initially.
>
> A small point, these help texts should wrap at 80 columns.  If there's
> no other feedback I'll just fix that up when applying unless you want
> to.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Simon Glass <sjg@chromium.org>

Yes please
