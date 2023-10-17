Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B06CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D6D86DEB;
	Tue, 17 Oct 2023 11:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D6886DEC; Tue, 17 Oct 2023 11:45:50 +0200 (CEST)
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net
 [46.105.49.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F55A86D5E
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.20.147])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id D447C276DD
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:45:44 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-g8p7h (unknown [10.110.171.164])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3A5D51FE4F;
 Tue, 17 Oct 2023 09:45:44 +0000 (UTC)
Received: from armadeus.com ([37.59.142.109])
 by ghost-submission-6684bf9d7b-g8p7h with ESMTPSA
 id uPF6CMhXLmXlEAAAPl3lTg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 17 Oct 2023 09:45:44 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003212979d6-14dc-4c93-b876-4db545cd75a8,
 E8A557B56471F6228A10BFFFE8FF761D83F94D6C)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH v2 2/4] net: dwc_eth_qos: Add board_interface_eth_init() for
 i.MX93
Date: Tue, 17 Oct 2023 11:44:59 +0200
Message-ID: <20231017094501.7713-2-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
References: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6325305680294636523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfekteeugfeufefhkefhfeelteetffduffdvleeluddvveehgeejtdefhffggeefnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehkedupdhmohguvgepshhmthhpohhuth
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

Add a common board_interface_eth_init() called by the DWC MAC driver to
setup the MAC <-> PHY interface according to the PHY mode obtained from
DT.
Remove the board-side configuration in the i.MX93 EVK files.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v2:
 - none

 arch/arm/mach-imx/imx9/clock.c        | 53 +++++++++++++++++++++++++++
 board/freescale/imx93_evk/imx93_evk.c | 16 --------
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 766a8811c1fa..92c41e9a67bf 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -18,6 +18,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <log.h>
+#include <phy.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -832,6 +833,58 @@ u32 imx_get_fecclk(void)
 	return ccm_clk_root_get_rate(WAKEUP_AXI_CLK_ROOT);
 }
 
+#if defined(CONFIG_IMX93) && defined(CONFIG_DWC_ETH_QOS)
+static int imx93_eqos_interface_init(struct udevice *dev, phy_interface_t interface_type)
+{
+	struct blk_ctrl_wakeupmix_regs *bctrl =
+		(struct blk_ctrl_wakeupmix_regs *)BLK_CTRL_WAKEUPMIX_BASE_ADDR;
+
+	clrbits_le32(&bctrl->eqos_gpr,
+		     BCTRL_GPR_ENET_QOS_INTF_MODE_MASK |
+		     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
+
+	switch (interface_type) {
+	case PHY_INTERFACE_MODE_MII:
+		setbits_le32(&bctrl->eqos_gpr,
+			     BCTRL_GPR_ENET_QOS_INTF_SEL_MII |
+			     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		setbits_le32(&bctrl->eqos_gpr,
+			     BCTRL_GPR_ENET_QOS_INTF_SEL_RMII |
+			     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		setbits_le32(&bctrl->eqos_gpr,
+			     BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII |
+			     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#else
+static int imx93_eqos_interface_init(struct udevice *dev, phy_interface_t interface_type)
+{
+	return 0;
+}
+#endif
+
+int board_interface_eth_init(struct udevice *dev, phy_interface_t interface_type)
+{
+	if (IS_ENABLED(CONFIG_IMX93) &&
+	    IS_ENABLED(CONFIG_DWC_ETH_QOS) &&
+	    device_is_compatible(dev, "nxp,imx93-dwmac-eqos"))
+		return imx93_eqos_interface_init(dev, interface_type);
+
+	return -EINVAL;
+}
+
 int set_clk_enet(enum enet_freq type)
 {
 	u32 div;
diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index f4297f8fd4d4..c54dc9d05c5c 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -49,27 +49,11 @@ int board_phy_config(struct phy_device *phydev)
 	return 0;
 }
 
-static int setup_eqos(void)
-{
-	struct blk_ctrl_wakeupmix_regs *bctrl =
-		(struct blk_ctrl_wakeupmix_regs *)BLK_CTRL_WAKEUPMIX_BASE_ADDR;
-
-	/* set INTF as RGMII, enable RGMII TXC clock */
-	clrsetbits_le32(&bctrl->eqos_gpr,
-			BCTRL_GPR_ENET_QOS_INTF_MODE_MASK,
-			BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII | BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
-
-	return set_clk_eqos(ENET_125MHZ);
-}
-
 int board_init(void)
 {
 	if (IS_ENABLED(CONFIG_FEC_MXC))
 		setup_fec();
 
-	if (IS_ENABLED(CONFIG_DWC_ETH_QOS))
-		setup_eqos();
-
 	return 0;
 }
 
-- 
2.41.0

