Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E80C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 04:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0295D8784E;
	Thu,  4 Jan 2024 05:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SYHc+ZAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08AAA878AF; Thu,  4 Jan 2024 05:52:34 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A40877F8
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 05:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQHvIajq3yGmTjs/TdSEhA3UDuKw3T21yGRnGk8CQc63/ajivANx/vq4fZT+53dbzB5STKjgel4lzFfCDmewi9RyGUZ10YlHoiiyvomkg0VFfxbh9q1wnTumSj8vIpZuNZEXr1imt02dccuN0THBztCjuA5fsCmsFc5ChdheZ3EPiDHDd5+SqL6rB+soo57Wr+h4zrcKRwjU9Dny0kPfgFg6LUwjq6lGyy1lwd34enMDYDWtqIitW2O6nz1+frsFedaHvB7VZFMkA3jDD0TJA2zSMb2Ace+PTe5eKGENCFbodkjoahHox5/SkSCi1BzRUPWN0mjmfv+Yk5vK7q4a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mBI9DPAIcLX6HAu0ipr1ZhLDu4VjsCY8n6BLSU1XRs=;
 b=DB9FKcJ2xwCTxtMlWPS0UXN0MMTlqg1JA36Cz8srll7ZmEbEySJnj/NTIS1yKgKj9ucKncJ3F+TzWQNe0bcSPlyHvmHgJfxrx0heReFdHIwsIobn/9HuDvy7t6talUYRp6MPtQ3nRAjV/I73KXbmP940G31GHsg0kXeZvV3mcosFFBPTV+bxKZ15+nHG2RqYux8pQtAi2NK6y6wdNv2Q31o73fW5fFR/2/J+hTzPk82lRAySB1pIffZ6KwUoUCpk+oOe953VldcRCKbwsbbpGUnJ0sExMZlzFavAOgRwzIp234l+gNxsGtCckj/F5JOQAbrXhKhKYNugikyN1YWoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mBI9DPAIcLX6HAu0ipr1ZhLDu4VjsCY8n6BLSU1XRs=;
 b=SYHc+ZASXHQrm289AXbBBrL0vJWVb6+K9tKH/XrvhsBq4XHgatE3L0/F2ZEEGz0BxkMmrmJmJ7UpkwFXRIW/eUVRRACQoB7PrhmAIim7xSjjPFb5FqVUXganYr4spuTYwTD357+LG2xQWy1I4EwE0oAayiHjcm/clW3Crz/wVfM=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 04:52:27 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::f9) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 04:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.11 via Frontend Transport; Thu, 4 Jan 2024 04:52:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 22:52:25 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 22:52:25 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 22:52:24 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] xilinx: Enable the NFS command by default
Date: Thu, 4 Jan 2024 10:22:17 +0530
Message-ID: <20240104045217.2966454-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: ce901c0a-1475-4a38-500c-08dc0ce0f2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuvqJaEC0y8gD6WKu0zdyJlU80/S0w8AVTkPdOzhXVKdc+T7Sio4+BOcLTLfrmubWB0hfojqQBaAB95s5kMCTeaM9pyML72nEA+2A4+pNxcPCzYAMZLAvJd420dkqP0GNE+cWpf9wSnrMMWzXwR6kQJjRRfPTJQLHQ4pL72ooH3lA05LLTpg14+R97Zx76dmge6dDfAuf8A9uBiq5sGB3Ye7JJYXNIXWKZyzQMluK7voZQ6TxFWScerOzwiGY7u3VtlyZytYty9EgdaWKgUoWDgyAKLJZ+M9W8jmQllgFbl3krRwcozPFuv8rjV3URbPOq/sNm0yLj0WmKpIeiUYe6GkBEp95/DWsCWkrc6lMz53zk/kbo0RpQNWwqRSksLfANn8JuAkwwyRNHKKLcPKG/W7l9lrfsn1H5IQM9A/07jWoo9gnBlxwaNjVyrh0yrNB4niaHiU/85s6+et+KPRk6halDOIVxinXH4VkzcBHoX78A8K6cZjj0Gq/fnhfySYTdsDWu7hl2QDrwvN2f8/0AjMQu35Bb+h4TUAA9n4ijdDvTxifzjG3aE0d1fG5IiYmqSbFbPUYQ+7SfRCzzQTsGblP001gheWqj7FJrUe3CkSpTtf0dhch6fen83LS244r2ZNpwY7miW6DgrbZaSqCvm/yDPIri24aFszbYCOvEdrqJgyP29hM+VeaOIkf6tueifHOTN+i42zhOicNR9rrn81dV5REEGFR9MIOZEn5RcyauDsBeHrOFbr/4xI+k4VMQ0HwJc9VhhG5Y7NyH0mTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(41300700001)(36756003)(82740400003)(4326008)(36860700001)(40480700001)(356005)(81166007)(83380400001)(47076005)(2906002)(5660300002)(40460700003)(86362001)(2616005)(336012)(426003)(103116003)(6666004)(1076003)(26005)(107886003)(6916009)(478600001)(8676002)(8936002)(70586007)(70206006)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 04:52:26.4554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce901c0a-1475-4a38-500c-08dc0ce0f2cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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

Enabled the default utilization of the NFS command across all Xilinx
platforms to facilitate the booting of images through the network
using the NFS protocol.

Fixes: 10de12570799 ("disable NFS support by default")

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
Changes in v2:
	- Updated commit message
	- Removed CONFIG_NFS_TIMEOUT config option 

 configs/xilinx_versal_net_virt_defconfig | 1 +
 configs/xilinx_versal_virt_defconfig     | 1 +
 configs/xilinx_zynq_virt_defconfig       | 1 +
 configs/xilinx_zynqmp_virt_defconfig     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 0553ac6b17..95743c0c41 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -46,6 +46,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 6a2c03ccdd..5a858537ca 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
index c3ee9beaef..136b497ab6 100644
--- a/configs/xilinx_zynq_virt_defconfig
+++ b/configs/xilinx_zynq_virt_defconfig
@@ -70,6 +70,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 239bb1f5cc..7192b2301f 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -82,6 +82,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
-- 
2.27.0

