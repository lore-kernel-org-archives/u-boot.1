Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25178C54731
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CCF88A47;
	Tue, 27 Aug 2024 21:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iPHJIAaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A68E88A2F; Tue, 27 Aug 2024 21:43:24 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4282D88A75
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2703967b10cso4166602fac.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724787801; x=1725392601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCXK0moNMngA8E1DVLnEuSS46dqTVrISoVui5Q8o84w=;
 b=iPHJIAaA72QqLfp+9OgzhDDkF8HjKoSUoNOzbFESuBqiy4vJTCzv0gU21+6TDu2umy
 m9/g8wjbMxXm0/Ts7KlqC52MJBMwV3HRFkk6yTCprbQuSiH/nRGqbD7TT/4AMivqZBud
 rtaSz9PlSDk2kG3Co5mynu2UYICzESfab3qpQgKKYkS68mipNhzi2O6S862gXVZwJnzQ
 +iHq3YxIRKgVz4G7KnYUKz/epxp9lTgHnMmaBkDGntEqTSg1zTESXit6UnRCmZOB08i/
 +k1VcbZ1QoWdV0+xNbN+rbFZXkUjtoXeDiYBvR20aHi+QQNziWtkrdVUnbNjgZgnWpna
 Vexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724787801; x=1725392601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCXK0moNMngA8E1DVLnEuSS46dqTVrISoVui5Q8o84w=;
 b=t3QPGKD4QghNKjHjZwMlyJGWxtUh6OcDPF+2ufjecAOs6YGWKmBo5IuV+gseIWyp8A
 NbyKkr3bRA4vtvYohR9yRVzj4DNXBfFUvveMdVJ4Yj813LqxzmC4F1+Eq93SvziY8n95
 EznBzO+HcTdOUcvAWHrvBcdGuxj/u/kgp0lOnvygTK8FJE76tj26mpkXWFAKLRq2x9C9
 RdZfu0Xd7v6TV+r7wQ7FEVCPRa1gJ8jPaox85FvtG8TZlNlrRg/bDklyziNyRbURHQp5
 0DI1TrynlhxviEs/W+DGqwD+F9g6cdPFuQMxBTEwq/4a3EWuypraW1GGcG/G4yVux26G
 j9fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ioo0JM8fnKkR7pl6hCIoYOYgNIcQOpoyNy5jafkVQets/b17BJtBsK/MlzO19kzkat+rtyA=@lists.denx.de
X-Gm-Message-State: AOJu0YzMo6jXTvMNshXE+r0IShrsIEIcfPndZ+2GKU140saUtrRE+gXy
 KT3L7NVo8kCI2SdD8gylTBHZCWqwUkFk4FcFxbXQNB0+nNw1AqSL
X-Google-Smtp-Source: AGHT+IFBSpewHHQ+o5gxu7gRc29dvOSeG+QlcBubQHhIhc8eQ3qEz60QhlWf4uR65mbKpG4a9CEmHQ==
X-Received: by 2002:a05:6870:b406:b0:270:5d07:51f4 with SMTP id
 586e51a60fabf-273e6727707mr16974832fac.45.1724787800818; 
 Tue, 27 Aug 2024 12:43:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9a82:cd38:57a9:3c17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acabccasm8311218a12.27.2024.08.27.12.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 12:43:20 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 3/4] mx5: Remove CFG_MXC_USB_PORT
Date: Tue, 27 Aug 2024 16:43:06 -0300
Message-Id: <20240827194307.2933299-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827194307.2933299-1-festevam@gmail.com>
References: <20240827194307.2933299-1-festevam@gmail.com>
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

CFG_MXC_USB_PORT is not used anywhere, so remove this unused symbol.

Suggested-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Newly introduced.

 include/configs/m53menlo.h   | 1 -
 include/configs/mx51evk.h    | 1 -
 include/configs/mx53cx9020.h | 1 -
 include/configs/mx53loco.h   | 1 -
 include/configs/mx53ppd.h    | 1 -
 include/configs/usbarmory.h  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 1491c509820..51ce030d831 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -70,7 +70,6 @@
  * USB
  */
 #ifdef CONFIG_CMD_USB
-#define CFG_MXC_USB_PORT		1
 #define CFG_MXC_USB_PORTSC		(PORT_PTS_UTMI | PORT_PTS_PTW)
 #endif
 
diff --git a/include/configs/mx51evk.h b/include/configs/mx51evk.h
index dff54d04a67..6c8cb78274b 100644
--- a/include/configs/mx51evk.h
+++ b/include/configs/mx51evk.h
@@ -33,7 +33,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	MMC_SDHC1_BASE_ADDR
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	PORT_PTS_ULPI
 #define CFG_MXC_USB_FLAGS	MXC_EHCI_POWER_PINS_ENABLED
 
diff --git a/include/configs/mx53cx9020.h b/include/configs/mx53cx9020.h
index ab6b0b65556..38bafc5156d 100644
--- a/include/configs/mx53cx9020.h
+++ b/include/configs/mx53cx9020.h
@@ -22,7 +22,6 @@
 /* bootz: zImage/initrd.img support */
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
diff --git a/include/configs/mx53loco.h b/include/configs/mx53loco.h
index 04f4b723209..e9340c59ae1 100644
--- a/include/configs/mx53loco.h
+++ b/include/configs/mx53loco.h
@@ -17,7 +17,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* PMIC Controller */
diff --git a/include/configs/mx53ppd.h b/include/configs/mx53ppd.h
index 3c9a9fb045b..e0bfbbb459c 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -12,7 +12,6 @@
 #include <asm/arch/imx-regs.h>
 
 /* USB Configs */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Command definition */
diff --git a/include/configs/usbarmory.h b/include/configs/usbarmory.h
index 28d86a26362..1d7caaa1448 100644
--- a/include/configs/usbarmory.h
+++ b/include/configs/usbarmory.h
@@ -23,7 +23,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 /* USB */
-#define CFG_MXC_USB_PORT	1
 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
 
 /* Linux boot */
-- 
2.34.1

