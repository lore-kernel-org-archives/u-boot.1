Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD30ECD4F54
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 01:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2369584659;
	Thu, 21 May 2026 03:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gxuEHgTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 063BE846CF; Thu, 21 May 2026 03:53:34 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279A18460E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 03:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpkQ88zb2CKJXd3A2lthxctr+EqBDFbqoDdnp3Y9IJXLgmq860e7L0OhkABXZltL66qOo+QKuMv6IlEjcFw2tgjz/8fsqSdJmYXEEplWfVOeTT3pug+WQf1qS3MYNlwLo6GVllWYsiE0+eEY1qhN9LXgRhrZOncclzJYnsS0KogKGCGlFNKU5O/BW22SCtgeEPyiLIDaSo5W6aRvWvgWzAoRBAH48LFTYwu5eqCdFmLgMPcnwy10uVPhsRYz99jGlIY5Nfz/InQrHXRjm5mEx5s/cS+Fz857/F8TOQvR9qMOf4x22jujNLwQLrEx3rWCq4mViMyspbPM7vU7WrTo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Gte28f5TKrzO0BpixRwm1Y9ncBR+P/GbzF2GjjkxKg=;
 b=d3OW13sJFbyb0nCPamYUMgCIBF9r2xIwwCgMHf8U0ne4N9ygPZM9h7W14pECo30OWnOEirUF7yDOnSUaCQ3wG7Tasuv3VpGlDfpqm1aYt2ImmrL7PYJ7ZvADRQvcBfMo7iHRCZNBpv1kuUmmCkIm9CUS7W4adZL+K9880FqmZCzSLwnEcw+ZUWh15Ek5yna/gVNkSB3+pgSaOrDSDryoz+knQHGi8yxhS2oVu6+8R3l2GGzdEw7a+lynTp+pEqbKP1hMb74IgDNEBWUR5yAnQbO+le9sUw74wAFTa21fHzPQZ1GjUGBOi+QpwJh0h2ntpTlelWuwmxlXXh4I3AfZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gte28f5TKrzO0BpixRwm1Y9ncBR+P/GbzF2GjjkxKg=;
 b=gxuEHgTrvDUbjbRcQEOUnUSAfap86kLTsgQHjpQde0bd0ph6JPvaLs/+ufVrpU+JJJ8xWM/0tkIA77wY3xkt2JHzyyjCW7Pns1zTX43XfdJ8zn0DvdgL3pcKrm3R9LB1fwiS+oASDAMd3JWih5Z4gclOAHpAPkhF96S1+cLppaSbh9buRnA6lw7VVeB4P7zlfaQNGoIUbV+AYlZhl5swNB2JpMUzhU+AZyH1iHi70+KPwB8EuO0tIlVS6zm6GTTttPImMca2x6YkNSH0I3tJ7LcQnFtOLmSJ8A6ZoY9BpxLoQbEvpUmo3puIJZW05myaa/m7H6f/2kp1Khzlwe649A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB6223.namprd03.prod.outlook.com (2603:10b6:a03:37f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 01:53:27 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 01:53:27 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tze Yee Ng <tze.yee.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: dts: socfpga: Add MDK support with external GPIO expander
Date: Thu, 21 May 2026 09:53:13 +0800
Message-ID: <20260521015313.19663-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed168d3-8978-46f4-4455-08deb6dbbfc9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|18002099003|13003099007|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 0DDtQpcAP+r0d21X7uwXC6RDTYK1SX5nYR1ukfswBd47J7xxvu5BEkhxpznO3nRyLrThydm8TgRrCjRNDrF7ZrKy/J83Cl5eX6mF1T6BaL2Wtt/zDyr0aBsViB2f79aMRz0sLFbiP9eiyuA604YIKKQ672RmCPzHxZirYmvvtp9Mp2bf8y161/tuY/NAzgLEYAmBa/Uctt6RtTZMULWmxYX3bJ4oeTzc8X9RjnFA2U43jW8vnJ27wVMj1NCIYc1MI8PoanvUi6a0GrsKEVsdyFn/WxCaE27425mLaz7QB0YcKn1PSC8xPKsaUcxyVKeSDy4se9vxFpONHFSMyNOI93RJRwGd3gx4pamhtNCd++3hQdBsYkTdczpnzcNAZE6fcZBc6i2XHpsX9nz7OqD0XwIYxm+/DcFqxLtCCnVayVwI1lLXhju2jEr9UHrjhDpDKfI6T0VWGWbN/YyzuD89ErX+1SD9vUPwxv41VCvz0NF1RvJrx8Q+QtPD//rBBNkgU+eRxsQ2JSvdAjNqzufHnKYvyhferRhbk4W/owFrVcUPb5qKv5rz+xvp50CF6RW2tw0ziTb2cBDuCrD4Wgax/burMRIZkvTMsi8ekpW+Z+vNz2yPvZMyLh10sopZZi/uMyxGMev2NYrnOj4l+CnmqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(18002099003)(13003099007)(56012099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pXE06fFe5o8h5jY1HKSHLwsKDBqhJrekU/yYBEcYz9ULnasy5BA6ApBRSqMK?=
 =?us-ascii?Q?ZqU4OURXvJ25V0U2NYRJYWtQdpZTr9fo4QSexKuIEiMtBdARl8IethSE8pME?=
 =?us-ascii?Q?Ve2Dsw1cVXSVFB3GFBk3RzZypE5um+VNgtG9vmXHyKtuRbNcbSBWqvxiuDWR?=
 =?us-ascii?Q?02gcGMLcXsnZqpXfK53LgpvLFVmjEc5S9knlaL8p1EQF/gLBMHyUHjCOWBNn?=
 =?us-ascii?Q?zvh1NqtPv+cuGDpVs/7mJCT73M+s1Ee98suYV8xASDIJkDNRoUTb63bv33Oh?=
 =?us-ascii?Q?8WTNtk6A/m6qEAZlqj7Idqk0naICEhhsc6Zzmkz+yHojCUYugFKIcLp+7YyQ?=
 =?us-ascii?Q?uAMspEEDntpGWaN2tkEeZuYGQbgeeqFDwKQgW5tQZ+Yg2zFBXQksaF4PX3wo?=
 =?us-ascii?Q?g/o7tOmhONR5LuqUBsYiEuBFcC8wOE1dpKEQbysHMrrz+/Gb6L1fNpR8lR30?=
 =?us-ascii?Q?1GSiaWzBo1lLVG1Tqg5zIjaj/l26SDrXle/ekbXqEYZJBnrRZjDCtM/Tp8U2?=
 =?us-ascii?Q?sB9gtobwR3prMiK4ajWHwflfr3TmMklf1T+xYa1qM1jukdmjLx6RO+HOt0sQ?=
 =?us-ascii?Q?CK8xhO67Rd6EjGj7Rj4ZUGYY/5cc6sYM0gBYf8iruzvsfvP5CT7UGb16Kxpq?=
 =?us-ascii?Q?MEG6Q7Y2o43EKtooueSU3Dq3gvvthJhxkHXDGp3vIQQI0SQjol8/SGvEw2mD?=
 =?us-ascii?Q?SBz+D3uRKz/fh3BSch76yhB1VZAUE8V/kdR26h8eUkR6zWqW+hzOOYndE4mX?=
 =?us-ascii?Q?+6cXI5U4YM5cNXDAzYFlB9kNOEfPVgq9ak+SWgIsSvQlWMD7RkPTL5z3eNY6?=
 =?us-ascii?Q?tPIwGveF/HBm4aasKNVcnlr0Iv+HNKmz353JXpj6r/cF/PkpBjgzKWRxx9dO?=
 =?us-ascii?Q?cRj3UnDqqoa2cpH+Ctkq9U7tJuV2c3hYbrERH7Hqgy+0klmENXzBku2GN3we?=
 =?us-ascii?Q?Tti3bv4os3zh8a5rHoyy/mErExBiwEKWVWLdaduxiDca9+aRMCW0lrU+V314?=
 =?us-ascii?Q?n+X5/NPj3fXaO0WPuTOSBsGGex4vwGaE8KtFNEol+JcgUqtWkxte2Qu4Oar4?=
 =?us-ascii?Q?2BYYCwsLGOSHzdfwKV9bXxBn5yS00sNoj8Z4wzvMApyVFRvXUG2tRBAC6nna?=
 =?us-ascii?Q?s+6n0iVQhpU4tsVnHMMmjhcXt01BUg7W8A3pgkFjH361CNlNYzf2JzgqoBw/?=
 =?us-ascii?Q?qIdy8SDt1B8su6HJXyamtuhUB18VTaRwbc7mrVMz2cVTbD7qRkXxzD075890?=
 =?us-ascii?Q?oYxBvvxhIbcxyVlEc7iCWxLS1U0jnIJdfB+0gxh9wbTTFqxUUMjqFkUFquMh?=
 =?us-ascii?Q?hcc63p5d8sftS72bfDU8jxcxhkByhSiLvAeL/TeQKbFogms3mjNh9tDboH/E?=
 =?us-ascii?Q?qyJni7UB+Y4f5QBhn3OGET32D1Jy9lpu82IPO7qf3H/RvW1geZ10U0c9iHl+?=
 =?us-ascii?Q?G5iqNFtyyPHc6MAgiyOlf2UkRZQGmlBIy3dgA7cgRwzZmYU2ra7USA6UVyeW?=
 =?us-ascii?Q?f80mIA+y06jsTnTJez82ufOBWPSQYhzDaKnCIXIz/rAEWX9G3os0CVaY2V+y?=
 =?us-ascii?Q?dPajBKLhxOY0QAH+1tPUdWDVkbRyJTn4Bjch2SPasfsvSWK7zH7WrnHXBUBt?=
 =?us-ascii?Q?1fYCw9eemUN1Ywhn6VK3SH01v6SDOvDrx5S0MD+Xo4gP5nAKTY/a/e+abqWf?=
 =?us-ascii?Q?qwQjnuZtiyU3Fgti/z8zMDTojRUB3gzU8Uq2HprMIm7C/YW94DX2PxWPTxxH?=
 =?us-ascii?Q?DfXPM92EecLbQqtVj3y37ZaPIyc0mqo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed168d3-8978-46f4-4455-08deb6dbbfc9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 01:53:26.8489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3qG1+cfuNS2Phr+OyIxAta9Gk+SsfGlWszhoYOsxWc6PxmBELedMWWzTRO3hS9l6arIqfE48O2etMTf2w6GebZLLjavnv1ze9yhMnK4Flc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6223
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

From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Add dedicated device tree and configuration support for Agilex5 Modular
DevKit which uses an external GPIO expander for 1.8V signaling control
instead of the onboard GPIO used in the Premium DevKit variant.

New files added:
- socfpga_agilex5_socdk_modular.dts: Main device tree for modular board
- socfpga_agilex5_socdk_modular-u-boot.dtsi: U-Boot specific additions
- configs/socfpga_agilex5_modular_defconfig: Modular board configuration

Key differences from Premium DevKit:
- Uses PCA9535 GPIO expander (I2C address 0x27) for voltage switching
- GPIO expander pin 1 controls the level shifter for SD I/O voltage
- Requires I2C3 and PCA953X driver support in SPL and main U-Boot
- Same SD timing configurations but different GPIO control mechanism

Configuration changes:
- Enable CONFIG_SPL_I2C and CONFIG_SPL_SYS_I2C_DW for SPL I2C support
- Enable CONFIG_DM_PCA953X and CONFIG_SPL_DM_PCA953X for GPIO expander
- Enable CONFIG_DM_REGULATOR_GPIO and CONFIG_SPL_DM_REGULATOR_GPIO
- Add TARGET_SOCFPGA_AGILEX5_MODULAR Kconfig option

Hardware features:
- SD card support with UHS-I timing configurations
- NAND disabled in favor of MMC boot priority
- Same memory configuration options as Premium DevKit

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

 .../socfpga_agilex5_socdk_modular-u-boot.dtsi | 157 ++++++++++++++++++
 .../arm/dts/socfpga_agilex5_socdk_modular.dts |  75 +++++++++
 configs/socfpga_agilex5_modular_defconfig     |   9 +
 3 files changed, 241 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_modular.dts
 create mode 100644 configs/socfpga_agilex5_modular_defconfig

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
new file mode 100644
index 00000000000..a91624864c4
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular-u-boot.dtsi
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions for Agilex5 SoCDK Modular
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	status = "disabled";
+};
+
+&i3c1 {
+	status = "disabled";
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	status = "disabled";
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	/* PHY delays is configured via skew properties */
+	phy-mode = "rgmii";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	/* PHY delays is configured via skew properties */
+	phy-mode = "rgmii";
+	phy-handle = <&emac2_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&binman {
+	/delete-node/ kernel;
+};
+#endif
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular.dts b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
new file mode 100644
index 00000000000..367948bcbc2
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5_socdk.dts"
+
+&i2c3 {
+	bootph-all;
+	status = "okay";
+
+	expander1: gpio@27 {
+		compatible = "nxp,pca9535";
+		reg = <0x27>;			/* SoM expander address */
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&expander1 1 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
diff --git a/configs/socfpga_agilex5_modular_defconfig b/configs/socfpga_agilex5_modular_defconfig
new file mode 100644
index 00000000000..3f3a47f02ab
--- /dev/null
+++ b/configs/socfpga_agilex5_modular_defconfig
@@ -0,0 +1,9 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_modular"
+CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_SYS_I2C_DW=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_PCA953X=y
-- 
2.43.7

base-commit: 29c3448791d3fbd8dd13a6e3b58547206a98d381
branch: master_agilex5_modular
