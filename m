Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0539BCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B56D83CDF;
	Fri,  7 Nov 2025 11:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X8pCFPyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD96883C60; Fri,  7 Nov 2025 06:49:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7711783BA1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 06:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqYHEtv9YyP3uJWeX3Zb4BOVh+l00drmIhcCdJmRdDqla4i+wAYOzjq6+HrTQyUE/2ZD7dXk2kIrU3RVP3s1uJh1Ls9fT3s3QI1IPXcoliXsm7AsxVdU1vhNpfLduBX/mHNvlogSXMbJtJJb8I7+ZEcxmxK1bzPKPIr+Ww/igNnah4GB7xci8WMOhpsOc4xcS/kXbMTJdvCVDEhIbLRVhRcxejDkPOue06bG6cEBR0LRfhVdROemc6rtvG6ZL1lE7RXsZTgePbp6Sihl0mtlYfs0NyjCuD0jSEfPX484f/0E5xtxyQv+OTgF/vAjhIyijWkj0uwN8LBGoE66KVVwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzgys5phRV0yoVELB1e852vhvU/9SZKCuRcp4aQs9iQ=;
 b=DmaKw8CblUSJEUwBzM29sgAVA5GOH7xRCDv8adOujRno3qxnRCbTZiLLJLI0DU06oTtLvFs7MnDT5FvP4y17xTqqLPOLYJKxWSGtLHbxiphINp+BLgHQao3wU3iLLOV7Jc4FJXOHErqj307vrkUvLQhBDNhzN9ZYzz2gFaBcv1Ki/0VtNAT1Yb+6KBSIUKeQp+Zp4AtveKICy3fGVYVS8tu3fwtcBGjnSrCbyxI1SpRrfjc8KRkWi9LYZF66Vl5CentiqcLmSQnqLbfyT9w+SSQ4urG+9fsfnYo6nUVLvc/BDdHTn9GRunF7xv2QUu91Axo+7lqUO1HFqP29UsiYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzgys5phRV0yoVELB1e852vhvU/9SZKCuRcp4aQs9iQ=;
 b=X8pCFPyVhNVjmATQZfRfllRx2A4lC6QqFjeI68rKIZmh/wB6o+m7UfZlPB0C9pIkbJNbCh5/loyOHrHQxvtSj9x2O7u/4Rj5SBCqL83VSJ6qdqoe5bkuCPCfHQYEZkJybPDcwblEXMSa8Qfe+GljbvN+AaxstMLHvvVnubo7GgdQlhQX0VZhAF4h88niTPTOT/uot4U6AwvkHzVc0IxGVFSuBpKlD7eJdANgE0hRApjCb6LNbVyibiibmdfwaLIFii957aBFx3ndhTQeWVtZgiYcBUULi3MlHuWpVpD2IdD9b+lx393ID0OyxQg9ZGYaEVnK/7ucU+C+Wtvn8TaJaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:49:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:49:31 +0000
