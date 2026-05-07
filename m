Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF83CD343B
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 07:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C8F284A19;
	Thu,  7 May 2026 09:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="K7DNKoE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F5C84A19; Thu,  7 May 2026 08:26:35 +0200 (CEST)
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CEF28490D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 08:26:33 +0200 (CEST)
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
 bh=+MPDa4vkq346DLcUtFkAoG7FpIVVSYGHCQ4Ac5Mq/6M=; b=K7DNKoE/ho1hA8ugBhnZkLnX4V
 VwMVNXyo0/fTNFbPWh1hWHztiRjq85/uReUxcxpqJn1pLM0mECqJa3cm4YVxsNqW0mSooHuOK4XqH
 hzW5EI7rA3N7DMKOfTsnWNffCI3Bm5aUwK/QCRDEOZ+CLRX4tAi+kl+jf9v1l9bsn3TlhA3cEkIZK
 pGReoz0bDEfzhgW0FKZOKYnjkKI3EL3COQEXO4FIKiK4Hc/xqOazH1d0CbFa8g65bUh/wAt64KFED
 g7dW22XhQNRd29qEf8PXgCP1/E6pYgCpfFVDkgzoMoFyUH4bkcwxklgAWX2nE5QftbuVXHkj7h1sd
 hg/sQVoQ==;
Received: from [115.246.246.98] (port=7848 helo=cypher.couthit.local)
 by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <parvathi@couthit.com>)
 id 1wKsBo-000000065Cv-2ZXy; Thu, 07 May 2026 02:26:29 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: u-boot@lists.denx.de, trini@konsulko.com, Maarten.Brock@sttls.nl,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, kory.maincent@bootlin.com,
 msp@baylibre.com, ilias.apalodimas@linaro.org, parvathi@couthit.com,
 sbellary@baylibre.com, romain.gantois@bootlin.com
Cc: pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, vigneshr@ti.com,
 srk@ti.com, rogerq@ti.com, danishanwar@ti.com, m-malladi@ti.com,
 krishna@couthit.com, mohan@couthit.com, pmohan@couthit.com,
 basharath@couthit.com
Subject: [PATCH v4] board: ti: am335x: Conditional MDIO PAD configuration
 instead of static for AM335_ICE
Date: Thu,  7 May 2026 11:53:49 +0530
Message-ID: <20260507062547.1570033-1-parvathi@couthit.com>
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
X-Mailman-Approved-At: Thu, 07 May 2026 09:25:41 +0200
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

Reviewed-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
Changes from v3 to v4 :
*) Addressed a comment from Tom rini on this patch.

Changes from v2 to v3 :
*) Addressed a comment from Markus Schneider-Pargmann on this patch.
*) Added Reviewed-by: tag from Markus Schneider-Pargmann (TI).

Changes from v1 to v2 :
*) Addressed Markus Schneider-Pargmann's comments on this patch.

 board/ti/am335x/board.c | 10 ++++++++++
 board/ti/am335x/mux.c   |  2 --
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index b5f69a45a7c..4a2d7655d2a 100644
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
 
+static __maybe_unused struct module_pin_mux rmii1_mdio_pin_mux[] = {
+	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
+	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
+	{-1},
+};
+
 /*
  * Read header information from EEPROM into global structure.
  */
@@ -779,6 +786,9 @@ int board_init(void)
 			hang();
 		}
 
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

