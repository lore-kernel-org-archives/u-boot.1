Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C5FD75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B9089675;
	Thu, 21 Nov 2024 06:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166772;
	bh=IZ2lIqyEusdaOEc+VJQcHkQoWL3i3JAGpg4uNsCTRdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vFdItZURBEjMzH4coHCnc6oI1Y3yjrTIJ6riy0YtyeO65eZFuT1okrdhf/qF2YWNk
	 uCK8hmFkPjeAorwFpb+OfCnU3xQLWrPtlhdGcU4BN+6BMIhbV8lTizocw68bYqegH4
	 nz5Y9EDpGT+JvlqWe+SJyZ+8Mw11yIsRPx6Rg2EkV129SrPBShpBsLPf6ejsjnC5l/
	 hqF7Uce9JfLSC/ZVdRUufnUcAzIr/afHtta/R48XScekddgp3nldI9YXoHl1duvn8L
	 vE3xcHM7g3Cuht7nCym8gaC3X8Oa8eFdcSJl0NFw1rVSFnrQpyuZ4mXgFMUb1mtDnH
	 3jkYSZ82T9Lgg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5188689651;
 Thu, 21 Nov 2024 06:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166771;
 bh=IZ2lIqyEusdaOEc+VJQcHkQoWL3i3JAGpg4uNsCTRdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=txKooZ4ZOFNw9JSsQ6yrpXoJqAekIdhrs9vFAn3kmRvm1mI7s8yVQNycL37uFUh1d
 kqRkTlWydvE3iWeG/JQ2fKcQFaV60ApuAv/IzXyfJ36JL53cL1sKEypNDh2f+1vBjJ
 lA8htZWXKJoazJxxnGplGC31X5zChUmdDqeAyGMtmJzaXpvGaaRmC8kXLlPcypMmYH
 BNxHsyLCf7i4ErSCPqiA3fz1mFRjdEzaR6hyvKYNrFdyMc84ag4+onblkZK0yHbj51
 OhE+MnlrXD8xjBUEasQi4/6/cYxpD5RPPyYgn+623CBIgrZ5MPaHiOagtvHRmr/Teq
 Ry6GbDCMaopKg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Fabio Estevam <festevam@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Troy Kisky <troy.kisky@boundarydevices.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v3 02/20] net: fec_mxc: fix probing for imx8qxp
Date: Thu, 21 Nov 2024 06:25:43 +0100
Message-Id: <20241121052601.72880-3-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

probing on capricorn board (imx8qxp based) brings:

Can't find FEC0 clk rate: -19

Cause is that when probing fec_mxc driver, fec_mii_setspeed()
is called which calls fec_get_clk_rate().

fec_mii_setspeed() calls fec_get_clk_rate with NULL pointer
for udev and so as in IMX8QXP case CLK_CCF is enabled
udev gets searched with:

uclass_get_device_by_seq(UCLASS_ETH, idx, &dev);

but we do not have yet a UCLASS_ETH ! as we just probing it!

Prevent this by passing udev to fec_get_clk_rate()

Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 board/boundary/nitrogen6x/nitrogen6x.c |  2 +-
 board/solidrun/mx6cuboxi/mx6cuboxi.c   |  2 +-
 drivers/net/fec_mxc.c                  | 14 +++++++-------
 include/netdev.h                       |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/board/boundary/nitrogen6x/nitrogen6x.c b/board/boundary/nitrogen6x/nitrogen6x.c
index b85fd806cba..1adee9a461f 100644
--- a/board/boundary/nitrogen6x/nitrogen6x.c
+++ b/board/boundary/nitrogen6x/nitrogen6x.c
@@ -281,7 +281,7 @@ int board_eth_init(struct bd_info *bis)
 	setup_iomux_enet();
 
 #ifdef CONFIG_FEC_MXC
-	bus = fec_get_miibus(base, -1);
+	bus = fec_get_miibus(NULL, base, -1);
 	if (!bus)
 		return -EINVAL;
 	/* scan phy 4,5,6,7 */
