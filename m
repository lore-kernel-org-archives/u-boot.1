Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599C2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDE484A4B;
	Wed,  8 Jul 2026 14:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NoAcUp+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3B418497A; Wed,  8 Jul 2026 03:13:21 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12A5849BA
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwiPMeJLZ6I2wrW1MlOR8H2QHygAMvxqHuvb1xCxtCyHQRaHyLX7PeMEdTV/FFjcSHpV+TTFah1lRpYGvcADAbYoB+XMAowRKyFMpB60old6QR2OI8mh/5forKzmfjPl2860ulcJ18eRWzpW+siWZEeICN2a/Sh62YvA3WTKOa+rDx3VxUHtpH395LEA2zWdqrqmpKQISxU3EsNkcWW1gf/XXnJX0S0xZb4ylj2HJTdhv2BMxSpUHzNOBBaJe+w2tzWyWweFDlhLRyETJhJht+WwaFT96CWovWumKVUJYYz42exJ++5Ak8oyOyWg+WktJUO3lpmnY2Nznr6NRj5LBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3CuHn0O6bLR/sHoqMsTm+uRFCPBL0R6QyNds9uZATg=;
 b=kP29lsng+IDPxRrgZw9t+M24QT0KhMPnFDE5ROFls4UQ9w1FLw2Vly0tbXfVgzxJt+5dwCyA7skC+NHeWOoCOCL+MWI8Q6snmOgZsGhQRV1wl83J1HbpMDKn8NQe5dp+DNlt0TZhaXYNkJRduVm4GsV1f7+6eEokIwrIybKj60ZXRmmV+UVLlDXXu0yG0pWGnPR6h9U5URH4jSLzBX/+hEdSk3BXvj2nFfI7detL9Mx4Ee5sDrMNrgYb7ragA5k3ZIbDevIDCQ2QvJ1dIvbLbZO+6dPh7gE6HkgPkJA4uuHfgVdj2f0J5jdlPnq/WMc/qNdCXUtmjgjmfPMvLae6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3CuHn0O6bLR/sHoqMsTm+uRFCPBL0R6QyNds9uZATg=;
 b=NoAcUp+BUoPjrq1crGMgoGvQfS/jCyUz06thebn+vXXQ0fMmwmCs0fDv1YjTUqHeA+BH2ecYJPe9cUZs3jGYqr8AIzePkGPbqxjdQzCFrW0KO/XJ27kY6XRwV1uT3nM2a9cfzXgp85lmOMvrzpY6geuOzTrGJaFy2SYWrKYar9qdVZ3DeL5ptxdaqHMPcP6F/sAxnRNldYd3yFRdywukx9ogRQNHgWFtUAa8YUPedc6TJHmVux9IKOOWj1igS2APzrU/2dOc8T1i1raYS1D7XK+ObqxbNgB57qfl4QGHNAJ9hkFbTlb1GLO8yC+Cp07WfKr0eRIaMf4z4rqNqmreLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:15 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:15 +0000
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
Subject: [PATCH 06/15] ddr: altera: n5x: set DDR init progress bit for
 watchdog recovery
