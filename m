Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D55CCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 20:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1938C86F38;
	Tue, 17 Oct 2023 22:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="x+hBbnLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEEB86F3B; Tue, 17 Oct 2023 22:58:28 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B5486F07
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 22:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=PADb4eImSEkwEJqXicm6Ily61SWvVtITfvP5qDrAbTo=; b=x+hBbnLCESVG69Pz0ucLa9lF7i
 JPKjP909slQa1dMtog45/A/ge0Em+M5h/8ajJzE034mgRgu+K4CgxpgZd04nd3Osy5Is/YU8enU2c
 /zncUcyKwUQo0fWkEh+d7Ybwm/F8B14gMjqwYJxjiySK8t+dQXapV+2j+5fkLu2YJVrA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:54398
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qsr8r-0001E1-BY; Tue, 17 Oct 2023 16:58:18 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Date: Tue, 17 Oct 2023 16:58:15 -0400
Message-Id: <20231017205816.318531-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] arm: dts: imx8mn-var-som: Fix broken EEPROM read
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

On branch WIP/17Oct2023, the EEPROM can no longer be read:

    U-Boot 2023.10-latest (Oct 17 2023 - 15:53:43 -0400)
    CPU:   Freescale i.MX8MNano Quad rev1.0 at 1200 MHz
    Reset cause: POR
    Model: Variscite VAR-SOM-MX8MN Symphony evaluation board
    var_read_som_eeprom: uclass_get_device_by_of_offset() failed: -19
    initcall failed at call 000000004022207c (err=-19)

Convert EEPROM-related properties to bootph-all so that the EEPROM can
also be read outside of SPL.

Fixes: 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi b/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
index e0caf3179ea..2bbc4a49418 100644
--- a/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
@@ -39,11 +39,11 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pinctrl_pmic {
@@ -83,5 +83,5 @@
 };
 
 &eeprom_som {
-	bootph-pre-ram;
+	bootph-all;
 };

base-commit: e65b5d35c9116485366bb08138043d51220551da
-- 
2.39.2

