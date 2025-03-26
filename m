Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D27C3600E
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C89C81ECA;
	Thu, 27 Mar 2025 05:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PtEaBeP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133F181C84; Wed, 26 Mar 2025 16:01:42 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8D8803CC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7557442BE;
 Wed, 26 Mar 2025 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743001299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/PKjmiT4GCVbt63PFfg9CZbL3X81e1rkHFoJzqKrHU=;
 b=PtEaBeP+nuYMxVgh3ChmwufFxa0DMwEYhxTx0NySGSzsXb+phlbzj3qrYJnm+i9GVTiJaZ
 0FXJIvrx29WU8hzZnfSuBKDBnXXwZStoL2/I5ytT8QiBTRMiO/2t5/QSeLDFQTxSx6EBkF
 dWW2h8XVCVtGOZ7SYfMX8/ONhOIE+JtOrf7pa8RVvNtj6thCOPcsDmMttXWf8TfmRFDEry
 pw/eo1PXFrmO4g/9sBm8vfVMerbsXK+pMFkyZMgYYOA5CXrK5bQOwhFVWruzarGjoI9tai
 2EUubPESqig0Z/iyxl9CsQZH4kOsQpWP+3Nh7mPsfT7DNUZ3iYalM1m61Lro3w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 16:00:54 +0100
Subject: [PATCH v5 10/12] video: imx: Fix Makefile in order to be able to
 add other imx drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ge-mainline-display-support-v5-10-ea4bc3fc9bca@bootlin.com>
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghinhgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhto
 hepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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
index 6073bc5234a93997a42d513feb360a075aa9d57f..8ebd596e11592b18fdc34542421ba165c1ec4fdb 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -53,7 +53,7 @@ obj-$(CONFIG_VIDEO_COREBOOT) += coreboot.o
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
2.48.1

