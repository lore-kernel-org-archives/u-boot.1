Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987DEC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F028691A;
	Mon,  4 Sep 2023 15:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3DQJeyC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23A5868CB; Mon,  4 Sep 2023 05:16:06 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005FE86824
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPn/AZGvyOrHjHAQxoFuJ4rhtcncCcne9OVDkdIXkotFyyd9OX3EmaXGULvICrPy8/U3Mf6McoLTQ32y4S/UWpkmS3XRxr1rbhVvfYLjK1mhQ4/cMNr3ti3jYRE9nHHe2EVqsewBlFE2FvRiH9VgLIaeC2eose8lKskSH/iD78mW75oBgkf2cn2LADvyTKp2JOGn3EWhnPRb3Ahsz2nqeQetvdr7aRthfO5ZhYymaNjs5BhmvqoPaPprXAcLLaezHcFcCBUG1lGDWDjmLfh24g5ot/IdZUrspuOZLON+IwYYgD4/hvwTSYK4whFk/pDQAKKsMgy6gjOXT9HRKZUIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K5BwHZkH09M2S60Q5fl5DLUrDbppG56hwZLp+8Geto=;
 b=L+U0KUxVeDyLr/HV06xxJdp/UJCydnDO49qGveJGlbm234KpQ502qatq6OTDxlGk+jFjvqZKI41zKbXa9Xgd89XrbczYDbmTbqNC7in68eBv+kMt4yT9lTOinRHPrGdFcfsczDgWPUsa3jUwRkvIRfrhgpL8KMhUN+0ygUfjGM9edoWw4tuW58kzAnbo2PxpEiZ1Xwq2nVZn41FkZ7yW0WZJBJ4qlJDeN/wnh5Nrx1WUDL4q4nkptVPfJSyu5vWPOglxhSXsY6Oj97FTGe+PRe6FauioqryNJ/znAfIcr481Ef1lhvmZUWYLDZLR8WVMkzNBC5zYDWC8YpkTa2RwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K5BwHZkH09M2S60Q5fl5DLUrDbppG56hwZLp+8Geto=;
 b=3DQJeyC6ejcgQu/97ujiGgVOFZpmhhCZQlcVHxnVwl5bLQjxLDJE6bdPEkyphBki8X8MYjmmO80ZTOhrX+5o2a7qer2jKc1xSZOKXubEdxXjKHmOA7oa6cI0vVeD+4Qpksx3wb5IJKj1WxnUj9OJ1enxlqYxtdzpqcsyQZl+ptY=
Received: from DM6PR07CA0088.namprd07.prod.outlook.com (2603:10b6:5:337::21)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 03:15:59 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::ba) by DM6PR07CA0088.outlook.office365.com
 (2603:10b6:5:337::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 03:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 03:15:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:15:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 20:15:38 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Sun, 3 Sep 2023 22:15:35 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <rfried.dev@gmail.com>,
 <seanedmond@microsoft.com>, <tobias@waldekranz.com>, <sr@denx.de>,
 <john@metanate.com>, <git@xilinx.com>
Subject: [PATCH v2 0/2] Fix dependencies of USB Kconfig options
Date: Mon, 4 Sep 2023 08:45:26 +0530
Message-ID: <20230904031528.11817-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 614ab87a-20ff-4634-63d7-08dbacf54268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ace4/gDr17qiOi53XzHaE4uMlRdrxJGSoJLl7e3Nb0I9riI4yc/xqAjv03xskXtG/lGapfusLMV6mZBHEir9iune8Pa/HzDEBorm3gtx0NnGmtadnkJ/kCucLuJOuXbdmRLuZoYCbYAZrF50LrgzKmtZOL9uGVUkF2axoRB2l1VGtdOVeF+DnU3OqKgXizEYq3U4nlf4zQEfs+Ub2BOxIH5NBWgy7/0RzU/g4yJYclgxMfUogWdIHkQ5v9AuDFrzL5wUWzzYIu0ggi6SUd2RVAleIVXTfzZ7sa3sKq4hPH/br2tvJU2f+hn5kR+8Pe99ub54zYw+/VN6nR+I1pDoc01SCmbLjK5xHCvNGN0YRmc02C++Pv18iwrrRW3j3CMsOJTamWRh9VMJqzJC6LeYyXXYvVCW/J4QuSP/oflUN351QWplTBsoFsTPHuWJAxhljhRaCvYXEuA0467MYrQIkeorHMeCKBsJ3bwDbrnfHHFlOHzl/5I60JY1yud+wB5c5eaBUZSGwPnSE0LAyrlSy991pXAtBH34ojNhKICf/U7F1j2Q0Phz0Mj+mOSKLMmJpT2V7MnNYIgwuRWdENwPHQO+lxanhYdPTcfF/MQq3vcgVOPuKeXXKpd9qtboLV3b80Ebf8ZEmaM7Pg9d+hq47OKUuxhxQd7fZk5ubxftP7Rxj4HvXFn0NRQNMAqvKma2u+Yc22whgPwP0PO0lI/WiKGSPtXi1OJ6I1YOvKdBBrMv3UVt1AkIzrjPhyO2iLb1xqqNo5vDqAV3uqEWrDhcGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(8936002)(8676002)(5660300002)(316002)(6916009)(54906003)(2906002)(36756003)(4744005)(70206006)(70586007)(4326008)(40460700003)(41300700001)(36860700001)(107886003)(336012)(426003)(26005)(1076003)(40480700001)(47076005)(82740400003)(6666004)(81166007)(356005)(478600001)(2616005)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 03:15:58.3377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614ab87a-20ff-4634-63d7-08dbacf54268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
X-Mailman-Approved-At: Mon, 04 Sep 2023 15:58:13 +0200
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

When USB device driver CONFIG_USB and CONFIG_CMD_USB are disabled,
some compilation issues are seen. Also CMD_THOR_DOWNLOAD should
depend on USB_GADGET_DOWNLOAD. Add dependencies to resolve those
issues and compile properly. Also remove unused config CONFIG_ZYNQMP_USB.

Changes in v2:
- Added the dependency on USB_GADGET_DOWNLOAD for CMD_THOR_DOWNLOAD.

Venkatesh Yadav Abbarapu (2):
  cmd: thordown: Add proper dependency for CMD_THOR_DOWNLOAD
  zynqmp: config: Add proper dependencies for USB

 arch/arm/mach-zynqmp/Kconfig         | 3 ---
 cmd/Kconfig                          | 2 ++
 configs/xilinx_zynqmp_virt_defconfig | 1 -
 include/configs/xilinx_zynqmp.h      | 4 ++--
 4 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.17.1

