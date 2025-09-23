Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D20CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 09:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA29380050;
	Tue, 23 Sep 2025 11:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="Mkju4UXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65FF833E9; Tue, 23 Sep 2025 11:58:43 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BFB80050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=354b57e8f=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1758621522; x=1790157522;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=g2G+KI1Fi1bO/SizbJyMOCX/Jd7BPzeJXdc1WsAstsQ=;
 b=Mkju4UXATsdVvZhGiNMAUKO1KSqsOAlBdHpKUZA0JrK42rjtGIAZH0WM
 7ObqP5/RAt6g6UFXLHD2DJ2auX3MjWlmzte8wrIpTx9Rx5u5qD6Ou6xal
 BWPRnoarCKXXlpLqvnazG0sV/5m8JQ6lfNpaK2GrlrOC2wKmDxR1ez+mN
 NCWnWb61Olnd7HRN9kcct9Tz+5bwLXZyLs60WTZ3X8HEyNsef/vsq4z5t
 Tz6IYTbMpVZbZ/vgY631c8hkTyUa3MZt7k/V1hqzDCnuJtp1mn6Do3C08
 hMZxsHN2hOsGjVUgPRdok5YGapCzjBQd5GaDQWTRkuwzY9GmzFo5c1tdd Q==;
X-CSE-ConnectionGUID: AbFig+T8T7e/aqNyDXzeow==
X-CSE-MsgGUID: +y1x6N+KRtWDZvRUw2/1GA==
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="46869730"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Sep 2025 02:58:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Sep 2025 02:58:28 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Sep 2025 02:58:25 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Lukasz Majewski <lukma@denx.de>, <seanga2@gmail.com>,
 <varshini.rajendran@microchip.com>, <Ryan.Wanner@microchip.com>,
 <balamanikandan.gunasundar@microchip.com>, <romain.sioen@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 1/2] clk: at91: Add ACR in all PLL setting.
Date: Tue, 23 Sep 2025 15:28:17 +0530
Message-ID: <20250923095818.441917-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add ACR in all PLL setting. Add correct ACR value for each PLL used in
different SoCs.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/pmc.h      | 1 +
 drivers/clk/at91/sam9x60.c  | 2 ++
 drivers/clk/at91/sam9x7.c   | 5 +++++
 drivers/clk/at91/sama7d65.c | 1 +
 drivers/clk/at91/sama7g5.c  | 1 +
 5 files changed, 10 insertions(+)

diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 580c9964ff4..f38868d1665 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -42,6 +42,7 @@ struct clk_pll_characteristics {
 	u16 *icpll;
 	u8 *out;
 	u8 upll : 1;
+	u32 acr;
 };
 
 struct clk_pll_layout {
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index e04266a2be2..2251e2846fa 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -123,6 +123,7 @@ static const struct clk_pll_characteristics apll_characteristics = {
 	.num_output = ARRAY_SIZE(plla_outputs),
 	.output = plla_outputs,
 	.core_output = core_outputs,
+	.acr = 0x00020010UL,
 };
 
 static const struct clk_pll_characteristics upll_characteristics = {
@@ -131,6 +132,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.output = upll_outputs,
 	.core_output = core_outputs,
 	.upll = true,
+	.acr = 0x12023010UL, /* fIN = [18 MHz, 32 MHz]*/
 };
 
 /* Layout for fractional PLLs. */
diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index ad9865feff0..9ea253e6ff8 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -164,6 +164,7 @@ static const struct clk_pll_characteristics plla_characteristics = {
 	.num_output = ARRAY_SIZE(plla_outputs),
 	.output = plla_outputs,
 	.core_output = plla_core_outputs,
+	.acr = 0x00020010UL, /* Old ACR_DEFAULT_PLLA value */
 };
 
 static const struct clk_pll_characteristics upll_characteristics = {
@@ -172,6 +173,7 @@ static const struct clk_pll_characteristics upll_characteristics = {
 	.output = upll_outputs,
 	.core_output = upll_core_outputs,
 	.upll = true,
+	.acr = 0x12023010UL, /* fIN=[20 MHz, 32 MHz] */
 };
 
 static const struct clk_pll_characteristics lvdspll_characteristics = {
@@ -179,6 +181,7 @@ static const struct clk_pll_characteristics lvdspll_characteristics = {
 	.num_output = ARRAY_SIZE(lvdspll_outputs),
 	.output = lvdspll_outputs,
 	.core_output = lvdspll_core_outputs,
+	.acr = 0x12023010UL, /* fIN=[20 MHz, 32 MHz] */
 };
 
 static const struct clk_pll_characteristics audiopll_characteristics = {
@@ -186,6 +189,7 @@ static const struct clk_pll_characteristics audiopll_characteristics = {
 	.num_output = ARRAY_SIZE(audiopll_outputs),
 	.output = audiopll_outputs,
 	.core_output = audiopll_core_outputs,
+	.acr = 0x12023010UL, /* fIN=[20 MHz, 32 MHz] */
 };
 
 static const struct clk_pll_characteristics plladiv2_characteristics = {
@@ -193,6 +197,7 @@ static const struct clk_pll_characteristics plladiv2_characteristics = {
 	.num_output = ARRAY_SIZE(plladiv2_outputs),
 	.output = plladiv2_outputs,
 	.core_output = plladiv2_core_outputs,
+	.acr = 0x00020010UL,  /* Old ACR_DEFAULT_PLLA value */
 };
 
 /* Layout for fractional PLLs. */
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index 8d2c25e6fa9..9f0b394543b 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -184,6 +184,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 	.num_output = ARRAY_SIZE(pll_outputs),
 	.output = pll_outputs,
 	.core_output = core_outputs,
+	.acr = 0x00070010UL,
 };
 
 /* Layout for fractional PLLs. */
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index c0e27828b1a..f24d251857f 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -169,6 +169,7 @@ static const struct clk_pll_characteristics pll_characteristics = {
 	.num_output = ARRAY_SIZE(pll_outputs),
 	.output = pll_outputs,
 	.core_output = core_outputs,
+	.acr = 0x00070010UL,
 };
 
 /* Layout for fractional PLLs. */
-- 
2.25.1

