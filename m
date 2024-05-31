Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED0FC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB1B88805;
	Fri, 31 May 2024 17:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="E46LDal5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260F5882CD; Fri, 31 May 2024 16:34:16 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED443887B7
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.schramm@manjaro.org
From: Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717166050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voH0lHvXrkTMmzvcaw0pD9clMspYefqJb2p+0LzH3U8=;
 b=E46LDal5RbHIbn/TJKrJFpIOKdbSXN36qdzWKU5elZ3nCWZC4etm0uCe5JreDvZBThAXf6
 7Ib+vS/DcACJH0Gwnqv9kfgi+crpABtS4OANjIiExcgCzE7B8s/URvc36GBt02awylOStA
 KvbJ1NVgTaIuLA4jWqbcOlJl1taYRnhh+L6s4gqZEMveKa29tfhCv6jS5aRVejZl5A9Buw
 mJuRmTNNdd9GvA3tkvoVhk2umfJOFX5BN2vfBQ4zYXC2ix6C7dYvHCNWyyXOdJVpf8+oV8
 fDsFxBaCt0O92HWQDLirJULno8djwAVGQGkqfmYtIC7nAF8BgoL3QL5VXLiIiw==
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/2] clk: sunxi: support Ethernet clock gates and resets on
 V3s-based SoCs
Date: Fri, 31 May 2024 16:33:49 +0200
Message-ID: <20240531143350.14855-2-t.schramm@manjaro.org>
In-Reply-To: <20240531143350.14855-1-t.schramm@manjaro.org>
References: <20240531143350.14855-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
X-Mailman-Approved-At: Fri, 31 May 2024 17:13:20 +0200
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

Previously Ethernet clock gates and resets were missing from the V3s CCU
driver.
Add the required clock gates and resets for Ethernet MAC and internal
Ethernet phy.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/clk/sunxi/clk_v3s.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/sunxi/clk_v3s.c b/drivers/clk/sunxi/clk_v3s.c
index 6524c13540..0402d5ed19 100644
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
2.30.2

