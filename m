Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E10C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D06B80780;
	Tue,  4 Feb 2025 09:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U3CHIyIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C44E80285; Tue,  4 Feb 2025 09:53:58 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE5F80568
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sabK52P09RY1hbqeBuv0NzDSy1ZHW9sIBc3fAluw6+dV7W136XhnsOL/kM0vlIkYyh1Es7MniX7ih3w6rilaojIcpfp2puF3EpZ3HW7KQQ3houBuZc5yxX7ngFyxmjfSaPLrtxMbUGiLAY8CczlPGEcAQ8Q0L07q0wA55d0IdBiJt5Ek6y7taqHBgGxy1IAEYY+D3TSRhK2Qr+vdoxYvuJ70ocL9vrhquULUYnhF4ftelt4ZFRg4ItuF6x+/6+UwNvVIecdliUE3kQLoHrXVRayeHfrrE2WghNSf0JFCcLrJZGCkrGTx5QO+K7Mrh5dB/iKkShPcmOkw0DlyZP6uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoNQ9VLEL6i3gcRENzGz3HO6abc64iigybcd09Eufc4=;
 b=P0/8r0CR6MC2ORf3jIroiAl3IXEn/WULQHbkOzv2vHNMJezD0QGjAs8n1ZMLM2/9HA5blrj+I269tdutt9DrMrbjVCmXbvvl+Yb5mshAXoeR1JlXNQY63NaTPeJCT76QewTR2/LPoMaEuzQz2tdOG34hXOrEGJjGsJ83HWQGCP1wWyFAeFXMuqpJryb9/TVBWMJlwgszNnf4zM4y/83yAk5RDwfCwhgz5hUEFrIuNSA3W0Hx8m76b97OW4bZBdIlD7nSXjDWZK4ZIXTD7BUSoCSprT5ia1e2yJx2usSqY/+Vj2EAFf/v6wLsorA0OM31ggCqOLmB2ggE+CPRQk/FSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoNQ9VLEL6i3gcRENzGz3HO6abc64iigybcd09Eufc4=;
 b=U3CHIyIQGC+lrCEVYiJx8SsKBT1QD9sos1j+eZQLD5FO1h7N5SYuo5qh8BV1krAeBnJb0To2ZgUWm+4CZpQ/9FJSKm/vqmCRC3Cu4Ky0WM4/krkw3BixKFthNHxtciTXiYagTYDj8TxohgPf8kVISbRACsdHV5tqTOHuqpWQsPQ=
Received: from CH0PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:33::30)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 08:53:53 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com (2603:10b6:610:33::4)
 by CH0PR08CA0025.outlook.office365.com (2603:10b6:610:33::30) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25
 via Frontend Transport; Tue, 4 Feb 2025 08:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 08:53:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 02:53:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] arm64: zynqmp: Use DTB address base from .config
