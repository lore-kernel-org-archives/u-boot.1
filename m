Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E81C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A550817A5;
	Tue, 11 Mar 2025 14:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ToegAd3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89BA1811C1; Tue, 11 Mar 2025 07:39:20 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234E7806D8
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edxs1xhubRLfjwh+PhYnRzeNGmoCXE1l84kDIWJaFL9C6zrHSxVDEovTKtYegaPIUjkeGq6VTHBS40ZZvC0JWscmHlQGbBc0B1KQWiHJgsMZW2kyeXczgxTJYi6b/bRAC22HZtwAwytxEmN2rasgiCFqbwjezylYWQnrbV0fZP+lzelBvQ4xHDi6A0s//W5YfZdJbd/Ksn31N9X8f4wz3qcLWeUExxhh8EDYB4jA4cxGPHoWdGqm//B5VdQKf/LwF3EHmXY8KOOEBmen0b7HVdU+Q2Rb/nFzzqauk1JsuuxhEBRv5NBhOfPJ4MMPH4JzM05CngwjqJigKthn4udcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16lQtVMEsTpXgVls4YTrTH9eDNUnww7946v+8cawi2g=;
 b=y6kB/ylMWcJb5yB1Vs1sS1enWUM0CPg6uXOSxyDDDjs3nqqKlMZ0OAJ4EipivivDdkz9gIHrxIx8e2QJTK7WvQ9MK1UOH2eqPyWiX9OT+FXt4Jrh3wv0MbEivyDsygebyzS5WnnT5ItFG2grCBesOpMLJRnc3aNcjuk0eVn6i8t+Pwx5q8flhFHvMeb9HiT+E2nS2NwbYALxhige5jDy2CnwjplW7nA52t+IiAU+0uX/SrmVKWwTseWyT4F/JVQ6Wwl8XhlkL9m2Qk2VBLeKMMw8m46oX6N94GqeN1Xa6mkqBf33t5TwPjvyO3BUplmQyT3+XbM4D5XiO783fmR+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16lQtVMEsTpXgVls4YTrTH9eDNUnww7946v+8cawi2g=;
 b=ToegAd3NJ/rhzshCN7fhROb3yOAZq4Flmc5JplbYCdS3wRP5GcKQdlbS328E7lD2Xk5snybnMsKusj1cvBL6lOn9DZMx1kDQNRf30K9TjIs6EgY/zdZzIgEFN3lcmFdYNqwuNrGQTVr5uiYaonpUNlDBUv3OzzcpTsqeRaa+gJxwcAhMuY3vFL0vVpGvLVINpAumJNCodyWiIWb/cSwO/HsbV3FcRB4hx8H6Nli+WMrzftutUy+6M+7Li1SJCDWjwTw5hzei/LixmqjR2mcUPnkYekcklWCeqjLBpV64CQGdT0m73KfXqGoFZYPNSyfDxqxxwnD0OXVG8kqKIifBAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3877.namprd03.prod.outlook.com (2603:10b6:a03:6a::11)
 by CH0PR03MB6049.namprd03.prod.outlook.com (2603:10b6:610:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:39:16 +0000
Received: from BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868]) by BYAPR03MB3877.namprd03.prod.outlook.com
 ([fe80::3bac:8091:d9fd:2868%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 06:39:15 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Mahesh Rao <mahesh.rao@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 2/2] arm: socfpga: spl: Notify SDM on FSBL execution
Date: Mon, 10 Mar 2025 23:38:52 -0700
Message-Id: <20250311063852.9059-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250311063852.9059-1-alif.zakuan.yuslaimi@altera.com>
References: <20250311063852.9059-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To BYAPR03MB3877.namprd03.prod.outlook.com
 (2603:10b6:a03:6a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3877:EE_|CH0PR03MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eae655a-a837-42e7-2ed4-08dd60677178
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wFi2bW5mWM75NDzEt0UVR9gqlXFiR69dQFzm/QamCkh0Ip+f8ci+pzSZnEWs?=
 =?us-ascii?Q?gn6qYrIWDCLuE8zwmrZxjIqvLepRtVf0KpeWi0m3Eszyv7nWhHPzzS3VkQYD?=
 =?us-ascii?Q?2tbW2XahuMfPKbfLs3WMcuGeKlyRCpUDlX9k+Q6UfD5276E4i0GohD20pMCG?=
 =?us-ascii?Q?/+ATL2GRgeKbH+thZHotTbfPrmp7W0VNEhMdPBk6mZ5zd6C8fb9AgNYvlCNZ?=
 =?us-ascii?Q?nPfgKZMdGwArmutSkVdHiiz4JX4YILxAaX/BQzOd9UKOepSO196Ah/JOJoxB?=
 =?us-ascii?Q?6V509e1dQL5+X9kd3WDbFAgJct8j6EhNOEBFwemfwwb4b/UhTc/xwggydVDa?=
 =?us-ascii?Q?uUwFNxiwuGBBl3AP9VQgo8aV6SwgN49/u0nmQpXuWhvc6QQtKyjvU3HVAkDx?=
 =?us-ascii?Q?LDskkfzSwoZr/hZZeVPY/KJAnUQJcX3KtdiMKoRBe/0T/ZY+xyGLE/2kb+pI?=
 =?us-ascii?Q?wufbTIxbFGO6SoawsO+lejyLf4eH/l+ZPB4mSAJeHcWhWPlMggBPd24ZZpLF?=
 =?us-ascii?Q?z/lj3kIdk2KPOaMma7hhxkLHNJedwQKlpJ9gA2ULnJ/vRHdRlUduLUffw99U?=
 =?us-ascii?Q?1QhUbLIebUltgBVuftgMcE/P7t/LLkHp1dAzq3QnxVZKbyrAU1bXtb5s2FYo?=
 =?us-ascii?Q?CUVYD+BMbR5oV03uIlfChrR463jePOCgmViaD/LqgqCasR99S75zsBlryWR9?=
 =?us-ascii?Q?HnhRxOIPsaCu1ojttUMiX/XvKAa2z/T5nTiBbcSF8WfXdJGh2JqqNOtDLZeW?=
 =?us-ascii?Q?JSktrAQrjwU0NMsCgmLZva0r0cnCUvHY6Oz0AykkJ0vhTC9zML3Th6qZSmQb?=
 =?us-ascii?Q?WQ7KUaIaBJJU2VNk/sZC2DVaN8cE9m0ILfuT4lzAhdzUm/p4//rmgwV91eKi?=
 =?us-ascii?Q?ruBAPpmy/otJd1SJ9Df2e2d7eMgSwXuOe1LCzO/390SU03iUFps+ovKWFD7L?=
 =?us-ascii?Q?/gxzwyPmL4bsPWLZppqukLCBOJY1fe0s5eloBO1qPEjfnCQhb6Sj0AXxC8Eq?=
 =?us-ascii?Q?ET8a+2s7AdjdyNfD61iLqE3waqmNIP8bVAHswkPmYXntTvekaBBxWULftJWo?=
 =?us-ascii?Q?hs/m3FLT2SfLgX9UtdJZSL2xOWr+pJzmGVj3Q6+JQHZnuy1Z1R2DdStkuKM3?=
 =?us-ascii?Q?jnhd8qEN2XVt7UZc1MPaSyyaBczs6O6jZ3KNEOrv9ayPQlugAu6ZR5ikwYTD?=
 =?us-ascii?Q?gtsXRysjlhugBrthhU9HKge0l6tBIm3q6eZ0uwu8kNIUnOvv82tgmy54An8V?=
 =?us-ascii?Q?/r+JS23xSGXqWPVKZR8JkJMFz43ndkIDDewaM4lC26WjmFZW483qvOX3Fz/u?=
 =?us-ascii?Q?vt2n8FgLBq0A29iMLV/J2cSTOSfsvWSo3qRf77fBT2V5uj+Qxnqj/uML+woy?=
 =?us-ascii?Q?EKkXEy/JTBLA1AykgkmLGaKXSYUf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB3877.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cmyz/prHOXASu2wmV8yQEWS33cUay9o4iZzQkgQxIaXinTS/Q2aeedSbO7C?=
 =?us-ascii?Q?UagrTi8pf0ZVkCMndrmsGgmsiI8oDsCVyYM+M8b4nqU/bGrZNPA/9YYhiyfK?=
 =?us-ascii?Q?TtPDtrxukVAd/rWwGMe+qoqVFDT+37N8E5kMJAvQnzJ4gO9rYTRClbd6V68D?=
 =?us-ascii?Q?qMSfapoA4xrddX0QV7mIjJb5t6T5L+GW+k+1M3zOf+eVErsiFdNY/2G+/yek?=
 =?us-ascii?Q?4rt+z7yBXuV7wwZBSLhntJ5ZZIsUgv0fRpGSORWKYeReOiMW+MyQpnKdQo4W?=
 =?us-ascii?Q?wpcY0G2a3y1zaOBKiyFWqLEHMpBZ+CjAt2d+YqZZXfB9EaTJln4jW+3K3RE8?=
 =?us-ascii?Q?jGn/ryB+CHunEcnxzWB8hjGFl60ZK8+v2GTbQwi70TJUgbgxqr2jwIuGw92i?=
 =?us-ascii?Q?9vQYDNZ3vr9uqkPm7tyO8fh3vVWcJeJM6N9aUFKaUvyhpu8LiUazdKm92gSe?=
 =?us-ascii?Q?PNIZrC70kgkBFk1wdrHejGFnDHbJJemjdUFOhEy5OSSRk7bb5jTK0l0lq9jo?=
 =?us-ascii?Q?8HkZhyiNJM0It1oLr2cwnKnP91SWm8VgQwJ4G+CTmHpXuILUL9OhFhreVk0G?=
 =?us-ascii?Q?aYy6RZcstI4et7RW+M9rKGKEno4HWPpM4UoJRnX7GrVXNwWbacD0pK4ufGdP?=
 =?us-ascii?Q?P/QBtplVQkZCGY+brKNOTQEFNiJoqQ9WYoevRrE8iRMEenU0WSyLqi9sCMwI?=
 =?us-ascii?Q?VkGMXvozwTfIav0LIdfudbVUWkDzWDMrbsBzo8PyN8nwoZTaMrXgMP0q5h5e?=
 =?us-ascii?Q?RLrEGuWWZj48NQq8JE3RyRP8tRNK7tFAuWqO+E3XqYIjE1GESvDapdCAdUTv?=
 =?us-ascii?Q?+mG9tKTbyW4Qbw0zxqaL778w9UGmwWUExOOC99QXB5eVZ2XBFY+c0dc/5Yj7?=
 =?us-ascii?Q?A1Vj2Ham32qrM8yLbSUnfDH4N9ETFQEfO1xkabdaqyTBjVE/H+fTpb6bIaZM?=
 =?us-ascii?Q?3bQ/r2BdymWny0XmZqRaxdoCfcnuBDwng4eI5Im9mRqANJ0MMr6Hz1U5/LMu?=
 =?us-ascii?Q?cYDQ0jOnt6MvCHP3fO03FZrGZdhEhhSWrEHIFtihPcCNKiG+vwF1QLgON5/l?=
 =?us-ascii?Q?Iu6jLOuSgfCQvHKnPC1n7TY5ydQ9yFKhBhpSGo0FRpOvUjDWpC03nYciKD/L?=
 =?us-ascii?Q?VXMEaG0tmhlEwyDu691vUajHWSgyu8Zmwfo6hhHvGGPPR5NFBL/s4BSQNJ7X?=
 =?us-ascii?Q?EnAJ6MsLl1qTicErzZY2Z3ZtjLzBJxMwdI1EGDXkCRMqsZRmBNhJjz5KlzE+?=
 =?us-ascii?Q?JhnDWXX1UrkrGMQcZZ6Gthe2kQo/J+pDV/QBQIhtEp6V/eXxIEOHQ4Vq4/rg?=
 =?us-ascii?Q?/OFoC4QBkUqn+6ar4P2ZrAm2ts1BYR/kZZ79YDsWX1ZbqDCjq3U7CJHQw5nV?=
 =?us-ascii?Q?QoVcRCGQmyH0IhwLZ/QC327LOrwxSIdwrj8hW4L00cMf45OjZ2YMzcfoslQV?=
 =?us-ascii?Q?DE8LMewIW1e1EtdI2lCMb2IAfrSVI31isZZTbi/ZOpqfBFwtfE2k6z2UDinr?=
 =?us-ascii?Q?+WYDCNXna8rIrFWIYVvnzOD3KWX0/PASly0FjPaFazHfzzOj9DorAZWjNAJ8?=
 =?us-ascii?Q?HxL3YbaaHbmHqxKXNVa7c0SpahUtkfRgO2JKae2fMtD/+oH/zv9g7NP1SBtf?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eae655a-a837-42e7-2ed4-08dd60677178
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3877.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 06:39:15.9251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLmuK9R+W/zC/yXa7mrb+smnH7QAHvoLLHEiFZujrq+Hx9mDogt3QmV6pDaPnk2Qn7ZB7l6teBJragbQTTFuhLs07SlnuN4SUVUoN5adYkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6049
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Send out "HPS_STAGE_NOTIFY" mailbox command to the
Secure Device Manager (SDM) in SPL to inform SDM on
FSBL execution.

This is necessary for the SDM to recognize that the
FSBL stage has begun its execution and should be
made as early as possible in the FSBL process.

Therefore, the mailbox will initialize and send out
the notification right after the completion of timer
initialization.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_agilex.c  | 6 ++++--
 arch/arm/mach-socfpga/spl_agilex5.c | 6 ++++--
 arch/arm/mach-socfpga/spl_n5x.c     | 6 ++++--
 arch/arm/mach-socfpga/spl_s10.c     | 6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 52617a39cca..91c27a5543d 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -50,6 +50,10 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	mbox_init();
+
+	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
+
 	sysmgr_pinmux_init();
 
 	ret = uclass_get_device(UCLASS_CLK, 0, &dev);
@@ -77,8 +81,6 @@ void board_init_f(ulong dummy)
 	}
 #endif
 
-	mbox_init();
-
 #ifdef CONFIG_CADENCE_QSPI
 	mbox_qspi_open();
 #endif
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index 3451611082d..a9aad5350d2 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -62,6 +62,10 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	mbox_init();
+
+	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
+
 	ret = uclass_get_device(UCLASS_CLK, 0, &dev);
 	if (ret) {
 		debug("Clock init failed: %d\n", ret);
@@ -100,8 +104,6 @@ void board_init_f(ulong dummy)
 		}
 	}
 
