Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353C5D1A427
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC9D88B9E;
	Sat, 12 Oct 2024 05:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B547988D10; Sat, 12 Oct 2024 05:14:02 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C02988B55
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8TTxJnS2SHCsGbVLSC7rU0yoBnwathO5/YxatfvZ5aljpnXpxt9tajKN2Y/jSrfoWAqqmOw07dOvZ1EZVw59eaNvAcnYo50Z0AW/nmemEU8qKmO5vhD4dNuM3qp9STfR3h477VpUIQUwWpc+ZIIHHJST4V1/kXpxvQgXoNcvl0vC8McwFpDKxuFLOnvEWRVvlpmoC4R40CiY9P7op3UPO+EeBKuZ7AyUpKbH3YnluuX+uIdwOouUzkyGfPp4jkdT5dzesk/84HCu86fslg3sk1En7mIhc+RI15W51rje/LGQ4pzuP8NJAKLI4VIWgrFoebdbnN4EmVtWzv3zwPlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wye2mPwBSaW3vaVCuMr0gSEIeVO9LAsNokz2na894qg=;
 b=CKd2O+PprZP0XQ4Uf70xke4YBtzMtZKw1ccpVXNLyhJygBmJZUhN5klMDghsAHbdAvxGlv6jlZhTVvhfuqokLEsIC+D9rRYhH3C/UmdxiUIU9Ss3rXjpPTreul2YYiwMQvGKnqJm1KBGxLUudcsket+l9Lcf1wqTG/DlWyB4WVK59VR70Q/CgGV7WP12Owy5TwleR4Ucailo64TE1X7W4n5UmIiRr9fpIF0F6RCQGkdzRswDcRI/zbrwOA1fjBn0I7FyCu2xtwQK6IPjzqQUiDuWuSq7hn7FGqm0MyXt3uRJmkNX9Z71FwySFz/W46s2yVreoinSyr9rkP3hT8yHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) by BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 03:13:50 +0000
