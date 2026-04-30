Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA67FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017FC8063E;
	Thu, 30 Apr 2026 14:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qH715m3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA3983FB5; Thu, 30 Apr 2026 14:20:37 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B22480433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+ubrWabq2+avnmqw/Z5SFOFw+O2wS0piHqhuNLgGNfy/z8MfKQ4zP+GL7vwcfUw6UiLih5lDZiQ+v3mxPUigzVpiDJxhALNbVm5Dm+fI2JmRbmhTmVZbt5O7s1HqygSoDmRMmT85bc0MsbrWph2tT2YKzUoF7Et998WR8PDDVjhKUBJ7OuYTxnBpKn0u5xCC3SDHl4iaXV0G8IaPef/ViyKjqXUoTjPPniryQSxpoMdLn8oCiWnpG6RP1eBfAXAhRWe7+hSIirMyW1EaK71pUvy5cF6pWJTt1h82xaauxY3UpZ5st0FnSTxm46iFECk6K/M8kN27gCfCRU67F8J4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMZDE/2qu0QdcLJ+Rb947g/c70xVJDpI26wiOzeV8MY=;
 b=VE6Rd3He9R1oZGpXaPNvjsDxmVv+Tn/UGVehv0lvI7xkb1iGXA7yprI0I0TmU31bLxcDoQFdDEpyKOXpoXPZMc3Zymr/sqJzFgf4/BU/AVSSdkx4Xan5HQ7wsB/7JDZV+lWaui8aWHq3BXk/Cd2Fvj2NPiZE7UPfNNjhtSWIplNWVXh3plljcdFJiHvigyqhW1u/g/IVVvqaDDU9E5wU8oKUpZHYDqhm+Q7Ae5+lmwSW74116fNBKgnVVi7Kt1GwnpoUg38Mv9CkrbQzCqA1G8qZdPMD4d6Vg6/m4AvzGEz8P2r9NMaaWvSbghnGIy3JWnCNowCDooo2dD0iWwXuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMZDE/2qu0QdcLJ+Rb947g/c70xVJDpI26wiOzeV8MY=;
 b=qH715m3cZFB+lncLqA7m6YTV4SsjAv7P5jzWuOd45Q6HNEghj56KB4lQPZLG1vw72PvrcPYG/890eT8VH7n5peyvNP+70upVwF4e89UAaDjppo7np1fRhqvDCldWKVmDumcdp5vVgHEFkNHdDijtpqC0YQYez5YKHHht2v0c7ZM=
Received: from BN9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::27)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:20:25 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::bc) by BN9P221CA0029.outlook.office365.com
 (2603:10b6:408:10a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 12:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:20:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 07:20:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 07:20:14 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:20:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/4] reset: Introduce reset_reset.*() API
Date: Thu, 30 Apr 2026 14:20:00 +0200
Message-ID: <cover.1777551598.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BkbsVAOa78bqPcoIWktw/c+gtPPZUumq6k2WFV9WGZc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+9vgpnOJ3lak10VjlvUmsyVsz01miK+peffHesXfii
 ViLNdzLOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAihl2MDEu8K7/PVzjbcEKE
 X9eeVWnzi7eiHzPZXp7Zmd0Z999vQg/D/4wM3ukfJtz+c8U5XIjl95tNTP8vvu9TlexMXuN76SK
 3EicA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7777110f-48b0-4903-3e3d-08dea6b2db82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: nc7Zhirsy0qn5CzLE8JqWP8rde/LNr3anz1XZ1ojSyy4BD1PN/RUX7R6wBf0XslEgTWYUz/3AbqbI3KOapQQVarI14NZkT8YCbksx1asTlRgSb2lqWeNU+H4X3Yf/M8I7lHnVqImXp6NR9sh12ljL3wCHabwdx1sqjDrcoowjWsqyEzx1Gdanh9ef9UX54hmPqpIyjSxdTzjwdGgpOo0RMvpYmqUPq6BYB3Xc4t5I7LnvacrZ9e+3srVmCSPrFRiBCtUaPkg5kF8pGjUtTRDS80ncihNSgSb7mgTVrUH0gL6bAODsjyrWMZ3+zFOY3ZVzFdvKjTX9V0yePnju3mrkQEAzBfz8vdjxQOvdmNuNOkaNOQfwrY/I54vPWwWVKGGqCkNwSsa7eYVf28an1Fwnp9waFyj5VLG+rE4KIUxVKkaY57vi3rsY2O6tmnLJNwQMHmdHDDHr38dBS116B7YHvAqbsJtlr5mdGO4iG9MFbf9HFgUvWpDHNXLFZcneXB+gHkFEcBf86GtjjfCsMoJoENPvAaSvYnBKnSU/1TAk6hVG7x43Cb8noadxJV4qLbmB+8J5hYJaFTHmXt86SnIKrDHByTgWTNtYJ9bElrgGnWd6r5vgKLTyRhKkf033ruILhfhmUqJ98RLbJTcrXlGL20cJY0gJb5nquvLH74GinFlvLKwrpHFw0f5ASLEJ0cnCm39ivtZJlYBxeEvxJWT+xAGqc53GXW7rnAvdaF1eVNcpN4cOs+AxYMXmm3PnUBN4GXFjOVoJ+UDDya+lCWQJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XA+m4NpRWDwUzLIPrqCwchOqjGfvNOTdByk2pN6ixvQ12exKbznZmPa3t1AjhP2rYgLi/sHlAJqm3FJeoff22oBZndzsh+KPrHO+m9AHpH7JwndzGEpeOPKdxhq3kvRbfv4f21oZWfY8gbKxnfL97tBblo1ykYR4R4qKlRj6PBILezSlB6UcmQnEXR3UGJC9f0NiqxkUcyOGbpvvPlcgwqQ/4a8rm4RcOK7X6/qprjzLa01RzQrJqZS8GJHq3WJILlJ3iJcSRVkUklGZd6bXJJkEsxdQkqKmYAkA1d0H6mcgRyYJi90SOmHqlQQyc98j4VTiKS87dZXyqhz1xDU7R0Dw0ztTybgUPC2yy9PJ8EMrWlX7flB5qWDUyadubNq7s8xxNNMGMIGsQIpwogmzhzYj8eMcC6/Ng30OTbyCj/H+1wvbhj1MSD8SyLP3DLg+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:20:24.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7777110f-48b0-4903-3e3d-08dea6b2db82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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


Michal Simek (4):
  reset: Add reset_reset() and reset_reset_bulk() API
  reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
  spi: cadence: Use reset_reset_bulk() for proper reset cycling
  reset: zynqmp: Implement rst_reset using PM_RESET_ACTION_PULSE

 arch/sandbox/include/asm/reset.h   |  2 ++
 drivers/reset/reset-uclass.c       | 30 +++++++++++++++++
 drivers/reset/reset-zynqmp.c       | 11 +++++++
 drivers/reset/sandbox-reset-test.c | 14 ++++++++
 drivers/spi/cadence_qspi.c         | 19 ++---------
 include/reset-uclass.h             | 11 +++++++
 include/reset.h                    | 35 ++++++++++++++++++++
 test/dm/reset.c                    | 53 ++++++++++++++++++++++++++++++
 8 files changed, 158 insertions(+), 17 deletions(-)

-- 
2.43.0

base-commit: 4885b1983ec158ed98e727091be38f7de104108e
