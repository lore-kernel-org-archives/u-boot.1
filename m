Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348E5FCD0A5
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B791E8421D;
	Wed, 18 Mar 2026 05:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XeYuPlAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE21F840F1; Wed, 18 Mar 2026 04:02:34 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7CB8415D
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b42f7fO+46gV4NVL+Lbtfg44Yi/+3cm0XK530zi7WlaI2cnknZfpoReJ5Sr5dbUX1DHNSrM879nOfoYs3tRA1a63JI1hqcC0dDVAy+iqkcCIWevI4nDYWWSvqEKG0T8J6ONJvnFTW4TuMDPzud8YuNRQH4AD6QxGGLoGWwe/CeY0P7dpipmT2glU+M5KLPDfapdJHrj+8VpQQhTPDJlVes141ALo16yn54Rk9gu5OvwgjAkj4GVBdA/P/hbnb6p1qH111+hPFEp31LQwylM/+9RqwzcMvGsQtWrNTIiCEFr3ryr7xYuy1EjkabdBSErropGEmKHrANLph/LOksewyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQX/zrGebI85henZpoeTO4RBhyfjeT7aff/is/CwNAE=;
 b=jLAUv2OpUAR0aKWu6/PzAyY41PJvsXQ6xI74wk23M7UGLuUjHpOVuY6XQ7S7Mjcv6ILltHVoiEw0ppg6rrOqZtabzbuG6KE/ejJ7gl/67S8qAELAwG9KB6OHGvixiIM1eaKAL3gf+8/LJW8FnLaaqHtfnhnLa6EIk2nvzTfnmj5STQGOr0PPSn4zclqyxwJRdKU/fcuHVG9XDFRpKue/oFd8MlCSLkBy3uUk6voHkGDbRURxXX1PFab2MJ9jBn6hztg657BkY6KbgagcK6bDYon+IdtHdsBkNgrA7lYDvrRyJrLStd3RxBYBj14RXCOk5i6mBA7Ux04IDUTcw7f2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQX/zrGebI85henZpoeTO4RBhyfjeT7aff/is/CwNAE=;
 b=XeYuPlAviT+UWITLsqwPx6qP94hgwB2YY8obw/ov5OsDfvF/pT/xzfRuKeYN1ArArqa7GNXQBX52mi2SnN3FKBr/Dhuv8u9qIwsEOYAkDp3aLZMv4R7JGd1qn5MKiP1mVCGbOlITUJmP2nCsGLw8Cr0Zhzijw3js76WV5ig/bVIdnK05LkJOPFpf0xdRL9ERzZUYeII+7bv+Zyc3PAhemeX9KzWl8PMsh1aR7qCd4HCRmOUCIyGh7YdMLiuFvPr3g2kt5J9YkrMU1FwJoSm7G0BU8TTXHxKywdDQAjlvWAn+kmILHFG2TtoDYLvI/KyvZ1T91PDpBeiFN0vnzNYt3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BN8PR03MB5092.namprd03.prod.outlook.com (2603:10b6:408:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:00:58 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:00:58 +0000
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
Subject: [PATCH v1 2/8] arm: dts: socfpga: n5x: enable DT register settings
 and update GMAC nodes
Date: Wed, 18 Mar 2026 11:00:28 +0800
Message-ID: <20260318030034.25889-3-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260318030034.25889-1-chen.huei.lok@altera.com>
References: <20260318030034.25889-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BN8PR03MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: 92daf55f-45e4-42d0-3672-08de849a940e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: f+wL4BMUg9LYV9Ki5jdzqFmHUiVkyaD8cWaE0zSvt6En40tDs4rsrajUttLIXw4tGmDV4hJTsziSkRDeAtObMbNDbOYb4IDFh/xsv4KIspRSIJ0WjjIph+VzOVCWvhExJe1NqZueBt5f0EwY8bqgfbMkkgY5xXkaWeKhWLfd6brvdua2c6+pY4cR/jgTsFLCqdV9bzbHRP3MysL8EjJnUlJdy7S4x8NEDKZR9p3ncwzIItKfHOdVhKkK/Ezd8jE68LXLiFOSxU5ytURKMzV37+o/xSNaBFw4s3YsWcbzH9kAHHco7KmkW04NEpRn2ZA5v3JmEVVDcTGu7aXW1QnAwg+KB0XGIuADioRDAi2DVsoraMc+HUKDgFsAFIPYeJVg5G0FJtdOoEPpvcYrzfcFGRbOTiF5ySlADnpKvUOCxR8Vsm858OTIvjV7FoKNi6BMTGT1+5PlsRlBVC/lBksjulyx+tkv2G+sfh0GzHjBaOW56JHXDIzjjb+KVGDYTgzqJZaO1YQs2kOvbsbagCaqbyica1eCD1HpwhaW2mEsbckcf4932VlXOkrVW4yZ2rA2SRjAGcLsoR3Ee9w/brXs46c5/L+KMEdcO2ri+jgC83ZYuJnKSffzh2VhYNnJwHZnJ1DEiDgzvSqEsuLtARIlcpc9dh4PYnLabhx3CU2wim/r9ZJ0NMrrIIUKT7JWmSKA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GMk1HHiwj204321z4hbIgHgdt5sfcRtkZwDzXPcSVmZvq9eZYd0MW6AnEY6/?=
 =?us-ascii?Q?+QQyZuvQyWOYkenLmTxQaJJzXYh1Rt/IYAtvG2JG3uct48FzediK13qACLMW?=
 =?us-ascii?Q?PAkBAX6iaoSv16oPLfs1D+wnEN4Kx63XtF/iixMRG3N8jl7sWhKFiQifNvvy?=
 =?us-ascii?Q?U47saARK07Rj9e0m+RerAPU2PxIklCgKTwa7BwL3mWpBqUMNQYH01XeqdDKQ?=
 =?us-ascii?Q?MDAcVf9l7Zyx6/7fa2FW69NVFPVuZ3rrJ3TPBPiZH6uZVMe4+JKEvKum9GlG?=
 =?us-ascii?Q?9n+pchTzV5MFRAVgLUuax6WnOlw2KqsyLlRL6PFNhHsJTQC16vJhtmjG3jOp?=
 =?us-ascii?Q?W+kD6+ITrj4Y/eZ2OS8NnXzzs8zMbPFjsiGY6U6WNv89VR5+YBn+a+jiavh2?=
 =?us-ascii?Q?Cl90el5e7sN2gwEtYi90d3vdKkCDgiZYqcScm5uUcQjtS1jotGu/7D9cvZ0y?=
 =?us-ascii?Q?dbxPE06XqrDRi44zsgpw6Alr3qcF3guCOJe7Xn77DGGM1nj9FpVx4Lbd8Abs?=
 =?us-ascii?Q?ch2wyOvH31bEFMDMkpd5IUHm9SHoH9zyhgdxepCc3OuWt+LTpd4Pjv8V+ZzI?=
 =?us-ascii?Q?l923QoK1X1+0OIF/Qx5IHzH3hkVcVFHF7BjqQnK3tknNgCPdq7YcjloBI/y1?=
 =?us-ascii?Q?g5qWzGXmh0vF8W9hc0kck2dIZPrB24nQAVDMmaUu0/UHGEeXdt6CD76mdBOr?=
 =?us-ascii?Q?SKL3i4cr8lR5O7WRE6vE44MKjuMK3dLpf76mvSDPl6kgq3mJnHlXmEgTMhKM?=
 =?us-ascii?Q?56qZz7Akhg8dGiMgxsZnsfL/jqaz2+qJ2qf1HYyIXN45Bg1BYnN6vNghux/T?=
 =?us-ascii?Q?Vq8p1F7+rq3gl7rcxeOmIy5y9+V64528cMDVmGwPOtazZLagm0BtwGtQdlaV?=
 =?us-ascii?Q?AqVnolNxlfCbFgGMrU/bNjOVCKFJydxsqCJwepQjABzDQ3yNAqTCgJKpEQje?=
 =?us-ascii?Q?x5SyfFqkT1us1i6nn6m+EMc8Au1EI/Lnc15Y/ZEbrZKXLLLGMaWxdDAuJI0k?=
 =?us-ascii?Q?G+DNwATvSJyIOqNNevQUxYlruWqmZQ6VaQ9gelLkf+pQYfWg8MyNmUrHdcZA?=
 =?us-ascii?Q?tVjgo+HrgEI/Tmsjg0oXWIQg5+bcHZKALpNDEf6vvq3fX0ebsjX7AERJzdPJ?=
 =?us-ascii?Q?uhjMwMHJsCR0ieGwxdwV0f662KByaTF3/1zHc7b/4ormeG3JGm6aUNkX3sQ7?=
 =?us-ascii?Q?vGHncFQrZL8aXJSRE1NxiyazrtulczrKSALRbNnl7yzUj3G5yO9bo7vEPaOD?=
 =?us-ascii?Q?eHeM00pNZ1JrCK/g39f8oVzfYXdnKascGTmK9LKny0dT8/xXlrS1X0NKETRb?=
 =?us-ascii?Q?B/HmJ1cV3MTAvVY+dNHGSvuyIACPuBcmupdWyKmuZFfZO8NCvkItLy+6q5C9?=
 =?us-ascii?Q?YULJukuq0PUgvnx7+aXJNUze/x1ZvAJIoK/ql5x/k1F7uan7tlTR9p+sJY9w?=
 =?us-ascii?Q?hgVNrMM+2ltTmZWBm/91p0nLhh/S3iYQ5CknDl1soSU4o8to6XN88sHSaxJq?=
 =?us-ascii?Q?krFWJDfQYF1geb2g1uo16Du7gzQGRMlB6ZZeNm82eLHvM20ywKr0uH/tC0Vp?=
 =?us-ascii?Q?eAwE7TXCycgRvRWneJNFj2iMj45/31dGLFi/n8OqZNz8OtVZLqtboplIVETN?=
 =?us-ascii?Q?NA6xVHS8XmWyFL2I8NIeLH8flJY2RcUWGCcOB+AD8oZgKTpfGzTtaSHPqjxL?=
 =?us-ascii?Q?f7ZhR5NGFhwVL476zFPtjV7k5e2sC+SC0KgOCLSR+9nD/OhndNd2xS7IabAe?=
 =?us-ascii?Q?s/BtKGtUq/a59gVK2TyIqGUVFVTgJCY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92daf55f-45e4-42d0-3672-08de849a940e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:00:57.9886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwSzuzXldMwhY5AfoDY7W8Te23EfxaSAFU3u+H9i5dyjXWzjEJoSMOT7yBCWjO7dnb82pG3wZ0aiysWd8V7Nw6Ci8aMMBHE9YUlhMx0CpJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5092
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

Remove the clocks property from the QSPI node in. The QSPI
controller clock is obtained via cm_get_qspi_controller_clk_hz(),
so the device tree clock reference is unnecessary.

Additionally, include socfpga_soc64_u-boot.dtsi and rename the
soc node to soc@0 to align with the common SoCFPGA DT layout.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 38 +++++++++++++++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  1 +
 arch/arm/dts/socfpga_n5x_socdk.dts         |  2 +-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index e27a64651e1..326ba722a25 100644
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
+	status = "okay";
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
+	coh_cpu0_bypass_OC_Firewall_main_Firewall@f7100200 {
+		reg = <0xf7100200 0x00000014>;
+		intel,offset-settings =
+			/* Disable ocram security at CCU for non secure access */
+			<0x0000004 0x8000ffff 0xe007ffff>,
+			<0x0000008 0x8000ffff 0xe007ffff>,
+			<0x000000c 0x8000ffff 0xe007ffff>,
+			<0x0000010 0x8000ffff 0xe007ffff>;
+		bootph-all;
+	};
+
+	soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
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
index 840537c9d0b..bc2fb91dfb5 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -55,6 +55,7 @@
 };

 &qspi {
+	/delete-property/ clocks;
 	status = "okay";
 };

diff --git a/arch/arm/dts/socfpga_n5x_socdk.dts b/arch/arm/dts/socfpga_n5x_socdk.dts
index 915b8f6380e..fe5462aff43 100644
--- a/arch/arm/dts/socfpga_n5x_socdk.dts
+++ b/arch/arm/dts/socfpga_n5x_socdk.dts
@@ -24,7 +24,7 @@
 		reg = <0 0 0 0>;
 	};

-	soc {
+	soc@0 {
 		clocks {
 			osc1 {
 				clock-frequency = <25000000>;
--
2.19.0

