Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52373C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0060885F0;
	Mon, 10 Jun 2024 16:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WJybajMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01769885D0; Mon, 10 Jun 2024 16:59:49 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87BC885D1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-375add02849so1768315ab.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031585; x=1718636385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWP206uw655HFYSiKuwnHSBsZQU7d8GW68CvyQMlElk=;
 b=WJybajMzQh7EbhXegD/D9MTmaHJgh/s/LKvL+k698JkUbmuGt9rG6BlvWd7xa/xAZE
 fqNg0oAHwfnqxTgQ+EYJVvP5ZxsxBhQ559Oe2ChNSgkQthgQICeBoZUTXym3mHoJDVWC
 XGOx2/gOd6zlwNnkd/Uhv6/MVSoyYA+OIxZhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031585; x=1718636385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWP206uw655HFYSiKuwnHSBsZQU7d8GW68CvyQMlElk=;
 b=JBYzdv/fzEi6TNfTe447FTDZMWsg8XJJZ+ovw74hBAXXo5VDgTG6FaLrkcLPQ2UBSq
 B58FcRab8W6qAQwUiZIvdXl31h9RdAk7ml9EDi3kAU6Rc9YItQtk8KN2xDs7784y5W5A
 vvYIFR2OtFQYfANXfhwqGetZYyBXJnRPwVsEqHDljAFXDc4fE2NE2/oCignu9XXC0p7R
 /EI1iLixeS00qR8nwW6U90BeGj5ImsGCNH0KAuPqplUAdS31neconx+dT532zCK+vF/4
 wnbJMEM0Bonc/yRwCdQSFITB19HR+cjUtlzr8coCQO3BS0io3fRNkGSe4lA0ECkPeZEQ
 85ww==
X-Gm-Message-State: AOJu0YzddsnKqWj1g+oggqcKZeX+9xXiTDUFScrqJGYsP7uN5kGDoBz+
 tMAplNK1ypXL9EMKQfXfuyTGm1Wt6WLdf/Vul1y0fBi6sP8/EfM9VNOi7Gl8lSgY1t73i8E3Dkw
 wVw==
X-Google-Smtp-Source: AGHT+IHSOWVuQVLrA0TUTVLKgJQ+OiFVm6fO3EDD5zsHxRLBdWHcjkcMX75jInX0K5aB4R5uAxM1DQ==
X-Received: by 2002:a05:6e02:b2a:b0:374:aea8:c9aa with SMTP id
 e9e14a558f8ab-375803c4e45mr102248325ab.31.1718031585276; 
 Mon, 10 Jun 2024 07:59:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v2 7/9] rockchip: Ensure memory size is available in RK3399 SPL
Date: Mon, 10 Jun 2024 08:59:18 -0600
Message-Id: <20240610145920.3302001-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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

At present gd->ram_size is 0 in SPL, meaning that it is not possible to
enable the cache. Correct this by always populating the RAM size
correctly.

Part of the confusion here comes from the large blocks of code which
are #ifdefed out. Add a function phase_sdram_init() which returns
whether SDRAM init should happen in the current phase, using that as
needed to control the code flow.

This increases code size by about 500 bytes in SPL when the cache is on,
since it must call the rather large rockchip_sdram_size() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to correct memory size in SPL

 drivers/ram/rockchip/sdram_rk3399.c | 49 ++++++++++++++++-------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 02cc4a38cf0..2f37dd712e7 100644
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
@@ -3138,23 +3144,25 @@ static int rk3399_dmc_init(struct udevice *dev)
 
 	return 0;
 }
-#endif
 
 static int rk3399_dmc_probe(struct udevice *dev)
 {
-#if defined(CONFIG_TPL_BUILD) || \
-	(!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
-	if (rk3399_dmc_init(dev))
-		return 0;
-#else
 	struct dram_info *priv = dev_get_priv(dev);
 
-	priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-	debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
-	priv->info.base = CFG_SYS_SDRAM_BASE;
-	priv->info.size =
-		rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
-#endif
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
+
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

