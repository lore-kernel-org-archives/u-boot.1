Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB688D3C913
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 14:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CE78334F;
	Wed, 10 Dec 2025 15:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="JPVaMwV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D7D836C8; Wed, 10 Dec 2025 15:18:22 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A3FD8042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1vTL1C-0005CN-Q7; Wed, 10 Dec 2025 09:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=h2DebJcOKvkzY+G+robr1/nbxCFk336zdg27ocQh5Xg=; b=JPVaMwV7uMY4bG
 WrzGac2aQJBqJa5yuCvYuTYz8ao3BE5J/Z/FLCcPn/V9xiqP/Klv+1HMud/UxZ7G9oYIy/5pmRS0v
 VTuYA95qMFCTELqgzC8HR/o7IjFStPCA2YQyH1CS3l2m8oJLazxYlevxYHVr+nwCQe78jS5Jr3fji
 48/HKflTvn7LgcvXvwGw7BYsxt9/uVtXByxb2EciXAVsgUz1FnkBYGhAKgRZfTpBcjKjtJVPgJVZ/
 4g31x5zL6HmtJ4ATJKr2HiFmrOL6SUXO/vthvISj+ir02MtzQyJ2Wog2vPbbPgy/wIbZ/dR69+WgW
 nrhuDmumXk4QQJilwBng==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: anton.reding@landisgyr.com,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH] net: ravb: Configure CXR31 and CXR35 on rzg2l
Date: Wed, 10 Dec 2025 15:17:04 +0100
Message-ID: <20251210141706.32760-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.51.0
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

As in Linux with d78c0ced60 ("net: ravb: Make write access to CXR35 first
before accessing other EMAC register"), configure CXR31 and CXR35 correctly
on rzg2. MII mode does not work correctly unless those registers are
properly configured.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/net/ravb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 68528864ac6..04ee0c0995a 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -42,6 +42,8 @@
 #define RAVB_REG_RFLR		0x508
 #define RAVB_REG_ECSIPR		0x518
 #define RAVB_REG_PIR		0x520
+#define RAVB_REG_CXR31		0x530 /* RZ/G2L only */
+#define RAVB_REG_CXR35		0x540 /* RZ/G2L only */
 #define RAVB_REG_GECMR		0x5b0
 #define RAVB_REG_MAHR		0x5c0
 #define RAVB_REG_MALR		0x5c8
@@ -51,6 +53,12 @@
 #define CCC_OPC_OPERATION	BIT(1)
 #define CCC_BOC			BIT(20)
 
+#define CXR31_SEL_LINK0         BIT(0)
+#define CXR31_SEL_LINK1         BIT(3)
+
+#define CXR35_SEL_XMII_RGMII    0
+#define CXR35_SEL_XMII_MII      2
+
 #define CSR_OPS			0x0000000F
 #define CSR_OPS_CONFIG		BIT(1)
 
@@ -399,6 +407,20 @@ static void ravb_mac_init_rcar(struct udevice *dev)
 static void ravb_mac_init_rzg2l(struct udevice *dev)
 {
 	struct ravb_priv *eth = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+
+	if (pdata->phy_interface == PHY_INTERFACE_MODE_MII) {
+		writel((1000 << 16) | CXR35_SEL_XMII_MII,
+		       eth->iobase + RAVB_REG_CXR35);
+		clrsetbits_32(eth->iobase + RAVB_REG_CXR31,
+			      CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
+	} else {
+		writel((1000 << 16) | CXR35_SEL_XMII_RGMII,
+		       eth->iobase + RAVB_REG_CXR35);
+		clrsetbits_32(eth->iobase + RAVB_REG_CXR31,
+			      CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
+			      CXR31_SEL_LINK0);
+	}
 
 	setbits_32(eth->iobase + RAVB_REG_ECMR,
 		   ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
-- 
2.51.0

