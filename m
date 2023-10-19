Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE3BCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 19:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BA287455;
	Thu, 19 Oct 2023 21:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="B0PP+KMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063238729D; Thu, 19 Oct 2023 21:43:30 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C08874B4
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 21:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=mkwMex6OA8+bWr5wYSPG5hyuP7EBtKcpWIQno4WfjaE=; b=B0PP+KMfmE5oenJPu9zr0zXyVS
 pjH76K7bO6UcUl5dfeAivK8DWIuvZ+wMYRXrOB1zSspwmj6l2TLCmGwxhAwFNQHJ/wn2fEt2hE+sW
 VCS7AMquUZ6kvaqfu8mBYKnT/VvCm9TF1s4P2OzosPNlPp3cTMQ+Yfd8jo2qlzj4Xrdo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57242
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qtYvV-0008He-3K; Thu, 19 Oct 2023 15:43:25 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	u-boot@lists.denx.de
Date: Thu, 19 Oct 2023 15:43:23 -0400
Message-Id: <20231019194323.2207989-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] imx8mn-var-som: Simplify FEC initialization
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

With DM enabled, there is no need for board code to initialize
the FEC interface.

The ethernet PHYs on the symphony carrier board have a dedicated
crystal/oscillator. If the SOM has the EC configuration option
(onboard ethernet PHY), it also has a dedicated crystal/oscillator.
So in all cases, there is no need to enable the RGMII TX clk output.

This follows a similar change introduced by Fabio Estevam:
  Link: https://lore.kernel.org/u-boot/20231019170441.1610453-1-festevam@gmail.com/

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 board/variscite/imx8mn_var_som/imx8mn_var_som.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/board/variscite/imx8mn_var_som/imx8mn_var_som.c b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
index 61b9455a8f4..994fd4f7058 100644
--- a/board/variscite/imx8mn_var_som/imx8mn_var_som.c
+++ b/board/variscite/imx8mn_var_som/imx8mn_var_som.c
@@ -12,7 +12,6 @@
 #include <fdt_support.h>
 #include <i2c_eeprom.h>
 #include <malloc.h>
-#include <asm/io.h>
 #include <asm/global_data.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <linux/libfdt.h>
@@ -46,20 +45,8 @@ struct var_imx8_eeprom_info {
 	u8 partnumber2[5];        /* Part number 2 */
 } __packed;
 
-static void setup_fec(void)
-{
-	struct iomuxc_gpr_base_regs *gpr =
-		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
-
-	/* Use 125M anatop REF_CLK1 for ENET1, not from external */
-	clrsetbits_le32(&gpr->gpr[1], 0x2000, 0);
-}
-
 int board_init(void)
 {
-	if (IS_ENABLED(CONFIG_FEC_MXC))
-		setup_fec();
-
 	return 0;
 }
 

base-commit: 4655b75335384e040358a2e3e478cc42f32a96c9
-- 
2.39.2

