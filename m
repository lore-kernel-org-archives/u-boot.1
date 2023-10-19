Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2EDCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 17:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7819D87450;
	Thu, 19 Oct 2023 19:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eKB+mR0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E3887476; Thu, 19 Oct 2023 19:04:56 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4B287445
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 19:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6bcbfecf314so1177637b3a.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697735093; x=1698339893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jhmh7TZge5elXp4V3HlMA/rv2Mnz2omQ3IRiYK7H+BI=;
 b=eKB+mR0RWZUc1hhO6rs+BWzv/uJWRATdW8j2O6p0KPJeBkm8mDCtGg2oHV2Fc5QM0Q
 00A4P9gq/m6Jyf4il7DMiTlucognybPO+RDyzUeC0CBOUdYcapbWxlxQQo3/KWyFhZsb
 bgPl1YQ8up42fVK8qWfq2yNMxXnG/8Q5u4UJLMhA/GNT6T4byGE7p7bavnbxBxaYAW7V
 vScpRYqteA4+3Z6XGa8igZ7z6W+Z+Cv3G7x8aqnN9tV2TBhvBPPyVmvN7AkhT9tu+KM8
 W7Mgldz9C30NMah7eJlruI9qilanGST4KPD9DmxTuQ/b+QqXvVWqP7/FdJ7g/Nj1OhKz
 uq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697735093; x=1698339893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jhmh7TZge5elXp4V3HlMA/rv2Mnz2omQ3IRiYK7H+BI=;
 b=jGnoiEhQSDMIv6OSrtu44e0Z9Stao6ZzABN2C0u+Yq4U6fCVfvPLIpdxewI50HGi75
 BMVBscYHYWXyIRDYS+yJFEyyE+/lM+jo6WLVwVCfqGKZtDT5y+XaJrSqnQcjFMpoBstW
 XPST48wXsw01CthgOAeV1bVD3y6YBK1g0m0svYh2coQLiy9JtDPWN6dj41vm842NyfDh
 t3i99NytQxStkKgwIN+bBGtiwfFF6Ma5CIUBVsgR94zPsJu1rgAS6sVNeFT1h4MJhozg
 h8R1qRPM/H4Jh2DjvcJK1vcxSFlY8895xaxwTkZvBFEz0pD739Xsywm501maPmoje+MH
 Ecfg==
X-Gm-Message-State: AOJu0Yzsv1h/rxZuSxPaxSWkotYO6cYDuqKaGVZGj0kZOR/tiqzISg8+
 IZHdrOVFgruId5yPWsvnSYw=
X-Google-Smtp-Source: AGHT+IG4qaqQ82vrqUXeHFPFVlZwLdPe1qbUyWrqNfn2FtxNY+tldGDjvkxH2imMxgtEDnSQhdblAQ==
X-Received: by 2002:a05:6a00:4a0d:b0:6be:4b10:b27d with SMTP id
 do13-20020a056a004a0d00b006be4b10b27dmr2617352pfb.0.1697735092778; 
 Thu, 19 Oct 2023 10:04:52 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:845f:888e:bc51:273a])
 by smtp.gmail.com with ESMTPSA id
 s23-20020aa78bd7000000b0068c006dd5c1sm25523pfd.115.2023.10.19.10.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 10:04:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx8mp_evk: Simplify FEC initialization
Date: Thu, 19 Oct 2023 14:04:41 -0300
Message-Id: <20231019170441.1610453-1-festevam@gmail.com>
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
the FEC interface.

The RTL8211FDI Ethernet PHYs have 25MHz oscillator, so there is no
need to enable the RGMII TX clk output.

Also, there is no need for describing the deprecated phy-reset properties
in u-boot.dtsi.

Remove all these uneeded pieces.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mp-evk-u-boot.dtsi     |  8 --------
 board/freescale/imx8mp_evk/imx8mp_evk.c | 26 +------------------------
 2 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 43f13a9c22f7..db6bc6a11883 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -150,11 +150,3 @@
 	reset-delay-us = <15000>;
 	reset-post-delay-us = <100000>;
 };
-
-&fec {
-	phy-reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <15>;
-	phy-reset-post-delay = <100>;
-};
-
-
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index a24b8c1d8608..2c2b8383c8dc 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -20,33 +20,9 @@
 
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

