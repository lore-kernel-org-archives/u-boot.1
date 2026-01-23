Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57606D74ED8
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 14:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981BE83B91;
	Fri, 23 Jan 2026 15:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EJVBrGMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8266883B86; Fri, 23 Jan 2026 15:17:52 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5264183B6C
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 15:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJZdNtdNKKj7L+ikmKJ+VBqk4cnG4l0v+lesB92tZRI3pJUAipOref8hYScybvkNbi/3bsdXETyRYbMxfghhMlVQi8Oqna1Bi7G7CLk73KkK6uFef3CiYUOZn3fkd8LExFESpzsqS/68NumUgZDrZDt0jkPqxkBDvKJVXjzvlGBIaymhoFFUxbbwKURoLHPhHWiCS6NZJ0mU+ZV+cMvvnYBVhawOXgDJD/DGFiEMSpB2JF0LB1fyD73daMUbgn1EQQxPgEMeuQ1UrllCmeF4pRRhmAjJuE8tnFcIIstP5N85Cf8PKS5ql+5ZHg5V7TfYZfYKEn1D5R2HY+d0B5j/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bt/Mc0O7ZWGDDDxTLyVz0Az9RUJBibSAvsjMnMmly7c=;
 b=Heojzz9Q02n12zshdMgROOg7yuSjYuUQqCJg5mCmUMu4mqHCTKb6cg8G063kPohcB6DKSNbDWaVmLDZkclaVUn7/HqpLOpoDBtekwv9LZz7hN00/zDqQUgrI05JYgashgLPxfsDnZFwhF1URDEfEdgUNo+YhnIamNtNtGdbG7tQQkAWhcDht+JkiXADZR5FfEY7B0pC1eewfnGo0t+yddRuquRRCE90frnVXAxBpwo7T/gYaN6aQB3tXzFVIiHsdArv3ok/IEtAiMrH9hzjCt4nocefRM99gtqXoq5S7orihDZVSjCHY16xUgVIJ9iD7d1gdMGHLBQSIWwNvLuFRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt/Mc0O7ZWGDDDxTLyVz0Az9RUJBibSAvsjMnMmly7c=;
 b=EJVBrGMb/WqwmwAHf/hUidcEBra8FAUlUcN4C3LiUrBrJBPl9jThCG30KtiFvMeE9H2LnavfzG6VZcrop6zGRsMCAo+m5UWyygAntNzLMe5wBz4pRX8lo3IXMHsciQhbShYcoDFsELBsKwO+dLocl8kQbJQ4cZZqIkR2CIwaYWE=
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by IA0PPF864563BFB.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 14:17:43 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::df) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 14:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 14:17:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 23 Jan
 2026 08:17:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Jan
 2026 08:17:38 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 08:17:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v5 2/3] efi_var: Unify read/write access helper function
