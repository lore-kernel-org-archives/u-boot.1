Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F7BFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0808F84609;
	Tue, 28 Apr 2026 09:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lg/juSEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5011A84106; Tue, 28 Apr 2026 07:30:53 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66CF83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puONubmKuvhPdU8HJrtdFg1STbK5bkfGtJubku/30xTrEJ4NSNVGG3mY5Ojj+nG7USpG0q7Jf1ESGAT7naX4ZNOqB/K6dtjy9LNBe+3dbPJF3zOkTMu4pZBcy7dTyBCAhqk5tCScfgstxCCnSVoD+L0m5T4zu+Un+O8Wdlgw/HK6OSn81COKodiiAi1wCqEXU8C6jviGeTfkTnM8qG2Hcdw7CnQNsMAP2OFeow20qpV2YJNb0qpCzruIFNOcp745wBVCz2Jf+j6tJ1qzWABRB3GkyPtjoEqx9ubgtPKXcquSFmJgynn3sHd6qLRmsd4ABQzDczxdw4wP0Y8C9xdwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/okG+xID62draUChjY5LsJR3XfPx+IM3D3MG/shl50=;
 b=UwILe3k4h+8sNub8ZzLRiWJEhDPeZKiHMj1NE9p0MH/cgcaV06wGNKEFujs+pc8RM813Ie8JX10lz323jGAA/bzYshpA0QHJJwPhMQMLrBXUUhGjFbYSpio61lcbiQ/jv9tTBC/A4IGknJdHqcXdwWSlg9W43hpkQ2lAIxniKAvgpfRIu6mBVieH9KbLNBB0DbsvjhfVYpinpb6Jn9W53rllpe8sS5ZUUcdbXXjyI9VcUYOX/w+pvXg6arPPEdoDaho35fMa0X9Ae4rRv+ITHFlqeuCCX23qtlIWMjcwrSOrJ8jsJ97EHY1BdkQhOeLjiiHwI0sFQ8LRaAtNKzV+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/okG+xID62draUChjY5LsJR3XfPx+IM3D3MG/shl50=;
 b=lg/juSEXxnkMK3aaoHXkyZf2bl8uIw2qLO0H4l4pEdPiBL/mynkSYZrTp3afQzM9jiV7eU6zudGBCgfeJn77zrJ7+CzhS75Y9QU+xBaSBBvWKXo+CoqiFdXIIcb0khJMNS4jCV2VkRJ1QMmPcrxgASzug22Y9wOQEP6fxIzZzyOLlVExa/MAtg401FDVyWWj5imN8zL8l7N6NTtf1yiGE4EjxBDAMtFwy/pridIUCUIx4dm0k3Wi8rdR0VBoKAcfOYDMM3/mWBy7eG5WqKm63MrbE+IkfzJ4xS/XNMrjSFJUuPPDw4qV5QWjys1TKEUYpfZlMwxveQkHSAl56FR1Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6387.namprd03.prod.outlook.com (2603:10b6:806:1c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 05:30:45 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 05:30:44 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 drosdi <danish.ahmad.rosdi@altera.com>
Subject: [PATCH v4] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
Date: Tue, 28 Apr 2026 13:30:30 +0800
Message-ID: <20260428053030.19532-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::8) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: be0c71b3-e513-42d4-13c5-08dea4e74b4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: hBbL5y5xNycdl9xCTlKW7IutRTW48m9VtdGEDw3mkC0HcH6zRX3zuorswLWV1GgCgrDI9FZZx1K18TRdTuGUKxGWcr0CXnUQgWhoUB1tArRDieSXTsXTj8nXBQ0mOwe89TRup/+/+f84pcGpIiILBP7GHmlmIDQKU2J0hM4+AdkB8cShjKX21/mbPZGNpBPX7abWN/TE0XxWtcPycJVCqBL1bU8fEJw9t503h/D0EbhM55BGBESLtsAke6Q85xxkZ8rB4fmrogLbUdj4mZOHykX1Tg25WlsOauk/YJQX0YigowcFXwtLLe1pRT5pN6rk7xeuFHvzhkRk4IktgdR/Dpvw/cu2ngjn4bPrRaNDjAw8uWGchjpVCgG+rWEG6kBXstBjqYbcce2wAlORjrOP4uyVuCYQeyW3szDpoBN9gzEjN7PB8V2Nh/W5SGfxioW2RtBhqF9WA/OZTcPFxyfHv0NNriLQnWckjXvb/p1gTa0B453kVqr/nW3V0rLa5rF+5Hh0vonprkFdAcrth4jPoVidcpTQc0LpKf1ysXkxiTmRAwntGsYb1skqHcMggL4V9MXXSyg6PfNyPAufEmgXs9BPrUepURktu5ZEnQ7iKu04lTDcAYRZjelx1oM/qnAnwqtmqtGGyWRRd7GNMSUW4tdgq0+ABCa3KSkGujE31SKsjETOBgQNzHsnABC7KQGKgGHLdSLGNf90Z4bqr99xBkIhCdsFXqAKyeEQOgOJWZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0NeBEY1FsHpzE6oEJ6oTNcUykQ4ryfpOUDDbHR/L/Mzf8dUp2LZvL4oyABMx?=
 =?us-ascii?Q?feP27s9LJCM1RKSS4xYaLKWrWu9rTnO3hnYn3uHvbXJH9664WSsWhTTfL4HQ?=
 =?us-ascii?Q?Sy61Yt30laKOtBMmGNexmdnsHALQQyzGikAC03323++ihkWLdVlXx1GpjwPn?=
 =?us-ascii?Q?mBHEsgMXRUeYjrXCrNVUx1YnpZdKoUrHa8FQ4IISuJ4shBCikwEvu4Z9Wm9b?=
 =?us-ascii?Q?kvDxwi2JkQKshDQR/lmT5Q7xSG86C9lTlO+MLXZTWFnGfkJU/2+Od6RFQ+P4?=
 =?us-ascii?Q?GFb207lXp8LelKkZ+g8JXVxgNmkr5QVcMYl9Ih7bp5lfS2Sd/PaRO1pfArVa?=
 =?us-ascii?Q?4yy6K6IUkbNshPAdxIC6rKYFYIa7u5q5e5EznCnYGf3bqTaNW1H8d4k74yQs?=
 =?us-ascii?Q?R/DUf8rhKVCgNR+ZdzSMRe/ZncWOFcwHGCOmelgttzjwvPGzhfIB3dLPN6Xw?=
 =?us-ascii?Q?+z4QBkqhBI47XyufL0Dd1HGibc7wU9PJh8gFKStfKmQnURiiXpMvzUXcM5+a?=
 =?us-ascii?Q?icTETUTVPPkLUMlDpFccnF5V6SRWrOWZIWGuVI7/RBfSFmZaPWblqz0vA7hO?=
 =?us-ascii?Q?hc1LqefdjIHDMGHUWgHJEWivLvIaysUMA8AxqEyiQPH9PIub8eOMkai/8wr2?=
 =?us-ascii?Q?iSfIJM9PPmOsH1legRZusNNBRySlBUb0WSSPZc3pgbSQPG6Xtl9GQAnOTm3Q?=
 =?us-ascii?Q?S2Yjn+7JimJ+ZdOSjDifX7a78l+U4T1eHEij3yVvxR90FY0HqzWhRQJ7MHBj?=
 =?us-ascii?Q?9BuOD5QMkG61KwGKcEsaN5aakRM1m/At5ibCsr6G4giwTjEHodTgwAOOjSiS?=
 =?us-ascii?Q?2vrXjCmkYaLcLDNwja67coZQgD7iNUdPLYl9GPGpZVE5dsMbnDcmL9l4+yfb?=
 =?us-ascii?Q?Mm+kTXq65QeBj5q33i8lr4mfA/IISLFc/9gEUcPe81eJVPodTx4777DFPYps?=
 =?us-ascii?Q?B3jTdmPTWQSEQVbyTAJoon2ZUbF2PAP7KIDTxFQdlEK11/hXdYoF12SLUDsT?=
 =?us-ascii?Q?M/XBCvUU2EUdiJBO/at865l8mOg1fsRJSUYlhWW0RPY0dPBhqK9qadgWCdsN?=
 =?us-ascii?Q?aEa8ZG6Trm8PFQH2EnH3gCcjiwsHEnXGt0NarYdUXPujPpfsrWQE3Ng7uT0I?=
 =?us-ascii?Q?hH+hoBB2krMwkHIAGTZr8r2LK8Usvf+jpg0zWKUMiokuGhMzD2TQuajCLYXU?=
 =?us-ascii?Q?IjqOkm/wf3K9WkiYwHvSfXhWko2/LZgH8nYa5dqala1BrlywWb1dRlvVBcDC?=
 =?us-ascii?Q?8Ry3/ZYlPsf+CNK1dmVdDKCcWOsvO90lFqIRwAvTmNmdvzdA5TRVYAxm+B/r?=
 =?us-ascii?Q?jJsXCL0dzrq3DkK9ZHwCig44Co1tI8QZdCLWIUoxFJUOOFjhwtGQ00Bh5+tx?=
 =?us-ascii?Q?/VjFSq4+1Ub5cEAzsrYtEO3Vohdw5qBqxJivEIyY9pX54sWmQU83vUqaTz0g?=
 =?us-ascii?Q?eij2iEDDAJLjuyBma44pK51K0KdFILkvk+k2puDB7PRZYFqf+IxFp+xneoMc?=
 =?us-ascii?Q?E9eyPrvQJaDfS6eJ7jGxFj935RSfMgZIAf93ZXYyQglgBxS0k4HJLWgRY9at?=
 =?us-ascii?Q?zOMns5qJm+zhxQdeBzOFpqs1UecVw3DkXnCHlPybQhMdeFy/1LXY1GZYDZ36?=
 =?us-ascii?Q?fud/iE/j2igMiDZsZhPOE91sB/n6Ae0iUx+9I7h3a9vPPv/Spkqv0mPy8YAg?=
 =?us-ascii?Q?oqMnWmytuRS1veZ3uAeO9qwPnGe5gOtDn3E+ZBhNPZrvkaxpvFPQuNR2EOwm?=
 =?us-ascii?Q?JED4LF5Ly0D5CFi85yOH+2o1bS0wsMY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0c71b3-e513-42d4-13c5-08dea4e74b4d
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:30:44.5015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAZ0vfB3EGdHZC4pvLa014uY6F91tTQvvE+tNhOXhSLdCqFyI0BWOkavUktUYDVEGaRJnWFvAKB5yt1Zl8dxyItJPW0lcnPRhOATlFbr8DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6387
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

From: drosdi <danish.ahmad.rosdi@altera.com>

Replace the conditional compilation checks for
CONFIG_ARCH_SOCFPGA_AGILEX and CONFIG_ARCH_SOCFPGA_STRATIX10 with
CONFIG_FPGA_INTEL_SDM_MAILBOX.

Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
v3->v4:
--------
Replace conditional check with CONFIG_FPGA_INTEL_SDM_MAILBOX.

History:
--------
https://patchwork.ozlabs.org/project/uboot/patch/20260414090350.34455-1-chen.huei.lok@altera.com/

 drivers/fpga/altera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 822183c5785..xxxxxxx 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,8 +12,7 @@
 /*
  *  Altera FPGA support
  */
-#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_FPGA_INTEL_SDM_MAILBOX)
 #include <asm/arch/misc.h>
 #endif
 #include <errno.h>
@@ -48,8 +47,7 @@ static const struct altera_fpga {
 #endif
 };

-#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_FPGA_INTEL_SDM_MAILBOX)
 int fpga_is_partial_data(int devnum, size_t img_len)
 {
 	/*
--
2.43.7
