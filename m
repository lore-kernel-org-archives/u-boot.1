Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD2606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Odf1EsMM;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=TvkiTmQP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BE0D8151E;
	Sat,  7 Nov 2026 12:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id scxgbXzXZFoD; Sat,  7 Nov 2026 12:51:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E9E1E815D6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055890;
	b=kJJwHny7AD2KlFf8hxv+1IA4qmwoV/UzI/tF903wEU+bK+LAJWte6EMgRMY8WUZd+K9C
	 F1/NDFwGXw+Wjve3a4VCiNgmR1y/5cFCk9arlZuiyHtv2c63uI8jJRH57ual1I4bVCH4d
	 wVgTBFevdIUvrzXN6foYX25HQ5/SkpypwL2a52dLTMlNZZZCIeYUkllWg70beMEiLxf1W
	 1EQKdyEJMQiBE6o/DRY2KkRaAA4OL4xdCNiH43pStEZzQheIA43Y/lL8LDwhabUjKHQyt
	 CaxtwsOpHQPMfE2E3NJvKbWGaoc8lGqF8tzG1VIxRWQWAcEuoxcPTwUt9BliyXT/Gyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0T8KakcHNmd6DpzGmL//7u061IIfGLGjZi09CO9/tkE=;
	b=PQhCKFmjb3uUFyQLBIdmUDhZtD1UskT8l9k8la19hbK9whvkktx0sqlcaSQv5Re9hK+d
	 ho3M0pfuCD+rVpZtyRf6rjvyNceGxQMbW9Af1/J2vIpeCUJT21NEPxrlK7oHqlYHDcPmA
	 Ssn87brjKtg7zFGJQMG2Z4xktACsBw51WRVTBZKgrmNyeBF7nLr7iH/zP46VlwRLbTb+a
	 /p+G3Y/eK/t8wF+WB4AwBahDCgeUvY6KV0gDIBCvTnHiTy51Eqw1+DPJfBTZzxLh+709f
	 HbkEx0xlE5eOeWGnC3vl/R9JVAQcXM10TM5LIJ698q5fwKdKC8uM3SgQck24YMrvjSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055890;
	bh=0T8KakcHNmd6DpzGmL//7u061IIfGLGjZi09CO9/tkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Odf1EsMMu+caoT2Bv9c+5exqwWGbgSHVOV1GpQdUqm2QA4wQcBGDZQZkCUaPo3Yko
	 c6/uhOA9HlaZGJ27WkhFkV/ZfEBoUUlz+N+MHzlLDMYtCqJ0W4s+CCndL29JX9JD7L
	 UYhnxGlOcPDcRPl2Awq5UMIGS4xGX+kSRNcSqlGSfOfNgzEgtCjGUPdc08EGse6nd0
	 dJJU6cOhx3G3/slFLDaTJevkLB1sSpbzMTmVDLPNmgPqsoIj+p7iDuXsVlQTr4V/2w
	 x69JrU+KUU6F6+vCaFsoXyV/D3k7qczd9XbUICTqa8cvzYTqrlacImm2P9E0pbjugd
	 KZ5a2lBJ4s1ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9E1E815D6;
	Sat,  7 Nov 2026 12:51:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCE342AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE44C4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q-Q_xJkPtOUP for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 48760400BB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=TvkiTmQP
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48760400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:41 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivms711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:08 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivms711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051909;
 bh=0T8KakcHNmd6DpzGmL//7u061IIfGLGjZi09CO9/tkE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TvkiTmQPqPY7AcTd9/729ukJkv2muLrXCkElIhVSu38flCFxY4Ta5qdh4jhWimbZH
 inyRvHpxc5nNTEitOStObYCpzvTlPgIPfuzLFxn6qagnxuqCZTCHpG4r+AdpW2rPa+
 Wnb7/S8KI00U3KDqZkaBhH3cuUgVM3knXhWzrDlk=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 03/10] clk: stm32: add STM32L4+ RCC driver