Date: Fri, 23 Jan 2026 15:17:22 +0100
Message-ID: <bec63fe7ad5201c1baf268a6c275d87f42713a9e.1769177838.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769177838.git.michal.simek@amd.com>
References: <cover.1769177838.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tS7/QQrrMOpch9gHA6/2TcDmnmLGsJ241bTtRuYPi0c=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWN/04IH73hvDXXf+vrY2ePkHD6tWjY7cCO/tfbw4Qu
 CngvuZoe0cpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBcZBIjw4oEofXnO5XVzcX+
 ufUqe0nJflz19LTpk9rqjl6znrU8Gxj+afZrVOXrTPWfve7Tzi/6B8xOhl2aueWq4sur1Q1rVl+
 q5gMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|IA0PPF864563BFB:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4fabcb-fa42-4833-3bc1-08de5a8a2bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bh7eBjmLkl0UqgOrQh3619x3Io2cg6HY5jPIBXeogwWZ8zHslpMSHsE7Ejrl?=
 =?us-ascii?Q?4je4ZT919sZFEfo14UtIZ2fQ8EzmaPoMSNJg3lWJfzhKIY3g2VpfhYRDGePd?=
 =?us-ascii?Q?yYpTwWfzEm7g6bwh/K+dRpmdjTC7n5D2Lp8yOPu2q9BFIqkGrQIygkGzCTEe?=
 =?us-ascii?Q?46UGnP+K872+KXdwCo7fpnoqD/mo5r0UBa2raA98LUqJiFKO/jNrMfaJkhg8?=
 =?us-ascii?Q?QrE/t1qOfGEDvxt3kLpFghR347vgjvCsX00C4BRr+h777q8LbYazD8VD/0/h?=
 =?us-ascii?Q?UdvWYR8JmF6JeP9G4HtJUF15hdkU/Wd16mPJ9hjzKsOhS26fgWQ3oNUIE2Gw?=
 =?us-ascii?Q?fKu17csKpssD1xLzjjfLC5xYrty7wqY4ZVmiSJ9q9/s6XELyMBk69M0xPvt6?=
 =?us-ascii?Q?d5ZCWHufDQaVF7dAWDi44jfiXOdo5UxwDbgpJ7wdusIuAjiBtGunUNuHaKH4?=
 =?us-ascii?Q?CPkIycmog6sWxd0WxcIYaJQYcDYF6Pn0Xo/xBx5D5HL/TWMaeunIP+ergx6w?=
 =?us-ascii?Q?AsRmlLqiqFK2BrTKkTh/s6xH46n3kJm/jFZhnwl/4tnAIKmAgIdRhXI8nnTw?=
 =?us-ascii?Q?e/sMnY/WhDGwDVZET0jSsAacCEFfqrcnMWIpaHhH4OAH5wXVaDAHgRZ2tRFG?=
 =?us-ascii?Q?M82FhQBP2jKf//6q4G3hKyisPzp5u0HUPDIozCKLPciMUzo2PLehdKHiL/V0?=
 =?us-ascii?Q?+S25zTHMuMG0ee30az2hQeuRaCATD/KAXdLKBmIY1+ZLp1hdftvznrh0FShj?=
 =?us-ascii?Q?Vo5cHailVkRVOmobCAzNbuf/npYg2iV6fyC06hWjYh16xTxwGZdeM8OYr5qh?=
 =?us-ascii?Q?JeEJ+shfOSpGs/R1aDOjFR3otrGupriuSWq3zay8V51WHQAgA+2uRg21/ook?=
 =?us-ascii?Q?Wjjm2j+0ie90MjlO8fEVWvTuwu7Vlc9TaZuQj1k5mB5akAd2174azl9OTRYh?=
 =?us-ascii?Q?CpqinUUmKoE3s6lENHlbIDhADixi5zy6mDC1uQKHCBCYCR9B/nf652h+zHL3?=
 =?us-ascii?Q?20frV91FXpoBcOwFdTvnexSpG7KvlLW1vENwMhW7nuU8iI4rkd8wm9qCDNCw?=
 =?us-ascii?Q?+G3RJOUoxmkvcFeQWOc0hNvF9LS8J6hDiF5puoJd/YaqkCeOIabrF3zVfh/b?=
 =?us-ascii?Q?+11zbOHoGrbmsFrcIoM3hOTFb/eefoBuNlV5NfDtySxXyTEeqclGjZP0OivX?=
 =?us-ascii?Q?C5FgHYJuU9tfTOfFUp8OHLd9onH0/IWPxZz0T4F5KR9qv90CdDN6X4+EfQzm?=
 =?us-ascii?Q?K19sPH4hlG2iwz7plrMjCL29FO+wqIY7PtxVsVOFuugaCyQsdzSMLx8pAjOR?=
 =?us-ascii?Q?mOvPzwnJYm/cJQ4X1/8fWia75PqL1y+q6dDoEWmORuPdrI4TetqTePm0TM3G?=
 =?us-ascii?Q?T2UjkaETFbdK7sqMJflsb+JWXsvSm3p5Zka3S3OBRucdlUS8Qxz/FhYXWeDZ?=
 =?us-ascii?Q?H3fnow/NWlP/92nwvbl3KWl6O8KTFOGm3cw2cDMgUhloHX156eJHKYs0ChU7?=
 =?us-ascii?Q?j1+eP4T2jcs/CqAFsBEYrcpJ3phswK4V8SCcK8OeYSqVW6NltIUCaXaiNhiG?=
 =?us-ascii?Q?xhgffWgKsD2u0XvRYggsUay8lUbc6kbk/WidGdXWrqV58jlI/jGtorRTZ1+J?=
 =?us-ascii?Q?riczI7Fq6jBEEXhg+DXWkvhQVeMpPpDJwfRHqZYtNOgs4kXQimP6YVntLc60?=
 =?us-ascii?Q?T629sA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:17:42.1213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4fabcb-fa42-4833-3bc1-08de5a8a2bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF864563BFB
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

