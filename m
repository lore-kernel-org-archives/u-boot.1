Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C05DFED9ED
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 16:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2E583F00;
	Tue, 17 Mar 2026 17:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Th+/+WC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D5184312; Tue, 17 Mar 2026 17:26:43 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8272283F00
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 17:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghr+sNB1Q9cnedgjzhC51pwuFFAF7OqhrovZuQhy8kiZlVWrG+bjmp7wD+eQt2o08tAlzJoE++l7bxx/BrRXyCJxV1s7ubOgGqU/DkYPKwH2xJ+q5cHNowjaSdmbH9w9rVzyxLI9schbvuZCl4nRGDbbMmH5aAPNo7Bp0xiG+5Rop/zxW4NZSzGHZ0JhSPjUb9erLJ+vVWu9aMe1B/Gtf+JdimYOZVRBn9P0xeX3Nvx0L/kd64dNFmAPobiTSyArfJdKrOpZ5aHKYs2EwqgNiBJ0UD7GhUVkx4OjbXLH8ByKg1CPF/emECyyFK6U/VxrSuzGa5bRV37+6f6x0SpEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CLVqvaXYeP7hEdNlRW0VxpG7uaH9U3LLbeehy/wZWg=;
 b=ZdRyzUyFuQnkhwQa2TfEsqiERDCmUUupn+1wTBRceDFyNHh5W5GBSO1OjXXg22KUQtt20Zf3WxT8pG6me8PB+hjWQd6MniOcvxEERtCZ8ph/7dJVTlRHyAyFPugnRABYdq9N7AcVSYxMo6mtH3vZBEFYwVI6X3zUA+4pTqXXNFVsa4GeuuOwxo7x+pVqufsRC/LrRD3OyIlek+IrRnb9k+k6Vd8YK8Dn5paZljqbHhe7b4xpI0iIBqWQrF8NqICahWsTWec6wA9bbjDxO/cuRiYbT0VfzYobFbqaDQNo8qqikGBEL3d0Bu0F5z/Npp0Kg+5kXvrVnyWAcEEPsXD0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CLVqvaXYeP7hEdNlRW0VxpG7uaH9U3LLbeehy/wZWg=;
 b=Th+/+WC/fj3LAWmGi8W55lYy5EpIOB3ha/YAAIkSl4kWKjif52PavamYw+jp6AViSAvaB0JVm96LQ2DVdEywiIUscGyxocvja6XaBe1P81kqInu9VHJm9x2LTvEIIEs87eLxv52ksxR71G6cKzJvpjRKrJI/KQJ/TyN4pkt85nQ=
Received: from IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::12)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 16:26:38 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::b5) by IA4P220CA0003.outlook.office365.com
 (2603:10b6:208:558::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 16:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:26:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:26:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 09:26:31 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:26:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Tom Rini <trini@konsulko.com>
CC: Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ovidiu Panait
 <ovpanait@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] cpu: microblaze: Fix unmet direct dependencies for
 XILINX_MICROBLAZE0_PVR
