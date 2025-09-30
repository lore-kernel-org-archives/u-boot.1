Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3CCCAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 00:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956CC8344E;
	Tue, 30 Sep 2025 02:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NP1JDHHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B4781D6A; Tue, 30 Sep 2025 02:21:24 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2219483071
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3L27r4kOnN5kSvGHsRI2J9Q8DACzHys2xRh38xdpO5FItte0YK60S1zyQmLxz48fxWO8/LoF015+P9XjnDEK0jDPM5Lvp+5VVYDg3PVT2W5Qz1hJHN9IzqNxQu0XK9ZNOxUZM05xa0OYIbQVa2O+v3kRRl+bUgdYZO4BEcJHSHQfH7m8dYSGLdAC6v8SB5io8vaw1MzzvyFiAQ+/HauMj28AM2pGVc4JoW/Zhi7Z+98jvYhVyfRkPLv0XTaXoZBmGr8sArlIy85a19/79uZCEcTt3JRy1Hx1R2bFQNp30YXC2opdYYadzjOqyZgdMHJxJRIC7yY6Qj/D0HriRuQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9hsK/F4YhQbYhYdHgz92H+LT9iJpwsoBEux9QjKzgQ=;
 b=ccpXpDeS6yZi5x+RtNEUGIw4sECCdVng6C4UQ/IfqvRCry4BLcsCrHaKMZO9o/E82IipxgKLtC/kcXUkA5ALYGv7UVHqavh7Oa77XJcacmYlFXNnRs1T8unAH1QrwTKoY4x/rqSZ5nOjyxF3ImfUXuYsLPq08PVwzquT+UYhkfa4raBlKCHd+My5bcUL13u5EVb9HVGcuYm4OnEODaySXl2s6/ERPO27Uh9PHrX6cf5uor+Jx5ZQnSEQFez32kmHhWbaJ8APhbuDxKp3PGcJHMsrdaax6Rwn2SY6WMina3+g7ybcbm4xDa4RtHEn4XbOigD4goblRifJAN1gZM0ShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9hsK/F4YhQbYhYdHgz92H+LT9iJpwsoBEux9QjKzgQ=;
 b=NP1JDHHTaaJf/8//EN1UVMtc0GGduehdzvDRGfrovkWVPvi+FE921bLMkC8doq0cbjIvsH3yH+LkAcOBuE9EXEQjwOpCCIuoYqbgyK+NhVEC+/+5y7lX5h07yyBHdJNd7VAAcg5oFGKhzaOvNN8A1MtJS0FykDL7g45GdbK0SMkSMWOvuRhQR2L+KsAATHKBVM/Mc1gwms/R70uWh5e+Jdo5UgjXsXokFEM1365adgoX/9OROUAbLv/djBSyxHfnHOArdRMWbQAh0WlZlMoeJIutSzF1qcMbaYjBJ9QKnkGN5ifa+GdIGG/bs0q67kv/qZfbr+TkLjLpuOIBRJD2fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 00:21:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:21:18 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 00/24]  mtd: spinand: driver improvements
