Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5275DCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311C486F0F;
	Tue, 17 Oct 2023 16:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="q24YHip2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA97186F0D; Tue, 17 Oct 2023 16:25:13 +0200 (CEST)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1768D86F06
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=FMTtTC8JFamZBY6mUi67cjv/6IdeI7hkaWVbK+vLVnk=; b=q24YHip2S24PG9zR07NPpbPvcW
 oS5pgxgxXKHaA6HeIB+b+IKjYo10T1PGnKpdqr6pshIqfIXLgoTQbxrcqHt+8b2yI7zkjqFn/I9M0
 BfBZH28FVEIFE54MSD0q3fQCKk2LZsYrS7Akv9dTi/7gmToLxpj6F5NFmzFd18wUktfQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39722
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1qsl0J-0005hO-6Q; Tue, 17 Oct 2023 10:25:03 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Date: Tue, 17 Oct 2023 10:25:00 -0400
Message-Id: <20231017142500.4074185-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] imx8mn-var-som: add manufacturer to target description
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

Add Variscite manufacturer to the IMX8MN_VAR_SOM target menu label as
the majority of targets include the manufacturer as part of their menu
description/label and it helps when looking for a particular
manufacturer/board.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 3d62d7052e7..5cf862a8eb0 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -249,7 +249,7 @@ config TARGET_PICO_IMX8MQ
 	select IMX8M_LPDDR4
 
 config TARGET_IMX8MN_VAR_SOM
-	bool "imx8mn_var_som"
+	bool "Variscite imx8mn_var_som"
 	select BINMAN
 	select IMX8MN
 	select SUPPORT_SPL

base-commit: e65b5d35c9116485366bb08138043d51220551da
-- 
2.39.2

