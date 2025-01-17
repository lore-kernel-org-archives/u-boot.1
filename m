Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340DAC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 06:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770798069D;
	Fri, 17 Jan 2025 07:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QztxZNgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E01806D8; Fri, 17 Jan 2025 07:46:12 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2735180312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 07:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP914vz3EA+RbV7kOEqp9Bvhe73iB4JpSQ7FJqAlVUmXJR3xVBda1v04FCxE2vabp6T82nEn6O6ThYEKfvE13Fh4BR7VQdYAKB5h/dJuh+33rk5pfTfVHpZaJUWR9ZmADKw5E921iyECy+wMhiRGOwZz0Np4z+xrETb5I4vHoVz5Hb/s2vQrSiqpEfVlKjSnkIFNNyYsM/M2DSO3iOgsfTzAkMSuasPAFrfOp9ebiyFXYyLrSpPHrvt14D2xjQVNWSLOvQer9aps2ABClcd1wYBoZYBjEl6dIYvTBrtuVkT5Tnu3Fwx6z2K22NmZco+/k5XKBmxRbC7RBIa/QNguAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9VjiLGm043LhhdeICRNEuYbREsI0eDlgQHq0V2jy9w=;
 b=o79XQxEEyayok1op4+O1m08V7O2NYhEE1HVXazptt59AX5UVTPpLv93lhTAWDrMrfPZrPQaTftcsonzI+XyugQA22M4/FrKr9a8YtV2fBMuHuOsqwKJDus+kOLQkf8KlAG9dzrLErcfarvoKZhp81V8N/dkQhv+iPXi2keO12I4rUDFKezVUfHzCVqLDYiz5TlxXkEjPzJng6Fd69SCG/Rc6Vr5qVvOu9ZECaNo7+tB5RJYWF7eiBpzHkXuavz4MB/wjsTy/8kejcYY+8emA4dbbDl3b7kMoNG8ZDjwmxxL6Vqo5BhRVlcysYVbN1xNxSftlG8Tj5hBno+sNkRvqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9VjiLGm043LhhdeICRNEuYbREsI0eDlgQHq0V2jy9w=;
 b=QztxZNgCL2+oKMyvkTSGUXhSFD2SQrv0xq0CoRAcL7ZjWXYA5LOrTwXQAaMbpXhXdgwNALnlSOUGvcR1UA3B2ySTwkXPlJX62lSO4b6h7m9Zca8+VyOO68rE09gTplYlP/zKhSdKE3HTGd+1M/9/spkSOUYJnRZZDJ0gQaO44dE=
Received: from DS0PR17CA0001.namprd17.prod.outlook.com (2603:10b6:8:191::19)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 06:46:06 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::3e) by DS0PR17CA0001.outlook.office365.com
 (2603:10b6:8:191::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.19 via Frontend Transport; Fri,
 17 Jan 2025 06:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 06:46:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 00:46:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 00:46:04 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 00:46:03 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] arm64: versal2: Enable the OPTEE command
