Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF46BE95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 12:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29B18695F;
	Sun,  8 Oct 2023 14:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TjVbWUI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8CD68695F; Sun,  8 Oct 2023 14:47:44 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1D686590
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 14:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjnzwwTQqqmK4fCQ7f4jSeMGDcmtcA0ojy6BdJt7IiWi5YRjQL4Ln63K8IL0TC+mWv5ljWsruklSh7wCJnZWyOiHd/1uS3wA4jI02uMNxnU1Z5JZE0Oj11pRz5QORCBZ4PR002xDGDs0V3tQ4Gsaa0fO8YrWN+4a3Zb3b9ERI9REenHyJ8xHCGY8QfLPmBD00fV7hDjngSTcDVpAkDYT06YZmWL3O7TwVd3HWyLszFsNZihoEfEaq1u2lhgMP13LfCSuN/86qTCpmvsf6F8QdmQtZCojuPfI9bEXhlp/BJl1ItoKz+YCrx2ceJjk5qqpydvAM9mYwCCyLbkZAqjEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmNlMlqTiB8VlQxrNy70Nis2FsTUVPT2im9QOZtnwDY=;
 b=iAJ1lT6P+einqZsA0tc5xsTiPGx1RYfyPbdx0tsYVeoWU9U9p9981uPCf7ut5hn8hheuithZGwWu3b1S1r1gA1U3C0FW8QfAKvFo6rnmSKqIArbp6MFCUJMa+m+47aHI7+fWbmb4Ar/5CHORUypCxJSUEM1J3ycX4zSEmUqEDwm0tL010d6gCwGPkxE3LblRTDN4yCcdJteuI1DkdUmlfNqU52K9InuW3eoQVLmi6zqiKXU6KWBJcD3bGh4+AEkSpcsVjGUTVeQNgv//gbYRRAlwVXXC7TImATpCH+Dj66AFS6CNpL+7lAcWYA4nG1GHsKY2LnWi6D+yaDs8jtIvfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmNlMlqTiB8VlQxrNy70Nis2FsTUVPT2im9QOZtnwDY=;
 b=TjVbWUI0TN/C6PCXny5gNnOO2Lq1rqfmNPWA/pYXt6GvnP1QmsBFnWidT2b56jmkmtGaCO32MZTDLpnmQBZj7vPnfPtXrJ/9AuTruySAOgmpKJMYAOrf00EgTCUI0HgyHGW6eDrmzIm0zCAnHTEeKwIWY4jeDz9eaHZdzvcSmns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB7651.eurprd04.prod.outlook.com (2603:10a6:20b:280::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 12:47:38 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%5]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 12:47:38 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de, sjg@chromium.org, kabel@kernel.org,
 Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/3] mvebu: clearfog: add support for emmc boot
