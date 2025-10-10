Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6038CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1956D8422F;
	Fri, 10 Oct 2025 14:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="17DfD71J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D5584286; Fri, 10 Oct 2025 14:41:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A8D883F91
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sj15/N+/y5n1CVgJeAbbX3L19yJJwIzRg1VJljLHs/hObI5Ev/PFy4vcKGqQ4S76WVehIyS3Ttg8UaJCTctWmCGurBzySpiBa/yNDnOW8my+1NURiZ9rrC8wrMtJZbW2hLCRv5gneX3++O8DyJI/iJKhVb2nz5ms05a3SCcOmnBAD2O2Cm5knlEJvNqaMI4XVPt/AjMph5mYp1SD8C7ugbW2QcP4Fo+9gO2ZVE1EAbCsmjhCjLSZOn79GWa/ml+ancr8q09rbRQa6l+hWB2mr5SwLZZvOLjPLkKkQahZ9WncH6OriiLyCyWypUUKHHsxcQAjWIY1uNJpc2FDkg4+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOXJL0QfJbBf4zCD8POP5b1Ivu//biZp/f4Q4rfEZeI=;
 b=y12hnm7loqbqxhhvSnvrRdQmQbrIwmVdj1qdgJocrynFstR1NCdD8kQOq/ujBE2SVs8SLQ1ea9RELfvzGWzuZxKYjY74oqrjFRrKI2ouodUy6we4936px4VKCqdrYD0XiTgu/fopGo8UsWb+tcjTv7aQrYPmPSpy7T/IxfohnVDbUM+yhffQ+twyiroOkkexQK9ilHqXhWKRtVx4k8yONdmXKVe2WhYkk6FfrmiWhhwkDB4pr3iz2AWFm5kbs+q9raA5iZXLhFN9DM3u944iCcPbNT02YgSrdLklkR/TRvdHduyoQHd8fxPEVnpf7fqMSSVi2eorRctiVk8hW3XZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOXJL0QfJbBf4zCD8POP5b1Ivu//biZp/f4Q4rfEZeI=;
 b=17DfD71JfpEbOWb9j4DkNb8NTXh9+9o6aJvEIAEyBB3jlqRymQIqOBaVgL+47PKUJO3IPm5QvJn6h4jme04BsSpi4lf5aBHVrOU29dFgDAo3mr6m8tSKjQ3uBckBYndFPvMuSZgAW+cGnlesTv181JaS1L42wBGGEXdF5rVQRT4eNTtCMgOTtsjMt15VyglUTmleaIzouhwCt1GkAaW2IQfPt6sfSEpe0UHIIEkz1jY4Cw1EGsmEXVLVcT67fScbcdpZgrFQd9CsN9vLb0JCoQejyduZuj2tqsOYmY5ljzAAc/6nX+Ff0Ues2eT/kZpDmV+dCequUuVJgxqJ1nv6Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6259.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:41:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:41:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 0/5] cmd: mtd: improvements
