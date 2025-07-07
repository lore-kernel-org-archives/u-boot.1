Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F95C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 896958304D;
	Mon,  7 Jul 2025 12:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cC/VFhrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C88383102; Mon,  7 Jul 2025 12:39:42 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFB6830F4
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjJpqiYXbIJ8N8KxfsO4gA5jmbAAyrQJ/1l3jIysvRD/5OegxOGm8el5dZJVhJlJnIPK8Q5vkdR9tJ4SE4tV1A+PtNVAHUk83DM5ivupe/rH9A4xgrVuSWZgjgDRQJm/KRopVo/eTZKN3E7OJ8wxAt6V141hpbqaRSl6sKnqaNVwRMeoGBF+QOzFS4F90ub560HBamiN9JJyLpOW/aA8xvEVm+y7TrBeGOysh0QODZ0VwA4BDH33jvy2fKfG1F6k00bRFAHYHsd6PP4ngsVYu6RXrwCc9qV9/JZTyCwDyuj0PZbFKaOxFjYccpdMAuF5fRfzyoja1P2aMJWycvq1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWWSqn2D0qu4qG+otIAV3PMVZ/XG0Y9/eluiTvFAVqM=;
 b=zNLKUXXUbmiye0QQJprHjeqnz7j/8yf0ugwuJzetWeEL9W33IQGhzcvXI5oWXf3RBO7bseBA8nkBWO4rQbkO7M7vap2YmA5bRCiUXvEdHpHwGEfOnyxgaKjSo8MLuLght4wQyh7CHEKRT5YQj7V4vVK6ZXcWgkqA2wPbay5/1RKhClE5c4TFAZlBiXNNdqhdxQwUEYuTS2TgV5JJMb2kUCiKiAZH9XF51k3zkpU9wYQGzB6WD37hXcQLEfHBXA2wp8LlM6cb1r7COrdj0SyI5/KuBwRWVmusARJ7MEV4IjvK2InYYQZNOgX3ip4PbU6OWSgFw9ROaslgYRQmN9u9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWWSqn2D0qu4qG+otIAV3PMVZ/XG0Y9/eluiTvFAVqM=;
 b=cC/VFhrwS855o5Ej/vu9MtO2hO3IzyWOceE9Si+cmWKh320viGHB33P+ZoDducb5KNJCUsxE4Gb+6P0PHytV9wMQ8+RrO6pItUlKWhjThBL53mhVwjigKuwMXH+2m5S+QFw4mOIe83tqvOU2vQpcgUzB0PwFjo1XuLTv7VioIao=
Received: from BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 10:39:34 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2e) by BL1PR13CA0443.outlook.office365.com
 (2603:10b6:208:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.19 via Frontend Transport; Mon,
 7 Jul 2025 10:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 10:39:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 05:39:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 05:39:29 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 05:39:28 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 2/2] board: xilinx: update guid based on metadata