Received: from BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 ([fe80::480b:a135:6e33:10ff]) by
 BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn ([fe80::480b:a135:6e33:10ff%5])
 with mapi id 15.20.8048.017; Sat, 12 Oct 2024 03:13:50 +0000
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
Subject: [PATCH v5 7/8] dts: starfive: Add JH7110 Cadence USB dts node
Date: Sat, 12 Oct 2024 11:13:27 +0800
Message-Id: <20241012031328.4268-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241012031328.4268-1-minda.chen@starfivetech.com>
References: <20241012031328.4268-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::26) To BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e1b75b-3a2d-452d-0060-08dcea6be4de
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: mkJUj0rL5lGL0Nk+TiETydHKBRQWDC+36e7FixYv2+XgsKYdtH3qzCAHIMv8Km/m3+xQABfJUV0P27wBX/V3PeCh71IH+DvPZE7IqvxQ6/8vJ0Q9s+fL3uNG2gjulMeYY62m6Y8VJgQbcfwVrolCcmaUzxzc0WN6N/CfuIO9trZji7jJE1kMZDsIElE8okT3SmGZauh/+cRy+0T7uEWMyWSBdF5O0uH6kNHrOUNrIdA9Vc0+omm/wyyOBEdFOPwnZ4/HcUCXTUaim77MOQw++EqIxQv2JmCR2xOAcbXQcqLXhZwo16Y9IpqNhY77bjzrppseick8KRXUZ7SAOFq6L4GPvJwABCOXEmfsQ/S0xc21bi9J1HJxflYlyqSfkecDtNXjnHHMwPuG1DyG4ai2RnQb/Cv5N00G4z+k7pGs6TYFInyDvmytFinEmYS7sONn6nHnD8CaZoj516XvO47EwVYAgixaquIReiOpxH+Qbbhu6wmWDgHAZZYh55nhdBXKRZK1goyJsjuw51HNCTWOo02fDpag/zAzlFHe9MugVuyCmqn8hItdqqqfi+AuMK4xlSgJ1NsSMEBSA3QwLwCbQ87QvvhGJnVAdpTqs2FXNRTfbUMZb4SiZpTqMnKK84BcPD3fCkNAMXQ2zc8nCKq8Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yPfhkHXXgIKYM1vhnEq3Nj3SEa5WdIwJnFmt8sUsw+Eg2lz+VYx/q/FfHSHc?=
 =?us-ascii?Q?mEEtV5crZx/yY+PRJSeSRnxle58hTTwrtEcZE47sfxxxnGj8Kb8+llYaoI2Y?=
 =?us-ascii?Q?4TBALaziohil/VT/d2rHBPF0hPNlkMHO4yxMs60AI2Qm5HR/O6YUrO4+biEE?=
 =?us-ascii?Q?MkxugRfFq4NQyJwu3FtuyxAgEsKddDM8VDJbPIzVQS9eEWr+pgkl+ZDLk6sU?=
 =?us-ascii?Q?Y3t4b6tydOuGSr6PXTUFmaiou2oCPxLb4Akib3zSyv22n0Y6vrpHu5ffgAID?=
 =?us-ascii?Q?062nkGEVrlIHjW7cDuzSzyizpfyiya/Pqh0cz3A/38mi3aK5RBqqQu3xuGAW?=
 =?us-ascii?Q?ZzjOoSX1i79W2JN6CA6GJNgl5U4i9TOZ0qcSDlGHhP3eB/Zhx8EDTkeKt1ae?=
 =?us-ascii?Q?EaOqYWY0L1YIje0ctfUvIKmieQ+ozwQJGcp/SoPPhq7LKye/CtKaNbARHe9d?=
 =?us-ascii?Q?3v0VuPL7Qh7nhq5TCiZskXwGhUPg/SSRL7ZUe5ejIzNg5cjBXL7tUQZ14PEh?=
 =?us-ascii?Q?/yXD1grk/MMnNZlfWV+SN3c4IU/Wy7yWI3PSVOoyf5tXVbslkUk0I4IOTnTK?=
 =?us-ascii?Q?Z6SzvMm//p2R5HdCFuavfCkYALGq9cJb+/zwDIgCz3KJxNequpAI3cRvpHR/?=
 =?us-ascii?Q?h/5WJNhyfp3PIdDa3PaND+2+IXHoHAWAZWBnqIOciOZjgvM6v4/7baj/S4nv?=
 =?us-ascii?Q?IBp5ICj1ku1YdTZqOwMpD7FFY5WisxMlbDewU8/9H8s+07A2bUC77dH5cJRE?=
 =?us-ascii?Q?yrbfHCG9eXaYDMIFmHBfc3ZT4RMoU6RhVOLuR8aUKEAT8NEOnScaFM1vWqgA?=
 =?us-ascii?Q?wQPjxwGqq9lw2iAOtR6aJIrLClfiyx1k0o5Pf4JcVR/5C5EtTXIhQne8t4Vs?=
 =?us-ascii?Q?0fc9/sVDtwfEdWy7xkg4BdwREIczWnQWlLxFzoAMRInhT5X7f5BwijXZGN1L?=
 =?us-ascii?Q?AbrMfm6SclXr3VAUThMJrltEG/+jxfbFBNryiPgqKBSaDlFqoCoE0m3sIB+I?=
 =?us-ascii?Q?tP873kM7wiU32Z6W3drasPKqblzZYYbJKnvm1jogItaGrLvrN52gCpQqtCYd?=
 =?us-ascii?Q?JtMC2VAssHnkmDV/xbR/zAFHxdTi7OIm8ZKGMjoMeaVL2zdWX9iLv9ROImwJ?=
 =?us-ascii?Q?6Es2yPrr57fDea0U3sXcj74REHfenmmCL8jkHHBoiZMawmqazecxsd3pZjyb?=
 =?us-ascii?Q?jjh0IKJd/8E6X+Wpb059h3IhtClert+rQCJgTxdgZnzv0tdTwBIxVlgwoHWd?=
 =?us-ascii?Q?GGyjmkCqGiu0yHbYRx6uNY8QJEr9G0rIYRGXJNJ/v5KAcJxkLIynVh9aqwGd?=
 =?us-ascii?Q?UbiJyUTIcawd/BwLA3q2HC+nz88XGeI+sq93YeOqSDw+uHA30u2fRvfTc5MN?=
 =?us-ascii?Q?oDU4SDwWvrVwmg9qlOVQqH1UzNtVMHC91u9WW0ueNQSHuDyFkjyR8pk5WwWS?=
 =?us-ascii?Q?PANJ/peCvCfjiy4pcDgWKpR2li9JuhjaDKJhXoZl7rrH/CvFPoiIShZ796Ly?=
 =?us-ascii?Q?1quLR/Jtpt59I2p+q9egkrNYtiSfWAhXN3Wm+/PQJrqvBn1XMPYlH4QjHdXe?=
 =?us-ascii?Q?jUZAP7o//kKZw0gIKicTf2N8URnv+stFmPFIXRVjPXWLi/py62CfcvP7C9bF?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e1b75b-3a2d-452d-0060-08dcea6be4de
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0850.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 03:13:50.3031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/1qZq27S6x3t0nrogjTLgg8FXZfMW4pD6rvpGJygsUtvcytXQhsBVhEkPlMXZZJBDh+hxKHogNPEfBPkdDrwfUk0B4GvDk+ikEA+wk1VhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0850
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
index e11babc1cde..f62582cf93e 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -378,3 +378,8 @@
 		};
 	};
 };
+
+&usb0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index 2cdc683d49b..c770da2fedd 100644
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
+			status = "disabled";
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

