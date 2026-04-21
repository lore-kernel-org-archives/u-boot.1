Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EFEF8FA6D
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E75840D8;
	Tue, 21 Apr 2026 14:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q+2M+Bfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A2783FFA; Tue, 21 Apr 2026 14:25:15 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864F484198
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv9+Yu+Rfa5as3RrBh+Mpkuy3K77AE+2dBfobJmFK2Th5wJPVoc7YHXs8lcinHAoS4A4vI7DxYdOV9oVpSdrcuvoVnusrKTRXy/GzRSq+1jh5h6kITYJxbwfO7iYDsbQEcC+Gp373FwRpZWowW/JDCAom2RTekWGeUydpHnJNakH67RhjxyXZeC80cDT2M8Ci8Vboo5W5KzD+ELbMVtohwNiSz7zHNQZdYc4zHlO5gkpsJEJMlrZyPyjME+BfVze424IWRBfkEU3eNxXoIUuCb4iGhwLJkeFB7/hnM93P+4Yvbkjc6Gx0Z52vo2VImAJYT7vVWXp700BoZz3JUWzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91App/XUKJ0X1RjMPKO99rSsgZ2lWxkRa+fxb0RO5S4=;
 b=RTH+JfLFsQnAn4fYqCXNey9HbAxyldOVKG3nmqYk0TE1sAsV1bG9WSLkUyRDLcV7g75hZAvBD8XTILnp49v2q0Ka07pnXJ+W92/bqWbtDQIP9PS/GC422bxf8QwVkF8lWc8AP8HpE6YIXTRfH31SpOx+JW12DkIlL4/OnvEVLDCHC/9TTNoQ0UUmA1p8q/IYzjG/g+S3r44wB5dWjnthrCtoY/qc07bpDl+GT0nNP0QmLcEIPu4qparI/OyrOSJur3J4ZihiyH/9318wi7x9+LZmt+gpBeUZzk6A6r0KERsTXM66SBqQ5i5o4Kimrl1AABqb2DLwk9UEWEvsYcad0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91App/XUKJ0X1RjMPKO99rSsgZ2lWxkRa+fxb0RO5S4=;
 b=q+2M+BfcFgwMbcagT6fKIptp3pmtr3tvbxiQQmcKmp2uzStactqDgejmkmbWcDcFVKIc10z34fmzAv8P2Oap4XsqPnc09yUmRh9qWw7zfTsB2oWOh4KPnN4vDNjikJXfJn1GAWQRK5XGzX42hXaevW7KXvuc/2tzPJrwmlRnDsbkJsvvyZsWUvjME/MgodrcOH1Elht6lAXjPoU2FU76eXrkBn+lhERVugwhcbUMsKvPoyoie737y15gn+ce38pkv758tjLg8AjnIJQAPuFmNHWsV8u7TdeyI5YvDZ/u3pLJ1NY5YWr9910vOBy6JxdknEYX0q3n+gHJvZDIm5yulw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUYPR04MB12667.eurprd04.prod.outlook.com (2603:10a6:10:65d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 12:25:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:15 +0800
Subject: [PATCH 03/15] imx8mq: phanbell: drop redundant gd clearing in
 board_init_f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-3-0e2b490542b1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c4b09ec5-6cdf-4df9-7d8c-08de9fa107a8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DRcLeyd1iG/qokbUZdQbzCkMzFoDO/qEppK6z202AYLvhoXtSmnQ5wo7b+j/k8TqH9qfTQ5AmiEaTgy8+CmqjteCTPheliRf60gq/hq/cM1Kw3Gc+N9yRIGyIfRfWH5C8W1ycYm0hMbK+gGC+vyRCYuRIXzEzOBCrzpZzhzlSjwzCGIzO28eBhLx8v2VX24+Tda5BI3ys03+HCVnzMyaUq8MQ/2AFKrvcBWcBiP/Xx9O0I/IjLqNbPYJtzh0HXw2Nkj3+tO1h50i2xM1QcCPPOTUlc97YVdkXBOj9v9WmuOltmmEcRbQ+U1ZPV5xasZbxC1CFX+R+tgODEIO3tHTTIJVIoQXRWyD6tBQvekHYJPkZNA3f21XjZ5y0A9rmRgb1lCI/ADu6P5v4T/wQFldXl8/NxF7QhN/N7oeGfFVoTx1cm7InRBUpqMpPqx01pKI8fR67Tac0rqHvmTQmSrez7hVFTAVH9p1X9S237cnVJKWbz7lTfhaaO1kaRFJxtk0vmMD8HkuBKUO7W8F+7S+DFCD7zzULyQyhMIApNEAV+dYQIhWDyNA2YfZJNJJwR6cJOgm9pOh4pRlQ5PvRe04cGhwH6N+/UU6GiCIKwBfJgsEY7N0rQmraNw9Co1a8hEBE1s3SuunaGqJND96b6DM8u5eOYMd2JJeEDMUQ0Usdi4Y/OyafEoOAlke4TJQsbbWSjBhv2XVim95b8UKY6xTismjtBlpEVaKWYQfA+s5f/5jnD+WMwnqI6kjI5hIEpMAecXQZI5axNTPdKF5gJ0k8aejGqSCCGJTEna8aCzzp00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNOM2JJNXQ1ckNGczJYMUg0SWlCQktLUWNWL3FrSEs5NlN5WkdHMUgxVDdk?=
 =?utf-8?B?R0RZNGsxT3R6amhmLzlpekY3K3B0OFNXQmt0QVZQNkdrWnVvTTdJZHVTVkNF?=
 =?utf-8?B?NENCeDhaeEdodHdWdmZoa2lyZ1FLZk10Q2s1OHcra0wvVzY5NVAwTFFLSWtD?=
 =?utf-8?B?dC9UMlcrcHp4UVVyN0dmWk1WVkZiS29sRkw3SGh3NFNMSmtwRXVTWkNPL1hj?=
 =?utf-8?B?azNuNUZyMk1jNktmcm1NazNuQVZjdi9iRS9ZbzVrek9GZXpSaDdDWncxM1Nu?=
 =?utf-8?B?bldiVTlpUDV4STNIUVVPYjZ4SWczRUV6Wm4vMUtFUUo0RE14ZW5XamozRlAr?=
 =?utf-8?B?d0RiTTJaZEtBR2E1K3dyTm9Kci9ZWFR5aFdISm5lZXE1Y3NmVTVJV25GYUdO?=
 =?utf-8?B?RWJlVS92TUFEd0dyUDBPeVVpWHZvcitzKy9Dd28wM04wOFlEazhqanlqVVNW?=
 =?utf-8?B?TEhTYkZSaGlURGttSHdaeGVwby9ZTHZnV2Jnd2E3aXE1WnVIOEtzdkNnbXVa?=
 =?utf-8?B?c1NlWDlYdTRqa1NLOTVYWVFMcUQvTFZyakw0TEF0VEE4c3BCQUZCcUJtbEVs?=
 =?utf-8?B?d280dXBZVkpMak9tRWJRR21LTVpEanN4V1FCaFlsUnFyTmVCQW50dGNtZ05V?=
 =?utf-8?B?d1lBaEIva3ozNzdjZGphUW5wa0IycCtIeXA0S2RTdE1ycXUxWDdxWjUyakhK?=
 =?utf-8?B?VFZ2aEhNZnpKMm9yYWpDdUZnMkhKNE80QnZRM1lnc2V0NitMZzlNQmRGZFNT?=
 =?utf-8?B?U1REbml5aWlwTStzdEgyc3BwcFpnZG05U2FTeXNHZVkzMkZ6ajdTaGgxb3lS?=
 =?utf-8?B?M2pRN1JGaTIxUzZPQm1OZEtDNXZROHFyZFdrUVA5MjB6TGZwRHplSWN6OXJT?=
 =?utf-8?B?RkdiK0hwYU1GQjlnVWhRWTZuMk1rUFU4eUgzVHIycTlsQWZ2NHJIQTFSaHk0?=
 =?utf-8?B?elgrRk9BQUYxM0JUc09sNzhWQVFnQjFQZmRBamR2dDIybEU5Nk5zcUJpNWdx?=
 =?utf-8?B?UmJ0YUswV1Q3aFRMa1UxTWVkR3NDUVBXYWwzcWRRWG5tSjRqNm8zUnBzN0xa?=
 =?utf-8?B?NUFyUmpBb0t2RHZ0RFFkNThjdHBjb2NZZUxaYWdWUGRFY3BGTldkWDdMMEVB?=
 =?utf-8?B?cjdUSHJTZ1dJczcyM2tTUUdpTUVzV2tHTnEyTGlkYmRKU3RuZU1sVXFQeWZ2?=
 =?utf-8?B?MkxxRnpLUVRobzR2WFUyQitVVG9ERUNhY0tFT0UyWWNaMExyaGVBUHh3UEox?=
 =?utf-8?B?SGQxdjBjU2lwRDBpQmRDbnZNQUFvWWZaV3BWSjdHdkw1SDFyK2ZCK25TYnYv?=
 =?utf-8?B?STZkNEdFZzFFNktDVmVvdXhRNzc5RXlhUWZNZTVSZWRVT3lORkhpK0VTZWhB?=
 =?utf-8?B?T3NoWlpUYk9pWUJmcDRBdUdqMy9zZGwyRTMzZnhySTZ1RktrNitsdDlSTGQw?=
 =?utf-8?B?UkRlTzY2MVFtUTJWT01iWTkwUFVrM3BtK0h6NWYyYzVtcm5GTVNhb2RlUG9Q?=
 =?utf-8?B?YWJCZ0xDa3Y0dnBZSkpvTzVuU0NEd21Ic0I1bnBpemwxdWd0NzJwdlloYTVS?=
 =?utf-8?B?ZzZrTUxzMW1nODJ2S2g1VkxzRW1tL1F1RnNsaUk0ZWlNY3JjdXlJRDBQcncv?=
 =?utf-8?B?bzBXc2ZYa1F2cytxNCtsK2FyaVJqQXowdUpVeXBzemU0S1YrN2tjNkhyOFFz?=
 =?utf-8?B?Z0ExQkNMazczK0MrYWkzQmczVXN3M0s4TktoNzZxNlFURXFOelFjaUNYbEhV?=
 =?utf-8?B?N0JXTkVoZFlUNmRSUExaN0FCM0hmck40and3dW9zZ3JtWVVNZXZLaFR1NFZH?=
 =?utf-8?B?RkZ6YXlQUENHZmRjemdQU0tkQ0RkWW9vUXFaR0N2eGQ4a3Q1MGpNWmdrcjRY?=
 =?utf-8?B?Mk5tbkZZRVBySk9pM2o1QkNyb2tRS2RJVjNNL1ltU28rOXpWUGxYK0FQWnB3?=
 =?utf-8?B?U0psQ2wzdTRJZ3BBTjdSNnE2QzMyd3FVa1R6bWRiTmNPQzFqTzNMUk5mTFNr?=
 =?utf-8?B?d3I0akw3dElZUDZCSWNHaWxXdUpIUHVoYk9PMHpsZG44YlJ4RC85cGlpNDZE?=
 =?utf-8?B?UGcwSDh2RjlnS20yVWJ0di9reUxkY0lDK1JMNE4veWpsdEt2TjBtSjVFWlp4?=
 =?utf-8?B?Uk95a3YrYTRNNmV3anpWOVo0OHNVQVdxb0Y0Y1g5Ykl1RWVSYmRKaHNZd1kw?=
 =?utf-8?B?U0k3WEIxYUp6aXhBRzkzRFdBK1FPMFFZbDV2NS9qcHdMRTJyaGpwcWd5K08v?=
 =?utf-8?B?OU5HWHRKbk5XY0NrUmhYMTkzSDVjTllxUldTTVlVKy9KT3FDeHhZZ1R2QlYx?=
 =?utf-8?B?OERNd3ZxbWxnYjJDRytPTnU5ajdjSHJsQjZmUXhaR3NvaDcyVVZPZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b09ec5-6cdf-4df9-7d8c-08de9fa107a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:10.6500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY1Hn9nUTqVcVdAu0ljs4iGMkTUhjpS+NG6HJfCibimrv80iD7W7AmMY2uXO9GLPRinWCjhLmJlJfMCsKt1Q/w==
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
 board/google/imx8mq_phanbell/spl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/board/google/imx8mq_phanbell/spl.c b/board/google/imx8mq_phanbell/spl.c
index cfba9300dcb..642167bca59 100644
--- a/board/google/imx8mq_phanbell/spl.c
+++ b/board/google/imx8mq_phanbell/spl.c
@@ -6,7 +6,6 @@
 
 #include <config.h>
 #include <hang.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <init.h>
@@ -25,8 +24,6 @@
 #include <mmc.h>
 #include <spl.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static void spl_dram_init(void)
 {
 	/* ddr init */
@@ -153,9 +150,6 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-	/* Clear global data */
-	memset((void *)gd, 0, sizeof(gd_t));
-
 	arch_cpu_init();
 
 	init_uart_clk(0);

-- 
2.51.0

