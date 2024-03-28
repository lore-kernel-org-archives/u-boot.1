Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403D3CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA15881DA;
	Thu, 28 Mar 2024 19:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lm5u5ZOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2851881E1; Thu, 28 Mar 2024 19:43:35 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE037881D7
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 19:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5a46ad0d981so244385eaf.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711651412; x=1712256212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/yjFa+g9tB+fBdQiyiWpmngG1WC9Tb5wgLFQ8Bz69iI=;
 b=lm5u5ZOmjme4XUYpjLmtxrCzxsZVbUesj4Ac7JzdziA8+sTXIn+WSaBx8yGxItUJXd
 pdTshHwc67SimiKvp3e+kP0RJxWbCGcdBSzIF2KmBOkQUnpSguBIF06QsKVbeABI+Q9V
 vOMFzq2NbPx2A52ThkrnchZ7YpkR+0dRhBjuUJrnfpjaMT6FEXHCt3l95K38/Dfk4Zhu
 SeggWE69+Pdp3sw1Q+t88bGmWbFzx4HzZzeTRSpKB/WfvIUssvDeRU61HdXmtDZv8cAY
 FuGslJIHuuSdfVJaWqMIIOBh+powsASgRWsnmsH8hKuozjXllGRdK03b1savvbTYQFVp
 +JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711651412; x=1712256212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yjFa+g9tB+fBdQiyiWpmngG1WC9Tb5wgLFQ8Bz69iI=;
 b=OgyNl63Pa2nKzZ/SnYVp2AGfcEY4gFjWbiy4oPxE1EYy2WyMcM8kGE3aK8vBm/xm+F
 vdo3JQvklZjE7xpyIYM7L/vjdVGFwTIkQ3AYsppTJfuFTGk9YbXRW7C3opuUgxZNi4Jd
 ebY7c+VmFVX+ObRmIb1G3pGozHHptK6stCNoAf0bi+RRVV6bJm3fQGUC6MRNARYIpcR+
 dPDGNnVC2q7sOKvfph13Y5N+MSPaqq1ftQPxX1V4WMbyI7zqLJadfsY2PvTgsrhD7edY
 oxQA2BC4FaO6DPL43Fa0gj5qCsVwfbMIpkK8kVYrOA+iixyrTTni9B6sVNh8U87RnNVK
 /piA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC95N3vs0K1ZoiHXFMhgit4EjE9Uct+bj3m6b9aH3r8oqroBfQlXJidQ53mp5eUobacnsnpHFqm6pI0Bk77sAHoM8nqA==
X-Gm-Message-State: AOJu0YwjlaZ0C+cZdnhs2TrKPt3Jd/ibO+2YkELi/z6ePA/8HaqMettc
 6pOoNta5LnJaFSX1g4SL6DhXv+qpmBgjAiVOS8+G0mJdthCxZ9I8
X-Google-Smtp-Source: AGHT+IFXEDEB42BKTV66I9QrOmOFdmt7IY3HiqeItH43Ci4FrW2Hzbl1PuYnf5OZddmU+NoW+3cxrQ==
X-Received: by 2002:a05:6358:3423:b0:17e:b7a0:2ec6 with SMTP id
 h35-20020a056358342300b0017eb7a02ec6mr177930rwd.3.1711651412384; 
 Thu, 28 Mar 2024 11:43:32 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:918f:1fce:e47c:7f91])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a63f401000000b005e4fa511505sm1630737pgi.69.2024.03.28.11.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 11:43:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: peng.fan@nxp.com,
	u-boot@lists.denx.de
Subject: [PATCH] imx8mq_evk: Remove FEC and Ethernet PHY board code
Date: Thu, 28 Mar 2024 15:43:19 -0300
Message-Id: <20240328184319.2572139-1-festevam@gmail.com>
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

With Ethernet DM in place, there is no longer the need for having
the board_phy_config() and setup_fec() functions anymore.
    
Remove them.

Successfully tested a TFTP transfer after these changes.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 30 -------------------------
 1 file changed, 30 deletions(-)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index e39480585609..e577e4d9ccaa 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -54,38 +54,8 @@ int board_early_init_f(void)
 	return 0;
 }
 
-#ifdef CONFIG_FEC_MXC
-static int setup_fec(void)
-{
-	struct iomuxc_gpr_base_regs *gpr =
-		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
-
-	/* Use 125M anatop REF_CLK1 for ENET1, not from external */
-	clrsetbits_le32(&gpr->gpr[1], BIT(13) | BIT(17), 0);
-	return set_clk_enet(ENET_125MHZ);
-}
-
-int board_phy_config(struct phy_device *phydev)
-{
-	/* enable rgmii rxc skew and phy mode select to RGMII copper */
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x1f);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x8);
-
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x05);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x100);
-
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-	return 0;
-}
-#endif
-
 int board_init(void)
 {
-#ifdef CONFIG_FEC_MXC
-	setup_fec();
-#endif
-
 #if defined(CONFIG_USB_DWC3) || defined(CONFIG_USB_XHCI_DWC3)
 	init_usb_clk();
 #endif
-- 
2.34.1

