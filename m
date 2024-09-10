Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF381EDE99D
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 15:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF77889CD;
	Tue, 10 Sep 2024 17:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZsGRHUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D921D889CD; Tue, 10 Sep 2024 17:44:23 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65BB88B27
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 17:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZI7RiS1ht7kUCb5B06TI6U0fNZdli+0UGQ5DjQ7CEOcTq/NUvQclC0QH4/t2HRI0IJ8d7N/tZZhcX62ugeao8hEdgUzs4WASmimBpPpSPifh0TAH+ztDYRslzGp1EeMgY/N/BcIiEYwDZsh8W/1Zhycmr6SZ99Ay9sf4H42DstxoWEw4ZjBAIr9CPvdH8p4184Tn/IQBD0YOUpkfbNyKLdLcmDZvavq9LmcqncUuC5U/NmwVf/j4e19NHRUq/Ig+3ytsW6S1ajr60vHNtASXRmm5HAm9fLtjQGlMgVKT0zYFeE3GInwgBaTczXhr+nLl0WPO9oGRCyKeE4zo+zgnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1bCh1dBfydwpsLHA3TMu4qqHYMwopdJRbHG/tm9OsY=;
 b=y+Db7MsCuK99mfOyNzKy5iRxAJx3yu/HQpwoeli0XPyDiM4/Blfdd470Omgbjt/KoQXy3KN70sZ9QOBVjZMiMube0azbLxNetVoMkkR14/HKqL2zoJ8XbHwPwgZDXBB0K6yPKMnK1hfeKHh+yAgmKoS7tEfVjowluE68pw/HfyMNYOy6IUfV2K0aQL3YwxhoNSP9eVJaMO9+WtZ0n2Zb31+0ExagwQOSQoV4Lvga2qWaxK34YOTczpaESc7wb78HfSLsJ1nslkzh0sv9mMdaspGcIKXFAiaTOcHXQjUnwydvgkAun+C1D3FIgnYV9irxru/iiFqbPhUvnqXTXlb9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1bCh1dBfydwpsLHA3TMu4qqHYMwopdJRbHG/tm9OsY=;
 b=pZsGRHUC37u80PTLB+MgRvuAb4Pb+OuiRM/bNPVt5e9qTIAtpdrK3pKF/2vwQ/vQ+iYxXdPk5awndZ3nqurwMXWWSbl29Es8GNx+vDrt4ojSUdsVaiJWY60JByaP9Ijqf2dRgKiT/FKd6U5NnlW+Hyw2iu1uOE/xDUc5xmEyxJA=
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Tue, 10 Sep
 2024 15:44:14 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::f6) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 15:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 15:44:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 10:44:13 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Sep 2024 10:44:10 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v3] cmd: sf: prevent overwriting the reserved memory
