Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42186C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 20:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7452187527;
	Tue, 14 May 2024 22:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fpTpnZzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0F187527; Tue, 14 May 2024 22:26:44 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F3E871C7
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 22:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-61e0c2b5cd2so48308487b3.1
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715718400; x=1716323200; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hljhHZT0YBIuxtEL2XUiKvaJqsx0YEa2X9Prfx7GeoQ=;
 b=fpTpnZznNbg60p4ByUteqd4bHYK9EuenM5J0NbpLGpBEBT9KMXzBuS/fx1mrqbpJDg
 prRLkfn0ppz4OMc/0c36I5R68g2kQ9TP95vM4kCB888Lj0Msbf/fCiZorXfjrZs/4YZU
 kCWlU77kf9G4ampBOdPTSqbY/U9CwJS4rjcf6FBxknHjHP9Ec8BX6dhDFI3nPri5IKkQ
 Wtdv4KY+1+LmoTdO2XpKMCP2Jnu/0J7zkL3fDS03erPT2+4ZS0wiyFnBUXD5CmVaSy9+
 ZE7YpkPvEIon6x8/4fWxOD3y72U2tt6G3RVFHX87gOJZjaHKLX2jlWF7rqoSSIt0xGBV
 XaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715718400; x=1716323200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hljhHZT0YBIuxtEL2XUiKvaJqsx0YEa2X9Prfx7GeoQ=;
 b=OzQgIKcTc96DAZtAkPHEepYBHKSPHvZq0x0Yc2fPydBypq1rDUiTsqDnj/U0YFt/wT
 Tz2kfSsq+aRKXgeXp3t183gGdnnnxT/kq/Tf2Z6RdhvtggoeCzAatUEalGeC1JcMdjkP
 dWfzpjnIh5dO4hz1TMBq6xsbuJ6IzwonuHebnJUrcA50xaA9aNQv12fkCQQOeJTzWvUQ
 3SXZrtNpYJa0G7ELZFY58HJDJB2/iZuqbrBC6gJr9OazrBobYMIX2PP/W+rhEeSJtwZo
 0XPbFp6xUpkTTKAGrxx32+YoUK8DBCw82iR69qSuiyslUmkoEu0j2ItD1nGYBam5Dvae
 XiYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkLS0RgVjVWJoBNrmXcylgy8oIOkz+RYogkd+Z3Flcc74Ug5PHqHLewGD5xtkNhuGNuZ+JwgPv0ZgJYZ9Vy85IE/uFfg==
X-Gm-Message-State: AOJu0YxjVjm+wZGsvd+tEt0NAy1eJ5IXyyaAwleTsERdOYTMn/FeBQaO
 k6C8uOx/JYnQfHZsUoDIaRMCb+zQG6OLzwI75wnZvV4+a+V4XKw3Ek17II3lw7PxzVxoInpc7qu
 2PbPA7bsrHlhCR6xyv9Tk1Jn0XXd0NsUbZyEdLQ==
X-Google-Smtp-Source: AGHT+IHNmgbe+UFTr6URgJOwfo3JpXAuydF5A1+DIsAp48smF16RSIRuQeqjDRueB3wVBioNRDZiLt2p78Cs2Xrb31o=
X-Received: by 2002:a0d:db12:0:b0:615:73f:d52d with SMTP id
 00721157ae682-6255811bedemr15836397b3.17.1715718400663; Tue, 14 May 2024
 13:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
In-Reply-To: <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 14 May 2024 15:26:29 -0500
Message-ID: <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
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

On Wed, May 1, 2024 at 4:12=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> On Wed, Apr 10, 2024 at 9:53=E2=80=AFPM Sean Anderson <seanga2@gmail.com>=
 wrote:
> >
> > On 3/7/24 19:04, Sam Protsenko wrote:
> > > Sometimes clocks provided to a consumer might not have .set_rate
> > > operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE fla=
g
> > > set. In that case it's usually possible to find a parent up the tree
> > > which is capable of setting the rate (div, pll, etc). Implement a sim=
ple
> > > lookup procedure for such cases, to traverse the clock tree until
> > > .set_rate capable parent is found, and use that parent to actually
> > > change the rate. The search will stop once the first .set_rate capabl=
e
> > > clock is found, which is usually enough to handle most cases.
> > >
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
>
> [snip]
>
> >
> > Can you give an example of where this is needed?
> >
>
> Sure. In my case it's needed for eMMC enablement on E850-96 board.
> eMMC node in the device tree [1] is a gate clock
> (CLK_GOUT_MMC_EMBD_SDCLKIN), so the MMC driver won't be able to change
> its rate. But that clock actually has CLK_SET_RATE_PARENT flag set in
> the clock driver [2]. So the right thing to do in this case (and
> that's basically how it's done in Linux kernel too) is to traverse the
> clock tree upwards, and try to find the parent capable to do .set_rate
> (which is usually a divider clock), and use it to change the clock
> rate. I'm working on exynos_dw_mmc driver [3] right now, making it use
> CCF clocks, but I can't do that before this patch is applied.
>
> Grepping the U-Boot tree I can see the CLK_SET_RATE_PARENT flag is
> also used in various IMX clock drivers and STM32MP13 clock driver. I
> guess without this change those flags will be basically ignored.
>
> Thanks!
>

Hi Sean,

Just wanted to check if you think my explanation above is ok and the
patch can be applied? I'm finishing my new patch series for enabling
MMC on E850-96, but this patch has to be applied first.

Thanks!

> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/exyno=
s850.dtsi#L408
> [2] https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/clk/exynos=
/clk-exynos850.c#L353
> [3] https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/mmc/exynos=
_dw_mmc.c#L117
>
> > --Sean
