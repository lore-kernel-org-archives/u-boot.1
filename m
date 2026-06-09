Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CEECD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 02:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A0E8481F;
	Tue,  9 Jun 2026 04:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nu8oFJax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39B484869; Tue,  9 Jun 2026 04:04:14 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6739A839A8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 04:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+kkUF06a74Ev2dh8btG4CXk1cJx2sTf//gfdvvV23r/9m+Mewp7EGOW0BvWoGatxuvrWqSd4m7K5IJvW+katWoJuo+ymljwHbpdVyLMZWxpNKWbynBxXprtVIMTmwE43CyUJO4CJpBEc8HajZh3m+++pdw0Mthrsz6RelpBUDLBeLtY5ujnevPjDmKxSdabJmaatBzDwVVKTnwUeF2IGPBQfWNkIz6MN3U3iM6M7k7XPbyKPZn87m3UyoT0U1gxX+XzO+3TGKUxc1hEdhUVfTCvVYVYQg4O8AlXw8OK2FSWxH0b4hflyBmlQeQIfXKAU6nGoRKs9nmyZ1g5aWkBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5X2rs+eM+2B+XhMTT/fjwH8xwAF9rjq4Y0hzHVbJKM=;
 b=GHIfgGShtkaA+jwE7qzByTZIIFPb49VBUnm2AKBf/H3+mEDDmYCZXuK6+6G1TxlBvY9+WnvTacOsv41z6Su+yEH5z0flR0TPWrLTOW5wlhd4VPmk7V9DeeJxt4GmQYGTXHl554mwjfGr6f19BRxFWB1CHy4o3omNc6KTiw4uABPHWIjl4cPbymXlpkihzyTknPe71RQYq5WKk89LuGA+VCvskJ+nCGzwO1FZrAEOxxgl6z2iprP6se/S8sBkCPp6SwODYJSPESGxVb2VtzaxW/esocpaLoJclAwq68zJIwt0E6tKLpOwEmTpWEo5TLH58pkEP65H+wq41xpFhjxc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5X2rs+eM+2B+XhMTT/fjwH8xwAF9rjq4Y0hzHVbJKM=;
 b=nu8oFJaxPXmZfE8L8kF0haTZ0AhtuE5JvYDbNRtJbtvrXklUQUbv+ohYSk4cIJEn/0fVjy6FTRWHa+VM9js8rT+SMS6UySwJ/R6RDZSI5uzPJpriVlbbTIEiol4jWEe0otOa9gx5sP2zJNCggS8t2uyHb9UxiibI++q6RaOGO++Aa+jKDqaVVj6XBe5J/l2yOhoFn76qSXV82b34fEDnQ1ApG45NnOgMD3VcjzX8F3voSmuEbu4WN03hF9udYNBBHUC5P1gPEl6N8J2ZZRA+Sb0OotJDY9DASecHptuIkfs3ITYLYjYscBeIxPmkIofp2R4JK8ud+R1nMwJMDBSg0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MWHPR03MB989484.namprd03.prod.outlook.com (2603:10b6:303:2a8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 02:04:08 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Tue, 9 Jun 2026
 02:04:08 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, patrice.chotard@foss.st.com,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4 0/3] SoCFPGA: Update DDR Support for Gen5/Arria10 in U-Boot
