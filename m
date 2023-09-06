Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1921CEE14A8
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 16:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250D8869C1;
	Wed,  6 Sep 2023 18:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bkLxlitM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD29D8643D; Wed,  6 Sep 2023 18:02:11 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C427086611
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 18:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ0B6847ayOF6aVRvemSdmBR/OXmQcNyNwyt5FslXgW5gw0UTQLxUfpvKgmrUY9Sw7YKVjiXjpEofznevANCjuwQROkWhHu00SkfbW7pIg6GpsbH2f/6x2IH798Men4FMJFvGzNIKEjeYC1+sBaikGzSEs1q6a2X63amKC/khrxA9cal4XeqVqRyzMjX77baoQHGA//d7wlFHD9qyJ6tccBCxQooSvyvUaZjwUfYKWOorlWqdCAcodId7nXubGKxq3+Z5LDOy59zlVLCpjLzlKndvuGs3JqXBOPghI143bHsXXsRFWjiRPIrsTy+MKcyk6PsO192CHgGsbfjhDXCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/K33TvjnX5QQRBONenuD3dr+x9nkeWHVRLdJZKXag8=;
 b=gDanvZKS3KOBkwCoFvv/JMaY6IANMnbrVECslpCXznoc+ZP9r7ZdMAgwJ7wUSKzXxzMqJJ9EGsafvVr9bnjUn3hgueCcB9mB+LspDIngxBuUUNnQB1lvCl9NqzQdEiv1u1/l090D8AoJcDu27Uu7rsijds2+eLdiubEj8n4dLThTW26SfeSIA1TSQ8S1ikvyIBPnoZFxm5IM13Tow2ozpj0A7xxyQ6FyI/uVyl9AEvaCE3UNDesuQlh3zAeGU1UKFvuvMOhZcZkLzDiuqhMDdcwfisxekRZ8lEawxeqFMoqiF4sQqbvFS9oRwKcBPsEBhbucENOFTHxXXOS6q3ZlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/K33TvjnX5QQRBONenuD3dr+x9nkeWHVRLdJZKXag8=;
 b=bkLxlitMCkAhgI6oe/3KfToCXsIYcHLCG9jj1M5J+KI4KDi+PYiJFISq10cpmBLIrRi98skSdMBJlqjJW1x1d6vTA8mnBk9Gcor6FdnvvDsYUiGjSC8DjL5NcMv1zsFWI/F/4CWGy7GMuys5UMJxiUHcPDA8wQlpxuA+RU09bEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:07 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:07 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Ashish.Kumar@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com,
 meenakshi.aggarwal@nxp.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 peng.fan@nxp.com, sjg@chromium.org, sean.anderson@seco.com,
 ioana.ciornei@nxp.com, u-boot@lists.denx.de
