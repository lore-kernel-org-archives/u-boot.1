Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3F8C10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BFB8789B;
	Wed,  6 Dec 2023 10:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zT1X5osj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67D08789B; Wed,  6 Dec 2023 10:33:48 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A281386CF4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eelg0i+Okt4uAVKGTOmYdQ3PcxlrYYaqk5BxAD6+h9/3o4s1wnyiwJ/RKYk1IjyHYbBz/QrMA3yQAgpGZr+e6mcjOIPzQKQLF8s1wmk8snrNEzQRzjpUoT+qLuqnhRZ4rEwkK0+VKbSFtK6XLXDrV09/b1F0qnyPtoqAEe+RxQhRDq/fWPyjNE1u8pPJXNhUM7wg9e5t+/9V15liDnl7IMpNh4FHoH1/fau5Kqoy16EZKcLzoz1QX38VjwLXrvJn9OptgdxV2pHaaJchiFQPcV9y/RQeauf6+IkldNhVjE9W1caxSIhJvtxWl+B5ipcldQh+baODdWZCmrBVznhRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2l5FhzsUA8aU5d0uHnyzBdztUFh36esFtNte5Y0XR8=;
 b=CrleKfgdWxkTu/Zt0KqTEGmssv8by2SnsCgAjGXzKuk6U0gZRNsrEMLgvuGL1MT/V4YmquDZ488UnpCfGfjMunuzisAYAxcI/uE23/x/HVIvYuFxefoUpwzg7jYTCcMp/fWB+LbQhaI7IzzLg1zFAqLmfnoIUigvGk1Z/MdrVn2nNZNNbMCV9oTvRdXtMcwc30REwO770TE2kT3fWulAkodELhcoSiPbZDWnALdEbeX29gthSNuRShAPNJQkyP92rigwql0bzYxf1650Tg9Z3KtLFHnnRqMfR0mXUGy3iIR55jNsoq9XUGcdeVSPWV0fVz5RuRbWjES0vGNPSc53ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2l5FhzsUA8aU5d0uHnyzBdztUFh36esFtNte5Y0XR8=;
 b=zT1X5osjlqKx+nwUw5mA5Lo440iuXTQWYERXY8CTHADPrQhPTSbMxbmMUvsyi+6uC92m54vcXf26lP+VOClFeGQF18nXaVGgJ3EHM61WrxQUOxbyR+p25pcQDD1zSwsAgO6t9SQDSxyUot1z1tygUlQrwkrM+7kND635GaFfwPo=
Received: from CH0PR03CA0402.namprd03.prod.outlook.com (2603:10b6:610:11b::23)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 6 Dec
 2023 09:33:43 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::5d) by CH0PR03CA0402.outlook.office365.com
 (2603:10b6:610:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:41 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:39 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH v2 25/30] arm64: versal: Enable octal DTR mode
Date: Wed, 6 Dec 2023 15:01:36 +0530
Message-ID: <810266c0acfd767c9598976a9faf839515ddeabd.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 653361d8-0c55-451b-fca0-08dbf63e6fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhtZaM2f3Q31zbi+R70K7D2P6MG9R3eW2nUEpOICVUm7fACp9bj0joFADPhQDl3tE1MeASX/yhWR/865BMzR7+nTfV9QWXQG14dJlU0LCBVMyIekbSXUvIwykA/TTHOaFJvlc9JhGw1rIPlPVi9y4bra7THOCjwP+ZACwoxAJ/gus0tmTk22z7hcKYmyeZbeVvnLW06IyJrlVfcEwfL+Xxpo0CaUQGSCRllrznQrcts+qZ3ybx7tcR0kuxk5ie+XWL4Lx/Lp5lbJzjJScFE77fn7quB4l/h6/QqEzHcmbUeB0lXdtIp3mz25jnSs/Mtuwc9Ibq9wFS9I/Vuic6epc7RGJKqh9tMquPZyHhDcsI133EjkUHp77lW/FKW/GJkzW1S6Zj0C8RTOSodzCaDouNH+Ru2Rg5zcmFsRU+igA0ZRAwZJambB4YfFWYok91P1aq8CZ+IqRx4bfOoojaGCJlf1GCfGdcBfv4//t/Rjc4EtZnoWvLWYbFeV+2djneGZOM8f+dApWNCQtRh2amuBxw6fnHPfgpeXIdQbGjB8XTX2E//i57Ds7kGv9YC2FtFzPCy3R01SAPE8Ib94HnIpqN4Obd8KdpkbrL9JxDECI0bFu6YoYPBL3WA/BzTDxNUgzH9x2yB/z1mbJ8OGQvNfUu1f0KD7i0WyRe/7PBSFE/AICjeDMuinIQwcGitlWybxxD80irRvRFBi8raabX3MRxVVbvV41WxGkcxQaVLGvViwKLAa8Q6VqXRmcJRYYSpWYOq614t7pBH00OEFn0/kbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(36756003)(6666004)(107886003)(2616005)(86362001)(4326008)(40480700001)(6916009)(70206006)(54906003)(70586007)(26005)(336012)(316002)(8936002)(8676002)(426003)(47076005)(36860700001)(82740400003)(5660300002)(478600001)(356005)(2906002)(4744005)(81166007)(41300700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:42.6623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 653361d8-0c55-451b-fca0-08dbf63e6fd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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

The Cadence driver must switch between SDR and DTR modes based
on commands from the SPI-NOR framework and the configuration
set by SPI_FLASH_DTR_ENABLE. If SPI_FLASH_DTR_ENABLE is enabled,
the driver should transition to DTR mode; if it is not defined,
the driver should avoid switching to DTR mode, signaling that
the controller does not support DTR.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index ee247b905f..69835fce55 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -98,6 +98,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SPI_FLASH_DTR_ENABLE=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
-- 
2.27.0

