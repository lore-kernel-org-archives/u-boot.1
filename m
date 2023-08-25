Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF8EC6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09FF586A2D;
	Fri, 25 Aug 2023 21:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aXMl5UjZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F20786AB5; Fri, 25 Aug 2023 21:02:06 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF9986776
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-26b41112708so794500a91.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692990122; x=1693594922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vt2nLg74asIpA1ZBBgEq/NHJrL9R2shqszs3BCb/Fng=;
 b=aXMl5UjZcc71tkF/MrUam5PxcvyPRB0u52ayvrfe6tBxyolANxOWs1UCsnhH48ziHr
 HRP0Q0FbkiHUoOCvyVg0bTrilcgVczDVbQT+8+/GSJe2wF5WBT9LvrCq/jmrN1R0q981
 WQ6e/Bode5RPuXRNGg+7Y4+pqadGI1LNL+ELOlfJQCtBuEyV3dFIhl+fbjNRO3yMXd6I
 5Suj+t4kOBeCW13J0rNaoCXZad+KwUFORcbIvvKHTpB0EZQ0nc638h1yFlZss0gd1LP4
 RMwiUTjgNWxAD+zH9itQqq32iUG0mp6GG6h84GZLV8YxllonR3zWrglDA/5sQzGTLvyF
 RmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692990122; x=1693594922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vt2nLg74asIpA1ZBBgEq/NHJrL9R2shqszs3BCb/Fng=;
 b=TwE6iqzfUosO1W4PL3a+iHOG20BBa2xFQGTZ7FL4lq+CSvSZYYgkF7pBbaCVMiumgh
 LN1+5+7uwo58H4EMwihladTxLbS1i2fX+OQHjUD2heYPXKgnVhJZF+/Oa7OgibxahLiF
 aiOS6zZTue4lKNRqbwPwqYeac1X68nNMKswCY4REMkLBwy4/LScK3ohP5U+Vdi95Akrn
 j6RpS5fcNNwJ6gNjh5n5sWmJ+PCnwgBCxlbVcl1g+83v1mVaPcp6os2fMdIcwdLHZoy0
 iY1rxny+4Yu94GiO5TFlCXN3xdcquekvUocwHou4pvUecr9aadYUTwkhg55DENU4jYR7
 QxOg==
X-Gm-Message-State: AOJu0YwQ/GXsFSAlVigGNDem6/gtZF5vXJvdnPS2NsMp6sEXR/DJITAj
 e/5wBcisd7CG8y7JfAcdDU4iUwRH2T18Lx+fm38=
X-Google-Smtp-Source: AGHT+IGuaPGjt0w3KchBMLqLAYobVMDLoslUTwH+32OzrSTc/ThGs0DQ3kz5kavjhT+C/o9IlvFNPKar0aQdkp4NC20=
X-Received: by 2002:a17:90b:e97:b0:268:34b1:a5a9 with SMTP id
 fv23-20020a17090b0e9700b0026834b1a5a9mr18659514pjb.8.1692990122050; Fri, 25
 Aug 2023 12:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230825015948.780662-1-Mr.Bossman075@gmail.com>
 <20230825144859.GI3953269@bill-the-cat>
 <CAPnjgZ08F=mezS-cQD=6SjQO1OW9b9aZK9iA_NG0LN3WFRXH-g@mail.gmail.com>
In-Reply-To: <CAPnjgZ08F=mezS-cQD=6SjQO1OW9b9aZK9iA_NG0LN3WFRXH-g@mail.gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Fri, 25 Aug 2023 15:01:26 -0400
Message-ID: <CAJFTR8ScbW-+A9n1hP2f1mdoF6YQ=LMHZwUeiWc8ckDY95AqsA@mail.gmail.com>
Subject: Re: [PATCH v2] Convert CFG_SYS_UBOOT_START to Kconfig
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
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

On Fri, Aug 25, 2023 at 2:06=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Fri, 25 Aug 2023 at 08:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 09:59:48PM -0400, Jesse Taube wrote:
> >
> > > Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_=
*")
> > > renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
> > > this meant that the value was no longer available to the Makefile. Th=
is
> > > caused imxrt to fail to boot. All the other boards that used this
> > > variable were unaffected because they were using the default value
> > > which is CONFIG_TEXT_BASE.
> > >
> > > This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the defa=
ult
> > > value to CONFIG_TEXT_BASE.
> > >
> > > Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > [snip]
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 5e2d4286ae..3883cae2ba 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -738,7 +738,24 @@ config TEXT_BASE
> > >       default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >=3D 64
> > >       hex "Text Base"
> > >       help
> > > -       The address in memory that U-Boot will be running from, initi=
ally.
> > > +       The address in memory that U-Boot will be copied and executed=
 from initially.
> > > +
> > > +config HAVE_SYS_UBOOT_START
> > > +     bool "Use custom U-Boot Start"
>
> start ?
This was the original name I did not change it.
Uncapitalizing start, or changing it to "U-Boot entry" is fine if
that's what you were asking

>
> > > +     depends on HAVE_TEXT_BASE
> > > +     help
> > > +       By default, the address in memory that U-Boot will be copied =
from (TEXT_BASE) and the
> > > +       entry point are the same. Select this to start the execution =
of U-Boot from a different address.
> > > +       This may be required if a header or vector table needs to be =
copied but not executed.
>
> Nice help!
>
> > > +
> > > +config SYS_UBOOT_START
> > > +     hex
> > > +     depends on HAVE_TEXT_BASE
> > > +     default TEXT_BASE
> > > +     prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
> > > +     help
> > > +       If TEXT_BASE differs from the start of execution, this sets t=
he address in memory that
> > > +       U-Boot will start execution from initially.
> >
> > A small point, these help texts should wrap at 80 columns.  If there's
> > no other feedback I'll just fix that up when applying unless you want
> > to.

Oops, it's faster if you wrap to 80 columns.
Thanks,
Jesse Taube

> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Yes please
