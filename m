Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802ECCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BAE384099;
	Wed, 13 May 2026 11:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sXbs5SPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE2F83FB0; Wed, 13 May 2026 11:42:27 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 953528341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObMihi5vmSwpOoaJEmUFzaHnz1i0mls950GQPSs5bFyaSy65oZ0UOACFn1k7w5Pte1/iCRcYk5YchW8RzTucSgVouY5ZKEwCaIjo77XJG7g6sI/efHUFEZNJc6fUhrYyGGTD8/Ol6BBtZL+pRLuMAf+166irDrlcEiNXr0bsm70CgUuSw8ddOBg3VcFmEwuuq181XOJlgqj7ObNcGB1ZZGOYpUBfXWMMDxlmBsC81bBdWA+lcjbyDa46DOJQQeWLSGgWMYPe/PB78q/6ZLBNnZAcLpe9M+uPyXudaY5iw3hzGX7urQ5sw1CCmphTZQ33XoTNZ/FmqzucNr9g09gsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaKi7nJbdgZzoKnJno5F2XifDvstxd4YQCS15tJETDc=;
 b=aWLvxc946TASQxTKMiXFFhEY0NT/aAL9HbTblE2DfW+V++x4vYoX8FAnFFwNcDkWdQGqcfcHONeoScD4RBypm5PiN8NYvq1kHteLlhJl/4r2RUcuFy5gA4zdrtCkWDzRd5IPz01yYIlxN5IkfV2I+P1aWP3F5kGTYmrRTLVqN1+kvjEK0WuV/utLOJ5s7M+Acxhb0mCAAnZty8QLbP20mHyqXXNPtvdRcxUolETfkY9IBPp3rxnHZTmQgfy+/BGnvjudJySkF52mEygVymH3VFyM1lHHi7C93v48u49r0bqkSSx+VkrV4OFQ8gZGYvREU1UaFNEtfUMKhVqLk24VQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaKi7nJbdgZzoKnJno5F2XifDvstxd4YQCS15tJETDc=;
 b=sXbs5SPuzd2d6gsfJI3DEhVky+l59TY9prYT8j3AYBX4HzBChM7j+yscol5FFgWVQ8FRfC9Qg5i8KlTM3WbIn1lFGu8gotyAB1ste9H9bxYkdeZcQ58DtIWbhNRHuhD17fhYUOHcCkyQdHt3qJOXb50i+ePz1EiHgyEJz/G80kQ=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:42:20 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::c8) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Wed,
 13 May 2026 09:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:42:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:42:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:42:18 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:42:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>, Lucien.Jheng
 <lucienzx159@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Padmarao Begari
 <padmarao.begari@amd.com>, Rasmus Villemoes <ravi@prevas.dk>, "Senthil Nathan
 Thangaraj" <senthilnathan.thangaraj@amd.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 0/5] reset: Introduce reset_reset.*() API
