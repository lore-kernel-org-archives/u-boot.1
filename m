Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA14C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88ED788261;
	Tue, 21 May 2024 11:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716284523;
	bh=cj2oz1Stq1/xZPKQT3sZehVPbsIBBmuOw7Wgio2oseo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Nnvv17XxiqGEkJqQ7liIcNh2Wv8Gsnc3F35Q6ZSLwx0iEABJSrryoIR2SAhmrO4Wt
	 iCXnwld8uJa2KrvTTPqYcLo7uV+xvMQ+RD50lOYleOOuchy2YrxAT2J3TxkToQePus
	 hgJliHHvZuV3E5/JfOO3GLKzPlffy7yaLs+0CpLaGhkjyySthRso7Ua6Jql7rZC2dB
	 PagGNJ1S4w6xJjIAMNjl4PQ0XXsKJvO6ZxA2Oqvl1buIpLYymUtgueXBq3zPikClTn
	 zCw37w+FigFZiL1UmbE70ky0aFn73lZKlVcHBXASKo8aD5XvuSEc/CqCYqPAZAiQZ4
	 tR2HguW4nfWxA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 79C1D88131;
 Tue, 21 May 2024 11:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716284522;
 bh=cj2oz1Stq1/xZPKQT3sZehVPbsIBBmuOw7Wgio2oseo=;
 h=From:To:Cc:Subject:Date:From;
 b=LkSW2IT7RJkC3zBNa+7X4VCoqP+FdlG+r9pbV0xRBb1V66FGJAZQ4F8xVEUUm5xrH
 0ui1S/2XyRao6ZEEOHChaiMHxaMLAl9GupAXNExkkLlZKSFzEMQqiY0rwjJtuJwvU/
 NK4k4YDOhPgx/sUH+UD9jxAi7U5F+v+3vNPnZldUweviT0ZJWyE3V0NenmDum8++Z5
 Fq8OC7gl8zbwTUbT0aprKylZN3QSeLSU+bUrsiiSdU5oSHoweHlQ7VSr4BOBokkPHs
 IWxneQsHlfWJhnWwhcZZq2uAEM4gyOmWzDWReRf/ErCfCIuyi42GuPqAu9FwpWFE/X
 5jb4UbRqsw4OQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: dts: imx8mm: Enable CPLD_Dn pull down resistor on
 MX8Menlo
Date: Tue, 21 May 2024 11:41:33 +0200
Message-ID: <20240521094146.8886-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Enable CPLD_Dn pull down resistor instead of pull up to avoid
intefering with CPLD power off functionality.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Philippe Schenker <philippe.schenker@toradex.com>
Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx8mm-mx8menlo.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/dts/imx8mm-mx8menlo.dts b/arch/arm/dts/imx8mm-mx8menlo.dts
index 0b123a84018..c226285c6ea 100644
--- a/arch/arm/dts/imx8mm-mx8menlo.dts
+++ b/arch/arm/dts/imx8mm-mx8menlo.dts
@@ -290,6 +290,28 @@
 	>;
 };
 
+&pinctrl_gpio_hog1 {
+	fsl,pins = <
+		MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20		0x1c4	/* SODIMM 88 */
+		MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1			0x1c4	/* CPLD_int */
+		MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2		0x1c4	/* CPLD_reset */
+		MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3		0x1c4	/* SODIMM 94 */
+		MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4		0x1c4	/* SODIMM 96 */
+		MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5		0x184	/* CPLD_D[7] */
+		MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0		0x184	/* CPLD_D[6] */
+		MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11		0x184	/* CPLD_D[5] */
+		MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12		0x184	/* CPLD_D[4] */
+		MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13		0x184	/* CPLD_D[3] */
+		MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14		0x184	/* CPLD_D[2] */
+		MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15		0x184	/* CPLD_D[1] */
+		MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16		0x184	/* CPLD_D[0] */
+		MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x1c4	/* KBD_intK */
+		MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x1c4	/* DISP_reset */
+		MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x1c4	/* KBD_intI */
+		MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x1c4
+	>;
+};
+
 &reg_usb_otg1_vbus {
 	/delete-property/ enable-active-high;
 	gpio = <&gpio1 12 GPIO_ACTIVE_LOW>;
-- 
2.43.0

