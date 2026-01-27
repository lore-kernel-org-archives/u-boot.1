Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C0FD25920
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 02:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3170A83F50;
	Tue, 27 Jan 2026 03:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfy0Ss8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CBD83F5D; Tue, 27 Jan 2026 03:55:22 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5EB83BFE
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 03:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8710c9cddbso633113366b.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 18:55:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769482519; cv=none;
 d=google.com; s=arc-20240605;
 b=d3TG46lAfvS/ONETNYE+XKAKw4cEFaKIcP/fBbGcjcKye/HPAca71v5oV+xd3XD4n+
 UahBi2ympZxiJ9KGMvPZrU8EZ/H9xOFOQ5kuGaz1s2liXd8do2oC4LFtYWeKWuYEFu0c
 QY5LF0nfqNnd7eqJoyfisMdonOPiWw5UzdingrHm0cSulQoo2QFLk60HcARpihfEkRV/
 e2tY/JC1uqALdMmM+UQK4NTq+XWxjr5/N8ACld6QQW0eqoeocEYKRCbBBcQPfNXJKLa4
 1+30HtR8nD71U1r2jt+lER3sfulnCj3Dvrl7RVnTtqN7JZxemqjTdsDyrPyifcOC6RZR
 WTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M8mUslVE4EtU6qtCbwH1jzBcY2TNDDMscnMGnJ1pGcE=;
 fh=pLPW9G0nY5afxya6J1SRRFm4G5WR9SZHRKprXg8519M=;
 b=FxtuEDqfOFJsX4z+fKlJ+6TGIj4slHwf2paBKMuhm69DU0JCgwyRmiFOBwG9FzZLiE
 1HedY4gEROKwe1wvYySh6F+Xj6OlHyOCiM6+5Bwlig+1Th7iT/nStVqJBL3EWUNvB0tf
 vslwrL/Xn1wFUz36FuEzpetYXeSF7nbCuzVm15kTHICzHyKgZ7pK36WEGx6pJdBxz3ln
 CEce7DG8HqhRbw5EpL+ObAp0mQTZhKHOe7pNk81kZNN+C+nTJzhzZYQb0kgmhjTMNGfL
 SE+uqh960bqNJzaUHsFjwWJogmgp3MyD8kei4VUmTZDyZUUyHT4s3QWgq6jH3/eTftsT
 XXpw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1769482519; x=1770087319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M8mUslVE4EtU6qtCbwH1jzBcY2TNDDMscnMGnJ1pGcE=;
 b=hfy0Ss8rrwAPWu2DBKzHtc4yXtZTGKJu2T3ime7XHWRpVwTD+/Vughndv1e3K8UqnV
 u1r+giGFiFcBwI4BH275wFI8OyhoXO+Lhohjpd+nmvrKnGPUz9xCA0z/M3ZYf3szr/ya
 QtXsPCb8df/t2vzxh/W5dTeUfkRwN6mjn3V+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769482519; x=1770087319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8mUslVE4EtU6qtCbwH1jzBcY2TNDDMscnMGnJ1pGcE=;
 b=Mb7THmck/zr0r+nkQWjYFSdtjNQP+P76wHY4t1pZIQivvVdt0QVDL1GI4EtZ2iPjlr
 0nM1jT7REgRCCGF8RHj69lbgz8PpQFfExOh+SoHQ7cZKO/fKcdg5rueSqXJnzlWceRV+
 1y6aDKnl/JrgQ0fGS7W0yTQp4CS3ijAXB4Y8gmDYZSOddLJToaJa6kX5am5JDawRxGha
 fkqtfHGfyiN51RGj9yZgvFvbw0FiXiVBnyC8wHvSwhq5xXFz4dDUYT2GeOROURwdiD+U
 2uYyh0ziTYGRhkiD3XDwKkVGsdxQHuW3mNKwm/gO+6w/iqva7SONjd0q+IBI2vwhtPSK
 071g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM0FX6g73hlJPrjhXncM6WDYU42jHkt6grUdt73Vpc4obynv58wc+RpQ2GEEbk9gHFnOSOaTM=@lists.denx.de
X-Gm-Message-State: AOJu0YyvugaGtLGBlxj9H+x72hdJKb2jjSU9s4b/NifKFu/H5+vGW+Ir
 ZyyJSLvR8LcCFd07WJJDoRHKnKdIuRXnipkHp3QpqSIRzFvEDmYmIc6p3XlZ+toSsNTJ3TAy2uF
 2SdUoJx9c8WNoSamZ5JFERJPgyrw35jj13i48dpZj
X-Gm-Gg: AZuq6aIIjxHHMr7BY8C1yXtOeWJgk9p6sRiS7LrXJFBWBezAG8UCdMQ7LE8Orz9VDpV
 BcQddMwnul2bbdvX8k6twW6EW0exJ18QtalZl43YIslopgcD1GVmDitI0T9fy+eQF1KjoGnYjLD
 gSpSsyPrVSC/LgGMZVG5F8MzYi+4mc/aN9EI0pxaoeTsmcSaCDur87MXPVu2thnSuGPwAJJWHkD
 ECOF1QcGnMO+nVnbeLC5qDxubtAljBqOGx57UGkjqf+4GM7dus2mb8Yk/7DnTwLBgXKKo6h
