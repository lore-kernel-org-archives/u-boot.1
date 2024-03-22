Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29257C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0FD881FF;
	Fri, 22 Mar 2024 12:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="41jeG7bA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3177881D6; Fri, 22 Mar 2024 12:43:35 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A934881D6
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxr/1YBUif6Y8+lLWKtoE8PHlfUFasbASQwX02jNIorTXzh6dxUusi0yGmqFNSspYEm3oaa2MoAQIIEWjkg4okkm+h8fWagdTOLmTq/4KpK5chV5ufjV6qpb57StlyFNf3+XycRvAx3L6KLP4VqgRJJykX3CK4XDtOrPR2pH3SdsAAv5EMTEABCNG1H+YwChb5uRPzhSI86hpID+oUzmNfPeKYIMJFOQCrEfK89G4Pj4TkRBTvb+xzvLtBsoPZsT5hCeUcDqTQXqLEhAGgZn+6feuEGzrs0wyUdWL3JYbwhT00yNChWx6yVAe94kUvPLINr07jYW2s0mug1DuKNuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk8UyhE0nTv+Jb4r291KdL5NHksqQ/yhVriugibV+U4=;
 b=Ys8LCR6r7xNDuQHkwWclNTefBxZOUcGEX2itrGJpdJk72CUxVT5X2ayILo+6nktuVcYvNhRvTA7iQFmj+C30NVVwAUKUyBxvaMGuQY0Lqo5lCHmjFv8cr/hXWkHsGcQcbAipD3VCEU/mP+5syDE/sqbQMWdN9+xUyj+OOdMdLAz3fxiwIF/Ys6WuwmdWmiRWU2FBPHWA5rPvA24M0vA5Kn4HDGT8fwKPzGrhA1leFi4My2XrhQKZSYfuzQi8WAaVbKJp8e9CRZu23i5yAIAo65vIBjxe0mA/p4VG80aUj5BkCQTNQnKwLYU2/yuvihYQdzH9JJdwvASRAakcqzI3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk8UyhE0nTv+Jb4r291KdL5NHksqQ/yhVriugibV+U4=;
 b=41jeG7bAfwpQEjUyQiOAeXqfKM1SnrRsvkhfBs//HdR08jOedKT1M2lc+l38JU2wICFDpCfvJysk84TOotQ23Dhwmt0Fm6KJRpRj2O6aQ3QhM3yoXS/ukq8gu+TIRoofG9FYeic5MWW+ipHPTCbga8A0ljfy7/RGLkS9FFL2Ut0=
Received: from DM5PR07CA0054.namprd07.prod.outlook.com (2603:10b6:4:ad::19) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 11:43:27 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:4:ad:cafe::77) by DM5PR07CA0054.outlook.office365.com
 (2603:10b6:4:ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 11:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 11:43:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 06:43:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, "Polak, Leszek"
 <LPolak@arri.de>, Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Do not call private env_get_location() when
 !ENV_IS_NOWHERE
Date: Fri, 22 Mar 2024 12:43:17 +0100
Message-ID: <830b9c93d30688cfa8a5cbb0388e79deb7731f29.1711107795.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2635; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/EVH53ybSP1jYuuask25aqlb0zfhdMNDrHKg17YU8Bs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtS/ede03xw6vfWrW1txwse7nF6VZbNr8nhNNasTvW2/H
 HjgmZPSEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACaS8YBhfth1rWWrXRu3RvrH
 ib3r5ls+LdU1mWHBzPtsT4LeGFYLyC0qnXk8XiHq88cdAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: aad2344d-4f94-41f8-5926-08dc4a654a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4T6+iRz3OAv264JbeGr+7ZMeBrKbBmLuJRnkGZMdyvYm4Dx0yKJ8nNjToqyVDA2xeCypEecVY3kZDEUkUwKAzbfNSHaix/ReFEEFpkrlrcM1GOM/CWN4xLVsWtr9AApxskEpsC31SzceM6IEfNbsRKfYSv+hvDp9RzooNyrNKPH9t8YoyZdtT/sBSAKBbP16MTyEq8Jq19Iz12PXJsmEfpBxOjQBF7Z8UuQsCpxESw6TKuwTWKJCotA132Ewy+p0QhTA710hKb3dwI5ioRhPGjjqAyqlhTY7SMCof6lCllPmbgUjSUgRXrS2yjF9kVWVS4sjJMTOo8qtxUiqCXptXMhRb6iC4y0yAApGIcWy51tTA8pv3w3UiI6ZtGJUSWGKWfovTRLYZ0rzPHWUmuOy3ak876uuX5hY5ltASrWUNsDItFUdiYQijxr/0vxSN7OdVcV2EGW9QP7RxamTNg+G51TtL6Qo7CgSoVmLIjKB6UOlAJBZAR1BzwS3jfNUuQlHmb1Al+SG3BchRdbUgTKiRt5Y8Au0RfaKLA+yPvNSyVgFfYGG3T7Pgf9/igvqMcxcBeUrSCY/qdhfrDIisQ3HlBYnmuMWWUPGT/ZMdvCuMnTJxYGEIFqTwjG1a3SUMQMpwFXkDqy7L2hx8jRhJ4IChSuvRhLVVyp14YUVJkxYY14v5PlV28KsSUqUrAMBrMzgFPKQtkTYgeIWgHpl31nLU0k4ug6B60A5TBRzhRaoT5hSg+VtjpBPoPsw50nFxen
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:43:27.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad2344d-4f94-41f8-5926-08dc4a654a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

Private function for finding out location of environment is not working
when ENV_IS_NOWHERE is disabled.
The reason is that current fallback is ENVL_UNKNOWN when
CONFIG_ENV_IS_NOWHERE is not enabled. The code could be updated like this

-               return ENVL_NOWHERE;
+               if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+                       return ENVL_NOWHERE;
+               return ENVL_UNKNOWN;

But then boot is still not working because ENVL_UNKNOWN has no driver and
env_init() returns -ENODEV. That's why it is better not to define board
specific env_get_location() because then weak env_get_location() is used
which is going over env_locations[] and returning locations which are
actually enabled in u-boot instance.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal-net/board.c | 2 ++
 board/xilinx/versal/board.c     | 2 ++
 board/xilinx/zynqmp/zynqmp.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index aecaeb657453..da03024e162f 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -372,6 +372,7 @@ void reset_cpu(void)
 {
 }
 
+#if defined(CONFIG_ENV_IS_NOWHERE)
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u8 bootmode = versal_net_get_bootmode();
@@ -401,3 +402,4 @@ enum env_location env_get_location(enum env_operation op, int prio)
 		return ENVL_NOWHERE;
 	}
 }
+#endif
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 8c2e614ad8a0..4f6d56119db1 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -291,6 +291,7 @@ void reset_cpu(void)
 {
 }
 
+#if defined(CONFIG_ENV_IS_NOWHERE)
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = versal_get_bootmode();
@@ -320,3 +321,4 @@ enum env_location env_get_location(enum env_operation op, int prio)
 		return ENVL_NOWHERE;
 	}
 }
+#endif
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index ba49eb7be229..79daaf8723ac 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -588,6 +588,7 @@ int mmc_get_env_dev(void)
 	return bootseq;
 }
 
+#if defined(CONFIG_ENV_IS_NOWHERE)
 enum env_location env_get_location(enum env_operation op, int prio)
 {
 	u32 bootmode = zynqmp_get_bootmode();
@@ -621,6 +622,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 		return ENVL_NOWHERE;
 	}
 }
+#endif
 
 #if defined(CONFIG_SET_DFU_ALT_INFO)
 
-- 
2.44.0

