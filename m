Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDE5D5E393
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 191EC8942F;
	Mon, 18 Nov 2024 07:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911257;
	bh=cyK+ZlDmL1bM5x4ww+VOQrzCA+PP8JQXKazm5dMdGSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DEioM3JZekpw3jbeCUvvKqbLoYMTPvaiGYjYZhDJ6C8BAHPXnFWH9C1hfugvXffmM
	 VEdj/tTx8/I2RyqqA0dhXOot0DNkUyg6K0kEha9N1E9b96pS8IVmFt97edKF+VqjXe
	 zqbL9Wq5JrSrC2ogkoI/PW5cPgK7vs5ELPAv40p4AJZQSPZnMVdc3UDBlJxVQ1/6ki
	 X4nycgJEY4XvT5p8wlqvg7evRWkm5YyEIl2v7pNR9/DpG8ht/66wLHWiPk7onT6L4U
	 sjiEh8htb5sYgc9yBKJ7YoBwbMugVuNCEF9pJH6H3uSbkibI4XIDDlhkgiblpXbgLB
	 Cxf3flTlqGUKA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5485689443;
 Mon, 18 Nov 2024 07:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911254;
 bh=cyK+ZlDmL1bM5x4ww+VOQrzCA+PP8JQXKazm5dMdGSU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=loCTqWsmX7yzYX9lRjSkAOq0i6qxpaKqyrT+CbRIpGCTRKXyjm+5p/YvKXjvcLO3T
 S1LMtoOu9YaWobexkrP0YbpXvIN9YGbjvHAdghEQWcd1NxNfl//Ww50Q8Q6o1proUb
 IGpPjoY5gVUz+J/kmobp7wcozdDNnsua46AGJgbUvPyW1LBXyQXZnZfmdHvcTM6mk5
 LTWKiSB3RzlKhhrokmx6FU+xif0rbQUZUNDvQHxV9PDa1Ch4se6TMv/OEBbQhC1zSK
 JGxxQrpQiUGE19MHyHgyhp1x3BoCB02rsFkqoWK1dpgJIKZ0wFZmHy/hqH1leVKdfQ
 C48VkIEX9PiPQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/20] siemens: capricorn: sync spl code with 8qxp-mek
Date: Mon, 18 Nov 2024 07:27:06 +0100
Message-Id: <20241118062715.32989-13-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

(no changes since v1)

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

