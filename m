Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DD2CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82BE08469D;
	Mon, 25 May 2026 13:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XOPyeh2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82441846A5; Mon, 25 May 2026 13:46:10 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39258460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKy7BlMcv0ef76/0Fb+pdbmfMQTMyXq6I/VAhB3B7xzz51Q1RkBEiajxBekav+JRqMi/hTwErvF1gA494CdEIuGD9cUNPexGNwp8FtdqbRHCyjZDs8UPLiDTF1RqXGpu/HZ3nRZAMmfx0GUSB8g++jhp88rSRsp8paheKAOB/Wzv8Flwe4BNa9ZZUBChSPmp+tpjAdvOn6GPe4v+j9cdYUPuisq6/ZcNW0zDTTSSTHawo9yqfKd/AJTzdu+jm/pdZ4aBZGkerkSaO1WU//aELmyzRbU1C8o16eVEbeAM5yRzBK78ljaomW79Sn9CaMwaFcwpPaxtnZwVZ0s9r8c0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gpd6awYBSOoJdeesjVNCNrtm4e4eW46SMcQjibItJzU=;
 b=Zm/oFg3i8zbINTzIFYxRWQWHxr4GBAW4L3CaajlFXEqTwSm+8vIR4kHYzG8iiPYTG57+4fn8y+euH0nwdAynmH/hnrjrvc+liAiHp4T7Parsl40uspPL4TJ8y/+TfPvWShZQ2uWy4UBHTUSpPRziavuCHi0i0f1+sJSpm30kQC2NzttS6Cu9Lwqpv775JGgI/iltyxWeGEIaSDtk5mzuXnPrAWvQCU4mPB3qvX9JRs5vZ6vdMbQLwAM+fo4ThsYgZ7poyzvmK7vRc9Fl0VPuBaXYuGJim2MXRMBCWcW4mLzUzZV1wQCr0M0ALwQKwooZ3D4QpRx2U/tLRyDiQMx9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gpd6awYBSOoJdeesjVNCNrtm4e4eW46SMcQjibItJzU=;
 b=XOPyeh2pgZnfJmDMSPtJ4VBgixkjSAPsdN9p5KjEeI+GjqgIqN/N9Bqf3kt2+aBbwOlm9fN5yT8958x4RQ7mVBMXnIQcHTMzd3aiPKtsahmyAFv40kyO1IZ2ZsBktKEdMBll22g7CNeAwBvnBZqydMoz7jdUTGWxrJjwiQNcYJ0=
Received: from MN0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:52c::21)
 by BN3PR12MB9594.namprd12.prod.outlook.com (2603:10b6:408:2cb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Mon, 25 May
 2026 11:46:04 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::28) by MN0PR05CA0017.outlook.office365.com
 (2603:10b6:208:52c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Mon, 25
 May 2026 11:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:46:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 06:46:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 04:46:02 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 06:46:02 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>, Lucien.Jheng
 <lucienzx159@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Martin Schwan
 <m.schwan@phytec.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, "Naman
 Trivedi" <naman.trivedimanojbhai@amd.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 0/5] reset: Introduce reset_reset.*() API
Date: Mon, 25 May 2026 13:45:41 +0200
Message-ID: <cover.1779709539.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MjfeNiWxLkDKWhRzB2uNU1bMt1QyQC2BmZqjEWfzLdg=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSJmGXnpUx4brmsW2Df1Kw3jyZper8TSpc11jtae/j5L
 E2Vzm++HaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRJk+G/8Vzj2laai99yJK3
 +d3mGLN5nziPsjPk2ood3ziLxVPARI+R4YaxIrPiFd0Ke3t+0XNfiqcFWQuxN8p4sL5m5q84VDO
 FGwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|BN3PR12MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: e81b5aad-61a4-4586-6c2a-08deba53336b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RW9J7kcr8U0aAVyiCzdB74HfptFFlsEnsnn71Fcnv0Pu36tdNghlMv15Rloh5HdCgkosx3iWR++152AEoHJzxxHLPci2K534fAsg3DwLSZGvt+pNvEpklhUcILREOPx+g8KzCnwL7zSZOb5JGIDSSDA+WA0pWrRda3S4WzEcflwPQwGm8gI/Piq27+In7lhO1rSCsRVgyufY5eLs0UcXsPOql41T9pEl/kwXfzzJY+Jdnm9ZVcDZjNXPyciCujEGL54leKp6DjVuP5M2+pBB+5iH0tCHtcdpCVQ4kLjjFhw+WtQFpEzExPW35r4JPGJcF5tOrEFx5FcmIH12B2+nPZfqI6mxIU2I0a/SPanVPl0XyLn85uX96ySiLioy9VHBEgePLHSVv79G2KZRvTGkDqH6vhS2T46e+wBvvrssogFzyq5fBwiIhp2zgNdnpVMgbtudvdxqtiY+T2czIhV4Kfznn5lgOKgNAOlG5FUSubxdIaiIjeEF+xYotu3dgjc2uAUUgPxf03Yfx4T9TNEa0AAGMP27OXCoeDWHGdLatd9d/rJWvXVIHSAxzExMPOmE0OtK+kth/h/FI91HaOagcJpFP6QVt81ZghrKRVQNon1dMnIH9IrSK2wjiCTk9aI6s6NF9oHzYZIel2wh/eKadT/YbMWz94Uq8bIG2rsyRVKTeu/ZkU0JPcGGEI0Cvr6LWMpJdypHF5Pm1POoia4Eb9XuRBjdmcVELdNQyngTBQ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(11063799006)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iPjhNrzeAIzRkYwmsc+C8EwsY4mBRlrv09625c6u2vAvdugP5mc8MRk+OdUNSBq/85lZt01qY61l2u7HG3eSkG9rCHYpKB554vzESUZxva+tkOANyk8kjDFFvgkAuwXnT+bEJdkP4Kczh9msFqyVEiMwLvJeN9YaHtxWmSylhzWixCwdqQ05ltSJ7nHycr/Dk0mkVDS23KF/Yz0qf+WgyrsQPXZLOPnVqVfBsjyhL9RpVUPv8CgF7NFbtgfVj9nwqznX6Fe76vRRi/72ZiePIO/3OAqPDRfdjllKr0dQhlwSkCq+mlD+mIMb5x/HEfKgWa4bejPDGpmW5HhfXrKYBzgVjBtQgakAwXc4UAuVfuwxQbDYuHg2wIBIcmZ6W/k8iNkTDJx58J25NOv7u6NrnwLvtC6I7/MaYU2Esyy8j4K2zwl10q8TWm8beISbTAvc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:46:04.0499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e81b5aad-61a4-4586-6c2a-08deba53336b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9594
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

Changes in v4:
- change reset test logic

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
 drivers/reset/reset-uclass.c       |  34 +++++++++
 drivers/reset/reset-zynqmp.c       |  11 +++
 drivers/reset/sandbox-reset-test.c |  14 ++++
 drivers/reset/sandbox-reset.c      |  58 ++++++++++++++++
 drivers/spi/cadence_qspi.c         |  16 ++---
 include/reset-uclass.h             |  19 +++++
 include/reset.h                    |  49 +++++++++++++
 test/dm/reset.c                    | 107 +++++++++++++++++++++++++++++
 10 files changed, 307 insertions(+), 14 deletions(-)

-- 
2.43.0

base-commit: 987c93fc68a641cc735c9828872511a947e54191
branch: xnext/reset
