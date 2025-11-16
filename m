Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C37CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D206183B24;
	Sun, 16 Nov 2025 15:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62782839AC; Sun, 16 Nov 2025 15:45:24 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4173F83B1E
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 52AD033BF0E;
 Sun, 16 Nov 2025 14:45:16 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 16 Nov 2025 14:43:58 +0000
Subject: [PATCH 07/11] gpio: a733: add initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-01-a733-soc-support-v1-7-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4141; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=mWYJAy8bqzXTuaxqv1nhF4kHyaOaIFky7f00AxvVNIw=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeNMwsVTTPhAGre2ztFTIGDk62TtrEIPJzgXv
 i+N0myUdcSJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjTF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277Vn7D/9iZhMIEt1Hvdzq9/
 eOnQzb+S4dGWJZF7hGHcJcaXEo9RGSX292PvtWUDC9phJyu8fEanH6+Sc8A7ufYXjl8kLLzrEIl
 8wZB0YLieqP7rX5FjUSuRz0hfzMXQc6AIL1sTtj0Uxq/p/04ZroDYoyjacRgrwXjprlBoeyOIoH
 ALJvI+smq+/LAZDM43mNfosxd7rzNlDmxMWu7OZbEF7ESwWleLNoquEp8+3JPKrQO7yeGOKNL9u
 o5UxSutWVodq4v13tsqZqzX6hNLW+9ZkA4IWcWvIAf4yxI7tyLbfwf9svDRgEXNyIHoNZOu+t40
 4hVjs5DC4QLdPU+nXoshWLnGjHyhPAutXBzSw66KtB1nKVafJovsYivUzXh8XgeQAqqJFA1RPT6
 A5IHNgzNBL7z2kxQu8xvZIQqqrQjumRRJwqIqajTZPuMyh4Nxgp1oY0Ys32mYTlwlJ2WaBLNycO
 1XfyAr4qePwSih/xA4bR+L6CjvEs4RCnBO5HdeoMI/gh4EobYeqxyd4HhUwzjmm4Np+T1LJXkA4
 cXdGiRdX4sup9PRf02x/MEcW8hskS8j769z0Rx0idA4YT1LgpuNw96BgcXxkN+/PeWovyCmPWqR
 whHPl3FMnfp6p9a3zfklxiTr5CUrbiFxlQsjqFbYD9t7MgZkIMNRI3B2DXsULxYJCY7w==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

In A733 SoC, the GPIO IP block has changed its arrangement, so initial
GPIO base address and port size need to be adjusted.

Introduce new SUNXI_NEW2_PINCTRL in order to reuse the driver in future.

There is no PA port exist in A733, but introducing a virtual one as offset
0x80, and with the port size 0x80, it will iterate other port correctly
starting from PB as offset 0x100.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm/mach-sunxi/Kconfig |  1 +
 drivers/gpio/Kconfig        |  7 +++++++
 drivers/gpio/sunxi_gpio.c   | 12 ++++++++++--
 include/sunxi_gpio.h        | 11 ++++++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d16ffddf482..81dea29964a 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -560,6 +560,7 @@ config MACH_SUN55I_A523
 config MACH_SUN60I_A733
 	bool "sun60i (Allwinner A733)"
 	select ARM64
+	select SUNXI_NEW2_PINCTRL
 	select FIT
 	select SPL_LOAD_FIT if SPL
 	select SUPPORT_SPL
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index db077e472a8..8a578b872c2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -426,6 +426,13 @@ config SUNXI_NEW_PINCTRL
 	The Allwinner D1 and other new SoCs use a different register map
 	for the GPIO block, which we need to know about in the SPL.
 
+config SUNXI_NEW2_PINCTRL
+	bool
+	depends on SUNXI_GPIO
+	---help---
+	The Allwinner A733 SoCs use a different register map
+	for the GPIO block, which we need to know about in the SPL.
+
 config XILINX_GPIO
 	bool "Xilinx GPIO driver"
 	depends on DM_GPIO
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index 094c45a6927..6fa74e5c599 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -38,18 +38,26 @@
 
 #define GPIO_DAT_REG_OFFSET	0x10
 
-#define GPIO_DRV_REG_OFFSET	0x14
 
 /*		Newer SoCs use a slightly different register layout */
 #ifdef CONFIG_SUNXI_NEW_PINCTRL
 /* pin drive strength: 4 bits per pin */
+#define GPIO_DRV_REG_OFFSET	0x14
 #define GPIO_DRV_INDEX(pin)	((pin) / 8)
 #define GPIO_DRV_OFFSET(pin)	(((pin) % 8) * 4)
 
 #define GPIO_PULL_REG_OFFSET	0x24
 
+#elif CONFIG_SUNXI_NEW2_PINCTRL
+#define GPIO_DRV_REG_OFFSET	0x20
+#define GPIO_DRV_INDEX(pin)	((pin) / 8)
+#define GPIO_DRV_OFFSET(pin)	(((pin) % 8) * 4)
+
+#define GPIO_PULL_REG_OFFSET	0x30
+
 #else /* older generation pin controllers */
 /* pin drive strength: 2 bits per pin */
+#define GPIO_DRV_REG_OFFSET	0x14
 #define GPIO_DRV_INDEX(pin)	((pin) / 16)
 #define GPIO_DRV_OFFSET(pin)	(((pin) % 16) * 2)
 
@@ -64,7 +72,7 @@ static void* BANK_TO_GPIO(int bank)
 	void *pio_base;
 
 	if (bank < SUNXI_GPIO_L) {
-		pio_base = (void *)(uintptr_t)SUNXI_PIO_BASE;
+		pio_base = (void *)(uintptr_t)(SUNXI_PIO_BASE + SUNXI_PIO_OFFSET);
 	} else {
 		pio_base = (void *)(uintptr_t)SUNXI_R_PIO_BASE;
 		bank -= SUNXI_GPIO_L;
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index 12b54c8dda4..ba8e5428900 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -19,7 +19,7 @@
 #elif defined(CONFIG_SUN50I_GEN_H6)
 #define SUNXI_PIO_BASE		0x0300b000
 #define SUNXI_R_PIO_BASE	0x07022000
-#elif defined(CONFIG_SUNXI_GEN_NCAT2)
+#elif defined(CONFIG_SUNXI_GEN_NCAT2) || defined(CONFIG_SUNXI_NEW2_PINCTRL)
 #define SUNXI_PIO_BASE		0x02000000
 #define SUNXI_R_PIO_BASE	0x07022000
 #else
@@ -27,6 +27,12 @@
 #define SUNXI_R_PIO_BASE	0x01f02c00
 #endif
 
+#if CONFIG_SUNXI_NEW2_PINCTRL
+#define SUNXI_PIO_OFFSET	0x80 /* offset for virtual PA port */
+#else
+#define SUNXI_PIO_OFFSET	0x00
+#endif
+
 /*
  * sunxi has 9 banks of gpio, they are:
  * PA0 - PA17 | PB0 - PB23 | PC0 - PC24
@@ -172,6 +178,9 @@ enum sunxi_gpio_number {
 #ifdef CONFIG_SUNXI_NEW_PINCTRL
 	#define SUNXI_PINCTRL_BANK_SIZE	0x30
 	#define SUNXI_GPIO_DISABLE	0xf
+#elif CONFIG_SUNXI_NEW2_PINCTRL
+	#define SUNXI_PINCTRL_BANK_SIZE	0x80
+	#define SUNXI_GPIO_DISABLE	0xf
 #else
 	#define SUNXI_PINCTRL_BANK_SIZE	0x24
 	#define SUNXI_GPIO_DISABLE	0x7

-- 
2.51.2

