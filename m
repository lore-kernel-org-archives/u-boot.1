Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DBDE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 04:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1DD897A7;
	Tue, 10 Dec 2024 05:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="paRTfYo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B5A897BC; Tue, 10 Dec 2024 05:28:50 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C51DE896DC
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 05:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fj4T4l5sr8H0OzQM2NWOCFunmEZPzdyCL8m9kgsL7MRYFcBzoAIXQ06VpfM2xLhVOsug7EKAr1p3vvCFBAwghZ46yN//nY08flUQPNmzGKcKf72ZzzMpS8bYtSuzLpGUyy3M/U44aLOfVKTHXsBvhLEeya3GO/2h6HBb40zkIkrrb5rbzcd69IgtxmhKxF9+gtMgY4C5DAqNhESb+fw2TQaZyN6ff3vbbVkg6wounf7pwwt2YEAiBG9Tw72q7Je1DYdJ0gn5b83Kgbg9wz7fzTy4F3WImNfjWC7CAxp17XbFYUyfexijazL+0bJm/i8Zfl91I8Us7EcJVM6XlRHE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgl0ysqRdkxKs7h13Tym9k9Jhbm510geNGZspdCvedk=;
 b=wyQq5cgAfFaE/JaBvqxL+w9wRbn8y5AgyAv8X0Mbkgr+T91MOAjZMRwnpJO9Zj3XrCbyZnSyGrOLmosf6NFxTxcJAzUuYN08dll7qoHX+2H6FHlVvV6JH5hNRDwoyRB29AazLGUHmOCFXGRg7Z4I5ylsKrWTIWE7g9kELhava0noKLOLb5Ok6EtV9f7A0vXdq2wAm2fCZFozh2wHlS2pJeu1kYOazWaYmRhujik4Lv5AtUxvvKVSmQwNgeLbrHvDrhKLYPg4POEAo894vgL6F/RDxCCxmiaG4ZdBTGAbQE3GvJE2ZDtUz/Dryv93RkEs/pgIypIqdNkxef9QkMyd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgl0ysqRdkxKs7h13Tym9k9Jhbm510geNGZspdCvedk=;
 b=paRTfYo7DAqgNzOFFcI4FZpqizzcl2ftGmYfrJ0Ii0lO3nfmCN9bCQkBNrI8C/RpDr+kEAqm2iDhbcoF4QlHwcfHM0XXK5809mFYa8QwFhh2C63GwMcEkERsQ4lT6XJIuzXUsnceNvUkEa8d3TMoNRNYxi8Vp42hJLP00q3fmOY=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 04:28:44 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::9d) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 10 Dec 2024 04:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 04:28:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 22:28:38 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 9 Dec 2024 22:28:20 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>
