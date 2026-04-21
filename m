Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE85F8FA6E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450B384399;
	Tue, 21 Apr 2026 14:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="iMPY0yxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCD1839D5; Tue, 21 Apr 2026 14:32:05 +0200 (CEST)
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0469841C8
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parvathi@couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
 ; s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
 :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iAzGmVT43JikPSoFuSkcdhfJaBTFi7mzdKkdTDS5sGo=; b=iMPY0yxAcdBbpYQJWyOCEsY2kZ
 WwfQwEf/sLAna1va9syvV/nQg6euCtUtxdtMabkQwKJboissp5DWWiF/hmLI8M+88FkwzZW98zdhL
 MFCubZomENin5LyuojV9O1fXZeFfdsCP/VTH0E8ME3p+2K2vp3mjcSiwu0HG8ARousTT8cKQ9O05e
 ku700wLKIfbLvTFNMp/uiGqpcYyRkZIFplRbRAkCM2umNN5jlFUaHRLHv/ul1kO0T3K1Z79VqIWAo
 M8E7NoYX/6zaVnjCEQ1FgLfaTb/Ifvg43eSY7PEbSFrKOpmJ2/jmhpp/4COVAoAQRvi87ZW9cDrXH
 xgYmXh4A==;
Received: from [115.246.246.98] (port=33215 helo=cypher.couthit.local)
 by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <parvathi@couthit.com>)
 id 1wFAGj-00000009rlx-3TRL; Tue, 21 Apr 2026 08:31:58 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: u-boot@lists.denx.de, trini@konsulko.com, Maarten.Brock@sttls.nl,
 kory.maincent@bootlin.com, msp@baylibre.com, parvathi@couthit.com,
 sbellary@baylibre.com, romain.gantois@bootlin.com
Cc: pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, vigneshr@ti.com,
 srk@ti.com, rogerq@ti.com, danishanwar@ti.com, m-malladi@ti.com,
 krishna@couthit.com, mohan@couthit.com, pmohan@couthit.com,
 basharath@couthit.com
Subject: [PATCH v2] board: ti: am335x: Conditional MDIO PAD configuration
 instead of static for AM335_ICE
Date: Tue, 21 Apr 2026 18:00:22 +0530
Message-ID: <20260421123106.2885994-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id:
 parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

This patch removes the static MDIO pinmux configuration from
rmii1_pin_mux[] and instead configures the MDIO pins conditionally
during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
were always configured for CPSW in mux.c, which could lead to
unnecessary pin ownership and conflicts in scenarios where CPSW
is not used.

With this change, the MDIO pins are configured only when required,
ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
This approach keeps Ethernet boot behavior intact and provides cleaner
separation between CPSW and other Ethernet use cases.

Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
Changes from v1 to v2 :
*) Adressed Markus Schneider-Pargmann's comments on this patch.

 board/ti/am335x/board.c | 11 +++++++++++
 board/ti/am335x/mux.c   |  2 --
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 90e37a8d913..f0a40cb82af 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -28,6 +28,7 @@
 #include <asm/arch/mmc_host_def.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/mem.h>
+#include <asm/arch/mux.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/emif.h>
@@ -72,6 +73,12 @@ static struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
 #define GPIO0_IRQSTATUSRAW	(AM33XX_GPIO0_BASE + 0x024)
 #define GPIO1_IRQSTATUSRAW	(AM33XX_GPIO1_BASE + 0x024)
 
+static struct module_pin_mux rmii1_mdio_pin_mux[] = {
+	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
+	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
+	{-1},
+};
+
 /*
  * Read header information from EEPROM into global structure.
  */
@@ -779,6 +786,10 @@ int board_init(void)
 			hang();
 		}
 
+		/* Set the Mux Mode to MDIO_DATA, MDIO_CLK */
+		if (!eth0_is_mii)
+			configure_module_pin_mux(rmii1_mdio_pin_mux);
+
 		prueth_is_mii = eth0_is_mii;
 
 		/* disable rising edge IRQs */
diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
index d2d87c304f6..36d849d2119 100644
--- a/board/ti/am335x/mux.c
+++ b/board/ti/am335x/mux.c
@@ -190,8 +190,6 @@ static struct module_pin_mux mii1_pin_mux[] = {
 };
 
 static struct module_pin_mux rmii1_pin_mux[] = {
-	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
-	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
 	{OFFSET(mii1_crs), MODE(1) | RXACTIVE},		/* MII1_CRS */
 	{OFFSET(mii1_rxerr), MODE(1) | RXACTIVE},	/* MII1_RXERR */
 	{OFFSET(mii1_txen), MODE(1)},			/* MII1_TXEN */
-- 
2.43.0

