Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692CFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52994848BB;
	Tue,  5 May 2026 14:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C+/UCBkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A382848CE; Tue,  5 May 2026 14:30:50 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CEC7848B8
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jL4cxgWN12wlPqnRY5zppkTudoG3+VQMitQWORmut7+oW2Cn/hqm3U36IPWZ30hcsEmNuo2COxWn2IzPbg0DRxeizq9h4Et51yzQmg9ZPVJF716k/piaCHbKaPmyD4Wt/RZWBmvwZ8kYCrrTr03Fq2L9fqQ3d+2oj+yG1wObQVJnSh8Baao9F04NQ05LEERA4fpOeKyP7nB5Pwuzx7lk/IHmzLZkPlgaZVVl1XVwOF5NTBmBU1k6+FK2kbevMLeiy6GSnTAxbSdjD2/ErXumrYo5sn3L5SgGK694CER7/sm7RayolwuZN6jOqarW1JvauNlIhvM+Hj06IElk2pEUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNasRr7V3qCN5rAjRZELUYQ+i2yuq5SRkpcoqM8mOMc=;
 b=j+YQ4MjZrgHSkzVwIlwnrkJ5X5VkLe3Be3Hmy6W3wTKNkceWAA8Rr6PAmfPkvjr9KLkfaYERokyVCkEerw5CicBdBD4AnD2HleopQt0kB5y9YwrFTsfgQQj7l8mh7qIrEIIfi7smOcwfeCQyIjIaaC8N8GtEB5zboqXxkWoorLPvlcVwWmFRgTFDLKYSRvIrUw1uI6/wfZszMrgZDGA8aixKV/HqscdgtgDAtDkbz2/9kqX30XzYiPXWyu7LIB53JkSi4DQvhimmPtiaByqvnqoPAPtgx0srv4Mbj15JsXC4lghoofudSSIqHGR+K8qA9Y9jvuCIzaL2P2FfIH81uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNasRr7V3qCN5rAjRZELUYQ+i2yuq5SRkpcoqM8mOMc=;
 b=C+/UCBkGGYpqgo7KewozLyez+RUkc/SyGhNUi9WUswWDEH4dxOMrAtnbh2A1xYhOj7LWtn/yQ9O3vL58tPtVwvlYjkyrogg+qHBFeRLIEnBul+fNvuX22n2F507dxg3FQXpEipJkpGJPdbZ0wFkOCW8r/2DIVH6gGJIkpBvjPNc=
Received: from BYAPR06CA0012.namprd06.prod.outlook.com (2603:10b6:a03:d4::25)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 12:30:44 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::c6) by BYAPR06CA0012.outlook.office365.com
 (2603:10b6:a03:d4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 12:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 12:30:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 07:30:40 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 07:30:39 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 07:30:38 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 0/4] reset: Introduce reset_reset.*() API
