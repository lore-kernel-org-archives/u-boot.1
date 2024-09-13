Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208C4FA3723
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 07:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE9288BB2;
	Fri, 13 Sep 2024 09:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sq1qcYv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CC288BCF; Fri, 13 Sep 2024 09:33:31 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D42788B63
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqsKP7tDlvGQhY8AvTeZHLOrpSSRmep7CSSboJBQDwx6VLfW1nQB5On5idInWw/5tYFEuCkEifPrViF46sa+FnalWFUjw18WWRF67YyWQSC+uMqPYRtTzhjSPTZlPG19M176qILlOwTt2C7b6ImdLYm6/yq9QMdIGFSLK6BsWzWTJlNg0DafqvTwm0dFMDb5WlRzgTXSUoeGvOAkKNFARAcPnZvhB/fjKpk3uRzbUDrof3oYWhXOx7d1xiH6T14XlSTqJfC+j0McONPxbm6fbCxqB2eHUse57BP1Z7OfHb9hKjZkm2gY9ucuYDz/kndGEZOjQ0P+UwWcR0YcXUpKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAP3Bv+pd1bDwaH1UjWWZvCTn+LK6fvuQ3mLBC3tpGc=;
 b=LngjKM0Oz+0FgJgcYDrfE06XORr+s4Loyj7laOXgJcyAKnDGq0tD/EOk38vCSCvZD66f1U3qf0zB5N/iurpPl3g7tjQxzKhgP5vvkMIPdmyp5t4OrejZF+toZB3M+WJgL/WNYCE/ZpoJuoaxDGLIy3B9UZfpGBAhAwNywj/p6sqYuwrvqKixLHca7ApeEEs7m+CZZVEzZKZLS+DMwT8ug2BNRwDVBC9xVLZuEQTy1vG7Fqodrrc38xt6WZUdB3E42VgLqbUPc3vfwmPgE+DRTCd6QJGOTZK60R8kVJmGePcR4wWEAEM50349EX824eDXLOoi1ExYE680e0onXg8APQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAP3Bv+pd1bDwaH1UjWWZvCTn+LK6fvuQ3mLBC3tpGc=;
 b=Sq1qcYv3PbY6C8A9VxpuwgHAyHJMnYwutornwVDG275N8Idd7xVF3HMYsX5e1MfKzhLBUW2H9FQ4QmMvxerqHMJyK9w0MSDdDBKvuBMJkfZd/nUrOFBxXVtIgNQn5BjD9ofMiWmh/UTbA8AEQrg/p2hSyqIdK0VV972V6co4rNM=
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 07:33:23 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::a3) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 07:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 07:33:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 02:33:21 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 02:33:18 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v4] cmd: sf: prevent overwriting the reserved memory
Date: Fri, 13 Sep 2024 13:02:52 +0530
Message-ID: <20240913073251.2286529-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d5eef6-f7c6-407f-9359-08dcd3c658f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXNHY7W4zxFdEVfOaTRv2KerrhrR9WfJGDvceLrQQHNFHl4PthsNIahQghOh?=
 =?us-ascii?Q?TZolow6SZcHk39EJMQZpnFsZACUL34MJ0d9kvJ0G+INSMLU8BViQ8xGEiyx2?=
 =?us-ascii?Q?vrcL1Tw5MZ+RHi6CVkjVzsaU1zUXwgjV4aSKfap8OH6i+TA4i5a1STxRdQp6?=
 =?us-ascii?Q?bPb9IKa0r0aI1S5/7Q6BgFxw2LEWXvmdjEO8dy09eValqmsWyzjrMaPj9BnD?=
 =?us-ascii?Q?shJDJ1mxCEfXbYhFwzktL+bgkscvL09n1VSJRqF5UVqqBtWkSYwexMkrX+24?=
 =?us-ascii?Q?9OBXmPLQkre9zLlZzXUwhiminwbIGDfXusf7qbldOwE2rInlBWtfsIEKyxfm?=
 =?us-ascii?Q?XG77gjeKLee+9YQrB0sV9CjVq9Q1yj9qb20mcNaqcp+yzFki6/pvl2uZssJo?=
 =?us-ascii?Q?LqYx76pbBI9OWhGJMCXjdseUxIKhYU28BZ+kpgM8k7/dSkC5/mygQOE811BL?=
 =?us-ascii?Q?B5kNy3sc/zbuQIIVv49XAz+HBboFjFpGDbf6Je6raIKyfKPt4arzz/mTCqY5?=
 =?us-ascii?Q?ITldb+kAhps3mMtWjJvjxrDEG6zktqnFNwYrO0xIjT3D2yN1IEoKQwI/lt4I?=
 =?us-ascii?Q?3wGL+a4YsiLjczd7gD3/3eFvm6ksjsyjpqfgC5HRTpffqzVr9xMIz7bu3Ual?=
 =?us-ascii?Q?xPnfzxxHgoqNnmbw/ZZpUTcNApTmsReMkOEOZPojlHETtIICi3CVtHBHDOyK?=
 =?us-ascii?Q?uvmkkW/r7RC3bzZyHm2PHU/JMYcLQFQ/B+5AHP+PihTFmxVmYuHmEkf6Lkop?=
 =?us-ascii?Q?RcpneNuLcYTzu9Qnbb5dwVwbFn6PWUzb3rLZa+xFD0fgfqSRhWrkAmDKfLgw?=
 =?us-ascii?Q?iUSUCeJM1pTfYUeBJZE/mq4WZpK7710s4xcw75d2k7y84q0wnzTOyDbDkFgI?=
 =?us-ascii?Q?D75Z1VJzk1271jkRKmJIwddJGTqnCRg/xfkARmEsqAvfv84PX3byOURzIOxz?=
 =?us-ascii?Q?nXSWHrpNHaIYyeHjE6ja/kHGp/T01j+4C0341x8CKL/cW63io7Y8Qf6MfE8U?=
 =?us-ascii?Q?1Zff01r7d2HdcaK5kyKVimb4c0NXuRXaluh3m3WXPM+o2sOrp32Mua2vqmzU?=
 =?us-ascii?Q?6JfLsygxYhhbuDiq/zo4g1k9Wu4KOBj8d2vUkxdNxfGoEH60aCmGF0VaJKiU?=
 =?us-ascii?Q?AnGVe1hqGbE1dB1qZNWgDcOCy1oz+k+Ptvc7zijh0uCIroKp/DfAaAHLjvOA?=
 =?us-ascii?Q?GcXxJ5qwWXjwrhRZARIF27qjKV9GoyYgg7bdpNuiJMn6nb2f9UFviSjFhYzj?=
 =?us-ascii?Q?lg4GQ8bCbosKF14/e3fhVKqy7LegfiXfBV7N9RRKCMMNHpX6Yhlmz6pAOav4?=
 =?us-ascii?Q?iw19zH91lGGMUF26D0tfky63ZpMhLyBy+RtZO+Uzg3He9tc4VfZT3l9ujhGz?=
 =?us-ascii?Q?LnMTR53++p41sUqxcWQJ3qCIz1ZrV8gkPPxssuo6jD8dQHJB2axEpM9pXXY0?=
 =?us-ascii?Q?sIgn9BmCDjcGznPrRd0ueNHEwj3J7Uso?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:33:22.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5eef6-f7c6-407f-9359-08dcd3c658f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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

