Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1078606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L07tCFSF;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QqBcWtwC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39AE160650;
	Sun, 15 Nov 2026 10:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w94oWGDJT04B; Sun, 15 Nov 2026 10:30:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 16C2D60629
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794738641;
	b=lbTVDTFFzrMrwWn1P7pUYKmb2ktsbRZoPyYhgdhfYlFWRe+hl84uClgmLLYdlhPNKevT
	 /IF/mKLF3IlFCbw5QMO55qOUGNBwbm/hASk9m+KG3mRoBoYKrJl3QsKlj+DxxPG1tjZ9d
	 7CBHFEseoXWLdmxea6PpHebEckhdrKypCuRMj7VGQ1x36V4bz74r6u1ZDT0cKT1Bnw8Ob
	 QSfb87f0LNLTuhYo2hbTz3G59fvPWDDDmmGKkA9k37vDoLgAIZ4ezFAfJCchoJY22l0F8
	 ImqL45dG2dtXG8N6qsy94Pqk3pD+x2sWYYtIjTR1Jp9wR4hEyq5Ll9ZgSS4iqd5qZaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794738641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CUUuvtl6UguSC8VYrlgnnLS+F54/0jjFJBGaw8kRMO4=;
	b=HZMorsX4iG2/Q7uGsFoWxaJFbxzKupRds/Fa0W17RDluXModLCGyPAM7rAjc2L/oct+q
	 pHLCytLRWW/2nfet3rPUqq0bFyab8RyZMOT4TJwRerOGOJdaYSnZ/NPJoht3UWwVL9TtI
	 MiuV73qmodHIASoauVJC3l6xoB6U1YI51Tk5He6AYWb8KZK5v2M4ee3r8AT6G2eiJUSF1
	 nkzF0Oj+g3fyGl0KarDajHfgZcQNL8oxVn7GfvseqxpTvDT7asJDXyHjKjHngVLmPVisU
	 kpzqUu8Ah1pTPllFwRvl3jm8g/NGdYBJ2QWBZ4/jYz0+IDdSJwzJZ2+eOoS4lqre8YA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QqBcWtwC;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794738641;
	bh=CUUuvtl6UguSC8VYrlgnnLS+F54/0jjFJBGaw8kRMO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L07tCFSFMdM/I4JoPvodIsN9kWKhIsgWMYb1NlUwhu85JFrXI6y8DBfYs0HvmyOSp
	 rAs+f8KlmNd5mL0bU+BMO2B8H6TeSYkQzjnVM/p/BTgPh8A0jo5A0CV1pKNb5KlH93
	 p2fmUqUf5C94OXwkW64pX3bbo8Yn3wYsabSbNz1hgLObsZqd7suZe8zY1vlP8XNug3
	 4Q8PLq8uQ3WZ2xyYMUZviVFH27Xn4Ud6ZueGoW6XcKjhzwF8cV7XRCeciWavfsQuHL
	 MRw3eMAKBFVbryhCkxSZ9eqbDor+49Jm5c8kJRHWWLhysTeE4DX06HXPaF1b7Myq6v
	 KfTwzkAIOk1qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16C2D60629;
	Sun, 15 Nov 2026 10:30:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C7FC2FB
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DA7F60629
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btwKrTL-7T9j for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 10:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC86B6061B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=QqBcWtwC
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC86B6061B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:30:37 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b81214ab40so347442a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 02:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794738635; x=1795343435;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CUUuvtl6UguSC8VYrlgnnLS+F54/0jjFJBGaw8kRMO4=;
 b=QqBcWtwCUwc7HPurORyKNP9GEjM8P1gPlTi6j0c5Us4O8wS5PNqq9zSTnQY45lKIB5
 /ukPwnAYVrxyIEFf9baCjAOd/MWexDWUv+D9Wi04isjxM59wdVIjRV/8r+R5d7PiD4AH
 8IDL4l0GaXiQsqE4Sc/1gUvEVv1Wm4pTXR6WCjyYORvgTYqxy0ImjxrqCQB2sVoQoQDM
 modAI9l+plk+Ys3jhrL+scbAPexOtt5MIsv9rRa3PItWJwMN2aLUDC144w0DoSVtQJg+
 GTNuch7kEJOM4Hg0fJFZKiXXBicnvzOwlOlmmDXE5xOtQKJ4SgWLqxam6aeul5kAW3UW
 Sr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794738635; x=1795343435;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CUUuvtl6UguSC8VYrlgnnLS+F54/0jjFJBGaw8kRMO4=;
 b=iKU9A4FL81bAwsNWWVkL//qjBGuAiMgjKsMRkRfcOq8zh0WCkO0viocqDHDDYvR+pM
 lCSQQyHrsoCe8oOar/twIvGQK0U2KqOt06djxPGyiPR6Zz9sPt6affwLwc2gx1HV/7am
 pKBttZTb0yhFo7w6TZl+QIuBqX3fpweJFCPk2WKWv1H6/33hSDgFBa/iAKJs0a46BaQt
 C56oe1xE4lTayw9qd5HyfNSFiXGiMbQ5/8Tttj14ZJTD+Xh9xLvYY5qUSQlcTRaDSMDQ
 rJzeEXGxv9RwOA2qcb6pYBSPzFho9d9CVb5VGOwbdO4CMw/tq8wqxwkWchTTe/FIE81w
 gcjA==
