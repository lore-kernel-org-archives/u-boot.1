Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B435AC5B552
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 11:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DB98129F;
	Sun,  8 Jun 2025 13:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="d9EaH+Yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16ECB82A0A; Sun,  8 Jun 2025 13:32:56 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06E680FA8
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 13:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNKtNLlXC3f5pqk2NtV7aXofhvrHPgk2AMI4zP5qzkIXcW8xVk8UOEI+JZaZ0aVvSI8zktDkTv0HS16vhdgn5Yqn5xCyoxjN5vIk6wOBbThVTHvQkFu/ZWGNB9PyIcW5O19n+KydmaaQfAlsfylM5XuyEjAKxmH6oBpduRzit3+SNKjeyc74Oqcp0+od/Gu3JUSYEFPxW7EdQMP/8n7k5PqSm3vy36QYy5fK4tk5cV3nCy2nEm2ih3cnDbzPJhZNX/iAuU+DpQ6HhWUNUtOEcITIwHaU/Fl5MQnTheYmhACSILNUYFsjwQuGRwIV1zHj6PRSUXlSLwIv5g6v+SopqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITI198FPPDpZAEp6T+HOcvSHv4lwKhZRIImLWN5btNs=;
 b=waVyvwpuFo0Iw4EkA8l8yBrC73Y69MJIYFKefe+AjmHtwM3ahB2LdIab7nV6Yt8MvST4Gat8DKcZHhWc+6Cq/KexqZ05rRTowTc0zt0dG7rMbB9krGFsgMWokd/ua47Xe53oSfPGzeFUB6LHICVlRGdLSQNKJu6WyqbdEsjY1tlbRM0p4NBRFg9q/8zolSA9is4WmSoB1gS47cmC5+kbYlZ77GN6kN/qLNptR8A0bsLwsSAJYN/VeqbwWGJn4QohxYv1j2SvXOA5tCHsaZadX0QN+/10lth0S+bOsdWGr58MU5o5VDM0w0/rrxHNj9psFziqGkAWJj7qmfdP3bs+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITI198FPPDpZAEp6T+HOcvSHv4lwKhZRIImLWN5btNs=;
 b=d9EaH+YllMrEDkvbwdoW0KIKwRNlLmz2QLRjI4iZCqmtuDeCoI9EbQfdOHlHpV1hZrEQglP+V7EupZPMI4EOCZPpO2HvdYJYv/uUvdzM/h/1vs40Pbj08Qrj4sR05icy73K3aRJEUUozyt0vzSCBptMStmOBQMyQuy4pWoX9DXdoQpSFs6+Wp2r9i3mQBhc3/+hKZORb/IQU1CN9g1z/yOhQ+NkvC+ImATSsaoBetCDy7lx0+hWON6yI90ouS/ftikHE/974ry7n2h1Z5awvEpFj0Jr7PlpQ5iwtQdNu8sFAS+grv03gmvYG9JLP9RwFhnScvbHdnSldj6pMGEyncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB3PR08MB8842.eurprd08.prod.outlook.com (2603:10a6:10:437::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Sun, 8 Jun
 2025 11:32:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Sun, 8 Jun 2025
 11:32:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/2] drivers/spi/airoha_snfi_spi: add support of dual/quad
 wires spi modes