Date: Mon, 7 Jul 2025 16:09:18 +0530
Message-ID: <20250707103918.4189148-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250707103918.4189148-1-padmarao.begari@amd.com>
References: <20250707103918.4189148-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e430c3-e3fb-4ef6-5756-08ddbd429048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RE/29idc/mRcQmsQTqpCwaRUJatqTl5YApDWPZi8bfcOFnQuHSVMbUmIZmNK?=
 =?us-ascii?Q?JFYyjKrQ7kzJOWylZDWYEwC4d8nrHOxYTQfgn+Y24asl7oHlaz1GV8phCDV8?=
 =?us-ascii?Q?glZJyUnaTX6p+rBii0+uqPiTRa1HA5P3D/rvLzQlEIsydfmuJ6IEQ9jfux0x?=
 =?us-ascii?Q?8p+G8FGs9XjwQTn8yUMBq1d9CISdBUjGzAaA0ZrPpfdBagJTvMol6ocTOEMz?=
 =?us-ascii?Q?NzQ7NCMlA3BuMQCENyviiwabwKTrdRzPNuHIVzSe5GVpoQEzdO1Y92xuKaJf?=
 =?us-ascii?Q?/maNc41bJAEpyVn2nzZZR7CbsseS7KYGK+0SQajNVBe4ZBaVIqgGX8BbGEBk?=
 =?us-ascii?Q?MJNfjUvDGpnePFyIYQ+odoy7ifzoo0YM8Inlsjvq00Pd9J0OhhZANB9O9cR3?=
 =?us-ascii?Q?N+dcLi8TjFdiP6x8cbSl2yj0v+tnlG3FCDGxbOTSgLvL2ng/ATzWUD1tVGf0?=
 =?us-ascii?Q?KV4rumFbaTa3o+FACuCEvlL5frVpCssvYsXOUqDEADui7N1PxKTnYg1WPh2x?=
 =?us-ascii?Q?e3JLgGNWMsxHQ8WG4uRrpbWwVja1KRlzkc3jXNUtW/7z/Guyl+QelDAkbxAA?=
 =?us-ascii?Q?GQerHlvixx4OceSFHuzWfL6ps6cfNslH7y7IaiBVAaknAndz1fLqre1PRZCp?=
 =?us-ascii?Q?16huYWrrVx+D5zFWOE6kF3suHucJT92e3J8MSHcQfs/Wz7FdK5hFXR+wbbv4?=
 =?us-ascii?Q?I1HRJXnBaU55nXF4jxCW+FlrPTwnfYwRImfFZRdk7l9kA0sBWh+CVCi1NgLe?=
 =?us-ascii?Q?PNkW/1nhnqkevw5+Ncs2R+DvxyZnm4p5elMedeaemL+XsUGZx6qA16Tav+4A?=
 =?us-ascii?Q?WctYXI8wxpS/OK+kgqH5O5dXh8uY3rl3qa7LemtLuTnuiCoJqyElqAvfKy0V?=
 =?us-ascii?Q?V97ZqD1wkNnhE80T8YAaGIUVMXG2aQQguUDigP1NheRQ/WfVmHm98KfmrWeg?=
 =?us-ascii?Q?durjJsLNtHno2vybl7w8S2Qbz9b+YLndQMA/mqNROn/8nz9n7baiX/cjYqRd?=
 =?us-ascii?Q?4PIRPDovO+YUAJ951e/dDWUmbEcY9VXNYwJb2sDj83p6q9Z2oct+6w29SClo?=
 =?us-ascii?Q?pYE4Annf2zkdRoKmtHN4RskjAf4vuDQ3HCHKnifLZ1o20tedAUZ51Fh/coA3?=
 =?us-ascii?Q?/5XXGwaiY3rlclJVk/9eRtJfHr09zixuxV7XSfjxg1XkHFuHs9ffZbzTzuub?=
 =?us-ascii?Q?Ys2d6IQFSx9K3E4Dp0RGogoUhm9OwEoD/W/8/dtYqRKmC4uf+InFN3hYRRqu?=
 =?us-ascii?Q?FaiBLgyOj9hlOwb3s44qKTHnRlF1dS4+GIESFID2+trb+ZeJE2DguyekFRjw?=
 =?us-ascii?Q?oJAAXHkmI3xomj9vwzCTbPBsNoSgJv8kmNWdY0a3LSetq0Xzn16G2isV1L5a?=
 =?us-ascii?Q?ls96CZ9cU0m6cK5pk0eq1ojHY9iND5XfaOFCFuk9MAPPvAF+Ll8wKHzaKf7x?=
 =?us-ascii?Q?MfasySmswDi7T4T/K22trYymbjjDFyaL/pc6PK323s5i0TuV9PEuvjeq2tzd?=
 =?us-ascii?Q?44s8THH4U7v28qm+wrcoVcPRXf4RvaaSzjP8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:39:34.2174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e430c3-e3fb-4ef6-5756-08ddbd429048
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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

The generated GUID applies to all Xilinx platforms but is not
specific to any individual board. For FWU multi bank update,
use the image UUID (GUID) from the FWU metadata structure
rather than embedding a generated GUID into the U-Boot build.

Note: The FWU metadata is an unsecure piece of data, as
highlighted by the spec, and there is no way to ascertain
that it has not been tampered with in a malicious manner.
U-Boot OTOH can be part of a trusted boot chain, where the
U-Boot image has been verified before being booted. So,
although this does remove issues that might crop up with
manual mismatches, still need to consider the fact that
the FWU mdata is not a secure piece of data.

And this is a not real problem with Xilinx platforms because
actually it is only providing reference stack.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 board/xilinx/common/board.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 8ffe7429901..3d22149d429 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -712,3 +712,16 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 }
 
 #endif
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	struct fwu_image_entry *img_entry = &data->fwu_images[0];
+
+	/* Copy image type GUID */
+	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
+
+	return 0;
+}
+
+#endif
-- 
2.25.1