Added LMB API to prevent SF command from overwriting reserved
memory areas. The current SPI code does not use LMB APIs for
loading data into memory addresses. To resolve this, LMB APIs
were added to check the load address of an SF command and ensure it
does not overwrite reserved memory addresses. Similar checks are
used in TFTP, serial load, and boot code to prevent overwriting
reserved memory.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
Changes in V4:
- Removed do_spi_read_lmb_check().
- Added the lmb_read_check() function in lmb.c, making it reusable for
  NAND, MMC, etc.
- Addressed review comments.

Changes in V3:
- Removed lmb_init_and_reserve() as part of latest LMB series.
- Error message moved to one place.
- lmb_alloc_addr() is not required because the given memory address is
  being checked to ensure it is free or not. 

Changes in V2:
- Rebased the code changes on top of the next branch.

UT:
Tested on Versal NET board.

relocaddr   = 0x000000007febc000

Versal NET> sf read 0x000000007febc000 0x0 0x40
device 0 offset 0x0, size 0x40
ERROR: trying to overwrite reserved memory...
Versal NET> sf write 0x000000007febc000 0x0 0x40
device 0 offset 0x0, size 0x40
ERROR: trying to overwrite reserved memory...

Versal NET> fdt print /reserved-memory            
reserved-memory {
	ranges;
	#size-cells = <0x00000002>;
	#address-cells = <0x00000002>;
	tf-a {
		reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
		no-map;
	};
};
Versal NET> sf read 0x70000000 0x0 0x40
device 0 offset 0x0, size 0x40
ERROR: trying to overwrite reserved memory...
Versal NET> sf write 0x70000000 0x0 0x40
device 0 offset 0x0, size 0x40
ERROR: trying to overwrite reserved memory...
Versal NET> sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;sf
write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;sf read
0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x01000000
SF: 16777216 bytes @ 0x0 Erased: OK
device 0 offset 0x0, size 0x1000000
SF: 16777216 bytes @ 0x0 Written: OK
device 0 offset 0x0, size 0x1000000
SF: 16777216 bytes @ 0x0 Read: OK
Total of 16777216 byte(s) were the same

 cmd/sf.c      | 8 ++++++++
 include/lmb.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/cmd/sf.c b/cmd/sf.c
index f43a2e08b3..08e364e191 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -10,6 +10,7 @@
 #include <div64.h>
 #include <dm.h>
 #include <log.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <spi.h>
@@ -317,6 +318,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
 			strncmp(argv[0], "write", 5) == 0) {
 		int read;
 
+		if (CONFIG_IS_ENABLED(LMB)) {
+			if (lmb_read_check(addr, len)) {
+				printf("ERROR: trying to overwrite reserved memory...\n");
+				return CMD_RET_FAILURE;
+			}
+		}
+
 		read = strncmp(argv[0], "read", 4) == 0;
 		if (read)
 			ret = spi_flash_read(flash, offset, len, buf);
diff --git a/include/lmb.h b/include/lmb.h
index fc2daaa7bf..aee2f9fcda 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -111,6 +111,11 @@ struct lmb *lmb_get(void);
 int lmb_push(struct lmb *store);
 void lmb_pop(struct lmb *store);
 
+static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
+{
+	return lmb_alloc_addr(addr, len) == addr ? 0 : -1;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
-- 
2.44.1

