Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C159C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 21:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82D7885A0;
	Wed,  1 May 2024 23:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uYHlCUvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3798C8869A; Wed,  1 May 2024 23:12:29 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FE48857C
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 23:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-de610800da0so2757732276.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714597945; x=1715202745; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3vsAs76CSrfRx9MU28GvVE6lBtvqHFj4sm2a7LpkBc=;
 b=uYHlCUvjiAzYDp4rq138ew4x35KVtGcZUnrsvVwrLOlHMpEIU/N0cuxkpIsWg1dwo6
 CaftmxnEuz1NynUPbzhFZeWLeghJK+XXIbau0mPJQAaPvy4FVwz98WfGzNFmQcLop6Pa
 wtiJNW7tyq3dro6YaAzw5vLlugRl2zWR8mjwCEBWZNhieUSGP3BAZogHpPLifYrvnUqn
 /MKjTaZzvQ1p9BcfDHM7oyONj0f+GgDyi08XcS9ArHbBPrhOfq6u6D3Du+QjYbMUt9++
 hAAUfaWVZeAUC91duEei28CkfwWgjcHarfK2SGjgOmfTZwZu7+Td9knc+y1a2v7y8E5d
 HH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714597945; x=1715202745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3vsAs76CSrfRx9MU28GvVE6lBtvqHFj4sm2a7LpkBc=;
 b=Dk3ZnVs3av+FfUB3c2Sz/aVWUVPG8fGRsnCESAXCas/h8IYFt27f5O7HzW12rH8LgU
 yALH5RYGUqhbg4ueQF++Ofl7ckpVEF6HtZngzO2GpxVoJO0a1j4VCkTJ6UmivlOJt0lW
 ijB/fDBaBSqPfsusNOPrFK78Hg5cVk8xoqZhXcvcXQwabF0s+w5y6tcyeQxEXS9lxpV3
 v6gBtzDWZgUWDRWoRGBer1scIrvEp5EwSjhWcOIRL3wuf3wtZKVOC8TlWENJJrhH/s0R
 FMjQ6h2w6rpORJMnL+LWbOfISkOKIeDoOz20t1jErSRUsWXe1Ai9NUjoUvdhDa8MRLBB
 QeFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZSPgYADGkJIjko9RwxAuCfBePVobSduAkXm+Xk0to1xQzoj/jEGVLwikWRSrPKD86gbn+slXo9H1YK3iuOqSCI8G8PA==
X-Gm-Message-State: AOJu0YwNSKgsjbbPHEfSaMBsJ5sQbszAoS3G6fM+ReKJ0tEQsuxB23va
 nyv3kHM8lQcf1vo3EM/xRHgX4l6dKd46onji2fap9qk2Om7CJPKnnFrVJeOJ5eiAtpzlfnL7E7c
 5gyOoP/DhjTqJAKThD9gqo51WvUZIU/9K8GNnkQ==
X-Google-Smtp-Source: AGHT+IEWpuwwypfFQz3fvZSb5pKz/b3DE60Z89WYHljbIunNuu3jmeNofkQ0H/dqkNySo02XEuhoWJcxawXVyjOXs9c=
X-Received: by 2002:a25:ac57:0:b0:de4:6f1e:c9bb with SMTP id
 r23-20020a25ac57000000b00de46f1ec9bbmr36874ybd.26.1714597945427; Wed, 01 May
 2024 14:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
In-Reply-To: <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 1 May 2024 16:12:14 -0500
Message-ID: <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Sean Anderson <seanga2@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Julien Masson <jmasson@baylibre.com>,
 u-boot@lists.denx.de
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

On Wed, Apr 10, 2024 at 9:53=E2=80=AFPM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> On 3/7/24 19:04, Sam Protsenko wrote:
> > Sometimes clocks provided to a consumer might not have .set_rate
> > operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE flag
> > set. In that case it's usually possible to find a parent up the tree
> > which is capable of setting the rate (div, pll, etc). Implement a simpl=
e
> > lookup procedure for such cases, to traverse the clock tree until
> > .set_rate capable parent is found, and use that parent to actually
> > change the rate. The search will stop once the first .set_rate capable
> > clock is found, which is usually enough to handle most cases.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---

[snip]

>
> Can you give an example of where this is needed?
>

Sure. In my case it's needed for eMMC enablement on E850-96 board.
eMMC node in the device tree [1] is a gate clock
(CLK_GOUT_MMC_EMBD_SDCLKIN), so the MMC driver won't be able to change
its rate. But that clock actually has CLK_SET_RATE_PARENT flag set in
the clock driver [2]. So the right thing to do in this case (and
that's basically how it's done in Linux kernel too) is to traverse the
clock tree upwards, and try to find the parent capable to do .set_rate
(which is usually a divider clock), and use it to change the clock
rate. I'm working on exynos_dw_mmc driver [3] right now, making it use
CCF clocks, but I can't do that before this patch is applied.

Grepping the U-Boot tree I can see the CLK_SET_RATE_PARENT flag is
also used in various IMX clock drivers and STM32MP13 clock driver. I
guess without this change those flags will be basically ignored.

Thanks!

[1] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/exynos8=
50.dtsi#L408
[2] https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/clk/exynos/c=
lk-exynos850.c#L353
[3] https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/mmc/exynos_d=
w_mmc.c#L117

> --Sean
