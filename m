Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A10C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75680805E7;
	Tue,  4 Feb 2025 09:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+ndQot6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2672D805FF; Tue,  4 Feb 2025 09:54:04 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1ED1807B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5Q+uzZv3DhLD6FBy0R0v6PzDiUnMaZHyp7zWfXEel4WAJvsCiDGgOj9msWjBMmAT/neuNNYmpBg0Q1VUAcIyZBagfy4l5k9Uw7WETenkBZUJu+3VqUqbRWx2CHUq3i3IonXT+GWBNsJTFZ4OYlBVqDxTvJQuAsD7HjvpZo3PhkplUvLjwTV9Iudeio+J2HNyuEeuvHh5DcwIxgwTiy7aKWF02e3OliVhKuX5Y3BMceOUgSfSw1vkTAQ/eR3o9mwOVwHburEntIuGi3orhKEN7q+PLTT81MVAXjyD1leBKLqklBoQrnJFetKb5xXcamTpK0AxDaUNI4iyW2zy3Eh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVuhYMz4CcnXg91fDwlcUvxFFf0kUXGIIEam7sDjVOk=;
 b=LrcJalSDUYgWIpGazKI5UnPRty2zjc0fpi4srdWUQUKiwEl27MiXYKobdrel+RLwKPHR61EndQi+uj0XYOk0MkSMlM4Jle6uL1YnRJopq7Mfnxi4F3cf1BbGkfrVJAEz3BKOlAsS/P0jPb8yR2FmgKsf0JgZd7wABcRcYb9C6mUzHfcwQFsO5I8GDqJhp6+I7AcQeqqDpQ5Gk5GruGHlHfrfo2XIys2oeHzuioJjb0NWETKy9DStolYpGmYEvHGC2K+CjDg1ZABTKZ6yZPyRgTNkp9HB4T3CUskiO4yHJgpdZJKCQ+SUQKlSPEQ+mV+OKerInsiTEtFve9YNt3F5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVuhYMz4CcnXg91fDwlcUvxFFf0kUXGIIEam7sDjVOk=;
 b=E+ndQot6WlwRxQBupsV5ZFjt6lXPp921iAzYQSw/S75mRLFH4MvWkDxBbyL21M4fm4nTYTIDSdH6bhjF3l9PUUOLkl98y+rdagrvhezNZbkRhqpL6fG2rWKiEx7fBSDI4QX09tP7MG2mZ2bDNl2KWngm2OrYW5Wn0uHv8agJs4o=
Received: from DM5PR07CA0070.namprd07.prod.outlook.com (2603:10b6:4:ad::35) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Tue, 4 Feb
 2025 08:53:57 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::52) by DM5PR07CA0070.outlook.office365.com
 (2603:10b6:4:ad::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Tue,
 4 Feb 2025 08:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 08:53:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 02:53:54 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] arm64: zynqmp: Describe images without TF-A