Date: Wed,  8 Jul 2026 09:12:19 +0800
Message-ID: <20260708011228.15613-7-chen.huei.lok@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: a8a52860-2998-4aa9-9ebf-08dedc8e1631
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: PYm5b7jp00i3f17d8N5DHkAqVcXzcxZ8U3pzFGZ0r5/jkOeEzVn3wtIi4cfGUDiGSQcblPIEvJUV6yyQ68ZffYZuG/B3Fuza5L6KJeCoCWIZ/As8Q2pQxa4G7TUYbue2/2/QCe2NyIJ6OpG33UbeGOidolpe65EH8i9SBQMOAUipP73/940jEEQvT7KbvJCiMbISy3nMDkDzJlPTL6qEtzuTWNroqXRMT4NFeT87JgoVZE4R76Vu2WY2e+q98YZXXvzd/7kPxAUfSPCSuHLFjQr6UddS6y9vu4FKw7W+/9+CAyRLqPVq50WkeEtVEiqyntIaAmDSpSgM6pdufAfIU6IXzMb2zwuQKEqIEWNgbosj16KLDwxZH/U7kBb39tQfLunNWUD7w4F6ecUhmIeXpdWjMjqbZAv4guNYuWmyQgYjbaQZ+Ejx6/t/KRjDG6RvHniBn49iKZK6dYX5W5B/mcQLIv7zdZI7ZWF5KzJx/d2VidqTBE0YLEwGJAxjSN4lfRpCxoSfiwmX+ldMAJxvoIzPkWX2aBQqtGGaX3GolozSDi1fO3/7Tj7plej3A3U1V6NC71btm0JZbaSyJZ29cgTFdpEdBw20i5/hNxd7flyilaBpjFOi9PDysCsjBARXdeVIg0TvW/M06QsqcYmvLDBoEox/K5MwY30a5jcTs18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5GeDgB3iRsALqcjkbN03PQjorkCofkGGBh5Owsrm7BF4WuxmJrgMt8qym5wj?=
 =?us-ascii?Q?bQjxhB9AWIfbUAzu0EUmyhSJ3POGDHfESryspYvhvevzcTE6WcFCidJNjRr+?=
 =?us-ascii?Q?+swTSxWjJA5O6u1C6c/Qte8srthl5zlYdAe4cfH45678UipmpXZZwF9B55uO?=
 =?us-ascii?Q?JRzhq2xxG2vswSuc8l+HnULqzhUvLM5GKYM3wbzVMw27IbxSLrObPAI+L53Z?=
 =?us-ascii?Q?DI9hSubVMhf+jZ2LNM8iGQJl+Pcu265sGfrRnKaerzq/TaeTFvZSqKhXUkNE?=
 =?us-ascii?Q?Fw764/4FM1sirdPOFG10yhz5/1pVtD/LtyCSVEEFxAMkXq86S33TQWInC0ny?=
 =?us-ascii?Q?l3L9fcUyg24KRS8KyXxU+4y7jPQdyI8dcBOTGP/LagoMvYDedE30jG8T45Hm?=
 =?us-ascii?Q?iD/hv8MiE20t8ww2kIa1yeiVlvUBrk92DTJMPejeRmZYW2thUWKAogV3RzVC?=
 =?us-ascii?Q?UzGwAktbXbgL6tddwq3/hKAfYtDDXEJoehRJFFrjAhw2sNseQCgsWE1KllPJ?=
 =?us-ascii?Q?GeSNIOBouCQJgb90LNhvLoCZdlbu7YldDq88hbEDzbbXE5nrzmM9agMTxsHN?=
 =?us-ascii?Q?keCTCUYVxrfnop5j+BSl4MZok687caTiJFm1ywUaVIabc7uycWZ7xr26B35i?=
 =?us-ascii?Q?B2L83kzop18lP9RmGPlZ7WP7Qpd5uH0FMZWNMzzZh+ewc1T63f4QKGHobmFX?=
 =?us-ascii?Q?dI4G4gy+vYDOy4Y+degUBbz6LKYMKjZ7nysX6P/L5rqxFwQYfqFit3uPzyb3?=
 =?us-ascii?Q?3KhOR/TMRWTgXcciQ8UO8eoCFTMNjWbHODUZUDjotR2cysq2Mvly1rCNvRF8?=
 =?us-ascii?Q?3U0lkZI3z/iSntWSQoFY85J4pFxP3xCHH4R0etYZB9Uan0lIu9lQaWLI9Osi?=
 =?us-ascii?Q?9Tvi7xpFHSwPAXxB8xsXAQYGaNCC+j0JAA3QzOYeCwbcPEDUzl1QgbBqsm83?=
 =?us-ascii?Q?Xo2uzeS4WC8fWhaLZ4B1QJ54JGDs55eLAZp/cgaWqtkTkR1L14J6FW+ZGMsE?=
 =?us-ascii?Q?omv/CR5HA/0dmVKF2ZkSlwbsYCE5cXtXXMueWqv/e/5PuqaJhE/zNJ7DCUNf?=
 =?us-ascii?Q?B9zXQ3g6Di5bE7LT9MWCCFtd/25ziDGUGy7TX8PoUPvAID/GVEI0LzsRcik+?=
 =?us-ascii?Q?XhQFPrfq1G6TSYpwcbQNXTTosZeINM77GHE0i61j5FezyfgbERpFdzvzeoQA?=
 =?us-ascii?Q?THNvaH7ZueQZFxJtxmTGFxVGpoeGVHuFM32m7KR4QEraIkYtxHsfvjb6OKAF?=
 =?us-ascii?Q?2FOe+fspuw6lZWx0BnOeCFRMaFaKkMPp1UgWDEuxQ4ZTgCXz2Cf3j780GUa3?=
 =?us-ascii?Q?EO9WIur2lKxj65sLdFreb5eprx6Vi88vnD0h8osF+T0PxgKvFrZ1o9k+lWCY?=
 =?us-ascii?Q?wx1pHIiEZtpJLQJv9eWcyKTOHIlIrsm1R1Lk7GK5NyaBHw4YxZGDMsC8n8/4?=
 =?us-ascii?Q?Nt1X9lkBB0fY36l/gczmiZTKi5J4CAinXHck8WOxkrIu4nRw3VaNmcbLgJMo?=
 =?us-ascii?Q?qbHoa/TIYtQnnIsF4ebxYM+cX2yZVkzpJtKA0QnI065X9BDUamE+vEOPKBMP?=
 =?us-ascii?Q?GwK3fGnwQv1zd5SkdEaXHDigw/WVTqB6yEQH5P/bIsVs5MvLuhWUH5hBGjPd?=
 =?us-ascii?Q?3kcCWFlapTSmMrr6uVsnwfJHmywZipEsR7ZT/rXrohBAwDJ6XlGPz1QpPBVc?=
 =?us-ascii?Q?Z5vDvN4LnKG/3qnEFv0sJCb80DTlCKx8zKzkBdlmiYhXL86J9x+v+Ho84huY?=
 =?us-ascii?Q?4UKH+DfEIIR9jY+U6hyBLh8mOrkPav4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a52860-2998-4aa9-9ebf-08dedc8e1631
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:15.3360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z/qFvkwXHJwukR2vAEbXqb2ed7atJngxjixCPaYBmG/kR6ym92eV3ESLDDPYvvJKPFtB0TkFFlEI6gLHtUGEoztZAfMeVBSyf/iu7C+IJ8=
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

