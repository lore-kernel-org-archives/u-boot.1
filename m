Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF892C41513
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 07:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9912882ED;
	Mon, 13 May 2024 09:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AFXqVrVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF7A882E9; Mon, 13 May 2024 09:25:55 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612E6882E4
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 09:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so2731010b3a.0
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715585152; x=1716189952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o0yijqizDIMJNHDspVjVdokKPgSUwjLOVEC3fgMCNZU=;
 b=AFXqVrVBKNRCLnBdVaELDbvzhS8A6hDegGFlUIX2LCVSlAPudT/Bz5WVrPuOhymvKY
 JhcG6OD4WcY/ed2BmiZweAda/tOfiAn3OdzbYY5rkljKhu31okV1bH0Zx6FAKmd75EPJ
 qSfZ1nDeC05/k1mkI9GXDa3NQVpeDdGCgXcp//3CtmBbXXG/EY9pkqX3ISSYjjNTZ4UL
 5o5sSeombKjXuc0jmRoPgl+ZQIT9V5dkhUvR+9Dyzyx8vmeCXSdOpgxRJLIg+iOUEpCm
 REtekubPL3hT3uc7Kjysuj7i4J5OIqEwNOs+LUfbAuCL/swQJnNbfq66ayT/Kx8fqp6b
 +o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715585152; x=1716189952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o0yijqizDIMJNHDspVjVdokKPgSUwjLOVEC3fgMCNZU=;
 b=AyuteREByXoq031a1/G5wzNzPC7y7mVoBPaYdXXFreEwkOyV7MFT8t0n+JFhphpxhO
 FUMo3LkDfRk8MLx+fpmV4lNR5K2py+/kRmg7+uhp3dmWddfLLX2tol4fkwXAwzq7V9Ss
 NexGI5/W+eANzIbfw0nria2r0JB6/DEq7BzBwISGhsm6MavsEr3GZucPJJdto0SuMlMM
 3Hff4VKipUpstlzj4Y9Oow68ZZQjJDjPVP5TnflIke6Ij+Oj9fAa5RVX3pXDGcAdGMY0
 G7AgPJBWBpmS0HJvuo3kurpVjvE2i9nBNSU+LJTxQuT2M8N0kBPxzndf0DOXKU25Uc79
 Ioxw==
X-Gm-Message-State: AOJu0Yyjtt96GgZBkvFI1suNZrrp5wPUhAk3TeHrNT5+WLkq57m/PIK1
 ntaDsY+Cx4AP2SOrBztbrawe3vDLzY42kLEhI2g/vFlgZBVag/NM
X-Google-Smtp-Source: AGHT+IEjx/OC+AG4FSnyQH+PWwH7H6j6JjVvDlR2ojNWhAJC+PrN65PuISqTS/qdJahYqadt/o3/Jw==
X-Received: by 2002:a05:6a00:9288:b0:6f4:b54b:e4fe with SMTP id
 d2e1a72fcca58-6f4c908aee4mr19874547b3a.2.1715585151624; 
 Mon, 13 May 2024 00:25:51 -0700 (PDT)
Received: from localhost.localdomain ([180.217.146.232])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d90f54easm6248377b3a.18.2024.05.13.00.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:25:51 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, trini@konsulko.com,
 jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] phy: Use dt-bindig definations for npcm usb phy
Date: Mon, 13 May 2024 15:25:32 +0800
Message-Id: <20240513072532.1592391-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Use dt-binding definations for the phy switch connection.
It declares the target usb controller it is connected to.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/phy/phy-npcm-usb.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/phy-npcm-usb.c b/drivers/phy/phy-npcm-usb.c
index 24eba66554..09fb14e26f 100644
--- a/drivers/phy/phy-npcm-usb.c
+++ b/drivers/phy/phy-npcm-usb.c
@@ -12,6 +12,7 @@
 #include <dm/device_compat.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <dt-bindings/phy/nuvoton,npcm-usbphy.h>
 
 /* GCR Register Offsets */
 #define GCR_INTCR3	0x9C
@@ -32,14 +33,6 @@
 #define USBPHY3SW_HOST2		FIELD_PREP(USBPHY3SW, 1)
 #define USBPHY3SW_DEV8_PHY3	FIELD_PREP(USBPHY3SW, 3)
 
-enum controller_id {
-	UDC0_7,
-	UDC8,
-	UDC9,
-	USBH1,
-	USBH2,
-};
-
 enum phy_id {
 	PHY1 = 1,
 	PHY2,
@@ -47,13 +40,13 @@ enum phy_id {
 };
 
 /* Phy Switch Settings */
-#define USBDPHY1	((PHY1 << 8) | UDC0_7)	/* Connect UDC0~7 to PHY1 */
-#define USBD8PHY1	((PHY1 << 8) | UDC8)	/* Connect UDC8 to PHY1 */
-#define USBD9PHY1	((PHY1 << 8) | UDC9)	/* Connect UDC9 to PHY1 */
-#define USBD9PHY2	((PHY2 << 8) | UDC9)	/* Connect UDC9 to PHY2 */
-#define USBH1PHY2	((PHY2 << 8) | USBH1)	/* Connect USBH1 to PHY2 */
-#define USBD8PHY3	((PHY3 << 8) | UDC8)	/* Connect UDC8 to PHY3 */
-#define USBH2PHY3	((PHY3 << 8) | USBH2)	/* Connect USBH2 to PHY3 */
+#define USBDPHY1	((PHY1 << 8) | NPCM_UDC0_7)	/* Connect UDC0~7 to PHY1 */
+#define USBD8PHY1	((PHY1 << 8) | NPCM_UDC8)	/* Connect UDC8 to PHY1 */
+#define USBD9PHY1	((PHY1 << 8) | NPCM_UDC9)	/* Connect UDC9 to PHY1 */
+#define USBD9PHY2	((PHY2 << 8) | NPCM_UDC9)	/* Connect UDC9 to PHY2 */
+#define USBH1PHY2	((PHY2 << 8) | NPCM_USBH1)	/* Connect USBH1 to PHY2 */
+#define USBD8PHY3	((PHY3 << 8) | NPCM_UDC8)	/* Connect UDC8 to PHY3 */
+#define USBH2PHY3	((PHY3 << 8) | NPCM_USBH2)	/* Connect USBH2 to PHY3 */
 
 struct npcm_usbphy {
 	struct regmap *syscon;
@@ -153,12 +146,12 @@ static int npcm_usb_phy_exit(struct phy *phy)
 	return 0;
 }
 
-static int  npcm_usb_phy_xlate(struct phy *phy, struct ofnode_phandle_args *args)
+static int npcm_usb_phy_xlate(struct phy *phy, struct ofnode_phandle_args *args)
 {
 	struct npcm_usbphy *priv = dev_get_priv(phy->dev);
 	u16 phy_switch;
 
-	if (args->args_count < 1 || args->args[0] > USBH2)
+	if (args->args_count < 1 || args->args[0] > NPCM_MAX_USB_CTRL_ID)
 		return -EINVAL;
 
 	phy_switch = (priv->id << 8) | args->args[0];
-- 
2.25.1

