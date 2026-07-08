Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE227C44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BEC84A78;
	Wed,  8 Jul 2026 14:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kWldTu+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB42838D7; Wed,  8 Jul 2026 03:13:40 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2240F8497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dafpbv+dTvlMvpxZkdHSR7/XU/R8hiVL1T+ukPateAENHPaKjI92iwOQ9hPbT9k0chusbCJA90jBWYoDhsB666hpiqyUYd1e4lnvLO/2kUFk4U6o+5pgonnj9jaodDlXWefJJ5AQgmjrr7Kd9M6xMwDGPO9nM5jft3CbQ666+9zBFm1/qdMRxG0WUBWiDk83ohjQxCMDP9CCbv+4ypRiM/TuRAGnH8s7zU9HWSdQM7RyQfdxNpoHSWuhneCMeJIdXrd4JJ/NqDODe8wQ2Tw01FjuGAIoDHwsMhPMH0P69l5XD33t21lHrIWIgRkA2o4wzu7ygYORvPyXuh1EYFiMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyEOBKFdNyRxMAWZm7Aw1DbUD0NLZIFoculEaOmRT3E=;
 b=woDUosXEQ7z1Ci/7DaJYCUAcxJuJUbT5ipmq5zNi3Aue23ac12ARDmoRATVB7NXddopO7Um/rhcgz2A+mTP+YX+6Xx6PBGHtiD6LH6L4O9BLqAkuB/uwQRRJNrshzClKNWY+BgOzLkNwnay+5g2Wwp5WhRfPCi2eJ+ajwBuQhIts/1alKZ0kVtoQtxWOzV7dO5oNiNBQUDTxvt/GIV3sI4NK5obSwzP0Zg7if1gH85gkW3Bn0oOBCk3vrBrdgp7sHeV4Vm07lENHCqohRlc95iydpu5tn7VdhHpFiAkZYIxT5A9PighH0gurqBmiUBnRh38ewxd3SI3lNCwlb9hm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyEOBKFdNyRxMAWZm7Aw1DbUD0NLZIFoculEaOmRT3E=;
 b=kWldTu+F9YW8s+YqNHzYh/97tyuRtGJUOdWYeUtBVcyAKi7fS/TlQtunukAP4IlxmYUXovR5w5EXeDhQwS8SCw0xj8yIahRDO9pV1UrjLSJtXI29P+FGXprw0LaW1FKCRwFOUf1uRcyVVxlKVxDLbDMG2mGGI/Aw0m5FQKGaZdopuPdLHIJ+CU36eRfg4aREjGjZ0hPNRGgS31HoW4bgUfgIWWnHy8YTILVWnkZycEcEWbdj3j0xBIGqTl+MXqrsOsYxOpcr6ZARcNbRHwc3SKqiNeqLqm/ehXl/9isk/ApZKZWniuzCNoPbVBNeTzUyq3eG5k+vWWEe5yy3e48WSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:35 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:35 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 11/15] ddr: altera: n5x: fix debug log typo
