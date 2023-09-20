Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761E3CE79AD
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77F6B86B25;
	Wed, 20 Sep 2023 05:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a6brVF75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E6D86AD0; Wed, 20 Sep 2023 04:55:36 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BB386ABF
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1fhA6RGO44MMNiw7gM22qg8ILBDsJTG2R0ArUJ4gcvZq7k013roLK1Fl8VZ9jol0kEBwbBSBvRIQoPfjp19LOCfwurv2ZA3IMLVd6I33KQ+E6V6npFKD86Y2LHDjt1dyCPSQ6s93cvN8qRC8wJmR37j3KlBoRFIb+y9ZSf6ubpGvP0RQiQA4gMPTX/nGs4cR3IAwmjGYt77S+1x3qdwNVnhyG2oWUtlD8tP3kx5GtaZn8Zi9eXFXKDdBGPEFYYUd80ztvg5R1PtcZLJDVxMU8fqF97piTdNjOulHuzqYhS7Q9/ZCclLGJsbpDyEC+uMnijNIgTMyBKrXW28fxiejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnIB79MstOPmdRlrHFyOc3KikeULJZ3QkUbL4moDsA8=;
 b=DDN96JZ93uckODJfocgGfsa0vPmENz8Z93+RkAphTdRHC4ESzE00qRveazORmmnSAzpBDf/B1D7tjucb1yoOygo1luPDQx4kZNDSlBJZor/+XvJlJ+CBbwi9bnesYaKmtndNvMqu6xuH0/pcpETaBM1g6arN7kAznY6e3lajDOw+XbIR7P8tV3P0qBpsxwi7nTCNvnW6L0Ze7VFcMQqRSNA7HrSZo9MjwofcuAZvQ6777bUbhEM6+drBpQ2JjOOjprbEjVjdPN14m32GYjYrvRE+Svo4unHDYPfQElt9Y4Up8IFwo/ZiKyc8LDnlYRqM4l08G+8gdYGOQ9I8mTDXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnIB79MstOPmdRlrHFyOc3KikeULJZ3QkUbL4moDsA8=;
 b=a6brVF75HDWJyZK2q1+Rk/fv8UjO+Zl2qkBypnsTXqGVRHSuxap9DjnDyaybZz0R09ZuHS7QbyiMEnIeAkOWezLtaB23tkzawPqjtuKHOOeYGY+4TbvThJyjYDO/EdGfsx2R0+u/JaSgUHe8Bl+x56PUY0dSjrGdcncXO3FVfV8=
Received: from DM6PR08CA0062.namprd08.prod.outlook.com (2603:10b6:5:1e0::36)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 02:55:28 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::f1) by DM6PR08CA0062.outlook.office365.com
 (2603:10b6:5:1e0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 02:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 02:55:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 21:55:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 21:55:03 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 21:55:02 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v2] cmd: sf: Fix the flash_is_unlocked api size parameter
Date: Wed, 20 Sep 2023 08:24:50 +0530
Message-ID: <20230920025450.6281-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac82120-4454-458d-702c-08dbb9850b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quvz3VJARWIoIshHnSsPhWWh1Au+S6oZcneF3xQ0/eazJ0ouPyVtBYBjxzCbji+lz5cfubM5rDiJ2VFpYVbV/k7hNqvL8Q8NTUyVzdba7YbQ0qksbOIBHBB8ZFOTzlBXgwCXPFsjYqAmTojbXv+SC3pVlfVM7qd4OX53rIB1FmBgrgGgIxUWQq03KrzAxea9OYTE+CHfRFS+ZW1EVy6fkb6rtLWnehA1NLBPV2U/ypBzQya3uf3Lku00zlspTQZhH4x7cY6sDAmBVy9LDXfeG7giIeKDTRFLHllX17Wo231xrWr/8lIX/38AcBS4hrUM1pMEvpIbFIvhiLL8dlQzNvg9cHWLM3DqxQXfabYLKXwdOk4QSSfC6PKn6krN8oBpM1QWcYO48zHd/MMzQAGhdoKvTAnOBOgiNe2LT/oUhbbU3WglDC9NJvO6OU809IAN/eb5CPuuPquQStaHnmxHTjmkGcUJ7UEGVdWegazyxW/Qgw4fyI03/AJjj7TlPp/KP4DnkalSuW88TimM35ChrN+VZVeAe8nVwggrhrKC1VV7W43QdT78xc3f75N4bKj6gNBQ4PJMO/SwQuVS+ws9ReLr/OwHgbfpAYmTL9CLGtHs5spI7SKyMpPLLJL5ZJdk3HoN7i3foNcsqo1ytQVUrz5mT0QDHJPEgy7yA4C6VJfmHbkLxF6QzcFVfxXDuTwU4NzCGADaAmAJWJLqs23H0w8J8yRym+cjb1/Em8mTIVDAfCJaeHUyz1G7w5PTQmZ2d07QRHzUssELB+KC4XgKyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(86362001)(54906003)(316002)(41300700001)(70586007)(70206006)(6666004)(5660300002)(478600001)(6916009)(2616005)(8936002)(36860700001)(8676002)(40480700001)(356005)(26005)(81166007)(82740400003)(2906002)(36756003)(47076005)(336012)(426003)(107886003)(40460700003)(4326008)(1076003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 02:55:26.9469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac82120-4454-458d-702c-08dbb9850b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
X-Mailman-Approved-At: Wed, 20 Sep 2023 05:42:43 +0200
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

When flash erase is called with size parameter, code is checking
if sectors are locked or not. But for checking, the whole device
length minus offset is used instead of actual size which should
be erased. That's why when only some sectors are locked it is
not possible to erase unlocked sectors.

The length is calculated as "length = max_chipsize - offset",
flash_is_unlocked() api is getting updated with length which is
incorrect. Fix this flash_is_unlocked() api by passing the size
parameter.

ZynqMP> sf erase 0 100000
len=0x8000000 which is flash size
size=0x100000

We need to update the size in the flash_is_unlocked() api and not
the length.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Updated the commit description.
---
 cmd/sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index 55bef2f769..977ffcb63c 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -366,7 +366,7 @@ static int do_spi_flash_erase(int argc, char *const argv[])
 	}
 
 	if (flash->flash_is_unlocked &&
-	    !flash->flash_is_unlocked(flash, offset, len)) {
+	    !flash->flash_is_unlocked(flash, offset, size)) {
 		printf("ERROR: flash area is locked\n");
 		return CMD_RET_FAILURE;
 	}
-- 
2.17.1