CC: <j-humphreys@ti.com>, <michal.simek@amd.com>,
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v3 1/2] mtd: spi-nor-ids: Enable DTR for micron flashes
Date: Tue, 10 Dec 2024 09:58:01 +0530
Message-ID: <20241210042802.632688-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210042802.632688-1-venkatesh.abbarapu@amd.com>
References: <20241210042802.632688-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: db7e09a4-8c33-444b-affb-08dd18d321aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iLLnemnNJf161sa+pMZXrk+MzWezHLo82l+yzAFPDiBo5KFUzzJYS/Pw5VmM?=
 =?us-ascii?Q?3z1+37q05YJcNF1zPHj2Y1DJjl9IN82ytqmN87i/w+wtOxKaEW+ri8Ub7F9q?=
 =?us-ascii?Q?nNDHmFOhoRh05hF0LSM6c8WDdL+WuB9R8qJ4M276t6CewBaJeA77JqBqy7Wh?=
 =?us-ascii?Q?8/JxN7EWaHm4O9XBqLz47R0ZUiaoZhHDOQuIJXJGU+pLQ6NB9UnenGRTYHpK?=
 =?us-ascii?Q?uJPD/CViH9kCrznMOTk19nwRMrbUKvxQVq8Jdpcb5BCP6emaqLiV7HDE4Qv9?=
 =?us-ascii?Q?G8hhQ9pexFnO9A/JYJkpT1gv3FQX+vAITD3MlkHtUYS/ucNkP8Xg48MJA8Px?=
 =?us-ascii?Q?gQEPYcBisAVloxzSRa2XblKNbj08rlUe9bOTY25FU0kR4E4QaCJD51PpchO8?=
 =?us-ascii?Q?7zf5sFHtbL8v5LuNjEh9pPG0vsLKsEZq7zKVpasMMlhZISC7kRpM06IINisa?=
 =?us-ascii?Q?7r247R9+IEhBgkaD/8LkomYzNmQWJMYfTh1B7jHrL61fftxmga8I0yJvZqO1?=
 =?us-ascii?Q?CsiXUPM0CuBKTg4IKE9lMMmfjdV+m2EP1pLYs5e13dy5Et6POpTpPlKcnHaA?=
 =?us-ascii?Q?YAqUqyEu8D8+aUCofFZ1bCHlLSwfnKr2TUgoWfL5IJe7f6wOabnesy+FnoJ1?=
 =?us-ascii?Q?8UtA8QzzqzTBLuYR6PBmvZ2I/3lGI8IXVS/OA5we53VZn6UA+0ARQ/uaJWaN?=
 =?us-ascii?Q?Mte+OUIrCiXeDF54hUsd2ybKIDFb6Ge2+O0nFtPMtg+2SgZYIFJzTaXIxlKN?=
 =?us-ascii?Q?6peb9NZuRk8FXwhM6oV1mqciNkkPiQ/R4imPKIh3sqWkH3/BUUp4oaP/q+M9?=
 =?us-ascii?Q?7KvtsCKAPWhy05tTNoWlJJkGN9QmA9+NAvN19BGiRy9ozbTUMT5JdR7Q6+jp?=
 =?us-ascii?Q?7/YaNQZZvNirXbu55n2vp4RF2X8E8Im28i8ELpf7JG0NZ3L4dqNcv2yaYwXp?=
 =?us-ascii?Q?zo1qr5ng2Qas/kXqTg0OpeE2v7E1j7V5/Q2muJd+JN83czwmgk+xtvIf472Z?=
 =?us-ascii?Q?2FqC3poLjgB4yosPnhlVJn+eEUqUxdMwa2lF47bC7AYhV/sOhm/nfIyCgOsL?=
 =?us-ascii?Q?xk4B+46mRK4Z5YlA3mFsmIwxKEVMRW5DB6YE2c2DMSn5HGENXRfYbIYkW2wA?=
 =?us-ascii?Q?W86kXBlxTYyfuP9EYrN2STIGt/kLNnXzr6fiviPiZ3tH674p0UaqSv1YdAGY?=
 =?us-ascii?Q?VZJJnG1sfZ4KGZr/5Kj9w1RQabg3UXo1hbj7LLx14W76Z1OABfT+mrL+TuqW?=
 =?us-ascii?Q?/xsGc1vuaJemEDopwRj/WhnjxCzVM7Q4f+9V5tG3iSUXlU81d45t3o6ayirQ?=
 =?us-ascii?Q?HmI8rlV29w0+wdLcGthx7P7VHB4dfiqWopseqMlQl6m48NTCd53W8iGet6/m?=
 =?us-ascii?Q?xddiJ/7O/EU/VQlqassArCo7FOjdTYc3iyciwgdk2QQigihVL0V73zrJQLMr?=
 =?us-ascii?Q?dp9kkyKjz6jnsUtzAZ9597Pk+xMo6yCR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 04:28:43.6916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7e09a4-8c33-444b-affb-08dd18d321aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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

Add SPI_NOR_OCTAL_DTR_READ flags to micron flashes
mt35xu01g and mt35xu02g. Also move them under
CONFIG_SPI_FLASH_MT35XU config, so that in driver
mt35xu512aba_fixups will  be applied.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c9484..218c628f112 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -359,9 +359,11 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 #endif /* CONFIG_SPI_FLASH_MT35XU */
-	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_SPANSION	/* SPANSION */
 	/* Spansion/Cypress -- single (large) sector size only, at least
-- 
2.34.1

