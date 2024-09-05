Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCABCD5BAE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 12:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0801B88C88;
	Thu,  5 Sep 2024 14:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="puRqdxuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA4B88C9C; Thu,  5 Sep 2024 14:04:23 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C4888C87
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 14:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f4f2868621so8414331fa.0
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537860; x=1726142660; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vDqrqgDO4jM7tZFMhPKU7AJFmjTXperAU3Io71d1HQE=;
 b=puRqdxucdN5XXAOi8w9YNOZcnoezjiRNRjOz01rrj1m1lZueFx7l4aUGa8fRvcvEPv
 gbLGg9PV+jKeEbWxtxb9v+XYo7fivqmmp3JKEeTaQlQI39Am2rYWCHd/hymB53K5IT9p
 Jxpqo3S11CeRm4pGfZlak7heZPquTgsEypzzQrfQyVOuDIPOYRoEzaxXQ0urqdu9ckF3
 dWdJVnFxy3NBnPMk1VKtDa/1zSRB2Le4CLDaUJXAOfPj4CBNv9VLR53AqKlpOrLHkOWR
 LiBCaBJh/f0yVHDh7AJ9xcNM73A/nriGJkD+MAIbaiH8jJF/tvtGWSkYebo2qsTpnyVL
 jQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537860; x=1726142660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDqrqgDO4jM7tZFMhPKU7AJFmjTXperAU3Io71d1HQE=;
 b=D5HWGlJ/WY9BzE4tQBiNO+6LRoB5JdnPETmH2DncBhFUdsrJhzjwnJBdFct6/UeDaX
 dEd0qdu65WveoDlQm2dF1mO0U9evOnbnRRpOfQurXtjop09EoATw/k2jpZRqH47kJYTC
 jV0YBMTo/OtU6SMqSNNI0bx/HYKaL/u35OvWGkAhFI+U/MYCwXRoCKxDf9Vj4WUHzrAh
 bbr64h9G+WUr6hBgZlKHYVRGL9qr3cHGtN16seNrRojBP70jw5y+qrzyY+BVLb34QJRy
 qOf0RkJcwKx1HmUPEoLvUtqWS0GPChD2WlKJG2bx2cwe+TvgJab2reQnLDMMk0958dnx
 yV4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV139RRYtn+dwd4SNVAz4mbE8N9f6uZbd1YwMU4HFsP1szrCy3X6gb1/haAAxp8XurmhSKso3g=@lists.denx.de
X-Gm-Message-State: AOJu0YyCvSs3EGPcosnDgvhonBBXwysBAh2kZ477fZkerVnK1kwx3Y2V
 +wvVrDZpzLRjali5Aj/Fv5MkkVTO1nRq3cZ5l6ZG+WLIpVcriOjh74dcYS2Pe7Y=
X-Google-Smtp-Source: AGHT+IETSCL07Ec/NaPoQOehA2FJEbRNstxfOKOK9krRaFBEqJgvwIMSpSpE+m6NspAxfyz0GHTGuA==
X-Received: by 2002:a2e:b8c4:0:b0:2ef:2b38:879c with SMTP id
 38308e7fff4ca-2f62902e20amr133003231fa.3.1725537859674; 
 Thu, 05 Sep 2024 05:04:19 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc69ac64sm1158088a12.77.2024.09.05.05.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 05:04:19 -0700 (PDT)
Message-ID: <a2261c8b-08a5-4dc4-9397-eee8596791b7@linaro.org>
Date: Thu, 5 Sep 2024 14:04:18 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/4] clk/qcom: implement clk dump callback
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Lukasz,

Could you take a quick look at this?

Thanks and kind regards,

