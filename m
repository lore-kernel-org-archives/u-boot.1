Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7829CD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 08:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1113A87E3D;
	Mon,  1 Apr 2024 10:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="thwksfWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9814387E3D; Mon,  1 Apr 2024 10:56:56 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1683E87E3D
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 10:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7dfacd39b9eso3032312241.1
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711961812; x=1712566612; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NfJZRvQzYMtttvp2Der/qpnVAHVj5HC98rudgmvXiyM=;
 b=thwksfWp62tP0UMYkEuXWCtRX8WdA52PtichZMdMZLic3q6EpVT5UtHFABpVJdBxyr
 C8jlgRbuEG3PAEeimb7dYKaZrktePZA9Fhj5vIN4hjmvJKtrROPWlsrxvJoxyktlJe/t
 bwvvtSNaLs6rkq9y3qoZSVHUDyGWxN/H+6rVScSqtabOVUKuQ7dlbHlNGxru1J7k4Zqk
 49oFhRAt2e017jnmCoLXOsgbPKTjV80NCKCrHxuEhWX+Dxe8yvoYgIzwf3EEUQis37nX
 4rcKbFqg6PiU1l+igJi4FUba//cUSSDKlFT49BRqClPPJcspQy/8qqQkdlfYeWIeHBIl
 aj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711961812; x=1712566612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfJZRvQzYMtttvp2Der/qpnVAHVj5HC98rudgmvXiyM=;
 b=bGQqcXqiDBixjyX5h6GtJozZJD+YDqs5vCBjZDngpMv2tx8bQL3+TqRRwuDoXxNdV6
 oDXKcFaaMArafQAwWe9KAjHQsujn4RwXCJqNTgFc8a3WCYzl4jZPFwn0JO7m0KtWLbZi
 cp3yHkkdE0mKCMNfEb3olHwnpIufc8yi9ZmNkPqGVhaOktaew/t0Bl8l+6lSFtCuTguI
 QCOrjsZ2IAg5Fc/wXF9qiOvBlMUsXGetNSt4GnwZ+JnlStItEQXv03Fk8q7i4SGzMrHy
 2ohpz36sLWqlo+J0f1IFTd/+bQLQGzEDKN6bGCkfWYyohiRy/yhDbcU8/KZQZaYsLj97
 1uCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBQo2psBzIOU66BOzW5sOVFKEfZW4YEsX22dTuIDbeCwC1BEwEp5cGbpI1n/O8j0FtnF24VhqWPBBZ1bnyzrd3MbzVOQ==
X-Gm-Message-State: AOJu0Yx/3T+tEKDvuWwotfI2DhHtjFjYHdolzBALmGMz33rzLY4PMLLh
 tL1oT4nEHacNHmD+GKaXkeYRLt05tz0KrsuPOPtAXaXt7YozhFq/P3hrzSOM3eMyASyOroANryZ
 +yjbNgMIssoBO9Kkv2MMYrnP2HafpQt17/Z0xzg==
X-Google-Smtp-Source: AGHT+IH9bBTiF1iKUzzAZEDjV0/f7QUfC6e9jj/DLiEABtHJDTHQ+x5tX5bvW6Fq3D1rP4oSWakTOr6e6pTtAxtsOJQ=
X-Received: by 2002:a67:b109:0:b0:478:4495:95bc with SMTP id
 w9-20020a67b109000000b00478449595bcmr6979715vsl.9.1711961811862; Mon, 01 Apr
 2024 01:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-12-jonas@kwiboo.se>
In-Reply-To: <20240331202921.262323-12-jonas@kwiboo.se>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 14:26:40 +0530
Message-ID: <CAFA6WYMcprsYQxAQVUFCM7-yqsboxitN3ODBw1bkU63yezu+Xw@mail.gmail.com>
Subject: Re: [PATCH 11/31] clk: rockchip: rk3399: Rename SCLK_DDRCLK to
 SCLK_DDRC
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
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

On Mon, 1 Apr 2024 at 02:01, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Sync rk3399-cru.h with one from linux v6.2+ and fix use of the
> SCLK_DDRCLK name that was only used by U-Boot.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/dts/rk3399-u-boot.dtsi        |  2 +-
>  drivers/clk/rockchip/clk_rk3399.c      |  2 +-
>  include/dt-bindings/clock/rk3399-cru.h | 30 ++++++++++++++------------

You shouldn't need to sync this header but rather just drop it which
will lead to ./dts/upstream/include/dt-bindings/clock/rk3399-cru.h
being included automatically. Similarly you should be able to drop all
other duplicate headers as demonstrated by this [1] patch-set.

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=399954

