Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45180C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 12:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADEA87687;
	Fri, 27 Oct 2023 14:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fQdqPUDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B9087687; Fri, 27 Oct 2023 14:18:29 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E0387562
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 14:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7b6043d0b82so851994241.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698409105; x=1699013905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hk6sunEMDExsTnWshll1HbwdCLp2WiWUE1gPNi8rUfk=;
 b=fQdqPUDySzr9cEEcXr7cOR6ceodsX/XkdPtMRAw5+fQ/WCUc3dIOJ3vVkdlB+QxTHK
 Z9/QphAkBqiEqLuk0m/pz2j09HKXiz1+S1HnjNJiKloyyirqarRmWw3MPcMU4/eRlVY/
 lqo4YMcpDajAyDHJZEok2AMB/XeaQcbE5RMCPFIYIuTixQB1/EjZ05HcJ7mk9+8Nma6f
 OM+bIgnAdfkwR4bMwAKDv1exqVlBNS0N5i6kkN7jDaoYO+c6kmRqxoJvQSM1GI/RVi2J
 qHicHUDqe74aerCIueLuV7D54C2U+pYggX8Rp/x6V+rrpmYgVlguyLN9V3JwSacgt/RZ
 By5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698409105; x=1699013905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hk6sunEMDExsTnWshll1HbwdCLp2WiWUE1gPNi8rUfk=;
 b=EmSvNWjQR40XrjeHUISWVedxGnnR+9NvIHRBY8+P59t3y3MpgdPbeDXunPUL0malxD
 BmLXanNRHvuM4MgyYOczs9Ohyk2CM+fIkuvABgf3St3DtK695fPtw8daA4/M1AuuVsSt
 6/mWyIWjTogBDtogUehiI+4FSLfuc18LsAHJj4C+HojduJVQDyestJLowdHPa8Qlbz9i
 s54EFwlugR+OPzDqTUHIn6SoeIbmfTSjrxN2T1odT1HElh1KaxnBvUHzjHExs5zX9emw
 rVFzQhRMWkiRZFStKapdcCtAf+0opLEH+XkR3DE51LDWotCwUUwrwcneY2Ptq7M94Fp8
 tWwA==
X-Gm-Message-State: AOJu0YzpTEcWcI+Q3Oo5+qZ0yKI1aTSsbE1hUtLuapRQNYzaqntEsT6e
 GisYhmO7dWbWtqmF0R6jqP9qHDYpuxe6WztqvlGa4Q==
X-Google-Smtp-Source: AGHT+IHUWi2RJeTsh5v1pYOIHZElXhTkn76yPG4v3/pKjEqt1z5JSMeRVgEjbV6EujycSGx2zl2K1IlwLigTrQ1/bH0=
X-Received: by 2002:a67:c195:0:b0:458:3bd3:9ad7 with SMTP id
 h21-20020a67c195000000b004583bd39ad7mr2841374vsj.18.1698409104693; Fri, 27
 Oct 2023 05:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-8-9d96359b9a82@linaro.org>
 <184a6ae1-b911-4197-b311-645f4f795bae@linaro.org>
In-Reply-To: <184a6ae1-b911-4197-b311-645f4f795bae@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 27 Oct 2023 17:48:13 +0530
Message-ID: <CAFA6WYMGAi8pnp9A7c8BY9AtF4UN5p4=VVPVZOZo6BmxVm92HA@mail.gmail.com>
Subject: Re: [PATCH 8/8] clk/qcom: fix rcg divider value
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
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

On Wed, 25 Oct 2023 at 19:14, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 24/10/2023 21:23, Caleb Connolly wrote:
> > The RCG divider field takes a value of (2*h - 1) where h is the divisor.
> > This allows fractional dividers to be supported by calculating them at
> > compile time using a macro.
> >
> > However, the clk_rcg_set_rate_mnd() function was also performing the
> > calculation. Clean this all up and consistently use the F() macro to
> > calculate these at compile time and properly support fractional divisors.
> >
> > Additionally, improve clk_bcr_update() to timeout with a warning rather
> > than hanging the board, and make the freq_tbl struct and helpers common
> > so that they can be reused by future platforms.
> >
> > Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>
> [...]
> >
> >  #define CFG_MODE_DUAL_EDGE (0x2 << 12) /* Counter mode */
> >
> > -#define CFG_MASK 0x3FFF
> > +// Disable the HW_CLK_CONTROL bit
> > +#define CFG_MASK (0x3FFF | (1 << 20))
>
> There seems to be a bug in this patch that causes the actual clock rate
> to be wrong in some cases, most obvious with db845c UART. I had
> initially thought it to be a board issue but upon further investigation
> I think I'm wrong.
>
> The UART clock frequency table in clock-sdm845.c is taken from Linux,
> the 115200 baud rate corresponds to the lowest frequency (7372800Hz).
> However, with the implementation changes here, the RCG configuration
> actually results in a measured clock rate of 9085208Hz.
>
> If the entry is changed as follows
> -       F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625)
> +       F(7372800, CFG_CLK_SRC_GPLL0, 0.5, 192, 15625)
>

I would suggest we keep the frequency table aligned to the Linux tree.
We should try to fix the mismatch in the computation to support
fractional divisors.

-Sumit

> Then the resultant clock rate is 7372604Hz (within the tolerance)...
>
> I will resolve this for v2.
> >
> >  #define CFG_DIVIDER_MASK 0x1F
> >
> > -/* root set rate for clocks with half integer and MND divider */
> > +/*
> > + * root set rate for clocks with half integer and MND divider
> > + * div should be pre-calculated ((div * 2) - 1)
> > + */
> >  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
> >                         int div, int m, int n, int source, u8 mnd_width)
> >  {
> > @@ -99,17 +125,15 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
> >       /* Program MND values */
> >       setbits_le32(base + regs->M, m_val & mask);
> >       setbits_le32(base + regs->N, n_val & mask);
> > -     setbits_le32(base + regs->D, d_val & mask);
> > +     setbits_le32(base + regs->D, (d_val & mask) == mask ? 0 : (d_val & mask));
> >
> >       /* setup src select and divider */
> >       cfg  = readl(base + regs->cfg_rcgr);
> >       cfg &= ~CFG_MASK;
> >       cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
> >
> > -     /* Set the divider; HW permits fraction dividers (+0.5), but
> > -        for simplicity, we will support integers only */
> >       if (div)
> > -             cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
> > +             cfg |= div & CFG_DIVIDER_MASK;
> >
> >       if (n_val)
> >               cfg |= CFG_MODE_DUAL_EDGE;
>
> --
> // Caleb (they/them)