Date: Fri, 7 Nov 2025 15:02:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] please pull mmc-master-2025-11-07
Message-ID: <aQ2ZUlW5i4t7lMr-@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: c2055afd-d2f5-4027-785e-08de1dc16bfa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TgvleOCvIMEPfotydiW2ldaUztz4kwUV9ZffncRJNIDO/p0OLGl9lZAxDvqE?=
 =?us-ascii?Q?yKo20OEM8l/2K4xUULnLsEuZ9XI31rUXBhhs6mvuVpPBxvUrlIVpFb4XU34I?=
 =?us-ascii?Q?FiFD3pCTq7QjG2gx5BAENtl2H73olR3+JZxX9tBS6ljKYzoJTKRPwdMkOYnK?=
 =?us-ascii?Q?xYHbeYsIUj04HH+oNKOnP1e84oiW5+/16lh+H7W5aNsAZtY4zs3WQWidiRze?=
 =?us-ascii?Q?1nl49/of5UFQR7ZXmwb/fTkERH4rscgKaJm1PThP09g11P4WzTBKIG62FvnT?=
 =?us-ascii?Q?AIHXFqln7O9cgNIisf6UiDuj51Xrf7KESlbC4rw5qkL9rHGLyOahXZox1YKP?=
 =?us-ascii?Q?9ijxDKjeZ2ejLfOSLIwWwFnWlR+6HDtmTS+9+XOf7d2/9Ac20LRjT3LbCopk?=
 =?us-ascii?Q?5SeLWFYSOX2aVFjIhvlOfT4ZlulzDDoBw18PtAlfjxG0zXfosrO9FnhS2qP2?=
 =?us-ascii?Q?I7yYJAGY8JD51yNhANfhiiCOhmx+weYyCjY1lXCUrBeF6jdRX43bYJDCOGTN?=
 =?us-ascii?Q?/fpCuJYQl3w9Nf0bHDG+g3flpIkmPbpKLuIix4Ro9IzKgwax9X7iWqwp32Pf?=
 =?us-ascii?Q?58fpmD63SRm4cqX0cACQRpMZX8my01Vm+RtghtSS4w3nuuJ/YhXrPsbQaWBe?=
 =?us-ascii?Q?rfw+gKedZ1oYUYf8hCBoQKL4CYTUYXPHUNp2md7eJfprBJ/8zr1w48jvot1K?=
 =?us-ascii?Q?HUGH4hxlIu3xdp/T14qeHznVlHjfqjnEKHP4GE7KepNch5EVQL02B4EKL4Fx?=
 =?us-ascii?Q?CwfJUjHbE59BiVhMwrw7LYPhJEDw/nIupe08sUYzZQ9hDnHCLslEatqrT1XF?=
 =?us-ascii?Q?ffLXB4OcPb2QSKkUqdX5GUR+IG9FqnRIcOUVCKRwmh/xnKyi2wS7fbBti/v/?=
 =?us-ascii?Q?d6SVR9MnTuDQQ/BYEwtxFqgTLjOe7lZgm1KhNbm77rqBbMIg75duSIYkmbBb?=
 =?us-ascii?Q?nNFjuW9lYxg6MihUWNkTOcPXoJY585Zr0DxhNG6zrEN3NnbkY02PqyIVvBSw?=
 =?us-ascii?Q?cYr8lbYAFoKEqCHyKgLu1c4N6dqlNPyE1qEE7rcJZYp1gFF/tJel7p97u8q3?=
 =?us-ascii?Q?OaSZVLE/aq6aqsUyT0FpiQpLMPxalFCfY7Jo6Uzwfm0voty6kDWw1K7j8NNm?=
 =?us-ascii?Q?JyB+Yl4iVAvGsKx1dntpky1bMRc/XvC7o1AoW7QdUjwLVHExqmCJKYVQQqou?=
 =?us-ascii?Q?WOM7jK0moIO3+rbWjxj94rtS9Be1+ttL4TicaP7wwZTWGcZ5uKu1IehVA9PA?=
 =?us-ascii?Q?ZiF8Tq4G0vN3UNxEiZEXvPa91d3Q5bvU/+l8BPiw/3QQLqxe5C60WNgt81TQ?=
 =?us-ascii?Q?cBmIxxaja2GGOMf5EKBtjEzh4NlYUdRiygPBnWMtoLMtwWRTnMQj3597FUzy?=
 =?us-ascii?Q?s9OKyYcujF4QxzgTDwou5pAtpqileu+q9fJ3PgXYuuTvqDW5vV4g6YnEOEFw?=
 =?us-ascii?Q?Wu16PUNWzMjJ9TBMfd0xkE+Oic6JEhllVAEwzBCVSm8MBNdWqKvh5HZCcB9D?=
 =?us-ascii?Q?B6enFXmNioIQCngR52vxrGIUMPnf9b0KhU0j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kIbK9kAv9RUBAzyifuK/btldQAkGLUpamYwI+de/tudNd7Kekz7jslqo4w4U?=
 =?us-ascii?Q?MDONLfBOyAqYb1WGqXdQOD9B2V7UrJ8C5x+kNDZHCnLDBNPwOlbzcTcpnLu4?=
 =?us-ascii?Q?UB4VaIz6lfD75Diw+xYldF3tsrdTzu+fWFKqQnswrOWQgDFD3kTMY4CYejMz?=
 =?us-ascii?Q?CcuKafBm3JLMo5ghyRwFq441DWbkfki0YG7RRkVQcg0xIdT6DclvwNSADBMK?=
 =?us-ascii?Q?XBdOFkP7jBee9GP3lTwTjEOykUYV8FVD4b0MCwyev6vpu4NZ2GF8S2sQUTw1?=
 =?us-ascii?Q?BAxOl6BKcPLHWzOKAZfaHRmcR5Ruy7wJb6xEN0oemUnG0FPJDZGg6rcQ0JFz?=
 =?us-ascii?Q?MrkF7M2dGbSeVYJuvn0qJjqf8bVucn/OGHlPgTYGpj7ejdkr6p8+djteWmgf?=
 =?us-ascii?Q?LAvMm/MprHYuPNEGKjPeCypz39/J/0Y5PHX+PTY8hUiMnLTh7BVj+rJCYb6A?=
 =?us-ascii?Q?Pv8woa0SGjtksyv4dUFeWQ6VmrTjcAU7hyq4zwrFyLWNtOx82rvkE53sF9na?=
 =?us-ascii?Q?NMzDvI8lQ7W9vq5osmKa+MShqzaEeYxgMrsdx/QPqVMn2LDmahSs9PQLvgQN?=
 =?us-ascii?Q?LTNwgy3ZLVHCSh3+8kiKRy3WHMHKXUWZUy8wT5ewfjjobmjrajx2MhKeeKQ0?=
 =?us-ascii?Q?9RTGad1Kqpa8RGcj7p3a0OJYDx+ywevbcUB6eqaeD+3Jr+aI776UJPT/2BYG?=
 =?us-ascii?Q?F7qz4/admzLSg0RoQqVGjQqR79K6fBH2rNRIkzmi4hE5wkqwB4zKYiyUboge?=
 =?us-ascii?Q?HhGIBE/l9e6l1yhZ5FXOucw9RusCDs20XXVMULhZwctYbKGhJVK+t2y28T5b?=
 =?us-ascii?Q?tYQUbNPFFVet4W+/nTl8yIXoU8hIDD/h/N7Gf7tlG8qGMgNFNp/dAq0OTIJt?=
 =?us-ascii?Q?H4BwFcrUdGPv9QjOyeq8VKxghg4HFwy8SYhmFkDMCLQneVSgClJNKujAKLNB?=
 =?us-ascii?Q?l0W+xU/IEZuyWCulID7wTywnjmcwq6p2pqz3eygfyBMJQXTvEswC2JS5q85z?=
 =?us-ascii?Q?DWHyaKcAPsCeVbGFwd0w7M3kI12ddvzKF1anrWDSosh8cTnSYqMmB/jpPK+S?=
 =?us-ascii?Q?4RNn0Qlys86097kcTPbWpY7t1MGbjO7T/dsdGgiFh+hEkEhxBw7WskgNduHx?=
 =?us-ascii?Q?16l+qW418Lp6SThVlLxEBVPb5U+fdwK5VO1VLxkTXCORRS1318Zkkr8XFtF+?=
 =?us-ascii?Q?OkDqwMBP646wWxBiJSst/8kMzd509roCxvJCPPwFUhDorV0hXyWfl4eMxHx8?=
 =?us-ascii?Q?+CMieap4kTGaHbLyteGszPkSuw8mhLnYfeBSZ4XIRJzq+FMU3WjtNC51/IDh?=
 =?us-ascii?Q?uxlebxK7Abpc1hngG4bXbgEZIvVXOHk5uAsrMyOJko8h0E4NLDpGE5ILyemE?=
 =?us-ascii?Q?e3iHumzCBUeXyqU5BGwNeKFiA/k47q5MsxWE1qiljDXK+YH7vRd2egluIHGJ?=
 =?us-ascii?Q?VKV2aVUAsQJk/70KLsV3k4Ai+isep/Zh61cDnT4hwwid4bXyWtdBzS61ULa/?=
 =?us-ascii?Q?yRhui0dmYB5WOEggLlvwGkvnUTyrueUInltnFaveRcv6PrKKmaN8vxzDoNTh?=
 =?us-ascii?Q?YtWkH1icDy8MixgMZifn+qCVpI11W9yocmk4hTnN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2055afd-d2f5-4027-785e-08de1dc16bfa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:49:31.4785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfAq/K9OL0UzoIJBc/VsklSkHi4hkQq6RJFEUWI0BKxaQSWn/9OMpqmV8fgp9AhFZh9XZDX7FutBWGk05Z5P9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075
