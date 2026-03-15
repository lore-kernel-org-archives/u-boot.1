Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59474D58B2B
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 13:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FDE8441D;
	Sun, 15 Mar 2026 14:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="18rvMzr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB19084422; Sun, 15 Mar 2026 14:17:23 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0F38441A
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 14:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys2n7Vl8afr7xjn8IkxlZy6stuq8FiQtboSnm0mxBXxAPMN2tsYoq8xtqFy9T6bSdMEiDoHhpd2ddQKi5liFFqgUyqeApns7mthP+t6N8wAu1/lSEgzyTWm06UbKskbMFASa/PBy9k5Xub/4l0Bj7YGE3dDNFtPd1CsVWz1Q7TU8dBN/YFWIMYVjFp18zOdaotkUsoIHaC4/dkl1hWdKal3ZNmqbUqrGIMpymL1+UorI2uBk2dBzqmztFJjPQyEgi7nTzvuPOByxqXBxfhnMrsUH/rd7d+IrsRtkXAX2VBmYIiBKkXduNYUrGo1BjbKmR0qb4Nge2ZFQuPcEJOKiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwrT/1ACRhsGn1rdSudiEcSpU5RjTgf3EgxmD8Gehlc=;
 b=PlkNfp+rtfhm3i+HMQ6gfo9fJgQZrIeecJWeKLPCnb19Wk1+Mhn+MxmllgumxNoRxjNoDfWeTqM9uuh7fn9+pY1m67fdorBME9aYDcN3JIt47SxvvVvLUlGnbwmS1A8AP+q4WOIOY8fJYzBkU/LSix0o0+HSh74+w7AzS1uFHBk28pZ70j1tiR5pcYQWVaLSxdjAfQ5hoSPkdhZUrGzbUUSHVvz0anHKLKJtd8ztfFP/IjQlgtSXPTCzVIL7o1reTJOXqaoVyGd8GhauKAsjfzCb18nuthiuhyo2KgC1HEBe0OGaEGjKM3wIp/yReaUc2XaPv0uUouE3/1QSHKnJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwrT/1ACRhsGn1rdSudiEcSpU5RjTgf3EgxmD8Gehlc=;
 b=18rvMzr21RbHCLH1jI5BmhnUiE/NNReb0hl1uUSBWW96wnVRNMqNjBH8iWcJ229K1HVQGzhsvWM9ZVd9tZ6TFa7eADIYkCUT3VQUCWs/hi0dnmA5UYugEh/BgQ3dXENF0iHj6k9rcWm21Q4r8fhQOr1Nuvg9FEcXjyVR0K//evA=
