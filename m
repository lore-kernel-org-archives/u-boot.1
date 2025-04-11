Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E199BC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 06:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3384283EB9;
	Fri, 11 Apr 2025 08:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="burtqPwr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C511883EB9; Fri, 11 Apr 2025 08:31:03 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A1F83E92
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRa0MgdqE9FpZ8sBeRDIm9oHaTFly4YSaTeeArgFV5B7w+wHTDnOVFXZsd9NXnCXrzfcCp2tPr9bYGwzlMzrLqOdmP0V2kpbLudgaW9lKUzaH1tWDtEGdjltqmD3F9chykjReTumZjl8x2i33NnNDFfIXeTKdNtFZ1b/EmISinhlHzMndlNqykbvwXb/XZ5vKfDtCNy3YOalD3F+8TvX0TLsDS3jJ2BK0hilK1XreNPuElBYypG2O9cvYp3bajxmxEzuwLLfessldKzA6w8rHcMTxhncCOrP99G41VaVKXZrlFoorJYrowPOonnl0i2djPnR0OJIK5ODS4gwzeIgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FER/824kwWvnCafz+yTDaz1IgKHrhCwuM30mV/Q8ses=;
 b=ph055KgpMwYGac0/XjhA+DAMTEWVwnvmqheUydDITZtyECXTqZ5B+fVw9uUD0sWjiOqiMpt5pPdkTrsFBAlghLWt3eFRfwoTaOfY4raaXDjKJbH8qUO++c4s3U6btZC9Q0PMuH+CYlS2SGC16rrQBppoqNvP+IGG2r7t5h8qEBelpGtHvzrA9xuHGQ1nkzDU6FnNbGNeXN+wU0QjR851j2TpkzqvvgA7LuKPLDVoEzxe8+ktleXlpYIfxmYftwWwCp057GgiNhCaIZmOC4nQds9MSvFj5jPhdR4ydzxd2/ITPGuzCU1+9nU1ZKPfKn0aqxb4Px459F77hZYliEHTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FER/824kwWvnCafz+yTDaz1IgKHrhCwuM30mV/Q8ses=;
 b=burtqPwr5/m2bCekpGN2t6aC8xrGLvBez1lepFcLz+2QzeCobttGTDSG6eIEFQ8HFqzVXLw0dX1out9chj9gZigpAJbH2IxiFXpJgwl5Br8ouaOJJBKGWbMldvjC0PfDyknHaNxx6rq9EPD4f9r+jM6KLL7gCojcCd201vI1HWqMs1poPbWCTS8aUeL3xvpbeHJwsZyCmb6IqDN6JgH46EHl/fbOr2NgoEoFuNpg/TlaZxeMzXJJOGFRjbb8a8snPRx8BrSXYd0FVcXeqJaeWPU2r8RPM0/9whHYb7+7QisS+EDFQ8+dXI69/K020mn8I5osmTBwqyT2Uz+QuTN9UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA3PR04MB11202.eurprd04.prod.outlook.com (2603:10a6:102:4b0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 06:30:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 06:30:58 +0000
Date: Fri, 11 Apr 2025 15:39:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull mmc-2025-04-11
Message-ID: <20250411073923.GA5328@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA3PR04MB11202:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1a52bc-4397-4a03-54cf-08dd78c2693c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PaJ1ViMK2tFlYseXlwiVb7ialr+38iUj90Q1/urqVZfSUVUCe3+JT+AZzo6b?=
 =?us-ascii?Q?JwaZ5WiJc6tg2eOIhWHt6pxyuh4xZF7Fmf+2SSVoQy5Px93r4DEMFIqH6tGF?=
 =?us-ascii?Q?B+3EmQhq20NMV6fLcsdCs/Q6mSYB6yvxh4YoIBJ0hHImZoK9HY+/pYXVUl14?=
 =?us-ascii?Q?EyegHb4N8fkQoJgEUB0BlgmtxpODaJ5lGNdgjqgbdqj4WkNpPedH9rvKhcBL?=
 =?us-ascii?Q?iokEIZ6GDmyxBkwMELYpRXpZEI6AgFNe2DRiBwbkn6btWt9cCnJKsoBjs4QN?=
 =?us-ascii?Q?PiLoQ0SMDvyRacxiL8wABmPtB/1ia7cRq7f7/Uyndd8TrXNYTW05xKcHxg4o?=
 =?us-ascii?Q?M5VJ9E/4vkSWew20aMZua9a8T9wVjpnrMVCoxTVX8IZzMAKadPKAjaYNjXJs?=
 =?us-ascii?Q?5tH1sbljEy68tG/GZ5HfHVZMz8RecIKO/CcB9cK2ME3sTasRgfOmSDJW1CKI?=
 =?us-ascii?Q?a8omdsH900Nar/6ozP+8KzMHJyQWA9iV4eRk/rb3AhUpuq79qA/UtUbRw1RK?=
 =?us-ascii?Q?vTdE/VVGwleCP19J/phuKcKQsMY39ET7b5uOK/MI5vyrR/bvQwmwXOorlYat?=
 =?us-ascii?Q?7vt2s7yGZpla9bn6ZH9KQ9BQ60rydMnDmhpDCSooFeheWYMokp1+cqpsEtDy?=
 =?us-ascii?Q?OWrrlwYxFL+oOW5xs0B5jjsY3+WN419XhaVs59J+WHf89vz3oqMJM8b1GAUp?=
 =?us-ascii?Q?Z9cfZu21xkRxPpU3o44KhESSJMB1DVypdWKGxx4XZMWufRlea6YoEPmQwYOW?=
 =?us-ascii?Q?Q3IfNlRD1x7HChBh9PfUe1U/nBGNu/SogXueUWDrY/bs6GzgIL6yeTSVdjlX?=
 =?us-ascii?Q?kBsjolR/2Fvr4o5Lyqmuv9fx3lZ0KQ8C0C0q+V4aiTEaERdfa7oUbFvs+DP/?=
 =?us-ascii?Q?d1XWGbeO4TUhqWnc6JxyR0urCND6nHJ3CjQidIgqQe6hEewtF16LyP9NgHF0?=
 =?us-ascii?Q?6sSfqsEBvbXn1+UF0dSEkJb2gve9FgtkOrxA/pQaGnyqrmXEqlEqg6iPh/Cb?=
 =?us-ascii?Q?ki/g5cGVmqNuukj+ija+8aMPkcarKvSzRt+oiV7xh/wvpurpuVRaRzivd5js?=
 =?us-ascii?Q?C9U5BYTc83BO90032fhZSDKvlE2987XHgqBDRLSBajLVP7tsMnjri4ZxS8N/?=
 =?us-ascii?Q?lWnWvTOGhjTBJR1gEsd1LKqEOZIkui+Kwqp6wilKiNcas6movGiD6369XZzy?=
 =?us-ascii?Q?8vvkkZ49krgMMqij/8IPum/wpcYVuGB8qmg8WLyvpmqudlmVG0a0IUVldlgG?=
 =?us-ascii?Q?kVhTQ7TR4nNpgNfcS5DVtbxbize9LN8V7GrZesZ0lQuT/13NnnRB3otm0EPD?=
 =?us-ascii?Q?FnGHGGcnws/h6w/FK87eAyyqwVZEMrsNHyIpbelfuZDe5M5/viNhIky/IQu3?=
 =?us-ascii?Q?ib7WEjfQL6NQf29vJgMhL/itQyCU6qeF2f83YtKA/FzF/lVZfkGvDqd0AH3m?=
 =?us-ascii?Q?SL+ddO1x21E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zg43frj0hL7lwhVawL36bJO1FU5jamIyj6QZVcmmG0RH9jVZpOXzER4lfTT8?=
 =?us-ascii?Q?wzLWdXjTjHvB6IglGfrNl66/6HDzU4bQ9ROrWm8ylT757anOhfpCq0rsMXQv?=
 =?us-ascii?Q?sp506Vi1gbGandyF2u3kgwUuFxGy75V5lz19DeDPNTMOTnr226WqwCDqG9dS?=
 =?us-ascii?Q?YL0qeeLblqTYA7U1e7jNRaWcwDRMYYGEGFOgBjikyJAAscuKpdqwD+QYkfhJ?=
 =?us-ascii?Q?AqH5GSthYMG0KwNCImqly69Mo25hutMakgDcjI2XG3fhAhOTrOhB+eXUeXdV?=
 =?us-ascii?Q?Os1Ml3VXwcRqvOCdP9qeFv3se/AqD+9UJ86H6pDX8r5sMuLbrMyI/4qwDElY?=
 =?us-ascii?Q?20wGACs5gjBh7QrC2F54lRKjKT2JY1zLzGbbZ1InDAmckIlofutDlReoQ5sx?=
 =?us-ascii?Q?tj6c8poNgHGzfdn/AAmfqp6aOdV57NPBMkWx7NFDmTw3kz5T4sUAlqk+67Cx?=
 =?us-ascii?Q?buEGldBOOowIcs2zTMJdhN4m3JgnIk7BE9YbEY5mKScxueooEi3sPHER7VFb?=
 =?us-ascii?Q?SApgtuaxP2MGE3U8NKKeOAnXiG84tMcvaSzjH0JcOXObQFz4KgvhxzU4TzqI?=
 =?us-ascii?Q?VDd0CglDJfVVpgOJ7rk5+ZWGuyLfZLKpE1SmFFev6vQUvSFF5jYj6BGPgp5q?=
 =?us-ascii?Q?zP+8bR/CZmPPBbFwxx9tDyYBHJKEk0kZlsf6JZPaDYDZFR/GTTcS0zjeNFwV?=
 =?us-ascii?Q?LuHmkGEoFzAocUHMQZ2A0GyIABm9B2JlmEXwRuPiDb0Rfwj+SBQj514pLYSt?=
 =?us-ascii?Q?DReqBRv7E9OrnsX6HnMh43Jh9Q+kIrWC/Y6Cfa8nKT/nSDgfxqNXt2HFw0zw?=
 =?us-ascii?Q?zb+eWTJnNtvL22A468uYKjRvqYqwGi8zoB3a4Ky8timTvAPWJU+euCDxLhQG?=
 =?us-ascii?Q?T9GHjBwbfrDAr90kOX5GzGLUltmhqCDiK7RYeNLLX8ELXxv9vO8PhQI+dZ8X?=
 =?us-ascii?Q?SqaHit7PVNVhS0c3K/j5ihQSIoM6yIc56UezLoQaJiQwF1cl/uxxFJ4mAid/?=
 =?us-ascii?Q?IBHm200RZ8klUF/sshnel/O6qRU3nX8sc2zzpzkPYVBswehfjX1A4PPNvwyc?=
 =?us-ascii?Q?pm6Qa3w/6fY95XLjtjolEXhCtLLvuYpbtSbVU528PI8xc2t2eUmfGsH/1Lmo?=
 =?us-ascii?Q?5c0UU8SFt9JtYOh5NKeHlz9u+c7DSHU0XfrwPiKG22aV0OGkkbgL1wki+Spz?=
 =?us-ascii?Q?gJWExzAt1d1HHl/v+rVnQiGLdszGA4C8L8sIrqfA4ZK0+zuIVQiPmylrrMlb?=
 =?us-ascii?Q?OTiKfWUGl6L+L5CbYVBt4/Y6njOMf0JdIcfd2nMbpbF9jdL1NfxqIyfQh/4D?=
 =?us-ascii?Q?0Y1eRYvSXZHIK54dFlybVtk67C5NZaSI8nNwnS6jqJ9BhEJQ1gYbWRU1xEdr?=
 =?us-ascii?Q?aVhrykezqskPXxIEGTYYMidym1sF37sKaPTAPZUQYgBTNEou2PXbhgWcqUOP?=
 =?us-ascii?Q?k69P+fR7paVaeFNV7acx+3NyQZGCzTSw3c7z9tRiCLXaO2Ief8PBkFR9aRjK?=
 =?us-ascii?Q?tY13QafV6/IvojFpS/HEBEKvRA03HfvLQhbbbhHX2P8TJNEfiLLodu+okofK?=
 =?us-ascii?Q?AVv7PHNx3zuxfa3XY8WjUedyU68T1x9kYosYrhis?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1a52bc-4397-4a03-54cf-08dd78c2693c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:30:58.7160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruucrEVop5xAkuQaI/lifV6EOHp9UA+dTrxPILXyex5mVYaVvsSAgM7lrmxxoPKx9Wmgprqshx/ecTTpNSEIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11202
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

Please pull mmc-2025-04-11

-------------------------------------------------------------------------
Support Sandisk and Micron eMMC BOOT/RPMB hardware partition resizing
Optimize eMMC erasing time
Simplify poll CD logic
Fix possible Synchronous Abort for sdhci
Kconfig dependencies fix
Minor code update, return fail if mmc_complete_init, avoid uniniting twice
-------------------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/25640

Thanks,
Peng

The following changes since commit cb7555e93075114fe4af0adb806877ac4d4ef80d:

  Merge patch series "*** Add Ethernet boot support for AM62Ax + phyCORE-AM62 SoMs ***" (2025-04-10 15:04:09 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-2025-04-11

for you to fetch changes up to 7550bfdbf41b721f750a62b87a42a3329a2e2f81:

  mmc: mmc_boot: Support Sandisk and Micron eMMC BOOT/RPMB hardware partition resizing (2025-04-11 11:51:04 +0800)

----------------------------------------------------------------
Jonas Karlman (1):
      mmc: sdhci: Fix possible Synchronous Abort using PIO mode

Luke Wang (1):
      mmc: mmc_boot: Support Sandisk and Micron eMMC BOOT/RPMB hardware partition resizing

Marek Vasut (2):
      mmc: Simplify poll CD logic in case cyclic framework is enabled
      mmc: Exit from mmc_init() if mmc_complete_init() fails

Peng Fan (1):
      mmc: Optimize eMMC erase speed

Simon Glass (1):
      mmc: Avoid uniniting twice

Tom Rini (1):
      mmc: Kconfig: Correct dependencies SDHCI ADMA options

 drivers/mmc/Kconfig      |   2 ++
 drivers/mmc/mmc-uclass.c |  16 ++---------
 drivers/mmc/mmc.c        |  16 +++++------
 drivers/mmc/mmc_boot.c   | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 drivers/mmc/mmc_write.c  |  11 ++++++++
 drivers/mmc/sdhci.c      |   6 ++--
 include/mmc.h            |  12 +++++++-
 7 files changed, 183 insertions(+), 53 deletions(-)
