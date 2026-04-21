Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57ACF8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01DE83A91;
	Tue, 21 Apr 2026 14:25:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xKE9KyF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CE3839D5; Tue, 21 Apr 2026 14:25:00 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1C2801A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+e9HFQ7XT73QST6V32cl7ewZiLzZjlYLEY0a3Y8WzGlIRv4C00kqoYm3yELWk+snCWA6l8ptigRaEvECsksx8Tyns0kTkLc1zxM/b/V7yqBzevU7e6M3zSk1wXsYyy7x5AAlsMiL9C+E5RA3aIuiqBc8VsKNMI5I8AuDNq0asHUy5PHCAgjgGaLA3Mdyh76YPTwFaH7GbdacXoMzLPZ2rBmdagqKwZONqsqotuul1QvbvPzc4lLontVFNLEKEhutp7Q6S1WKPzllv0e3qA1ieR6mt6jhkZVxOpV+J6NRH54BvBxMj4jizqw415NbNE1aD8s98sHFhYimU5zCj5vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnarGLX5YF9m/aGbXPJLLEGQpMAuIVpcYqUnNQumGrI=;
 b=qJKzB8VLOBTItsHMuWfi6aZzyr0nI1o73OBiLSMBt/YKuabNA3ek4H1cVk1RlksN94p1REsHvG7uFnGdGWaUvqkjHqqbg4mNhEy5c/SI1PJTwhKd9Qy/k4sfSmsTFXAyblTtvoSnyEY4pFCx7tZXZ35Z4eMt/uTAgeZQewrCO/B/2pGRS8Gm/4mVEv2ceZib9Q4z+p4R31/LH+6JqXG2aDpscVHVMewhj2zz/tnCNeZyTaSCNH4G7D66rfYueNN7gOV0GQ3I4rmt3a7njii+4wFg9/gW0vwzWGSd5dlpN11ONkepFq/UgMzBbm1Sc7jFqDEe6TawhacQijgZMPSTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnarGLX5YF9m/aGbXPJLLEGQpMAuIVpcYqUnNQumGrI=;
 b=xKE9KyF7DVfvm8SFcKnT8KQeXkD1Zkr/9E0mDfR1oafoX+bwzjozGNlgYv5M0uutEZhpb7UoBSHHWHQic927037rJLDBN7ATAUEo5ANi61zAmuYWuO4rOFwIr4cljdfryUSIb8rCUbGstBh3klFI0qHB5T5/+uSVT+Xw61lCemmlqLhrwKBPATOVFhPhr4ZlnbDWXQWR+drX7zVJ5mM4SEOQ8yjMD7GoXyzVWTqjQTkZgFyYsLc8+mY6gUQ9JHcXEoEfGJS+7p/big9t+diBli4/IlIoOCYEEMhCHlNVZWG1wEM1np+qrjqG39Z8xPTLdUdBYM+sCoQS/biDxbgyMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUYPR04MB12667.eurprd04.prod.outlook.com (2603:10a6:10:65d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 12:24:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:24:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:13 +0800
Subject: [PATCH 01/15] imx8mq: evk: drop redundant gd clearing in board_init_f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-1-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUYPR04MB12667:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b69e4f-e59f-4f11-edc9-08de9fa0ff4d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZuF8QVorEG+qIJjDCQTKEiLI5G4jeprVApCvc/aPtEOecD+JEGsefLW1F3dhfQ/H5bxfUIY3ItZUu8LMosbXy4W6sQn3ZxIBQXw4HL2nz3HqjPyFF33SI1uDUkWe9QZRg8cAyZY3xqbLcwB2SIYjkClg1N3UCyyOjp4miDbWeYHhFnR0MBwEesfdS9sA7LVxpTJjGu8E/jSRM1mI6iv2RVh4N1IwochcN2PcSxVxNgHuRie+OIS8X10eJa4YAuwv1meD6/ZNHXl9n1Iom2EI/H1eUWK5H2hghDduLn9IUSatRu9ozj7ecsR5fjK9q8oMDDl50BaHstXJaZvMTw4P+rhYbAAUeNe3qHLcJrtHm5/MztCOL/dReXiH/jnFj0WAsUjlZMb5AVpT17Lh69G8GdEaagFAtMHmOz1eoXjUpNpUnK4A21LL70urXvMWW+XXR9LK3f6nYDDGVRJzDvyQ5HkamBB+sJNjHRM8RVweXjVwHeailj7WzQP7WJxr2WAf0srB+WWimXnW0+FgntYahpuAsg9/YsGGTdSroi0MhTRCCVuzSxrk0rpEkf2t2EqLe7b/LIMZHuPqlMBgSq4e/+jYvswdJO4eRXTPOOAwI5ZvvBCBcEKKex7kMCqVihWT/SReyXn+bafw/eW/IAt5ICz9ugL20sXIoA9dV0NPdwziO4etwNRkwEK4I3U9wq95g0Wii7ZijHrMzbp8CpyUrB3yJu53qDDNCvkFTT2bos0MV76Vx9zhm9ts2s2fTIvBUsYvVgFqkZu8p9JBmj7NvJ2yYcOJb6a6vj09kSERDno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJTcHQ2ZVRiNTZuK3l2dVhpRlNzaU5DMFpRNW5GY01PSEFJdHhnNmIwTk9T?=
 =?utf-8?B?MXRXSnBaWW5YN2YzTmFaRnBkWTJLZGYySUlEbGRKZG04OXNRcDNYSHVCc2w3?=
 =?utf-8?B?UjlKMDJZVUxINUxicVRGVmZSKzBZNkFOMDNQWkpUaVRNWEs3VHBJdkppM0t3?=
 =?utf-8?B?VEVDaC9TdDEwRUQyUk43TmUyUEI5cUwreWJLcUNJKzFoTEU5K2R6SnBnRjFl?=
 =?utf-8?B?Nm55Wm1kdWM1aUZIL21yQTVLUjhseHFkdzZueXZ1WkZBR1IwNVJnOTJsWmxn?=
 =?utf-8?B?Z21kSTNkR0lxR29OKzdIVWdJSjZOL0Jwakh6eCt2eE1DaGNWMXdjVzhwem9h?=
 =?utf-8?B?TER4OWdtaEhIaTFXTTVaenpFTGgrT3BhcDdTQStXbUhzTnlqYTFlbFErc1FF?=
 =?utf-8?B?Wms5akoza0hQSk1QcUl1djJNMFM1c0NzWDJiRGp4dEZHNGRlR2JYQmdBaUFz?=
 =?utf-8?B?K1JGTHdWMk9XVUhXWEMrVEZNcTRJM29rR2Z5WmQrbjNaN1JnQkpFT0RKMDgw?=
 =?utf-8?B?VExSSkJ6MTd6Q3djY0tDbGJHVHB6d2FtS2YrSy9oUkM5ckN5by90M29sOE9n?=
 =?utf-8?B?NEsxUVc4cEZHc0hPbmNOVFNMa3hSSHo0WWkzYmRRbmRHSUhMOTVpdjJLSmo1?=
 =?utf-8?B?NGxKblFrbVZMTnZKUkMyWW9pN0tPU2xzeUZldTV5U0NnRTVJdjJJR1o3MmRC?=
 =?utf-8?B?aG41aEF1RkpEdWNnYk9BSndGVUw1TmpRWWdWQmpCRm5ZWWRWd05xa2FRSWhj?=
 =?utf-8?B?UytaeDVtRjFFa0FPelhIWmxJUXBmOFlQbmNxVTBRT2JibUhCMDljcytKeGlh?=
 =?utf-8?B?ZjNmWmVBb01md2JCcXdRU0ZyNkxVQW40R2x4M3ZYWWIwQ3JqdkRzaVdwSzNt?=
 =?utf-8?B?UFhZUzlBdERnTGdmL0tjRU8wQzY4dFNwL294V2cyci9mZ1ZXbkUvU3dOUjVh?=
 =?utf-8?B?T00xNjRwOWp1N1M1c2tncDA1dWsyaWJXYWFESG5kNG5BN0pUU2hrNGdrc1BG?=
 =?utf-8?B?a3BpYzhrbGtFWW1BTE9GVExyenRCZ2pUZURjeWpCaUJxR3FqeldYc25PU0Zx?=
 =?utf-8?B?ZVlIcm1NNGVlaCtEOTA2U0oyVG5pK3FQWHdtdmtXMnp1cVlmTWFVZ3VYYTQ2?=
 =?utf-8?B?UnlQSUdneXNTOURmNEFoTWdtZ05rNnNpSFY0QzVTZDBlVHNmNDZtRlROZFVN?=
 =?utf-8?B?cWNqTEtGMUVQMytXc2o3SU5KQWI4YUhyTFpycE5lbHczYVI3QnpPYVlFSHEw?=
 =?utf-8?B?aXpNZHd1MEl0MVErZGV6RmNwcDY4ZlF6TlF1SDRlNm1OWHZ0K1FsM0p1T012?=
 =?utf-8?B?bTBjZ2pWeXVCeVljN1hxL09PQ29SWDZqVGNiU1cwemk4OGh4U29CYXpEWnpz?=
 =?utf-8?B?K0FwT055UjNtR1JhYTRLRDV5UjM5c2VZN0JzQ1VGTTl1OUdtWW8zRExZNXF0?=
 =?utf-8?B?RndWUm1IZzJtY2FmVjNLbzlxOEN2dE80N1p2L2U4TGRZNGhtVXZRekM5YUl4?=
 =?utf-8?B?MmdqSm9BVDRXK3J4aGVNenlYT20zOWtzMkRmaXNZK3BzazBackx6QWVKMUhx?=
 =?utf-8?B?d0dHSk5aNkxrRHllSG4rL1BsL3gyRERxWXNCVnczamludHVWYVVYelBUZ0hv?=
 =?utf-8?B?WitLMGM4N3pJcjZ0c1A0L1BuK25FbjA3M3JHdjhFbGEwQTJ5dElOK05Ddlkx?=
 =?utf-8?B?aGdGUENxOFVGcVovZGhTV1ZoZE9BbXNFSlNWUkNQK1NiQ28xYVRpRVZsamtR?=
 =?utf-8?B?UGhTUUYvWnVEN0lrLytGVU5DdG0yUnRVcUw4VjBNYmx3WThVWGQwWFYrb3VU?=
 =?utf-8?B?Q1FDK1dBTm91VUlIRFdoamFsQmVJTkZMSlBUanhXOTUxWVRycTd0eUxCNGpS?=
 =?utf-8?B?VU95VHdkcXpEMG9jMThiSlJUU3Q2aTFYSkxrd1JoWXgxWm1EQ29oTWw5L2Fy?=
 =?utf-8?B?ZGMwUkk1dmI2eG9MN1ZjaTZsUGdjd2RaQzhDd2ptdTFmbTdYc2VKNmRuTDYw?=
 =?utf-8?B?djFxVUpJMEovWCtNYk9La3NYTit0SHlxRjhLM2YzNm1xdk1MOVFiREJZcEdI?=
 =?utf-8?B?RHRydG5YZU5BbUpFNzU1M0NEVVpKRUV0MUJRb3d0eENXQkZTb1B6dENsWDVD?=
 =?utf-8?B?NG1sbDhNUVFGUHpEdWNHQXM1SXh4SmVXTWtzejhibnp4cGU0bzN0WVhWZVFE?=
 =?utf-8?B?VGVRd00ralE5d3NHK0IwN0RLVUUrMGFjcWxadDdLaGFyS3RDR0tLTWVxUUta?=
 =?utf-8?B?NFdJYkYwMEJLUFZ2bGhlQTd0NjI3QmcrVUZ0L0l0SVFnTzlGNUF4Y0xWdWhN?=
 =?utf-8?B?eGRjMm1jOUZ1Tko3VUdpdTlnUTZlaXNpYy9FYytLMFBuamxwN0hydz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b69e4f-e59f-4f11-edc9-08de9fa0ff4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:24:56.8605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX9kSR387u+TDXrYIhWqe0lR1MwveZADpNk1Kl3MR10W0YNJyrleOlflKV+nG//lOW89euvllFpsTGLSmj1J0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12667
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

From: Peng Fan <peng.fan@nxp.com>

The global data (gd) area is already zeroed in
board_init_f_init_reserve() before board_init_f() is called.
Remove the duplicate gd clearing from board_init_f().

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mq_evk/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/nxp/imx8mq_evk/spl.c b/board/nxp/imx8mq_evk/spl.c
index 5116d806bb6..6686fe34126 100644
--- a/board/nxp/imx8mq_evk/spl.c
+++ b/board/nxp/imx8mq_evk/spl.c
@@ -218,9 +218,6 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-	/* Clear global data */
-	memset((void *)gd, 0, sizeof(gd_t));
-
 	arch_cpu_init();
 
 	init_uart_clk(0);

-- 
2.51.0

