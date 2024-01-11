Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96587C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CB187776;
	Thu, 11 Jan 2024 04:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qwunNlz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E322787776; Thu, 11 Jan 2024 04:00:47 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE641878E5
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLMz7zjT2AvPVcoJZbPhoQWwrVStpV+v6qgHqvdfMuxle4CEf4RRYhV/IXpUObpYSa1rMWiQQ3jMGbHE7AX3mDN0Ry9kd3T3rpGSxbDsg6d1vjQd2K15vHoCBIfENJWmhFSDbl1/ER2a0bOxmE//9mR8NHxBpUWi/BT+KcANNB1B2Q5R+qL2cKswrCzJlvI7aZuI559KCqDJPjLr72TE66cHhWjQqnAwbZX++tjJszh7TYLw6PE09HSwDi4xElxI0Z+nthcyBi1HyXfBIaWI5zYxe9Hjdj/aT99/yfQwN7vTFrRe9QQgJjK98GD4RpbmtSjU2zue9GeQotmoje3Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbbQxtHBwvF1uZO7auR797OHmeUwGQ1HyEH12Lc5JW0=;
 b=Jj2sAX7azPWqTX1KNDOMez+Enzf970zcSW9Kczyy+GPTYrJ57RhEWdgnKZJtbC2pP49Lrcz0AR75TXB9V5QhPxXn9kvWZD9N02d/9aHoYcU+1TZbR5jpb++BMlcSrBAKBmplc3k/D6wdBhyxoVH7FZE9SRFf/bh+ATm6vJfFKL+6EGXuZpjHh7UdtCDG9StEn95YcNHir11PL0cp8Qu3Wxc9txOYpTbjcWW8iCInsRK9HFGJZ7wy+iRV94nnYktVopdiRYFIEmDi9XlDBP6KxRnJVwV+P+yIjAyLgZ1YSBqjlByqfDRg3BTpwzPYeDbzbrJ5BN7J8zAf7YMPQe7rBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbbQxtHBwvF1uZO7auR797OHmeUwGQ1HyEH12Lc5JW0=;
 b=qwunNlz55cUUiOGd0DJH4NCpO4MNOg1XjeFLLm/htVcld4ZlL7g1CbmYUmI6M95zKAChxei/BWW8Er1Ro7Q7fPtnY5zHDrt79ePgIN1okfNXnkxBSOR7FuTikAl2ZShT4YWs01A+SRVCb5GQhIwRfkpd1rr+pEX1QF5xRz5T6bY=
Received: from SN7PR18CA0003.namprd18.prod.outlook.com (2603:10b6:806:f3::23)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 03:00:42 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::23) by SN7PR18CA0003.outlook.office365.com
 (2603:10b6:806:f3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 03:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 03:00:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 21:00:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 21:00:37 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 21:00:36 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] xilinx: r5: Include the sys_r5_proto.h header for future
 use
Date: Thu, 11 Jan 2024 08:30:29 +0530
Message-ID: <20240111030029.2565827-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: fde4d55f-21e1-4ac8-c6b9-08dc12517fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saVVXR7oIzUP6bvmE4PQ9z4bhL5IhCPkos+8RFAfMK/kzia/fV3Kmw4bEJE96xQ/HYt3DT8pV9cwvjJo9ILQCPNR6UkoXc1cWSCyoGjjp5QklYkgPfXtj7sl2qEmzVpQRGtD4w/Vz4ThY7F3YQOn3FiLjxSTq+iDeSlob4EKYTJTsaeUG4hjaMiBGyPz9R0aHsszQ4x3/kDxdFrRQE8tyFMpY2X1tgixxgkboHIvoMaSyMY4z2lcucn8zhdNQ4oGP2sefub/wqu0S2jQVOpjZTXd0dLotvizH7QWyVMdTjylNGQV1qqE8+Vyss8Eraf3mWdE8DbMvu/XGIXqjZfJj2EYMVxYW5I4IqwMj5lM3L0Z+xKHbTJgcGVQFMhcH6JmKwmpzHD+aO4XN6LR9vA4wN7D6TZNCMijpOV3JEpGSC6LUTNDMK3NUHsC98ypgLQc8pKsLdS4yGczUDtEN2xCId6yjRN5r4KfQLKbA9RsCU/4g1AANnvoAmXuFnrvCtaZVqrYqIBo6s/zpBzx1YxTZ/zaxStwMZKuPVPfcnVUn3WciFUJIka9XgKmiCw2A3v3/DKR3n2ldSJH8dSqocwfnCOdpD73MiEKetoGF2IENLMTQI0ZmZ0E8sClu+L1nNe4Xyk7bN3TzhtNQsXjWLbteYPLSUNpaCfzF7UUxwoDDZPq+LMdYBzcKsbSNubERhqoO8UXd/XuouVMTTnf5MIRmWiPC2AedVm7Mkb9KNJJQ0E64q0pyw+mRfwhVRu98I0LB+lhPhbiNj+BCAd5AqIlcAWx7tZjpIIOGp5JCB8JFGJsKhn4fJKga2PSf102qoKJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(70586007)(356005)(36756003)(81166007)(86362001)(41300700001)(70206006)(47076005)(82740400003)(36860700001)(1076003)(336012)(107886003)(2616005)(26005)(426003)(4326008)(478600001)(6666004)(2906002)(316002)(8936002)(54906003)(6916009)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 03:00:42.2954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde4d55f-21e1-4ac8-c6b9-08dc12517fae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838
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

Currently when using "W=1" with xilinx_zynqmp_r5_defconfig, getting
below warnings.
cc1.real: warning: ./arch/arm/mach-zynqmp-r5/include:
		No such file or directory [-Wmissing-include-dirs]
Fix W=1 missing-include-dirs warnings by including the headers and
sys_r5_proto.h file which can be used.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Fixed the copyright and other minor syntax issues.
---
 arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h

diff --git a/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
new file mode 100644
index 0000000000..0f7a47bf24
--- /dev/null
+++ b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ *  Michal Simek <michal.simek@amd.com>
+ */
-- 
2.25.1