Date: Sun,  8 Oct 2023 14:46:18 +0200
Message-Id: <20231008124621.18803-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM9PR04MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4f2184-b650-4d9c-85a1-08dbc7fcc0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcK+POFAwi39WvMDp7YDbm9X4q9tidWPzeNdo96QVgv9RxzwlULJwGOXVqMOi+eKCE7kXCaQ7z6wqd7Q+YrSz3YZXmcnVxAL+/Qr03NQXjikvinRRih6w9WesmnwOhpIyqz3+KzSAn3ljyNaM6ooq/XKU3+hF+WLGJCXomes1VHnbjAkqlxtYJl0TJSCrsMjXsy8ddAAWE0pu+tWPCXTm2DXNK0JisQ0MNnSgSk/jZB0seTTFHqko6uMPPFfeWMC3UXcwVvtEISPCL/A5cAewUBjseDdAs1bIDYQB5XUqLt8hpK6zXy4mLoacKVDaNrz5thhgPS/v3i5EXzJsHkjD1glz74O0O3xS/W309Rg572UNzYodsN1PJmRhka3ENZqsc0GxBEa5/ndk6XaYxvYvDCAz2u6B6bJ/z7ODS/RCSgvJY9c0f9Hj5Qyiey2khbPXdRUM2xOELkIJRj8r5j7kq5s1W81jqRiS758poagKKnk021hKLiYi68M6Fqp7E07Me0HiaPzbI+2C8Uj7U1c+satkRoyexTUnXVdpm8718r78i/ExSrBX8Ysc+fxUFIWutKS1N0oKnWH10MG5txf8DGxXM5HzDuK2HTG0x8xUA8hPsRTeFH5bFtXVUaEgAuW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(1076003)(107886003)(2616005)(26005)(66946007)(66476007)(66556008)(316002)(6916009)(8936002)(5660300002)(8676002)(4326008)(41300700001)(6506007)(52116002)(6666004)(6512007)(2906002)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYzjCPTtY0iTPVeW5vu8GrZrM0Ex9YktM/xOi3eJykWsarw93UQg9Z43sO/z?=
 =?us-ascii?Q?5MxhFNKozabAKIi/B4k6rhCB0LPYfVKH4FIkBquicdUWegU164AF5vjJmCBz?=
 =?us-ascii?Q?HBpenhv0q//+pgrrXkybW3SxH4qcrAoJiEZGRvEp1uV+oKb9FuhvXXxDUZvg?=
 =?us-ascii?Q?DduIi8mFXAVHnEXLE5AOzNoQkZzZmkxrUnDfwVIZExXr0NXM4XTGfpkwV1m0?=
 =?us-ascii?Q?rgqyeZv5GF7iq/gcFWCjc/NKAoMYB2si5XlXgCicIbn5azgrdYsB9bqzAmqb?=
 =?us-ascii?Q?Bhmip2gkmD5aYVtgajG40+vWcezrdtg/7EhKFy8kIAzmhvC0huhthF2m0M2g?=
 =?us-ascii?Q?10W5FEx1K2NKzpMv23g263d6borNMyayNiU77K8qmJqqWiIGbsmoavdG2U+q?=
 =?us-ascii?Q?aJInyxFQlraNSXDMiv0U1qIQAjfEF0wAILHDO94e4EYugo4HZUNaIOTB4Mtd?=
 =?us-ascii?Q?DMQ5eihzKzM37j5QzZFkHWMWdFR4UiNFn49iQhlFS/B4npwGLWUOOwemu2em?=
 =?us-ascii?Q?+dHFXWgWg98oZ2rPhrGPHxwWkjaQqCgcgxBTmliXmrIE6gok5ovz5G7KRw9Y?=
 =?us-ascii?Q?YDZQsjztGr8EHqQ6cTI+N4UB/Ac5HQZQ5phhQYX9BGj/Bqad84K278VI0BLp?=
 =?us-ascii?Q?agUdSUrvJ9inbf4HioV0DV+yWCGtbpHKih0PfenWnDv4eIPcVJaoHEOtkbVT?=
 =?us-ascii?Q?Dh3pTUJyi4GltXz3uNpZ5+ds7uDgu0xko1zjZ0todOOUc2eC4sd6SziZELqU?=
 =?us-ascii?Q?RPpm+Ug+1hzI0JJe3jiKAvPo4iHM+g0VXeNXsZijRERSxIDUklAayItysKiv?=
 =?us-ascii?Q?mt6ClgoMWcTpJk77anwn3IKvc8Jit743lh+QBhYptjD9cLLUOekZo28e+XQB?=
 =?us-ascii?Q?LYcA5X0KzogUcNKa+mpuS2AXUi5bfeWGLGKB6bm80ZZ3OvsPn45Ss58jaST6?=
 =?us-ascii?Q?NQV/PCCLn/C/4m1m03Ma6qipq2KaVwCbh9swdKpFfDB6TZYNd61QIpSnPP8U?=
 =?us-ascii?Q?bR1ze51W8wvU5/pI1UgbcaEA3Aqie8GD7+tx/Di9126WgAFUnZ+VkAaMmwk3?=
 =?us-ascii?Q?YblXuxUzDlreFmnvvjZxGLUejfSA5oKNOo4pspKWJUS7oOWmElJ6/+2gg1CR?=
 =?us-ascii?Q?0hQ5L54nJSh/uFkP4tFI1cMaBj86XTNT0oO1NCXpwX4RQaiAsB1KEPGEsxOv?=
 =?us-ascii?Q?HcncNiU9fLXYwoo0KTQNHqvPDFkkp/IJeCgxz84jHICrxWW5lXx6wTtASCVI?=
 =?us-ascii?Q?ikyvRXk/anG28HxPySZSgS/Uqcqr27gL74hGkyZTy4rA9q8ZKhngJNJZtbV3?=
 =?us-ascii?Q?v+UZM8Md/eYgnXLRtKTQeGXRm4cAlMT1GUfDVn16l6C/Ut001/kycVVPcvpi?=
 =?us-ascii?Q?XxDg9W6H7XWsPNe6P6HLP8LNNKk4fJc9zVzXwdUdfpwDvlUkX4ztBRo4dONj?=
 =?us-ascii?Q?zPfWLcPB19hdjtWGPk1YYxKgQmiUBTrv8vAbpmGq6IUr/oUIKUsx7opLx0HH?=
 =?us-ascii?Q?hW1VsFWtF09BqDAe4KY2srnRoFl2RBb4uD9nMN/rBuCUIR/MEuWvf1HTxKCp?=
 =?us-ascii?Q?7liYVG5J5vmpHyu00afcNq/n2RGJSz9WEaypl6+G?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4f2184-b650-4d9c-85a1-08dbc7fcc0e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 12:47:38.6588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxslAYFd66w2t4ZnCYEPxd7ePY9MwGYKNDVJKuc0aZ+U24+YRo9oadtUgW4s7ZgxLOHLLBtlaGPCBJZJPah4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7651
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

On Armada 388 booting from eMMC is different to SD-Card in two major ways:

- Environment location
- Sectors scanned by Boot-ROM

This patchset first makes it possible to select offset 4096 for
eMMC partition. Here U-Boot can be placed to avoid conflict
conflict with MBR.

Secondly the bubt command is updated to use LBA-4096 for eMMC data
partition only, keeping previous values for SD and boot0/1 unchanged

Finally 3 new defconfigs are added - one for each bootable eMMC partition,
selecting correct offset, and environment partition.

Josua Mayer (3):
  arm: mvebu: allow additional 4096 offset for bootable mmc image
  cmd: mvebu/bubt: move eMMC data-partition uboot from LBA-0 to 4096
  arm: mvebu: clearfog: Add defconfigs for eMMC booting

 arch/arm/mach-mvebu/spl.c            |  5 +-
 cmd/mvebu/bubt.c                     |  9 ++-
 configs/clearfog_emmcboot0_defconfig | 82 ++++++++++++++++++++++++++++
 configs/clearfog_emmcboot1_defconfig | 82 ++++++++++++++++++++++++++++
 configs/clearfog_emmcdata_defconfig  | 82 ++++++++++++++++++++++++++++
 5 files changed, 256 insertions(+), 4 deletions(-)
 create mode 100644 configs/clearfog_emmcboot0_defconfig
 create mode 100644 configs/clearfog_emmcboot1_defconfig
 create mode 100644 configs/clearfog_emmcdata_defconfig

-- 
2.35.3

