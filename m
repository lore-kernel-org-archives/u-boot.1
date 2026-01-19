Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB07D2ECF6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 22:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98866839D5;
	Mon, 19 Jan 2026 23:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="r4XeVpRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260CE839E8; Mon, 19 Jan 2026 23:33:20 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3538389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 23:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm6fgfmV2nIq2f/S97DMdlCE9guZLQv5bqwzJo0j/Xay6us71s3UmbD44hyeQd783lWNIjdKy++NXHC7hJTSQBkmiEUZ0TY5HxhxdyVgID8xuIRvgST9Ab1oOfhQXL0Mq+jWqJstbVCQqcNpkGODkl4m3eoGRIxqxJ2+8yWS9rdZBZvMbJ6m4m2DHm9ozqG2CqMaVdKRR/o4b7q9VLBGVRwqPvDETCmzo2cx+fzuGT0xvedoYz1RSdpagQKDa6ieHA/6FRYWSN2k4Q269CXqd8+sntmlm0eKBs7uxx4KfHWzv/asUxxJ3QpunQmnbetlwkXfFizBNpHGuOEKqxoHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KVTjvPLvjmTklr/cccv6Sa7hAps4NHVHJa4goCuZm8=;
 b=ZNTYtOsL6KbeVFNgdbI3op7uYiFJstzO8LZ3Fxt9KyVDC5ZTLnwFgBsKChgBIEDY5f3qZttA6Wh6WEskGfG5oWzt+hNmIWakBDQue0PzQqicCL+cktE0OeNCfGmaprENwz5jR+a7bvtrJRLKtdUScdvfsEBn6mCblHgWnAXaxyll8JnLUglO69AJKjP+ShSTFnjsOPEzudtULoyPD3hRwHg1K0KfP8NEjRgxx3iM+8aj597IECsc5OdqayE32h3yVS/b4bRENtymjEI73sfY2IV3q9G4vWx0xg7qL+NYZb/N244HcbnY4We+ZSoA5As3wluG/GtWLFchPoC/H48t5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KVTjvPLvjmTklr/cccv6Sa7hAps4NHVHJa4goCuZm8=;
 b=r4XeVpRYpBIZU59Hcp77rOllnfr4n8pqezL+r/d6LTJZNZ3XQQREhFC8iD1kZMsHJGxIjBLM04dfd6dXYxTV/H5XIuF7JdPdm85cXYq3yOhmo4ZF6DXXiQ8hCXDQR5kDJen5QcTSPdIAQ8PidxPrSTKjviKK3JvK4EXDjz66hJBzaQyc1z2ACPPuPbWUUvYfa/2LS1Z64plVtCsVw7MxrR4mxGgBRmaqaQ24TR/FeeeqLzNcny8yEIdFjAg7r6CySIBfSvxUKg116va3Sy8RVVYvYEXsNSJHGDovwbOCqpDXLr+Uaw+GmIrGc9SrWQRaCq6yBjx2Pdq4sQIlU7FlXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by AS4PR08MB8242.eurprd08.prod.outlook.com
 (2603:10a6:20b:51e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:33:15 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 22:33:15 +0000
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
Subject: [PATCH v3 0/3] part: fix partition searching
Date: Tue, 20 Jan 2026 01:33:02 +0300
Message-ID: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|AS4PR08MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: c2aeb66b-1fe1-4f95-d25f-08de57aabc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zbdty2dMtp0QpuFam/OFxi3wrd5H2HLN6SFonVKjZu1BSCiFm6BQ7UeiGQIF?=
 =?us-ascii?Q?s5ZISfLscyT92anO492BYDHOoWaA2mZctY0/KL7zYEFu2pNxFNjTq1l0OjHV?=
 =?us-ascii?Q?6rLYS6RyZuT1WkPWCN7TqT2b4mWTjjK2xQxT7UzDlltrUY4jmMsTA0Ayx6Xq?=
 =?us-ascii?Q?bANV6yC/KFs8p+c8KRklboeJ1jI6q4ELc2dlJoZyZTN6Utd6nsc+M5kZH5W8?=
 =?us-ascii?Q?cLlYkC/gnfif7+SbxsVKF0w9HA9nQ5JfcniN8yigjjQAwbKSkefg9/BDQvU2?=
 =?us-ascii?Q?ZEUkSt2PnV6cKFkJRGT0BRR8anSALZRhmuPbl+WM8mRodtnvNqKSeyrXSiJc?=
 =?us-ascii?Q?nUC7ifoUkn41Km+b7e0Q/1041zhSAZ2iHck6womVw/fydtpr3AlW+ccSXr4v?=
 =?us-ascii?Q?mfTfEbG1vja4ACodxWKscjsQ1H5u1pvlRthvuz9L9ktSUqJZmwg/IVFBzCXP?=
 =?us-ascii?Q?Ef/6Edg6kO0BAfsga4vEXBEgkEFpFEZ8rgWO3f9Nery3jgY6qc4n/2x3UtzQ?=
 =?us-ascii?Q?qmjIy5t/0yGQhaGW8wtV+dQUmy8BSqTBd9iT82c26aeRXh5/8VV+689qkIXk?=
 =?us-ascii?Q?N0ZKYK1KqrcHF8fHVzb8XN4icDaA/55raZaYGzPhPki1oZB0oFPAzQF1kUHb?=
 =?us-ascii?Q?aCy/YWA1VfhXN0EqldlWT46/2TQigkPQfy7CA7HzqKcTtKXmke1Yt4Gn/HW+?=
 =?us-ascii?Q?YCL5Mx5gvFXjhOSe2PZUqXZi1F1xArwT2hGDX+A5jiTlH8D7oyAVQ9j1LR2y?=
 =?us-ascii?Q?2/tsnAkkbkUFoVUToFk1W3UdohLbazOYa/nYHMuIIDj+NBKjlm14En6J6Unb?=
 =?us-ascii?Q?rZov5qmAKAexAQGGLYyrMGEVHrYelyklxa7B1WCEBh9Z5kGuhYxqvV6XaaZ1?=
 =?us-ascii?Q?V8yR/TQ/YMom+PMsEsCcDUZXf5E5rxsrzT3DaR6p6PRi/n8hAKOO/y5g3DVs?=
 =?us-ascii?Q?4MyIe0dOyjXdfoeo7p4mbJ6+Vt7naGs2U7mztOwWbPgA/cz5WpXlHMbjJCc8?=
 =?us-ascii?Q?cSVSIZ4BR1FPZne+vYi9sIWYYHesDXlzkVUX12MrO6qzGIxYtg2p9xuZQN2u?=
 =?us-ascii?Q?zeNrm/UApyFs5AzcZDNw2vXFxFg8qtAhcAuCR6fARiJfhs/27MXhgRnlXYVW?=
 =?us-ascii?Q?odTsHEPYSVn5PRQ+6kjpMiVqlIKNgkkw2XFwXnRpoRaTYJ45kRmYXw02iOJn?=
 =?us-ascii?Q?G9zHaKSRf8Q6VSmmVrn7dGuEt8J5WAIqJp8/6SV+eo7naxBkKHdq/wnG+GQs?=
 =?us-ascii?Q?Ov7kKDA1LMJboFpiRpGGT3erSYD2KbnfgUTf0DnJOUMGV7LzW37CzzzS+xdN?=
 =?us-ascii?Q?ppNDOfusQSh1DXc1mtKTNSU6OrBk0Fs1dLcz/2rDhShpUCjIhbsJMRGQBqlM?=
 =?us-ascii?Q?nrdzCtwV+KaHo+qMgF+L8mzIq918a+hR4S+Vx+3/7+W6OQXnVD8+wvbJkR7M?=
 =?us-ascii?Q?yY8gPhF7Yp7dRw+u79PmnOb8IMDvAwSEyW2oLpjZCxk9H29v88Opj7LuEwu6?=
 =?us-ascii?Q?p3U7G/FOD46RMicwbEcPhStkcHChsZ6AqxHZiKASNU2xQOFUDAQKR+y1DEe/?=
 =?us-ascii?Q?vPV/bAMPb9FdEqhS8siMC8DUh1lvYPVzvETbRtDma+lZUdzbwAYtkEJkJXKo?=
 =?us-ascii?Q?lLNotzNtS/zz33WsTlEUK2XeR7P9ThuZMEFZxrRUho2K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1zur9YSNwAmanOzsAqpSxjBj5IoKDpveF1pJlWfWGG6LmKVuoFva/+hTyR5z?=
 =?us-ascii?Q?Gk81oADsS7VqHKp27ZCaGRxgXxFteHTrp392GvAkNsg5+LFnbyVlaakKsT8D?=
 =?us-ascii?Q?d6a7O3VxGtLSyroyatEzpcBfb7SgLzGysW6DC047YrTBI6VnSaMabAjEEgQr?=
 =?us-ascii?Q?pxzwOhiz7fox92JdxIwxj/SZzih5LJNyedS8BCD5moYI3ooogZ36gzHhzvCs?=
 =?us-ascii?Q?5/YQUYDTNEBnPibpJTwtrlD4hB5TXzcknvKdjAE/09QvOc4doq9eDO21e8uR?=
 =?us-ascii?Q?TsY3KfVDtyf0CAdVKcveJANedqvW3wWWayDbgpMEOnpb7fJtpcq0j19vCUHD?=
 =?us-ascii?Q?amyqB77ilm5kwjS1WY9PUDgPbhOUUA1PJYPL5zMP9KU6jhPr2KHYSYgb6ibm?=
 =?us-ascii?Q?pXPGal83WWgwX1pKVe3jTYMfAeeInCRVQ8XjYA/fTmZeQjZNQe70ZU01Q3Uc?=
 =?us-ascii?Q?GR6rowkqKVJ+doUB9/e1Hbb9985JHjZrnYnQF65Z9j2D3aytfaQnbaP+Sisb?=
 =?us-ascii?Q?5q0wPp1+n4vYGLyprUC9Ty3wTGTNB98qjGW48gA0C2QugeNSsYPwN48s80BZ?=
 =?us-ascii?Q?hFmYC9oLNlv8CjWtrbKT23gLilMm0fgvdto3XVZgCb1Hklq7fZHkPDT91yd2?=
 =?us-ascii?Q?M4yD3J/qZFzdpx9DXylRjzHW+VcfI2NLJqiZT+HgPGbhtowggRN7RNaPoJyq?=
 =?us-ascii?Q?2Ew4EdLCiI1f7BfwaBaSqr8xtofla4HbcgCV/EehrtGVjE7s8gGNlvCtDLIP?=
 =?us-ascii?Q?Uj/3Orr1TUZelzrLefTbfHb8fNu8mPfmJFK9HCY9S3qIB3xrwK+CLcBRBk43?=
 =?us-ascii?Q?nHrv+R7PKlacjB5Rsx14P8ac0yBTc+3CdNuTMnJzsaJ52JlSVYdiij3++401?=
 =?us-ascii?Q?6p+BsIaxRx/estvnsCr1WRBShxA+N758fgBgntPhic17aSxXcGZfwZUflO1j?=
 =?us-ascii?Q?yHVQ20M3efufN6DYvWEcRZKk9ETW68vTw+v67vcK41nVnia9pCuxL1eKfkRU?=
 =?us-ascii?Q?JSoOXtBDb1jwZsu2W+N3bDt0wHCxkA5BotZLWYYha9mWu7ygXgcHaSNVOAJh?=
 =?us-ascii?Q?qsARTvcGUKxivuBeD505oi2LOjnUFw1R9Mltzshoaryoh4qZNSfJ0Nm6Z5qE?=
 =?us-ascii?Q?vMud3Frv/N9cX/AvId98+fSuog1uQ0lxQd+I2V8nG+QXhe47BDjBVWVLHve5?=
 =?us-ascii?Q?PhZU96F5HNThTSQKAIE2RYpjY2YlfkdBf1gRp+J1kv9Hx4r7MGVxWLz6zeqm?=
 =?us-ascii?Q?1YYzgZhqEpvh/i70xIc2bgOYONIizREwvK9kZ9xCQxGY2OBLwbvC3xGgOTyQ?=
 =?us-ascii?Q?YwQjFP7tu0Cx3Wy3fxGtHg1s5yjz4EQHI/5lBfHDPV4g2D606bb8OTx+M/TL?=
 =?us-ascii?Q?Y5p7I/ClsWyaMmsRkWs9wDr2tpxGcf3u3HMIzFUdLJ8pD9Z5/wV3Q1LCatph?=
 =?us-ascii?Q?I12bR1dw9eQjtHquc38/GmpNEVuoU3+4cACvsc3UVCqQ3Al1/SGqv382PX8K?=
 =?us-ascii?Q?Ymqm3jsFvzvlxXHr29ID31Au8KvmrwJhA3uCFvgKF+vrCpL0+J2TZu6wREX/?=
 =?us-ascii?Q?ngoN4gUkCmpwb0L25yBf0bDS1sEuPtxn8ulPWDQYrP7bn20JX/tSLbv8p+DH?=
 =?us-ascii?Q?cfLZIsepfhMlIptN/fP4+u1KIhaSNiFL2AE2BWZnwCobff9uXz54K9tDsFdb?=
 =?us-ascii?Q?MA1CqUgStalL23fH6WpQljx40rnHMAbWeSrnMF0lZ28MUKIN0ImF/BF3fnBP?=
 =?us-ascii?Q?gTyHJUywsGqEXk1b34HwfrR3oWLLkl4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2aeb66b-1fe1-4f95-d25f-08de57aabc9c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:33:15.5899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT0VJDTYNSi0cDSiu5Ml9zeK9n7gcspiMVo3EY1RB0h7MO7Ed5O4YP/kHOZZR8rBsxzpvE5gjfwN+2DbuHEsAuZbqxd8iSa1xDRzIZ78x9Q=
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

It was noted that a GPT partition with the maximum available partition
number (ex: /dev/mmcblk128) can't be read/write from U-Boot using
read/write commands. Futher investigation shows that the problem is
deeper.

This set of patches fixes uncovered issues.

Changes v1:
 * fix partition searching inside read/write commands

Changes v2:
 * fix partition searching inside gpt command (thanks to Quentin Schulz)
 * fix mtdpart partition numbering

Changes v3:
 * slightly improve covber letter
 * internal enumeration of mtd partitions match to partition driver api.
 * 1-st and 2-nd patch was acked by Quentin Schulz

Mikhail Kshevetskiy (3):
  disk: part: fix partition search boundaries
  cmd: gpt: fix partition search boundaries
  mtd: mtdpart: fix partitions searching

 cmd/gpt.c             | 4 ++--
 disk/part.c           | 4 ++--
 drivers/mtd/mtdpart.c | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.51.0

