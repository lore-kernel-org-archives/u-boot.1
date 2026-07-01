Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473BEC43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA73284B86;
	Wed,  1 Jul 2026 12:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3PmngINU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F9884BA1; Wed,  1 Jul 2026 12:29:06 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF94584A7C
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJS0+RJN41eEblxKT2PsoBFpBZbh0zU48Kyh6c4AWODFmvrps3oiWPnuERBJ9vXCZUHbC9hKYoCZd+T+IFTxdMB4WKCfpRWRocy6wi4fBw4O+06055V+7Uj8tKHa2ouFpq53j3RbDAeDWal68VXxobPp4JVckWgXwUD3xcEWLa713f/U4YzGkduuOIeaT6+coX6y3bSdK3PxbJzllVhUvTHLoxi7BhaiJX5Pnko+ULC8+bKT9ebCEUb5aICefciKa3ATVSwRbaCsAUGQbCVjrLQSbTgykHDGtJa4Gzyqo/Hf5L/NbTloWZROhIcY8PjwE/dmmSmGOj5BOvVGzsVm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcdcivxhMaJdK9ctk5rPHQLGB/IWRrlX05juJqirAqg=;
 b=qr4+HsWMqEGcubcoGpdJ8bUPwlJmt2relaCXx/FSHpySfEaT2lhYKgU+Pc0FnEnZE2nDpnBrnltvrTGrs+nTuYJ4KwbqDNnYpHGHQqwhU/rt9g9v/knnu9Q3q1K2BaOPZGozlEtWCVEqZJ1zHAdYLEQYMkK1Lr6YV3BtW3ZoXgtpqeV86PREbFR/31mUxw49kg0/mVgBgxZ7+MC1PohBn6PQiCP27VVS8clV1yIIyyx1vQU1UDvOAtw/CeSvbOImJGAeGSRHedOX3sGEpFky2ezQ8hEPeYyL7gfx5Yvuj7nuhb2TUVgSs5tVP+9bQm0htRte+aPigeroYMEfC9TE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcdcivxhMaJdK9ctk5rPHQLGB/IWRrlX05juJqirAqg=;
 b=3PmngINULKkfwrONl24qbnYgBj4CRc+BCF49+Pqn8f6YGI3lqDGgS2ZbdspCCYwbY0+bf4GmkfMsft+BT+SjaLHqwRbwwul695QkEQwMg4C0/HSpY8Zs6kk0z6hCKCFar7Ty4ynu87ebgWrBZof+HdmXLyA2D/auGDdq1LlGZWo=
Received: from SA0PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:d3::27)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:28:53 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::41) by SA0PR11CA0022.outlook.office365.com
 (2603:10b6:806:d3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:28:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:28:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 03:28:51 -0700
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:28:50 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Dinesh <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/4] cmd: i3c: fix list and current needing pre-selected
 controller
Date: Wed, 1 Jul 2026 15:57:18 +0530
Message-ID: <20260701102754.345049-3-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
References: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: c82acf84-1a26-4afe-9d16-08ded75b8c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: k12RFl/mhdW6K/UQYtwb+SysT3m/1GhSk8xHVSIB1azqCAHXF4CamnqQGxm2lndew3uExO8HKE2w9/MIsNR1IJtgeTjeFbUwZQIUhhCJs+S2cU7IawFmV2Cxz/r9CzFtYpNIBqzT5jcb69snxSsqlCHpCxbDxumLRWJT6T38/77IPmt/a3wljML2ev1TkIWF4wYe8NHE1x5203T/VHJdG53bLnXiWGRyhr2saNzQQfFQVtjwmQk57u30QU+UcPCg5sJ3zFIc767s5d+tRpShItSH68+vJ/XY9ds8Bih5SbM77C3QVe33vC9n5g88MySGIZ0vDu/tq1PKmx/PL7AnjMydwL4jabIwxp8SWU4jID3hIruKNORfUSqlHvK7++AKbAdfZiPY3ZSGqg9Q/ZLcGteuoQGeyiB3VH21EEPk8MzYMpDGZg7gamU+rL9Mp06ojmu7Eln7WjOXJMFxYpE0MJtgZ6YaS7FeUKkCp2vKbM6/hup+WAu3bVuYTJgYlguWaWod7nsCPibLlBtFszAnuUwJ74wEc92U3267hA3foZTtIOOEgpv8YaP+GMxTMwz3KzU6oLoanjkrqLWwSWmcc9Xn+VbJr8+nL4+qnEf5YPhoq5TFFtIJtBwYbrbpOngU1Z7WAocd/sBpVGHapyX2tre+sZCJ3SlWOS1f/Ql7PB2UuYACkT3yP+25GZllUwagJ2vGwD1UC5vmOGC6ZTzQeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8Tg3eJuXit+DY8K9dGQIPTk2RNKmwH32WPOPhv8SoztqdvohJvLnTGnj9iphclI+uzv1FryOd9Z01IkcVL6t6lCgO+AImI290xlAqCfVwm4azuUWYRm93+9QJWDmopyYeUZwFAJmt9BJqDOIbJi9HFHtwIx842rOBPjnJnk4wrnP2zPNjkvSa05AR2F9Yky6WGZeQGDm+GmfGiYMF5juTFe4D/f5vZwEqkLx6FDprRO4sJJP4YYV+Oa7MjQRaKU04l8i3QntGUzucsp3q3RvtXSB0SH3Y/NwEDioCzo7AeG3+9g9GfnQmMSbDA+0kXOUAOjW9evEsRnsuudFRnsw40eEYkjrOM1fmwTOsLmtyn6keqVgUJWDxXIQ+XxYE4NurhyMK0PfAuyHu/79ybpuNCydif90JrMUVnWfqA2ze9B0ZMcH9fyNteuQbcLOXNdI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:28:52.9667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82acf84-1a26-4afe-9d16-08ded75b8c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

The !currdev guard in do_i3c() was placed before the list and current
handlers, causing both to fail when no controller is pre-selected.
Move the guard to only protect device_list, write and read which
actually need a controller.

Fixes: b875409da737 ("cmd: Add i3c command support.")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 cmd/i3c.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/cmd/i3c.c b/cmd/i3c.c
index 08957f4d447..ba99a937990 100644
--- a/cmd/i3c.c
+++ b/cmd/i3c.c
@@ -240,16 +240,17 @@ static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!is_i3c_subcommand(subcmd))
 		return handle_i3c_select(subcmd);
 
+	if (!strcmp(subcmd, "list"))
+		return handle_i3c_list();
+	else if (!strcmp(subcmd, "current"))
+		return handle_i3c_current();
+
 	if (!currdev) {
 		printf("i3c: No I3C controller selected\n");
 		return CMD_RET_FAILURE;
 	}
 
-	if (!strcmp(subcmd, "list"))
-		return handle_i3c_list();
-	else if (!strcmp(subcmd, "current"))
-		return handle_i3c_current();
-	else if (!strcmp(subcmd, "device_list"))
+	if (!strcmp(subcmd, "device_list"))
 		return handle_i3c_device_list();
 	else if (!strcmp(subcmd, "write"))
 		return handle_i3c_write(argc, argv);
-- 
2.43.0

