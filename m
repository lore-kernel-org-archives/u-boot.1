Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7739DC2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E05885DF;
	Fri, 21 Jun 2024 01:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ilxVihdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B2C88590; Fri, 21 Jun 2024 01:06:53 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3FC8859F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7eb75c0d0a7so47049339f.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924810; x=1719529610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ju9PAOGjEluCOxzy16vw0egRYSER0uqH9roSyQ2V8fI=;
 b=ilxVihdAuedgvc5BTEzW10wt0TQXASiorAgtvPrCXBjw0WnesO7AfmscFAKz7F6N7T
 XrZN82JYIsrRdAH/BmknyljtxTux4z8nXQ9SaU5u8r+qzPsCz/oLwlin3sinDpNmpjoP
 GobjDaODvjNpPgWZv/FZFnbVfAINfSkx2AM/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924810; x=1719529610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ju9PAOGjEluCOxzy16vw0egRYSER0uqH9roSyQ2V8fI=;
 b=hPpMv8tPCsSL2agTrboWuimgz3JTgUyOsbeHJRFyqyjSQpN9GXcPaXesOim9GWPUoL
 34U2/9OyPgVOcLhgFX8lyv2OIWw8dFILnaN34mFheh7Yz4YwwN5DSe4VN10FBvlbi82y
 ALMfsIsG5U7OCFK7BEAh3MCvcpypyk/FMHY5Il/k+69fLRS6WXaNb0oNgotvTOKc3WNc
 UQCtdfXQJ1ligwnFAqYNx/JXS/oKXMkGTbjfsTpCAMXztuota7cyYd0Fur6nl5+ZrRY4
 5BLgTKarwhtFTXn8L+JdCWpzNabhcDuNrS93rFXWaAgS2KGRP8q/TlVBkm71UOb6XUTH
 QMWg==
X-Gm-Message-State: AOJu0Yy8iClcbVkZ1vRDBtTpRks+DP1N/GEEThRJbujd797CnM8TAm/A
 p6odYwgphUowITNKw4nJkSUqrdfipHFmU5XDhNZK22HNht/hJa3/6P9YAeKU+w6u/yDlViIIOVZ
 Dgw==
X-Google-Smtp-Source: AGHT+IFAV0mRybPRVTgRmnAM/ka9e/PS/1qOFMU82/xYKEvMu7Dpi7IBSgvJaQoQzJFhExMsFVQusw==
X-Received: by 2002:a05:6602:2c84:b0:7eb:49ed:441f with SMTP id
 ca18e2360f4ac-7f13eea3a27mr752483439f.20.1718924810287; 
 Thu, 20 Jun 2024 16:06:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 16/18] rockchip: Avoid #ifdefs in RK3399 SPL
Date: Thu, 20 Jun 2024 17:06:23 -0600
Message-Id: <20240620230625.1797397-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

The code here is confusing due to large blocks which are #ifdefed out.
Add a function phase_sdram_init() which returns whether SDRAM init
should happen in the current phase, using that as needed to control the
code flow.

This increases code size by about 500 bytes in SPL when the cache is on,
since it must call the rather large rockchip_sdram_size() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split out the refactoring into a separate patch
- Drop the non-dcache optimisation, since the cache should normally be on

 drivers/ram/rockchip/sdram_rk3399.c | 47 ++++++++++++++++-------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 3c4e20f4e80..2f37dd712e7 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <ram.h>
 #include <regmap.h>
+#include <spl.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru.h>
@@ -63,8 +64,6 @@ struct chan_info {
 };
 
 struct dram_info {
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	u32 pwrup_srefresh_exit[2];
 	struct chan_info chan[2];
 	struct clk ddr_clk;
@@ -75,7 +74,6 @@ struct dram_info {
 	struct rk3399_pmusgrf_regs *pmusgrf;
 	struct rk3399_ddr_cic_regs *cic;
 	const struct sdram_rk3399_ops *ops;
-#endif
 	struct ram_info info;
 	struct rk3399_pmugrf_regs *pmugrf;
 };
@@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
 					struct rk3399_sdram_params *params);
 };
 
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
-
 struct rockchip_dmc_plat {
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
 	struct dtd_rockchip_rk3399_dmc dtplat;
@@ -191,6 +186,17 @@ struct io_setting {
 	},
 };
 
+/**
+ * phase_sdram_init() - Check if this is the phase where SDRAM init happens
+ *
+ * Returns: true to do SDRAM init in this phase, false to not
+ */
+static bool phase_sdram_init(void)
+{
+	return spl_phase() == PHASE_TPL ||
+	    (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
+}
+
 static struct io_setting *
 lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
 {
@@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
 	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(OF_REAL))
+	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
 		return 0;
 
 	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
@@ -3138,22 +3144,24 @@ static int rk3399_dmc_init(struct udevice *dev)
 
 	return 0;
 }
-#endif
 
 static int rk3399_dmc_probe(struct udevice *dev)
 {
 	struct dram_info *priv = dev_get_priv(dev);
 
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
-	if (rk3399_dmc_init(dev))
-		return 0;
-#endif
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
-	priv->info.base = CFG_SYS_SDRAM_BASE;
-	priv->info.size =
-		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
+	if (phase_sdram_init()) {
+		if (rk3399_dmc_init(dev))
+			return 0;
+	} else {
+		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
+		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
+	}
+
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
+		priv->info.base = CFG_SYS_SDRAM_BASE;
+		priv->info.size =
+			rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
+	}
 
 	return 0;
 }
@@ -3181,10 +3189,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
 	.id = UCLASS_RAM,
 	.of_match = rk3399_dmc_ids,
 	.ops = &rk3399_dmc_ops,
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
 	.of_to_plat = rk3399_dmc_of_to_plat,
-#endif
 	.probe = rk3399_dmc_probe,
 	.priv_auto	= sizeof(struct dram_info),
 #if defined(CONFIG_TPL_BUILD) || \
-- 
2.34.1

