Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FA2D2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96DB38404A;
	Tue, 27 Jan 2026 14:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F8sCewvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F8E83FCF; Tue, 27 Jan 2026 09:17:37 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2A083FBC
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5AOML+QMCy7CLRyX3PzGt4AN4ni4BsXTYs+plSsnIoPUQlcxtReeHWH46IGnSWO6JN8ts3cdYInrj0SADHCGxtFcg4QqPF0Kvo5zAhjwtTikdMcct6WY9FwUt3G854yTkVZpcJVYeOyBzNlmkJB9Yq1VBR+PmNcWIMoKVpJ0CgeWHEaJxCKr6hn2LUM6KA0lLr9SKbHsYit23g/MtXdUF+sgBAQCsAptzs96tJQKQxlcgPompkRiNssAHcIjC1/JeQVTIf5k/Tv0Ov2tnpgSpcg355Fvh2kexBhXDOxD/GBZyCHv/nJmSGWLfGWIrFlWJf/co79h6hv7T8+ED68Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYFdXbpPPG7769gN5eP+Bj33dyBqQMm0SxVgGJtGMx0=;
 b=kk30gSsUTSmq5f/haob1R2kLfdgSID1RkRgoEpPi8xNUBJMha8MfmcAUVcrNBKk2t+lZItGcPF7T7Q9utStz+H224YiVFoiXOjjebG8nb6hso9mQF8nzeKZ8H9xhaAZeENd0ttEMjxzMxwfLjHir3ufI4LE1cTwzRaOuY3EcrSCBtTQfbRRsDfUirA/RYSpQKQE+PvkZNQlzZA9Y6aBEJrFj94mcD5jcZ5vGqZxVPI6+MBeLYfJ9cqE0My+uPPOoigBUbKG/pH5B9cw47Bacqe+HVSPF7E9PZkBC5iQhiODtlXvrHvcou33rhYT1TZDM7u72NwDUuu/6T2UV0ijxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYFdXbpPPG7769gN5eP+Bj33dyBqQMm0SxVgGJtGMx0=;
 b=F8sCewvTOETfGocHFDiRNPapUxCOC1xgzUFL+2BDX3tLTHLtDl3o+4sZmAJiloStA41H0BhrUuKjHh7A1ZYvVXr9XLmvqWvI6NF8eqQp4GlGmB4PyC6s1oN6pqIe0is+AI78AevxVtqyQA/mepYDmGqiHz195tiQJGkAendi6M0=
Received: from MW4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:303:8f::21)
 by LV0PR10MB997566.namprd10.prod.outlook.com (2603:10b6:408:346::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 08:17:33 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::e0) by MW4PR03CA0016.outlook.office365.com
 (2603:10b6:303:8f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 08:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:17:32 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:31 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 02:17:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 02:17:30 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R8HTM54029927;
 Tue, 27 Jan 2026 02:17:30 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH v3 02/10] arm: dts: k3-am625-binman: Configure firewall for
 ATF/OPTEE
