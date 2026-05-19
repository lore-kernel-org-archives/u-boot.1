Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F26CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA5584911;
	Tue, 19 May 2026 18:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="UjckPcB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D60E84913; Tue, 19 May 2026 18:31:58 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4902D84911
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/qBNvL9aejsUu/aemj8FxUL2SCmzLAQSHGTXG6MqtFooyg/p6YxnaxhqHAxgUp7xHp+wk4DGGXzUM0G9XIcT9pWDxJf8SYXjHyhlyg2ZaxzykOHUxl62Tja9YnMVHF5nL6fQoEEa5txd8uC0HtusCR0+WSdoJ7T57xiXsMR+8PShpWcylPMg9kJWGmj81RVpGTI/5roCG3d2S842/Ki4sMr1ilFYKYxkkCkCkFpgTm6UqpVGjr235f38ufkYcg3vCi1HFH8gq9ZyQ4wyfQkQ3OorKGzTQX+Dgf5yYGxadxcBYMcpBK/v0fS2xvL/I+wETzLiABFu5ZgY4hOWfs74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvsv+0ZdzNJ2A+EVriEJQH6aSoxZb49+j72WPIHWZJw=;
 b=TLTkAV02SlA+vT4IJaf08Il35GIBe9+kRG9i2PBP1f8UQn5ycvhFEtkQTM5pPjmuQDqFv6ZC6yqrwcp9ZrDQUYMXFrLPUUI/Sb9XyMqz4ksP67FHh0vb2Nps6Z0CCqLbMZXn9J1rcCMWzJ/VtEIUnJAQoLy3Wts7GHBQSu/9dP4tuycZbo6VoM+9eYkQ3B5dyELcfJ4Wtor2L6wV/eL/Kp09Oo9WclDXyojYX/A4uuHC7j3C9HuEDOYY8l96HnV0IQ41fKA6VBqPyLmZikfoOj3xbJ0bjXfskb/6v52A4wi0qYo2x6JCnw6EBpEd0hENSedO+qp/OH+T8Oeo9MmPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvsv+0ZdzNJ2A+EVriEJQH6aSoxZb49+j72WPIHWZJw=;
 b=UjckPcB0KcZkWN3ZIjbY0opoCs0b4GMnJLobJozPV7y7MPlLkTz/UITcX1zotVIVeY/D8Wj4K4aS+PLeqlrxAH7k06QRoOcKpjUvbIDv6rpiUoL2IV2t9OAH74BIUmGlRMBR7a2N6smb+93Gvfeb0/BShqZuAVJ6qBpSOPbDDiGJGnwBiyXlx8J8iBwK2TS9pSZenAyJseJBg70CuNLqmnm2qhe3x4Wc6hKbDBwUDmx6kwlfoRw4ZW9IrouB2+dAMRstYEyeFGeIs8WQDHjUXkkoJz8cGmgVOxmFsDccI12xM7pOddRx429M8C6Oz3mOl/VVVAAkax5+H2lILIWXbg==
Received: from DUZPR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::18) by VI0PR10MB8834.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:232::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 16:31:53 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::87) by DUZPR01CA0161.outlook.office365.com
 (2603:10a6:10:4bd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 16:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 16:31:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 18:35:20 +0200
Received: from localhost (10.252.30.192) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 18:31:51 +0200
From: Yann Gautier <yann.gautier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Anshul Dalal <anshuld@ti.com>, 
 Christophe KERELLO <christophe.kerello@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 1/3] configs: stm32: enable WDT_ARM_SMC driver
Date: Tue, 19 May 2026 18:31:42 +0200
Message-ID: <20260519163145.221668-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519163145.221668-1-yann.gautier@foss.st.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.30.192]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|VI0PR10MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 9907ce63-fd88-4c00-1fd5-08deb5c421d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: p7zv1RgSnSH+TlMrVMF0kTuyXVSTYsuatzvCFW38J7vOd9YpAi+EWUQEEOxUaIt/+6OeAtI5rmgyAETucyM26uKqM7igfMQur5xlkdGTDfv6+bfIJiBIGQJseoI15YTWaeBozf/j3UNo75R/VhklrNPizT5fRYAfKHbk5UyFeN+KfFAqk0lmJz3I+GDrdJUxhjpwX8Uxnr1MgRhpcBCsCV2g1GbIgvIETUBkoMx8T1/8zkxwep6Mh0BHg9wFi+Dp/14Jz0KHNbXZV7YiVzUqhEVTXIwcG36LCfBNgujSN+GyjyG8p3f6Xd5+pQCU4yBqzfMwb5LctgVxeCX1e1kTXAizIyBU8zNcY/IkrsBm9fPdVNdjYAudrLRnzPowVJGCOp+vUT+19kz3tHTHw+8A6AvY7whAla7ZpZfvlg20bb1VFSwyr6XzjSFC2pQp0udI/6l+Hz5pH+1GlzMozmuWOlW2ptIH2Dv8p/Gv2Mv0VQnJlbgrMwDszzsmaEYpAgQ/P5/rnmU1GoOAKyhinAQLyEQZR+NBlQqLkAMECGuIRK27WcYs1RxICGaMVY9Plvk9a7DGRnlqbh21Wn4MyglZgqsGYqWYYGSQ2sYUzNMAQfQc1ykcYg1uGaIZkx4L7BLAeFJdjX2Z0SZ+cvhfwokJMXBOQeRl3qeKZG99eL5uysdAkCi7k6Ot18+iv8oHI5H0jmQfUrjYg7J2RWAf91dEFRNmsje/3E564Y1KVx5VNN8=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9HXPfGYhpwbdUO7pP6tSKqo2ZlPw/265AH8o1cd8oflgvHnNbeSZD4r2iz7d6sOrEMGzZMwAszRTPA4nWhFK4dm6F8TwIyZiQCLGeyBpFuOEGjmikNXhd9xRRaJa+yTkwTEcVx9xIUqRo5YvnR8WnJzHwjP6VwQPpazlmbXjta739R08JSgPbbn2jynkEhVsrp9pAe+H/Cjdiq+HCK75JsPUjMJ+vXephLcwV6Sk5DUwSXCHou6KjLqmxZaktxnNRGIkC7ediJtjIqh7tKl2GgtM6AuS7xiTcGIOAKsevuOn7GgP/NzJSertsgQ8Ihk4S22cnQJKGQ7Hq3Oi9jZrtsyhxvd0ON9GXT71isvRV1v3JueTQXa87rGv3io36WiO9SEkscl+RqtbCkhgqR+fTuNYxPOinh+dpATXNxK+nNzjIHB7ckYRe4GCN3qW4Q37
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:51.7774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9907ce63-fd88-4c00-1fd5-08deb5c421d3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8834
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

From: Lionel Debieve <lionel.debieve@foss.st.com>

Enable the arm watchdog over SMC driver.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Improve patch 2 commit message
- Add Reviewed-by tags from Patrice for patches 1 & 3

 configs/stm32mp15_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index b9e44254087a..2ee08dc15551 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -169,5 +169,6 @@ CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
+CONFIG_WDT_ARM_SMC=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_ERRNO_STR=y
-- 
2.34.1

