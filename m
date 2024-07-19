Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E2AC3DA61
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7755788B23;
	Fri, 19 Jul 2024 03:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1F6F88B46; Fri, 19 Jul 2024 03:38:45 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C75D388B41
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu/YXbzkyWzV5ezoVtzWP8Ja7xPXipx7Ea4pHe+x33aFR4NraMgH6a3mXH84j4S5YjBXNRBMWvh+P3p6HddVuF5qdoWk3vL7PX5gJMADXPoS0wUViT1+qMJVeVqHBePmYL3i+0UKaOKY8HKa8KN8cXdrEvweFO10pdrhqzEtrcCTclXaC2hk648DUsSMaWYCHgRpaGvi5keb7N5Fn2kPGh37ipyGw11hAj6POITh4SsSBr2BCG0MfuPGSbCgTfPhmFrPkvXBBUlFTAvUV/IWCGeGHAZWMdTrSl5GcgrNbFrD7lVuesZsuC4PkucADBaSr2sQscrIwYHcdXPGLwoqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX8AXxxQQH111MVi9DHnfgZwnc5506PH5sCjL55gPwg=;
 b=aK02mkv8dCJdZYnpK9Q/Hw2ziHuPeDnsHA9jewiyjqJfGziTZwft10oSsnz13mrloFQVMzuSoy7wLLKSBJHc2Lww86BYMyd1PUm63jgZd9LvOF7QJI0fk29gSXhhplJ1cmAWyfd/7EbAL70PVrpRo6oSi+st/TbfrHE1meBbZ9gHuDlAa6QiJFECGAB4RQCcoMabwVJMFYc6XSgfzDTIuqfzfiEJmAkCBN89nyA+N3pDfM2QkRIudgaDyOhYNYCfd627jj9Ii39zDdg0FTVARKdQuAqq11777XzETUi+XV9So46GfL3mhn/SgKAbji8RUUIsNjvI5vcS7RIHKrKyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:37 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:37 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 7/8] dts: starfive: Add JH7110 Cadence USB dts node