X-Gm-Message-State: APuU4Z/EBKqa+42TKgx/6GWKYuxMMEXR/NuE+qO7dtc/y73iH6dnPSPs
 RYvznBgE32A3FdVsnlyKh9O4pTvKGrNj5bka9yjWSfYFoGUzU+jf4ohh7vX8/+sff8V+wjlAybH
 IYydh/g1stVORGQP8+vqps8XpBU0xuMSpZQ==
X-Gm-Gg: AYBFou3jPYjY20nIb5m/uKKSSXRzQd1A0RoqEkjiVurLEyiQPY2fPEHKBhLavoPq8jK
 gm80DRezUqlBMztsFtmmuJ4CBZNEZdwdQe720hUKIX1cB+hdRDdHHgwcuxH6LSDIL1JWXoTDzNx
 7bqG8C0c8uL18gjmgUhv8SeqDbMZF470DWVBo8fJ5pLLQFaEbnY2lmiQor3ec2VKG+H7gf21KYp
 ZW+Y6E+xNMTtZgECFZTvDXm2w2Hkjf+qhSUz56jkVhc2E4F09pz7rhcVehS8N7YBRdBoy4/o8S4
 WS/TRyKVft72wSdLR06/l8f3KXCxBdxreD4SkhWZry6FdOBBXHFDPGaJPf4sZRv1ycdCJcmZF0L
 +rUVG+N7ZBC6Gsu3ioGq3PNA+EJIwLlgPGCRS3g==
X-Received: by 2002:a17:906:3791:b0:c49:c3f5:8bc with SMTP id
 a640c23a62f3a-c507bc6cacamr702236266b.10.1794738635147; Sun, 15 Nov 2026
 02:30:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-1-b82ff9c860ba@gmail.com>
 <1fba6d0c-acac-4495-bdf4-58765efedce0@0leil.net>
 <9d263ab1-5880-42d0-afc8-2f2ebdae4a95@0leil.net>
In-Reply-To: <9d263ab1-5880-42d0-afc8-2f2ebdae4a95@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 15 Nov 2026 11:30:24 +0100
X-Gm-Features: AclHuK_EN9fCRdYSodlzVoQqB0VetMbTkBC7_BX67LzdJbg_vZrNMnt4V3gu_xQ
Message-ID: <CAC928HaChzVVKU1LzcO13pMiQuCiq66z3v47zcLxyuodD3pL3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ram: rockchip: improve sdram type configs selection
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin

