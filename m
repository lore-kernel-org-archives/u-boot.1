Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD83CCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8EAB83710;
	Wed, 29 Oct 2025 12:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB1F832AD; Wed, 29 Oct 2025 12:16:34 +0100 (CET)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B00B882A9E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxPnq3M5WzxM7;
 Wed, 29 Oct 2025 12:16:31 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxPnp6jGBzJNG; Wed, 29 Oct 2025 12:16:30 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Oct 2025 12:16:09 +0100
Subject: [PATCH 2/3] pwm: put all UCLASS PWM drivers under an if condition
 on DM_PWM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-pwm-kconfig-v1-2-80186567f2e8@cherry.de>
References: <20251029-pwm-kconfig-v1-0-80186567f2e8@cherry.de>
In-Reply-To: <20251029-pwm-kconfig-v1-0-80186567f2e8@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sukrut Bellary <sbellary@baylibre.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Cheick Traore <cheick.traore@foss.st.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This simplifies the "depends on" since we don't need DM_PWM listed
explicitly there as it already is made explicit via the surrounding
"if". No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

---
Note that I believe PWM_SANDBOX should also depend on DM_PWM but I'm not
sure how to make sure of that. The PWM sandbox test is explicitly only
built when DM_PWM=y instead of SANDBOX_PWM=y (is that another issue?).
---
 drivers/pwm/Kconfig | 136 ++++++++++++++++++++++++++--------------------------
 1 file changed, 67 insertions(+), 69 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ec57a967721..218c861ae43 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -11,75 +11,12 @@ config DM_PWM
 	  frequency/period can be controlled along with the proportion of that
 	  time that the signal is high.
 
-config PWM_ASPEED
-	bool "Enable support for the Aspeed PWM"
-	depends on DM_PWM
-	select SYSCON
-	help
-	  This PWM is found on Ast2600 SoCs. It supports a programmable period
-	  and duty cycle. It provides 16 channels which can be independently
-	  programmed.
-
-config PWM_AT91
-	bool "Enable support for PWM found on AT91 SoC's"
-	depends on DM_PWM && ARCH_AT91
-	help
-	  Support for PWM hardware on AT91 based SoC.
-
-config PWM_CADENCE_TTC
-	bool "Enable support for the Cadence TTC PWM"
-	depends on DM_PWM && !CADENCE_TTC_TIMER
-	help
-	  Cadence TTC can be configured as timer which is done via
-	  CONFIG_CADENCE_TTC_TIMER or as PWM. This is covering only PWM now.
-
-config PWM_CROS_EC
-	bool "Enable support for the Chrome OS EC PWM"
-	depends on DM_PWM
-	help
-	  This PWM is found on several Chrome OS devices and controlled by
-	  the Chrome OS embedded controller. It may be used to control the
-	  screen brightness and/or the keyboard backlight depending on the
-	  device.
-
-config PWM_EXYNOS
-	bool "Enable support for the Exynos PWM"
-	depends on DM_PWM && ARCH_EXYNOS
-	help
-	  This PWM is found on Samsung Exynos 5250 and other Samsung SoCs. It
-	  supports a programmable period and duty cycle. A 32-bit counter is
-	  used. It provides 5 channels which can be independently
-	  programmed. Channel 4 (the last) is normally used as a timer.
-
 config PWM_IMX
 	bool "Enable support for i.MX27 and later PWM"
 	depends on MACH_IMX
 	help
 	  This PWM is found i.MX27 and later i.MX SoCs.
 
-config PWM_MESON
-	bool "Enable support for Amlogic Meson SoCs PWM"
-	depends on DM_PWM
-	help
-	  This PWM is found on Amlogic Meson SoCs. It supports a
-	  programmable period and duty cycle for 2 independant channels.
-
-config PWM_MTK
-	bool "Enable support for MediaTek PWM"
-	depends on DM_PWM
-	help
-	  This PWM is found on MT7622, MT7623, and MT7629. It supports a
-	  programmable period and duty cycle.
-
-config PWM_ROCKCHIP
-	bool "Enable support for the Rockchip PWM"
-	depends on DM_PWM && ARCH_ROCKCHIP
-	help
-	  This PWM is found on RK3288 and other Rockchip SoCs. It supports a
-	  programmable period and duty cycle. A 32-bit counter is used.
-	  Various options provided in the hardware (such as capture mode and
-	  continuous/single-shot) are not supported by the driver.
-
 config PWM_SANDBOX
 	bool "Enable support for the sandbox PWM"
 	help
