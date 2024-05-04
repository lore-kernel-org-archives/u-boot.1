Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDDEC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 15:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B62885CA;
	Sat,  4 May 2024 17:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD1838858C; Sat,  4 May 2024 17:04:20 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCB0885B3
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 17:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiATSHzYaP43+eRFVT7GoJMCD57hgLQPt7Q4ahgpU9H0554Ozaabxa+ttixZLFimgvZCdWSguMim8uKLGUaAxGr/iMIXzUHAcGlejk0MABh/6FcU38SYgEBPMNDTmdya/ZI3qxZyjqniv4JD65DJoKg/P2ZF0N7QsPSUqh27FFXBo+EHllt6OAPXDs964BcTbT4S8JEakXR+249JnbYRNBksuoJpxwLOQ/ScYOoFwUI6h4CSdK9zNAlKjEeaj/OAeEdJlJEhsk866WOw+QILLO3Q3W/qsCXgoqT0fYNL0iGiltl6ew/jRWETKsEfcqjZ8AebW1VjD7uy2+hVlwPdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX8AXxxQQH111MVi9DHnfgZwnc5506PH5sCjL55gPwg=;
 b=WGB4rLEHwIheKyfhqQkfu1jsqfYLNxcqynqd4Jr9qStCnWpN0tkfkM8NFIVk5A+H4D0Io82SLGoYL6Oaf42Wpc3Bei1XVJfrPkrcGWoNmhaejJ8JALx9GDJljZiLooUZnY1W4rzjecxX7JZCkq3eQ/gaeZsz5GmW61yQdQSR2+M8PcNz1UxNdDhncQhSbuKi/3bMsd1Cuir2v7DyCQRjQmgPRshK+4WcrS+EWUj1c55DkGDxAmkHBNzZI7999sjvm7AG9p0X5opWpJpS/UFaeel4XX/XHcTTdwQCudFWqkAj9lKJ5aY/GHf2Of4Q9AAYCfIlbTbxUirkXiXf9MAhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0839.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 4 May
 2024 15:04:13 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::3e54:57b5:e3e3:7f09]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::3e54:57b5:e3e3:7f09%6])
 with mapi id 15.20.7472.044; Sat, 4 May 2024 15:04:13 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 6/7] dts: starfive: Add JH7110 Cadence USB dts node
