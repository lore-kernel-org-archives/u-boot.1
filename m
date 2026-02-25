Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8B9FD375D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA4E083D8A;
	Wed, 25 Feb 2026 14:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="add5khMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CC083E36; Wed, 25 Feb 2026 10:45:14 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBDA82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 10:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbX557CyEIzd11mIGS+6KHC+LbWxi4w4dU2kK3w7rIVpOfoOgXSvt6pP+1TxiT0/X4S1VLsw68bLyHiux476DMfSuhe/RRljQ5qpqeEAvBzvKxYlhsAx5i8Ot7or8DKqo8tgwkckjMEIuH+cZZ/jISP5HCFnCIaKRDJ5JQk9pMC+tKhCbQ1CkQd3+RYp9/Ep16RqbLbqTcI96pyEyDNwzOofOZI+yMZrVU/pU5EXNfw2nY1phhmWL0TaX2ulMFBChVskJSQGGZYUrG1lVvgkuJZI8+4UJgn7tnnZx0b4XfJN/cEZiW9IIZ2hcT33TKPZEWG4U2btJG/EeluRj9gDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riC7gm3HlSKQyPaqZrCQbWxcfCadrKVtiFpWe5ivJuM=;
 b=fGZCHyswDfB9Nae/b7gwKUYrzoP3sGa+yvT0XWaXc7L87QiWXs6Jdr/+tVSCw98lABRDirZF8LrSmA8nZwvmi1vzRmwA2Vrh/M6qWYrG/PmKreaml832x/9d8LaV+5zJEN6BijazmyMBgfO7OT/qsdMEF7212lvU2iMo+fyZXsES7pLYtBRslgU/++zK8oSEXpNVb9LD9MC13m1pESZpmfbg1fZi7U3rMLOr7pIJXDKGSTjQWaa6KPv+7fSs1bn8fzo3FoAZLW/Jos9BQoRmL9M6bz8ZzMSjMTKryC6wR0SLP6PqmFewEZtXjwy4g92Iym8EHazpPh48emUNykqF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riC7gm3HlSKQyPaqZrCQbWxcfCadrKVtiFpWe5ivJuM=;
 b=add5khMY/30FxnFQAz/GAwl9jcUTo3O7zh8rDb4EZjriY94PT9MdGEXkZRVHyp6Nb+0/DLHm8P8EdAtGzjCkgzmRXMfGJ4fw6/dNcE0Zw3cXURREBKX5atbhF2oi/BjVx3voMwGZDSQ8IasR7qvc4pwNEoZYhsMgLmgoWAftR+onkPVC3Xtox8uwpE0z73eLEYEfSK5DjGHJiDTePrnp1GrnMT6GijXDI+clfxaLbecLgXOkitFgXS+uW4EdVaCljKVUCO+f530DNvi7RxkP5PmLSDTprvbUq+j1Bb9HbJSYOPXcpwHexEvoWW1DoPfXmLXLSWpm++hlVns6zU/qpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH0PR03MB5752.namprd03.prod.outlook.com (2603:10b6:510:36::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 09:45:08 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 09:45:08 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lukasz Majewski <lukma@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] clk: altera: agilex: Update sync to async mode config in
 clk pll
