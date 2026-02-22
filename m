Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A97C624D0
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 07:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C222F801BE;
	Sun, 22 Feb 2026 08:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35UQjI+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0858F83642; Sun, 22 Feb 2026 08:10:26 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8296380077
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 08:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTH2I1Ml78aUpVvD4rEXY8XiTDJJeD/JCQtY+ka6OLdx14BE5MS0vpNakxiwSvuCVsLwhm0YbU0s03NPOFqRA5/vkM4ZOPmQtbT95/k/RMvGlysv0dSIhNhZe5++gXI6CkK8GMahbK2DvUEhrJ6bUB5Bhnf8UoqK6ZsdgGRT6OeL3IhX8fr+3iAk6khnudRogsSXUo/o1tUt6XQljTuQO3nRfPQ4E1ptOXxkju7T1ZNBt9+EJGbaiefekj2Wb7RdxcnP1we0YBhONJeePbdOANyBMlMQ1R9BJljKoJq8AIYDVya7Y3wBV7IEICA80FWasRYA8s2jbBQx4P44Ouuweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HWr/TDtaQy/Itw33FVuBZ/ZbmLzShUwDrIjCXOgQBc=;
 b=fBgPXzr1r3o0pUwINA0jHS1R180Rd1qnAo0py0K/uzPuLWjGnTf5OPHcpfDctIJlMtLZjC4/Yp7koj30Qray9Ojgsp8/Mn9auVZJpNpWgeP+Linn8b3if82CDbIwYd495uj3PegUhzYy32HPtNdPYOXK+wHOU1F/sWopjUtIz1w+m/InROuHHJjYA9mAi5VvNB3uhAXQqcmuJya15l3mmSI4xRr7HKN1lHHMHiHACbAraNzGuLImzc/m7WXahhwu17qd0h6+sBKZZ/YugxPIIf+5Zr1V/Nxr2e+vx1Zuo6BtWgRak6zZoghl7LPZjO1sypsdXRenwgk+Hhs3YqTiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HWr/TDtaQy/Itw33FVuBZ/ZbmLzShUwDrIjCXOgQBc=;
 b=35UQjI+hkPT3NpFTcNIk5/oWTi06VtaFghG7rDZatuO7zlqXPwTw06tWMyEV2kfqKwOV6anIRZ66Sghzp0bNOIlv0hlTt2hxhZji7u0cpxNatrceMZYeXql/e7WAW6jNZctcsF/QEds76HTgK/7R+968ZORMEJiBk8jgOrlBB4w=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Sun, 22 Feb
 2026 07:10:18 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::f0) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.17 via Frontend Transport; Sun,
 22 Feb 2026 07:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 07:10:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 22 Feb
 2026 01:10:09 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 22 Feb 2026 01:10:05 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, John Toomey
 <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Heiko Schocher <hs@nabladev.com>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH v2] cmd: part: add dupcheck command to detect duplicate
 PARTUUIDs
