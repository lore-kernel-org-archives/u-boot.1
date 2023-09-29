Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA15E80ABE
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 11:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C5886E6B;
	Fri, 29 Sep 2023 13:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695987280;
	bh=5jCc3vyeeGFcUgfJHdd6MzvWY9u2M05i95aA3O971tk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ndzlQ2QWGmWoKnsP0IMTFv/HOZKevzyHjL2lnW0iHlXJzM2nyKUjH6s/+ISoK/YHc
	 NmRgEGZRDGegEBV8gdubbT+Z0SxgM4UxcuWoxDwN76raKWbx0hZc8I50YGQ/pbKR5m
	 Pnx8Lnfqc87/wio1ruNbt2PHDytQgnENtEdGk+fWCvbaxwLgbQYhCQTswsZF27iUXY
	 km84g8LxRcqpv8KU1A3mVKiLesNi8jJxkPlQ23ZU951yPKQsDSt/D2c7GxBU8SbN4y
	 nhEXVFKW4+m61g5BEeHkDD5Mkq49x9nRePeTDeofYYh0RehUiep6QrnVwTjjskzGzD
	 020+HYGbCseGw==
Received: from crub.agik.hopto.org (pd95f1e86.dip0.t-ipconnect.de
 [217.95.30.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3F58D86488;
 Fri, 29 Sep 2023 13:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695987278;
 bh=5jCc3vyeeGFcUgfJHdd6MzvWY9u2M05i95aA3O971tk=;
 h=From:To:Cc:Subject:Date:From;
 b=aXCItqUW6/DrP6UwhaH5TeuadKRt5DbDSedmY/0lOAtefe1Zt/B0giEcGqdLvzp82
 x9FHSyW4HXiq9LceEqXjEGTBqsgcY9Y6tUDg1etj4NLWKJPVB8MMdNVfDIW5eBGYvT
 SGKtEzGHH4a5sYGqnpkOOJqINsEB3+u02wF6kd63QKLdBiVqWnv7W4MeQoUH1IYL8R
 3yZ4sjVKvG3EXPDowzLHFNzAeqO/KK/HgeMoX1u5lyRSEZt/gb5jni4WomahDdPtPr
 tv6Z0ls9ddTXbRMhg3KN8nKkLYjrUTHHqtG1P+lAdwMEs4sfD/4rIKWdoPxOevBsUx
 FK11fjKrAsYjA==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, patrick.delaunay@foss.st.com,
 patrice.chotard@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] clk: stm32mp1: Add support for USART1 clock
Date: Fri, 29 Sep 2023 13:34:37 +0200
Message-Id: <20230929113437.26081-1-agust@denx.de>
X-Mailer: git-send-email 2.17.1
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

Add USART1 clock parents and mux configuration. This allows
support for configuring the USART1 as the serial console in
SPL and U-Boot via device tree. Without this patch the SPL
with usart1 serial console enabled crashes because it can
not find the clock specified in the device tree for usart1.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/clk/stm32/clk-stm32mp1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
index 6150287694..f3ac8c7583 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -72,6 +72,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define RCC_PLL2CSGR		0xA4
 #define RCC_I2C46CKSELR		0xC0
 #define RCC_SPI6CKSELR		0xC4
+#define RCC_UART1CKSELR		0xC8
 #define RCC_CPERCKSELR		0xD0
 #define RCC_STGENCKSELR		0xD4
 #define RCC_DDRITFCR		0xD8
@@ -317,6 +318,7 @@ enum stm32mp1_parent_sel {
 	_SPI45_SEL,
 	_SPI6_SEL,
 	_RTC_SEL,
+	_UART1_SEL,
 	_PARENT_SEL_NB,
 	_UNKNOWN_SEL = 0xff,
 };
@@ -557,6 +559,7 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 0, SPI6_K, _SPI6_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 2, I2C4_K, _I2C46_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 3, I2C6_K, _I2C46_SEL),
+	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 4, USART1_K, _UART1_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 8, RTCAPB, _PCLK5),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 16, BSEC, _UNKNOWN_SEL),
 	STM32MP1_CLK_SET_CLR(RCC_MP_APB5ENSETR, 20, STGEN_K, _STGEN_SEL),
@@ -602,6 +605,8 @@ static const struct stm32mp1_clk_gate stm32mp1_clk_gate[] = {
 static const u8 i2c12_parents[] = {_PCLK1, _PLL4_R, _HSI_KER, _CSI_KER};
 static const u8 i2c35_parents[] = {_PCLK1, _PLL4_R, _HSI_KER, _CSI_KER};
 static const u8 i2c46_parents[] = {_PCLK5, _PLL3_Q, _HSI_KER, _CSI_KER};
+static const u8 uart1_parents[] = {_PCLK5, _PLL3_Q, _HSI_KER, _CSI_KER,
+					_PLL4_Q, _HSE_KER};
 static const u8 uart6_parents[] = {_PCLK2, _PLL4_Q, _HSI_KER, _CSI_KER,
 					_HSE_KER};
 static const u8 uart24_parents[] = {_PCLK1, _PLL4_Q, _HSI_KER, _CSI_KER,
@@ -659,6 +664,7 @@ static const struct stm32mp1_clk_sel stm32mp1_clk_sel[_PARENT_SEL_NB] = {
 	STM32MP1_CLK_PARENT(_RTC_SEL, RCC_BDCR, RCC_BDCR_RTCSRC_SHIFT,
 			    (RCC_BDCR_RTCSRC_MASK >> RCC_BDCR_RTCSRC_SHIFT),
 			    rtc_parents),
+	STM32MP1_CLK_PARENT(_UART1_SEL, RCC_UART1CKSELR, 0, 0x7, uart1_parents),
 };
 
 #ifdef STM32MP1_CLOCK_TREE_INIT
@@ -786,6 +792,7 @@ char * const stm32mp1_clk_parent_sel_name[_PARENT_SEL_NB] = {
 	[_SPI1_SEL] = "SPI1",
 	[_SPI45_SEL] = "SPI45",
 	[_RTC_SEL] = "RTC",
+	[_UART1_SEL] = "UART1",
 };
 
 static const struct stm32mp1_clk_data stm32mp1_data = {
-- 
2.17.1

