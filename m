Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39566C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713E484979;
	Wed,  8 Jul 2026 14:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="B+cw/KWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF66A838D7; Wed,  8 Jul 2026 03:12:57 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C468497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSSOdLs5fqB1iXMw0SWey5fmBjaktgKh37h/feFQyLtQDNv85X7/TlEFX4RpAynCz4ixdSG++Jiwzh8L03xyxBPudzUAh2aIymlidobVjDyrnSofIE1yt9hFTIgM/A6qoahwJB1Ww/2ApjOojBahlRh+gsr17lvpZVOMPovY5NbzisMdz0mfn3Ev0IgvlL4ubFiGMUZYlDE+zfdJEl+azpnIo6mk0bLlGTteGWwJelY2iEc8Dpf8qIgY0nBPiIBIQ3GO1WyWK0Bqh2dLLbheG2QgSruM0QzlXekm0Rc7EeOlipIJ1w1vpDxOptFNKhNLeHUK+ZK3khEcA7TRLZhIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRz2NsdXVNnT5MLhk1nDj1+Vwqly7uWIoEQOWDPsoT4=;
 b=t/eGm5dNIKipqsKP6DBagHvse9Ni2LA2kah32Trjw3UTagR6GnnWexyPGuaQ3Wzr+66AWtcNHyDbyr5ZGsGz7Paadq94RAcE+Bn971kEJBsuYTnDZeBduLlKnt0r7kyq2TtRIZaXN3foW5DNxi7IcGIbIo49d+NLUh/RlH1vnx/QwEX3tl7GU9ElqpHwvrV57GcKRvna9SziK80K/V+B0CyEIjNlskVqMnFQjem0ik1oGuhkTSjh4k2nhCdn3e4e5sRFnYeayJvbmf6IPC+lvhc+JGGDs+/Ufso87Z3sWUudieM0Ps2NQC7BDeAXGt20CBqfmwPppfWCXdbbJxdLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRz2NsdXVNnT5MLhk1nDj1+Vwqly7uWIoEQOWDPsoT4=;
 b=B+cw/KWyRnWCARqFCyYWjnq0M9Wx14liYJWbMdq2pu7PaQcWKq/rUPNDYKwrqTIEHPyyDXgFv0sSlQh6m+ttFg7KWcI6sEy9LLZztp6+q2tIwgPJNwCRERVac9ksWRgLEgULyVB9wl0liFlT998k3DAQf/Y40Zn2n0voRVdApuS/r04IzoUCvHk5J7oezWid+IcPpMI2HZLnP5Eo7obUu8l3umRR0IkY4a64ObtlzX00Vc9H2Lzr1tvvN+nBHo0oagLjgNTmzyEwuqTh8saLGK6TclHzKqljVopSy+2S+PWSld2Ra2QdpKo4LQJqNWaEEl2zqptBM4vrjI8XbwOY9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:12:51 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:12:50 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 00/15] ddr: altera: n5x: add DDR retention support
