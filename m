Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18639E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BA48952A;
	Thu,  5 Dec 2024 14:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JAo1Bndp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6C3894E7; Thu,  5 Dec 2024 14:54:56 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C7A89527
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46B144000B;
 Thu,  5 Dec 2024 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1733406890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8qMKMEw9+A0UId7iFdzNe2JonFo6DtX+gAs0YUjiRY=;
 b=JAo1Bndp9s3HY0i/rh1+jTaqcUI5vApfQemiy3NIwamSCui/rXEmLEA5a8LSEO81GS6eoa
 0zEBF+xCJJisPCle5Y/TwHCWW2UeA0syFo/iPaxmvtiwfkYhuUU591g+bNfpxcdjZkYSh8
 Ufb5gBg1SDQdXKD9MKQJJOF/NPntBjRmfo3OChaKle4fnt7mETTIp9UYtv5xmKzDWm9OuH
 TWI6tqWLzxfFGfzEqJ9/8iLWqOWtqTfmQJ4N+eKH254ORekqcixJwzFDRJ2CcfYbr+S9vg
 WLjfjrwG1fr/9FaPpJcCvKmZ0CZOeGWgykkwjO9VJBLTwD1Nx1ynPCOq+hSgrQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Dec 2024 14:54:16 +0100
Subject: [PATCH v2 10/13] video: imx: Fix Makefile in order to be able to
 add other imx drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-ge-mainline-display-support-v2-10-4683bb4388dc@bootlin.com>
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com
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

The IPUv3 is one IP part of the imx world, there are others, and
selecting the whole imx/ folder based on such a specific Kconfig symbol
is sub-optimal. Let's always enter the imx/ folder, and then selectively
compile parts of the folder based on the configuration.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/video/Makefile     | 2 +-
 drivers/video/imx/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 5a00438ce0648effdcade42ee255f037c65b00d3..15ba0f1697ee93f2227f60efa67f4ed378f5780a 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_VIDEO_COREBOOT) += coreboot.o
 obj-$(CONFIG_VIDEO_DW_HDMI) += dw_hdmi.o
 obj-$(CONFIG_VIDEO_DW_MIPI_DSI) += dw_mipi_dsi.o
 obj-$(CONFIG_VIDEO_EFI) += efi.o
-obj-$(CONFIG_VIDEO_IPUV3) += imx/
+obj-y += imx/
 obj-$(CONFIG_VIDEO_IVYBRIDGE_IGD) += ivybridge_igd.o
 obj-$(CONFIG_VIDEO_LCD_ANX9804) += anx9804.o
 obj-$(CONFIG_VIDEO_LCD_ENDEAVORU) += endeavoru-panel.o
diff --git a/drivers/video/imx/Makefile b/drivers/video/imx/Makefile
index 179ea651fe8495e24206e2b06354a4f36651056c..46cc44d64b00959fb3880c7befb04a1ebdda1143 100644
--- a/drivers/video/imx/Makefile
+++ b/drivers/video/imx/Makefile
@@ -3,4 +3,4 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y += mxc_ipuv3_fb.o ipu_common.o ipu_disp.o
+obj-$(CONFIG_VIDEO_IPUV3) += mxc_ipuv3_fb.o ipu_common.o ipu_disp.o

-- 
2.47.0

