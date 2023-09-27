Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E287BE82CA5
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 15:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FAA86E24;
	Wed, 27 Sep 2023 17:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GuzJbMWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A14186BE2; Wed, 27 Sep 2023 17:31:12 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6FA86BE2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bs/oSK75II7gjAh71uPd345HahA1EBo9QkXgruBKh6O09w3kfsJqZEVid3Xfqn2RK0tqv/9GyRFP6EdUQFDjFspqOT9s5qHAiaDp6Rdy1Xo9m4T6W+ecyvolOmG6Tz6ZWTAkmdZoIuZk9wDAgngFB3bp8oGKFcGpOYDrP95HrWibDXxshPiJiVON/KPvzUz29EQQoYpJ8RQTVBGnslklkUsiOzssY+J2HwBdXM/r7DZQwQwMFUEnduQRfBAPcV49nkU5l+YGOo102RA0EYFViNFP65OFmc/3aIA/bWw4uVT+s2Zq38kGsxLcE9K2XeSBqNxMDeXVoCH3JjxLB1a8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ9ES5J7cxatHvfrMtvxm2t2QYAhd3j9wGCdJkOn8kc=;
 b=K32GOMz4ONU+NdyMcx/g+//Pk3AaKbIu2MnKOD7Xmp7XwTCOf4a1Gj3JsD1O/KqDzxhvQEOlEIJ+bfD6UWiJ/zjThAwIHCpIqn93gjo+z8dNTreoIwrIh14GIuZtFKsskvtSKwHBs0lbi+jrm3fJt0hcxLGt7fVPewsr6fuza3plYdzv32X1+MKFXtu2l0NNKvyG51ShQ1qrISDpPcKXC6oeUU0j9MpWcsI+xdwoCYW5r4Dj1vvR2XpDmr2bIbz8gre7VhaIid88XhvukMQArvu2O1bn7Vf/8eoHEDp9mCCxWgaFhOOE3cajpGSmb0oSiWMbEZMK7Vv01+VNI8KY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ9ES5J7cxatHvfrMtvxm2t2QYAhd3j9wGCdJkOn8kc=;
 b=GuzJbMWBJ2JABep/j34CevAbzAWfrBR2FImNzx67oxYxDbWNoe55FXpGFNLGZko9FJ6ibklaMCdJ1kJjpHVgWKRwwBOzkn4WZAAgyMCW/dcw9uGHq7vG5vzoWOwrE+0wWin6b7MWYYjcE2A0qbq3GO3XsLX1qq4mPdL5s8+gkAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:31:09 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::425a:a4a9:17b3:cfe4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 15:31:08 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: priyanka.jain@nxp.com, wasim.khan@nxp.com, meenakshi.aggarwal@nxp.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, peng.fan@nxp.com,
 sjg@chromium.org, sean.anderson@seco.com, ioana.ciornei@nxp.com,
 u-boot@lists.denx.de