Date: Wed,  8 Jul 2026 09:12:13 +0800
Message-ID: <20260708011228.15613-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ee397c-109a-4be9-fadc-08dedc8e07ae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: zd86iUU1rbqCIm26dzyrlKHABcGRiZZh9Z7YYC4a+vZNUVMRU8FALgtVw4AvqAJlMkieEUgNll2rAetwzKsBSbDtBU5NtlVqx6eq24tpWeV4Kq/eXfeE0XdX8LlBNhKKQ3V1uVtJeZUUdyCprgiG7s4zeiOvm5UReR3d6wLFvHqjJjihKElHpkwZ9OTgJzmFvmDwiVWn45kTuI9pdJtZwOFkCTwSBuD4vaUqu7pRr1XaHPe0CQ97knDM64ZPaKOYuTEbdPQsf/l2O5rts94x98GGWnJpTNF+6N6Y+nPEbFS2+N52mH+z+9+z5aOKiqlRe8O3/+EFfM2g6wipyANfRYHrFZSHGQo41v8INZAYv3qrGPXas/1CiBIPbWJ196MTDdaCXoO4MKhooDCRUJzrz1DBfpCHUdja+zGE1sxqEPKFBRs6Mq/7suUh7Ib7FkvWJPkp0aERL3r8XUYBezgTwDMMpGSx85uLQDauIkbzqBDBVE/KErY0ui+clz5Ppeyev37p6QhjnF15P6ttI32U4Hoom5Q2Rzb7vL9MQHEcqq6F3tQOReTuJOFUVjWpBRJqDylWUFf8KalwtvCMF3php7TDKZhbwKwDpbu+HfrEqguHApaGn457y5AvCJSkG6um5O4jfOx8bHUYOaij3kSbORI15KT5y0+PBOA4iP8LwJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Go3bUCEOW2c7UJKYeddZvoXHuBg6XElmc9+A1W8HJqDtNVpTStpOvrOTuxjz?=
 =?us-ascii?Q?0ve17C0FP4XbDwlDVCTw+xjNXSaQYOHKW5iG2VRVcMpCuh1Fd3/0e4EkHpGk?=
 =?us-ascii?Q?RhVisp+ByMMBCGP0xJukJgYIMul67tRreH0/9Jv6fw6J+HwWLekzRZrJZKmy?=
 =?us-ascii?Q?2MlGCGDE6COmb8tHGVpqU4443mhsCcOSEsZrx61IMmJI3gLn9S/VW8KZfU+F?=
 =?us-ascii?Q?VyFbHqQWyytmULcmBRnvzto5+gNdKAScp6x2hzzPrDhl6418LZqYI1yFRWnz?=
 =?us-ascii?Q?p2ChXD3bS589tp+Ji29wDKr7gIBXBkKz+uEAQj3wc6A8ZyRM+4IZMn0aPEUw?=
 =?us-ascii?Q?A/uEftM0RjKiGdD7fPlbSEZcROtEItl2t/CEOgRsQG2XiI2+yeKUa9X6R9JN?=
 =?us-ascii?Q?yBYyOpY5SGHn3yva+/ogcWrtxmTkTPCrAm3S3nBMMc984rqnd40GkdB15zh5?=
 =?us-ascii?Q?HKXlMu78H4NiswFD1GER9Gcei7RRPh1NTgDLCKIyNmCSCITvS/q5mogTMpq1?=
 =?us-ascii?Q?I1sLju1/pNtGMop+5FLP2OFD+Nqjr3H9k/vwSjBd3UcF7Qr43Xiny3xcvBwg?=
 =?us-ascii?Q?7xzxp6p4UOvqXZ7OFIdaIs3q3TXVfb5XDQ4qDFp306H3JFyTxE2shQLAcQ36?=
 =?us-ascii?Q?pb5FlL7TBwr8dKft1Ag9iZZndvFDl2DnAN4KglzBBJQd1FcELIUUUDrupVfw?=
 =?us-ascii?Q?R59WsIGs3a47FzOHMHDOS7SvgFEJHK9f0aspXqd78SmS/OG/zNQ1fEczkVuD?=
 =?us-ascii?Q?OO8zEWWkpZxIEWBb/943bvFJ7M0ONDjSJ6Wg6FCPmu4lPlEVwBdGb7IsUAVR?=
 =?us-ascii?Q?e3CARxz6nRRQhi9ROvTXRKoLEHBCrDp2DQVP5rwqPkAZSEbBUlPifWSXKEZF?=
 =?us-ascii?Q?XIu5QZm8OKVXU+ZO5dbTc31Sn6+BGgzbBcIxE8By8UCPLtKg7q74KVvswSF3?=
 =?us-ascii?Q?CKGsMQdNe4lYrUe+UKoUUOt/NEN/ZTZ9Wr+JN0SO6tk12AGpqq+YAv312yoU?=
 =?us-ascii?Q?mqHNZ0ESLNAht252Y0e/mzWfLjCxY0zbG2Ix3XhSI8Sg6nHh2qDkJDaXxLAH?=
 =?us-ascii?Q?3F+yEGzU5ItM8Cd5Jb//+PKLy8Z0vFHPoMUXlEGBE7Vb/Co1G2CzMWiz78Hc?=
 =?us-ascii?Q?L7QKih7dRhS5owm0HhcRBhCKVV/NJwTzTxM9oEIOQA2hAwFHF0xq0KPd9Sak?=
 =?us-ascii?Q?fOv1ZfYaAhheQAPWmMy7Oud0Ro9oNHmdpeyySmuRLl+QRfQhYuCW1V6s8tVP?=
 =?us-ascii?Q?Q5QluihZtIiJtzmDKkG2qCltAfu9+uMCD3QmmuVF34gBVbWlBH0nYElm6G7Z?=
 =?us-ascii?Q?STC+5n+M3gAVJCvutKSRTgAzvRBlDJhR3Su/D9hlPeujpMPEA6psq1AA8JnO?=
 =?us-ascii?Q?z+oVGLj6C2F77nnSnPlFTGGWonLkXcXxs6ALApR/IQrEanVtilDDsIe5fkiH?=
 =?us-ascii?Q?ZRX4vj0NRxw1vcbADUnhtbqL40uTfRpSsTiC6ie3oC2/1z0WxTCY1lmsrkvE?=
 =?us-ascii?Q?BfLMctHDL1KOw9ongVxVf89pyLVgfM2smiWyPCPgEcB9PENEKm8E686H65bR?=
 =?us-ascii?Q?rHn/+r23+h+y+AAtNx8+KgCnuZfCYJ4DWFXP0cw0maPNzNgpaoZiQFgvvCsW?=
 =?us-ascii?Q?xOogXsA/3wzAVnv8Cc+cUd31/N0kCc9d86syVh0RL8+39QAclAWb5mg3Dq6u?=
 =?us-ascii?Q?DjckDQQE1jqLV1zx7MMHJnJSnoEnuHg5K+WqiWjX8WAlwwZmKIBAN/ZNf0G0?=
 =?us-ascii?Q?B2KIAgoqaplQYf1ks3WWFpfzSA/28Yg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ee397c-109a-4be9-fadc-08dedc8e07ae
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:12:50.8745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiCNSaXJFrFs1zciiWIV5fPyZK8cwWPtztXQcwiJwqNUJHosdz1Pcr9bw3U5eOnsLXfD+0cDx/TTVgcemdOu/rsNyqpUeb7qsP4FOmpAi4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

