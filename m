Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAADCF318A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 23:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A5188B0B;
	Wed,  2 Oct 2024 01:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="C/MKY9DR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77BA188ED1; Wed,  2 Oct 2024 01:00:24 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2635788975
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 01:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6mKZhwuG7fDjKlfRQOtlIoyK1as7mU1u0APqVRLW1jcHYb+wG5SIrYbuhBeDIybqUOTQrE/Zk1dbQu0osHhBPz5j13POVq03yvuKcKnj8UiiPQarHtjdAnnQ7URqPs9oI22dyHJX4gYsUgH3YwFr2uJ2sWt6Ab57uzv1vqc0HiP3tqCRoAc8QQk2HvSz0/nnua9Xu3vexFxXyJn2N530Eqq/KPzqmLyrfc2xwDGRHUP4co0MIwqQzRQ3Nbf+1cBHtHT5mAqNq+3FSHPvj9bB2dtkCtXh07GdqFPaaFipuSwZd8MiP5TK56rnQ02JimeJ98JeG4KZuWRWSnhNMM4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07mCmW3pxv+eJx9z7RcpfGiJJuaWliz2O7TKMN8BJu8=;
 b=c6+azjBoQ3isAK4s+C42J+mpA4l9QE5bshO4BfkWJ9mCYJj0DIGbMrPL+QNZ9RfsBg4lusTvTQk7njndcmK1QvOFrUCtERcY96XxFIFMK9fPR4T6UWf2hdwVIpIramnkZAtJwl1cszamnCat86kpVUcHwAiqvIXY7YvYkkFSZx19YFMvHlHpeZemYpe9o5vxclu9hq4O9hAr68AovZPPkMckYe7zeNYoFNaur+meZDQwDIfCJDp+RR2j8YcMo8gEhE69G3TKlRgE/tvaniMSSYWjBYfZAhiRk+ejIDfxVoqVQKLJuIfO6Z//CPmguJYdR55F8cNfjeu+d9fTHhuk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07mCmW3pxv+eJx9z7RcpfGiJJuaWliz2O7TKMN8BJu8=;
 b=C/MKY9DRCJOFd2OZXFZ3O0TX2PHOwAvT+WQzG2+d8rXABsYSwQtLGKQlkMvJ68lkFWAQJUIx8wl8pivXRgIgjZY+CvID18OW4GxNnYMk33+4jis8+Z81zcN6XzTp3G7IQw/MQsS9ud5svHCKo5pYsc2WltoBeKejFLcA9txLCZmwLE9bweV95kgUEvj/OBym2gsNhxibIfoAinoySCFMEVcVXKTVkAobCBvKA2bfsaFW+eA0rCGuWzG9mCM/RDw7Fjtcjvoh/H6j1aR4/qNLcElP5M2GAX06aO0mcnYkHD5QCSuK5HS5CBpb8WxhkRUDSGE1oudh9++an7SPZ/Kqhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6271.eurprd08.prod.outlook.com (2603:10a6:102:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 23:00:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 23:00:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v3 0/3] cmd/mtd: add missed featuries