Il giorno mer 11 nov 2026 alle ore 17:08 Quentin Schulz ha scritto:
> On 11/11/26 4:31 PM, Quentin Schulz wrote:
> > Hi Massimo,
> >
> > On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> >> Not all the SDRAM types config options named in the Kconfig are
> >> supported by each of the Rockchip SoCs: improve clarity adding SoC
> >> dependencies to the options.
> >>
> >> Add a new RAM_ROCKCHIP_DDR3 option and remove PX30 and RV1126 sdram
> >> drivers fallback behaviour when no SDRAM type option is selected,
> >> raising a compile time error in this case, instead. The new option
> >> has a default true value if no other SDRAM option is true to avoid
> >> impacts on defconfigs.
> >>
> >> Moreover, these drivers support only one SDRAM type at a time: when
> >> more options are selected, avoid debatable preemption of one over the
> >> others, and raise a compile time error instead.
> >>
> >> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> >> ---
> >>   drivers/ram/rockchip/Kconfig        | 24 +++++++++++------
> >>   drivers/ram/rockchip/sdram_px30.c   | 17 +++++++++---
> >>   drivers/ram/rockchip/sdram_rv1126.c | 54 ++++++++++++++++++++
> >> +----------------
> >>   3 files changed, 60 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> >> index d707d09c1c8..f51ae6a4542 100644
> >> --- a/drivers/ram/rockchip/Kconfig
> >> +++ b/drivers/ram/rockchip/Kconfig
> >> @@ -24,28 +24,36 @@ config RAM_ROCKCHIP_DEBUG
> >>         This is an option for developers to understand the ram drivers
> >>         initialization, configurations and etc.
> >> +config RAM_ROCKCHIP_DDR3
> >> +    bool "DDR3 support for Rockchip SoCs"
> >> +    depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> >> +    default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
> >> +        !RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
> >> +    help
> >> +      Enable DDR3 sdram support on Rockchip SoCs.
> >> +
> >
> > issue: too much done in one commit
> >
> > Please split this into multiple commits. I could identify:
> > - add SoC dependency for existing DRAM Kconfig symbols (with the change
> > to the helptext to make it generic)

I will do it in v3.

> > - add new DDR3 symbol and gate existing code with it. That is, rv1126
> > and px30 should have their #else for their DDR3 timings gated by this
> > symbol. A new #else can call #error so the build fails in case of
> > incorrect configuration, like you did here,

I will do it in v3. Do you agree on keeping in this commit the default y for
the new DDR3 symbol if none of the other RAM_ROCKCHIP symbols are selected?
This should avoid affecting defconfigs.

I will also drop defined/IS_ENABLED substitutions, see below about this topic.

> > - enforce only one selectable DRAM init for PX30 and RV1126,

I will do it in v3.

> >
> >>   config RAM_ROCKCHIP_DDR4
> >>       bool "DDR4 support for Rockchip SoCs"
> >> +    depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> >>       help
> >> -      This enables DDR4 sdram support instead of the default DDR3
> >> support
> >> -      on Rockchip SoCs.
> >> +      Enable DDR4 sdram support on Rockchip SoCs.
> >>   config RAM_ROCKCHIP_LPDDR2
> >>       bool "LPDDR2 support for Rockchip SoCs"
> >> +    depends on ROCKCHIP_PX30
> >>       help
> >> -      This enables LPDDR2 sdram support instead of the default DDR3
> >> support
> >> -      on Rockchip SoCs.
> >> +      Enable LPDDR2 sdram support on Rockchip SoCs.
> >>   config RAM_ROCKCHIP_LPDDR3
> >>       bool "LPDDR3 support for Rockchip SoCs"
> >> +    depends on ROCKCHIP_PX30
> >>       help
> >> -      This enables LPDDR3 sdram support instead of the default DDR3
> >> support
> >> -      on Rockchip SoCs.
> >> +      Enable LPDDR3 sdram support on Rockchip SoCs.
> >>   config RAM_ROCKCHIP_LPDDR4
> >> +    depends on ROCKCHIP_RK3399 || ROCKCHIP_RV1126
> >>       bool "LPDDR4 support for Rockchip SoCs"
> >>       help
> >> -      This enables LPDDR4 sdram code support for the platforms based
> >> -      on Rockchip SoCs.
> >> +      Enable LPDDR4 sdram support on Rockchip SoCs.
> >
> > Because I checked, and for future reference:
> >
> > PX30 supports LPDDR2/LPDDR3/DDR3/DDR4. Only one selectable at a time
> > currently.
> > RK3368 only supports DDR3.
> > RK3066 supports DDR3/LPDDR3 but only DDR3 is used (MK808 device,
> > configuration via Device Tree and OF_PLATDATA)
> > RK3188 supports DDR3/LPDDR3 but only DDR3 is used (Radxa Rock,
> > configuration via Device Tree and OF_PLATDATA)
> > RK322x supports DDR3/LPDDR2/LPDDR3 but only DDR3 is used (RK3229 EVB,
> > configuration via Device Tree and OF_PLATDATA)
> > RK3288 supports DDR3/LPDDR3, both used via e.g. Rock Pi N8 (LDDR3) and
> > Rock2 Square (DDR3), configuration via device tree and OF_PLATDATA)
> > RK3328 supports DDR3/LPDDR3/DDR4, all used, via e.g. Rock Pi E (DDR3),
> > Rock64 (LPDDR3) and Orange Pi R1S Plus (DDR4).
> > RK3399 supports DDR3/LPDDR3/LDDR4, all used, via e.g. Puma (DDR3), Gru
> > Bob (LPDDR3), PinePhone Pro (LPDDR4). Either DDR3/LPDDR3 or LPDDR4, not
> > both. We should check for this in the driver.
> > RV1126 supports DDR3/DDR4/LPDDR3/LPDDR4, but no timings for LPDDR3. Only
> > one selectable at a time currently.
> >
>
> And RK3036 only has DDR3 boards supported.