Date: Tue, 4 Feb 2025 09:53:40 +0100
Message-ID: <a22c9671b965b222bfd419f5bfaee012929f3d88.1738659214.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738659214.git.michal.simek@amd.com>
References: <cover.1738659214.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1gKbArZeFXls+CZh3oLeaWfwnmf6gBCw7vAmFs7GrDc=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSFV6ew+7AqnNmqWRR747Wk6p7ePT+iNt07a/X02s9zd
 x6/uPBEpyOWhUGQiUFWTJFF2ubKmb2VM6YIXzwsBzOHlQlkCAMXpwBM5HU1w/xAjQ2Z23ZGPZCa
 qZO/70n6waPHGPcyLJj0bPF0mwvdnX6lSTu+Ptgr1WjdxAMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f303fb4-145f-4227-5516-08dd44f9739b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NRrdThqCOQLCRjtvELzCfY/4C/i3NiL4EHiWrtyNkyfEs+lwY6vBqWCyISyL?=
 =?us-ascii?Q?CfEMWSChUn+Q0abctOz1wBcgKj4soFe1P/uPN2u6BrRFkrGaM1qY/tuI3X+D?=
 =?us-ascii?Q?9Dq25HonrWiLZQrzpkyS3Airn6szsfxmveq/2fxs7LVHMENyUmuTQLEppFOW?=
 =?us-ascii?Q?Jlqj0LTw+ys4Bp58YjIrCGesg3VAtuPyRu9/qQxb44GAvzZ5cS+vK2iB7sO7?=
 =?us-ascii?Q?Okk32mdGtkarhqjQwRXZIjYcfl9K8ATtMUrhFWKo1mL2BJl4EB5uqCtS64F1?=
 =?us-ascii?Q?OqdWmq89zbKVI1ENJp6ObATQUoyZcU0QT1i9GHuh9w3KBafG5gAonKgNwfBM?=
 =?us-ascii?Q?o4lt6meO7A6rMwrCidDo1/ty74CfIAGmf5sMAIYw+9//mQIH3aKt9n3BFYko?=
 =?us-ascii?Q?Fl/Mjer3ltussnsxFoB+U5dqBcXH8RKHuDm1las6Tb50n43+tAilPvvB2RWx?=
 =?us-ascii?Q?Z4XrkX00wNZ7cvL4DdcS48lfwfX6CO2rxka+k64liv9ZUsj0iU453wJuW+rf?=
 =?us-ascii?Q?r19kN7moPGy1EsuRe5zvGsU+Cq9cseccZeUVkxzmiVjqImItxfnNkKomj7G7?=
 =?us-ascii?Q?zYAI/ks9cr8Vnt5C7lLQA7cHWtQpoihkqTzQ2frl4964S2j0+hgjBw3ZnVfM?=
 =?us-ascii?Q?80c91YXZWPizoSf6OMcoeJYkqEIlp1fjfcCnM8Ixj7aJXJwOUPxbhU94w2gj?=
 =?us-ascii?Q?z0soXxvLd2RByuixX5bwtJpleSW88mOKwKRCVW086FRp15TVRMqL+3i7Kx3Z?=
 =?us-ascii?Q?9explB4CkgXKigKvSN6Z0eb3pQEnmNQKu6vZOcN5xFC1bpU0oBPibNAj5LSZ?=
 =?us-ascii?Q?c/rK9u8f4LA9w+KGJdkZejkotZWQOcd/uPQ1F0eiEjxY9qaOeNKP+vW1FbDx?=
 =?us-ascii?Q?CblRwbSU30/ErBtBVakxsxqiVfaCHX+qic7cVR6O3/k2m5dKCDeo55UAQabY?=
 =?us-ascii?Q?2+NGBnbX/DYdH9B8bw4JUpmvRx1V5sbhAjZMLXSFWSS8J661JUwKoJiSjTUu?=
 =?us-ascii?Q?M8BWGDzrkf13iBj6jfPn0OuR+Ux8kWsf4RTL5qssOzhO/ZxDTNuK+q4lFpuV?=
 =?us-ascii?Q?3O70OwGOPEQcJgxI4pedRQfUy36Fue3TFz2Wenc/RH+JUlxyQFjP8c2HVzw9?=
 =?us-ascii?Q?lPSZ0sEzZilZ+qzNfPw38Lvxftlx54dMw1J7VgMftaYJCprceYpUkyonibu4?=
 =?us-ascii?Q?70ljVIapPPr0FN8r9Lf7hqjK8mNOvqOVnTCpPdmTbk5bsvwHm5dgX5+kSb+h?=
 =?us-ascii?Q?ItuGr1i9NYJ8vyubL5e5oHyv2TG7NbZfI4MoS5LkZM/pZHWYs0n8mMUwzx9d?=
 =?us-ascii?Q?cJ48tuUpNwUwbUoPdvA+vHPatrtYMFLqO5AQ3EVYdtKQihYItEiQ18/OqnfN?=
 =?us-ascii?Q?IpKAOYPsuqIdCV0V0Xsmf0K9JbvjHrrujJ7fb6Y9+kKREhTDXY3JeFvBCbuw?=
 =?us-ascii?Q?Z/8TkEBisGtdc7sQuModY9hbdxOu5H1jSbPS56YM2cvQCkwvZ/BZRlto/xZR?=
 =?us-ascii?Q?DkrVNPCy+tkQ9is=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 08:53:53.2334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f303fb4-145f-4227-5516-08dd44f9739b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

CONFIG_XILINX_OF_BOARD_DTB_ADDR holds DTB address which U-Boot is checking.
Currently address in binman match default value but macro can be used
directly.
Also sync node name (s/hash-1/hash/) and sync location to have the same
order load/hash/image.

All binman DTSes are compiled that's why also guard
CONFIG_XILINX_OF_BOARD_DTB_ADDR which depends on OF_BOARD || OF_SEPARATE
which is a problem for mini configurations which are using OF_EMBED.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Guard CONFIG_XILINX_OF_BOARD_DTB_ADDR usage in binman

 arch/arm/dts/zynqmp-binman-som.dts |  4 +++-
 arch/arm/dts/zynqmp-binman.dts     | 17 ++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index a697c2c1945c..a66b948b266c 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -162,7 +162,9 @@
 						type = "flat_dt";
 						arch = "arm64";
 						compression = "none";
-						load = <0x0 0x100000>;
+#if CONFIG_XILINX_OF_BOARD_DTB_ADDR
+						load = /bits/ 64 <CONFIG_XILINX_OF_BOARD_DTB_ADDR>;
+#endif
 						hash {
 							algo = "md5";
 						};
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 458387161c35..16e1052a64a9 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -75,8 +75,10 @@
 						type = "flat_dt";
 						arch = "arm64";
 						compression = "none";
-						load = <0x0 0x100000>;
-						hash-1 {
+#if CONFIG_XILINX_OF_BOARD_DTB_ADDR
+						load = /bits/ 64 <CONFIG_XILINX_OF_BOARD_DTB_ADDR>;
+#endif
+						hash {
 							algo = "md5";
 						};
 					};
@@ -152,15 +154,16 @@
 						type = "flat_dt";
 						arch = "arm64";
 						compression = "none";
-						load = <0x0 0x100000>;
+#if CONFIG_XILINX_OF_BOARD_DTB_ADDR
+						load = /bits/ 64 <CONFIG_XILINX_OF_BOARD_DTB_ADDR>;
+#endif
+						hash {
+							algo = "md5";
+						};
 						uboot-fdt-blob {
 							filename = "u-boot.dtb";
 							type = "blob-ext";
 						};
-						hash-1 {
-							algo = "md5";
-						};
-
 					};
 				};
 				configurations {
-- 
2.43.0