Bit[30] of the boot scratch cold 8 register tracks DDR init progress. SDM
inspects it when the watchdog fires due to a DDR init hang, so that it can
run a clean reset of the DDR subsystem before the next attempt.

Set the bit when SDRAM init starts and clear it once the basic memory test
has passed.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index 609f0f9cbd7..9c3f07b409d 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -421,6 +421,18 @@ enum data_process {
 	LOADING
 };
 
+void ddr_init_inprogress(bool start)
+{
+	if (start)
+		setbits_le32(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
+			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
+	else
+		clrbits_le32(socfpga_get_sysmgr_addr() +
+			     SYSMGR_SOC64_BOOT_SCRATCH_COLD8,
+			     ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK);
+}
+
 bool is_ddr_retention_enabled(u32 reg)
 {
 	if (reg & ALT_SYSMGR_SCRATCH_REG_0_DDR_RETENTION_MASK)
@@ -2815,6 +2827,7 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	if (!is_ddr_init_skipped(reg)) {
 		printf("SDRAM init in progress ...\n");
+		ddr_init_inprogress(true);
 
 		/*
 		 * Polling reset complete, must be high to ensure DDR
@@ -2965,6 +2978,9 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_size_check(&bd);
 
+	/* Marking end of ddr init with passing basic memory test */
+	ddr_init_inprogress(false);
+
 	sdram_set_firewall(&bd);
 
 	if (is_ddr_retention_enabled(reg)) {
-- 
2.43.7

