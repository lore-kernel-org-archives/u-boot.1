Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFBBCAC5BB
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 04:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D5283FC6;
	Fri, 10 Oct 2025 06:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jgyFviQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B13283F69; Fri, 10 Oct 2025 06:35:26 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB49783F2B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 06:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9Qa2ksTLcQetowWTg8aX5yhWNzJoOEAQSAtl4Ts+mBj70yY2AO+Av2Rmo5esIuJMpFpnWTEkfv6caBqRnGX6ndtLgzMfOIHo/J+QmqFnmdjyyBOiT9tO/A/TQawl7ZMs1G//VarkItI3R96N9k24VGNWFnH4MrV7kUV9rSKccjO1rH7kcOg8ZBKx5nO1qMxuR5cjXfaN7GRcVKCOPtrXobDPi79QQQh49hiFugsyR1/PdvHhukwIgyFOseggUdR82/fZ8CYNPYlmGhJbd6vDhgNw2A7DASj8RTRmfpugtND5gcz6aOf3Gck1a0SVYUzpXK0gkp89bjFcrON3Q5dgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfw77ZWeASfmW2E0CxKWeZdEifbkIGilzMVtP6b0G/8=;
 b=S3UVj2MewxAgfIyQMvO5DI0ij526ZnyX/0E2SykiSGuIYtiUbhyxcgVxQNusz3na2vdW5z2d0ExTHcDDXp4LO0z7p/kcGWdZbYT/vfZMfPzs1fZ/v2NNYTz5L9DzIH0+5cdp+pLzrWb5wvr7VZ+gulgaViQBDhjlK5/zFcX82lp6LWOG1/AGQctCbFDT1Iy9sZ/fFanHRZSe7JrWvTWpwWStaYvxhK5TUURyWTYOTXribQ5Yo16R92Fq0J1qKsJaBoERfvbs1+ZRhQ8SSm+XqC2VTt4zF1i1wjdxaJCL+Q7qQ1OIhE0ydDrsX4G9UzcR7ytir3hW0hsGaUFUiFQaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfw77ZWeASfmW2E0CxKWeZdEifbkIGilzMVtP6b0G/8=;
 b=jgyFviQiemUx0CRRyOSl8JR17w/oK9AVuQK/op0x3Dfgoh+Eix+3CalKjhtodYEjTvdHSgX2O0HyEbiw3Sou7XOv+aLSK6MDGQNI95551KLJz2Kku5iY0+ZxETreDtqCjYawjn4Cib95XlhK97D7x1Y0TZET+Azy0eL7IqMGGJgr/hSrP/u9KHDUEaiFIEIlEt1VPvkalKGvGcxFW4vvnFNq4hlXnKS601YJ8HASMMmJ7aPWZ/xQo0FTeWhh/IsGcDZhR3QMMXL3pkIa1lpmcOYZ0pSEw7xH2Z0kENAt7q7j+VsKm4DqsDe5hgEYK6qgGy391Sbxp5zduJPUchha+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:35:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 04:35:19 +0000
