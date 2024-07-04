Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2ADC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41FAC888CC;
	Thu,  4 Jul 2024 07:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999538881D; Thu,  4 Jul 2024 07:50:37 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CCB8888AC
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7erEvpkUMvJolYCun/fPEeW7XhqvobSvEucOVwHb28cqUK+yl5anbLat6xe3E0ufnHRn46xZI2kitK2F2BKV4olpXVpiNTz1QFg0hIZBiMIwz0xM2UF/zS9MWTzz/fmG1a7VPhG136+nj7FBwlD+RZjErZqp/zdBKAmXnP5Vo/olKGLi6enXX1eUk6WU4xIntFQDqk525rfcwd49sYVlH33ObmjXe9ydlOhoIUSWsWFPgcAUXgPbQmYpTbgSuGhfrx19hRRrTWAw9bIf5PkMNWSSITNzgARygXpwkUxALdnyg2qKa7YFc28Db7TQPhtGt+dzMOhXvufYjdcRQFLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX8AXxxQQH111MVi9DHnfgZwnc5506PH5sCjL55gPwg=;
 b=Jd7jFZFNtZ3ZBZxYcactygBUfxc4SO90XQ+BEIIv3nC7iHeNe0tuBA278EYLseVeJTYLh+xoLb8tgLy3Yzevn0TeprPzi9RY/XMo6ve5vHEMCLp6kQ0N6HeSq610aP5uAy+zqbP6p8CimqqIrcnXihRgAvmoul3SLpwaOfv5nFZPd/YUlJegtZueQF0ubYNbVaZCrHVFpTn84XvukO8bWtxQ4PjQPfOZJebcdrMDZQxZ4fsrQX6HRFThQqzLiBviCkePzxCaElBg30nFd13aT2/bvGKXtvlTjObb87KaBd1liglt1PqkVrgKn5mfJEVkP5v5wdp5bJ37n5Rlc2hIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:28 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:28 +0000
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
Subject: [PATCH v2 7/8] dts: starfive: Add JH7110 Cadence USB dts node
Date: Thu,  4 Jul 2024 13:50:13 +0800
Message-Id: <20240704055014.55117-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704055014.55117-1-minda.chen@starfivetech.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: b1563635-bc53-4a0b-aa29-08dc9bed354a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: nN+FWttOVHLSI7bnWbqvhPhFQGOd+Vi4MaInq9MgjBSCVOWZYUSYfxjh/TWNLGXbn7m46m4P3erpznXcPBTOqY1ptjWpW8/C/D2cEXrNysK+vo6IokQCuq9FhPHiquw8fqP333nOPTW2v5VjLoMlfKe81O+/BRLgSkqHdONkrIhVCFL5AoEr0syNrA2ojNMSj50r7uaCPBoVNslA7lVjQLHZulYbnAo/YBRgGnvB0zyAqxumYrPY4/shJH20iZgMsy1H1wZGIuFytwgm4JpdDrhXntFDJ5+9mYjNyrHNJxmQK9YB/1TtRnMXZXrg7AqqCan4rWxuJKPv3nPx8jF0H4uXYT41nQ3xhJBnukUvQfyPZrDd5mt20R0wIX0Naj7fn/6Jzgos+FixWPjLEbAgML4x211ibgvXb5tEOqysNnpjcpKqNQNKH9rZq63FOEpfXkXBS1K5vCu8dgFyu3I6FynF3DnK0jrYAOsugLLfYOgsbDeYiESFTDOk3tWZRNn93s6esNUt82QuhrhJrr2KKYqlmHHK1nNa2Vjk1mzqAly4lxn8UjSgWfKRClsYqfdzFJV+4AEe6TX3GFcO16gZFkh8054Cm8aPs2ztbhRYloIlNCcuZhJNf6YUXEVOKn4sFUkfH6OlUeHfQzIJPyRTxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vBrNj/bn1ArRSHoi3FgxdH95TVVFNivfXUgdWFTZsjjjAQ5zWocfKhCJKmD?=
 =?us-ascii?Q?Kvak2485fZThajTlD5bpa7j5irH2O5afTTETbiJ6PawHcJP+nayj2CXYBx/p?=
 =?us-ascii?Q?hF8aQYP/mszvpFHebOPbPE6ddnIWvvHseLd8JqQmh8w8MsjLZADi2J7+UtdM?=
 =?us-ascii?Q?JXzmsL0nvSzRn3+ETXaJRf1ue43WEBJks/EOISBQ1zW2LznQc7i5f4bXKBSg?=
 =?us-ascii?Q?vSRf+PfnZaljLVN7LYqM1nLr09gOlQvkQgjcUopUzIz8YFRqMzinhwhweUbD?=
 =?us-ascii?Q?buI6mypqmie/eAGwYd+z83e7sdIZi3hmEyRLEjQTVc/LMcTD5VKhcX29eWcJ?=
 =?us-ascii?Q?fMd+OpmCwUgaKSAolqfdJEV5c77QV5Shz776GbZQZpzOPG1T2inYgVKPhdua?=
 =?us-ascii?Q?uXJchspSjel4od2BfWndLXBFgNKD4MMddMa4KGDk87WphcE2vTqIiHUPP9TQ?=
 =?us-ascii?Q?Acla7De1DrQHJetkrgkIaODS0P0vNZGkMV75wpqmc0w6wfwGLVIjjgZVIv8c?=
 =?us-ascii?Q?vZqrSjDdIeqPeaBbf6h7V5f/+8JOEkCGuNcb1tJsfroBhLRhWUKtktHIcm4u?=
 =?us-ascii?Q?qgxXGHRJCqm5cWzzvCFXlLn42sTX4IA0VtQajgnJVHMF1MMepZyD0a7G13h1?=
 =?us-ascii?Q?SWmPJ2Fft4wGWl653FbmTnUY08IQhDPtxPXh9XEkCTcLNXhgEOG1EiZoMrWA?=
 =?us-ascii?Q?bhGxogsAlk33XF1XJ5hDrwxJJm1HLgQNA3fZv6Th8PHDC8fqipyopLkZvb7o?=
 =?us-ascii?Q?oMErklJIw4EekcIknip03TiWKCYPcp3nvWHvEt9P5O/JmRP5evPkdvCNn7FZ?=
 =?us-ascii?Q?OrSQu+MjIRHzFa6HCsIkZgjo2sLZJGmbPEWSZ0M32GGK9CzOGcvX8v4EYubo?=
 =?us-ascii?Q?Ttqu0kullUBXskCJ7gyXj9NvjxQFwbITGe82wpqI60jqokl0gh2BpmyP0Ys2?=
 =?us-ascii?Q?AidQARaZK7uRm+aIU3aU4dhiaTQJV7P6WuL+V1DKGNo2PdC2/xsJVKXnYcPM?=
 =?us-ascii?Q?YzGiGql1yZ0xsUO832t2rKXMwKtSRqvLAIEJPO1AAspHkHOg6tKEiE8/s4dz?=
 =?us-ascii?Q?sdcnyrbUJ8Vu7SQX/GT7KWS8xrSO7t8NcFl9hmdzQq8PFXHnjiLnKZc1TtPs?=
 =?us-ascii?Q?BqATAD4c6vUb58px1ASqt88xhO27MTqOlJPYd8CVPtn2u0XjpbANRRGDtfAs?=
 =?us-ascii?Q?h6fxyRWD6lJrzAfi5z1ATGeZaORAQKK4I8NuFpPuaAZnkwhwei+NolhoKtjv?=
 =?us-ascii?Q?686sDotc5aXeQR8HolSItdkOrMKD9aDaqLfjZhokItO6itI+8xpCPQRWfmVe?=
 =?us-ascii?Q?aezZPf261dEUrQdaYfrJna5a5hyFl/8b/vvdvW3VlFQiJQK4zxI1rKD6deUv?=
 =?us-ascii?Q?Z+bFlxYOZs6giT3WiegM6D8EAkCsY/y2JgjlX7n/CslMu5WJv2YfRyoiAcf9?=
 =?us-ascii?Q?+DvVGvvuyHfAEyRsoUvOcV5N1PHvYF7lrV7zC0Fp5hmqQxwJDrUKkl/ciJmc?=
 =?us-ascii?Q?Lc/qAU1Kym1lj0cGEbHqRXnDdEm4LCrva/gaGqjWeU8hYToGl/POPrSRWTkB?=
 =?us-ascii?Q?wOQQYW+sFVYWeW7vt0ZV+bNwRDwuYg9N7+kdRvfL0BS+GxXdSgrXomVmR7aQ?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1563635-bc53-4a0b-aa29-08dc9bed354a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:28.4424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQjr8mNIKVvnsVVjADNgTmWGrddgR93iPetlNS1e8XRgIVe57YbNLnL0B3ynvmIHZLgtGREUS7EwVP6kysQuLlMyrUpPezicuTs/1QVctqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766
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

