Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F02CD13DA
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 15:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 323FE8063E;
	Thu, 30 Apr 2026 17:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BWMzEN3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F34180086; Thu, 30 Apr 2026 17:08:18 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C9180F0E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 17:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwLsGPBPeEskzfAI260OO6WpicxIIV2X+Ax7riHPDhifglt57vsfKkX+IGYqWQa7X9IFAdAron0g2eELiORyK4TeCKizMsOATbVFSQsLI8uz0CmF9zGeUCA4r8MMSaMbYVmxZQIYNzLZIdoCSXDFeEgL/xfD9WqIYGbU+KZMiWaX4QiEww4K8rBXo6um10l+LFy+DygLqtphHyxKbDJWV3zJMWc2+onxpcHWXy81F3WoEHr7kP0WBEnqjOhaKc8O35L1avMVvJMYKfdLz/hz+KndB7fPrqwmwSxFLZ749pzKy2pfo30iqQ1BFP2Ty4vRM7BYCwhwzv1rwlwPAUZ0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuXfD5b701g7uC6fGXivw1TFf6pK6lbN5wmMdU0cP8A=;
 b=OLIodHEmkQto5ZOFV2igNVXLpwydFv4xi40aAPyl1zEapPIU8DBST2JfrCXYW1ot2Rvv7rOnbpiVjUtA+jtPXcwvCj43pGyZ9ndOszgdUkmWNtffLohjbFmqNM+mpwbjjxAz+r4/3Vdcvn4dVUz7gYvIDFkk6kMi/wBkkoggncz5Y5ZCO36z28YTdt5bNB1ZpDJDlTs9J+heEimNwMasTXT4GRwV/MRLTBIDmkn+/TQkvLP0juVr8A+gFBjdYtUFepy4JKXpKFL0tlBPlb07CZ0Mi75kzdqglep19+X9NGO5rHkkxyQXAsGgGMi/sPRObOKxnbZ903DGT479uKuZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuXfD5b701g7uC6fGXivw1TFf6pK6lbN5wmMdU0cP8A=;
 b=BWMzEN3P6+LnmuyUBXsePQ+YKC1I95o9CtT0h3h75KVfNQHIxKD7l/THk8+ddFcYCUDwJYvJBtW6AfXEOoyv2krcsi0Aew02nOjTVFoshG9+e//53V6PhfehkHG69xNo3qE3bDjD22v5mRHCNAudFH+NNju1CL5NQZEJhQ75xDMMfgTzBkS72MU5Zher1vKcNEEnokwTzrU5cbEerMGAOzYKnwq5H9llitRwje9xqdQp1kqc1B3BNSSMfz7vHNfCm1vtn4MyVbtOv+94ZCy162l4GShYHrg2dqW3+NjK4PVVr/FUsICXD6zHr3bIrK5WcDiGpr14ynRD6DJajH2NCw==
