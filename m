Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826ADCDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFC1686CFE;
	Tue, 17 Oct 2023 11:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC2086C58; Tue, 17 Oct 2023 11:45:48 +0200 (CEST)
Received: from 16.mo550.mail-out.ovh.net (16.mo550.mail-out.ovh.net
 [178.33.104.224])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08EA86D4B
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.1.153])
 by mo550.mail-out.ovh.net (Postfix) with ESMTP id 282A6287E8
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:45:44 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-g8p7h (unknown [10.110.171.164])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 62A071FE00;
 Tue, 17 Oct 2023 09:45:43 +0000 (UTC)
Received: from armadeus.com ([37.59.142.109])
 by ghost-submission-6684bf9d7b-g8p7h with ESMTPSA
 id BwwuE8dXLmXlEAAAPl3lTg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 17 Oct 2023 09:45:43 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003b19b8fdc-53ee-4928-adcb-740359ef15a8,
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
Subject: [PATCH v2 1/4] net: dwc_eth_qos: add i.MX93 support
Date: Tue, 17 Oct 2023 11:44:58 +0200
Message-ID: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6325305679358585835
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepffeufffgveeiffelteelgfetjeffueffuefhffeikefhkefghfejjeeufeduteegnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
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

Add support for DWC EQoS MAC on i.MX93.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v2:
 - rebase to not break Rockchip's boards

 drivers/net/dwc_eth_qos.c     | 4 ++++
 drivers/net/dwc_eth_qos_imx.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 18466cfe257e..e7eb6213adad 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1707,6 +1707,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "nxp,imx8mp-dwmac-eqos",
 		.data = (ulong)&eqos_imx_config
 	},
+	{
+		.compatible = "nxp,imx93-dwmac-eqos",
+		.data = (ulong)&eqos_imx_config
+	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_ROCKCHIP)
 	{
diff --git a/drivers/net/dwc_eth_qos_imx.c b/drivers/net/dwc_eth_qos_imx.c
index 60f3f3f5a10f..e3f55dd98173 100644
--- a/drivers/net/dwc_eth_qos_imx.c
+++ b/drivers/net/dwc_eth_qos_imx.c
@@ -181,6 +181,9 @@ static int eqos_set_tx_clk_speed_imx(struct udevice *dev)
 	ulong rate;
 	int ret;
 
+	if (device_is_compatible(dev, "nxp,imx93-dwmac-eqos"))
+		return 0;
+
 	debug("%s(dev=%p):\n", __func__, dev);
 
 	if (eqos->phy->interface == PHY_INTERFACE_MODE_RMII)
-- 
2.41.0

