Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76E3C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 07:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E78EC8847C;
	Fri, 17 May 2024 09:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXpH/FZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DFA88489; Fri, 17 May 2024 09:46:05 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880DF883C7
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 09:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f054c567e2so700055a34.2
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715931962; x=1716536762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hZfLoj4V88CY4PjpvEWcQMGlxiT86lFwbJhsY8PEVYs=;
 b=WXpH/FZtTXVJjPa7tEuIlMOQUDTUEQLzEcLbkyzi+4DiuTQz7vXX3cfEltvUoc9D5y
 qpiX3M/Ph5BolcO8tnk7clGDMECTU0Cq9hLNx8si0suvz6k3eWXzxoFNxXqDLo5g84L8
 jA/ElGc3JtBgsnzhE5RyqHRClTvV6jqbLeu+krbW2esOjYSb6pF/UAC9bZfeOQD20lIU
 D3+APGTBb6d0OJ5ztmF2aTDzbKSayzcf0RpEpgsg6piXrjxSCN1G9So9oL0+ia6cJjQD
 LZCNTKeF/HO4fZsPMQv9t483Uiql7UxGCKBfFAX/4lDtQEqmZo5MLcRNWz/ml9pGeMds
 CvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715931962; x=1716536762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZfLoj4V88CY4PjpvEWcQMGlxiT86lFwbJhsY8PEVYs=;
 b=TREAcCZloKgsgyPfC39OsYLkP8A8XqHTawauQnqbNGWr/T38GRhsInbfv6evu/aOm+
 Yg6DTfzQ1KrEiuDc9NEDkJOVpEFm9hcBwfqiD7+dXCi3D2PJLw4dqK2k568STGu0NTU/
 YVqn0G+pU54FxUhBlgKuKJrOZbdXcT3F1kiZ/XIOkhJZ/Ankt6HQNwL2UT38cm8gSGgb
 mJ4BL4I1UASKMHFXczLcw8Ofyo0k6TPsf2esiWC1doK3+4Wf4sSz7JSJLIN8EkYSoZhB
 Mbxx5rvkviyXdPgSD+cdFcavwfm0lkKVAw3/f0kn4CNxXhpAVJ4GzlZ1qV1cRtlHg9hT
 W3Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Xl84CyvZNo6L55Lfh7fCqpF3y+a5wpGxqNT5aG/sXg87eRQ5PCcqj0wP++Ihsq8YzYOlrVGM1hz58rarTpcQqWgXzA==
X-Gm-Message-State: AOJu0YydnoDD/S0d59sxJ51R81SYXIN7aiQ4IIX5n3/adyoBcTlkc3YL
 fOhQ1WcJ+6ffIDtu1VQzJGNmcHAN5LS5RgzA4J0QGzL32tAT6D9Z2R+smYih5JVEB8vJh68Dpvl
 Y4PCxVVQ8AkkWGHm0juY8ozoUEqk=
X-Google-Smtp-Source: AGHT+IH3gSAGqyoL9Evr6EbPK0zgOqwRjjFGGZ5D2rSRcfxKZlWkWeDRUb60g9bG9y3w2LGqXGUuH4lKGuKY1tfrHv4=
X-Received: by 2002:a9d:7e93:0:b0:6f0:6e24:585c with SMTP id
 46e09a7af769-6f0e92b6165mr23417349a34.31.1715931962208; Fri, 17 May 2024
 00:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-7-anand@edgeble.ai>
 <d7230a5d-e74a-4b12-9e97-b19e8024afab@kwiboo.se>
In-Reply-To: <d7230a5d-e74a-4b12-9e97-b19e8024afab@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 17 May 2024 13:15:46 +0530
Message-ID: <CANAwSgRJx8ok4yDi9+76=PjvQdcJg2WLUHcVdGk_jOKsM=+RbQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] rockchip: RK3568: Read the reset cause from clock
 reset unit for RK356x SoC
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

Dropping @edgeble.ai email ID as it is not working

On Thu, 16 May 2024 at 19:48, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Anand,
>
> On 2024-05-16 10:59, Anand Moon wrote:
> > Read the reset cause from the clock reset unit for RK356x SoC.
> >
> > Cc: Jagan Teki <jagan@edgeble.ai>
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > ---
> >  arch/arm/mach-rockchip/cpu-info.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
> > index 77833c8fce..114608b506 100644
> > --- a/arch/arm/mach-rockchip/cpu-info.c
> > +++ b/arch/arm/mach-rockchip/cpu-info.c
> > @@ -12,6 +12,8 @@
> >  #include <asm/arch-rockchip/cru_rk3328.h>
> >  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
> >  #include <asm/arch-rockchip/cru_rk3399.h>
> > +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK33568)
> > +#include <asm/arch-rockchip/cru_rk3568.h>
> >  #endif
> >  #include <asm/arch-rockchip/hardware.h>
> >  #include <linux/err.h>
> > @@ -22,6 +24,8 @@ char *get_reset_cause(void)
> >       struct rk3328_cru *cru = rockchip_get_cru();
> >  #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
> >       struct rockchip_cru *cru = rockchip_get_cru();
> > +#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
> > +     struct rk3568_cru *cru = rockchip_get_cru();
>
> This is strictly not needed for RK3568 after the commit 6e710897aa31
> ("rockchip: cru: Enable cpu info support for rk3568").

Ok, thanks for this input.
>
> Suggest you use same/similar workaround or cleanup the include/define
> statement in arch/arm/include/asm/arch-rockchip/cru.h for all SoCs.
>
> Also at least one RK SoC have other bits set in the glb_rst_st reg.
>
> Suggest you add following:
>
>   GLB_RST_MASK          = GENMASK(5, 0),
>
> and use something like:
>
>   switch (cru->glb_rst_st & GLB_RST_MASK) {
>
> or "unknown reset" is reported on affected SoCs.
>
> I have also seen POR always being reported even after a reboot so please
> confirm that reset reason works on the SoCs/boards you enable this on.
>

Ok, I will check this and update you on this.

> Regards,
> Jonas
>
Thanks
-Anand
