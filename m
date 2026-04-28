Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EECFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC9168466B;
	Tue, 28 Apr 2026 09:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vaODaQHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D728416F; Tue, 28 Apr 2026 08:50:21 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AAC84178
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyF9KNgeFwqedDq52xUFpneh7rZseXtYzzR3Rz6ebl4mrfj8PCAd6CuCpirH5Iyf95lJvDxZ6xMDyxUu2Kd8NGBxDOCTMQ2u36GyOoTu8MDRxSOJohXN3NkhQZIwVHUTHwl3iJQlFjsLV/phgA5M/ozNqT2/muu+H/+cM5c4oRD+qif/MWbkhs7mAqo5vUsru4Hm7hTLh9eRYDF2G4julDIPKCPWmHecQ6EjOEOmWBsxs7DLmH5ZQokAMmqa6t744yjTytgYNAwBUPGKhsUOUP8HBhjgh5To5HNqKZUlzH5hmfhonF1H1orLe0c5BvX7rISbIHByaurRGuOIxBUrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=Hv89dzdkXhq2Vou+JC3jPKL+32mrW6EoUZ0C+P2RmZbmqLU5Ff+PPqIvhs2WPKyFou2EkI+qhSiOge4jGCG93jNq7dOpRY95SRAD8tLCvlJMPK+zyfBl3B2qylnn7nhiQmK4F1XrHwp35672fd4p6jhYXnVDy6ZWuOqZx8fRv6KOjxKv498+N3lN7vrtKbSuAknAPtmkmft7Z/bpAoKxNEZaIl40h8NJoraBV6QTbdCejkNMdVuwxB20sEnFtQbdQyIt3elcvokp5/eumEj5Y5FFOfBRcTJ0OzBFHelooXNH2MJotS3odUxS+X4D918oWscSSV+HS2ecSEKIkvMCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=vaODaQHALx/wkQrbSZF9Kb7Foc7eo0QHbzo6tDO6ZLPWkob6FP0iM1/jba/RrbzZNR0X0QcxFzr3CG94qSxD99uhdXG/T+pcsfHBk6qO9RBRFaH/qYQLfRbWIVpe1Iv1eRJ+RXGO/NVCw36z16Lra9iFki24JDGnkFuf+jzccc6/MiTuiI3KJdU/Xyyf9O5WSbCxPvqQsPMrD4dACS6QOXrSXa6WltF6JKrvy3L/d53D1muWxU5Db8IZvQtvsWCoCtw141YHkC/FT2Khsjm1P3XVG6z42J8W9wgm5aDDp3vDpnltTiUHsxMGuwkiUJLISPoKO4AcLXcK/KPRx82vYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:14 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:14 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 2/8] arm: dts: socfpga: n5x: enable DT register settings
 and update GMAC nodes
