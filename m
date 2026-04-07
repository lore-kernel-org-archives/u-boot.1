Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9A0FEEF31
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 12:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E67884106;
	Tue,  7 Apr 2026 14:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=couthit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=couthit.com header.i=@couthit.com header.b="Pcm5n+OI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B93F83A41; Tue,  7 Apr 2026 10:25:03 +0200 (CEST)
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D228352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 10:25:00 +0200 (CEST)
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
 bh=LLc5kEFZ4/CYoksSRK7//avMWCYrBsptxIF4imWAxFw=; b=Pcm5n+OI+UZP6hVLsdSCaim8xd
 YfyUAoB5UM7jc03QAL0mzDOcJ/5zsW0vj0N/VOmno2KIPDR6hfpTFUA4POQy63HWlD4roqm4a+cs+
 2jB0YZsQMvH3updS2GWhcKNoReHRZeNlnzYYnPNFoCodhdLJ62unAc6Awu7ObKo6/1qU6jAUWwOst
 gDW1P+9zrsVXa48G/Q/vOjaaG5baQz8W91TnmfBdJjzC9sN1D9zHQy9gzgobHlAoCskSL5r1KRqay
 A9oVGvcd3ODuP9u+ep7sbcZbi1Nn02e1qTzWyG/hxhb0CuFATZSC9ec++ZyVOoTQtOlABgP0HvdaY
 HsLogfDA==;
Received: from [115.246.246.98] (port=48973 helo=cypher.couthit.local)
 by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <parvathi@couthit.com>)
 id 1wA1k0-0000000Djy7-1xaJ; Tue, 07 Apr 2026 04:24:57 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: u-boot@lists.denx.de, trini@konsulko.com, Maarten.Brock@sttls.nl,
 kory.maincent@bootlin.com, msp@baylibre.com, parvathi@couthit.com,
 sbellary@baylibre.com, romain.gantois@bootlin.com
Cc: pratheesh@ti.com, j-rameshbabu@ti.com, praneeth@ti.com, vigneshr@ti.com,
 srk@ti.com, rogerq@ti.com, danishanwar@ti.com, m-malladi@ti.com,
 krishna@couthit.com, mohan@couthit.com, pmohan@couthit.com,
 basharath@couthit.com
Subject: [PATCH] board: ti: am335x: Conditional MDIO PAD configuration instead
 of static for AM335_ICE
Date: Tue,  7 Apr 2026 13:52:59 +0530
Message-ID: <20260407082402.2311644-1-parvathi@couthit.com>
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
X-Mailman-Approved-At: Tue, 07 Apr 2026 14:51:19 +0200
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
 board/ti/am335x/board.c | 22 ++++++++++++++++++++++
 board/ti/am335x/mux.c   |  2 --
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 90e37a8d913..abeab809387 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -61,6 +61,18 @@ DECLARE_GLOBAL_DATA_PTR;
 #define GPIO_ETH0_MODE		GPIO_TO_PIN(0, 11)
 #define GPIO_ETH1_MODE		GPIO_TO_PIN(1, 26)
 
+#define AM335X_PIN_MDIO	0x948
+#define AM335X_PIN_MDC		0x94c
+
+#define GPIO_MDIO_DATA		CTRL_BASE + AM335X_PIN_MDIO
+#define GPIO_MDIO_CLK		CTRL_BASE + AM335X_PIN_MDC
+
+/* Enabling MDIO_DATA by setting MUX_MODE to 0, RXACTIVE, PULLUP_EN bits */
+#define PAD_CONFIG_MDIO_DATA	0x30
+
+/* Enabling MDIO_CLK by setting MUX_MODE to 0, PULLUP_EN bit */
+#define PAD_CONFIG_MDIO_CLK	0x10
+
 static struct ctrl_dev *cdev = (struct ctrl_dev *)CTRL_DEVICE_BASE;
 
 #define GPIO0_RISINGDETECT	(AM33XX_GPIO0_BASE + OMAP_GPIO_RISINGDETECT)
@@ -779,6 +791,16 @@ int board_init(void)
 			hang();
 		}
 
+		if (!eth0_is_mii || !eth1_is_mii) {
+			/* Set the Mux Mode to MDIO_DATA */
+			reg = readl(GPIO_MDIO_DATA);
+			writel(reg & PAD_CONFIG_MDIO_DATA, GPIO_MDIO_DATA);
+
+			/* Set the Mux Mode to MDIO_CLK */
+			reg = readl(GPIO_MDIO_CLK);
+			writel(reg & PAD_CONFIG_MDIO_CLK, GPIO_MDIO_CLK);
+		}
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