Date: Wed,  8 Jul 2026 09:12:24 +0800
Message-ID: <20260708011228.15613-12-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fc9d47-4984-4a38-ab9a-08dedc8e2226
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 7zzDG2spztB+jb/W2rEtCvzODU1HleogwK6sLX2qSVueo3EK5D5nqF1cfrFKZrzt09Z+Y2YBD17R/L46TUjGqgvuUhV4xykyz+CJa9pbn7Vzcw5ZilBJhxxDs8QMsQJVqsTCeW+UWjWU8cHcW+Op/zyARkAirOkC0BjIlviiaw4q1B2K8FMvaUEyfoJ1oUXtzyeqKH00H5Q0f+qS/VoqY+e1x+71HHSDODu5qezTIyrIi7N66RL8CQI+FkF7HJTboJ4SDnj3QIXBbGDkI1DobCbr4NsUp7J2mdBiLyDnOuhP0pKDQm9u+yvrkWtAqv6kcFrJzHKXJ8V8sXRfARpr85gW4PEe9lgUpyZLrAspVNxHPvwYFEWp8qT7MRvybJYf+D16nHHyWXHDaoOeLdnBStyaoKZVoCb28tEroZWUBDIyO1Ci10rF6xhbZVBaYTLgiduXqNHtaYvRK3ZAdOTE2msGM6Z21xLAYuCGodJ0T86Z00dectLDjkisqly4e1Pj2oeedXV+aVUzyGRTQCuLNzRuF/12bk2o7/sf72Zdbt8zclR0st6hPncZn8knF7+aAn534zJ5nrrU7jbWp4kih6QKKo0rDox27KaHjKCj4QA4cVqJ+IlgySazR9WE2Joyh6RbWgNDp0m+1x+6p4wNgpf2LPZxtbkYfp8ewzGrZRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v5uDafl8cKhCNsdD19ABMiyIiLwgQ+LEG4WGWB9DYJRvNJggat3tmkuvzQnW?=
 =?us-ascii?Q?sA413gKtG07RAnNsiOu1bOdDTN2NyMWaVIpreIg+J8q3KTiE5S+ZuH3MoVxf?=
 =?us-ascii?Q?ew8/IM8R2vVF5ezTpkjoh0RsESjqT53VISzG7zecuyGlm4bhzWPDA0vPgHFu?=
 =?us-ascii?Q?2JrSk4nGt1awPxOGS1nK6lN9m+mzMJiBrajHwnqRpkoxOBXJ/7i5aNORXcQa?=
 =?us-ascii?Q?EBmM8Xfhf5Q9+iDenWZ6zE6COLVZATGgO5zujjFhwW0b3qoEVqHSR2x50CEs?=
 =?us-ascii?Q?C7wJ/jdWTxjHaL9C/d7sAFRVQoz3ModXZjr9X8IVvxOPox2RbPiJMq5loIW+?=
 =?us-ascii?Q?RdomsKT8eTNkwXARk4wcr8f6LrPDg4FyoDtqUqiSRZayLjVg2FHh3/AXhcl4?=
 =?us-ascii?Q?CssMQHRjhH+kbI9nSuXmkbqIcLREets+9KBev6IiNIu7gdTM20ZM6f9TW/Ym?=
 =?us-ascii?Q?19MQY8BGAdHPrBcHd149E96tXineaXpbKR5mJRuqfs71joQbR5PkSnuKY/nx?=
 =?us-ascii?Q?aH54EwJ+/1uiNzl0VhfqxGjM4lxxUI3U6zOqEL3u7vIQmFgHFRmNPU/IfSGd?=
 =?us-ascii?Q?gth7FcqxAX8S2d9gR+EwzZe07vACysbsBuTSuJtQniZvf8PTp5ybiV5Q14PQ?=
 =?us-ascii?Q?Y37Mu4Lr/zfQdNXGnTaXqg4krfVEypEFAdByVNmDGFDIqh7zCb3BB6AuSGxt?=
 =?us-ascii?Q?/8cGLhnv1oPa6A4bY2d+84Kwr8zD3tP3TGs0Ug3b9Uo6OHmKKWTPQosBfIav?=
 =?us-ascii?Q?C4L67zkeMXYYomnEPadcCYoVi3FRMc7fr5bQgOCgA8zweHKOQUpqHLJbTFja?=
 =?us-ascii?Q?KjpFocotklPTKKiTirkckC8prYer6oQFSsBG7BgVTRnYbeCL+fnIHdTlL1gM?=
 =?us-ascii?Q?xGMdasChWlKsMmb9wSFzM2Z4g/eUGGlmUBXV0zWW04EnVAIT8f+qulHwMhCP?=
 =?us-ascii?Q?RqNc+1EpgIJpreuzHBgLhxsKVfyEz7299oowx3kuZ39TK9aIAchyrwcsWaNz?=
 =?us-ascii?Q?bxxGs3aTGb1HEjxnfP4+5cDpTGgzoQFU7UdFhO9xVO9i3Ke7Y3i7/cEFyRQo?=
 =?us-ascii?Q?MunKTQr+j+lQ70Y/gumaVgIX+eyee5Ez2aol1zi1UtBRGe3z11lJ+X5sfaKE?=
 =?us-ascii?Q?Bsn3Xb1nQFrh6H4phlxf2KSoKiBHA95FcwAGbbcT/XP9674OLCDOguuhJycm?=
 =?us-ascii?Q?2VWsFOpZKklHLd73j/A2NJ882ekt6iJYArThS6plQJC7F3YFCqRh02GxzJ4O?=
 =?us-ascii?Q?rBzvRStboktMqkVZroc+L9cCikEl/h0/TFxnwMfcq4JXk6/qDHtW9g65s7Qz?=
 =?us-ascii?Q?fvW5wrXKKEdwZSfUQXo4W2T61KY/E71vdAVDLc7/eFKDWYf3ibms1bcVTkWl?=
 =?us-ascii?Q?HZolwYOf+Lxa0odmJJxAlVFzBAA7THE9wCKxjj/3FWNoveNztbIcztqdfnJT?=
 =?us-ascii?Q?L9fKLtOWw82Drzk3ZIc+G10cm0SiM7PnwWa1DgQ0ViKMfhAhSQipgsYeXG6D?=
 =?us-ascii?Q?BnxU9cWrHQICrghMkHfuDevSl+6i2qnGA0khRejjNB81TcMykfz4aRnVf38x?=
 =?us-ascii?Q?iI948aZDzJrN7zlnZgxg0RmGUulN7fIvX30VZgDHJKBAnQyfSok/gHwcRTr2?=
 =?us-ascii?Q?AZYEQHqe3M6Ykuljea31xKruqC03bi7M0SkkwIrG+3T+qgB2eYbvFJBdZ9nh?=
 =?us-ascii?Q?MjjRNt0xY6liUxI6XcH9n051wFFS0Y2L7ZMtSRM1liT8p3r0hT6dOQj9ien1?=
 =?us-ascii?Q?38FtpE74GLlpr4SxP6/wG5JlfzXuZgI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fc9d47-4984-4a38-ab9a-08dedc8e2226
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:35.3767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYEogeuCQLC8zYt4FfWJBoAXCb+sf8BLIZIvaV91mY2fyZxA7DHvORR63GEgVW7h+gQmrboiDqBo/uS4Yf1tqXaXGxfhBwDkX3EF6CILvHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

