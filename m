Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A2C7115B
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6437F88B0B;
	Thu, 29 Aug 2024 03:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8567A88A95; Thu, 29 Aug 2024 03:31:23 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20716.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB1D88B12
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVIP3A0mf//jGq0hC9utuAktOXyNBiQiEvJglopte4MsfFGVF+3ZhMLIgbBExko7RsWaRYS6/WdLTa7SStCnNZBzWC2WM30+Jb9BsmWJBSCiycojPxH2hPR+tc1Rd3DFJpL/xJGv79SDIdrgLuC9EOn6//RQQxTjIOCVlHws8QKmPJLGxgSNdLFdELSbDSrAAJz1zLb/kj/zjGa0NPn2rDDTZWecCCQL/51SoibYelycaorMn/U1Mq2HJ9O3n372HS9r5ODJx2jXYqD/1xJxZ9zo5puHbtgK9gIUGdI3UxI/YpCEp9FYAsigqH8ljAW+2LZEBNIMQnRFzVH5Ucp8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3f2cP+iaImk7tjj2GNiGNBKONvvdT3pwD8HEUoh/s4=;
 b=ogVSwOtzOvpIDE+NSUOeRmGcV8MdhRxl/e1NQeUvrp42bdKc+CVLR29zC5CtpFBScGmG6bEWwgtNcK02kgyoqwmefghcpm1Hvh4HKzevvk1fnFATqdD5zphtE2VhCoaMmrunvFwICNVaG0YwtTG/qr3VCunBYXR+JsxgXS4P4820ILXaHUO6Fmrk1ZpYf6hme8YVxN/JzWdMKkvtfbraQt40zp3RYrN2xiCIzs8N+d603d3NaX+DjC/i0uxTwcJDHHIlfe1VrqNdMcueRC1IBx1qPYdn97RNvRU8Bu/K7k+22Q1je3aW8FTYWnKkFTk9LnoGeqnWEGOJpW5G4Xuunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 01:31:16 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:16 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v4 7/9] dts: starfive: Add JH7110 Cadence USB dts node
