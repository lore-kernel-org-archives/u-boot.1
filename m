Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6C3C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 12:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2AF86A15;
	Fri, 25 Aug 2023 14:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HE3dP4F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D25486A23; Fri, 25 Aug 2023 06:57:01 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA86869C3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 06:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCzP+VMHBeiWFlSLRrml2HtH1zmrjUZ/ygpb/tAjHCFlgyORJw5X115tFaQtfUcL2mQA9iJCj39iKWcyePQrCzGhP+eLv6+HKIVo2i+yl9lEXFYZ+t9UcMjgPJfKl0yed4/z4CHKdKRUCVdTHdP5j3nmDLmYXwu2IFOWOqnYBfXDrW8LwRliET3Auh2ovuQkuUSvuTQcuzZ/kUDn+jldgNBs+OYoCW4epwy3hlVINbV0u9STHUskl4grFSxaEL6YcZgWOpccbfMvBbQ5AepXJy9YQmBNs+Ua41B9r13Zx6kUpHVNwLtI2llDc0qD3/Zm5delbcnUF/kelANurUFQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Zw1mGnmBegTjN0G2HiW0bdsunMXz1uHK5YmqosECGE=;
 b=DRXnEzeVD1AByakXDJd7CBsmM98Y/Zw7L/HSuxiuw6x1INJBuxTQ71POgN4ovLQkVWfuZpUrU2rIeAcOJNt7a4kfYLNjvFJH4xhZqsR/OpzMuorCqFU2OvPluIqQTt/54j60x/WdrU/6BjYBmOtDOFbd+f8wsEe0fT3iIbQ9ZjUxkXZyttg0S0xGHfwuNAYJEP7iv5xsO+h2oxMnrJjCBg78/mWa+BZw5R0VZpi3PDL1BgeFyVRHo0qgPfuYHdvhCfBZ5LIuPghAugXz62xanCYQh6fglSnhjfYLWXO/uSqpoisJ39jmg6FgaG1DNJFHBYy3P9n+GPLpoMWJqgqOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Zw1mGnmBegTjN0G2HiW0bdsunMXz1uHK5YmqosECGE=;
 b=HE3dP4F3mZ2fIdzIGtdyODpAelInWc/ReiS3F43fVQgKVzzlHUyQPctYfeZ/K7g8P91J3rihQfRXCWK1Y1idaWXb1C6CGHVoArhWMtixncnqZ0S+7SdWroYlGG4L9Gy/JoJI+rJXZL/ItV8jg1Cc2NQ6wDOQgGXUk98PMWm6ZJU=
Received: from CY5PR15CA0179.namprd15.prod.outlook.com (2603:10b6:930:81::27)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 04:56:54 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::e0) by CY5PR15CA0179.outlook.office365.com
 (2603:10b6:930:81::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 04:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 04:56:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 23:56:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 23:56:52 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 23:56:51 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 2/3] arm64: versal: Enable sha1sum command
Date: Fri, 25 Aug 2023 10:26:40 +0530
Message-ID: <20230825045641.32728-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825045641.32728-1-venkatesh.abbarapu@amd.com>
References: <20230825045641.32728-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: b6142824-bf96-421b-8f70-08dba527b39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHuIsxc9zooxCW+x59KLnd/d71Ja36/67DtrsPK6Ul93Dy2aGOgQBIO6dpGqcM6TDd9Afi3Mz5R9yXqEWpj08DTfu8hQk4iJj63bT+xSWrvq2lLbExowCJ22uxJeA5xH9dJEOeZ0ZeBCYvDddRozQzx1H33VtwvyyiDlMyl7pnsehM+IKiUFv8h9aMapqXdNz/wRtLmwb8HMn14F1W37+wl7/dOmimDJuBTdQKpfFMunIOXxVN3lTlYMwl6Mks9OJxp05ejsJvoWBv6xuN0H/7KBuphuESoIZvpMbPe9hKOZCgcFk0O58Vtn0JFGhzLmAfds4pl/kITMO8+vdfW879FleSU/doyZFhv6cMNkYqtojmELl7UiTuZqBBHccTsSCwa/JemzHoc6eq1w1JLWgbtkYRqcPd1uM6xooFhax0Qkjuz9kQkwArW67JoaqCrVnlk+Rla3hcGOAyXU/SrQhHNV7q3MZ5hwSoV1KcmqnxWyZ9OervuTKXDY+3to/zf/DANo7JXVQg3k3MzcGZUp+mm+ikz+nVhT3Gp8ApHnXbWb3uTEcrRrKFBTyeG0sAClotYK8vLtRS8XoYqyg/hYZ531QeMdOaFNxMcIsWdfZwsZj8CNAkxxTU3GjshPDUlpl48J7b4omGg/1UNqcTubVBHqUr1bS6Yl7UzNiAKAp2lxQi/kGEH+PeIsqQzaylHudPFYiA9uyEGnbgjsiMIEb7cPv7Fr+H6oqlPYxK6zlTupoFkPAgXUA8WBY6+fbVCQHWANpC1c7Mtl7/jxn4K6Fn9XzNQJ7AYE4gtx6kGB40M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(5660300002)(8676002)(6666004)(478600001)(2906002)(107886003)(2616005)(1076003)(336012)(26005)(426003)(4744005)(41300700001)(70586007)(6916009)(54906003)(316002)(70206006)(4326008)(8936002)(40460700003)(36756003)(40480700001)(81166007)(36860700001)(47076005)(82740400003)(86362001)(356005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 04:56:53.7849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6142824-bf96-421b-8f70-08dba527b39f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
X-Mailman-Approved-At: Fri, 25 Aug 2023 14:39:25 +0200
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