Date: Tue,  9 Jun 2026 10:03:55 +0800
Message-ID: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MWHPR03MB989484:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7bb7b2-0956-48df-53be-08dec5cb63eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: sWzsgQucch/giMl8Nbm1j2I4i+Tz+yrPSd37YSqyu0jl8XW8RZyUk9LfiQ1Fq7Z8cAc0Atp2h0W21QKnwL+ovi6bzZSOH+uYkeXleeJ4Mxs34mrtmKgloRPhv7kvz4240O027gC2Da/liWlub65+roiLhol1dktnZvZaZu9CkPU8s60ndnn6D9CyZLVOQcKi4HRF41xOzhnuQzVHB1blB4P9ElFCySnaCMdOpOWP1LDk4A7InX18lpI2jLvIc0IjafSO2ReDTqBAArxcjjLzD2SETIDRbiJy6MxSvAvVLhEL2FFiYqRZLN8FSA81pX35jWiDIdQLLGXZGQqRZPDwzh9tCqejL8gdIwVmKgKn5CPegxzqPmNBLyaqLwvxF1IvsxGtSRAmV65nduCB7NyBXYpj3cqoS9L+0w4pb05YdPtUsutb74/PNPlnNBfoqfvlrD8ytJDyx2tKoNrp+qJ47+gDDvRnEqnghGIavhg6SOTKMV2p9I/cVVBlF+Rpj4IstdiQ01OLgAaQmEUfa/sVmOUAgUSvzBHCvD5nS3KLSKPrBV9MZDdeCVJ+Razfc/Nh9tBJxlLPzcJttV1ofIb8dYFuLezMAixEOmECFmlwh12/QnUWOVBkTrBZso5TZiV+KNuvQp4cl73zrgMotsEQRX+PAwx4u08SqfYLljtSLQNS2cg6/Mru2f6P7TjLncWe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4ez66bzSU7v7ThLiKKQ1tPyLAvuwI15cnccIHxcJ0DcbZ0PIbrudJg0/H1y?=
 =?us-ascii?Q?l8x6qlO1BPLfNPiCzmkL9Cwz3TkztkBbXpm6BHIrO4ch5A4tdobvjdirPYNO?=
 =?us-ascii?Q?MbzF7TsMMcXMkAYoobelqFf8LiNKCkC6y10Jj8NDEnVtqsKnnbc9CjHhxaIj?=
 =?us-ascii?Q?xSRfP26mjcd2woKc4aF0Do6pxdZNXnXuhy7SGG9jajwIQiZ+FfH7GIUUqxmI?=
 =?us-ascii?Q?sXBcGI2PJ8coq42eE/sJWH8+4U0RoHXEJKfKxhjZlsuqgKlpJPV/jK3LfGZ4?=
 =?us-ascii?Q?xEo9EA20w+cUhLIxlXkLgF2DXqRO6ljaDoBnn3YBimZxOZ/UHpzkcyv1VJqu?=
 =?us-ascii?Q?kvCvO8aU9kQyKR/keAhOrWpilaWyShTubOgMyOmXhGsdGpXzuwhZIfo6kGwY?=
 =?us-ascii?Q?PARsM6njtzYc5AAvLFEbMZo+ebFoyivaXs77BPjPpSIMvuVi6cd94vNOkOVG?=
 =?us-ascii?Q?LGgfd3T439rDaTQeDQNgN9xM9LnJvlK4TCAGmQg/zdGpYmUIopaJp1nGcn0M?=
 =?us-ascii?Q?ZsMKv9qy+S97BToMpMV+gMQxNUYZQ7X+nVhsCaV3MsSZfrCum1UCzS7gxA5S?=
 =?us-ascii?Q?nMj/Eb4D5mdk9SH155s+YUEIEPjcv8p4nVuPtHbjT845Go1YuGNYNWMIEQsx?=
 =?us-ascii?Q?nhLEY1gVCYj0x0lnor0/vLEQrCWuoIDhu2LfwvEun7j9ZMGfxsl05njgveT0?=
 =?us-ascii?Q?sM1itB9efznwOb40FmIN2xjzuQp8qLSWqmAgmwGvD7wwgMn4+w3Sz/ztBWN/?=
 =?us-ascii?Q?o1M4Byi0PYwdvhOF0DJfXVBErg9AwB188Ykr7SDUqeviSGUs3d1549hQucK0?=
 =?us-ascii?Q?mJXBpT+mBS5bKSO03kHdeH9Q8suz9+Iqe8W2YsmnVTBLEcfyZZaH3L0/sQyX?=
 =?us-ascii?Q?G8nBRfLSzWk4MzP0TQAOr6RuvVKLlQzYhVJe2ZShPQoC03UNqF8m3hItoZMz?=
 =?us-ascii?Q?lW31GPtSkDWhGJ+8m/14x1cpzC4QU2FRiawtKD9j2vMHRax6JvhAlcKBR3h2?=
 =?us-ascii?Q?Z8WrpjobpaDpmYXc2A8IbpRKDdci2qOF8UtuE3zvbpq9oemuN0rm7TrCJsWf?=
 =?us-ascii?Q?8IJkupfing7Jovdo5kX8rW4wwiG2l0nKBM0V2/iWaicpixriUqeHqH8kxnnn?=
 =?us-ascii?Q?K14bKZoiVlSBJ33RJHtLCcuCZB2V2z2lAiUNwbWbFVWbH/pWft32FC3Y1N3e?=
 =?us-ascii?Q?4YDl0NSe9kdBb7EXQnT9qBi3fIZA4Hq789/0Fj85Na5ZDV5MalgO9xqCpclh?=
 =?us-ascii?Q?ccYT6L9PXMXyfVXkz+Qco1y9Sx3KyYJXY0Cx64onKlSMfbB/rekpAW36h2GG?=
 =?us-ascii?Q?LOKvrXOnjVunaXyxrG12pNGwLrsf4qTRY7hQGt42mmoteBsOyVUhwfXMK1t8?=
 =?us-ascii?Q?EM55SzAr4GjU1mY7hTaCTWJSVNAC7fKkdNb4lRjyuX1HkFJWkDUYq8faY7wF?=
 =?us-ascii?Q?dsuNiVxs1PaKxVJ7MHHb3v/EWPSm+8Ip7E7Web/uXXoVZL2SJshjS1rF+p2A?=
 =?us-ascii?Q?WW39eWhd24J3+sVqSz/BQVWXOcBvTEDDfqq/LSdMpq1eywTgyhFnhKbCxPIg?=
 =?us-ascii?Q?+uNzPsN1pgizAwmddoI6AqrKvg/L+iPnbQUEFtZiqQIgmBSWlEoAVY/9dCOU?=
 =?us-ascii?Q?ciaWwHYLDBVRq3uEYfCcZBKvXI5OTYsSxqZ7sNS3dJcT8r7PQwbSLvMAojB6?=
 =?us-ascii?Q?UUB8P89Jt/EjZzEajRHOR0kZngJxUJZjFmPut+URwMCf9IXr/k+/uL+aYwQo?=
 =?us-ascii?Q?klfULDmAc/6pTRb/JQcfzth6w5EuHEY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7bb7b2-0956-48df-53be-08dec5cb63eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 02:04:08.1917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z+xpo/MdLCEzUKtu5JAGCeNQWYqb3LfRlHi1IczeW7YhVFiZhy3ccPGYNkicSbZKEBar7SxPRGNe1tK+6Q7XK8SfWebpt/PwFkhzGbM/5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB989484
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

