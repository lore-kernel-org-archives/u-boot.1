Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48A5C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD19288551;
	Sun, 23 Jun 2024 19:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GDQqEixz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408C58837A; Sun, 23 Jun 2024 19:53:33 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3F08855F
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eeea388a8eso143693839f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165209; x=1719770009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+p8Pdbfu6l722uGlnhM73JYEXoNC156QEoeBM2oBKw=;
 b=GDQqEixzgnGTa6OQxQnAM6mK46DC94eDUQ+nZgFJgkyfLPu7fHa+iTYYpU9QGMlkXn
 bEyOJsGianaG7ux3+lIVIuZ+vYiuzKRMnQ0somkyVa6hPdOkxg0ObBQ1ne9+3ZV/dazM
 7eCi8GAjLUYZ0MhY3cBGs0Z7v4MkWK/LPuxxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165209; x=1719770009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+p8Pdbfu6l722uGlnhM73JYEXoNC156QEoeBM2oBKw=;
 b=ZmPRJYn0uDKpMW9ib5iabIMT8fZy9P7WzfI4pbiCV2cEtJfd2U5G4vzcePWCUONpcy
 rWeFSNnnP/ynE+qzECL+5qcjuBVkZ3noEjt+KReR4fDJhAppWpmmAi92FPy5+9XhsYKZ
 yHZmterKOYqDM8Jl4cvCoYeJJL1IYxNVE4K8BZCa/fFFb+6WrtCueBbkaTNKBnuMmizZ
 qXXf51YJMqNwU7DcgSrUUtQsaQ2/C8WZVTHFuruUd+qvliBxy4HqpAfXzvL4FKQy/+BD
 fIuqgtnobSdn00tIuI2DSN2K4OZ6iugStmW/8bQ0n9nFf9Kp/U+yEaSHjHYgZDgh3ypW
 2LRQ==
X-Gm-Message-State: AOJu0YxVG1ST/Tm9bZJXzY5VzJgQuHUoouY9k1by/oUKkCWIm7jF1ISb
 31v0Iu7smc2glcI8TvFz80nV9+LLcXZDj8pdFnXUHCE5rHLq0Dw5RseE+UiAQeFiLefex/GFT/m
 3Aw==
X-Google-Smtp-Source: AGHT+IFPPyq8Fwhmd2mUHls/glX6vdBsEub/QkOq1fi+3FiVKp4wOHFB+QfZhGnOFknVcYEGuSYZBA==
X-Received: by 2002:a05:6602:60c1:b0:7e1:af90:44ee with SMTP id
 ca18e2360f4ac-7f3a7481f22mr239954839f.8.1719165209654; 
 Sun, 23 Jun 2024 10:53:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
Date: Sun, 23 Jun 2024 11:53:00 -0600
Message-Id: <20240623175302.1463973-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

Changes in v4:
- Drop the non-dcache optimisation, since the cache should normally be on

Changes in v3:
- Split out the refactoring into a separate patch

 drivers/ram/rockchip/sdram_rk3399.c | 42 +++++++++++++++--------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 3c4e20f4e80..949a082d00c 100644
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
@@ -3138,22 +3144,21 @@ static int rk3399_dmc_init(struct udevice *dev)
 
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
+	if (phase_sdram_init()) {
+		if (rk3399_dmc_init(dev))
+			return 0;
+	} else {
+		priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
+		debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
+	}
+
 	priv->info.base = CFG_SYS_SDRAM_BASE;
-	priv->info.size =
-		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
+	priv->info.size = rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
 
 	return 0;
 }
@@ -3181,10 +3186,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
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

