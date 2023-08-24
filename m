Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37CAC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C00865D9;
	Thu, 24 Aug 2023 18:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="d4SfJY6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02F4865D9; Thu, 24 Aug 2023 18:25:51 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn20830.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::830])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0046186694
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1TDS/76/i+R3eYqTMTnYNZ+8RyoZ6M/lMifSl7xeoIsgriKmO7bBbyT5ksd9iRpyliNCihhKB5M00aj7nF+Y/cLS3PfSwDKYygbohx4xhKxQHlGdq0XLfF1x0gqM55uL/4ANobx2Ve+KaekCBOtvzcOBnW0y9ZiMHYRWUJLQyGZpt70RqVpAhM9cnZirtA1DXkH1QEGBK3kDv1hmcTFffD3RhkXP8LbXCxHAHAM6HDiq7/WqBA9G/7pOR1gyALSSwPZflYLehv3ctCwbNo5yJj/7L5n7IWUQHNjidQmq+XwmjhIq9/bEwJaK709+U7WA774xIbsst48tuClPf3HhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lQS52nQjIyqWxifpy5Su+OjztNK4813Qv+1vwCfZN8=;
 b=Qz2DUmHF6uJXNzY5RkC/N4TDMaxc2huuaD8TeHVQkfkv5HwwcDD1luYV8q12kHCmPBGawwFICEK5IcefITjVxUpHpuuVomdYbiO3XEvUONkLhViH/ABDBiudsp7QtZbANZJiWng3ccyDpb/G+GfJveEnsk7is5je27G3xevJRGIszIKo6xgtARucZPA3nZ48XGYQGqwTiwmBQ8XdUqGt8qv9nVFUx3BJ54CcDLJM0hR0ltjWFHAOtQQUcfO0GJAXzeUil1Dj6YL18RCPvJwQouQso6mlZVDvfePQINU0Uf1wdxaBxQ7iFjjPEr054w69DO5TtiG4PE++ajMdwlxLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lQS52nQjIyqWxifpy5Su+OjztNK4813Qv+1vwCfZN8=;
 b=d4SfJY6ZEINRzNXb++bbB05NErLhz/PBoSRL8mz0GSkyVmBkJ6SCVwKb3FQRznesRfL3ew1xWx3RtwGNBZNlnLmYzySSs2pi8fejw58zR34afNY0xVnvXQUxKtfDfejanqi65jOFIzN90AX8LT/qm73AJH8wSll83L5hKLNIP1cuRGvQmMRo0aslN1XzVDWd2Ick3wQDHXD0AFWXC+V8HuocB43BnicO+cl4Nz+jaQfUrLQkyh64u1jhs7ILvq2kvdLd582tb6whNEFVxxzuETo0OGNke7s8OAijavlJRGTG49r9tfkU1A56Rw3obH7in0ohqboYodHJKsy3K6+ZTQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3381.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.19; Thu, 24 Aug
 2023 16:25:42 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.018; Thu, 24 Aug 2023
 16:25:42 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 sjg@chromium.org, andre.przywara@arm.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, jbx6244@gmail.com,
 bmeng@tinylab.org, ganboing@gmail.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v6 0/4] arch: riscv: jh7110: Correctly zero L2 LIM
