Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568D3E6BF3B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7782584589;
	Fri, 30 Jan 2026 23:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hN4Xttwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE61584595; Fri, 30 Jan 2026 23:06:55 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0559184584
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgqRIHm6ip1wRHdvmLsYkYotp6sRZL2OBP2wWzg82AhkpCLWz9HQF4g/bB7/y0PNNUxynhhopf8iCrTEM+tKOAIgl09ChH8QiKOBJFKtwZ3fiXQ65nlabUYuOuBnNoX0Nety/y3jjM7V5syioK6H65DhCMdfxN8kUbocmVq0uHBs8YIyPstPTi5eC2THNpSxwGu/FblO0TI5USfH+tojYcnnsReHvnCrshOTaAVBi6l/LRcRgJD+HEPXuDH5HnFB9tbe3WV7NRbTJCXF6ywi0qNXOX2u0vO+IlRElqJzrFA7nlkXyyZe8RHYzY/9WJl3sTladvicCr99KY9R4YH+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUE56mNHQp+115mA61ued0z0v13I2YzBUw7UYHCIA/s=;
 b=u8us3WJbKS0DQD8Blia+UPpXvWlahjuKjfEJ5orYfptKAFKWhHl3CL6hok/hp6PyDM98935ifBudtHtLu7MYPI6AeDtS2Ub0ani7rdoUw3TDzKBi3pzpgWlQIWr1/oSWMpd8EY0vRxK5onve2KhdBZGQuZQ+uzK/xC2VULPZreuZlOj2yJYK5yoenEWf7DQeeDHcPkV7LVzGqYmH/o2efolnO5voGsSrF6cYa0xNmQYRuwfsAWbust9Hb1eWo7v1twHeLPnuBvu64llAXyTzZUPTSMmtHQU+BmmrarPbYtJxEcqhaxLmDuSkTW/7my59hA5K35hPUBWb9axOCmiJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUE56mNHQp+115mA61ued0z0v13I2YzBUw7UYHCIA/s=;
 b=hN4XttwqVb3PJ3VcN3Oqf2SwTPI61LilwRJ3vHv5JMzJ4b4sxbNf3HKI4B1xWIAL1z0QXO83hUl/NjmatlLK05W46pSowIz5ibKFOyEziV/SQoe0q9u+mJBzg/8RY1mTv7SEFp0Lon85mLBjJ426z/1rqbBVNz2qX+V+CUiQ5+rKzMhX/1IbY5agQc9BGDWqUu3WHIvLZyfTot+c/XBaoaCxJwf+IXPSO0qMyZKMFnTJHScXBdw3OLFj5QkwsiGeXf+KaFvvewkosIFxz29ADzsXVPrbe97ZbHwYDHytJVN/8cGXhpxXdGUzyahYoOUmppWJ0NKzpXCMvjJ52IQDyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:06:52 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:06:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Robert Marko <robert.marko@sartura.hr>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 4/7] configs: an7581: add mii/mdio support
