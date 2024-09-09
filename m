Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B9ECE57B
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 09:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E4188CBD;
	Mon,  9 Sep 2024 11:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xDMoZ94v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00F188C8E; Mon,  9 Sep 2024 11:45:29 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594BF88D70
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 11:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/PoIo/Slp3PAmAPs3tx0LrK+SFtj876gHpUuVx0LrDsRQQgAbLjjpLe9SvrhxByXQg3HLjFzgz1Ad4Z83w2i9p0hbXqLquCabZ+mRNjJBk10jnwSlKHzmcgWQcX0MZBLgtUn9bWiuIAx2C/QEgpjMM1ZoDOLyBRbciZKqTekiT2HWTEjyI5zOftYit2pvwZKJSDoU0a+r/Dq/qJC/dChwR7R/vDojyK/q3AeKaqV4H4UqytMXQLYS7lpyo+3bROjmVLJgHF+8Qbv4R5lAnEPP3TolJkcULqze2vg6W+LO6YfMHEjY762jGpzKk9v3tjzOM+J9fEMNmPVWHNkl32vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGIcg0JQtgYm7I1LUdZDkxyBIdfk3PlFnVVR6rXkBNQ=;
 b=W540lLl5WyZW3o6FoAvNWQXrcydX2ziUcU9gQYGl9vTJZyEVhrnxXt/XbnRTCV3TIjf39QqoQYALnuD7tL7daZ2PLlWwbnXTtXMWosuoUyOSzFqoqNoX7cQ/WIahP1zcQPr7bKZmki0Qg8YzTyjz/0bdZt9FV+WcD6zZ8dB1Qzz9dd2g9rlqLsmZkJHIN25PJ2imjFuc2QfYEHNzK16au6uoxQQsY2TKCWnaBBGOMRWKL+DG6Y40J4l245Eg/x2Q1uKEG1pUpKTxJhIlPPccgkrMtcMqsDT2ZNujvXU0o6LWZh5XtEDQrSgxdE2OxYR92Hqw9BJPbw8415YyaFRadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGIcg0JQtgYm7I1LUdZDkxyBIdfk3PlFnVVR6rXkBNQ=;
 b=xDMoZ94v79SER1TKvNJpKJ11PJxEYvxeyun6+AXO/+SFAMz2hg6H4djNFKhD2Rxuw4ifB+GfSASeUnk24OdJ+2eBP8xQ4j3eCfSK9B44y0/IBZY4DTxtzp7DWf+8HncGn5/6rMtvlloPx55S7s4ndjhNHxNKIshJOLhwc02a0A4=
Received: from CH5P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::21)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 09:45:23 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::7c) by CH5P223CA0016.outlook.office365.com
 (2603:10b6:610:1f3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 09:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 09:45:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 04:45:22 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 04:45:21 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 9 Sep 2024 04:45:18 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2] cmd: sf: prevent overwriting the reserved memory
