Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD94CD5E12A
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D15891FD;
	Fri,  8 Nov 2024 06:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043326;
	bh=lVG2bBYjaFPxWdmIUq2CHBzUW/YUiWZXz9+unnHmcj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zVpswTxE+GODRZr4ox6fxz2QXm/2gaIW5dpa/9dh9XD9b/LwJ5P3x4mgMSH4UaFYt
	 TGOu86jrxqh+LPShhHSXCjwXPNtpo9iaqGvr1Uy+TzwXuXPF/qCgpGDuDBFoK7ZN+V
	 vjMBFoDTq7jz+zVR1VKGDf7QdY5fK+nEcyelpH1VAqokSW0O2bIYkuMEi/cd0J648O
	 SgOxrWp0iimuNmnntKe92jlwkornq1XZflqIi/42SjTkKvtJLfDxzI9k3X6aauHd7H
	 4+fa/rY16slrJzuYgTx4P5HCWGtkDRVtxnocof4MLEeHliyhJOPhySHzIKwpfbHGky
	 qmwrIZWzZipIw==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 627CF88EBA;
 Fri,  8 Nov 2024 06:22:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043324;
 bh=lVG2bBYjaFPxWdmIUq2CHBzUW/YUiWZXz9+unnHmcj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QBGLN0FTmL7zMPTfWjourIkYb6dd9BDJSyF2v9dGoMY41e6PEePkkvNsQ5Oaasj2I
 k+vM1Io9Z3YDL61irld79DZutWizmBiD8ivfkSke50hheNzOLpblevtgQZeEaKL6O7
 wS/Qklu73BBd7YoyJZ82mDzpitkUQcaI7jheNU8DKusS4nqQAjbjF3WJzpFd1LbAWn
 rvyYEsAXlVsnz9CqNtd2roLU8HCLswgtWebLlk8EpO37dVHwL1U45T6saXVwakXFAj
 L8PXTVQiN4ImUjxhod9JZdyBnoIjofPipx5BNO7nPy8S0KCX1+7jJMpHMwvpTTRF99
 2OKZaMH6gzbMg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 14/22] siemens: capricorn: sync spl code with 8qxp-mek
Date: Fri,  8 Nov 2024 06:21:35 +0100
Message-Id: <20241108052143.26874-15-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

sync spl code with 8qxp-mek board.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 board/siemens/capricorn/spl.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/board/siemens/capricorn/spl.c b/board/siemens/capricorn/spl.c
index 696b5ebd340..7ee2895b6d4 100644
--- a/board/siemens/capricorn/spl.c
+++ b/board/siemens/capricorn/spl.c
@@ -15,12 +15,30 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 
+#include <firmware/imx/sci/sci.h>
+#include <asm/arch/imx8-pins.h>
+#include <asm/arch/iomux.h>
+#include <asm/gpio.h>
+#include <asm/arch/sys_proto.h>
+
 DECLARE_GLOBAL_DATA_PTR;
 
+#define GPIO_PAD_CTRL	((SC_PAD_CONFIG_NORMAL << PADRING_CONFIG_SHIFT) | \
+			(SC_PAD_ISO_OFF << PADRING_LPCONFIG_SHIFT) | \
+			(SC_PAD_28FDSOI_DSE_DV_HIGH << PADRING_DSE_SHIFT) | \
+			(SC_PAD_28FDSOI_PS_PU << PADRING_PULL_SHIFT))
+
+#define USDHC2_SD_PWR IMX_GPIO_NR(4, 19)
+static iomux_cfg_t usdhc2_sd_pwr[] = {
+	SC_P_USDHC1_RESET_B | MUX_PAD_CTRL(GPIO_PAD_CTRL),
+};
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
 
+	uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(imx8_scu), &dev);
+
 	uclass_find_first_device(UCLASS_MISC, &dev);
 
 	for (; dev; uclass_find_next_device(&dev)) {
@@ -34,8 +52,28 @@ void spl_board_init(void)
 
 	timer_init();
 
+	imx8_iomux_setup_multiple_pads(usdhc2_sd_pwr, ARRAY_SIZE(usdhc2_sd_pwr));
+	gpio_direction_output(USDHC2_SD_PWR, 0);
+
 	preloader_console_init();
+
+	puts("Normal Boot\n");
+}
+
+void spl_board_prepare_for_boot(void)
+{
+	imx8_power_off_pd_devices(NULL, 0);
+}
+
+#ifdef CONFIG_SPL_LOAD_FIT
+int board_fit_config_name_match(const char *name)
+{
+	/* Just empty function now - can't decide what to choose */
+	debug("%s: %s\n", __func__, name);
+
+	return 0;
 }
+#endif
 
 void board_init_f(ulong dummy)
 {
-- 
2.20.1

