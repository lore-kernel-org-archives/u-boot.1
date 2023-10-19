Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5003CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 19:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06D2B87476;
	Thu, 19 Oct 2023 21:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CurInxw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915F487455; Thu, 19 Oct 2023 21:22:17 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6EC87025
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 21:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1e9c28f8193so16855fac.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697743334; x=1698348134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sq41vJSPcMPWNeJ2r+d9shaRDPUzIG+Q7TBrpjpxfG8=;
 b=CurInxw4O0yk8zuly96aXrPtBCEZbf+BoFKFJoSKK+cUesE/s+zAT6+q1VF+RjX2Hm
 oWrmZ00CmVMKo+U1H+kTVjYBrYnrHA/j/Kl008T+R9yLIjzf8NWRwSQYWLZYOvdPGlLj
 DB5OwKjQViUJMlBR+l0JbBn0ku1fij1e5bClqFq3Nhzi3ti4I/rPzMxr3Ly9UHh7c9Il
 /ac90HeUjTL37+jRNoO90k3PW9EHOnjTBwDhvmEfbcjc1/DAmccY4woMo+mNAoI7xBlv
 uYjC06X3Ss+pQ6koAJ9ZgUqzSD2vgjikzyktOFbHWfSksDOVe8I3H4+O0yoR/Z6+6ga8
 DWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697743334; x=1698348134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sq41vJSPcMPWNeJ2r+d9shaRDPUzIG+Q7TBrpjpxfG8=;
 b=tunwybAPN1j1lCfixMnNHhpT5aIC75BpONwkwgBxkLycmzIrGieDDGlYvdK4+zxV64
 +QHAA0CL7nJ5PmB4tqgxF80W1yKSlcuFz2u0AParSVDM9z5oFDN8O1jqy30qVEEy3Gn3
 DRLBaq2vjLYhIG16ypby3PM+5loORh5oDkHUKl4zG+xFhd9vHKQlmDMfvNDnp2VjERr4
 gpbuOYOU/e6KZZG1yq6ykZUfyFsU+BxbdTf1B1D7b6yGJ0u/LutldoENZDZ9TZKvDi6J
 4nWnhopFO6CVaQv/QVJoucMaRa3kehlVq0Hn8eNGGulaa6nUI4ooLqHHZyM6R/3G8KqH
 OB0Q==
X-Gm-Message-State: AOJu0YxbrJ3eeDBxrvkxlqB5wXeSA4wVgHoP3rApAWwRAjSf5vrkBkon
 jNWjrPJWVtFvo1zxkWwe1Lk=
X-Google-Smtp-Source: AGHT+IFH2CvJghNmTIVhQ+Nzd2vUsM+WcCS6Ff6FCZWX4ewYT8DbA7tishlXDPVZudLfDj7GIJPMfg==
X-Received: by 2002:a05:6871:53cf:b0:1ea:7463:1b8f with SMTP id
 hz15-20020a05687153cf00b001ea74631b8fmr4204927oac.0.1697743333718; 
 Thu, 19 Oct 2023 12:22:13 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a63f10f000000b005af7ee01ab4sm121880pgi.6.2023.10.19.12.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 12:22:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, hugo@hugovil.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 1/2] imx8mp_evk: Simplify Ethernet initialization
Date: Thu, 19 Oct 2023 16:21:54 -0300
Message-Id: <20231019192155.1735199-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

With DM enabled, there is no need for board code to initialize
the Ethernet interfaces.

The RTL8211FDI Ethernet PHYs have 25MHz oscillator, so there is no
need to enable the RGMII TX clk output.

Also, there is no need for describing the deprecated phy-reset FEC
properties, nor passing reset properties to the EQOS interface in
u-boot.dtsi.

Remove all these unneeded pieces.

Tested both Ethernet interfaces after these changes.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Removed Ethernet related headers. (Hugo)
- Also removed custom eqos reset properties from u-boot.dtsi.

 arch/arm/dts/imx8mp-evk-u-boot.dtsi     | 14 -------------
 board/freescale/imx8mp_evk/imx8mp_evk.c | 28 +------------------------
 2 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 0bf489b46248..51c84383673c 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -137,17 +137,3 @@
 &wdog1 {
 	bootph-pre-ram;
 };
-
-&ethphy0 {
-	reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
-	reset-delay-us = <15000>;
-	reset-post-delay-us = <100000>;
-};
-
-&fec {
-	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <15>;
-	phy-reset-post-delay = <100>;
-};
-
-
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index a24b8c1d8608..42291c958e39 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -7,8 +7,6 @@
 #include <env.h>
 #include <errno.h>
 #include <init.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <linux/delay.h>
 #include <asm/global_data.h>
 #include <asm/mach-imx/iomux-v3.h>
@@ -20,33 +18,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static void setup_fec(void)
-{
-	struct iomuxc_gpr_base_regs *gpr =
-		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
-
-	/* Enable RGMII TX clk output */
-	setbits_le32(&gpr->gpr[1], BIT(22));
-}
-
-#if CONFIG_IS_ENABLED(NET)
-int board_phy_config(struct phy_device *phydev)
-{
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
-	int ret = 0;
-
-	if (IS_ENABLED(CONFIG_FEC_MXC)) {
-		setup_fec();
-	}
-
-	return ret;
+	return 0;
 }
 
 int board_late_init(void)
-- 
2.34.1

