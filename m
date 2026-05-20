Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15A8CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 16:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE541846E1;
	Wed, 20 May 2026 18:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MvfGELWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44155846E7; Wed, 20 May 2026 18:07:26 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B326B843B6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 18:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n56qsGQIIql7tqbHXps4R2h7L/bEbwoyXiH2NRLUG2WvuPiHMsajw7bct8gFPbKAtIIkvEmJR59ea5r3p9Qh0DduhxFiKJgsbImg4kD55Bmkzmg5jQO7KU9Opf/sgD5j2GrXYy7/Cm2guEyyNXjynV36a+4XNqbGpa2m46JyDjHq04V3so0OYf98w1IcaCv30niJ/ckpxM7/mZUdUfhg+BTgkZlnG799nDgrKyzECe9HAHdAWdSx2bWhTE76HYqztg9f+y7pGZISlBu5oHWLxy7PQTqf6YHzZfpJ//EKJQNDRPBSIRnwPDobCKoZ2qenjksXI0X4oAkhIwY58YeqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUe036ShRYpcWT+7XLjtFoX+8vYUVySrqHx0vGKXiRs=;
 b=ybusNuVwdgJCoEbiAEpJASBmGfYQKqGOlSTSraJ+M6wqQ7NpEQ+LwqKuCsrrN85A9wL5TT5s5IW/idpjY78wH/B7GY8zrhfmqkN6T2CrblPWjPCowPlvyXN5rnIDPy9j8KZ43LVdOHPQYWj2SEA5Mg+/Qysc9dRFiTiFKpgJMJ0qZUa1lqVairJ0dTLC+wS4CzdX9AZlXZIaLsT7ywfvrdmTT8T95aVSoAk/SaZyXmDvRtB1riXQV4t/ne9d5V3eYWzV/pORhQvVmeh7KItPi9yKq60xOESAfej8Q4MPZWgIlaoJyrNWuGuqHnruh9sFlGLIJY988f3vwtku8GOUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUe036ShRYpcWT+7XLjtFoX+8vYUVySrqHx0vGKXiRs=;
 b=MvfGELWb1FVwhILl/y0fCsx/PczZaNqKbeaX0W2lqlIyxqtf/PAOxJivYzKnkDCFyjTRj12ih9m2K9NmrEOftHI+c5Eyfqrjgas67B2gfPaeLginfcasZ+XKo0Rkr5pYp0BgZ6l5t88N3Au9brgycUuTFndHVx3y0dtPlUaRHnHLd3UzGnbn7o7LTLOrzgscxnkLrynnmTY3kSIMfWWYvL9iZF8h+a/mhuTe/neihwl6rpWAsUZvKM+ZkOsDEkDkMOAEXNdDMoPf1cXy0TNDUQt4Hk5tzYDZuLkaE5kh4y1OAYs6hLiQJXgGb/LRqU8UWiEQ6/D7mub7iCsELehpbQ==
Received: from AS9PR05CA0018.eurprd05.prod.outlook.com (2603:10a6:20b:488::22)
 by AS8PR10MB6295.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:560::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 16:07:20 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:20b:488:cafe::6c) by AS9PR05CA0018.outlook.office365.com
 (2603:10a6:20b:488::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 16:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 16:07:20 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:10:49 +0200
Received: from localhost (10.252.1.215) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:07:19 +0200
From: Yann Gautier <yann.gautier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Yann Gautier
 <yann.gautier@foss.st.com>, Anshul Dalal <anshuld@ti.com>, Christophe KERELLO
 <christophe.kerello@foss.st.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/3] Enable Arm SMC watchdog for STM32MP1
