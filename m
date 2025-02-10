Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D353C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 07:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C37C803B5;
	Mon, 10 Feb 2025 08:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hSEtc87G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC3B9809A4; Mon, 10 Feb 2025 08:36:46 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::719])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E685C801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5m24xe6yEOh64QRIFRtDWZuhdX4INkZmJAmYVGg/f9i0PGi/3afSIjTuhOnVwpS7DqZ6/IJ8u6M7g2PpyPZr3aVd165w/oyV4YZpNqm0Xw0MWTYXGynYt6iMDnlWpy7DPxKEz0fbFmIIsEIxT4wSc+QxGfO+qjS5XBYd8ftb23UghXme21j0/+qlrO1ENnsuhXP8o0hZfZ8BKU1LSE64iNBFuloyb2w9d/8MpvE22yV/14b20NnYJGipBNlo4aQZIvnsJy/hqnimFtRLndg0aQOWPuwKE68Cqn0O8pwL/syHZx9FwzobahbZbKp0fxc8PKLxu0qm149XBMVaC8N3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dId1aK90VlhNkZo36MiPnCVI1Q5f8oOtGxFji0QEe0Y=;
 b=HbbyDWebfshPq3kNFZp3vfPGC51Ofw1tP8MxhtbBEgp+ELzWgt23kh7v/MAi7rMv0e5K9stVOjV0f0HHzxpe9jzqvF0xuoi5Na376Lcc3psfk8hGNoy1LUv7pMU4FqSiu6VXgROCQwNl7mhtHeDXKyaNmT2tGaClW/Ssl5hJ/+Bo5g8IygI8F7ILsay43FiilecYLEf3VG3rc57SQmkC6NLEOx6+mObAmbkQt9o8Lo+mO75l31wzgZzaJQyn6A5nDkyitHTV0G5+fBsykXBQp8tocPAhhA8BB8o/mqSgZfRv4kd/mnZbkPpSPUSwqv60kdmHDOtRwisC+eVV/5t5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dId1aK90VlhNkZo36MiPnCVI1Q5f8oOtGxFji0QEe0Y=;
 b=hSEtc87GlEPLGQdWNgamek7MTSd5FF/dwA9TE+8ZyBzeOsklM7LXGz+0i1cKhvfnCxphvGrAJYUSWQe38SqhqX2mvamQYzJK1iZlWw2fZNYFm5EEu2/Hnfbh8YZ0Mo98z319Z/lFboro4PiCkpFJGj3jT5DvnhHIZFxUUkdZWCIFvw9uAPtOOssaXY7u9Qb1LwXp5At36LDJGydEG+3THPHbQ8ddCSJSQ+lZFEjDPlTNXURPY6tNuhmKi8IhZO8TWFW7FzOXCNYn3ImAfAymYJxQPeCAqdaCMMsx8q4A2c3BL0fOtBSY1FGdGWyUGHUS2zegPQW0WvXaebfvxbwyKA==
Received: from DUZP191CA0065.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::6) by
 AS8P195MB2096.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Mon, 10 Feb 2025 07:36:41 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::7c) by DUZP191CA0065.outlook.office365.com
 (2603:10a6:10:4fa::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 07:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:36:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 08:36:40 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 08:36:38 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <d-gole@ti.com>, <nm@ti.com>, <afd@ti.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/2] arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk
 to all images