Date: Fri, 10 Oct 2025 13:47:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull mmc-power-master-2025-10-10
Message-ID: <20251010054725.GA17199@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bc145c-d1a4-486a-b633-08de07b66aca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c0SlVvmYQBE89ZQ/hb9W0uESoCHC95zfA6597ZfmvC4ehmhctqqG7i6NtVTI?=
 =?us-ascii?Q?kCWMkp0y8Lh3TaBOGaW+wpI4sGTd71qUzBGvdKs/4IKs6ZUrU4jbbCP4A0Ze?=
 =?us-ascii?Q?6AsfjWEnQHhxotJ/NChr/dPsIJyw08KNVc+nR0Mmr++oXNB+sEY628ryldgG?=
 =?us-ascii?Q?wqkf6L3RND1zztwamcBik/w44sQfngBZhN53AK20uQgGQaL/WN3o85RwPlTi?=
 =?us-ascii?Q?+qrL0w8R9ffwEkULJ6tRRreRh2KJQIa0aOkUIUKGZLSrXUiQRVMjuWi0pkos?=
 =?us-ascii?Q?i2EAJSu0wqEBx9MC5dX+pst1B/bAnbvi37pbedcuLDn9y4o3QmjMBpdDiRt/?=
 =?us-ascii?Q?bxAdfTroghw7hh2rOlHdjZzcI1U3JRGcpTMsgl156blYKqnsBho/oiLetSdx?=
 =?us-ascii?Q?sHiGFtmusheOiQwMsZ85SB0SfhzZ4lV68gUljef/BibWqJfnlXgL7aWymM5r?=
 =?us-ascii?Q?9FKenaHn1p7oe9JohBNLrvrFyw1IvBOgubdO8x6TsYjUG6Qp3F7yjKajrcDC?=
 =?us-ascii?Q?n/saH1lPIUBLumJ/AFlj3GnVSNqM3jmMQ+ky5QNCUx8ukTaOuezXzA97+J4S?=
 =?us-ascii?Q?Gu+G8ItQfFzFaMM65xnik5Hakf0gdo9Rb/5xdiMPdOjXxeYmM3B/eqQKSgFQ?=
 =?us-ascii?Q?UR+hxxL8FxUZY/2FXDEQf8I2+GUv+ObFcDbsWgkD0Iqs0QdQQsLhGYKxsAuD?=
 =?us-ascii?Q?TBKJvzrCBejbwE+4/WGf6NGS0o26zQOQefUJrluFKMVfEWcWfLrfTUyOnviF?=
 =?us-ascii?Q?6xGGHLHdMMzqZH348AVI6pBuBlO+gBBub//GiFSRVM7N+vCMUEW0z29o3IxO?=
 =?us-ascii?Q?1kU2SJLQjX2LqF0bZLt3DCc9T0iNtihYFMXzi/0XFYPVlLQM2b/C8mR3HV+K?=
 =?us-ascii?Q?PDTj5t4SUhYzP841ml8lVpmaquHMVt4BV5KfKcBra49HOavw8LR6Usd4Vpsk?=
 =?us-ascii?Q?E3Lak6jx+v9mdskc8wgZJ0yGMPtloPjEg4BU9Z5r+M11tIF2RetF9h1G0Noo?=
 =?us-ascii?Q?yJ8ah90sTKIzAgdU1ep9NeHBgBTB5KymL/TmU04Q5ofKd+NE/E009H5Jkj5B?=
 =?us-ascii?Q?a8QVcmKIyzuALJ6kv6NQcPQI82uzgOkPoJlYxjz5UcObVzHbi5bmUDDtAdW6?=
 =?us-ascii?Q?yo/IrVb6l6CLuzWqgGjJ1JoQUdklnA35VV0DeU0Us1FDuf3PmwEYPc7pAe9Q?=
 =?us-ascii?Q?D8E5kr9ppHxwl5vIcWzSwOl/TllhBflmNWSdnw6IcvV/R/Qqz+UUGh+XgqBe?=
 =?us-ascii?Q?1N9nM2Md6+n7+2XWDWctMZVc8jtDRGkyTNJBPpMfIrK34SBbtNqlq/jhdZ6u?=
 =?us-ascii?Q?CSostV9DfuUBp9KMbDcgPgG+RUk7jALrOV/JLPCqkIFBKEhmufuCh0V6Fg7G?=
 =?us-ascii?Q?Wrvj3SEEQoORTviMgHcJhUWloB4kshty9RFnOV3zD+QLUbsbC7q3pRIwAFVn?=
 =?us-ascii?Q?LOgHeQxkBKRTKrru4UK+VYVCnEJubDkI0vxHAKjgsem1hI+F3YT2vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GboWX2A2v214pmb7mGj94PWoKrnQxi/H7yxMtC27+XijVc3M8mCy7yNLvpkr?=
 =?us-ascii?Q?yJOd9QSp98n5z+PsKA7ektqR0GIYvpn1y5HprEVjn7w6xoY9b9AQ95EqyYYx?=
 =?us-ascii?Q?cKFeYUvyMQqMCH0He590flJKzQW0WAk62PeTHesW8Yq3ah3XcDGEZGUYzdFp?=
 =?us-ascii?Q?991+fyIH+FvWPMJULuw0KOLFZm1d+Zm2HX6HFqlXFXbBYrcwUoOkV4s57RGg?=
 =?us-ascii?Q?laXCWA6fwo65mx2IAJ8jnUYcfe+nv+8EO0g9ebtImJJezOk2AovhrFzm3Ra9?=
 =?us-ascii?Q?lwLwYqj6AbTYzBSVJAE9YZQbVLjH7SXXfkKQuOMhyXfm7nT0SRaZgnWFLjiF?=
 =?us-ascii?Q?7KEeT40fnSbIn0xbutVo7arwhH04kmczzGmQf354s8OcdqNymvgA+OQYsqIN?=
 =?us-ascii?Q?7I5GhLqovNc/msCYQojacPocLDavGAJtXi1UUOI4StNy4FPnPoWpIy4CUAgz?=
 =?us-ascii?Q?g62eoGc9NDhBRqOL/E8n2SvjrY9/hTTuFCkHJ4k6pkyWdFPADNoURcgoQasg?=
 =?us-ascii?Q?/3uSeadjaYkP7Rn9wQ7lQ+gKmubjxRAfyZcCJ1N2+OHyuPJ7oA+cX/k3XaVl?=
 =?us-ascii?Q?pS7WAFjyQuApPzPGTbTQkIEqt9A9lgZTkiSvwoqy42QhX1BPwxQzLLIz8l4G?=
 =?us-ascii?Q?rcNVkyIv5C2sZPTQS2tnXr8fh2/zQgUW0pzLkZS35tLBCeZMUtQlfaQuPUxE?=
 =?us-ascii?Q?aKHuuRCgYOYM7HLxDJq92RxygXffjTJNFYcoM/9Z6PKbfgsWYUSZ1n78EKS8?=
 =?us-ascii?Q?4YhsxYWGIPGWQwy72036KwkVbqeHLTqLkWOLKJgH8hsb5MF0uQQCebaHKJGC?=
 =?us-ascii?Q?ZrGqZm3Peb9YiFM9uRBABySFjB828jF6PQsqEJjonspl8VssswN0lfXo/UaX?=
 =?us-ascii?Q?j4AN/7YzubU4ep2ECAqaxTpYhvQwLqXCytA3n4x37AKmeqYyMSoTF7GMUK2A?=
 =?us-ascii?Q?vMXV4Y4Ql7cKJx8MX7nDNG4UtDvChZ0fgg/Av7PTwDmWc7P43Av1+oKvBlfO?=
 =?us-ascii?Q?ywvaeqGBZv17B9/WKvrZFU0aptGJhvk/zTqdBYpLZQ/JFqybHnOHmWeNwntW?=
 =?us-ascii?Q?GYLOrw4vXsqEIr5LVUE37ogWkSa7UPSD/ySsYWmJUmjzlk43IwyXmqUwOCBr?=
 =?us-ascii?Q?eQ4JExd2sKf926dJzdC/IpRfxpUVdBE3IDd7K6VazkaICkQ4w5UwvbavKsOI?=
 =?us-ascii?Q?wjGK7EYpqzoINQyvSTdd5gS4YJrYoCOH93YK/ex43lOACFtTTLjSTNttaFUA?=
 =?us-ascii?Q?n3+WQUeY7mqKEd0wC1UjNJNtPrrPNuSaiQZ8WUMvm6U72Drqg8+878DOYNrS?=
 =?us-ascii?Q?A4u8oyG469zRlQixv5DeMcor2GDK/90H+yEjety0poKwcFVAiNTQyK3ovUn2?=
 =?us-ascii?Q?YyTSBQTOWuu5CyV1++tV1LECjKCt9KHsjbjrK1M7tMPpfhErCzIpwuvuJQmo?=
 =?us-ascii?Q?PQai5Rq6S+YhIRoe3xWJg08eQ3gSeaC+b+yQVr4mQ+mXBa5E801nDeAgzzv2?=
 =?us-ascii?Q?2T2oWeSTyE9On4bauAbTYiJb9RGyANaXnvCB6YHl44Pxjmz946u1609enhl9?=
 =?us-ascii?Q?kIzjKSJgfErhMg0n5QuUfIP646oZHml18giRkoOt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bc145c-d1a4-486a-b633-08de07b66aca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:35:19.4301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMI+zI6O/297mZW5oNrU1v2JCtwFELPepf5brxdGpTUngVZ6qVkA7kb1lCjog4xYv43kmHGChoVhrSo2cjeVyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087
