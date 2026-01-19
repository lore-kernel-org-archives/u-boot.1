Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17DED2ECF6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 22:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F104839DF;
	Mon, 19 Jan 2026 23:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CXjJbNOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DBF783A91; Mon, 19 Jan 2026 23:33:27 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D958389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 23:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK8gcmp7U6NAK3IUUU0SHzusw5JhUJaLaE93iwSh5EiU0xgbHGJNNpbiQb4J9vm2RuP7qXXW5o9zkWv6HFiDTQQmLqDWiYSM+tV/DyA9oKv59vhR7AhvhuP5lPNoYpM3ahYrwafzo+caP0gjUVbwnS8GxaXjCF+ooGssqkswkL3UxMiv5/FwUDTa/2/tb7SbO13yeERHv9VbfteM7QW+qiHEga6Cs/RX0/8Y6J99mm43k9rrI0YtfOtd7IUrYNUgjL3dC4azol2ndhaXz5xfrC0Iv0m3709rig1kF33UCy0DuSLuceGgRijz1M7rP7ZbPBWnlcDw4DaP7P7sXeU2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWen+0xEjGEVftNY1gMNDT1dNYaQdALEjU3XunMjV1M=;
 b=hptGZB7KacF3mRjCKLp3SwujsqjDrWX/BO79fyCshbeDJqK53ECKMiGpeG6pBBhpjrIucslqoBVx+QQpMeBiGSAA7sxr+5QQb2owA1tpLtyhLogrKbrXfwMYci26o3I3sF/iPEV7u1EV8f97jUhbOrYpZ+IkpkcXunJjq0jVoMJD8pB2EdPqaUL7uqWC+zRbPrDuxuVZhKgFaGDUk7zq2RxGIBxFzObn1yjj71OfNyJs5QiHirLrWF+9wBK12DJ6Oy1WKqmHXRNsSozrQJdqz3rHt6XZEgkcYDC3tIwBb1YhDN2xz7vpjIac46SvjhhJMCCDbb9pPy/2D8DXmvnkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWen+0xEjGEVftNY1gMNDT1dNYaQdALEjU3XunMjV1M=;
 b=CXjJbNOvKMdJcb1GgNdeyfVfDenkmILMpVTtsYvDKIM2hekqPCkXmxCDgbxgcDjJ1FNPo+uUuDzwz5tJfYybcMO941mKwSwAzu761hiNvIqZPdfs4LA19UZXDk+z6Tu3CNqeoUdWW2kx391IxOumFE75cTqZBSJhx0Q/rfOUHJ64W7deGI6y2xk8eZt/FWmxWqkp5qlV8nyje5vK25Xnh9a9FnvRT6uXec95y2h46DAE6o6nWoL37v+YaJQkypTzHuQYHT7tY5AMdcapZlGTQbaYGhhHsKY5eruOg6/FA5VCIrEXX1z0VQS8kHQVHDJUJRx4psN1vYQ77ZNoVtQNfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by AS4PR08MB8242.eurprd08.prod.outlook.com
 (2603:10a6:20b:51e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:33:24 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 22:33:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 3/3] mtd: mtdpart: fix partitions searching
