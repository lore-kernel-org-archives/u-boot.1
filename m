Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B235FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 10:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D82684852;
	Wed, 29 Apr 2026 12:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="jYEo8aef";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7234484836; Wed, 29 Apr 2026 12:35:20 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E4584836
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 12:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g5DGC60WFzCCs;
 Wed, 29 Apr 2026 12:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777458915;
 bh=4uywroN9PVnqErnP9mV025LuSI5epUWA0OmnBuQ81E0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jYEo8aefdl4j1WOQhaN8WE2hAvQ+tqU47PXQuHX9L9AnYRxEzvmkbXzqWaXljsUlf
 jKpUmq/ZOKoR7oroQd3wRAUJgvptoGQhqU0kM9Bpme8iyJlf6x0BQ/H1dDY+NmtxJ3
 6Imk1TmWwqcpN1qocefU7iJlrScK7yHx9JriQZTzbfphcATH5ctpTlz/+OAVOl2uDs
 5mPdY71qma23LOLSstFLrDv3ftFk6awoBl8i0LtzztPMRLrv1BZ65lB6t727TNIUO4
 wZPUyeF5ADhr6UdUaNBkbm4v4HDn2MKDdzjhoFaHNziB0ct+JEbB8K39/8HOPM2RAH
 s4SJZCwCAOjEw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g5DGB6L18zXtg; Wed, 29 Apr 2026 12:35:14 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Apr 2026 12:35:03 +0200
Subject: [PATCH RFC next 3/5] net: tsec: make tsec_private a private structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-sys_rx_eth_buffer-no-net-v1-3-396ef37ae93c@cherry.de>
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
To: u-boot@lists.denx.de
Cc: Tang Yuantian <andy.tang@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Move the definition of tsec_private within the only file that makes use
of it.

This adds the benefit of include/tsec.h not referencing PKTBUFSRX (which
is set to CONFIG_SYS_RX_ETH_BUFFER, which we're trying to move to be
under CONFIG_NET dependency) anymore. Considering drivers/net/tsec.c is
only built if CONFIG_NET=y, this is fine.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/net/tsec.c | 17 +++++++++++++++++
 include/tsec.h     | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/tsec.c b/drivers/net/tsec.c
index bd4ebdd745a..d03368b9408 100644
--- a/drivers/net/tsec.c
+++ b/drivers/net/tsec.c
@@ -37,6 +37,23 @@
 		)
 #endif /* CFG_TSEC_TBICR_SETTINGS */
 
+struct tsec_private {
+	struct txbd8 __iomem txbd[TX_BUF_CNT];
+	struct rxbd8 __iomem rxbd[PKTBUFSRX];
+	struct tsec __iomem *regs;
+	struct tsec_mii_mng __iomem *phyregs_sgmii;
+	struct phy_device *phydev;
+	phy_interface_t interface;
+	struct mii_dev *bus;
+	uint phyaddr;
+	uint tbiaddr;
+	char mii_devname[16];
+	u32 flags;
+	uint rx_idx;	/* index of the current RX buffer */
+	uint tx_idx;	/* index of the current TX buffer */
+	struct udevice *dev;
+};
+
 /* Configure the TBI for SGMII operation */
 static void tsec_configure_serdes(struct tsec_private *priv)
 {
diff --git a/include/tsec.h b/include/tsec.h
index 153337837a9..f5ced38f3fc 100644
--- a/include/tsec.h
+++ b/include/tsec.h
@@ -350,23 +350,6 @@ struct tsec_data {
 	u32 mdio_regs_off;
 };
 
-struct tsec_private {
-	struct txbd8 __iomem txbd[TX_BUF_CNT];
-	struct rxbd8 __iomem rxbd[PKTBUFSRX];
-	struct tsec __iomem *regs;
-	struct tsec_mii_mng __iomem *phyregs_sgmii;
-	struct phy_device *phydev;
-	phy_interface_t interface;
-	struct mii_dev *bus;
-	uint phyaddr;
-	uint tbiaddr;
-	char mii_devname[16];
-	u32 flags;
-	uint rx_idx;	/* index of the current RX buffer */
-	uint tx_idx;	/* index of the current TX buffer */
-	struct udevice *dev;
-};
-
 struct tsec_info_struct {
 	struct tsec __iomem *regs;
 	struct tsec_mii_mng __iomem *miiregs_sgmii;

-- 
2.54.0

