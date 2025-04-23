Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60299C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F9BE807AE;
	Wed, 23 Apr 2025 16:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DQ0s4lBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B658070C; Wed, 23 Apr 2025 16:53:11 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB36280944
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbTsN1gqs4MjzSwt7Tz4uD4fYHfnN37FqtnFsgaMEb3FnljjGw0lzgm6/aLRmFJbsr9ZffVYHgJi528ULomYIfzADMyCmeYMderLoidsQzv64vr9XWHRckXfEqzepzXuqSetAZ/g43cE9QEdOQTUrIbTWnXWJOfTFSOHrMq11j+ow+WhNbPB2mLpzqagyb7WL8OEExxOVqhZcscKDxi416RY7Y5W1JEVJk1oPHHfNOZWKt70W0Fv3/nKtE3Gc6z9Kq3Hh+yoDk6ZWbCGyLptLEQNidwazjwkX0+jbFK4sjNKxVrRg7id5hTeSosWVR2qBeTi/OidLZ4OxQ/mXbaaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c79yDbHzCoYJN3sYNhWCUn7z9v2vkUVwJGglOZhKTU=;
 b=ismmuWVMGxsMrl35krTxTHOR2uSUKVDvSjJ0y2VJL8cqDQNNACM73w30rwNqzO4BBJS9X4G8z4dUhCR2hYarJ+InKpeO0Us+2eR9I6ZR7l5rZM33yHLcMHtK5xgm+qU8hCgogxTexk4rLRuKmK7XV1YFMUs6waGoBNkBJmyNwLkU6rkgqEvoaSF8SLsF0G618RP09dyLOvHwuGnvLVPL350w9tGlq2YXRrtd08/Panvj2uTO7pnZ10b6Ord9avK7n0g4f13tDicGNxT2NQbpgjIxa9tK3MjLixHtPMrDvBwzLe2ubW2kX1jJoFnUNsJPxD7V03dXo3OGz7GfSjBIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c79yDbHzCoYJN3sYNhWCUn7z9v2vkUVwJGglOZhKTU=;
 b=DQ0s4lBcvPZaMyrb7dkoz0gJG2aIxiOyiWpg/JA+V4KzWvVoEJzcXqp1vulvIbEW1hs1lNNMUw+cr4xBbfGGgX36gmFPBssbOnntUGx/lge/XpGen4LxGMWPijdbSipW9vG/nJIrtgNZ5DdFYqA9xjJeIj8B/NaD8Wj9n2TJqkOhfe/XJSMiouSaPR4MFuoBoVxvlLheFPBo7ZkrpogiSL/UlcWNguP7Ad2D41JVgH6H1fHGbLy1ZNs3VB+j/L7qjdHd3RhunWh4Jpt16bX6wirOO1NmOGMiGobOzXzjH65jslEI+qlsGdFU95kvS5FPTKEV8mcLypZQkBcfM41Pug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7169.eurprd04.prod.outlook.com (2603:10a6:208:19a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 14:53:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:53:06 +0000
Date: Thu, 24 Apr 2025 00:01:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull mmc-2025-04-23
Message-ID: <20250423160155.GA30338@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a07251-ab6b-48aa-eb70-08dd82768eaa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUcJvsajjdt/t1SKrtFL1wGtXxjkrP5Ub/VsV8MzF77JvZUI09gnJjiL/yfU?=
 =?us-ascii?Q?mNWpn+ePKKcTk71pR8lnKzur20vQGlQXzsBm3ZxoTI7hFeuDhtwEmcQe8g4n?=
 =?us-ascii?Q?Y8kSzq8yOimEeIeN75++lyt6m//cpxzHpK2A/IW5oywrJmKz8AId1cth/L5J?=
 =?us-ascii?Q?aajOtkireykEiuDdv/nqO305Y0P0VjrOaWb+xMzFruXGEYx8xZ3rL7yykLSp?=
 =?us-ascii?Q?9/b44VbviyTmy/qC4Omm9LCLT0uLmq0/8nd3SIe1/1P7JiRCNV97SkJ84SSU?=
 =?us-ascii?Q?DjOAGqcFmk/gCuNq192W8sX/hEj+/SjIgNMIfq8d3yWtpTtLbpmuyVyX9hus?=
 =?us-ascii?Q?LcJ87Ygf14HFWi2UBOSO9OVfbUHuvIx9ywGWX0x72YyJ9W23jZqdOwx23gLa?=
 =?us-ascii?Q?0SQywvl0/w2PqPYXPSGCFYoarpb9ZxRUZug9tVJLiGCHZS3a/HZ0jh4PFMl0?=
 =?us-ascii?Q?Vv3QZnCohEKXMkHJXuUw121cPXyUTBGhsTBMQc+RCClq11/jjNA5cYUMiTPx?=
 =?us-ascii?Q?sekzMr0poBBegB5wgL5F/PNmIHfwJV1d/OrGrlEmOqlISgoCeoRBII42sgNV?=
 =?us-ascii?Q?LVdO5WRc+P5moY4/eKJ58m1BNtcueFYsNQNRHEKPqRrgie9gR8OhxR/F05J8?=
 =?us-ascii?Q?IfcTsbJNqDse1NBGPP0wjpfbEUel0H5ZuQueoYzdcYJEtfWAa9APcx2GWgsn?=
 =?us-ascii?Q?hkZq+tP1HLKlR0s9IP/yv8s7DmguQy0j0bunmlFFrvb+/tFR3UdT1Up6HggM?=
 =?us-ascii?Q?cS0yPAJMuph4jzKfqsyV+n4MjwOg0b8bsUSzysGETO0fkPbY1egWKnUWnrO+?=
 =?us-ascii?Q?SWUlHnQQU6/1ZPEdl/bL8jeZbL5dOV7p+Sy7nNvcvSFRSbyo+YDoVV+58XNZ?=
 =?us-ascii?Q?trVYft+nWbc8OzAE2IxysOjyg7pKT96xOwpT23tyg8PfsmikyWc+m7HZ3YjY?=
 =?us-ascii?Q?O4dXhMa5LVgD6yFD0JLNKtuPgsbd0+w4lZu6gVHU2rWk612E3z+naSeTtFs0?=
 =?us-ascii?Q?u6H8KjqHtrEhiWcLLv42xNAFQ0U2YX1eR71WmgcSLhPB+gLLZ+uNo4Iz6lXs?=
 =?us-ascii?Q?Xts5V9xTcpNVV07OwdBEg99qRgmxDQ0vge+SydFYGVoJhXMKYUFzWqLYyiKH?=
 =?us-ascii?Q?Bo+pELZQhvl6It2h0HfibnYAT6Vbi36lghsyV11bJ5A2WwxmjMu5Jk5JsOUO?=
 =?us-ascii?Q?WhHK6WJUyU0kX5YDOAV4s3JbeC9dQdMIZEde7tS0DBjMSeZojn2OKXlnhlHa?=
 =?us-ascii?Q?VxhasVmAAsciP+y9ScsrB+oTCF1p38IqMaje5eJuAdXzGP0SIEBDFp3wg3sv?=
 =?us-ascii?Q?MxwUdeJIp3nMZABFVF0dT3NoM0yX1bL9oh8Ziwf6zbSmDPROwLljHZHR7gvA?=
 =?us-ascii?Q?vaEVf0PHwNJ49JaQhRnd37y/sp/jTG8dH/BKuEPXHapjjm6mtnXg+lBfijs8?=
 =?us-ascii?Q?unsreEXIPQc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?38iG8nDDUq2OZgYD2N9I59VHmFXBRwL2aReb0FMCyYMpjsIScveu7x7y10zQ?=
 =?us-ascii?Q?xkFbnpljjDARw/jG+Fo11FW2jwM7qwQX37FwmmK+zgRWVz9htOVsi0rlxpEf?=
 =?us-ascii?Q?PWX1xdeaV+InO7z/m8Xi5UBgZwiEljClw9EHdaryBvWjZxV0VhssBP3FB5JI?=
 =?us-ascii?Q?VK0Ehm4K/lVKZjIIog2BEFFaKp6XSmRBvuJpwj/siszF9eg3qL7stcLEufH1?=
 =?us-ascii?Q?gicI45G2814RIXoMhGZaEf6xQLt5rpkpfNQiaMxOIbtYHNHzC5Ok7Mc0khyM?=
 =?us-ascii?Q?qiC7Tz65zAFZdEQJxR/JnbC+QgZMuwiGM1ApALHFvgLZus2cvLNn6QRA3Sa9?=
 =?us-ascii?Q?y6oeGrVMl4U1GUamsQyWXxLIxoKFZw1jvqx1TEPlYbibl04FixJRoD/W8rM9?=
 =?us-ascii?Q?oN1jqzMSSzoJ5vzljsGxvCmKg0v7k5BRR50M0s39RPx21HEuXDFNYM3OBfzO?=
 =?us-ascii?Q?4aEte5m3Ls49S9k3We+wire+znzmHY8BANvdqcRbgut6Az6DY5oTmmzVQE7H?=
 =?us-ascii?Q?66gGRYU/51qG2hoPl5AWfzciVPCNMMRbghuE1ZwRcvquSHc8aCmuLYU8Ppby?=
 =?us-ascii?Q?atdlc4EnIwJUsM0jMR3w4NVFPWQwhsFNcC4DC9hX3ZOoysvmsRoDo6HN11p6?=
 =?us-ascii?Q?sqooN1pnVgt4A2oO9phdWaaZMCNRMFxmygKiKg1EbZmuiGJeQ8m7DbWUaX8+?=
 =?us-ascii?Q?KXEX7ZpKEtJlJiXn5ftkP07UMQooX67ZVBNLS/V3GZGJ9nqymVgrdcIF17m6?=
 =?us-ascii?Q?bNV+qEwc9XC0KvFfxncNUmheTJ03gz+gGUepCIvLH1nXM34uKSfxjMmTq80f?=
 =?us-ascii?Q?G8Qdy6MkOSQM+pssQeeJq/tlszAEdgz78JviPHP2WaVz+A+myOhbdvW0qDPt?=
 =?us-ascii?Q?s0LTB5SAsNDuMr6mClkxSlgs2nwJcc/aQszgd6qXh2yenux/HBpgS9D7u6ii?=
 =?us-ascii?Q?JOsa8/BJ3Km4pfYxbZfDcGenNK1rXC1/qBH/Ku5mwe0yo3rQFma4X5bNJNWU?=
 =?us-ascii?Q?X577xCRy+hEtIBVgOj2QqLsqkOLLBYlpV3GuYoCqaABrvktfuqFg7mrBXe8+?=
 =?us-ascii?Q?1KsySs+kf3hQZv0HBtGoLpuEKD7teSi/0lk6VCxw4mIaWwTz7BOobpRTWPxo?=
 =?us-ascii?Q?Qr3ABtcXOVBi4XHFYTGGW+Ah2L6ZGuLJnFj/FQqXhIFUqBJaJHGEynfShfqy?=
 =?us-ascii?Q?/MD482VG0abADdSjhEm/A7im1SAAPz7irjNUPXyMy4e27fKH8/8thDkpS3kR?=
 =?us-ascii?Q?Er7hXC/McAyhcgn+70CHrbYCSW2dsqUI2D23N9wYWZLuwHiMG1H8Tzbc81A6?=
 =?us-ascii?Q?P2IS0PmZQjegk8cHtqX8VsZTRL0SR9PDbiGjXHLJ2umQnvh3ik65+LlNwtha?=
 =?us-ascii?Q?u/4/6YhaJEOJin0xPbckN7JbxpH5UL8C4BvKgsPy9LX30j6e9UcKmGifmMfv?=
 =?us-ascii?Q?x+gY1oRv/6PDzOWAq+f1Z2D1mVeF5p3TkewxhK37dYEouUDqcqxT+H8hSi8q?=
 =?us-ascii?Q?1+3C0oH49aAzuHkkg9/AGurmRbNBqm3df1zaKb73X+lZnh6vL8nGVmzQ9OFU?=
 =?us-ascii?Q?qACX4K71dos9DaDRLWCFQB94izcsLciQxKFjauYR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a07251-ab6b-48aa-eb70-08dd82768eaa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:53:06.8923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxFc54GpY8gOogHrjkz5DM+NGxUJOlQkaoPkGae5hqHTMd1UyXwJIwGWBkAZ3mdhEFukFzYh59pezSVsjKBYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7169
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

Please pull mmc-2025-04-23

-------------------------------------------------
- Introducing back send_init_stream for omap_hsmmc
  to perform the 74 clocks cycle sequence
- Move scmi regulator subnode hack to scmi_regulator
- Typo fix
-------------------------------------------------

I picked one scmi regulator patch from Marek, since Jaehoon is
inactive these days. Hope this is fine.

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/25899

Thanks,
Peng.

The following changes since commit bf2db18116137bb2f82165206be3f16baf314feb:

  Merge patch series "configs: ACPI enabled QEMU defconfigs" (2025-04-22 12:54:53 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-2025-04-23

for you to fetch changes up to 2a8e7ea4f948e3de7033b297fd827fe082cd63da:

  power: regulator: scmi: Move regulator subnode hack to scmi_regulator (2025-04-23 11:28:12 +0800)

----------------------------------------------------------------
Heinrich Schuchardt (1):
      mmc: type 'Relatvie'

Jean-Jacques Hiblot (1):
      mmc: Add a new callback function to perform the 74 clocks cycle sequence

Marek Vasut (1):
      power: regulator: scmi: Move regulator subnode hack to scmi_regulator

Mathieu Othacehe (1):
      mmc: omap_hsmmc: implement send_init_stream callback

 drivers/firmware/scmi/scmi_agent-uclass.c |  8 +-------
 drivers/mmc/mmc-uclass.c                  | 13 +++++++++++++
 drivers/mmc/mmc.c                         |  8 +++++++-
 drivers/mmc/omap_hsmmc.c                  | 13 +++++++++++--
 drivers/power/regulator/scmi_regulator.c  |  9 ++++++++-
 include/mmc.h                             |  9 +++++++++
 6 files changed, 49 insertions(+), 11 deletions(-)
