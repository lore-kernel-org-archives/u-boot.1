Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB10C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B466E88816;
	Wed,  3 Jul 2024 17:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HyMvoXoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FA4887E7; Wed,  3 Jul 2024 17:00:44 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38EC788816
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 17:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a72510ebc3fso822808966b.2
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720018840; x=1720623640;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn070vh5guPcbPMWkf4Ffcn17Les4k5C0ou+QdL25uk=;
 b=HyMvoXoq+GfV3M1w/djRmtE0XSgfb8mOk6jTTqg/wBFizS1J/CLrk3lXv9coRqlxwj
 wSWQAjfLmIvK2fux40UWzB4OeIDLtUd+FzFFBG9QcuNpIKgnLB53fjt7BUx4QprVvt5h
 qDYvw5cw81nefy224JzX0YXZ1ZHZMo+k+2evE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720018840; x=1720623640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tn070vh5guPcbPMWkf4Ffcn17Les4k5C0ou+QdL25uk=;
 b=fBXlNFzmZLInG0FoGQ8gIHrH6MwWmHtvgBynGDjp0hXe4+La6yvKjtLau8U2khVotE
 LGpHwglpJZsVx150yuzYW45VDzp6+6N9ui+T2/CraRJIxGtVyzkpBhqqOlUW1oe1aS9O
 eLojyMSfHhhksk1J3iotlYOgF0KMwnbHIlkfvIorx7CBwKvLaG3NWdhJBeu7gM8XQN52
 KF679zAiqogNJ/9c/6XGBU9MCZPjQJCtPRNUm8qqjG0PSh7OvbWxHQ4j8MPjXQfrMBJk
 QmXbqRKD7Wn0PxdritEJskFvbDSVu8NZBtP1mOADW3d9emyu9BEqWV9RZKBZMrwR8LNC
 jhLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVsr5klpSeblcKLG40p2eLACRBPuwsD7gj+HtLt4M/RW3ewvO8NAE1JuNXe7SMBzy3qk6bjKZoayG1T7aXAroDbOuT7A==
X-Gm-Message-State: AOJu0YzNrGlpTsvLxWjKgoMs3hfXUIBcu1hwSItbc1W793u1u/VJk2lh
 tKMm2Ktd2xbzLzYdpCS0gcDLjpuxBTM2ua9TTuF2ExsTPfi0cj5u66oMbR8IbonG86xcP4g5oq2
 trz5w5pdf4V2phnqHax1t220zExSkppXs/IbOrA==
X-Google-Smtp-Source: AGHT+IHKN7+9WeSsJSu0BvCGUCXW+MUi/tNcsInG5CVoTO5cGosl/AAmCBI/R4/44BeXy18v46LaYRFWt2OZqNSFRbE=
X-Received: by 2002:a17:907:7f11:b0:a6f:e5f7:e966 with SMTP id
 a640c23a62f3a-a7514475b33mr908357466b.45.1720018840463; Wed, 03 Jul 2024
 08:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
 <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
 <20240613153310.GM68077@bill-the-cat>
In-Reply-To: <20240613153310.GM68077@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 3 Jul 2024 17:00:28 +0200
Message-ID: <CAOf5uwm8ez2MxirkxYQ=VXQOnV9z2s3zeKMPMJnhBa-QRXV9eA@mail.gmail.com>
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
To: Tom Rini <trini@konsulko.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
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

Hi all

Working on the clock now. I have done a different implementation

clk-mux, clk-gate I have added a clk_generic_set_rate that is a stub
that propagate to the parent, I think that should work the same but
wihout this while and even on preparation on more
changes I need. Can be work on your case too?

Michael

On Thu, Jun 13, 2024 at 5:33=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Jun 10, 2024 at 02:43:17PM -0500, Sam Protsenko wrote:
> > On Tue, May 14, 2024 at 3:26=E2=80=AFPM Sam Protsenko
> > <semen.protsenko@linaro.org> wrote:
> > >
> > > On Wed, May 1, 2024 at 4:12=E2=80=AFPM Sam Protsenko <semen.protsenko=
@linaro.org> wrote:
> > > >
> > > > On Wed, Apr 10, 2024 at 9:53=E2=80=AFPM Sean Anderson <seanga2@gmai=
l.com> wrote:
> > > > >
> > > > > On 3/7/24 19:04, Sam Protsenko wrote:
> > > > > > Sometimes clocks provided to a consumer might not have .set_rat=
e
> > > > > > operation (like gate or mux clocks), but have CLK_SET_PARENT_RA=
TE flag
> > > > > > set. In that case it's usually possible to find a parent up the=
 tree
> > > > > > which is capable of setting the rate (div, pll, etc). Implement=
 a simple
> > > > > > lookup procedure for such cases, to traverse the clock tree unt=
il
> > > > > > .set_rate capable parent is found, and use that parent to actua=
lly
> > > > > > change the rate. The search will stop once the first .set_rate =
capable
> > > > > > clock is found, which is usually enough to handle most cases.
> > > > > >
> > > > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > > > ---
> > > >
> > > > [snip]
> > > >
> > > > >
> > > > > Can you give an example of where this is needed?
> > > > >
> > > >
> > > > Sure. In my case it's needed for eMMC enablement on E850-96 board.
> > > > eMMC node in the device tree [1] is a gate clock
> > > > (CLK_GOUT_MMC_EMBD_SDCLKIN), so the MMC driver won't be able to cha=
nge
> > > > its rate. But that clock actually has CLK_SET_RATE_PARENT flag set =
in
> > > > the clock driver [2]. So the right thing to do in this case (and
> > > > that's basically how it's done in Linux kernel too) is to traverse =
the
> > > > clock tree upwards, and try to find the parent capable to do .set_r=
ate
> > > > (which is usually a divider clock), and use it to change the clock
> > > > rate. I'm working on exynos_dw_mmc driver [3] right now, making it =
use
> > > > CCF clocks, but I can't do that before this patch is applied.
> > > >
> > > > Grepping the U-Boot tree I can see the CLK_SET_RATE_PARENT flag is
> > > > also used in various IMX clock drivers and STM32MP13 clock driver. =
I
> > > > guess without this change those flags will be basically ignored.
> > > >
> > > > Thanks!
> > > >
> > >
> > > Hi Sean,
> > >
> > > Just wanted to check if you think my explanation above is ok and the
> > > patch can be applied? I'm finishing my new patch series for enabling
> > > MMC on E850-96, but this patch has to be applied first.
> > >
> > > Thanks!
> > >
> >
> > Hi Tom,
> >
> > Would it be reasonable to ask you to take care of this patch? It's
> > been ignored for 3 months now, but it's needed for eMMC enablement on
> > E850-96 board.
>
> Any comments at this point Sean?
>
> --
> Tom



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