Received: from CWLP265CA0398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d6::20)
 by DU0PR10MB6778.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 15:08:12 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:400:1d6:cafe::b) by CWLP265CA0398.outlook.office365.com
 (2603:10a6:400:1d6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 15:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 15:08:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 17:11:44 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 17:08:10 +0200
Message-ID: <b595bf2b-7076-48dc-adbf-c77349f4e250@foss.st.com>
Date: Thu, 30 Apr 2026 17:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
CC: dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.07 =
 u-boot-stm32-20260430
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|DU0PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a80ae12-56e9-4b86-ba77-08dea6ca4b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: IXHVdadmqpkXb7T0kIFyEMSQp8pQd0n6YpSCJhs0sUbBbkCD2HC7pU4Lr71i4Amt2rcMfi49271MYrGKWkJ/YwJ1aQbfGKbLiJ2911xgA68a0Yt49UhSM8urBMM0Yavp1gM6NTyN/yBZlR5jgFFmkR7dgz62uLZdu14T9liGp+39tu8Zr85eYGtTMYAaQT8EqqVOgo0VGDr1crm77fFa2crms4Hh2NORTdudnlVxzodDwYmN1h1dH2LLMWNC1EdcVOUrNQhIvgVjQnypdspS89ov+kTuYpcMTXN1D73dSIOCgo6SkU6aEzQLFZ9QHeTEL3vUp51/1lTnJ6X1/jNmsrc3Kv5VB2ptCUdFDqTdNCUAEoeJXOsERJcruddqlHuejjdAkXZj5WCKO006zY7lIP+ZL32jiQQt190SyswkT29px4G7mAOZ0aUfiQajejdGlhtw4lUnvkCzoG2STSzWEfAtOn9hKuYmZaDaiSnm9Nc6BRctDQKalnY+K3MXCUUSROK27otRMSzSg/PsOJAh220marjiPD7st/G72+2ZHVWsUM6XmkQiiS7qEksROoNS9l9zNOVB/yh1/uT6ZHIB22aaDQPNeWv5UvXfcDaFtIlC4ywAQUubgpWYeVkGOe4L2RoCVhzM2Ah+fQFHaUAY26W431HlgNflupf1kzRNtlDvsPkOP4PM+OjYVZevPm5Fo5K71j4tVA7V71B3BpI3Y5R3x5fPEMheyi+S+RPuUjM=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0UBY6A8l3owfCFzUJwLUYY7UptWmJVJUIJkXPB1KxryqYe24qNLX3RJL/kalDtJXnXrXMn41Awvd3XAB21gDXoN4aGzTYVZk/0f10Qf36UEI+sGfBqt1efRZONcColzNZkFFE3ZIa3FXOltIW87gduLoh16uxsXjcsN0Ae7rQBK5nSjvfJLo0I618n9845yudAOl7A6wz5IfpsmHpfVtPqIXaD3WgYIzIvazAsqHh8YtSY+8A+Dqw4H3T1cxogY4bv7PSzRY9ylQ4hh7t+d9vxm14C+iX27aQs6s2itTsl5s4CkmetCmQXj2PpJW1pH5GzSIvNA4ie6L0E8BBjYneSJqNpp+txSpuYwcv2jbPXLmdNJNXJ+02DjpD9VH+mKVE+AaGD0lyxjOJVxGkNQ3hq6WyDLjwbuATWE8qrfI7K37B4XEGxBPg58u3jtJjLnD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 15:08:11.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a80ae12-56e9-4b86-ba77-08dea6ca4b90
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6778
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

Hi Tom

Please pull the STM32 related patches for u-boot/master, v2026.07 = u-boot-stm32-20260430

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/29940

!!! Regarding the CI status, for socfpga_vining_fpga, spl/u-boot-spl.bin exceeds size limit

I noticed that you recently encountered the same issue which lead you to submit the patch 
13b3502157ea ("socfpga: vining: Enable LTO")

But unfortunately we again reach the spl size limit for this platform.


Thanks
Patrice

The following changes since commit 4433253ecf2041f9362a763bb6cb79960921ac7e:

  Prepare v2026.07-rc1 (2026-04-27 17:03:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260430

for you to fetch changes up to ae1966e2436e69c4bce24c03ed4e77bf2e0ac971:

  arm/mach-stm32: don't select non-existent STM32_RESET (2026-04-30 08:01:12 +0200)

----------------------------------------------------------------
arm; stm32mp2: Factorize TAMP_FWU_BOOT_IDX_MASK/OFFSET definition
arm: stm32mp: Drop unnecessary BOARD_EARLY_INIT_F usage
board: stm32mp25: support dynamic A/B bank bootup
board: stm32pm1: Fix board_check_usb_power()
clk: stm32: Add STM32MP23 support
video: stm32: dsi: fix unchecked return values
video: support Rocktech RK050HR345-CT106A panel
Remove non-existent STM32_RESET flag

----------------------------------------------------------------
Dario Binacchi (9):
      spi: add support for bits-per-word setting
      spi: sandbox_spi: support wordlen setup
      test: spi: add sandbox_spi_get_wordlen interface
      test: dm: spi: add testcase for spi_set_wordlen()
      spi: stm32: clean up buffer length assignment
      spi: stm32: add stm32_spi_is_enabled() helper
      spi: stm32: add support for bits-per-word setting
      spi: stm32: extend support to STM32MP25
      video: support Rocktech RK050HR345-CT106A panel

Heinrich Schuchardt (1):
      arm/mach-stm32: don't select non-existent STM32_RESET

Patrice Chotard (4):
      board: stm32pm1: Fix board_check_usb_power()
      spi: add STM32MP23 OSPI support
      clk: stm32: Add STM32MP23 support
      ARM: stm32mp2: Factorize TAMP_FWU_BOOT_IDX_MASK/OFFSET definition

Raphael Gallais-Pou (1):
      video: stm32: dsi: fix unchecked return values

Tom Rini (1):
      arm: stm32mp: Drop unnecessary BOARD_EARLY_INIT_F usage

 arch/arm/mach-stm32/Kconfig                  |   3 ---
 arch/arm/mach-stm32mp/Kconfig                |   4 ---
 arch/arm/mach-stm32mp/include/mach/stm32.h   |   8 +++---
 arch/arm/mach-stm32mp/stm32mp1/spl.c         |  15 +++++------
 arch/sandbox/include/asm/test.h              |   8 ++++++
 board/engicam/stm32mp1/spl.c                 |   6 -----
 board/st/stm32h750-art-pi/stm32h750-art-pi.c |   5 ----
 board/st/stm32mp1/stm32mp1.c                 |   7 ++++--
 configs/stm32h750-art-pi_defconfig           |   1 -
 drivers/clk/stm32/Kconfig                    |   2 +-
 drivers/spi/Kconfig                          |   2 +-
 drivers/spi/sandbox_spi.c                    |  17 +++++++++++++
 drivers/spi/spi-uclass.c                     |  22 +++++++++++++++-
 drivers/spi/stm32_spi.c                      |  71 ++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/video/Kconfig                        |   8 ++++++
 drivers/video/Makefile                       |   1 +
 drivers/video/ilitek-ili9806e.c              | 356 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/stm32/stm32_dsi.c              |   7 ++++--
 include/spi.h                                |  14 +++++++++++
 test/dm/spi.c                                |  16 ++++++++++++
 20 files changed, 523 insertions(+), 50 deletions(-)
 create mode 100644 drivers/video/ilitek-ili9806e.c
