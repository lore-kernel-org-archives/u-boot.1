Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D433C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 11:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BD783950;
	Fri, 25 Jul 2025 13:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H0J21Dmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655D583950; Fri, 25 Jul 2025 13:26:17 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE9B83942
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 13:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWna0DHJNITfyiGRDUvoHsQu7aScNv8AGXImEkYsaq5rju1QZAXRd22QOzVJYgd/ViZLh/axxD0E+0lhdHxOt2ma1YLxA00ag8y4qIJ5W99hM7oasDcZtBVxwvIGmmEyc8l2DaNr0jCAz/vZqtatYI70KPQikzh/bqFnwVlN9UEVneGWoSRIpvZju4mpoftFZ4TKXOCpzokaRTDSisQc3D1fD2oI2EDJFkHOzJiyEhkkzIpPxmKDUrmPZMmuiifjeqExpYfHZP35cxork7NqyTieVWGxZyGIrIBnkFNcO1GCdNJXb3YgZa8W0sD5iYJf5s1Z4PZMhLyIGm9REuCHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1f8idbhsHpaZ1yypnu68JW1/D7zWF+6RW+ESfF75nk=;
 b=NhUbiQT1tCuRfIEQQRXlhNL6zXnsWMnKdtpcdCm0JUgwr11sw7GvVWDDdkKuRNj7xKFSAba+L/E1MEG0xE6gpaVeTykdIqmYDP5Ca21tY1FslEySmbfvDz0yYUUdD2UVzSXEdv681lbl0oTqsYTq17hOcCZbsmwij5kBHyKg7OHjJTYlgLWcZASVyFbrw9ZpxENIi00eW6NHtSNLo7KBW4z2DF4WpXzXErsocDGpHXbXIxyOxKI/FlyCst/HJTcGLcesqQXS9UTQD+R36ZrvDLGbTGrruSQxizYI+l/XZqxtl3bP1n+tnqKR33WGoTRXWPoE1kV5vD5YZ33KdJCumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1f8idbhsHpaZ1yypnu68JW1/D7zWF+6RW+ESfF75nk=;
 b=H0J21Dmc5nRVpUYc+qefV8II2vwahoyeLFzJCa+yZA1xehiomLMuJYhRkexDmA8KLsigTSB1e5aR57uizcEp6xMNlHJsP7q3GoOJhLnQuStNbeaMEiAFFb3jnL/pgejOsJX+ErurPCddY6afY2OD3o0Dg8StiP15J0amBBjTtFU=
