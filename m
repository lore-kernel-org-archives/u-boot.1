Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3302DC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 09:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD5087E31;
	Thu,  8 Feb 2024 10:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sO3XPGS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE8087E0F; Thu,  8 Feb 2024 10:34:05 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B47EF87DC6
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d0a4e1789cso16763691fa.3
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 01:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707384836; x=1707989636; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wDrZO+1GlFUvKMXUInHHZFBu7m52lO77m+eshykpv8E=;
 b=sO3XPGS6tGYL3kbBWUnJYTnDWHbmVbzNDXtUQyLR1gCKBqUwYWcbAYBwwfXtRPpaIs
 KoxDvDxfRzWjuu79KLMbtOe3RANRgFFLg9/UbmgsHtxE3TqgAvpAPgCyZQP/o3LIwNV4
 Gr59qRqXuQBMS+xefxZQjaeuZLIuWH5gs9lwl65aqdU9xRfw6Dzc6W9QVDMHqmGTsfmT
 L9A3ghoZgHYE1pAoR/41tUzWAjDPFYTwvd7OpBper/v0gCdkxALxHyMqader1pwUJu+W
 r5iFVziYj+MZXK5bSvGwSXpUZjDvI1n4IBxW/cqdJxa/DLP6Rl882UKhDc9M4uVKvJGL
 oXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707384836; x=1707989636;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wDrZO+1GlFUvKMXUInHHZFBu7m52lO77m+eshykpv8E=;
 b=uozY0wnVRZ4kVjrmMl9paOW5BaHcC405t7COiQkwSjz+w05B3LW761aTH3Dp741viT
 4swNKn6Mdl7TNQDaOM01CNIjrjYuCPEohsr0a7E3RUFE7oCkqY2LjI83sIGQW6ejdjUw
 GgdB4jnTMi2aFIrhRmpDaNYs77yIWQLaPkvZKdjMxldkHDCIZdd5fxM6Z6fAOydkqt0b
 ctaaGa0f0AkmBuRY9Tlyadw7xjxW48/qsAAHyp2zQWNPz7OIk1OISHh6UUX7GUv5MMog
 fJwMkapKP87OyfWlzw4lgg/KpPiLV5mOe5O+HbrCcdnEm9jXo9OfjhKhBGWphvy3WAr5
 bq1A==
X-Gm-Message-State: AOJu0Yz/ACK/AJIZnjaIgt+VRQP7MrhyDq9uKQcFWxLKwDTceYewjA/6
 V9IzvWDVJKhjeL4TWrjzj8Euvao2g712oYK9jYOMd0QX294ITcq5etkKbkAulX0=
X-Google-Smtp-Source: AGHT+IGHKmxtUiuCJDyON+q0PHg/z38OnRxcOaCiqe8F/H2v2UUc6gfuqLyyPRB35GeuumBfO3NEgg==
X-Received: by 2002:a2e:8ed8:0:b0:2d0:b663:f052 with SMTP id
 e24-20020a2e8ed8000000b002d0b663f052mr6031435ljl.6.1707384835946; 
 Thu, 08 Feb 2024 01:33:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWrVkAdTl8SL3IlPxmpbyXF73FgCfrOoYrN0eE1J/dnEAe1igvwW27u2IBi4E0fYqpx5gvT77F1unPI5Se6FFjmTj+Bfy5DwMg1Odg0NBkIxRFegB9yOUfdB9kHY23xxHNxZU6NVRVH54xL+4R8eYSR2sJVL7ez2SrYMqtnrrXpmjvh9Y5GoQbvb3EN6ypbRT5DWH/Pguqu5ksCKikftoW5qN9Zhduny03gH3BFs7qA0pfUKTunFcuIZgYw
Received: from [127.0.1.1] ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 y14-20020a2e320e000000b002d0c8fa072asm418294ljy.20.2024.02.08.01.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 01:33:54 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 08 Feb 2024 10:33:43 +0100
Subject: [PATCH] mmc: arm_pl180_mmci: Rely on DM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-uboot-vexpress-ca9-v1-1-ad7bc1f2f433@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPafxGUC/x2MywqAIBAAfyX23IJa2ONXokPmWnvJcCuC6N+Tj
 sMw84BQYhLoiwcSXSwctwy6LGBep20hZJ8ZjDK1MqrF08V44EX3nkgE56lDbRrnrdO28gFymE3
 g+58O4/t+st0ikmQAAAA=
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>, 
 Ole Orhagen <ole.orhagen@northern.tech>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
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