Date: Fri, 17 Jan 2025 12:15:56 +0530
Message-ID: <20250117064556.673369-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: e19c21ee-7df4-44be-5db2-08dd36c29e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y10AkF+/FDgSTvLeyNBlxqK/Fub/p9L7xhLUisNiPPOQqbEl4qJF9s6cBUW0?=
 =?us-ascii?Q?cPbtp8t6kQ6+flU/AAcNcfCQbG4QF60T+HJumBllzhTg5QFA0Imn86vrsqz9?=
 =?us-ascii?Q?i4FAc+YVp5fnojJoZfyUN6gDRSmcvspnJnZuom1VNnzDzwNk4oa9RI7bAqEu?=
 =?us-ascii?Q?E+bsa3wHPwvZDUd0RJeWoV2rp0QomF4M0DX4vLboipL6fU7qB5cY/HMaLsGv?=
 =?us-ascii?Q?WuAFbIWCoIXQ5pPAQt6n7Vb113O9cp0tpoCALCuCCsTZKUPczByPbKaLTD3G?=
 =?us-ascii?Q?kw6BUouAyvJgOiKXqpMKL3ziI/JGPNFDas6DmttvAqLRPQ5tWh+nIDI/CTbe?=
 =?us-ascii?Q?PufwmLOt70Dh572jUrx1Ti6Bg4VQa8tmohw/mJqMXfyH7ppcwa37eAslulJx?=
 =?us-ascii?Q?WGbH/JYHUpJ4BQCCi2KMZvZgfctwrcms6Lm9COi8eImiJiX0evfxMCxs13MU?=
 =?us-ascii?Q?y62934dNnb+RdnwwbQIBXFSsDOUb/y5J530P8Wlv4CZKW36bTYvRVmi5ZHV4?=
 =?us-ascii?Q?UlPInYMDCPvW/FwABWZA2wtcX+LOSdNogpvXR6pc22ct2PpJRXkPKRrhw0nW?=
 =?us-ascii?Q?OOqOkx4/h4tYQVov9BhZlxvu19x+hL+aRydFpJ3G7AgwDqRr4IYlF+VD8KE9?=
 =?us-ascii?Q?+nnFvjHiwxKp33d/3TejnNLAWaCD8aPS55dN0p8XRVG8NutDLq3UdfQMEqxp?=
 =?us-ascii?Q?20PL8PKNRwns3GzZuG3WofHx64DPUpalyHc8uZQlz8VLD0055LQpH7qVIIdK?=
 =?us-ascii?Q?7RKJ46f38PEmVA1s2vT0J+RvNdhmKrII7YD3bQIjKYZqig3CDEKXSoCDXjFO?=
 =?us-ascii?Q?bEU9uoDS3rwUeoyZujkg1bf9fk9npuRv1sVKL/8V7W39amUDgstJynrj1Co/?=
 =?us-ascii?Q?KOPgF4K1bHqqsabjdVZdEP+6v+ZObc1j3QOFldokX+LSzvp6C0yUvrOK8jkf?=
 =?us-ascii?Q?z64d21uAwTMq1BYBUidL6ggaqFzYWLOY6zUVWsHOVjEH7q/CipdSVIg/Cpnx?=
 =?us-ascii?Q?mxIdtGLu++uAY3ypjnHZ68qeoM0Tbsm6gFdYT/WP7ZOeISNkHJKv2EsBTPgt?=
 =?us-ascii?Q?8VLOFFOf+8mFFZAJebJSpjElcyN5BzwNVqbgbPi9TYwjyEmdSNmznt4CiaVm?=
 =?us-ascii?Q?GC9IpHJF8K/apNL5y8UNKL5/Orsht/pOEWN4NonYFrf0oDoLQ7urt/dYeEuS?=
 =?us-ascii?Q?y5RqFHNY4/eTIPO8xlWVXH824UDroeOYJHOgFi8mNfrVM1AlO8Oj2mg0Dwwl?=
 =?us-ascii?Q?xK3vBF8t1qk8q9sYQ/hctxG00xaOxecUX+Pc/ov83Qu6knp2uYKBSOpbF6DC?=
 =?us-ascii?Q?/LoCmktmMvuAlDgDv+SqEklQy92/h9hKXbrOWPRfc1R/NmMtdx3iEgtXLFav?=
 =?us-ascii?Q?OjfW4XLhPPQPFwHYPFgH+4cesP9Tmgzo94BlIOGq9Ayn7sHgRMlP5GJLL6lt?=
 =?us-ascii?Q?qm6cCl6hAPNU30moaalylwukxdJMkdvPi/JmJfnEaEXxR1Mkm7G4i9/f1Eb9?=
 =?us-ascii?Q?9Wu0gRyWYk7sVv4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 06:46:06.3007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19c21ee-7df4-44be-5db2-08dd36c29e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
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

Enable the command OPTEE which runs the basic 'hello world ta'.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index b4aebf3e9fb..22dad1b7076 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -39,6 +39,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
+CONFIG_CMD_OPTEE=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
-- 
2.34.1

