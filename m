Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3C7ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358B483DE4;
	Wed, 11 Feb 2026 19:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vQnlNZq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AF083015; Wed, 11 Feb 2026 19:23:07 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0DB83DCB
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/qC2qy26vpNMdCZ8rsOSDYs5w71Q7GrqdV2iLlA9BrmCKFw1Ox2MA5rrNiZ7hT/7E2xuZju7rOMn+oTm7l1bys+s3mBGh5J4FeHhhBdad9vp8s4gYN8zTZlo4mS6MGwWoPqCYUZN7muvBC9DOFZe55PzEKQiRe9+kLGMilJQVGffx8mUrDh9R63Imd4FnChEJHBkZhOFEjoL1mSSFeOYJe+SgF3qVRhyH07dJrYTVrabUnxF54hwNeLwE8jMEwZ7E5N7XbSW8hTEZypc1eZ3U16X9+2aWNmVDAwkOOezMkoV9RG1q8bjAcL4sv+pw1Kpm8fLeRZJG+jLuJmWqgiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRC4qlQI5ioGU55VD2jlAPFxxy2kHcKSVzcuLJL4iFg=;
 b=YLQwkB9WfmSdOYdMHMKoZ/x3d/Jvwsi1KiH/bDiOfwNoizN5XZUgjxEQrYxuzfwgsaQrSfimwRmjcq/1Bfj8vebd0fuj/u83iDjr8Gjhn73tNEwgzUHkDpSYc7B1kQdm7MwrRBhKIaBsyMhbrtSymcDlzIUSXmWh97YAKOjT+mlFTd+duvp52Dy+IzHKftq6Dy+iRppTP5wamr5MxsYsdnN+ZIf0lZhobDwE2/2W1Lx35n8VCKWw6gEzo4tL1EL57WvVndN5rVpx9cW0FdHHKM1b2tvUO/jE4D4nIcFwi5JLrMxMkMVCdBJZZbkf+PTdErUZZA879Dc7wrjp2VVozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRC4qlQI5ioGU55VD2jlAPFxxy2kHcKSVzcuLJL4iFg=;
 b=vQnlNZq+7iHrEtCADktwCJWo9zlaUq/eF/iXvfVuATIgelXZ4YoEl7IxXV0o4W04ooCiy+uvwf+4yb0nIgp3V+KG0Zc1P/MQ9hFjgSGu9XBOTrvCwokKc9J/4tH9vhydnmB+BjDpJReQOKpNGxIthmC1DCmESnoEiJUeEbGNg66GFf9RCoIBqU/zkwWiQKJ4xLBo0ls2k8/q5XZli+C8eUrzBjCxZW1VvZmTCSAUvV5gKy0fo6ssgC5gjJkSMh9+mch9f3f2f8H80PoxpKNJAXP8uvP5kcuukcS0ik8d63nFtCLLfClCw8kI3514ksuj3Bdhoa0zPMB20HE9gg+/kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:02 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 05/16] net: airoha: do not call airoha_fe_init() from GDM
 port independent code
