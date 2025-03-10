Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBF8C28B30
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 10:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F3B812C8;
	Mon, 10 Mar 2025 11:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U8G+jxb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C078003E; Mon, 10 Mar 2025 11:37:30 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF418142D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 11:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbM1k953645
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 05:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741603042;
 bh=+BfiNKWW7rEIsD7zUk17r6O7WZmFO92yV4Yg++tENkg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=U8G+jxb3OZWH3RTLAgiyzRdHxgLZ8d2EyiTqFedfSNyD3EsGCA3EX22GVMeCHMPFa
 WdIBcu82zbt881iS4o8+FfA8fJZVci29NMMPBXzPFNFuT2bCPCDv66JeKQZjIE2Otr
 U2EyCobX6a7suCKNF9K0GvSO0BbqOqfnCedQTgAc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbM0O044617
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Mar 2025 05:37:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 05:37:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 05:37:22 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AAb6kL072804;
 Mon, 10 Mar 2025 05:37:18 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <hs@denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <stefan.agner@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 3/4] i2c: omap24xx_i2c: support CONFIG for repeated start
 in DM_I2C xfer
Date: Mon, 10 Mar 2025 16:06:46 +0530
Message-ID: <20250310103702.1464782-4-a-limaye@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310103702.1464782-1-a-limaye@ti.com>
References: <20250310103702.1464782-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Repeated Start Condition (Sr) can be used to transfer multiple i2c msgs
without sending a Stop condition (P). So far, the driver default was to
always send a Stop condition after every i2c msg.

Add support for a config option (CONFIG_SYS_I2C_OMAP24XX_REPEATED_START)
to disable sending the Stop condition by default. If this config is
enabled, Stop condition will be sent only if explicitly requested in the
msg flags OR if it is the last msg in the transfer.

Consequently, handle the Repeated Start condition (Sr) in the next msg
by not calling the wait_for_bb() check since it will simply timeout in
the absence of a stop condition (BB will be 1 until Stop is programmed)

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---

v2:
- fixup code formatting and comment blocks
- CONFIG_I2C_REPEATED_START -> CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
- Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-3-a-limaye@ti.com/

---
 drivers/i2c/omap24xx_i2c.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/omap24xx_i2c.c b/drivers/i2c/omap24xx_i2c.c
index 7c5d786e8e9..ad739b123e5 100644
--- a/drivers/i2c/omap24xx_i2c.c
+++ b/drivers/i2c/omap24xx_i2c.c
@@ -1066,18 +1066,28 @@ static int omap_i2c_xfer(struct udevice *bus, struct i2c_msg *msg, int nmsgs)
 	u16 i2c_con_reg = 0;
 
 	debug("%s: %d messages\n", __func__, nmsgs);
-	for (; nmsgs > 0; nmsgs--, msg++) {
-		/* Wait until bus not busy */
-		if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
-			return -EREMOTEIO;
+	for (int i = 0; i < nmsgs; i++, msg++) {
+		/*
+		 * If previous msg sent a Stop or if this is the first msg
+		 * Wait until bus not busy
+		 */
+		if ((i2c_con_reg & I2C_CON_STP) || (i == 0))
+			if (wait_for_bb(priv->regs, priv->ip_rev, priv->waitdelay))
+				return -EREMOTEIO;
 
-		/* Set Controller mode with Start and Stop bit */
-		i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT | I2C_CON_STP;
+		/* Set Controller mode with Start bit */
+		i2c_con_reg = I2C_CON_EN | I2C_CON_MST | I2C_CON_STT;
 		/* Set Transmitter/Receiver mode if it is a write/read msg */
 		if (msg->flags & I2C_M_RD)
 			i2c_con_reg &= ~I2C_CON_TRX;
 		else
 			i2c_con_reg |= I2C_CON_TRX;
+		/* Send Stop condition (P) by default */
+		if (!IS_ENABLED(CONFIG_SYS_I2C_OMAP24XX_REPEATED_START))
+			i2c_con_reg |= I2C_CON_STP;
+		/* Send Stop if explicitly requested or if this is the last msg */
+		if ((msg->flags & I2C_M_STOP) || (i == nmsgs - 1))
+			i2c_con_reg |= I2C_CON_STP;
 
 		debug("%s: chip=0x%x, len=0x%x, i2c_con_reg=0x%x\n",
 		      __func__, msg->addr, msg->len, i2c_con_reg);
-- 
2.48.1

