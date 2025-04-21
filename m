Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6825C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4857681703;
	Mon, 21 Apr 2025 18:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dIb3MYL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D9381F0D; Mon, 21 Apr 2025 07:10:06 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B62181DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 07:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqAJiyZweEFIrqYGB/aTtkV8WZ8wY52THP/DUDVQkxUQUN0rOryL6e8IMVExhmrJZlQPnqpZsRnEq5XHs9Q1xpGlsoP1LtCJAzQ5QLV1WpEwJbN6dA/I2BMSMC5pXwvzKlBcqny+SzfL8GFUQbTWy4+kz0G9Ir7u+uUdQ48daMVTjkVKbAfFJrQjc+XExXM/HvA5uS8WHJ361HBj0/f3a/mcMlqWBi1lrXnlPSeNdlxd/EmIGbrgLdRP04eVYc4faERSmcEtqVVyCUf7C/X/9sUeQAPbqzfmYzRtcIfx2bpRolRzbKJa6JHYI7L1TTkbu/s6rawMCBK8OdQCqCLylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caPJnJY+V7yO1WgONxcsQJFz2kxi1k7JR42GSjMtWtw=;
 b=uDGSAZhw8epJT34EL4HmvilkFkggZqZOYkqkD5DwPvPa2oGD3GJXvQ3Bim0y5kSOIzneKkKMQWzP79bP97nFCLjKnrOql/NVyfi8vCY9PBwPjJEizhTPnNrk0p3w3wwTD6RxOegmcixcLXZ0wcpXz4QL362msRno+iWITebuvDIIB8fkqh+Gf0hyLpA/E/XRlMBIngF9B6s128gKh2kKU5KOFA2Aw3ZXzQ43a5esGMkIOgF8GdlzfVM1Qrt33s+q6OOgwilDNnHxNzdL33ornvfsFaWFeRPa9A66lu12tMaWFtpOFJKgYqg+Ma5WvmY2ykkseGQz70AWaA9fCFL4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caPJnJY+V7yO1WgONxcsQJFz2kxi1k7JR42GSjMtWtw=;
 b=dIb3MYL1iLsDFOt1Nh+zwtp2oYq1HVamHuzvYb31UFoxZtdYDM8lheoLfNkgTc5AmSWxwTmo6l8Y7AtrM0y+FVfgiKLrURSMFLHRQu8wP4ebIilfIQlvft6Z+RHIX1pab4AoWWi4uhV622QHKOA1xfBHwIf50vb57X/XDHxuth7+dk3GqxxoN5nABT7FYAZw/eiwDsslNz+4i++AcsAmo8aFdWJMKDGqiaeab1bwTqYLJzlRKTyFbKBdBFHCgg+8FI1F+lgLCz2qtXdyJlg9SNH0855P20tIdECuUc8z5W/VWVfC7FElidnJrMCcJu5Od8GbOyimGjGgb8c6FZ0Y9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by SA1PR03MB7099.namprd03.prod.outlook.com (2603:10b6:806:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Mon, 21 Apr
 2025 05:10:00 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:09:59 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 0/5] Agilex5 DDR Driver Enhancement
Date: Sun, 20 Apr 2025 22:09:04 -0700
Message-Id: <20250421050904.2192-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|SA1PR03MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b654046-d65d-4b4d-c069-08dd8092c3d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uF2OGxGcKHHNX/L/L4goCW8Qcz4ufMaJi56d73njEVOT38Ynua3oUeaYQLpJ?=
 =?us-ascii?Q?3dCisWYd+IqBM9WRb7u2ISOg7xO19gvgZl3Gs6jzRRd5qDgysY+3Cmfy5/X8?=
 =?us-ascii?Q?OmBi/h4lO4K82YuCp9L2yogZzXONpDg1I5VSPgIkNPBRDbm4JjMUqN6ZMBnr?=
 =?us-ascii?Q?w0Mu4qDwCCsWu2+ZlBb2cQoJm83D7LkmGxRQu5sVRft2TVr1Tebz82EabGFQ?=
 =?us-ascii?Q?vSsBlfo2OtwUYnwNtTCvw5ILuecDvLrPzsy9k9X0Kbi4ESsU2i0MEefzrrWC?=
 =?us-ascii?Q?PptAqoiUnRa8aTkdRe+GRIqOBNCntOLT/UCH+gL8T06LzX0TGsCqp0RoIxGb?=
 =?us-ascii?Q?KlTozP3VBPF4AnFRcOIhnARbYGyMoQcwq/pCsvT4GPp7l6tpFeNUq97y2sFm?=
 =?us-ascii?Q?aHLYSB3jJT8rz/ipv3B+r2ZmpfxpXLbVsw+haqqHsU4+HWFCqTgo/91d3kd0?=
 =?us-ascii?Q?Ss89I07JUomgUgTNGGryTrKw7Kiy5I0Dg4b4fxKfQCJ+wloBor4SnsO0bwKk?=
 =?us-ascii?Q?91O0C99HIjNfcIzA9KVW3vcGEMNqRLXgrJzKChGZTFWmZa1MlY9bvFfS1EqB?=
 =?us-ascii?Q?/UDLrRa4oSm5UOK78o2KRI0LU+VzDSv8EpLv8ozhtVNNY/OP9BZXWRzQDm1/?=
 =?us-ascii?Q?mv29jSsb2JB+vnOzvsgDlImUgyClvyVS7KiL6bPo78aISu6zDcHW1EC7krZm?=
 =?us-ascii?Q?YGxDccYRY5WqHDwttDwgn3R3xnE/A245lnaRP6gsd4qBluFMdDsWYXyts+Ia?=
 =?us-ascii?Q?0m7kFJ76TxuLQdOCu07gG0W66Etoz/h95W33rk1fDKfs0S9uIqmiuEaVJHWS?=
 =?us-ascii?Q?Kbsh3ho4h1FMWI8jZ5D+uZcso+JQqlKlGKWS00/KUG1jRjZYDpBTfr3NOoBQ?=
 =?us-ascii?Q?4ug8waQw0kYxKe87YzXXiZZgYvK3o/SGG0IZwmq/xqYUwLOysMNewTP5AL2M?=
 =?us-ascii?Q?Trt9buxWHLrQO6GO2Upf+zUHivPYrKTg7AyOCEU/ey7eqt+Mzn/mSzX4y5jE?=
 =?us-ascii?Q?LYmds5weGlin6O7sKk3ClBSUyKJedcfSlXsaufoxwN3WUhVTR5mk+dVfk3gI?=
 =?us-ascii?Q?iNuurDNwzuvR5u9vclBTGIqNoUWI3JJ7V0VlTfq3mcGcE3dWo2tqPS1ije5V?=
 =?us-ascii?Q?Yrtagb4mzywpqBtw1S5lDMVRyfmP4JUWkDxOZhIc+exi5Uz/5V5AXZ3fS36k?=
 =?us-ascii?Q?DyLf5N8sfvZzN2ORNzEXXCLIwlNhVMbq4Vzs9XD4mDuxJW5u+nUI0oT1iCMY?=
 =?us-ascii?Q?px0QVgQ4WIwj3N5onIUQP4Di9mXue/XHDyLm51M3DqhHnDqUfC0krm0XPMdr?=
 =?us-ascii?Q?7uPozwcXQrr1J8HOOqMWFeVtJLfYdbVaUvY+DvVsyev2vDHKlg+dZqG5iuqc?=
 =?us-ascii?Q?LPwJitInanT6m4tBm2nHTi5gx1w3iWoDZxO39bYkQU8dwRHcKs1zgLinoq/s?=
 =?us-ascii?Q?gDc+m7dp3nI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f38x2QVuiuGTCCqyFCtwhXvQkzcWTHXH7IoZ4DGJ38zXkHhz44KUAZwghAyO?=
 =?us-ascii?Q?bTKOlbPOBUVdbE9YHf5rTmFzLz50eWpxYwUHeOhfPhsswf7rtMH0/51UGtSk?=
 =?us-ascii?Q?TGjxB6isDtNkXVFi3X5jwI8VbM+lEh5hAAa64X5DFJKImP8M76t7+SH+7uwk?=
 =?us-ascii?Q?yjWK7d4A3gKmhnzw8FFwUdDtLt8pU1WM+Zi/ZKXCeZ/og3hlAzJFxgUXP0+Q?=
 =?us-ascii?Q?KIrYCdciPYykCpUTpZz/AruvgVCDvtlQp0pxK7wbhtGEA9u/NEfn8Ri4t/EM?=
 =?us-ascii?Q?t/LtB9qdwsLwzdCXuSiVqFksAWpF5zrjkp5F7IWBoSFcKmbZZnFx7d0xDDPT?=
 =?us-ascii?Q?7wzDixeq+YA/WKTIPb8XhYWlFIH2w/YUKv2JULmkxLZ0sEe5hJe9SnrYyhYM?=
 =?us-ascii?Q?00LGTrrBL7qHyrH/ZUhcniG+kIVqi2300QD2w0Qvr0kjPBqPdFjIFOPFmln1?=
 =?us-ascii?Q?BtHgpphGx+MtlLL6eo/W5rwnALD+wzzKKsU2tpUXZx7qGwjLWez4h4Sj/ppX?=
 =?us-ascii?Q?g5pXp52G6g5FxAJeCFjA7mn0neBorK0usdO8SZd43SK8jz1C0rFdkHXCis2Z?=
 =?us-ascii?Q?EBjyCExdOw/Rn7YQzSqO890M2auQOff/IbxHv3EvzErIyHfwQ4Zg7yMFZgHM?=
 =?us-ascii?Q?ou78QTYck0xGQncHxyvJuzU0fsgfmdVvw9HvUpSEOKqqO2bJzn0dtisjxXlu?=
 =?us-ascii?Q?jKIr4b5/gwrM7Ugw0JVf7LRPNybc0vwoqsDmL/NhX+Xkc94gXw09iSLpOwN6?=
 =?us-ascii?Q?GfwIk2q3np77O+YZ8zFwQNwVymLZz4Nqv3mXl1vwfvpiErBc3lsrFX+Do5MA?=
 =?us-ascii?Q?gFWI/zr7rTaS4F/UJvd8gMcgCMFItCru6WhdsShFBXL5oS0goNXz4VL7OkZp?=
 =?us-ascii?Q?uRhCQNL1U07eUcNHM6vuIufn8z4hQgBSCCVbj3aqbroEJIOjfFRZVaivXv5r?=
 =?us-ascii?Q?8/4f7xc99utj1tdw1vbp3g/aaWp2KunMp3T4R9SqL82GZTY/Ofih08hXsUBD?=
 =?us-ascii?Q?FlI03xuyhmgMTPI6E4ru/sNg1AAtjNTxGbjbr971HQ/5VXm5P9cZBwF1QtAL?=
 =?us-ascii?Q?FUmVsWXSzog3JaZBDu5Hu4Si/GAN8SFpIfhqkvB0XL0IR/fnsV3myiW6xsrR?=
 =?us-ascii?Q?wQxgF0F6yN0jmjI7w/Z45Q7A7blEnv/Ucc4iLVdD8ENJcoJlVX/SaI+D3oSH?=
 =?us-ascii?Q?BJxIRyOXief2nRDfA2665I13FWZmcMgJ2CMdZvb3bcY4xypKjIXMwhdk2kKk?=
 =?us-ascii?Q?EC/VyMSXppO3vPGj0Gjk86XDYlmX1ORacEWDMV4OsisSDLMrGiVSqhB6qtfd?=
 =?us-ascii?Q?OPCgmlan0TwzwpmVuS2QQnOUm9Xeji+fC5K9OCF6OiZ5Atnm2z56FK7mpFB9?=
 =?us-ascii?Q?FvAwazzqYL3wOtrU98x7yRdJry4LNK3fSdRUv+NvehFkc/uielPnj+c2eMwn?=
 =?us-ascii?Q?gkGPnk9ngHDxmMhQNn9uGonzweHZoERKAH7Q4UGKDs6bF9uTsk3w7eXJplbL?=
 =?us-ascii?Q?/fnGAtQnAyRHye6nCKTEfuK+yrplhW2ZbEIntXqLu1hblfrdevamH1oDzC0J?=
 =?us-ascii?Q?XpD10dVFeQ0yU6YolNjtnBqxVzsnXTgFjeHwLeDk0QNpIezd2e1NTOF9LNl5?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b654046-d65d-4b4d-c069-08dd8092c3d5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:09:59.7127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWd9pF08CdwkhuMqqKvGmPuA9KxCxR4cz7kuK/qW44FyEubLhQPccdxF/JGppGpz/fwzMGdtWSue6zibfXM0l9Krgs/8WSnMEoR+6LmgRQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7099
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

