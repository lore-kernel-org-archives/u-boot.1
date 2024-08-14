Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60B5C531DF
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 18:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF4B889FD;
	Wed, 14 Aug 2024 20:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KyRWDPVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27208889BA; Wed, 14 Aug 2024 20:29:02 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FF9889E9
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 20:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc47aef524so166085ad.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723660138; x=1724264938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2Vt9rpa2YamZsp/lZtqrb1zYci4QOWOB+5m/vqz690=;
 b=KyRWDPVnHazXZviUxBbZNZWck10nZVdVBYgT3mGXFI/CIir8hfYYXehzapUvxeueaF
 7YahB50SjwVGsDq0Qnpo3as0EKqpewcyEIa1ET3Ll7cHJM+BJuAwYcZvxq1f5m4ltMhV
 pooEpcqs6GwTxd/bmgqzrKFQlh8gdVzEJ8ZGJ0eZP/VJSJPiUZxvbdFI91NznCNDVvMa
 EEEp7Bu9JJE0kExZiBcqPMFUrqrcp70P2j2COzyCzS0pCYrhUL5GaeE038j8BZwVw4wa
 qM0IOfngxg3C48sBYD2Q/EWY3EZ/pnr8nondYj0lUvCF2IZwS6hxWDcNnXxUChFOjnYF
 CQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723660138; x=1724264938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2Vt9rpa2YamZsp/lZtqrb1zYci4QOWOB+5m/vqz690=;
 b=QzyzYA2eEfaePvmqsqNNoLKZDASXcuOY1iNEzqDSz29ZULfczl2+uZNLdLrth5SMKv
 C9Rth4R5k1ymuda8gxBAwIkA88uVn2ZEPaw8gB9h4GvX2XK0rKZGFCdyl9SHs5AeA54R
 yRGtuF5/7nu1gRITwwljDOsvDxFnlgrLDLipY5weuqO9rsyN9da56uouKOxUaqvhXqj6
 /2pf9EV0x2kYc/5FauIZa9f8ToFxPp3fVaoj377xDBg4Ty1bQyElhPElEiWSeVGhFs7E
 zHUFJK7ZC8hejm4bbLEHDLR8aJKrwd4lBHGCi+IAFuUhq2eWxIXwpa468gBloVoW3Z4r
 hKpQ==
X-Gm-Message-State: AOJu0Yxc/y4Xaa9bW/0WZQfvTRJT4CSkJROJBxBEV7KZRw1QNf41VwmT
 A1DAOrXNNbWSdf4npiDXmMfU2yca9df8dUZ4xWuB9zN1Mgi6rPzk
X-Google-Smtp-Source: AGHT+IE61UoGfgXLbQQfDje/4WZ4st0LHTBGQvKKu5LN1GOwMADnTWRohvV//EMv85NNYvLmNZmV6w==
X-Received: by 2002:a17:902:d0d4:b0:201:e7c2:bd0d with SMTP id
 d9443c01a7336-201e7c2bf11mr10316755ad.11.1723660138321; 
 Wed, 14 Aug 2024 11:28:58 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:31ab:46dd:f2b3:633])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd13149csm32563535ad.47.2024.08.14.11.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 11:28:57 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] tqma6_mba6: Remove UART board code
Date: Wed, 14 Aug 2024 15:28:45 -0300
Message-Id: <20240814182845.762118-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814182845.762118-1-festevam@gmail.com>
References: <20240814182845.762118-1-festevam@gmail.com>
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

With DM_SERIAL in place, there is no need to setup the UART pins
in the board code.

The UART pins are setup via devicetree, thanks to DM.

Remove the unneeded code.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi | 16 ++++++++++++++++
 board/tq/tqma6/tqma6_mba6.c           | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
index 78457ef68f4..c8c0fc1fba7 100644
--- a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
+++ b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
@@ -10,6 +10,22 @@
 	};
 };
 
+&aips2 {
+	bootph-all;
+};
+
+&pinctrl_uart2 {
+	bootph-all;
+};
+
+&soc {
+	bootph-all;
+};
+
+&uart2 {
+	bootph-all;
+};
+
 &wdog1 {
 	bootph-pre-ram;
 };
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 7267d812e7d..b8f76591006 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -31,9 +31,6 @@
 
 #include "tqma6_bb.h"
 
-#define UART_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
-	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
-
 #if defined(CONFIG_TQMA6Q)
 
 #define IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0790
@@ -70,17 +67,6 @@ static void mba6_setup_iomuxc_enet(void)
 		     (void *)IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
 }
 
-static iomux_v3_cfg_t const mba6_uart2_pads[] = {
-	NEW_PAD_CTRL(MX6_PAD_SD4_DAT4__UART2_RX_DATA, UART_PAD_CTRL),
-	NEW_PAD_CTRL(MX6_PAD_SD4_DAT7__UART2_TX_DATA, UART_PAD_CTRL),
-};
-
-static void mba6_setup_iomuxc_uart(void)
-{
-	imx_iomux_v3_setup_multiple_pads(mba6_uart2_pads,
-					 ARRAY_SIZE(mba6_uart2_pads));
-}
-
 int board_mmc_get_env_dev(int devno)
 {
 	/*
@@ -140,8 +126,6 @@ int board_phy_config(struct phy_device *phydev)
 
 int tqma6_bb_board_early_init_f(void)
 {
-	mba6_setup_iomuxc_uart();
-
 	return 0;
 }
 
-- 
2.34.1