Date: Wed, 25 Feb 2026 17:44:53 +0800
Message-ID: <20260225094453.33673-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|PH0PR03MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cd716b-5e67-49e7-c658-08de74528fc5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: nI05eBWW3dO3S1L9KduDv2kVCKdW5CyrFX0mjFS5ASdllk+ghwOZAQjqQay57vtJnXfvJDtFeYDmRWzJEFNCaCdXIXd+XWbH7ab0OADeBNJvCWO57q2dnwz4PmlHJ8Q4Bfmr4qEtXwaC191NKcCLVVr3blVGz7wNGjvmKpgpYeBXCz52s0eGXcg9yN9DKMBUMHM6jyGyqMz2DiphN/C5YgytsdBMZ/oQtwpajHTgqFwluDKUU0HTihQ2L9d/JptPCN4/eX8mJV7309j4UfAa3bmvYFZMoPEq+vYTvfAs+IbmIOiTQmybQL1/7Ntj9Rkwi2MvdWXHXiPwNO8WF/5vfXj4hwV0ENV0QSTIE1ItoMphtZJjR7QJUsg2DHpbRjpFHV6TYwGbwt3rlmIIqffUHs57svx4l7iKeL2D78isQXKnTEsuJIBqs8Wvrtk0liYx7u8u5D0cjj5EE517qM00QAV7MTgA85WakCivO3h8QKMcUfNAPDvtZv4s4ZbqQArrJHqkLiFW4ozH8aR02gCfi5dNdrZLGSVBW0QEiKYOLPE1RO/hqG53BX93vrsy9YWqFv1UpYIEKg3y+MR78UNFLOXyHaphCH7P4LGn7u/89BSMJR71F1yCKBDGx9Q9o6hhQl4P5NvIygx2AU8aDZu6bXd6kxnGOXNR+78MFZ0N4LtcQQQD9HQkEc0KylEDVFC8Ps3xnn4kOaXm5RPQ8RaVa1jS6sOZdXaGchItuJ66C2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJHkypX4/vvJ14xtYdjgaWhT7gnuZ45On498ZsjY+6G+Q2oYEG2gqY/qaWkM?=
 =?us-ascii?Q?A4SWDwGIy2h0ZXsXSYkZf9TH8EIlCdXK0vJUdrW+vd72j7cTFae3YidenhPQ?=
 =?us-ascii?Q?ODHj/yVqPEuwNHh+w6MrWTjb86Js1wcNEuNvs2oouKyBRgYxm4FCapFLyeKi?=
 =?us-ascii?Q?LjBZ4XVFOcUg/8sQsU/HZvBxVk3qPy384zAIhXVEigs3IK4Csy5I4quXIx+/?=
 =?us-ascii?Q?00M85CjYLYzNFhaszrZLgc2+ITg7XlPyl6AQlFZoGxgK/pOjX0/3Ujph2FqD?=
 =?us-ascii?Q?ovOCDxJmXPbBMgvi36fzVhuG6eIv4AeaVIZ2VEDYPSM4+p4oe8xUVmENn6v3?=
 =?us-ascii?Q?rhSnQcsxTujeDscQkQm7DnYJ+lgErF/SpF4U3UheqgZGuqLAQEmKueGIwP+a?=
 =?us-ascii?Q?e1lYk6gXofbxvFTajjNJrfq6alb/+jmGI64G5C851AjX9dQCRmdIfFXL8xSx?=
 =?us-ascii?Q?Sfukzdip4MP3mZr/5mE0Sx76Zq6fuVBdtOLNAJLihqxkG4VitvaUbdobJ7kN?=
 =?us-ascii?Q?LeSsTjz2CKejUF5DtdvvbQ8sGuS4Eq6gnWe4O0lI75l0M4EFNIFdMQwdqdTY?=
 =?us-ascii?Q?O12qAlHz4v/dpdH1hOcnucuhHzH1t3wqfKTcu1afJT/XIWAFYMdVISbc14K2?=
 =?us-ascii?Q?NQdadI3YgmORy1F5SoidtzAoJ9GMaXyKvBDo6KS4X/yk45qemt33uFAZT93+?=
 =?us-ascii?Q?Pdftwx4KD1762N/PQXgwqWXYCBahIqPNeAKkxxgO87SIRy7PdIhRFKObMZoa?=
 =?us-ascii?Q?rgxjlqFPYv/jSk3DXmdHyKQeFG3eNun6FfhdU4RPgH02ARaukqfopgWVqZSq?=
 =?us-ascii?Q?bxLnj4vclO3kFS8gwlcXwPhm1oiVcpElf/JiOpaQjgft41cHCid2yv/ushFL?=
 =?us-ascii?Q?i4bwI9WuS1uPvhWq2z/X2nIPu8BrJ1eeb0TTd7BXk4AM3iJr5srtu+S4XtfP?=
 =?us-ascii?Q?DmyS4FDCtwrc71e3cfqUPjNcahMTj1wgXY4ZqSH2V3cW9Lrn02GoZHoq+fSb?=
 =?us-ascii?Q?CnR31Z5L52vklVhB1nkU7804ASSviinCVkkjWavPHi3DmqBizt1j/PraMfts?=
 =?us-ascii?Q?lO9z9rTHa80dna7EL6LbqtgBC7TFnRLtT2B11uKkFwnyim1M/bKbtEFiRfVX?=
 =?us-ascii?Q?r+woXjl73aCpe2UwQtRRrLCKFIg6XEFarxXYCxXJtXeNZCDXd4uyCH/QVbwh?=
 =?us-ascii?Q?TVV1SChEw4YdhCno/Vefo6jzNKHABpYfyQ94eGmrFG/6CSBAu2hwy2E6Fypo?=
 =?us-ascii?Q?TSeXm+hnTHsiSUtfksHLF6376Mur1ZFycbfp1SYqGNgZC1eSdG6AId/QFfLd?=
 =?us-ascii?Q?eA5mPz2b4YPEQjPhhgV3MdG+ESPqDqoat4Xzk1y5jzt/Fs8BrfoKlZcdqPN5?=
 =?us-ascii?Q?DXqFiZqBM6D/BU82guvcMM/X4FkOoXnyDMY0BekgSrZY3U6+sbNYCQFPserT?=
 =?us-ascii?Q?rMumY9DVh/xvJYkODvQsP0fxGiF4z8fh0drlRCM28+RKMMU185IYW1a2z6wY?=
 =?us-ascii?Q?WILHi/AHL86nSJ+X3vd4/qQG3isbM8lXast25Yiz19EXd0tRHcQSOvF+/Vth?=
 =?us-ascii?Q?kKRMK2rNd4EzIfvLL4kBWfO3ceTmTV2SGjiRqhsj9zgIn10HTl3OSVmp7LSZ?=
 =?us-ascii?Q?TNQCbCb2Ap7RlLrXI3f+S7Zs1rl5KvBTwWgmcZ8BOzESF0yqEkfMk2ivccqK?=
 =?us-ascii?Q?6ZrhufQ6gbatDFy0Iqjgos83llKLlYIbEmr8rrifei93SzMtXOOJzOEqEOQ+?=
 =?us-ascii?Q?N3xC7eI4tQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cd716b-5e67-49e7-c658-08de74528fc5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:45:08.6039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/Sm+UZNZiBGZvgNQlba1sM8RuI9/SzIEDyme7Yx0UQoGT7lqy0/dQMpSXfmsGeF1VaNVcFmxQGh7D3NUZm2ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5752
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:19:09 +0100
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

Remove MEMBUS_CLKSLICE_REG source synchronous mode configuration to run
as source asynchronous mode.

Switching the HPS PLL to async mode improves resistance to clock
marginality issues such as F2S clk to HPS PLL

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index b793dbf6a42..426f400159c 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -74,15 +74,6 @@ static const struct {
 	u32 val;
 	u32 mask;
 } membus_pll[] = {
-	{
-		MEMBUS_CLKSLICE_REG,
-		/*
-		 * BIT[7:7]
-		 * Enable source synchronous mode
-		 */
-		BIT(7),
-		BIT(7)
-	},
 	{
 		MEMBUS_SYNTHCALFOSC_INIT_CENTERFREQ_REG,
 		/*
-- 
2.43.7