X-Mailman-Approved-At: Fri, 07 Nov 2025 11:22:57 +0100
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

Hi Tom,

Please pull mmc-master-2025-11-07

--------------------------------------------------
- Disabling FMP on Exynos850 to make eMMC functional
  when U-Boot is executed during USB boot
- Drop extra included errno.h
--------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28218

Thanks,
Peng

The following changes since commit ddc916334a7a7e180b532dbb2cf1b778466d2b9b:

  Gitlab CI: Rework our tag usage again (2025-11-06 15:16:51 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-master-2025-11-07

for you to fetch changes up to 0408ae531fe8ad01b9b788181fc5b91e0a527b42:

  spl: mmc: avoid including errno.h twice (2025-11-07 09:32:27 +0800)

----------------------------------------------------------------
Heinrich Schuchardt (1):
      spl: mmc: avoid including errno.h twice

Sam Protsenko (6):
      mmc: exynos_dw_mmc: Extend dm_dwmci_ops without code duplication
      mmc: dw_mmc: Do not export dwmci_send_cmd() and dwmci_set_ios()
      mmc: exynos_dw_mmc: Improve coding style
      mmc: exynos_dw_mmc: Add quirk for disabling FMP
      mmc: exynos_dw_mmc: Add exynos850 compatible
      mmc: exynos_dw_mmc: Disable FMP for Exynos850 chip

 arch/arm/mach-exynos/include/mach/dwmmc.h |  6 +++
 common/spl/spl_mmc.c                      |  1 -
 drivers/mmc/dw_mmc.c                      |  6 +--
 drivers/mmc/exynos_dw_mmc.c               | 78 ++++++++++++++++++++++---------
 include/dwmmc.h                           |  3 --
 5 files changed, 65 insertions(+), 29 deletions(-)
