Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A370CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8229F846E7;
	Tue, 19 May 2026 16:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g6htxute";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083B6846F1; Tue, 19 May 2026 16:17:39 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB7A843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHy3A5itr6o8vs25s3UYjyLSVSDr/LK6mmVTqXByfuczI2gePXRid07gwBsl8vwZPXZuLvYR3t3dYf6YKYpTkNq+CxtxkioPBJ7pB9WPqCuTSj2qeZcJWOGUenYWScnKHyJx3vZ167E+pbzlsAY5sIbZqsfU727v2mMlZ3nYkL7ibfw59XhikTWH5F6xF9FmI3hKY+2/XU51Oae6Wd3lh5sU6mug7OrlivBrYBmmhM8hm1XlLXrnfBk8xWbor5VyWhjgL5LkcJJ4PGJCLr1hFXMOh7GGGrcuHKz4T1943EOhNylMiATH1g2N5q4sX+QdG0w3YMM5EAgr51OMjUg7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcldM+NZW/+KDhXczzA/U8sg6qbDP0AHFWXXzAciVCY=;
 b=qIAix1znVMgVmJyYPOTbBecyZpbf/qym3ECJIRFB7SO7Ifb+YHp7c9RuVoGfwqNtkrC2tRlnC70kiVjpabjopx+OV5dvOOHrR91J5pA0Zy3jKpvr90xdbrawMqwEm2KxljINLroz7OtQOW0yuHW9ELVwBT2UEBaAUo0BdLLLLys5wB2lH5dMzv+C2HmnRAMkamDCF5tefyudJWY00SYkvA1BASD9i6BfV/wMynPg+RdcwA6I5tfqWJumlssyh2j1pj1Kew15+5KkWY+9bWLiY2WyuD6h7QTHBAsQS1Iw3Dc/6squp2tN3DrnbUqd552xnM2HzATr0187EijuWp/z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcldM+NZW/+KDhXczzA/U8sg6qbDP0AHFWXXzAciVCY=;
 b=g6htxuteLULIWXRz3p9nGymIyRFX6z+EbXwV45ZBVeNdvfLfC88JLFlttKkjPxdyXbASQ9jqdrnDTKk2zbvjNsLFytVwmxQzYkyEg9oiiHB1P7ir0yipB3EdtGLF9haS7bcGFNwRN/yPNwyMFNCM3I9skXaBsAjGP2ULT6g6l/g=
Received: from BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 14:17:30 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::2f) by BN0PR02CA0055.outlook.office365.com
 (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.25 via Frontend Transport; Tue, 19
 May 2026 14:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 14:17:29 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:28 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 09:17:28 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64JEHH0T3643846;
 Tue, 19 May 2026 09:17:26 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <bb@ti.com>, <trini@konsulko.com>
CC: <devarsht@ti.com>, <anshuld@ti.com>, <praneeth@ti.com>,
 <n-francis@ti.com>, <s-jain1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 3/4] configs: am62x_evm_a53_ethboot_defconfig: Disable
 splashscreen
Date: Tue, 19 May 2026 19:47:15 +0530
Message-ID: <20260519141716.1346635-4-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519141716.1346635-1-s-jain1@ti.com>
References: <20260519141716.1346635-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c0d261-66c7-40d5-b438-08deb5b15c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: mAAX1TneNvDiNqy9P7SE6jaLgUcVkSR4YZXScJK9UBL+X/YGvEXPzuBIVQ5OwKIdR8QvM8R6Kivu2mHGViiWtLeCsNBMuVu65xvlo4931AtXVLjJYdiepu6UbiR8/dU4f6pgH3qaClmrfsItZPhXer/CpqCtfezKUt8npJbDqpS0ImyPQ4skcYfN739av32SVTWGfRcEGtr0iWcgRKnQHru+C80tHONtBCRh5iDbNwADkNIetMVXLcwwcpemY9j+1rfoS1CX5P49JcuMOuUMQVN8/1VSNlLJEX1/gXpuEve/CRQepNKCQP7AAhYjx2CC3jmoPvIg5qbQOzFrDRUXRfMg068WupNm1K8c8qQKghjPuQgU+mp7t0u7i3GuqtKMMefm1c1n7BIPS9iKyKj3Niq35FNpq/sa+KdK0YA3oDZ5pbGBqNYcb1Fi4GuEJQT+kHeqSUxo8oS74JLF0a71gmegPKT32xtOrJ6Bb0WyV0a0p6O9rSYJdnkoz/U0cjn3yyzRbN8cwzr8MAS6TX+JVtkCXZIB885BhUaRBEuZD2JnEDWtzKH0S3EktV/Gq3COG4Kqm0Z55SZRUWbAXDL32jg4tapkHYQ6GakGQe81bmzncDoKHoAhMUULi/kDadQKxejcDtUmc32BKmVrMf+mFsa6MO+1SGq3uNNCpOljbYmdL3UPg4xL9i05V74U2GsKXNC5AxJEr6kZ+PiW++lQnY5B8CZOe+c3UzaEXCMqTqs=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bW4LORUW61HkFOelQGw7FSvyjlyu6xFD2dLL8sxr/P22EvvN1ASnRW5Myde3MF4yT8BReKqmB3txCBO4KMazoVEpUyoCuAOQ6w3jpCwwOaTsuj1hC9jgtW1Idw3KwRrYAKa2U9/zY0emn9q8u2C91oDdkO8dQnE5pOtJkNuL2DEfVUajLSdhSC+J1EFOJscTYBT9eveg8wlBrsRK/ppJAkyPFQjXnqaljyS6VZ4xcFZUPQyC1sVUk2Te8h//yjZmBJf8CNNNdb/cCr29CDYu5vNpyasQfYU8KPRdann831FQfUEn/JVKNUWBOXbzTlCoeajEeW8/QVQNIlr2XPnebYW4ysMZYufo+DKStO45y9TRh9c0a4ybxb9SZCnGFopzEydHcdfZtfc6QOGXHHhHRHFGWKzlf1wWV7uRpkmaIP+XAO0NWGk+AcBbpiy9NO45
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:17:29.4491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c0d261-66c7-40d5-b438-08deb5b15c4d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
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

The ethboot configuration inherits splashscreen settings from
am62x_evm_a53_defconfig. Use the prune fragment to disable this
functionality as a baseline before adding targeted splashscreen support
in follow-up commits.

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 configs/am62x_evm_a53_ethboot_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62x_evm_a53_ethboot_defconfig b/configs/am62x_evm_a53_ethboot_defconfig
index 9d3c6b889f0..fc81662247a 100644
--- a/configs/am62x_evm_a53_ethboot_defconfig
+++ b/configs/am62x_evm_a53_ethboot_defconfig
@@ -1,4 +1,5 @@
 #include <configs/am62x_evm_a53_defconfig>
+#include <configs/am62x_evm_prune_splashscreen.config>
 
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