Fix a typo in the calibration-result debug log messages.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index 0bb04c5eac6..6fed9b79257 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -2336,7 +2336,7 @@ static void set_cal_res_to_rankctrl(u32 reg_addr, u16 update_value,
 
 	debug("max value divided by 2 is 0x%x\n", update_value);
 	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
-	debug("update with train result\n");
+	debug("updating with train result\n");
 
 	value = (reg & mask) >> shift;
 
@@ -2357,7 +2357,7 @@ static void set_cal_res_to_rankctrl(u32 reg_addr, u16 update_value,
 
 	reg = readl((uintptr_t)reg_addr);
 	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
-	debug("update with train result\n");
+	debug("updating with train result\n");
 }
 
 /* helper function for updating train result to register */
@@ -2370,7 +2370,7 @@ static void set_cal_res_to_reg(u32 reg_addr, u16 update_value, u32 mask,
 
 	debug("max value divided by 2 is 0x%x\n", update_value);
 	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
-	debug("update with train result\n");
+	debug("updating with train result\n");
 
 	value = (reg & mask) >> shift;
 
@@ -2381,7 +2381,7 @@ static void set_cal_res_to_reg(u32 reg_addr, u16 update_value, u32 mask,
 
 	reg = readl((uintptr_t)reg_addr);
 	debug("umclt2 register 0x%x value is 0%x before ", reg_addr, reg);
-	debug("update with train result\n");
+	debug("updating with train result\n");
 }
 
 static u16 get_max_txdqsdlytg0_ux_p0(struct ddr_handoff *handoff, u32 reg,
-- 
2.43.7

