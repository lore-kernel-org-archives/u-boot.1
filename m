Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05659C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C60A87EED;
	Mon, 26 Feb 2024 14:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kb5KgRrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773E887EED; Mon, 26 Feb 2024 14:44:05 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FBB8785F
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 14:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d2e21181c1so2056986241.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708955036; x=1709559836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VFIPkAs9Cb19I8n9QhR0cO2ph5q3YNq+GNZdnxLs0QI=;
 b=kb5KgRrUGGRHco6+YHTvJV4NLsQxb/+HPhDDtibBHIRHVc7Ho+lvJ37h62PSKe7ZPg
 fxDXeaVCNOy4E+B1C9n6awylio0uR7uUAy0GV2ON/bnuFyirlCzKoz6i/gk159/vyFmR
 4EPrZTWs8kNdFmWBsradIsP1kq4OiHEk7UhM71QPHASwdV8va50PWjnfBy4Wei9t7OR9
 ce0Frxc6n8fKqnLfBA6YPdzE19gy0OO6EXqw7oM7eaiWvre68qGtQxzSnX99mjgOnaO5
 zEh4kl0TLRv2ax3yXrc8cLW935ZTpTbLw2srdV8uvyhRcGznJPo4BMH0MDjRizlOOM+Y
 nqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708955036; x=1709559836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFIPkAs9Cb19I8n9QhR0cO2ph5q3YNq+GNZdnxLs0QI=;
 b=olidsBmGCeoYa21cZ42CeuAnrQhHSiAwZOzRCYHxMHrsSXEaffR5+AAZcu3ko56iCD
 5LQwnLe3fxnFy9cbTtoHmc3q1CwcJign8l1A6oyVhmycNezjp7tIRRNJxRwMgb30Ngle
 mbjnDFwIyDN+jPnaFDq/Ce3DNOcD85DnRf/kJzxa6lVRrFt66DHS/Phh25FP3Nc91EZW
 7HKPCIz+lyXfQRImqiLqp5uPO3ZExjIkRXg4KUGOzK57opUywTJWDhSnT849fKupr+Vz
 kz6r7MWnbDwSrqInt/d+QjeZaaUKym5WVmIgLUM5DRh2uMSf9VNYXefxZORamwVs+rm4
 TEAw==
X-Gm-Message-State: AOJu0YygtOLe5cSTSpIuK5Q2kXJLStJPpG0hsM3RptjpGYN1cRvNiqoR
 bkH1yXd3YJ0H7znLJje4dtsZ6dJeEUMlu8TVPwFeLlLcGfuAlwUblgcbKDsEyssTZdecOrT3vuS
 VFTnu3mlMpMBtxa//PIpvyq3rRXnmW5NXUGYJgg==
X-Google-Smtp-Source: AGHT+IGYpIPFyyosYbBBG4UJepnXh5L1edYjvr/DM12lOpcVEudj0BuT5D6PBwlNPZlIIGddkTi20jnIKl3VUA01AQY=
X-Received: by 2002:a67:fbd5:0:b0:470:5d0a:14f3 with SMTP id
 o21-20020a67fbd5000000b004705d0a14f3mr3576525vsr.15.1708955036635; Mon, 26
 Feb 2024 05:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-5-sumit.garg@linaro.org>
 <8c36eac1-2b6b-4810-b4c9-1b8912bfe81e@denx.de>
 <CAFA6WYO2n-QG7TvSnKyk5O0Pzwcn0jd4iCeLbebbsVZiOq2fdQ@mail.gmail.com>
 <6aee8c88-f333-4dcc-aba2-cb37d60b5697@denx.de>