Received: from DM5PR08CA0035.namprd08.prod.outlook.com (2603:10b6:4:60::24) by
 PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 11:26:09 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::9b) by DM5PR08CA0035.outlook.office365.com
 (2603:10b6:4:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 11:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 11:26:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:26:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:26:07 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 06:26:06 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <p.bruenn@beckhoff.com>
CC: Pieter Van Trappen <pieter.van.trappen@cern.ch>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/3] fpga: xilinx: Check valid desc structure
Date: Fri, 25 Jul 2025 13:25:52 +0200
Message-ID: <6d54fc5633ff8281009987056f14cf43b23c07c6.1753442748.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753442748.git.michal.simek@amd.com>
References: <cover.1753442748.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=756; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=t+raa02o0cMrzxAKvgEAlrm0Mkfhdv2wNGgJM4VLNMA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0Zx7PWuA2bcXJ6wumNuSWzBCbuL7vqvDHzB/Tvs4qX
 ZNxx2ohZ0cpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMRMGZkeH23L5skax3r1/m
 d0ya80Z1WeZZ9XknShZlW+9hvBgvmyHHyNA39/H/ys0ifJOK5S8Ll8eabP25jUt+4g/xjyETW/d
 IbOQAAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ecf5e6-130b-4845-2d37-08ddcb6e0da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E7oBggTnVh7IIC8GUPfg9XaDt0yEgXjriKMuDG8VXg8WiuwEoWPd6YpjpgHk?=
 =?us-ascii?Q?SYvjYNqyllpEa4F0CMbNcTdcxDkamXDTXxo5Op1fjkZuNWBTtIptYiHf2fQ5?=
 =?us-ascii?Q?sd/h85prYnKysONXbHya8F0M9NX3f3NeGqbXv2b9RimNUnyjSP+0Y45EjGJM?=
 =?us-ascii?Q?xE/qhtAJatPCcEqmR3xJnc8rp+6dkOEgqATpkYOfnRH3K9027GzQfXytfJIN?=
 =?us-ascii?Q?KhPhjpkfHVRcP8uXs4c5DClMJ2tKtPF0HgeIVSAyDcddS+qe3vWdS8el/Puz?=
 =?us-ascii?Q?kZbu3AGIva79Uy+8COEKEdiEwitnfGEQ2XWnTFOLshSDUopn3R2AkI5MUDc0?=
 =?us-ascii?Q?XJxh/wBxLOWEp61x4+xf67CN+F4fc2fY9vrspFP76dWjpXX5CGMni0tXKXrm?=
 =?us-ascii?Q?PFXwSvjHN62MAH9Ol+8X9DDfWCs8bmBdi3GC0t7yQy4ZZvtNdCMBE1jEmn50?=
 =?us-ascii?Q?Lgly+NZ5gFnztZNRgbO9tRL/jv1b4luaufVGQkt00Sj8lxx7wcDjJVQwPUGN?=
 =?us-ascii?Q?En8AYbrS098O04oZm71Z1IvnWKRrDqmIlmySaB017LN4yyKZc3BOUVOalF3Q?=
 =?us-ascii?Q?SmQXBjd0mwj6USPdNiXqkdVkGfWiV6ZtMmlyN/PDHQYo6AZzlSlEIfWFEZL+?=
 =?us-ascii?Q?3f7zbmTfn1Tohkcj7d4bvrXWAq/3HXHJWGhsGJkdAfpNXiLH5lb6P8q9rKLQ?=
 =?us-ascii?Q?4ul1pQZeBfqXIyj/KWthHSWUx6TwFdUo7pIYbRAuBMRA7eHVqmIwwJdD8YbE?=
 =?us-ascii?Q?xRRSxMiL6crLJSkqqaVHQEU4rB0chFjU1IG/oHF3DhB3jcl74XnpovCGBURk?=
 =?us-ascii?Q?l6SVbh+L6xQ16uiEYna8LyIKlyYpskSxn6kymhfoBbAYMroKaZXJw6mwQ9iM?=
 =?us-ascii?Q?BPhVrMWtHcJlNAm1xt1R+sB8Nu3QNb9otqnJ7blU8KwLnDtl+EazP9yy6oVq?=
 =?us-ascii?Q?+96WWX+FFloKOE/aSEiMeSFq8Snm2XEnV4oIsBSbD10DVZyErjQd2sRkssRC?=
 =?us-ascii?Q?RPhd0ZtJnqxnGtYCS05R8fl3lIwjLdUVB7hbZxRhQM3j+Z08UEENpAB1DCaW?=
 =?us-ascii?Q?wT+XRrNmgy5MfF75u8e4XnrWlwvlGTP6vM05q8o+DlqryQIeYxoDly359MjZ?=
 =?us-ascii?Q?oYzQtcdLuvIpmKMmzgavElquT63Yn2httC5JuglXUpJqtQR2UQBo3b07zz/f?=
 =?us-ascii?Q?iCuQ5ud16oilSV+pukKqL6U4eiqxFkjnCgvde5q1KLII9QLABSF/Pa5lSlnq?=
 =?us-ascii?Q?tJtjMq5KxQPJyuh36o7X+WlwA33kiXleZZekAFy5+5R1UwYFpcidSDZMVxyh?=
 =?us-ascii?Q?3/5xOhfsXu8hI1I9ZxGMnqIe+av4+K1mxvbMMXKGIAmJ195HUlubjudUSe4C?=
 =?us-ascii?Q?06zTqH31Npg42WxYyUrJcn3H2obIp6HG2/3wOiPRR087lqjM+nq8lDEN9Uvg?=
 =?us-ascii?Q?+2wmr0iyFI/SJTFoxhII4aa/yWrmLe1QeB/EuR9Di+gcT88QizGPl2sKNJgy?=
 =?us-ascii?Q?pLlxKYIOhJdcwKutvWoZtVZVXUJ/eWfX1MKd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:26:09.1374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ecf5e6-130b-4845-2d37-08ddcb6e0da3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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

FPGA validation can fail and return value needs to be checked.

Addresses-Coverity-ID: CID 583150: Null pointer dereferences  (NULL_RETURNS)
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/xilinx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index 28c68faba55f..25b348648eff 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -50,6 +50,9 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 	dataptr = (unsigned char *)fpgadata;
 	/* Find out fpga_description */
 	desc = fpga_validate(devnum, dataptr, 0);
+	if (!desc)
+		return FPGA_FAIL;
+
 	/* Assign xilinx device description */
 	xdesc = desc->devdesc;
 
-- 
2.43.0

