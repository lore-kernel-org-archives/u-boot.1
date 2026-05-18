Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B75CD4F50
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 13:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1759983EF9;
	Mon, 18 May 2026 15:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="G4y64+tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A6983FEE; Mon, 18 May 2026 15:28:35 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F17283AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgiWQC8ZOOZkrOBgnNp2M7jR1bA7/SjESA2poYHhUtEigFXrAEQnvU5KmCSK4SJjH3VqsHwYCP056GEbeZBjD/xpB6Z18PlpQeldzVpvqFGEBUiR0vRwQt9GD0Tqerk54mTWOohU5iB2VfdwyYEZyGW0NMU7ojczPI87HR28rWaMGxn4ljemWTdqckKTAas4dZF3/iMg0TrcpBdIlHc5mxu7vQPbyC3kpAYP0vA4wwq/zH7Z3aRWOKHZgOTReUjxUegadkff++ePQcdVh1P1ktr+zdxznzx2W3ISNRnsO/oiN7f0wSv5rvk5oo3+UCE4w6bJ0RWoPMdCSUG6V5UZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adrfl0xz80j3TA0oqsmL0bctDT6zioN2PmXVHWYsfhw=;
 b=O/Bc/r2zvRUT3Nfav8SKyDC/7jBxs8arfUTzPy9MlCtx9oUo02+fgpdObgbL3BhTp9bUwME55iS9BdvxyrmVxLTP2niWPboFb1mx1a+CWREMICd//zgEZYy5hfASKw2sf+TwQ1bzwMscm0+h6Z35Hy0A9tXakdLCpj4v9aKRmzTFe5QFWDCmFaKsZU/Pt5ctO2e0LFxavakeNydogHHQzXM+ma/EPn31ZBA1yQTIdX8QX4ur8fJ1VLi4AT6hfT8ZjZif9eBudHE9rtcOtJu+aKprhRIdtw2+cb2YOTh9+LKT9sZMDP7+Uwub/rUXSO7Xi8AJmzC6Pw/EcAk0+/XSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adrfl0xz80j3TA0oqsmL0bctDT6zioN2PmXVHWYsfhw=;
 b=G4y64+tw+uH7PO8ikcqyN6PIjXMiwF5DwhkcSeWJ5i/X58QhNJZ/X8zLkIeMpf1m1cC2C3SSASMs5iBR9N+wDFQyiFd7bu2mEidMH7RGb7S53FAIXUqGqKhRgNeJXFAtwPryRiYO8B8s0GIQFCSkBAuvaft4G3kcAc0jxSUTQ13TZdovjuTNxGQ13rLmYLj8j+Icmt6kXWSLWU3xA/f0z21WzRnGWzC1pLIa+ohA8tYF6HcOsKdhzqZFAQZg8gDjhADqKirhfdbsvKZvT2H8LKbAWii4Eo/exHsjoUhB5IPmzOP+xCwvZrnRMMaXRph7jp/ZoG/ThgJYVF0nv0PCKg==