In-Reply-To: <6aee8c88-f333-4dcc-aba2-cb37d60b5697@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 19:13:45 +0530
Message-ID: <CAFA6WYN6_QL-NHHNSSCQF8+HQppK8=qwpEjmOvGpiTfjTR+cHg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] imx8mp: power-domain: Expose high performance PLL
 clock
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 18:31, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 1:39 PM, Sumit Garg wrote:
> > On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 2/26/24 9:04 AM, Sumit Garg wrote:
> >>> Expose the high performance PLL as a regular Linux clock, so the
> >>> PCIe PHY can use it when there is no external refclock provided.
> >>>
> >>> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> >>> drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> >>
> >> Commit ID, please, see previous comments in this series.
> >>
> >> [...]
> >>
> >>> +static int hsio_pll_clk_enable(struct clk *clk)
> >>> +{
> >>> +     void *base = (void *)dev_get_driver_data(clk->dev);
> >>> +     u32 val;
> >>> +     int ret;
> >>> +
> >>> +     /* Setup HSIO PLL */
> >>> +     clrsetbits_le32(base + GPR_REG2,
> >>> +                     P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
> >>> +                     FIELD_PREP(P_PLL_MASK, 12) |
> >>> +                     FIELD_PREP(M_PLL_MASK, 800) |
> >>> +                     FIELD_PREP(S_PLL_MASK, 4));
> >>
> >> These magic numbers 12, 800, 4 could use explanation (why these
> >> numbers?) and a dedicated macro .
> >>
> >
> > I can't find any information in TRM as to how HSIO PLL computation is
> > done. However, I can extend the comment above to say that this
> > configuration leads to a 100 MHz PHY clock as per
> > clk_hsio_pll_recalc_rate() in Linux kernel driver.
>
> Try the CCM section 5.1.5.4.4 SSCG and Fractional PLLs I think,

That section also does mention following:

"The ARM PLL, GPU PLL, VPU PLL, DRAM PLL, Audio PLL1/2, and Video PLL1 are
fractional PLLs. The frequency on these can be tuned to be very
accurate to meet audio
and video interface requirements."

without any mention of HSIO PLL.

> this is
> likely PLL14xxx from Samsung, so
>
> f_out = f_in * M / P * 2^S
>
> I think f_in is something like 24 MHz, so 24 * 800 / 12 * 16 = 100 MHz
>
> P - predivider
> S - subdivider (output divider)
> M - multiplier

IMO, we shouldn't document something based on our analysis but rather
it should be based on facts.

>
> >>> +     /* de-assert PLL reset */
> >>> +     setbits_le32(base + GPR_REG3, PLL_RST);
> >>> +
> >>> +     /* enable PLL */
> >>> +     setbits_le32(base + GPR_REG3, PLL_CKE);
> >>> +
> >>> +     /* Check if PLL is locked */
> >>> +     ret = readl_poll_sleep_timeout(base + GPR_REG1, val,
> >>> +                                    val & PLL_LOCK, 10, 100000);
> >>> +     if (ret)
> >>> +             dev_err(clk->dev, "failed to lock HSIO PLL\n");
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +static int hsio_pll_clk_disable(struct clk *clk)
> >>> +{
> >>> +     void *base = (void *)dev_get_driver_data(clk->dev);
> >>> +
> >>> +     clrbits_le32(base + GPR_REG3, PLL_CKE);
> >>> +     clrbits_le32(base + GPR_REG3, PLL_RST);
> >>
> >> Can you clear both at once, or do they have to be cleared in sequence ?
> >
> > I generally follow the reverse sequence of how the configuration is
> > done during hsio_pll_clk_enable(). These bits have seperate functions
> > related to clock and reset. So I would prefer to keep them as they
> > are.
>
> Linux does this in drivers/pmdomain/imx/imx8mp-blk-ctrl.c :
>
> 120 static void clk_hsio_pll_unprepare(struct clk_hw *hw)
> 121 {
> 122         struct clk_hsio_pll *clk = to_clk_hsio_pll(hw);
> 123
> 124         regmap_update_bits(clk->regmap, GPR_REG3, PLL_RST | PLL_CKE, 0);
> 125 }
>

And just above it:

static int clk_hsio_pll_prepare(struct clk_hw *hw)
{
...
        /* de-assert PLL reset */
        regmap_update_bits(clk->regmap, GPR_REG3, PLL_RST, PLL_RST);

        /* enable PLL */
        regmap_update_bits(clk->regmap, GPR_REG3, PLL_CKE, PLL_CKE);
...
}

That's an anti-pattern in the Linux kernel driver which we shouldn't
copy, right?

-Sumit

> [...]