Date: Sat,  4 May 2024 23:03:57 +0800
Message-Id: <20240504150358.19600-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240504150358.19600-1-minda.chen@starfivetech.com>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn (10.2.0.75)
 To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0839:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a7fee9-1413-4742-1bb3-08dc6c4b75da
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gAW5M+IcApMoDPt+9dKY4PZis1CYM7tRsun0lq0A5AU5SKRdd7IWV8YvR7gnKgRmzAVvDcQ7ye6hk2cn/UPVnJuQG5XQMxwUIppFiQxSw4+BqtjwBQ5aYTKv42m/tI3mbL8IAUCQnhqYtvwXw77mEqfG3z7HhhxYq/FIx5mcr/gask530HNFpuSy4QY6kpqYcKyuQz1h++PzU/zVkflUJqWTcMO7Xa6CZLLU6gNcrfmiGbmV31TJcfDehH+7Nh6IRmLxkN1dlFvOkQIb5Jo+qpcWyiJI2LskDV9EUxfQJrd68n0uRzoL1uXXP9gVSAY+vnzUv3rTms3N6cXZUuCLAb9i3sAvrKcE41LDMkp1rTxVwBULwWMuB7MYGEIXeGHZoNxg3YtA6t3gST9+Rwb26kxi+Rin0IWfp83Mn1HaqX8IP1dhDJdydWfZY185DxV88CIARc+cGIlN3cBpEI1GQvDgtBDHFWrUa5c/oQnEIiujlYlEih2GEfx832LIicJYhry1MNl6SGuBOZoaacne3mUo4SkGW9HBoaiuia9ekV+DYpwT2+/GErovZ7hPk9j0jVcjIPHNwfWBdS+kLg2Qe0e106WsXjiZQN1uaRglWFRAcMfaIaGhRsyi3t2lexznrBqHcDFsJy4q/dJ5Kreiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(7416005)(38350700005)(921011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?56QoVZMS8fTzLmr/xI/LZBoiAu5yvoKJ+lgIhRe5vIB2bxMs6yYCakeE5soj?=
 =?us-ascii?Q?eA1dUcuOiLks3INELPejZusCp86MchOCMKXXVBe6ivLEvti3b6t4nUYKLxLt?=
 =?us-ascii?Q?mfvAKbUemk0df2VEbVVpB3aJTIYQ1AtB+1yaW7g8r8Q47skr8v2KDFCEyBqI?=
 =?us-ascii?Q?8RaFm7FgGdKcl9GDZ+c/Jpj1tSafBRh2fh2Jt8bY6EfP1VBJUCwkFk/rFdGV?=
 =?us-ascii?Q?Y0z7wdthncncnijaGZ78H5Lf3nf2+od+Q382oCo4WjjwbjASEO0A0VAMCepY?=
 =?us-ascii?Q?+S8EJ2M/6iO7+SkJb7tXTr9vEc4SZm7LT1eu6b1KL5/L6lTN3uNGXjXhr+ys?=
 =?us-ascii?Q?/h3AO9zkDmt6+BByEhBEWtCw+m8tC5gQxs1MClhFZmk8TrqpF15rwxAw0Z7V?=
 =?us-ascii?Q?d5x1Q18wSjri7zgbv/VlTBqNLN7iCTWQ6+aSn3oPrvMb/BAwUmxzu+pLMHjS?=
 =?us-ascii?Q?66Z0uuM0Frz59aM6MA3ekwiWQF8L2v8gZjmrbIS5WqrAk23ekspU3VdTLscY?=
 =?us-ascii?Q?UdHtNOse4yNb/zASnChr6vZDM1jnP+CaoN9qrC/cd7S1nRQKvXIBc0WoOXSs?=
 =?us-ascii?Q?K/PS3F9xjecf/Eh4LoACFkJT4oiAbnXZkIW6aFv8NHOmggdzNb8ZRs+w9ZpJ?=
 =?us-ascii?Q?8grBYhCO8WAO9GNhACrn+3cKRPmaXQg4AyLRvDPaa6WZY5zdT6y8cMscgVdg?=
 =?us-ascii?Q?v8thWwmL69tSnHpJkI0A5VgaPXkqfPv/hW4ADX2R3qPUSgDqseqz4jwbszxZ?=
 =?us-ascii?Q?GoIWVk9+J9WtSonJ4T5bNKasEANSF707zpezqoBCzsyZMAssLI7YRLUsGtZy?=
 =?us-ascii?Q?EeqyTyHShAXIBTQipe5UL5iSTn3RWKUDUHnY5Mo65uagbicjmQ/itj+yW4a0?=
 =?us-ascii?Q?fyp6lqUTPxRQ3JBw8QNWUs7lLawH9jihFV8aJ7YTqf1Ov09PHAKZnb2cD0OY?=
 =?us-ascii?Q?FS6L8HLJuDc3SyoogM5rXcy0JarDJdNDj3oO7V2aEmq6eVyznalv+rBtOFPp?=
 =?us-ascii?Q?Vx89u0WaCAwMtoht82wMCIFLLvwmah8cAuPQQa5kq41y6/2QssbSxf0FQUeE?=
 =?us-ascii?Q?aGVkSFicr/KjzqsRgvqUpKmfO8/WuUiR+qSFD7Dmqiwe3D0Izp8TkurDMKuk?=
 =?us-ascii?Q?Rjx4uI5kQi7/fD2qrje8f5eVj0eAw8XU824XA+80+ZGyrj/EgWVEJgq+QTte?=
 =?us-ascii?Q?mXpm71el6nbXZTC91XMPxouPOYrlryXfMtyBaL+EjZB4/hg9opo73mz6L3rU?=
 =?us-ascii?Q?3N3nYsIpjvAm2MpU79uuUjvJ64b4pxQVcyZGCZRmrSPetZ/gmmjWaIWP6O5b?=
 =?us-ascii?Q?bjfuFf3JY3rxLkU0G8uVeT1XcAVR07fQ/Rtd/xwaEkYcOUHZQ9EwBaqsWdFE?=
 =?us-ascii?Q?KxppHi1zok23y+EsOhJt5Baw3rsFOiPTMl/DxNHMaNplI0Pq/Em6YcWxfPOh?=
 =?us-ascii?Q?a7FxRUmO9t9VIbHF1QbtnOQsHzP4mKxAm5knm8i2x7/GRHSiWBEZSaKGSRsg?=
 =?us-ascii?Q?qMRoS8KqzfPp4KaoKdr/6+2v9WEVjNWmKRAYqG8kYMwsPGSVPCiQa7Fz8rIt?=
 =?us-ascii?Q?HYc796XgxpHcWgrc/dpxl01stP+sLD705iEZETQSRHXQXRg6lXya2fcEKg9H?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a7fee9-1413-4742-1bb3-08dc6c4b75da
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 15:04:13.6566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cecM2/xcHP3VlJBB4MJpzRWwokVkv7PVnJTdTG9heAVFWF+0OI9iNXHFx74VhyoOUOXtKGYQnQegCD2QgVuvrbu2dMUZaO9OkdjM/CQJES4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0839
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