Date: Tue, 4 Feb 2025 09:53:41 +0100
Message-ID: <9b3dad80138e97005df3d033b4611c9d7e05a177.1738659214.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738659214.git.michal.simek@amd.com>
References: <cover.1738659214.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OF95IOyOjl+2PwcHCkRIlUCd9NoPNVFkHcgPzHRU/tU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSFV6eI5+S3bZiyuvr+n/UP/zblfrAzrj69tJcjoHXJb
 +/AA0zmHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiUoEMC5rOXj2dkGesc8zn
 zxH7nKopt77atTLML/Wb1Rvgv/Z0b57S+Wn/9QzKDJsPAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: b434c814-3fb7-4c69-e646-08dd44f975b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mJTorE2uDSXp0y/5RSCytw/0rcKr4mIFfMtU38QdWqZ3lncHOSudgZ7NXF9o?=
 =?us-ascii?Q?X8yNy4Gysjmj9u+ldc45KsgAsSoDQXz1v6MI6oAHLFijlN9ZCXJFi+tWFm89?=
 =?us-ascii?Q?HX3zf/lPRf/obDKih/XnTRUX3DSKXQyOQ+JKbY1naHTfyYc3NWtzCq111uwP?=
 =?us-ascii?Q?1en4tcj3J9HXfagf6Wz6Z24qscjEHKD7UVT2boFrVCa1sOGmPIssxUlDAXQQ?=
 =?us-ascii?Q?UjVtqaVSV5xBp1Pvw/rIHvwnd0rsLciOoPZkhlOgVTZbyN5Pdb8thR2iZgP5?=
 =?us-ascii?Q?XAABrSw8yqpekFV4ql1wuDrBvkGRx17YELfH5mgp27kAVdeLhxv20jEjO+5S?=
 =?us-ascii?Q?ClkrAPSX5mZhzQOXASTv6NFMw9tJLwtUWt10hZ1MLZ+C/pu4Fjmaf+J6jKmw?=
 =?us-ascii?Q?yETDx+q5kywc5cdpzYWojHmMjdIzKowAYeWA0dymnluGC7uIDDLNhKowLhvh?=
 =?us-ascii?Q?G/qG1/0bRXyuEiOA6+Gwz5EZY2gM91fEpzTlOSzGMFl+ZT326QN/Hsn7/9pq?=
 =?us-ascii?Q?KPXzW3ST2iBBP0/nPbbpo1REpwtUljEPuGoLm74HB/6+8oANjBy7W5q/DsQs?=
 =?us-ascii?Q?11FIL/Cmz/hstOTykqaIsarxDtnGDMmHxtnaozWGkRFGtjEjpnCrfwLk3p1w?=
 =?us-ascii?Q?UsKIFbFrksXlLx512n3fcUOro2+FeZl8AFDqCAnF9o3VduZOoM7c5oYVB6eJ?=
 =?us-ascii?Q?Ffz1cTzC2O4Lpe43su4QhSvGxbdOzZEFwXn2UYK6kzodjnqv5t7sH7mhGta6?=
 =?us-ascii?Q?XKOzbY4vk60oncwEE+9gU6Nlb4zmqeTufBRePvVXeDbqejPbKbP+vh4o2Dc0?=
 =?us-ascii?Q?6GwEIDh6S3JJRmY5hOTjzWMPKuxnV7KOrFUOvVGmyb/MxSBigGp1tIJ6JdpV?=
 =?us-ascii?Q?RgQlk8sE4eKLD4wCSoP0krohbDjgxzyvz3jhNS1bbFzKdrAHnjD+d3fvQ8bQ?=
 =?us-ascii?Q?VyT1ozeDTN+ipKWlsScR6AOKtO2aRK4u/nVRl7IlZT3v/Ows26NUTUPujnbd?=
 =?us-ascii?Q?LmQjV+K8e0BIezRu+x3MQOQrLCo0qmkzqGl0ml3p2LPFiI1sC55Vww6wyQhS?=
 =?us-ascii?Q?NzdM8Rcn3qqzhsTPK+CazINUbAuWKPThaRUOPCrD4dVEMHgUtozCloYDJ339?=
 =?us-ascii?Q?i4F/PYF3jspOJFhm9kXslsI2Xa8eLJpEXpMHOOC4h4ZMIHt+LhXFPKsh22Z/?=
 =?us-ascii?Q?0QDJSVLy7zOxg1eK+5ZA1y75a9p7//nJJHDIJWZkXagCTaYxiWJmfUanwjHD?=
 =?us-ascii?Q?QpQsTtYZhLl1xu18RcSIRkw9Y2lwe3CaceqpraQDnYMLpUOgGbQq7IM7IPpY?=
 =?us-ascii?Q?2195RHu6C9xd82A2ExzGaXJXkKSSlY2Wq+1QejRpmzKzErMNFbQBVBd9ybIf?=
 =?us-ascii?Q?k/EubHpaYz9bnbWPGkJnfuc7J7yyzU+iNmHpeNTcE4gRa3bXJzOirC+v8YTX?=
 =?us-ascii?Q?3dhd44ytvQifgKCZkMox7+vgsN4jVA7HKDPOPHW57z08OYlhijuJeJh4eK/M?=
 =?us-ascii?Q?O7o5bFH3S+AfRmk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 08:53:56.7563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b434c814-3fb7-4c69-e646-08dd44f975b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

U-Boot can run out of EL3, NS-EL2 and NS-EL1. Currently default
configuration is NS-EL2 with TF-A but when TF-A is not passed and
configured images can still boot just fine. That's why support this
configuration and describe it via binman.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 arch/arm/dts/zynqmp-binman-som.dts | 5 +++++
 arch/arm/dts/zynqmp-binman.dts     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index a66b948b266c..d5b63ef604ba 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -178,8 +178,13 @@
 					default = "conf-1";
 					conf-1 {
 						description = "Multi DTB with TF-A/TEE";
+#if CONFIG_BL31_LOAD_ADDR
 						firmware = "atf";
 						loadables = "tee", "uboot", "fdt";
+#else
+						firmware = "uboot";
+						loadables = "fdt";
+#endif
 					};
 				};
 			};
diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
index 16e1052a64a9..252c2ad552b0 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -87,9 +87,15 @@
 					default = "@conf-DEFAULT-SEQ";
 					@conf-SEQ {
 						description = "NAME";
+#if CONFIG_BL31_LOAD_ADDR
 						firmware = "atf";
 						loadables = "tee", "uboot";
 						fdt = "fdt-SEQ";
+#else
+						firmware = "uboot";
+						loadables = "fdt";
+#endif
+
 					};
 				};
 			};
-- 
2.43.0