Date: Sat,  7 Nov 2026 12:44:48 +0100
Message-ID: <20261107114455.304896-4-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:50:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Add a clock driver for the STM32L4/L4+ RCC (RM0432 chapters 3, 5, 6).
On probe it switches to HSI16, selects voltage Range 1 (boost above
80 MHz, with the required HCLK/2 step), programs the flash wait states
and ART accelerator and runs SYSCLK from the main PLL. The dividers come
from the optional st,pll-m/n/r properties and default to
16 MHz / 2 * 30 / 2 = 120 MHz. It also marks VDDIO2 valid and selects
PCLK as UART kernel clock. PWR is found through the st,syscfg phandle,
as on STM32F4.

Rates of gated clocks are derived from the current prescalers,
including the x2 timer clock rule.

The driver cannot use readl_poll_timeout(): the timer is clocked by
this driver, so polls are bounded by a loop count instead.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/clk/stm32/Kconfig       |   9 +
 drivers/clk/stm32/Makefile      |   1 +
 drivers/clk/stm32/clk-stm32l4.c | 483 ++++++++++++++++++++++++++++++++
 drivers/misc/stm32_rcc.c        |   6 +
 4 files changed, 499 insertions(+)
 create mode 100644 drivers/clk/stm32/clk-stm32l4.c

diff --git a/drivers/clk/stm32/Kconfig b/drivers/clk/stm32/Kconfig
index e63385d3..3b0b7ceb 100644
--- a/drivers/clk/stm32/Kconfig
+++ b/drivers/clk/stm32/Kconfig
@@ -6,6 +6,15 @@ config CLK_STM32F
 	  This clock driver adds support for RCC clock management
 	  for STM32F4 and STM32F7 SoCs.
 
+config CLK_STM32L4
+	bool "Enable clock driver support for STM32L4 family"
+	depends on CLK && STM32L4
+	default y
+	help
+	  Enable the RCC clock driver for STM32L4/L4+ SoCs. It sets up the
+	  main PLL from HSI16, the voltage range and the flash wait states,
+	  and provides the peripheral clock gates.
+
 config CLK_STM32H7
 	bool "Enable clock driver support for STM32H7 family"
 	depends on CLK && STM32H7
diff --git a/drivers/clk/stm32/Makefile b/drivers/clk/stm32/Makefile
index 0b849c52..f4cd471f 100644
--- a/drivers/clk/stm32/Makefile
+++ b/drivers/clk/stm32/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_CLK_STM32_CORE) += clk-stm32-core.o
 obj-$(CONFIG_CLK_STM32F) += clk-stm32f.o
 obj-$(CONFIG_CLK_STM32H7) += clk-stm32h7.o
+obj-$(CONFIG_CLK_STM32L4) += clk-stm32l4.o
 obj-$(CONFIG_CLK_STM32MP1) += clk-stm32mp1.o
 obj-$(CONFIG_CLK_STM32MP13) += clk-stm32mp13.o
 obj-$(CONFIG_CLK_STM32MP21) += clk-stm32mp21.o
