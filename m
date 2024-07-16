Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E71AC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 13:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889C788971;
	Tue, 16 Jul 2024 15:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0lxwqydv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEDC88865; Tue, 16 Jul 2024 15:29:23 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467C9889A2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 15:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx1L9IGhjepCXCgpABEukOX8fBunBMwAfyxBUObeAcPBzk5+PFZATcy9IGKTwLGIy4W3HDZ0DfZRQT9uIP4XqNqX7z8j5gs8U2N9fdxymcfegXCbZk2rp8Al3tyxQzl1qfEKq5Tz6DW7zXMdWCSgaUQjN+zZuALjPpwRDgYM8dAx9kOBCtkr9Ees8OOnd9QkZ/I/ZxnZrB76nOZx7ad74cpSaVHLgz+gFU3qtfSsT6478s6cYMfjsTe4L6VTfCzcZVSwNIf1n9q3OkSaIkLVpVOcizN5ZnpKpOebey+V9xJ1FpwamG/HFHCraIvpFCzkhf1iJzKCbZPb3VSAI7mwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4HnW9O7ktplv3ac1M0agOgFPY/zpxRTaHejevtHN34=;
 b=rvtkHH2+407BqtIy6YkzcQu6orK090scf7F02YDMFK/vBbmvagJkUBomhIfX/JUC7M8tCffpJlWcFhI0xu2US63id9xTlrvDCvHpEkpbRHmAkp4Pz/dXBcbMWJmuv9qP96ZC3e5Kcdx6bjCLxQLm3V0uffzrCSIg/k4kTjkX6inGn/GdO9OMTya8YzIzDYen1eCaWUysHYpvz93v0sKEKCDPRX9x9oKNJIGmsCrh/O1FJv0iSCmwHWay/7vQDIh/Vnkmoqc8tVtI6MjeXH3vK7EbRs/N9OyVZUdJ4EpCKkwFFKkp2Hp1wat/QGtDVtk+L6PAOdG9ZASqIto+soGktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4HnW9O7ktplv3ac1M0agOgFPY/zpxRTaHejevtHN34=;
 b=0lxwqydvwLKckCeDfG4cH/tRupfC57MR0kceJU2f7SENX0XTKZIgG8rHDPFPORJ5iGH0VKabNOf4aIGQw1iMo9j2V/FoOod7LoEx/F2wwbc6QQ6AEZQsKad/MDOF57+Py+CJAnPYNVMIcIua4St25eG7P8E5UwbrojVYkmVetnA=
