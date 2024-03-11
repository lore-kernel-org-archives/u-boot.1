Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B36C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDC587F43;
	Mon, 11 Mar 2024 18:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yep1It1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28BE787E6F; Mon, 11 Mar 2024 18:23:28 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B72F87F43
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7GvfrP9b5pI7eqEmfA/ypK5hB8NWSa/LIeeiUJlh6x/w73hqdCbjk+eYBjGOW/V7mDHfWLAZigqlIM70c7dqweqM4g9xAVfj2r7ZBDuxbSze4BkN523wlIUmRrJ311h54grX0EY2cUc7pCTOCstILfBq+gOZZBJ9BOftz54Z0c0hnstEnpamqrbnZeiLXSSIAfZ4P9rVN6tPYcqKK1V9IKLdZ6xJx6MQrZxRKW6yemqiK2+o086HydHHEp+togNfJjc6r+iAY9sb2Zi5dlr0FBPJFvQdoFE6z9fkwqelSMbzm8x+biKsFqhdXEHmQaR9w+SomZfbxN1bTkRUUWg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOg0zDowiPfvRn9AJn73YKRq0I10eQVxvOmtv3zoUIo=;
 b=N/IW89iu337xH8rg4As3zYegyIPjPsX32IwVr8CeIbCCGDKA405hsBB3tNnKDIJ24gHI7I5swcDTfbSkiVyCpNOqZAJTh/IAkBbSp3SCpNkIXiNghDFbqz1vq/W44zWd1ZQbaNno7fRN9lfHKs+jplrvUpMLBLQOm66QAB+RG3cDwP2N0IbanEL24pkeTmoS+9sDI0dXc1gif2uq48jNHINcbQJ0UFN5skuhCR0fQ6zXDQJOHsC0DLnNakMVn1bRi8ZrGqPBMGMD+s8FsL/zigqSNrq3YW6YCQsGa2dyDQVrB1gbLgmIAiLvi2xUNp7oNYZWDcBmJoJU0+cjkab8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOg0zDowiPfvRn9AJn73YKRq0I10eQVxvOmtv3zoUIo=;
 b=yep1It1O3a3UhzXex2xHImRNVipJyWHyKH5vbTGmwHddZ+R0m4SNOV8/YownHaL41bT0g7X5b6LlIWKrUXkq7/mu1CrQZ0jXKUK88JhtKAcq67+6GDyIkvU8W41Hfqtg0XVPO4Dg/HZUKYo5vwJFa3neV6SZGgCumbOWvZpxixA=
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 17:23:19 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:174:cafe::24) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.2 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:19 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 10:23:18 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:16 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>
Subject: [PATCH 08/19] arm64: versal: Enable defconfig for Micron octal flashes
Date: Mon, 11 Mar 2024 22:52:38 +0530
Message-ID: <1bb288f1901318b6cfc200bef148293a501ab343.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b4518f-5866-4f05-e20d-08dc41eff21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cr0/srIEEapdH6gCJ43DOhge6K0q3hwdg0/4hgXz6GkIXVyy5ByjyE2GDdHj5zde6c2SZB1HZ8IksDHWkOH9JVoBsyke2sfFUIbSJkU3ebBK5HqlULCE1wcH+kP6htOhVHExvKTkKhQ6K4Z2ELPQEAnDOpKkSJOaE9DI+qM0Vs96b3ZV/vO0FdiIdt5GhXhIi1Z29ShsdK6AiIunFaK67NvKNMTMrfI/kFkoPbv1wtZZ31nokxXiaUkmZnRUoQk/H2DMKjAuz/9mGdqvsQ8lm60sB0+cfE280UtFcuY37ow+KeDL0Dedbx5xDUl7+0VnEXvRI52s2ASL8KUN0bCunp/oNRGkjjSaaScaPyFGY3UvFBL048PS9x0SiN24AN4xpbdwPbfYAaImZZIrdvdYHU8034zFLuhmVWDpwQ3xRSoDsei27d4/AsgiuD88xb1guvfYGxhFwwsGZBz5NIJsPtZk+9vr4l9py0YQ3+uzhc9Rzc6BmhVyUMP2RHM53c5bL0cWPRmShyn71WBUi6GxI7T49DFVj+PdK/s/3lU6pVsy6+Gyw5JxH6VlA9OzcXTUBuuB6Vtn5qthnP8O4Gu1hGMsAv49pppp4zD4WUoCZ/hbzdHv8HY0pAi49wT0D/N6ZIonWtSh4Xzp4slwJ0p2RlRmzUfnn6OJQO5c8TcWAhEpcfT/VdhdXqACTKjkaj5t3NogEy30w/yoaW3tg/khI+M6A016lKdlLyOpP4pX8zkbaT4TdC1zTtjVDDsFyWg+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:19.4085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b4518f-5866-4f05-e20d-08dc41eff21e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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
index c9b8a6de01..78141bd45f 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -98,6 +98,7 @@ CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_SPI_FLASH_SST=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-- 
2.27.0

