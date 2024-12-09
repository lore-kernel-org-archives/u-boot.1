Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF1E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 09:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46972894A2;
	Mon,  9 Dec 2024 10:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kpKiifZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16951895E0; Mon,  9 Dec 2024 10:11:15 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0FA88CEA
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 10:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ke07trjY8wyNO1yDOZLVXCz3huZft9w3i9FyiWrxy4Fh36zlIcIi20Ddt7QbEtrOdV7eCPl8LmkwW+06LJ2qNpYdASA1bnD8lQEDfq1crW2DlyVEtRN2Sa/xWZMUqew4GWbYcl63NFCguJqW0YM9Pcq1k2NSIOVch39Fv3mZho5FJerbrOOWyw/ZcIUs6Y3dLD7pRDQLpwHplNuwy4wUqIQtflI6kgaA+jZBrzpj8uI0zhgPxz88Dc2zuNist1mcjDoDEGKao9GDirQmbUVLxvKYQDoGpmcWAtA4msVAHjXMD7gcpXCSMJhjuXvs0DT8IpA480X/wLQtFzt+Yg6GJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucwsPeZEkyv2I4+f6ggOPvxuXxbcnYD6r4NEkRRa93Y=;
 b=aDzXYHm6ysm3UbJjGgNem/RY6wtaT0JnxIYoCA+1d1zwFqvuEQU1rMrPs/1igyvvk6SGN1oI1aChvbH6xA+MSb5h31ThpUdPpo/oBXZUiy8jpCwXUPyoM9H2DQ8673L/MwEwbRzuf8IcmEY4GZ+Ir39nGYoUGQdb7P4VLr0QVZN+gnqOFyB0jD5wXw/4+vvoeij58hlgAbU5puS6SqH4QJJXKQLohKpTOdUBvdTIrEIv15KnMDZIto0dOmu0Ckmju3Dk7t8WseIAdRNPI5corfzjBRlBiVXWPyxuzzX1x4/pqQwiGBbPCR9Xr0z/jYJVA7iwH5eOflerrAZ9cwGq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucwsPeZEkyv2I4+f6ggOPvxuXxbcnYD6r4NEkRRa93Y=;
 b=kpKiifZHGhfZZURU4fzfEtmdRwcraF3Fg32WkI8AyPxQoXtqh8Wiz6G7yZ6RD8NqKpicoRkdvoBOIxcIVaWTok7KuxuC+K1N5y/PxmaX2G3csyvtZk9m6Z0DOzaDXMQy73hfScsxVqVXxZxz+kdN6NxaNZMLp26N7OGOVIjb9Lc=
