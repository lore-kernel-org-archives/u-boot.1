Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8F5E8FDDB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:09:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CDE86E81;
	Wed,  4 Oct 2023 11:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E2A86E79; Wed,  4 Oct 2023 11:09:22 +0200 (CEST)
Received: from 20.mo583.mail-out.ovh.net (20.mo583.mail-out.ovh.net
 [91.121.55.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC3F986E81
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.20.85])
 by mo583.mail-out.ovh.net (Postfix) with ESMTP id 8C390293EC
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 09:09:09 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kwsqc (unknown [10.110.171.66])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 238F51FF05;
 Wed,  4 Oct 2023 09:09:09 +0000 (UTC)
Received: from armadeus.com ([37.59.142.96])
 by ghost-submission-6684bf9d7b-kwsqc with ESMTPSA
 id CA6OBrUrHWWVpgMAdCGBnw
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 04 Oct 2023 09:09:09 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0019131ed48-400b-42b6-a377-3b4deab4f849,
 CB129E9803428A999BD6735FDBE6309C32927EE3)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 2/2] dm: adc: imx93-adc depends on ADC (fix boot)
Date: Wed,  4 Oct 2023 11:08:10 +0200
Message-ID: <20231004090810.28923-3-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090810.28923-1-sebastien.szymanski@armadeus.com>
References: <20231004090810.28923-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3149423516357815275
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfekteeugfeufefhkefhfeelteetffduffdvleeluddvveehgeejtdefhffggeefnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
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

The i.MX93 11x11 EVK fails to boot with following error:

 Model: NXP i.MX93 11X11 EVK board
 DRAM:  2 GiB
 Error binding driver 'imx93-adc': -96
 Some drivers failed to bind
 Error binding driver 'simple_bus': -96
 Some drivers failed to bind
 Error binding driver 'simple_bus': -96
 Some drivers failed to bind
 initcall sequence 00000000fffb8f28 failed at call 000000008021e0d4 (err=-96)
 ### ERROR ### Please RESET the board ###

That's because since commit e7ff54d96303 ("imx93_evk: defconfig: add adc
support") CONFIG_ADC_IMX93 is enabled but CONFIG_ADC is not.
Fix this by enabling CONFIG_ADC in imx93_11x11_evk_defconfig.

Make sure this situation won't happen again in future i.MX93 defconfig by
making CONFIG_ADC_IMX93 depend on CONFIG_ADC.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 configs/imx93_11x11_evk_defconfig | 1 +
 drivers/adc/Kconfig               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 89130c437d6d..7a7978c280a5 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -81,6 +81,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_ADC=y
 CONFIG_ADC_IMX93=y
 CONFIG_CPU=y
 CONFIG_CPU_IMX=y
diff --git a/drivers/adc/Kconfig b/drivers/adc/Kconfig
index 4336732dee56..a01d73846b74 100644
--- a/drivers/adc/Kconfig
+++ b/drivers/adc/Kconfig
@@ -66,6 +66,7 @@ config STM32_ADC
 
 config ADC_IMX93
 	bool "Enable NXP IMX93 ADC driver"
+	depends on ADC
 	help
 	  This enables basic driver for NXP IMX93 ADC.
 	  It provides:
-- 
2.41.0

