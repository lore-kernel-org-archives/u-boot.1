Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C9BC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 19:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF1F88684;
	Mon, 10 Jun 2024 21:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TP2iSno5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF65884A0; Mon, 10 Jun 2024 21:43:31 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF988852E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 21:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dfa59c35e44so5094465276.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718048608; x=1718653408; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkjNwIZ0C+TCSd60OVli4OZCPFU+9Q8mcyttmZ1miSg=;
 b=TP2iSno5HaRQOLA/upkHsu5dGoXBFf4hw/ch671B9oKdYsO8NawRt1aTX09S5a2EUQ
 Xs3TwcDrMgIYntsSQeRyCmDZITh4AHyoAunKXLwQmOiBHRwQ66erEv4Kf5JHEOr0ntQq
 cCPV44m8dJ32gxAuhCENxVyFf3HUcsG9bAoQ/g1POZ/CTi9FVrGHw6EXz/5Xel4Zxo6o
 BBX9BNaVYBvpLXeBX9iydSxZNmfEYvAxeC3WuJFb2KpqWtDpBMUg2eYLQXzl5eayzUMf
 vnwFys+i5/rbPe2p9CYXS9w6szetDzEUvdclv05Xv90oQhtcQlJVH3FjxiqIYCXb/ptH
 2skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718048608; x=1718653408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkjNwIZ0C+TCSd60OVli4OZCPFU+9Q8mcyttmZ1miSg=;
 b=bCRzFtWk+aNFkMQVP7m5MeR5/0VDLHM0JpwRizuNamRMF2U7+v0uKLD6ZEsZ8vW9sP
 fO4YyzTs7whu+a0vA42S0ZNh/Mf2JsgU97JKkNvzm5eShP2iJxm5dcEb6aukt13DA368
 TZgYL06eul4F6sGq9JuhkWz1zZkQ6GGHW1SE59Ex5HsHQJq9T6mu28KHmxMbG3nlJHZU
 /7tqVz60DenslyJzEqAXEqRO7gjZg3/qPtEpcooWyIQvRp8I9M+KkQnqaJ+0avDbKRDF
 H+Q+0qZjQvlc6BzKP3wKk3XrqoGFYWQvvFCRknpMBoipTLq/j4PgDmXEvWRXVsnF2dlV
 iL8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfuoqPNfHfqvtLW4geLZqglhHYA5KJDQsoes2LeGHN5TzvV9yU/gRxK5/Tm1yI8lMG53LDewNFtOZrkrKj1E4CC1jvOw==
X-Gm-Message-State: AOJu0Yx/zguxipCMA9aJiFNQeLH/J6GtitthwqppTMrleUX+4SbIL2WM
 RoatS5U1XuQmlDqvwps4Zg0fLQ9+3DADLw8sehuNC8l1n0vza2aIOvjYtrEavKv9MXDGzHSlsLx
 KluHTg3npIWfgkoKepqIVsA3CRT/o3bZlFFqEFw==
X-Google-Smtp-Source: AGHT+IEz9Zja2jl/6NMiUEjotuVVCRhC9UKyiHOrFin05UScP3aA1I4TgJ+XoIp6mk5NsEV53T2f/zVbHZ2jZ9uVTHE=
X-Received: by 2002:a05:6902:1026:b0:dfa:5748:124c with SMTP id
 3f1490d57ef6-dfaf65b677dmr10649319276.10.1718048608002; Mon, 10 Jun 2024
 12:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
In-Reply-To: <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 10 Jun 2024 14:43:17 -0500
Message-ID: <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Sean Anderson <seanga2@gmail.com>
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

On Tue, May 14, 2024 at 3:26=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Wed, May 1, 2024 at 4:12=E2=80=AFPM Sam Protsenko <semen.protsenko@lin=
aro.org> wrote:
> >
> > On Wed, Apr 10, 2024 at 9:53=E2=80=AFPM Sean Anderson <seanga2@gmail.co=
m> wrote:
> > >
> > > On 3/7/24 19:04, Sam Protsenko wrote:
> > > > Sometimes clocks provided to a consumer might not have .set_rate
> > > > operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE f=
lag
> > > > set. In that case it's usually possible to find a parent up the tre=
e
> > > > which is capable of setting the rate (div, pll, etc). Implement a s=
imple
> > > > lookup procedure for such cases, to traverse the clock tree until
> > > > .set_rate capable parent is found, and use that parent to actually
> > > > change the rate. The search will stop once the first .set_rate capa=
ble
> > > > clock is found, which is usually enough to handle most cases.
> > > >
> > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > ---
> >
> > [snip]
> >
> > >
> > > Can you give an example of where this is needed?
> > >
> >
> > Sure. In my case it's needed for eMMC enablement on E850-96 board.
> > eMMC node in the device tree [1] is a gate clock
> > (CLK_GOUT_MMC_EMBD_SDCLKIN), so the MMC driver won't be able to change
> > its rate. But that clock actually has CLK_SET_RATE_PARENT flag set in
> > the clock driver [2]. So the right thing to do in this case (and
> > that's basically how it's done in Linux kernel too) is to traverse the
> > clock tree upwards, and try to find the parent capable to do .set_rate
> > (which is usually a divider clock), and use it to change the clock
> > rate. I'm working on exynos_dw_mmc driver [3] right now, making it use
> > CCF clocks, but I can't do that before this patch is applied.
> >
> > Grepping the U-Boot tree I can see the CLK_SET_RATE_PARENT flag is
> > also used in various IMX clock drivers and STM32MP13 clock driver. I
> > guess without this change those flags will be basically ignored.
> >
> > Thanks!
> >
>
> Hi Sean,
>
> Just wanted to check if you think my explanation above is ok and the
> patch can be applied? I'm finishing my new patch series for enabling
> MMC on E850-96, but this patch has to be applied first.
>
> Thanks!
>

Hi Tom,

Would it be reasonable to ask you to take care of this patch? It's
been ignored for 3 months now, but it's needed for eMMC enablement on
E850-96 board.

Thanks!

> > [1] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/exy=
nos850.dtsi#L408
> > [2] https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/clk/exyn=
os/clk-exynos850.c#L353
> > [3] https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/mmc/exyn=
os_dw_mmc.c#L117
> >
> > > --Sean