Date: Tue, 30 Sep 2025 03:20:45 +0300
Message-ID: <20250930002109.3600886-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: f98d3f73-524a-4de7-64e1-08ddffb745e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6e8h6WWfkuTK3YXsgkGZmBl08VEQyzzzscGnTLo6nU+uGYJM+naIaauU3Ftl?=
 =?us-ascii?Q?w0yA6HWsMBbniSvts76e/d4NmwJn6KbFpOX6VKn5w2AF+/zbZTKBZkMbXrsY?=
 =?us-ascii?Q?9ZvwgGrlMyuGcB399OyoqN29dUQ+uLV5P+ixeLW4Uf+J6tUjxlBbD/mmyeJK?=
 =?us-ascii?Q?ZwYTwM/7qsqyb/Aiwkr/ouUzmVFLdNOYdBep/eXzyUww/m3G9c0f4V0hKtj3?=
 =?us-ascii?Q?ofIE6GT0YCR1F8QKPtLQDUy8SVmEWDQ71qT17R/yhLsDiyIKOZ23KxEPZwON?=
 =?us-ascii?Q?EFTtRZRwrAqYgAKh2C5Xx5KaAQngDZEYrdqEMvIm2U5P4dd/imfPrQ++H3vD?=
 =?us-ascii?Q?kGNoL2JzOCZeKf/I+ZM0PLsGDT52Rai/AhDCYAfvnh5o4bWFrJMsJrnxXCVd?=
 =?us-ascii?Q?Dthwfv0ChuwfYvG4HFQINOl5tqXz9INzuE3XlZDqR5mufukUdUYSFgMvGdTF?=
 =?us-ascii?Q?2tAu2cAOHICGAxKQL0XJ8PROagKm1AMwsYyEgWuCQstIsDqNHwHFpgp8vsF9?=
 =?us-ascii?Q?tlfhz0OAnHpLbQSWjfreKW1GCb7BYPg8TovwOX3O6qgkugTXMdq8q48GSVBQ?=
 =?us-ascii?Q?6uNfAjqyK5HTZuZMB64ExbJW23mve0sSKkZJx16RsqRNacRcd7TbWrM/1OP6?=
 =?us-ascii?Q?q/34UxDdxCg8cPqF7IYOE6PpcYiHLYiICkT/7rH0Z4jQ1YSjZ+gmaENjYBV6?=
 =?us-ascii?Q?csAejaUJYc491i2fxY0Tidbn6amMLOGr9IB4n8+CiU8NQiinde+pTW4il6Dx?=
 =?us-ascii?Q?5vGci7YWh7P0yN1Uvj5RkiiP67lqX+6j4DQTdS2FGE6qB+N/zVrnx00dFrJQ?=
 =?us-ascii?Q?9qLXaRew1kFDBY1ryKPu5rJChFTElFThKdOeAQCEyfRIgRsipk1vFKG8CvUZ?=
 =?us-ascii?Q?yqegMPQucZvdIgYRpNyMuUEOx6ciPzxDStRvClBC9N1HH0Mn96ymnN8IuS4r?=
 =?us-ascii?Q?3/xxIKmIiPG9PrafyNFf9rDgtgE5REg4SnKTteeaiZCHLr/QrgiB4WWwrQ62?=
 =?us-ascii?Q?6PKEZ5MFT80cBQKy7sMZhSPoKFTBYWXb6CvKwDU9tnCFvDJcUsj3JL6nuVsN?=
 =?us-ascii?Q?/aVzG+tNl0sTXWqq4nGroPsB4RI6jpRCwtdW+a8osaM712zHMUcLTc6Qk8sK?=
 =?us-ascii?Q?hndZschw1BzNttpfobtQu2OBxnIs3l7EpV1XMs5EoBcfJm+Rh/frC89KG7DT?=
 =?us-ascii?Q?26yEiXoiuKewqvyH6Ny6ipJt/pF3AUI1mQ9+rgbddeHg+qtm3ZvKNq6t+/9I?=
 =?us-ascii?Q?l8insGoOKgKdmMLm21IoEcHYsxQd5PcOX3N3I6rlniJScAYethT+BApKcfYE?=
 =?us-ascii?Q?+y2cEdL1np/MiBao/roRXbfId07mUNpLCX/bJF8TUq9m7Ek5MtgVGIs2q6FY?=
 =?us-ascii?Q?PBoaow4ouXfMHaFYOSa75q1y/quFID3UKo6GOx188Ql8ntTBTwFi8n2rp3J2?=
 =?us-ascii?Q?AA8kn1fKsf464uVoNFgTTnBm2TZ9OL1xhUZhBVpBeFnbXcarxJpctdDbr1LK?=
 =?us-ascii?Q?vvK18hrGwJoMQj0DyCV6glY14QdGcxBbZngPyoi3YD1E2F57chFrAtHiSw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nE6iuSb6zf+Aya5Yquycpd+zMmcYHcZVOL9XDzsom92jfXr/kYThQLV8rJv1?=
 =?us-ascii?Q?EWF804DJWT04/Ymlf5AAOJCxzaJQvOuqgllDl8bxGSHcBgnMS0IPu6cS6Nx6?=
 =?us-ascii?Q?1sQBLvElLfr+AS6o33L69ofedwmCK0JjCoh4qXOtS2HdlX+iZ5zwIb5M2PTq?=
 =?us-ascii?Q?X39blvy2db752vkpxeHBjBhmGi840V2TeOvVKYZ9oC1YUuFJJqtQkUsvZqRF?=
 =?us-ascii?Q?He31y4hu7XN9vgyvLAZA6Af4xgKOeXQkizFu26ojiBxhaDChFgzdi7B6ECs9?=
 =?us-ascii?Q?6Ntj3GXeN1i+SktbDK6MAhagPQ+R0GDEQzx+hydnuAw8x79SZwEI5DP/advh?=
 =?us-ascii?Q?VLnsYLvoMDW5OS0BRsC8/pJ/CdReWf4LJzUnQHDxx0HMJMwuG40o3Jl148hN?=
 =?us-ascii?Q?6IPN0RYuelCFRJnybgOeocJRXk49fN+xu4bG6XMWS1YISjmVVCRNIfgtCd8r?=
 =?us-ascii?Q?6JFkGIH7NIptjFNkb9/O/L4ozuMz0jJ1IWUxu7ydSrrfvdSIAuPWKDNN3Hmq?=
 =?us-ascii?Q?ATDSeZ4/YZXzGzCVsU/Ut0wfOPhQdbla6/QbDRFuf1boX0t3eboYr+SB8xzw?=
 =?us-ascii?Q?FtkFSoowdG7I2HYr8/qHQuV+Zt76iTI8moxzmOpjwGSABjQIbpKcXT9FT5DK?=
 =?us-ascii?Q?BJ5cyW682pZbityb+5uSauusexOwW4QMHahHzqkIoyQAjyghEc9ri31cejp/?=
 =?us-ascii?Q?qWOrTuv+e9sS5UZJAlC7/f9GGZ5rJkP4908PGFrxLbC1VDpEA8rndr3r+h+A?=
 =?us-ascii?Q?UepTdL3ccZoH3Mg3v4lTqXlxae/EfyKKXqC03uu7ozpcUwzrHE4B5/OwK9LT?=
 =?us-ascii?Q?SEknpn1+k5Adkgze+3c7+neGpLkJguayglJrdLpkyCDalyLX48n+XrE499Z6?=
 =?us-ascii?Q?E84mGMp75OEhBubSvqKaDpQHrDlKAFcOsiEMHJhxZmEv77U54XbP8OPn6Wm3?=
 =?us-ascii?Q?/OokJI0QZVna1Kys0tvYOAZLnKA5LDyg0PjTjAxMFrl/ELLxm5y4+mDo7Z0j?=
 =?us-ascii?Q?7rzS/WBSJrBR/q6fkoidKTt2Csmq0z0d6aS68AAxaVpTz6jGLiSL5rjJT3Ly?=
 =?us-ascii?Q?yiHv4mYHa/v90rE5JElV96dt4ob+I/S9xLeiasigBqAtQR56GPfr41+WYMU9?=
 =?us-ascii?Q?7j7muRImXTA+0cA4ZieNb1m3HyAiGYXdZCnf+USDi71gjfSfzZoMOVd4XeMJ?=
 =?us-ascii?Q?kPORdrP12OBlysftwQGj9obyX/c+Fv7vXk8z7nvyAyd35QbQ7zxhm4AOrTnp?=
 =?us-ascii?Q?FlHg6RjuEAMHMAoBSH3GA1mLhO4zjjEtMOVnPZMbR5pBkDV02QlSjD2JbhRF?=
 =?us-ascii?Q?4qs7UxwBW3LOLc/lgYmvT7AeNtGV+hYpLvyvJEonkG9eVsO+iRhprbTrl37x?=
 =?us-ascii?Q?IBw+A8ms4b1zTyObTgA68qxivBq+jopGlykvcku9jaWYWt3yRrViEAIpznzW?=
 =?us-ascii?Q?WSCdd3H9pEmuPubnWY7622x5GK+fM5qeAUVOT/yYc9Uv1VrH6KPEEgutl1v4?=
 =?us-ascii?Q?n7AMyTrLVEb+4Ofb3kF1lTZNCYzxJV+e/7sBL6HAyLEgAGqR/vUSNBCu4cmQ?=
 =?us-ascii?Q?39ATfNpPJ/Slr0lR/o0kjPtg2twYjBVM72d+HWYOOnqhHUNYIDNEKEyhBTXK?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f98d3f73-524a-4de7-64e1-08ddffb745e0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 00:21:17.8500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcWavgpPyKF6YExI9PqDuht8CD7zzfDjByZgYdu/s6jJvqcIPfIW6FAOTwhaEt/omPp7kfMWpmTduuOKjc2Ew3CNnwpvdONfdv22NuIsYFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
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

