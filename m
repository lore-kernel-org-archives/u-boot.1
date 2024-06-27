Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2093AC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B7B88256;
	Thu, 27 Jun 2024 11:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LuiR1JhW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56CA8857E; Thu, 27 Jun 2024 11:20:11 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1928852C
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b50aeb2f31so37710736d6.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719480008; x=1720084808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=epviF/wzGK+mRcCt4yC2dbZzZLbsi+7mAksB51e/HY4=;
 b=LuiR1JhWhZnV5SuboyzrSGWifz7zP83LFRp65wPpZ8BUso93gYE3Hq/2pQn4PBhGfP
 Li0WGtX0q4miy4g+l6bI91wMpEQw3+xBDuXU/Ie64UQ2PLSM5wpVgr4JAY0YTSv5YZ85
 rOB6qndtO1rOxgZq1gISuVl+1rrinQ+AYI4mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719480008; x=1720084808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=epviF/wzGK+mRcCt4yC2dbZzZLbsi+7mAksB51e/HY4=;
 b=I/cBOFO55vqZ73R1OIR+ReYe9o8xsdh6FGKpxU3O+cIaOg1jjEKse4Db2S0KrlnD6g
 /zKLM/JadCf58Ie3NRA2dblaKCzu4Ih6ATncvgsaghIF4TvKjETa3mMBiD9c1eV5Eg/U
 ReWR0WGxWNH8rashlMVoXcq5CglKOSWwIrFhjVFfeY2kb0KUlfuXD13cNK0Lzo/bOvgU
 SLEPPocSCZfJshXekoGF3Mb/sPZIlx4pNbkLX+MIVFYI9mV2gWjekBR91GswWEAQOjQe
 VkcbswslMkVose+r99y788KiAi/7mHCDkojZvw7qRgqD3XL66vJ6DzRD4ORHLqR2ru+7
 e6kg==
X-Gm-Message-State: AOJu0YyIPVELBpVpYW7FNfazn10vsC9htbsEJrlfi8wx4XYM0HMzel1Z
 j0xGFiEgb8LXtc5nHB3idzHpCBlGmiHgHD5+XhSU8MGOMZdFQAdbCQBW1FPGYmA3scpetJaq35U
 Y/6RgQBkhLBje3C2IVCeD9m2vqlp/+EJ2vfqW
X-Google-Smtp-Source: AGHT+IFrHQs8dcIt2J582E+1QTtiklaunuGTW5cJ+0KrNbpdtE59dPj8Jz1Z6g08IY5LS/OkaaMlbPxMN1+r61/LNwI=
X-Received: by 2002:a0c:f2c3:0:b0:6b0:7fa6:c004 with SMTP id
 6a1803df08f44-6b540bf3ef1mr135942226d6.59.1719480008454; Thu, 27 Jun 2024
 02:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240626155945.278640-1-sjg@chromium.org>
 <20240626155945.278640-15-sjg@chromium.org>
 <e6df1db5-745d-4398-9207-7f08faa1628d@kwiboo.se>
 <CAFLszTjRO7CypWHBLqHr2NW6YPjxdD+VxeUEWLXGfbiPE4kJ3A@mail.gmail.com>
 <60d9f7b0-1964-4ce0-ba6b-4d4d4438716a@kwiboo.se>
In-Reply-To: <60d9f7b0-1964-4ce0-ba6b-4d4d4438716a@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 10:19:57 +0100
Message-ID: <CAFLszThg5xohR-9AgSMHVrW5Dp_tN39nC7rq1Z4ZMnqOQqJa1w@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Thu, 27 Jun 2024 at 10:00, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-06-27 10:02, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Wed, 26 Jun 2024 at 17:16, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2024-06-26 17:59, Simon Glass wrote:
> >>> The code here is confusing due to large blocks which are #ifdefed out.
> >>> Add a function phase_sdram_init() which returns whether SDRAM init
> >>> should happen in the current phase, using that as needed to control the
> >>> code flow.
> >>>
> >>> This increases code size by about 500 bytes in SPL when the cache is on,
> >>> since it must call the rather large rockchip_sdram_size() function.
> >>>
> >>> - Drop the non-dcache optimisation, since the cache should normally be on
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v5:
> >>> - Move setting of pmugrf into the probe() function
> >>>
> >>> Changes in v3:
> >>> - Split out the refactoring into a separate patch
> >>>
> >>>  drivers/ram/rockchip/sdram_rk3399.c | 33 ++++++++++++++---------------
> >>>  1 file changed, 16 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> >>> index 3c4e20f4e80..b259e8e3dd6 100644
> >>> --- a/drivers/ram/rockchip/sdram_rk3399.c
> >>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> >>
> >> [snip]
> >>
> >>> +/**
> >>> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> >>> + *
> >>> + * Returns: true to do SDRAM init in this phase, false to not
> >>> + */
> >>> +static bool phase_sdram_init(void)
> >>> +{
> >>> +     return spl_phase() == PHASE_TPL ||
> >>> +         (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
> >>
> >> This still need to check for !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL)
> >> to be correct, else you must build with both CONFIG_TPL and
> >> CONFIG_ROCKCHIP_EXTERNAL_TPL or the generated SPL will incorrectly try
> >> to initialize DRAM.
> >>
> >> DRAM should only be initialized in TPL or ROCKCHIP_EXTERNAL_TPL,
> >> or if none of them are defined in SPL. All other phases should
> >> just read and report dram size.
> >
> > Thanks for the info.
> >
> > The reason I am finding this hard to understand is that
> > ROCKCHIP_EXTERNAL_TPL does not appear in the code as it is. So I
> > cannot figure out why it needs to be added. Is there a bug in the
> > current code, or does my patch introduce a bug, or...?
>
> The current code does not handle ROCKCHIP_EXTERNAL_TPL and TPL must be
> built to later be replaced with the external TPL blob.
>
> This adds a new helper that states "Check if this is the phase where
> SDRAM init happens", and for this statement to be true it should also
> consider ROCKCHIP_EXTERNAL_TPL or a bugfix patch is later needed for
> this newly added helper.
>
> Adding !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) should make this
> statement be valid for the foreseeable combinations.
>
>         return spl_phase() == PHASE_TPL ||
>                (!IS_ENABLED(CONFIG_TPL) &&
>                 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
>                 !spl_in_proper());
>
> With that it should be possible to have TPL=n and ROCKCHIP_EXTERNAL_TPL=y
> and produce a working SPL.

Thanks very much, I understand it now.

Regards,
Simon
