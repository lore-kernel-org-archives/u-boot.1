Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E50E63CBF
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F27F83D0B;
	Sun, 25 Jan 2026 21:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KMk9NUT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF4BC83D8A; Sun, 25 Jan 2026 21:24:02 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E1C83D07
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 21:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4slmJ4Ee5itseyxJKCTw6zJF1LZLFO6DFabfXa6uGE9VWkuT12B6V+3775plmys2DtdiozFXdJgXk2yvLsv97ztoR7P/aHjLGymiV/abBMLAq6aNThGFKBWTgQfQ+xL8nxgcVEQkEkF/GqFMuvqSNCzsTuOat6LxpWh3FfpeelKVcvK0vbj9p9BEmOUo5V2WlnO+L2aEVsaQayvASVNExfK02E0WP2IMU1ZUZVKILAAvJEAWh3avv+qH69DNFq+r/g4+11u2AghZBGbLeqbxeRZaTSg/1LQNCTsD8FKGPNugYJQdpqmEILZl1DFllHqXYVYdmBw/afHW+XaPaNP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f7RbjZyO0+07UhhtdUYgREOeJies+0/dxTmSlM30RI=;
 b=mNzP/MuGA9AOVJg0Hk7gsxEB0Bx1QGsTOA5087rNzkSOOWRMjk0RoIo/CY/YAaGyPqFjOgXKiBp1iY4cu4Fvv6NlJcSmhGmYvQ7n7Jer9OLhpdLSodIYg+EZwC393dYU8OV56yJ4JXzLuTR1w6blhDNjqg1GL+eV3z6N1LSpvf1RFoJ2/uMFNkkZ2Tzdmy5bHM0T0y9c17Gj3gdCJtqc6u5mDy0m9CDBMLH5SUZJx/3L3HcUlcg6ejpwjK5dKHaLFzfmrLZSSdTLUeepy7aZBOPxCsqzxqKh3GDtUIG5OhtxqpNouVWUMMRK14p1kB1IGJ/fI3J7X3b0GTYSBBCOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f7RbjZyO0+07UhhtdUYgREOeJies+0/dxTmSlM30RI=;
 b=KMk9NUT1QS+IJmoRK6ex8hCnzw9ptj3YJe4R0hgy1wtI7MJ+D/zio5GV52opSRfLqWiN/FnylFsFcmEJoWm35G6fjokRWp1YxvbnGQYCr9jBHqR4PuUADw77SuJ/MIJBjRLRA/S+BYihXKSVFJJ6DCJtFlzc/AMSYlwe6fNaiHR4+yI7gQWjvornAOr+HkYkGEh+ARlYJrDOp4azeBi4IHrconPcnJ3uUgWyRqwEKYxkBu2HWRAHLeaHi6PKhyzf0wy2/IQxAa/Xa/G+eXGCJwc50kxPFrgu5OhgEmIL27jShizLZaPvfeKThrUPfRC35HhV2pyrrDw0WFdEFhz03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CO1PR03MB5794.namprd03.prod.outlook.com (2603:10b6:303:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 20:23:53 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 20:23:53 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 0/3] arm: agilex5: Enable high-speed MMC modes for SD and
 eMMC