Date: Sun, 9 Feb 2025 23:36:23 -0800
Message-ID: <20250210073623.2994856-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210073623.2994856-1-d.schultz@phytec.de>
References: <20250210073623.2994856-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AS8P195MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: cffc4f78-b8b7-4b0f-02b8-08dd49a5a944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MmEuA3no8Ap9iDa0TUZXZeRR4lD7/zajEOeU+9wgwhHRmCczMzlysK1O/jAI?=
 =?us-ascii?Q?TeJzw2XLlN40B0ofvcgbtkmq3qzYTt8ATeuTDOswLqjwvsQY3JsnVtqTSVYc?=
 =?us-ascii?Q?E4O8yW5Ikew7Xu4mFV7zwiU8XUWa9jTQ2LQipTonfvZX2yprUSkuf7xvVOt/?=
 =?us-ascii?Q?dP2R8kLCaHh7DN42M1qJ01taNgyvXv0djJbDHQN9IRnDDPY2n068sbzqC+6E?=
 =?us-ascii?Q?IMsPU8PdRzlgNbcRAOAhy+FSVxlzJh98m+cNcXQozHS1GyqOJBenVE16g6n/?=
 =?us-ascii?Q?Ws3pBAXZ4c6PLKu5RjrTLGHJThWPL4WtU9LEfsLC3ERPmgwpaiswUVgNqWSA?=
 =?us-ascii?Q?BTDOPL05kO8omhe4cCSqHOsZ00GaalX7iJ7q8cPV/nCEV8vZicDyUJ1IJBtX?=
 =?us-ascii?Q?7J7n7MZrVn6Nliqn8VphM4hacqP5daQh7g8aGTV+HRiuLGzO5Pcsdli8pZap?=
 =?us-ascii?Q?Z4QVgKkN2b5p15rXt7BMuCd2F4OOr6i0/Xlr3SedgjHFokpL0x3vsnkwtBnY?=
 =?us-ascii?Q?hTJl9N+X+icCz4MgN2n7xnPj1vlmOPGsJ5yGoAfAFjZoTE2PlpN81NrBfVSa?=
 =?us-ascii?Q?dppX5fAyCxeyaOKKSi2Ds4S3c06XlKTvH4HMsipeSxjc6OMbDkGNEjbydtU5?=
 =?us-ascii?Q?8Fkh6c3WQbHmfFRvLS6xGOOiM9PHkLHqfTJ5Fh1e2dzTIe0gLHFUwwdbKBbk?=
 =?us-ascii?Q?SBfDY0Ey+zR1xBEwZfuBE/gFSBrWmASSDBQwXjog7CKyUy/OQac/Jpw3lsbH?=
 =?us-ascii?Q?PWaYMaz4b5GuitQNVLrJ7ODkRkUTqykUP8lptlCd8iezvZynvunGoxo6Tkvc?=
 =?us-ascii?Q?m+s9Y5ryaNO6DWOUEtTi2k6Oxk8utrMMRM0Bl+uWlHjQhi6eVe4C+uYwHn9Q?=
 =?us-ascii?Q?GOcxZtZCzVLPmzcwrLEUdzVIlgmk0Mlb99rywPF6aJDgGbR0ZawOYt8caJGr?=
 =?us-ascii?Q?j+0k510r/gV4QYDtJejiuSm7o2QL/2YRabv6q9oGpeV/vcQGJ7mo/dHReCCt?=
 =?us-ascii?Q?HOEfXiMqC5HnoTiCI3B51b+NkawNTbg1a7aj7jVTTsWNOSShgiygnZKQdv9/?=
 =?us-ascii?Q?GEz4+FDw9ga9m6VMkYAMTEJHKKY3XfmDNP1pH+mTcqUh2qXgvmyVZW/aL3oa?=
 =?us-ascii?Q?3YdZoSeQLDgmX/QvsHiqckNY49JEE/RhGVlM+iqBoOmfNg62ipdrDwNfLTqP?=
 =?us-ascii?Q?OtCtjATRGh8YrtCASmaQ1Y3IE+T7hm4jdkhGnTIoAXsNjHFln9wDjdEb3zn9?=
 =?us-ascii?Q?n6TzoVVGHCJ1w6W3SFF+Ej+jPOFgQbal456DHtuNUB411IQjW8o+XWFbPWY6?=
 =?us-ascii?Q?mkIE8/sMvld/qGClAAIipTuH893Bh35RIW/wJcQoVRS+RG7agFu1pPaxrA2J?=
 =?us-ascii?Q?OM7YHJmMMIYpMGPNAQOHUQ6dFczHSW4kjlw/8iFNqTM3WHIlgUIbYPWIt4PP?=
 =?us-ascii?Q?lHKwr5fK5JRKlDHtY7wWgs0Wx8F9eXqgzJjTyxPZk8gp2kfJ0VxvfOOJzUpu?=
 =?us-ascii?Q?BNZNQqXexhc16ok=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:36:41.3466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cffc4f78-b8b7-4b0f-02b8-08dd49a5a944
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2096
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

There are some device-tree overlays and firmwares with missing entries
for the keyfile. Add them to sign all images in the U-Boot FIT image.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 49 ++++++++++++++++---
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 3710564cd4a..03cac277434 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -146,6 +146,24 @@
 			#address-cells = <1>;
 
 			images {
+				atf {
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
+				};
+
+				tee {
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
+				};
+
+				spl {
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
+				};
+
 				dm {
 					blob-ext {
 						filename = "/dev/null";
@@ -190,6 +208,9 @@
 			images {
 				uboot {
 					description = "U-Boot for AM64 board";
+					ti-secure {
+						keyfile = "custMpk.pem";
+					};
 				};
 
 				fdt-0 {
@@ -363,8 +384,11 @@
 					compression = "none";
 					load = <0x8F000000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_rtc_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_rtc_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
 					};
 				};
@@ -375,8 +399,11 @@
 					compression = "none";
 					load = <0x8F001000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_spi_not_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
 					};
 				};
@@ -387,8 +414,11 @@
 					compression = "none";
 					load = <0x8F002000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
 					};
 				};
@@ -399,8 +429,11 @@
 					compression = "none";
 					load = <0x8F003000>;
 					arch = "arm";
-
-					blob-ext {
+					ti-secure {
+						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
+						keyfile = "custMpk.pem";
+					};
+					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
 						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
 					};
 				};
-- 
2.25.1

