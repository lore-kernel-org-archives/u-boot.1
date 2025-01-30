Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F028BC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 08:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7937E82012;
	Thu, 30 Jan 2025 09:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PmSWzgGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6425D80AE2; Thu, 30 Jan 2025 09:08:58 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C8288205A
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkxYz4n+I1pGeFPSm/LWHTbhOy5YJs8E2tojz+B3zAfxMOBTvGG25qQ/FtMefW5wTTNr8e3cZui1gveQfNgmQtsdMP4NV54MxqUn03cehJb29hCwMke/3kYPAObpi7qiajUlRsSm61+sKcee0NDA1LNTw8sIQHjUjni9YJ0kjORyz3ssbt4lj/CyQ31WPWKwzQ0vslOrThvTCty795zpJzxIlM+SVVYaM/cy1Lgtd20V6C8PKGfUwxQ/6YjWZ3W+aDDTMvcj8CeGJS1sjwY/HqR0QiL3zt3P+HOkalQozwlwd8XsYFOuH9O9CMd4Cus1cpr/DMDXN/xi+tdD10SLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuFoTNRJtqMvfMZfiNlLR/yCt0TooZZ2vNB+V2lI+eE=;
 b=OaqgJPKptjKGv1T1BeKZbthueuvwSRsIJfwECg/wOfKVC/xGTyO7klIfXtFS+3+qYKT5mywax0iCG3RrUU/ZIcnK2vR4pTKmsuwRts/f6U/nDymym0qQAuRoFReM0HQe4y2pei5scczT4xt4FZB9CKa+RUikaSKkMlzUx8/9unVlKFfiAB6gv3iGO/2oW+qv3eurSjSubcdoBkaYsAMWV5+wobA5H2LmNYzzbY03mFOpwx3a+T+z3Psz8QKWN9LaiFaA3TSPXzod1cn+GrGSEvjkV/Mlehq1C9RWWqeMtmUCuJxHv5vI35ArvRRneU3fXaNdWLTOqRHaL2rCcxJ+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuFoTNRJtqMvfMZfiNlLR/yCt0TooZZ2vNB+V2lI+eE=;
 b=PmSWzgGsJ3tPa35hWAygLTY93hDheA96nxRe6+bU/Va2IIk4Hnjs+vfqBHCrBgrHVOrzuSzAJs/stYuSUcQj/0tZcp63oBaWbsT2SpY1OR/onsdJRUUWrAN14telLvQHyGOWVbqO60E21s5VAPJpZCTaV/UtAf3gPzMC5M03DMY=
