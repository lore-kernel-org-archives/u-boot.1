Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0310FC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8462E81111;
	Thu, 27 Feb 2025 10:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N/KNG2aE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D5181115; Thu, 27 Feb 2025 10:44:17 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FC9807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-521b84aa5d5so264508e0c.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740649453; x=1741254253; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vS3WyWrQLudsj1BNryEPYbGmdNc+G/LQUXEyfb/mvhU=;
 b=N/KNG2aE4k6kGV/9bOfUfDFHhafajxc9sJkG66FGIl3Fs9eohlnzKzqa3YWcFtObbL
 6QgwUW4bfWorx5OHQihtzW9gb1KMDCX9XxBqEvRDQa2F6WT9JatXUkHUTQLiV5aphcBt
 zQi+JFbyAchkUBKM8mZHZ2jbDNi69aJANqzaqbDKgZjfu5xSsCPPo2vCYI4OqH+9DV78
 wh78kP2vjtmqaeMas8+EzhEXYoLlwvMdN34oDA2DaIKe2jGBxGYN0mKjNxuPyTW6GtXK
 i1+WYYARyKMg6vetaKIIciIBBW7ftV3G/02HnKztrWvZS51vJCC49FDHyglRFXZGSbDy
 gfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740649453; x=1741254253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vS3WyWrQLudsj1BNryEPYbGmdNc+G/LQUXEyfb/mvhU=;
 b=sMYQ+GnLZJz0Fnq4rvL1DN6+kbNRz0798W8hDEVw/9o4SgDl/OKi584BNPKGkBAd3z
 r/w1YPagmnaW5jtiNWXzP8SGlbIegR3aLL4rZrN+7l3dq2PziVYNV+/kMEune5DqgL2B
 Ynt0ERlCCeO3mTmziIiEhNslF0VYKb/Djf1gUFcl34fgRk3RL8hsydL+6FK4u2V0uZB1
 r0ETWi4CSGcWW9iZdzFZW/qlwR4DfiuAILIHOUbHirvNcuMF3yYx+YtDJeXxX+fgK/zI
 XP+lwPqcORb60+5PbuVqoBZ4Z5YOwgkFPIOHF1GJVcxe44yTERqKTwRz3gN+5i85AU+0
 f30A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY29e5AC8n0//0Jc3PtvAD3rUWzBZ2MjZfdvw5kAfW6ouunjcP2xb8jBewjVpE06cHYDSVe+4=@lists.denx.de
X-Gm-Message-State: AOJu0YwaYSsj6HGKnbBP0j/rIzkEkYKF5YOQOu1PGwKbtgQCD0X/bxUm
 wGDk74hk3tYlyi/0W9wM4+RbcnTZiCMXr9+6xMl/zsMaahejCf52FPdXUmxNpwuhRC3TtFxAOO+
 0lwk9CSpzif1DhJmDDWWI2nvEeghNC6VK3o4SkQ==
X-Gm-Gg: ASbGncvf2SLW52c8vDFCdh8B4l4BdnzPjzPRN6Oavd1e2rbFRpybbIPB5ht4QUQXd2y
 ges0fZ44+sLkzG+EoCLR1haHBG7+NWFQ9naPCH5dkZnkU00bbKjlED3TQfkPLwyZzcoY1oQ4vhl
 cREG6SOfUSFA==
X-Google-Smtp-Source: AGHT+IHzI7Mz4gHTG3reSJYOIGOT+qcZa8MHAS/3O34b3AHE7dhLR76RfN313ZzdWmA8IYVVCj37ImrEzAGIBW2p2Bs=
X-Received: by 2002:a05:6122:1986:b0:520:3914:e6bb with SMTP id
 71dfb90a1353d-5223ccef3bemr5306712e0c.7.1740649453469; Thu, 27 Feb 2025
 01:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
In-Reply-To: <20250227093559.797618-2-manikandan.m@microchip.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 27 Feb 2025 15:14:02 +0530
X-Gm-Features: AQ5f1JqQ8TWsVcSa_KCNGBGoImSm4KiDjXQlEUAMqa5rqgIQkjufQq7pxObpoDs
Message-ID: <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 seanga2@gmail.com, 
 kever.yang@rock-chips.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 festevam@denx.de, Oliver.Gaskell@analog.com, aford173@gmail.com, 
 prasad.kummari@amd.com, caleb.connolly@linaro.org, andre.przywara@arm.com, 
 neil.armstrong@linaro.org, mibodhi@gmail.com, nicolas.ferre@microchip.com, 
 mihai.sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
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

On Thu, 27 Feb 2025 at 15:06, Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:
>
> Add PMC clock definitions for MCK and UTMI which will be required
> for the sam9x7 OF_upstream DT since the clock framework is not in
> sync with Linux and also include this header in 'clock/at91.h' file

You should rather drop these local DT bindings headers which will
allow dts/upstream/include/dt-bindings/clock/at91.h to be included
automatically.

-Sumit

>
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  include/dt-bindings/clk/at91.h   | 3 +++
>  include/dt-bindings/clock/at91.h | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
> index a178b94157b..016c6e0c620 100644
> --- a/include/dt-bindings/clk/at91.h
> +++ b/include/dt-bindings/clk/at91.h
> @@ -24,4 +24,7 @@
>  #define USB_UTMI2              1
>  #define USB_UTMI3              2
>
> +#define PMC_MCK                        1
> +#define PMC_UTMI               2
> +
>  #endif
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index ab3ee241d10..7235b3ba01e 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -6,6 +6,8 @@
>   * Licensed under GPLv2 or later.
>   */
>
> +#include <dt-bindings/clk/at91.h>
> +
>  #ifndef _DT_BINDINGS_CLK_AT91_H
>  #define _DT_BINDINGS_CLK_AT91_H
>
> --
> 2.25.1
>
