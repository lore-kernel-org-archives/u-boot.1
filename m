Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B52C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDE187FCB;
	Mon,  4 Mar 2024 12:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4E787FBF; Mon,  4 Mar 2024 12:30:46 +0100 (CET)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF3F87FA3
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhw6GrHzMpnPV;
 Mon,  4 Mar 2024 12:30:40 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGhw23c6zspK; Mon,  4 Mar 2024 12:30:40 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 Mar 2024 12:30:08 +0100
Subject: [PATCH v3 14/16] adc: add missing depends on ADC for controller
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-rk3588-saradc-v3-14-7424e2ed5d3b@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
In-Reply-To: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The ADC controller drivers are obviously all depending on ADC symbol
being selected.

While they don't seem to fail to build without, they won't be useful
without that symbol selected, so let's make sure the options aren't
shown in menuconfig when ADC isn't selected.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/adc/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
index a01d73846b7..c9cdbe6942d 100644
--- a/drivers/adc/Kconfig
+++ b/drivers/adc/Kconfig
@@ -13,6 +13,7 @@ config ADC
 
 config ADC_EXYNOS
 	bool "Enable Exynos 54xx ADC driver"
+	depends on ADC
 	help
 	  This enables basic driver for Exynos ADC compatible with Exynos54xx.
 	  It provides:
@@ -22,6 +23,7 @@ config ADC_EXYNOS
 
 config ADC_SANDBOX
 	bool "Enable Sandbox ADC test driver"
+	depends on ADC
 	help
 	  This enables driver for Sandbox ADC device emulation.
 	  It provides:
@@ -31,6 +33,7 @@ config ADC_SANDBOX
 
 config SARADC_MESON
 	bool "Enable Amlogic Meson SARADC driver"
+	depends on ADC
 	imply REGMAP
 	help
 	  This enables driver for Amlogic Meson SARADC.
@@ -41,6 +44,7 @@ config SARADC_MESON
 
 config SARADC_ROCKCHIP
 	bool "Enable Rockchip SARADC driver"
+	depends on ADC
 	help
 	  This enables driver for Rockchip SARADC.
 	  It provides:

-- 
2.44.0