Date: Fri, 10 Oct 2025 15:41:10 +0300
Message-ID: <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
References: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007577.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ff8768-388e-460f-d200-08de07fa51fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+MVZjiFBv/mR1qGwdrEDP+D9ARUQGICFkrU5sZDauAsrqrE6WZu5VwxMwZoc?=
 =?us-ascii?Q?JeF6R+1V+IZbQj5QqSI06DTFWlJpX1XMHtbPBG8/soMSIrriCuDq1eJ2gP/X?=
 =?us-ascii?Q?L+g1+fCZ9HQruUBdwtf2d/XP39DCJhBu0gsGJcpzDe+HQ7eoVePiX10FCiH2?=
 =?us-ascii?Q?4/DXF0mYSNOHzUwAATvnAP5BnndvGyte3ucaSEGOg/ePxRpUv8gJU8MXKuwh?=
 =?us-ascii?Q?EFfXoRSh+Y1Nf8vSo9TJfKjo0dsKK85fBNkopjaP9cnwt/o1WxdnztM+L1sg?=
 =?us-ascii?Q?R0GKOk1eqrqY6lQNkC1IifmkMwz60CANPyAODiGqXzhKsATnHJ8GPyLiVdHx?=
 =?us-ascii?Q?nSr2VIt4HDMsMuE5MueRIXdEYvxC4yKQfW64DY0X1unzpZ1ImSTGXZpDcLYH?=
 =?us-ascii?Q?t8z/18cudHxm52fg+/hPvT2k58AbmSzK9Xa2oxMolMSmhtS9hFeDXI9e4M4f?=
 =?us-ascii?Q?4ObejN6spwymu5tsYL3CrCxQtOK7h5fJ0Iez5oqEAz9OrryrD8wP1Wb/X4xp?=
 =?us-ascii?Q?k6vS8RorsPFVmHQ9U4fCmPyWVVaiaNcOc/c+VE7JrbsUsnW1WkyP0Sj0SdQi?=
 =?us-ascii?Q?VWKuw2nD1Y+8tGz6hYNd1OJndWxnHuLuux8uhKavkCrhqBYPD/fPkH4s6L0D?=
 =?us-ascii?Q?PE2N9pFEdqrtsfDmeAZHOUlPsv/FKZx0Qh0Y+6Xp1rS6Utuo2l2GA3CAqHgy?=
 =?us-ascii?Q?ftV1N4tr01M7oNgk/wV5wfZk2pIP/kRiQ7BiBFp+MiDVNnkV4TGsyPUZ24Zb?=
 =?us-ascii?Q?DCLiJKiirOwiw7YczQ3RKSNEr4pbndj29vspNMJldr9rZmtuX8YWceh8khFX?=
 =?us-ascii?Q?nFOgznUGXve5biZypFx3WOAc7gjlaEKjG2oXIRnAmqhl13RanL7FPfIr5Jkc?=
 =?us-ascii?Q?qbDFPhwH5EwTQGs7TGTUUohZ+26mxqdQaOVuJwlJAJ+z5EQ8CWF+kjRD9Ri9?=
 =?us-ascii?Q?6YUDEDZ0ZTrUsSSpjIyrURYWcmNaGyOGYNJlU+KHOjShxw0eTiUNhrD8d/uN?=
 =?us-ascii?Q?y00va04513v5ZzseFIdRbaWn3QVrSa0DTkA9E6c/7u6/SMLnl9QH+07Ywg9i?=
 =?us-ascii?Q?YI8BiB41HAut4Chv8MWmmFcmUDN8cBqjzszzh3BDAezq5YIJwnPl28mnnn8Y?=
 =?us-ascii?Q?zbGbVbH0vG0cS9r7bfMwjguUF0OzJuJgq1aKU4PohkH8MdO8Au7GolkvnoEQ?=
 =?us-ascii?Q?0d3dLKNMWIppYGtzgKLb8vM0lCXyRFtcv7mqSihpExdE+wP1Yz09k2Lzk++p?=
 =?us-ascii?Q?sLzIw9Gq0/SgMU73Y9Afn5+/Tqws+2I2uwmEvSKYjlhARJDeDGAc6XoEPs0m?=
 =?us-ascii?Q?PC7Q4w4pAlI3xQAk13E6wi88vgPznIyDoGaN21C1pUdSZNCClb7TL5+A3xyD?=
 =?us-ascii?Q?JCqk49OU7/VExzoOmu/UhqejoXPfKqgBYlerVmX18tUWCYI9o8/oC0DB/ZdY?=
 =?us-ascii?Q?BYOl4FwGdP9ebx/TslhHV4o34xb3uPNkyy+9o9HTgurhY35SZMoJMvExIlrH?=
 =?us-ascii?Q?0qNjmGietBGKem46xOK5HUrZ1rgDp0cY2QZ74WrQjXqxKhbjHyK8UBXtUg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6dx8Zp8fQKnwbes7lmukR979abSkmK5Ufo3lHZK0SZkTEuCRQez+4JQ13Ae?=
 =?us-ascii?Q?sW5BJ057MCgK6+URKpp0Jq9tt4/cOeOS5JpqanaweT4qFtByzgH1ZoeVrCJ6?=
 =?us-ascii?Q?/a7JVo1fb91tcAyUKk79z/cCFudfX23EeT9WRAz+Q0j/cKJ+m1ty6trd+/0O?=
 =?us-ascii?Q?sjlWiHqhnbydIk5QQSakzIoNMVzOoG9AME/v6jyI0nu9Q4aQo/CkGYr8/JFw?=
 =?us-ascii?Q?OMZKeeAJTttjOt12GozyvF+mqMKizVB1OCg0pOlHjgdRbgFF3+dmWmfC5hKt?=
 =?us-ascii?Q?xj+2yVljllaQXazhkWVRR4gxGatCQwehfuoUXdTXm+gw4FnT9x7TgQb9W2B8?=
 =?us-ascii?Q?CQoP0qUI0q4aB8Ufj76A1xq/8MC1qGuZLPOPTKCaOGQKXgc7kj95AJQ6TVX4?=
 =?us-ascii?Q?OBkzIgyCvc8cY06mgRdKpfcIvI0R0cyzO0O+FtGk+016bOY10ZwI+tVuZgYj?=
 =?us-ascii?Q?V28pRk18dYO3TFe0Ujl1zzdeszEWYbGcnx0Ae+hxDt+HGo10WgQqU8mQKv4i?=
 =?us-ascii?Q?YkdYT8nFlm4kW4I9hCZLfIYD/VaJmDScOoEVqHewMiKCtBe81MgGq83Rb6Xs?=
 =?us-ascii?Q?ZmzRFDg98wOyipRceWH2o/dvpH15eJAFUg7QSJTIxqhw8ysM8ME+dPlIAWLP?=
 =?us-ascii?Q?QuV43e6IjVzXX68wQeVIV6BQz7eVl5tJNCIJ3M+Bk0wDL0NuM9dJcWarrXS+?=
 =?us-ascii?Q?/ylQ/AnlLgdqGTR/6P3Ay5xWOnq75ssnOCaUwW76zY3ORqgGsr5TPMXBblfK?=
 =?us-ascii?Q?M8zhW61yWh4p/DEuH5JNj8F08cLzR20YMZmHQg184LPnwIoSCMQmopS/dQxm?=
 =?us-ascii?Q?BjM2ULkOT7pK+KuRzx9OHrXdiVtAi/lXs0z0LlrpUfH9KtKWug+mnFXLXBiZ?=
 =?us-ascii?Q?gf354U7AT6KGoGid+DqGQhAUDwiLM9ptcRPUcmBFl4PN5Y3cUCU53S0FX8kl?=
 =?us-ascii?Q?1wNj3qSabskSM08giYKLqp9m4VnfstfO/vkcRaoCg9dx8R+3BsfeFEFzJUVm?=
 =?us-ascii?Q?QCRiZUKBKrD0tKnIbbp6U6sSrB5YNRqEelsHjT5+XrJ0rHvEpWD0N9Xamm3i?=
 =?us-ascii?Q?0XiEL30krZH9hB+nOcXSgca6GjGcYMdKiBiyRMTbm6DgzFEFcP7kddl0X3Sm?=
 =?us-ascii?Q?3axjlgts3V1HNugo0KpruppGfSMeUJ5tD3+BrM1HYuxHFhbgKjb+kzgv8b+s?=
 =?us-ascii?Q?X3yJXa2zVBpYHfFnNzdbUrv3y03riFtJlwCgTfyRw2VKjOpfuxQxYM1J7RqE?=
 =?us-ascii?Q?OUrwV4bvTAoh4mtVi3SRX/3IuikNGD5wjrl0yIkAdqTONeJhDPnDVKWJmU8V?=
 =?us-ascii?Q?1cvYYMHt+QBUaVzbhWS0Ye/hUOkp710RLoU2++VuoTJLOMDAnCmZBpSCdykV?=
 =?us-ascii?Q?ozLzCn+Wawb+xH7D2/+izc8XRn6tSZDNR24oI1b4gX8pjOd4lBC2w9dLhW7J?=
 =?us-ascii?Q?Xhl4LqHZwIsDtphmS2f3/fvO3zmCWWJr1lB19gAIOW1Bcy1KBT28hgCsVdYb?=
 =?us-ascii?Q?LGrObiJGnGzHKBbVZmjPETkAVPF4VHhhfo/lcgMGx7Kk9W+bWPriJruOoUzk?=
 =?us-ascii?Q?Emu+oCbKAGngXOV2tZs/L0cjx0fRiVf5eSyvCkJ106VvXjWmIf9pDCqwVY7x?=
 =?us-ascii?Q?Q2dtNW8uVSMur+ZzGu7gXj4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ff8768-388e-460f-d200-08de07fa51fb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:41:23.4583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7T0042b0cMRb2ahbNKZ6NjxXh2l6v92YpT7cWr/4uzVqTzeN0DxUAWx2H3pEQj312SFitmvfhNROAmHjgrWcoipnTLtO8+fcDWzRpFzNDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6259
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series introduce following features:
 * 'mtd markbad' command (clone of 'nand markbad')
 * 'mtd nand_write_test' command (clone of 'nand torture')

Also a new command 'mtd nand_read_test' introduced. It produce readonly
test of flash. It's mostly usefull to:
 * check general flash state,
 * check the correctness of returned number of corrected bits.

Also this patch series fixes speed benchmark.

Changes v2:
 * added detection of the blocks above ECC bitflip threshold
 * minor cleanups of 'nand_read_test'
 * comments of Michael Trimarchi was addressed

Changes v3:
 * speed benchmark fix was added

Changes v4:
 * use lldiv() instead of 64-bit division to find a r/w speed.

Mikhail Kshevetskiy (5):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support
  cmd: mtd: fix speed measurement in the speed benchmark
  cmd: mtd: add benchmark option to the help

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 481 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 508 insertions(+), 11 deletions(-)

-- 
2.51.0

