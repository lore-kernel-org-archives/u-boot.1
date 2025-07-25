Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F02C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A07A6833FC;
	Fri, 25 Jul 2025 14:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KpuLOPd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCE8833FC; Fri, 25 Jul 2025 14:42:06 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2A3833C8
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvXuECeiWYsrwlROf4D1lJYEODPsGiKbWiF3RrBCLmsTa/csVWR9abw5dKkWZtHzLcQ5FsBL100pIeJa7SZv8+nq+8MQZB5t7B+4jDIw8XNxHWau4LYumeYDxbcMkXMT+UgNP0WuhT5HdPNsSOwo/U18zGnVf5RurEswec0eONpJmyxo5UaP5xCV8HG4r4Rp9UPjG6E8CjLNHxz9mtz+4zND5z4aHMK36kWcOwFP/eduw5W2B6SYCenxwO+GEpxFjB1RdqKHtniBVRxO07Lok+LV6DRvyt6IdZDGWCvFigAfNCh6vhLkfqsiYpHJBXAjQegdzcpyVtDdKv+0x5gfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TNMk0NKf85INbNbIq5dr0Eq7M6RB/fiZKwN+DaY31I=;
 b=VrMS8EOXoSxNHuJARHZlLjaFmb6wMWlAFsSMXBCkzSguxTCp7xVZUXsLrmPT2V/BFBKb39Ul8TftzJvccMZXBKO/iR3C6Ets/Nv2ODIWAbozyLE58wfB8L6pLbux6Lu9CCfcuE7G0IEQacQaeyw8s6KpEqtdIj+/cZ4f2JnOXbI3pfHAgOJffBjsj+hah9Jqp4gfnoJCMqvL9qLrRNEdadV04YopKVLoMFUbrKtBqdWVfWd2gGX1TGvUIA/WfG7AU4j1I2HvBpm3u21AiUEG3lpGPaRrRkFTOlweRqvG3f3PDBNP9sq/ZsFircgcRxjQ9pKvMzcbjTTNlrCdV7WhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TNMk0NKf85INbNbIq5dr0Eq7M6RB/fiZKwN+DaY31I=;
 b=KpuLOPd2Y2S7eexfUsf7GEuI3jvVACZ+vo2lJ8xZeACMWCO4XKE+VKOhdjUKyCHC6Xfpp52TSp4Sr96SR9OoDtO/ZFV3Quaqo8iab1xoCYxmcE/a9A6E6ykRiXW/o1cN8QkRlqZuaiJ5UjEUBLBlP/dbocVYvnLzCVDcZ6Tk3Zw=
Received: from BY3PR10CA0012.namprd10.prod.outlook.com (2603:10b6:a03:255::17)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 12:41:58 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::43) by BY3PR10CA0012.outlook.office365.com
 (2603:10b6:a03:255::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 12:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 12:41:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 07:41:56 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 25 Jul 2025 07:41:55 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] exception: Add missing string.h