Date: Wed, 13 May 2026 11:42:05 +0200
Message-ID: <cover.1778665323.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=vBlHB10Xe37Kvt3RHUP1ZCGS5yR681ewbRQeN5Em6zI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxuOd/KjLtlEkUnau+1j5SKaTc41p11YGK3mNPHkzz+
 qV0TFevo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACbSzsLIsOvpp1Vi80OF+wv6
 dDz67+5VWtmc/+EXX8nlKeUVr5zvvmBkeBOjzVSy8uOC0x8btuvEpah9DNZczG5kPP2GVPq0wwc
 e8AIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb289ec-ba4f-4671-aad0-08deb0d3ed0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: q2E9vxJif3zMeNrHVDmw1bAOX767UxKT26j7jrKmSqWE9rgOwBVhb7tEj4kAwNsxk5O5ofeO+Gt7oadx6JPixY48g7NKLKfifVHup3xvXAeVGE3KL45NAUOymTWPxUmwxtwNksHQxYKpaNGdlRr94vFENSlXtQgj/CjRUa1jwhnRi0ouvSXN21PPwA8U4S+tY+vg8huges9r6UDx7gaDvxI8t8TutVX6M56E0c2fQCLMNfctwlFFp+viOgT0XvqeJCx6kRaW43DdcBjl4oTWBMgh6cuInp/y64W+D43Fcvx056idAjaLm2bu8PknkgWrxgszNrC7FtwVJEgAMaxdd76H5Kd9ju0m2xi5NqxSGtj5zst5sdC13ul03XVX/jj6WGbmOo/uOdymqs++BsxSjFjhISUm8xIqo00RcWwCPy//cicVKFtDcGJri8fVMuh1PBs3Tl8RhUm88b98NdHODzvmi+pm4mPNoIVJ89Xrx9auwErQeWz7oqXA+0+nhQmX1DZ0U7aXpHBkUNPHpMYF0abrLovxOQTJZ2VetE7gqTjdsTQtWpWD3bba0kVyVFiFndjS8o4A1gZgB2a62+xBMn/LyEk4VWRcv6gd52snDhTchCuubz0pLlTK8TZmmJvkYTVpyBVRvPHhZwBkXY+OL+XjaWCfyiFsGsvlNg3gO9tUR1T1Q4Qxgsf9uQXPcIAfseL8EMiMyYYNK2kfru/PTwBSmKYF9eGnaOXmQFiVBMk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6v8EcwoUHO0hu+/+Qqqz8ZBkBR2Gh+dlnZ2UKbMUlbXFi1AXQ8ltfyEhHRzJZPdpmBZMkp6WT30zL8uubyFaJiFX3b0yp390eQ5EISlwri+x1vkXyHAL8sdRxqmsHjYzIwRBfjG0zvS661Dxp/sQhF08SkhMlNW6PL3ogz5oAS6CEzgaK4deyg7ZKqhcXXpa60ltSnm4AQsAHJl/Y74J/vakXZi16K71QUqcPRBLimoURvDVuik/m+736qeVk0Ni1Yg3qD0CqC3pZKHjP2Vs+n/F3+gmufhsYv6UoDloOKuiK8A2eQy3lojK5dOhd1/kqxqBWdurrS8Htkt6MDqf0U7N7H54gW0O2R/glS72G6nRbxJjDi8zK39bPxx/E/Up4GAl0Vq89hTmnm7TCBwtYd3HqiRZa9SdVJX+4RvBNcKSHmrBQiC+l4mQQDcz9lx5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:42:19.4390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb289ec-ba4f-4671-aad0-08deb0d3ed0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

Changes in v3:
- extend function documentation
- align commit message with implementation
- new patch in series

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

Michal Simek (5):
  reset: Add reset_reset() and reset_reset_bulk() API
  reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
  reset: sandbox: Cover reset_reset() fallback with second sandbox
    provider
  spi: cadence: Use reset_reset_bulk() for proper reset cycling
  reset: zynqmp: Implement rst_reset using PM_RESET_ACTION_PULSE

 arch/sandbox/dts/test.dts          |  10 ++-
 arch/sandbox/include/asm/reset.h   |   3 +
 drivers/reset/reset-uclass.c       |  34 ++++++++++
 drivers/reset/reset-zynqmp.c       |  11 ++++
 drivers/reset/sandbox-reset-test.c |  14 ++++
 drivers/reset/sandbox-reset.c      |  58 ++++++++++++++++
 drivers/spi/cadence_qspi.c         |  16 ++---
 include/reset-uclass.h             |  19 ++++++
 include/reset.h                    |  49 ++++++++++++++
 test/dm/reset.c                    | 102 +++++++++++++++++++++++++++++
 10 files changed, 302 insertions(+), 14 deletions(-)

-- 
2.43.0

base-commit: 36d4c653580824b16574560b21d4401614d8b68e
branch: xnext/reset
