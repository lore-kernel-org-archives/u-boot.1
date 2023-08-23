Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7CFEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 03:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543D88647F;
	Wed, 23 Aug 2023 05:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="iC/YNqWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB6B8643C; Wed, 23 Aug 2023 05:23:08 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01acsn20808.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::808])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0702833DB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGhfnh4CXFmVrbZ8e3WU+FBGFhBwrXObo9CiDBRm7wYcjiESb0lgh1xE6s4OAaRBO4nVjlJuH8OpFdtDTCox9P+io+BWAG5oBG+p8OBAR917o6Mx5GLl38HxLuFrjwLA94k3k4CJUJDRQDPN+8QQwHGOSO9fULwHyLM9+ba8U4lnqKnCS3PVHrhaGeCsw1Ci5hTOMk62SwlgiJBJh297FMdYFriTR0w7fwxsOpl/VFh5UDxTGrvX0yVS8nvaRW7tpB0oG6YwTF3wPu0RfcXJD30pOI4/hq/86LsPk3DGe0f2v/iWpZkrJIXHHwjixW+2Gxr5qnNcdEP6dIy9NkZyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pibq29IaUaZ5OBg46/2KN/0IYkCC9mhEAFI0ytDizXA=;
 b=nMotDchhGhfQY1p2eZAMOdcO41iv1z6JQq9XENaQX3WHG0v51r5WvZVl/8pjxBTxXd9oqGKho3QPdFgMwRXMviPB4NWtjNjeEXOCRZq+kMWbBX89h0TfpFmmDhFnbagEpD2zVi4j+1hZyxV1CPZnq0WeyD/hGtOiElMFzvbBY3TA+qCwAgslEn6lBjTbAHIvCzX4ImhDmauCGyDVh0vbo+andK2lsXw7Mlq714d/gza12MR6HA3ZBq51pV97hpG4NUoaaY//Tb5Vzf389uFU1oUDvBKZ3z7v78NZIPGRjcSjXCDsNsLt2XjQeGe6NNC7QLxpOzYIZkb3/QFuSYO+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pibq29IaUaZ5OBg46/2KN/0IYkCC9mhEAFI0ytDizXA=;
 b=iC/YNqWeWRELqquFQWR/lz2brzqLT5d6T46T9Vd+NFdWSa36aPKrEIXsNms2HhUQB0KMOR6Ip9JS3AULC4oKaIu+DEnq5onx6JlAlokKwWCqowZQudUPdURtdRwUdLEwDGVYD9TYbBcj/YXj7+6pS/Yth63+4dJLZXjLVH5FI4FMNNF+BZG0u9iUfRmDufqctlv05vxFhRyWb9wWZsR7FvRDl68l6DjGpbXFyvoSHOPT3/fFcR/NFt/Bz0zCsTkIHLfqorxCvJPL7tYW14tIvYnBtObpbspmnAU+L91xgPW8mECUWmz71KIlGNGxsZ2jzTIg3m0SglVvwQ9G3rZKsA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3125.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Wed, 23 Aug
 2023 03:22:59 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.015; Wed, 23 Aug 2023
 03:22:59 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, sjg@chromium.org,
 andre.przywara@arm.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, xypron.glpk@gmx.de, jbx6244@gmail.com,
 hai.pham.ud@renesas.com, ganboing@gmail.com, bmeng@tinylab.org,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com,
 seanga2@gmail.com, u-boot@lists.denx.de
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v5 0/3] arch: riscv: jh7110: Correctly zero L2 LIM
Date: Wed, 23 Aug 2023 11:21:03 +0800
Message-ID: <TY3P286MB261133AB5D40B0C5AAA0FDDC981CA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HkCT3D5YSSXGMtp3j7J3LXAPhaI1T3P2qbXfyCmw75wa5m4JqqFvOjN32hDIIUxr]
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230823032107.1792-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3125:EE_
X-MS-Office365-Filtering-Correlation-Id: 0764e141-1529-45aa-cd39-08dba3883fd4
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvtspoS0ND55m3zeS6sGOowrgC/yw6osDGptHv13UpDRsuIKgAfbzof4y+zdS26Vz+IWWIy5kAV3xAQFZiBwtlqTmQKVjcNs3AJvFNKwQmFHhehUURKdvS8vVX7VTRo3+OJeTwKHIA0HvukKyuBZ4fLqID8ACpxlx46r2MjFKy4k8DaC4Z/Fk3nxK9TdD40KgqHlJzwb3BSrSuzLitMiFG7GPmbjk3HZB+IScFXQm0ZkWMuNhDq+/V9Gsi6oIl2Q+Ww1u5tosnjrA5Zujq0IYr1LSuHRSKB+rmNRXT5z/buU1PnWHxRZTwJtyhJa9dxUL1tDb5ubAzf3il3DJjnSwq+h+477Eb9k6zDyAwaXEXk+1wm0beWCsipbXwegNlESV1JK3gV1XKLVvtN+rerim/VaZ8komBwB99myaX3adz3chIZneaomJkdwWQ544px+33KX+Wye2GcAHlIOaPSjhlXNkxlRAms6EituoRZejc5gduMwESFc8PI58vvuyX+D/Unh9I8nXZyjaIB/de/pgM2peLEhV9X1VPq/mtdbRIeN1i9t1R6EzkLrPNCqzZMyvQMOxfDHuALfMx+ORX5FsYurcTk2Hv1iXffVjJusUlkq5xN4wdxNFDIMah4QTn3L4ItL7wkamOSWdHWEPti5aChtRqZeWgabVem2DtsX1cJQSnOn9McK/CLsvEiT1gvLzehBQoRdnt8TQ3UKs4u2U0FngGnphPkoMJedQzzhhu8mVQJWhjXkqPEuPZd0GpAV5Rc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtA9bcjdoRdRdnP47BpvYC3cwElibtc6ZmxkTQheT01o34tgsfyFLUXD5Kz+jiC07ejJfe04iBDm+Cwk280EntQsZ7nSGSrgv2iOS9Oz+9YReJ9X4RgeGse/1BAGcMZHVIODdG3N0wf/UY/rgkkdYH1Iw72soA3lVcQZofErG7FSaHRjUiYSEC8u+MwZY2r2DYLMEBMdih2Lwm+4rSL3WpqdfdMwdbyIUonCdwVYvPtWtuX0IeVAr1Qa00DGarkyefR2Baz2kXajGLxBJvI+wO3BZMUOxmesGib40y0d9bMA0BzOr6dmiKPNB6U9EVazEZXuvT0zQ+AsC3uizn9LnjPN+HH+QHMw/8QIiwck3mcaVOZjn2xQLSehbfigYrv6Jc5BRMBppM8E1kmfq9Xo55MOGPNkl3i4tIv/92ORE9aSFiXTiFN82DBcJS60jIrLBIpJIIDYV6upo3lX0S8zZo+6S17u2rNBpL7dl6Wpal33kEsES3qwEa3UksL3YS+PDd7+av1rxShnXRw6SSY2Gg211peAajrO+m4cllxTwL5GRa8KLouhw95xJOkIIEL6k1cXhTaT1BZ4Q9KAb26lSJUNAD88p2DhOTQYwEWzfHlhfGPHH986DPxQbczwY88x
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KobcwSHdDBp5QsDlZEpKUWtS5m+GNDOJM7v9GH4efaDHET01Ll31Sx+dqkS3?=
 =?us-ascii?Q?VRb92zAHaCDdNkAnf42c3MtbYpR2ZirCWVCfKS7iWLmuPaA7Npt7fdIAjRY/?=
 =?us-ascii?Q?zVpwmKTki+irONGkee6/BEBHuyCLDL3M3vVWfqp1UaPpE8MQYo6D5kgZSweD?=
 =?us-ascii?Q?JxEqI+vnL5EZSaoHe4Ohu3W/Gv/sMS34UwsVpzcsSYo7pXpwXJyOP8109Fqw?=
 =?us-ascii?Q?2sfa8TEMD+VKtc5Aj7Hb7fdk3edBzf8wj90h435GnJL5jnibErUqO9AFWmky?=
 =?us-ascii?Q?h1l0+Gz5lrqINot+52why+1B0042hO00ROSIdRuUz7YS+gGpEwwW6VOedvom?=
 =?us-ascii?Q?j3wj27AW6ly4g9YCu/PNC6wGwpfVQs8+18TlumCpJ4ukntdbqmSjLNgJlGh9?=
 =?us-ascii?Q?klfpiP3VUYsx7s9fCZVRUaOS3IJWbGuZxgTe/m3383ZJ3RQUdzxv6uTcXTMu?=
 =?us-ascii?Q?5D9LfZDFyb4i2/9IX4D5vrhsHtBoI+SpPS/6snpxs+ytPJWjqOy7kpaPkpgP?=
 =?us-ascii?Q?O70n4VpzeA/vXngKw60QV/M9+MSDm3lhv3ZZwOVF6MTGILStnopXmNcB0y/z?=
 =?us-ascii?Q?1kvjWqiCyUSu0qlBa4QuwzngbjGeMXTqAVEbqhDZYCFXXB1hIiV5Yay+c2F8?=
 =?us-ascii?Q?68MC61OP22/B2tCifqvwtUWk1RKKnB+gS304uOyyfoo9NFqz8CUCDpdlp/ln?=
 =?us-ascii?Q?71X+nNhrGmZTcI2qyAatEbEnqDMUVurFxAoy+dwuDga5KqrADudFGCIhR1QZ?=
 =?us-ascii?Q?nlkEaKuGVKygR1/f1Tz9LvnoP/JjOyNNoTJBjZjn9aWr4ubmOyob1Y3pxw4B?=
 =?us-ascii?Q?UUzktu366o1BTQ9gViN655mIJTGChWZ1e6VukJlIvBQbTOQI4KB+tntwO/lb?=
 =?us-ascii?Q?DwuZsHvsjQq+CQsRR7xprXMm+PKTKxfMqlOWSAVRpSQ60Ayd/59xgou2q5pb?=
 =?us-ascii?Q?ReAotiEeFF6dn9s3dL6O4bzcinHZU0ilUgn2GuToGODXQ9Bd4gpOC98dI/lo?=
 =?us-ascii?Q?w89WlmknMqL/7VsBrcuWPJ9QQgof8SaWjY7hhdPEHdy7nNEMTFM9vZXSEARN?=
 =?us-ascii?Q?qOnjjuYFVYhYFVFGXUjezpxjKilPGN7IrZT+DK+n2Tr/V/C6o4oFouAybdRf?=
 =?us-ascii?Q?m7jshDEyUaLrZLDX68eRyjtH9LlZRLaPEKBeLPJySgrbWGoy0Vb8pYEnP5Ez?=
 =?us-ascii?Q?B5GG1UnTF04iLhJvrLe1gV0xr3eJx8b8jvTVyEtVirRvkj/w4HCuFTT8zNs/?=
 =?us-ascii?Q?VYySsAtvu6gHClR4p8dKcDLTskV7aGG5KRiOHFGYzg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0764e141-1529-45aa-cd39-08dba3883fd4
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 03:22:59.1331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3125
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

This series is the fifth version of Bo Gan's L2 LIM series.

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

Shengyu Qu (3):
  Kconfig: Add SPL_SYS_MALLOC_CLEAR_ON_INIT
  dlmalloc: Add support for SPL_SYS_MALLOC_CLEAR_ON_INIT
  riscv: cpu: jh7110: Imply SPL_SYS_MALLOC_CLEAR_ON_INIT

 Kconfig                       | 11 +++++++++++
 arch/riscv/cpu/jh7110/Kconfig |  1 +
 common/dlmalloc.c             |  6 +++---
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.38.1.windows.1

