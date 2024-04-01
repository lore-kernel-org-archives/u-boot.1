Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F6FCD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 11:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE8D882DB;
	Mon,  1 Apr 2024 13:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IpzXxBFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE9BB8821E; Mon,  1 Apr 2024 13:33:34 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FE0882E7
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 13:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4765792fc76so632497137.3
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711971211; x=1712576011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=euDxCThCPYQFWmpCttn36I/Kfbt7dZOMizfumvAudnY=;
 b=IpzXxBFWoQpPCvxL3b3jVB/4HCjkNelj4ZBdF5CO+2vSLJiDJSP02tott2MM2ruBCz
 PQic9dnGZFBiVs7quUBJYYjL/yeUrvmdKiENsK9sYxV+hgxwsQMmd48wpgHGJ+Fzlnae
 mDh+Lw4m/p+dhgnNYfG9c01v0GJMusdvXfuLXpOWr5m/nSWqNz03wVITew+bK30uJg/0
 RTgT1V3wYCtGACJ2gUtlK5yb8l2+QgfdQPfi4QgDkvLjQjKoHIYN03GKgA3LrzyC1Djk
 37376Ztz/lASqwjDK0R9gvB+G1A5qoyXPuYqZB+0see0s+7vGQbnKbgdt8B/FWhgY/9R
 63EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711971211; x=1712576011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=euDxCThCPYQFWmpCttn36I/Kfbt7dZOMizfumvAudnY=;
 b=sP2tfi8I7NlZn2Ryy9UNZ40aXSOLcf8WcmjreEyHajtHGE2iJ9Kk+Hwt3snHf4SxhZ
 0NlrO85reivmp25VCAMoxVWBkHC+yF5QbMmptltDC4Otin15vITaXIUZFD+ejP6SLgFh
 5TLuvocnTQNJL1VUUVEjcW5Xm4M9vERMEdiNAAKrKSakvISmObzVZePORMh+nI2NkR1P
 fAl9pthJvS66SAMN3ZhCJgK5J1HFooofCSdyLyIplmVBK4VY3/U7fh0xfqu2U+rVd/Gl
 QLD6VInwcVgwismJt8H25mTdEB7DXZkLGfxw/XuIOU9t3Iw6GyMiJTEm/SgLR55WDfDv
 +57w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMcm/VAMcMCBQEOmFkUPDzIQWGM2s3x0QCDYxi5X69c5hLWgdBDIM8pOOZNn2Rt3k8Nj5ciXFWy5Pf9si+Fslz1tjlSw==
X-Gm-Message-State: AOJu0YyYWDHxUMtRRvTFe5CjP8CkO+VN8fW+Obz+UbLh7MN44ISpEXgq
 aSAFPvnppnZS4kwcg0jm3AyRDBwvMcG/3pPHZW66x6rky+eZEVwnh20xOJUOAyq5msXGkWm+Djk
 8xT6jJMY9SMOA8yh51M5mefxE+zlO8HbYgyi0OA==
X-Google-Smtp-Source: AGHT+IEn+6Xf+pm+V886K6SYY8M22eLo0FR8NQfI9CS2cwHL3Yoh+DV8QF7Ca0wYH/z0DxfqIW/rCws0n1HRgCztw18=
X-Received: by 2002:a67:ef8d:0:b0:478:4019:7a35 with SMTP id
 r13-20020a67ef8d000000b0047840197a35mr6332019vsp.21.1711971209897; Mon, 01
 Apr 2024 04:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <CAFA6WYPMqRQRpcN--3Mz7czh6MK10W75e19h9VWWp5P6KKbBJA@mail.gmail.com>
 <63f29606-ad3f-4883-9e8b-4d80194c12ab@kwiboo.se>
 <fc5a4ae1-21d6-4b72-a9d8-a551e3753f17@kwiboo.se>
 <CAFA6WYPtay4Z6W7GWsJQA+ejd2XhmSkcVPnDX0xhjPrAf1essA@mail.gmail.com>
 <20774ea8-2e06-4f27-b62a-d2b1e06b71da@kwiboo.se>
