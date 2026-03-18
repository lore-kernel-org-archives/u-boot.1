Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EE5103E177
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5913584297;
	Wed, 18 Mar 2026 14:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e0tyyo4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96FB842B7; Wed, 18 Mar 2026 14:25:56 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B800F8428C
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWkeTdVt9UmMgqw3pMqtMbHbcpNhJqS8QpQ/yHTjs4wQ0R4kSDQDF2FT9aykhGta/Sm/GkjK3szHHq64WhitIqfrOdsQdu6K+A7sCF0DAF9rFmpODF/bQKRNUlwwwmLfL08d3wo4KtXQGJ4NaojhGCnu9b0/asxcNGWi2rWLVmXcq+0oAig889lsoNlpUbYuamEFM9lHw7S5AwqusZ9aCWq5Tk9Rvmd/Jh1FZrhf/DNg6QIKLdgApg2vw7ZTbXCQTXUuctuA/9FUzIEJY67mKOvhrPSOxojvB17ymK5oUFvkNZQoSh3mjI/YnM4qKB1stvS4iC7GZaYHsMa+Vx48IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2idZQvoj7JcDQ8d+ASM96keYKVO8Y08LGZTBuiuMAco=;
 b=aS0OldpD8ntA/Ex+XiGjPkEXHFCWIl4YtFFwWmjEfMSZkIe47VHW6OehQX9HYkwyJwbwxPi2AifqxougTzGHGDv9b07EQGAV2FHUOYzVP6+2yEcFfxDTbZX6+RtQ3awn2TUCmtDx1QVYVT//67RrT2KlQXkDpRyDQoSWTeNTo2GbWDPS1Z86cS7FdS0YBE1C/rC9xuaQatAjUZHf6whpcrSFGSeheSXCqxx9O07RXMh/KUQaj1MJIDpGDvLLfmgt5X8wQJuG2Hl5IW+78WKVLILSfVQJtlmkugOIzDdFHL6j/HqdVfmQ+RsdVtQFPqao70ekmMfZKpxth78zGQ71Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2idZQvoj7JcDQ8d+ASM96keYKVO8Y08LGZTBuiuMAco=;
 b=e0tyyo4ESsBR5+JxCo0KFmJYWgoUW6DGuMFdeBjpICLeOi4J+L7K/ndIN68beIM6cq5RbFms4K0MeCFGWgTnDEGDa627S9eR3xUJUm8dnhm407EdvLD/2F4vIxKingWlRc5a4ZSNpr6Ky9mUmd+vjV4faz+wocJyBvaAykBk0qY=
Received: from CH2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:610:50::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:25:48 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::eb) by CH2PR16CA0008.outlook.office365.com
 (2603:10b6:610:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 13:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 13:25:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 08:25:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 08:25:44 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 08:25:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Kory Maincent <kory.maincent@bootlin.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 3/3] fwu: Move boottime checks to EVT_POST_PREBOOT
Date: Wed, 18 Mar 2026 14:25:11 +0100
Message-ID: <0d7293676b1e644b9b9ee2e45fb1ed10337cef31.1773840306.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773840306.git.michal.simek@amd.com>
References: <cover.1773840306.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JGr8nXWnwZuEoGEdXLcS6H0JeuMU3j8/ahHXdAKSpZE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTuWn6oXZXxYOtL21yT157KnAsyv5XmhBrvcKk5dnp/q
 9LJp9OrO0pYGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAia6QZ/srvvFbXbWD11oIx
 oM1+t2MOj5+sYuny7DnvOz6HlHyTi2T4sbfonkfcXtn2qV0LlV2Svwj47HLSuXRzRz7HyrXfT39
 mBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: de10b6a2-3968-4b02-30fb-08de84f1dd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3Ownn4fVzu8VHRJnLoSRpIHzXUZ4LTSwJcj+Suxo3s0kton/xQq/sxcthozsxaFyykDMoyld8EcQtkKbt1eYFUlxNhYbptU9f6Txc9Oq6kbKHe0RDDirstThkbDjhMNbiUfKF5MGrhopMBAH5XQTJ6RHEwNMerBOHqHDT4KfimmqkhESnRTIUmcvuB4kqwAfrut/DW0pF4KgyNexa6cH2icskSN2YPcH9r/k+jPcG34sP9OFaQHjiwg4+TRp7as39fwht3m0mQPwLwqvQlivIr3WashNefKAX4ELN8iGwr19vHgQz5a88L/9Sze7R6o4ACQwmjx262nA1G5decY6e2ykjqCKk3LRZRqkIDsAJHin5mCSA12RSyq7xheDf1u5hHF+kwIGabUO4fYNmKX6H/Yjl9GzMGMWYtWKSJ0t5i3FydG4u31xoluizMtN9rYSQRwGfuKRsHbb3lHlayPtfgw0bPnfQe+INhkwpLdhFz87StWU7MIrVha26jBRp/UdqSONbv2QZUZszKNHB3Vd6cl8OGlFMXyQkV/xdqxwVk50vpIuBn8fnTqe+5/l//YDhd9tnhkf+TkudWx642ETsxBrgHwaVeXKCceusrhdcd1yTc0bhfBOKvQb78uUckZNKqi5RYk5Oc0XtZMGkW0JuS0XubU01LHeAzujHAqwfBiPb6TH943uCtZASwO3jZmBtx5mRVFCYnb2y4yVtM/t8Qdhwqk79RnitaGCeDg0EjkoywRjJcm5oqVoaUEzl7rJXxbAIoYMGUZYag0lVicn7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 101iUkk5lIW/4OblSq7IyyBsRKJiFdj1040NHqIS3F4NpKPuuz1Odmsy3s0zIUtJv5vu7hAMsrr3rny+AGaz8mykpOrDvhYRRgxQ8tItOFhyruA+eOUSsMqPZ0y5xptZbagJ1rYiEfMXxmk/S3RkS8unbOsN8DYAqm6OI5LPH5aGPTVit9hz/7E8Vvp43wa4wZIseYvsK3twbensSQgDZYDa9CPQAOfeMB36xiyBbiCWrJDIBQdJK3No2LnfGmhAc2jmRYZQdZIHvawVSBbyF2h933anjfGt4TG1OWIaeDh5P4N/QUmnItqC4/37ZGj9QBggxDfamr+Jz9hPxl6BpxBHJx4hMkTE2iXUTNHSXet/G7rVlwvTUuqfb2zI+Ik6EJnQzcA9hgGNnbFrLalxxMIO7gZ6LCMCYipAaFuh2HmHCS9bsmgHGc1L9s1D6Fv/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:25:46.4006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de10b6a2-3968-4b02-30fb-08de84f1dd1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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

Switch fwu_boottime_checks() from EVT_MAIN_LOOP to EVT_POST_PREBOOT
because there is no reason to call FWU so early. FWU triggers EFI
stack initialization before all devices are visible which prevents
the EFI stack from scanning these devices and adding them to EFI
variables.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 lib/fwu_updates/fwu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 37c613014d18..e82600a29a40 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -796,4 +796,4 @@ static int fwu_boottime_checks(void)
 
 	return 0;
 }
-EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
+EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, fwu_boottime_checks);
-- 
2.43.0

