Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF04CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 04:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9AF82AC4;
	Tue, 14 Oct 2025 06:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061C3836C8; Tue, 14 Oct 2025 01:16:36 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C1D83710
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 01:16:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cltX01qwQz9t3y;
 Tue, 14 Oct 2025 01:16:32 +0200 (CEST)
From: Lukas Timmermann <uboot@timmermann.space>
To: u-boot@lists.denx.de
Cc: Lukas Timmermann <uboot@timmermann.space>
Subject: [RFC PATCH 1/2] gpio: s5p_gpio: Add config option for s5p_gpio driver
Date: Tue, 14 Oct 2025 01:14:01 +0200
Message-ID: <20251013231542.821799-2-uboot@timmermann.space>
In-Reply-To: <20251013231542.821799-1-uboot@timmermann.space>
References: <20251013231542.821799-1-uboot@timmermann.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 14 Oct 2025 06:56:55 +0200
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

This config option is required to make use of a newer pinctrl driver on
exynos 5 platforms. It is enabled per default to ensure older devices
can still use this driver.

Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
---

 arch/arm/mach-exynos/pinmux.c | 18 ++++++++++++++++++
 drivers/gpio/Kconfig          |  7 +++++++
 drivers/gpio/Makefile         |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
index 48c325190d5..77c831b8684 100644
--- a/arch/arm/mach-exynos/pinmux.c
+++ b/arch/arm/mach-exynos/pinmux.c
@@ -934,3 +934,21 @@ int pinmux_decode_periph_id(const void *blob, int node)
 	return PERIPH_ID_NONE;
 }
 #endif
+
+#if !CONFIG_IS_ENABLED(S5P_GPIO)
+
+/* Add stub functions if s5p_gpio driver isn't enabled */
+
+void gpio_set_pull(int pin, int pull)
+{
+}
+
+void gpio_set_drv(int pin, int drv)
+{
+}
+
+void gpio_cfg_pin(int pin, int cfg)
+{
+}
+
+#endif
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 58e464106a3..2c09fb7a65d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -724,5 +724,12 @@ config MPFS_GPIO
 	depends on DM_GPIO
 	help
 		Enable to support the GPIO driver on Polarfire SoC
+config S5P_GPIO
+	default y
+	bool "Samsung S5P GPIO driver"
+	depends on DM_GPIO && S5P
+	help
+	  Support GPIO controllers on Samsung Exynos 5 family of SoCs.
+	  This driver doesn't support upstream Linux device tree bindings.
 
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 83e10c79b91..5555ed27b14 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_PCA953X)		+= pca953x.o
 obj-$(CONFIG_ROCKCHIP_GPIO)	+= rk_gpio.o
 obj-$(CONFIG_RCAR_GPIO)		+= gpio-rcar.o
 obj-$(CONFIG_RZA1_GPIO)		+= gpio-rza1.o
-obj-$(CONFIG_S5P)		+= s5p_gpio.o
+obj-$(CONFIG_S5P_GPIO)		+= s5p_gpio.o
 obj-$(CONFIG_SANDBOX_GPIO)	+= sandbox.o sandbox_test.o
 obj-$(CONFIG_TEGRA_GPIO)	+= tegra_gpio.o
 obj-$(CONFIG_TEGRA186_GPIO)	+= tegra186_gpio.o
-- 
2.51.0