Date: Fri, 19 Jul 2024 09:38:21 +0800
Message-Id: <20240719013822.101374-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719013822.101374-1-minda.chen@starfivetech.com>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1282d0-ce9a-4e13-3436-08dca79382e6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: DvUTQgtPKK3Ke4/2GVoQ4GQ9PEdk4I+DCD/MTV/IUyx5vzzN5Ju5FQ7eMiH8/F2NihhMAdYQIyIKF68mh5Dw9RR4tEwjNINBj+8NvZu0SHCo4oeVjIJyijp2QU2eLyCOKds88gSzekqsDr+HAZSjhKYMhADuUyMUF2QJLYnsHcfJCsm80FS+ot4pW7ZjMdkxX1NfKbDA8UWkggKA1LZ7o/l3q3dPjoruXl4cmJaRudSnFoi5V9IPQ3FFcRaRt+wVyclagfyVfHlxz4XL4OOHC0vVmpfNWAvbTug9um+udp0SwUFjsoJFrkefwmcEk6tg7JgUTHy+KToOL4bPAC4gX+v10cDmScU7doYKFKumirsRJAogKpoyrGP15w8E9BrpPSZ6pZjBvxCf93mf2vTHlk0QrBF1tySbr6x6eTFN/TKPPAizJuF4Ky7vpEsfOYDvmWdiPQucpMZHUdB5HsnWwp04+Dxt7r1pfDNWDqAO/HxvLAbVg/pSYloWHLJEMpu6NDyGykWmnA2nWKochTCzNZllwdTSAbQpttXGSEQ2PZiPyWIy573XzQ9yyK3fC/7lHNtKP+tO6bbK2lIew9NgxL1m2sOFkwBID9dmWnmOa3q+oUMCUFUJomxhFB+1Gn9clhFEdIOBpon3dudmWLRBuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7uFqoBgxdPVy8Z9yk8J4PBqOYXboZZdFVek6P1GGQlvhMQijImPc7ICUhwnI?=
 =?us-ascii?Q?IP33QUh44ftyPQD7Bz9dtxcYUZX6X+KnlEVEsu4J1SHigaj+ZcHiuAVLuQ/f?=
 =?us-ascii?Q?ldkDyQv6Wt+WqcMyrpPhGz6opW8Kj9eh94MDnU7dxdOTkkUoAmXGYpAT50VF?=
 =?us-ascii?Q?kTWLhgB9VfrS0qpUzreJDlnM1V0zqosQjDrBiB+pFc5b7z6sBw81+pKu6Vik?=
 =?us-ascii?Q?oJLqWIbE0WFPZNa71J7HrjPKlnEXdQ7Xf3pce9r5LW7sG5N5ok3obV58R7KU?=
 =?us-ascii?Q?nPnh2Se5vU3ndBL6oD5Kzquk9rB4IhHia1B7ctU8xR7K6VwCUn1juAIdptuS?=
 =?us-ascii?Q?Gyq/ZpaMgU/rakdNnbaIPwlufeAdBtBlkQyZcJFVw021autfUgSnHj28MXN7?=
 =?us-ascii?Q?+z8Qhc6HvZZ0B7EeniE8LttVvVbAhI3Gar7sRtsf6AnJN+RdXYYdljzbH+xi?=
 =?us-ascii?Q?QAx5aXpIKCutEuUVttn9KA7HXhzJlfSlBCAVxTNN+y6ASB+MgxRl0jJMEU1L?=
 =?us-ascii?Q?R2zNtfdM8bIR2dR+wFE1guPG+TskIt3McET08gHHrhmWEwiU3HEK9U6XWPde?=
 =?us-ascii?Q?FIoWO7F/H4uXflLmVmB7XvYB9OOO26P1pVJuENk0wLT6txREHvfNJF44S4f+?=
 =?us-ascii?Q?w30XAFDPJkrRBGzeL3amiMiHyBFQ6NnZ79TBrjbkl4VnTg1B6MLKLTbuY8fK?=
 =?us-ascii?Q?9KvSup8ppOTv5I1zdhuomrp1tQOUonD8MoAPqk8J/s7Fwq5eAaJujGkCMjxt?=
 =?us-ascii?Q?HYABXfL21/SauEImCNb6vRUDY34Kb0vBxuxEN/jS0+P0/PVViDV5k5wQyDDh?=
 =?us-ascii?Q?DW2UmgDH7/X0CEPqSG8Q5zveixL8xWweS5Ydo9PbCGuEpWqJxnWwAvmzn+Qn?=
 =?us-ascii?Q?HlqQsC3sE2UYeOHKXzk4eTD8l7eC5y77Be5ezcd/kiGAd5pmKCOXpGtp1nbZ?=
 =?us-ascii?Q?IF43JrEsYIDC4d3I3ld4LpenEb1ABK7FgX47xbYt9fPx+3B8uN2iN4Y9buAp?=
 =?us-ascii?Q?k+ByNsnevGvBO0Uz8xw7BiiCOolipV8hAN/dNtg5b4a+vsda7U/jJih6fIIc?=
 =?us-ascii?Q?6AKBWZozwIzImNPYuJVERsrNRKom+D6Cma8eWTaUJvffw78UcXY5sElNoGog?=
 =?us-ascii?Q?CZ29o8vpdGlmrJ+09eE56kHvXtOSTk44pMxsy/61esuVHx6COuB8vEdYto8T?=
 =?us-ascii?Q?ADeX8LJim2DiszdxLVW66u7AhuKiCWiLwwywURTnwJ+GOg2l/a0Gt71dJVcy?=
 =?us-ascii?Q?m0/QRmiUF5feeUnkh+oROQvWBKT/nYaXTHPD+qzBsPb534AzJfWBhHOYtPS1?=
 =?us-ascii?Q?2Cj1IKae1DpHsGM4/szxPFSGR2wwCT3avqp/s++5IR1cQjrykFma1aGQF+dw?=
 =?us-ascii?Q?SmnC72JB+znv26cnhKLT59CoAvLiVKz3/HBjQM+ZKTM7hBtJeq6sdPQdlexI?=
 =?us-ascii?Q?MDalt6b0pdR9TFLUrolYxYGmiwXF4yWyE21oQvil5+u1RrSlEJ/iqM1bt1Kp?=
 =?us-ascii?Q?mq/kKP9oA7/YT9rzcW+QOFSFzWVbIMjC1LGrCWSOAxloaivs40SbIibbWrAp?=
 =?us-ascii?Q?nEOseRh2kkEbuoTHMvyMAgAVMmM68GegfUUtBPZxT1fyJT+TbuqWBX6XUPXc?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1282d0-ce9a-4e13-3436-08dca79382e6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:37.8997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdkaaMyCuA+6RgYge54flbzfiiAVJeIfSTsjUcXpDipW40eiTSgIY22oazb89rbcC//j4FPd5Ue5Qihh2x7+UtNLqgx4NL+LzjaLnXMPKYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623
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

