Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82B5CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC99D86DCB;
	Tue, 17 Oct 2023 11:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E99E86D4B; Tue, 17 Oct 2023 11:45:50 +0200 (CEST)
Received: from 20.mo550.mail-out.ovh.net (20.mo550.mail-out.ovh.net
 [188.165.45.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7002086DEC
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.1.153])
 by mo550.mail-out.ovh.net (Postfix) with ESMTP id 0F5B5287E8
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:45:46 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-g8p7h (unknown [10.110.171.164])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 82CF91FE4F;
 Tue, 17 Oct 2023 09:45:45 +0000 (UTC)
Received: from armadeus.com ([37.59.142.109])
 by ghost-submission-6684bf9d7b-g8p7h with ESMTPSA
 id wG1zHclXLmXlEAAAPl3lTg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Tue, 17 Oct 2023 09:45:45 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003dac0be55-2e24-474f-b526-2934c31fbd19,
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
Subject: [PATCH v2 4/4] arm: dts: imx93-evk: remove wrong eqos compatible
 string
Date: Tue, 17 Oct 2023 11:45:01 +0200
Message-ID: <20231017094501.7713-4-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
References: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6325868626621754347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfekteeugfeufefhkefhfeelteetffduffdvleeluddvveehgeejtdefhffggeefnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
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

The correct compatible string for i.MX93 variant of DWC EQoS MAC is now
"nxp,imx93-dwmac-eqos".

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v4:
 - none

 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index a9dffa5a71e9..4ecb53ed8be1 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -131,10 +131,6 @@
 	phy-reset-post-delay = <100>;
 };
 
-&eqos {
-	compatible = "fsl,imx-eqos";
-};
-
 &ethphy1 {
 	reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
 	reset-assert-us = <15000>;
-- 
2.41.0

