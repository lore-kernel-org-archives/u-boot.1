Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AAAE8FDDB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D68C986DED;
	Wed,  4 Oct 2023 11:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F8886DED; Wed,  4 Oct 2023 11:09:20 +0200 (CEST)
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net
 [46.105.63.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33CF86E5B
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.16.8])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 2E388206C5
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 09:09:08 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-kwsqc (unknown [10.110.171.66])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C64101FEC2;
 Wed,  4 Oct 2023 09:09:07 +0000 (UTC)
Received: from armadeus.com ([37.59.142.96])
 by ghost-submission-6684bf9d7b-kwsqc with ESMTPSA
 id iELtLrMrHWWVpgMAdCGBnw
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 04 Oct 2023 09:09:07 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00137882185-dfa5-4e92-af7f-c3365574a7e7,
 CB129E9803428A999BD6735FDBE6309C32927EE3)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/2] arm: dts: imx93-11x11-evk: add bootph-some-ram property
Date: Wed,  4 Oct 2023 11:08:09 +0200
Message-ID: <20231004090810.28923-2-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090810.28923-1-sebastien.szymanski@armadeus.com>
References: <20231004090810.28923-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3149142041983577067
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhephfekteeugfeufefhkefhfeelteetffduffdvleeluddvveehgeejtdefhffggeefnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
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

i.MX93 11x11 EVK fails to boot:

U-Boot SPL 2023.10-00558-g65b9b3462bec-dirty (Oct 03 2023 - 17:40:10 +0200)
SOC: 0xa0009300
LC: 0x40010
M33 prepare ok
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, pagesize 0x200, ivt offset 0x0
Load image from 0x44400 by ROM_API
NOTICE:  BL31: v2.8(release):android-13.0.0_2.0.0-0-ge4b2dbfa52f5
NOTICE:  BL31: Built : 17:52:46, Sep 28 2023

That's because commit 9e644284ab81 ("dm: core: Report
bootph-pre-ram/sram node as pre-reloc after relocation"):

	"[This] changes behavior of what nodes are bound in the U-Boot
	proper pre-relocation phase. Change to bootph-all or add
	bootph-some-ram prop to restore prior behavior."

Fix this by adding bootph-some-ram prop as suggested by the commit
above.

Fixes: 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index 5b465e2dbd9d..2d9c9618ce2d 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -8,6 +8,7 @@
 		compatible = "wdt-reboot";
 		wdt = <&wdog3>;
 		bootph-pre-ram;
+		bootph-some-ram;
 	};
 
 	firmware {
@@ -30,19 +31,23 @@
 
 &aips2 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &aips3 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &iomuxc {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &reg_usdhc2_vmmc {
 	u-boot,off-on-delay-us = <20000>;
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl_reg_usdhc2_vmmc {
@@ -51,59 +56,73 @@
 
 &pinctrl_uart1 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl_usdhc2_gpio {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl_usdhc2 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &gpio1 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &gpio2 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &gpio3 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &gpio4 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &lpuart1 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &usdhc1 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &usdhc2 {
 	bootph-pre-ram;
+	bootph-some-ram;
 	fsl,signal-voltage-switch-extra-delay-ms = <8>;
 };
 
 &lpi2c2 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &{/soc@0/bus@44000000/i2c@44350000/pmic@25} {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &{/soc@0/bus@44000000/i2c@44350000/pmic@25/regulators} {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &pinctrl_lpi2c2 {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &fec {
@@ -124,5 +143,6 @@
 
 &s4muap {
 	bootph-pre-ram;
+	bootph-some-ram;
 	status = "okay";
 };
-- 
2.41.0