Date: Tue, 5 May 2026 14:30:28 +0200
Message-ID: <cover.1777984225.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gFrb0V9sDP8/SopbviY61slgpQa57pNRL59KRQJ/HB4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT+fPT0XMms38Xh63c/qrPlLLtltj62N2SPe/9F+/pzN
 aazI6bP7ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJHN3NyHCba7uD1HZvS5FP
 T35vv2cZdlvBuWBy/LTs+X/PsvTP4iljZJisdvy4+bvYFS2LM8uLY8+uYT4jeVZS20HZdul2xa/
 /5JgB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 9495b918-6293-493e-dab9-08deaaa22058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: R4l7jzUZGAw4vOu9h62ynEPyH874GLmPWWPgj5OFKGtbJ3ACnFvLsDll13QXErlAhytExwq84EoVIM15RKWEm3Q4ssIpExsK9j/kYiDCKD+o1iKeOHs/GO01j+btL6TqwZK9izEt8AAXfBk0C4hUqyAY6Smf7f/EamgjXn63OWzsjnDJFXy1jwoB5ReYa6i5icfe+3fe5wf7byxW8oPBc5shiH4jmrGDze+5xkYaVpa6EjeON51VvcQxDGxXsp5rKRqsfIbSKkZE5eukmY/v5/YUXCmuKwP7BjoYOLrj8yg0Avc8EVrMY1Xyq7ddBRY/dXeRGMd8hQ55SiQ2ilhzdIoqsuCcSqNz/Qm7Lj6iEF57WU687oFMXHv0kTvQVZBQLF/wk3DxdDNcG74mBH1ByaUG+SJ0PdLHbREO5vskCPnda6g6FCp+aZKguENsE6EPUDRwusGJBNRxnSaSpXHyqig6FKPNApkmKnR4fiZ2C/mHxQ1/gtivu8IG5fjxQ4psZ0vIEqeKK83qCrjJ40qkX5gm/QygsZmnHNxEwYiDPgbGjnqZZCrq+YPoLGnC8zoS3duvinV+HUHdRVoYdcI5O4bUZPODUQusyweWTlbhaMqDFp+Z18KMeNUicqBzGLerg1TwYUkU7pmgYz8aZBUjwxbQHA0XP21thzONeJxVo+cMzH0mQlOJwJG66lQVDhmXJiRY65//iQpzxBKEunpSPwRH7plgY/UOEhWpGWsr4H0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HwnkgnspfnuzSxUD329p1cmSJdUdPhVmNClIrSiozUTS79UZS7pyRa5t7YrD44qjIukk/om52c6/DbUxDOsEZaud/0JazlgtEwp4a1W7y7fZdbpjhHCPy07bD5GDL/uoWiYowBr4lMMGGGEbH8q+vSfjuLWkAjTl7jAimec/RBcRTvwsKVcEhHVIkoSZ8JH2vyh4HuqbiNPTMCr0XMGLdftqupYuF4w16lNwM/O2MJceTfcZmZ7ESjyrr0CqfKwMC7Z6QzEHVIHyEkIqgvf00uec2kPrM2ADfRAYUAweEglwZMPIXY62Zxgu0eUyC/TE5fE2iooF5HritsBnlrgKWcQ3wiyRsQqH5J3hfd7kONCeima7tAdNo0fyw1CFU9RCjVTC3wyJFaLR4dR2A0+BHMLvfVF9a8BC99pTlLycCe82Mw6+eYgzaAhniIS8MftQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:30:43.6063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9495b918-6293-493e-dab9-08deaaa22058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569
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

the patchset is adding reset_reset.*() interface which is common
in Linux. And implement it for ZynqMP.

Thanks,
Michal

Changes in v2:
- Add delay_us parameter to specify delay between assert and deassert
- Pass delay_us to rst_reset op so drivers can use it if needed
- Return -ENOSYS in stubs when !CONFIG_DM_RESET (like clk.h)
- Fix line length to stay within 80 characters
- Add reset_count field to track reset pulse operations
- Implement sandbox_reset_reset() for rst_reset op
- Add sandbox_reset_get_count() to query reset pulse count
- Clear reset_count when reset is requested
- Update tests to verify reset pulse actually happened
- Pass 10us via parameter

Michal Simek (4):
  reset: Add reset_reset() and reset_reset_bulk() API
  reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
  spi: cadence: Use reset_reset_bulk() for proper reset cycling
  reset: zynqmp: Implement rst_reset using PM_RESET_ACTION_PULSE

 arch/sandbox/include/asm/reset.h   |  3 ++
 drivers/reset/reset-uclass.c       | 34 +++++++++++++++
 drivers/reset/reset-zynqmp.c       | 11 +++++
 drivers/reset/sandbox-reset-test.c | 14 +++++++
 drivers/reset/sandbox-reset.c      | 31 ++++++++++++++
 drivers/spi/cadence_qspi.c         | 16 ++-----
 include/reset-uclass.h             | 12 ++++++
 include/reset.h                    | 41 ++++++++++++++++++
 test/dm/reset.c                    | 67 ++++++++++++++++++++++++++++++
 9 files changed, 217 insertions(+), 12 deletions(-)

-- 
2.43.0

base-commit: 57460fde4ba84d67de4066ee1141e89e8139ed23
