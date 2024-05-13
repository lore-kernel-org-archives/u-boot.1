Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3372C25B75
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 20:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 847B488273;
	Mon, 13 May 2024 22:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vmi51gOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BECB787D46; Mon, 13 May 2024 22:56:43 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D8588210
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 22:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9B00260F80;
 Mon, 13 May 2024 20:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA26C4AF07;
 Mon, 13 May 2024 20:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715633799;
 bh=Z51OZIOCShp1ZcHIbATzWebdi4zEruWXy6IqzirLhis=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vmi51gOQtkAkmofI6/XiUoWvCPvUvS+vSbwmI3m1iokQK2idJetrMh8liJP1iCqAC
 FHeHuvutC7bQQIf9aLc2Vk0DAmsDGIouWycsBHJTm9DF8Bm4LuPosBwzehN57E43v5
 a10JRQaT53yY+LCNcgQ+nUmhY8y2lW0IzhrT4lRG55RCGKOiXUxL8oEEynvIA3Y76C
 rYa2Z6+/pohi6QwpyNcM9xuUP7290AwYw2mZLo+eGBrKvkl+6/wa4+rKRiPx/DD5JU
 +TZOX29Hu32JVm+FXlWrVt3PAJnE+xMA333ujhRYmrY0cmTucqYc3C/68vo05GTHgc
 PwzU0H7Y5VBxg==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/2] clk: sunxi: add EMAC and EPHY clocks and resets for the
 V3s SoC
Date: Mon, 13 May 2024 22:56:08 +0200
Message-Id: <20240513205609.1872861-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513205609.1872861-1-mwalle@kernel.org>
References: <20240513205609.1872861-1-mwalle@kernel.org>
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

Add the clock gate registers as well as the reset register bits for the
EMAC and EPHY for the V3s. These are needed by the sun8i network driver.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/clk/sunxi/clk_v3s.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/sunxi/clk_v3s.c b/drivers/clk/sunxi/clk_v3s.c
index 6524c13540e..0402d5ed190 100644
--- a/drivers/clk/sunxi/clk_v3s.c
+++ b/drivers/clk/sunxi/clk_v3s.c
@@ -17,6 +17,7 @@ static struct ccu_clk_gate v3s_gates[] = {
 	[CLK_BUS_MMC0]		= GATE(0x060, BIT(8)),
 	[CLK_BUS_MMC1]		= GATE(0x060, BIT(9)),
 	[CLK_BUS_MMC2]		= GATE(0x060, BIT(10)),
+	[CLK_BUS_EMAC]		= GATE(0x060, BIT(17)),
 	[CLK_BUS_SPI0]		= GATE(0x060, BIT(20)),
 	[CLK_BUS_OTG]		= GATE(0x060, BIT(24)),
 
@@ -31,6 +32,8 @@ static struct ccu_clk_gate v3s_gates[] = {
 	[CLK_BUS_UART1]		= GATE(0x06c, BIT(17)),
 	[CLK_BUS_UART2]		= GATE(0x06c, BIT(18)),
 
+	[CLK_BUS_EPHY]		= GATE(0x070, BIT(0)),
+
 	[CLK_SPI0]		= GATE(0x0a0, BIT(31)),
 
 	[CLK_USB_PHY0]          = GATE(0x0cc, BIT(8)),
@@ -45,12 +48,15 @@ static struct ccu_reset v3s_resets[] = {
 	[RST_BUS_MMC0]		= RESET(0x2c0, BIT(8)),
 	[RST_BUS_MMC1]		= RESET(0x2c0, BIT(9)),
 	[RST_BUS_MMC2]		= RESET(0x2c0, BIT(10)),
+	[RST_BUS_EMAC]		= RESET(0x2c0, BIT(17)),
 	[RST_BUS_SPI0]		= RESET(0x2c0, BIT(20)),
 	[RST_BUS_OTG]		= RESET(0x2c0, BIT(24)),
 
 	[RST_BUS_TCON0]		= RESET(0x2c4, BIT(4)),
 	[RST_BUS_DE]		= RESET(0x2c4, BIT(12)),
 
+	[RST_BUS_EPHY]		= RESET(0x2c8, BIT(2)),
+
 	[RST_BUS_I2C0]		= RESET(0x2d8, BIT(0)),
 	[RST_BUS_I2C1]		= RESET(0x2d8, BIT(1)),
 	[RST_BUS_UART0]		= RESET(0x2d8, BIT(16)),
-- 
2.39.2