Cc: thierry.reding@gmail.com, robin.murphy@arm.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 4/5] board: freescale: ls2080a: declare MC reserved regions
Date: Wed,  6 Sep 2023 19:01:51 +0300
Message-Id: <20230906160152.24185-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
References: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0059.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::29) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AS8PR04MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a74199f-fa57-47a9-9086-08dbaef29ec1
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ojty+EPhm3vVG8ggRdG7GAgWU6DbYU5CjpuS9ruhEUE8Y6ZnkYsybPPegY3gasj/Vt7HbbAwyychVJPIGCC2YA/gXl34O43P6Cua9nVEe8qxt+IYjGjuTd2lXEGKUrb8cNErwvCNDqoBFYnrMdFLwd89XF/p7y56I0dAqhZBRGWUhcjZs1c71bF8Tvuj19kW0p13uBVMZ302b6UHT2LCkrolVm8s1LnaRC+C5aAj0INv5C/RLcuXPKsIc2jUT4vx57aTXL77PzsI/Vk6WfUZSKXCX8OPTUdbinA73aA9LEC8a3QyqsgSbCmKJiy+qC+ChHN7lBcsAazqlIzafzI6aremDma/xpU3a1zDSNkfLhn1V4xMO/LKEOviqWj82jQFDmBmT1e6+y8ahWpL9b7xIxP7Phocgu0WVeXXehtT/0YuC1TwBGCRqqFL0UIBcfesI9SjQUi6tPwbwvREeGIWYi/vxvxPUPsw6IIIKiNTUf3N9TMt8z+JDh2BbcXZlJvXMZI/wZRQg48uh9xTzjmmM30zcPqe8C9T75WJpExbpcCwSjAqNWoha8Jx9/6jeolGTsYhIWCwm/7HdZ9T2yCPdxJPymWN4cacKj5k44ToDcBls4HNMRxdDizHTJx9bEnwq6g7mBQAbO6TygCucLQ4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(186009)(1800799009)(451199024)(36756003)(5660300002)(86362001)(41300700001)(44832011)(6506007)(8936002)(4326008)(8676002)(52116002)(6666004)(6486002)(2616005)(1076003)(26005)(6512007)(478600001)(921005)(2906002)(38350700002)(38100700002)(66556008)(66476007)(66946007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zIVrVi8+v5XEVaD5b4dgCtTVwaQlbTz0fYieCFIVxWYT0xQEk2WT2wIXmvBG?=
 =?us-ascii?Q?yXb7FBDW6wMMddHOmoMeFEGc9xujcL+2QJFYMx/5Xtnt7Ybb6au9XyKASSkw?=
 =?us-ascii?Q?dl4pFj/NDe8jE12rhoCT0fdNccNjvoKdm2uYUJ36OpswqKDXUqdLfU/q+Nqu?=
 =?us-ascii?Q?sMTePzfvE8LLlR0Sq/Pbeu/0sUSdtEVow9ABqqJC4k0+X2ilCqRPzBZmE4DA?=
 =?us-ascii?Q?6wGZV0dx6CBBiUdM5StQcDPwVg+N/4y12iOt99ShSr6H9GaFNRN6oZzzMP6a?=
 =?us-ascii?Q?M+fw0fxlm350RwX8J2epAo6CneSSyyC9vf502e83B2xneeK5x1bo6WlGrYUx?=
 =?us-ascii?Q?i4V3pJIZGVJ64KS1ylV53Vy0F1P3QtTUOjzaRaeIlo0TPPdHvd8iXIU3Y6SI?=
 =?us-ascii?Q?xLcfP+acwCNCEuVge0cKEmocwG49qRu92rPLsU+/lydCGrVrZCGBZm1UoLA4?=
 =?us-ascii?Q?et6Db+29OI99qapLK2lRBUfPjBQFwWb++BBSYOSQtoRYaEyvWtx/JhnKTfuf?=
 =?us-ascii?Q?KHlvtuQo1EMAT8aDkymmoEOVwM6J9vhyLiU41o6VZ5/bEEwp45ni1madOX/J?=
 =?us-ascii?Q?L6u845wVvKWdYuCQrsjS1xfaO5XX4zex5aiMDzvEYvqaml2GRL/vP9GN8+3H?=
 =?us-ascii?Q?TWvWZrOu3nmn5ON+N5+QNKV5R0BfzxdXQ6tujB2UYvGHsqSS5f7SWQzJ/ZH2?=
 =?us-ascii?Q?gmmOj5bTujKa4P+ihPcZAg6jSLe3K4KDGdwkyLb7vJTJZFb80yHRury65rns?=
 =?us-ascii?Q?8s8d2rcgaE1xYY17gqOsfrEsh2IeHcAQTj+IVcJIErp9iGg4cGsC+lXmbO20?=
 =?us-ascii?Q?6fYsHQXDWQmNbTh05jW1Kb8hwxeIRIzAPiBWX7FIS4CAiOt3rpy4kRccRLlP?=
 =?us-ascii?Q?uBpkaBI4HL4duAXgWbohwQFgpby33Wntm0JWZ1kQ5PCzj/rPdHwyFmieMTHP?=
 =?us-ascii?Q?0V/hweq3GuzXxrPkCXRVQOijm2+tDO6CvdX7UZJTI3kjiEd+aj9AUR5lgT5v?=
 =?us-ascii?Q?w5ycoK8fpUJhXMf+2OtnJT5KW20nrB5ZwIM4Rb2/2WFaeXASagS9sYR60TXX?=
 =?us-ascii?Q?uqjTp03s1dHYu1LqNL66VjhWOqxzpxpnLiRlVej0dLeaPZrBPT0RLIQx7qIa?=
 =?us-ascii?Q?GPg+Kc1FavXqS4dYFLSTmZcLe4MhEwUB8QlvWIqmc+4vXi5Bz/esXKbLOSHK?=
 =?us-ascii?Q?HhzRgPJzJcFxemPN8ab47OLWX9vAONVqhsEEeWAt6SwlzIcp1R9WbH0MtDSK?=
 =?us-ascii?Q?SH0u2EgCZPrcy0wddDfJbrLpx1m8EQWcCurOoLm9g9AGMa1vi/kH39ZWxQPU?=
 =?us-ascii?Q?ZnbfyCsmcMbt3z7NPO5DIyffzzkokRbKrDDmkt7OpiAX9lbKe2XZOaRVAVsv?=
 =?us-ascii?Q?sd5ruVY4wd/E8Y5NO/AGnhtnl547bZ6WvaSh9lJcVgosaYvckCFjdMqaXGPG?=
 =?us-ascii?Q?KV2IH9MYWokhXiTqTmpBXrUFj1yJc+mVQYQbHfx+Nbv/MzuzgAgMF2a4a/zL?=
 =?us-ascii?Q?NNbIz0ZBR+vx0PQqykMrLkyDoasSQbvwKQKzWzJQnMDxUtyXcVsAP5qdrleI?=
 =?us-ascii?Q?7IiMoymiQmnONn/kyxljD+m+rpZ5K7AA+hL4Agdm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a74199f-fa57-47a9-9086-08dbaef29ec1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:07.4657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tAGnOkuWwx8JOCN5XSs+jjsfPY33aQtVzeA5ghWlG9ViXEUQdTti87FJYBZH8G99hIcW6A1NHVLO8iV1Q5O3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
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

Populate the device tree with the MC reserved memory regions.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 board/freescale/ls2080aqds/ls2080aqds.c | 1 +
 board/freescale/ls2080ardb/ls2080ardb.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/freescale/ls2080aqds/ls2080aqds.c b/board/freescale/ls2080aqds/ls2080aqds.c
index ba25e9b0b8fc..5c94c83121b5 100644
--- a/board/freescale/ls2080aqds/ls2080aqds.c
+++ b/board/freescale/ls2080aqds/ls2080aqds.c
@@ -325,6 +325,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 #if defined(CONFIG_FSL_MC_ENET) && !defined(CONFIG_SPL_BUILD)
 	fdt_fixup_board_enet(blob);
+	fdt_reserve_mc_mem(blob, 0x300);
 #endif
 
 	fdt_fixup_icid(blob);
diff --git a/board/freescale/ls2080ardb/ls2080ardb.c b/board/freescale/ls2080ardb/ls2080ardb.c
index 8d340f17a256..5c30de83d841 100644
--- a/board/freescale/ls2080ardb/ls2080ardb.c
+++ b/board/freescale/ls2080ardb/ls2080ardb.c
@@ -522,6 +522,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 #ifdef CONFIG_FSL_MC_ENET
 	fdt_fixup_board_enet(blob);
+	fdt_reserve_mc_mem(blob, 0x300);
 #endif
 
 	fdt_fixup_icid(blob);
-- 
2.17.1

