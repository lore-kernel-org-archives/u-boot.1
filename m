Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A0EFCD0A7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DBE8423E;
	Wed, 18 Mar 2026 05:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tlVd84ct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E1D84230; Wed, 18 Mar 2026 04:02:36 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F271A8421D
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBfRuVsFrmCRhSzHzDufjqn9oxB50GYfGZKb9/kX//wG3gWh+4IbvUsf+wAXvfRcFPtldMskVlOgy4G3p7feQZpGSbZyXyj5GiZxq44/0RCiH+fwvhz+GPK9XxFI/PeS6Gafudon8j9duCpz4EyPwyE4IT05cXiVX5x+ENPUTJekLuGLZcDmBs7SgHMU41wdyi73Jg681u92ja+0FfXdv+GDCIdsoUkvRqNDQIu6lg/NY8JJddrDtVttSzf8lnCgRhjyTFYfFzf3P4ceBnyFgUMDsDvUMafvsbipf6tQ5JRZ8M0uMBobm/h3VyCj8PHJTU/A4ta/gptS3aRIr6hvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFcBAGb28JJ/f8ODGZljgzxFkkQX4Ktfq8fslS1hAjk=;
 b=cmRKX2moVnSPu47siXodjfddufXurV5ZYscuiaps39vmmdU1hhOLsXgAI0izVAUqkBJQWNg1MemvcDhFLlHpspc/dnMHG0IGbAglddG0Mmb7ufTwrQjduBQe+gt3qaQdTJ+IUFBm7raewVtA1LY5fUJ4AlzAnez/BTzenRKeBtLNHKjG2xBqnyQbtrMoMAKQP3IQRn4FGoqx6nh7JR9k0hxKkLVe97FDiidSlXoaehMPLYxB46vUadQKPQxZLfF8Ir2/0WZR4S+bdh8oMgTe8Om32tRgbsMxXst0OSZ7US5yi1vEuX99AQkIP8wfufn+/rzbTmBz5E/Vn09ewTBPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFcBAGb28JJ/f8ODGZljgzxFkkQX4Ktfq8fslS1hAjk=;
 b=tlVd84ctVAE5fXftwVd9Xu5nnRP9vxQwKRYAonx3zg4MBh6GkmBLEI7F0+02gK7GFmHwgy1sXInb7xvT4GImYwSXcPhkHFZDPapkdGwOruQggUF8rGAibm4jvlLNyL7I8DjV45FaEceyreAyVQjX7J2vzRYgxuebycr/zZE9+5Pfs2m1PnS1EaFjRyN0/UGmEMZU9Hn8SGzxQdqqg27kzq7wNoo27AtPk9orLBJ2O9JYtodM5JY7uJnN20ndVpMJhw5XO6dXKKcseZTaGdaaR57LSNSehv62L7/2V10/yHUBWi0h8R7nlQcjU5r3EK6iz5ul+YaKkL/3y5oON/NLlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BN8PR03MB5092.namprd03.prod.outlook.com (2603:10b6:408:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:00:47 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:00:47 +0000
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
Subject: [PATCH v1 0/8] socfpga: n5x: improvements and cleanup
Date: Wed, 18 Mar 2026 11:00:26 +0800
Message-ID: <20260318030034.25889-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BN8PR03MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b89ea6-ab82-4e8d-4e48-08de849a8d84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: iU0WDEX96juGKVJf1yvarOEqCkF4HQ96xqfrQf4VRRGFUQVh63qOmRalbx4d722WLEYkLXpsdXvkniktiDfFjFm4RaO8g2PtKPaTNXMB4efQd0yq2Per05QgeNKDs19qzjPW0ESm8keKC1oNi26XJpcU9vmUDTkvBx6Mx6YqniBIN9UA0aB0BYAzlC80E+IwlWqWnF29J3BXb2wLa5fVRX7mGOb4cBs2lOC02dgMuvzp6uqMw9ns1EWwLwusj+F9ch2LGKgcpEL4AIexPXAMgYAxXM9r5v5v/gK2oP6Db2QaEC+3MLSw8a4/BMGTD2YuHLlS/6SqJFGyDkJhMZww4oyP5jw3vLXgh9IiSsOesjQGWiI2W0VYfheo61dEntc2iLJD9MNLHru3AzV+5ERKBL/TaC24GBTVqW2gK9z931kJRUHOt4ZyXWE/ehCGW98Iiaun4OxdrhVWatnCzzVmx2/S8N/fAsI3j9+VANP3PHKiWSSy/oRYMloxG6Cshdn91uX4abfWPQzMzEYGvIYgQ2gNFJJiEv95zLbqERH8RUBlq8wouU/QF7Yo4UZMe8QELdHh1mFQKcIkOCSEARwy+OmLK4XJEp7xJVEb0507ZDMoUhOAIyYqg33pAiQvBYEmr2YMqpFVmyh5sRKoKupA1DEPweNqdsLcRI+Ruc8useVI18YjUEkrDxnmYdLOsz5p6KDgpxYW5Ma9LNAwWc6JyY3fZiKuRSPp44PQX0IMED8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oo+jHiekOnfuiGsEVzFKsGTQoBgwOScVIH7lcGCGLBwObQRhQ88US0Egz4Rl?=
 =?us-ascii?Q?tQ1ey61QRVL9Hn2Axk+8j0uY66+xC1dwBVFUZRaY2BJhGsmobuJV6dzEBB31?=
 =?us-ascii?Q?mjSgckUm79SfTQZsZLKX3Ixf7IArUS31wxyOzh2Qw9lhdcbiYT2fEPUa17sD?=
 =?us-ascii?Q?YCG0t4OIs0mQvbzfBp6zPxeLUWMYcScekYdAMLFZAcDmCV0fYoM6/55F2/jn?=
 =?us-ascii?Q?X3y+MdlJ3Muo3LAEhvvmJsHnGMr8AwK9Dx/wI+ev/Uu8hsxMRM+tDEaUoTNt?=
 =?us-ascii?Q?T0+YYKA9FeTerJEthYUB+NP+mKAXTp9hJ9wHxErLxtLoXC+EAtn//o01CqI5?=
 =?us-ascii?Q?fDCiWaDoXiensbPh6El0LSEeO3Z5MHCI+0qcX7NUm9gT+Ty6Nsj+SF/gRq9s?=
 =?us-ascii?Q?dQ4AXqtaV0WTpXfppAKRoN3uHhdm+qcx4dfbzicARxmLAKu+a0lDtlbTWsxb?=
 =?us-ascii?Q?u3jHXn9CvlTieFWdldJQx4Wdq15MtwksZ3f9eYrUY1qeRmr6BpgPkQuzrxEB?=
 =?us-ascii?Q?LcQHgbQCi00dElLJp5SLbvIMeVyb0w3Wo1N8rjm6/I2u3y7mCJ1WMkHNaEHS?=
 =?us-ascii?Q?7EzWIm28ga3sJneRtlxTxpeavZVkdzwSjg+AWjm3N37Kifq3PGGFXNt8CM4r?=
 =?us-ascii?Q?1rbhxXoqoJjRW1reUEDuoBy1LCg7sigp11GbM8NWcRx1RV/NmyEc1CPqk5Mk?=
 =?us-ascii?Q?0xkA0ue/D1woHIJzD6LyOjK5kyDvTtvYwbmhYxTN4AyQDSIR+XfoJGnxXevG?=
 =?us-ascii?Q?dE+vJgyUZKyVfkd3ilQ2SNF5cNq2AaKirGevD72Sf8vLCRP/i5bm06b0tZot?=
 =?us-ascii?Q?ydwlez5N9c9IcwJaM8qJonKyHbmTZm1m8F2xouqmfGdzSvVDQ1MrOG6qkZIz?=
 =?us-ascii?Q?D/JwnW/METNQPOrskYQ2XscOWzEI4fZYOG2B00AMGFwHhcHuO18Gs5IAj0Vn?=
 =?us-ascii?Q?snfowWW58xqXtwUQT3JvPtomrPyaFz907hBIfzrGIDglHVdMsS31OYzrbRT1?=
 =?us-ascii?Q?cJul+Ry6pY8VG8tgZH2OrHHhYiUqqEIFLNrEzNFUbczzm6K+lP+WnfjFhykX?=
 =?us-ascii?Q?0ITlOHkGN6OE7Fh6MzVZXluzdLWCdGBgPo7pndBZeslIuGkJcQjzJVz5ouGj?=
 =?us-ascii?Q?4YOTY/ro/Ti/gIU852MFHj+/V7CiDr5P5eOzSGRaYFhtfNbF7uEP3Hc7si/D?=
 =?us-ascii?Q?q2v2tc7lYB1pNKBFXvFr45gbHYYvmh0Blh2jSvBNtc/fU99IqD0mVW5DJK/+?=
 =?us-ascii?Q?HAOvK7HxlRW9zgqijWhMGcd/ai+w3WT9iSZF4m08ewF1uR5QjJRgLBubHkfH?=
 =?us-ascii?Q?rSwerLx7ErwDLDnAN91kEP3VNT2528odRqMnoYD6mvH8Lb+AtKXoKWEoczsh?=
 =?us-ascii?Q?BR9nlzW/IS8d2fzgd1P7q+obF8ZXLn24z6d7j005gu9KaPvwD8VhCidy4wHT?=
 =?us-ascii?Q?f0Cn30m0Eb6xQDgKLTJLJGn3tnGEvnzB0xo+TC46RSX0EkMA01SgZwBRYkSO?=
 =?us-ascii?Q?ceAGVaObht2DYQpiMLTT/IkuFu/CXRt0/x0KT3ZlKDH04MDxxnKIMIwwypXN?=
 =?us-ascii?Q?C7Moswlm8M6BhVOdAmsQZb8/wE7hVq3as8OX+dq+drJlzWC9zx4bt3sonkAT?=
 =?us-ascii?Q?JOWpQ9OVwiSU3EC+dhy/9FP/u5b8MfDpLL29NwryTEBerw5HMQIpI8Fks/BI?=
 =?us-ascii?Q?9UCWFKVHDwz8cwTyEPSAX6i6SwgnSG2Xqzl6RHldWarF3oJw7EwZ4MIuNwL0?=
 =?us-ascii?Q?L87OZ4voUnfYOfSSNDYhjhFhOjUW5Bo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b89ea6-ab82-4e8d-4e48-08de849a8d84
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:00:47.0973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVSydoOAvYYQjdB6wx76i0WKjZyhpLqpcY3X1SCxr/c0BLKrxeNEiw+yO/IyORFRo5K4S9zueanwlSRM8gS9qBu+2fVTHJLyQOiTpE4yJ3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5092
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

This patch series updates the N5X platform support:
- Replace defconfig with ATF variant
- Switch to upstream Linux DT
- Convert firewall setup to device model
- Add ISSI QSPI support

Tested-on: Intel SoCFPGA N5X SoCDK hardware.

Chen Huei Lok (8):
  configs: socfpga: n5x: replace defconfig with ATF variant and simplify
    VAB
  arm: dts: socfpga: n5x: enable DT register settings and update GMAC
    nodes
  configs: socfpga: n5x: enable CMD_MTD and SPL SDRAM support
  configs: socfpga: n5x: enable required configs for DDR retention
  configs: socfpga: n5x: enable ISSI QSPI
  arm: socfpga: n5x: Switch firewall setup to device model
  arch: arm: dts: n5x : Switch to using upstream Linux DT config
  arm: socfpga: n5x: Update SPL data save and restore implementation

 arch/arm/dts/Makefile                      |   1 -
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       |  56 +++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  21 +++-
 arch/arm/dts/socfpga_n5x_socdk.dts         | 122 ---------------------
 arch/arm/mach-socfpga/spl_n5x.c            |  30 ++++-
 configs/socfpga_n5x_atf_defconfig          |  90 ---------------
 configs/socfpga_n5x_defconfig              |  31 ++++--
 configs/socfpga_n5x_vab_defconfig          |  91 +--------------
 8 files changed, 122 insertions(+), 320 deletions(-)
 delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

--
2.19.0