efi_var_to/from_file() suggest method where variables are placed. But there
is no reason for it and generic name can be used to wire also different
locations for variables.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v4)

Changes in v4:
- New patch based on review comments from v3

 include/efi_variable.h        | 13 ++++---------
 lib/efi_loader/efi_var_file.c |  8 ++++----
 lib/efi_loader/efi_variable.c |  4 ++--
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index ee68fa4a885f..ae542c597129 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -137,13 +137,11 @@ struct efi_var_file {
 };
 
 /**
- * efi_var_to_file() - save non-volatile variables as file
- *
- * File ubootefi.var is created on the EFI system partion.
+ * efi_var_write() - save non-volatile variables
  *
  * Return:	status code
  */
-efi_status_t efi_var_to_file(void);
+efi_status_t efi_var_write(void);
 
 /**
  * efi_var_collect() - collect variables in buffer
@@ -178,17 +176,14 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
 
 /**
- * efi_var_from_file() - read variables from file
- *
- * File ubootefi.var is read from the EFI system partitions and the variables
- * stored in the file are created.
+ * efi_var_read() - read variables
  *
  * In case the file does not exist yet or a variable cannot be set EFI_SUCCESS
  * is returned.
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void);
+efi_status_t efi_var_read(void);
 
 /**
  * efi_var_mem_init() - set-up variable list
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index d32edaac277d..01ac7cc20e1f 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -43,13 +43,13 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
 }
 
 /**
- * efi_var_to_file() - save non-volatile variables as file
+ * efi_var_write() - save non-volatile variables as file
  *
  * File ubootefi.var is created on the EFI system partion.
  *
  * Return:	status code
  */
-efi_status_t efi_var_to_file(void)
+efi_status_t efi_var_write(void)
 {
 	efi_status_t ret;
 	struct efi_var_file *buf;
@@ -85,7 +85,7 @@ out:
 }
 
 /**
- * efi_var_from_file() - read variables from file
+ * efi_var_read() - read variables from file
  *
  * File ubootefi.var is read from the EFI system partitions and the variables
  * stored in the file are created.
@@ -98,7 +98,7 @@ out:
  *
  * Return:	status code
  */
-efi_status_t efi_var_from_file(void)
+efi_status_t efi_var_read(void)
 {
 	struct efi_var_file *buf;
 	loff_t len;
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 13db6eae882a..124281c29c7d 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -404,7 +404,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		if (IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE))
 			return EFI_NOT_READY;
 
-		efi_var_to_file();
+		efi_var_write();
 	}
 
 	return EFI_SUCCESS;
@@ -599,7 +599,7 @@ efi_status_t efi_init_variables(void)
 		return ret;
 
 	if (!IS_ENABLED(CONFIG_EFI_VARIABLE_NO_STORE)) {
-		ret = efi_var_from_file();
+		ret = efi_var_read();
 		if (ret != EFI_SUCCESS)
 			return ret;
 	}
-- 
2.43.0

