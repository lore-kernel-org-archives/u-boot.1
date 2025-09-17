Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9C8CAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 21:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB74800C1;
	Wed, 17 Sep 2025 23:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="x/DOreu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8EC80C93; Wed, 17 Sep 2025 23:47:22 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5132F80050
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 23:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQlJUREvkjtzYtnX3b/oxN3thSBM0uXYO/sEJE+gWyuq1DV/jK8NcruS5QoPpBnNuPH1SXDIiek7X/xHkDmt095TURouzXHxEKg5ZHAP8b2NQbm4ruXBwCAB7aZYAQ2TgRBbxth/qp4fdedPaKOqr0tDRobV9U0wCW6Ty26cGrnT952cEImHMnDDqVUIJm7dWoYJY75pzI2+O37jX0a8qAIqvjc1jI6qTwPKKMBcDE7s7r4Sqc8E0NRZC3f5tSGn90hfMJ33K1bzQPqa2/7+K2paDWYa5KOoj+rzE8w/IEtMB0u92tFFXIDcpa8bA7FgQwaJhluzgmgXO/B0BnhU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWQiz4de/3jh/GIA2WDJuahZuQX+ufyXlWR0yFurUSU=;
 b=pk97T5D6WWnwETDf5yRMmlVTdzvcxwuOJzj6lYIe20oZMoTjK8wfVcDxM6JHlMYrvJyjm/CXNPDaLANOSk2CcHcJoqUlHjkEWYm9z+5XpgyukJANhUm+5mwf7hCJ+J+5HSdnQj5tls6kZjJuHnzuvqyF9VKfZQbGqjruURApUYX0xDwP0UnZduDDdKndWvQ41KX3GXFmQJ0k3ZeD76ZJcueChWEX/xjw0Qp2+uu+648LEbLxVy2Q9Hkd2n4OBFRnmiD9RKNkmdJBwC7pTPcAdzJTCybbTG+zKrDVjuw9+fwu9XoKkmAgSBDcgU+ALIY6pYQTuxDFSDUYDWHvAlGb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWQiz4de/3jh/GIA2WDJuahZuQX+ufyXlWR0yFurUSU=;
 b=x/DOreu9FU3i4sqLlkrcFYBZtPZAvBiHzgLr0+pyC5D5wZcU8Og8Fjsh/+/SbGYbSyJ8JbLFP9umoj3+Yxs6g1o0+dcuGmMQ/D8lEFxRGjO8yb5kUYo1FgbM6ba/ElqjAS4KY/OBa8VxaolG6P39J3eHX0w4sYqfyw+q4plh7vSj+OS6dsir6/DJBI+tfCRcHYYG53S3LBub+mGu8MXRMPNADf9PdOh7BjSBcPGqUnPZWRZS1tKN+w71bNiX6aSB5U3Gjt25ZWNB0+4GQqWTH3vI6Jb4ctGUeiSQJWudTJrWC/STCw30jEldlZ1LsS7fgISFQK6NbLvFvhpipTTlyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8188.eurprd08.prod.outlook.com (2603:10a6:10:3ef::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 21:47:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:47:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 0/2] cmd: mtd: fix benchmarking
