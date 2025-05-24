Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5CCC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 20:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E17E82D6C;
	Sat, 24 May 2025 22:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="D3VfLrpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6048363B; Sat, 24 May 2025 22:37:59 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5877983043
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 22:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBBH/2KXtSfDP4UoNAzz6ftMTxY0OGWust8VaZ0iH0XvxpOptsb7MNbeyYWg7mvQB20fem5zXqBJYa+OEB+kEFwbANkvHkFLeJ1zec7dA1zJhTrCxs1xeKJDlKlqRrhbsGPv8sgmizSe2m63V5FthiKaNhyyBXCWQF+er7ZOCsu/9xOYZiywwQr6XKmbSwGzVNdHwZrrffbs17mlrG2BLz7Tz5rKX6g6i6xOmtve8GVyMGTpbJYWjubLg/KKgVrfDiEA/Z6l4kddqM5POHUwrHsDef7ho14dg2UbkfU8+z9gnatuby6qLNa+rXbYs/cm2nv6zbiJC4vhZsDzfzsjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJkry09k5OrEHDH3PhBEx5xH2RDJEBBPryO6BHuyuTM=;
 b=mGMvwk1ru9i8NqDlhZDfsP5d5EaFJ2Qus65YfNK732fo4oEc19XhtEc8O0XBt789xBtevJ7pK+J71eW3HJk0a2GsgfN8aSJGHYcVdG/19vVKc9Q/P6PmTU9i711IiHMqtCQSgoAvIz3WgV65/ysyWo6FsPh4y5dW1baY/dkWqm0zgB3bksQa7BFa/GFzl8nhTlyrWV19nvD1ndzGCnqqNG8XYS5hMImlTS3wKDxuMCYdzcbYc8/hsxbL/U4Lp/mF4xgMDQqLeo0Yuqg7BtgxB2VM6KXLLx7RSKZZy8efwa0IySg76nmnsTQdXIEnqsn2t1mEGUlEAiBnFYI5s0NXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJkry09k5OrEHDH3PhBEx5xH2RDJEBBPryO6BHuyuTM=;
 b=D3VfLrpHMlUhtqUm8sks1X9s7n61PWveqlJ6GfNmQtD04m/l67UjlureQwIEW1ffeU6Fh50iNcc+DSjs1Vb724Hs3ZnU+UIME+V9MH4XUZhMNtyMkKLwSKUn0ipd6gqCJDEUKmMfp8jrMrcQrGEGKMhiWnOqvQufR2jEfUuRn5/xjOITEl4A622wJ6gV4P0Gbcot8YSEIwSjQ85lXCx62uFwhYPdOa0cSjXPx6ohTL/m/mJZSkcl61DEKjhSBwHlwuMXsXTiqcdfhXf0bLKta600ZRlyg5e48A0wetjr3ugI8H/1GPuKPVDFwc9KienPnMge2gT3wW+Vty91iQZZEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SA1PR03MB7100.namprd03.prod.outlook.com (2603:10b6:806:339::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sat, 24 May
 2025 20:37:54 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8722.027; Sat, 24 May 2025
 20:37:54 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 2/5] cmd: Add partial reconfiguration command
