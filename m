Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55C6C47DDB
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 08:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2F087BAD;
	Fri, 26 Jan 2024 09:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3gSwrdyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D718387BC4; Fri, 26 Jan 2024 09:12:55 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3338786E
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 09:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj6k/g9auhbMSjzrBvP6GiVnQ/Qv6NaVf/1l29For52Pbm372eudLQyDFnaykxLv7KfsJSOKxcboqpO1qexlD3N26uxKKHI3x5OLJHbztFGvfy1k1xslL8eJzMnm1r5LbrDbYZqIJ1ZLLWXeECzHPwX9n8jpI6yRtPmP8EHSNP0nrENdIr+NLXvTQkumvOrDEeBvFU7+950EiTOISDID2Nr693WOkyq4jMothQSRdfr9vmc1Qc8EX/FGmxNdbTx5J3ccgUy99ytfvZBt/pthe7mFvmYb6t90aDbz3hRGhoncc1zF0UpWI6T6H63p8ErxPjfIXyISed1+gRoGLhI98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hxsPOfEq0TQEaKg5Mg41TgDcGLHFr3Qg58lSsNEdAQ=;
 b=k6AUaYkJLUJybyMmL25XX8QXWlxersFNylnU1JuJo7/heftWZmjaCkTtzlEM4icdildelX+UFAvXfzDNvP43oEEHvCp7n2JontID+p+DEEk5z6noUZUZTLQ5k8iYk8nLUFSnsV1pL86nH1cOuPGbK8U4crYZQVOCon5/LPv/1o7dQKY22eBR1V3FBhq2yfwJ2SuYdRrodgkyZoBfXLmbbpMRr8tLjeHcdt+fhE/c/N/yib/NUJcznt/Irps8ETkRWEmAb4Pv4zsBOtr9VkA02uM1LBiklWEWOHQ/sLjud+rc6NG5WmpvIXMaqJfsTaxnavFSyR4uzjt0kawyArYbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hxsPOfEq0TQEaKg5Mg41TgDcGLHFr3Qg58lSsNEdAQ=;
 b=3gSwrdyZS5ymNjd9QL3MV5pBpkp/kwHyojvUxqyvy2ZKe8I4H2CLA0p55V8AEXd5IHx5dmktPQC5Jknlnsu/OtWrbDcmP0KDnpLuCn7W+pDg831PEqgfOEAy1EZ0snbQnSa0l6j43DU5X96r5mWi3gTBJCNcoIm6fp/rBrxXE30=
Received: from DS7PR07CA0016.namprd07.prod.outlook.com (2603:10b6:5:3af::18)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 08:12:50 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::12) by DS7PR07CA0016.outlook.office365.com
 (2603:10b6:5:3af::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 08:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 26 Jan 2024 08:12:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 02:12:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 02:11:47 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Fri, 26 Jan 2024 02:11:46 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] configs: versal_net: Enable CONFIG_LTO for mini qspi/ospi
Date: Fri, 26 Jan 2024 13:41:39 +0530
Message-ID: <20240126081139.3210211-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 474e04e5-c944-4b76-c03d-08dc1e4696c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xb2D8wgp9exDXyrkoH/KdzsHd0eXhyEFoWz9PzG1RTsrVBGXwWRp5MEUzRjQkUWw9unG53muhVGlQ9YaPxtL0Q8mbvhYG5wgfxgY1fl1vssN05Kr4CqnKLa8CgXV84GhUUU86OT650hmm0FBXHbOw+gEqyXaOGnrqr8AB/fK0lhgPQ+gQx2K+1p0Sni/N0w2ZBEW3ArL57ghWvLaKlvlADNxrfc/2ZcyIDyq7rxPHnHVzc8woh2xYL1/L5a3z0DNBFha0lJVfP7OpWnKGcxUNoXO6l89JsjmFUMnDXfEbnwu+or4whbxUF55YA7YxLK397O68qQfyRMi8w9BOKa2NoqS3ycGot/6Vpr63MZd2px9bxGvkhCoYZX1Id0BiEXCW2fNf8C8DzqVlkHG9tvDmz7jAeeeH5+zO0sbPkS3w8grRBk4BRSvsjrjH/4V2VOx7QpiZ1cY2zNQ/c3pk3T1gCpWeuZPIJ+JzTwPhae5NNQ2PCtju1iBxvN4biz9JEpGso+QtCC+Ia6oFng/GZ9fXoXkt4W6srwUnGMQpANwlif0q20H4pl9CLqjORq39k2c0iSBc9d+vbwcQNPKWWsmvp3nwmf+cBaEL1hn/0XaTuye+KIkoQpi6SYyS066zIUhJefAnZJDrubP2fEQSHQ7yDW5xjOCd7+8mLAZXuIbRd/elPjd4Fh3Wo4+4C/MxoxwSEDfYxKBiTK4XnUIQWbEguqdF6tGKmb64vPvSpyBueE62u1BH/xm1cX+JTjZ6YpOP78D5K/YkAxTvBWpy5AiTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(2906002)(36860700001)(5660300002)(36756003)(356005)(86362001)(426003)(4326008)(2616005)(336012)(26005)(478600001)(107886003)(1076003)(6666004)(41300700001)(8676002)(47076005)(8936002)(70586007)(54906003)(70206006)(316002)(6916009)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:12:50.4810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 474e04e5-c944-4b76-c03d-08dc1e4696c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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

Adding a tiny bit more code for mini u-boot leads to a OCM
image overflow. Fix this by enabling LTO for this board, so that such
changes still can be made to the common U-Boot code.

Enable building mini u-boot image with LTO, which results in about 8KB
reduction in size.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_mini_ospi_defconfig | 1 +
 configs/xilinx_versal_net_mini_qspi_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 5f42243d22..d78c9f8059 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-ospi-single"
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_LTO=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_AUTOBOOT is not set
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 4fa83faa40..b0567f857a 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -13,6 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="versal-net-mini-qspi-single"
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 # CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0xBBF80000
+CONFIG_LTO=y
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
 # CONFIG_AUTOBOOT is not set
-- 
2.25.1

