Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C26C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2538A880E3;
	Wed, 20 Mar 2024 06:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PNL6+TDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4CF880E7; Wed, 20 Mar 2024 06:44:11 +0100 (CET)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA272880E1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4767bf3e2a2so1600538137.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710913447; x=1711518247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4/16Q0u4XfDWKs7JnqPsJfRW0BUXP9xd/rNaGwBPpRc=;
 b=PNL6+TDXl1igajL2Ij4L8hRco2FQ7dnRU+4JRpQhpKcH69XDQDv4XFzFz31N88pD4Q
 93MppRrekKINaJiGHnwLR8edGnE50ZoHaohShoPms4TFM833N3fdvh+sAkgr2jsh571y
 m7KY/M413LoSAMQyB3fBZoKxgo4bQtczw2VSLXNhvUuOFXN6URFJBNCg1bYU7L9hwQfd
 dm81ZmpCI05mcP20c7z2neLOQUo1oEc7tzJl8i0H+2YIxdYPodzwUULW9AZzPYEAV+jc
 4687AYlMerXZkyzaCDJ6Ntz4IvkZ4KjcMafraHNXC4JKoxEPMDHP4ov+YFo8fihg+N8o
 TcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710913447; x=1711518247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/16Q0u4XfDWKs7JnqPsJfRW0BUXP9xd/rNaGwBPpRc=;
 b=GWratcTJ5TlNfJz0d59xv8YH+p9yI7PIjclJTxBVNTgEKUFZ2jKwiA/ADOveV8S0nC
 xW0qcbWliyOmuVFU065sYU7bbc9Ba8IdCJTM0p0sOu86xthWrHgsvjA7lio/y7lZraAX
 xuXxAdGxb8hsfhYzsFSYiqA4f/jEr4Uv7yONUHbb2GP146vf8rFCtCyPnq9/1UDukIEX
 ogUrxnu0SxkvaXoB6MtSXDr9fjMQm69TVyldwZwDBHmbkSvCxTwCwxS8PbCbbhwAULVi
 DoiAZs9T8bkm+OvpglKcNjleZBjisUkpTa/1EvNwTEyPcUuF1kxxIzAd1AoAG7VIaHLE
 YR5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKaY9s76IXnQuCXf+SlCEi7EJiO42ckvKDaq4abJ2CF/4w2FyT3MI7LjDSCCnhoVd2hbVuS9WZQk4uUyXRvSRgx37LGQ==
X-Gm-Message-State: AOJu0YwcbRcHzNOD/7Pmb1q6xnjLO5Ux/Z3mBkW18y1W/sU71gbUv64K
 N3yaLzGL254vyH95sF97g4MjbYeDYo7LN9b9Ss0rIMLKYJhVz+EpXuUgmuXy0nUh3A7X7L21l1N
 9zs1GTRXc+FCPV5YWha5leH+64ja6/c8sA+STDw==
X-Google-Smtp-Source: AGHT+IGdMexqGaL9iq1NtWoessOGZZ1zwx0iLrKCpijgQP+709Y9OMzCpZLQewxfwF4HfopF0B/HipI02k6drdRga7o=
X-Received: by 2002:a05:6102:3955:b0:476:b489:36d5 with SMTP id
 f21-20020a056102395500b00476b48936d5mr473807vsu.22.1710913447434; Tue, 19 Mar
 2024 22:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-7-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-7-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 11:13:56 +0530
Message-ID: <CAFA6WYMTm59QygeWkrEgw0r25VPuEvD=Fjh6TY9tq0u5eZi=MQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] clk/qcom: sdm845: add USB clocks
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Most devices only initialise the USB clocks for us if we boot via
> "fastboot boot", add the missing clock configuration to get both USB
> ports working regardless of the bootloader state.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-sdm845.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index b7154360894a..e9c61eb480de 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -20,8 +20,12 @@
>  #include "clock-qcom.h"
>
>  #define SE9_UART_APPS_CMD_RCGR 0x18148
>
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf018
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf030
> +#define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf05c
> +
>  static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>         F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>         F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
>         F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> @@ -56,8 +60,10 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
>  static const struct gate_clk sdm845_clks[] = {
> +       GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,            0x82020, 0x00000001),
> +       GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,          0x05030, 0x00000001),
>         GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,                0x5200c, 0x00000400),
>         GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,                0x5200c, 0x00000800),
>         GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,                0x5200c, 0x00001000),
>         GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,                0x5200c, 0x00002000),
> @@ -120,8 +126,27 @@ static int sdm845_clk_enable(struct clk *clk)
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
>         debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
>
> +       switch (clk->id) {
> +       case GCC_USB30_PRIM_MASTER_CLK:
> +               qcom_gate_clk_en(priv, GCC_USB_PHY_CFG_AHB2PHY_CLK);
> +               /* These numbers are just pulled from the frequency tables in the Linux driver */
> +               clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +                                    (4.5 * 2) - 1, 0, 0, 1 << 8, 8);
> +               clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
> +                                    1, 0, 0, 0, 8);
> +               clk_rcg_set_rate_mnd(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR,
> +                                    1, 0, 0, 0, 8);
> +               break;
> +       case GCC_USB30_SEC_MASTER_CLK:
> +               qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
> +
> +               qcom_gate_clk_en(priv, GCC_USB3_SEC_CLKREF_CLK);
> +               qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
> +               break;
> +       }
> +
>         qcom_gate_clk_en(priv, clk->id);
>
>         return 0;
>  }
>
> --
> 2.44.0
>