-	mbox_init();
-
 	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
 		mbox_qspi_open();
 
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 5ff137e5c6f..81283ef7162 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -49,6 +49,10 @@ void board_init_f(ulong dummy)
 
 	timer_init();
 
+	mbox_init();
+
+	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
+
 	sysmgr_pinmux_init();
 
 	preloader_console_init();
@@ -84,8 +88,6 @@ void board_init_f(ulong dummy)
 	}
 #endif
 
-	mbox_init();
-
 #ifdef CONFIG_CADENCE_QSPI
 	mbox_qspi_open();
 #endif
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index 53852cb7443..fa83ff96adc 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -52,6 +52,10 @@ void board_init_f(ulong dummy)
 	socfpga_per_reset(SOCFPGA_RESET(OSC1TIMER0), 0);
 	timer_init();
 
+	mbox_init();
+
+	mbox_hps_stage_notify(HPS_EXECUTION_STATE_FSBL);
+
 	sysmgr_pinmux_init();
 
 	/* configuring the HPS clocks */
@@ -84,8 +88,6 @@ void board_init_f(ulong dummy)
 		}
 #endif
 
-	mbox_init();
-
 #ifdef CONFIG_CADENCE_QSPI
 	mbox_qspi_open();
 #endif
-- 
2.25.1