Date: Tue, 27 Jan 2026 13:46:44 +0530
Message-ID: <20260127081652.506357-3-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127081652.506357-1-s-joshi@ti.com>
References: <20260127081652.506357-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|LV0PR10MB997566:EE_
X-MS-Office365-Filtering-Correlation-Id: 35242082-0896-4807-355a-08de5d7c8570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y3BZ7ibgmzMowxpDr4pM1tQzY1CGhHmovxCfyQwjXNtP/SsLsWVZOD0YHTWk?=
 =?us-ascii?Q?AHP4GOrWDF05gzKc1YC/USe69zfX0g+4NJ7Ev6Ot/zBah2Pf6XUYrB76ZWpw?=
 =?us-ascii?Q?T2pZPprRx5p4n+idu6FL3cvcC3surB344mvsQjvtNCETgsRxdIywqfCzhH5r?=
 =?us-ascii?Q?Z/xLOiU1rQHl7NWeeU/WVTqPaKAVQwYvgVu5ww2BBjzDkxEFY/QTcBzIY8u8?=
 =?us-ascii?Q?EnVTTjM8RF0sv/HM/hAjDuCVq/q0SIsnuhadpW2ESUoSDvXd3KdrQAsAWJSX?=
 =?us-ascii?Q?+q62rIns0IOXYLShIzGW765QEvZTTKmzYHemu+ZGinBAFivlkeyR+fK/K7Vl?=
 =?us-ascii?Q?7+qJT8aoragftp9awSzqG+1kXfvkiLJrNsSlEdwczLTPhrueyhkRFYP0JgB3?=
 =?us-ascii?Q?NdBoCclEAN/T1tyJ7yk9AJ/M5Ll59h5ErJ4aVi8zczIJfXcFaSC0D5xuNiiS?=
 =?us-ascii?Q?Wz1b7quHmxl2vXs+PRrJ3C03qZf8oZWKCPT1tva3OS4bgx8ZZv+10eFZNrnE?=
 =?us-ascii?Q?AIhijt6fqKZXP1MXONuQkJiGsiPXKakMVqGc9gdyPGAweqozP0VkMcZahsDu?=
 =?us-ascii?Q?lKYQXHiZnHAJBcHD7/Rp00Bk1BU85mqHWyF338SQwBucG6mHN8gRrhXyJB0k?=
 =?us-ascii?Q?5pLVTZDjT8B2IxsxJCLtgxtcZN3skYeVAaZyr5cEDshMRJ9M2VPh0j2mOUM2?=
 =?us-ascii?Q?cWX7rewK0/L7/rBtKF9a8ShwO26KgmWETytpx3ObyQKbDCVF+reXQCR9JtzI?=
 =?us-ascii?Q?nRmYYLJL0hEZ3WFIMi1eRKxw6HC1Xysv1njKrQhaVcmuee6DLvcmUqi/8yMO?=
 =?us-ascii?Q?4ZlJUjUkOfgZ2UAqniCZPzGMDI4CkBGPOtL1pm7nPZCvzNsaYn/oyMEX7cVT?=
 =?us-ascii?Q?CIc/nat69ep8g8y4Cbb39AXxBT2FyJF0Xe+eXWPC+fAZHMjxWQXk3IFXOh8V?=
 =?us-ascii?Q?GeAm+a9VWugMPN2HBgECy5qBjazBuIVsM//OznAb/4B1MqZSBUInsrs52SRf?=
 =?us-ascii?Q?QuzyociU0wfiWmhPKeTmadjk1cDnJhZdD7BXrhMebDhRVMg7w1ondb405rLj?=
 =?us-ascii?Q?/TIcOucpAW4+PDkGpkcxYGfoR/ZmlbuRC6GDpyVrBGdk1hvOi0WhXPe0G1Nj?=
 =?us-ascii?Q?8smWHxuiKCVhCnaNsV+iZXRyorWzRVxPU5NGawsxFEhu2f6M5p4LJ7IrXzai?=
 =?us-ascii?Q?ItSTxNq6niEckNfp8qlXfLDCt5ANWU8G0IXDOzWqBY9b+FunXPT31jB+6Txn?=
 =?us-ascii?Q?Astw+yjr9MiQ6cbVIRFeMLd0JM94saYVGuOQaG07FYQwAEhw1VRd2BwIR6wV?=
 =?us-ascii?Q?EOh/gA7uNr5d+MqnASOJO8/8DQavOHzu++r8QePeIndHKvzv7Wtc9zwFQtwK?=
 =?us-ascii?Q?NXeIxo/4LSR1eMR8R2sR0AIUzjDAk00CwBT9i/DcaGjGVtdPCJd0ejOv6DMq?=
 =?us-ascii?Q?bdcw5rMDMV5B6HlBkBGE2o14m6iFM24iBpIOsX7ZlvJIIxziZIPxsxpnnxTU?=
 =?us-ascii?Q?dIZl0ko1MeNu44bsR7YoIeBigR4Lihr0ynLDXAVVncaZKBYIoK8TvQ7QLFhz?=
 =?us-ascii?Q?DuwnnA6Z5p0jyHI5+Qwr0OZhUOzwuPapjwflYAG9I2Qj9xbhYHMVK2rhatMO?=
 =?us-ascii?Q?zxAa4FSsxeFksG0/EFKBQTbjK5VZ4aCwrzB1ikgZ9tIYVRKD4u75CuTDUy/b?=
 =?us-ascii?Q?XVHoLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:17:32.7926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35242082-0896-4807-355a-08de5d7c8570
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997566
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
from non-secure reads and writes in AM62x.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-am625-sk-binman.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 42edb35fa7b..8d6015e44a9 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -275,6 +275,35 @@
 
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
 
 				tifsstub-hs {
 					description = "TIFSSTUB";
-- 
2.34.1