Date: Tue, 17 Mar 2026 17:26:22 +0100
Message-ID: <61ddd555f58ef5169c48b190423640d949e4aad1.1773764781.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=VrYkI8BCrvHD4dwvTPsSIpGw5FK7JJin0yiPeCvBSyk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTubNh4oEHJwJY3m+X5siUBy9bUc1/YtCU1YMHqOkGjP
 w3LtaX/dpSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEFvxkZFgUlXc04Sy7e6K8
 4Gv1u2HnVgtrZy0sXLuh5dblr7Nvqq5lZPj6/7reX7lmVpVXH59u9povlBr1v/ryFovZkj1OFre
 3+7ADAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: b04f7882-12cf-4523-3dc0-08de8441f666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: SiY8juEVowtYIVgdbZPp/bgK3p46jyEDRFW9KevhtQzwRFXy3zuKxDdCi1fMCybrHgB0Rb5XoRDCwTJGZFlr3VSRBMGFXZ4NCKLRrW9uwpKNSjzsiB44PFJApI7YU7HCCE/ZDukpDTj5ijyvuBvXD02KjhkPRBW1CIuFWADFETn9itDcuMTZHRTDkWdLOyF6X2djaidoI3YskhIr0wFrVgGyATDrqd9QRuPuKtbY6L1VR7QSsImP6QtEXxQH3MKF8lsEHsT9o61FhY1DM1Su4EzKC+oW/WXDvo87VA7o+jYrtGwM/1wxy0HwufdTE+p1CCv1KvzaN5AQ9cv1lXs6hLKvcJZ+Ox/CNcQOiLV9OUEtMdtuJRzEJVCOLusevJS7/dg2vWe1mMq5F02kDY5MfX1FRHXulE+mIczGxY6V7pe+GvYwAUmQQrFlbY6zKxWSJnSEGRo2ZCleCqsT/AX4XCAR8Gw3rtkJw7KIuacKZME0TExJnFz8yGn5PAvqb82CgxMILrgKAHf3EvSJPVTMebjCWtm/QFIvVDr7utccqL18jCxjD/zfQYxGX92JFSghd08BfofVkXy2EyFG8lwP8w4mX0swFUg0cCa3oMXf0+25nACLypgDG0dTp3ake5RZqRQ4d7YdOssnQ4N8ig+srTbGAuTvSX2i2aZlrcLCWP07yYtr+NeBBsf4G9v16DbFhWb+CSI/TUFdwcuHVUHyzJP1DVLgKtrn+uCT7k2cHPVd5dtQo24YwofsusTv+Ua2iQOOLK2QrmPY+8+nPGsCgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mILpjLUcJAZgjfKdlTqzaUJUF+fNnkaopy9khy3sLyzx3R/KogpL/NVEh0R9R/IWSAtxVTNk4HNWwjMVXwT8VUFfwYBDatZSciY/eT3tpIs6cHNYsc9UawjycxVu1qSKbdGYirul7wAeTNnnYpc1ZFki5JMgnsUJRqEKRk7IuSVfvai4ZO7qkUbgC+dmAnoSF3dX6/yHViGTzhmDuw79y0cW/OzzEH4W4XmAsH50PZfvreqVQ62KFHr7XFKDofeNlMDjsxnESVweIEiWAFQ59l7oA2ztmddNEYRjkFRg8rseoFq+yAe8kNZkpSFDFciwnOY0zP/oXk16qiLkUv8rqht7ur1nqjY2YYEstkRgNJCDxtaYgcXSJdSuGLzM9XD4iyRyg/GGceDsGZ+p/PP7J//Tuim7kbh4Wly/6EEyXY1YhaXapOrFUp/zwcREfQhb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:26:37.4361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b04f7882-12cf-4523-3dc0-08de8441f666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

As exposed by "make randconfig", CPU_MICROBLAZE uses select to
force-enable XILINX_MICROBLAZE0_PVR, but that symbol depends on
TARGET_MICROBLAZE_GENERIC. The select bypasses this dependency chain,
triggering a Kconfig warning:

  WARNING: unmet direct dependencies detected for XILINX_MICROBLAZE0_PVR
    Depends on [n]: MICROBLAZE [=y] && TARGET_MICROBLAZE_GENERIC [=n]
    Selected by [y]:
    - CPU_MICROBLAZE [=y] && CPU [=y] && MICROBLAZE [=y]

Change XILINX_MICROBLAZE0_PVR from select to depends on, so that the
CPU driver is only available when PVR support has been explicitly
enabled.

Fixes: 816226d27efa ("cpu: add CPU driver for microblaze")
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/cpu/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpu/Kconfig b/drivers/cpu/Kconfig
index 6a96be94de49..c805c0bbfa19 100644
--- a/drivers/cpu/Kconfig
+++ b/drivers/cpu/Kconfig
@@ -35,9 +35,8 @@ config CPU_ARMV8
 
 config CPU_MICROBLAZE
 	bool "Enable Microblaze CPU driver"
-	depends on CPU && MICROBLAZE
+	depends on CPU && MICROBLAZE && XILINX_MICROBLAZE0_PVR
 	select DM_EVENT
-	select XILINX_MICROBLAZE0_PVR
 	help
 	  Support CPU cores for Microblaze architecture.
 
-- 
2.43.0

base-commit: eb140da739c8459498f20f4706b6decb54f4aaac
branch: debian-sent3
