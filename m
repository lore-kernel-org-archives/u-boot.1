Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC57C35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE828168B;
	Mon, 17 Mar 2025 17:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a4Uu8RHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5248122F; Mon, 17 Mar 2025 17:15:12 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0972880F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913fdd003bso2283760f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228110; x=1742832910; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P+WVDpSXY/Mk3XgOObAayDEvFQZxsL4LqvkDSiaI6pI=;
 b=a4Uu8RHfYwfxl9s3cDt/pvYf6gwCXnwbeWCw5NbxMiUd/hJWOMyWDeGlGbvTodBy9l
 wMSIX0rcXKENFoNrwXpGm2SQy7C5IDk+KWf77MyoL96Mqolzf7UJoboI/LAb9AhDBjcU
 Ym5wRdVy0dXVOPxOweeR7Aony1dO0AAhTLiztQgL6Xrbt1+d+djgZyp7PbQts0fyE639
 4dAU3xCVnlnjJfUaZZgHY4CncwBON1/lxYhsspq5c0g5Ug7CmZ/CjT8aTafkouSDW+UJ
 qnpS2eSHWhAcc7/sinJhodMOAhHDw5xYL5qWWaQLIdLWYnW7O2L5v7qjMwZZoozY9+L8
 3lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228110; x=1742832910;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+WVDpSXY/Mk3XgOObAayDEvFQZxsL4LqvkDSiaI6pI=;
 b=SxG22PizdNMnUl8W+YLHtTukt623WhdhIsF2bWq9uV79lWl1PSNeg4IjYMD2P9A7mt
 XCQaEEtLTx/UCd26DQPK5quU/XVTn6wA6OBq5WrHMl+baA4ZEx/Hay/TzbnrO8ZynqMO
 cC2Yz/krEQWvbfLbKXpROk7FeP3asK/JeZY5k0+ZeIbKK0MWoKfYtqlnxgLeOpZvW7ll
 65d1aVSseJSjDxtNwH0zIaDDyjjVg/W2m87Cawj7JpxLUXrIksigrv0zYy4ZENdFiIUL
 Z3AYHBuUKMGM/gAzuPTmlE2akG9VfKdRiw7t0rdn6xeaxI9Ca5uYwM/M+G5JQeS4Aiuh
 oCdA==
X-Gm-Message-State: AOJu0Yya6gZJBck9ojRkV4tG9FuzGXwuS5r8VnRJZMYITpI0gWWk7cOo
 3Gn7CFW28IMMlFl8Et2YxnkfudupKZ3GkoYLFJo8azp0qxV49QgBHb+nb18B8dU=
X-Gm-Gg: ASbGncsZn0/LIWHYciPCbGpeKJdatcQ8WCIvAM/mfvFdeZAQYNw+hAa449PEe9s1Jgq
 /EoB4A9Cxj5KdoIGW/SiyZXBruyYm75UB18Dnlym4sis3ObjFrHVpwruWkHxyY+om3VvNRnirN9
 dxneAqDfnyOopXNP1uVyqbOoxTjS7NfzEP9YnzhU85iLxbjRyUtJupUCqsMDnGN6tq0bYLvB/BZ
 YF/OLwDZl97CUsM27gG0b7Dg2bWKWMLXpGJAW54ch10RjMpgUPd3zJTEyClKj5ItHx2aa3fgKsB
 2VCt0G8/n693SNO3yT2zgksUjMPuH+Wt/5gNGR5KLeN9mXJD+ovvMke/FPpY
X-Google-Smtp-Source: AGHT+IEnE7SRE8/J6hDj8rYbhajUpi7UUzUqv9PymCQtippoLl14XxJkB7H6epQNS1lXNaGtCaiR6A==
X-Received: by 2002:a5d:6dad:0:b0:391:952:c74a with SMTP id
 ffacd0b85a97d-3996bb44ca3mr35079f8f.8.1742228110400; 
 Mon, 17 Mar 2025 09:15:10 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888167bsm15382001f8f.45.2025.03.17.09.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:15:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 17 Mar 2025 16:15:02 +0000
Subject: [PATCH 2/2] clk/qcom: sc7280: add missing UFS and MMC clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-sc7280-mmc-ufs-clocks-v1-2-38e05c16511b@linaro.org>
References: <20250317-sc7280-mmc-ufs-clocks-v1-0-38e05c16511b@linaro.org>
In-Reply-To: <20250317-sc7280-mmc-ufs-clocks-v1-0-38e05c16511b@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=274yFWAVcD4QFEJiDqDnn7YTJyP05G6pVVzrkKyid4c=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn2EqKcWxQWGgAQ7PxFwbdwBp45pdhuXc5mpnRK
 SWZaQGymbqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9hKigAKCRAFgzErGV9k
 tjHOD/4lribEv8GZnZkJrYi7ITq1W/yGuT/9/nqh0LtFGpteFvEs2iDnukvtDxl7KI0pUsu19c0
 1DE+xXIcVVHB5h3idGUMv1PYFamOXlMLZcj4DIMOxbGGGienEHbaKS34ftbAvlZrWxNQ7DV8dDf
 MiS7E5LywQUlsLm+2aNC9VFce8ronn84jm2E3nlD3oM0C+MDrOYW1w48YXgSMivo39FL2G2+CsR
 79BJFFPBVoUEnBPCYLOBkXGItIsHRLAUvYDYFPPqgLnEpg+WvasvcdL3itEtpjznx4RUAWrGLqP
 UibV/ewdBMWuJyYzkUDW0OeX4F/RZH9WLDU8R2X183Bm9S3KlKR1rFJnwYLjWI07RTh2df0QioP
 HCLgKJOZIhKj4bebkEVwhJxaJIrhzy4e1Zlpg0E8z7I/dl14bm2XR9fstKXiN9X9sHgJXkbKxMT
 WVVGBWcDV4o1yx1XC89aQskfx8EwDGB2CtDTb5JgKsw9Z18DyXb1g2+NcMBwpLbuxqwxUzMXCxY
 CtdGiPz/nHbWmhVQk3uHHiqcBp6DjO92La40RElpeEKfYETw/3AhKnmwBRP6tgc1fmAc0bIEy1X
 VVqUpzCyydNC+pIlLHjrhpSndwKplh9/sY+dh61PcrZuLHn2MJHYKBytdFHOmbaevCabSsefOnJ
 UyutLDSWQcfxWlA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

These are all usually enabled, hence we don't (yet) bother configuring
their RCG src clocks.

Add them to remove the errors about missing clocks when the UFS and MMC
drivers probe.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 8691f08109b39639d8a5defe75161049399bf682..9aff8a847ad1bd59b7ec7246f5719e4d7c32ec65 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -106,8 +106,19 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK, 0x52008, BIT(28)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x77020, BIT(0)),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x770b8, BIT(0)),
+	GATE_CLK(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
 };
 
 static int sc7280_enable(struct clk *clk)
 {

-- 
2.48.1