Date: Fri, 25 Jul 2025 14:41:52 +0200
Message-ID: <e9b3fd74e233ea783e64fe1d1c3de5d4f3c6610c.1753447310.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=2a7SLoEbzKkXJvfaPABjcak8JAPFMwVB14ycTffQyd8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ0V0886jpb4Wy8VYijZP0S6RhH7/U6zz7zh91IFkncf
 8Bvd0FSRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzEXZPhf9kvyykefpd+XHM4
 ZB6Vf3ZtVciB+a63m1pbfPOXv22dUMPwzyKpQlbuxvVlzoc27Vlhfu6Zo9rjcO3sDazuf5h3f3C
 /xAAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d32589-e616-4317-3fbc-08ddcb78a535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JwPXIRIGBKRBIA6ZO0FMBnFaNESmpchTh3hWn2aiolWs0nY29d4eU80W1a+q?=
 =?us-ascii?Q?ZJk9MuWakg7ic7NUcsO/yyjXJ0q7hFCc1DAcC2BZZaw1Cz9NRfBPCq1CnzLH?=
 =?us-ascii?Q?5IUHkX0Yd+cYAcnPHjrDhS4SrsOMNpGli9+7dNgz8aoarn3x7Q0EgJTIqhpK?=
 =?us-ascii?Q?TwYjx6tZIzqkPCt3U+1iEM4bOzPK4yo95Ese1Nta0SE0fo1bTrXAoOhd0MPD?=
 =?us-ascii?Q?nPQDswd17XQL9pTO3HKO/en2Lb1vDSGW8Qp03tBJzzNjrwfQUNfiYjNK2Di9?=
 =?us-ascii?Q?K/jw42al2G1vaJ2Rtpfn4g+3U/J/2xUxICV+sjZ+/Et/5sktZOnAKzrJSlUT?=
 =?us-ascii?Q?S8SNR3cU6Np0ENlezvmF2uAGjbTLdnGMRCMCZGddUTLIR65FyinvWsdAhxZd?=
 =?us-ascii?Q?zl+xKIclgWDXyEEwn3LRwPDWIcQXtuziDRTqAkbQOnJX48JB8rhphNf24B06?=
 =?us-ascii?Q?JopkqPPQZZ/CTho6swCF8zm6nMz0p3ey2Ybbek3m92OBh0sH5lgfV+2TnMXW?=
 =?us-ascii?Q?fKdJPwE7Xz5ArzIlHXnUZEgxuWl8vrRKafHPBEtPkmi/szZS9eawRBOhnXA8?=
 =?us-ascii?Q?Q7bWWB/EuEud8PiSg2uKATyAxca3iqsF0ZC7pYH1U1NloBsP28iKakMEeugT?=
 =?us-ascii?Q?tUeMT/ivQz6dhSYrU3LKpM8EkIPH4Jd8nxNsgDWtEMpcWOcvHv5fBs2G8FFs?=
 =?us-ascii?Q?I8D8EJE0X1f1T66BdUFaTnuG31k9CGSKiN4YwFybQH0bDcmykKbin4RU+Nak?=
 =?us-ascii?Q?x86F7qCc/fmIvRuZuogMAz6A21DXNGosAUSuYvlIsoxKTVnsLnWmw681lzj4?=
 =?us-ascii?Q?+LhX+splEUajplYlWTZ/CSR7UutRX/eHqBdiFWd7+auFPLoAjiR8qtRp/Xom?=
 =?us-ascii?Q?G6lH5vXTqsEg5fU5GB+51UTqRvgW2sNwvFZodEiTZvaMVvWqV56xLg8zKbTo?=
 =?us-ascii?Q?vw1uNPyhOXqQSvvSieuJtBRL8k2iv8UfwrE4bUxf1GozJGNJMlDg9sRlD3M+?=
 =?us-ascii?Q?+KJSKl3mAYXnKW8cEgh2bovSihO6jWakZHBNJ0zV6jXiK59WQsVqZYBoszRw?=
 =?us-ascii?Q?nEUPTn2QkLuAZXPpXgtYxIhfU5OCTkmA7AIBUePcWXsBrr+BJlw1yZJANRJd?=
 =?us-ascii?Q?Zx3ELw7gUO7J8oMuyp0KxzvHcF/Tmra/wkkBjFCIfyUH6zGx2VwRrEgUfs4d?=
 =?us-ascii?Q?eaM4EmRUXnXw+uNw7WIMobkVNSNlJlqzct6QKfypMDxZF5tuaWtX/ZY8ZiGR?=
 =?us-ascii?Q?WEztqS+sdcS3qX3Amwe1TJPOnqSBdYfhZW2wrSHDI4LDuTIme0TG8PXFDLxA?=
 =?us-ascii?Q?Y0Rxybw5cbevtTR5HutW/BMeqo2Lh5YG2oBdJJUG0Dj8Cd6UGyvSI62OhV7N?=
 =?us-ascii?Q?ZNNAY5F0gmnpteRYMW/Yb3gIHXU5/e/tww4VNk/7QYGZElwnN3RgiqNyViLm?=
 =?us-ascii?Q?H5p3UENgVqFmjFTWSgCXXsy5n1HlQJbfjPwaTnm6A9FtDE1a/uN8ccvtmwgp?=
 =?us-ascii?Q?SDtVEQNEzTuzul4oClYxE7vmmFC+6l1I6scK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:41:58.3374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d32589-e616-4317-3fbc-08ddcb78a535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
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

The commit 1e50f7457fca ("include/command.h: Drop <env.h>") removed env.h
which also included string.h which generate compilation error.
But because none is enabling CMD_EXCEPTION it by default it hasn't been
spot.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

  CC      drivers/mtd/mtd-uclass.o
In file included from cmd/riscv/exception.c:91:
include/exception.h: In function 'exception_complete':
include/exception.h:41:23: error: implicit declaration of function 'strlen' [-Wimplicit-function-declaration]
   41 |                 len = strlen(argv[1]);
      |                       ^~~~~~
include/exception.h:1:1: note: 'strlen' is defined in header '<string.h>'; this is probably fixable by adding '#include <string.h>'
  +++ |+#include <string.h>
    1 | /* SPDX-License-Identifier: GPL-2.0+ */
include/exception.h:49:22: error: implicit declaration of function 'strncmp' [-Wimplicit-function-declaration]
   49 |                 if (!strncmp(argv[1], cmdtp->name, len))
      |                      ^~~~~~~
include/exception.h:49:22: note: 'strncmp' is defined in header '<string.h>'; this is probably fixable by adding '#include <string.h>'
make[2]: *** [scripts/Makefile.build:297: cmd/riscv/exception.o] Error 1
make[2]: *** Waiting for unfinished jobs....
  CC      drivers/serial/serial-uclass.o

---
 include/exception.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exception.h b/include/exception.h
index a7f21e73d753..0d4dff49954b 100644
--- a/include/exception.h
+++ b/include/exception.h
@@ -6,6 +6,7 @@
  */
 
 #include <command.h>
+#include <string.h>
 
 static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
-- 
2.43.0

base-commit: 2aed9f720ab6fddcf49bdc361063e53451a7dddb
branch: debian-sent3
