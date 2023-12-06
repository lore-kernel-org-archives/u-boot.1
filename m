Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9273C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FA78764D;
	Wed,  6 Dec 2023 10:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GuUofXxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABAB887630; Wed,  6 Dec 2023 10:32:18 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 723F18753C
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UORcoJsfvndfy8SMmiEPAcfgprHf0SmqksRODoAPahXxd3XoBISvt0rL6u2yAPpjwP0XWhNzAx0Ek0ilMVVkJSzg0Ra9argSFJ4gp4gguDOpnNwg56/4O8aDIxDkpId8jdWiMTsfwafN4RrbXjPNS7JAX8tfge9MeBrwLfjLdWSiCU97HhqdNLNGuSpREF4bT6QURIcam9x9hvFjhihxGzpiAjyyVTAJLmCHKp7dAf5MPzQS1Am67SR+1bTCb0neoitB9f9Sas4j+Tgpi+SmRqpWCp4WrrrDjWPimhEUeGCmZdc4UtrmyDO7zo/azt6r6h269E1WA57v/ksjjjgv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3EQGPJlUUXN1TmTgPut+mR6jFDIQNHbaVZtkjbqmqw=;
 b=n6Ja81qPTH2gBTS0EMwtnz0CXPy77UJueI0gn2/5qlLzdsTAdmlX6gYEsxyk3RN+s7povPuj2VGi35Zh3ADq1/8swue2uaeRv1B0kd9nADFRy3dR6R80LwZ/65hebLBu6qQ+2hPXRmRqTz9Xnx+oHlyUlg8mbItRmMKj7lt8mRQHQI2xQWwIY9YV9A7UWP+Vci3ER80E9hitSOlBHmgWyo10+1teN87MKYngNHbZrj5vGOA+mn4FUkO6FbzjWkLOJHfxrAknU4UcUI+LiiunBgQreYnes+SxnblsgpxdNYWeICyWNV7xKHGXkgNzQCTOGW7LjFH+3LDypr/dh/CkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3EQGPJlUUXN1TmTgPut+mR6jFDIQNHbaVZtkjbqmqw=;
 b=GuUofXxB+kGHOFJlaABCl+/nzVXOD9oWjwWM3qGFLqSnM69LEAiRS0CFaTu/sVEjJaeSMoBR+hPeEYYRun5tz2zzuNV+oIJKCjBx3LXjDkQ/+5oMWj2TN/VtviSOnE2Lt52AF+j9tBo0qLHfrtWu64MpuwKAXfc9h3haz+irEsY=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 6 Dec
 2023 09:32:11 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::7e) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:32:11 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:32:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 01:32:03 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:32:01 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH v2 03/30] arm64: versal: Enable defconfig for Micron octal
 flashes
Date: Wed, 6 Dec 2023 15:01:14 +0530
Message-ID: <338f4590131b94517c49b26190499e3cda7a8f7e.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b3fe3c-37bb-4bab-cd4a-08dbf63e3952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpzGEQ2ZXwRLKySqd1bL6hsQoCiWapo174fFQbPgbqhV4CKIJXDCzN+jyFHH76ummmduB0FcvqdgN3Li3V47gEqyfvI7A++UEuIQFk4jO3vJ962e7c9XUDWzzUbmKOd8uJ7BPu+kMJzKNge8IqhEfsD6BZdUiKHnViRL1bV0VuZam3402VaveknY5rZpAUm6TFCyHSbOLrfwxRiXuGKwbAqpH5vzTeBDIBljswrWGfYjD4qwNB2/xuV97Hc+0zzx21qDm0kYCDI4QQ4zbU/9Of8VDTOmpHXxK5uJGhccqt3Oc5SbtdRbkB8AmpqX7Tml+PDLlmRAu+fHJI/ab/5bZOcjm22QNe4lc4pk437lyVHhAAuWpD5aWH+bq7Vl1Pc5xYJ5Jkejk+dfrvBkoMcui+Fi5lE7NCeclILYRqmul7jFOXLmBbioLY2mgijI12ArLUw7bHZfxDrMaf9HuSwtBWSnPkjyH89hjjJY7Bqu131tYXbe3Bor5k3MKbDvxMx7qNb4kqZIWitmZoa2eFduzVJ0+f0dHjSabMR+A9vjarAf/INuuKLj09CMQH9gKWUgyrZKkusdM9F9/QiseMVrLzh9Yzf4dLe+Th1uTWf9yVgDUFWbImauZPlniwxUegHjYqRQzEMf16K1PS1n7jIvhI9phsuWm2YAVH3k6i4gDwo3fKBeFlZUORFPjiqegBNlnk/yW1PpggsTZsY5Hk3Vxx0IvFFD4hbEiXqHbwrXmKZcxnZQO8eXX/Pc3qOVvwWgmlysGdJbOGfEMHLnVfQ1nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(81166007)(83380400001)(40460700003)(356005)(47076005)(2906002)(5660300002)(26005)(2616005)(107886003)(54906003)(86362001)(70586007)(6916009)(8936002)(4326008)(70206006)(8676002)(6666004)(478600001)(316002)(4744005)(41300700001)(336012)(426003)(36860700001)(36756003)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:32:11.1783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b3fe3c-37bb-4bab-cd4a-08dbf63e3952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

The Micron MT35 series octal flashes can be activated
through the configuration option CONFIG_SPI_FLASH_MT35XU.
To ensure their detection, enable this option in the
default defconfig for octal flashes.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 6a2c03ccdd..ec7caacca0 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -95,6 +95,7 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
-- 
2.27.0