Date: Thu, 29 Aug 2024 09:30:56 +0800
Message-Id: <20240829013058.6178-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829013058.6178-1-minda.chen@starfivetech.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0574:EE_
X-MS-Office365-Filtering-Correlation-Id: 30006cfa-9db4-4586-7bb0-08dcc7ca46c7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|41320700013|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Ydfw+QsWSWX3C66txaHx/7A0ign01SH3BbhyuVhgeW0O5vQdJjLMiLIBxxbPTKKyIoJ0uKOyWbpJJjjOyj2HFWxH35b0LNev+pJEcVOag5EoBtTGAIIzKY5iFtTKg51UYGfEKsVu0tO6KTpQaplZ6gFJGLUCcak+WjYJXSr1TqhteuCXyCLQYe/J5YODB6ERsX2ylq9RyFmOquWkqicYCzK9IFE2VPM0xW1VpAA59fbL4JvINjby/vEmCQ/29ruAG1yfyZn7CG3FuVZT1jGZw2LmW5w/9M9ni9XNAMwjlBfb7dAmCCwe9AStsI2sewzBkdFOseWjQ9bXf/GGU3hwevmIlvS81vNx3KD/VvzVb6hvf3IROARbYFy1t2e6ODkFwZuRKFaD+DNfhWXTvdBHaW5wYpUgwyg7oXVEpWj1hYxxitsgX3rqAu0ri+Ux2mtTqY8QHBBsl37HTNBSXcYiz0NHQkM6nCMCgSKMCTxW0dVN7y1nk46Ct7glL1Mo3JU4MhCpUqpvsHTNsmcQwxmFn2y63wjhhUk9TwB4hgoIt+Pbtc4YwNG3ZeG7vUhLlm7ekri5HT69Lov0HA5FYNdUHup1AlV03tqZsKegRoo6Q5i3FjkGVyM65nzS4MCjt0LrpV09304yvvbCasU1NV6Njg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVwpCX6kEOtNoX9q7PKSTRn42mDLOQc3tlvF67M/tHHSNUekzFRhw++iNPKc?=
 =?us-ascii?Q?QxS7YqNBNAH5iFVQ3NWPc3ZoPWFa6+FPJdpRYx90CK1Z4C7ppYAZeaaojGSt?=
 =?us-ascii?Q?yHWZgZWCiNEMdg4Exl+Qu3U5BVhGl5Ivx8giDDO+EIiLe5i05GHccfkzxoss?=
 =?us-ascii?Q?hnEppcZDNufhuH6ZZNqwx0lpQxP6P7VA/wixqogMClWHEB8BY6v/MX+wv6Iy?=
 =?us-ascii?Q?e0bjvJ7mUI4XJk1n/KPSUv68ZOmq/uuHTCGD1myma8UvpNuWJnLACIyVk5hi?=
 =?us-ascii?Q?0r0dm1sGG53YksLYByshx2MmbW7/60UCwO8EgjnJzghK9BhPSIOuftPu9i1q?=
 =?us-ascii?Q?9djQqR0kZW9BniErd/NTfjS7UzupeeDqYi+SvlCswrPBU8jSNDyp6kFUH4ui?=
 =?us-ascii?Q?N81l2mX+RlfTw8iGH2FanKfwnFr/hv1KA7q5EPZQFJuQEpV2XvCL6vS2xhgt?=
 =?us-ascii?Q?ntZRJsRbqHvmOeHK3YYGKgCFTT0PLFZ9oov6EV1nO7AHqC5o/A65+tvlBus5?=
 =?us-ascii?Q?v7/DApxsLllbX8NDEK81C1Myxr7aXmYL9aEZ1Gt80RbVlO6oumH9e+Z6y1yX?=
 =?us-ascii?Q?5EDvRuGTEOSaChKCXRjsU+lZ19QX8fqHlHyaDj5yThDUxRClO/qz6ye5qNxc?=
 =?us-ascii?Q?0feRcToF/LvVOsv+LJ4LBlPAX2YbeApigwRKl8p6Urh1zJBvz3GbzmWIhtv/?=
 =?us-ascii?Q?cNFU/5o1MhEHSjtbcew6WyeLuPtJwEwa9Y2jtfnbTcFOzguYRo1CfSkTlTMx?=
 =?us-ascii?Q?ITXrn5VD4nTiSrQXPxS4DzWqUde4W/ske5VXqRuhbvnpSxlewxmyn2TUOBpx?=
 =?us-ascii?Q?/qhNPPVDnFdvTytCpKt3WiZY1gnLnfOoguJFtqkiaKiYrTPuCDr7wdVKZchL?=
 =?us-ascii?Q?Y36oVsn1w9QhJHzc6D4Vmcf4JOTXuqCaq++ogNhpS89ygWYP25swamu7TUxK?=
 =?us-ascii?Q?eZenwgmZhC8Id7Ywv/1SLhjrxNHSFV2B4695q14KY7WIyUGx7OvfIVUSzbdc?=
 =?us-ascii?Q?osPRNt0wPeiFI7Imzcyw2AhIntIl/yNlN5bbKTVi6Zoew/OFoJdjEdlWeJBu?=
 =?us-ascii?Q?RfZnPjUYuvZyo4ks+p2/ka6dCFsY6Muy4joUaMRn4SXOhUYhpRod1Vz084mN?=
 =?us-ascii?Q?Fo3G/cMampLuRAY8gPyNqQY749Ux7BxyJtMugsOUUIztpLiCmYLZXAi18dLC?=
 =?us-ascii?Q?3z9GRK8XwmGk7Se/S5MHkANcjAuptVfh1/fxRtosHNhVihqSuJfyEsDw0VgK?=
 =?us-ascii?Q?Vn7neZaT2tpexvDsj5Em53S21QRaWT9al9aaY9J09OszPhzQEeAeDi2cBvO5?=
 =?us-ascii?Q?4PkdSt5PZPUYf8XAjg6azalzYmrKDqhguUEyT+qH+sVkNOfI/81WBRZaJh85?=
 =?us-ascii?Q?780Himh5ggWG2iB+CPtye11w66dHiNcotTkX//JES0Iye2d73eJi0trEAGOQ?=
 =?us-ascii?Q?g1CMiBHYKeaWTtsg5YkpxEhgdndBf3oyVxoWSo0fTocpryww4HT+tyrUHx+E?=
 =?us-ascii?Q?h30i64iu0KCdzpwdsJv+EKT6ocznd+JgSQutbMECW5s2DqQY7hSpLiM0dati?=
 =?us-ascii?Q?P89uIc1uuRk2WXH6QCe0LaPw1Mqu2hagWMk30KTZ24AZ8DLYZ3gBbtPv3CM1?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30006cfa-9db4-4586-7bb0-08dcc7ca46c7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:16.5271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFK4i2t92ym19jbmLpFcFcprNJ0IHxGXcLIYRj534DOj58vJ818SY19k7kHnVCAcM1BgVlZuZTLwGUh8wmYNMg4vBEwQjCcxz2ZZzLrQqrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0574
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
 arch/riscv/dts/jh7110.dtsi                    | 53 +++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index 2cdc683d49..7bf9b2a03a 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -371,6 +371,59 @@
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
+			starfive,sys-syscon = <&sys_syscon 0x18>;
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