This series adds DDR retention support for the Altera eASIC N5X
SoCFPGA. DDR retention keeps the DRAM contents alive across a warm or
configuration reset and skips the expensive full PHY re-calibration by
restoring previously trained calibration data from a backup in QSPI.

On a cold/POR boot the PHY is trained normally and the calibration data
is stored to the QSPI backup region. On a subsequent warm reset or FPGA
reconfiguration with the retention bit set, U-Boot validates the backup
(SHA384 over the configuration plus a CRC32 over the calibration data)
and, when it matches, replays the PHY init engine (PIE) handoff instead
of recalibrating, so the DDR contents are preserved.

The series is structured as:

  - fs_loader: QSPI RAW partition loading, used to fetch the backup
    calibration data from flash (patch 1).
  - N5X device tree and defconfig plumbing: fs-loader node, calibration
    offsets, and the SHA384/SHA512/FS_LOADER/SPL-env configs required by
    the retention path (patches 2 and 5).
  - QSPI mailbox handoff before DDR init so the controller is ready when
    retention reads the backup (patch 3).
  - Core self-refresh / calibration-backup support in sdram_n5x.c
    (patch 4), plus robustness fixes: watchdog progress bit, double-bit
    ECC re-init, init-hang recovery, error handling and logging cleanups
    (patches 6-13).
  - mem-clk handoff change detection (patch 14) and PHY init engine
    replay on retention restore (patch 15).

Tested-on: Intel SoCFPGA N5X SoCDK hardware.

Note: This series depends on the N5X boot support series "socfpga: n5x:
Update Boot Support for N5X" by Chen Huei Lok. Please apply that series
before this one. See the latest version at:
https://patchwork.ozlabs.org/project/uboot/cover/20260623020221.32362-1-chen.huei.lok@altera.com/

Chen Huei Lok (7):
  arm: dts: socfpga: n5x: add DDR retention calibration backup nodes
  arm: socfpga: n5x: enable QSPI mailbox before DDR init
  configs: socfpga: n5x: enable required configs for DDR retention
  ddr: altera: n5x: rename is_ddr_init_skipped() and quieten reset log
  ddr: altera: n5x: drop always-false unsigned less-than-zero checks
  ddr: altera: n5x: reconfigure DDR when mem-clk handoff changes
  ddr: altera: n5x: Replay PIE handoff on DDR retention restore

Tien Fong Chee (8):
  misc: fs_loader: Add QSPI RAW partition loading support
  ddr: altera: n5x: Add self-refresh support in DDR4
  ddr: altera: n5x: set DDR init progress bit for watchdog recovery
  ddr: altera: n5x: re-init DDR when double-bit ECC error is detected
  ddr: altera: n5x: re-init DDR after watchdog reset from init hang
  ddr: altera: n5x: return error on invalid DDR controller type
  ddr: altera: n5x: use correct cast for reset status register read
  ddr: altera: n5x: fix debug log typo

 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi    |   13 +
 .../mach-socfpga/include/mach/handoff_soc64.h |    1 +
 .../include/mach/system_manager_soc64.h       |    3 +-
 arch/arm/mach-socfpga/spl_n5x.c               |    8 +-
 arch/arm/mach-socfpga/wrap_handoff_soc64.c    |    8 +-
 configs/socfpga_n5x_defconfig                 |    5 +-
 doc/device-tree-bindings/misc/fs_loader.txt   |    8 +
 drivers/ddr/altera/sdram_n5x.c                | 1051 +++++++++++++++--
 drivers/misc/fs_loader.c                      |   79 +-
 include/fs_loader.h                           |   31 +
 10 files changed, 1057 insertions(+), 150 deletions(-)

-- 
2.43.7