Date: Wed, 11 Feb 2026 21:22:19 +0300
Message-ID: <20260211182230.968921-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aab069-195b-4bdc-847f-08de699a9795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbXKXLvtWK4TZujpHKHNJNZSosSCtgAtWY28Sr1fjuJy1BlG8926eZmtgEQ2?=
 =?us-ascii?Q?Y9w4B6lnt8YIM5Dlli2E9k72V+E8mx8EFfAZXxshOaG51+MK2z/G++XoKQQK?=
 =?us-ascii?Q?fT/Wj1FE8XY49hPU7N6eOKsR8q3scbutykpkk2peOxrVn4+Zq99Rkj9Q2XOf?=
 =?us-ascii?Q?wqHbQ7Ab61p0slJg+xyo+2tbs/GiA5T3PymaxoKaWyyZnRktQr8nRxpiFEdx?=
 =?us-ascii?Q?qR3M3BqJCJlWVyn4wMi7U6De/tKS8tYZQ1F4GpTQ2LlQRyYdDzgbVU3bzCV6?=
 =?us-ascii?Q?5apAk5P1UuYJoeA8JkKtgTQu1XFHJSwPIc79Mf2ZopYx7PT6h3j/h1Vdn5MM?=
 =?us-ascii?Q?9o/9NFAXy3hPqXe6js2I2RXfvRFYdCcH5H2TID00OQTPaKEq1OtQGc2W0oFA?=
 =?us-ascii?Q?TwRZULcaCxwC30bYCLdtznV73qNWPxfjBsEEfxra7nhyq1iKDmvSUTt0t7u3?=
 =?us-ascii?Q?i/nt9k+LxcNANkjo8WtlS0CVV3EDjlImYlfJE/J+ZpciuRAZ+wD6ycPVC1UA?=
 =?us-ascii?Q?PaCOD9rew3cvxNE6mKoQHJMilv6pXJs0Mt1g4zm4Wd5DAG1IrCM3U6NtsoQd?=
 =?us-ascii?Q?bzyiQuYBZmOvIuBUtVOFgwRUQtaCNXGCmt4uUjvtFrRLzl6vTE6MA17Empxq?=
 =?us-ascii?Q?IefuiT3nNJQ/skpesfVO9XDQ+pK0Oa9WwDkYZXDWKINoiUcUn1It7bMw9oz1?=
 =?us-ascii?Q?2oqP616b+SZa4W5XuXC31OfXBBIX/Xj5531l2YSUqFWwG9Dha2QdGKRGwX+S?=
 =?us-ascii?Q?Jx31oG9x6e0mAxpc6UMigx/RhnBqfJ/u49cYrjCedt0HZB5ev1EQfzcwLN7r?=
 =?us-ascii?Q?+wrC8/X/UeJrukQID90Suc6i/tSQJaqUoD/8kRoDkzTzopKY+a+m5kpBg5/D?=
 =?us-ascii?Q?05FWewS7+vPI3of4s+/EK/79ZdTFP6SR+NPq4/AjQ5YocF7uMMwCJK4+eE2l?=
 =?us-ascii?Q?PVJP2ekGKXchfRJ6pV1t/19El3iO4IaISp6CADvedLWyJ8hnTIbkI0XZq8mh?=
 =?us-ascii?Q?boha30eP+OyesQRbwY+HeDu8Om74z+Bw9SAvFmSdfHhb3G7wamwYdZOHW6TL?=
 =?us-ascii?Q?bnAGM6FZOKbJ6FF57UdatrPr7x2S50P9ZIsmWCKgmERB4nOr5Lvw2g7/Q1op?=
 =?us-ascii?Q?y+KHGc3Aw9TBrpruq5mZkxphuQUZENpPjhinFUMTiMzTiOzl9CgIUT+1Pfd5?=
 =?us-ascii?Q?UI+Z7hWbMyZm9zgr0DUUxObyhKLKpa6SlnDjwXBsnCpPZUhpkGIioSedX78+?=
 =?us-ascii?Q?rWub/xPMFsIPVjnMSNA/trKJo4jRD58f4tpD2lZ0nm/+5ML40IQDnblL3w7z?=
 =?us-ascii?Q?uzQcKI3cJnj7vWCpTMo6I051+tAWEk6QQx1X82/R/K/IZ4XmeCTOzbds8DOe?=
 =?us-ascii?Q?aLJRwJvZJGXucqrV9RS/uFVFnHfPLd7WkzHYHiqN/O+GOLiqM7HdlLuObR+D?=
 =?us-ascii?Q?bVMCwYf7P9Yw4ls/skxhvfJV0ys58CWsKaOA5UHwmYeJL4ICLoplOUqW5td+?=
 =?us-ascii?Q?oOuEzRrq5ZP39Pi1IT0h+iIckcl7hS5L7zgZMVEIGrVd57QQ8k4UN4bsOjRI?=
 =?us-ascii?Q?Ng/Pd5iS4q+/4uBDJ3XQ0nK1W8zhApeZve59zuTLoJaM11s5Onzj+g/ZaKk/?=
 =?us-ascii?Q?lZvo7y1LppsSkqMPcBs6Ta4jwTg4te1dCbnF7gWpPzCw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kiE4X2xoxO3U3nMFNGvl6jNIht0DJxhCUH1es7aC9aPfyMCcmTGjNP0tstlT?=
 =?us-ascii?Q?0mPBRe7t2kQKZYS3GSG0Hq83/KcEc2pVxyRcGdC3S8PsTDJFELicX8EinE6B?=
 =?us-ascii?Q?COw932MBfXKPnGZMeghOmacWCF5pDmhtgkQ531rRiVtV4E+Sd/HYfoAiuT21?=
 =?us-ascii?Q?MYAbVXvVq2rSncdRRbxaYQjsYRWmRVmy+vfPWDeL60j7EMC4HHJ+R5qnpV+X?=
 =?us-ascii?Q?27HDi9ptkd+TcMhDvnlLJOhYu1lQLC3GE61TwZKVdERcHQlCwllmKisf4Z6k?=
 =?us-ascii?Q?NTgXZFoXZqwPo+X6aKhNCQ1z8DWWzYV0Lctyp7LN0YU9pDcwZ0C0kqIjeiza?=
 =?us-ascii?Q?DOqgXkRRWLIFLccmX+WEBrSSNko5N8DIO+5OiMgLXqndsoM7P2YA2mJQAkRt?=
 =?us-ascii?Q?MXWDHxt0hoW64q/2jGuX3MBOD03jegg3Nisonvg45i2jbfaylk9EpIx5N+xW?=
 =?us-ascii?Q?ejTkV9h2BLcD4ZY8G7SgWRkQ8sOXsEgWuD3VszDJfWI32PHndnqhUz72/gjD?=
 =?us-ascii?Q?pbX4STUEb5MhGRW75sobX5lT9gSVIFhT+GDoOARnOoeZzC6u0DrPVnT6o2Xd?=
 =?us-ascii?Q?Uw3Xk3gm0cZmI4P+Kv5CLNxrEnLGVcIuAnyFuVYG8AiWUTgGRVDx2KYvRjN5?=
 =?us-ascii?Q?ZhDs79T1PKHC5rsJPV4aiWR4f6lJ5VVJLhOcq6pQAGQmLQOsE2QNNmrAQZrm?=
 =?us-ascii?Q?Whvx90mQxBNnjySHyzoxI1B26Ju6B4SyeIyq/33mCKEr7mqGR0rS0xiwBS07?=
 =?us-ascii?Q?xpPDCf3lEI59BnmSd7HfhZQSviCp8HYEKjAhsL9FdgzjZXZ5O5L9EAAhx4p2?=
 =?us-ascii?Q?LdGegzWJDKJ0/JkQ0ru1elqvY7Sj/FT+cbKfkMiPM98B2iiNa9FVdATe+pjz?=
 =?us-ascii?Q?vfgkN69/NbEHl8l34XCdVpXaGImpLFERR8Dt71yfCkDrNoIdyTyUI6KIeFI/?=
 =?us-ascii?Q?AjW1h05+oEOl/M1bepbGgWERBMHFe6nHbbZjIWA3LmbwDsOllxUxhCHW0RUt?=
 =?us-ascii?Q?sz5qatnxe6xCGMcom4Qu5jcoaBw7T6ejUTDWxBcEwE764Dq6ny6JiRo4Gnju?=
 =?us-ascii?Q?bUQ9pCxAiUnNpGziTeGPLo+JdVqvrIL3k65nJ9f7F+aJZrlv5jwm8eJlKqfR?=
 =?us-ascii?Q?tKgM2r8Bx2HoDHaRuK6bLke2kZGXjWG8Le4+XPN8YRP+x8/LyayJ1bC7r3KK?=
 =?us-ascii?Q?to7oj2ubTv9Yxw6JZTSXxcEDWj7Yg0dE5q3jKnz3NY4I8Y/d6NYYMchl1LMF?=
 =?us-ascii?Q?3/Y/MOPvJfWL3OZiguUqDMvvkxJPhZJBOGCjilB51Qu9hy2mqMrM8Yb2YSNx?=
 =?us-ascii?Q?Ux/YyHzwuyNKZYkqIGjXd1UvZpWF/sUgQTQfeQREF1zkTgELXyYAqhm/xUGP?=
 =?us-ascii?Q?Q2iKrmfHZN9VPzOQYh+dhShcyQZWbz9bayJ/HX3h4QZffBRg2WrWeq4y78af?=
 =?us-ascii?Q?S7i0ZcVnZQK2mlshcxiYEKjo2u+hAW4fSn41BSifMjLUCJ6UdwTr3iOclpAr?=
 =?us-ascii?Q?y8OFy6r5Wd0L8Nb0rOm5D5opAcPDtUCnhtfqNvOZtBQy2+5xQEkv64aGeJp6?=
 =?us-ascii?Q?B6pspFS68Fywl385LlHPMyrnutMpLhqNpxC2fl3A2TiiYZiY+fWOQdQx+h6f?=
 =?us-ascii?Q?GjWYl7WTjY8g+E+ze+A1P+i8PzDPIwDCtENoPudqcAN9DTl2fVc6ZJQRfCbU?=
 =?us-ascii?Q?rw9iVxsQ0YW39Iwk4rzvvs4eylrxYaS0Rr9Y6vs5U5Y/6ECr4sB9TgffvUyO?=
 =?us-ascii?Q?8EiGzdDBMTz56Xd3VEQMFJdwNImnXWY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aab069-195b-4bdc-847f-08de699a9795
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:02.4725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoR9+uxXVoPwyvze86i6FGPZI4UJkEKg9NVGqZiHEl0biRL05vHtyUYTZYgqb6nzBZR/psDLDagJATofBU4FgP7/Fhe+4lLMhpNlnuivuhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

