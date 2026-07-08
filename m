Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467CC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB23F84A73;
	Wed,  8 Jul 2026 14:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vEf0GWbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AC08497A; Wed,  8 Jul 2026 03:13:36 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09491838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFfbGGad1LVNfdoBPhlG8Aa266OhM0NLRLogMnssS62+ly2AAxVOyNOQvM9A+GlHgSp4JwOwT8gAFOd2ffVfWniEG8m7mmusiTRQGVjdQJB63HhH0YpAejFllgkMjYGCYe49co4FNSifKnGyNFH1x0fzfgxUZ4F5emnHGwodlbgP7JOSzS4N6XLJT5cX0v0tkoAc5s4Y3XUWyPcRJEbaRx4px1MnVXlwgbSc5MroudL/QSk3Z69TqruXbd51BXuxr0OWNGYTa3hUAzOmLdu74yH2sDGX270FeRGXQ8lpAX8sHKMw9f7s3unDtxNpB+61iwsScUGDHicpVB9Y+k6TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5p2nHef8ePrLRE7w7J8qwtnE51rOIytTDSZ20vBz+M=;
 b=WDLT5Y0SZ8ak99Lxa/KPNfA36vi13ezd7vJhNY0mdLYD8xcl/D0FkNGYLVfxtBt9qxY6X08vGMGSbOXcwS3M0DNIbEh8OW0rAQnWwco/c0TLDmW2AYDmHVhL9k5on77Tqghttcepxga60GnHGRlrK6WQBrN1c1AErfnzcEGgA66LbtDxG8vxFemdd2RUhSNL2cLK5AVv3zx/nbjLIwXU4VDqK+GRu4IyWnpJmt9cDDW5Ijz4OfZwXk+6q9Z9410AkUhhzWYedZ/pgL00GojqguGsGGnsDg38qCug0eUUpPceO01zkQUwd39RkWDXh2xBh3jIZcy+gISJNrnmzJ6h9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5p2nHef8ePrLRE7w7J8qwtnE51rOIytTDSZ20vBz+M=;
 b=vEf0GWbTFGBW8no7Zs3NJB2U57Ex04MzLZX0cjV4aXFK7/IfxXpU2p1EQlSdrvKOzyRrfvaimJAVE2UmxfYBtEWBA8WslEliHCeTZPtaQeHR0HKaWGLFnp011Uw5sxNq/dIOdZS30NpB0KYqA9weyyrRA7yoZkN7m02avByb93lhrC7JBYfhTVUgdIpGsOM7TnkzjVpjU/NqYcNWu587eWuUgM640An02CJQGbZMLPkEyTZeSSPHKVpJeBzE0rVDRD+qe/HMlKLQwp/iMXQh0MzF7p90ABsg2O3eTMelHxF5vMmKcGId+pem7851YoPAcuSRSMUbl2yJg/iTwXlBVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:31 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:31 +0000
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
Subject: [PATCH 10/15] ddr: altera: n5x: use correct cast for reset status
 register read
