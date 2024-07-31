Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6EBC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 21:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A2778800C;
	Wed, 31 Jul 2024 23:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jBxkQtze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB688692C; Wed, 31 Jul 2024 23:58:42 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1B788A23
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 23:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39834949e42so30911355ab.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722463118; x=1723067918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CQz1f0HI8eXKmfX+m4WqyPuhe0F8a+WNYxplsPecbqU=;
 b=jBxkQtze7TdyC7aSxFzBKLkAQjRXeD+YnTRtGdkrMb0Mp8oRro/4niQicZCPceogDU
 FrI7tidNb7sGNjWx2nAnE6cPaIjwbg0u58lq386Rbrc8Lc0IhxSJk2qAI+WqAmCc5Crg
 02TAIQ0q6HXkEgXAwX4N1eOiuiMh/1BSkKi9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722463118; x=1723067918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQz1f0HI8eXKmfX+m4WqyPuhe0F8a+WNYxplsPecbqU=;
 b=LF6yXz1HSo6Ib3Ot9+8ySJpX2WYcA265VGJ7l2t2ldyR4PYsGfYIrJGE6FUy2kyjV3
 YnxagUzE6z8xQlhXpl/YuydKMoB+dnUbUkxFCcIXym9peaX8x8gCmXWSSfbR0aWQLwv5
 +nLpkBrr8/D7Gu5BsmHwzG6yFOeNzh5uisqMrhrXLp/VryLKFUFVMXpwtf6N0KwglHtC
 dxNMtfql2x6/e8ISZOYGKMYnZDnmHa0vMsvCn1kepDzr8sTgttkmy6aUZhc2+VvmDwwB
 h3CeEVVsosxJyu537ydJRFTVey9CEPvu5vBvlQR/OxbMoLW/EN2cf1TGDsR5Kytr8EwO
 HOEg==
X-Gm-Message-State: AOJu0YweuYI5M8Gaa9VHk6sIvFfWvQyypE2ukFzkz29QpCE+EDnLpm7V
 obKXKyUlhyTwC30gs2esUkU/RDqxWYaRlPdcktx2U+F38h1mYmB8+NoEDELDI+0EwlVtkcXbkhk
 =
X-Google-Smtp-Source: AGHT+IHcWDlHZp8VMTTMy017Gx4zbt6odzbcFSbLrNgC4sk20qq4gC6JB6eWL32dNWzIHu2GsSARtg==
X-Received: by 2002:a05:6e02:1fc8:b0:38b:3c81:17f4 with SMTP id
 e9e14a558f8ab-39b183a1e72mr7504565ab.23.1722463118312; 
 Wed, 31 Jul 2024 14:58:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b17c2009fsm1759725ab.1.2024.07.31.14.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 14:58:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v8 8/8] rockchip: Avoid #ifdefs in RK3399 SPL
Date: Wed, 31 Jul 2024 15:58:32 -0600
Message-Id: <20240731215832.2266189-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Changes in v8:
- Include ROCKCHIP_EXTERNAL_TPL in the condition
- Put the non-dcache change back into patch 5

Changes in v5:
- Move setting of pmugrf into the probe() function
- Drop the non-dcache optimisation, since the cache should normally be on
- Drop patches previously applied

Changes in v4:
- Fix 'stating' typo
- Move Binman size feature to a separate series

Changes in v3:
- Split out the refactoring into a separate patch

Changes in v2:
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

 drivers/ram/rockchip/sdram_rk3399.c | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index bc79c034808..611e30cbe52 100644
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
@@ -191,6 +186,19 @@ struct io_setting {
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
+		(!IS_ENABLED(CONFIG_TPL) &&
+		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
+		 !spl_in_proper());
+}
+
 static struct io_setting *
 lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
 {
@@ -3024,7 +3032,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
 	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(OF_REAL))
+	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
 		return 0;
 
 	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
@@ -3093,7 +3101,6 @@ static int rk3399_dmc_init(struct udevice *dev)
 	priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
 	priv->pmusgrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUSGRF);
 	priv->pmucru = rockchip_get_pmucru();
 	priv->cru = rockchip_get_cru();
@@ -3138,19 +3145,16 @@ static int rk3399_dmc_init(struct udevice *dev)
 
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
 	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
 	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
+	if (phase_sdram_init() && rk3399_dmc_init(dev))
+		return 0;
+
 	priv->info.base = CFG_SYS_SDRAM_BASE;
 	priv->info.size =
 		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
@@ -3181,10 +3185,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
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

