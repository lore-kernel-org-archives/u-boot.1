Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A776AECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F02389006;
	Tue, 10 Sep 2024 12:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hOAYHZdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 979FF8900E; Tue, 10 Sep 2024 12:14:01 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231F58900F
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56CF2240012;
 Tue, 10 Sep 2024 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725963228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifguc/q40qj9lXGFr56iCN5Qs72SMF6TtydG8r21acY=;
 b=hOAYHZdARDweu8E0fXCjEHsiu05BikhQBdwP8RDL/umo4BFSvVPJUqWJir1yclg+xqMQEx
 rezwz9e9jhQlY3Jbe3uQHevn7oFAp1f8b/hLV53ttM6ZjrZ8LebkStAeH1m23p54d1AZYi
 QGXEUxg7TwTE7jW4o/58/NhozQcP9HeNzxUQRB5Ii1e0iGJyhis0zFDsLV2d4476QY7/70
 705sI3Ja7EJpZ/p5TdRxDSq9z0OtBQ0NINf5JQFbaR6lysvW/+LSUHNPSYjkujQRtLMdD3
 k4mggDxZ2fYfZ4MB0uKwXiBxv5U/Q9Ev3wSkYdvk8Yrf8OwwI55Q9cqPldQLoQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>
Cc: <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6/8] video: imx: Fix Makefile in order to be able to add other
 imx drivers
Date: Tue, 10 Sep 2024 12:13:42 +0200
Message-ID: <20240910101344.110633-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910101344.110633-1-miquel.raynal@bootlin.com>
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index f3f70cd04a1..20854b7081e 100644
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
index 179ea651fe8..46cc44d64b0 100644
--- a/drivers/video/imx/Makefile
+++ b/drivers/video/imx/Makefile
@@ -3,4 +3,4 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y += mxc_ipuv3_fb.o ipu_common.o ipu_disp.o
+obj-$(CONFIG_VIDEO_IPUV3) += mxc_ipuv3_fb.o ipu_common.o ipu_disp.o
-- 
2.43.0

