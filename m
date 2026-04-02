Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4B2CC6B03
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 07:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D9D684020;
	Thu,  2 Apr 2026 09:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC6EE80212; Thu,  2 Apr 2026 09:00:56 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E13783D8A
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 09:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZKHod6Z1RJfio55WmGjlxbeghp2zlu5aDoPygI7cnN8sRthJQik8Mfd+2hiHomMYlQiXxuaq2NofUkuXeR7JgSy2uXDuZiJuvYCTwJtWXGtjxVlBbJHg0e/2RgwPdoY37xpnGfnKiNzy/zdDUT5Bq5IZ7prh2d0b46jz8xC5p7KbsA5D7wm0ObeXfNO29dJ0Hucq734MC2+6e4NhzhQ7dkUFJ2vT/7xtegKDdM/KGg54b08RfNGzvrFR8/HZWPRya5A2aU/XshG9dCBKC6IRrLfSbBADmnoJF5tp+7YssrQgBaSE7mdr79UH27zNPi6SsGLMGnHDczQjo2RGJl4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nafnvmS5tH+PwK38sAvreMVZO4zcOSxwX89wV0TBmM=;
 b=eYPsqmWFa+hQpZHF8eoAMx2ZoMxQEEgu7cDwupSnQ9FfYyVImX+zy2gfwax2gsdUqipTF3+4HNNwvSh8tfzPic6T4TT2eeSEUNwP92aQf2YdzhK/ati3xUPGUxulLPNwYLzm7FDCkr5pozrqXEoD9gFLyq0HNMdG1aS+Umn/Tgg0X9SGKEG6rnBMfBhwJ9DhFfQafB/T0t0t8KHIdEaD2YRxXOIH5+8rXJCJAzyB04MKOVXRxqHun+kb1qhUh0IkSwQEz3MS0SJ01236YaHcIr47mN/0qeN5aC7B9vvUdZcGoYuavoO9Qvdz8xwfEtIo/1LCNd5N5C0zTufupYKxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 07:00:48 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9769.018; Thu, 2 Apr 2026 07:00:48 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Add support for StarFive VisionFive 2 Lite eMMC board