@@ -93,15 +30,75 @@ config PWM_S5P
 	depends on (S5P || ARCH_NEXELL)
 	default y
 
+if DM_PWM
+
+config PWM_ASPEED
+	bool "Enable support for the Aspeed PWM"
+	select SYSCON
+	help
+	  This PWM is found on Ast2600 SoCs. It supports a programmable period
+	  and duty cycle. It provides 16 channels which can be independently
+	  programmed.
+
+config PWM_AT91
+	bool "Enable support for PWM found on AT91 SoC's"
+	depends on ARCH_AT91
+	help
+	  Support for PWM hardware on AT91 based SoC.
+
+config PWM_CADENCE_TTC
+	bool "Enable support for the Cadence TTC PWM"
+	depends on !CADENCE_TTC_TIMER
+	help
+	  Cadence TTC can be configured as timer which is done via
+	  CONFIG_CADENCE_TTC_TIMER or as PWM. This is covering only PWM now.
+
+config PWM_CROS_EC
+	bool "Enable support for the Chrome OS EC PWM"
+	help
+	  This PWM is found on several Chrome OS devices and controlled by
+	  the Chrome OS embedded controller. It may be used to control the
+	  screen brightness and/or the keyboard backlight depending on the
+	  device.
+
+config PWM_EXYNOS
+	bool "Enable support for the Exynos PWM"
+	depends on ARCH_EXYNOS
+	help
+	  This PWM is found on Samsung Exynos 5250 and other Samsung SoCs. It
+	  supports a programmable period and duty cycle. A 32-bit counter is
+	  used. It provides 5 channels which can be independently
+	  programmed. Channel 4 (the last) is normally used as a timer.
+
+config PWM_MESON
+	bool "Enable support for Amlogic Meson SoCs PWM"
+	help
+	  This PWM is found on Amlogic Meson SoCs. It supports a
+	  programmable period and duty cycle for 2 independant channels.
+
+config PWM_MTK
+	bool "Enable support for MediaTek PWM"
+	help
+	  This PWM is found on MT7622, MT7623, and MT7629. It supports a
+	  programmable period and duty cycle.
+
+config PWM_ROCKCHIP
+	bool "Enable support for the Rockchip PWM"
+	depends on ARCH_ROCKCHIP
+	help
+	  This PWM is found on RK3288 and other Rockchip SoCs. It supports a
+	  programmable period and duty cycle. A 32-bit counter is used.
+	  Various options provided in the hardware (such as capture mode and
+	  continuous/single-shot) are not supported by the driver.
+
 config PWM_SIFIVE
 	bool "Enable support for SiFive PWM"
-	depends on DM_PWM
 	help
 	  This PWM is found SiFive's FU540 and other SoCs.
 
 config PWM_TEGRA
 	bool "Enable support for the Tegra PWM"
-	depends on DM_PWM && ARCH_TEGRA
+	depends on ARCH_TEGRA
 	help
 	  This PWM is found on Tegra 20 and other Nvidia SoCs. It supports
 	  four channels with a programmable period and duty cycle. Only a
@@ -110,7 +107,7 @@ config PWM_TEGRA
 
 config PWM_STM32
 	bool "Enable support for STM32 PWM"
-	depends on DM_PWM && MFD_STM32_TIMERS
+	depends on MFD_STM32_TIMERS
 	help
 	  This enables PWM driver for STMicroelectronics STM32 pulse width
 	  modulation. It uses STM32 timer devices that can have up to 4 output
@@ -118,22 +115,23 @@ config PWM_STM32
 
 config PWM_SUNXI
 	bool "Enable support for the Allwinner Sunxi PWM"
-	depends on DM_PWM && ARCH_SUNXI
+	depends on ARCH_SUNXI
 	help
 	  This PWM is found on H3, A64 and other Allwinner SoCs. It supports a
 	  programmable period and duty cycle. A 16-bit counter is used.
 
 config PWM_TI_EHRPWM
 	bool "Enable support for EHRPWM PWM"
-	depends on DM_PWM && ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS
 	default y
 	help
 	  PWM driver support for the EHRPWM controller found on TI SOCs.
 
 config PWM_TI_ECAP
 	bool "Enable support for ECAP PWM"
-	depends on DM_PWM && ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS
 	help
 	  PWM driver support for the ECAP controller found on TI SOCs.
 
+endif
 endmenu

-- 
2.51.0

