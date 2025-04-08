Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E0FC369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 16:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A085D82C38;
	Tue,  8 Apr 2025 18:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aW4q8YqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6915682CAE; Tue,  8 Apr 2025 18:12:21 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 004A782AA3
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 18:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parth105105@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so1119074266b.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744128738; x=1744733538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TCmuGNwR0QpHrbIYQkxWGvcBjEbhoKl1lE9qGStRkmk=;
 b=aW4q8YqDyW6LyVaAg6Uy1Uhs3IWZviGAlXkIJEDZqlER5PeOLR6wqoHuTXaHM+xu65
 cJ7VRB/kPsC1M246AmvqW5dvzkKJHqeALmXRUfotIOWefnC+dCcDL6xmOlOlRspCnEwP
 D1J692c7T3SWCgAqX27W5rraluIzG8xs59RYoQFRQiEca7Sl0pDLO2H0NU/zjMimbCCa
 yL/tQcoZM2/LtCT3ebGMeZGPsrEh34BbVVZQ1IbBSzZpSU1RfTK/GumGHF7kaVXTceER
 2hOJ11BDjpf67zLPbm6aQzNenKFGsd+XsUb87X2ZXZBEaxFHfExBojkbKjRx49gPn8oC
 fsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744128738; x=1744733538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TCmuGNwR0QpHrbIYQkxWGvcBjEbhoKl1lE9qGStRkmk=;
 b=nxSys478BG5T7Y7zYkU9TsmnI/sm/oS9BTIzmwVVw3CY3Ymq8n1ErhDaAO7fEgY1ZC
 q3l8CXdIyREWyVtb6zK5PB6uCiln9bnz2zbaw/mxR/uj1/yw0XE+sYOg9ikCkbOBCsFZ
 ekN4I1WuWBi400J3VopNr1FJYjKyiDpBaKz9dAX4hAhF7mTeo3CaVYlu5rtr6w526zCj
 7EzPqa5vVV62ACapw+VpW3c/l5EB0eOfEJV3ORewKtEQJ7WbMOASq/3lau6ppIkJqS+X
 o0fT1aSCupZW19pny8G6GX60NC104fv7QwYt+PhL2SvZAOTSU23YKy38nlyjZGP3ZNek
 /VvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCKdeTl/un02zUkjsFA1hIadWXVvX6EImk0K2Woz3OOWzVs5GEIyYlXkysawn+FsXcWIslk/M=@lists.denx.de
X-Gm-Message-State: AOJu0YwdrgIodVO7M/4oPTb0onZNrNQnSuvILcGxA4YaGnRa16+il2Lv
 Gs1kqgoiHMNBpM6RxNbPlyfdes/AgXVglOWakwWr7a8Xy6r+VdKU
X-Gm-Gg: ASbGncv3uPOFqA+BMZ45a/4qEi4hDj8RQ37ck8r2qZnv4RoxYUBZdRYUcAE4VJKPczh
 ydZKAlSMQQZNUaHotJWrstL6BPSTjUKa1Rz5VxJNUbITbnxEQ8cLBxb01qemHltb13aRVoNK8bV
 l2IgY3hnhwVzZEIchdElqF8VAkoGNRauRFapLAnX8I8r2O5VSiRMg+bPOD3kuDd43ph41O+jEnQ
 tOgdEy/8uJtKGPwN1S8+Ifi2GlSpo3dPkTSg6Zn+bzlrmW4LjUMMY8Lq7Z+26VrAwFcRBFwkMkd
 kV9lG7zWMIh9HFflAT1fVFtht8f2ABCdw0pjPTqHLhDpyROg7YyvaY1U7G7+hFT9AKfAgYiYOCx
 xgCgLwTmQZYxmHXJhHn+HXq3q6Rc=
X-Google-Smtp-Source: AGHT+IFF9EUT7kYOsT0yodfoQ63RYjtIT4SPoc7jHF/YRIHRCNdCJbLWv/M7+On4scUaAG5oHtMQ9A==
X-Received: by 2002:a17:907:7f89:b0:ac7:cdbb:bf4a with SMTP id
 a640c23a62f3a-ac7d1853c90mr1734765366b.1.1744128738274; 
 Tue, 08 Apr 2025 09:12:18 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c0185f84sm950775666b.140.2025.04.08.09.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 09:12:17 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v1] arm: mach-k3: am62px: Fix MCU_CLKOUT0 parent clock mux
Date: Tue,  8 Apr 2025 18:12:11 +0200
Message-Id: <20250408161211.3165588-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Parth Pancholi <parth.pancholi@toradex.com>

CU_CLKOUT0 can be driven by two input clocks: a 25 MHz and a 50 MHz source.
Currently, the 25 MHz option is not selectable due to an incorrect mux
configuration where the 50 MHz clock is duplicated in the parent list.

This patch fixes the mux setup, allowing proper selection of the 25 MHz
clock source for MCU_CLKOUT0.

Similar configuration is already correctly implemented in AM62 clock
data for 'hsdiv4_16fft_main_2_hsdivout1_clk10', where MCU_CLKOUT0
parent switching behaves as expected.

Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am62px/clocks.html#clocks-for-board0-device
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
 arch/arm/mach-k3/r5/am62px/clk-data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/am62px/clk-data.c b/arch/arm/mach-k3/r5/am62px/clk-data.c
index 4b9892fe0516..bc62d1d0d084 100644
--- a/arch/arm/mach-k3/r5/am62px/clk-data.c
+++ b/arch/arm/mach-k3/r5/am62px/clk-data.c
@@ -59,7 +59,7 @@ static const char * const sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk_parents[] = {
 
 static const char * const clkout0_ctrl_out0_parents[] = {
 	"hsdiv4_16fft_main_2_hsdivout1_clk",
-	"hsdiv4_16fft_main_2_hsdivout1_clk",
+	"hsdiv4_16fft_main_2_hsdivout1_clk10",
 };
 
 static const char * const main_emmcsd0_refclk_sel_out0_parents[] = {
@@ -193,6 +193,7 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("hsdiv4_16fft_main_1_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_1_hsdivout3_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x68108c, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_2_hsdivout1_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682084, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_2_hsdivout1_clk10", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682084, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_2_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040080, 0, 7, 0, 0),
 	CLK_MUX_PLLCTRL("sam62_pll_ctrl_wrap_main_0_sysclkout_clk", sam62_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
@@ -281,7 +282,7 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(146, 5, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 36, "clkout0_ctrl_out0"),
 	DEV_CLK(157, 37, "hsdiv4_16fft_main_2_hsdivout1_clk"),
-	DEV_CLK(157, 38, "hsdiv4_16fft_main_2_hsdivout1_clk"),
+	DEV_CLK(157, 38, "hsdiv4_16fft_main_2_hsdivout1_clk10"),
 	DEV_CLK(157, 40, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 54, "mshsi2c_main_0_porscl"),
 	DEV_CLK(157, 91, "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk"),
-- 
2.34.1