This patch series makes u-boot SPI NAND driver almost the same as in
linux-6.17. This provides the following improvements:
 * it becomes easy to port changes from linux kernel
 * more flash is supported
 * spi drivers can accelerate flash reading/writing using spi-mem dirmap API
 * continuous reading mode was supported (for some flashes)
 * OTP support was added (for some flashes)
 * add support of special data recovery reading (for some flashes)
 * bug fixes
 * other minor improvements

The following linux kernel driver features was not implemented
 * support of different ECC engines
 * per operation maximum spi bus frequency

The code has been tested on Airoha AN7581 (64-bit) based boards
equipped with flash memory Micron MT29F2G01ABAGD

Additionally the patch series includes continuous reading mode fixes.
The corresponding linux patches were accepted to nand/next branch
of mtd/linux.git repository.

Changes v2:
 * update patch description
 * add fixes for continuous reading mode

Changes v3:
 * fix duplication in patch description
 * add more information about commits ported from linux kernel

Changes v4:
 * the original authorship was preserved for several patches
 * the code was synced with the latest shapshot of future linux-6.17-rc1
 * spi-nand was replaced by spinand in patch description
 * continuous reading mode fixes were updated

Changes v5:
 * add missed SoB tags
 * improve patch messages
 * add tags for patches ported from linux
 * drop continuous mode fixes (will be sent after corresponding linux fixes)

