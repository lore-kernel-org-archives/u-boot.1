Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE16CD1036D
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 23:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F9984172;
	Wed, 26 Nov 2025 00:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JB6RyljF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C94840B0; Wed, 26 Nov 2025 00:42:44 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 022FF84172
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8D1F31A1D5D
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:42:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 64B35606A1;
 Tue, 25 Nov 2025 23:42:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 593B3102F08B7; Wed, 26 Nov 2025 00:42:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764114158; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PdPW9b4NRmp2SRIdEBIE+AGtlCqFGFH13D18tzWdWQ0=;
 b=JB6RyljFtI2x1VoDAODfeoJzlHa6To3rVQqYHDHHpyTGVuUJ1+et0FIxZty8DFVxtlSU4k
 s4KcNaNSp/FDRvNoWAB5mF4s7GZvQ1jXcajCdudG6mqedC3B2xo2xHf7mp/O6RrK9Z2+eA
 rBEnFmoieo55rs3NvC9XC8pY0UKmGkQvNrR8qriIzeMk85D89JMJ1lSLyP4t9b7yD7E8Se
 RaUotIzOMjNB8gyJ76C1GNEST9yYPUAAPZ2hf9T+HK8NR0nL0BTS3jmWvBjQLhD65jqK2+
 gLQLwxNJhXKP88N4oZso3feI6T6O4tZAcLkGhtXTtYIArh+MeU+NLf/qtMoM3A==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 26 Nov 2025 00:41:57 +0100
Subject: [PATCH 5/5] board: toradex: add splash screen to Toradex i.MX7D
 Colibri board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-repair_imx7_splash-v1-5-d3877afb7381@bootlin.com>
References: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
In-Reply-To: <20251126-repair_imx7_splash-v1-0-d3877afb7381@bootlin.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Simon Glass <sjg@chromium.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

This commit fixes the PWM<A> that was previously used as a GPIO output
instead of a real PWM, it also reserve the framebuffer region to
preserve the splash screen while the OS is booting.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 board/toradex/colibri_imx7/colibri_imx7.c | 40 +++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index 69a8a18d3a7..b5d22337a04 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -7,6 +7,8 @@
 #include <env.h>
 #include <init.h>
 #include <net.h>
+#include <fdt_simplefb.h>
+#include <video.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/crm_regs.h>
 #include <asm/arch/imx-regs.h>
@@ -29,6 +31,7 @@
 #include <netdev.h>
 #include <power/pmic.h>
 #include <power/rn5t567_pmic.h>
+#include <pwm.h>
 #include <usb.h>
 #include <usb/ehci-ci.h>
 #include "../common/tdx-common.h"
@@ -114,7 +117,7 @@ static iomux_v3_cfg_t const backlight_pads[] = {
 	/* Backlight On */
 	MX7D_PAD_SD1_WP__GPIO5_IO1 | MUX_PAD_CTRL(NO_PAD_CTRL),
 	/* Backlight PWM<A> (multiplexed pin) */
-	MX7D_PAD_GPIO1_IO08__GPIO1_IO8   | MUX_PAD_CTRL(NO_PAD_CTRL),
+	MX7D_PAD_GPIO1_IO08__PWM1_OUT   | MUX_PAD_CTRL(NO_PAD_CTRL),
 	MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21 | MUX_PAD_CTRL(NO_PAD_CTRL),
 };
 
@@ -123,6 +126,8 @@ static iomux_v3_cfg_t const backlight_pads[] = {
 
 static int setup_lcd(void)
 {
+	int ret = 0;
+
 	imx_iomux_v3_setup_multiple_pads(backlight_pads, ARRAY_SIZE(backlight_pads));
 
 	/* Set BL_ON */
@@ -130,10 +135,14 @@ static int setup_lcd(void)
 	gpio_direction_output(GPIO_BL_ON, 1);
 
 	/* Set PWM<A> to full brightness (assuming inversed polarity) */
-	gpio_request(GPIO_PWM_A, "PWM<A>");
-	gpio_direction_output(GPIO_PWM_A, 0);
-
-	return 0;
+	enable_pwm_clk(1, 0);
+	ret = pwm_init(0, 0, 0);
+	if (ret)
+		return ret;
+	ret = pwm_config(0, 0, 6666666);
+	if (ret)
+		return ret;
+	ret = pwm_enable(0);
 }
 #endif
 
@@ -142,12 +151,11 @@ static int setup_lcd(void)
  */
 void board_preboot_os(void)
 {
-#ifdef CONFIG_VIDEO
-	gpio_direction_output(GPIO_PWM_A, 1);
-	gpio_direction_output(GPIO_BL_ON, 0);
-#endif
+	if (IS_ENABLED(CONFIG_VIDEO) && IS_ENABLED(CONFIG_VIDEO_REMOVE)) {
+		gpio_direction_output(GPIO_PWM_A, 1);
+		gpio_direction_output(GPIO_BL_ON, 0);
+	}
 }
-
 static void setup_iomux_uart(void)
 {
 	imx_iomux_v3_setup_multiple_pads(uart1_pads, ARRAY_SIZE(uart1_pads));
@@ -277,6 +285,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 {
 #if defined(CONFIG_IMX_BOOTAUX) && defined(CONFIG_ARCH_FIXUP_FDT_MEMORY)
 	int up;
+	int ret = -1;
 
 	up = arch_auxiliary_core_check_up(0);
 	if (up) {
@@ -313,6 +322,17 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	}
 #endif
 
+	if (IS_ENABLED(CONFIG_FDT_SIMPLEFB))
+		ret = fdt_simplefb_enable_and_mem_rsv(blob);
+
+	/* If simplefb is not enabled and video is active, then at least reserve
+	 * the framebuffer region to preserve the splash screen while OS is booting
+	 */
+	if (IS_ENABLED(CONFIG_VIDEO) && IS_ENABLED(CONFIG_OF_LIBFDT)) {
+		if (ret && video_is_active())
+			return fdt_add_fb_mem_rsv(blob);
+	}
+
 	return ft_common_board_setup(blob, bd);
 }
 #endif

-- 
2.52.0