Received: from DS7PR03CA0255.namprd03.prod.outlook.com (2603:10b6:5:3b3::20)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Sun, 15 Mar
 2026 13:17:13 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::62) by DS7PR03CA0255.outlook.office365.com
 (2603:10b6:5:3b3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Sun,
 15 Mar 2026 13:16:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 13:17:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Mar
 2026 08:17:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Mar
 2026 08:17:10 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 15 Mar 2026 08:17:07 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, John Toomey
 <john.toomey@amd.com>, Tom Rini <trini@konsulko.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Quentin
 Schulz <quentin.schulz@cherry.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Heiko Schocher <hs@nabladev.com>, "Andrew
 Goodbody" <andrew.goodbody@linaro.org>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [RFC PATCH v3] cmd: part: add part dupcheck subcommand
Date: Sun, 15 Mar 2026 18:45:29 +0530
Message-ID: <20260315131655.2352627-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 2692fb2d-0967-4699-c28c-08de82952b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tyc74NYIImOUWp7Q5kAd14OulgXfx6XNszMnVj0pCQfs2HmiO1c441IxWalST2Hwdle4B4l/blklOwsYlpxEP0iso8FPvKBIQTuwv2DWtMrtwSFGURg57xa3Nz4Ig9plKzSoLUU0NheklD3BYm3q1FGvhEOqjPm9na0oKSu5X+JYSas6XvuRElyzAnOCQ6O2wKXek4N2UOE9i8og+AwL9Fto36hT2JJf2YHPyvh6TZPnS0yRUMOdd4DNpWZKGIBLdV20pEmJvjUE9Vp7uxppKR8FMuXRNzswbqZhj73YJNPdGpk3aIIs1ooVsjtwlTNNNNvFkUE1+Hjszd062zH2m/idO5xitOiWrFhej6WVood0qGZELN52NkWGjoy4bfdrLnAhWwuAB5TNQmstv+2IXDpTOsnD6TcjQHe30QJ0FYOo0qJwNuDkuhCBMRC9unD1oXx/8SJO/1ysqQEo4vmP3fw3xOsMLcgIB4rbL7JWjSHJf220fGCjs3YSdeqU1BsemwZ7jPwq7jtBEdq+mFTTkiSgAXPbnzDf5f7cJw07JrcOnCQ/dWyLO0fkPFwe11DJpyJpcr89KZzzenbreXV3GqsR14r3ulzp3aT30YstMenhR3yk/qU9A9oCTuYhYjYtF9UwwZmmC56pzU8PHf7tMxp4s2R0Bze0nB7dIOL9DoPU3bco/Z9VW7iKzif9th7J9Ox9+lzaeAm7fEkcSAcpsctXWJa5izKnMV6D3alBKeamB/WT8Mlub3v6LQHK35xN4wUkqXMO3rtAfLFFXYDqFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q5DLyX47ibNRCjlmWFVhzqfkvBbKzl3C+JpxSLdRfOBktGD/huCuVHYQyEhR+0aYKLEjLXmbVGCd2luGQgNSRwD1DLWvAAjX8BKingVymxvTC5TOvltQiiFYtG5pZRfYG1BX2PniEPnxafI/yu985pu24HzY1wivdHeYLuqmb52ZQQKHne5lAwiFFiYmnUcwB7t/fwM+i7Lk+Jp9rk+Hc+OhtLY/NzIVX9Kwaz8CSO4VKWKxTNdGpLDXRpKHnoXgteFN1pAaVB/4wUiF0d71VqZ6Y93wXcGKa+dOfFb9u1+qWadN5CebCcIxrC4RBcTXXEobLjQo9tT0e23txzFjoXjitBxxcht/Sl0+rBOIxi9Da2WRMo6Unw5mwZjfFSTvLHBHocj/XtJ/S8C7EEIy/sDuLODtzHAQN6MRxamY9w2T7xyVT0UCVHsG54Q7qwOn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 13:17:12.4174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2692fb2d-0967-4699-c28c-08de82952b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

Add a 'part dupcheck' subcommand that scans all block devices probed
in U-Boot and reports any partitions sharing the same PARTUUID or
PARTLABEL. This helps detect situations where the same disk image has
been flashed onto multiple boot devices (e.g., USB stick and UFS),
which can lead to unpredictable boot behavior. Duplicate
PARTUUIDs break UUID-based partition lookup in Linux, and duplicate
PARTLABELs cause the wrong partition to be silently selected in
bootscripts that reference partitions by name.

A single collection pass iterates over all block devices using
blk_foreach_probe() and records every partition that carries a UUID
or label into a dynamically allocated alist of struct part_seen
entries (UUID string, name string, device pointer, partition number).

Duplicates are detected by calling detect_duplicates() twice, once
for UUIDs and once for labels. Each call sorts the list with qsort()
using a comparator that places empty fields at the end, then performs
a single linear pass to identify consecutive equal entries as
duplicate groups. Each group is reported with the device name and
partition number of every copy, followed by a per-field summary
count. Per-field counts are used consistently in both the
duplicate-found and no-duplicates paths.

Example output (with duplicates):

=> part dupcheck
Warning: duplicate PARTUUID 1234abcd-01 (2 copies)
  found on usb_mass_storage.lun0:1
  found on ufs_scsi.id0lun0:1
Found 1 duplicate PARTUUID(s) (2 total copies) among 4 partitions

Warning: duplicate PARTLABEL primary (2 copies)
  found on usb_mass_storage.lun0:1
  found on ufs_scsi.id0lun0:1
Found 1 duplicate PARTLABEL(s) (2 total copies) among 4 partitions

Example output (mixed: UUID duplicates, no label duplicates):

=> part dupcheck
Warning: duplicate PARTUUID 1234abcd-01 (2 copies)
  found on usb_mass_storage.lun0:1
  found on ufs_scsi.id0lun0:1
Found 1 duplicate PARTUUID(s) (2 total copies) among 4 partitions
No duplicate PARTLABELs found (3 labels)

Example output (no duplicates):

=> part dupcheck
No duplicate PARTUUIDs or PARTLABELs found (4 UUIDs, 3 labels)

The CONFIG_CMD_PART_DUPCHECK Kconfig option (depends on
CMD_PART and BLK) controls inclusion of this subcommand and is
disabled by default.

Signed-off-by: John Toomey <john.toomey@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v3:
- Add partition label along with uuid
- Update duplicate check and output messages
- Remove dynamic memory allocation with calloc
- Use alist for dynamic allocation
- Use qsort() for sorting uuid and labels
- Update subject and commit message.
 
Changes in v2:
- Add own kconfig symbol for dupcheck subcommand and guard it.
---
 cmd/Kconfig |   9 +++
 cmd/part.c  | 215 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 322ebe600c5..a96d6472359 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1663,6 +1663,15 @@ config CMD_PART
 	  Read and display information about the partition table on
 	  various media.
 
+config CMD_PART_DUPCHECK
+	bool "part dupcheck"
+	depends on CMD_PART && BLK
+	help
+	  Adds the 'part dupcheck' subcommand, which scans all block devices
+	  and reports any duplicate partition UUIDs (PARTUUIDs) or partition
+	  labels (PARTLABELs). Returns failure if any duplicates are found,
+	  making it suitable for use in boot scripts.
+
 config CMD_PCI
 	bool "pci - Access PCI devices"
 	help
diff --git a/cmd/part.c b/cmd/part.c
index 975a0a08a99..5e520d707f3 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -15,10 +15,15 @@
  * Pavel Bartusek <pba@sysgo.com>
  */
 
-#include <config.h>
+#include <alist.h>
+#include <blk.h>
 #include <command.h>
+#include <config.h>
+#include <dm.h>
 #include <env.h>
+#include <stddef.h>
 #include <part.h>
+#include <sort.h>
 #include <stdio.h>
 #include <vsprintf.h>
 
@@ -246,6 +251,205 @@ static int do_part_type(int argc, char *const argv[])
 }
 #endif
 