Date: Tue, 28 Apr 2026 14:49:46 +0800
Message-ID: <20260428064952.3965-3-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaad820-ef1a-4db3-098d-08dea4f2668e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: ud4varTtBPlR5qHq4hkCv00NdOqpx6hPZIEy6qRESNqAfPVuTnJEjGadcVWzRre5bx4rFZnMrTXEo5qj2aiQu121dSkTaTFX4BIgRquDCqKZWks8CH5kFNoeGD6GBU1nZiLJkxTqYI6CDMJ/LoKL2Kxu4u2xNgaY+KgMLokx4unCT5pq1i7g+gtp+sswMnA2Q1P/f2L4GqegZtBajUp6597/K0sNo2Z763Q7NW3CrPtELl4dbvwMLNAhbdAc39oHS0Vvmmw4cPyUX+FnnqXetmE5pSy2xIWE/NhcxjcfVwhueU/ygjgudv36zegso6wX4S4a0KSBGoEJrqpXuYrdZGZkXUetedYZXFiZwDpkxLUQxQhFYBmwPbQLWRAs09lECuTmNRbZKHsAy4F/rTeE3PCkoDhKPnNcj/zwEgQwVG23jvYzYOe3Edc4+oP93rxXimwNq0m2prmnAZjV8+67OKuGB4KWlAouUqcBp/y/D+gqkGwlb1Wt2mbf1QmZOdfRX5ASNRV5CeTrGH4VZ8lNjENYf/I8MMWb422sk4KYOa/gaXj/kuEIZrtWUXGNAe3ENKTyZ0W6xlakNZP76Ev95IlbeMuERipjcnUpn5PxE4mVwXm5Vn6h41Ln7HyYCi7TH6ruOUuY5dPkfmghJ5yLFSQLCrQsN4nlKvrJnOwztiq3loDyYfZYE802KVAsI7Nr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWcwIpyQ9CihmiaBabDwJPhQV33XZjXEM/Toyf5OJE8TUadr8va82K6CTj4U?=
 =?us-ascii?Q?a2t5ONwYkIyhQtwih2Bc2TVEZIiDgFxjju2ItCO0COmkEsVvTOuznbYNqTWA?=
 =?us-ascii?Q?AgEWFG13yh8DSjt92cnwXvgzTlpfVlhI9BlXucxuq096b19JJv1Y1xC2lxRY?=
 =?us-ascii?Q?NvPKzciz9l+pjLbHURvS+Fw0lTmuPpco8zQYrg/ubtRCFt8f3d1bzEMORDn+?=
 =?us-ascii?Q?heNNTl9/DX3I6u0pUqZtQIMzSoKnam9PqsTjYfgETZECP4Xew+cHmqT3Uwkl?=
 =?us-ascii?Q?dOcQZ+B/eGIj5gRNPEvna17/aKKOJTsar94g+zo3qfYqCgLF9oaunUYGz/0M?=
 =?us-ascii?Q?md0n8o18c1Hoqm1+N3YFb1jSvtfyE8ugTihKtuGRLX1rTlZjxaEmQDJ3/i+h?=
 =?us-ascii?Q?0rlym8NwappbWtpczcRE9WXATz785+ZktCa3CkUGqinTbikO7oN0EQ67ecxU?=
 =?us-ascii?Q?vPiNBS0FCA/0I2N2kijuWt/x+puWwbe3nzCF38sNfOCNdhA5nWrId5Rokg4Q?=
 =?us-ascii?Q?0CSSxEkGqEIJHXgb7h5khE3CPU8wY6alD+nm8GRJCuV2P6JFNYnOWB0iJoMi?=
 =?us-ascii?Q?6n3UZf2ZG7UONpjPKCxpxK5JtqmGfhRlqKColjZKX7u1gf537b3rAZ4cGibe?=
 =?us-ascii?Q?XjWtuiyCvCF/mCMk8KsnUnLxes2Wy5K2fVnfJk9Pp/QHYYUPz/KfyfhHZ3SA?=
 =?us-ascii?Q?u3oTqX7NB8vTJrEaghGEGGPpth2eoFyIxDPdp9nkoKDW/U3yZTDA6BQHVyv3?=
 =?us-ascii?Q?EnOpRoQzXrOL+d54hwCT3P/xVth62nUSMYoMYRSqKgyeavvv1lHFN+V+pUHb?=
 =?us-ascii?Q?zkUVDh9Uya6b9A/1xc7WWZVOFTUl+kI0C/eAIgVFPv9+slRDle0jdWhZ0aBs?=
 =?us-ascii?Q?O67IfscuUfuiz9ou7gKr9fs6jFw4vQJbsZKWVHr1PwmCbpDeIQ0FhejPmP+I?=
 =?us-ascii?Q?oDiuijmy/vHm3qJAYKF1l82CttMtPf5iuggCxBI8t2eFSA0pYGAasHSFjt/b?=
 =?us-ascii?Q?l8FJmbdwr8am+FpD1laiP7lDLy2NouMqeXMIaXu94GKImvTKr0E2zy4qcuY3?=
 =?us-ascii?Q?ypc8RiE1auGk6lQIc3U7gpyKTGigvfUJeftD5hxtPHvdIvRM4PYte2KyTfNZ?=
 =?us-ascii?Q?7NV+kRqPlw9ItpkNH5E003rWH7GzgwSkoUxiTE9M/VlH6K/lO/7yF9m8OQEI?=
 =?us-ascii?Q?xEw+UvyWqqbtLR9bbg6GRTmlFNNyWcwL5FUUgu/CVD31lUf5ZhEyH+exk9/D?=
 =?us-ascii?Q?0o5rHRXalnMcQMTvBIm2XWjfkPdZ+jGyy9QxL7Hpi4Ax1IovrKOA6ARH415t?=
 =?us-ascii?Q?D42h6o2+3BwMhH6fNGPGzQ4z3E9pAn0TEsfNnC59pbf66PCX+39cUDleTHcR?=
 =?us-ascii?Q?zH0carxatmhMMVoXDpMbcHd2cg1Z76Wi+Nxh49RJ9biNYjCrIlIeJFQTp5yX?=
 =?us-ascii?Q?YT8yOH7qGlIWOihvJXr4d8zir+LWRq/gYrhu7aRPim9rIMSU/F4ys0FJhk0P?=
 =?us-ascii?Q?cP0WVaux40vK5HMzgybaNkHMuxQAxDr5jERtt1JwuGR07JdtcXCI1mOITiiQ?=
 =?us-ascii?Q?LWKC8zszG91hFtgr79qiazl3jpSTmGNuvc5267pdS4kE8BoU4bbmx3LBJ7yQ?=
 =?us-ascii?Q?xA+zw7HxPeWxiHNQi+wd66813S7XJzXqH0HD9/DxZ7IXED/TTTJoNDB1NSlw?=
 =?us-ascii?Q?lwITzR4B7YAv8b2ovfbuqpwVVNXwDajh8SsUAWIRXitv4lC6GUV749PxS6zT?=
 =?us-ascii?Q?ZSPUV8EFP5UBXnMEn5Af4a9Ews4baSM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaad820-ef1a-4db3-098d-08dea4f2668e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:14.6992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlkJgJNpXLPYyyXgq1lywSLhdLo1tW61UTk0FCgH9CaYzpJvjAg7F+nGz9Q6JSIdYHjrVwnOAYYOWxqsc4UUkrhsJKluUNxCQENPodmIi/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable register settings in the N5X U-Boot device tree by adding