Date: Thu,  2 Apr 2026 15:00:39 +0800
Message-ID: <20260402070041.2418-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1276:EE_
X-MS-Office365-Filtering-Correlation-Id: daf6d2c0-570e-4fdc-0a8b-08de90859187
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: lGHHHU4jr5iF5umb+vfCEnmQlxiFKXY3QsV+8KbgxX7jXKkDT1U2uYOBNdFExviNrC/FJ6hTtGpu9SRwU2zVjPKVZkdyOzoL336nF8fSlEboWuq3VfeRO8JrKfUMKJJyJNkJ/Yhnq0In5iyPE9l5cAxxW4K8rnEfydzw6M6sQfyRf7EjHdnCep5BOmm11t2PjP60GEV52toDHZrUl011PQ1UtR+jxpwKtDRnMfwmqojQMYl2LofKDcM1fiNV4VEHLbC5GKIr4/48A/x9daYDGFrYe6RDdsBRSHDesYFOgtExYrU7SgX74fN1/Tp0oXfrOfAwQ1T+E+lK9gLVxA/HIQO+MX5+V4l50mdnEzAiHxe3ES95iZsck7MacUhzHlt/6rGCJa0Xjups+B5YIP8TbBcJRaRRiHFzy1K67ErIYMnqSNz/UFfD73PWfWUDPb1KQe6aUcCg2kACkNA9h920xayuyt+4SPPO7pdhXJorPZNbBI/JXqnquBJ+KA1KpVlHJuTCiOF9I6CFKMV6CT2slg2sW3OArTPyOJP/gAhRvjiR2IeK93fMpiZLRQO28x7OLaFKaLJDbvbUSpslRchx9jayoR0fcVdTebhr7DEptDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKkynFzNv2M6+W7pYoW3BhlSFVVz7WFhZ4639VsBEVuuro9HDSFe/Gr/4w1V?=
 =?us-ascii?Q?/AbNyAtqqzr8yB+g90634pGPV8M8Y00bczub/mjo/xkTFp3e7XL76fgzllOl?=
 =?us-ascii?Q?Pzet9oAskO2pA4NdDqs8C0imJco8O98yV8Ik1Y4NVc8k61H9iENoEatxTfa2?=
 =?us-ascii?Q?gbyjcOqdKv0DTC6fkf3iLZfvlRiT0UeSQw4PVFjwiy5qcEgRu9xGnNRYouWx?=
 =?us-ascii?Q?4EWxmv5eA9Ewe/p/pN2CQvUZ6/eUIX4nAXy0B4USxvxRsfVPcEgjXkGI1h6D?=
 =?us-ascii?Q?csLk58fvUkf3BHSxr/pfutqd0VWrCyvA2yIl4ESSJZnKCFGjo2eo/HUx9jcq?=
 =?us-ascii?Q?+h7eYxdy2hmZpjNFbUvSVuGzA+kki25eck9SYhbeOXYrrgqrbMk92ktkE8gx?=
 =?us-ascii?Q?mL+i8PHzi+CPXMxXdbIXacerKoIxuHJuijqxf0LOAE4k3e4tqBHd5AyeTg1m?=
 =?us-ascii?Q?bgCA9H8h8vjphqu52RT5p0qFRnPn6MQtdizcHVfMZxzi673npNJl+q4NKhLx?=
 =?us-ascii?Q?Fd3EVNIF5DkmSoxvrHoi3Rg14BiOcVsBsNLkTWVTeIeGflG0KrVcADEs0ttf?=
 =?us-ascii?Q?Ln3ieJQiSWhVLKNJRN5mKGikauDgQwAD9Z/31gYHaHj/q7Oo4VWpo77idOHh?=
 =?us-ascii?Q?7ch2ghw7jdhZj1tgbkj4FEd9w27dAJf8gNsqBISTbZNBTNLONeGyWGEPUEj0?=
 =?us-ascii?Q?O/8XZTSSlG1OYuPVz6sF8xzcHbqc3cUFsXRyMfXKgWaQqKQSrkMgVeuH+LFE?=
 =?us-ascii?Q?/bT/PRFy6vB5J0VAHrGt2s1HWx7XG+KUnoGADG8fvD0fbYssuSWAuPcUM+F2?=
 =?us-ascii?Q?psnX40tbNvsPJK3OnlVQ7+1pdmoWmzD65uPGoDL7vfFr2IMj2Ot59sW7CVcU?=
 =?us-ascii?Q?GbJ03olDxzloTe+v4c5paKakZuw2o7ONS6yfnf+aQ6K1QCj+R30xqmoOdBTZ?=
 =?us-ascii?Q?ZibSgHAIAZt7MQxMwD62PhN887M8X7ZBAZ7XJKTMTRpwzgFnMrPQZ3qiiz5T?=
 =?us-ascii?Q?bzXtpv1LS56uie0zXYms4CYaoRFxlyvVD0e1CU/3WgZlIipQAWtsBLRpO5sg?=
 =?us-ascii?Q?XQgTcUvL/zaVqj2/d5VHg0PC+WeMIKQupdn4amZbm88TJ/buboz3b1ycDgvp?=
 =?us-ascii?Q?wO+2/WhzUy3A/bEjH0FyaFbOsULxQSI/RdK0W1/8UvxILRpYNz3FdwBei9Qj?=
 =?us-ascii?Q?bNJDU7Vj4LKEETQBbtezpL+N3qy8oeIWf7hczadappOXXcZwgZ3jsH4eRr6v?=
 =?us-ascii?Q?5u3vUftk8ywbvIQ9uBvxxFFR584DdK67Hd3FKUzOr0nkn2TRtiSZMTTke2Jn?=
 =?us-ascii?Q?h5zhUQEpwqyTYGJySf7iREg3dDmHV2ukLuPFZLKam90UtWcXH0HCHFU8ON9Q?=
 =?us-ascii?Q?X4cpHVKbmRKilMQ2k5wp+EGnaVemES9MGaNVXYG8+DlsJlEXkNGd2fPsfBzo?=
 =?us-ascii?Q?WSDClXbVmyg+ffU704bNKQFwoSG9APpKRSnpvJZt2mtHFUks7OQZfpUHH6ip?=
 =?us-ascii?Q?BqTwPz4yHLnkQ6brh+DOgcJJOedPv98dx9cucc+9QDvwtT2RRLBR489u+HTF?=
 =?us-ascii?Q?nWjT2wntB+IUJvyTrarE0hxJlAoWZ2A5xqhcPSKU8JNJxXTTs9j+rxwj91i9?=
 =?us-ascii?Q?c84m1nhKehIuXCriQZydvxX8+xhMaQvRnRD3na+YuDc6YpBx3ZzoeUV1VpMR?=
 =?us-ascii?Q?/ZAoYIcy+qU2KOD+ZFHlyqL6xQPIx+mnfZFZDXjXjRrcxrrn1oBtUJaQbpa4?=
 =?us-ascii?Q?UFdChqnTpXa6iDywn7wJ4xtF2w361+s=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf6d2c0-570e-4fdc-0a8b-08de90859187
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:00:48.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4haKsTlU/Pc/x2Guf9AVlkSAWxEiLW7CRQt5EXtAHJ31Cfkn6KPdHy28Rph03TdNrlkEWEjgyVC5GiN6Dc/pyX2wM5b+ATIWqmBaXtGw5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
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

VisionFive 2 Lite eMMC board uses the eMMC as storage component instead
of the MicroSD card in VisionFive 2 Lite board. The device tree of
VisionFive 2 Lite eMMC board is already upstream in Linux, so add support
in u-boot also.

Hal Feng (2):
  configs: visionfive2: Add VisionFive 2 Lite eMMC DT to OF_LIST
  board: starfive: visionfive2: Support VisionFive 2 Lite eMMC

 board/starfive/visionfive2/spl.c                  | 7 ++++++-
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 configs/starfive_visionfive2_defconfig            | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)


base-commit: 98cf83d81617f489d7ff7bf78d33e693e2799254
-- 
2.43.2

