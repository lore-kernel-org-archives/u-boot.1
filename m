Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAE6D4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5112583A2B;
	Sun, 18 Jan 2026 14:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jFMF/WQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6687783935; Sat, 17 Jan 2026 20:05:59 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8FC838BB
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-5018ec2ae21so28275741cf.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676754; x=1769281554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeGlwu/ZfsTYgxvwNfUnmzWEJx1PZMyGOBJCzDVgNkU=;
 b=jFMF/WQvtuZ8J753YTScAPsdRBqJxAlZn3mxO4xJhSshr6R/PGSOHXD7HE9lZopBLt
 +zvM4ebCAkuufKDb7yXdzhKlQcBWWOlz5j8EQaCEXJqtn+fHtPh1nXMsTUx4K9AZj+vS
 Lp1aYgREYqZDkU2fq22D/UA07I0PHvHd1hOrmVwCmQyZM1XT5G1kJwMCFv1jaszLZjFN
 L6A/3+Q6k9teqUcdmW4XjRNXtao6vRNdCmJeHESJE1M1Xoeft/1vcHG0VU5KAY7lgD7g
 qhYi+z54VACcCr4szWZcXP4mIlHZlLeSjIpa0FzyUVsY6uzBE32DHE5we4wuWdZ8Ww1u
 ehzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676754; x=1769281554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xeGlwu/ZfsTYgxvwNfUnmzWEJx1PZMyGOBJCzDVgNkU=;
 b=M+ecpst+XzzYpQRdtyERYGIQTXp42JrgayAEzVnU0dvhmWsw3pBa+vBLcHnNF1R0X5
 uI/3X3xa0SO0Kj3lfz578s+5c2EDw01jf2ALs+wm/14D7JlBSHOFCkF2+N78xGPGb+jl
 Y2EblS3+Sckmm2LWk1bt3XzVq6XOksot19IoH3B7ccaNklRhNA/7fI67DgvbwtIC6HEw
 Az7wIErqBv8HlATn7aWzIdK95AV4v7ndLgaHpV/7ZOv/JjYRmHVNWMFSOUlclw6CGK68
 ZgWIEzDpN9m1ndptaQpfZAjVNtNR8ttenpOofb4HfjUKMHayapTglGqAT+bn/qKIePpK
 i3RQ==
X-Gm-Message-State: AOJu0YwmwYiovGHbQa38gPhnx9d8vdO8+WOlzmwwqHWdjRPCsbb0sBQp
 3oWyZKmUNDDmE0zyf7qeaN1SBjT2moMZUqc5uUR4AVJ/JrA9ZDddpNknFNtSVA==
X-Gm-Gg: AY/fxX7Yg3a8pLtm1rw2iqjp6NGcnhQ/3Z+RJv7i469XXjg57TORX6JG2RIcXdwu3JY
 NDVXNw8VElsfLQZoBGaPUFw78tZEMhkLajFp6shAY7cauPXJRdJbv9lOkZl06jxSZHWj6Eik7D5
 tGhesIy02N2tCcqf/uWV5Z3DBrqgU9iTHr1qTG0Gp3HHZnlFrES6gYccSKog9W8z/vVNJwD+Id4
 TQERxXTzUWKf52rz4gqZc3Mf1JK5VrlrMOBMgc3J3foydwrDn5kpjdcyF32M0kYxk8YHUgGzaGe
 L9Z/+/PT8TRxKxwv9Zq1rwnC1U/DAwztMoMuvC4K+56S+sjKCf2IBWmeE/WkHhHkitEdhZQtfUc
 BcG7v8OywstvNUJFgBcK2lZ2glUHDfHqithLygfiYQJQh9IR1Vk2nKCdkThoW71Gh3VyIQ5Bf5n
 df7ucKaIQ76IN4TRiH7JujjfzZlk5TroOeoV748Up3GqJb/QHjrW2/t4JgxbEMn1smggHTe77MI
 gdr12ID/g==
X-Received: by 2002:a05:622a:3d2:b0:4ed:aff1:3f45 with SMTP id
 d75a77b69052e-502a1771e33mr100671261cf.83.1768676754009; 
 Sat, 17 Jan 2026 11:05:54 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:05:53 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Samuel Holland <samuel@sholland.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 05/17] dt-bindings: clock: import k1-syscon from upstream
Date: Sat, 17 Jan 2026 14:01:39 -0500
Message-Id: <20260117190231.977686-6-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

From: Raymond Mao <raymond.mao@riscstar.com>

Import spacemit,k1-syscon.h from upstream folder. And remove
duplicated reset IDs in it.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 .../dt-bindings/clock/spacemit,k1-syscon.h    | 253 ++++++++++++++++++
 1 file changed, 253 insertions(+)
 create mode 100644 include/dt-bindings/clock/spacemit,k1-syscon.h

diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
new file mode 100644
index 00000000000..c33da4ce73b
--- /dev/null
+++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2024-2025 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _DT_BINDINGS_SPACEMIT_CCU_H_
+#define _DT_BINDINGS_SPACEMIT_CCU_H_
+
+/* APBS (PLL) clocks */
+#define CLK_PLL1		0
+#define CLK_PLL2		1
+#define CLK_PLL3		2
+#define CLK_PLL1_D2		3
+#define CLK_PLL1_D3		4
+#define CLK_PLL1_D4		5
+#define CLK_PLL1_D5		6
+#define CLK_PLL1_D6		7
+#define CLK_PLL1_D7		8
+#define CLK_PLL1_D8		9
+#define CLK_PLL1_D11		10
+#define CLK_PLL1_D13		11
+#define CLK_PLL1_D23		12
+#define CLK_PLL1_D64		13
+#define CLK_PLL1_D10_AUD	14
+#define CLK_PLL1_D100_AUD	15
+#define CLK_PLL2_D1		16
+#define CLK_PLL2_D2		17
+#define CLK_PLL2_D3		18
+#define CLK_PLL2_D4		19
+#define CLK_PLL2_D5		20
+#define CLK_PLL2_D6		21
+#define CLK_PLL2_D7		22
+#define CLK_PLL2_D8		23
+#define CLK_PLL3_D1		24
+#define CLK_PLL3_D2		25
+#define CLK_PLL3_D3		26
+#define CLK_PLL3_D4		27
+#define CLK_PLL3_D5		28
+#define CLK_PLL3_D6		29
+#define CLK_PLL3_D7		30
+#define CLK_PLL3_D8		31
+#define CLK_PLL3_80		32
+#define CLK_PLL3_40		33
+#define CLK_PLL3_20		34
+
+/* MPMU clocks */
+#define CLK_PLL1_307P2		0
+#define CLK_PLL1_76P8		1
+#define CLK_PLL1_61P44		2
+#define CLK_PLL1_153P6		3
+#define CLK_PLL1_102P4		4
+#define CLK_PLL1_51P2		5
+#define CLK_PLL1_51P2_AP	6
+#define CLK_PLL1_57P6		7
+#define CLK_PLL1_25P6		8
+#define CLK_PLL1_12P8		9
+#define CLK_PLL1_12P8_WDT	10
+#define CLK_PLL1_6P4		11
+#define CLK_PLL1_3P2		12
+#define CLK_PLL1_1P6		13
+#define CLK_PLL1_0P8		14
+#define CLK_PLL1_409P6		15
+#define CLK_PLL1_204P8		16
+#define CLK_PLL1_491		17
+#define CLK_PLL1_245P76		18
+#define CLK_PLL1_614		19
+#define CLK_PLL1_47P26		20
+#define CLK_PLL1_31P5		21
+#define CLK_PLL1_819		22
+#define CLK_PLL1_1228		23
+#define CLK_SLOW_UART		24
+#define CLK_SLOW_UART1		25
+#define CLK_SLOW_UART2		26
+#define CLK_WDT			27
+#define CLK_RIPC		28
+#define CLK_I2S_SYSCLK		29
+#define CLK_I2S_BCLK		30
+#define CLK_APB			31
+#define CLK_WDT_BUS		32
+#define CLK_I2S_153P6		33
+#define CLK_I2S_153P6_BASE	34
+#define CLK_I2S_SYSCLK_SRC	35
+#define CLK_I2S_BCLK_FACTOR	36
+
+/* APBC clocks */
+#define CLK_UART0		0
+#define CLK_UART2		1
+#define CLK_UART3		2
+#define CLK_UART4		3
+#define CLK_UART5		4
+#define CLK_UART6		5
+#define CLK_UART7		6
+#define CLK_UART8		7
+#define CLK_UART9		8
+#define CLK_GPIO		9
+#define CLK_PWM0		10
+#define CLK_PWM1		11
+#define CLK_PWM2		12
+#define CLK_PWM3		13
+#define CLK_PWM4		14
+#define CLK_PWM5		15
+#define CLK_PWM6		16
+#define CLK_PWM7		17
+#define CLK_PWM8		18
+#define CLK_PWM9		19
+#define CLK_PWM10		20
+#define CLK_PWM11		21
+#define CLK_PWM12		22
+#define CLK_PWM13		23
+#define CLK_PWM14		24
+#define CLK_PWM15		25
+#define CLK_PWM16		26
+#define CLK_PWM17		27
+#define CLK_PWM18		28
+#define CLK_PWM19		29
+#define CLK_SSP3		30
+#define CLK_RTC			31
+#define CLK_TWSI0		32
+#define CLK_TWSI1		33
+#define CLK_TWSI2		34
+#define CLK_TWSI4		35
+#define CLK_TWSI5		36
+#define CLK_TWSI6		37
+#define CLK_TWSI7		38
+#define CLK_TWSI8		39
+#define CLK_TIMERS1		40
+#define CLK_TIMERS2		41
+#define CLK_AIB			42
+#define CLK_ONEWIRE		43
+#define CLK_SSPA0		44
+#define CLK_SSPA1		45
+#define CLK_DRO			46
+#define CLK_IR			47
+#define CLK_TSEN		48
+#define CLK_IPC_AP2AUD		49
+#define CLK_CAN0		50
+#define CLK_CAN0_BUS		51
+#define CLK_UART0_BUS		52
+#define CLK_UART2_BUS		53
+#define CLK_UART3_BUS		54
+#define CLK_UART4_BUS		55
+#define CLK_UART5_BUS		56
+#define CLK_UART6_BUS		57
+#define CLK_UART7_BUS		58
+#define CLK_UART8_BUS		59
+#define CLK_UART9_BUS		60
+#define CLK_GPIO_BUS		61
+#define CLK_PWM0_BUS		62
+#define CLK_PWM1_BUS		63
+#define CLK_PWM2_BUS		64
+#define CLK_PWM3_BUS		65
+#define CLK_PWM4_BUS		66
+#define CLK_PWM5_BUS		67
+#define CLK_PWM6_BUS		68
+#define CLK_PWM7_BUS		69
+#define CLK_PWM8_BUS		70
+#define CLK_PWM9_BUS		71
+#define CLK_PWM10_BUS		72
+#define CLK_PWM11_BUS		73
+#define CLK_PWM12_BUS		74
+#define CLK_PWM13_BUS		75
+#define CLK_PWM14_BUS		76
+#define CLK_PWM15_BUS		77
+#define CLK_PWM16_BUS		78
+#define CLK_PWM17_BUS		79
+#define CLK_PWM18_BUS		80
+#define CLK_PWM19_BUS		81
+#define CLK_SSP3_BUS		82
+#define CLK_RTC_BUS		83
+#define CLK_TWSI0_BUS		84
+#define CLK_TWSI1_BUS		85
+#define CLK_TWSI2_BUS		86
+#define CLK_TWSI4_BUS		87
+#define CLK_TWSI5_BUS		88
+#define CLK_TWSI6_BUS		89
+#define CLK_TWSI7_BUS		90
+#define CLK_TWSI8_BUS		91
+#define CLK_TIMERS1_BUS		92
+#define CLK_TIMERS2_BUS		93
+#define CLK_AIB_BUS		94
+#define CLK_ONEWIRE_BUS		95
+#define CLK_SSPA0_BUS		96
+#define CLK_SSPA1_BUS		97
+#define CLK_TSEN_BUS		98
+#define CLK_IPC_AP2AUD_BUS	99
+#define CLK_SSPA0_I2S_BCLK	100
+#define CLK_SSPA1_I2S_BCLK	101
+
+/* APMU clocks */
+#define CLK_CCI550		0
+#define CLK_CPU_C0_HI		1
+#define CLK_CPU_C0_CORE		2
+#define CLK_CPU_C0_ACE		3
+#define CLK_CPU_C0_TCM		4
+#define CLK_CPU_C1_HI		5
+#define CLK_CPU_C1_CORE		6
+#define CLK_CPU_C1_ACE		7
+#define CLK_CCIC_4X		8
+#define CLK_CCIC1PHY		9
+#define CLK_SDH_AXI		10
+#define CLK_SDH0		11
+#define CLK_SDH1		12
+#define CLK_SDH2		13
+#define CLK_USB_P1		14
+#define CLK_USB_AXI		15
+#define CLK_USB30		16
+#define CLK_QSPI		17
+#define CLK_QSPI_BUS		18
+#define CLK_DMA			19
+#define CLK_AES			20
+#define CLK_VPU			21
+#define CLK_GPU			22
+#define CLK_EMMC		23
+#define CLK_EMMC_X		24
+#define CLK_AUDIO		25
+#define CLK_HDMI		26
+#define CLK_PMUA_ACLK		27
+#define CLK_PCIE0_MASTER	28
+#define CLK_PCIE0_SLAVE		29
+#define CLK_PCIE0_DBI		30
+#define CLK_PCIE1_MASTER	31
+#define CLK_PCIE1_SLAVE		32
+#define CLK_PCIE1_DBI		33
+#define CLK_PCIE2_MASTER	34
+#define CLK_PCIE2_SLAVE		35
+#define CLK_PCIE2_DBI		36
+#define CLK_EMAC0_BUS		37
+#define CLK_EMAC0_PTP		38
+#define CLK_EMAC1_BUS		39
+#define CLK_EMAC1_PTP		40
+#define CLK_JPG			41
+#define CLK_CCIC2PHY		42
+#define CLK_CCIC3PHY		43
+#define CLK_CSI			44
+#define CLK_CAMM0		45
+#define CLK_CAMM1		46
+#define CLK_CAMM2		47
+#define CLK_ISP_CPP		48
+#define CLK_ISP_BUS		49
+#define CLK_ISP			50
+#define CLK_DPU_MCLK		51
+#define CLK_DPU_ESC		52
+#define CLK_DPU_BIT		53
+#define CLK_DPU_PXCLK		54
+#define CLK_DPU_HCLK		55
+#define CLK_DPU_SPI		56
+#define CLK_DPU_SPI_HBUS	57
+#define CLK_DPU_SPIBUS		58
+#define CLK_DPU_SPI_ACLK	59
+#define CLK_V2D			60
+#define CLK_EMMC_BUS		61
+
+#endif /* _DT_BINDINGS_SPACEMIT_CCU_H_ */
-- 
2.25.1