-Sumit

>  3 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 69e6b808a69b..adb64d17e040 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -44,7 +44,7 @@
>                 compatible = "rockchip,rk3399-dmc";
>                 devfreq-events = <&dfi>;
>                 interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
> -               clocks = <&cru SCLK_DDRCLK>;
> +               clocks = <&cru SCLK_DDRC>;
>                 clock-names = "dmc_clk";
>                 reg = <0x0 0xffa80000 0x0 0x0800
>                        0x0 0xffa80800 0x0 0x1800
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index 80f65a237e8e..f0ce54067f8c 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -1049,7 +1049,7 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
>                  * return 0 to satisfy clk_set_defaults during device probe.
>                  */
>                 return 0;
> -       case SCLK_DDRCLK:
> +       case SCLK_DDRC:
>                 ret = rk3399_ddr_set_clk(priv->cru, rate);
>                 break;
>         case PCLK_EFUSE1024NS:
> diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
> index 211faf8fa891..39169d94a44e 100644
> --- a/include/dt-bindings/clock/rk3399-cru.h
> +++ b/include/dt-bindings/clock/rk3399-cru.h
> @@ -1,6 +1,7 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
> + * Author: Xing Zheng <zhengxing@rock-chips.com>
>   */
>
>  #ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3399_H
> @@ -121,16 +122,17 @@
>  #define SCLK_DPHY_RX0_CFG              165
>  #define SCLK_RMII_SRC                  166
>  #define SCLK_PCIEPHY_REF100M           167
> -#define SCLK_USBPHY0_480M_SRC          168
> -#define SCLK_USBPHY1_480M_SRC          169
> -#define SCLK_DDRCLK                    170
> -#define SCLK_TESTOUT2                  171
> +#define SCLK_DDRC                      168
> +#define SCLK_TESTCLKOUT1               169
> +#define SCLK_TESTCLKOUT2               170
>
>  #define DCLK_VOP0                      180
>  #define DCLK_VOP1                      181
>  #define DCLK_VOP0_DIV                  182
>  #define DCLK_VOP1_DIV                  183
>  #define DCLK_M0_PERILP                 184
> +#define DCLK_VOP0_FRAC                 185
> +#define DCLK_VOP1_FRAC                 186
>
>  #define FCLK_CM0S                      190
>
> @@ -545,8 +547,8 @@
>  #define SRST_H_PERILP0                 171
>  #define SRST_H_PERILP0_NOC             172
>  #define SRST_ROM                       173
> -#define SRST_CRYPTO_S                  174
> -#define SRST_CRYPTO_M                  175
> +#define SRST_CRYPTO0_S                 174
> +#define SRST_CRYPTO0_M                 175
>
>  /* cru_softrst_con11 */
>  #define SRST_P_DCF                     176
> @@ -554,7 +556,7 @@
>  #define SRST_CM0S                      178
>  #define SRST_CM0S_DBG                  179
>  #define SRST_CM0S_PO                   180
> -#define SRST_CRYPTO                    181
> +#define SRST_CRYPTO0                   181
>  #define SRST_P_PERILP1_SGRF            182
>  #define SRST_P_PERILP1_GRF             183
>  #define SRST_CRYPTO1_S                 184
> @@ -592,13 +594,13 @@
>  #define SRST_P_SPI0                    214
>  #define SRST_P_SPI1                    215
>  #define SRST_P_SPI2                    216
> -#define SRST_P_SPI4                    217
> -#define SRST_P_SPI5                    218
> +#define SRST_P_SPI3                    217
> +#define SRST_P_SPI4                    218
>  #define SRST_SPI0                      219
>  #define SRST_SPI1                      220
>  #define SRST_SPI2                      221
> -#define SRST_SPI4                      222
> -#define SRST_SPI5                      223
> +#define SRST_SPI3                      222
> +#define SRST_SPI4                      223
>
>  /* cru_softrst_con14 */
>  #define SRST_I2S0_8CH                  224
> @@ -720,8 +722,8 @@
>  #define SRST_H_CM0S_NOC                        3
>  #define SRST_DBG_CM0S                  4
>  #define SRST_PO_CM0S                   5
> -#define SRST_P_SPI3                    6
> -#define SRST_SPI3                      7
> +#define SRST_P_SPI6                    6
> +#define SRST_SPI6                      7
>  #define SRST_P_TIMER_0_1               8
>  #define SRST_P_TIMER_0                 9
>  #define SRST_P_TIMER_1                 10
> --
> 2.43.2
>
