Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B459D3DEA4
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35DE88D9F;
	Fri, 18 Oct 2024 19:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QI1mKPvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D5488BEF; Fri, 18 Oct 2024 19:55:58 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9635A88C4D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7ea8d7341e6so1828825a12.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729274155; x=1729878955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ziPaQdDmEEK+UWukYnKF0HVAbQ7fTQ+5IoSkGiofLE=;
 b=QI1mKPvnTHdtC6BiwURGOLyQnKqgAdUQvD1c7YvP2nfC8fBu8j0xdiXtOJFt73a1hZ
 wpbnmQagAu/uEKwwf6AGCA921mNV9HOoRR2W2nQ09NN9QYY0WzAz8++cXVCP4lihyjmt
 iNxGYTYeSjEuoj0Cr+lwTrgf6pEagqnsP0tVW1v3uTFfYKG0iD3VlYfYaco4FcRRQcMu
 v8k2o5EDYWAIwMjveU8eLqAiRS7aL4YdSouZi7UFesSCvjuwL/1rLS+jRdD7HggB2UBP
 /qfGYf9kt/m+yQR5WZgYXtVQdOjhLaRffYDN454CKmn8rdHPO8WMQGFPaRz7KO2toUZT
 dqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729274155; x=1729878955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ziPaQdDmEEK+UWukYnKF0HVAbQ7fTQ+5IoSkGiofLE=;
 b=kvHx2dYpD9UWs0ljkqQ0V1yei73U4tx7z9xZ3vTyf9c/9ljcbsWRdzd4TLi/iiddQe
 NyxynOucjQ0WEuLx9GMpg2uTMr3v2rreWfyORTJRS9XIxHkcP//WmcY5LBLeStWR2JO2
 ncL37vXoT5YWnbSR7mwU+u1Q6ZGEe4dky1KyiLClihonoNRNu6ep4PjPfreQBdm9vq3m
 hGffNG3dMFeAMRzKbs2LRFuns2ijLh1Ybojhj5mDJF2MY+7ruLZ+VPmB+c1ZrWym1Cw1
 KP1FPAWo98Gnz1wg1yJgguUat+V2aa/n7ASujcA2M33wjPdlxY/vQqNAqGRtN9DKBe6g
 0zBA==
X-Gm-Message-State: AOJu0Yz5a5LPnGAgixGJ44KbN9zKTjj/T16Pq7/gjcBjGny98n8qLPxs
 3ZVpyVEGYTwryagGCjG/s44d0mb5TFW+CfbueiMsPzgv02MeLpXs
X-Google-Smtp-Source: AGHT+IFmZ8JbEv1IH6SLN6MRgYQidobUQFeRQR2IST0J0p/gGyW19K6sWi8Y7xAxJCAPhdxLqhoImQ==
X-Received: by 2002:a05:6a20:b908:b0:1d9:2659:5da9 with SMTP id
 adf61e73a8af0-1d92c4dfc42mr3702042637.18.1729274155068; 
 Fri, 18 Oct 2024 10:55:55 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ad3c:ece1:18ac:9bc9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eacc20d1bcsm1428408a12.9.2024.10.18.10.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 10:55:54 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] mx6ul_14x14_evk: Remove unneeded USB board code
Date: Fri, 18 Oct 2024 14:55:48 -0300
Message-Id: <20241018175549.361096-1-festevam@gmail.com>
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

With CONFIG_DM_USB, there is no longer the need for any USB board code
anymore.

Remove the unneeded USB board code.

While at it, also remove the uneeeded CONFIG_USB_MAX_CONTROLLER_COUNT
option.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../mx6ul_14x14_evk/mx6ul_14x14_evk.c         | 51 -------------------
 configs/mx6ul_14x14_evk_defconfig             |  1 -
 2 files changed, 52 deletions(-)

diff --git a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
index c4ab59da78c7..fbb5a12212d7 100644
--- a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
+++ b/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
@@ -31,8 +31,6 @@
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
 #include "../common/pfuze.h"
-#include <usb.h>
-#include <usb/ehci-ci.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -155,49 +153,6 @@ int board_mmc_init(struct bd_info *bis)
 }
 #endif
 
-#ifdef CONFIG_USB_EHCI_MX6
-#ifndef CONFIG_DM_USB
-
-#define USB_OTHERREGS_OFFSET	0x800
-#define UCTRL_PWR_POL		(1 << 9)
-
-static iomux_v3_cfg_t const usb_otg_pads[] = {
-	MX6_PAD_GPIO1_IO00__ANATOP_OTG1_ID | MUX_PAD_CTRL(OTG_ID_PAD_CTRL),
-};
-
-/* At default the 3v3 enables the MIC2026 for VBUS power */
-static void setup_usb(void)
-{
-	imx_iomux_v3_setup_multiple_pads(usb_otg_pads,
-					 ARRAY_SIZE(usb_otg_pads));
-}
-
-int board_usb_phy_mode(int port)
-{
-	if (port == 1)
-		return USB_INIT_HOST;
-	else
-		return usb_phy_mode(port);
-}
-
-int board_ehci_hcd_init(int port)
-{
-	u32 *usbnc_usb_ctrl;
-
-	if (port > 1)
-		return -EINVAL;
-
-	usbnc_usb_ctrl = (u32 *)(USB_BASE_ADDR + USB_OTHERREGS_OFFSET +
-				 port * 4);
-
-	/* Set Power polarity */
-	setbits_le32(usbnc_usb_ctrl, UCTRL_PWR_POL);
-
-	return 0;
-}
-#endif
-#endif
-
 #ifdef CONFIG_FEC_MXC
 static int setup_fec(int fec_id)
 {
@@ -284,12 +239,6 @@ int board_init(void)
 	setup_fec(CFG_FEC_ENET_DEV);
 #endif
 
-#ifdef CONFIG_USB_EHCI_MX6
-#ifndef CONFIG_DM_USB
-	setup_usb();
-#endif
-#endif
-
 #ifdef CONFIG_FSL_QSPI
 	board_qspi_init();
 #endif
diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index bbeb364e256c..522c5660d72c 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -92,7 +92,6 @@ CONFIG_SOFT_SPI=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
-CONFIG_USB_MAX_CONTROLLER_COUNT=2
 CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
-- 
2.34.1