Date: Wed, 20 May 2026 18:07:12 +0200
Message-ID: <20260520160715.175032-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.1.215]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000092:EE_|AS8PR10MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c795e07-a02f-45af-9724-08deb689df3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|11063799006|13003099007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: PP70IerOWipyEqYTzE7raRgNourBNVrZTWQy+gy/zmvSjstkaB4HI0k0nByT1vQFXhX98hlMkvOcRNa0HF1/opPqm8E75hUkcHlaqwvJbJzHEBSk4QI6eTjSNoT6eQmppWcxcUsaD64mEyTvCXN87+zk9M3JU0Nl2jVIU1NoKcsvhmydUDBenntf32ro2Y0c/V11K3Re4Hw8qngpVsOH8MFoAXGIs1mJ3i7N22U7S6mNxAmMH2Gp1paDjO9dNlKWIRLl0Mn3pJ4cWSn5A51vENMbi5ALKzTdDLCmr/stdp7h/7BtN98T5AMZoAJ3TPciI9VWi53Y7nmmVr94PFx/Hg+r6m2ASDOiekA1PWb2kmppie8aRQ1MFZhk5Nwjc19UxmsJmZfVqNFXiaToAnxGJpZFw8yeOUuyf1e3LLjC+jNc/NUW8qhCJeaMkCHVNk1hk3czd9kfacxKwwAfASG5LMpDuo5IbXzxIJZVFrJeFanUyUFJXapXmm+K+L5pb+P1eM7qLbnjfAd22X3Vkz1j9KUXbhLE5NgVr+oWu0ZyMGcrYULGYe07Hu7FDjesCTda51x/+VEkRuDCxbY5JThReKv6TxXNPNA+uZX23DedlH0FdRxZxu7xQcFmf5z8fPOmF39fExtULO2ohqJlcG12Z6qopGPI+5qLejVh+V0vnmufgDI7UQ2UMuuZ6ZWPiw+9znw8uzGCJ7B53M4J4E0ls2JbL7j+Q3CDrpzsTplZtzc=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(11063799006)(13003099007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XlWJmEQSvZaoeXwB4+dgrvY7/8J7ZvFPGCRZcb+7iVKumQMKS1DP9oFwMuX40K9TRhC0buSq8LgtmCp/4vhqOVeNbabTHlh0qMWM6pPtbRdzg11pzGFCwBtOmwuVCjZQqx2ESkcHgUY4XVhDEFIHmPJwnj3WL8d9COH+hREvX6NSAawPHHVuNvm5e15fBS0rI6g//xVT5zNmDxjRFB92LeSazdJu8h1aVXpfTTdlUGfnEE9OsUrdlv1lSfxvwgDXCxZFPP2zx3Pqgi6dXzu/QxCJyffk5UpfBuNX8pmskfzzQ4QhhKcUVZLWmNI1W5zpvTqXqQtl/tGCsAMvnPIg3DCUvl7K4KE/K9ATsldx4gVLFATiEXe02Y44xuouaSutefbFz5pya28/O6hkubWtgJXsnUnx9IaWQzF9PLJhbrkyOy+IEshfYq19iV4ADbAE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:07:20.4541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c795e07-a02f-45af-9724-08deb689df3d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6295
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

This series adds the supports for Arm SMC watchdog for STM32MP1x
platforms. This enables the required config flags for both STM32MP13
and STM32MP15, and updates the U-Boot overlay DT file for STM32MP15
in SCMI configuration.

This series also requires a patch from Patrice[1] increasing the
CONFIG_SYS_MALLOC_F_LEN for STM32MP15.

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260518-master-v1-1-37fd4df56609@foss.st.com/

Changes in v3:
- Update patch 1 commit message
- Remove CONFIG_WDT_STM32MP for MP13 and update patch 2 commit message

Changes in v2:
- Improve patch 2 commit message
- Add Reviewed-by tags from Patrice for patches 1 & 3

Lionel Debieve (1):
  configs: stm32mp15: enable WDT_ARM_SMC driver

Yann Gautier (2):
  configs: stm32mp13: activate watchdog
  ARM: dts: stm32: enable SMC watchdog for STM32MP15 SCMI config

 arch/arm/dts/stm32mp15-scmi-u-boot.dtsi | 9 ++++++++-
 configs/stm32mp13_defconfig             | 2 ++
 configs/stm32mp15_defconfig             | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.34.1

base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
branch: master
