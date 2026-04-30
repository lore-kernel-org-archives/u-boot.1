Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E623FF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 09:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E538B846B4;
	Thu, 30 Apr 2026 11:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vfTNOuHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9BF846AD; Thu, 30 Apr 2026 11:34:49 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCDA84662
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvGsVHFvxpW0VYDcgZllDQTMXP04kokTGL5boQcSUe7w9ULBdWXca3qfHqdEYkNHnJ0sSjcdggKTjqdcPVcsJ6C4M6YGgTxDX2qDXelOB+wM8lFYbUBPqSRZyxNi/1GE8/EGq2NtDziS4g8S3u3XpJgHOdN2mZHJfH4uC0Q9V0DmGgK2U+fPT3nKWOA0zhxrXUk0n7hhViaZ2x0406NwSla29UEN+dpqZSqHgOLkXyHdwcNEob9boe1Go3An+HeiDUCmalTQM3ZHdQP36SstSk4scSioQomHaQX1nDTBt13OktnpxDNZIzZygVnkFLwuehWouuRdf7YJRK8MuNe4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5y8axj9Kj+MbYsoFVBKGGOFR5G+yukEE056IftXgxA=;
 b=rVpfHFLOzMeEznO5kxMZSqmixCKkTb2CHW+fPYgvdNeIqnUQPpHIlQrN2khJK7b0GQfJ39I7EOFmydP8DGteeVvD2+/7c8snVD/MbFRqcIuPT0NIZEDN7NroSUEAXePt5ZGndo3DwVhJGJoM7OwToWIYgTKhqKtm2u1McUEIYPPb0+3LipUDg7ZHh7NLQfb0qFkGdMHe9/RZ49q2LiZW6mJOgBbejsbbWQbl/OaFfoIemvnVw0/U77gZKre4ToPUK/khUCcyxewypGotlVl7rZqMiccmSBEhNfCL0CxWKhUcGrbcGhF1Vj1NWcUZrgPiv5wLCaD42qbIbfzKrvrFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5y8axj9Kj+MbYsoFVBKGGOFR5G+yukEE056IftXgxA=;
 b=vfTNOuHrbiRvjjA4oVd4/k6zdtVDRqKtifO+laNAoAk5rgJ65v149wRTmamxue1ku9XewBnK6KJAqa/lFk2aOu0GFg28aLQ/0yugHA3smwuoo8Wdcx2oQyvINhyU/L6u9kg5rlWiaUFd3muzdoA4pn4J6lBc5MsKwRUhGkUGyvk=
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:34:40 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::f2) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:34:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:34:38 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 04:34:37 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 2/2] board: zynqmp: Remove hardcoded USB ethernet
 initialization
Date: Thu, 30 Apr 2026 15:04:27 +0530
Message-ID: <20260430093427.1852145-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430093427.1852145-1-pranav.sanwal@amd.com>
References: <20260430093427.1852145-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e1140-09a0-4c64-ed4f-08dea69bb413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: cdRGouNeasQwR5qCAzWXTTcd6nGBU88c4ymWhtqK7ezX4FSutdX+Ttl1ak66EfUKaxBqkkoI7ur5rz951sRX+EqYJFBuN9CsCV7778rCLXu+xQ0UOvaEy4aDzDF87pM5B8CuvZiJSQcuSuqKImtIAWuG0xm/ofL9VqGitf8wfdIRj2tAOsWdc0uTs09oeUNhSKrdp5j8MecGtBq2cAd41TYOl0ODisB0DdW/2cR2wyGAbqFpz/nZ21/nZG33lY2NO0dMnrqUXoW8PFO8UxrXVPB82fEupa+qSKvn0NdoeCgFJxOLYe1giGvLs8/Cv0r+EkgGgJN8t0FoAaQO2JWfEvg9dAfJJmNvOhyQ757sFecnIK87fY5/eYTG0oollThTUY35x2tqqeFzyzhPlZpqiGeXX8xhaV4ZDGg/pLT3L8ANlCSkaEBKiQ6RlwBWnHvwjJb8bhzDR1KPhKGYzTFi4/Z0KC+Ld7oZBsLxF+CRqQqQmQaqtf65zdLbfytjwlZ5ALqyVH7xQShj53z4TzdPGgrJiJKkGGocIWykpifoNjbeShJa25ju0er6B/4cl4UsmmqVoZj2BW6llSP30VePcJpdWOVBWhp634TmW4uSCEUbsmPuzzzDUeQ/EK4rGHMPdZU9JVpLRhxcT7UyRfjpzHth026Rmg843cO8Hb6C46PEgbPtnEP/VhLFxqjtVxGZlg5HRXGJpE88VlmItQ8dgQXECVzCcTR1Z71Ma9CJ5eFKQutvk7LY9aJdtbo/yhBcYZyNafDJ+7uCXdi+UFXD3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /8Wn6If1vz3SwWNEDJJwqgdF01dzAo5mPfPu2uJtiByiCjTsV4fz1ShPAtOtnXV8A0PMVTQGVsSmkN1/6bSDSWvj5MFcHbzHfyrilujIT/+gnMinD14GWcIzKGMM1d+HZ5FY9myreWDW8YgyKVWkkTdLZ3E5ACRAo/bexibO9nmLc5QR8X5DEkRY+yQeDdWro7u58vRy5cFJajm7FrIzbo+iNXxX1WG03wn0jTz6NhU1mxcRF2KJhAx08e2RmRCLUJ+JshxYL4+XSmUAyDt6ev4P9fllxbZb/uGOj9yDdHjyqO3X0x1DletuNXFeT3g6c8JPcTFj2TQZpAhxwsmRxgDaR7yKwlyADyXjPKD8rZJev/3vtcvge0/0c1TfIr3m4zGndMSp3eaeuiREUXjQ45ubr8OjQ+ockwkOTdCuFJ+Fz7NmLPrLO1tW23UtwQFE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:34:40.3743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e1140-09a0-4c64-ed4f-08dea69bb413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054
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

usb_ether_init() called in board_late_init() when CONFIG_USB_ETHER
was enabled without CONFIG_USB_GADGET_DOWNLOAD.
This makes USB ethernet gadget a fixed default, with no way to opt
out at runtime without a rebuild.

Remove the hardcoded call. If USB ethernet gadget functionality is
needed, it can be added via the preboot environment variable.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 board/xilinx/zynqmp/zynqmp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 091e0d0c88a..4a62fdd8028 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -541,10 +541,6 @@ int board_late_init(void)
 {
 	int ret, multiboot;
 
-#if defined(CONFIG_USB_ETHER) && !defined(CONFIG_USB_GADGET_DOWNLOAD)
-	usb_ether_init();
-#endif
-
 	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
 		configure_capsule_updates();
 
-- 
2.34.1

