Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD292C004C0
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 21:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF374871A0;
	Thu, 19 Oct 2023 23:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="al7QCzjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F47087184; Thu, 19 Oct 2023 23:51:30 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E993986F6F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 23:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d27026dc2so51374a91.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697752286; x=1698357086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ilEeNlMI1BLEmBm6D1d+FvXJN6sZccNNbJzZ3aYcf2k=;
 b=al7QCzjRxKxvySCYyI9YYESfRoTxsXnBCL4pswf5eBXM3pEANYvfj5gOxDKfXXD8+d
 CmGbO2VfmWSdNIgo1EXaj4zmobpiO4zgNYHN74K0+Vs/1xrfn7LXtdEdT4CidleNNOwm
 Zz2pLA0HpBWONJHDjeWvVvv79VuwEOOs06T/yfT6sqtxxLJnBmwSN25jH63xKjllHj2z
 r118dh8+ODaax7oGUpQjNzOdghOX0xPfJs++eCuFsccOuE170CG4FPPBcrA/g7ebShzb
 mWEqKOAYfED4gA3Do2b2tGgdcra89fOBnq2qfvNdJscSdVZ1DPCwCuXk3LAPyjGLLq5k
 SgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697752286; x=1698357086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ilEeNlMI1BLEmBm6D1d+FvXJN6sZccNNbJzZ3aYcf2k=;
 b=wMsjpojao39ESDNT6PyduD1Cgv0dezz6/1eVHcLj+97p+YC2vY0AQ9qSHyhw0FjbQo
 7kM7bYXR/PIDaj9kmaPkywBs9EB4GIFtI17TZBoPb5c63Y8T7fd7vuu8ip+ZSnIVV4tA
 ZkoTHxCI4/JvVSRh1mwu6RAYI8O0+pE/JIgdPGN1oPOAtGc9Jn5zAbEnvEJ7lkAoy1eP
 fcbnp7FxP1QnNmc81C0z2FepAtfbGHYXmkEs1vFaEBPe/zzmKBFe5RKRCUsDn/Q173PQ
 2OFhubEmpXNgoFwdjKnBmwOSz6dIE9UBy1tAwQfQTDlkndGQfpk8iLdpvC7/wHAkag4+
 YUyA==
X-Gm-Message-State: AOJu0Yzdr/yjS/hg3f7MSqRpgPr716u9ea099VKX5FTe7+NIYxU5F3x2
 zvUV+0/LF3X8rrceeJbPm/8=
X-Google-Smtp-Source: AGHT+IH5u4PNmH0KBk8lXhQK5h4UtkYsri4gvNbivfLIMyEjEPIHgZfZ29JnM+Z9+VLqzLVtz9ytcA==
X-Received: by 2002:a05:6a20:2451:b0:171:737:df97 with SMTP id
 t17-20020a056a20245100b001710737df97mr59836pzc.2.1697752286196; 
 Thu, 19 Oct 2023 14:51:26 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ec8400b001bc6e6069a6sm177371plg.122.2023.10.19.14.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 14:51:25 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, hugo@hugovil.com,
 Fabio Estevam <festevam@denx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH v3 1/2] imx8mp_evk: Simplify Ethernet initialization
Date: Thu, 19 Oct 2023 18:51:12 -0300
Message-Id: <20231019215113.1833803-1-festevam@gmail.com>
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
Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Changes since v2:
- Only collected Hugo's tag.

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

