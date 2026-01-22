Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB09ED3EE64
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53E28397D;
	Thu, 22 Jan 2026 14:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="O8HV6Eyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2F7839DF; Thu, 22 Jan 2026 14:15:39 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B4FB80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez3C9nEIPGEWXn05XYPfJls/bdDQERNgHqdAhLJrnRPJhLNCXJLgWTjENfvEUiK3KQBXQFMUVIgU/SgiF4sQBc3DHuoEZNhOhw6vVbKq5Igp4kdYyoWkQaHW5TgsZHQVp/6GriqYAxlZ0ZPjfE/hzk/YPpvrWw0KsJCNN/Qztrzm4tdtmLqhAQ9PlRb0JSg4q2hpDq6BcdPg16hBC9sDgE+YvSeTk6g0o+4KWtiiy18bqDr4BGaceWWwjVy42zLyNNd0uj8TLMHDqJAHYbnJlbfROl80gFtRvNE5OjzDVGy8htCi4uTj+Xkp4Fd6+zI62n5rWkiANcVjM0c4DKQ+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx3GvPrtEc84oKQFqZgw+1SQMoPJkUHR0Y/wpzWk6o0=;
 b=rh3Kh/4nRceYu6UUaTc18E5RtJBZggdqVt26TVOIGqbwAE9Az/hcCwgaFxH/3VUx+y2TsGrH6uCso3vde13XyP2k0BR560LDkjlHdGrWOz/5kwKmlyOmtTc5R1UsmlvTQrbVsUMshyx6IJO2jOCWO4R7FRJjFbIEio/HC9f+q+7Sm8rh5lXTT2kksFDAumF2DrxZdVhf5z1xAxQIQRbVg8neDALmFI/JsM+ZL/DelsQOwZJ6G60Wo0/yh+fxEv1iXZ3CwcFEFfPjtgkQRhhhf4xm3mb/9sVc6VxBbVCIYpeVhfK2d7C+rOLr7yR/M2Eh0zrqQOSlczD2dc/bPvHWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx3GvPrtEc84oKQFqZgw+1SQMoPJkUHR0Y/wpzWk6o0=;
 b=O8HV6EyryRbaREUwz5RiDTPN4hXVgxaAetbJsEb02sBwqVi3i2G9gOyYKgexShOafmqn4wPXbONxSTadGnFcqEYRokpOi+WqSdQW8km3V5r+MmiBGXWXqE4mec7i2T1hOTonidAwPITQiLujHv3Bkghdsjc/uD43xUm8gGjZ9/fR/tF9nqWQua7JPUeN3zpI3vSY37P3QCo6DTWEHNN8cW/zDBBRT9YhaMO/kWVPEgZg3MIXF2zzrFhj/OPPCS1o4dcc3eHfJaIE0lThxlV8XhLC+nrJidRdl4ytcqKVYsZDIwgx2ZAmj1NKZtFvuG1Hpc+yk6qT+RGpa1PNbtApCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by VI0PR06MB10594.eurprd06.prod.outlook.com (2603:10a6:800:310::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 13:15:31 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 13:15:30 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, vesa.jaaskelainen@vaisala.com,
 Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH v2] mach-imx: ele_ahab: Mitigate imx93_qsb build error
