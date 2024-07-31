Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E21C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F0888AB1;
	Wed, 31 Jul 2024 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e0JWoQph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8DF88AA7; Wed, 31 Jul 2024 16:49:22 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9540288AB1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39adbfafde5so19380255ab.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437358; x=1723042158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4E2c10BvuSfMbhKBhbZ3K9HOwbuo9EqCE0pZ12xpneU=;
 b=e0JWoQphjSDifJ7c/p0xcFvjpxy8mF57tua+wQz6kCz2jbr+7lDYghtl+/GA0G7CiE
 hF4B3mUFWVrdB1KkWvai3KOBpWWw+kv4rbCdLswxwQLtTYaJGCi7SfutTMFDN0qD1WkR
 w6cqFPXa7Tz6gQOVU9npechvtcAn1VXj1RFUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437358; x=1723042158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4E2c10BvuSfMbhKBhbZ3K9HOwbuo9EqCE0pZ12xpneU=;
 b=kzz4a9s3JrThP7oj/zF4/wq6mkfXuxQga32GaxrM4HdcuMru7qyZOlMnaCxLyU05fs
 B5Y1H/KmzRXSRav6QkOsz6+VvroFlbCyNG2weWKN7d/NcGn2g1tU7puAom4fHi8JueX5
 VAACYSQ54GunVt3hlqtshxj4aPezOs9/PUVg3qkDm5fX1xlC85TNul8bNhfIfHhSearL
 7xCbZJqVjMEbF4STcbFUQ/cC2MCGdbptHwbBOc49MgCiAD6HgYuYFNAQ3ijynazzoJOa
 RifwVTwBbIas+owh8eznLIvpKwyV68Q2yj0cH+o04Cm1CvKOjaYPWbLfKnANOKj7rI6O
 lIwg==
X-Gm-Message-State: AOJu0Yy54zRHfpNMQgaw0isGL5NMevQq6mzYkcZBwIRpcZ7Mx6KX5+Ex
 i5BWv1Ob3O08OSM+OoNkBkyDS9wjkdX6zlfKS1B4DNvi+LurcgjT9XiSH97vhrN8xVUs/FtEe2I
 =
X-Google-Smtp-Source: AGHT+IEFhuetyJADmaoaRuA3uPpApD6yXl/ElQVuy84Z92E2534R5Yp20M81KQmXQR/rcutdnJn5Tw==
X-Received: by 2002:a92:c56e:0:b0:375:9ff9:7cf4 with SMTP id
 e9e14a558f8ab-39aec25e985mr156102695ab.4.1722437358238; 
 Wed, 31 Jul 2024 07:49:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v7 8/8] rockchip: Avoid #ifdefs in RK3399 SPL
Date: Wed, 31 Jul 2024 08:49:07 -0600
Message-Id: <20240731144908.795290-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
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

- Drop the non-dcache optimisation, since the cache should normally be on

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Move setting of pmugrf into the probe() function
- Drop patches previously applied

Changes in v4:
- Fix 'stating' typo
- Move Binman size feature to a separate series

Changes in v3:
- Split out the refactoring into a separate patch

Changes in v2:
- Drop patch "regulator: rk8xx: Fix incorrect parameter"
- Rewrite boneblack patch to onstead drop the target and update docs

 drivers/ram/rockchip/sdram_rk3399.c | 33 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index bc79c034808..8a7cbb1849f 100644
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
@@ -3093,7 +3099,6 @@ static int rk3399_dmc_init(struct udevice *dev)
 	priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
 	priv->pmusgrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUSGRF);
 	priv->pmucru = rockchip_get_pmucru();
 	priv->cru = rockchip_get_cru();
@@ -3138,19 +3143,16 @@ static int rk3399_dmc_init(struct udevice *dev)
 
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
@@ -3181,10 +3183,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
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

