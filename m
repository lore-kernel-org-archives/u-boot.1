Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D5EE63C8E
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 12:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E5E83A5A;
	Sun, 25 Jan 2026 13:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="X2malykn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34B3083A64; Sun, 25 Jan 2026 13:40:09 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044B883A36
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 13:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpoFFxcClSnic9CcqEyzr/CXLq/ASwD9KTaeN8IErXH0gwHxZ+KJoPoEqlEmgHbICinYUnD5TbMlPyL83JH4+bnSxvapuy43Q8er/4MDxUHy4TmpKRU9X1xZdnlDO1XwhkQ9Ro9XNUfGa+cDWPM7rb+HS6EDomvS9Mm7RgKQbEH4C2I3FjHxIS7T4c2KGg9tn1J4DqMo5aKt60Rw/mdzo69+Jyr+cS5DJVo5+CMycjKYGQBvVzuPzDTJMp4MuCqlyuKn6srBhE7AWRj/XTcQcKnb1i7stB2xPWGJjcGS9YtklAc/D9gxm2jBhW5aaGHAmbms+j5ImRH2+sNxfbbjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swm6kqBMRcaZznmXV9WHqDI4gdl4RucFJm6AKahNrGg=;
 b=FiAFS0AmfYfP+3WNMCINoMqIM+D696hOOMTSMMJYTtYxXpkNgf9+Ki1lNyj9W6nLjMrS9OhCLLNTE6YKAtq4QeawMG5PurK8BZrAFN/BUByfCg5/VX0ePlBxZnm8eBUrdrxDYZXsioBnWQDIu2bYDBfUtS9RWL1GPo3OaqZUsQhiSDIl3Y5RoBiDgdCdtjQU5QbUc3t6DBhhNe0HSif30yLP5UxOCS6gKXUGcLWzUNHLFDp9kAKOv3SIKlIDvVNiaV1zbfDdN1Y6UJvg6cCsD7ZzyNuBl/mqxhOK2dtXdoZo/wj3M2tat9iNrHCkibyBfET0EpOOzM/N/PQAAdbolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swm6kqBMRcaZznmXV9WHqDI4gdl4RucFJm6AKahNrGg=;
 b=X2malykndMb8MgrC/qObTGl0XNE2Mkj2QyAwOgd9oimC652cwtXoG4ZqWxEyxVyFJxOoRXY/Ps5eK6LPXt1NLwgP73DxfSIRf995KxIX3Yk3TyN5AM/4nwQTHcgXBtfx/m3L3us/wDx/hRwNTJjvOKE9oE7QvHdXp9qEw0HdNjD3HvnMpueVEey0nJciqQ268udU7eLMvcFzwLFe0Atbb5wHgOkE4vtF/CtzuxC/rWD57WmBsqCqYfb8ZKhPn4yESJxSBdnspGrTBQie+TWTA15j6TxPETwRUZfhW+UOAb0h93XGf4ZuvgqWAvpOOmNM3sz63SCN1UvNbbV113avYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS1PR03MB7821.namprd03.prod.outlook.com (2603:10b6:8:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 12:40:01 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 12:40:01 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tanmay.kathpalia@altera.com, festevam@gmail.com,
 ivitro@gmail.com
Subject: [PATCH v1] mmc: Fix typos in comments and debug messages
Date: Sun, 25 Jan 2026 04:39:57 -0800
Message-Id: <20260125123957.21295-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS1PR03MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe3fbe9-0e85-49d7-595e-08de5c0edb0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mac7DR6kb6sh420hcZwWMjgtcMgsgLyh9/SDHkup1wlvjx0duL646eTglNn4?=
 =?us-ascii?Q?41n7KoGFgKyv+gxW9GiAaOIvZ5U8vae1Oui0IMzqbQxDH+/2q1Cxs4JVZpx2?=
 =?us-ascii?Q?cF02oQtX3B1zYF8+r2A3mu3FvkK0+RBjj2U2zXDciqmuKzC9Wj06HG9k2WQU?=
 =?us-ascii?Q?vPNU/WBwzfjpUB9RTRcjPWqjJlq/TcKSJFeowE/37pCRrYWClzgo+/Y2jGOl?=
 =?us-ascii?Q?rtk5CoHmvIsVoB/UGya4e8tmJ00aHJRnsBQGmW8YzsBViFwqAosv6WIw2Kg9?=
 =?us-ascii?Q?GDTplV4j0T5v8+gm9xnF2LlGRW2yiYJXTLSDEOzcI2WiDl1V8As+DJG9kSf4?=
 =?us-ascii?Q?8XHrLIDLOF+Cmqvgnx5XciPzjs9THnph/SvAL4HeuFOT/DXFl2Ehbkd4YjV1?=
 =?us-ascii?Q?41X8y/VFKqMrk7yogMdDw/BuhTbPyAOAnDIYdwedP1Twb9EH+bdYAZzMPY8h?=
 =?us-ascii?Q?i/cI3T6BPVs1jIM7iF37nRX2lOPO2kQlfN76+m6+GuREIsun7bheeH1n2o9a?=
 =?us-ascii?Q?Pv04jrZLe7qa4zThcFo8D1D9saQLpEZ0ODYLdl63871fKcQ14RFjmr2q0Dfw?=
 =?us-ascii?Q?D8HPwl9XeamMg5d/4WcecFG18+auAfcz2Z+pv2Nin5a3CF4Qo3lPmBhZK6Ew?=
 =?us-ascii?Q?0V9Odj0O89LnxPdnEkrJXhfLPn4pasaj5Elmq/9r3FqDADm98/FXxOhmzrPy?=
 =?us-ascii?Q?T+6oyQ0bwBEMEnxAXvk4qowID85GB+qKGLTRCXD/uFzLmH4/cx/KRMALHQ0c?=
 =?us-ascii?Q?xaoiezhQTa1T5UEbPKBpHrnjZT52+OSsfKEOOEel1Y9HiROOkG/t8wP6VERg?=
 =?us-ascii?Q?T5NVJxplVVVOh94IjlSFOQOfq1GifKnmGIZMOvhIRJDWULyLXYvFo7qrByXw?=
 =?us-ascii?Q?F24Wt7r8PRoEPKky58PWjlbJqdr+Wrv2xHGuzM3Plo8WzCIYFZK+nmJql0+J?=
 =?us-ascii?Q?3eIv0kySKhd3jDXgxev6/UU6/ROdwaJtRg6LGtepwk5cAC+1EuYDgWg9PzNT?=
 =?us-ascii?Q?+Gi2mU/7tJv/rKs4UBE3KjgU6FL7znkUBdcnKfKEzerl56/265557yrxRT8I?=
 =?us-ascii?Q?edp7tk48cx6YQF8/f4nApSZhNMNPtXC0p8+GgJKpxjFwY3zZXlV9ckE9k9Iu?=
 =?us-ascii?Q?68MTXcBY1zjsToHm5G0APzOlAnV9uBcPrRiNQDBa/8m7aPHPTz5xzYpG9St/?=
 =?us-ascii?Q?cGklKp59ibogA6RRTfRJm7yfQsT6uK2h9Lkb0QS82tppb0gB1F9eEPZN1CdZ?=
 =?us-ascii?Q?eir8PwJ0NPxJ4iBSuiB0PkXfeKfpg4TAHdBbW0i79/C5DsqyUhtmED7A3XX2?=
 =?us-ascii?Q?pQmTWnhkWaPIhxn7eXik1Up35tsk49alJsdkjeYtErSBOuGgJ0F2lvPy+JzA?=
 =?us-ascii?Q?kWA/KQQ/2ROtWxleSPj8zecVIC8m0nO9/tEB97ohCAkV8c2OPkPdWa6liaNE?=
 =?us-ascii?Q?+RYyq9XymsZ7cZaXqfw4OChkjFqddRFg9eK0+CLsk7966L6qMKZ+FU7QITXh?=
 =?us-ascii?Q?0+/qK1LVL+DqlR+zVJt03rREENaBmVO9cybGHofm2X6CQQyfFKi9cmK/pqSJ?=
 =?us-ascii?Q?KxVUYEx+l9GIhMw2QMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?muqBW2ZxhnIK01TQgj8vBfFumeJiY2HPCUC4kr6oslKBtaEb0IyEWwByubDj?=
 =?us-ascii?Q?OTQZds4Mlel0PWu5+VeixmEXHN5dlubQ9XORXMQ3w5iQooQNrnw+7ZlV1F3t?=
 =?us-ascii?Q?Kl5jqB6WBzlly9Tm1xZtzrTYH1bN73y1TTpd3tf9FkbrtPOQK0M9KnUFKCQc?=
 =?us-ascii?Q?dGkk5yBvxMxCylCOYFQ/P/waZnw0a0CQYGkYNBmGzbsWXms8JiXO2wBjGHK2?=
 =?us-ascii?Q?IsJs5o1PdguqmGw6P+jcEsFWC/X4qn6+R0VjwJgNBc6TjlYekSgeuXkbBRoZ?=
 =?us-ascii?Q?ywjfIyYrStAoEt0YTTmWCcKtwHqN3sNqInZJ8eNo1QcpBIQtYK3nkk9TsHNk?=
 =?us-ascii?Q?4Eb9b5+pfWwfdBWxLIauZPnOdMgCFmD/zZeHDzXK2dPvmVXhbgsEVyLQV1YK?=
 =?us-ascii?Q?8b1sqfjy3QEUwtxIvv2e+jL9EBf4W/KxLDqmjVrNNNiIElqvR7mfL7+spdQz?=
 =?us-ascii?Q?0lCf3Gzj3+cIMb/6BQ5S8M7B+57CX6itXgxhSm0SkAh3yhNdlUth8xuEYbb4?=
 =?us-ascii?Q?NCubCv9Qds8BM36D1kU2hX+FFafLg2gO6XcJmDv1H2FRwJ5nz5UvBCOhB8i/?=
 =?us-ascii?Q?MY1fHM7O5EkYZWpOj829zRIfKREbBQC8ftmVqozKcJjICT0BBe14p4zDHGu3?=
 =?us-ascii?Q?qflKApzs+d/BnwaeXhvBxTV/f74oEcOP/lZdYFLbQtv4fgNR+Sk+dUvA/hGF?=
 =?us-ascii?Q?1mXCDFkECSd0WGgp5puw4HvyWwSkrfih5dUOPpa6Aw+JepLvJhE51WKsrz8e?=
 =?us-ascii?Q?DKpL3823vtsEohCh7rFGId/n3g87/vHXoplaHbjB1eHMxu4sU4dQakjidESL?=
 =?us-ascii?Q?RFuEvu7IT3PbPup1I72EDhTBUg+1iFcsrcsg1PiKQAFrd6neznOXVHJjnrXd?=
 =?us-ascii?Q?ux7IjFdvNRJpliOnL+4/rALEhBVJHxQ6iFYfA5hKpGW2IMizzbuKd/wbYooH?=
 =?us-ascii?Q?QRfWHbnQS+NA8FXr3cWgBw2UAaL2cB++tV4f14gKei7XueKUn3qH3Zlvt83R?=
 =?us-ascii?Q?6cpBs+kJNY9bKNJZfciNmwrpm/Z2USxrmC4MAIxEuHxUnygJASaegFyMZiGN?=
 =?us-ascii?Q?sLuRzt2vMrNp0Y13HfHoSpRoi60AQKWoD0AJxv4gwFpG9kUOlETC18g4ofWS?=
 =?us-ascii?Q?6n0tauC9RQzE2vFqbxO8KfJc6AxRHh3vroiU/xmCwWqrAZBLuyMDM1E8o8U1?=
 =?us-ascii?Q?MacumRMIBsx6i87aH3W90Q5ATdt16Ov9yBXFokyI/lLZobnCJbVZaiNfRjvx?=
 =?us-ascii?Q?sGOnvc74bIfdYmAFfnDwX+M+nWRMxF3ykzUQfSgMoRBeEqL6t8FrKpoBmveU?=
 =?us-ascii?Q?8ujSzdIas0PVQHNfMIY0s+2sNhUEY9XZ96QdtqzTYd/RcvHCOOA3BUOYzJXX?=
 =?us-ascii?Q?nDiI67Nc2p2WvJ6Aq7iLBf7ryHcPy+uqNAAQLGe72ScI8lENzp2+XMcZfgT2?=
 =?us-ascii?Q?LMcy+0P4/y3eFdiHPxuB86tay3XZTllaxGCoo7Jwc6EdHct0LqM0D5EoP9qJ?=
 =?us-ascii?Q?QCIPa+S4voT3XhW5Qpa2QnZEwufnwbnb98gp8B82vuyFfsHRRSqpia8ozflR?=
 =?us-ascii?Q?oiynuCBWYzbuV4xPI8Mx6ulvZumLIk4PaD/efZlmXaffxaQsBEGAh0pdi1RB?=
 =?us-ascii?Q?6qdLSbaqLwCcsZwdyF7CLYGMmtQFj4W+aJxmBDkpfUFTj95Jvk2P6P+stACB?=
 =?us-ascii?Q?36JItjEdd5Wv8m0PKe5LE1ljMwy+rrlecv3M2L/J3hxBzERXflZfTQNH9WIR?=
 =?us-ascii?Q?wzYjcyybrfoeFITlmJ/3sFeN7jVKxCc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe3fbe9-0e85-49d7-595e-08de5c0edb0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 12:40:01.0219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WL2BR78ILWhODaKaGPZ/J+M8NkqAQnpJmv3x4q0EdJG/vTynHlgEv02fIq4HKR0dnRVn/hb9ZNjmRdg6St/g55QeLi3wHU8EPypjSr7GUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7821
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

Fix the following typos in drivers/mmc/mmc.c:
- "neiter" -> "neither" in __mmc_switch() comment
- "witdh" -> "width" in bus_width() warning message
- "enver" -> "never" in mmc_select_mode_and_width() comment

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 7dadff27abe..c5705f4f215 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -889,7 +889,7 @@ static int __mmc_switch(struct mmc *mmc, u8 set, u8 index, u8 value,
 		return ret;
 
 	/*
-	 * In cases when neiter allowed to poll by using CMD13 nor we are
+	 * In cases when neither allowed to poll by using CMD13 nor we are
 	 * capable of polling by using mmc_wait_dat0, then rely on waiting the
 	 * stated timeout to be sufficient.
 	 */
@@ -1663,7 +1663,7 @@ static inline int bus_width(uint cap)
 		return 4;
 	if (cap == MMC_MODE_1BIT)
 		return 1;
-	pr_warn("invalid bus witdh capability 0x%x\n", cap);
+	pr_warn("invalid bus width capability 0x%x\n", cap);
 	return 0;
 }
 
@@ -2200,7 +2200,7 @@ static int mmc_select_mode_and_width(struct mmc *mmc, uint card_caps)
 		return 0;
 
 	if (!mmc->ext_csd) {
-		pr_debug("No ext_csd found!\n"); /* this should enver happen */
+		pr_debug("No ext_csd found!\n"); /* this should never happen */
 		return -ENOTSUPP;
 	}
 
-- 
2.19.0

