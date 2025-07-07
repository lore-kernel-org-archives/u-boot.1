Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F8C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B31E831C2;
	Mon,  7 Jul 2025 17:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="VxXys5rw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7310830E4; Mon,  7 Jul 2025 13:38:09 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4758305C
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2768a2b95=Varshini.Rajendran@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751888287; x=1783424287;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ilPtvBJiW7LJ77p1JUpK0JBYKHK30m0dOS5gnr6i/IM=;
 b=VxXys5rwN1aDmARVLy/2WMn4IA+ZHa8ZQVLW+ps+lIQC3RydrXv2IQYX
 CZie84jfyM5uY0PMx8G6OBpPrEDsyrPuXygp8r8SngAp74anjZFEOFLfV
 5OT8eLWbTuRxde5XmnqT8Qve4Gw68YlyVmLPzmqthj/MPAit8CyozfKUM
 qVtXt2+kX7qWC2tuAEdJ8isL6B2OZj9tlYYCIdpRbkoIiVlDhC5LaMZzA
 KbzUfq5831MiNSNHuwvaeDmlkSKMUbrwQMCbs0kIbpWCLOlZ22Poot1M+
 dbZjqyFBib/9Ki3w4+c8Z6Ub8pmVU6mxXKo9Yud71o0jZlcxM8+OE6Avk g==;
X-CSE-ConnectionGUID: Y+uV++1dTMWM329rmu1xxQ==
X-CSE-MsgGUID: 12QEHHMyQJae5NR+vkbwQw==
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="43164824"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Jul 2025 04:38:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 04:37:35 -0700
Received: from che-dk-mpulab01.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 7 Jul 2025 04:37:33 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <lukma@denx.de>, <seanga2@gmail.com>, <Ryan.Wanner@microchip.com>,
 <varshini.rajendran@microchip.com>, <u-boot@lists.denx.de>
CC: <eugen.hristev@linaro.org>
Subject: [PATCH 1/6] clk: at91: Update MAX PLL and master clk ID
Date: Mon, 7 Jul 2025 17:01:27 +0530
Message-ID: <20250707113127.4130992-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
References: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 07 Jul 2025 17:54:47 +0200
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Update the MAX PLL and master CLK ID to support sama7d65
SoC family.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-master.c      | 2 +-
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index d28775d64d3..cdc5271fa83 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -37,7 +37,7 @@
 
 #define PMC_MCR_ID(x)		((x) & PMC_MCR_ID_MSK)
 
-#define MASTER_MAX_ID		4
+#define MASTER_MAX_ID		10
 
 struct clk_master {
 	void __iomem *base;
diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index df8172bccac..65be2775ac3 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -32,7 +32,7 @@
 #define UPLL_DIV		2
 #define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
 
-#define PLL_MAX_ID		7
+#define PLL_MAX_ID		8
 
 struct sam9x60_pll {
 	void __iomem *base;
-- 
2.45.2

