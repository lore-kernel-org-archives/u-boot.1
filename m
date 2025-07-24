Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E86C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 07:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD7B8362A;
	Thu, 24 Jul 2025 09:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EvK6C7bJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDB783653; Thu, 24 Jul 2025 09:37:12 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B8A83616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dh4ygrf2Kre89cLXG77HNt1XvKjpQndpMuVSfti6m5V+mwBRDrRXFMf3byMMKUC+gLZkvMByiXs7qMeV1WA4Z0WFwLMLu+AZUQF8WTjx7wxo3qfyD6EFxelzVi7PaCt58ic24uB0W79RohPvbxiY4vQCAmT+T4jACSXzDaVRAQP7sX18dPgZuMIh/brRC7nW44ZNDLoYIkIGFzYED2kU0cL5B9n+sVYpu3soThtHB1WqxJr7+7aL/PV93YRcK8amQZMNbYTzaWdplrcz0LtxyLqpHvSk3kPx9m7JcQo4X0WzN7rGln/j0CtZaqcvjp67sS53qMVteuOOWc+M+a2CEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1kBshF+t1ICw1/dT0exnYARyMt8eperX/+rXANJRYI=;
 b=DlUr7NsmIVwzXKIWRjot0Hhu0luW/VjKtt1aZFmTAOqHX2sdO9gJ/4BOLREjmQ40Dzr4/3HbIe67nxAjCSguwYRtqg9fEkqmBE78preH7vUdrqTdd3ZwZEY/0hMXVaqYsnX/3yvdLQnrKgu2jVpgnHqmxSaKU++LegMFfTX0llP0PGDzlVMZJVsWDmmftGKTNUIN1SujRQ+S/Dh7+heYUWob21Rit61xSZiS36s/tybt46c9YTiQ86VN2QkVY79vFVynhhxpnUm5TS45r3FraU4kICrMZTyo+hA9byLCkgnLM7mD2fgNB5IIyDH4cqWmfU8q+t4GCGOxwBdwR1nuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1kBshF+t1ICw1/dT0exnYARyMt8eperX/+rXANJRYI=;
 b=EvK6C7bJTTFOY63b2gIfbz9WodG2jfwq/DM+ktXD4XvTbuOWhn3dF4pgsgpRs7RDumRGVNP/AwTuQRaIYRqPdfwlvUe05I8wVGE3GTpXmsKUzDrAKUMDb8Sl8h4lF25xChWIat3JE9z254wlxk4FBoWmwhYei0vH71MierEFxhW6k+RpcB9H/z0bElklk2FtZHJnxL8PAoojGFamBvvNckpuxmVdyD2xJrcgq/fGWl429pUh4az8jUe918RIjXEL+0pkZ/qCw0enOrZzX628meOWAPM5n6kiERkzpHa9kDSQQrwvN1rifAri8l17SobTEBpC1BB4smfiVPgpnqmMEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB11486.eurprd04.prod.outlook.com (2603:10a6:150:281::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:37:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 07:37:07 +0000
Date: Thu, 24 Jul 2025 16:47:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull mmc-master-2025-07-24
Message-ID: <20250724084733.GA30707@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB11486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e47a707-215d-4974-4a5b-08ddca84e44a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oU2R59dOx+oqISWfdHkWV3rc5CQGyix112gjqKGqPdU3daB2R8EFpZBUQLIo?=
 =?us-ascii?Q?zhxjgW0ja1is87XI6Z+eBM8beYGYrhASM1TjIjq1HO52WIdwdDCW5qm6+9Yr?=
 =?us-ascii?Q?tAMsWunncvMfQcAM/8qO5sThvZIdRikAMzaL+DdYZYvodvHrmtiC1d4oTdx4?=
 =?us-ascii?Q?bj3qPV+n6fZ5S9P1iJFuXjVBMNHyEDFRyBmirxLK5JV4TEGYRWHpKQq+D0/+?=
 =?us-ascii?Q?S25FJDlBEMFcFhvPzZ/S2AegP2vrVgpaBj+ziu5ElEFOm0AvcWM7xqPO+TQP?=
 =?us-ascii?Q?Ffch3112Sgq7n92KUPbRa3lNUetr1evz9D85fvlZtLrSH22V32wXzCJa0Yt5?=
 =?us-ascii?Q?FYMnynOM8E4SYAa6bf//RnhP1JIJ9Hnupw1NCDWbZ3Rm1K/0iFeBYSwOPslC?=
 =?us-ascii?Q?sOO45EWQ3QrjfvQFutugT/pAo1mUOXEEc2MWazOdsRBHQ+0DlaCs0KG1rcVM?=
 =?us-ascii?Q?L8Kk+EwUyUYTvEtnPBmUZNJ1alFAjXlKRUzikxFkKyHomjDtMQb9pGhhSoso?=
 =?us-ascii?Q?+2ln+qalX4FD+Rc2WFOLB/3/wWXL9O9K33hs4fj16Jlv5+64ryFxMTMUF2su?=
 =?us-ascii?Q?AOQW8Y9HejI6g6dSAS5pQ7dAR9NbyHAs2IDMZN8MZPptkhtwj3uQrZuvO2WU?=
 =?us-ascii?Q?cebo8M82b1YlmDXKS23lSTgA7ispOun2JbahW643f+M80UzM9WClk9eqTR7C?=
 =?us-ascii?Q?CVaOHynu1A/uFjdiHuSfsak0jBdcZr+8wGyXUkWFVx3JnfGQ+jaMNQgEfLaM?=
 =?us-ascii?Q?lzaNUca51Mto3bZR/lf1rLojstgApRLeIj4VFO36VV9oXYxrDwSOZZeFuZTD?=
 =?us-ascii?Q?2M/M2Dsfz/y6HPxG3mWfSxuFCGi4rKWsLJ6vmQYB7zkcBwJ+pmIWq37q/wmk?=
 =?us-ascii?Q?BeNUMsv68i7MIa1AuieCB/aDWboOoOMEr/PE72s3W15zUWpiNgr9Nq2JsPAn?=
 =?us-ascii?Q?MpQ1ahLhVmCMTE3Bcm1EODBITNNeZNeZcC9ZhB3CbwuQrkKAUXO6BKZh4E9G?=
 =?us-ascii?Q?XhH2HzYK3m01w6sRhT/02Z4lXMmlsjp+5amqYNBUGoEuVAfpAhTxTuRdu69D?=
 =?us-ascii?Q?hW4a9qFgvUflW2oEiuhIEFazXQujr9GFZsybYuIJgVBNxFoYcBX/Xf7C1c5V?=
 =?us-ascii?Q?VD/NUV/BTNfSJX2G2cKYSKXwddZmNB/0nSIWuBwjUHYpERdqIZ9xjoQMS1KC?=
 =?us-ascii?Q?3MIezx3vXZZ2Ats4j31/glovtJVewYUTf5KOXjHP+LkB/+7Q3/AgDhMpnA84?=
 =?us-ascii?Q?YUdO2eiELOZANLLKQhuJ5fxqBcp+HY9RL7lAht0F2PDO8ISYODEp+3FUXzX/?=
 =?us-ascii?Q?2qRnlxMr2D9crClPsAuU7tuAmTXSMYk5mGqBoE+MsUs+uqJNyr47lXXTYq3y?=
 =?us-ascii?Q?Kyho0XldSYeQhA+vY7YlcZv6FdqOSU9cGn2uEahe2MH7c1YN6sDEdHmi2Wb7?=
 =?us-ascii?Q?cD8paMSxOcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2T8uBd35qkUZmzN7CB1juddMixEqPnZlrwTArjm3y98+T1O0R6ORlIE0ntb?=
 =?us-ascii?Q?Mazy05zE4gvAX/jZ+YwY5ttWa1otwk3WpPVBqKf4Q1qciSa8QQ1LAXC1vYqA?=
 =?us-ascii?Q?IKwOXBGwQibUHKcIoQgqkqQowZ9fJzNLf/7DCbGfyCk3RqkbJt3W5O07WpXs?=
 =?us-ascii?Q?uuf5B9FTV/yMoTi+i05wj9d1lCsfOU0MBQjt43ZWh4w4Rj3vSGALnl9zHL7c?=
 =?us-ascii?Q?HjqM4sMW5Q6EOwIj7GDChlaweW6xJIU+z1pmSrMdL7CQW9YkeUVy2mB7P0ZA?=
 =?us-ascii?Q?wlkvcNxS996St3xhTYoh1QYNoO++seCcXYqL0XHEoz/gaXq0VqgPIoNGA2vv?=
 =?us-ascii?Q?hTpPGfJX5mZN926yFhkuWmRZ//PqjgolfJPwidezsKCRntb6PO6RPF+Q6Lqj?=
 =?us-ascii?Q?SsIcAc4I+X6uRtpJjSRFB7pu22MoCnQATKxFNLR1gFx1AwoW/Qqd13y35lW1?=
 =?us-ascii?Q?DU8KX2evPSSqZFRpm8bm0eylovuRLyk6V2DXBr7UEj8OSnbGL3aGh2J1Abz3?=
 =?us-ascii?Q?GlYRzwvf5JiT+AuOTWKL5V+AGL3TlUGWXWgUEvX21jibct2qh5mUdGPpJOlW?=
 =?us-ascii?Q?oYEKFf8w+LAxfH7TEaue6USj4JWznqMBpknGSea1foPt0Lmm5XraKojHDfXs?=
 =?us-ascii?Q?LXkD+5LRd0F8xpxWvfiK3I8xIeIkYa1jz4gq9tysEipjubaNrnWUNL5ARPaY?=
 =?us-ascii?Q?zSpv9+1fox6z3XAzvJHyE0bsm2J44v3Gd0HK/JweGNEuGxJs7/59yBnpCwgO?=
 =?us-ascii?Q?W0NIUvKFRwVaMxRwdJzarSrFWkrGqoo/yPqggjwFrNiev/3EOqpJwQA46htR?=
 =?us-ascii?Q?fqLkl8zarJq6+Vwx9yBwMkVGbcWRWfGNWFBTKv5kiQjkZgy8nNyp6Rgsdkey?=
 =?us-ascii?Q?wEojRnPNJRzsuHU9s9h/KJ9z56kiS/e1UdGOAbLBbWRbnRfdbckqtKFw6Nck?=
 =?us-ascii?Q?vdQgiLXTxbt/PtG3SNi42wxlW4ACrar5mRNiY+UMJmYVOYXyr1ZHaNsHmDs7?=
 =?us-ascii?Q?/5uBTyt4Jebt5wumiQ7BuzcHEa1Ldj6OkDCpcLTOGWExxn3xVvhkM3SmAPOb?=
 =?us-ascii?Q?vjVxsNGBAsHO7PXuQgdRUMaUsWjD8V2aU+tbSYVpDuaJANa8Gt9n4gw9jtJ2?=
 =?us-ascii?Q?oFHTvd4K/USrjEcyredqRmeCSH0M8mYnQRlcplr+f6a0Bm7u+0eltxIYvRhO?=
 =?us-ascii?Q?FB2x+NtQ2ivLL6TyuGP61rZA1cGRI/F5DJuW2H/4WLUSKJ0mduSKXLIS+0Oe?=
 =?us-ascii?Q?bOesZI4tFrx6M/lMzL/lYKuWNfhAOixiFSvhtMshIVrRJNRXq5MRuGUiMlvQ?=
 =?us-ascii?Q?sAJcQ3ICK/nHt0DAhr7k598CwHUP9Hi8hgYcehbMbyejwGw2peCXbZj9W9vv?=
 =?us-ascii?Q?yTLBRl9SVXgLsy9PpEnp34xtbfZmN6PlGkR47j6Pw8pf8PlzllHmSHqsaKc9?=
 =?us-ascii?Q?wSgVwa7kYf0oS0QtL8uhRmN1/owuk/cMphv+MJcllShhvQ8m31r29f0f991I?=
 =?us-ascii?Q?Cyx0zYQYbDHOLA+BT1r5KfCmrbVQ0BCAfDN1ukmmzT7/8j10mFQEQAJnm+qq?=
 =?us-ascii?Q?QZgQWFE30iOvKG771oH0OQj4gBp4PFof8xLo5t2c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e47a707-215d-4974-4a5b-08ddca84e44a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:37:07.3577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x03qSSyeVKiCxXt6T1NnV/8ag0lDik4gR5d2VqC7BuusZgOOLhi647maRGiiJEv0IdLMRkG57cZVXWMVEaCSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11486
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

Please pull mmc-master-2025-07-24

-----------------------------------------------------
Fix emmc error state after mmc write timeout
Minor cleanup s5p_sdhci
Support DT upstream for exynos5420 and exynos4210 mmc
-----------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27140

Thanks
Peng

The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc669:

  block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-master-2025-07-24

for you to fetch changes up to 1080815650a00257929f645bedf4e1795bf188bf:

  Fix emmc error state after mmc write timeout (2025-07-24 12:43:31 +0800)

----------------------------------------------------------------
Henrik Grimler (2):
      mmc: s5p_sdhci: remove duplicated card detect code
      mmc: s5p_sdhci: add samsung,exynos4210-sdhci compatible

Iulian Banaga (1):
      Fix emmc error state after mmc write timeout

Jaehoon Chung (1):
      mmc: exynos_dw_mmc: add exynos5420 compatibles

 drivers/mmc/exynos_dw_mmc.c |  6 ++++++
 drivers/mmc/mmc_write.c     | 12 ++++++++++--
 drivers/mmc/s5p_sdhci.c     | 11 +----------
 3 files changed, 17 insertions(+), 12 deletions(-)