The PL180/MMCI driver is implied to use CONFIG_DM and the ARM
defconfigs such as configs/vexpress_ca9x4_defconfig will get it
as well.

With a simple oneline to default to not being the v2 variant,
the original ARM MMCI variant works fine with the driver as well.
The IP version actually needs to be read out from a register on
the ARM versions, but we will simply assume we are running on the
original hardware if arm,primecell-periphid is not explicitly
specified in the device tree.

Drop the !CONFIG_DM code and depend on DM_MMC.

Tested on the Versatile Express CA9x4 board.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/Kconfig          |  1 +
 drivers/mmc/arm_pl180_mmci.c | 66 ++------------------------------------------
 2 files changed, 3 insertions(+), 64 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 17618c3bdcc1..59716c3966e5 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -79,6 +79,7 @@ config MMC_SPI_CRC_ON
 
 config ARM_PL180_MMCI
 	bool "ARM AMBA Multimedia Card Interface and compatible support"
+	depends on DM_MMC
 	help
 	  This selects the ARM(R) AMBA(R) PrimeCell Multimedia Card
 	  Interface (PL180, PL181 and compatible) support.
diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 5cf5502ed545..2666b65362bc 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -18,6 +18,7 @@
 #include <malloc.h>
 #include <mmc.h>
 #include <dm/device_compat.h>
+#include <dm.h>
 
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
@@ -25,8 +26,6 @@
 #include "arm_pl180_mmci.h"
 #include <linux/delay.h>
 
-#ifdef CONFIG_DM_MMC
-#include <dm.h>
 #define MMC_CLOCK_MAX	48000000
 #define MMC_CLOCK_MIN	400000
 
@@ -34,7 +33,6 @@ struct arm_pl180_mmc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
-#endif
 
 static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
 {
@@ -358,65 +356,6 @@ static int  host_set_ios(struct mmc *dev)
 	return 0;
 }
 
-#ifndef CONFIG_DM_MMC
-/* MMC uses open drain drivers in the enumeration phase */
-static int mmc_host_reset(struct mmc *dev)
-{
-	struct pl180_mmc_host *host = dev->priv;
-
-	writel(host->pwr_init, &host->base->power);
-
-	return 0;
-}
-
-static const struct mmc_ops arm_pl180_mmci_ops = {
-	.send_cmd = host_request,
-	.set_ios = host_set_ios,
-	.init = mmc_host_reset,
-};
-
-/*
- * mmc_host_init - initialize the mmc controller.
- * Set initial clock and power for mmc slot.
- * Initialize mmc struct and register with mmc framework.
- */
-
-int arm_pl180_mmci_init(struct pl180_mmc_host *host, struct mmc **mmc)
-{
-	u32 sdi_u32;
-
-	writel(host->pwr_init, &host->base->power);
-	writel(host->clkdiv_init, &host->base->clock);
-	udelay(CLK_CHANGE_DELAY);
-
-	/* Disable mmc interrupts */
-	sdi_u32 = readl(&host->base->mask0) & ~SDI_MASK0_MASK;
-	writel(sdi_u32, &host->base->mask0);
-
-	host->cfg.name = host->name;
-	host->cfg.ops = &arm_pl180_mmci_ops;
-
-	/* TODO remove the duplicates */
-	host->cfg.host_caps = host->caps;
-	host->cfg.voltages = host->voltages;
-	host->cfg.f_min = host->clock_min;
-	host->cfg.f_max = host->clock_max;
-	if (host->b_max != 0)
-		host->cfg.b_max = host->b_max;
-	else
-		host->cfg.b_max = CONFIG_SYS_MMC_MAX_BLK_COUNT;
-
-	*mmc = mmc_create(&host->cfg, host);
-	if (!*mmc)
-		return -1;
-	debug("registered mmc interface number is:%d\n",
-	      (*mmc)->block_dev.devnum);
-
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_DM_MMC
 static void arm_pl180_mmc_init(struct pl180_mmc_host *host)
 {
 	u32 sdi_u32;
@@ -477,7 +416,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 		host->version2 = true;
 		break;
 	default:
-		host->version2 = true;
+		host->version2 = false; /* ARM variant */
 	}
 
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
@@ -561,4 +500,3 @@ U_BOOT_DRIVER(arm_pl180_mmc) = {
 	.priv_auto	= sizeof(struct pl180_mmc_host),
 	.plat_auto	= sizeof(struct arm_pl180_mmc_plat),
 };
-#endif

---
base-commit: 0101a2ffe125911ebf89172b495f5ff14f2fd058
change-id: 20240208-uboot-vexpress-ca9-127bd6b163df

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