Received: from LV3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::26)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 08:08:51 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::a7) by LV3P220CA0005.outlook.office365.com
 (2603:10b6:408:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 08:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 08:08:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 02:08:48 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: zynqmp: Describe images without TF-A
Date: Thu, 30 Jan 2025 09:08:31 +0100
Message-ID: <63a15843ea49477c8db1fe5458a2f4283c4237c3.1738224505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738224505.git.michal.simek@amd.com>
References: <cover.1738224505.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JACIeZTLWS+6SYPy966KZJdCdt+ZAvFNB2LHfuw03VU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTZxk0iuef7Q7/E/Vsb9EDitn06444d85X5wiwaDf1Ez
 sgxh+3tiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABMp2Mowv/S2/Txz9pvvahKS
 l93qDp/8+eLcRIb5njWzyxqyVa5McRHz4JPaFvjQrdsCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: b73c08f0-084a-40c0-22bd-08dd410554a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NW+etI/cnP6TVpZ5Bq3c+HGmlS2FY5erUHgy+NF1Zc7N7xd+Evi3gXaEyyuz?=
 =?us-ascii?Q?eAY4GyppWK6Y3GhxjqT3aCniuTSAHSerpwud6GgVJGQ6mH2Jg/JYdGYFjoK7?=
 =?us-ascii?Q?eG+t0g+KSP9D8U8+A76PKwsVqqUQT3F6rRB/U4VjBR0NnbaWo/8gCGq0uLFh?=
 =?us-ascii?Q?2icwxCassfuPid+XesBtfR5WGjHd6LmTEntwOP6dZ0RiVSyzXwrCxpX5reu/?=
 =?us-ascii?Q?hIoKOPXD0I4YOKKXdu4KEjh22hzGf9ezk2Ii1aEgknbTkvgtAmGR2Cd33Q62?=
 =?us-ascii?Q?mqZ+wtgTp1P0oNPWGYcdlw5EhkXqsuOQC2i7HAryDNyd1aWEyOVx4i6apD07?=
 =?us-ascii?Q?F+Q3wloLzxgxpwfdCH4mM6y2No39Wee9Pz2w/ZjWSK7wE0B4mAWTH9hxnxNY?=
 =?us-ascii?Q?6FXX4U1Vm+bBXeZLHF/1DA67KG34h0+l9ld6sWZ9xqWLOQ9Y9vLi4haRng39?=
 =?us-ascii?Q?tcVbN6cU2WuiknUp6kjR+KK6uyfw6IJTbA2t61I3fdf2L0Y6b/WN9dipNnUg?=
 =?us-ascii?Q?tl4+qaaKPunlPY2ETcYLNRnJgcvnht/V1/irBlgJVo4hizp+RHpzTKTeX5DC?=
 =?us-ascii?Q?9dZnxsl+TR39oqweEMdYnS3XC7YX8+h11YMAS4Xi/btRQPho8N24HbER9dn6?=
 =?us-ascii?Q?V9IJdScZaxMZmhhSWcbsEi2nHb0IY2P0S53kW2fvscReJzjtq6kFztxUw4A8?=
 =?us-ascii?Q?IFcQx/0cAqPqWkxsgzcPc3lztzIWx58gNXRycP5DhxAGGNccqMHDugwfkvVs?=
 =?us-ascii?Q?KhgExOVHgM8E1UmAUVhuSnEk9hT/YCNuzgocDu58r02TJNnBnmJ5gWYzoumv?=
 =?us-ascii?Q?Qr0bdhNnQhshGgWBmeHhS9oh6eD/RWYNZJPUSncez2Sj4dlZTcBl25VDId/G?=
 =?us-ascii?Q?XKHeu2rKwDw5egVEBSA/f6a+MIgnDmabIU4sly7ioPRKg9X8S96N9oeSo6a2?=
 =?us-ascii?Q?piVavG8Y+7syvfcSyX507LkKTaeOm5MSoXtOfmlnBuj2Smz4SrISpXS5Wqcn?=
 =?us-ascii?Q?TDP2nZORTKCaMFFGDLHxtSxIQEFWrPmRbCZx63COqWlja4h/Wm8OuylEacLs?=
 =?us-ascii?Q?Oc0dnlIpohT/O+zhFDsKwyH9HhLVbuFsyvg7cHlOYv72niDpRUlOw5xfUJMG?=
 =?us-ascii?Q?lAuDLtt76hz+h6ZuVUX2TRc3pVb2rgE/tlb1aIx+QgncP59cF6AeJMrvSQid?=
 =?us-ascii?Q?QUFwasBfhmLbgmcn5nh0+W0swpOYzcqAZwjdd9J3Whrzmceih8zNRqwYQE2v?=
 =?us-ascii?Q?6yrXPg8u3jFkWXP+n04lkJt75jSqucUtmQYag+fwjYZQsGBs+u6Z/hg0nrRb?=
 =?us-ascii?Q?TY96lY0dcUX8TEfyDV12SXglVV+8MoGmBfbuxrypSocbeLXKso4LGaJkdEBp?=
 =?us-ascii?Q?xViLpSbJBm/CRu0gdagJFlXF35aRfOdG7OqoqXddOGupSegfoNgJFCEdpIX8?=
 =?us-ascii?Q?NHNgVZ9zrzklK7NmCBHPLuzDI/i4fYBjChYJGZvDxk3cw3beFm+RDiqL5Adt?=
 =?us-ascii?Q?T/mevIk8Kp9Q2ps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 08:08:50.6382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73c08f0-084a-40c0-22bd-08dd410554a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

 arch/arm/dts/zynqmp-binman-som.dts | 5 +++++
 arch/arm/dts/zynqmp-binman.dts     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
index b0100b23f7f5..634118d170e0 100644
--- a/arch/arm/dts/zynqmp-binman-som.dts
+++ b/arch/arm/dts/zynqmp-binman-som.dts
@@ -174,8 +174,13 @@
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
index b3cda8b59eec..3348ad63ed63 100644
--- a/arch/arm/dts/zynqmp-binman.dts
+++ b/arch/arm/dts/zynqmp-binman.dts
@@ -84,9 +84,15 @@
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

