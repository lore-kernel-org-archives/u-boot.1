Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9F2CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1ED784BE5;
	Fri,  8 May 2026 00:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="SUMRC1+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579AF84B9D; Thu,  7 May 2026 20:52:04 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24C584A75
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 20:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5806bb17a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1778179921; x=1809715921;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1t9uLN5Y6r7zkbzGNdBR05m/n2dl8Qr1uqK8h27QIEQ=;
 b=SUMRC1+99kIPtiZ7+ScphFUkqv5wvi0J8loXAYU7FbdoW9m9x60J5d8U
 PfJgyKd60ZTnSR5Q8VctCX0jxQvoJbm6K2pRESvWYGVJojBXGp4qVaI+S
 RWIrYVdo7aT/QiX8zh5PY7eQaBDh7SVmcMRR5PVtBFu9UvMr5uXuHMW8m
 x7qXfdrAKZGwxx4CDxHyG64Ta5uGwLnHv8ZiKBTARs1DGSl9sj0cUAPn7
 ZVPjX61pMlgihIacw34VReqw1jgq7+2rLeDsoS4WhLj/Og34+zN2uF8d8
 XDjWpO4f89/gfHM0Yw0Vurn+BRjWwMSENvC1TIDIdyOPvStTRGbaQ8+Cs A==;
X-CSE-ConnectionGUID: BmhTEcy2QxKfTEeqpvNLrg==
X-CSE-MsgGUID: cvwGErBwRfyPyanpn29D8A==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; d="scan'208";a="288561683"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 May 2026 11:51:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 7 May 2026 11:51:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 11:51:58 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Charles Perry <charles.perry@microchip.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rasmus Villemoes <ravi@prevas.dk>, Yegor Yefremov
 <yegorslists@googlemail.com>, Michal Simek <michal.simek@amd.com>, "Tanmay
 Kathpalia" <tanmay.kathpalia@altera.com>, Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>
Subject: [PATCH v2] gpio: Correct dependencies for MCP230xx
Date: Thu, 7 May 2026 11:51:22 -0700
Message-ID: <20260507185123.2210247-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 08 May 2026 00:05:04 +0200
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

This driver depends on DM_I2C and DM_SPI, add it.

Fixes: 3b639f643889 ("gpio: mcp230xx: Add support for models with SPI interface.")
Signed-off-by: Charles Perry <charles.perry@microchip.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Notes:
    Changes in v2:
     * Mention SPI devices in the Kconfig help
     * Add a Fixes: tag
     * Collect Quentin's Reviewed-by: Charles Perry <charles.perry@microchip.com>

 drivers/gpio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 37cb672697c0..8cfdabf76cd8 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -309,9 +309,9 @@ config MAX77663_GPIO
 
 config MCP230XX_GPIO
 	bool "MCP230XX GPIO driver"
-	depends on DM
+	depends on DM && DM_I2C && DM_SPI
 	help
-	  Support for Microchip's MCP230XX I2C connected GPIO devices.
+	  Support for Microchip's MCP230XX I2C and SPI connected GPIO devices.
 	  The following chips are supported:
 	   - MCP23008
 	   - MCP23017
-- 
2.47.3

