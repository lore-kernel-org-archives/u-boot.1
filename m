Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BC3D2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BAEE840B0;
	Tue, 27 Jan 2026 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tJkJ6GcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65DB483FC5; Tue, 27 Jan 2026 09:18:02 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C3983F9D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsafYvpygiWpjyJ5iQz9ZmPhAImuGRNq84o8kF8203DdA2ohrYIqrp+11HoDf6fnd0fmD3PZZ3nQyH66A8OLLTj3JLMX/TGJTdWUdpYT38TK3hgUxhYMD0D35ekOnPhn4dXLyzg7Yq5qIahMzA04SXnfGk4wAZ150TPRXRf0O0SP9MHZBDnROi2H3C6p0njInQkEgZXjYwuRXDx3KKehoDUm0AujYzjWySE4pFfqJ2+QfHtHV/PmF59N4FF1SnipXnWWrXj+6aP1Zwm6+gnB+o8SC2wLrZsmLushnL87lRMqnvAa/sv36EnxcAuHUEk0G25Nu9RZS4xQFepMgOsqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXkaFokPqC9NivNWF1/1Xnw4NCeBT27vf8HZj+903zs=;
 b=po6yNB3vrPQmUr0/DEQZ49o+ANzpT3oHU0c0vnc5K9wPuuXLyP6cj3f94kxBbrnRBp12BHR1MI5R4OND6JdyjefKIKWFgdkWjZVm34LvZ0R2AUwi7+jxZAcg0HqFOKqc2pK+U9qpEqU2JX2sGIHxyAKzfjyBBnF4Pdhw8nY7XvgbGAOS/C80kpexe7kguRq/bnkPwVowak8fLR8cKDtZqDNpxQ6oz4SiphKXG9VhaagKCyjAloWCP1/QRSAE9paYmayaAxL2bfhrzZp4UyqTN/KcD6W9Cv5iSqrLUOksLdMVTBSbWqKn83tBWL4tSasKkw5V0SL1MYgJ5L5t6Eya5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXkaFokPqC9NivNWF1/1Xnw4NCeBT27vf8HZj+903zs=;
 b=tJkJ6GcMYgA9au/o/zOLb6z2tdl+us1qLYwpS7gSMNO6b3d+R5ht5aaZe0VIYC4+inWwTrZzz5+p1eAYdK6Q2YCcF8A3yT9i4URhtZS8TofIaPtc1hHtDlSC0UNu9vludQQ7aoLAU6szK8wPULuKIKekG5dEaodb+g1/9rXIoNU=
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by CY8PR10MB7172.namprd10.prod.outlook.com (2603:10b6:930:71::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:17:56 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::36) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:54 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:42 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:42 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HelB185507;
 Tue, 27 Jan 2026 02:17:41 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 08/10] arm: dts: k3-am62a-phycore-binman: Configure
 firewall for ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:50 +0530
