Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3B0FD7F9C
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 11:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E1F83E81;
	Fri, 27 Feb 2026 12:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AkOWeNNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8858F83F0A; Fri, 27 Feb 2026 12:57:48 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F62283AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg/eCF9hg2t/GZRQ2mCQ+L11Hs2kYpo8FdOCwOFovbdp2H03/L0WSRd6ai52s1Y7IjrQ/Vko/PLFvmDQ5pC4iVz7wPE+dUs0ssMe0JHz0MUP8+2C98ZEvzhCNuRyv+0NXVcSk67oZZb4QBH3PBK5wgy1m+pnVti8e13gwPTwp57RsYCsbpM5XioF4Rkq2pkYfLEO++6BFs/uBn7dZqcZADkc8lG47hJ5u8GQRzcHa5Xbi6smWdw6IUH2/s4lkKVeluJKekt9ft1oTCb8ssNdomevqoHl23tXTGxgUY+DmK76uc60HDHFM5Q2b+a05x326YFxlui5Ar2+djCwCOiI3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQX0jYq0fglmbTTG0iaqJAXKhQKNqXkQiixocHvJ+VQ=;
 b=gyFmSOB+Neu7d1LDHZPAsPYcUtxipLNVhpEqv0CKUq3EHcSzDCPisO9V7Nau7bS/dHCLY7F6Uc9ct1KEE7TTHBJbujIVX7xxZtu5Prgi/ShFInSMx5HAIVOwX1YbNgIvuLY8xPMEcQ2+HdT10k3qGz9Ye08HJlBnqhDCyrM5EvHlU35+lrhj6UdtQdQ/OCOUhyTmVkPUqEWIevGp+Xxv0gsMArfiWl4jRSKcPLOgOupcZM2PTxBMG/Va/rAABWCEl2iTaF1PF+NubDvCyKf6Cp3zun2V9tsUechky9pSIt42i3yA2QfLS8NsFy6QfrZtOUHeEiu1OxPPDioSJGtIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQX0jYq0fglmbTTG0iaqJAXKhQKNqXkQiixocHvJ+VQ=;
 b=AkOWeNNpRGM7va7+KwVGP6viKvF+PtINs90Hq9eGiozVkdbIePmT/F6OFTqgIf1EGSswMFxOgircLFtGzslygj3pi9dJ7McO7JDVSxjpNbxF7qo9+H2cphnYLqu8FF3WO0REkR/6sahrtpX7Nwk1lFMOOrV/u0o3oYauK6XeWJk=
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 11:57:43 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::9e) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 11:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 11:57:43 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:42 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:42 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 05:57:42 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RBvApc3689228;
 Fri, 27 Feb 2026 05:57:37 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <anshuld@ti.com>,
 <d-gole@ti.com>, <n-francis@ti.com>, <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, 
 <afd@ti.com>, <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <a-dutta@ti.com>, <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 5/6] configs: j7200_evm_a72_defconfig: enable 64-bit
 addressing for PCIe
Date: Fri, 27 Feb 2026 17:28:33 +0530
Message-ID: <20260227115841.333073-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ0PR10MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: e05fb459-cee2-4370-5abe-08de75f76a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34020700016|82310400026|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: Mh23sCmaqXzUm7WaOo3392aearcCsQq7EBnTxxPUpuHKj9eJ+n3airRjN3DNR0OqAcNrs2OSkCPfQNxeE+sRwwyESP7HT1b082fwuQhlEBj0ngddp9Bkj41RixL+lwxGtsV5PFfqK0D1oM6Yskigh0KoUPlqBLO6XRT6W2yulhrkFfs0VxC6eh9PjapChzqfsZLfHrRUlN3LKd7RiPKHosG0PqkiIGnrfPghMp8c7J6mFxhY8Fsl+U8gWkxOuI4AfoOmBtJXvhGjQNxpNMB6Lw5WSSKjAaIN2TlJ7LoZfvZJHOtDMj1KV9GyGhV/vPTYfokLdcozfSfRQmTyLjUwu3FXKub8+Ob2WWL69lmQ2NIc/aVDPvT794bqmeaLdOPc4gfr1Caam8mF8Q4EQUbDNMvaPVgG7+/J8b9m4Q23mj3a4JrmYCt7JRv3odsJN0MeOtYe1E2+udMTR0BMFfmsLoxUPIUkAWkYF0Uq5C/auO5k59VwH/0NWjZsD6xjzx+nTvi2e96vUUc1P40VmC+2tLFmWJaBXXJhadfYeI8RkP4RhK73Tzch0343d/ta/dieAa1YyS3VKoB0rbfuvB3xpXpSFKFJ36ACQWTHXZEMA3ophGABJlF9rxilxKtr87/bTq2mRTge1MyAnAwXSNkA+DS26JckusJlJEyD4prAHGovhjc6EVSvyilF6yftV5/K2Ai+1znwhNmJUQcJ34FUvoEIymSLdMqsKgiPwcq7bkjNB5NU6g+1GcVp3W8VRKNUKf8uHeccKNTeZQFmX9sjv2KeMqTsTBRVHuc1vjZ1q+FASiLmr2jye+RMJO2Jsu+BKZPZOzq5x0ZCmPlBS+LepH9uzRSMzgRMYbh9aTAhi3c=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34020700016)(82310400026)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2gap5DEWrI4txNf2TC9TFruXwN0njOLcv7ync8qN29pBUpKr7HA9Uc0bxRXgr+0MMKYyUlTNHM3vMgSEQnT6YSGoxDqCWDMSyv+mVQ7HVah8RWWjEDZ+e4VKkR7y9ZSSMCkby5U0MXiRBUmzhSMGKejvmLO4NOxaj8yGgO0nvqcQw+Meqpo7BMiKkiTMPXSbRtPoL9bC7CopknMy46QDJEe8JChS0k82rQPFyfwf+1fMF/uDBoj49NPmjwVCAzDDoPdbePgeu/ixUhl4CVX9dwO9l+n84Dk+nkm+vAI/3CaFb6EjgOq6UHVKjw36XKgFnalKGyISJScohCFT3K5Z4gTZa7+yh8sXXiffjsahKksqhbDqspFjZEw/HVxVJOQiLd/1DRrR7U5/k8j69RIeEcSKs+1gkMbmBXm8YAlMyC1Vy0YseBSGHnhwS6uSD+SM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:43.0716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05fb459-cee2-4370-5abe-08de75f76a2c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
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

The PCIe1 instance of PCIe on the J7200 SoC uses the 4 GB Address Window
starting from 0x41_0000_0000 to map System Addresses to PCIe Bus Addresses.
Hence, enable CONFIG_SYS_PCI_64BIT.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j7200_evm_a72_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 27a9db72fb5..5c5abd94eb0 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -30,6 +30,7 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 # CONFIG_PSCI_RESET is not set
+CONFIG_SYS_PCI_64BIT=y
 CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_BOOTSTD_FULL=y
-- 
2.51.1