Received: from CW1P123CA0019.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:292::11)
 by DU4PR10MB9637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:644::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 13:28:30 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:400:292:cafe::19) by CW1P123CA0019.outlook.office365.com
 (2603:10a6:400:292::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 13:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 13:28:28 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 15:31:56 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 18 May
 2026 15:28:28 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 18 May 2026 15:28:09 +0200
Subject: [PATCH] configs: stm32mp15: Increase SYS_MALLOC_F_LEN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260518-master-v1-1-37fd4df56609@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAOgTC2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0ML3dzE4pLUIl0DU8tk42RzU/NEQ0sloOKCotS0zAqwQdGxtbUA4hM
 1iVgAAAA=
X-Change-ID: 20260518-master-059c3c757a19
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan
 <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>, Michal Simek
 <michal.simek@amd.com>, Yann Gautier <yann.gautier@foss.st.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DU4PR10MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: 898ebbeb-7b06-44b6-96c2-08deb4e1593a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: hC2eDH7qR7+c4e8X95l3Sq6zaR2o7T6ry1hYuRCR4UGqopwh5/2Tfb1WNtgiNkryoYGJ6My1+ZDIywy7mFUK2VvqIx2JEE8ZbI341XF/mq/Utd8dVFZMvWN6ZOJw0ESy1ePxcrCzZOjEb9+BjzPLT2nv4gphHzBk4V96XpXYAUYC8+jc3QmBILbnYPQmmAMOTTzBBdhp+WuczT8rvkfcRyhl/msgOEtAJ2xtVQyWwt3242ORlhi1Khrq0ffwRIy43xLkc4l6yuAYFs18uQgRYIsuF80HM/fCB1WXMSLspZh+JMCzVvsNyfPU9iWfT6jQ1wFQhCi2ye+1XWWmTKNUFkpPUltk+GP6cTngU/En2NOjMJBbjI8GpMaKLMq6JUAqaQ3O1ULY7tLFhe+dPbJTEq7PRqNIbNdhNuSGn4SvQ4oHuMiSBnvPcp1+G+lL7HST07cWvqPbhq6RRRxVfHfip+dROUs1Tbviq2PK6VLftt+KRG0azCakPOSE4jP+1bALLYU7HWTVuZwb1YGJlatxzdxCzrO0u1YG6BTkfS+Pa1opcEjWUU80JKppUE8htS/FVtoguF0VylqEFF6ucNN7pNqsV5G8nXns/HAybpaBBcIEjLenAuAF29nzeV0aRUoWAZT+Z8Lj0mvp2eVUd8cgqTlDajiPerfz74zBYt+XXr2rT1g68dsL1+wXVbcCvhZWTMI41JOuOHsOtswXR/UcZwOIBVmtNlLGqYv57ywXd2A=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8QWJREmezs67+xJpLi1pk4BJRoz/9aCYRmfLGCV2+2I/mvKjAmU4v5bgc0vc3sAFrFQs1cr3z+0w2C2qDvntt50b/zTV6qycUJ2HqDXJCL6mzezr4LmCjYQS04+39R69olk7MIVLsMMbdfcJJP/nZxCpQBWhU4JJs3hjJsesD40jzXvVy5K7o1L1HNhrVUbX5rJVsDvH7HyUR8qQk4KC+DTvm3RlbLZuuNIB/BAsPOmD24hcI+ziypgj/FltYn3dpYpsCQDo4XliO8pKInadpXvMr+nMefKxoReuUOh93xj0I8URqyE45XAEtRNDG1ob0aaCwcbW/6ythGqq2QxYxrlTjEyGTdWyOECm/YrdzwS1gYHOZR+5f74/zzmmQ9cl5IUnHRiSp2iPQKFTQjvsgU9GTTL/3fvY/Z6tIBglxVFGS+gJ/yOlOShJQDekIw/I
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 13:28:28.9994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898ebbeb-7b06-44b6-96c2-08deb4e1593a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9637
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

Using stm32mp15_defconfig with stm32mp157c-dk2-scmi.dtsi device tree
with optee-4.10.0, we got:

U-Boot 2026.07-rc2-00052-g215496fec59b (May 18 2026 - 15:05:34 +0200)

CPU: STM32MP157CAC Rev.B
Model: STMicroelectronics STM32MP157C-DK2 SCMI Discovery Board
Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2-scmi)
alloc space exhausted ptr 80060 limit 80000
optee optee: PTA_BSEC invoke failed TEE err: 0, err:fffffff4
alloc space exhausted ptr 80040 limit 80000
alloc space exhausted ptr 80020 limit 80000
DRAM:  alloc space exhausted ptr 80040 limit 80000
RAM init failed: -12
initcall_run_f(): initcall dram_init() failed

CONFIG_SYS_MALLOC_F_LEN need to be increased to fix this issue

Reported-by: Yann Gautier <yann.gautier@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32mp15_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index b9e44254087..cc4dfd9af70 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -1,7 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_STM32MP=y
 CONFIG_TFABOOT=y
-CONFIG_SYS_MALLOC_F_LEN=0x80000
+CONFIG_SYS_MALLOC_F_LEN=0x90000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc0100000
 CONFIG_ENV_OFFSET=0x900000
 CONFIG_ENV_SECT_SIZE=0x40000

---
base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
change-id: 20260518-master-059c3c757a19

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

