Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4765BE8FDDB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF84786E82;
	Wed,  4 Oct 2023 11:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528F786E70; Wed,  4 Oct 2023 11:09:13 +0200 (CEST)
Received: from 19.mo581.mail-out.ovh.net (19.mo581.mail-out.ovh.net
 [178.33.251.118])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CA586C96
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.138.56])
 by mo581.mail-out.ovh.net (Postfix) with ESMTP id D373B28D00
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 09:09:06 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kwsqc (unknown [10.110.171.66])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2D0B51FEFE;
 Wed,  4 Oct 2023 09:09:06 +0000 (UTC)
Received: from armadeus.com ([37.59.142.96])
 by ghost-submission-6684bf9d7b-kwsqc with ESMTPSA
 id DmoFB7IrHWWVpgMAdCGBnw
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 04 Oct 2023 09:09:06 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001973d1402-2904-4816-a87d-04137956c5e9,
 CB129E9803428A999BD6735FDBE6309C32927EE3)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 0/2] Fixes i.MX93 11x11 EVK boot failures
Date: Wed,  4 Oct 2023 11:08:08 +0200
Message-ID: <20231004090810.28923-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3148579092797975531
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepffeufffgveeiffelteelgfetjeffueffuefhffeikefhkefghfejjeeufeduteegnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
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

This series fixes i.MX93 11x11 EVK boot failures.

Sébastien Szymanski (2):
  arm: dts: imx93-11x11-evk: add bootph-some-ram property
  dm: adc: imx93-adc depends on ADC (fix boot)

 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 20 ++++++++++++++++++++
 configs/imx93_11x11_evk_defconfig        |  1 +
 drivers/adc/Kconfig                      |  1 +
 3 files changed, 22 insertions(+)

-- 
2.41.0

