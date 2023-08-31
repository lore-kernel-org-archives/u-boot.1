Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CE9C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD59865B0;
	Thu, 31 Aug 2023 14:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b70547IW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD79805C1; Thu, 31 Aug 2023 05:26:47 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AAD786554
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6NVKbtgXUOYfhHANiciLB8w6yhV5Q7zbbEwL39oc1iuD4mwB1B2MFxno/3xNZThe4Dj5UHr1MNhlKPvr9+S6IgeS3mA3RER9nwkRI8S2JiSoL2WeIQEhm4x/YxEVt7vajct7U8OgPKBVrrLyKAr1EOdiPLuWP0Z74b4P2Nsr4i4IEwY8Tiae0yyLQZfcyvO8F8+UvI4RhbHlZOHKnDT3B/soe7iO3AndigxQKtS46RpeNYAIqJg8/ilLW5tv6+Otn+xTgJayyZojAjuuwY+5dgRrY6v9/rcG/xnVgFe89GZlxirowA1SrNSvnKDwgLs5dNWqy7iNMPFlxhl1VvHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG7wiYn3Jg9jxs5S/lVPXXUscz9JSvAfAO/XICO7a2I=;
 b=nCblG8kB3XVRNENT2jY79DONVU2dJdQOpbiSw+U/FUOnMtcMSBGhdQjMycUpj9Q3sbeQ6dph7gBxNSaJuUmiAmmgRMZwGJRduqfX1ykWoQZizl+TxVUYdLaGiwXX0aJ6iL9WljeiXM403xR/U7nkkLDEp72vVh2hTfT6rnm/8xUDDONXAHBBuIPuV7kH5YGr0DA/qFAiuyGPaGfdl77V8pecXuJ6TwVU6YOD8yOQmFjDgehoGEQZhGWWBxK8k3xXPv/Ak7i6J4qw5THUbFJriMrs17Fg1J6mcRlWbgLtjEA7V8WKYFGOwYDM2BwXyGTsNe8YiAlrZeZg97QCjJ3s9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG7wiYn3Jg9jxs5S/lVPXXUscz9JSvAfAO/XICO7a2I=;
 b=b70547IWo5B2Ixg6lxA3xP1ec55dB2mKRxVbm+Ev+tk6mhqPxFPIAb8da8k2fE9qockS8xPWR1ZWGkJQnIFwt6ZTy7uw1O13sV47FpCcysgq4+N+nb4mP71kwtKRuMlJyYtFOI/2UWEZ5+0juu204mKzmwOV9jOhpOYdBR/tyTI=
Received: from MW4PR03CA0158.namprd03.prod.outlook.com (2603:10b6:303:8d::13)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 03:26:40 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::34) by MW4PR03CA0158.outlook.office365.com
 (2603:10b6:303:8d::13) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6745.16 via Frontend Transport; Thu, 31 Aug 2023 03:26:39 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:26:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 20:26:27 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:26:25 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2 1/3] arm64: versal: Enable TPM for xilinx platforms
Date: Thu, 31 Aug 2023 08:56:10 +0530
Message-ID: <20230831032612.2729-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
References: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 11845630-22ad-48ec-ee2f-08dba9d21705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkOdhMLMcZg1jauc9nugoYB4DrnrTL5M6Ip+fHfTG91EhjjpKJM+gbDAOp9QIjIPVwkvdtVfuflqSax2xPwhgo5X/fTOim4BhnF2V5qi9y2zUpQyxcNLOEI6/0PeSLtl3ED2kIZ4DXz+n2tbzyo4yDXZK0REsK5+gSVWBVZYSHETXfvy3YUFwvXjB9U7eTvPto8GdsbLsw3vqPYVHZnyvS8gmOCj3DfVW4vvRGSFTvo4IWWI2B1hVOWlsnhfquOY5Mx7hPuc8QtQBcG0Rm79tkyoSCxInYIGUOybpDVoWSuVElWRjzXYl7sjPUhZDc4cYx7C86O1nUa5XXJJpC4+vpcZ3Mk9X6Rg1tZ2Ym7F03XCfYf6C2HW3P9GySETRGaOdto6EUpFUY8Gkw93zeBZwDx3bV7HYUFv8aZUcY65J9bsi/b6uA5mmY7WHpgz2a0ZQqPjKrhYmrYYSNSO1BXBQ/gAcJx4vTeZpGg7jZ492IOWaE2ZCOXGur8g0KIPEyNHzDrXef341isDr6nns1A4o+n3QDbsZKtkBs/Gl6Jten3BSCRjLMyXM4Z5NWiIvIS3GAuKBj219OejyVcKU5+80G8/96uGQvCRF7xIxhggv3xwgiYFVORG48TVVlj9KTXmRogiq8wjcne+4G/vPkrWexrAwss1BPDWdbulRUhCbfzuV/UvVbGStLqWQ3DINWKGDS9c9jaO/dH30MaoYfwjC1dpTgmyX9/W1O7jOaCXl81DvejJpjkuHHWe+r1lXwWbNBcvbHVjJK6ff2qeJA6Lcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(8676002)(6666004)(4326008)(2616005)(86362001)(107886003)(40480700001)(82740400003)(356005)(36756003)(47076005)(36860700001)(81166007)(40460700003)(70206006)(8936002)(1076003)(26005)(2906002)(316002)(83380400001)(478600001)(70586007)(426003)(336012)(54906003)(5660300002)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:26:39.6140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11845630-22ad-48ec-ee2f-08dba9d21705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140
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

TPMs are becoming popular that's why enable drivers
and command for it.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_virt_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index a1feafc49b..3bca89d27e 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
+CONFIG_CMD_TPM=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_MTDPARTS=y
@@ -114,7 +115,6 @@ CONFIG_ZYNQ_GEM=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_ZYNQMP_POWER_DOMAIN=y
 CONFIG_RESET_ZYNQMP=y
-CONFIG_DM_RNG=y
 CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_XILINX_UARTLITE=y
@@ -127,6 +127,7 @@ CONFIG_CQSPI_REF_CLK=200000000
 CONFIG_CADENCE_OSPI_VERSAL=y
 CONFIG_ZYNQ_SPI=y
 CONFIG_ZYNQMP_GQSPI=y
+CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
@@ -144,3 +145,4 @@ CONFIG_USB_FUNCTION_THOR=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_TPM=y
-- 
2.17.1