Date: Fri, 25 Aug 2023 00:25:17 +0800
Message-ID: <TY3P286MB261153D43AAD87F0A2F1EB73981DA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HP4Ocp7jBrGPPrXhBwKt02zCh6Ets8MV]
X-ClientProxiedBy: TYAPR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::21) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230824162521.22240-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3381:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d22159-cab1-45c4-35e6-08dba4bec234
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnr2Lei0t6BdvckvQPHsYbU+eRy5a7w+8cZTjMlarVeUPBX0ZpJVfSoUT+gsBZ2kudyXQpa/2vinxZ3pT3CJRyawpY614CflHjnBD1hHvwHr8teUwxTzEzogRhp96vLlp/xA3wWSU2+kw6K4BLyRzFvCEFLJkIBM4SjMfT+StymzXh4V2fsShi81G9E8pTsYY8a4ubnPkJYitQnoZpCJwHziqnX6u31nFpl+9wdXg/lNy2Hekk+8ygtT5K0OAjN2Vu+//+yQgMAn7vAhC3e45tKQR1y3fGFdfzQa87BYvkKkFt3xODd6bZFYBcMTPF5am9RLKxnvMx2VAJsdqidTtVqE+cMV89TSh0H9Kx1a2zWxlQWGIpIwPts+eNGxFzW6Msvj6X3Ia1UoK6ETIu3/EnVxKDrJobrp9aHW8klTU2CVrGOFv3OGG8Sak8UlqkKfyEFr3njncPDX9e+Vj/4KLTttxONKM6bK3zV8t0HQEjQdHigzrdHpEBu8cgqYaJH2YhTg0t0n+V7tDnU8cc1DJtBaocN4bWBm1gckNhVw8ElJVfMjQukm4WXvmIi7/bb2DxIp2QJV9SYHBI5QTtANRDdzx7HKjRmxCJTqVcFxeQMp0t3uekTKWcV0+dYFlu54SX3q363JBSPLrAYvlwF1xH//Zt6oEey/lNcW7Gkpcr63khSyuwXGhBfqoLV5CEOaQ/V/7o8k8GblYQZWRVk47mh7FbIG7R7ArFehkse43cz99f1SR63ZQEfeAOMLyJRu+a0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICtt7/qpufXwJ9r0Q3s7ayb/k5RIw8ZalcpbN/5fDGI6PQRGgiBVeL9VOom4+neQdPyiJZ2P7fv+03/r2QKvEoFwFLnVI5kKFuHRDpVgMj6jbQs3kYFFtpCC0E0LgC/N+6302ajbWy1/6X6RUfIRTfAHDbq5DXYFwKY+Px8eZi++hnkvkgXX2XgEd2go+DmrcbBgyb2QGRvgAwR24jMefMb58zI/TDzsVvbtx8QYFAfb2bBgusFQ3d+gNZZt3uvSQDEYAOxuCaNPOvPekFGUNxyCDTL+4/90om5AHbvtu3O6Mw9d/EWfy/72b0Mf9Frc6+p17eZMlILhOVOF/hC5v1aKoa6cyNdvgalT5t2czC+6j+rMMxwSvQyHUmtaM0cxzN1K3mwSge2V99QJaxasHDMT7mIhGXPGkN7iBqmQwI0QSr9mU9kqDUdLShL8J4dKMCm33+DaE63BmZVZMl9TVBsGEOVaTgmr9ywVU7v6jmqs8kpd0hmohqdhU6A8mjfrALfaPEJbWIg/Uvp8UQy8xhjOsh7PW4sVS9DiyxsJuJjpJpOu1o3fK5KKXZTxaoTcJJCIn0eMwCYZYEUmRT4TRxFaBJf/kiceB3NVHLTWIwtMkxzb467ACpCXbA7pdymf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4MKBgCHAtPhzor97BzSnTbs3CMhkNyPfx3ahmTGUejbcJPLWtGPhqSX6DK6?=
 =?us-ascii?Q?GLqtM0x0mU8AzD9MlBhdMohYW2hK4uLJZwHEkPprIFj6qQZ704Gb8YU2j6Zf?=
 =?us-ascii?Q?5KqGNn8LzoR7IXN4PPMjgk/9xXNQ+fyeA7U4P5CdyJLN8qJl3h/k9lHgOyXS?=
 =?us-ascii?Q?TXbm6M1HkHQWjMDSEc/gDREWfQk/Ra3HdI+yseWf2/Y1CZPk+5mDafAYeOqh?=
 =?us-ascii?Q?ylHuN3qEX183sQ2SI0wF4tlm66fittU3IkV03NdCem0qJ5Ofo41lQ3pOY/4x?=
 =?us-ascii?Q?JdFu0s6yuhWjMf/t0+l1G4I3gcNNGKNvLREeEJBXTCN93ESi3S/v0irraoVK?=
 =?us-ascii?Q?fti1p5Zu/9Uruy6YG+WErR8+z2aROX4u50wyzkUneowFIrAO8zfdDTARN7zH?=
 =?us-ascii?Q?hrW1DsvhwY1rBzb3M1Ixboz4ExMBgYBJdyBkznCwMKv/uxtBG1/DE55sAcCl?=
 =?us-ascii?Q?FcLlKDyX0Up5xhkBpNFVEq+NHMqMl4Yb2YIwPrKeSGgXHqncMwg9Uhb2IYIa?=
 =?us-ascii?Q?SzEMpuoaWEFP+kpOta3MZZ7VWEhs7bv3zxfVtgjxbDM/txBWYf6muatta8dY?=
 =?us-ascii?Q?K5nRrXy14NxRdgNLLcDlgEDL/5j5Zmub2IdxnDLTm9CG5tnWOr1haYXAcddT?=
 =?us-ascii?Q?UP4N0Z5ibnV6uODQnNQTuPrQ5IRq/bLbMpBYYXZCmPGrdT7/cobGo+To09rT?=
 =?us-ascii?Q?5nXvWU5ZYSA+YLbxu6AB9aVJmwiGWdz5OfQmxt9ROFSogKB61ZM8bUfIMYkX?=
 =?us-ascii?Q?iCkRNcTBB187rywZ957hI0GY9icL/OiaFI2Hf55u29mNczigceMNDS7uWyOT?=
 =?us-ascii?Q?eDSVKWsHPbHBMpGxFDQbMn7tuiWz9XO8Kgmlq17Jp3r6+96RS68QVw3RQ8it?=
 =?us-ascii?Q?CFlB6scmZJhpS0eA7hqaPN0jFfOlt/9BqVglnjYoOzIUMZC+aiBX90fPm5MW?=
 =?us-ascii?Q?0nvYFWYRavHT/tbHa9PWvD26nuP86u00lE0192QAM3qdvU0tv6a+zqAvxR1M?=
 =?us-ascii?Q?JlHKHePxeCSbaCW2W6K5VncA7+qpBBQi02ZV8b15lrRgfB0k7Hco/tWg+t9A?=
 =?us-ascii?Q?gq38jZe1Hi+MlIspSaasFBQ2vu4+jF/9ZViqbFWfTOT233NuZez1egM1xLPH?=
 =?us-ascii?Q?PQ/2WVYZAxIj2ziptyeqU6i80Lqfn1S32Lx0eE0RQaVJqFwfbURs+HRD8S6a?=
 =?us-ascii?Q?gSjMsLdxp4vzli1lvDfBUhPAB7g2pPnrHLcA1Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d22159-cab1-45c4-35e6-08dba4bec234
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:25:41.9465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3381
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