Cc: robin.murphy@arm.com, thierry.reding@gmail.com, jon@solid-run.com,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 4/4] board: freescale: ls1088a: declare MC reserved regions
Date: Wed, 27 Sep 2023 18:30:49 +0300
Message-Id: <20230927153049.12786-5-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
References: <20230927153049.12786-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0175.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::12) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: ace74a25-05c0-40a7-f622-08dbbf6ec59d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRo4wlEr+Y4yer/hatoWisUtYsXZznoSvFp0TYvJ6ycMM/ChO8KjpDgPxfqzC/h86u9yXMsdZ80Er8NpT1j3lVI08EsKkwaPw5knEYvOyL8LlvPyqm5w44B0gk7fDoFZV3tKt14Vt+dbN/NqBK9xK4ZZkAv+fE4N31/JRj08mTFdqw9vrDWV7aVlc9BdOtyxg9AbBYFYI5YxjtYwFmn/8Oz+sy2R5+U4AIdahYs12m1OhJ4cDwzf/+qir1ed7ywXJStaDaGqZ5SuwshoLPLiOXgn/mCWnqFHOtxxUej64WBBbP0wRL7R5vh3O5B14VHgLf9XgNLek0GATXttjO6skgtj8ciaGw73oJowN3XPbzlBw9V8y70HRuJIq/TZVPKNj8Lw5Eyl8PwVIm8fImQ94MQuG20PoFOOONluBYSvkaM5kgzvIJ/EkKb56n9WQ4fM7OI0vBTMPyVZUEZLdtdamTxfUSsOuS3X5lniU8vfmZP+QLcgpqmHfd7TxcqUUylvNZgJjMD+haL1mq4PEdc1P+zNrt+zn87Yv1h+89r29InykHUj7UsfQbnzyG/Gyfy816sTueWX8ta16vZ+wB8zBIocWSTKLIeK49xKt5z5NWFDVk3w9hn0K5n1iJq9gyC0FpcW3zwSuH3BenuYHPZAgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(26005)(6506007)(66556008)(6486002)(2616005)(66476007)(52116002)(1076003)(86362001)(6512007)(66946007)(6666004)(478600001)(38350700002)(38100700002)(2906002)(4744005)(5660300002)(921005)(44832011)(8936002)(8676002)(36756003)(4326008)(316002)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s+eXArD6lB+/Q3HhpczALmXq4pyF+bD9Cp5gMmOf9fTsE3t7GoI3J3BGAUuj?=
 =?us-ascii?Q?rtwGrIftb0Q9ZZ0kd64x3DukP1kUk+5g9btHq3W3I76mIdq5PsCZRlW6cZsf?=
 =?us-ascii?Q?hXnZPdl4kYK94bCPhBQEvGWbwi8+iH2cAY5x9ZckRmCRVvJFteI/GEATOWq8?=
 =?us-ascii?Q?GuHic/ExRVMuJJ0l0gbk3XvzCBi7I2X8PDZacfT3aMmoKKnE8LAyUQscKPNL?=
 =?us-ascii?Q?gIgDY7ZfzB4L9bOH2B8FOBq8KB5iNsRHAE3CpyI/xUjPze4g9HxHJU7o4taR?=
 =?us-ascii?Q?pnPc4Ewi9+kHL+nuYusCVxO0oZzRe23SPQG+ysHM1+q20f7sNGRFvq4QIkwZ?=
 =?us-ascii?Q?mp7tTUoA4DGQiKOT6ic83anml128fd1qamcD6uhUhRMmD+ojMV9o1V2oLWJW?=
 =?us-ascii?Q?cnKxh9hneq1DhFiHA46X5SuH0hQNrvaMmXZumoHoPcn+7d0ri/YUHl0gngdY?=
 =?us-ascii?Q?tS+OZwTXMcCvc2xceVKCuKdLPQmXpeVsfLsW/W8NQ6yHVe4O2F6n2prqpjuN?=
 =?us-ascii?Q?2/49A7vax1uhKyoUICA/HhuicyyVeRjmGmgDxM4SZHgHJ9XV7EwFtyPdxDLO?=
 =?us-ascii?Q?Rrz82bPTh1s6YD2hi6U/olcPRla3Mz2s44+M5aK8wt9EVgZioO1V2PS8SBJB?=
 =?us-ascii?Q?pROQjB/v1CgCxQ5rWGA6VW8PQsq2k75ivaLONQE40svcBusnktp0yVikon7Y?=
 =?us-ascii?Q?e2iEYER5cTHc51X84rPwOczqzsTbh2PFQP8A5n/rX++Fd7qLQKn+XLhZP6Zd?=
 =?us-ascii?Q?sDHWIxpYKe/TrZ+ssito2v4JfVANr4qbeWQNTweefAwTq2+5OAEkoDu9K3fk?=
 =?us-ascii?Q?5/rZtNWrBuWFjekSYHZ/xxmJfrRb1F/Ppb77bg3QQ8EJD4M1vD5wH/qjLErH?=
 =?us-ascii?Q?uaE4fhg9Wesnk9zY8VF6EhEGV3b+MIoC9U8L9jBdwbvWxGJAE1k2IMPN+EDZ?=
 =?us-ascii?Q?/IrRKEdT0R3Pkv/Tc3Uuf2j/3Whe1qTQviDo+2Lf9AlefounF9BOahPgMfsP?=
 =?us-ascii?Q?qJKu/Lz6bpHkuJfi6nQb3SX5ynrUSVUO2J9GakJnUgm0mH/wJq1K8lLGlYp0?=
 =?us-ascii?Q?ptieqvjdn0C+C5u+z4f3M8qWQLHiAX0pqQkiDEKiF58g5mwvd7drjNVIiWNW?=
 =?us-ascii?Q?UqFs8+/Zoivx0XaN9gzjwb4tlz69ZFWdnjONU23fOyagyWbicsINPkKsODFb?=
 =?us-ascii?Q?RN34Qcje4xE0rNzuXyiH2Ilw++KXwy5GSi1UVVhOTJd/l7IOoV+h/UHWUT2b?=
 =?us-ascii?Q?g/2/Pj+JiNWvD3eewXiFDxDZJGwelx+Fa3D2am+EckwwZS+1JZcDJV+SyOqP?=
 =?us-ascii?Q?y7QiWckSkRq9F2r1RDk3Rh8IS5XZ/tbGglSeRD4JZYQYZ5+x/PUrSUS74yOV?=
 =?us-ascii?Q?l283F4KbfeKU6sAQYGflAyfUFtfRHR6fMPmYmr6w7MIzZ+UMYoJjbhQ/buCe?=
 =?us-ascii?Q?5Ejy0QlLP6chAzAFIO4cYHt+N9HtnzRPXqqgPAOUCAAdum78P5s+mMu/51mJ?=
 =?us-ascii?Q?L3Xn/ewNAOM9S9uRCUQ8sEFJ5v77Ni5TtrHMKragHFJ21pJl5vjleRslsyYA?=
 =?us-ascii?Q?pABJ1ZX8drixukBuRKjoChPqu5HvIA8iFhg0PBey?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace74a25-05c0-40a7-f622-08dbbf6ec59d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:08.8501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/9Fe+Gt1O5g3HZfYWxfp6FYwL5CzN6gHxFAMhpVMtXcj8J1L53qOSSLD+nlcOcXfUlDzB/Mx3yCV+DzSogo/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
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