Date: Sun, 25 Jan 2026 12:23:26 -0800
Message-Id: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CO1PR03MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a76f69-ebc9-4b49-3c8a-08de5c4fa82d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8i4IL3iF//EbqAtkL74prOuTpEh4P6/UC7iekEPeSLq42vRdnTsL1+OntCC9?=
 =?us-ascii?Q?ccT1gszlHrmM4MAZBAm0v1VBMTvXbwzIy5X7vqg/8JiFtHDQ0npgbKeuWRUI?=
 =?us-ascii?Q?J2bQd5LCSF8ZX7Z6Xu/xbvd0kHA8B1/hErhc3zNwMZEuOsib9g5KEwibj8S4?=
 =?us-ascii?Q?TU8QDR5A0waY3N9TaQDDwMzsu83eJoTFKkUUDkUHsum3rsjc48sF8BJ66qTA?=
 =?us-ascii?Q?YrEK3f2uBV9lIrVyZiNdS3wGhy/RlEzNm931iGBmwGa3OTXWBgKCeuTvf0MQ?=
 =?us-ascii?Q?LUWSkcMq+Sd7rwiccCqqFUfsTa9/N8c5+qA/LpmbAhRvIZ33fGvauEJUYjpD?=
 =?us-ascii?Q?0ujz0YUo/HyReXGkXH9MBRxi+XVlSKVjHRgtrvgAC9UbdHcnaD+iVBNzPt7s?=
 =?us-ascii?Q?bbTg9Qvzmh4u4SlYGjUYEkVFZbd9gM3uLcTs4UKlrSkzCe1pjzuDZsPzGZe6?=
 =?us-ascii?Q?GqvVdboQIoktUtrS1bgLlkKIE0bUjRGyUhjIegSBWFwJQs+cXWchPlL618Zh?=
 =?us-ascii?Q?EZspB9vPftvjkKWSngO1HzdYI7C6s1FTsDni5aB46dFXOMQa1riJ8/0/2Cdi?=
 =?us-ascii?Q?auAvXlsSHenYdj34WFSzCBVw58WHnGAU1c1X6v2Hlyl8wn2KvDxkLXA0Bafe?=
 =?us-ascii?Q?MaP4htmMmpVb3P/BTea/nW26cyo8hy4p1JP4co4GmhSMvmrZTsaNfv+/8bmV?=
 =?us-ascii?Q?fGbNLWsSxmMkDp+bS/A9wqk6COKj2SuCIcKk81XPJEJQqM8kj/Zm0pcIzlUT?=
 =?us-ascii?Q?7UPUlEPlLzlYa5Y0dbhhU/WztzN4XBe1RaejFOBpt1M3gJHQgosfmV1LNWmI?=
 =?us-ascii?Q?JnIbIWDNDPBJVIk8OO7sQ5m3MuoBc6jKvQGi2UqjxN5jpsN4DJPJ6tyBhJkr?=
 =?us-ascii?Q?4C70paqhCz7opEhqoDr65LNstX6YTwgzqeLOyHaGs3hbTa9vXsc8P9sc3Ijc?=
 =?us-ascii?Q?LIohwUGy3Q/CiT8aOVuN/cF7gGcobiAxmP3vDb1sWZ5c0MpbOxpH643s+fAd?=
 =?us-ascii?Q?hhfKJ+oAdB4o1qAebO6d2DXFw5Xo96LetsWci7YLwS/ukbUizwzZArfHlO+k?=
 =?us-ascii?Q?Rz8zEHpf7VB23u48Y7hNYJPodAbKap8/6+NwJIinIxc6aM5TYthNCBbMExFM?=
 =?us-ascii?Q?1uFvlqVhswuWfIPou7pXWQGKZBy6+4c6tdAon3oM11blsnLcVFJWEq4rS3qf?=
 =?us-ascii?Q?t10T2rMx5O4QHnijosyBl36Myp8xpz4CiUq8nMOcIpzVjthvWBKTptBto9u/?=
 =?us-ascii?Q?AyTFl5WehkS2Vi/aW3OqWV5A7d11ghDpFGYj9Ke0yvFEBXx6K2pULr/c9K3m?=
 =?us-ascii?Q?pGW7vzm0iVDL/XGxDBfnK8JhlC1Ah7z50frBB0LBUVOgR38vSVsPwZ8knc9+?=
 =?us-ascii?Q?9Ga59iQBRvJoybCjuG0R5Vud8wE+GitEnkf1Q3KgMvaWF2QncRvVvg7fh8xv?=
 =?us-ascii?Q?aqBnkD1DLVatyAdbvKzADhbh4M17t9YL1bE/zOgSrlCdJTAuelMAMdAVUkDt?=
 =?us-ascii?Q?x5kTBtSoz2JuNO8aoXY/XKQ25CQyrlQduZPt1EyPBH0U+vLSj22Pj+LL+z9m?=
 =?us-ascii?Q?6/gzLewjGNq9NBqXspw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Fmuf3gDQ1hJLJbhRGCqy5eyloZvAAxAO88W9CBhifY3peLgNPW1kBtWbEGm?=
 =?us-ascii?Q?4ze/WYJTiCIJs67eqXtcWOFWmpSDsUsBZc4LUd4M4m0Wdu7MTt39ZFhiTenc?=
 =?us-ascii?Q?4i1cPXtDqb4FTltkMpOW//uguLGadj1hiLFDp/8Hue5yHgutkzS4GdL9BgPP?=
 =?us-ascii?Q?5m338f6YHHqPyQQdNDl0gnAA8e/hhE2r/fh/aj1vl2tTtP8f4nQ/xT579Mb8?=
 =?us-ascii?Q?VDvJDlj26pcqx0pw6GVu0ucCi+WXkg/+Gv5aBW9aYnJOrlhhW4QGhwwAjMmA?=
 =?us-ascii?Q?nCK0YdvDhJy2hn5awQ0u242kVW3Tb+rVSctNHeyfqWiY1FsqusvK+HfFC78B?=
 =?us-ascii?Q?dal5Np6D+DsO2IT4ao/SkXAK1EywWQSpdAdFIcrWc7JQ8OfMEDUCX1x5JoNf?=
 =?us-ascii?Q?C6BI6mXNGQzsb/B6CC2n+05fHkJ47YJNd6LE8vQZ1+YHc+S0psNeadvi956r?=
 =?us-ascii?Q?piMpGKCvlK51h0VpBwjCO4/X4n8SQ3hVQd2NAItXKjO9oOsh16g/c9BWDytP?=
 =?us-ascii?Q?lRlPk3wF5PqCiidY0rvB4CrYjobdZlhNhd+x/UuObxKFkWilAkn+zau35sLj?=
 =?us-ascii?Q?bOSioDumvYiY7k0CZ9GnjGhy92dGbvVi4IKK28E26ZGxD+Ka7bBC7wvy5MaJ?=
 =?us-ascii?Q?XIBwBGUYmY9UUrD79TV+Q0nwCEZ7b6qKnS71I5krTBVxYu7b/Ev0o9UUUqW6?=
 =?us-ascii?Q?WgpUTaT/AD6nxR794LsxBv51doWAE7TwBWOgqLY2Yab0r+NU9PYx/1Ecd6Bb?=
 =?us-ascii?Q?YvUUdcFV4CeeoY9AlVPGQa9t4cByr1xE/RnDU5a/owc4+C/zFoeXSX8V5RGH?=
 =?us-ascii?Q?iA+lIYdIz0v7AexdmnIEtXgTDGNW9Q1WlWkgMhkQ7Yl6O1zV+0pCcllPOfUr?=
 =?us-ascii?Q?l38WERdrtPEh65wkoEMQowmRLk3Kzu3ZM2XY+B6+UTWpip1POnIjvJX7ms5u?=
 =?us-ascii?Q?rAewPI1zzJObyqtdHQeILSEfvnAIZKY4ORWwspoAtdS68Y/A+8plB1LUxpZ4?=
 =?us-ascii?Q?bYSkhNU9sJOtFu9I4HCQMDW4b0CtqOZSQiIaKH9ErWpEkiHmI8zYFJXK88y5?=
 =?us-ascii?Q?O6/2fbqwOMa+ZWPOm57s+mJe3JUoWTlSTaA9VvI40h4qXoE4tnbvpQM5QTcK?=
 =?us-ascii?Q?h2krUU33CNDEIRAMtxg9dnN7RrOerppDldrMLuaScjRzU4UAlsqwnHEoTxzC?=
 =?us-ascii?Q?7wS2Ct9COre/NVOELePiH5/uV4iVMsyTvzPsEuV0HdLh8OPoBrwayN8mIPP3?=
 =?us-ascii?Q?+PvagHGfnLvvvRJqW+4KNYj529MmSelaAYckG5ZQ1zjwfooOWUp0z7t1e91B?=
 =?us-ascii?Q?98qGxo5Ql6sYZlF7tuKBiL2jKVzMS0HQbW7GnCsynvvwbX30BywNiuoH2CUt?=
 =?us-ascii?Q?Q6rNpJrKMM5DH0wskfSMAgvHE8bUoR9S4yigfT62+MiJSS55a/SUa3AVWyG6?=
 =?us-ascii?Q?g++ulhBZwdaXcyAyTHyQylNxrPIKJ4jW1E82rrTYCECX+CuC0i8ROuIaaBCi?=
 =?us-ascii?Q?tCruAHT8k+4rr4IhMDQMFTUqauoGTMsx1kBezkmTMIO4F8f2THk19Q6JB/3/?=
 =?us-ascii?Q?bl95WRp+qAcGFbkYy3uXaYcjtN1EwQu/suZfrfeGzXxuT09TgO4UfvT5nnGt?=
 =?us-ascii?Q?NT9XGOyE/QqrbW72DdVp1cyi01/OIS+/eS573wLWrguyxMtajgA8W3ytYRXD?=
 =?us-ascii?Q?/Rh2zCGzAOBy0AqCqfkBQ+/7B7usdQQD09fs8zFk/VknKcwkrgknCyDBSY4V?=
 =?us-ascii?Q?FR2Uxv02+UgtQejsC4EQXZfakdTWlAI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a76f69-ebc9-4b49-3c8a-08de5c4fa82d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 20:23:53.2950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h813DFPTQx78rHGFMXauevYmr9sAgU+eoanPRqmk7qIOxtQjuckD5W/tMPG0nj16UmSpRH57JAKzmE3VhqHnbp8mcYDuB+Ndh/SPGmDWnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5794
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

development kit, improving storage performance for both SD cards
and eMMC devices.

The Cadence SDHCI controller on Agilex5 supports UHS-I modes for
SD cards (SDR50, SDR104) and HS200/HS400 modes for eMMC. This series
adds the necessary device tree properties and defconfig changes to
enable these modes.

Changes include:
- Fix DT property naming to use hyphens instead of underscores
- Enable SD card UHS-I SDR50 and SDR104 modes with PHY timing config
- Enable eMMC HS200 and HS400 modes with PHY timing config

Tested on Agilex5 SoCDK board with:
- SD card: UHS-I SDR104 mode at 200MHz
- eMMC: HS400 mode at 200MHz

Tanmay Kathpalia (3):
  arm: dts: agilex5: Fix DT property naming convention
  arm: agilex5: Enable SD card UHS mode support
  arm: agilex5: Enable eMMC HS200 and HS400 mode support

 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 31 ++++++++++++++++---
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   | 28 ++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  2 ++
 configs/socfpga_agilex5_emmc_defconfig        |  2 ++
 4 files changed, 58 insertions(+), 5 deletions(-)

-- 
2.43.7