Date: Tue, 10 Sep 2024 21:13:45 +0530
Message-ID: <20240910154344.1837906-2-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: dcacf581-69ee-4fa9-6e22-08dcd1af6c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h7iCK3PXehWV85f9eXtDmEHB/4Gbl2AU+nPDKLlXiD9FKnPticBCJYtSwcuE?=
 =?us-ascii?Q?jsAGc274Laok0MxeGgjNCq4oYzLHx5iXuR3oqrnsI1f7HYAp9PZLWnIdIpJ5?=
 =?us-ascii?Q?SJcTJ+d6KknXGIbK0vmRgreQQ02C07Xbn0lWxbyk5j7gF+kWVQXm6XxnEGkK?=
 =?us-ascii?Q?vJRHfZqW8aRCg89Yx0/DnrLqvoOmnCO5LSx5MTlR4QxI73m+F4YMjMTgMuc+?=
 =?us-ascii?Q?aN2agzJMzmjFL8j7U4pDJ5diCWcGpAgiNY1ft2iT4zoTKwmZmipz5i1UisqL?=
 =?us-ascii?Q?l+SQwUfEhHmSm/IFnGybBQwPnH+S90lBLR0FFJcmXwcoKS7p0rwcUhMb9MsZ?=
 =?us-ascii?Q?8K42eIck/g+E23doTozIgSFswRrEzKh8mdlC4ipPiSUd98kmXJTJQ4LvcXVV?=
 =?us-ascii?Q?IRGhlp/9R+6K7ZbprC5hn4WZyCfaxBLwA1SJmhPqeWT5F8g3CwR4LfiHMUaf?=
 =?us-ascii?Q?B+JfqPaQCAaF2SHCfZwBwB/rE3+l2kyJ02um2uU1GaNUxGuItszyBs2B5kiz?=
 =?us-ascii?Q?Crcz4Wwd1ZrvJjQ3u9MiFKj7QEbZdN33TlUv7flywcJk3j29g4O7V5rgwnpn?=
 =?us-ascii?Q?LXG+VJ4v04D/E5ui0qL6yvt+KLWLHLBnpzXLL5mLos9uKSRkkmTCplnTtfr1?=
 =?us-ascii?Q?zO9FJv1bNI6HEARh/ybrRFWFiP6xpUA8ye1BerFe3uQnxyc1+DqSinSu1xSa?=
 =?us-ascii?Q?O2LrkJblPie9j5CHAJyubCuO4pc2q/1Gl+mqiIk+ZbI9GdduUpBGWNIS7jQZ?=
 =?us-ascii?Q?zAUTyZ8iGPTSg9tfHAJRZBEVhusTTtJKFHqr5t00xHCKBFiSDP79d5PJ+Xqk?=
 =?us-ascii?Q?hYg5DqB343Hmq3dDCQzmFAOdOp1rsEWjtRv48CK61evQ3+1eJXE286fSC181?=
 =?us-ascii?Q?/kdaHqdFEj4+MX4HsFkjCD0dYtb1tZVMWln6UvGy9E27FLLFwpnwBaKwKQ59?=
 =?us-ascii?Q?2crztR10v2/jv8DLX/bST0WtRFD9MkQ2PVLk+sD6Dh/YgIU5rnrwosaB6Hbw?=
 =?us-ascii?Q?PPIhIDpeDGcSEw2lmn52oIr8fPAJBPHCS/NEwRYKd78r7DISAHoAMtmv2BhC?=
 =?us-ascii?Q?dv9X53PC2KioV/FLf0KqrWaYTEIYNB7unPfoK3WneNrkGEngaxs5CKYC1mbZ?=
 =?us-ascii?Q?HFVly8iWVrfoIci8EPGR8Rq9mMF2g0l+Y129znwxIF1dc+cSq5K5Xk8Yrf0T?=
 =?us-ascii?Q?xqt+uk0VVZ0OhHLESNSvREUuMQuWS8K4l6fUE0hloLecPKFWCYiFKLYWfjXQ?=
 =?us-ascii?Q?wWLLoOyAAzzk/qHwq0E0yJjTH90PkM+BOwC+U5I9QzzoM54QYkCjX0DgbCjp?=
 =?us-ascii?Q?bpJGqU16TkESpv7wEyM/P6VFV6rhQ02sTXRQ137L/eg2nbLBT8sD4r7PHeOH?=
 =?us-ascii?Q?w7xup9En8RaDrGIUlJDYx2k5V1g2588uJwwgj0344yFSsR+kdZy7G/d7cV3/?=
 =?us-ascii?Q?f6+1aDz367+vZAScGt3aseiL8r+h97zB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:44:14.0416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcacf581-69ee-4fa9-6e22-08dcd1af6c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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

Changes in V3:
- Removed lmb_init_and_reserve() as part of latest LMB series.
- Error message moved to one place.
- lmb_alloc_addr() is not required because the given memory address is
  being checked to ensure it is free or not. 

Changes in V2:
- Rebased the code changes on top of the next branch.

UT:
Tested on Versal NET board

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

relocaddr   = 0x000000007febc000

Versal NET> sf read 0x000000007febc000 0x0 0x40                                 
device 0 offset 0x0, size 0x40 
ERROR: trying to overwrite reserved memory...         

Versal NET> sf write 0x000000007febc000 0x0 0x40                                
device 0 offset 0x0, size 0x40                                                  
ERROR: trying to overwrite reserved memory... 

 cmd/sf.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index f43a2e08b3..7bb8bcfce2 100644
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
@@ -272,6 +273,31 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
 	return 0;
 }
 
+#ifdef CONFIG_LMB
+static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
+{
+	phys_size_t max_size;
+	ulong end_addr;
+
+	lmb_dump_all();
+
+	max_size = lmb_get_free_size(start_addr);
+	if (!max_size) {
+		return CMD_RET_FAILURE;
+	}
+
+	end_addr = start_addr + max_size;
+	if (!end_addr)
+		end_addr = ULONG_MAX;
+
+	if ((start_addr + len) > end_addr) {
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
@@ -315,7 +341,15 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
 		ret = spi_flash_update(flash, offset, len, buf);
 	} else if (strncmp(argv[0], "read", 4) == 0 ||
 			strncmp(argv[0], "write", 5) == 0) {
-		int read;
+		int read, ret;
+
+#ifdef CONFIG_LMB
+		ret = do_spi_read_lmb_check(addr, len);
+		if (ret) {
+			printf("ERROR: trying to overwrite reserved memory...\n");
+			return ret;
+		}
+#endif
 
 		read = strncmp(argv[0], "read", 4) == 0;
 		if (read)
-- 
2.25.1