I think this information, even if available in the public domain, could be
useful also in U-Boot Rockchip documentation: would you like me to try to add
it to the documentation within another series? It could be useful to know if
these drivers have ever been tested/used in the past with RAM types currently
not used by any of the boards maintained in U-Boot.

>
> > The common theme though is that they are all configured via Device Tree
> > (via OF_PLATDATA) where the dramtype is hardcoded, and this here would
> > be the first to try to do autodetection of the DRAM and init properly.
> >
> >>   endif # RAM_ROCKCHIP
> >> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/
> >> sdram_px30.c
> >> index 37e62120504..c7ff924b2c5 100644
> >> --- a/drivers/ram/rockchip/sdram_px30.c
> >> +++ b/drivers/ram/rockchip/sdram_px30.c
> >> @@ -123,15 +123,24 @@ u32 addrmap[][8] = {
> >>   struct dram_info dram_info;
> >> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
> >> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
> >> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
> >> +    IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
> >> +#error "This driver only supports one DRAM configuration at a time"
> >> +#endif
> >> +
> >>   struct px30_sdram_params sdram_configs[] = {
> >> -#if defined(CONFIG_RAM_ROCKCHIP_DDR4)
> >> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
> >> +#include    "sdram-px30-ddr3-detect-333.inc"
> >> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> >>   #include    "sdram-px30-ddr4-detect-333.inc"
> >> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >>   #include    "sdram-px30-lpddr2-detect-333.inc"
> >> -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >> +#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >
> > question: what's the benefit to switch defined() to IS_ENABLED?

None. Having checkpatch complain with - WARNING: Use 'if
(IS_ENABLED(CONFIG...))'
instead of '#if or #ifdef' where possible - I misinterpreted and
supposed to make
it quiet in this way. I was wrong and I did not notice checkpatch was
not quieter
at all, obviously. Sorry. I will avoid in v3.

> >
> > It almost made me miss the fact this reorders the DRAM timings array.

I wrote about the reordering based on alphabetical criteria in the cover letter
description, and cited it in the v2 changes list, too. Can I help if I put the
version changes list per patch instead of grouped in the cover letter?

> >
> > I think the reordering should be made in a separate commit, possibly the
> > one where it's possible to select more than one

In v3, the reordering will be within the "more than one" commit. Right now,
that commit affects PX30 only, but reordering will impact RV116 code, too:
I would prefer to keep the ordering criteria (alphabetical) shared between
all Rockchip SoCs.

If you prefer reordering in a dedicated commit instead, let me know and I will
split reordering from "more than one".

I will send the v3 rebased on next after Monday merging.

Thanks for your time and your support. I really appreciate.

Regards,
Massimo

> >
> > Cheers,
> > Quentin
>