Add Jh7110 Cadence USB dts node, Visionfive2 default setting
is USB 2.0 device.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
 arch/riscv/dts/jh7110.dtsi                    | 52 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
index e11babc1cd..44785bbee3 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -378,3 +378,8 @@
 		};
 	};
 };
+
+&usb_cdns3 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index 2cdc683d49..1eee924e1d 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -371,6 +371,58 @@
 			status = "disabled";
 		};
 
+		usb0: usb@10100000 {
+			compatible = "starfive,jh7110-usb";
+			ranges = <0x0 0x0 0x10100000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			starfive,stg-syscon = <&stg_syscon 0x4>;
+			clocks = <&stgcrg JH7110_STGCLK_USB_LPM>,
+				 <&stgcrg JH7110_STGCLK_USB_STB>,
+				 <&stgcrg JH7110_STGCLK_USB_APB>,
+				 <&stgcrg JH7110_STGCLK_USB_AXI>,
+				 <&stgcrg JH7110_STGCLK_USB_UTMI_APB>;
+			clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
+			resets = <&stgcrg JH7110_STGRST_USB_PWRUP>,
+				 <&stgcrg JH7110_STGRST_USB_APB>,
+				 <&stgcrg JH7110_STGRST_USB_AXI>,
+				 <&stgcrg JH7110_STGRST_USB_UTMI_APB>;
+			reset-names = "pwrup", "apb", "axi", "utmi_apb";
+
+			usb_cdns3: usb@0 {
+				compatible = "cdns,usb3";
+				reg = <0x0 0x10000>,
+				      <0x10000 0x10000>,
+				      <0x20000 0x10000>;
+				reg-names = "otg", "xhci", "dev";
+				interrupts = <100>, <108>, <110>;
+				interrupt-names = "host", "peripheral", "otg";
+				phys = <&usbphy0>;
+				phy-names = "cdns3,usb2-phy";
+			};
+		};
+
+		usbphy0: phy@10200000 {
+			compatible = "starfive,jh7110-usb-phy";
+			reg = <0x0 0x10200000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
+				 <&stgcrg JH7110_STGCLK_USB_APP_125>;
+			clock-names = "125m", "app_125m";
+			#phy-cells = <0>;
+		};
+
+		pciephy0: phy@10210000 {
+			compatible = "starfive,jh7110-pcie-phy";
+			reg = <0x0 0x10210000 0x0 0x10000>;
+			#phy-cells = <0>;
+		};
+
+		pciephy1: phy@10220000 {
+			compatible = "starfive,jh7110-pcie-phy";
+			reg = <0x0 0x10220000 0x0 0x10000>;
+			#phy-cells = <0>;
+		};
+
 		stgcrg: clock-controller@10230000 {
 			compatible = "starfive,jh7110-stgcrg";
 			reg = <0x0 0x10230000 0x0 0x10000>;
-- 
2.17.1