Date: Thu, 22 Jan 2026 15:15:52 +0200
Message-ID: <20260122131552.30702-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::34) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|VI0PR06MB10594:EE_
X-MS-Office365-Filtering-Correlation-Id: 60704eb6-cf17-4d8d-c5d7-08de59b850f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pEd04+amQNvbL6U3ALdSllfZ9s38sSDts3GAwdNBhH/EkLuQK5C6A159PdC+?=
 =?us-ascii?Q?3UEye66aEkOg86118HA7hvQI+P4ZlZYnb2Gxu9omC0vDvB5EEAj1rb6U27dk?=
 =?us-ascii?Q?dcPExUwdYThOtloEtXoCuvS9schWFIFrWq/W1Ww+zT7UogCRDGnIEGWeY4Lu?=
 =?us-ascii?Q?WdjJx5egLSYHZqSu2qwCQKowvpkFcKWUackCwu5lZzW6NTG4L4XFxpljsQrR?=
 =?us-ascii?Q?rIF2TO7+DuMZlGnoppk5tkLx2Fi40D9ige0aHQxO8s8glvtX2Rkv1fSkJupx?=
 =?us-ascii?Q?Z17+zskC6iJ1QajFeZSmyh+s/gY6q6OTpWQf0AhG1I7EFewNHsbj/bQxewRy?=
 =?us-ascii?Q?9yiSJTKT8lq7xq4wBW0Gd6y80fAz4tGWq9zFvVtpzrt5Qq5rGwT6cFOOi/yF?=
 =?us-ascii?Q?B65Xfwe8OAxSf974oD3kV0jI0z2In1gnByecBeLMv4pRRQP+cU4i+de9gh4T?=
 =?us-ascii?Q?k2w01YvvD84UKmtCzImDXLUDTjg3wVny/vmwEoBCH8oQd4bxneEIzKy6Ka+b?=
 =?us-ascii?Q?uoDp4eAW8JbXATo/2HnFlZxf0cVaJKM/fkFvXRh+jo1EoJlQM6bTsDE0D4n1?=
 =?us-ascii?Q?kUVZFXFEVM5yt8/9omJRHfHoB9aaI4fyvnyiFAKfZfWOKcFZ1bPyAaQqpXAH?=
 =?us-ascii?Q?HG6mlgPJizkloJlRlUjjfHYY7JQC3EEnZms0GymDnv3erCtgBbybF9WR6jht?=
 =?us-ascii?Q?TOx49b5iO9wdl55oLSeLkxZdUeJxHHyMBUaz7kQQIlUOPVzv790FDOnM9sMW?=
 =?us-ascii?Q?RdCTzISBbVqTtaGVZq3XgQqpBJj3MYFq8RTIO+jn7z06KDRhnY6/sx4VKOTD?=
 =?us-ascii?Q?1nlsydB0mwTxeXmHzCP9rNhMyoW6tMS45WiUGbZcUNB5T35ns7eqU/q7U7N/?=
 =?us-ascii?Q?na5SNERlOmgBskJmUMCN5LcoqtwOEBvVvsh+o/fh5qPQbo48qvaxmk53ZOkd?=
 =?us-ascii?Q?0U7IYhIZBkgcs/U7s/rblDvdMo/4lFE0QoxrHLWoEXzJ86rjPNoClIyrVzFB?=
 =?us-ascii?Q?QoCWaWB4vfLsrla1HWS8tadce+pHxZ1gBQVE6v7c9wuB+SDpsne5glVprUnz?=
 =?us-ascii?Q?uJ6gKkAx8nlXv6zhh9NJT+YUGi9/5X6xEa9LJZN08Wy00HY4d5CDqwv+8WR8?=
 =?us-ascii?Q?7WA1fcrTol3mC3nEGi2wzMwqyR+fhAFGe1tSBbtSBvN9vTvttlQL5E2VVRCn?=
 =?us-ascii?Q?MKEQoceM3pP/qMTUFs3ORGrRzyX8ufL9Kmae8U7m6uAjFylfIIheEbnBmgBK?=
 =?us-ascii?Q?vsj6H1qVEN/blOJzR7q8rbkr3roCmqx8SxPFaZ7ZffznRVhBxcyAno1En2v3?=
 =?us-ascii?Q?QfoqvQrfaqsaD1cA4J6WJhwdmtSx9NSw2ywvtI/6l859M/Qp7ny2B5Z//pyw?=
 =?us-ascii?Q?HQ33GEkxLVC0IamLulZpQRCY6mPUT7p5DTzbIwE0PWgDdc0zanyJAaOGww6F?=
 =?us-ascii?Q?eB05bYsxaLazr1aDXXnU3XP21L09SChFKEGRed41z4CVyBIt6/TuTpNA0ofa?=
 =?us-ascii?Q?n/3kbLubzl7HZ6NYFmqyYJ6/qoSipyYvyUSX/9dSK9KIXUKaW/GZSdvrh9fS?=
 =?us-ascii?Q?fYAKL8zLtcdt976iGqcHJb0bez0en8JOhmpHv4g0GfcvMcR2Tz21w0V40ksa?=
 =?us-ascii?Q?hIbLp0UruFqUt6RrbCdQOsw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLavlIzAyRf+8o3g+X49ch6DxgzlqYWu1QrTkzqWCnzecJvL6B/lv5NMwwyI?=
 =?us-ascii?Q?hSYuwkhT10ShWPJosB1D6bm6vHzqviCNhEEDjCMWJxX2CFfj08HynmAuOLxs?=
 =?us-ascii?Q?QGktnis6oTjdOifMMhXjuSkdEHx8jLT+Obkur6x7pHChFvNk5FYiPc+9XqNu?=
 =?us-ascii?Q?lwihYxGkjnGsDytW9G1s6qDvfALlJGl1uBvcXvtyyR8jUr6w2icMyoW2rURZ?=
 =?us-ascii?Q?kNtnl0jYc/LceBBdteSHKTAK3UXk+E124Sv36ZOjUZuNbXDm6CmXZUanJqqr?=
 =?us-ascii?Q?Yg+eAWioRuflQuYVUWUudcxf31+NTDE/2WGckKzq3DUO2sVh6IOuZUyyBK8e?=
 =?us-ascii?Q?R03blZ+TIXYypHcRwzM/KpCpGPmSp8m/R6uz4CO+dtkgWEE340nc4PME6CVb?=
 =?us-ascii?Q?oatP0fM112smWa7e8Uj3u6+THPzCP4gHmgLF5b4LcxJoF70WFtaYq9hf3E/J?=
 =?us-ascii?Q?weQIxWUl7657/Am40wK19FfGaSOaM8Y/mItU1tUEwCOjjAf5Yzuy/7ryOfLL?=
 =?us-ascii?Q?uC1CDKE4vAL2vHtHefcg8fo9niku5X853YC49cbosCzA+LxN89hgteCt8wtV?=
 =?us-ascii?Q?hnfDorxHlYgG9Sfb7oGuRHxh0JQkqeTiS7y488jvhPMM+5YzMDL1HjIKfn2G?=
 =?us-ascii?Q?qxLLdQMprcpQlzmjDPc3+7C0Y8oymURuSkD26tubYMA+kKTprfSOhFQbeV3o?=
 =?us-ascii?Q?GPGEnAIHmoRFKF6c+uN3iazJfzP+Y43r/mUq2oxkVpQSBQ23hr8YY72FnSkh?=
 =?us-ascii?Q?mdg2gxM4swczos06RNYXHOhvIcVY8C88ASlqUsdyPT1qatwfusNMFa7Me8hf?=
 =?us-ascii?Q?dH62d1fiFXtyvy4ZzzF9GEZaBVtlPGyTSpuXQvGTI7av1cM2T2WAnVXd7KZ5?=
 =?us-ascii?Q?KsPMAG0BJAP+W+VH2OnGTuruyiLYjswhCzzNB5LHvQ2Pzl85pe2jHbMhFAhf?=
 =?us-ascii?Q?XhvlACicfVh7uPD7TQkohsCSn1VGD2U7i0efOfA01q+Kj1xR8mKehJVOKXTX?=
 =?us-ascii?Q?OzN9HQHn1sMilSRnLnmOg266OdNe0879zkFh1ovaXDFsnKWFDlyC7l0Ac5Xy?=
 =?us-ascii?Q?a31dgsnVqkITPdwB4yziYlVrZPPjgMd7nSQl1A8FgNzevAc1NtLGH+10ktuf?=
 =?us-ascii?Q?fh8v0Jm9cYzEnMEMAzKC63i2LPNW148QoHHN9cKp8GB526mInUcfCVIs2o9h?=
 =?us-ascii?Q?bafGaZ4fjw9NvRS74fHKfGAN1lTgar7uNxpt/c8Vmpb0VXKVaRw2N/nIjfbB?=
 =?us-ascii?Q?T+fM51G4XBlfuwQPc47Z05un2IxJAy41JwdCGlN3Gn32ImaKEntWA77Pc35+?=
 =?us-ascii?Q?BioRCJ7xyMbnQ1DumI2BKoyMiSgVAxkH4G+ozvdfEUfsfFJaAJCMYJe3s4KU?=
 =?us-ascii?Q?6DodUyoisfEKwcq9zhGcHSB9i7xHpnM3r9Is8z3N+wjHdxnK7/c74mgFv2uQ?=
 =?us-ascii?Q?2CCXTDM4XHTumE5IKaeBdWyDhsf21eGPFjGD4A0xv/L3IPepjkkP//FwWG0I?=
 =?us-ascii?Q?Q5lq90KJQA9vOs0qPzcPnOfqBEXwQxB7f3C+hgjqJPjFDp65qnQIJtdWzwUq?=
 =?us-ascii?Q?Rhg2yMsntyy3qvYxGMx6WBoukt8uHRKYOSFGYxqUoWTrvQPH8IgrIcnmVgaA?=
 =?us-ascii?Q?dA6Itu7+yEbxhkKaS4FzI1GlrphjvopQux8NdE9LpmVYQwVA7iPynTaPAhcm?=
 =?us-ascii?Q?oX2/qGFpz/fdxgMjAIVBQqpSExf0S11IcxaKzlmVM+74Ql7H9JqvmYxKCKhG?=
 =?us-ascii?Q?NGMMtsLkB9Pf32Lk1GJNA3FkmFDXpPA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60704eb6-cf17-4d8d-c5d7-08de59b850f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:15:30.2372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoZ2tNhRgqlmhITV6hPLiQ8eucSemogumD1/ow1h3UCFe6TW7jRtYCXjVXPKT3mZz5QqBzBwdJgXlkJtt0Io5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB10594
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

From: Niko Mauno <niko.mauno@vaisala.com>

Add include to avoid following build error with imx93_qsb, when
AHAB_BOOT is enabled:

  .../arch/arm/mach-imx/ele_ahab.c:262:24: error: 'IMG_CONTAINER_BASE' undeclared (first use in this function); did you mean 'IMG_CONTAINER_END_BASE'?
  .../arch/arm/mach-imx/ele_ahab.c:477:20: error: 'FSB_BASE_ADDR' undeclared (first use in this function); did you mean 'WDOG_BASE_ADDR'?
  .../arch/arm/mach-imx/ele_ahab.c:543:20: error: 'FSB_BASE_ADDR' undeclared (first use in this function); did you mean 'WDOG_BASE_ADDR'?

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 arch/arm/mach-imx/ele_ahab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 38e671e3935..4d4620dcafd 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -10,6 +10,7 @@
 #include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/sys_proto.h>
 #include <asm/arch-imx/cpu.h>
+#include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
 #include <console.h>
 #include <cpu_func.h>
-- 
2.47.3

