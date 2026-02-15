Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C2EF587B
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 13:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FB380FA1;
	Sun, 15 Feb 2026 14:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S4guuknq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8D68309A; Sun, 15 Feb 2026 14:11:41 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE2880B98
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 14:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+HbiZiTiZET13wJWOFhDk2371rfstk6zwjqMS7YnmxTf0N/A6foUSpZEfBcFQ3DnabKROxd3PJUo2HU9mItBNA8GCmYsKFrFkgTjINrJAXTK3gJbizrwUOLbgbYwQ7IbdY7+jrp2xvs8364RetUI1PSq9cgoVV6td5Y7tIEPzCbXvj3/dPE+1ZXLSGKbT3jjQCuau9nWiG27XAg0G/d7KQb52wfnkV5K+0txvovV9uwMz3lAkAbB8vxexBc+PjTrZm/YO6EswjtXLIKdzhowKIk6GWyX0HCPsJjOEWJ6h9Zp4hJ6k1jnN3WPXfDB6Eb9N+pH7lAx3yuGGvmb/ylRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Yi/rQfI2sDlkPD8MtTFVTHeV6Y/mo97KuANHbu8MI=;
 b=B+bc+gDu7chLPUJ0+gGo88p3kSWGs7YOIMff3QSrnkWdGx4aYxInNkVF8LextNGTCFudWDxHohYr0kNvzTOHu/gczcfzyrCuGy05kbI/8wIPXdtPba73PhJQzDOLangNhSr9RTID6a5A5/Q/EolXywqT6NqjUWTMz/KCu6PQbjSK60I6S+jewnZuuNcx9arCGq03J6iFFfXpl71VVMNb8kcv/7U/zeOVTp/z0u4NmKNO3ZLiCwIbiApeCM5JB+bSg34n0rxE6csKZksJsm0yxPc+caIcAXz6CAQkyO9ZBvFni0pkotUzPGR4yV7p5t4Bov3O0wwKSwKLumJ/V7La5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Yi/rQfI2sDlkPD8MtTFVTHeV6Y/mo97KuANHbu8MI=;
 b=S4guuknqaThdGugaRNiiI2HJm63hcuj8jq0OqNMF7mAZ2Esh+f9ToB+esuZss6kFR2s3wmya8kFdGAgEB2YY6Mi8tZbWGjsl0gb+sJhzLQGmq3U62b8EE3R06NtpagppOuSzm012OMo2N9p4sp16TmLZiVXRCG7l+wTg1fb2p8U=
Received: from BY3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:254::17)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 13:11:34 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::79) by BY3PR05CA0012.outlook.office365.com
 (2603:10b6:a03:254::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.11 via Frontend Transport; Sun,
 15 Feb 2026 13:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 13:11:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 15 Feb
 2026 07:11:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 15 Feb
 2026 07:11:30 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 15 Feb 2026 07:11:28 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, John Toomey
 <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH] cmd: part: add dupcheck command to detect duplicate
 PARTUUIDs
