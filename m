Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12A6D2E9D5
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479B888EC9;
	Mon, 11 Nov 2024 11:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GDD35tN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C13488F8E; Mon, 11 Nov 2024 11:52:41 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8A9588915
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731322340; x=1731927140; i=xypron.glpk@gmx.de;
 bh=0jPww1nqAIF2DHRqbPZOGTCgGYUIUxJE6l66n+XMl3s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GDD35tN47sM531D8gkWBqum2qIKOqlgLx415vVArTBDeaK9DrQ3Xz4FYau95lOjs
 m596XfTMNu9qHuhP3YRobQe1xxFVtw6wQQI16ZhNWVWJyQSunW8GoI9sug4sc6ZfY
 G2enBWNs0Xz49k6wohPKSqk3VbaeO+M6NOuFol43Ys7P3XCHcDXdXukLEedHFaaLb
 cntYavpIdlM3kl0SNRgRhhnAYxzFn8E9W3g6O8K2D53lSmb1iG7us1SrkLtmCyaOD
 PxTTmdeHlrrzrxpCVdCBTbTc2UQ+2eMvf0Oz8dujEZcsa2kDTPI+bXnT5MwhXf5UG
 nGiNbhmneL2u4SL9Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1tk3xm3BMQ-00nRcd; Mon, 11
 Nov 2024 11:52:20 +0100
Message-ID: <da0f9fde-4ddc-4f03-ad3f-21887a967d94@gmx.de>
Date: Mon, 11 Nov 2024 11:52:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] dt-bindings: Remove StarFive JH7110 clock and
 reset definitions
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 H Bell <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <20241111020808.38974-4-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111020808.38974-4-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+yJl26zRenIaLq8ywAewWO0QP9qa3mzdnuTFgTd6+wnAD1xg5b+
 QCy0Rj2Au8BCb7szD63c7tayTuB6VMYsjig8m0fCOXZs28J6pDho5bW7YrjfwUQuq74YgJ9
 /KJMu9up14wNwNdnBGz/s8l+svBlcQdQFomfeZv77t4Jd8LFkF9uBtuVbvO3W85XtJNjsjX
 xhL666AlZf5bDC3UNA3pQ==
UI-OutboundReport: notjunk:1;M01:P0:FCo/n/nvs9A=;xNM/QD5sieOqSZKKuZ8M9mmk2w4
 uplcjBvdo8bwkwcHLuIiKqOcyP3XmJLW0Yvtgor/EHxZ94OCm/wNFrY5QD4jQYTXFZGzTzFYd
 9+Tt3+3VHWujreU9hp4NyVP75Ow3AtaGnZf0mN4hKaT5sIUqXDiIdCZ3Id+jJkyc7N0u4D1M5
 41YDTJAW/1zWTfW/MCq/NGUO5Wt1R0dERgIkaHLZvjJS+xbdE5dk4pcftrXgAFAG3uY+xcA0P
 g1YYUcPKiIZKEYL/qs7qEfY+WjXxO0qAgc97PT0bN3rzEeZo7qaoDx+PvOtp9mbsiqn2vY1Wa
 Saklyx5iV++g2fzHAu8TNQ2O85cUO4c9td9Tac9pZTEv3Cg3a3FL5y+AsE0b184xTlGuuc22z
 eSLoFB9Un3Re04YXetZzq4+yXKE3nd3YFaFQUcGIzWsUTL/0iOtOWKVqH5JPvz0XIPf2SfwTr
 yKN3bR9R5jCCZ3SauaQ+w2Fl00OrLvhmTT+p3IrSd4DT0qBsaRNBofTgQX/d3BHU5CWBTGvNy
 Dr5hkJFYTs95YeuPdsUYTUNAvZV8tWMBtJTdxV3Fmjg00Me7xQlwhRxCJ+CPlxdYhP4AJQj6z
 5AaXVLh8X7VwhiEz1zAbtsLfNmQapr/E3lObmbiOYJ+UoD0ZY7ac1yPtDRbtv1Ym850z62cJK
 BH0XEDjTtEp7hbUJPEdHqS9zYHSapwGQvpN+tmD/Kt/ZDQuLbtoJENfaitdUEb2vEH8x/fFAa
 qP9rqqLTJHbpigE98Teyb63B50cgWVD0kYQvA03DgxVGmwtXMGI2r1CODFGDCY45/psmO81sx
 Ws8JqM3kQAQjKFxFkwxNzAPg==
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

