Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C42EE14AD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 16:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E750869C8;
	Wed,  6 Sep 2023 18:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="iiSOcDde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E82869C4; Wed,  6 Sep 2023 18:02:13 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 637A8866A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 18:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+O+G6TQXQjJnJ5GweHkSJISq0KELijRsUvuuab6Sz4mpdS41u1pRyiJkDUcYjN0V4wXdT5mhrRo5/5hPQ1Db5hJL+MtMdzqXSkEbZOw5GvZdNOz7D1y1700m1uHF84cyVabpP7BG2W5RIh5tG321zqdmDn+oJpRzgTUdltPiPR743lxw1P6LMQPCrj4D60hjz/WDXo9uNufQ/RrTgeBaLE4Lu+sX0aYsXKGsKScIxro2tCvmRKHh0bud+RARCCjpbYnoCI9x8Htsjwk1JaphUqyBl+O2o8Ijj5DCpiOLvUIlFUF9RHgxAPKNCxBhuYECXnriC9M4ZcrLX4+P2+Rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ9ES5J7cxatHvfrMtvxm2t2QYAhd3j9wGCdJkOn8kc=;
 b=N/GFkrGuQWocnM/UtFnODh6ig9QL7stqKQZlaQM+ltpqpTIgxmXwZTEyoZ55fWE/O1fQQuvwdfu45w0H8jCC5SmoZqIkhFxr7XZoEU/2DlivVIAaajAZALbNL9jpDwluqe9iX8PyRRHx4GAGdv0BqaAVS7F3amvXMsv5Nff1ckiwYKKmYJVCiec4Lr0ggboKNDpnfRFMx01HCth3nR96mduZUkOMteCzchOIPiePoLlx0L0RFRB7xbuiAf7LlpqqnrMl1bOWSe9pkXLg/Cf8fl69Y9ucjN1Q6zkvSHlbIZGbWqkzIrWIgNpIOcCsv7T4pWV70Gx2OFSi975l1o6i3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ9ES5J7cxatHvfrMtvxm2t2QYAhd3j9wGCdJkOn8kc=;
 b=iiSOcDdepk5BCY854G5xa5b1wlDunOnxu3V1cSyOj2gx6FouqtKqnE6JuRWRudAZdbuqcCxyeq9nGCxK5bOq9TXN3o3nUJdmQ8iCBtp8v1Pd5TG4cwFuSQuQtqhnH6P1cT7M/IUYZ4Fx6j7gOk4aWs9xfuHpKSV3VtKEySQZcko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by DB9PR04MB9914.eurprd04.prod.outlook.com (2603:10a6:10:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 16:02:09 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:09 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Ashish.Kumar@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com,
 meenakshi.aggarwal@nxp.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 peng.fan@nxp.com, sjg@chromium.org, sean.anderson@seco.com,
 ioana.ciornei@nxp.com, u-boot@lists.denx.de
Cc: thierry.reding@gmail.com, robin.murphy@arm.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 5/5] board: freescale: ls1088a: declare MC reserved regions
Date: Wed,  6 Sep 2023 19:01:52 +0300
Message-Id: <20230906160152.24185-5-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
References: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0059.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::29) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|DB9PR04MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: 9485039d-4b1e-46fa-05b1-08dbaef29fa4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXEJRpQoMvkg0+udWvymhTSbx+4T0BtIYNjmJsy1zQbNvETLskrBfku5LNU910L3bgGxOS2WjGqYn7lH2FSmYFPxyz4Ir9cpiwFboNz/UI1fikrjqdqM35/bRymk7jCTiLp1Gs5fDcPSJ2KjKyr3VrSnN2EsWp95h7AvOnZvXoMgv0VTeBAiTHQoXGW5QsGgbDT/KPhCDlA/3ULLg0qVBDeG8DNf9Go59NFsDPCGwL0x9ub6Pl13iXea9SVXXR9/lcvcXiRs2qnd9gmnywXkcOKntpKMZHnJcsdUNU8ysk/QfBUOcuo+9vjKEsQi9ZWTF+5ULH+QOoo6/yLa6VuwSyuTpPlUvyItTrHNpunIV2fzVZ48LoK7ZhChfuiujGjY0bYpm29RHsL8y3HirXmtxTRzNcI5gLMQllH92iiOHCiIkUclfMhQC4Y52clBwM5sIhxqV6l8w8uV/uUXwu9RBhi5yPa0O68b/BHIVUF0YwON2U5Od0SyOwvN2am3TVy1ASilZtrbOAUymr2tF9ocHe2OFaWLSLr5/CWffKAA6G4dOgH9lapHe3K42rk561mdBNafWGixpE5vC8SW8nqhToD9uNqL9ym+JNOib267Kcmpnz7uMpRck7VPkwKSNJvMIsx791CbcxfP/asbk9Q+fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(186009)(1800799009)(451199024)(4744005)(2906002)(66556008)(66946007)(316002)(8676002)(41300700001)(4326008)(5660300002)(36756003)(66476007)(8936002)(44832011)(6506007)(6486002)(26005)(1076003)(52116002)(86362001)(2616005)(6512007)(38350700002)(38100700002)(6666004)(921005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8Kg2txzYyGSDpgmm43m+F24/kPIH/TcKeehpA/dFz+J6wvNNfmPkF9WjDZC?=
 =?us-ascii?Q?w3TnbqvIDywEca4vrHlzfuurDfx/iamQ50K///2kOCluADKjneL2bT0GEtEh?=
 =?us-ascii?Q?pHS4iSd5IpQRJWHJFpgTcFZiSkqHJTkPYLg0KQVqcpj7mg4H3OysCimTwnX3?=
 =?us-ascii?Q?ozuBlyNKNsw8gNvQMWwIE5HdGg0IB42CrCnoktMvAM5xBVn9hniZTMelRIuz?=
 =?us-ascii?Q?1ksLWhrkjjjk3dOJIbuP3+Eq/S+ZftL7aDh2rNWrdrq5LNXVFAlaA2PjXlc1?=
 =?us-ascii?Q?Cb2+qKVObLn7fmgOCdjC+kiN8bduQ+HZ1X53Av1PvDRAJD6vZN9rMpTZTLAY?=
 =?us-ascii?Q?uI7m1bVM9oWICVMNEdrLW5pOtW6VoOfCx3kDHMNEUCvh0G/VuLmECH1I+NP1?=
 =?us-ascii?Q?AdqREke5kvxXfTcHRX/N7HEn8VQ6jIX0wOhAqdnxmckFgALv6bvTG7hjhxTj?=
 =?us-ascii?Q?stRKWy3ncYdQZAZrAq3V067gntM1JzIwj59/wwKyTTC67YpPYC2YW/YMwoBC?=
 =?us-ascii?Q?ZxrM9xIClkErrLHzWmqyriA6VhczyaV7MRtcIfJXzXL5gXQ74npvY8xnfaU/?=
 =?us-ascii?Q?K0VJsFQ/V2MfnPeDTKnu/PKfLfOr7wO/6p78gN/kuutmRsbnVJeo/Ci8DEUL?=
 =?us-ascii?Q?L9rYNrtBN8i9TlIkuPbs7GFrP+B0N21yLr7AbrZHc6faN82PN0GdbKybvZoZ?=
 =?us-ascii?Q?UEBz/VPjKIvnomE8dvtUGsCfgIjpG1lDP7Zme0BmDAMlpkF8vKKzt7/L6zQk?=
 =?us-ascii?Q?grLSU/7stq1hObbmPUzQZB0Gw+Zfs4ZWvoS5otrZ/0kJNxXWJ52fSPjDB5vL?=
 =?us-ascii?Q?59ZacSzU23fU3cm3SHWZ2ttaz5BxgLTEj7r0d+Q8JfvpSfJXY9KGb0JDdQy9?=
 =?us-ascii?Q?dutMT4Bddkqt2CdBZuzcJbXZ1Ampp1oklsZsWcWzgXGlueD+NNZOxMoK1s45?=
 =?us-ascii?Q?E4laetzmxaRyfcDZrVdavk+Zjnct34L+ca3MJbkDp73tz0vW6wwYo+Fqu/71?=
 =?us-ascii?Q?+SxMdadhg+gTjv+duPzE3N+GzmYiv60vWNJiIGirrL7oYHO7ahaM/Ssqu5N7?=
 =?us-ascii?Q?Nw/txQaLSlTxQPg42AFILghKXM53uCOi3A1Svzt82NTAFNrbvCiNF+QOVqea?=
 =?us-ascii?Q?5tvZnxLQQAmmWO4a5ogqY+c4GE5PXsumkQLPFpinje4VPXUm/wrcfOoLbDy2?=
 =?us-ascii?Q?rQTOo/y+sFnbYZmjseCYqN0Yhw5Qjl8GPOtyFJ+WxgQ/nrTZfltnGqb3bYXi?=
 =?us-ascii?Q?gbL1E1+V5K1ShTC0rRNaM32bxXjtyXYysyVJ3/yu3BkQXjRni7DJcO40HQ81?=
 =?us-ascii?Q?xBU0TAYBpUtC8l4wB+vPKhms4tSMAz43UecLdPnwFozEQb03y1gch/QYa5lY?=
 =?us-ascii?Q?xQfxQ03FN6QsvFIln9FtArL7VlS+/9A3pTRYzt7Rxfp1fcLBxainxvKtn4jw?=
 =?us-ascii?Q?Yfgz+72R2CBjfV2kBKZTGExR3kw+A9FJDlYLfUUfEcGTMCOFWZBCN0KnTbPo?=
 =?us-ascii?Q?c/HzoRu+CufbsJoEuAohbOZh/QLRZ/0yWT5AlKmdMeZrn7Cwg/PiHG1bzaqN?=
 =?us-ascii?Q?67Xc0rRuLPWmqyQYkHlxZ+TtpXl/FeHVtvQv1Rav?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9485039d-4b1e-46fa-05b1-08dbaef29fa4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:08.8877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piZh3vZrmlEZcsOsACmt9fE8nsZKI6ZYMBqQdWQv+0UGIPBN4nwSy3+8m09D1uYuA8yWq46TJfBPI/j5Kq6k1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9914
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
 board/freescale/ls1088a/ls1088a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index 65593f10a3f5..7674e31a268a 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -983,6 +983,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 #ifdef CONFIG_FSL_MC_ENET
 	fdt_fixup_board_enet(blob);
+	fdt_reserve_mc_mem(blob, 0x300);
 #endif
 
 	fdt_fixup_icid(blob);
-- 
2.17.1