Date: Sun, 15 Feb 2026 18:40:47 +0530
Message-ID: <20260215131115.3352282-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 7401f743-b682-4d1c-c7cf-08de6c93bdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0PEy2c5l0L3oJiPXDFI3ax2fjWl3Q4uRYQKkJ4w6fnoWp/lKd1ET5w6bz9Va?=
 =?us-ascii?Q?xJyMctWuEaCADU0P4j8FBFwEFsKK3wbxk0jLDxhCR/my6a1oS5h5DQDom1/g?=
 =?us-ascii?Q?LvFIY29KPUF4ZPs7+CV8vJzoUZ2qaBBnh3dp0HrD5QDqkrLO1XRvJ7jCRb4W?=
 =?us-ascii?Q?KNCpA+wYldZ5Lmluig7KxMEZM0UP8FJgQ+yGvOGPR/fEjVrp5asorzO2e6XL?=
 =?us-ascii?Q?j9D9ZY+Jjzx23LN4imu13efDI4PvfTybAP7QCtwSySILWulaRpMPaXN9Ay+e?=
 =?us-ascii?Q?HuQU79FsEfhWdhCpu1DP6OCtYfQt2uY/ahP3gPfW8wxc40MRPiOQaWkVzbGm?=
 =?us-ascii?Q?nkryUzzCL7RleNSVWnAxU4sAil/y2RTGfmnusGzweMF6mdeW8ylG7nBF629Q?=
 =?us-ascii?Q?gTT5KdkFlW4U013ZVOGSW3kLd+QasaIFE5qUhYLyrDGyRIAzQSg2XZCDKuap?=
 =?us-ascii?Q?+G461mJj2xuNV6kU+W1mHAO0wwRrb73EwjwkNJBkhCGqiOfTcOdlOU7E7Rv8?=
 =?us-ascii?Q?yPhwTYMJtnC1cWGWcUfCRwjk2EF/NKLtXyct6huwa9XOdvm4t2rG7yWgJjpt?=
 =?us-ascii?Q?vLc29/ls1CjW9itAXhfx5s0zhBmhkVXPWOGTELgFua1QVQUDzO1xnneAOjAB?=
 =?us-ascii?Q?SxiSIwoWZvUJQOZA8Jn1dWd9g3rgpfx7UmmkXVClgWINV776Yz57Rj422Czt?=
 =?us-ascii?Q?M6WzwBkO8tUVI624DBQnTDSZkml5ID7ExY9Emy95YI3Dc7oMyou+UZB6GYAF?=
 =?us-ascii?Q?7e7RrdbtT9lr9vomcj4sUlhCsjKQ8UlFNabT6KMJZ6udWJ9hbeY+sJ0JGSS1?=
 =?us-ascii?Q?kKX4bRA2Hgm+dJrSxuaWUaxnSNeMA+3A+HMPFiDBax07R6W4YG+wXHbLMbW0?=
 =?us-ascii?Q?5BxmJvQhEyLQ6nKnl5gz5cTX974H2KMCB4xl70cUvVKAi/9MQk+vl4qeKfjc?=
 =?us-ascii?Q?S5bnk7DXX8lN+aDjsd6jRWPva0lQzvZ5HlWpU0QJoYx/WyO/MhJFC24OGuhE?=
 =?us-ascii?Q?ZmDjOUi8x6D7lLV3ecLyewqHFz7vVM8d+ZGXJuEf4babthAiEH9hMd829KK+?=
 =?us-ascii?Q?EpED9gi4MHY+kynwheZ6DvNnOfrkc/vFWpvdh3lFN+jmdQktL8gF8w8wc3QB?=
 =?us-ascii?Q?CDAnoLFRwHzkuDxAoh1fEAi9YXL8sM5Jj8ApmIUF9dpk8jt/waJjvCIt5715?=
 =?us-ascii?Q?SOWSM6N+FmvQQXuw9sDeBwJEzHNJtIzJEGsmuyKpQySDC5aNbvMDN+LgStl6?=
 =?us-ascii?Q?Dq0p6n6DJ3pTaLmbiP+hmPnexSI/e8cZ1VtgHuSTGW2NMR5teqnL+aHSOlqW?=
 =?us-ascii?Q?2HSsDb+TnrhbgGPNpopfck7Ci8I5KNocE0JPS1IT/Q/GIlEczRv19k45GPhQ?=
 =?us-ascii?Q?nRvF+J9SippLcohlMGn7kl3FEZrpFiIn+OXr2J7s4z0Wp5ErVOp/QSeshbDN?=
 =?us-ascii?Q?hXNh0tKqEmLoXS6EUsLgvYKszhtnZdCm5mA7ubT0N5hoHDP7K1sPCZTZ+wPQ?=
 =?us-ascii?Q?O3AO2LrmJxE8qa4mjZIpHVF1ePUDEeiOTMiaf8jQBbuLzd3wtKbTIANbw8PE?=
 =?us-ascii?Q?qrW4gYR1SUmA3QmlLeLSPHp4PZb+atAGfpzeufHDjMAfaw84escbTi6kVPY7?=
 =?us-ascii?Q?idx61NnehCspUmvu1HNBhCL8dfom7UpKVTyL0fguCxgTTc+XKLNLkDRtbTwa?=
 =?us-ascii?Q?Kc4m8A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ptfABBt81WeVZBp9/gIgTT4gWcj7lsKdA9pfbGnz5WWAp9DdNKp3q7sba0SvFMPJcuyOf43T0DKX1ooVhexgnL45G3o4rN2fT/eaUJvfQ7cKWHMStpifqim2JLDjGZerTnshbfi5zZ3cmWwk9aTxNoPUR6WkJS0lnzQkU+LVokNFi3d9LwObz7f4rNYl2Mp0M8DIAMpHdno+oVzpA8aK5/qZpdPnrR943CiCP06Faipc39TIyyt8b8vQa8w2GLeA188ugz5teAPv+7+1/FD7KemKsigEXPET9TDhY1lnvHxANwUWYtUs5sV9z5dB0nGmI3O12NLqZ4WYItVO5Ju6z849b+V1Q7SuG1CzzdkNaAoGcvus/6evoiAKbYEqPL/UyLpuYIHsiX1GP9GFDqiYqt0mxQMwQFbZJDYR8d1iDOPdUNwjDUUXD3YPEgPvWaTw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 13:11:32.9924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7401f743-b682-4d1c-c7cf-08de6c93bdaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

Add a 'part dupcheck' subcommand (gated by CONFIG_PARTITION_UUIDS)
that scans all block devices for duplicate partition UUIDs. This
helps detect situations where the same disk image has been flashed
to multiple boot devices (e.g., USB stick and UFS), which can lead
to unpredictable boot behavior when using PARTUUID-based root
filesystem specifications. It iterates all block devices using
blk_foreach_probe() and checks partition UUIDs via part_get_info().

When duplicates are found, a warning is printed for each occurrence:

Warning: duplicate PARTUUID 20c5fba5-0171-457f-b9cd-f5129cd07228
  first seen on usb_mass_storage.lun0:3
  also on ufs_scsi.id0lun0:3

Signed-off-by: John Toomey <john.toomey@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 cmd/part.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/cmd/part.c b/cmd/part.c
index 975a0a08a99..31bcdec5e6d 100644
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
 
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
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
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
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
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
+	"part dupcheck\n"
+	"    - scan all block devices for duplicate partition UUIDs"
+#endif
 );
-- 
2.34.1

