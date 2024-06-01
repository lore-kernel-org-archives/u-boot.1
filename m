Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3532C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 05:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31B28880B;
	Sat,  1 Jun 2024 07:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I95FqAl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A9388827; Sat,  1 Jun 2024 07:25:34 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20404887E2
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 07:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5b96a781b63so1363001eaf.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717219531; x=1717824331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uie+Ow8d0ScgG5/jXKVsQvz9orekOYpPl+iNL3nagqQ=;
 b=I95FqAl35zHsnPgABj/lc3r42yPXP/1k9nmcO7z5ea3K4vOVoQ0m3gNQv9FBP0I2f8
 PvhGunaGM5A4e3tG7fUgwhXemBxBg/f2RZF0fHMnRhZKbn9jB3VqLQbeWTMUbjklkdz+
 JshreOgQsFTwKsyrSWnptLimSmpkAmHPAx2pSbt6vG478jE9afEjvckrybQigBiP+PY+
 sV4PJC7uCvwoZCu2wuIZQwbyl4cQ24/opMV1GFrvxKk9U9nKJCFInmZhPui/UGFZZcQw
 m5idG1+G1zNHd4saZff0lAZ6Ys6zK4jNotPZMPjJE9jogDjiA9aECoM4QFwBPETAtDFy
 6+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717219531; x=1717824331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uie+Ow8d0ScgG5/jXKVsQvz9orekOYpPl+iNL3nagqQ=;
 b=U2KcyOHs03CgaRTOD5CgKyBWnbMZynhg+68zAuI/gUIy7nDEomF5YsGu49HuD1UEiC
 sLSYpKkxQqOemsWFLvVG9DwSLLsvQn4XMO+fE0oZOfpvJd/EeAscEybcBFe4LzvmDrpZ
 MQCEUq/e69lDAoue4RP5mn7KKt45OkxtwLV3E39H+28hCfDbJKMGtfBKy8sSpFQWHtsS
 M3rg+acqAYOIyvRze57GSWwtLAAGtUK0mK+Lx+dvO5ZrzHYSha9kTiKsV3Ubb1ky3GaE
 lhStRvCwwDeIO+fNavzGug3hoOVJlVGqCfpkEq8Ou+p4NTHhDTDOnocQQHol+f5B0DIW
 3y6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDSrjw1tBlf/2yW2Nu3Mpx0beAospx/eiCMbRq1HBvdyucP0ns+LOBNr3zLpfkErHIoPLMfHlHZ1/fx+XyKhrn7eDc1w==
X-Gm-Message-State: AOJu0YzoMOc9QaRZqLGjAuu/7j1/4MkemfscYp6jAt5zzEx5KRTWSfR8
 drMcnUE6bNV6VK+E/y+VUrzdgkGDq5GyK9nqY/kVcVRUl/rZfbRhwXcwpkPl/tdZcWoOoqIniy6
 RqmwCgx3DAqE2idRsOy8eipURcrcMb0aD
X-Google-Smtp-Source: AGHT+IFEwGA4vf9fg7/D4Fiaz8kF96sheCNCjfAQDP+61RofX0lHiLN8QL1jdI/YQYbG4mFycS1np8tSZ6VnA2xuBO4=
X-Received: by 2002:a05:6820:1ac4:b0:5b9:fc9f:6a52 with SMTP id
 006d021491bc7-5ba05cfb5bfmr3728323eaf.4.1717219530711; Fri, 31 May 2024
 22:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-21-linux.amoon@gmail.com>
 <6a43e749b6edd8611dcaf01aa678b5be@manjaro.org>
In-Reply-To: <6a43e749b6edd8611dcaf01aa678b5be@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 1 Jun 2024 10:55:14 +0530
Message-ID: <CANAwSgRAY7gBTrQtW03LY+Ug8VZCccm0Tk3qKOxxv25jp4tkgA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 20/23] rockchip: RV1126: Read the reset cause from
 clock reset unit for RV1126 SoC
To: Dragan Simic <dsimic@manjaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de
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

Hi Dragan,

On Sat, 1 Jun 2024 at 03:23, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Anand,
>
> On 2024-05-31 16:18, Anand Moon wrote:
> > From: Anand Moon <anand@edgeble.ai>
> >
> > Read the reset cause from clock reset unit for RV1126 SoC.
> >
> > Cc: Jagan Teki <jagan@edgeble.ai>
> > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm/include/asm/arch-rockchip/cru.h | 2 ++
> >  arch/arm/mach-rockchip/cpu-info.c        | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/arch/arm/include/asm/arch-rockchip/cru.h
> > b/arch/arm/include/asm/arch-rockchip/cru.h
> > index e886adf515..e1a8d8adad 100644
> > --- a/arch/arm/include/asm/arch-rockchip/cru.h
> > +++ b/arch/arm/include/asm/arch-rockchip/cru.h
> > @@ -29,6 +29,8 @@
> >  #include <asm/arch-rockchip/cru_rk3368.h>
>
> Although not related to this patch directly, a single space character
> should be added between "#" and "include", for consistency.
>
Not sure of this.
> >  #elif defined(CONFIG_ROCKCHIP_RV1108)
> >  #include <asm/arch-rockchip/cru_rv1108.h>
>
> The same comment as above.
>
> > +#elif defined(CONFIG_ROCKCHIP_RV1126)
> > +#include <asm/arch-rockchip/cru_rv1126.h>
>
> The same comment as above, but this time related to this patch.
>
> >  #endif

Let me check this again if needed. I will update in the next version.

Thanks
-Anand