On 11/11/24 03:07, Hal Feng wrote:
> As JH7110 switch to use OF_UPSTREAM dt-bindings,
> remove the redundant clock and reset definitions.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

After merging patches 1-3 I get:

   CC      env/common.o
drivers/clk/starfive/clk-jh7110.c: In function =E2=80=98jh7110_stgcrg_init=
=E2=80=99:
drivers/clk/starfive/clk-jh7110.c:498:36: error: =E2=80=98JH7110_STGCLK_US=
B_APB=E2=80=99
undeclared (first use in this function); did you mean
=E2=80=98JH7110_STGCLK_USB0_APB=E2=80=99?
   498 |         clk_dm(JH7110_STG_ID_TRANS(JH7110_STGCLK_USB_APB),
       |                                    ^~~~~~~~~~~~~~~~~~~~~

We want git bisect to work. This requires successfully building after
each individual patch.

Best regards

Heinrich

> ---
>   .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------------------
>   .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -------------
>   2 files changed, 441 deletions(-)
>   delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>   delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>
> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/d=
t-bindings/clock/starfive,jh7110-crg.h
> deleted file mode 100644
> index b51e3829ff..0000000000
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ /dev/null
> @@ -1,258 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2022 StarFive Technology Co., Ltd.
> - *
> - * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
> - */
> -
> -#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
> -#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__
> -
> -#define JH7110_SYSCLK_PLL0_OUT			0
> -#define JH7110_SYSCLK_PLL1_OUT			1
> -#define JH7110_SYSCLK_PLL2_OUT			2
> -#define JH7110_PLLCLK_END			3
> -
> -#define JH7110_SYSCLK_CPU_ROOT			0
> -#define JH7110_SYSCLK_CPU_CORE			1
> -#define JH7110_SYSCLK_CPU_BUS			2
> -#define JH7110_SYSCLK_GPU_ROOT			3
> -#define JH7110_SYSCLK_PERH_ROOT		4
> -#define JH7110_SYSCLK_BUS_ROOT			5
> -#define JH7110_SYSCLK_NOCSTG_BUS		6
> -#define JH7110_SYSCLK_AXI_CFG0			7
> -#define JH7110_SYSCLK_STG_AXIAHB		8
> -#define JH7110_SYSCLK_AHB0			9
> -#define JH7110_SYSCLK_AHB1			10
> -#define JH7110_SYSCLK_APB_BUS			11
> -#define JH7110_SYSCLK_APB0			12
> -#define JH7110_SYSCLK_PLL0_DIV2		13
> -#define JH7110_SYSCLK_PLL1_DIV2		14
> -#define JH7110_SYSCLK_PLL2_DIV2		15
> -#define JH7110_SYSCLK_AUDIO_ROOT		16
> -#define JH7110_SYSCLK_MCLK_INNER		17
> -#define JH7110_SYSCLK_MCLK			18
> -#define JH7110_SYSCLK_MCLK_OUT			19
> -#define JH7110_SYSCLK_ISP_2X			20
> -#define JH7110_SYSCLK_ISP_AXI			21
> -#define JH7110_SYSCLK_GCLK0			22
> -#define JH7110_SYSCLK_GCLK1			23
> -#define JH7110_SYSCLK_GCLK2			24
> -#define JH7110_SYSCLK_CORE			25
> -#define JH7110_SYSCLK_CORE1			26
> -#define JH7110_SYSCLK_CORE2			27
> -#define JH7110_SYSCLK_CORE3			28
> -#define JH7110_SYSCLK_CORE4			29
> -#define JH7110_SYSCLK_DEBUG			30
> -#define JH7110_SYSCLK_RTC_TOGGLE		31
> -#define JH7110_SYSCLK_TRACE0			32
> -#define JH7110_SYSCLK_TRACE1			33
> -#define JH7110_SYSCLK_TRACE2			34
> -#define JH7110_SYSCLK_TRACE3			35
> -#define JH7110_SYSCLK_TRACE4			36
> -#define JH7110_SYSCLK_TRACE_COM		37
> -#define JH7110_SYSCLK_NOC_BUS_CPU_AXI		38
> -#define JH7110_SYSCLK_NOC_BUS_AXICFG0_AXI	39
> -#define JH7110_SYSCLK_OSC_DIV2			40
> -#define JH7110_SYSCLK_PLL1_DIV4		41
> -#define JH7110_SYSCLK_PLL1_DIV8		42
> -#define JH7110_SYSCLK_DDR_BUS			43
> -#define JH7110_SYSCLK_DDR_AXI			44
> -#define JH7110_SYSCLK_GPU_CORE			45
> -#define JH7110_SYSCLK_GPU_CORE_CLK		46
> -#define JH7110_SYSCLK_GPU_SYS_CLK		47
> -#define JH7110_SYSCLK_GPU_APB			48
> -#define JH7110_SYSCLK_GPU_RTC_TOGGLE		49
> -#define JH7110_SYSCLK_NOC_BUS_GPU_AXI		50
> -#define JH7110_SYSCLK_ISP_TOP_CLK_ISPCORE_2X	51
> -#define JH7110_SYSCLK_ISP_TOP_CLK_ISP_AXI	52
> -#define JH7110_SYSCLK_NOC_BUS_ISP_AXI		53
> -#define JH7110_SYSCLK_HIFI4_CORE		54
> -#define JH7110_SYSCLK_HIFI4_AXI		55
> -#define JH7110_SYSCLK_AXI_CFG1_DEC_MAIN	56
> -#define JH7110_SYSCLK_AXI_CFG1_DEC_AHB		57
> -#define JH7110_SYSCLK_VOUT_SRC			58
> -#define JH7110_SYSCLK_VOUT_AXI			59
> -#define JH7110_SYSCLK_NOC_BUS_DISP_AXI		60
> -#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AHB		61
> -#define JH7110_SYSCLK_VOUT_TOP_CLK_VOUT_AXI		62
> -#define JH7110_SYSCLK_VOUT_TOP_CLK_HDMITX0_MCLK	63
> -#define JH7110_SYSCLK_VOUT_TOP_CLK_MIPIPHY_REF		64
> -#define JH7110_SYSCLK_JPEGC_AXI		65
> -#define JH7110_SYSCLK_CODAJ12_AXI		66
> -#define JH7110_SYSCLK_CODAJ12_CORE		67
> -#define JH7110_SYSCLK_CODAJ12_APB		68
> -#define JH7110_SYSCLK_VDEC_AXI			69
> -#define JH7110_SYSCLK_WAVE511_AXI		70
> -#define JH7110_SYSCLK_WAVE511_BPU		71
> -#define JH7110_SYSCLK_WAVE511_VCE		72
> -#define JH7110_SYSCLK_WAVE511_APB		73
> -#define JH7110_SYSCLK_VDEC_JPG_ARB_JPG		74
> -#define JH7110_SYSCLK_VDEC_JPG_ARB_MAIN	75
> -#define JH7110_SYSCLK_NOC_BUS_VDEC_AXI		76
> -#define JH7110_SYSCLK_VENC_AXI			77
> -#define JH7110_SYSCLK_WAVE420L_AXI		78
> -#define JH7110_SYSCLK_WAVE420L_BPU		79
> -#define JH7110_SYSCLK_WAVE420L_VCE		80
> -#define JH7110_SYSCLK_WAVE420L_APB		81
> -#define JH7110_SYSCLK_NOC_BUS_VENC_AXI		82
> -#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN_DIV	83
> -#define JH7110_SYSCLK_AXI_CFG0_DEC_MAIN	84
> -#define JH7110_SYSCLK_AXI_CFG0_DEC_HIFI4	85
> -#define JH7110_SYSCLK_AXIMEM2_AXI		86
> -#define JH7110_SYSCLK_QSPI_AHB			87
> -#define JH7110_SYSCLK_QSPI_APB			88
> -#define JH7110_SYSCLK_QSPI_REF_SRC		89
> -#define JH7110_SYSCLK_QSPI_REF			90
> -#define JH7110_SYSCLK_SDIO0_AHB		91
> -#define JH7110_SYSCLK_SDIO1_AHB		92
> -#define JH7110_SYSCLK_SDIO0_SDCARD		93
> -#define JH7110_SYSCLK_SDIO1_SDCARD		94
> -#define JH7110_SYSCLK_USB_125M			95
> -#define JH7110_SYSCLK_NOC_BUS_STG_AXI		96
> -#define JH7110_SYSCLK_GMAC1_AHB		97
> -#define JH7110_SYSCLK_GMAC1_AXI		98
> -#define JH7110_SYSCLK_GMAC_SRC			99
> -#define JH7110_SYSCLK_GMAC1_GTXCLK		100
> -#define JH7110_SYSCLK_GMAC1_RMII_RTX		101
> -#define JH7110_SYSCLK_GMAC1_PTP		102
> -#define JH7110_SYSCLK_GMAC1_RX			103
> -#define JH7110_SYSCLK_GMAC1_RX_INV		104
> -#define JH7110_SYSCLK_GMAC1_TX			105
> -#define JH7110_SYSCLK_GMAC1_TX_INV		106
> -#define JH7110_SYSCLK_GMAC1_GTXC		107
> -#define JH7110_SYSCLK_GMAC0_GTXCLK		108
> -#define JH7110_SYSCLK_GMAC0_PTP		109
> -#define JH7110_SYSCLK_GMAC_PHY			110
> -#define JH7110_SYSCLK_GMAC0_GTXC		111
> -#define JH7110_SYSCLK_IOMUX_APB		112
> -#define JH7110_SYSCLK_MAILBOX			113
> -#define JH7110_SYSCLK_INT_CTRL_APB		114
> -#define JH7110_SYSCLK_CAN0_APB			115
> -#define JH7110_SYSCLK_CAN0_TIMER		116
> -#define JH7110_SYSCLK_CAN0_CAN			117
> -#define JH7110_SYSCLK_CAN1_APB			118
> -#define JH7110_SYSCLK_CAN1_TIMER		119
> -#define JH7110_SYSCLK_CAN1_CAN			120
> -#define JH7110_SYSCLK_PWM_APB			121
> -#define JH7110_SYSCLK_WDT_APB			122
> -#define JH7110_SYSCLK_WDT_CORE			123
> -#define JH7110_SYSCLK_TIMER_APB		124
> -#define JH7110_SYSCLK_TIMER0			125
> -#define JH7110_SYSCLK_TIMER1			126
> -#define JH7110_SYSCLK_TIMER2			127
> -#define JH7110_SYSCLK_TIMER3			128
> -#define JH7110_SYSCLK_TEMP_APB			129
> -#define JH7110_SYSCLK_TEMP_CORE		130
> -#define JH7110_SYSCLK_SPI0_APB			131
> -#define JH7110_SYSCLK_SPI1_APB			132
> -#define JH7110_SYSCLK_SPI2_APB			133
> -#define JH7110_SYSCLK_SPI3_APB			134
> -#define JH7110_SYSCLK_SPI4_APB			135
> -#define JH7110_SYSCLK_SPI5_APB			136
> -#define JH7110_SYSCLK_SPI6_APB			137
> -#define JH7110_SYSCLK_I2C0_APB			138
> -#define JH7110_SYSCLK_I2C1_APB			139
> -#define JH7110_SYSCLK_I2C2_APB			140
> -#define JH7110_SYSCLK_I2C3_APB			141
> -#define JH7110_SYSCLK_I2C4_APB			142
> -#define JH7110_SYSCLK_I2C5_APB			143
> -#define JH7110_SYSCLK_I2C6_APB			144
> -#define JH7110_SYSCLK_UART0_APB		145
> -#define JH7110_SYSCLK_UART0_CORE		146
> -#define JH7110_SYSCLK_UART1_APB		147
> -#define JH7110_SYSCLK_UART1_CORE		148
> -#define JH7110_SYSCLK_UART2_APB		149
> -#define JH7110_SYSCLK_UART2_CORE		150
> -#define JH7110_SYSCLK_UART3_APB		151
> -#define JH7110_SYSCLK_UART3_CORE		152
> -#define JH7110_SYSCLK_UART4_APB		153
> -#define JH7110_SYSCLK_UART4_CORE		154
> -#define JH7110_SYSCLK_UART5_APB		155
> -#define JH7110_SYSCLK_UART5_CORE		156
> -#define JH7110_SYSCLK_PWMDAC_APB		157
> -#define JH7110_SYSCLK_PWMDAC_CORE		158
> -#define JH7110_SYSCLK_SPDIF_APB		159
> -#define JH7110_SYSCLK_SPDIF_CORE		160
> -#define JH7110_SYSCLK_I2STX0_APB		161
> -#define JH7110_SYSCLK_I2STX0_BCLK_MST		162
> -#define JH7110_SYSCLK_I2STX0_BCLK_MST_INV	163
> -#define JH7110_SYSCLK_I2STX0_LRCK_MST		164
> -#define JH7110_SYSCLK_I2STX0_BCLK		165
> -#define JH7110_SYSCLK_I2STX0_BCLK_INV		166
> -#define JH7110_SYSCLK_I2STX0_LRCK		167
> -#define JH7110_SYSCLK_I2STX1_APB		168
> -#define JH7110_SYSCLK_I2STX1_BCLK_MST		169
> -#define JH7110_SYSCLK_I2STX1_BCLK_MST_INV	170
> -#define JH7110_SYSCLK_I2STX1_LRCK_MST		171
> -#define JH7110_SYSCLK_I2STX1_BCLK		172
> -#define JH7110_SYSCLK_I2STX1_BCLK_INV		173
> -#define JH7110_SYSCLK_I2STX1_LRCK		174
> -#define JH7110_SYSCLK_I2SRX_APB		175
> -#define JH7110_SYSCLK_I2SRX_BCLK_MST		176
> -#define JH7110_SYSCLK_I2SRX_BCLK_MST_INV	177
> -#define JH7110_SYSCLK_I2SRX_LRCK_MST		178
> -#define JH7110_SYSCLK_I2SRX_BCLK		179
> -#define JH7110_SYSCLK_I2SRX_BCLK_INV		180
> -#define JH7110_SYSCLK_I2SRX_LRCK		181
> -#define JH7110_SYSCLK_PDM_DMIC			182
> -#define JH7110_SYSCLK_PDM_APB			183
> -#define JH7110_SYSCLK_TDM_AHB			184
> -#define JH7110_SYSCLK_TDM_APB			185
> -#define JH7110_SYSCLK_TDM_INTERNAL		186
> -#define JH7110_SYSCLK_TDM_CLK_TDM		187
> -#define JH7110_SYSCLK_TDM_CLK_TDM_N		188
> -#define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
> -
> -#define JH7110_SYSCLK_END			190
> -
> -#define JH7110_AONCLK_OSC_DIV4			0
> -#define JH7110_AONCLK_APB_FUNC			1
> -#define JH7110_AONCLK_GMAC0_AHB			2
> -#define JH7110_AONCLK_GMAC0_AXI			3
> -#define JH7110_AONCLK_GMAC0_RMII_RTX		4
> -#define JH7110_AONCLK_GMAC0_TX			5
> -#define JH7110_AONCLK_GMAC0_TX_INV		6
> -#define JH7110_AONCLK_GMAC0_RX			7
> -#define JH7110_AONCLK_GMAC0_RX_INV		8
> -#define JH7110_AONCLK_OTPC_APB			9
> -#define JH7110_AONCLK_RTC_APB			10
> -#define JH7110_AONCLK_RTC_INTERNAL		11
> -#define JH7110_AONCLK_RTC_32K			12
> -#define JH7110_AONCLK_RTC_CAL			13
> -
> -#define JH7110_AONCLK_END			14
> -
> -#define JH7110_STGCLK_HIFI4_CORE		0
> -#define JH7110_STGCLK_USB_APB			1
> -#define JH7110_STGCLK_USB_UTMI_APB		2
> -#define JH7110_STGCLK_USB_AXI			3
> -#define JH7110_STGCLK_USB_LPM			4
> -#define JH7110_STGCLK_USB_STB			5
> -#define JH7110_STGCLK_USB_APP_125		6
> -#define JH7110_STGCLK_USB_REFCLK		7
> -#define JH7110_STGCLK_PCIE0_AXI			8
> -#define JH7110_STGCLK_PCIE0_APB			9
> -#define JH7110_STGCLK_PCIE0_TL			10
> -#define JH7110_STGCLK_PCIE1_AXI			11
> -#define JH7110_STGCLK_PCIE1_APB			12
> -#define JH7110_STGCLK_PCIE1_TL			13
> -#define JH7110_STGCLK_PCIE01_MAIN		14
> -#define JH7110_STGCLK_SEC_HCLK			15
> -#define JH7110_STGCLK_SEC_MISCAHB		16
> -#define JH7110_STGCLK_MTRX_GRP0_MAIN		17
> -#define JH7110_STGCLK_MTRX_GRP0_BUS		18
> -#define JH7110_STGCLK_MTRX_GRP0_STG		19
> -#define JH7110_STGCLK_MTRX_GRP1_MAIN		20
> -#define JH7110_STGCLK_MTRX_GRP1_BUS		21
> -#define JH7110_STGCLK_MTRX_GRP1_STG		22
> -#define JH7110_STGCLK_MTRX_GRP1_HIFI		23
> -#define JH7110_STGCLK_E2_RTC			24
> -#define JH7110_STGCLK_E2_CORE			25
> -#define JH7110_STGCLK_E2_DBG			26
> -#define JH7110_STGCLK_DMA1P_AXI			27
> -#define JH7110_STGCLK_DMA1P_AHB			28
> -
> -#define JH7110_STGCLK_END			29
> -
> -#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__ */
> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/d=
t-bindings/reset/starfive,jh7110-crg.h
> deleted file mode 100644
> index 1d596581da..0000000000
> --- a/include/dt-bindings/reset/starfive,jh7110-crg.h
> +++ /dev/null
> @@ -1,183 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Copyright (C) 2022 StarFive Technology Co., Ltd.
> - *
> - * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
> - */
> -
> -#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
> -#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
> -
> -/* SYSCRG resets */
> -#define JH7110_SYSRST_JTAG2APB			0
> -#define JH7110_SYSRST_SYSCON			1
> -#define JH7110_SYSRST_IOMUX_APB		2
> -#define JH7110_SYSRST_BUS			3
> -#define JH7110_SYSRST_DEBUG			4
> -#define JH7110_SYSRST_CORE0			5
> -#define JH7110_SYSRST_CORE1			6
> -#define JH7110_SYSRST_CORE2			7
> -#define JH7110_SYSRST_CORE3			8
> -#define JH7110_SYSRST_CORE4			9
> -#define JH7110_SYSRST_CORE0_ST			10
> -#define JH7110_SYSRST_CORE1_ST			11
> -#define JH7110_SYSRST_CORE2_ST			12
> -#define JH7110_SYSRST_CORE3_ST			13
> -#define JH7110_SYSRST_CORE4_ST			14
> -#define JH7110_SYSRST_TRACE0			15
> -#define JH7110_SYSRST_TRACE1			16
> -#define JH7110_SYSRST_TRACE2			17
> -#define JH7110_SYSRST_TRACE3			18
> -#define JH7110_SYSRST_TRACE4			19
> -#define JH7110_SYSRST_TRACE_COM		20
> -#define JH7110_SYSRST_GPU_APB			21
> -#define JH7110_SYSRST_GPU_DOMA			22
> -#define JH7110_SYSRST_NOC_BUS_APB_BUS		23
> -#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	24
> -#define JH7110_SYSRST_NOC_BUS_CPU_AXI		25
> -#define JH7110_SYSRST_NOC_BUS_DISP_AXI		26
> -#define JH7110_SYSRST_NOC_BUS_GPU_AXI		27
> -#define JH7110_SYSRST_NOC_BUS_ISP_AXI		28
> -#define JH7110_SYSRST_NOC_BUS_DDRC		29
> -#define JH7110_SYSRST_NOC_BUS_STG_AXI		30
> -#define JH7110_SYSRST_NOC_BUS_VDEC_AXI		31
> -
> -#define JH7110_SYSRST_NOC_BUS_VENC_AXI		32
> -#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		33
> -#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN	34
> -#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN	35
> -#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	36
> -#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	37
> -#define JH7110_SYSRST_DDR_AXI			38
> -#define JH7110_SYSRST_DDR_OSC			39
> -#define JH7110_SYSRST_DDR_APB			40
> -#define JH7110_SYSRST_DOM_ISP_TOP_N		41
> -#define JH7110_SYSRST_DOM_ISP_TOP_AXI		42
> -#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		43
> -#define JH7110_SYSRST_CODAJ12_AXI		44
> -#define JH7110_SYSRST_CODAJ12_CORE		45
> -#define JH7110_SYSRST_CODAJ12_APB		46
> -#define JH7110_SYSRST_WAVE511_AXI		47
> -#define JH7110_SYSRST_WAVE511_BPU		48
> -#define JH7110_SYSRST_WAVE511_VCE		49
> -#define JH7110_SYSRST_WAVE511_APB		50
> -#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		51
> -#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN	52
> -#define JH7110_SYSRST_AXIMEM0_AXI		53
> -#define JH7110_SYSRST_WAVE420L_AXI		54
> -#define JH7110_SYSRST_WAVE420L_BPU		55
> -#define JH7110_SYSRST_WAVE420L_VCE		56
> -#define JH7110_SYSRST_WAVE420L_APB		57
> -#define JH7110_SYSRST_AXIMEM1_AXI		58
> -#define JH7110_SYSRST_AXIMEM2_AXI		59
> -#define JH7110_SYSRST_INTMEM			60
> -#define JH7110_SYSRST_QSPI_AHB			61
> -#define JH7110_SYSRST_QSPI_APB			62
> -#define JH7110_SYSRST_QSPI_REF			63
> -
> -#define JH7110_SYSRST_SDIO0_AHB		64
> -#define JH7110_SYSRST_SDIO1_AHB		65
> -#define JH7110_SYSRST_GMAC1_AXI		66
> -#define JH7110_SYSRST_GMAC1_AHB		67
> -#define JH7110_SYSRST_MAILBOX			68
> -#define JH7110_SYSRST_SPI0_APB			69
> -#define JH7110_SYSRST_SPI1_APB			70
> -#define JH7110_SYSRST_SPI2_APB			71
> -#define JH7110_SYSRST_SPI3_APB			72
> -#define JH7110_SYSRST_SPI4_APB			73
> -#define JH7110_SYSRST_SPI5_APB			74
> -#define JH7110_SYSRST_SPI6_APB			75
> -#define JH7110_SYSRST_I2C0_APB			76
> -#define JH7110_SYSRST_I2C1_APB			77
> -#define JH7110_SYSRST_I2C2_APB			78
> -#define JH7110_SYSRST_I2C3_APB			79
> -#define JH7110_SYSRST_I2C4_APB			80
> -#define JH7110_SYSRST_I2C5_APB			81
> -#define JH7110_SYSRST_I2C6_APB			82
> -#define JH7110_SYSRST_UART0_APB		83
> -#define JH7110_SYSRST_UART0_CORE		84
> -#define JH7110_SYSRST_UART1_APB		85
> -#define JH7110_SYSRST_UART1_CORE		86
> -#define JH7110_SYSRST_UART2_APB		87
> -#define JH7110_SYSRST_UART2_CORE		88
> -#define JH7110_SYSRST_UART3_APB		89
> -#define JH7110_SYSRST_UART3_CORE		90
> -#define JH7110_SYSRST_UART4_APB		91
> -#define JH7110_SYSRST_UART4_CORE		92
> -#define JH7110_SYSRST_UART5_APB		93
> -#define JH7110_SYSRST_UART5_CORE		94
> -#define JH7110_SYSRST_SPDIF_APB		95
> -
> -#define JH7110_SYSRST_PWMDAC_APB		96
> -#define JH7110_SYSRST_PDM_DMIC			97
> -#define JH7110_SYSRST_PDM_APB			98
> -#define JH7110_SYSRST_I2SRX_APB		99
> -#define JH7110_SYSRST_I2SRX_BCLK		100
> -#define JH7110_SYSRST_I2STX0_APB		101
> -#define JH7110_SYSRST_I2STX0_BCLK		102
> -#define JH7110_SYSRST_I2STX1_APB		103
> -#define JH7110_SYSRST_I2STX1_BCLK		104
> -#define JH7110_SYSRST_TDM_AHB			105
> -#define JH7110_SYSRST_TDM_CORE			106
> -#define JH7110_SYSRST_TDM_APB			107
> -#define JH7110_SYSRST_PWM_APB			108
> -#define JH7110_SYSRST_WDT_APB			109
> -#define JH7110_SYSRST_WDT_CORE			110
> -#define JH7110_SYSRST_CAN0_APB			111
> -#define JH7110_SYSRST_CAN0_CORE		112
> -#define JH7110_SYSRST_CAN0_TIMER		113
> -#define JH7110_SYSRST_CAN1_APB			114
> -#define JH7110_SYSRST_CAN1_CORE		115
> -#define JH7110_SYSRST_CAN1_TIMER		116
> -#define JH7110_SYSRST_TIMER_APB		117
> -#define JH7110_SYSRST_TIMER0			118
> -#define JH7110_SYSRST_TIMER1			119
> -#define JH7110_SYSRST_TIMER2			120
> -#define JH7110_SYSRST_TIMER3			121
> -#define JH7110_SYSRST_INT_CTRL_APB		122
> -#define JH7110_SYSRST_TEMP_APB			123
> -#define JH7110_SYSRST_TEMP_CORE		124
> -#define JH7110_SYSRST_JTAG_CERTIFICATION	125
> -
> -#define JH7110_SYSRST_END			126
> -
> -/* AONCRG resets */
> -#define JH7110_AONRST_GMAC0_AXI		0
> -#define JH7110_AONRST_GMAC0_AHB		1
> -#define JH7110_AONRST_IOMUX			2
> -#define JH7110_AONRST_PMU_APB			3
> -#define JH7110_AONRST_PMU_WKUP			4
> -#define JH7110_AONRST_RTC_APB			5
> -#define JH7110_AONRST_RTC_CAL			6
> -#define JH7110_AONRST_RTC_32K			7
> -
> -#define JH7110_AONRST_END			8
> -
> -/* STGCRG resets */
> -#define JH7110_STGRST_SYSCON_PRESETN		0
> -#define JH7110_STGRST_HIFI4_CORE		1
> -#define JH7110_STGRST_HIFI4_AXI		2
> -#define JH7110_STGRST_SEC_TOP_HRESETN		3
> -#define JH7110_STGRST_E24_CORE			4
> -#define JH7110_STGRST_DMA1P_AXI		5
> -#define JH7110_STGRST_DMA1P_AHB		6
> -#define JH7110_STGRST_USB_AXI			7
> -#define JH7110_STGRST_USB_APB			8
> -#define JH7110_STGRST_USB_UTMI_APB		9
> -#define JH7110_STGRST_USB_PWRUP		10
> -#define JH7110_STGRST_PCIE0_MST0		11
> -#define JH7110_STGRST_PCIE0_SLV0		12
> -#define JH7110_STGRST_PCIE0_SLV		13
> -#define JH7110_STGRST_PCIE0_BRG		14
> -#define JH7110_STGRST_PCIE0_CORE		15
> -#define JH7110_STGRST_PCIE0_APB		16
> -#define JH7110_STGRST_PCIE1_MST0		17
> -#define JH7110_STGRST_PCIE1_SLV0		18
> -#define JH7110_STGRST_PCIE1_SLV		19
> -#define JH7110_STGRST_PCIE1_BRG		20
> -#define JH7110_STGRST_PCIE1_CORE		21
> -#define JH7110_STGRST_PCIE1_APB		22
> -
> -#define JH7110_STGRST_END			23
> -
> -#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */

