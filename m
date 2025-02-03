Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832D4C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F038801FD;
	Mon,  3 Feb 2025 14:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="n5q8fEVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8395800CF; Mon,  3 Feb 2025 11:41:48 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA2080087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUufuHjNMmuSNfz3MaKVczt4G8JdrNqNdQBGbiFqDZPExVm60KSN7zaauJdV3UvDNAnAAw7gx7efTVQvuIeL/oPQAFS30l11GYy0aCX+U8Gebb1Xzyowj0WJOhsPDUFEZGI9sUNVYHvqi+RC1PiFhAl+jMFGMlXBnHtkXu1qFauGO2wkmJANk5yKrLgYswhw/VtIFnqjwkg+9qg6caYNGkg3DouhKxQqDTV8qi4ObJ5QVJ8S6hUodjxHfc59fE6U5VzgAQOb/+pcMrvTESrI0QQFyWI/FawDTSwwtrBBong2Qi6mV+C3xHytG6/klO1IX+pCncRSj94nUFKbYqZclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlRB1o7Irz3oe7h+WM9mki3/fHBO+jLcQGsmtF+tSWA=;
 b=tc9Qp0iRvZDInVbTkjIraSAa+X6pawsP9bR1efC8iPIoZD/e/YrTmyNSokmzWZgX8dWUdphsTY8V1O603oP6gC8HhSABzFGLqRxbPKQg6xeeW5Mtn0FD7ARKkmViqWVHy6fEeO6ywa9v10g/yg5RZTJ3FZuHf6V358BkpFsn6pNCo49l/Z6wvPI1giuoMoO+q2vzbdw24ibs51FuhrD2kwfDKLZ5PaIH4UYmzm8eLrEF6FMNs0FF2hbVy8DEWvsXSJkvKKrmLmo12AYCS6d1KiuSH8x0kQYT4AXw1ytSVfAsQRQ5geZcrGUXxx/9pEFKxh24F1O0Afreh96M46Jzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlRB1o7Irz3oe7h+WM9mki3/fHBO+jLcQGsmtF+tSWA=;
 b=n5q8fEVtWJ//TeVonlFMEyWkpfFBsTZKJdQQ6dOOSrkQMm+I+5GdOK2s1MU1uzSVZ2isbJuf8ATXcPFuQ4xe8W4jMgXrPCqoe8EgBOT4VuiRB9tT9iu8clnb4uWTKO7QENvws//bEd6jaS5Z/6NGYnEEpgBTcv+5KMV/uk1PTCa2lhG89hQKVkU/ax7FEm5ervO3haKgDUjhb/FLsTBNzmtGtEBdVjQrmSAkcNqKQEAd2QFpbDBB2A8MsSliiv3t1hdygmGChsKGqvC4eB56rxYLlJsXgTergMaae8PEsR87zlE9OnplQRimGmiyqOgRVlsTc9Z5GaiMHRwx4c/nxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by AS2PR03MB9394.eurprd03.prod.outlook.com (2603:10a6:20b:59e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 10:41:44 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 10:41:43 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: Manuel.Traut@mt.com, burak@gerz.io, Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/4] FAT file renaming
Date: Mon,  3 Feb 2025 10:24:47 +0000
Message-ID: <20250203102501.35750-1-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|AS2PR03MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b0277e-3a93-4f5a-35d0-08dd443f59c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/CIi3l7GIq/GKBCaJisStpYchWsnM2ggqlb2aygp7teBTZH833ou3d+h+fPz?=
 =?us-ascii?Q?vYMImsClQBfABtgYPpBy5abTV5T6igYtlb9qOsR1hR5ufnUVi2sKA7pBz30K?=
 =?us-ascii?Q?EjHzbhEP6ktyic8xldAqketz52J/ab9E0/zgaylA/YBMOK0MgR35k8qsF0Tq?=
 =?us-ascii?Q?d22vFGj3nri7KFre5NKzCseZMZFM7Qaiqux7l0Esf/8m68XagxIstbFh9Yj3?=
 =?us-ascii?Q?tcpH42qD+3D8fO4fTf9zMmLBcZMhudIt3HB8L+Ypvgu7a+ddE29g7pbUgilj?=
 =?us-ascii?Q?Gl5YOJ3C7zq040YtXQEOVquFjkwHeX8I7QeJUbU3BNx8YN12WT5lAbp3aYNg?=
 =?us-ascii?Q?rIK/21QfYwpWc7m+O5Cz0Iz78DDk6lS+319a2Ckq8H3cikAm2JcxCdtQJwdk?=
 =?us-ascii?Q?ABgh+DOJhcz2aQqLdSJUAf1pbPnJMBOQO/UZbjy5+VILxTSYCX9+v8rz+erK?=
 =?us-ascii?Q?CoTnTG2U+ZZPkUZEyrxXMzmiy/GUSZVx+2764ikYXQOeMuM1FsOJIOYTtp3i?=
 =?us-ascii?Q?XvfD13VK5o87KKI4mvmBxdkKvlP5JJm8Ou9nC7KOSHI90/9k90mkHrOxveUP?=
 =?us-ascii?Q?76VgI+fGstWl2zLL3+/qvO+xgLv1zBtpmVT+zH4Yi3/WoepaD8Fm8Cz412qH?=
 =?us-ascii?Q?4KPYpIRTXoysUBHED/gNLxVuwlrvQKMouJCrS39T/s6GLKJUZFQWPJUkcfmP?=
 =?us-ascii?Q?yz6cLX0PmkZAbfC3yNHh8sD6cwzjaRvRpjXXtF16KEQ3OmVX1a0SHAiJ4W5o?=
 =?us-ascii?Q?aJtYcoe18aDUZm/6f120PfLTO5qh5w4H7s8uohNUTnMUzbF1+4mGeot0qt0P?=
 =?us-ascii?Q?ApKZ+JQaSKzC9o7Lb7b2jF8GfvEGv47f+W46YzL4W1gujR5/B9ye7t/yajc3?=
 =?us-ascii?Q?CZudVDVYZnyrdcJrytdDDc8BEA+LNGgsSYvv8xwjcR4W18frmYp5msfYGfyg?=
 =?us-ascii?Q?wrONBX6ok+JkJAqtR3T7G3klSqp/HEWfg16wZQGSUKCXRw6ul/6vGpLhPWgF?=
 =?us-ascii?Q?mjHWJL779xKxA1UeVCLOAf6FDKybi0FURjHPQkCZHrueE11OtaCDeEF3x33z?=
 =?us-ascii?Q?xIgKxuQj7pd8I1CJlsqFLn7G71uzVQXkhRXoPRnN/F9AILEtqQQ8wZAOs/vR?=
 =?us-ascii?Q?XJLecyZGk9lUtBvWr1dJZPmBAdiL2yKxNq58777PWpXD8F7MtylL6jG4heNE?=
 =?us-ascii?Q?JRVynykFX/6i2ZpgxIUZV4flGQRFWlTotNWoD/PBBWIbQTD3R8kjF37X8BeT?=
 =?us-ascii?Q?ZBAlXFd01FGbs7sPd8W38ejG0vkl3nbJ4guOKaThIdt2oVcGOe5uC/HSgJuN?=
 =?us-ascii?Q?oMTvElMGP1aiBb0Knx7LO1zOsIekLs+h5LqLeax3VzImOXe29eQXbD7kFCkP?=
 =?us-ascii?Q?lKyV5NzaGUD9nlzb+kW3BlT3ulVLv8OUP1Tn4m92+68Tv7hPRSqO3ATO282T?=
 =?us-ascii?Q?BjNKG0ybit4oBWzi4QrNon88tZK7HUUE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VP/xwzIGyo7eZ92LXXOsnF5xJPaxAmP9TuGjyMxkunqXg0hEIpQ/mOB8NWV3?=
 =?us-ascii?Q?oBez6tdAHB9hmyaMrkUBynz2CZBPPOl3wX7qfM6uktXu0JvpW+BAVEyijo4H?=
 =?us-ascii?Q?GDUZfmFsDiDoij2PumZeioTYwZlBLsb+4Y/UP71NUGp7Nmq3S3PVqR2ofCMy?=
 =?us-ascii?Q?5x9AE2cv4NujPc4/PtUzBw29o955zDTETs0UYiGrkEupMgw7i1xdUT/pGCWR?=
 =?us-ascii?Q?+j03I65JLDvOZv4vkRYQac4/pN2dpomWmWVy5ud0tj/fhlHF+LZRumQX4TvY?=
 =?us-ascii?Q?F852P7BCwvzziiaDK6zY4nAu0gVpC/fROXJCo2iEN+pDblNE4Ij0/KGO3GU0?=
 =?us-ascii?Q?N6+v/iqTqecR7L1z+RdBNFv65gHuAQb8nhbBt407W1WCxzHf50gx4vSTg/bZ?=
 =?us-ascii?Q?+TKZgSSbs8yEvCS5vcE8en7kq24dZoyVVzoDTmaGmQ5ybc595+a5sh277h79?=
 =?us-ascii?Q?p878lzimjHzuLnALCSXyWdnZHfLBceNBimDra3Kb1pa6YZOZz6m3vXH9ztNB?=
 =?us-ascii?Q?0mG+gv/80F8yWqQ3tXQjwqIWWSyx4MZlTLHY8gN2KyiJrgn6qcdA0R4m9QI6?=
 =?us-ascii?Q?LjdKXMxDErouKgYhjf+xyIdBVqqu4FhHwgJbopejJMjbC9DMtageE8A20ovV?=
 =?us-ascii?Q?BquO/wy+/hX8ZrIlDA9L+GsdvjVyS9uKWJXv2DkdZG2R8qHUGQeUrYj9ihMV?=
 =?us-ascii?Q?C3n1GLgnQ2BUezjcOYe9d01J4LxVzTUmccElmjLIjcNsWz3N8FSX6NopXUGH?=
 =?us-ascii?Q?rvqXz06YLO86FS2rak+IaTMbz75jjXWL0mvV3c32v4ncjhNK+z1QaDPJitu2?=
 =?us-ascii?Q?5BufvSoFOsOKnkGc2D1XV8JZymUtEF5vXMS1UU3PkNXfRlxp0vNwtR44ma2/?=
 =?us-ascii?Q?BnWGK3LFzmVF2TIQnFazEhZF8+jgn5rBTkoLvaSsqCtsf54nYZ05GBmMasAF?=
 =?us-ascii?Q?ZCV841UGcbEwEoXb/dVwpfIszwkn4JCF8yY9re1YsGas4saykBVdhFlDfnXN?=
 =?us-ascii?Q?q0QD18LE8DeoMjOK0k/Drg0nIVxp5dpazB/SeLec/98CQjGlhIiF+gqimWUJ?=
 =?us-ascii?Q?lHdLAlOUIT9FbiYxm8jCjBUcOa6yPnx1M1EyljpbX0EgyCq2Iy1gGkM9p7bK?=
 =?us-ascii?Q?MiWb/puUj7wP0tkrTYr5vUoJ60W5Rqw6Ef9luT6iOc9QlGGoJMxBP9q4lHoD?=
 =?us-ascii?Q?etDoUwMau04EbwBC6cHMdwpT4ITxQBgglMKnfwJMtUfXF2YaxLL02PJo4g9r?=
 =?us-ascii?Q?sTPd4lHNr3j1O+HpCzeVnbRBrWsBypNps5KUhKiEi3OBJH6BQ25qUdBa9ido?=
 =?us-ascii?Q?DIaFhsVTalFhvybglhAiYcyRwaDjVcaZqU8hNZ8XdK34zjCO4L+NjP0VSt6t?=
 =?us-ascii?Q?kzdKXkfrl4yzeFEQJUIFnOwlkwZFR/KA7z7hr/3MGC4ZtE/uiTXOKO7our9h?=
 =?us-ascii?Q?guNLsI94tZv/xlBtleirHerwo5a5cAYdz74i5aw2lyexDnLtVHTJ1So/PItI?=
 =?us-ascii?Q?My1F8vHtPHSidOvp2oUr1mMHBosuNn5o0OGZSQpArLBw7Jx6795uS5jl5II8?=
 =?us-ascii?Q?+H3lR+oC2eTODQ+KAxsPZuq/nLygJeWH9Tsx3QHj?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0277e-3a93-4f5a-35d0-08dd443f59c3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 10:41:43.7615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhNV5VGRB9XS1yM6AuSwPBEMS9G5z3UAXt80pvqbsj4plx73VmId3RM6A7jKz2R6kp/TSNsMvd955XB4g5fPIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9394
X-Mailman-Approved-At: Mon, 03 Feb 2025 14:10:19 +0100
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


Rework of v1 posted by Burak Gerz [1].

[1] https://lore.kernel.org/u-boot/20241212221427.GM1505244@bill-the-cat/

Changes in v2:
- Adapt variable names for better consistency
- Add missing rename hooks
- Use EFI_ACCESS_DENIED for unsuccessful renames
- Avoid using of "== 0"
- Move the call to set_blk_dev earlier in the sequence
- Refactor delete_dentry_long for improved reusability
- Separate the rename implementation from changes in the filesystem layer
- Eliminate code duplication with delete_dentry_long(..)
- Ensure that the source file exists, but not the destination file
- Free the fatbuf if it has been reinitialized with fat_itr_root
- Delete orphaned FAT entry after copying file metadata

Daniel Venzin (4):
  fs: Add unimplemented rename hook to FS layer
  efi_loader: Support for file renaming
  fs: fat: Refactor delete_dentry_long interface
  fs: fat: Support basic file rename

 fs/fat/fat_write.c        | 134 +++++++++++++++++++++++++++++++++++---
 fs/fs.c                   |  30 +++++++++
 include/fat.h             |   1 +
 include/fs.h              |   9 +++
 lib/efi_loader/efi_file.c |  11 +++-
 5 files changed, 174 insertions(+), 11 deletions(-)

-- 
2.47.2

