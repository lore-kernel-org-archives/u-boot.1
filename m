Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFFDCDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62B40849CE;
	Tue, 23 Jun 2026 14:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZcxNtXBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97757849D2; Tue, 23 Jun 2026 14:54:23 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F169A849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzu9bi5DQ/lStvFmwGf6TEh8WM+ekIgEI7jnmS2gbFP+5B+UMfLPDfP9OMDTxXPnBPL2pUQC+VyJOLr/xJYIkNxvTv/n4xXf6VtDQFT4uefbQKWbhzSyGVYau9lRQlVQs4bybgzr/1fUvpgquzzbDBJtRRLmVT7EEaYTlfN7wZKVvkIGN9M0EFghhRbRnhg5w0mikNswL1Nt0ioMHO2V3jWUZygZ26N3VR4i2SMomIH6MqTD9yv8pJNGr7rgsnZ3E5/iYinrwTz4E/fGas3+D/XnAJuz4cOTuY60wjpnGOFyu+1VyNY9bucgeLoIA6uReFFmFz7HuycSSUHwag0zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy8qjGoCHbS/QgsnIAjAh4uwo3xv/h7lgaJ4OIaxVhU=;
 b=BFEVwvtTkz+ef+nAFjm4QVa6klefYhYa4Eg+BYOm3YkGJocuCXYVsmEEyH4SOiqs85srvjfA33ivx6Z1JJh36zDR54dbn6DlvJXWFJYi6PMcAJBDjh5nts9HQi8/BssPczIdBL2e97zWB0lDGVVxNqm7FJDwFffd2TI/ntIvB8TRcbGlBtU6TcP9rj6VdjRIggwe2fr9SV+Rpvta1av510IIKNTP+gE+VVr80vhAUxwmq1sVHjF+9J3l/HqMzNV75CfrN0jtcrQ2DxehZLrzI7YK/KUjgHB3M6IGKl9+9vBiyQ+WHUVS8ZuGYnlRpfTt8zqQDzcZMMXQT93XqhF00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy8qjGoCHbS/QgsnIAjAh4uwo3xv/h7lgaJ4OIaxVhU=;
 b=ZcxNtXBiqN5ju4tlNucZ7d1a4XxsHWoH176rI86ox2ZWq6OpvmTYBTE/vjA8rG8a+q8M/uxa7ZksYMU6c4biuJ3yOS/FCYqsP2daQBiESjs1cb3gPFkhv/7SKZYNzN+i5zT7aUHoxrnKQz2dbGQ6OsxAeRaG7rvRGdOwTgZ05AI=
Received: from CH0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:610:b3::7)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 12:54:14 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::97) by CH0PR03CA0032.outlook.office365.com
 (2603:10b6:610:b3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 12:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:13 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:12 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Francois Berder <fberder@outlook.fr>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Neal Frager <neal.frager@amd.com>, Padmarao
 Begari <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, "Sean Anderson"
 <sean.anderson@linux.dev>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 00/18] arm64: xilinx: Decouple firmware interface
