Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1A6C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 20:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C71E88875;
	Mon, 29 Jul 2024 22:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CEE88791; Mon, 29 Jul 2024 22:44:51 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E7888875
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 22:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 00AC51F00051
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:44:44 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 61FD1A1258F; Mon, 29 Jul 2024 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 8D84AA12587;
 Mon, 29 Jul 2024 20:44:39 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Heiko Schocher <hs@denx.de>, Felix Brack <fb@ltec.ch>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH 1/3] omap: Use spl_soc_init instead of spl_board_init
Date: Mon, 29 Jul 2024 22:44:37 +0200
Message-ID: <20240729204439.429900-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.45.2
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

Both spl_board_init and spl_soc_init are available as ways to run
specific code in the SPL's board_init_r. Use the former for init
code that is specific to the SoC and leave spl_board_init available
for boards to use.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
---
 arch/arm/Kconfig                  | 2 +-
 arch/arm/mach-omap2/boot-common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba0359fed5ad..656f588a97c0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -802,7 +802,7 @@ config ARCH_OMAP2PLUS
 	bool "TI OMAP2+"
 	select CPU_V7A
 	select GPIO_EXTRA_HEADER
-	select SPL_BOARD_INIT if SPL
+	select SPL_SOC_INIT if SPL
 	select SPL_STACK_R if SPL
 	select SUPPORT_SPL
 	imply TI_SYSC if DM && OF_CONTROL
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index e1ea3515ac10..21b204074e80 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -269,7 +269,7 @@ skip_ipu1:
 		debug("%s: IPU2 failed to start (%d)\n", __func__, ret);
 }
 
-void spl_board_init(void)
+void spl_soc_init(void)
 {
 	/* Prepare console output */
 	preloader_console_init();
-- 
2.45.2

