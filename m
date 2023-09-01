Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D999CA0FE9
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7801386795;
	Fri,  1 Sep 2023 08:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xFkigZBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7146586776; Fri,  1 Sep 2023 08:15:31 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA2186205
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3816FPtn074596;
 Fri, 1 Sep 2023 01:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693548925;
 bh=dKe/3GGnbLIzWb4JXUbml6T8OyWj5VRbjySOHV5Y+xY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xFkigZBBPO5YweKDauCtf1rwHNgQsi+CnNlF3dMYyWixlphnN25n51qROsi1pOqDn
 YqHeN+8egZwu/Uz7MBS5LoWdBvuN0AyTpUNqCtEqEeX4xBJlhaTeO/BcpcTxrM2cY/
 xUbwFCpc2Ru0YY1belHSVclwuwyFEnsuEKmhCNQ0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3816FPqP029877
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 01:15:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 01:15:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 01:15:25 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3816FF0N047686;
 Fri, 1 Sep 2023 01:15:22 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 2/2] DONOTMERGE: j7200: device tree and defconfig update
Date: Fri, 1 Sep 2023 11:45:00 +0530
Message-ID: <20230901061500.2342452-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901061500.2342452-1-u-kumar1@ti.com>
References: <20230901061500.2342452-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Enable VTM node in device tree and update defconfig for vtm.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi | 9 +++++++++
 configs/j7200_evm_a72_defconfig       | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
index 1044ec6c4b..5e647a7cf2 100644
--- a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
@@ -53,6 +53,15 @@
 		reg = <0x00 0x43000014 0x00 0x4>;
 	};
 
+	wkup_vtm: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		<0x00 0x42050000 0x00 0x350>,
+		<0x00 0x43000300 0x00 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
+
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index ad8492a17e..b4b99dc863 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -178,6 +178,9 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_HAS_CQSPI_REF_CLK=y
 CONFIG_CQSPI_REF_CLK=133333333
 CONFIG_SYSRESET=y
+CONFIG_DM_THERMAL=y
+CONFIG_TI_K3_THERMAL=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_USB=y
-- 
2.34.1

