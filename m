Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92307C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE08387877;
	Wed,  6 Dec 2023 06:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eBpaNCGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E059877C5; Wed,  6 Dec 2023 06:35:33 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3136A877B1
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZd4V6wBzAKkeX81BkFFCSS3N7JPKOe7LmUU9ONBR7Ie4+35il8wdYJYh8BGhCccs+ESsfkaK/EqoEMAoGplTk8vWkampwaFfbFvsMip9yaNRz9W/p6HuDzDYK6xVTUxDedZE1HfU16uxlxyBdutM7Z6IrOKqPhYdhAygP94W81yfIZxWVRSieeFYavn+50+dLUtaQ1dMNZRyh+CqFYUcRR1RsLRMSRBFkRKWyPDZ9wmF0ekKXXTLCl27JjQfcjiqJOusE9sIvKcdkL8PRMtRK5nMQlpifpiWbbZsp22rjJKFXBQ01VqkIcLoK4CiDMxwhFpcYRgXhYOXv9IgoBegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2l5FhzsUA8aU5d0uHnyzBdztUFh36esFtNte5Y0XR8=;
 b=hUO6uAtXCiuKQiqq7/b0HZ7YfsLkpWIxz6g9JzKD0/M9oDfC+LZuyrYwQwyN903SbxQr6MRfLv6yO5iU1KJaWiYTGLyVY2Fx6eEkdU/Uo4HeLoHPEHHPurxGoendjfiu0Vpb40B+raXFrpMETnmw2NWsL3qE/GT90CDk/PHuKRNPZdY+kIUrElT/14napwBBm3tDTuRiN7BXqLU3noUwk2ELSCMiXCgZpAjeNn4qTRaoA0w6578yLn3It0qvfOtXrg8L2SeQCG/JWEAAw0vZtLYH7W3clSvakpQr3Dcamog+VAgXNpO9L57r5+vnCZtRQMazFb8fgas7ZOXREq7eMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2l5FhzsUA8aU5d0uHnyzBdztUFh36esFtNte5Y0XR8=;
 b=eBpaNCGr9PU+t0rQ8wozhc1owIEb0ZVj2ibsJpvGh1sSINGuuUeptR28S65v5o9C0fG2fqS2Uy0puy5tCZwcsr9VBf0OwqIy0ktFnLXExaRz6FpkguXkejwg8tvlKy6pPC9zKGh72csiuyJ9AsIb/Ioz5VEq2PA/MHLnpo7F1aQ=
Received: from MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 6 Dec
 2023 05:35:08 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::be) by MN2PR08CA0017.outlook.office365.com
 (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Wed, 6 Dec 2023 05:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:35:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:35:06 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:35:05 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:35:03 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>
Subject: [PATCH 25/30] arm64: versal: Enable octal DTR mode
Date: Wed, 6 Dec 2023 11:04:39 +0530
Message-ID: <20231206053443.3746237-6-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4907a1-d51f-43a3-6126-08dbf61d1ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xLOlGZC30vC75ozl2iqH3BxatE6o6771iYWOkFBkLLwCZ966wwWGqNDnl9kmkFeA8zc+WlrZodY7mKNO/SgNB1cbkQPVGp9GlPWkXE55+/vt3FYUHLTKuV3Sy5QYrSyzrxKoAShPXORJo3pzqAhVD/Os3oFsIx/zb/Ez4BdciR9uZU5jXHqEyFy1nHHTDgh998HZk2SYT2LXvaJNo5SarWA5dEd3+XOqW0suIAhkLayh6KVYFMjd4tntES1XBERpLKh3BRuUA8Iu40E1fy+8sLEyGzbOmc5sUc+vGw3jfhFV6NgircAkeT3NT5nPZ7LG8XoMS+BHkXiCBgpAxCBvf6JZQmfUIJDJwFHm2DQwgqaYqulBoeI8yGcVnGcFcC0vtmrY+71wnhZQw3rWEYvAuknVtys0LEoZtEPIho2SLSUhhewKhbsGjZgOuEdRKKTYfPV262pUqv19IU5GOmlcCugfDhEdVDjOERpdUsF/pmaFWoWeeYYXVa9WgHHDeJIEtErruTrjkcA/fVpztxONyrF1GrCvrfwnKEUqcGPKRb/rf67Hkf44jtY/62tVMU3oVPithxPdVnqs4ixhXad01wDbmMYe2PlMk1zo8H9+rddCbV/evUbCpM8l4d4aADBKP8949SXMy/5oFmBlvFEN5qr0WMMybwzrcNe75WbmYzjmdK5NzHn7L3jC+CMxEZLmHadnMUVPYL0BENVrZs3mG0YHGMixdr9tL53Yz1NaSTD2yUYww6GYSLZnD2Ql3T311oCDKCB5HLRfEx3XbZjoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(70206006)(40460700003)(5660300002)(2906002)(1076003)(478600001)(4744005)(6916009)(6666004)(54906003)(8676002)(316002)(336012)(103116003)(70586007)(26005)(107886003)(8936002)(82740400003)(81166007)(2616005)(47076005)(4326008)(356005)(86362001)(36756003)(36860700001)(426003)(40480700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:35:08.1092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4907a1-d51f-43a3-6126-08dbf61d1ba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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