Date: Wed,  8 Jul 2026 09:12:23 +0800
Message-ID: <20260708011228.15613-11-chen.huei.lok@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 532583e7-f17c-4c62-a6a7-08dedc8e1fc1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: +fv4Rrf4dM/+O+4/ZJp9YFwt+WfY0QwFVVoDIzY3lLKnT5/mdb12QEACicaXNz8hRf2b9xE0+/nDOvl6vhzSEc3mJyEn2DncxtE8R34e7vEn7Xt3MzU9VHrcYI2Ozk8xHkgk48VeYcB8g1ftYrI8FaD6nJaDqRMCwTAXQe/pIvJXjfCKwGNVQSCWqx4hnIgI8zuxUAr5Nu/PUGFDR4kKKuT3HpbpbIwUpm7yfpQ8HRu8Qcz76HhtyB1QplmpW9hwlJcUy+D3wd5mMj0H+Zy9ayzxDTxFiJbYJ2I6CQlQb9dSFIp6NH5N3bQW9Ee60fQ/QkHih5zzkn6Grt9I8hrlJodoziXhT2ZzudbJ4gBuMH5uPOspEdXM+ZbP4lkSL2YJ3nkl2Btkhd2kgYWkNe4t+dur0K/QvzU9P2GmuCK17sMVgmzK7qX54OE4n3t05Y1feRO3KDM65h+WCEQIQXON0W9UI05IAa/Ou7FuWSJoAXRJ1XGSNETuyB5fgWb3bPinjNJP5h1NHnQixYjhgfHmX8EEAFqbmI0zeXLtS6Q47VZl7WaLmjR0aN1mH3P62LpDaaQcWxSdS3WDeWfcb/gNE4fCxFqEi6tuy+9+t2L5E+L3ZviUJruyL7pXaawKp52fsjA9fULD0ffmCVmH7r1tOKsA9osbtRPIg+WYRE2gAp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R+YNX05VMS7/2724EytWlB6xz9e5MCBsgEe4zm1QuZr26YQnAuqCApmgBhDp?=
 =?us-ascii?Q?VjMflVqwX6ut+Ga7IgsgPJ+av4jsY56qAo1ZYQn8r/bRNz5Xqo3hotAoVFZy?=
 =?us-ascii?Q?+UfWHek4/8mSuqKtOxiVzWj+ETWRte+lQou+O30X0dGyALjxjUZSP+J68roS?=
 =?us-ascii?Q?avII/9HWVDybucV4qNMt88yBoYe8jRM0pNY+/GCk1mRTepXecDAnmHxp8KxP?=
 =?us-ascii?Q?VSPkFSES/50DSX99JUzOCgvdQF888qiuAfFjLsXROK8yGBRo9T6s/kh043wI?=
 =?us-ascii?Q?ey/ePG+WaxQwAUvczBqzqChRMF/KHtS23XA5bIax+EOvcLy1OzCPesyFMTwy?=
 =?us-ascii?Q?LFL5vmRfa6MF1IuIrBkNiLlLMqHprORG+DbsrFZ7fdKDuANlRLO/8Cu5+aoI?=
 =?us-ascii?Q?ms4PkP0VBk2JJPgak0xZaJF+UTs7+2A/QZ/vl6wj+Lj8JUX+i5K7k3YDZvNJ?=
 =?us-ascii?Q?hKBIiHPCybMY5/Lqntg5VlCOYW53aejTj4wfRz/Ulsbutfsjv7D36dAkxQjh?=
 =?us-ascii?Q?Ms88WoGsmAzzddVuNcOWgFh5nULNnvolnBsQDRHZAfNTWw85NWf+qsG9nKYw?=
 =?us-ascii?Q?rZO7v6iUiTaHMjumFrFgl2eJ/ttsEbizCkO4Q6iHukMPNkqSvPsGdPaF+Q/y?=
 =?us-ascii?Q?gJPDoaPwrdvgiS4mL+oUffMmSkzxS5y10NQWiN5wUads3rZRoQITKphXkF2I?=
 =?us-ascii?Q?puKtzyhTHy/WzIcdVoepLumXqimuQUfoP8wtpGbc6m/beV41PdjQWe1ZX4RG?=
 =?us-ascii?Q?ZnCSP3NjnbOf2LxvZwIuNsMlpGkTAgpumfdb/NXVvFweqHiIBYmj1f5aZIuJ?=
 =?us-ascii?Q?QTZ6f+zbXll4FFRsPkooNICuNkeolCV8P7gHVjFc7kWhj+h2I8EnCML0ONOl?=
 =?us-ascii?Q?gw3HP3OpkONXJ/m0O7Vcsrsb/Woi36rV/WAHR2fGeTdJQwN0OTLWI7c/oMrx?=
 =?us-ascii?Q?P87CUe5mORVpgZCUdjGPcQBnd4dLsuuirxIqhEDSoGMgBQYoj7FFzdtthQWn?=
 =?us-ascii?Q?u/xPR3H6Z23xKiE6/4AaFWgsUEFyNi26E2MeARhep/ca+WHgwGBTdwijk+RW?=
 =?us-ascii?Q?OtHhGbWfylpovLXJUSU1Agjn7cuLHr+BFHfa2EEUDwNTR1sYXIjCNag8t6+c?=
 =?us-ascii?Q?SUD89HW8/oCb4BX/cgA6+z71bO0Ht+MojVxIH0/koJA2npQVpLPWM38+cyVp?=
 =?us-ascii?Q?w3EwT/oUq7zfBDMVGcgauekEpFZqXO6qI58ZvIMmVuXJMsxT8KlhUMivzuXh?=
 =?us-ascii?Q?P3yTy51ejIiFTd0xX9SKV1OO6aBS3Egm7V8PuNB5yx+o3dFuOA7zkzsm9U2e?=
 =?us-ascii?Q?icpqUKibFDcPn98YHl5KBE1Og0c8zHu4snlPuFMTZRLBT+MYgP7QVu7JSvMq?=
 =?us-ascii?Q?LFR0qbZzyPuDfkCvuO0kgajnCQ2Wqz/rASgSz2IkJ2GMODE0RWn1CCk/7pkW?=
 =?us-ascii?Q?xvp9yU14pUZLMSjGKimM9uKVdBcQg8Mx69bUzjcQie7I132LF8fw2D9wLjSf?=
 =?us-ascii?Q?346Ky216OMm2KIyxjJaArnPXN5QsWT2MSsgaha75Jwbm1Bs30TXlim3VJ08F?=
 =?us-ascii?Q?24/7eqAlLRoNQSIeBGRtoK1rZKY14Pv9wIftex1DvYVPufKHE0OWx54ViPhy?=
 =?us-ascii?Q?AjEzW96UTPJRTw5OUqNme+EKIUcQ8z84nBdwH79htxmh30cF8LGKwolMfaXQ?=
 =?us-ascii?Q?J5RB52OU8Zbup6gzjYsN810CvrbWoB/7/wfaX3YleqcEml+aH0Wqd+d8Qigo?=
 =?us-ascii?Q?PfRHPCiAAWUlooL9Ls84JQS7hw2K/NE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532583e7-f17c-4c62-a6a7-08dedc8e1fc1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:31.3092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyfNCxZdLFbywBhueGDFAHQI6m5SlZYbBfGvosR33NKQwK4hSznFqwBJyPZ0npQyzb50NyebgtZSDe3QweZnwSRYilrl/dEue5tbfBRDBjU=
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