Date: Sat, 31 Jan 2026 01:06:26 +0300
Message-ID: <20260130220629.4040550-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dbb465-129f-4d4f-e2ba-08de604bdf85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9iifDKkrzn6OJrCd7EADuNK7qQcsnt4c8CFK00ayUgA150e1iPWgcwAf9wF7?=
 =?us-ascii?Q?bPilcJPowEtV43oXwt8RpCIQHrguxJ+8IqTAd8NaifKY3RneFPrpd2x3qHBJ?=
 =?us-ascii?Q?F2iZPg5+jORz6btJ9/ZY4kIFTeets2KgG6MMJCluImoYfK7DSSAcC5pDIw/k?=
 =?us-ascii?Q?M+PDhtWugRyE/08F+MPBjbYeISjUnNH/5hJc2X1TfweExcKI1jyVn30x9Z8u?=
 =?us-ascii?Q?vyQCB81iX1LRpizADSmqnNyViXwACbE4OruSsvdBl7uPC4aMky7sv8fyfbX/?=
 =?us-ascii?Q?ChgetHGH47u18em03geP1NQ94SvDegfG7iNIYFVQc3Ww9Irrtp9kDy9Oua6D?=
 =?us-ascii?Q?+0iAG7xH86Aul8ueCQYMmqmuArdpnam8wNo8y2t6DX1S3r0jP7mJS6l8Ak8q?=
 =?us-ascii?Q?ZddYFIjmpz6JD935097Rw+wpX2IcLO/OouwFLmJ/7GlkaejaOSf4CYwuQ+6L?=
 =?us-ascii?Q?9tVgPtYJXQffWEhps3K4xzLvtA/XWVTug1tUn4+/Yc+Ztfb6SSrJ4G7IrA8Z?=
 =?us-ascii?Q?vknUBk/fDA2Aje0ziHQjggQ5NMjl6MzIQwbXQjpVrX5utlXWkDWcci5cXHH7?=
 =?us-ascii?Q?8ai9gz0utbzhJcVeQyubnG5tU6nuB00FI9Zw9+AtxmsUAudO7OB4jMGMMYg1?=
 =?us-ascii?Q?sRaoYe5aaBth/FIs+Psqkb9H/VOr7nnIq3KQm+OCbW0HNJ6TmeXKioRwa0B8?=
 =?us-ascii?Q?mg4p3yvf2mI+4PnOuMTZKDmNQc+BWYS1VAsYqBdeXdCY+wPlCQfSG69bvhog?=
 =?us-ascii?Q?rmDD3CFLw9/EhzNfx4UDoHRKgtjJlhIv2symxXsz8MEG1N+p2oOzzvzVQTTS?=
 =?us-ascii?Q?wKvit48ulBgavutkncM5cYdG3Ezb/KkmMvd/QN48Jk5lNeXZUGXn7H//lHsp?=
 =?us-ascii?Q?OALJWyWpOJuVCvKUhIR7ezRuqe7qx35tPkx7jQ8gYQDG1/14oqSsLzYdEFoB?=
 =?us-ascii?Q?WUHl274vKB6E1BIyOarbmI1nkI8B9Msk3BQAb6VQMgPmaMlQ0LXJ62El3UqF?=
 =?us-ascii?Q?rw0cQaTjRzKUfqOFTXvkc4mp9HM546E0AWCGI+7GGBw8N/zTMpeyUiBT3v81?=
 =?us-ascii?Q?RIwN9R1/ytjyKeQ1pbU/m0oo5d2NeRz1jxQR1ljqTfDgMEGlLSeaAA+0esyW?=
 =?us-ascii?Q?Tt5cCizTtDS5R4U+hyJS/IkaeCPYAJpT4Os72HJHtebfmuX38H5SUuLSYMgj?=
 =?us-ascii?Q?w0Vs4bU9BrFKG0gtAOFYK8eqMcDAUN9646ozgvPtb7SrmvTAuqFj5OCLC25j?=
 =?us-ascii?Q?j8aKw/NhWJk6kbQV/jFrM9wlq5CfvlNlMRuCz+gd8yd9Ze3i6kPu34RJI9Y9?=
 =?us-ascii?Q?ECpHbDAlpCffReAPqRC4v9ZiQDX4Odl1YRX72afzCkJqeDupN1kerD6/rhaH?=
 =?us-ascii?Q?3WwydxQhJApmxN6gPfI5Qz57/a3WonUdjchUA2YbxGGeylLcqQl/EJoZ1Xo3?=
 =?us-ascii?Q?XixcwWIrnTp1/pBltTfye8eezdju8OGDfWp24fa/n3gdyYV+nEYGkpZN65rD?=
 =?us-ascii?Q?M24xMy2w8Kp8orM8LRbogpWjEsWWLb72ODZwTUpCFV35xLxVt1WzzwbZODF0?=
 =?us-ascii?Q?Iu680UlQWaiwimt3m2KkiJcM55yAONGGT10pxlCztuKCcMIraEQ4MFe/7q89?=
 =?us-ascii?Q?fgFc7SNlRRHOWfrvMgQr2vghQFjhjw26pty1cZmTBCRr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HGH3IFg1pBLdUAw1UifUCvUotdlyGrmf/g/KrNBGa2LxpPRb6tt2v63UPDnY?=
 =?us-ascii?Q?rcMhwjrCG3Tr4x1ayYcnJ47xR4SugBE/6Rhw4XHWHM0EUBqrpSbe77Pw8O8L?=
 =?us-ascii?Q?mBYLe0g+ATpaJJqdnWEF9auMMF9p/N9TujubMxU90fCR4hP8krj5AsFTiD17?=
 =?us-ascii?Q?Aqor0HEWMlzCICY3eNKGCYktfwek+q+z4RTA/YzKBs9atEF/hELcZYsCprJE?=
 =?us-ascii?Q?wwWhv9l3NtkRnRgUaGCTrtWHt4c/1s+7MhNVc0m4OMyUDSTwUltXttVuT9jf?=
 =?us-ascii?Q?q+RDbifedGaMnhuNONMvxkaIpCKCL6b3xngx/rb47k3lVCu1LMkux9at5aLD?=
 =?us-ascii?Q?uoi//Tj9KGo0V7RAoFXzXd31Ub/Q8pLfpFBPFQsRIjmIo82CedMYiFQd2Ml6?=
 =?us-ascii?Q?q7+wW4F71WZQxt/3YSLMYx3AKeoJnESXYm0qdVcAPYjVim3E1CdFUXh/QzDX?=
 =?us-ascii?Q?BvWG1ExtVZ2la+Wym9svZq5Wh2JvGbefT0Todh7LZxGPNhp9gWwdkxi00cpv?=
 =?us-ascii?Q?wdZHtSDCLvy7yCWIDDiUq0rVdGCkTbio7nxvhhacpdrAniWtS3KO8K0UDxoC?=
 =?us-ascii?Q?VmSwq4hxax8M9hJx3rzSkZjCdK0WfXRf5HwYtTdNgqgCvbC+P92ysW6MlTCx?=
 =?us-ascii?Q?+ZaV4Sdp7LRlz55LJzeGZpyflwmTWJO8GRumCjNOfJKMwLKGyew+xOJBVppY?=
 =?us-ascii?Q?jjgZhEtU2xeDNA2AIFJzH7l+E/TTp+wyiZm87YcWXGk8Bao/zafh9df/cQYG?=
 =?us-ascii?Q?pIxUtGYPhGTE5TB9DcfoWQ1jEBh6g85sAHCBlh9tjv+HLTIr9lghWsRqr8KP?=
 =?us-ascii?Q?lAcynhM9cm3EBEmCzb/4ASS3A7kTiRkU5bZcckMNg5xrzsg/Q8K+BYYDS+UY?=
 =?us-ascii?Q?KN6OOcp5Bg2SZBGC4iickvvlAaMs5/bm+5wXeVh/yFzGbeAfDbG85x8B8gxa?=
 =?us-ascii?Q?McLrmukjOMsar1WA9jZisYNvM+62lxgLM8+WnKVpekVXCp3HP4nkpjFMcYut?=
 =?us-ascii?Q?xY2wSEJ/8PTl+oJHvuzbQSPZG9GzQBmGGzBJ7rAh82gr0I9PO/nWbEsLm29N?=
 =?us-ascii?Q?cxdBEJLJ4YMrP1Adkzrv3EPOu0HzrhYlKIx6W0R80MXJwmPD3pIOgc3/vRsr?=
 =?us-ascii?Q?Tvv2cYZkU4yNeJgNnu0llUo8ZoePqp6yjIbAj1J6SJSTVVCg5PpM6deo6OmE?=
 =?us-ascii?Q?Zpb0HXnIX7ggIvz4vOiFjhyl47J1AD4QtczJvPrD7HnpjINXlFTj9HBX5Cpt?=
 =?us-ascii?Q?ztMYryHIUopKRjFoXgqBSkNn/znjCNS2VHN16nPvSK025uG4qikvyU66D5oo?=
 =?us-ascii?Q?ICpjfDwSeqWYAPAqgzQc1NdO1sjLbipaP2GeocJZRUsg7df4dtiKw9NhAmKz?=
 =?us-ascii?Q?i3FXDTYm4nnrVVM2BxI4qSVwl00V5ObYLZwCccj3ToG8Lfcg4Zbb932rmU4m?=
 =?us-ascii?Q?jUmCVvsYqN5YCzwznyAqu7LIsGVHcndJun4TXzULKBdXSnKwz6rh/re3RSKE?=
 =?us-ascii?Q?gDyepJnzqvD7Yc1ArfDWiVhoyZRcIR6o3ccvEMK8jgpXYPwjaOVhzaqjm+GY?=
 =?us-ascii?Q?fjx4cwy9S3K2a3nbO/jwnJrqUjpzvjG6lyOcgy9i++NSxv7lrtUPibr2wqE4?=
 =?us-ascii?Q?YOb+NoG8Edf2v3VaSD7Q9DeZI0DGJQv41bh7nJ8cx5j0B736vXmlV6w3LKcK?=
 =?us-ascii?Q?TB8gpaJfjGJoGwUwOB2/7ytVCYvOXjUu15Ut7qnkmdV5K4q2KkLkKAy06qz6?=
 =?us-ascii?Q?yKhXaqX7ZwNZxtOy62jx3/CroiBjc3o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dbb465-129f-4d4f-e2ba-08de604bdf85
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:06:52.4474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmeZxKA2GJl71pzKpsrJza29yJKG5mRzlfvnvDQYd+ADp+Ad/+jF8LAWR00wV4e5L6/vJY8JJSeSzcDNOol2RG4keXqJNUtv57ky2ow7HLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10697
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

This enables mdio/mii command support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 73af30cd693..8e2c694dbbb 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -66,6 +66,9 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_AIROHA_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MDIO=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-- 
2.51.0