Date: Sun, 22 Feb 2026 12:37:39 +0530
Message-ID: <20260222070957.2756719-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: f37a2be9-c784-4751-dbcc-08de71e16f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L4p7kAx6toCAl4cqNVjif9HRlXPMqI7Wn3cJ9me6xBX1uCNHXpZ+N77UV7OE?=
 =?us-ascii?Q?xOyxnnBPdi4sDGBnZGIlbWvVCdsgxcH5MCqzx/jUojAPDndQFtCfW4CfVyhl?=
 =?us-ascii?Q?UaUn7G43b8XAoC+6Sg0ArINyfFH2+WfVN8SdEqx5tYFg1k5i788V1yWcTAGm?=
 =?us-ascii?Q?bMqHDQlEK/E9XxP5izij1hZBRgFEuW5K0ATKdvznzWYsve+KwCU9Eqcx6JmQ?=
 =?us-ascii?Q?+s3cufP6l2ywiZbD9fBsbaOuGS2nZ6gTbdsWZe3Ry/SONI5oWFlfhUGxT4/o?=
 =?us-ascii?Q?ctmFaJLsgjLCnJn66D8oXHoVHvASq3jmcXyWK0w2Oy16fGP8glaLv8RFvvUm?=
 =?us-ascii?Q?m39tibfSjk7jRzqa5AwjNSFlqJmKBV90ZoAN5qjB4H8UH+6uQhLFJEacf2qO?=
 =?us-ascii?Q?whgETTLs1wqIXPEOprr1fN8m3jTBH23fGRlgXhNeIoDHasfOEtNCyY4P3sAh?=
 =?us-ascii?Q?2kJfuCi6XECi87fRHppQBL/OQNHkzx3/nhBSYMl+9C7Fym2jzmEeXSHF/rJs?=
 =?us-ascii?Q?H72mIRAcHC1YsENz6TxO8riJEA+H/OzbXhpMgEGm5+qGYKBL1YbkwoDP8ETa?=
 =?us-ascii?Q?o+jGa2HpGjn4oF9THIXPchGdFHojjdx3ai+BjXHo8HRLq6F0Q8B15gcA/PG9?=
 =?us-ascii?Q?+pOVvMYW3qTN6ppN5IN+wY6fpY1z/zkVpjiijcOx6CX/aYEbLcE08MkEVcR5?=
 =?us-ascii?Q?iqE2qG1ajaLVWH5X+1LpO/YMluMT8fWmE6j4PPr4kvhmzqDeK2ZtBOYlHj7s?=
 =?us-ascii?Q?SF6lhrhHWHMrpWc/ISFTXWEzs/qFJPUPVSXQcBBRvGvIQnuSu8ER/lGWRKoJ?=
 =?us-ascii?Q?99Obk2LFEPhulUlTgK54hWU72fUxvYvRTVzYckt6iuYb8CLPCtIAanbRSVwC?=
 =?us-ascii?Q?4NEB4D5/UiDqQ3lqbaLBN4B88m+fEsaLz4b3QIav6V1n9/ME74A10bcz5Vvs?=
 =?us-ascii?Q?1D/cQQGBln/ywZ2gBPHs4IK+zfzGxYEO3yvJN2ghA/mnSVqo+8JTFkSI0Adb?=
 =?us-ascii?Q?E2MuQboA/svfrGtEQVyjVim/LzVjyHr/XoQxPhUJIv6y43nRUsr8uFSRSxOt?=
 =?us-ascii?Q?gaoHhoSiHUFVlNch2EKw4UkoH1WhPIVffMh0ghDKB3YiFdZBGiHzXQpWZ9Cg?=
 =?us-ascii?Q?PvqPNCYXGn+hdYeoefyxEwFWuors1KOtxBAmJqlekH874BlwIAru6ND8X8QZ?=
 =?us-ascii?Q?9vE2uu/4pRviYSIV+iivrF2AE1Dj/xS80Q2VgNiEn6SZmHkJ6f2gIWFYow/g?=
 =?us-ascii?Q?RLp8ooKft5uHE0rQTguIYq/BGzuTxvrLQf8TK5TMOY58G0OTBlEidPtTSGmi?=
 =?us-ascii?Q?y9FovDbK3O5BEqNP5fyH7JN/BDybNwZOAMb4FL07gVxt/RyIwxbe6e+i/L5K?=
 =?us-ascii?Q?SgpO2cucjB9VV9Ry0uaBd/yeW5nZjjdpxQ7/IPbnfOfZ/S8dZdaqOZycTuDL?=
 =?us-ascii?Q?5GJ9rupoIOUkG9siIULV9W9+3t8AATYIRXDt7vmJ26Ver+bMeybyYgLVia+A?=
 =?us-ascii?Q?MqLWKh412wA2xq8+Vbd55HD8wiLcbH1aSV68MXiE96LlLXczXPKaDLR9oFN4?=
 =?us-ascii?Q?Ik3Xfd+V1Rp561L711cTSF9l21h/E33SfdGxRrbsObUwG+2G+Ma/JeENKs9N?=
 =?us-ascii?Q?4PSzl7vr7ygxwpqTfGvu18bqI0O5RzZwhB/ZRclHnw29wVIssIXQjqt+630y?=
 =?us-ascii?Q?pSfYRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2f+7Ac4G6uMCIGl3zcn3UodymzLKKFMsiGmrCZiy32rFMlBL8xiAj2nbElO1FG5ggpT8saCHFo5VZfGJJdldAYkqgWOt0TeAinIsj2u8vcMvLspZoXjw5HZ+useZiO4NCFjAOefGjUnMbCD3dhZE+EUed9hkJXsp3BcW/mksgAxUl/tzNb3QYuZOcMd/c9VHX6AMJiVBRv3KmynhKJN5dbxMENM4bK7VczRs6JlyA/bU/ZszsBOZCZkjpdIiqCVrBnZ2DkA0eu3BEl6nt1wFIwg+gIHFQr4jSJ0vjmFbACkXFzR81uZukaEuXJxY/Rd0viY390c+kkycGEVzjn9yTR4Yp/9x3V+x2BMZwT+f9uo9t7iVgrRewaFc4F+owqZ8BNl+X98ROOg3fYOJFTQEBlxTvADTKhtwQq0VEN5gTJE8NQwfAbVc3qrCC3YPlcGQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 07:10:18.2054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37a2be9-c784-4751-dbcc-08de71e16f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
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

Add a 'part dupcheck' subcommand that scans all block devices for
duplicate partition UUIDs. This helps detect situations where the
same disk image has been flashed to multiple boot devices (e.g.,
USB stick and UFS), which can lead to unpredictable boot behavior
when using PARTUUID-based root filesystem specifications. It
iterates all block devices using blk_foreach_probe() and checks
partition UUIDs via part_get_info().

When duplicates are found, a warning is printed for each occurrence:

