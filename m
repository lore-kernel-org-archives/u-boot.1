Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B5AEF99FD
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E47783E60;
	Sat, 14 Feb 2026 05:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="KwZW9oRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F89F83E4C; Sat, 14 Feb 2026 05:57:13 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC6583DC9
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C22EE10F814; Sat, 14 Feb 2026 05:57:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771045031; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=7/SlEyQa90TL9NQ3PhVMuCbKTurajE5ub34XjTCX71g=;
 b=KwZW9oRfqiZyIep/PGq0WMeCqEwvGZukW5LPFKCm54mkdiYOpEHHRaRRpnjaH4xmMTfves
 DI3lSUOS73SmmJ2s61V0HtkQjE6x7FDMkGC4OVlT6mwC32bk6JE810bIocILz1SokA6v8p
 WqSWZf+tz9Oq+v6kqsi8uh1jmcr1GSfi8XIEkY7GEvpnFRMK/o8qiJY7f5/IgPZ9O8VLlw
 jNrheAFFywX9DuAvhHcqGW0degDywh7W8b0xefZHfYvImB4nJYfzszmNsIuRXSTI3O2O6l
 qTEVfZuTZvJUW4MDEQLGtxvayWhD6ypUpseeuKuciVzj3oQBoUKMmhiIwtVOiA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>, Peng Fan <peng.fan@nxp.com>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 03/11] arm: dts: capricorn: remove pinctrl_usdhc2
Date: Sat, 14 Feb 2026 05:56:55 +0100
Message-Id: <20260214045703.28051-4-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260214045703.28051-1-hs@nabladev.com>
References: <20260214045703.28051-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Lukas Stockmann <lukas.stockmann@siemens.com>

usdhc2 is not used on the Capricorn board.

Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
Added Reviewed-by from Peng

 arch/arm/dts/imx8-capricorn.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index fab7ef95166..41f4b2f646b 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -66,20 +66,6 @@
 			>;
 		};
 
-		pinctrl_usdhc2: usdhc2grp {
-			fsl,pins = <
-				SC_P_ENET0_RGMII_RXC_CONN_USDHC1_CLK	0x06000041
-				SC_P_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD	0x00000021
-				SC_P_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0	0x00000021
-				SC_P_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1	0x00000021
-				SC_P_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2	0x00000021
-				SC_P_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3	0x00000021
-				SC_P_ENET0_RGMII_TXD2_CONN_USDHC1_CD_B	0x06000021
-				//SC_P_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x06000021
-				SC_P_ENET0_RGMII_TX_CTL_LSIO_GPIO4_IO30	0x06000021
-			>;
-		};
-
 		pinctrl_fec2: fec2grp {
 			fsl,pins = <
 				SC_P_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD	0x000014a0
-- 
2.20.1