On 19/08/2024 21:34, Caleb Connolly wrote:
> Add support for dumping a few of the clocks used on Qualcomm platforms.
> Naming the Global PLL's, Root Clock Generators, and gate clocks.
> 
> This helps a lot with platform bringup and feature enablement by making
> it easy to sanity check that the clocks are programmed correctly.
> 
> == Usage ==
> 
> Enable CONFIG_CMD_CLK and "#define LOG_DEBUG" at the top of
> qcom-<soc>.c.
> 
> If your SoC doesn't yet define the debug data for clocks, it can be
> added using the Linux driver as a reference.
> 
> The "clk dump" command should print the states of all the gates, GPLLs
> and RCGs for your SoC.
> 
> == Glossary ==
> 
> RCG: Root Clock Generator
> * Takes in some fairly arbitrary high freq clock (configurable clock
> source and options for taking just even pulses and other things)
> * Output frequency = input_freq * (m/n) * (1/d) where m/n are arbitrary
> 8 or 16-bit values (depending on the RCG), and d is a number (with
> support for .5 offsets).
> 
> GPLL: Global Phase Locked Loop
> * Crystal as input
> * integer multiplier + exponent part (2^-40)
> 
> Gate: Simple on/off clock
> * Put between RCGs and the peripherals they power
> * Required to allow for correct power sequencing
> 
> If you do the maths manually using the equations from "clk dump", the
> numbers should roughly line up by they're likely to be out by a handful
> of MHz. They output is formatted so that it can be pasted directly into
> the python interpreter.
> 
> == Example output ==
> 
> => clk dump
>  Rate               Usecnt      Name
> ------------------------------------------
>  38400000             0        |-- xo-board
>  32764                0        |-- sleep-clk
> 
> qcom_clk qcom_clk:
> Gate Clocks:
> GCC_AGGRE_USB3_SEC_AXI_CLK      : 
> GCC_CFG_NOC_USB3_SEC_AXI_CLK    : 
> GCC_QUPV3_WRAP0_S0_CLK          : 
> GCC_QUPV3_WRAP0_S1_CLK          : 
> GCC_QUPV3_WRAP0_S2_CLK          : 
> GCC_QUPV3_WRAP0_S3_CLK          : 
> GCC_QUPV3_WRAP0_S4_CLK          : 
> GCC_QUPV3_WRAP0_S5_CLK          : 
> GCC_QUPV3_WRAP0_S6_CLK          : 
> GCC_QUPV3_WRAP0_S7_CLK          : 
> GCC_QUPV3_WRAP1_S0_CLK          : 
> GCC_QUPV3_WRAP1_S1_CLK          : ON
> GCC_QUPV3_WRAP1_S3_CLK          : 
> GCC_QUPV3_WRAP1_S4_CLK          : 
> GCC_QUPV3_WRAP1_S5_CLK          : 
> GCC_QUPV3_WRAP1_S6_CLK          : 
> GCC_QUPV3_WRAP1_S7_CLK          : 
> GCC_QUPV3_WRAP_0_M_AHB_CLK      : 
> GCC_QUPV3_WRAP_0_S_AHB_CLK      : 
> GCC_QUPV3_WRAP_1_M_AHB_CLK      : ON
> GCC_QUPV3_WRAP_1_S_AHB_CLK      : ON
> GCC_SDCC2_AHB_CLK               : ON
> GCC_SDCC2_APPS_CLK              : ON
> GCC_SDCC4_AHB_CLK               : 
> GCC_SDCC4_APPS_CLK              : 
> GCC_UFS_CARD_AHB_CLK            : 
> GCC_UFS_CARD_AXI_CLK            : 
> GCC_UFS_CARD_CLKREF_CLK         : ON
> GCC_UFS_CARD_ICE_CORE_CLK       : 
> GCC_UFS_CARD_PHY_AUX_CLK        : 
> GCC_UFS_CARD_RX_SYMBOL_0_CLK    : 
> GCC_UFS_CARD_RX_SYMBOL_1_CLK    : 
> GCC_UFS_CARD_TX_SYMBOL_0_CLK    : 
> GCC_UFS_CARD_UNIPRO_CORE_CLK    : 
> GCC_UFS_MEM_CLKREF_CLK          : ON
> GCC_UFS_PHY_AHB_CLK             : ON
> GCC_UFS_PHY_AXI_CLK             : ON
> GCC_UFS_PHY_ICE_CORE_CLK        : ON
> GCC_UFS_PHY_PHY_AUX_CLK         : ON
> GCC_UFS_PHY_RX_SYMBOL_0_CLK     : ON
> GCC_UFS_PHY_RX_SYMBOL_1_CLK     : ON
> GCC_UFS_PHY_TX_SYMBOL_0_CLK     : ON
> GCC_UFS_PHY_UNIPRO_CORE_CLK     : ON
> GCC_USB30_PRIM_MASTER_CLK       : ON
> GCC_USB30_PRIM_MOCK_UTMI_CLK    : ON
> GCC_USB30_PRIM_SLEEP_CLK        : ON
> GCC_USB30_SEC_MASTER_CLK        : 
> GCC_USB30_SEC_MOCK_UTMI_CLK     : 
> GCC_USB30_SEC_SLEEP_CLK         : 
> GCC_USB3_PRIM_CLKREF_CLK        : ON
> GCC_USB3_PRIM_PHY_AUX_CLK       : ON
> GCC_USB3_PRIM_PHY_COM_AUX_CLK   : ON
> GCC_USB3_PRIM_PHY_PIPE_CLK      : ON
> GCC_USB3_SEC_CLKREF_CLK         : ON
> GCC_USB3_SEC_PHY_AUX_CLK        : 
> GCC_USB3_SEC_PHY_PIPE_CLK       : 
> GCC_USB3_SEC_PHY_COM_AUX_CLK    : 
> GCC_USB_PHY_CFG_AHB2PHY_CLK     : ON
> 
> GPLL clocks:
> | GPLL   | LOCKED | XO_BOARD  |  PLL_L     | ALPHA          |
> +--------+--------+-----------+------------+----------------+
> | GPLL0  | X      |  19200000 * (0x1f      + 0x0            * 2 ** -40 )/ 1000000
> | GPLL1  | X      |  19200000 * (0x37      + 0x0            * 2 ** -40 ) / 1000000
> | GPLL2  |        |  19200000 * (0x14      + 0x0            * 2 ** -40 ) / 1000000
> | GPLL3  |        |  19200000 * (0x30      + 0x0            * 2 ** -40 )/ 1000000
> | GPLL4  | X      |  19200000 * (0x29      + 0x0            * 2 ** -40 ) / 1000000
> | GPLL5  |        |  19200000 * (0x30      + 0x0            * 2 ** -40 ) / 1000000
> | GPLL6  |        |  19200000 * (0x0       + 0x0            * 2 ** -40 )/ 1000000
> 
> RCGs:
> | NAME                             | ON | SRC | OUT_FREQ = input_freq * (m/n) * (1/d) | [CMD REG   ] |
> +----------------------------------+----+-----+---------------------------------------+--------------+
> GCC_USB30_PRIM_MASTER              | X  |   1 | input_freq * (   1/    1) * (1/4.5)   | [0x00000000]
> GCC_USB30_PRIM_MOCK_UTMI           | X  |   0 | input_freq * (   1/    1) * (1/1  )   | [0x00000000]
> GCC_USB3_PRIM_PHY_AUX              | X  |   0 | input_freq * (   1/    1) * (1/1  )   | [0x00000000]
> GCC_USB30_SEC_MASTER               |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_USB30_SEC_MOCK_UTMI            |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_USB3_SEC_PHY_AUX               |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_SDCC2_APPS                     | X  |   5 | input_freq * (   1/    1) * (1/4  )   | [0x00000000]
> GCC_SDCC4_APPS                     |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_CORE_2X            | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]
> GCC_QUPV3_WRAP0_S0                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_S1                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_S2                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_S3                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_S4                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_S5                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_S6                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP0_S7                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP1_S0                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP1_S1                 | X  |   6 | input_freq * ( 384/15625) * (1/1  )   | [0x00000000]
> GCC_QUPV3_WRAP1_S2                 | X  |   0 | input_freq * (   1/    1) * (1/1  )   | [0x00000000]
> GCC_QUPV3_WRAP1_S3                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP1_S4                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP1_S5                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP1_S6                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_QUPV3_WRAP1_S7                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_PCIE_0_AUX                     |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_PCIE_1_AUX                     |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_PCIE_PHY_REFGEN                | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]
> GCC_UFS_CARD_AXI                   | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]
> GCC_UFS_CARD_ICE_CORE              |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_UFS_CARD_UNIPRO_CORE           |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_UFS_CARD_PHY_AUX               |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
> GCC_UFS_PHY_AXI                    | X  |   1 | input_freq * (   1/    1) * (1/3  )   | [0x00000000]
> GCC_UFS_PHY_ICE_CORE               | X  |   1 | input_freq * (   1/    1) * (1/2  )   | [0x00000000]
> GCC_UFS_PHY_UNIPRO_CORE            | X  |   1 | input_freq * (   1/    1) * (1/4  )   | [0x00000000]
> GCC_UFS_PHY_PHY_AUX                | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]
> 
> ---
> Caleb Connolly (4):
>       clk/qcom: implement clk dump
>       clk/qcom: sdm845: add dump data
>       clk/qcom: sm6115: add debug data
>       clk/qcom: sm8250: add debug data
> 
>  drivers/clk/qcom/clock-qcom.c   | 117 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clock-qcom.h   |   6 +++
>  drivers/clk/qcom/clock-sdm845.c |  93 ++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clock-sm6115.c |  63 ++++++++++++++++++++++
>  drivers/clk/qcom/clock-sm8250.c | 115 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 394 insertions(+)
> ---
> change-id: 20240819-b4-qcom-clk-dump-e25a0198f6c0
> base-commit: b7d5ce05b1b52136af09cf34541c6a91079a4b86
> 
> // Caleb (they/them)
> 

-- 
// Caleb (they/them)
