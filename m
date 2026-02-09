Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF775EF06FC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 02:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A7F83AA7;
	Mon,  9 Feb 2026 03:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FrSTTR4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840D383BC9; Mon,  9 Feb 2026 03:07:31 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B438341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 03:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXldxyZhOxTciB9tvwuzdLOiQxWFN5KmhZI/e9Y50uYc5TMu/gulEblSa8vg1eSHMp9RARCtJBr0zd9MhIZEsBd3oFy2lQLpWcghyiSVsaCofICYeU3JsXZB5qzFIN1E9gG1Yw5sfut5zGWr38RJ/J5NQ/oWBawSBQdFBVwPWZzbIbyA72u4yKqa+m5NwNYZpxe+a++kdXOWKtai/ZenSJgsM8MGdk7GYeSNkotu9+O1RuqyVlmr4mh6BQxVz3GKaRDQRYK8g2pP+unkVy1NCrJZuAgsN0XvfAp/lf63W2OmqalD6fkd/2OXcJLps/hYza8B5/Ii9Bi8xJ2BKsEplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s+Dv6DcsF0YImJapBghrb5OxbEv7LZ63iLhyNPunN8=;
 b=y1orjIo1kef+HqSsJ7PQIIBhBDYhp9ikbLm1eoATEISxBtm2XcPYWJgftyQDJwCwkT8cGj5qTC1I0NmJ5kF2+sgBfcXLwn/ZZP7GK+r3eKI5bloXUO8VQcO/Qdma1w73u/Q7nwgqQii72+L7JtfsnT/PA7NIhYnLqF26u62ZMRvJ72QD0NhQMlgtg/7uexFVZVI+/sIYuJyCUbKZZngFEw0Eeq2+0lXJdB1SP9VA6wUeVkeffIAMNGpQ/belcZPHpuYqA41K80Ybwc/M/rsNeWtw2qSD8S6sP/urq9+rRdZfSVcbSdcGQbdpwjgOUHMRIlq15KZxrcJl8MknWuSkHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1s+Dv6DcsF0YImJapBghrb5OxbEv7LZ63iLhyNPunN8=;
 b=FrSTTR4N/040/6YbqvVvyz5a8Khyy0tQ6tdhnQ+gAttxQr9v+W2kuQnClBe9BU7oBDIStpJ1Z09MsZ5dQTpHVTRWvzu7+/4zZ0iyWtOyxt4ysQJYyPvlkGnS9MNslQSNBXMUA03rO/oXiLv0GHfOE7lYtxcVp7DINNfu/b6/pbNnhQhfPQmpIRZof22sVGq2bs8IRuijQnKDH0x+9kgmUAP9zMgThg540jprIEoRefVgLXn01LMTgwXE8kCc1oIzyOZoFQxdHesxGoK3qRvItC7zENluChBw9BNSTwFY0mG6iZR+H8oIV2V7n/3awqg6oKRZEScZM3TD9eNLGw6dMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by DS2PR03MB8419.namprd03.prod.outlook.com (2603:10b6:8:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Mon, 9 Feb
 2026 02:07:26 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:07:26 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 drosdi <danish.ahmad.rosdi@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v1] drivers: ddr: altera: iossm_mailbox: widen
 MEM_TOTAL_CAPACITY mask
