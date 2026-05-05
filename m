Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B6ECD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3468497A;
	Tue,  5 May 2026 17:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="gY27LO+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E6B384910; Tue,  5 May 2026 15:34:39 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E59848B9
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5789c44b6=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1777988077; x=1809524077;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=j/JorjhradRtE7xuCaa7pz5DXQbmPBUZ9Ll5Qich0RQ=;
 b=gY27LO+w4l85mNyHaXVIdQfTDljyWGxTWQCa6RfTimXYzDiXDI/IPjpH
 NiQc4/t9lQbG9okADOovARqDl/F2WiHuMBXBfDhprMKAwt5kJRZ3SFTNK
 wKLQ8ttsVLxBGIGvk05WpY3co61HKP+wF6JkFLIxZYfy4oXsLdPgqTFI7
 QD9LKMQC1UQy5lYR1xbqBR9SsVHEHkZnMpg5TUY0kwyYZYMZ2mtLfsNmD
 Al53ZSrJFxyMQoLOXQD55z2gb9W3MALUTZw9lFFvilcn7OUNOcMNiagfC
 b/hD2rc0bGpx8+CF9yO2+gGbSHIM8aO3VH3Ji0fXf9+lZoQkmOQjqIXl0 A==;
X-CSE-ConnectionGUID: 5zTlGS3UQvqre87F2ekPEQ==
X-CSE-MsgGUID: VtDHmKQpSca7UXyq+WvYjA==
X-IronPort-AV: E=Sophos;i="6.23,217,1770620400"; d="scan'208";a="65280711"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 06:34:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 5 May 2026 06:34:34 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 5 May 2026 06:34:33 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Charles Perry <charles.perry@microchip.com>, Tom Rini
 <trini@konsulko.com>, Eoin Dickson <eoin.dickson@microchip.com>, "Yegor
 Yefremov" <yegorslists@googlemail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Philip Molloy <philip.molloy@analog.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>
Subject: [PATCH] gpio: Correct dependencies for MCP230xx
Date: Tue, 5 May 2026 06:34:27 -0700
Message-ID: <20260505133427.2647028-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 05 May 2026 17:49:47 +0200
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

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 37cb672697c0..3ced3fb32f24 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -309,7 +309,7 @@ config MAX77663_GPIO
 
 config MCP230XX_GPIO
 	bool "MCP230XX GPIO driver"
-	depends on DM
+	depends on DM && DM_I2C && DM_SPI
 	help
 	  Support for Microchip's MCP230XX I2C connected GPIO devices.
 	  The following chips are supported:
-- 
2.47.3