+#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
+struct part_seen {
+	char uuid[UUID_STR_LEN + 1];
+	char name[PART_NAME_LEN + 1];
+	struct udevice *dev;
+	int part;
+};
+
+static int compare_uuid(const void *a, const void *b)
+{
+	const struct part_seen *pa = a;
+	const struct part_seen *pb = b;
+
+	/* Sort empty UUIDs to the end */
+	if (!pa->uuid[0] && !pb->uuid[0])
+		return 0;
+	if (!pa->uuid[0])
+		return 1;
+	if (!pb->uuid[0])
+		return -1;
+
+	return strcmp(pa->uuid, pb->uuid);
+}
+
+static int compare_name(const void *a, const void *b)
+{
+	const struct part_seen *pa = a;
+	const struct part_seen *pb = b;
+
+	/* Sort empty names to the end */
+	if (!pa->name[0] && !pb->name[0])
+		return 0;
+	if (!pa->name[0])
+		return 1;
+	if (!pb->name[0])
+		return -1;
+
+	return strcmp(pa->name, pb->name);
+}
+
+/**
+ * detect_duplicates() - Sort and detect duplicate fields in the partition list
+ *
+ * Sorts the seen list using the given comparator, then performs a single
+ * linear pass to find and report consecutive duplicate entries.
+ *
+ * @seen:       The list of collected partition entries
+ * @cmp:        Comparator function for qsort (must sort empties to the end)
+ * @field_label: Human-readable label for reporting (e.g. "PARTUUID", "PARTLABEL")
+ * @field_off:  Offset of the string field within struct part_seen
+ * @dup_groups: Output: number of distinct duplicate values found
+ * @total:      Total number of partitions that have this field set
+ */
+static void detect_duplicates(struct alist *seen,
+			      int (*cmp)(const void *, const void *),
+			      const char *field_label, size_t field_off,
+			      int *dup_groups, int total)
+{
+	const struct part_seen *pi;
+	const struct part_seen *pj;
+	const char *field_i;
+	const char *field_j;
+	int occurrences;
+	int count = seen->count;
+	int dup_parts = 0;
+
+	*dup_groups = 0;
+
+	qsort(seen->data, count, sizeof(struct part_seen), cmp);
+
+	for (int i = 0; i < count; i++) {
+		pi = alist_get(seen, i, struct part_seen);
+		field_i = (const char *)pi + field_off;
+		occurrences = 1;
+
+		if (!field_i[0])
+			break;  /* Reached empty fields at the end */
+
+		/* Count consecutive duplicates */
+		while (i + occurrences < count) {
+			pj = alist_get(seen, i + occurrences, struct part_seen);
+			field_j = (const char *)pj + field_off;
+
+			if (strcmp(field_i, field_j) != 0)
+				break;
+			occurrences++;
+		}
+
+		if (occurrences > 1) {
+			printf("Warning: duplicate %s %s (%d copies)\n",
+			       field_label, field_i, occurrences);
+			for (int j = 0; j < occurrences; j++) {
+				pj = alist_get(seen, i + j, struct part_seen);
+				printf("  found on %s:%d\n",
+				       pj->dev->name,
+				       pj->part);
+			}
+
+			(*dup_groups)++;
+			dup_parts += occurrences;
+			i += occurrences - 1;
+		}
+	}
+
+	if (*dup_groups)
+		printf("Found %d duplicate %s(s) (%d total copies) among %d partitions\n",
+		       *dup_groups, field_label, dup_parts, total);
+}
+
+static int do_part_dupcheck(int argc, char *const argv[])
+{
+	struct alist seen;
+	int uuid_count = 0;
+	int label_count = 0;
+	int duplicate_uuids = 0;
+	int duplicate_labels = 0;
+	struct udevice *dev;
+
+	if (argc)
+		return CMD_RET_USAGE;
+
+	if (!blk_count_devices(BLKF_BOTH)) {
+		printf("No block devices found\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	alist_init_struct(&seen, struct part_seen);
+
+	/* First pass: collect all partitions with UUIDs or labels */
+	blk_foreach_probe(BLKF_BOTH, dev) {
+		struct blk_desc *desc = dev_get_uclass_plat(dev);
+
+		for (int part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
+			struct disk_partition info;
+			struct part_seen entry;
+			bool has_uuid;
+			bool has_label;
+
+			if (part_get_info(desc, part, &info))
+				continue;
+			has_uuid = disk_partition_uuid(&info)[0] != '\0';
+			has_label = info.name[0] != '\0';
+			if (!has_uuid && !has_label)
+				continue;
+
+			memset(&entry, 0, sizeof(entry));
+			if (has_uuid)
+				strlcpy(entry.uuid, disk_partition_uuid(&info),
+					sizeof(entry.uuid));
+			if (has_label)
+				strlcpy(entry.name, (const char *)info.name,
+					sizeof(entry.name));
+			entry.dev = dev;
+			entry.part = part;
+
+			if (has_uuid)
+				uuid_count++;
+			if (has_label)
+				label_count++;
+
+			if (!alist_add(&seen, entry)) {
+				printf("Unable to grow dupcheck list\n");
+				alist_uninit(&seen);
+				return CMD_RET_FAILURE;
+			}
+		}
+	}
+
+	if (!seen.count) {
+		printf("No partitions with UUID or label found\n");
+		alist_uninit(&seen);
+		return CMD_RET_SUCCESS;
+	}
+
+	/* Detect duplicate UUIDs */
+	detect_duplicates(&seen, compare_uuid, "PARTUUID",
+			  offsetof(struct part_seen, uuid),
+			  &duplicate_uuids, uuid_count);
+
+	/* Detect duplicate partition labels */
+	detect_duplicates(&seen, compare_name, "PARTLABEL",
+			  offsetof(struct part_seen, name),
+			  &duplicate_labels, label_count);
+
+	if (!duplicate_uuids && !duplicate_labels)
+		printf("No duplicate PARTUUIDs or PARTLABELs found (%d UUIDs, %d labels)\n",
+		       uuid_count, label_count);
+	else if (!duplicate_uuids)
+		printf("No duplicate PARTUUIDs found (%d UUIDs)\n", uuid_count);
+	else if (!duplicate_labels)
+		printf("No duplicate PARTLABELs found (%d labels)\n", label_count);
+
+	alist_uninit(&seen);
+
+	return (duplicate_uuids || duplicate_labels) ?
+		CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_part_types(int argc, char * const argv[])
 {
 	struct part_driver *drv = ll_entry_start(struct part_driver,
@@ -291,6 +495,10 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -329,4 +537,9 @@ U_BOOT_CMD(
 	"    - set partition type for a device\n"
 	"part types\n"
 	"    - list supported partition table types"
+#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
+	"\n"
+	"part dupcheck\n"
+	"    - scan all block devices for duplicate partition UUIDs and labels"
+#endif
 );
-- 
2.34.1