Date: Sun,  8 Jun 2025 14:32:40 +0300
Message-ID: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E4A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::1d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB3PR08MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: e50e8390-1f25-437f-e184-08dda6803396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q9nIJc7EsD8VtesTx4G7I8kIRztPPPdQNsipZaFJpii5A9xywnp4JsF3uvWf?=
 =?us-ascii?Q?z8R+J3mFHvP2f2V5MTZmTElIhQF0oDuNOlNFWv9r8p/gm1ytS5h2zrc+Y4Rj?=
 =?us-ascii?Q?bZyGCfZ/VlYYLVhhxJtSVurjatdfbUCzAZVnxSUe9CRqDa7E4Uj4qEAVMp+q?=
 =?us-ascii?Q?tRfQV4MpBjvVfQuwc1Pa//o5+Gj3hxzzpm1gA2Xy+juEw4R0OT80EuZMwWoa?=
 =?us-ascii?Q?dSCDcezq/RV29s7euTwGtQ3DEfv0YikyKd/g1XbYkFhbPR7XzGuoT52lHasO?=
 =?us-ascii?Q?3cNH5v66BQy1kflgAlsqNBKEMeUN+L7LypZKEZXPwF34lXIHjMdmg2P3psK5?=
 =?us-ascii?Q?AtHRaUeyRQuJ6lzSXQrhAC1XQRPMuLrTYOlrRsVm1CfCsnEXCQ9qheJ3lJsM?=
 =?us-ascii?Q?QG4ybOgPtSzkq3oiP3JrEgX07HmEsFNwJomQTszfyFaVUJt2GRluXIiuA7PP?=
 =?us-ascii?Q?orAphcFwRJwCpr/V9zKrtsHlpkoJiQhbyk+Jr8ZSW1EnAiuMYCM1+MwUoJQV?=
 =?us-ascii?Q?b0+MBSNYIGVFbsQ6lZDXG4ZtUpDLKg3B9zTC+r35tpJ7GFVPSCgrpQ6g7f1j?=
 =?us-ascii?Q?27uzsB9dh+azQ4/5PSvLzCoukS2EAHoExji6vLRF/lKDQZtX3XT1pYgMhKtl?=
 =?us-ascii?Q?UFzq2RXBhGUk5lcTm5clXStvq6jUO2cdSR7LWIiz+4B7zqX8CbPKzHdLKxqN?=
 =?us-ascii?Q?0H4fsdoAnpo10jHkXW+l4TIlh6c/U9b7GaKB2R4r3JTFF5LvO85wC/6AX63n?=
 =?us-ascii?Q?EStwTvz5ECAdcGBOA0DUL/Fu8Bn0RR0HQn4L42SBKlc/GdR5IpGjsSlejqjr?=
 =?us-ascii?Q?Jzxe1mf75+WISliEf83klTSIyYqwiXt9dehtq5qqEDlIM2bQVOpzERW5hB55?=
 =?us-ascii?Q?O+RIUAy3No+d27NUv9+fRsuM27W2NgvNlTp0CunK2B8TS76O0rsgEYzaomUx?=
 =?us-ascii?Q?uDJTS5+kKC/txs5tsjzrLvcAYGhwEp7h79TFuE2B+lE8M/yoYsfn3lh8ix3z?=
 =?us-ascii?Q?AtCwao3sG2xAXTYDwKEmYIAoKZ/d5/dBFZ2nnYVoJFcLJzlNO/0/yu8aOkaq?=
 =?us-ascii?Q?JeUlqtlrFUD0uR/C6X5LG9OT3ZA/iyIwkerF3XN6DWu9qrYgqJIRXVvnhdss?=
 =?us-ascii?Q?0ktBAvQp+Gt6ObbtfhdUJY9GzCxqvLq6SMy6kFcIOVPJP9Ip34EdFtupXX4g?=
 =?us-ascii?Q?0WzAN0aM+plSDg42SQteGBpvmrHMF9d0qFWFwuS2EqEp+mEjsGSkD8U2FwKC?=
 =?us-ascii?Q?8IWyIIMZyCfrmSt1plg+a8SMLuFAU8uBQqO+Vfco7cjz/lAbEhJau8srAjZ2?=
 =?us-ascii?Q?mAsl2GtQh2lt3z5ZoFsQqy1UzsNLJAQyNNgt/j4o2v5Wd91A0aqMyLo8zzxq?=
 =?us-ascii?Q?dxPn7okiqng6gyCQcW6I7LvYjgK8MuFhwZOKmlIbtlVzs1XMHdaIcXJuolAn?=
 =?us-ascii?Q?21YJUZ9CgfionByrh35mORdfwUGf/4/snOEEIKpcKhTN4m02DVsuRw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C1PTbmr/9Qa9nNo/lbyibFmFhBujyt546Qc/H8eRWD3jGiKKMOUqyoRmCe+V?=
 =?us-ascii?Q?9QFGOp+vzYEzcsAcNit7Ni7QA5cLc+Wenva//SQOfBhvY3wZG7gZs9sr5xwd?=
 =?us-ascii?Q?yVqfHoSRLR4SDOiCdfYd6SWv8p6cdjdZVepMilF3axIDkAzhDhx4amrCDkI7?=
 =?us-ascii?Q?huuRZZAQTloRLPNVNlIdVrPkv5ZJW0exQviX59utmE6tI+wQ9LBgX03Q8iPv?=
 =?us-ascii?Q?QoXfZ3A0MlEC8gyjcwMfrha/UrSLBhAXSe1TwMl8buZl41SdnOH9t/6Uv3VM?=
 =?us-ascii?Q?q566AyT9XgcCpKNI9OrNR0Twz5pkjoMdjn0VxZUhufBGX05klcAusfp1DnS1?=
 =?us-ascii?Q?97DqqL4Ikvo3Tp0PUpGld37PgL9sSW1rW+1mfwyOdeAV0QJJXyskuNbkj4jl?=
 =?us-ascii?Q?L5pa7OPxzuOS7dnmO33V5wCj3gwKJRm9B81Hx1WitO/6hIWpzubkaaMiQyLj?=
 =?us-ascii?Q?g7M4hGZp8mvK6rURF6i/ADqp9FKKDJV9UTF+DPTOOR7oJlwRzWb3ziaeG8EA?=
 =?us-ascii?Q?6lmGdA6ZfH41mingkHNdKu94QZ5d06kIAPQWykWDm4XQyEQye1eOLctLkylX?=
 =?us-ascii?Q?HOI9z779ds0rlBclp+ImpEzVLPizAnspYXV/i+R+3GHGcG7yxe46waSnGqap?=
 =?us-ascii?Q?KYJGdXRx3A0yoxCIw2LCaU9vWOLbRaoyIqXFPxkrlIvulhF9ECnD7IO8XX8k?=
 =?us-ascii?Q?Q4XATYTm/+LUjL2Ye4uGOfZ3fW5TIU+h7RApxG7518Gh0nSQxa+bGkk2EVz7?=
 =?us-ascii?Q?VSMYdMb5CUkUXaa+MT13Hr0VTB2zlNG8EmCO77X3o98FMCmiuAQ8ZZbEoX4N?=
 =?us-ascii?Q?MvYGJ22zdcA21T5IzC2TRkBzFMiT5srQ2EEpC6RqRe7X4Of54Fclt+ywHIkp?=
 =?us-ascii?Q?nV2A3TJ7tSO+ZpkOW7BAiwXJq2St1TOhf3a/9DBzcsT8OMH6kDU+gFfQSPL5?=
 =?us-ascii?Q?JtssRu3XSDISZJf1eDE4kEW/FdRWulgXl69C0l6nQo4k1oAp4BldHr8zDyHd?=
 =?us-ascii?Q?Vz2hLiYz8/r4ZCEjxtbbJLPRJOmquQfru5O1DBgO6xF/uk0E9PYMxoFzm9p0?=
 =?us-ascii?Q?SBs2T9iS5zlvI6F1jLZdtbv2MbfQ758fF8XxzqlgLe/QglYu4q5ezhQYvX3P?=
 =?us-ascii?Q?3tqs9OtFq0IMIEhTOnTybDyiOnrzyytVnD2EwWSmAEncqrL10YpB8tvAX4wD?=
 =?us-ascii?Q?nw+dA3yxRslyUDYuKfud8rlz/sv922yHrCKQbah9C4s7aUVvLAMCWYtTRyCK?=
 =?us-ascii?Q?xe5lf21fSGlHD3k46F+VgyaDLzwRYnAmKDqfLnCI3TQw17f65jUXh5LMd+Ll?=
 =?us-ascii?Q?AQ1rBPWdrFJLuUzdcTp7jfqGVOEyCG08aqRUWJlCiXUwrD97fLpaju/kAHeV?=
 =?us-ascii?Q?30RSQc5wOiHYxh9jldGx5TAuK6r4cSbdnYTTLKu9eIWoOWcs9eKvcSvnUDwP?=
 =?us-ascii?Q?pVCNtlC/V/UJj01OthblPaAJQSebOLu5IapD7Xtm4M5obds92Huj8iVwFdK7?=
 =?us-ascii?Q?28XAMW1zmmmA1jOdoC2909d4YHmBCulKHAgShfWbReGrBlnitlX/+rN8iBE3?=
 =?us-ascii?Q?ZMWJ6XlwCPjYa8jqueUnGmU4cQODeY6r2GdoALQJgZDo7FuQJZo9quvmnqBw?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e50e8390-1f25-437f-e184-08dda6803396
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 11:32:51.2299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXFhKsdGKxc/tpMdr2rd+pkSOj3qFbyI4jxfyXmExl+6A/x0kqW4WjDu4gUJ0BVROZRpVftvoCB/t3ZCHjKdO8OTPp2rr3XEE4tiCVmr7I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8842
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

This patch series adds support of 2-wire and 4-wire spi modes. It speeds
up flash read/write by 2 (or 4) times on the corresponding hardware.

Only 2-wire mode has been tested so far. It works fine with en7523/an7581
chips.

PS: We have dma support for reading/loading spi-nand pages. The patch is
undergoing internal review for NDA violations. If everything will be OK,
we will send it soon.

Mikhail Kshevetskiy (2):
  drivers/spi/airoha_snfi_spi: remove unnecessary operation
    adjust_op_size
  drivers/spi/airoha_snfi_spi: add support of dual/quad wires spi modes

 drivers/spi/airoha_snfi_spi.c | 131 ++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 46 deletions(-)

-- 
2.47.2