Date: Tue, 23 Jun 2026 14:53:25 +0200
Message-ID: <cover.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=mCj483Hy+HZVyxl8DxEb+0jHAmS7lSvxLXYOeRebDjA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNd51PBdwR9jWwkNVhlXKsOjhAjvdjJkOFep/juxRN
 J6n0ZnSUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABMRuM/wP+1yQKeSyfljj4t2
 7jcRac94kKxQfcd/ycakkoML+fmichn+Shw7s/fthxU9PwV6vQ50v2AzXsggaNKvrL8s8azra/U
 LTAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aee3427-74b1-4e79-ce03-08ded126877c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|32650700020|376014|23010399003|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: yQvXnhx2Dy79pFp7E989jhzhHstJVoBGFplA1Tp8CgNiYFNsH0iVAiPyso2BAqjsd5Em/Hx46UCkAzdvH29ipYO1lrO7Av1R84ORz5CoWrM9VmfhH5EaV5+IUQLarNdE6EUGAlB4tweoKvG/0tXrwFkCeuKmQ3TBlvRTwXJw4j0IbklIGQe+5j5TdE/WMhNpFNwb8NY5FXj/uo3fstBfpUKeBbqPx3u+Ilry9NdbFDN6+HVPRFPTVOn0TOTWa4/pbdnXWVRIVhu6XS3HZ6Wlyx0aXrY1wA/N257aUekY8sKBD+vf6NimZXhOs22ZndnDl1/heGUEDoDjxSxW+3ufQazRlJCTT0qIxVIKc9ffaPH/8PtgQN/V0Alo88ny4GvrSfhEMy7MEg+IDqe6Mnn4NU0SL49E43s/KU4zKeK6BPtL+ysEYKSNcZyLEplglphXl8JrO53yuolUjrUQdcHDtVB5PiJrOm8kFsE+qSCTs3EeqCBkubj0vr9dC29MHAfMDkAPMSROjnXklopwww+UaLiBRn7C1i9ROxGoh9LDnsGZxnVaap/NssQeBUVv7f2Sev86UOewvfSbET+6RlLyCWTL82PuIQ3qQOZsIh8aHy/Byv9lzEnPXCku/Q1dQ2XKT/+ySua7Fsyrr8BSlQAf9QfdsRrzmq4FCVukvJKtwejk+uWLRS4oki/QK77pDl9clb6z7a0BGzyyfS6J1AWRFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(32650700020)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8IQfGgwYOMiu4R8liyoEDlGeW8lCJzKjvJe4t3qiv1H4yHrP5+HA/vnyWFNeuavjyr//StIqyM1tlXVY76jz6N1UA1I/bKwUxGyUVnMmacdt4hNP8fpl3Zg1sXTy+C6oOR+tZutt/gkMCWprq9CJp/+cJ5xppJ+Bd0iAxIdNoDrVQkgA+ogTaWiiNR212oi3MMiqM5DW/JwXq0wTamFo8mGnJqNCUAP2ER/xwWm7ODKMM1TIQZ57iNrcvh3oYWXTeFj/5g2a0KVJuq6rfqMeZxwDFHgWIwoEeaH/0ekbq1Gyvv8CZzqcjtdecwIpEUNg7U7lofrQx+Jjt88NTMVpkxRtIXa5JXLzNQQRKLWcOiTvX5t64kmjurK+kIzNAJf2RqY5tg0BG8yT8aa2ENYbmGB5AAr8QCf6ZHrN1qYbtAJTAfZRePUvDAUZSKayYWY0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:14.4715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aee3427-74b1-4e79-ce03-08ded126877c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

Hi,

firmware calls are spread across board functions and even drivers.
It shouldn't be like that and it is time to clean it up. Pretty much board
or drivers shouldn't really have zynqmp_firmware.h included. Generic
functions should be called which have MMIO version or firmware version when
firmware is enabled. This is the first set of patches to achieve this goal.

Thanks,
Michal


Michal Simek (18):
  arm: xilinx: Guard mach sys_proto.h against multiple inclusion
  arm64: versal2: Decouple multiboot register access from firmware
  arm64: versal2: Move bootmode decoding out of board code
  arm64: versal: Decouple multiboot register access from firmware
  arm64: versal: Move bootmode decoding out of board code
  arm64: versal: Move board_early_init_r clock setup to mach code
  arm64: versal2: Move board_early_init_r clock setup to mach code
  arm64: versal-net: Move board_early_init_r clock setup to mach code
  arm64: zynqmp: Move board_early_init_r clock setup to mach code
  arm64: versal2: Move SoC detection out of board code
  arm64: versal-net: Move SoC detection out of board code
  arm64: versal-net: Move bootmode decoding out of board code
  arm64: zynqmp: Decouple MMIO accessors from firmware
  arm64: versal-net: Deduplicate SPI bootmode handling
  arm64: versal-net: Simplify spi_get_bootseq() bootmode switch
  arm64: versal-net: Do not print bootmode from spi_get_env_dev()
  arm64: versal-net: Look up eMMC device in boot_targets_setup()
  arm64: versal-net: Add mmc_get_env_dev() and deduplicate MMC handling

 arch/arm/mach-versal-net/cpu.c                | 149 +++++++++
 .../mach-versal-net/include/mach/sys_proto.h  |   6 +
 arch/arm/mach-versal/cpu.c                    |  68 ++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  16 +
 arch/arm/mach-versal2/cpu.c                   | 143 +++++++++
 .../arm/mach-versal2/include/mach/sys_proto.h |  14 +
 arch/arm/mach-zynqmp/cpu.c                    |  69 ++--
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |   5 +
 board/amd/versal2/board.c                     | 133 +-------
 board/xilinx/versal-net/board.c               | 295 +++++-------------
 board/xilinx/versal/board.c                   |  66 +---
 board/xilinx/zynqmp/zynqmp.c                  |  18 +-
 drivers/firmware/firmware-zynqmp.c            |  89 ++++++
 13 files changed, 606 insertions(+), 465 deletions(-)

---
base-commit: e01bb5b8ad09464b8cbf9c4186683e998c2d40fe

-- 
2.43.0