Received: from DS7PR03CA0131.namprd03.prod.outlook.com (2603:10b6:5:3b4::16)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 13:29:18 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::c3) by DS7PR03CA0131.outlook.office365.com
 (2603:10b6:5:3b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 13:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 13:29:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 08:29:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Shubhangi Shrikrushna
 Mahalle" <shubhangi.shrikrushna-mahalle@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: xilinx: Describe TPM reset for Kria CCs
Date: Tue, 16 Jul 2024 15:29:09 +0200
Message-ID: <2c0cb3a2b27a3bf0ede75c5ccded2d086d9c62b0.1721136547.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dTUvGuCDM38qKHolFkNUSbnvCw7WRW78ROktBGFq2jg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRppcu4Gpbl7pJpXjx9tug8ptdmvNqmRWbzruQek9iuv
 zfc7xZDRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIHA2GBROYnrjW/dhWbsaf
 c2vpidZ3fQpO6QxzxdrquD3s/Ce6hVpYljyQdfqt+O4gAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: bed42ac8-ffc8-4fd6-e90d-08dca59b4b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R2N1NlpOIutD/e93HdLhWShRwbTLFAMIWWRLM3KC345pz1EjXIjikoNk2Cpf?=
 =?us-ascii?Q?kxG2FmoHwNPPqR4P1vGHpZSt1LNjMpidlvqITu5Qb7aHLnFJPnE+R0zZMDOZ?=
 =?us-ascii?Q?yKORPPLxLHp3NTEi6dnL09KZfKHlLGwDKQvWglav0/ph7Wk2mAZeMnJFlKia?=
 =?us-ascii?Q?8Pk2Sj8xR88t8bw6aSCs3DgJJb6KKI1Bv5K4a3fao0ZjrtmcIaoF74leclWp?=
 =?us-ascii?Q?2du9xy3Y7dFSaGEN9JGZXYS/PSbZlpVYoh2BnK9757W3ny/F+vte8BdUJ1QJ?=
 =?us-ascii?Q?r1DjX56uPzj4Nd8QWxYl2sAws5xqHKdYFK5sLAoFWFk+aDMxk6ujjPkzMMr/?=
 =?us-ascii?Q?57S9AMtfWzu8YjC8e1bg2ndjx3Jzc6up3lyU52AVcrhpTwouUSwU27iD9oLu?=
 =?us-ascii?Q?DjG/NDRp5zlGVi6OIPMC1Me0zSS0CpMpWgfSZ+mS56n/bNw/QD7JLAj2IUKp?=
 =?us-ascii?Q?AMYKZc0sl0fYybTLW1qvUPI0C3aO0ePsM0oJBHRyUkAPgPAKKU/jcuAQX9Oo?=
 =?us-ascii?Q?TdHouuHytHkUvbgIHehkKOjyGjvlxBpcZ+oTw50hPp48sRiApPAtIRifBiXF?=
 =?us-ascii?Q?6gprA6YVzdbg0Xdd9j4JyMcroqEmq1qtleuZTIMQEolVBYr7R+jdqJUwZeGf?=
 =?us-ascii?Q?H5J6peRnlN2ZyiFzVU4XTw9ECxCG5eeIQx7YfKAcNqfRqguwBvsnDyY1x0Me?=
 =?us-ascii?Q?KhV37wtDpPZvBtlvYjiMecgpwXXbopS0TUhm1TENswnHVbvJcQk3W32YsnGZ?=
 =?us-ascii?Q?4W6xOF+FaGh3f97vhDBFjLWxM8VbO4hekcKJT1RaZKrzp0co2elXw3KFC8yq?=
 =?us-ascii?Q?Tyo/WyYwhDu4eGsxYBo0qy7DibujsMCB34zsHhVhMUhTRu1Iwk4/OO3OUF9D?=
 =?us-ascii?Q?eKbUr8QRrtLSUHapqI0TAPeIrOe7LpE1SXXpZ2n7cU9zPBjoFw9y5dheZ3Ln?=
 =?us-ascii?Q?5Ig/w34CYgGfhCAkZhwhpns8TaCCdyigYkcaM8i/acihYP3EXHWkLP3YEPnv?=
 =?us-ascii?Q?TV6x4DdHnK2HqPVtdfQ5lCJFXTBaeAEgQz+cE/yNI7BKBYt4AUk2ggOO2o2c?=
 =?us-ascii?Q?G/+vVHJJssEe5+ROJqFdabYOBCWAEX4rCr9NCMcJZcU6+jzOW6hslXOOrueL?=
 =?us-ascii?Q?8H1vQT7VoRmpLzh6uEIJB1wt0dY3zgmEi400uW70jGDG1XwfKD5BogMC1a+u?=
 =?us-ascii?Q?uSnV/3hLJdqlezrNzj6ELoa1/88WrFIyJ0eU6KIo/1wK4Qpx4T++fGzXbipE?=
 =?us-ascii?Q?j9fQgR4eEkJyw7SgsmL5+Ein5gsawhKgmWUPLVp5VvpOBUe0Yvg6Iz+7ar7E?=
 =?us-ascii?Q?fzwXjNIimuuUjv/C0YNbBqiYs5EqzFv+sk63ll9jDG7nRpK+OLWsxX4Dt6JW?=
 =?us-ascii?Q?CCr4lc+HyOpxIsQdJ0r4wtWvm0YicQXUGX1AANBJa9oF5Jl8y/uQo94NAvIM?=
 =?us-ascii?Q?7J5zqR9FsUlAcErQcRvBu1ObbAsST1BQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:29:17.9405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed42ac8-ffc8-4fd6-e90d-08dca59b4b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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

Describe carrier card TPM reset behavior and show message about it on boot
console to let users know what to expect from it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 69e333c53887..49ef3e7d7532 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -63,10 +63,13 @@ kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
 kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
 
 tpm_setup=tpm autostart;
+tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
+tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${card1_rev} = Z -o ${card1_rev} = 1; then run tpm_reset; fi
+tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
 
 board_setup=\
 zynqmp mmio_write 0xFFCA0010 0xfff 0; \
-if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
-if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
-if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;\
+if test ${card1_name} = SCK-KV-G; then run kv260_setup; run tpm_kv260; fi;\
+if test ${card1_name} = SCK-KR-G; then run kr260_setup; run tpm_reset; fi;\
+if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
 run tpm_setup
-- 
2.43.0