X-Mailman-Approved-At: Fri, 10 Oct 2025 06:50:32 +0200
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

Please pull mmc-power-master-2025-10-10
-------------------------------------
Use dev_read_u32() for sdhci-cadence6
Misc compilation/Kconfig fix
-------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27881

Thanks,
Peng

The following changes since commit ecdc3872a767fb045be3296d4317ae978a14b022:

  Merge patch series "firmware: scmi: various update" (2025-10-09 14:30:02 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-power-master-2025-10-10

for you to fetch changes up to 63bce690478169758484881afeea45ac6a812d00:

  mmc: cv1800b_sdhci: Fix possible warning with MMC_SUPPORTS_TUNING=n (2025-10-10 11:06:00 +0800)

----------------------------------------------------------------
Tanmay Kathpalia (1):
      mmc: sdhci-cadence6: Use dev_read_u32() for device tree property parsing

Tom Rini (3):
      mmc: Fix a potential warning in xPL
      power: regulator: Correct dependencies on SPL_REGULATOR_PWM
      mmc: cv1800b_sdhci: Fix possible warning with MMC_SUPPORTS_TUNING=n

 drivers/mmc/cv1800b_sdhci.c     |  2 +-
 drivers/mmc/mmc.c               |  2 +-
 drivers/mmc/sdhci-cadence6.c    | 18 ++++--------------
 drivers/power/regulator/Kconfig |  2 +-
 4 files changed, 7 insertions(+), 17 deletions(-)