X-Received: by 2002:a17:907:3e13:b0:b88:3bb9:e2d1 with SMTP id
 a640c23a62f3a-b8dab3d97f4mr25835066b.60.1769482519178; Mon, 26 Jan 2026
 18:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-15-marex@denx.de>
 <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
 <9dbccbf2-39a7-48a0-9d2c-79de220c07f3@canonical.com>
In-Reply-To: <9dbccbf2-39a7-48a0-9d2c-79de220c07f3@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Jan 2026 15:55:18 +1300
X-Gm-Features: AZwV_Qgbol-xD9ZK5MT3EkSDn3XaH9FEkwTg13MZHHLUdNdPj1A4vfKv3g_Jg6U
Message-ID: <CAFLszTh7-9a7F9h+knc1CMNvm8C=gXLZhLZ+W5eJDEZ_e5pc2A@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marex@denx.de>, Hal Feng <hal.feng@starfivetech.com>, 
 Minda Chen <minda.chen@starfivetech.com>, Adam Ford <aford173@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, 
 Fabio Estevam <festevam@denx.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de, E Shattow <lucent@gmail.com>
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

Hi Heinrich,

On Mon, 31 Mar 2025 at 05:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 30.03.25 17:15, Heinrich Schuchardt wrote:
> > On 23.03.25 16:58, Marek Vasut wrote:
> >> Use clock-names property which is accessible via parent clock OF node
> >> to look up the parent clock by name instead of depending on unreliable
> >> global clock name to perform look up.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >
> > This patch breaks booting starfive_visionfive2_defconfig in the SPL stage.
> >
> > To dig a bit deeper I enabled the debug UART for SPL with these setting
> > on origin/master (5e74863ad6613df):
> >
> > CONFIG_DEBUG_UART=y
> > CONFIG_DEBUG_UART_NS16550=y
> > CONFIG_DEBUG_UART_BASE=0x10000000
> > CONFIG_DEBUG_UART_CLOCK=24000000
> > CONFIG_SPL_DEBUG_UART_BASE=0x10000000
> > CONFIG_DEBUG_UART_SHIFT=2
> >
> > clk_register: failed to get pll0_out device (parent of perh_root)
> > clk_register: failed to get pll0_out device (parent of qspi_ref_src)
> > clk_register: failed to get pll0_out device (parent of usb_125m)
> > clk_register: failed to get pll0_out device (parent of gmac_src)
> > clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
> > clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
> >
> > Marek assumes that property bootph-pre-ram might be missing for some
> > clocks in arch/riscv/dts/jh7110-u-boot.dtsi.
>
> This change suggested by Marek resolves the issue:
>
> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi
> b/arch/riscv/dts/jh7110-u-boot.dtsi
> index ce7d9e16961..4ed764393bb 100644
> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
> @@ -113,3 +113,7 @@
>   &sys_syscon {
>          bootph-pre-ram;
>   };
> +
> +&pllclk {
> +       bootph-pre-ram;
> +};

I just hit this as well, thanks for the post.

However, -master still does not boot for me on vf2:

U-Boot SPL 2026.04-rc1 (Jan 26 2026 - 19:52:48 -0700)
DDR version: dc2e84f0.
Trying to boot from MMC2
spl: partition error
Error: -38
SPL: Unsupported Boot Device!
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

Regards,
Simon

>
> >
> >> ---
> >> Cc: Adam Ford <aford173@gmail.com>
> >> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> >> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> >> Cc: Fabio Estevam <festevam@denx.de>
> >> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> >> Cc: Peng Fan <peng.fan@nxp.com>
> >> Cc: Tim Harvey <tharvey@gateworks.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.denx.de
> >> Cc: uboot-imx@nxp.com
> >> ---
> >> V2: Rebase on u-boot/next with additional clock patches
> >> ---
> >>   drivers/clk/clk-composite.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> >> index 1191bdf87df..9e3b5191767 100644
> >> --- a/drivers/clk/clk-composite.c
> >> +++ b/drivers/clk/clk-composite.c
> >> @@ -149,7 +149,7 @@ struct clk *clk_register_composite(struct udevice
> >> *dev, const char *name,
> >>       clk = &composite->clk;
> >>       clk->flags = flags;
> >>       ret = clk_register(clk, UBOOT_DM_CLK_COMPOSITE, name,
> >> -               parent_names[clk_composite_get_parent(clk)]);
> >> +        clk_resolve_parent_clk(dev,
> >> parent_names[clk_composite_get_parent(clk)]));
> >>       if (ret) {
> >>           clk = ERR_PTR(ret);
> >>           goto err;
> >
>