This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria10 platform in U-Boot. The changes include:
        1. Update MMU/dcache setup across Gen5/Arria10 using common driver
        2. Add ECC scrubbing support for Gen5/Arria10
        3. Add DRAM size checking for Gen5/Arria10

This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).
Tested on Arria10 devkit with RAM boot as well

Changes in v4:
- Commit message clean up
- Block comment style fix
- Rephrase SDRAM ECC init success message
- Updated commit message
- Updated copyright year to 2026 for sdram_soc32.*

Changes in v3:
- Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
  applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3
- Move the bdata declaration and gd->bd = &bdata assignment from spl_gen5.c
  in patch 3 into this patch, making this patch self-contained
- Updated commit message
- Removed legacy HW watchdog check in favor of current WDT DM for Gen5/Arria10
- Dead code cleanups, indentation fixes

Changes in v2:
- Shared dram_bank_mmu_setup() is set as optional via Kconfig and defaulted
  on only for the reference Arria10/CycloneV boards to avoid SPL overflows
  on size-limited Gen5 defconfigs.
- DRAM size checking is set as optional via Kconfig and defaulted on only
  for the reference Arria10/CycloneV boards to avoid SPL overflows on
  size-limited Gen5 defconfigs.
- ECC scrubbing is set as optional via Kconfig and defaulted on only for
  the reference Arria10/CycloneV boards to avoid SPL overflows on
  size-limited Gen5 defconfigs.

Alif Zakuan Yuslaimi (3):
  arm: socfpga: Consolidate dram_bank_mmu_setup()
  ddr: altera: gen5: Add DRAM size checking
  ddr: socfpga: Implement ECC DRAM scrubbing support for both
    Gen5/Arria10

 arch/arm/mach-socfpga/Kconfig        | 21 +++++++
 arch/arm/mach-socfpga/misc.c         | 31 ++++++++++
 arch/arm/mach-socfpga/misc_arria10.c | 26 ---------
 arch/arm/mach-socfpga/spl_a10.c      | 11 +---
 arch/arm/mach-socfpga/spl_gen5.c     | 17 ++++++
 drivers/ddr/altera/Makefile          |  4 +-
 drivers/ddr/altera/sdram_arria10.c   | 31 ++++------
 drivers/ddr/altera/sdram_gen5.c      | 62 +++++++++++++++++++-
 drivers/ddr/altera/sdram_soc32.c     | 85 ++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h     | 15 +++++
 10 files changed, 246 insertions(+), 57 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

-- 
2.43.7

base-commit: 75daa277941702bf58c88d65c0cb6ed962899d9e
branch: master_soc32_dram_mmu_setup_v4