From: Tingting Meng <tingting.meng@altera.com>

This patch series enhances the U-Boot DDR driver for Agilex 5 with
improvements in memory handling, cache control, and ECC support. The
updates include:
	1. MMU mapping regions were added for the second and third DDR
	   memory banks.
	2. LMB_ARCH_MEM_MAP is enabled to correctly handle memory
	   reservations for the second and third DDR memory banks.
	3. Cache allocation for dirty writes in the CCU system cache was
	   disabled for performance optimization.
	4. In-line ECC support was added for LPDDR by reserving the last
	   one-eighth of the memory space for ECC data. Full memory
	   initialization using the BIST MEM INIT mailbox command, based
	   on address and size, is required to correctly generate ECC data
	   and enable proper ECC logic verification.
	5. ECC debug information was enhanced to improve the readability
	   of error messages.

This patch series has been tested on the Agilex 5 devkit with RAM boot
using TFTP and the ARM DS debugger.

Tingting Meng (5):
  arm: socfpga: agilex5: Add MMU mapping region
  arm: socfpga: socfpga_soc64: Enable LMB_ARCH_MEM_MAP
  arm: dts: agilex5: Update CCU configuration
  ddr: altera: agilex5: LPDDRs in-line ECC support
  ddr: altera: iossm: Enhance debug information for ECC errors

 arch/arm/Kconfig                              |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |   6 +-
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  26 +-
 arch/arm/mach-socfpga/board.c                 |  13 +
 arch/arm/mach-socfpga/mmu-arm64_s10.c         |  14 ++
 drivers/ddr/altera/iossm_mailbox.c            | 225 ++++++++++++++++--
 drivers/ddr/altera/iossm_mailbox.h            |  11 +-
 drivers/ddr/altera/sdram_agilex5.c            |  19 +-
 drivers/ddr/altera/sdram_soc64.c              |  52 ++--
 9 files changed, 303 insertions(+), 64 deletions(-)

-- 
2.25.1