Changes v6:
 * improve patch messages

Changes v7:
 * patches to fix continuous reading mode was added.

Alexander Lobakin (1):
  mtd: spinand: core: add missing MODULE_DEVICE_TABLE()

Cheng Ming Lin (2):
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: Add read retry support

Daniel Golle (1):
  mtd: spinand: set bitflip_threshold to 75% of ECC strength

Gabor Juhos (1):
  mtd: spinand: propagate spinand_wait() errors from
    spinand_write_page()

Mikhail Kshevetskiy (15):
  spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: Extend spinand_wait() to match Linux kernel
    implementation
  mtd: spinand: Make use of spinand_to_[mtd/nand]() helpers
  mtd: spinand: Align logic for enabling ECC to match Linux kernel
  mtd: spinand: Refactor spinand_init* functions
  mtd: spinand: Refactor ECC/OOB functions
  mtd: spinand: Sync core code and device support with Linux 6.10
  mtd: spinand: add support of continuous reading mode
  mtd: spinand: add OTP support
  mtd: spinand: Enhance the logic when picking a variant
  mtd: spinand: Sync core code and device support with Linux 6.17-rc1
  mtd: spinand: fix direct mapping creation sizes
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

Miquel Raynal (2):
  mtd: nand: Add a NAND page I/O request type
  mtd: spinand: Add a ->configure_chip() hook

Takahiro Kuwano (2):
  mtd: spinand: Remove write_enable_op() in markbad()
  mtd: spinand: Introduce a way to avoid raw access

 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++
 drivers/mtd/nand/spi/ato.c            |  88 +++
 drivers/mtd/nand/spi/core.c           | 975 +++++++++++++++++++-------
 drivers/mtd/nand/spi/esmt.c           | 123 +++-
 drivers/mtd/nand/spi/foresee.c        | 107 +++
 drivers/mtd/nand/spi/gigadevice.c     |  86 ++-
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++-
 drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
 drivers/mtd/nand/spi/paragon.c        |  24 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
 drivers/mtd/nand/spi/toshiba.c        |  63 +-
 drivers/mtd/nand/spi/winbond.c        | 361 +++++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 ++++-
 include/linux/mtd/spinand.h           | 374 ++++++++--
 include/spi-mem.h                     |  93 ++-
 19 files changed, 3154 insertions(+), 509 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
2.51.0