We should not call airoha_fe_init() from GDM port independent code,
because it do a GDM specific things.

Makes airoha_fe_maccr_init() and airoha_fe_init() port dependent
and call them from airoha_eth_port_probe()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 4ae97326c36..9052c807cef 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -433,22 +433,18 @@ static int airoha_get_fe_port(struct airoha_gdm_port *port)
 	}
 }
 
-static void airoha_fe_maccr_init(struct airoha_eth *eth)
+static void airoha_fe_maccr_init(struct airoha_gdm_port *port)
 {
-	int p;
-
-	for (p = 1; p <= AIROHA_MAX_NUM_GDM_PORTS; p++) {
-		/*
-		 * Disable any kind of CRC drop or offload.
-		 * Enable padding of short TX packets to 60 bytes.
-		 */
-		airoha_fe_wr(eth, REG_GDM_FWD_CFG(p), GDM_PAD_EN);
-	}
+	/*
+	 * Disable any kind of CRC drop or offload.
+	 * Enable padding of short TX packets to 60 bytes.
+	 */
+	airoha_fe_wr(port->qdma->eth, REG_GDM_FWD_CFG(port->id), GDM_PAD_EN);
 }
 
-static int airoha_fe_init(struct airoha_eth *eth)
+static int airoha_fe_init(struct airoha_gdm_port *port)
 {
-	airoha_fe_maccr_init(eth);
+	airoha_fe_maccr_init(port);
 
 	return 0;
 }
@@ -720,10 +716,6 @@ static int airoha_hw_init(struct udevice *dev,
 
 	mdelay(20);
 
-	ret = airoha_fe_init(eth);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		ret = airoha_qdma_init(dev, eth, &eth->qdma[i]);
 		if (ret)
@@ -891,6 +883,10 @@ static int airoha_eth_port_probe(struct udevice *dev)
 
 	port->qdma = &eth->qdma[0];
 
+	ret = airoha_fe_init(port);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.51.0