Date: Sat, 24 May 2025 13:37:34 -0700
Message-Id: <20250524203737.20541-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SA1PR03MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1839bc1b-0cb0-4f24-9099-08dd9b02dc38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZWay89iqJ9VKXq/k5JXOrsHxym4+AMLsJ9yo58uKqn0ZubvuCtE4Zakr4Nuq?=
 =?us-ascii?Q?9LXHPOUNJsKlzny67rk7vCupPtVYW4GP0gZ21swNZFGKeVpZneZjv2m3+r8b?=
 =?us-ascii?Q?gW/9kFbo0MrGJdI7CcDmzElYbsoaWxhMrqPd7n50Np5RAIG1m+2Ve6d5uuYM?=
 =?us-ascii?Q?oTCLrZxdjjzypb9NvLNfegHpK5Q826OIcs8P1ybLSbwspDbyVPok8LzM2NBW?=
 =?us-ascii?Q?G1jcRCqKOJ+fDZpJq+Ju7g/LeZtjGJcPg4mUWU1diP4DjlfUg/fhfgs8Sefr?=
 =?us-ascii?Q?Qt9vq59J1aHypQYAo0iOo0yRWFbLnxsASPWEspiPZnkKxUEu5SBs6kuILQVL?=
 =?us-ascii?Q?UjW4rsWVITrGfBOUL+96IO/4onwrf8U2kpvqVw6S7YIN5tSrPhrtsLNOa0vK?=
 =?us-ascii?Q?UnF+D2CJ0Tw7HRIMi0l3E8T5ywSZiWXmnmXhf2sil38IAwR5EysbInwRsbTI?=
 =?us-ascii?Q?cs3E6QlOGBl5ewPm9EdT3JMk6QNScAUp7PiO3J+TOEpU6S3mUsqCaqDy/w6v?=
 =?us-ascii?Q?jV9Loln3+lhrBwSUchkZKlK/43liYSXE+RxiKHSsP70jg0tqDnHwwt8Tj9RG?=
 =?us-ascii?Q?yUTCz24GcGvS9Jc2ASau5KGd6Y6kGdl6K5HXgmM/FjfwlzGNsqVXgrmpNHse?=
 =?us-ascii?Q?yqjFzI0S+FInsD1jDNMz+5CGaVgAeypJkRZryMgjARpT1awUgSHgNUUS8SB0?=
 =?us-ascii?Q?MI4266t86IknDB3+jU0iRMD2Uf+C1i9fuzkMnQLUNAgqCfc89vu0l8OV+eKo?=
 =?us-ascii?Q?qqHwzp5JexKwpscM/lvUzocFpazVLDyTEpJ+w4MGX/O1N5dsy49f89O6HnKH?=
 =?us-ascii?Q?G9r+Y5lbcjk+D8AF4F8nXjw2l8my4IaNUo843sjRrWZVILceghjbHsVlFBuh?=
 =?us-ascii?Q?EDCO71MzgVURg8CWz0BmTVkuVg6xl/9UiIZH45kExLIAirQtSmCIsHdYlT2A?=
 =?us-ascii?Q?ChgWJdgMWqXl5jTBXsvyzxDZDKlZ/wLhYsEBeIvHbZyWdJuqH6cHOXc2DckE?=
 =?us-ascii?Q?IVv42Tdp8rpUNOuSafwlyhwA0yVc4NvnCn/Fk+dBUY9Z6Ix2tUZmYgZBdjID?=
 =?us-ascii?Q?HZeqa3fbRwxLknP0Sdb1WXPFHISCifjy7mK2E3rEeOJW9YiaDpWHsIEdq9SV?=
 =?us-ascii?Q?Ji4MMdeTuP0shMXyL64TomUxkQRKG2Ff2l2f7Wh+HLRvCwappO73rZBhgV+5?=
 =?us-ascii?Q?t/oekM+jyMJI5dQhqItOYm0rP5h92JxOeNvaKZtOZwHzDECpKASOCewYshy3?=
 =?us-ascii?Q?0Ne3K2KjAOOynrIF3Lg0HnZ2672VTKgVW3MqyRGV6qDGLljmrOh1VoUYXhV+?=
 =?us-ascii?Q?Fi8rdznJYDrAsEzje10es4z81GEKDNH6bRXzVTStJvV2gp5pDjfs41QOVHXj?=
 =?us-ascii?Q?PFcZoVg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8o/ZmStFfdSSh4KNgu3vu6zFS7/TZTtQ6cMM4l97CPOmSbt0I8Z7Fion1xVx?=
 =?us-ascii?Q?RA5Q/vfJ/WXkpKFp2jkLLGTZYGf/YAHwdISXxrrQKA8MS8slzlJ7eg4YkU8P?=
 =?us-ascii?Q?/8hkT/ha5s5v7H5YzQb5Rzj17f21thpbU1SNFgHO3OcBAUzdHGOuuagZnWYT?=
 =?us-ascii?Q?vLjtENyRoGB5w+Bs5MpWaNK91Rmy/F8KVyPf+WqtfvHPOR7z804GLSGXOSrZ?=
 =?us-ascii?Q?DMmyyyf2SkVSouvVx2xcYzHi4yuaL896sWI3Qp91nNwkJMzfIzQRmMkqU3mO?=
 =?us-ascii?Q?6Y2aV+BMihn43F5JvgO01gd4EuUcqjCt5peiQwN/H4mv6bIZep+WKDxz5tYN?=
 =?us-ascii?Q?5wPRHumnL4uiO0xtlYi4Mc2hRZwXc5rxHenPAFgFEVpY+a9BuN2JAx7Pn63b?=
 =?us-ascii?Q?UuRYyGIJRx0Y91ajmIO+xJ13eU+k6pJrtIfjagptzTOIabwPiRu/CxjIOawT?=
 =?us-ascii?Q?8qAdJuubO2qd0cnwxYng89/rpVtAaHl3WOT1f94HdZlG45O6qLB5IBLKo7lX?=
 =?us-ascii?Q?Dz1V93vZO2GSZrnSrPpmx2Wg3sh8KJDopu7N5C7ypLo7qICMAww999CwqeEY?=
 =?us-ascii?Q?iJu31DutckqcibuEpvDWpSQ6XL3Ull/XNXP2auRqg4xLSknksgW5nGXh39F+?=
 =?us-ascii?Q?hgWzoh3h/SRbtFNkTlSQA09wiA9melPK3CQ9cGPUFpgbeNd/uZ2Cl06ozGbZ?=
 =?us-ascii?Q?WyfurHVUKG4UJbz6cnaxAWDc3RMyUGbatoMlex7ztkiZ337BQK5E7h4ZFfCA?=
 =?us-ascii?Q?FYztD/jB3TU1GyTZhesE+PoLzNTYO0C0MbQNxZfaN890oyDTzB8k/yzApuW9?=
 =?us-ascii?Q?UPDkIHwWf3UcnIrG1K01OEf/bzudySrVNgetSuA93JpUY6tu9WcjtHOlDRlo?=
 =?us-ascii?Q?huaprDsrFFJVPXpph1Lp9xj4ILAxT69svouWLVLQfkOh5xGRpEKr+t1wcHNv?=
 =?us-ascii?Q?mRKpT7C8PL9IrwiqVFJTVy1VdErF5+GZ9uG/OG5c85mJnW+lRd6DwbcIagoW?=
 =?us-ascii?Q?JxzLJJiyMXq7iymgorzkjD4ZuG13PQrvPFgj4nfRzMp7YwOiOClLMf73FlDx?=
 =?us-ascii?Q?hoCeSiQRU+wPCI4enkUpcHUe2xcWDCFa1nHN3P8W3eCg+YK1UQH78WrnRhTT?=
 =?us-ascii?Q?dxzK2Z6QBCf9fdgw80ClwW8rUKMWkx53S8yGxA8qDBAiMTZWH4VOhjvn/xp6?=
 =?us-ascii?Q?82b5u8BxnvxcKuzfeC69Xebx2uqeqzDbFmsu03X475/dCVHI+2NlBb5D3LnX?=
 =?us-ascii?Q?q0IMSIhsymCsmn+VyOpxeTQ8RWNwEDaLg0nQF5lvTymEuVf27CKO9CaYki0u?=
 =?us-ascii?Q?A28ShvzuYJXA/Xm9NPJA1Q8aO4dFAnLTrvICk6etsRPGXlI2diMlkIzrcAfw?=
 =?us-ascii?Q?ItihYtJsPRthqLlzkHgwKK/8ATfKI1oP+fz2n/+Bvy4Ksx0G2GasJWRt+szy?=
 =?us-ascii?Q?gwouuqhHAYk13yFJ7hsxfWQgAGPu7hNjr9Q73+3UQDxhp8ufn+mN52YD4/aS?=
 =?us-ascii?Q?7N2p3n0m5958LmxAFR33RHl7FzAbLBderFafHIv+ebxVxAMm6WIuee22FhL4?=
 =?us-ascii?Q?7c0K5MdcZ/IUELO6hreyLKJ8WbdtAW52VocItC1MpFpa6utqFN/PPtlg4zRb?=
 =?us-ascii?Q?iyryP5wMueQtNxIeZsHZ0qM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1839bc1b-0cb0-4f24-9099-08dd9b02dc38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 20:37:54.6064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMnEmwPDyaPc7tedvh84h/8dEnLJg2eYUIkvynkKdPLJeuXgjV0x8DDZBr67FdJz46HOzlPV9+Jyu3drQg23T6WCuHIK31DiebMhidZ+AFFnoDK2O6g8xUyqijWeAteX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7100
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

