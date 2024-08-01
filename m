Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1280C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 12:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E6C88ADF;
	Thu,  1 Aug 2024 14:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XYPs9AlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7BF2886F0; Thu,  1 Aug 2024 14:48:01 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A4E8880B
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 14:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-81fb80d3887so141669839f.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722516478; x=1723121278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYSByFWfC9+NQGFlrVo4XenT58lNxEGxbht2EoEg658=;
 b=XYPs9AlD66buZrqrDTCF1sdJlTwL89f8GzqCTWXOWvN7V6OhwNNUvaWMI4K9b3cswz
 E3OJBVRDLEgnodVFO8nvTKZJ8kyY+DIrj4YeQsvfaMo9kVuFXZEWh6/ZbFefyc/h9NtH
 v420jWqCM95/wS8j0FiUbnehsAfd+EsBRFDfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722516478; x=1723121278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYSByFWfC9+NQGFlrVo4XenT58lNxEGxbht2EoEg658=;
 b=tkSh4sOnBg2G2t3rIqZGq7NPK4SbCBnowjpDVWHMdq3XDSs93qHqNNeud6OdAVTC/C
 wgzkif0Z0h+gcDU9s8WeBqYPyLdaF00tBOpUuPuTxSVwNt3V5/SwkhVwuN+k6iyByrl0
 +Xa3dvIptnKt2HflLzolrugXgBM5h5FvaqkAI5ub1doNLxHKWsJH5pLT9w9O98cFqjn7
 tueu2JuWhsFqhY7Y1zNYlenezp3/Ae7dU3rNhrqJ30FRUr1FeKI8r5sZETV45y7C53Fw
 rsP9jB89fUs0xV74ZMK34qrxY13Pdne6RDT4lKyL9625vu5b5jSFF9z+JBTSDsrzx/kh
 bweQ==
X-Gm-Message-State: AOJu0YznLCT7J7d73wFSC/Vm7RxHBdK3q73UucMoDZgmWdG1o4MqZ+sX
 bhgspUkKleMhdzpSN4f8iO+rRMzcTnOC1ZdEsj5z5ZRGW6FFQ/6q4EXIL9evE6kFtigZ80e3mYk
 =
X-Google-Smtp-Source: AGHT+IGubmVOmlVV7bE0F8aLI+zc0+ZQeB3ZGto97PBC3fVgWXa/UQgrZvSQLcEUU8u9C2kn14EXYw==
X-Received: by 2002:a05:6e02:12eb:b0:397:2918:6f52 with SMTP id
 e9e14a558f8ab-39b1fc35b53mr303405ab.25.1722516477992; 
 Thu, 01 Aug 2024 05:47:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm48720935ab.50.2024.08.01.05.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 05:47:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v9 8/8] rockchip: Avoid #ifdefs in RK3399 SPL
Date: Thu,  1 Aug 2024 06:47:23 -0600
Message-Id: <20240801124723.770213-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801124723.770213-8-sjg@chromium.org>
References: <20240801124723.770213-8-sjg@chromium.org>
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

Changes in v9:
- Make sure that rockchip_sdram_size() is not used in TPL

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

 drivers/ram/rockchip/sdram_rk3399.c | 40 +++++++++++++++--------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 58f3745ffa5..45270e27184 100644
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
@@ -3021,12 +3029,13 @@ static int sdram_init(struct dram_info *dram,
 
 static int rk3399_dmc_of_to_plat(struct udevice *dev)
 {
-	struct rockchip_dmc_plat *plat = dev_get_plat(dev);
+	struct rockchip_dmc_plat *plat;
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(OF_REAL))
+	if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
 		return 0;
 
+	plat = dev_get_plat(dev);
 	ret = dev_read_u32_array(dev, "rockchip,sdram-params",
 				 (u32 *)&plat->sdram_params,
 				 sizeof(plat->sdram_params) / sizeof(u32));
@@ -3093,7 +3102,6 @@ static int rk3399_dmc_init(struct udevice *dev)
 	priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
 	priv->pmusgrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUSGRF);
 	priv->pmucru = rockchip_get_pmucru();
 	priv->cru = rockchip_get_cru();
@@ -3138,24 +3146,21 @@ static int rk3399_dmc_init(struct udevice *dev)
 
 	return 0;
 }
-#endif
 
 static int rk3399_dmc_probe(struct udevice *dev)
 {
 	struct dram_info *priv = dev_get_priv(dev);
 
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
-	if (rk3399_dmc_init(dev))
+	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
+	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
+	if (phase_sdram_init() && rk3399_dmc_init(dev))
 		return 0;
-#endif
+
 	/*
 	 * There is no point in checking the SDRAM size in TPL as it is not
 	 * used, so avoid the code size increment.
 	 */
 	if (!IS_ENABLED(CONFIG_TPL_BUILD)) {
-		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
 		priv->info.base = CFG_SYS_SDRAM_BASE;
 		priv->info.size = rockchip_sdram_size(
 			(phys_addr_t)&priv->pmugrf->os_reg2);
@@ -3187,10 +3192,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
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

