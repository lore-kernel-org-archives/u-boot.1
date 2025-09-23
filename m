Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBC2CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 09:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4739583443;
	Tue, 23 Sep 2025 11:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="ImDMeUi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04BB80050; Tue, 23 Sep 2025 11:58:44 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEFC80C93
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=354b57e8f=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1758621523; x=1790157523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xOnqtG70bRLA5V0J+jTkFg/O5L1EL+cuHKiZ1brm+0c=;
 b=ImDMeUi9W783nei4HKwLEcOYulKOdPvQ5Iyv8YkG8kTn6ce57a9PC24K
 BlANf5IOu2uya5rjVUhZ/FEtzMDiKVDXwItbLAStxrlkdjitjFqZFudp1
 tcxqGK8+QDXotOToIUq5Lc57xq6FfrLdD+2TgqNMnEnBjKNUfvRkZpz5s
 8TYqmcoJ9SEOaJFZNErqt6xQymMP+Lkr2af+sUPHg4hEGPppOLshNPLDG
 ln/S+suuLnRZmuf+PWxcKHB/6yweEJKd6wsa4KOWH5Eq5/7Kvj3rOY96L
 7eIwe96vhvYm/W8keWb/yhL7W7lbyom9qIXkldeKCdwjCIMFafnENxM81 Q==;
X-CSE-ConnectionGUID: AbFig+T8T7e/aqNyDXzeow==
X-CSE-MsgGUID: UaqOj5WLQ9Cw/jQuJ/jbtQ==
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="46869731"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Sep 2025 02:58:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Sep 2025 02:58:34 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Sep 2025 02:58:31 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Lukasz Majewski <lukma@denx.de>, <seanga2@gmail.com>,
 <varshini.rajendran@microchip.com>, <Ryan.Wanner@microchip.com>,
 <balamanikandan.gunasundar@microchip.com>, <romain.sioen@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 2/2] ARM: at91: remove default values for PMC_PLL_ACR
Date: Tue, 23 Sep 2025 15:28:18 +0530
Message-ID: <20250923095818.441917-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250923095818.441917-1-manikandan.m@microchip.com>
References: <20250923095818.441917-1-manikandan.m@microchip.com>
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

Remove default values for PMC PLL Analog Control Register(ACR) as the
values are specific for each SoC and PLL, so load them from PLL
characteristics structure

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 7 ++-----
 include/linux/clk/at91_pmc.h       | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 65be2775ac3..66f01472739 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -183,11 +183,8 @@ static int sam9x60_frac_pll_enable(struct clk *clk)
 			AT91_PMC_PLL_UPDT_ID_MSK,
 			AT91_PMC_PLL_UPDT_STUPTIM(0x3f) | pll->id);
 
-	/* Recommended value for AT91_PMC_PLL_ACR */
-	if (pll->characteristics->upll)
-		val = AT91_PMC_PLL_ACR_DEFAULT_UPLL;
-	else
-		val = AT91_PMC_PLL_ACR_DEFAULT_PLLA;
+	/* Load recommended value for PMC_PLL_ACR */
+	val = pll->characteristics->acr;
 	pmc_write(base, AT91_PMC_PLL_ACR, val);
 
 	if (pll->characteristics->upll) {
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index ee39e72e2b3..a48b15e049a 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -45,8 +45,6 @@
 #define	AT91_PMC_PCSR		0x18			/* Peripheral Clock Status Register */
 
 #define AT91_PMC_PLL_ACR	0x18			/* PLL Analog Control Register [for SAM9X60] */
-#define		AT91_PMC_PLL_ACR_DEFAULT_UPLL	0x12020010UL	/* Default PLL ACR value for UPLL */
-#define		AT91_PMC_PLL_ACR_DEFAULT_PLLA	0x00020010UL	/* Default PLL ACR value for PLLA */
 #define		AT91_PMC_PLL_ACR_UTMIVR		(1 << 12)	/* UPLL Voltage regulator Control */
 #define		AT91_PMC_PLL_ACR_UTMIBG		(1 << 13)	/* UPLL Bandgap Control */
 
-- 
2.25.1