Date: Mon, 9 Sep 2024 15:15:09 +0530
Message-ID: <20240909094509.1481038-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: caa48c75-8e99-4ef1-41b3-08dcd0b41fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?669iDqPSQwBIhTpMf3fUjloP6v8at7x44t0u0X6ZJ2KjFQAsjOPriJTWznz7?=
 =?us-ascii?Q?ewHLk/Hobtqm/FhsOm56fLU3HZiXh+DacSLIYo2qwnro7Lzu5qEQbLk8Nbsi?=
 =?us-ascii?Q?1Z6mM1+AtE4Dby3Kp06p6hIz7a1o2N5tvNEuYE9qY8RWgB2S22VZ6Yji7PT+?=
 =?us-ascii?Q?39+tgg5PFqXk9d4GB8gvADLI9WFTTC1t1vrQbPUPKqMDqJ2lCnzqCMGsoHP+?=
 =?us-ascii?Q?S4QwPSvaLD45rk0NsHknCbSjhrWcjZ5U/O5W1UssCT+1/AAthQ37NQi5IyYK?=
 =?us-ascii?Q?CRBVpcxiNTgtZ0FhX7loL9ZmriOSnC/aupzXDHiO6zBA6ihftS3l36J+cC/e?=
 =?us-ascii?Q?XDJH7ToEu7CrIr0t0bdpBWrxLLeiHNcW8y8YFw6Be2X56CSrBmPJjlKQDqj6?=
 =?us-ascii?Q?J7AguZcyZ4BYKpFLN3UT58Ml+IvBZ+KKmjozJrW3knia/YKAJwZDbIf71/z4?=
 =?us-ascii?Q?HurFSyPRW5k0DeMPsvWV9Gnf5gWhOrevK0M/eOQDAyNhZDMwf5ZR1KO7THir?=
 =?us-ascii?Q?IYSih7IM57lHVn4lrxNiHjohR64isJG15AfS3ACHqnDB0wvSZ+Cj+Lgp66rh?=
 =?us-ascii?Q?22uI17zv3VKAaZe/U506Y5b15xvYDj2U1gM0DhcDW4eXFP23j4oQZy9r+lqt?=
 =?us-ascii?Q?JxjlJo9TaEqHQhRSr9DGPnOta7UHNNdmlSdDIMEYSxdgzb9m1tstAMDzJfE8?=
 =?us-ascii?Q?GqyGJApyWlTLGgYs9+IYnmgLjOe7ZuE1a+dsTNZy7ayMziC2DsQaCJ+UvkY7?=
 =?us-ascii?Q?QV2tdnLhz4+AGE0LCO6U4MTMEu1buU365B/6ftbnoLGRd+ozRt1lHrA8SdxU?=
 =?us-ascii?Q?ZDJaZ4RsZvPpqAGTodcAhkkd32QGkLFV05HD8wSI/Gy8PrqYm0nsMcSMUImj?=
 =?us-ascii?Q?/Qq+NLpEkuIZ2lpuV6Gun6CyVv11wPqN3X531MaxeUkM8K6469/grUVoJhQh?=
 =?us-ascii?Q?ulWSKOmxi5G0nXsml9OpRCgagdkj3Myga7sH4HSjVP3xpWwg+4CyibEa2heN?=
 =?us-ascii?Q?Rf+tPppT67/5Vrbfb+yx4H9B0E8xdogsBKNsU0wBtxf/BwLb4zyyAgc3IOEs?=
 =?us-ascii?Q?VUDhH1/L2ogQi0w8F012carFmIa9SFkvssTuDxjCEi+ioh4uDvA9Bjdi2QaE?=
 =?us-ascii?Q?UHvfY0umEoqQQEpFoPwEE4ZWr3gzFgHeEUUNGeHxoavQGt5PxgJfUo5hVc5d?=
 =?us-ascii?Q?stuFIbAcW9b3uVdNBtekLhauhxrs7YR3Px9ZONPgd8LcvTpavEAh4WLfUyc8?=
 =?us-ascii?Q?lOOYx7ymJdCOLrl8AaUsudGtETZ1HPj6CpD4rIXqVVUAdY/BtHkCxJI3YV/f?=
 =?us-ascii?Q?/Dv/1FuH1G2kYyUhMvREAJyoGQPkCPcdmbal6AxFy/I3e4HoJX+Ifb2BQSOl?=
 =?us-ascii?Q?e70A04NQoIitzrsyo2y20NKMc2rRfm729bnZEq6QGtNrxMWveYzHlvHyiJnd?=
 =?us-ascii?Q?0N+h2LmKu8P3Hne5IaZLsb14TAPq9EeM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:45:22.7450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa48c75-8e99-4ef1-41b3-08dcd0b41fef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
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

Changes in V2:
- Rebased the code changes on top of the next branch. 

UT:
Tested on Versal NET board

Versal NET> sf read 0xf000000 0x0 0x100                                         
device 0 offset 0x0, size 0x100                                                 
ERROR: trying to overwrite reserved memory...
                                   
Versal NET> sf read 0x79ea9000 0x 0x100                                         
device 0 offset 0x0, size 0x100                                                 
ERROR: trying to overwrite reserved memory...       
                            
Versal NET> sf write 0x79ea9000 0x 0x100                                        
device 0 offset 0x0, size 0x100                                                 
ERROR: trying to overwrite reserved memory...

Versal NET> sf write 0x79eaf000 0x20000 0x100 
device 0 offset 0x20000, size 0x100
ERROR: trying to overwrite reserved memory...


 cmd/sf.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index f43a2e08b3..d2ce1af8a0 100644
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
@@ -272,6 +273,35 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
 	return 0;
 }
 
+#ifdef CONFIG_LMB
+static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
+{
+	struct lmb lmb;
+	phys_size_t max_size;
+	ulong end_addr;
+
+	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_dump_all(&lmb);
+
+	max_size = lmb_get_free_size(&lmb, start_addr);
+	if (!max_size) {
+		printf("ERROR: trying to overwrite reserved memory...\n");
+		return CMD_RET_FAILURE;
+	}
+
+	end_addr = start_addr + max_size;
+	if (!end_addr)
+		end_addr = ULONG_MAX;
+
+	if ((start_addr + len) > end_addr) {
+		printf("ERROR: trying to overwrite reserved memory...\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+#endif
+
 static int do_spi_flash_read_write(int argc, char *const argv[])
 {
 	unsigned long addr;
@@ -315,7 +345,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
 		ret = spi_flash_update(flash, offset, len, buf);
 	} else if (strncmp(argv[0], "read", 4) == 0 ||
 			strncmp(argv[0], "write", 5) == 0) {
-		int read;
+		int read, ret;
+
+#ifdef CONFIG_LMB
+		ret = do_spi_read_lmb_check(addr, len);
+		if (ret)
+			return ret;
+#endif
 
 		read = strncmp(argv[0], "read", 4) == 0;
 		if (read)
-- 
2.25.1