In-Reply-To: <20774ea8-2e06-4f27-b62a-d2b1e06b71da@kwiboo.se>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 17:03:18 +0530
Message-ID: <CAFA6WYPcnSXOFCZJpmRxtYiRL-y-Yd3vrS=CmXSWS2xHi3p90w@mail.gmail.com>
Subject: Re: [PATCH 00/31] rockchip: rk3399: Sync DT with linux v6.8 and
 update defconfigs
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, 1 Apr 2024 at 16:34, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2024-04-01 12:53, Sumit Garg wrote:
> > On Mon, 1 Apr 2024 at 15:31, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> On 2024-04-01 11:45, Jonas Karlman wrote:
> >>> Hi Sumit,
> >>>
> >>> On 2024-04-01 10:52, Sumit Garg wrote:
> >>>> Hi Jonas,
> >>>>
> >>>> On Mon, 1 Apr 2024 at 01:59, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>>>>
> >>>>> This series adds support for new clocks used in linux v6.8 device trees,
> >>>>> enables use of FIT signature check for checksum validation and fixes
> >>>>> loading FIT from SD-card when loading FIT from eMMC fails.
> >>>>>
> >>>>> After this series it should be possible to move RK3399 boards to use
> >>>>> OF_UPSTREAM in a future patch once dts/upstream move to a v6.8+ tag.
> >>>>>
> >>>>
> >>>> Thanks for putting this effort together. A switch to v6.8 tag for
> >>>> OF_UPSTREAM will happen as part of patch [1]. So if you want to save
> >>>> further effort then you can just rebase with a switch to OF_UPSTREAM
> >>>> once that patch [1] lands in next.
> >>>
> >>> Because this is a jump of device tree files from v5.14-rc1 to v6.8,
> >>> reviewability and being able to cherry-pick these changes to my
> >>> rk3xxx-2024.04 branch, I think it is much more appropriate to first sync
> >>> everything to v6.8 and then in a separate series move to OF_UPSTREAM.
> >>> Else it can be very hard to understand some of the changes that has been
> >>> and was needed to be made to u-boot.dtsi files.
> >>
> >> Also forgot to mention that these synced DT files still contains some
> >> minor modification in #include dtsi paths of files that is shared
> >> between rk3288 (armv7) and rk3399 (armv8),
> >
> > I can only see rockchip-u-boot.dtsi being shared which should be
> > handled automatically. Is there anything else I am missing here?
>
> The following is a diff of arch/arm/dts rk3399 DTs after this series
> compared to fully synced v6.8.

This is due to the different DTS directory structure within U-Boot.
With OF_UPSTREAM, these modifications aren't required anymore.

>
> Also the content of cros-ec-keyboard.dtsi was excluded in this sync
> because it initially caused compile issues.

I suppose that's due to missing #include
<dt-bindings/input/cros-ec-keyboard.h> for cros-ec-keyboard.dtsi. Once
you enable OF_UPSTREAM then let me know if you encounter such issues.

-Sumit

>
> diff --git a/arch/arm/dts/rk3399-gru.dtsi b/arch/arm/dts/rk3399-gru.dtsi
> index d90fe4d40d48..789fd0dcc88b 100644
> --- a/arch/arm/dts/rk3399-gru.dtsi
> +++ b/arch/arm/dts/rk3399-gru.dtsi
> @@ -684,8 +684,8 @@ ap_i2c_audio: &i2c8 {
>         status = "okay";
>  };
>
> -#include <cros-ec-keyboard.dtsi>
> -#include <cros-ec-sbs.dtsi>
> +#include <arm/cros-ec-keyboard.dtsi>
> +#include <arm/cros-ec-sbs.dtsi>
>
>  &pinctrl {
>         /*
> diff --git a/arch/arm/dts/rk3399pro-rock-pi-n10.dts b/arch/arm/dts/rk3399pro-rock-pi-n10.dts
> index bf026786fa92..c58fb7658d7a 100644
> --- a/arch/arm/dts/rk3399pro-rock-pi-n10.dts
> +++ b/arch/arm/dts/rk3399pro-rock-pi-n10.dts
> @@ -8,7 +8,7 @@
>  /dts-v1/;
>  #include "rk3399.dtsi"
>  #include "rk3399-opp.dtsi"
> -#include <rockchip-radxa-dalang-carrier.dtsi>
> +#include <arm/rockchip/rockchip-radxa-dalang-carrier.dtsi>
>  #include "rk3399pro-vmarc-som.dtsi"
>
>  / {
>
> Regards,
> Jonas
>
> >
> > -Sumit
>