firewall configuration nodes under the L3 interconnect firewall.
These settings disable OCRAM security at the CCU and relax MPFE
firewall restrictions required during early boot.

Update the GMAC nodes to include proper compatible,
reset-names, and clock-names properties, explicitly setting
their status.

Remove the clocks property from the QSPI node in
socfpga_n5x_socdk-u-boot.dtsi. The QSPI controller clock is obtained
via cm_get_qspi_controller_clk_hz(), so the device tree clock
reference is unnecessary.

Additionally, include socfpga_soc64_u-boot.dtsi and rename the
soc node to soc@0 in socfpga_n5x-u-boot.dtsi to align with
the common SoCFPGA DT layout.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 38 +++++++++++++++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  5 +++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index e27a64651e1..dbfd2abfd59 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
  */
 
+#include "socfpga_soc64_u-boot.dtsi"
 #include "socfpga_soc64_fit-u-boot.dtsi"
 #include <dt-bindings/clock/n5x-clock.h>
 
@@ -15,7 +16,7 @@
 		bootph-all;
 	};
 
-	soc {
+	soc@0 {
 		bootph-all;
 
 		ccu: cache-controller@f7000000 {
@@ -46,17 +47,29 @@
 };
 
 &gmac0 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	clocks = <&clkmgr N5X_EMAC0_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac1 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 	clocks = <&clkmgr N5X_EMAC1_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac2 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
 	clocks = <&clkmgr N5X_EMAC2_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &i2c0 {
@@ -132,6 +145,29 @@
 	clocks = <&clkmgr N5X_L4_MAIN_CLK>;
 };
 
+&socfpga_l3interconnect_firewall {
+	ocram-firewall@f7100200 {
+		reg = <0xf7100200 0x00000014>;
+		intel,offset-settings =
+			/* Disable ocram security at CCU for non secure access */
+			<0x00000004 0x8000ffff 0xe007ffff>,
+			<0x00000008 0x8000ffff 0xe007ffff>,
+			<0x0000000c 0x8000ffff 0xe007ffff>,
+			<0x00000010 0x8000ffff 0xe007ffff>;
+		bootph-all;
+	};
+
+	mpfe-firewall@f8020000 {
+		reg = <0xf8020000 0x0000001c>;
+		intel,offset-settings =
+			/* Disable MPFE firewall for SMMU */
+			<0x00000000 0x00010101 0x00010101>,
+			/* Disable MPFE firewall for HMC adapter */
+			<0x00000004 0x00000001 0x00010101>;
+		bootph-all;
+	};
+};
+
 &sysmgr {
 	compatible = "altr,sys-mgr", "syscon";
 	bootph-all;
diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 840537c9d0b..1f7e31bcae3 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -44,6 +44,10 @@
 	bootph-all;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -55,6 +59,7 @@
 };
 
 &qspi {
+	/delete-property/ clocks;
 	status = "okay";
 };
 
-- 
2.43.7