Received: from CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::25)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 09:11:07 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::5a) by CH0P221CA0041.outlook.office365.com
 (2603:10b6:610:11d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 09:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 09:11:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 03:11:04 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Charlie Johnston <charlie.johnston@loftorbital.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Do not use hardcoded address in
 do_zynqmp_reboot()
Date: Mon, 9 Dec 2024 10:10:56 +0100
Message-ID: <3e5c6ea426b81cc73b90e6425764e41a98deb2a6.1733735454.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=T+6sd4dYG9cZfYJqRCUXXcGiA3Mx/Jdz/RYexq/sBIA=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSwLYr72Z7cudj/ZvaBCQ9mOX5Zb/VVqkty6dFAK0U7x
 ylsHHqMHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAixvMYFrRnWBTMa1/NdENt
 /e2fHz/4Kvz5O5Fhrhzj9MqC1k21Vnv3897o54/gKA4QAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bca9b42-8983-4ad7-1649-08dd18316a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KWtLvABaC/9sA2lTP5djShw+enbPb82iInRvYmm8hcgZier35hqlFQE8bERD?=
 =?us-ascii?Q?nmCNQJOAHpWR289ts6k6MjDlJfJ5VXX9CUirAq6AW7sVNR3mtTlaf++WGUw7?=
 =?us-ascii?Q?qXCGierANmHpNq9VWSuZyyufuHNTam95rjGjPmRjE+3t2gGd6BmP48Se6PNw?=
 =?us-ascii?Q?49HO0XmvqFXQH7BKLakr+e5hAXqP4jUUDEfypb3xCrU2SzoF4ipNnV5zAMo6?=
 =?us-ascii?Q?GpefCXjP5Qmc1nNRGlipwf9I8vnOGn38x0WzawObchZHUxjoC4FIkH2U3NAB?=
 =?us-ascii?Q?lco92T+Av+JNEQKJJJ2Qdse3og1RG3PNYiTc7gAWCvt1xQgDXAH6uVOMSeu0?=
 =?us-ascii?Q?o/hADPATGGIH2nlSzNNfZIwH8U9xiMwOvSFFtEZuIWaCFeI9LYHIDadrx0T+?=
 =?us-ascii?Q?Hqn9DDCqjyqQvIRwnn/ke0mTJ7rimLtddBuulAVXQz/vv7X6YvqgrZprjx8P?=
 =?us-ascii?Q?VV903sgYCaxit/UKrGX0zrNONHuyQebGxXNcX8XKfZ5h+Zh2YKpNU4e4m3Hh?=
 =?us-ascii?Q?rikIFFB8IsF/XT575Nm8YajfS+ml5t7Qh5lSU/dSSCxZ86GUFraXsos0bcr1?=
 =?us-ascii?Q?lbyvpX7x0r0FUbpUZIvDykSDUZrNoqHW8kKPelGiQh6xCeVGFARO53L4VfsS?=
 =?us-ascii?Q?6O3qX82jV/LCANXSmoj5NjBzVbLk9q6pMjK1JgEbSk3oipYa34HgP63Y+O/5?=
 =?us-ascii?Q?W6xcZNY0shRCBvXU7oS1VOtGOz2u6Jniyg3blAun7zWGp6jEl7jlNuSHryqv?=
 =?us-ascii?Q?oeMa3fsFh8EO2GSg3v/3eqXemg6lu3jRlhSjF1cZU/vbk1m0CdVR7yHKiS8l?=
 =?us-ascii?Q?G3nzvCAoee8vmU373qeKRujQW7oYSRx7Q64GTPzKR3rblu9RZDM0uGzGvjwU?=
 =?us-ascii?Q?eZvsn4yVCi/9YN5BRc1BXZzD4wF2qY/vswDn3CuYiplQ7J8dEIJ20ajZeZpy?=
 =?us-ascii?Q?IsCULBbcgtdWwwc+HLcAfxe4D2sbU7uDMAfOQv7CbNoQM4DNYHRrg5LCte6+?=
 =?us-ascii?Q?xqkJnuYdEwd0Hp8pYtyLtTyzWVVr0IwQsuwoakirH1iuJpDi7tEQo9+jGyj7?=
 =?us-ascii?Q?g8SaQVijfvmcrW6smyU0Hjdhiq/8sgN7nqL+gpSv2lh0a9/SrsoZ5VXmdJnp?=
 =?us-ascii?Q?o5A2L4O8JHfdInvjCV+wMefFC32NmhlJCcqWARBU00TXV6qfetInlDFpZD9K?=
 =?us-ascii?Q?Usqu/auEPZKbCEjnShwYeL97NCpfDuxj6k7sgUK+g6lHRKqY2due3dDzt5/S?=
 =?us-ascii?Q?gqoAvTgNC+o8ATdB3yQlKTtsX6dauvTyxrRFT39VBhQYvT+/Yb7gRPy/dCLC?=
 =?us-ascii?Q?nRYw3+ATepqMgAcvnng/TTWzK+PxI0bYgBdlSzvNFL1aY65oPOUZqoUQePia?=
 =?us-ascii?Q?JJeXXqkk4TlBV0hOPjPVBhc2Y5oc1HY4Qfhc9igk929BqpBo8N14R0Nh8WmZ?=
 =?us-ascii?Q?0hhoVLDYY8golphskM5DEnJ0Evy0xj7S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:11:07.3342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bca9b42-8983-4ad7-1649-08dd18316a6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

multi_boot is already the part of csu_base structure that's why use it
directly instead of using register offset value.

Fixes: fc001432e5b0 ("arm64: zynqmp: Add u-boot command to boot into recovery image")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-zynqmp/zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
index 8ee25e4c3161..3aa218545bba 100644
--- a/arch/arm/mach-zynqmp/zynqmp.c
+++ b/arch/arm/mach-zynqmp/zynqmp.c
@@ -349,7 +349,7 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
 
 	multiboot = hextoul(argv[2], NULL);
 
-	ret = zynqmp_mmio_write(0xFFCA0010, 0xfff, multiboot);
+	ret = zynqmp_mmio_write((ulong)&csu_base->multi_boot, 0xfff, multiboot);
 	if (ret != 0) {
 		printf("Failed: mmio write\n");
 		return ret;
-- 
2.43.0