Date: Thu, 18 Sep 2025 00:47:04 +0300
Message-ID: <20250917214706.18130-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aff470-aacb-4cd0-2970-08ddf633c412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?legx+8l1VGaqbrMD0aQdWtYGqOG24vbDQkpw3i1t33gu0sojx7ATDrPi/2iw?=
 =?us-ascii?Q?D3pmtZrmFQIMfs2/RzU7+8eDC8G4CBp1Fsskw798uYTjANWENHH+a+1ycqAE?=
 =?us-ascii?Q?hJCTb1rMyYZor3DC14vI5JNEHWzAeKd7bkdf0wlH9iw97j9mOzuNisNh0PTY?=
 =?us-ascii?Q?B2G5qxffS1RGUUOaRZg0rU3FO80Du45J4yFtwBLtsTMoZ1gUudClfQ0wp1ei?=
 =?us-ascii?Q?EjEAH5c0q6hIe1WWRc8B/aYtENzSasNvTc1tOR3U6e26OHg6GM3Nwrzoe/YO?=
 =?us-ascii?Q?T8GWPlx76ul1n4ZcFY3qZjCuHEcCVWvydhXOV0ga7XYj+0YKcoewALaBHzVd?=
 =?us-ascii?Q?M2XAyYSpQCSmzUW42dTPmoOMpIcXpd3FvDPgKQMf42cIAH8zynHih8X5o+of?=
 =?us-ascii?Q?LyrgMgI+Skz9QhpH/+JyBuFoXcxk5kfqPwwvT/Pvc4hSE1Q30U7cQ5hMnjBN?=
 =?us-ascii?Q?mYmbMuNY267qRhaWeJGkSftCFuG1PoRnzY+QZT28gpKRoAjis3dnWTgptFi8?=
 =?us-ascii?Q?LWH0T8jTI76wAi1rb8wtRc/2HfSVnOqFyZQMVyR9FA+otBhuk6B8628ZfMc9?=
 =?us-ascii?Q?EIOvpV/5btERp/DTlrdM6L1YN4lxI4o4Iz+/+F34LpNjDWfqHYuEsP1RIRSO?=
 =?us-ascii?Q?pcYw6hTJNk3Ol7gPzSRvNOu5oK7iGET4U1esOsstY1j/19DKRdeTbOML/B8x?=
 =?us-ascii?Q?cm7h4Jd6xDe7nYCb1R4uwbA0SMl6OJL7x7iJ2K3c+49KOUL7P3NbsaZeHtvz?=
 =?us-ascii?Q?e5gUXmqZ1eLEHLkUOqRLX9qF3s0tnYFwNKpBftf5eMJueDHbMjjrjXQBgFjB?=
 =?us-ascii?Q?pJ0/pJnvHwTT63xCBX6mSon06qbSmAA9Q1lgigMDCkte7+SOlZEag6OZiSeA?=
 =?us-ascii?Q?T1L7iYonLVl8Gk1MCgSkOfDnBACjnoL2i9FWI1Mq6c9S9L2LdVLjn5ULLTgG?=
 =?us-ascii?Q?2OINasp0RBls3kmLslKxA61QtJsN71upe8O3fT14Ni12O+2Xq7PYSXOAUCLf?=
 =?us-ascii?Q?LqDeHYPCI/0nUo3m2hTTb/Qwz5nJw86cZN042aw44qXuAIS+E9WLUbbrb2C+?=
 =?us-ascii?Q?LUZEJhfjBY3DvxMBRp/OprhQplHwDPUzeVBZ5E1uJp5ylYYiT8qCMTibvp3/?=
 =?us-ascii?Q?N4kByqMTuqARthqGoXL+7kqHlZwXpALZf2bUtG12uk+BBiJjJaMkO0Ib7hht?=
 =?us-ascii?Q?5kM8F42vrufEdnUQrVubSBVRfURnoaeR/f4cbXHHa3KRbb2uFQ2kZCVlnnPI?=
 =?us-ascii?Q?QNypO55hG5BF+LCb0/2PKuDFo7vXk+M96j6VanD2qjzvyjqLLD+C2p3+/tmI?=
 =?us-ascii?Q?Mf6v0c42ULpyWTJicrYW58VL7CWpNfEnbxW8QZNsBqbjDlKyZDFRPVQ/vLcu?=
 =?us-ascii?Q?EUJU6trBoVznKfPW3APKtkGFXFlFOrjfGiamuLKZXr2b/w+izdJs6llwN2s2?=
 =?us-ascii?Q?wTci0B/kgpMXy/ATatGRqch9PBoJOGi9O9W2vdQYoIotxwF1wgz9VQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdE3nUtPZQ2jtAJVmY6KBLSkFy6uQNt4FsKFkXFZLOFuDDSdmS9zH8vr3l/e?=
 =?us-ascii?Q?IR094fTGGfokq2KkPwlDBM7x2EypJqvr7gmBFk4lV+C1rEHh7tKW3cs2cybT?=
 =?us-ascii?Q?Wffy/vQ7Ka4klsc8+85EYt6CdW+nAJaq23u16R6YIyme3WHcNMJOKLxOTVXg?=
 =?us-ascii?Q?qcjeGvN06QsKwRtqsKysCx3x1cXf4IrRfTWAIFlP9EsVDIDX25csBn6e0vfm?=
 =?us-ascii?Q?95sOJXdiM6ccNsLLrEayi61EDwo1BeX73sAsIbuq0lVWcAPxorrCcW5Ixvpq?=
 =?us-ascii?Q?h7NYJp95DEoqqvfeOvkOUvMBny3TQHl8Dr92EWzgBXUYXxxIRLpvCdzMoIAJ?=
 =?us-ascii?Q?UzkeXnZdVaL4HwwVE66bICioHr2pdEyZVghbStpX/mxKzHc8AYiQe6MjwXcm?=
 =?us-ascii?Q?9VUtbqIgfy3KG9a3BB1DUZB3VWppWfcioCQZ9lPVpQN7tPtRNR09galsogDg?=
 =?us-ascii?Q?1vDQp+7Kg7jEccTdOJGy/r67edOtoFE1QoPs+tkyemTY+8oCja6osf/YYTqw?=
 =?us-ascii?Q?7qUObbFYijjlnDm8eczARB83CtcmjteWUKidzrZGXvYTqfwU8rvIj17sGHpa?=
 =?us-ascii?Q?swGlFDDJM/8qTTd/3BE8Q8UxH+GFM74DC21vzQkPcmeDRdwZW4LC67R+mZ5B?=
 =?us-ascii?Q?wvqfbz1cKbopcrlgkUSATkAWoBOJEtfNrRf1ybR+hYXjBn6yW99lesn0zd0j?=
 =?us-ascii?Q?HnZro9uvS3fkK/1mWDYLUj3TgbqhzxQ80GuAgafw58syUMG82ZZWndS6XlTl?=
 =?us-ascii?Q?1HzSUQV8MQ0VDxfJI6AsgkBICc1OOpoYn6BUeHAqeSLRY86Guits9c/js0an?=
 =?us-ascii?Q?bl75z5bq/Ix7c6YvWl5yowgri89F3+cdxmcXm/ff44PpkNKBTQiTgmRnyZ8d?=
 =?us-ascii?Q?DQrGv7fS3UtdMTgQQQNcRVV8xb5p2HW+gQEO+VbBiSBGj6P2ppqFkxkaf9Ky?=
 =?us-ascii?Q?UnKbDCiPHyJOWyKz730M706hFz3s8sKb0lOINOmZDkJjfYjvlYEZIjOxw3ot?=
 =?us-ascii?Q?HmAnLx4QlcovTs6ygFyVImUZxZ0gFWvrAvXhbFMBurn5uX7Jb6Xkwj/EFZYB?=
 =?us-ascii?Q?uw05ToB8KJwvnUa5ujo4vnEHIx8gS3v2sMIVZTNL7UbtwmlSu70b+6+vW3kY?=
 =?us-ascii?Q?W/hNg85WbtZBoLekIRjNFl6fRXtcgzB3FJkk3GkGMf5XY+EypG6W+gz9CSTr?=
 =?us-ascii?Q?+/Yt/XthB0fjrUYnW+7ymD+0b1gJpdfQo3xTD2sczWaJ6pFdsHNdADuUjnpC?=
 =?us-ascii?Q?4guJ9rCq5e8qLYUfTtOS9LcZV8Wt4BtthejIB5PaOVvZLncSrJi4xwEm73QD?=
 =?us-ascii?Q?A+3sCHBAzf5jxMYow+nl4MxbPMJqgvK0mNNoCejqF23+SZuI47jMzsNHylKO?=
 =?us-ascii?Q?5xvx6w6DgIZKIGuDdwc4jyTFMQhahsn1An/Vr+sQ1BqfAdyxjiiN2KtOBsU2?=
 =?us-ascii?Q?Ks64bWWcodxbjOinDz+K1NO7Y9GrHy7fpfT64NPN9ynASrvf1LIL+SOsOVlI?=
 =?us-ascii?Q?rUolwJzc/K2S9lB2/weNPU6gtW8+mI/tlajfVqLXV0drX11EKNrY+5Dz2bax?=
 =?us-ascii?Q?Bu8MP6ln2xAYz7chX8GZCfFqOBozOLWjg/QiMQvQs+CflpVppb6jxz6FLdAL?=
 =?us-ascii?Q?hVgap+pD5j2RueiKgtIdhOU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aff470-aacb-4cd0-2970-08ddf633c412
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:47:15.4170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oPtxOsVQPvEWjhGcSW/JzrIUDwMVuOFC4icnzNpc++2jSmtMX55pVURPvbHuPjFkfEOw639jLwDH+8gZl4RmSK3EpShddW/VOWclekqyIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8188
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

The patch series fixes speed calculation for nand device case and
updates help to refer benchmark option presence.

Changes v2:
 * update commit message
 * 'Fixes:' tag was added
 * calculate speed a bit more precisely using a 64-bit math

Changes v3:
 * split on 2 patches
 * update help for 'mtd write' command as well
 * format help for 'mtd' command to align device names on the same collumn

Changes v4:
 * attemt to sent incorrect patches (sorry for this)

Changes v5:
 * really rebase on top of master branch

Mikhail Kshevetskiy (2):
  cmd: mtd: fix speed measurement in the speed benchmark
  cmd: mtd: add benchmark option to the help

 cmd/mtd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.51.0