Klocwork reported a potential value overflow from an incorrect typecast.
It cannot actually happen here because the result never exceeds 32 bits,
but correct the casting of the reset-status register read for the sake of
good coding practice.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index c101123b14b..0bb04c5eac6 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -2864,9 +2864,9 @@ int sdram_mmr_init_full(struct udevice *dev)
 		 * subsystem in complete reset state before init DDR clock
 		 * and DDR controller
 		 */
-		ret = wait_for_bit_le32((const void *)((uintptr_t)(readl
+		ret = wait_for_bit_le32((const void *)((uintptr_t)readl
 					(ddr_handoff_info.mem_reset_base) +
-					MEM_RST_MGR_STATUS)),
+					MEM_RST_MGR_STATUS),
 					MEM_RST_MGR_STATUS_RESET_COMPLETE,
 					true, TIMEOUT_200MS, false);
 		if (ret) {
@@ -2889,8 +2889,8 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 		/* Release the controller from reset */
 		setbits_le32((uintptr_t)
-			     (readl(ddr_handoff_info.mem_reset_base) +
-			     MEM_RST_MGR_STATUS), MEM_RST_MGR_STATUS_AXI_RST |
+			     readl(ddr_handoff_info.mem_reset_base) +
+			     MEM_RST_MGR_STATUS, MEM_RST_MGR_STATUS_AXI_RST |
 			     MEM_RST_MGR_STATUS_CONTROLLER_RST |
 			     MEM_RST_MGR_STATUS_RESET_COMPLETE);
 
-- 
2.43.7

