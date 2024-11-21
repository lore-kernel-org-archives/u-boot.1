Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172FBD75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E8E896A3;
	Thu, 21 Nov 2024 06:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166783;
	bh=cyK+ZlDmL1bM5x4ww+VOQrzCA+PP8JQXKazm5dMdGSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xDok6RXFydwwbtm3I/TRphSNU+Xq/RDs0Ek/BZ+C3LR71hporktNSU44/726NHD4M
	 h6dIjSXgZtA3aM/q6PoKC749a/bjKkdsbwW+JbTsPtLApxgP4zaLyyBzoxOKyWPx8I
	 KlDyXytpB42vjpqNSy4zof7qCyFa7cZVhRK/9F+gu++xd1lr6DIEUxxZDgeG1sz+ot
	 6Acy4BLhtJ2Qum3M6kZmoANzcgEU4yMJJCXGJUmiydX+McT/Qjvqwj7gRzyPMAu2L+
	 HT391ds8aTDo/q42QiS/rdcD5JaB/9nwaOD8USW0L9eMtE4fY3NNlGI7JJDatxkXGu
	 PvlaB+RW8obUw==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 479418966F;
 Thu, 21 Nov 2024 06:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166779;
 bh=cyK+ZlDmL1bM5x4ww+VOQrzCA+PP8JQXKazm5dMdGSU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aQIY/pRJfwoOlklGos4c42C+ZxWvu16GU7qLCAWiNxUGRA9XzdGwFCXXoEoau+47F
 Tb2IyaPjsvx1D3aUUGSJqIbNhqu0IqtB/GLb5KKOzNOTtowvhoWwsY+1bv5wIocBez
 3LXWXkpX+4iVTm/kmw4Cg3Q/oLsMqbAPfwbfa84m5MpJHUfNIF3daB0Jyge5EU2tWv
 +Hvs1C1A2SToDf99IsPSJW1+5zewZsPDKNb7jEODgq8QzKaAUdztgWhSXrDP2tjOAS
 ddeMZaS4ciHvWfJYSWtHIZLacX0v67ZQi1a4pnAE4q9PCymuRc39EmH/Pt/X8vqS+T
 7SlNAUtD4Kb1Q==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 12/20] siemens: capricorn: sync spl code with 8qxp-mek
Date: Thu, 21 Nov 2024 06:25:53 +0100
Message-Id: <20241121052601.72880-13-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

