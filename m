Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EACC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50AAF86576;
	Thu, 31 Aug 2023 14:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DU6JDkr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF01C805C1; Thu, 31 Aug 2023 05:17:22 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183B78655F
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHvRJ7PHOFpNsGeXFxoVMXO5SkE8oz1wLp+DCGV+ShC2BOHbSQ4foTcefvxyDUTwSLnPDO1muuF+Gs9oYROH2GxawzQ1Fd8Rawrx9L6S7kcHTDQWnXvXortqd+RmmSGSIz07WATBgOxo3O2pNZbswHj6ev/rGrLG1Ox/zfcC6xdsm+NEZf8zzC2HYHNlM/HY9zDPOQTywW0S6PhfXgK7P+gXiMvZCb4url4g6Z43j+uuFIDoiYrKFqOFvz/8ISy8p3WdiJiawKthUjE+TnY9nrrTe36cP7FLhfI/JEVzBuxqJvw7hGSQxu31zBD5Te2W6TWv2t0jifGDxip+v0BeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zV9NGk1Nc8R7GbfQaGun1XDzgLhYlKm6FBZYhicNXvw=;
 b=FyaXOisbU8kUORxJtuZKee6Q5glUBGZ/xEAQLJXSsraHkQ/i8P0gBqoNrMfs/1oN6rw2qyoGbNnXt03LwlPVZ7O7smfoBAupygpimrUYFgzyYWNedmr7uebSkLwkA+ph6sVlXsd1rmAqu0bmjF5k1aYgSx291U6LO38c6Y7AT5UUzN9vHIriB1cJhC6myQoXA8DXxFPMO6ymmMNSwtJ6eRc5UuNRARDSjCr9zCiOA9h2P2FcvaaMUGCaMyPb7UmSuYzd+55XQJAol+3AXvJjokZs0M9g/cEuqvSA96R1xq59uMcVTy2tQlgqKjDoerwJWQ8avsqeCI01qtlRgA+j/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zV9NGk1Nc8R7GbfQaGun1XDzgLhYlKm6FBZYhicNXvw=;
 b=DU6JDkr89RGGHZAcSNpAvitZPVw7HUDqQT16Sq6HoL3uT9gbbl2eF4MgMgDMItxIpBkPN3wQIL/eVoJWW1rAUhEONYLAN5p9AC/XV5r4yr87SWj1NgqcMDGEgg/RZVH6Dz7V+Wx82q/TggSVqprsXsa9sj4vrz42zzJdsCFUnBU=
Received: from DM6PR10CA0018.namprd10.prod.outlook.com (2603:10b6:5:60::31) by
 BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 03:17:16 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::77) by DM6PR10CA0018.outlook.office365.com
 (2603:10b6:5:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Thu, 31 Aug 2023 03:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 03:17:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:17:14 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:17:13 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 2/3] arm64: versal-net: Enable sha1sum command
Date: Thu, 31 Aug 2023 08:46:57 +0530
Message-ID: <20230831031658.2203-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
References: <20230831031658.2203-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|BN9PR12MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: a2579283-419a-4cf9-6a4a-08dba9d0c69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lh+dMhIUPRjLmpTCzb+kT6WKpO+SaazEYtbA3w51QbeaFh69DtR6VZXbnLut15s/5y1FgSLyVUxvtVv+Tc10LCCP//bDvF3ehbtnYlKObV7hRQ8gJ4i6lH+wycOblq6lrzxnzpju5EgfdNVGqqB4ZgNV+Q3AnrWq+lz0nq+16O7DGn9p1Yqi6wnNPGiHpA11NrIWjq4z6nF9/gZjYCWQY0nfJZqZLU77TdqemBvGKEkJyMyqsiZaovLK+ZRJzd8peSn3gjMZ9bQ551nCxrQ5vBTjE8v61CPrTF2plHFuy/YsJ3faBoX8vUERHbrWM+BtHyt6thH+f1z8gs0mwMHFmXvUJ3cTtFvg5j/zml8LCRaG0diNL0xthzUXPg7rvwSGhm3lN/R/SQ0opE3FyI88UC8qV+Kr5YSW2PzMlH7JrPt6OAEL+9BYkIvPZGIw9AChWvoyGPZTPyr23qIQqtNkM4NwIw4X/z+m1s0EjDJzMZ7LWg1tq5/Q/O3OzpMUq+q/ATncl4Abwvk3FRCIYwvhEWw1gj3zuIHDP/4eVmFWJC3BV8Qx659LH/q0/fNVR+5y6kYC83TtFKvINAzz9yHmU1XJrV7QJlbZUfb/senv7viz7jya/hqNhedjhB5mMP2qs7U/A3+JI/yp8WehiDlUAS1c4tdTRAvJ5VBMjscpRp3SIKPZC9UXJPDjX2WUqC+iBB0KDUlnR0aHAlKWqx+63Zm/kEA7mQT2t8/S3FTMexovKWIJw+zM24v0ShnOn2KmjVrAe67lvt5vgpmtltVkF4l+X/uwFH3fbcKZQ1T3EY4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(6666004)(478600001)(1076003)(107886003)(2616005)(336012)(426003)(26005)(4744005)(2906002)(6916009)(54906003)(316002)(41300700001)(70206006)(70586007)(5660300002)(8936002)(4326008)(8676002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(356005)(82740400003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:17:15.2863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2579283-419a-4cf9-6a4a-08dba9d0c69c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

Enable it for TPM usage.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 0510bb4cf0..7d1ca8cf27 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_CMD_SHA1SUM=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_DM=y
-- 
2.17.1