Date: Tue, 20 Jan 2026 01:33:05 +0300
Message-ID: <20260119223305.3022690-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|AS4PR08MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7b0168-d279-4685-3937-08de57aac1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h9QYN4EYZFGX5H8WhztKsMaYM4DeNWiSiRhk9dAXxBnV3VI1Iv/zeb5dFpdN?=
 =?us-ascii?Q?DFXJBNYFvboSk9+fWRIAGpGjt6dyqT3t3yOQAJfThGiqyRkqbhqCX6QIqb4j?=
 =?us-ascii?Q?jYEqe3U2JKe9V1qJ7rbEjOl8QLMtFzSFklWTtF8ap8lDH28z1cjbNLE96gsm?=
 =?us-ascii?Q?rTX1Jkrv98FaRabQLWzaST+KFbdvcrOJOe7jBRtToLCWFxyOAvs8FsdbXXaN?=
 =?us-ascii?Q?dG1civFHyEsRx0Milkb4rS2pIgzVSQSlfUzRyFqf+isSHehxD6RVh7B03345?=
 =?us-ascii?Q?8uikmVFkFOlAsTLcNPWu8zhbc4Qn+NAyShfd0MEeegvAbk8Ca2VbjVsAO7Cg?=
 =?us-ascii?Q?HYOXrXLExMD+ZG64yozBLaq6vqPa5YBU+HhYLooaCoNZbLLBdOHFIY/yoU9I?=
 =?us-ascii?Q?QegdnydmCdOBXs9ZJ+8I3+Umh5opYmtmQMiNiqvVnzIQC4J/w+Zmgll2MZxC?=
 =?us-ascii?Q?3YieeunZsUtz4XLuf5XwLwZlxZ8+aUiBAG5Actf/UUp3Eey0t/ZKmUn9Yp0A?=
 =?us-ascii?Q?LR4a4oGswDBnPjHzb4bk7E7t2D11cmxykIhvlwF8oL5+IOnmsmPb4QZU/R7O?=
 =?us-ascii?Q?4GCxZ4kTNTLWWkqVW4eD6Azn5H2WZTO2EWTek4h7QKdRUm2KkWGm6xwgHPK9?=
 =?us-ascii?Q?c+7hAk4dE22wco0ZNFu2HcfLOI5Vd9HOxQVbSEVgwrHNkqbF0b9JkIhRvsWT?=
 =?us-ascii?Q?eZ5kweiyatT86H2SCjY6j+udGIrQ6mBObVT6ZB+b/3ABtIgwSoSemKJSD1cx?=
 =?us-ascii?Q?0jS0sW7up2VjgUnBE7RCxZnlbpsqxN8sXeAFc5YWVGNruS37JMksh2DV0BFJ?=
 =?us-ascii?Q?v4d863GI2AuJKFceqKGwONgLCri6JyZwlumoIZG37hpLrX6xMSYJtNDF6Tz7?=
 =?us-ascii?Q?pEhhPUk28y9/aTG+Fl/UqUr6tmyLTsNEwh4iGUhWBloNCIma3wn1s2XXLKWJ?=
 =?us-ascii?Q?kl2PV1Uz5bXYy6CfMDWNFXjdKtYrORZbGMzgb4BvoUbX+5MMbAoqPww2vk67?=
 =?us-ascii?Q?oGtNsz4G62lILfwVWBLUSPSUnkRd1IM/JaVMd/iynMbD+j0fbLQJ9Uxptg5J?=
 =?us-ascii?Q?MDDMdsvfOqi57Fo8mepgG7B/BiHPYo9wjs2t98ZPQV/m6a1kupGY9qEIKwIi?=
 =?us-ascii?Q?RP5kwgGiQevZL9ylqW/LuTGZxY/Hlr/mVnEAE6RpHsLmKG0Yz4hLVOJKl8dh?=
 =?us-ascii?Q?LEdYe2rCqdyPjcn1iqvwZJK+kwQF9vo0E0IPUuCGQrwkw01YaS6EQBTr7Er0?=
 =?us-ascii?Q?fQ6WIBocYNWcqZYLNQdxXbxjT7DTr5Vl5/ARvjYBsODvlWA+5yGHTXm1hza/?=
 =?us-ascii?Q?CGfx9qihLa5559fgPMOG3uVDZjhRpogUN+JMfy2DVRC+VndTAu5YN59UqHG3?=
 =?us-ascii?Q?7BSbmYdDcIbYXStgwoBVsSUSC0sOsfuAW/mbsdtLOp2k2/70WwQN8ocnQonT?=
 =?us-ascii?Q?cSS+CaQRRBEnOEH+D84Oh1kqLzZKF2r9fIDKSYgUTF5/vlRzuZ8VeLW4GjRd?=
 =?us-ascii?Q?n4cKCR5rv8egVYDmFwTimuob+/QNFSQ0BIeliV1McR6qL+qRCzwQKr227Ba8?=
 =?us-ascii?Q?NS7msIINE8BG4DFYnSZlXdtudjUsQ7UpfIejakYDDT1XmfpbvJURn80ZaApk?=
 =?us-ascii?Q?RG+DHn7zw1wGcK1A3hFMZ3U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fni9+eWD6xAwhaqgRB8Yzt7zHlwgNyh27X1Rg28bb5lq1fuLxlw3IVSYMP1J?=
 =?us-ascii?Q?XH6ZbHbP0b0mlVklCAgNSA3GMksg+WPaiocgrhc8D1vNGUTkgteT4Z92qO1B?=
 =?us-ascii?Q?AlesbbKh6ssFYjthp8fMAqTtx9tKVKZOmIz+c7V0rQ+PIq0g+T6+548DXNwI?=
 =?us-ascii?Q?qk5V4fg46wdiXUFnLNePBodj6hyYGXjDGOQnIXKShf+7A/i73PL7IrzO4E+G?=
 =?us-ascii?Q?tBTFuTOKNovSNTUuFMd7b7QzAa2a5+5NMiueFR3a7wdMmUnhusHKp+ledYPZ?=
 =?us-ascii?Q?bw0zy3uAo38AtLG3mUNV9opjeO/uPczRHiqqAMO41sAgrzFsFpaTi+GFiC5F?=
 =?us-ascii?Q?V8/Zta+O7FoLflUOsj9QhLM6jYhSh8xtPqPzv5OdSwZxa+nFkpxU1OrH6kGg?=
 =?us-ascii?Q?Y0H0KyPI/zUA8zeOKFpRwm3HwD/XQyd//ca1+e3Npx5c0ArUAMMUw6S+yA4U?=
 =?us-ascii?Q?/ZQbUj+fI19gfIULKC77eD8Zj37eVRXxfRFm6GfgkxFsGJaKkMw+5LHu6bvB?=
 =?us-ascii?Q?oE6RE5l6thOkqE0iYg1yj0VXk+9nCbgR7uNkW/d4uJOxEtdfciqNa7Na3d/Q?=
 =?us-ascii?Q?xmXN8/3CFwPlNrIXXQ6z28qgqXKOdL9wKs2t8LBzR4EW/BqWE7mW3YPb4vua?=
 =?us-ascii?Q?k17TZp1wMYxGneLSywjDgEqL8scTTEGmOkyhRc6gD8m7WnoksMxHWnLKCoOi?=
 =?us-ascii?Q?+P+/SWFZhUeRO7gVxsLTgBkvksys7g1uDLfbdSOsV4RjaO0PhSiUIk6PQiZy?=
 =?us-ascii?Q?1PeQc3TFzZxVtg5QcC+J/kQP8t/Y09ns///ImS3/4XeyVu7v2CxjHIdxvxVQ?=
 =?us-ascii?Q?qHLgI9gm1UxolkhVVDRHiHv2xG1wbPbzW7S1wIOQPJgLpuZYT0vZs15YzQ/R?=
 =?us-ascii?Q?cZiOrbNlwOyoomCc5hJS0fdkmqEmbz2uoLVzN4OcO/z6T6iuj6GkYkurpxO1?=
 =?us-ascii?Q?AfB1WR/Jk1jrGF1QWQDhJMZff8VY1uNbGNllQFD7I0jn6T1j1nMzG1VBt1+t?=
 =?us-ascii?Q?WKuNJiX/GN4TmvMUFBdUKxYR3lwaS/lxhM11usnQ93xf3LnN0ISGBT3UqoXW?=
 =?us-ascii?Q?8WEl/l7NmFAO2xwmfgruCpIRQ/xBAeJBqm9heoCdGY/7Y36a8ETAuMStr08l?=
 =?us-ascii?Q?UoQDGGR6WZ1jILYAGVgxWk/VNh63e8vNOXe6zzx5nWFsz10rF54S46wt3TN7?=
 =?us-ascii?Q?BLTFD9obXBBAQIHjPHZEt2tEwdeu985e22N14z2X7w/4ZznrLNyg5XbSfr8Y?=
 =?us-ascii?Q?WjD/FUUqaqA4fsybZv1ms7wgyNQas7iQobjC84a6V+jDTEyYED6HurNxmQ/f?=
 =?us-ascii?Q?M4QRqdsZ3aeWVOPR3DMt6EXTy8w0cd0sTQOpN6IxMQy5YrA7s/Xrr6v0FfyF?=
 =?us-ascii?Q?eEv1Elt30RuGzypONRXV1G8L0x9loE+im45fSTF5Kiy5hahiK9DoiH8a+uBn?=
 =?us-ascii?Q?NfyRslTW4j9WkiD9RpVO6M32Q+lBePHeTU2IcofscE+LJNk72l83apkteB0M?=
 =?us-ascii?Q?aKcoNBGaf5mzK1DmDqt//1lVhMVS/NWDt3s2Zsuxil7U1H3/GQd186iLQBBj?=
 =?us-ascii?Q?tSh3xIeBUIQFT33piQiF7eINL1wTDjsSbWrTgWE32Ai3UwMmPV3Q4AoOJ3pa?=
 =?us-ascii?Q?pnhxnhY7ydAE6RgXwJZDR/qudOdGmc8UT/9VRaCRR5DrDHdj74lp3unGt/9s?=
 =?us-ascii?Q?a8GPMQuoFdXXjOJ8/As40fq6MgtnW541442nOvQgFs9cE/w4h/kDOs6rl8Yy?=
 =?us-ascii?Q?cXshIeUz/1XXkS/n8nNApeQ326NF0Mw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7b0168-d279-4685-3937-08de57aac1a8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:33:24.0240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCyhiCZd8/NwX/NoqvMycOEc+n505XbknaiHmo4Kii1qp1Z/mlsio2y980M5NfA+iHMerNoNCyvqNoWBGLULYyRj85zCpAxuU1KcLZIqzIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8242
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