Message-ID: <20260127081652.506357-9-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CY8PR10MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9f9f5e-8745-4cd6-7306-08de5d7c9216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fQuZemAi7jXQYR1RbQZi1r1tnrvBjd6BrsMpXmz2uBL4qRsop8gWpJ7UY8+J?=
 =?us-ascii?Q?TcVvVxcptJI69UquHrmrtm9uF81A2jdnjmuIz+CwdieUE3a0AFJMmEGzlnL6?=
 =?us-ascii?Q?B/epBE46zhpTiKNCWycWYFSj7BUoY1ZuFKnQxnlXi146GE0wYVldm9IutS6R?=
 =?us-ascii?Q?CJHzAn7psnlQegGX6MX+864H253jLuGj/KH2bX244lmYXd8vJ7Hrc4UC2N59?=
 =?us-ascii?Q?PHa+MV79k0DF+jlwCHLDuYNxf7FMyNZl4f+9K8wZcOX2kLJykfsmPt3zxNqC?=
 =?us-ascii?Q?gUIXiGv9JOmHvIzhoLRvfkSaeszBoSu8K24D0hE7CfprXjidFbn6G6lOJ+wi?=
 =?us-ascii?Q?Jjmu7zd392Fp2x20trEU6zd7LG1tZmyIwNFydWSJs337WXfa0aViR/rwoqDL?=
 =?us-ascii?Q?nstjBQyKQoIfkPoLo/IG9+27Hh1She+pzTEf22V7/dJWsa8ERKJa04nfWrsr?=
 =?us-ascii?Q?y6ZdiJ7tMVM1F10GxaFysHEPgGc7+u4Iut8RPFbEB7cdJNG3m0JHNcTgg6O+?=
 =?us-ascii?Q?LFgsZ219Dm57eDPNBX/3l/Dc4u1ZyncN0lAZcpOmX+aooxzmgaMnGcNSZDdo?=
 =?us-ascii?Q?mf+G/TLBH9b4SmMV1T/KeVMh1wdpWxUMA62uav/IWJPWwiKe4DCW0JaBffQt?=
 =?us-ascii?Q?COJBfvfMpS8AwvOG8fkdRw9B1LPxjPylaalqzVyNcKdw3X4sNvnbB/k5Ympi?=
 =?us-ascii?Q?rUQ4CaKn1L0Zjk1jugeC4RbQ3T9KVxAPSjbrca4fYXu8qugiYoQ4AW6m0Sse?=
 =?us-ascii?Q?nPzEvG7G+kD2G0EMAno0sJHeEkfimN304OzwYUBacdTqMEjhwzU6YSJvKiCu?=
 =?us-ascii?Q?J1FGx+Uhf157frQ3T5w/dzIfXBGITLHrwjuBvkkSULrWM3b3ZCKnpORfxuCS?=
 =?us-ascii?Q?rAlXGAhUH2eGdXuZWXpbVyVeHhJZ0FxB/D8fNIuTjm0Wt4yWvKvUCx9ZWnrD?=
 =?us-ascii?Q?2sTpQUViUXK0yoiGMfr0NDv9OcvCGmqWZvLfA1XCQHuD5J8iYSu8xpCrMkir?=
 =?us-ascii?Q?D9sm6i06xWOQW76wTGKEk4NXPMeYvA0bcaC8VnLpN0SpN3xC5wg1LUqCTvi/?=
 =?us-ascii?Q?I5BqQhlHOvGTr3mzXT1qQ5a1G0g9YEp5BfCGKdJN36CxCHYXv2Z6vULxXMv1?=
 =?us-ascii?Q?f08t2sPXRJLvLEs58pYxOCppjlHkAXbYj7kCccnRnfhipujWU1Yfk8MGyWc0?=
 =?us-ascii?Q?XSyBDRGk5jAdCN7dH3tvaF5MZEsEyCye+JnQ4Ek/Nf6O/Zwk+oTFI5YEfftA?=
 =?us-ascii?Q?juhhasW7rb6nBFa5WdDllwBhWjyC6lanWCDaq8ykGRjSdwGUqT6V3y8KtRl1?=
 =?us-ascii?Q?eUy1K1EM1YUllPWMvz+vPq0Klb95wF7U9VH2CahYQMXYpqmjgoiphEKJyKk0?=
 =?us-ascii?Q?n2kK0XQmv34H0GctjlENniy10WjT246nlTFG19nNzCOCHkrQf2Sbnt9/+W6P?=
 =?us-ascii?Q?fIcqWpK1nBpNh6OKndf/QHoXa/NVTCI7h8J0Y1XLqqnkNUWspv+OpEadnL9m?=
 =?us-ascii?Q?gpdV0OAscyi3ZOEmPoWZj2j/1FX2IdeW1tI49cz4Afr5OXPpapE3r4bnGg2u?=
 =?us-ascii?Q?idbqj3hCu1ZJ8Ns3fFS2a7VQMnkCj+95dLs/u6mXmJuXgGZMl3TGAJjhnJ9t?=
 =?us-ascii?Q?3/XraSHdjk1F33dlvdwIO6IXoOkL5pLMKhSoWz89q1V5nq6L19S8jzo+OUXJ?=
 =?us-ascii?Q?kz+REQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:54.0213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9f9f5e-8745-4cd6-7306-08de5d7c9216
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7172
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

Add firewall configurations to protect ATF and OP-TEE memory regions
from non-secure read's and write's in Phycore AM62A SOM.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index a284226320c..6f82a40908f 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -165,6 +165,36 @@
 
 		fit {
 			images {
+				atf {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-0 {
+							insert-template = <&firewall_bg_3>;
+							id = <1>;
+							region = <0>;
+						};
+
+						firewall-1-1 {
+							insert-template = <&firewall_armv8_atf_fg>;
+							id = <1>;
+							region = <1>;
+						};
+					};
+				};
+
+				tee {
+					ti-secure {
+						auth-in-place = <0xa02>;
+
+						firewall-1-2 {
+							insert-template = <&firewall_armv8_optee_fg>;
+							id = <1>;
+							region = <2>;
+						};
+					};
+				};
+
 				tifsstub-hs {
 					description = "TIFSSTUB";
 					type = "firmware";
-- 
2.34.1