diff --git a/board/solidrun/mx6cuboxi/mx6cuboxi.c b/board/solidrun/mx6cuboxi/mx6cuboxi.c
index e9269ef5353..b543bf8c1fb 100644
--- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
+++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
@@ -385,7 +385,7 @@ static int find_ethernet_phy(void)
 	int phy_addr = -ENOENT;
 
 #ifdef CONFIG_FEC_MXC
-	bus = fec_get_miibus(ENET_BASE_ADDR, -1);
+	bus = fec_get_miibus(NULL, ENET_BASE_ADDR, -1);
 	if (!bus)
 		return -ENOENT;
 
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index d6d5cb52fdd..eca681b16d1 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -160,7 +160,7 @@ static int fec_get_clk_rate(void *udev, int idx)
 	}
 }
 
-static void fec_mii_setspeed(struct ethernet_regs *eth)
+static void fec_mii_setspeed(struct udevice *dev, struct ethernet_regs *eth)
 {
 	/*
 	 * Set MII_SPEED = (1/(mii_speed * 2)) * System Clock
@@ -182,7 +182,7 @@ static void fec_mii_setspeed(struct ethernet_regs *eth)
 	u32 hold;
 	int ret;
 
-	ret = fec_get_clk_rate(NULL, 0);
+	ret = fec_get_clk_rate(dev, 0);
 	if (ret < 0) {
 		printf("Can't find FEC0 clk rate: %d\n", ret);
 		return;
@@ -581,7 +581,7 @@ static int fecmxc_init(struct udevice *dev)
 	fec_reg_setup(fec);
 
 	if (fec->xcv_type != SEVENWIRE)
-		fec_mii_setspeed(fec->bus->priv);
+		fec_mii_setspeed(dev, fec->bus->priv);
 
 	/* Set Opcode/Pause Duration Register */
 	writel(0x00010020, &fec->eth->op_pause);	/* FIXME 0xffff0020; */
@@ -996,7 +996,7 @@ static void fec_free_descs(struct fec_priv *fec)
 	free(fec->tbd_base);
 }
 
-struct mii_dev *fec_get_miibus(ulong base_addr, int dev_id)
+struct mii_dev *fec_get_miibus(struct udevice *dev, ulong base_addr, int dev_id)
 {
 	struct ethernet_regs *eth = (struct ethernet_regs *)base_addr;
 	struct mii_dev *bus;
@@ -1018,7 +1018,7 @@ struct mii_dev *fec_get_miibus(ulong base_addr, int dev_id)
 		free(bus);
 		return NULL;
 	}
-	fec_mii_setspeed(eth);
+	fec_mii_setspeed(dev, eth);
 	return bus;
 }
 
@@ -1354,10 +1354,10 @@ static int fecmxc_probe(struct udevice *dev)
 	if (!bus) {
 		dm_mii_bus = false;
 #ifdef CONFIG_FEC_MXC_MDIO_BASE
-		bus = fec_get_miibus((ulong)CONFIG_FEC_MXC_MDIO_BASE,
+		bus = fec_get_miibus(dev, (ulong)CONFIG_FEC_MXC_MDIO_BASE,
 				     dev_seq(dev));
 #else
-		bus = fec_get_miibus((ulong)priv->eth, dev_seq(dev));
+		bus = fec_get_miibus(dev, (ulong)priv->eth, dev_seq(dev));
 #endif
 	}
 	if (!bus) {
diff --git a/include/netdev.h b/include/netdev.h
index 2a06d9a261b..949245ecdec 100644
--- a/include/netdev.h
+++ b/include/netdev.h
@@ -117,7 +117,7 @@ static inline int pci_eth_init(struct bd_info *bis)
 	return num;
 }
 
-struct mii_dev *fec_get_miibus(ulong base_addr, int dev_id);
+struct mii_dev *fec_get_miibus(struct udevice *dev, ulong base_addr, int dev_id);
 
 #ifdef CONFIG_PHYLIB
 struct phy_device;
-- 
2.20.1