Warning: duplicate PARTUUID 20c5fba5-0171-457f-b9cd-f5129cd07228
  first seen on usb_mass_storage.lun0:3
  also on ufs_scsi.id0lun0:3

Add Kconfig option `CMD_PART_DUPCHECK` and update the `part` help
text accordingly.

Signed-off-by: John Toomey <john.toomey@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
-Add own kconfig symbol for dupcheck subcommand and guard it.
---
 cmd/Kconfig |   7 ++++
 cmd/part.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 322ebe600c5..73d27fe2e28 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1663,6 +1663,13 @@ config CMD_PART
 	  Read and display information about the partition table on
 	  various media.
 
+config CMD_PART_DUPCHECK
+	bool "part dupcheck"
+	depends on CMD_PART
+	help
+	  Enable the 'part dupcheck' sub-command under 'part' to scan the
+	  current partition table and report any duplicate partition UUIDs.
+
 config CMD_PCI
 	bool "pci - Access PCI devices"
 	help
diff --git a/cmd/part.c b/cmd/part.c
index 975a0a08a99..c4df5053936 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -15,9 +15,12 @@
  * Pavel Bartusek <pba@sysgo.com>
  */
 
+#include <blk.h>
 #include <config.h>
 #include <command.h>
+#include <dm.h>
 #include <env.h>
+#include <malloc.h>
 #include <part.h>
 #include <stdio.h>
 #include <vsprintf.h>
@@ -246,6 +249,97 @@ static int do_part_type(int argc, char *const argv[])
 }
 #endif
 
+#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
+struct part_seen {
+	char uuid[UUID_STR_LEN + 1];
+	struct udevice *dev;
+	int part;
+};
+
+static int do_part_dupcheck(int argc, char *const argv[])
+{
+	struct part_seen *seen;
+	int count = 0;
+	int duplicates = 0;
+	int max_entries;
+	int dev_count;
+	struct udevice *dev;
+
+	if (argc)
+		return CMD_RET_USAGE;
+
+	dev_count = blk_count_devices(BLKF_BOTH);
+	if (!dev_count) {
+		printf("No block devices found\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	max_entries = dev_count * MAX_SEARCH_PARTITIONS;
+	seen = calloc(max_entries, sizeof(*seen));
+	if (!seen) {
+		printf("Unable to allocate dupcheck table (%d entries)\n",
+		       max_entries);
+		return CMD_RET_FAILURE;
+	}
+
+	blk_foreach_probe(BLKF_BOTH, dev) {
+		struct blk_desc *desc = dev_get_uclass_plat(dev);
+
+		for (int part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
+			struct disk_partition info;
+			int first_match = -1;
+
+			if (part_get_info(desc, part, &info))
+				continue;
+			if (!info.uuid[0])
+				continue;
+
+			for (int i = 0; i < count; i++) {
+				if (strcmp(seen[i].uuid, info.uuid))
+					continue;
+				if (first_match == -1) {
+					printf("Warning: duplicate PARTUUID %s\n",
+					       info.uuid);
+					printf("  first seen on %s:%d\n",
+					       seen[i].dev->name,
+					       seen[i].part);
+					printf("  also on %s:%d\n",
+					       dev->name, part);
+					duplicates++;
+					first_match = i;
+				} else {
+					printf("  also on %s:%d\n",
+					       seen[i].dev->name,
+					       seen[i].part);
+				}
+			}
+
+			if (count >= max_entries) {
+				printf("Error: dupcheck capacity %d entries\n",
+				       max_entries);
+				printf("       exceeded\n");
+				free(seen);
+				return CMD_RET_FAILURE;
+			}
+
+			strlcpy(seen[count].uuid, info.uuid,
+				sizeof(seen[0].uuid));
+			seen[count].dev = dev;
+			seen[count].part = part;
+			count++;
+		}
+	}
+
+	if (duplicates)
+		printf("Found %d duplicate(s) among %d partitions checked\n",
+		       duplicates, count);
+
+	free(seen);
+
+	return duplicates ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_part_types(int argc, char * const argv[])
 {
 	struct part_driver *drv = ll_entry_start(struct part_driver,
@@ -291,6 +385,10 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, int argc,
 #ifdef CONFIG_PARTITION_TYPE_GUID
 	else if (!strcmp(argv[1], "type"))
 		return do_part_type(argc - 2, argv + 2);
+#endif
+#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
+	else if (!strcmp(argv[1], "dupcheck"))
+		return do_part_dupcheck(argc - 2, argv + 2);
 #endif
 	return CMD_RET_USAGE;
 }
@@ -328,5 +426,9 @@ U_BOOT_CMD(
 	"part set <interface> <dev> type\n"
 	"    - set partition type for a device\n"
 	"part types\n"
-	"    - list supported partition table types"
+	"    - list supported partition table types\n"
+#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
+	"part dupcheck\n"
+	"    - scan all block devices for duplicate partition UUIDs"
+#endif
 );
-- 
2.34.1

