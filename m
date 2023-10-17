Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D765CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2558286DFF;
	Tue, 17 Oct 2023 11:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA16E86D5E; Tue, 17 Oct 2023 11:45:52 +0200 (CEST)
Received: from 3.mo561.mail-out.ovh.net (3.mo561.mail-out.ovh.net
 [46.105.44.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E7286DE4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.146.32])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 844FE23C88
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:45:45 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-g8p7h (unknown [10.110.171.164])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E1C261FE00;
 Tue, 17 Oct 2023 09:45:44 +0000 (UTC)
Received: from armadeus.com ([37.59.142.109])
 by ghost-submission-6684bf9d7b-g8p7h with ESMTPSA
 id CCZwNMhXLmXlEAAAPl3lTg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 17 Oct 2023 09:45:44 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S0039ed7a44b-e57e-488a-bd4a-f75346484bc6,
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
Subject: [PATCH v2 3/4] net: phy: realtek: Add support for RTL8211F(D)(I)-VD-CG
Date: Tue, 17 Oct 2023 11:45:00 +0200
Message-ID: <20231017094501.7713-3-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
References: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6325587152369150955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfekteeugfeufefhkefhfeelteetffduffdvleeluddvveehgeejtdefhffggeefnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
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

Add support for the RTL8211F(D)(I)-VD-CG PHY present on the i.MX93 EVK
board.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v3:
 - none

 drivers/net/phy/realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 396cac76d632..7e1036b2271f 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -446,6 +446,20 @@ U_BOOT_PHY_DRIVER(rtl8211f) = {
 	.writeext = &rtl8211f_phy_extwrite,
 };
 
+/* Support for RTL8211F-VD PHY */
+U_BOOT_PHY_DRIVER(rtl8211fvd) = {
+	.name = "RealTek RTL8211F-VD",
+	.uid = 0x1cc878,
+	.mask = 0xffffff,
+	.features = PHY_GBIT_FEATURES,
+	.probe = &rtl8211f_probe,
+	.config = &rtl8211f_config,
+	.startup = &rtl8211f_startup,
+	.shutdown = &genphy_shutdown,
+	.readext = &rtl8211f_phy_extread,
+	.writeext = &rtl8211f_phy_extwrite,
+};
+
 /* Support for RTL8201F PHY */
 U_BOOT_PHY_DRIVER(rtl8201f) = {
 	.name = "RealTek RTL8201F 10/100Mbps Ethernet",
-- 
2.41.0

