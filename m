Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377DCD44C48
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 13:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BD183966;
	Thu, 15 Jan 2026 14:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YxWaCDHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE8B380077; Thu, 15 Jan 2026 14:53:29 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C827E838BB
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CCB3BC1F1EB;
 Thu, 15 Jan 2026 13:53:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 89D5B606B6;
 Thu, 15 Jan 2026 13:53:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0519310B6851D; Thu, 15 Jan 2026 14:53:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768485206; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dKpYVjWoQ+X39TwcP7X6rUXOTD/jYKUXm4jzrie6YRg=;
 b=YxWaCDHTtcc2XJaoaqdY7WLQt3vJp0YhOi0derreMeWh8dAk7lwzl6j6IcWjtL/cpQd44t
 OWjAQvQCscJeT6V3df8zGSHE3HwT0hKC31+PnIF5qchv4tBQoh3FTyhBgAnEQZXBSnhLpK
 +2mMljPiywLixDQDbV7Ou4REPjoyR7srEvYArCB9biN9mjOSJiqjyGifgBVlYoUGAWbkS5
 NuO1HAmYUCMhONC8qDpTZl2CWHi6r9BSWaNWLhb+TmeHgrORdRkZ3Whx3utAFll/tAXJuE
 fdokXnHdpc8D84x45SAs1CS2Ept4K06PKatMmyp/HTVhPhTd5AXUQAt7WBkHuA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 15 Jan 2026 14:52:48 +0100
Subject: [PATCH v2 5/5] board: toradex: add splash screen to Toradex i.MX7D
 Colibri board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-repair_imx7_splash-v2-5-6595491341ba@bootlin.com>
References: <20260115-repair_imx7_splash-v2-0-6595491341ba@bootlin.com>
In-Reply-To: <20260115-repair_imx7_splash-v2-0-6595491341ba@bootlin.com>
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

Fixes the PWM<A> that was previously used as a GPIO output instead of a
real PWM, it also reserve the framebuffer region to preserve the splash
screen while the OS is booting.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/colibri_imx7/colibri_imx7.c | 41 +++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index 69a8a18d3a7..55480213c67 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <dm.h>
 #include <dm/platform_data/serial_mxc.h>
+#include <fdt_simplefb.h>
 #include <fdt_support.h>
 #include <fsl_esdhc_imx.h>
 #include <jffs2/load_kernel.h>
@@ -29,8 +30,10 @@
 #include <netdev.h>
 #include <power/pmic.h>
 #include <power/rn5t567_pmic.h>
+#include <pwm.h>
 #include <usb.h>
 #include <usb/ehci-ci.h>
+#include <video.h>
 #include "../common/tdx-common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
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
@@ -130,10 +135,15 @@ static int setup_lcd(void)
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
+	return ret;
 }
 #endif
 
@@ -142,12 +152,11 @@ static int setup_lcd(void)
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
@@ -277,6 +286,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 {
 #if defined(CONFIG_IMX_BOOTAUX) && defined(CONFIG_ARCH_FIXUP_FDT_MEMORY)
 	int up;
+	int ret = -1;
 
 	up = arch_auxiliary_core_check_up(0);
 	if (up) {
@@ -313,6 +323,17 @@ int ft_board_setup(void *blob, struct bd_info *bd)
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