diff --git a/drivers/clk/stm32/clk-stm32l4.c b/drivers/clk/stm32/clk-stm32l4.c
new file mode 100644
index 00000000..02533048
--- /dev/null
+++ b/drivers/clk/stm32/clk-stm32l4.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ *
+ * STM32L4/L4+ RCC clock driver
+ *
+ * Reference: RM0432 STM32L4+ Series reference manual, chapters 3 (FLASH),
+ * 5 (PWR) and 6 (RCC).
+ *
+ * The system clock is generated by the main PLL from HSI16. The PLL
+ * dividers come from the device tree (st,pll-m/n/r, defaults give
+ * 120 MHz); all bus prescalers are 1. Peripheral clock gates and the
+ * rates reported for them are derived from the register state.
+ */
+
+#define LOG_CATEGORY UCLASS_CLK
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <log.h>
+#include <asm/io.h>
+#include <asm/arch/stm32.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <dt-bindings/clock/stm32l4-clock.h>
+
+/* RCC registers */
+#define RCC_CR			0x00
+#define RCC_CFGR		0x08
+#define RCC_PLLCFGR		0x0c
+#define RCC_AHB1ENR		0x48
+#define RCC_AHB2ENR		0x4c
+#define RCC_AHB3ENR		0x50
+#define RCC_APB1ENR1		0x58
+#define RCC_APB1ENR2		0x5c
+#define RCC_APB2ENR		0x60
+#define RCC_CCIPR		0x88
+
+#define RCC_CR_MSIRANGE		GENMASK(7, 4)
+#define RCC_CR_MSIRGSEL		BIT(3)
+#define RCC_CR_HSION		BIT(8)
+#define RCC_CR_HSIRDY		BIT(10)
+#define RCC_CR_PLLON		BIT(24)
+#define RCC_CR_PLLRDY		BIT(25)
+
+#define RCC_CFGR_SW		GENMASK(1, 0)
+#define RCC_CFGR_SWS		GENMASK(3, 2)
+#define RCC_CFGR_HPRE		GENMASK(7, 4)
+#define RCC_CFGR_PPRE1		GENMASK(10, 8)
+#define RCC_CFGR_PPRE2		GENMASK(13, 11)
+#define RCC_CFGR_SW_MSI		0
+#define RCC_CFGR_SW_HSI16	1
+#define RCC_CFGR_SW_PLL		3
+#define RCC_CFGR_HPRE_DIV2	0x8
+
+#define RCC_PLLCFGR_PLLSRC	GENMASK(1, 0)
+#define RCC_PLLCFGR_PLLM	GENMASK(7, 4)
+#define RCC_PLLCFGR_PLLN	GENMASK(14, 8)
+#define RCC_PLLCFGR_PLLREN	BIT(24)
+#define RCC_PLLCFGR_PLLR	GENMASK(26, 25)
+#define RCC_PLLCFGR_MASK	(RCC_PLLCFGR_PLLSRC | RCC_PLLCFGR_PLLM | \
+				 RCC_PLLCFGR_PLLN | RCC_PLLCFGR_PLLREN | \
+				 RCC_PLLCFGR_PLLR)
+#define RCC_PLLCFGR_SRC_MSI	1
+#define RCC_PLLCFGR_SRC_HSI16	2
+
+/* USART1..3, UART4..5 and LPUART1 kernel clock selection: 0 = PCLK */
+#define RCC_CCIPR_UART_SEL	GENMASK(11, 0)
+
+/* PWR registers */
+#define PWR_CR1			0x00
+#define PWR_CR2			0x04
+#define PWR_SR2			0x14
+#define PWR_CR5			0x80
+#define PWR_CR1_VOS		GENMASK(10, 9)
+#define PWR_CR1_VOS_RANGE1	1
+#define PWR_CR2_IOSV		BIT(9)
+#define PWR_SR2_VOSF		BIT(10)
+#define PWR_CR5_R1MODE		BIT(8)
+#define PWR_APB1ENR1_EN		BIT(28)
+
+/* FLASH registers */
+#define FLASH_ACR		0x00
+#define FLASH_ACR_LATENCY	GENMASK(3, 0)
+#define FLASH_ACR_PRFTEN	BIT(8)
+#define FLASH_ACR_ICEN		BIT(9)
+#define FLASH_ACR_DCEN		BIT(10)
+
+#define HSI16_RATE		16000000UL
+#define SYSCLK_MAX		120000000UL
+#define BOOST_THRESHOLD		80000000UL
+/* Poll budget in loop iterations: no timer exists while clocks are set up */
+#define POLL_LOOPS		1000000
+
+/* MSI range frequencies (RCC_CR MSIRANGE), RM0432 section 6.2.3 */
+static const u32 msi_rates[] = {
+	100000, 200000, 400000, 800000, 1000000, 2000000,
+	4000000, 8000000, 16000000, 24000000, 32000000, 48000000,
+};
+
+/* AHB prescaler: HPRE 0xxx = 1, 1000 = 2 ... 1111 = 512 */
+static const u8 hpre_shift[] = { 1, 2, 3, 4, 6, 7, 8, 9 };
+
+struct stm32l4_clk_priv {
+	void __iomem *base;
+	void __iomem *pwr;
+	void __iomem *flash;
+	u32 pllm;
+	u32 plln;
+	u32 pllr;
+};
+
+static ulong stm32l4_msi_rate(struct stm32l4_clk_priv *priv)
+{
+	u32 cr = readl(priv->base + RCC_CR);
+	u32 range = 6;	/* 4 MHz reset default, MSIRANGE in RCC_CSR */
+
+	if (cr & RCC_CR_MSIRGSEL)
+		range = FIELD_GET(RCC_CR_MSIRANGE, cr);
+	if (range >= ARRAY_SIZE(msi_rates))
+		return 0;
+
+	return msi_rates[range];
+}
+
+static ulong stm32l4_pll_rate(struct stm32l4_clk_priv *priv)
+{
+	u32 pllcfgr = readl(priv->base + RCC_PLLCFGR);
+	ulong in;
+
+	switch (FIELD_GET(RCC_PLLCFGR_PLLSRC, pllcfgr)) {
+	case RCC_PLLCFGR_SRC_MSI:
+		in = stm32l4_msi_rate(priv);
+		break;
+	case RCC_PLLCFGR_SRC_HSI16:
+		in = HSI16_RATE;
+		break;
+	default:
+		return 0;	/* HSE is not supported */
+	}
+
+	in /= FIELD_GET(RCC_PLLCFGR_PLLM, pllcfgr) + 1;
+
+	return in * FIELD_GET(RCC_PLLCFGR_PLLN, pllcfgr) /
+	       ((FIELD_GET(RCC_PLLCFGR_PLLR, pllcfgr) + 1) * 2);
+}
+
+static ulong stm32l4_sysclk_rate(struct stm32l4_clk_priv *priv)
+{
+	switch (FIELD_GET(RCC_CFGR_SWS, readl(priv->base + RCC_CFGR))) {
+	case RCC_CFGR_SW_MSI:
+		return stm32l4_msi_rate(priv);
+	case RCC_CFGR_SW_HSI16:
+		return HSI16_RATE;
+	case RCC_CFGR_SW_PLL:
+		return stm32l4_pll_rate(priv);
+	default:
+		return 0;	/* HSE is not supported */
+	}
+}
+
+static ulong stm32l4_hclk_rate(struct stm32l4_clk_priv *priv)
+{
+	u32 hpre = FIELD_GET(RCC_CFGR_HPRE, readl(priv->base + RCC_CFGR));
+	ulong sysclk = stm32l4_sysclk_rate(priv);
+
+	if (!(hpre & 0x8))
+		return sysclk;
+
+	return sysclk >> hpre_shift[hpre & 0x7];
+}
+
+/* APB prescaler value 0xx = 1, 100 = 2 ... 111 = 16; returns the divider */
+static u32 stm32l4_apb_div(u32 ppre)
+{
+	return (ppre & 0x4) ? 2 << (ppre & 0x3) : 1;
+}
+
+static ulong stm32l4_pclk_rate(struct stm32l4_clk_priv *priv, bool apb2,
+			       bool timer)
+{
+	u32 cfgr = readl(priv->base + RCC_CFGR);
+	u32 div = stm32l4_apb_div(apb2 ? FIELD_GET(RCC_CFGR_PPRE2, cfgr) :
+					 FIELD_GET(RCC_CFGR_PPRE1, cfgr));
+	ulong rate = stm32l4_hclk_rate(priv) / div;
+
+	/* RM0432 6.2.17: timer clocks are x2 when the APB prescaler is not 1 */
+	if (timer && div != 1)
+		rate *= 2;
+
+	return rate;
+}
+
+/* TIM2..TIM7 in APB1ENR1, TIM1/8/15/16/17 in APB2ENR */
+static bool stm32l4_is_timer(u32 off, u32 bit)
+{
+	if (off == RCC_APB1ENR1)
+		return bit <= 5;
+	if (off == RCC_APB2ENR)
+		return bit == 11 || bit == 13 || (bit >= 16 && bit <= 18);
+
+	return false;
+}
+
+static int stm32l4_gate_decode(ulong id, u32 *off, u32 *bit)
+{
+	*off = (id / 32) * 4;
+	*bit = id % 32;
+
+	switch (*off) {
+	case RCC_AHB1ENR:
+	case RCC_AHB2ENR:
+	case RCC_AHB3ENR:
+	case RCC_APB1ENR1:
+	case RCC_APB1ENR2:
+	case RCC_APB2ENR:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ulong stm32l4_clk_get_rate(struct clk *clk)
+{
+	struct stm32l4_clk_priv *priv = dev_get_priv(clk->dev);
+	u32 off, bit;
+
+	switch (clk->id) {
+	case STM32L4_CLK_SYSCLK:
+		return stm32l4_sysclk_rate(priv);
+	case STM32L4_CLK_HCLK:
+		return stm32l4_hclk_rate(priv);
+	case STM32L4_CLK_PCLK1:
+		return stm32l4_pclk_rate(priv, false, false);
+	case STM32L4_CLK_PCLK2:
+		return stm32l4_pclk_rate(priv, true, false);
+	}
+
+	if (stm32l4_gate_decode(clk->id, &off, &bit))
+		return -EINVAL;
+
+	switch (off) {
+	case RCC_APB1ENR1:
+	case RCC_APB1ENR2:
+		return stm32l4_pclk_rate(priv, false,
+					 stm32l4_is_timer(off, bit));
+	case RCC_APB2ENR:
+		return stm32l4_pclk_rate(priv, true,
+					 stm32l4_is_timer(off, bit));
+	default:
+		return stm32l4_hclk_rate(priv);
+	}
+}
+
+static int stm32l4_clk_enable(struct clk *clk)
+{
+	struct stm32l4_clk_priv *priv = dev_get_priv(clk->dev);
+	u32 off, bit;
+
+	if (clk->id >= STM32L4_CLK_SYSCLK)
+		return 0;	/* bus clocks are always on */
+
+	if (stm32l4_gate_decode(clk->id, &off, &bit))
+		return -EINVAL;
+
+	setbits_le32(priv->base + off, BIT(bit));
+	/* RM0432 6.2.18: allow 2 bus cycles before the peripheral is accessed */
+	readl(priv->base + off);
+
+	return 0;
+}
+
+static int stm32l4_clk_disable(struct clk *clk)
+{
+	struct stm32l4_clk_priv *priv = dev_get_priv(clk->dev);
+	u32 off, bit;
+
+	if (clk->id >= STM32L4_CLK_SYSCLK)
+		return 0;
+
+	if (stm32l4_gate_decode(clk->id, &off, &bit))
+		return -EINVAL;
+
+	clrbits_le32(priv->base + off, BIT(bit));
+
+	return 0;
+}
+
+static int stm32l4_clk_of_xlate(struct clk *clk,
+				struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	clk->id = args->args[0];
+
+	return 0;
+}
+
+static u32 stm32l4_pllcfgr_target(struct stm32l4_clk_priv *priv)
+{
+	return FIELD_PREP(RCC_PLLCFGR_PLLSRC, RCC_PLLCFGR_SRC_HSI16) |
+	       FIELD_PREP(RCC_PLLCFGR_PLLM, priv->pllm - 1) |
+	       FIELD_PREP(RCC_PLLCFGR_PLLN, priv->plln) |
+	       FIELD_PREP(RCC_PLLCFGR_PLLR, priv->pllr / 2 - 1) |
+	       RCC_PLLCFGR_PLLREN;
+}
+
+/* Wait until (reg & mask) == val; the timer depends on this driver */
+static int stm32l4_poll(void __iomem *reg, u32 mask, u32 val)
+{
+	int i;
+
+	for (i = 0; i < POLL_LOOPS; i++)
+		if ((readl(reg) & mask) == val)
+			return 0;
+
+	return -ETIMEDOUT;
+}
+
+/* Wait >= 1 us without a timer: 120 cycles at HCLK <= 120 MHz */
+static void stm32l4_delay_1us(void)
+{
+	int i;
+
+	for (i = 0; i < 120; i++)
+		__asm__ volatile ("nop");
+}
+
+static int stm32l4_clk_setup(struct udevice *dev, struct stm32l4_clk_priv *priv)
+{
+	void __iomem *rcc = priv->base;
+	ulong vco_in = HSI16_RATE / priv->pllm;
+	ulong vco = vco_in * priv->plln;
+	ulong sysclk = vco / priv->pllr;
+	u32 target = stm32l4_pllcfgr_target(priv);
+	int ret;
+
+	/* RM0432 6.2.5 PLL limits: VCO in 2.66..16 MHz, VCO out 64..344 MHz */
+	if (vco_in < 2660000 || vco_in > 16000000 ||
+	    vco < 64000000 || vco > 344000000 || sysclk > SYSCLK_MAX ||
+	    (priv->pllr & 1) || priv->pllr < 2 || priv->pllr > 8) {
+		dev_err(dev, "invalid PLL setting M=%u N=%u R=%u\n",
+			priv->pllm, priv->plln, priv->pllr);
+		return -EINVAL;
+	}
+
+	/* PWR interface clock, VDDIO2 (GPIOG[15:2]) valid */
+	setbits_le32(rcc + RCC_APB1ENR1, PWR_APB1ENR1_EN);
+	readl(rcc + RCC_APB1ENR1);
+	setbits_le32(priv->pwr + PWR_CR2, PWR_CR2_IOSV);
+
+	/* UART/LPUART kernel clocks from PCLK, matching get_rate() */
+	clrbits_le32(rcc + RCC_CCIPR, RCC_CCIPR_UART_SEL);
+
+	/* Already running with the requested PLL (e.g. probed pre-relocation) */
+	if (FIELD_GET(RCC_CFGR_SWS, readl(rcc + RCC_CFGR)) == RCC_CFGR_SW_PLL &&
+	    (readl(rcc + RCC_PLLCFGR) & RCC_PLLCFGR_MASK) == target &&
+	    !(readl(rcc + RCC_CFGR) &
+	      (RCC_CFGR_HPRE | RCC_CFGR_PPRE1 | RCC_CFGR_PPRE2)))
+		return 0;
+
+	/* Run from HSI16 while the PLL is (re)configured */
+	setbits_le32(rcc + RCC_CR, RCC_CR_HSION);
+	ret = stm32l4_poll(rcc + RCC_CR, RCC_CR_HSIRDY, RCC_CR_HSIRDY);
+	if (ret)
+		return ret;
+	clrsetbits_le32(rcc + RCC_CFGR, RCC_CFGR_SW, RCC_CFGR_SW_HSI16);
+	ret = stm32l4_poll(rcc + RCC_CFGR, RCC_CFGR_SWS,
+			   FIELD_PREP(RCC_CFGR_SWS, RCC_CFGR_SW_HSI16));
+	if (ret)
+		return ret;
+
+	clrbits_le32(rcc + RCC_CR, RCC_CR_PLLON);
+	ret = stm32l4_poll(rcc + RCC_CR, RCC_CR_PLLRDY, 0);
+	if (ret)
+		return ret;
+
+	/* RM0432 5.1.8: Range 1, then flash wait states, then boost mode */
+	clrsetbits_le32(priv->pwr + PWR_CR1, PWR_CR1_VOS,
+			FIELD_PREP(PWR_CR1_VOS, PWR_CR1_VOS_RANGE1));
+	ret = stm32l4_poll(priv->pwr + PWR_SR2, PWR_SR2_VOSF, 0);
+	if (ret)
+		return ret;
+
+	/* RM0432 Table 12: Range 1 boost, 20 MHz per wait state */
+	clrsetbits_le32(priv->flash + FLASH_ACR, FLASH_ACR_LATENCY,
+			FIELD_PREP(FLASH_ACR_LATENCY,
+				   DIV_ROUND_UP(sysclk, 20000000) - 1));
+	setbits_le32(priv->flash + FLASH_ACR,
+		     FLASH_ACR_PRFTEN | FLASH_ACR_ICEN | FLASH_ACR_DCEN);
+	readl(priv->flash + FLASH_ACR);
+
+	writel(target, rcc + RCC_PLLCFGR);
+	setbits_le32(rcc + RCC_CR, RCC_CR_PLLON);
+	ret = stm32l4_poll(rcc + RCC_CR, RCC_CR_PLLRDY, RCC_CR_PLLRDY);
+	if (ret)
+		return ret;
+
+	/* Above 80 MHz: HCLK = SYSCLK / 2 for >= 1 us around the switch */
+	if (sysclk > BOOST_THRESHOLD) {
+		clrsetbits_le32(rcc + RCC_CFGR, RCC_CFGR_HPRE,
+				FIELD_PREP(RCC_CFGR_HPRE, RCC_CFGR_HPRE_DIV2));
+		clrbits_le32(priv->pwr + PWR_CR5, PWR_CR5_R1MODE);
+	} else {
+		setbits_le32(priv->pwr + PWR_CR5, PWR_CR5_R1MODE);
+	}
+
+	clrsetbits_le32(rcc + RCC_CFGR, RCC_CFGR_SW, RCC_CFGR_SW_PLL);
+	ret = stm32l4_poll(rcc + RCC_CFGR, RCC_CFGR_SWS,
+			   FIELD_PREP(RCC_CFGR_SWS, RCC_CFGR_SW_PLL));
+	if (ret)
+		return ret;
+
+	stm32l4_delay_1us();
+	clrbits_le32(rcc + RCC_CFGR,
+		     RCC_CFGR_HPRE | RCC_CFGR_PPRE1 | RCC_CFGR_PPRE2);
+
+	return 0;
+}
+
+static int stm32l4_clk_probe(struct udevice *dev)
+{
+	struct stm32l4_clk_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	int ret;
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	ret = dev_read_phandle_with_args(dev, "st,syscfg", NULL, 0, 0, &args);
+	if (ret) {
+		dev_err(dev, "can't find PWR syscon (%d)\n", ret);
+		return ret;
+	}
+	priv->pwr = (void __iomem *)ofnode_get_addr(args.node);
+	priv->flash = (void __iomem *)STM32_FLASH_CNTL_BASE;
+
+	priv->pllm = dev_read_u32_default(dev, "st,pll-m", 2);
+	priv->plln = dev_read_u32_default(dev, "st,pll-n", 30);
+	priv->pllr = dev_read_u32_default(dev, "st,pll-r", 2);
+
+	ret = stm32l4_clk_setup(dev, priv);
+	if (ret)
+		dev_err(dev, "clock setup failed: %d\n", ret);
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static void stm32l4_clk_dump(struct udevice *dev)
+{
+	struct stm32l4_clk_priv *priv = dev_get_priv(dev);
+
+	printf("SYSCLK: %lu Hz\n", stm32l4_sysclk_rate(priv));
+	printf("HCLK  : %lu Hz\n", stm32l4_hclk_rate(priv));
+	printf("PCLK1 : %lu Hz\n", stm32l4_pclk_rate(priv, false, false));
+	printf("PCLK2 : %lu Hz\n", stm32l4_pclk_rate(priv, true, false));
+}
+#endif
+
+static const struct clk_ops stm32l4_clk_ops = {
+	.of_xlate	= stm32l4_clk_of_xlate,
+	.enable		= stm32l4_clk_enable,
+	.disable	= stm32l4_clk_disable,
+	.get_rate	= stm32l4_clk_get_rate,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump		= stm32l4_clk_dump,
+#endif
+};
+
+U_BOOT_DRIVER(stm32l4_clk) = {
+	.name		= "stm32l4_rcc_clock",
+	.id		= UCLASS_CLK,
+	.ops		= &stm32l4_clk_ops,
+	.probe		= stm32l4_clk_probe,
+	.priv_auto	= sizeof(struct stm32l4_clk_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/misc/stm32_rcc.c b/drivers/misc/stm32_rcc.c
index 15bf69f7..145fb589 100644
--- a/drivers/misc/stm32_rcc.c
+++ b/drivers/misc/stm32_rcc.c
@@ -37,6 +37,11 @@ static const struct stm32_rcc stm32_rcc_h7 = {
 	.drv_name_rst = "stm32_rcc_reset",
 };
 
+static const struct stm32_rcc stm32_rcc_l4 = {
+	.drv_name_clk = "stm32l4_rcc_clock",
+	.drv_name_rst = "stm32_rcc_reset",
+};
+
 static const struct stm32_rcc stm32_rcc_mp15 = {
 	.drv_name_clk = "stm32mp1_clk",
 	.drv_name_rst = "stm32mp1_reset",
@@ -88,6 +93,7 @@ static const struct udevice_id stm32_rcc_ids[] = {
 	{.compatible = "st,stm32f469-rcc", .data = (ulong)&stm32_rcc_f469 },
 	{.compatible = "st,stm32f746-rcc", .data = (ulong)&stm32_rcc_f7 },
 	{.compatible = "st,stm32h743-rcc", .data = (ulong)&stm32_rcc_h7 },
+	{.compatible = "st,stm32l4r5-rcc", .data = (ulong)&stm32_rcc_l4 },
 	{.compatible = "st,stm32mp1-rcc", .data = (ulong)&stm32_rcc_mp15 },
 	{.compatible = "st,stm32mp1-rcc-secure", .data = (ulong)&stm32_rcc_mp15 },
 	{.compatible = "st,stm32mp13-rcc", .data = (ulong)&stm32_rcc_mp13 },
-- 
2.56.0