This series is the sixth version of Bo Gan's L2 LIM series.

Background information:
 JH7110 SPL runs in L2 LIM (2M in size mapped at 0x8000000). It
 consists of 16 0x20000 sized regions, each one can be used as
 either L2 cache way or SRAM (not both). From top to bottom, there're
 ways 0-15. The way 0 is always enabled, at most 0x1e0000 can be used.

In SPL, we don't enable any cache ways, thus all 15 (except way 0)
ways can be used. However, due to HW requirement, we must zero the
LIM before use. This is because ECC is applied to LIM, and if not
cleared first, the ECC part is invalid, which can trigger ECC errors
when reading/writing data.

There are several issues currently. We clear L2 LIM from __bss_end
to 0x81FFFFF in `harts_early_init`. This is wrong because:

 1. Each hart (in the middle of a function call) overwriting its own
    stack and other harts' stacks.
    (data-race and data-corruption)
 2. Lottery winner hart can be doing `board_init_f_init_reserve`,
    while other harts're in the middle of zeroing L2 LIM.
    (data-race)

To fix this, we split the job, such that there's one and only one
owner of zeroing a specific region (No data-race). A new SPL config
option `SPL_ZERO_MEM_BEFORE_USE` is introduced. Allowing The zeroing
to happen in the same code path. (much easier to reason about).

Besides, currently we use DDR ram for SPL malloc arena on Visionfive 2
board in defconfig, but it's also possible to use L2 LIM as SPL malloc
arena. To avoid triggering ECC error in this scenario, we add support
SYS_MALLOC_CLEAR_ON_INIT in SPL, and imply SPL_SYS_MALLOC_CLEAR_ON_INIT
on JH7110 as default.

Changes since v1:
 - Separate single patch into several patches

Changes since v2:
 - Fix typo (ZERO_MEM_BEFORE_USE to SPL_ZERO_MEM_BEFORE_USE)

Changes since v3:
 - Revert v3's fix since original implementation is actually right

Changes since v4:
 - Add support for SPL_SYS_MALLOC_CLEAR_ON_INIT
 - Remove already merged patches

Changes since v5:
 - Fix whitespace in patch 1
 - Disable SYS_MALLOC_CLEAR_ON_INIT by default on Visionfive 2

Shengyu Qu (4):
  Kconfig: Add SPL_SYS_MALLOC_CLEAR_ON_INIT
  dlmalloc: Add support for SPL_SYS_MALLOC_CLEAR_ON_INIT
  riscv: cpu: jh7110: Imply SPL_SYS_MALLOC_CLEAR_ON_INIT
  configs: starfive: Disable SYS_MALLOC_CLEAR_ON_INIT by default

 Kconfig                                | 11 +++++++++++
 arch/riscv/cpu/jh7110/Kconfig          |  1 +
 common/dlmalloc.c                      |  6 +++---
 configs/starfive_visionfive2_defconfig |  2 ++
 4 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.42.0