Date: Mon,  9 Feb 2026 10:07:09 +0800
Message-ID: <20260209020709.19712-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::18) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|DS2PR03MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 1633d77d-c40c-419b-4da5-08de677ff853
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRxNXO1RJG4gWCWEwTl0CiX/MrO1NAqm9BfAqIPWkti69iVEOKtK/gV2Q/qz?=
 =?us-ascii?Q?2nPqVYz1i7YUfJahYm/CmU24GLmfOCi/1G4puQKGPMtQY71a2YcsOU1Irkoy?=
 =?us-ascii?Q?I6eBjbqQogyRwvT7b5zmC9zq9RvglsFBAXKjOi6LKFDHqTSQXkfOR8NWK2iS?=
 =?us-ascii?Q?8TH7MUC7fb/VUhRUYLV6ugDVSFl8ZtA6uGSy8Zp6q/oFLJCJwJyAHJEB5EFY?=
 =?us-ascii?Q?UUVnS4OcGfA7DATwg6nDhwQf461ByIqdSDh/2uLXrS+MAt87fiETAc/2ZtUV?=
 =?us-ascii?Q?WwHyrg5/N0gNQXGewEo14aRUDMTxvywho2h0cUkf96oxgkwi2POvZR3E8ICd?=
 =?us-ascii?Q?5mHNlDtYgUmHCuDIjkIKh11t/9bRKMmcTU+Ti9F1XPMCbhqqv1VV3oghzZTh?=
 =?us-ascii?Q?nL6yksaeJW4O0raypjfBh17pgb5FsfCTBTgF6ELK72iplw7AlJlTFWApz5h7?=
 =?us-ascii?Q?YkdHnKCHErXBsf/xwB9gquT+doFohEbQfJD+kLxReb4xa5nETi22gEZFRNcR?=
 =?us-ascii?Q?zH/NlvcxEw7IrSEqbkw3NuW6N9cXLt5WzkzQPSBN4JGSeeQYGVWLtODQcmPh?=
 =?us-ascii?Q?qbkMrGCtK1ipMtPYkdfqzFE/N3hq02QzMUhe2tNauebTHNNAjF8apigbunPS?=
 =?us-ascii?Q?5Xh29nIsQReVz8kM7BAWI+XqHS7YZO2iC+ZFtucVCSv3g0Z4CgzJus6ISXxr?=
 =?us-ascii?Q?K8ocI8CRX3i0JAqXtHCP7zzfyphNaHtLtVy2zi3ssFAcK1CvLzZM2QsOHZSp?=
 =?us-ascii?Q?nzFobZCxkxLyyPsU8dsjLOu5CHf6285jHA72A5oejIR83iVW3T9c5IxNiVyJ?=
 =?us-ascii?Q?sfiU++kNZ6fNwfJKPZlDwAEdr678McuYF9JMTy3E2O7pnsy+6/h8+QFcrfzD?=
 =?us-ascii?Q?Siv2iWSqS23WOwtH+2nif1JUJLNJzdDS9yVk1B/VezOCQ6K1MYM4P3XNqe5Z?=
 =?us-ascii?Q?wwrSQNjeyWgyS2csbHq/vQXclDAfGue9dJodS0JgRhczrMceyqtpgKz4SHLG?=
 =?us-ascii?Q?6L7Qm0FSTZArJUa2c2MJ33rgivYClO0yNI/WDEPe7Y+9eyRFPPHNjfxdAFTF?=
 =?us-ascii?Q?y3xaRs/JMCcYWlr0Jt/Vu9Z2iXp4xJwKEQQrMLekFtLMPqxa33q69UiM2tTk?=
 =?us-ascii?Q?PZOyGicjhep090ZOga5HpwuNygw0SypeTUdI/NEPI11DWCVqxOQP09cWWtWe?=
 =?us-ascii?Q?3AFfOR4RXzk3pnMZ6JWgQhwP1hGetc55PlAVuCxrJV+u5HsXllq7hQr3qJ+v?=
 =?us-ascii?Q?8pKtMdc+T5KPgCoq+r0LQ/ii9RHm0zl7bwNVsFmwySboijjCDdHE1Y95q7zP?=
 =?us-ascii?Q?lqBanNXGIxDCR2TcPwxdJ6DLWo6KTzwCVKcbpai7QLP3RG9V/qAncg9quIRY?=
 =?us-ascii?Q?kG8vek/41AphPFBevDoCELBrGtPrTGGY9+gcm+8mFbtYZuvQByvgLVEL0zId?=
 =?us-ascii?Q?c5FkDu5VUqm0W17bbl0B2tyce6RbgtdE+kRck0X8MkRMVlvbPWuHoN6iZD7M?=
 =?us-ascii?Q?kE0vROOHUQsemmr0OB1XeZyGC9XHJ6cTVYGVhlNCHPsLU9sDA4DMSYId6w1Y?=
 =?us-ascii?Q?ErvLK1FoQWBt2vwGT/c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kq6xuDcAjQNHUPpW5zRccCANU4KSrrPJOy82lRjC7uOAyxH/4MXFznAZK+SO?=
 =?us-ascii?Q?Jq1/7e7IJsfZAGHp6N91SUjEkOV8fTuutEw/wk6wkLdTYez7XIWiOjspoDba?=
 =?us-ascii?Q?aeh/RBZSx3VZc1wGLUBbWaulsuCZkvMsRdrVRYzLLlhZzmYF6BJa6K/w95u7?=
 =?us-ascii?Q?FRBE7INVw3W4aOXED3g8pWFAUtgd0LRlMTIzbJTw74Ypzs39yiBuHL2JWWfB?=
 =?us-ascii?Q?ba087HE5Fe/NFw70NPzovWWkwViFnBPriCUw+hC9nqaVG8FOcZ+FC1a7eBpm?=
 =?us-ascii?Q?aMjCbqcarCEjGuZOlYxJhh0xuOLHjS3g0dMf0BmTYnsPeoj2ZkGzEL1TGcIC?=
 =?us-ascii?Q?pWp94aZcTvfxplObHWcS+rQ87O84y7TCE8pQm9IgLUNZys7ns7GBHH7ujMLq?=
 =?us-ascii?Q?0wdipHxitsHiojugQU7alKql7wXjdGT75MTeXsSCi1s/Zu3qsAXUpX28nJkp?=
 =?us-ascii?Q?9VrHsfgJ03Ds6NDHepvkU3Hg8iuc+f9CbYbDpgA6dzvr05lCZV3cqocbhjSP?=
 =?us-ascii?Q?wyuZSgP7GGj45GDlCLJaBTf5xyMZIswITnX4tCt3B11jCWDecmZn+LCoZAgg?=
 =?us-ascii?Q?Jq970H4Ctj0dOuHPENWCiybCnJZkpTf6KO57W2Uc4aejRuz29zUvLM41KV6k?=
 =?us-ascii?Q?NT2PUC/I8o13Fro8KEpwbE0/g315TjjheLEPzzeEMAOer7Q5skABgQdroFhA?=
 =?us-ascii?Q?85byb6Fwr6jwFGul6kIu4OfAMBk89CL/n9/JIwoTueYDaBlSO8DyJNLVvWrI?=
 =?us-ascii?Q?/owv1bOESradGyRBQ7g7uU+LuvKImr6pk5Zwe2kPNtov/anSZYlEzLIeHJIT?=
 =?us-ascii?Q?bKfYJlBEkFlaExiNdHxE/wDRwT58vahUnS7aRkCcv/i1OdtwTlGmdpkdtinY?=
 =?us-ascii?Q?bo/Fh2Kd1tvyy7zwTXT3kdxBlARVh2k+3b0u7hzFDaPLrf5HONsxjuXJhyJ8?=
 =?us-ascii?Q?cRm0SSlgTpU57TcUJ9U9eFidSsQXIfO3N2G0TB1w8PRpOvV1f+7J/VXAHyJC?=
 =?us-ascii?Q?HuphehQLR48ZY/3+f/ab0o6gFoZQi6yGp2J6Wz2/7Q0k+Cgean0nebh0pkOl?=
 =?us-ascii?Q?8eNEdmKP8azD7YkFgiKUXqdldGu32bTf3/763YnuK39CPWmmquH10hfTD5qq?=
 =?us-ascii?Q?nf6iaAEZ+LkWYniv87ZoBcCBw6IGIb9w3pGj1xBT54DAsRZdoRhjvXsU09Oo?=
 =?us-ascii?Q?NniRenrx97tlPhzMijmS/KrATTmEzkxAFsrhZnsEkRo9DiZAA5uPrSK5kObJ?=
 =?us-ascii?Q?mThWbCLi0iTSHTVdhmPUVoVFE3e9n6N+mZzmZr2NvYDXemR7nDnxqcmGkkte?=
 =?us-ascii?Q?WaQfmCn36Cg7HmidaFaWbPDcPLeuwNSRUixk9JPUArnYxhyimt18EYhwrnP5?=
 =?us-ascii?Q?Lu29YaGHSH6G3c4ouYoGmP36ITNhTzhIrh8of1VblragFOazsYs6yvdJdBhh?=
 =?us-ascii?Q?P10hDVQs2WRwwQB5qjsUAtKQtqPqKdQZcHbqadBQWrezCSWfUyhFNw9R4uW+?=
 =?us-ascii?Q?rDyXB2qibDqub5QQAXRR1bZ6EqYNT+BSymoL7e+TdfdNj7UZShOq7DAeExp8?=
 =?us-ascii?Q?GB92wB27NHYWvqj7mF1jtVYlVz2RtDoUyb2eVLX70bG2aWLFnxxaXbmJYoRO?=
 =?us-ascii?Q?yN8tgZf5S9OOka4LpOqXNIZt1n/cI41ZTHwhbJQWI+eXj2JWFZdtUQU3nbG7?=
 =?us-ascii?Q?m4xh/qiCxEZL/SKp3ObCoBf7OoBVAQKTCYz3DFwG0uzS6Y564p2DOPVYm79v?=
 =?us-ascii?Q?UjF9KDM2hA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1633d77d-c40c-419b-4da5-08de677ff853
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 02:07:26.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REi15la7ljlOkyoe9gAm6qMxgzP2J8+6vktLJPnO+n30SBRHRFqCu1TvBeKS3KI+dYQUeR+IUnAiFUiD5XcVvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR03MB8419
X-Mailman-Approved-At: Mon, 09 Feb 2026 03:08:27 +0100
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

From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>

The previous mask for MEM_TOTAL_CAPACITY_INTF was limited to 8 bits,
which could truncate DDR size values on larger-memory systems.

Update INTF_CAPACITY_GBITS_MASK to 32 bits to correctly represent
the full capacity field according to the hardware specification.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/iossm_mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_mailbox.c
index 2a2f86a650e..3156cb9d4b6 100644
--- a/drivers/ddr/altera/iossm_mailbox.c
+++ b/drivers/ddr/altera/iossm_mailbox.c
@@ -86,7 +86,7 @@
 #define INTF_DDR_TYPE_MASK		GENMASK(2, 0)
 
 /* offset info of MEM_TOTAL_CAPACITY_INTF */
-#define INTF_CAPACITY_GBITS_MASK	GENMASK(7, 0)
+#define INTF_CAPACITY_GBITS_MASK	GENMASK(31, 0)
 
 /* offset info of ECC_ENABLE_INTF */
 #define INTF_ECC_ENABLE_TYPE_MASK	GENMASK(1, 0)
-- 
2.19.0

