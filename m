Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE874105F7A8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 13:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B2C842F4;
	Fri, 13 Mar 2026 14:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GqGStFFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC828420D; Fri, 13 Mar 2026 14:59:21 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E82842CD
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9PLBEpF40MdCoZbEXVv7lb6bOgGrVf8D6G8Q/+c7WOH7Wl9CiBSR4j/bYIyDhIw4sRTL9oUD9R43WBU82vRMOLbtR7XrSpcaf4b4RmCOzwGTlhsxSJFzk1HJ8D0DFzJM9egkvDdg9mgyZuOcmcdsffiL48Hw7m2Ddqx3RYhUBrr8eKCDsQdPLuKFv3By+ETgJOtrJMm/v8AJddzS4Tx11pjaP6SuB41NpJ+kTbQyPP5G7bZ6JA8heT/yU8EQqzDniP4A8bKe+zUdMBgIpbqOzKkyJFjASwsYLZeVP66iUwFwJXuj/ZemoPTWJ3MfI8FtxpUaESaxtwIgqhAWlIu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsvLbQ7Jc5IVQi9SLB8GqmmNllITZTZjCppGhGvpaTs=;
 b=H/iNbXC983gXPP9r1EnCmLWKU8Yj8kLk0tpqmFVRPMkLu2ObeQKjKonltFPoiQujh40V4lK8uWzdJFZfjvvETVwe6k/G2Uv92JtZ/ZTc+ls4WcT1ej/AQSYUieWJcUrq3b4KIpYsmVW0Xslr+h/tCWGI7r/LWgnQY8hC+1/BVgsWm63hsINbwCevTRaZTQVoucWM50uxJCo9CYCitDXxKjtHfTtxgnE5xtGN+I4sb86nd01UQlEhzDbbZuWWECDqdnmAszVKEc8lhKIR2HNPWOHXuQumIh2p6HMZNl/EZRKtwixI9gGMUT+IaiLpmNPmOUrkUu/3LtaMfazyaqvIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsvLbQ7Jc5IVQi9SLB8GqmmNllITZTZjCppGhGvpaTs=;
 b=GqGStFFwVmUliISijWFdPo7JqTkaaII5eck3ZruP8lIZMfi9bURE7H631chlqTGNxXy5jYMZpTOrUCraKH2Do+znnF/ibLpkatEisFM1RXbI70g/VgeKlE+BQ0KF00xi4WVfMYOv8af00wD+RRV29XRW4ksiDBMAmV5fkPSegbY=
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by SA3PR10MB7042.namprd10.prod.outlook.com (2603:10b6:806:317::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 13:59:15 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::a8) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:14 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:14 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:13 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6JY638000;
 Fri, 13 Mar 2026 08:59:12 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 02/19] configs: j784s4_evm_r5: Used main_r5 reserved
 memory in DDR for malloc heap
Date: Fri, 13 Mar 2026 19:28:43 +0530
Message-ID: <20260313135900.3430264-3-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SA3PR10MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: aef7809f-b2fa-4bf0-d39b-08de8108b629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 12DC2XbgSEyisFROWoJIPJdq8Pm+JR08kB3AwK9p24d/m2oV1I1OQJ9p7Skv3UjJ+RtRoLyR2VzBCMWoX2w9zewI8FjVAG7n2OObFhOSLLKmrkKxOsBMKvX6ePK8L+TwewfruMRwpyLFGKKzwCREBytWv+riEyOqvXuGl98cqINqMbpn4UzoWTVbXygsvbffe6m+1bMFtLzZ5+YYtBUAkBX9BN6rYR3dBYjFUNIXQIDtLdhsfkkuqvWjeIbibkjTpfo1LApafORhfgshoIdkn3hHbe2HGM88uC7QFZ/QbOwx1EGbLPD+HHM9T39rtzjJAYCv9rXWeb7qRdm6VvDoQYAA7gHmmpUpTIgPzUCm2ZgKtANtiRrNdghGYVIQsyWJ/2KMUmiWKOI+oheN3wut2s8w49ivqea0SHIerkZjKRK+m84z+VSQNTxqkk91yE0PI87koyHJVA9WhK5yJey5NSLLYNKGmpMey0eJiIXsYTqG9cZp0dCL0flIUsb14L+kiMVmQmt49ObCHMFVWfySwa29sbFMCH0Y6fIGdXJ0wy955Y3Lemnzyy7cfiNtstjkiqI6qJLGLqRUWPXcspb52CwwpiOApesI8lOGu232X5OrvJCctVaqWuUogw7YExSrHZKrrB8CPJaSMPrUa3FFNNE9lditXB3z+Jz99TuJtzed8hdO8diQyEqCe6RJZWIip1n/pl2Fg85CnngMbmckOds1CmudtrjR2aAAHyvDcB+7YZj9lpE6+zGm/1yozLY2/FL1FsjkYRGLoCMYaNfYfw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDEd2ja2lNBhAGmRrQ1uo8RA1zXb6AFx/Dqtat/EKX/ZkRA/SQJL0y/wHpPnBgnnugzo0KDvMoSgWCAT3dnVgra2XvaL8LZiFU72cqrzE3DmYzYvjCd+3PVRcX95ldUdrmA5S+cGM+yU7og1iFbJp01Fkxz5SlkZ7kOzMN7RZBNRxxAFxJuWhBmJf8/gB7vvTdC5wFosH4JZzQ2j0SoKTrNMM9HiPx5oeJS+NuOmrlpEzza0M/JVxh6co8vNhBsYKQEtr/9sR6G0ExToK9Z9U637kYbmqHho/jsEPdj6MAngZ2MhO993YkfOQi+BEC17Mu9Pus6WBnruQE8Xmsex6RV3cQiZAe0ZXoKkKF8t7WezInJMNRs8+/vyChUQZyaOnEcRxbW48BBBjfmMsVzBmlA2JHm1XEA2QoaDl/7wOn2FClbh4rhYw935nOQC4DuM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:14.7758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef7809f-b2fa-4bf0-d39b-08de8108b629
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7042
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

From: Gregory CLEMENT <gregory.clement@bootlin.com>

When resuming from suspend to ram, we load again the DM firmware.
However, we have to be sure to not modify the memory used by
Linux.

Currently the SPL malloc region is in DDR was in place that could be used
by Linux. Instead of it use a memory address that is located in a
reserved location of main_r5ss core0 dma memory region.

Linux will reload the firmwares and these reserved regions are invalid
once the system goes to suspend.

At resume we need power domain driver to enable R5 cores.
So, enable powerdomain driver in R5.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 configs/j784s4_evm_r5_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 25ab6f17d17..dad25fd5d44 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -19,7 +19,7 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0xa3000000
 CONFIG_SPL_TEXT_BASE=0x41c00000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x41c76000
@@ -124,6 +124,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_TPS65941=y
-- 
2.34.1