Command to support FPGA partial reconfiguration (pr) is added.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 cmd/Kconfig |  8 ++++++++
 cmd/fpga.c  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 2d31abcef73..68143d62a44 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1229,6 +1229,14 @@ config CMD_FPGAD
 	  fpga_get_reg() function. This functions similarly to the 'md'
 	  command.
 
+config CMD_FPGA_PR
+	bool "fpga pr - support FPGA partial reconfiguration"
+	depends on CMD_FPGA && FPGA_ALTERA
+	select FPGA_PR
+	help
+	  Command enables support for partial reconfiguration on supported
+	  FPGA devices.
+
 config CMD_FUSE
 	bool "fuse - support for the fuse subssystem"
 	help
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 9dc7b63db5d..e4aa44ba7dd 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -2,6 +2,8 @@
 /*
  * (C) Copyright 2000, 2001
  * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
+ *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 /*
@@ -354,6 +356,31 @@ static int do_fpga_loadmk(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 #endif
 
+#if defined(CONFIG_CMD_FPGA_PR)
+static int do_fpga_pr(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	const char *cmd;
+	char *region;
+	unsigned int region_num;
+	long dev;
+
+	if (argc != cmdtp->maxargs) {
+		printf("Error: argument count mismatch\n");
+		return CMD_RET_USAGE;
+	}
+
+	dev = do_fpga_get_device(argv[0]);
+	cmd = argv[1];
+	region_num = simple_strtoul(argv[2], &region, 10);
+	if (*region != '\0') {
+		printf("Error: region number '%s' is not a valid number\n", argv[2]);
+		return CMD_RET_USAGE;
+	}
+
+	return fpga_pr(dev, cmd, region_num);
+}
+#endif
+
 static struct cmd_tbl fpga_commands[] = {
 	U_BOOT_CMD_MKENT(info, 1, 1, do_fpga_info, "", ""),
 	U_BOOT_CMD_MKENT(dump, 3, 1, do_fpga_dump, "", ""),
@@ -376,6 +403,9 @@ static struct cmd_tbl fpga_commands[] = {
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
 	U_BOOT_CMD_MKENT(loads, 6, 1, do_fpga_loads, "", ""),
 #endif
+#if defined(CONFIG_CMD_FPGA_PR)
+	U_BOOT_CMD_MKENT(pr, 3, 1, do_fpga_pr, "", ""),
+#endif
 };
 
 static int do_fpga_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -448,4 +478,12 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	 "            -Userkey address: address where user key is stored\n"
 	 "            NOTE: secure bitstream has to be created using Xilinx bootgen tool\n"
 #endif
+#if defined(CONFIG_CMD_FPGA_PR)
+	 "fpga pr <dev> <start|stop> <region>\n"
+	 "            Start or stop the partial reconfiguration process by freezing or\n"
+	 "            unfreezing the specified region\n"
+	 "            -start: starts the partial reconfiguration process\n"
+	 "            -stop: stops the partial reconfiguration process\n"
+	 "            -region: region number to undergo the partial reconfiguration process\n"
+#endif
 );
-- 
2.35.3

