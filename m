Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7BFD111A8
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 21:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D966C83993;
	Sun, 30 Nov 2025 22:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03D58312A; Sun, 30 Nov 2025 22:46:26 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C130B8397A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 22:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 9B0B4340FAB;
 Sun, 30 Nov 2025 21:46:20 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 30 Nov 2025 21:45:15 +0000
Subject: [PATCH v2 06/10] gpio: a733: add initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251130-01-a733-soc-support-v2-6-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
In-Reply-To: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4530; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=l65N9KQvJJokTTs4TuHmQCP6D/emeZe1k9nXRFb9xKk=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpLLsI9oTZEqS3OJs9iBge9p9IvCfIUmm3K2HD/
 kozsOwCwsaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaSy7CF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277V7cD/46rj5w6fHuVPed6E
 urjcC71DM65OF+reoDEZ59QeqGI1k6sM7NjZSJVMJQc1Y9KC1XrHYLiDAvWs6qq0Uklin+C7Ttr
 S0HMb+chWzC4NVcPNtlZ6lanAtHFs/64rbY2Vhze5JFyuLucCqSK0WEMdp7uzLt6MpULeWMjpn2
 UKkxJs7IWmg45xokZn8d4p89hI7m32Vg2Mnb6s76mjM26PBGDFATt9eD4KQbKelJJzrY52ZyGpI
 rbdkVW2DXlu7uC9Sg3Xs+SWuJjSWpDp9X6RUT96Fm7g5WIBD4Xv8RB4gojloEssJeIF2Z+kur0S
 Ij2geZadGofmhbo3AGFrP04DdBd+FTClisXxYzIxR9LNN8r/rhTPDFtPoRNs8EJF0JKqDx6gpfi
 etLUAoM3QJhzAdejrHoU5jCl/52/2oMMR+Nc8wlx24Cx55nXNTRZyAICDwHKyp2U2K14mDFVn18
 qF6zjVidmrQdeIwvwytShujIyo+BKEXLBgpskhX7wYFLX35lDHreq28sNbPK18571RUYtttKui7
 bP56JNTzQGj+wLyG93njR/Ybjc5FwDqIWf5AlCXE2idKYseckVR/w4g6D0ch+CQ49nYDi0//zqK
 +DA7rrerN27yuy+TclSrb5egGUdQ4glhzCaxNfkoTDZjykPW0U6PZwiOfJ6bWQLrE0Nw==
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
GPIO base address and bank size need to be adjusted.

Introduce new SUNXI_NEW2_PINCTRL in order to reuse the driver in future.

There is no PA bank exist in A733, but introducing a virtual one as offset
0x80, and with the bank size 0x80, it will iterate other bank correctly
starting from PB as offset 0x100.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm/mach-sunxi/Kconfig |  1 +
 drivers/gpio/Kconfig        |  7 +++++++
 drivers/gpio/sunxi_gpio.c   | 17 ++++++++++++++---
 include/sunxi_gpio.h        | 14 ++++++++++++++
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e6b4ac3688b..c3d4e0ab3c8 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -561,6 +561,7 @@ config MACH_SUN60I_A733
 	bool "sun60i (Allwinner A733)"
 	select ARM64
 	select SUNXI_GEN_NCAT2
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
index 094c45a6927..f6f7d0005ad 100644
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
 
@@ -62,15 +70,18 @@
 static void* BANK_TO_GPIO(int bank)
 {
 	void *pio_base;
+	u32 bank_size;
 
 	if (bank < SUNXI_GPIO_L) {
-		pio_base = (void *)(uintptr_t)SUNXI_PIO_BASE;
+		pio_base = (void *)(uintptr_t)(SUNXI_PIO_BASE + SUNXI_PIO_OFFSET);
+		bank_size = SUNXI_PINCTRL_BANK_SIZE;
 	} else {
 		pio_base = (void *)(uintptr_t)SUNXI_R_PIO_BASE;
+		bank_size = SUNXI_R_PINCTRL_BANK_SIZE;
 		bank -= SUNXI_GPIO_L;
 	}
 
-	return pio_base + bank * SUNXI_PINCTRL_BANK_SIZE;
+	return pio_base + bank * bank_size;
 }
 
 void sunxi_gpio_set_cfgbank(void *bank_base, int pin_offset, u32 val)
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index 12b54c8dda4..67d012fa0fa 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -19,6 +19,9 @@
 #elif defined(CONFIG_SUN50I_GEN_H6)
 #define SUNXI_PIO_BASE		0x0300b000
 #define SUNXI_R_PIO_BASE	0x07022000
+#elif defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_PIO_BASE		0x02000000
+#define SUNXI_R_PIO_BASE	0x07025000
 #elif defined(CONFIG_SUNXI_GEN_NCAT2)
 #define SUNXI_PIO_BASE		0x02000000
 #define SUNXI_R_PIO_BASE	0x07022000
@@ -172,11 +175,22 @@ enum sunxi_gpio_number {
 #ifdef CONFIG_SUNXI_NEW_PINCTRL
 	#define SUNXI_PINCTRL_BANK_SIZE	0x30
 	#define SUNXI_GPIO_DISABLE	0xf
+#elif CONFIG_SUNXI_NEW2_PINCTRL
+	#define SUNXI_PINCTRL_BANK_SIZE	0x80
+	#define SUNXI_GPIO_DISABLE	0xf
 #else
 	#define SUNXI_PINCTRL_BANK_SIZE	0x24
 	#define SUNXI_GPIO_DISABLE	0x7
 #endif
 
+#if CONFIG_SUNXI_NEW2_PINCTRL
+#define SUNXI_PIO_OFFSET		0x80 /* offset for virtual PA port */
+#define SUNXI_R_PINCTRL_BANK_SIZE	0x30
+#else
+#define SUNXI_PIO_OFFSET		0x00
+#define SUNXI_R_PINCTRL_BANK_SIZE	SUNXI_PINCTRL_BANK_SIZE
+#endif
+
 /* GPIO pin pull-up/down config */
 #define SUNXI_GPIO_PULL_DISABLE	0
 #define SUNXI_GPIO_PULL_UP	1

-- 
2.51.2