Date: Wed,  2 Oct 2024 02:00:08 +0300
Message-ID: <20241001230011.954429-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BBE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: dc63928f-6773-45e4-f1ce-08dce26cd1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+r/MYTFyPyAocGfu1uUa4oYmuOdyO4ZXhlWBsE7kjmvA9qeTRt5Zu7fYSYv4?=
 =?us-ascii?Q?EDeVpvQ60hm5FlGhXdVxrVBZakyWuHcaH87FA2N0AkVMfTwYvFW35RQ1wHTs?=
 =?us-ascii?Q?7FLLRsfNE+fFTK4al/N4KgFMveeVJS4L1w6eQDH7NofI/DxnUpsWXy+QjqUa?=
 =?us-ascii?Q?1IZ8BVK+bVTyP3Pop+V3RvhrKzQai2Tt90GjFMF8Jh0j7gos3MHj4aOSOH3U?=
 =?us-ascii?Q?JFHjBJk5TugQEV2PM9ti+Pmx1DnHBV9hJZkmXlcb/u//UZZt/U0kmLAHExqa?=
 =?us-ascii?Q?LHjS/EGbD88EAyeqzqqj86+4c6awx0ObFlgEZMsv8BggX5Sl6djRAW729VSx?=
 =?us-ascii?Q?GojHjZCL3WAuVhz1xv1gg3wzavamdoz3EDQ3EU+KYFhBfNyGwhMEhsribx3S?=
 =?us-ascii?Q?DdJKNo8M2feMu1DSvgH4E5SpPtMNWU4bRHd0IquRT6QBaHXyMa9Ut1Ggxq2U?=
 =?us-ascii?Q?nwi273E1aHCCORbJFCi4dVSmO6lyZRv3liWKoeXv+j4hB5sYOM1sKbUE3N7h?=
 =?us-ascii?Q?Korl4foONdul01xLwrcYTPV5A3AjeYR8sY2QGldFVU335mP2AxROx3Opqf0/?=
 =?us-ascii?Q?fokZN1mmc0v3ZdfF+4DudrSS5IePUvouV9E9/zcoZUkdWF8Gc7KFn833tYeI?=
 =?us-ascii?Q?50ojMNDtQZPqr8fC2pjG4oDHW0NbYNvg6JSXaOkB5qLkIWi2mz4X1URoGfHc?=
 =?us-ascii?Q?NyVmdCiE3bIyFHr2mbpXWBZ74UpJBqpLfbai7+UkogmMzA6uzoDFUDIJURBd?=
 =?us-ascii?Q?gqNvKMoB70CtSZpTUI/Fi/DusZGniOEk/v/MWpEoIGQBvpmose2kiJYVt8as?=
 =?us-ascii?Q?/x4G09JfnBMOEDv7272Tv307snUNo2OhyxBtvIbiOQo3v/fqLlPlDw1KyTWZ?=
 =?us-ascii?Q?yaQmi8rYVj0fEE56cN0VPI6WQvW5EN43IB3ejlzoceyc/iwHPWsIIB7n4A3V?=
 =?us-ascii?Q?rcMc9XnPahTsKxNejDWvGIpkmLxTofjNzCTmi0nJR/n1F9kBoevsh3zd9FQL?=
 =?us-ascii?Q?FC07IWCRFViYc9grL8Cg4YDQdG7pR+djHwFYHlZ9J1xqYTDfQq5dMPWoEwPW?=
 =?us-ascii?Q?lx0WNT3j4GiRhG9Tt9b4DOmS3siqLmAXNveNnUuFmImdjxoJgq0EsarzA7ow?=
 =?us-ascii?Q?PZeWTihsGv9mvyRNhpLpzbopUaiOtcDTBIwOumk8bfJZB5aqEtbdCOj2AESx?=
 =?us-ascii?Q?j50SNlqq6Hg9vqsvpPg16jXfobvuqyXsYE6T/kk8cLIYl498J+ihymmKVj+u?=
 =?us-ascii?Q?Xx4/A9DVepzvIMywO5bZpkLRarswDUD0fwJOTvyASgnSpeaM5DTyGpIXQ4t2?=
 =?us-ascii?Q?X5EZkQuohoRrYMryYWlZTnk0BnzIEGd3pNpwCjaA3Ll0Aw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAS+qidgD8BP3OSUn/x4d+0uP9Ele5PkV3fhMg4KjFruzIPseGfzbOMYer07?=
 =?us-ascii?Q?K2GQQiTR6508IH+DsJgpWGKbTMgxab6MzVQNMxgH3fUtBJdG0MHuvop325RZ?=
 =?us-ascii?Q?yo8JRg39qI+HAPF1h0VuSrFo3tGq6Lv5gFeMSYSFlPd7riTX2PhfQMZIMD9B?=
 =?us-ascii?Q?oyHZ+FNemRa2tZAaEB75PGcnUd18xkmb8JecI1S+QA/KXlTCBr02usjgW9E1?=
 =?us-ascii?Q?LwWDrzyaJTgk/Q13+PMQwnD9WGoeN0EqRROCRn9Wdc7m09qaFiGiBcj7obrL?=
 =?us-ascii?Q?XzQZ3dZNqPddvb/5BQGEpDB43sCjQzj8w+GRD051GqOQQgHT1obBc6nFBF56?=
 =?us-ascii?Q?HL1nnG90r/DSWjpMGB2QcQWXtQpMOdPnPEl6KTaETrrjYD7AulBARwpAYMLv?=
 =?us-ascii?Q?C5sOWUVCAU+GmGLM3j6r0t4GnUGnNw+XVivlDF4sf816R9/6jUcdaHZAQNPU?=
 =?us-ascii?Q?pDIy/Rl1NqtHVeWWKNwMtxNHESxP2bIaWvPFN9Z2rbunNWRGw3Ftt/giTBFm?=
 =?us-ascii?Q?ztw7bU337lxZPnVHirGqEGRJQ4+FWTwJc7FWRRI0zoGuCArlmcijV99FC2YC?=
 =?us-ascii?Q?mULIQN54P3nujOY3gq5bAVRCi8KCaJZa3NpBh6Vjg+J7chfA+2csNIrsmlrm?=
 =?us-ascii?Q?9EY9pTrTw9pgzC1Z9+J1J2Pz4TY84BXTNW9U2IkM5WzrrFmY0IgNY2Yua3KE?=
 =?us-ascii?Q?gBotjOX8ZacdtC3gv9B+Dgpv5ai0QLzv+YnOrz5/RwxfKDikaNACXt4HfyaE?=
 =?us-ascii?Q?a5W8QGPMAaRs+c0JOXfn1TS+qC6f88eVHEHLF2gVWi6V7i3IiKCxIIqHC9yn?=
 =?us-ascii?Q?2luYaEXz0wWuEciEE5CJ/7FdZG76bhBVm+ubJQliLqzFssxMrJllWsstaR9c?=
 =?us-ascii?Q?qA7g+3rVMI67UL5EK0w/q2LZIPhR2CwTb7YEI91CIl9HJ665LbaA3rjh6L2E?=
 =?us-ascii?Q?X2cG3Ha8K8scBduyiSFWZ8TAKzFaBK4rjqXTC1C8t0IqN+vvVBvwS/3UQ2bn?=
 =?us-ascii?Q?028xz+8QJFF3OV6OinyffzY5fTLM3t5YI1gsxAxzrKgnVZ6pm12kBN9DINGM?=
 =?us-ascii?Q?WUuPxOj2hK5MaEfYW9GhRVEDjmb8AtWv7q/hWmaErSUIs8FqG30Fg7f9Otw5?=
 =?us-ascii?Q?I8Kd1HrnoO62L2nlshgfZYF5wL3DgyhYasT8KF+NKUl2knCGqZrqizvWJD39?=
 =?us-ascii?Q?84gTQF5Sn/4p6NPZR8UMcKIcYt4866pF3WzwUjqp5cFx94T9ipKYQKlqlPr1?=
 =?us-ascii?Q?UtA+Gyatx4yBbjSOIK2pZJmnJIWg0dumJUWKGLUsLAFAPABTHVlUMv2uJ09r?=
 =?us-ascii?Q?w8W6M6N+iOHgLXFK5X74TdlSlveJ2cjZYFsBcCBZFGuhSdvmRYmbXgYaPA35?=
 =?us-ascii?Q?920/avjdT7Wv9wgvqv5Hgg1ZJk09OWYwppbiU+QF1hudcIcS+WkWfvRv9TkO?=
 =?us-ascii?Q?cMW9xyS7p6jpJkPbw/SGn+QJmR4aqDJahnAfW+a4wWF2W9hF+62vnJ4Leh4P?=
 =?us-ascii?Q?DKO/nxkEJzNkJW2Zp+xFMpKBZf8lAbgm/I5I9qsZ2G7J6s2iYCPKdJDkYx2C?=
 =?us-ascii?Q?iAhNgdg2dQgynwh+bq2sDALwzhOEvPhMFkFEUwt0Cny7x9Xa/hWnxgKQUnMm?=
 =?us-ascii?Q?jT5fqckZYBrUFiHN88ZcO6Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dc63928f-6773-45e4-f1ce-08dce26cd1b2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 23:00:18.4721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQu6oiRgKX6A98DMum0SH1Am9ML2F2kOP49PeZmn9uIIW08Y5zOL3i6E7pzb4sh+VNvuS45ziwJaru2t2Kr/i4j5n9dw8nAewgDcXKPVtUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6271
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series implements following subcommands:
 * markbad         -- mark block as bad (clone of 'nand markbad')
 * nand_write_test -- destructive test of flash blocks (clone of 'nand torture')
 * nand_read_test  -- non-destructive test of nand flashes

Changes v2:
 * add cover letter

Changes v3:
 * rename 'mtd torture' to 'mtd nand_write_test'
 * rename 'mtd nandread' to 'mtd nand_read_test'
 * improve features description
 * code fixes suggested by Heinrich Schuchardt

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 448 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 486 insertions(+)

-- 
2.45.2