mtdpart internally enumerate partitions starting from zero, but partition
driver API enumerate partitions starting from 1, so wrong partition will
be queried. This is wrong.

Unnecessary debug message also was removed.

Fixes: c29a6daec184 ("disk: support MTD partitions")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/mtdpart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 842d3e7274e..f3b7f1ee13c 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -1061,13 +1061,13 @@ EXPORT_SYMBOL_GPL(mtd_get_device_size);
 static struct mtd_info *mtd_get_partition_by_index(struct mtd_info *mtd, int index)
 {
 	struct mtd_info *part;
-	int i = 0;
+	int i = 1;
 
+	/* partition indexes starts from 1 */
 	list_for_each_entry(part, &mtd->partitions, node)
 		if (i++ == index)
 			return part;
 
-	debug("Partition with idx=%d not found on MTD device %s\n", index, mtd->name);
 	return NULL;
 }
 
@@ -1084,7 +1084,8 @@ static int __maybe_unused part_get_info_mtd(struct blk_desc *dev_desc, int part_
 
 	part = mtd_get_partition_by_index(master, part_idx);
 	if (!part) {
-		debug("Failed to find partition with idx=%d\n", part_idx);
+		debug("Failed to find partition with idx=%d on MTD device %s\n",
+		      part_idx, master->name);
 		return -EINVAL;
 	}
 
-- 
2.51.0

