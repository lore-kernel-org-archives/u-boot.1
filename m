Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB30C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80B6865A8;
	Thu, 31 Aug 2023 14:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vtC+uLee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753AC8655F; Thu, 31 Aug 2023 05:26:47 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E4C805C1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2UKE3T+TPjQFJoTJ3VZWXJ2Oggwv/YFE7wuNG06RnKsbk0RW11A6zk3M2QE1msfBHOdabXoj8k7Nj6wdQ3KyO5ML7fqorVhuk7Kuxd6b/xRCXQ8Nl/phCVx0h0wB2pblbjKzF7IQ0IoZZu0PFYl5izeH8rbBSX1As7w50Ykx33/Tv5BL1arKHLBRljakoW7tR+F8vDOPtNdsoPNl6XavTJ4lx3SP3czQSxxS0K4Zvc9USU6kYWmUnGrYrRfJxAk0D1XyPwoBqA8h2Z0Ra/pleB1HGE7etIyHmbEVolkLmVRxwFl8SIKnbML8HyvcmdcOJFACuCrGfr4lLEylvQ8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zw1mGnmBegTjN0G2HiW0bdsunMXz1uHK5YmqosECGE=;
 b=DuZpnWh/6vAe27yb74GpTmT5hiJsHv59NbypkKA4BL14Sv4y1ags7RdoIU0uI1UFHFJR4iJKbmioVFv4yrYW+omb0PCiLUGPkgIEKpGb9uwt3yBAUl2asyCLj10SP3sV6kv/oEc2m1QNf0Tx5XoDh3yXckyDcwffkpqQJGCVPOc/w2h/kg+ryOqoFaeIAK07LkdCxQ/cVG9yY1DoyJQAAXEVFgK8IjsJXCOmOT/5fkrZ0KhkRhkWtPVOlS+XK0mXWrP3Xmcl3mvV/VkfPQ8WWOYbzK6A6wkv/V0+KhrldZdGRq4WPcnnhUM2QfUfGuKRtiLzRaQHMBE8fDJ4VGUHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zw1mGnmBegTjN0G2HiW0bdsunMXz1uHK5YmqosECGE=;
 b=vtC+uLee9/85XgsBfRgSbRJHs1IJkaozwxo9766oRxI+ulWQ+ETRjw7eWUJlz4MCTwnKKRZdrcBmNHuHGjWRmwaB5+12bb52mTmypx/6GQTuJYNB92cQU3rW17iiYQSMHc+UmTDq88YNG0nw4slMhWPNh6Y4fNkqhv0iwJPri+g=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 03:26:41 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::be) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21 via Frontend
 Transport; Thu, 31 Aug 2023 03:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 03:26:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:26:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 20:26:28 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:26:27 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2 2/3] arm64: versal: Enable sha1sum command
Date: Thu, 31 Aug 2023 08:56:11 +0530
Message-ID: <20230831032612.2729-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
References: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1db546-545b-4bd2-f802-08dba9d21794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McYyOnBQo1B7rW6hze2Xbid/t/iJCwXhk++vGyFQypHHW+0tYAFsfEC5H/vZqnE3zRpyGwgV7cDhjoS36MnZAN40jyEnAx35+HNtGZ6iM9h8icz4Igjvcqff2cHiIpNskzIeVVFzemKGg9ZY9e8yKBqyVQxbFGUOSgnvmH9374FNuVhU9OCGalgQCrABKhfY59ErhiJzgrOW3OGcQ6KUnIT5roVA7WE3KyGBtUcGggyivg8kvw9qRrxUNT8tz8Hw+wdFxaqj6jlLP81DZl70kLfRT/FhCEW3lKqjvKNtEL5QbXdW2y9oail460A+aUUB6cHo95tcBoa7TjIPLOazdXo42vsLXBJPc/2Dvzj0jHlUbFOhO7W/d3s39GbZxOYUIjWtLefX8MOGwnZ254jk1mD9ptK+QPEGBOU/mLQgNdROgVxRUfoYeV1OtDPTGBBbR3n9WEjBnNiiEb76omF+BJagO03IY1WSGS8nwTqvTukv+2PzsJJkdbGqI3a9tlS86kuTJ88O0p+ruU8BoxmJFYGfqVbKLpfAvnRxrt64uq3oXqM7dZ6YNSRzsFXaWPoheGABe/iYWySx2Ap9Xnau1+OgxFfN2KBmi4w2Tpq+mqbwXJ2Yp4KaAOy+biCnVmfYTVUINh+dojzBrcxHxzE43eKpnhw4U+VqBy77hG5GaLL01l14RtdQ9aQudxAeTGWg5Wpqrm6Nd3Oo56A2E0EhCo6IZZiJ9ZI3PL2ndP/mWLIckVssNUg7KgleEe4tkcFjv+zXmKpXhk0ivXRvA+rvpme6HTStokquWsY4RnVR2Hw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(451199024)(1800799009)(186009)(46966006)(40470700004)(36840700001)(40460700003)(41300700001)(316002)(4326008)(426003)(336012)(2616005)(2906002)(47076005)(86362001)(8676002)(4744005)(5660300002)(36756003)(1076003)(107886003)(26005)(36860700001)(6916009)(40480700001)(8936002)(6666004)(82740400003)(81166007)(356005)(54906003)(478600001)(70586007)(70206006)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:26:40.5515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1db546-545b-4bd2-f802-08dba9d21794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 3bca89d27e..b4082c3dee 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
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

