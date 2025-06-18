Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6500DC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 12:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF3DA82CC9;
	Wed, 18 Jun 2025 14:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OUDEv+aQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40A382CCE; Wed, 18 Jun 2025 14:07:18 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDCDE82C84
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 14:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRxvrgZfJnaNZEwDH3ltX8H9IzDdOqtHQEenk1IpjOP/KIEqCDHkJuv+jcdMJ4OFziFcIxV2H+fxEENQ8oBNf5YIXXBGpdTFvOCv0LE2qzvl5Df9XYRnQuG/lyeMJK5J1zp9ADLiZBwX7PosJEGTxk6AhIHdvEPOSIMTdDgOf3FZ+YnvaAIpc8Dv9c7F5avsxmqaWU8VAw5k11QnztZz1D10W100XtGtFmviPi4jG7moM+PWZdH1VeuaYd2vXmddCGLQri3ZDSTl/f2BJQAINJTSnIAkbizmUjFJx2RcBPO56hkd033M3LIV/JHZdwep0Cvrd+hQju1JUXuQo2Jw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A31r2rNn3t7i3ukDShw0oq/wx4wVPLaszMraU1B0ojY=;
 b=GKUWDeVRt1w1EJFQOTTdqLaZs5xw2KSLUqxYkbEfGstXoBueG+Quqf1yzMy3fAu+9FGcPUbdZGvtecDAMTXN6k3I3e8d2CQU352DIyPwbAzqQetvtHobJVtLKi4rAS6zTbN/F7dDEI5jiFxaNUvhS4LdF8ZXEpCOgvzzbrR/H9PDPs9q8u8a+WtW/A7UvIOc45qn/6TQzYXMXNW22PtiKJwhWDlXQaY4p6O7AQhFzaiVm1D49Pw5YJ42KMedrnRVNA0G9v5diZ4lERulcuLmMufSt0dEplRNgwmKJ1YWFSo10BMCnGPBnWmIwXvIQxwk3IriZmTxJ2D9h6xPC/bC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A31r2rNn3t7i3ukDShw0oq/wx4wVPLaszMraU1B0ojY=;
 b=OUDEv+aQ1YOdHpk8Ok6Zn+Boo0VMySCuVayT4GzTe8DDZ1XtrfmeQx5ytnDNXaHWSvuZv0/gscQfpEilUKf+TWvjj/VKxNk46920pIZW3H+337wXlmt4yW16Xstl1RVXezj1dqT2LKAt+5WfU0pdhKN6dHsowV8tr3c+KDYpUFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 12:07:13 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 12:07:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: failsafe update of bootloader on am335x
Date: Wed, 18 Jun 2025 14:07:11 +0200
Message-ID: <87a565z21c.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dc058d-05eb-466a-478f-08ddae60a8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OECAk+IWpQf4JSq1xXiY9QIi6lOKif2HY4YW6NLAVd5zFFJoyZwSwqd977og?=
 =?us-ascii?Q?4xQLzGLpBZAJKNoAMosDRJCR87X9QcJQbSAU2z7kHNwG9dT6takUn8nj35NS?=
 =?us-ascii?Q?nFRqE7Ljv3ug7Lq7v7fSjkHdOrDngK7zLdyCJ88nkpVpCf1GtxtWFnw+q4/8?=
 =?us-ascii?Q?R7fuQDcIQvH2bA5VNZtZ7A687sjLUgPvIc0xrrrYLeSJWr2wAgUwjedcCCEF?=
 =?us-ascii?Q?hms2Xnn/COC80rENNVcIz6qVNm5iMF6QhquIdBPLCLiWyZi9Diag7AW23/EG?=
 =?us-ascii?Q?Sw37/n3cTHJ6PkhGYT1vv1P6dhQs+CRiov5QWT02BdqH2OdaH3n99SOHepnX?=
 =?us-ascii?Q?/AJTzqeumoLYJwKg90+3rYcuFXqDWpYLcUzAJ7OqJpOnCHxj+bc/qFzVlm/A?=
 =?us-ascii?Q?AoC+1MVn6JGirtgOMmsUE/ov/Q9arKVi6Ae5veypu1erT4czIJq56/AC7+B+?=
 =?us-ascii?Q?g5uDznR1+Qfnp7CqW0mlhppiwPun4ZLsOQPsPFdPQ24nApDNCnaC9HU+6mr9?=
 =?us-ascii?Q?M81BqvfZbAml6zQZlOElj8gTGb16GS2bed3XmGFcvoc6WLkUuXHkvQQJs+8g?=
 =?us-ascii?Q?6uwRnt/hAtSDOMgnYbAKXZ17Lr4hDQQZVD19smRzTt7dr6b54qG7wEl7uVQK?=
 =?us-ascii?Q?C8MFf9//4ewRVlLKyDF6rwfdjIb2o2iRBSbNF8Ndvrp8mliIodI8gFAGRSP6?=
 =?us-ascii?Q?SNjVoOMqaFiySiCcxnMJpxGrHPTW4VE2suJu/wVKSjBarzq3S00HDQg/1l8m?=
 =?us-ascii?Q?7BGT0X2gI6Mg1VHpwZQ/OQNR8/31XongnDDdzCgKS5nfJk0uUoHuw3P0xsaO?=
 =?us-ascii?Q?WQW+sQcunp8XSV5/CUr4aw5fbccV0QGIg8KWw1YaAbjdIOfmvduE/ZO5gTYD?=
 =?us-ascii?Q?76ehR9Tmz/Z+mWBTeboi58gJQerKsyXXmZVYlM/PNoV7ZHKfp2Z5ci/fHuSh?=
 =?us-ascii?Q?u9iZJEXz0LzRvfQ7YzeTxWlJmxpqDRzZwz/EJvdAOu1ru2yT8Z+YTN8oUIfR?=
 =?us-ascii?Q?pCzYljs/RbHlO6crDF+H9oBE2XmaEfMzJSkNUYM3ETuk80M5sxNNbK0K/2wu?=
 =?us-ascii?Q?oaSDkIITuX293/gQJXpMc3IO+5C5yxispFf/KV5uS/GproHWAzMZndA6jr9Y?=
 =?us-ascii?Q?L9Cq+lXjAb+isR6uWof9y7R1pR9sEoARWWqWPsZ5Lx0RlEkC0948qsy9TcEc?=
 =?us-ascii?Q?v8BDyLwEAoxHd8UqYU9DA0Fi/z2pbE7B/ekIdfq9R6g+jHLEgN7SliDaKyGy?=
 =?us-ascii?Q?Plxq/q7ymgZQKCGc4fM5u4bISlrCNLQd2ZWDdaJZVXwLzUDFkgMigZI5imNV?=
 =?us-ascii?Q?uHzNiTGtGs4a16d2AmMf3YAMd0j7KYT/UTY3BDR0trW6jpv5/ZnpKHfs9kAe?=
 =?us-ascii?Q?mS+0mkhFy8ycrOHkbP6ELsagnkgGfZh6+VCeEeg1GtaNNA9Rg/WFfPyrYCdn?=
 =?us-ascii?Q?1pYTlYFKBdc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxU6RDnhGC/fC1odM3UgELvhN18b3u36t9KvOS881K8XbxvU5QorKNNQcR8R?=
 =?us-ascii?Q?6f2AGbKwlhP/IW/azJXTan/vlLdVl/oJpyEenhnj5emA4JxMo87jaGgE8WyQ?=
 =?us-ascii?Q?wSz/PvsN5VW4+uVcMjxSW2ekEjfPCyE8RoJf5hIqyUEcvyOlMkxO04T+yLoh?=
 =?us-ascii?Q?qLFb44Ree/AdIrvQLiLffgH1EBd4yI+Z8yX4mZBmNMEi2HXwH7iXCJ0O3SKL?=
 =?us-ascii?Q?w83SOX1HR8CiP498+qHo5MhD3h2Shy4vn48eVnRZkVDNqUxhHVFp0p8l33ix?=
 =?us-ascii?Q?b8Rl7RYsAU2eUE5Z46FEBK6t8IAD6kKGcNAXLHyzqnHhX3T0nGJQuC/kvs86?=
 =?us-ascii?Q?rgmDsDpmO2V3W9Zp7kqlqr4ibL3ypeEASJmICM+piREXehzPPXnhUA2fU3jr?=
 =?us-ascii?Q?QA7MajrbpDtNlUJQBAsbhMqIYoxXFfx2in8abICAf8JU8sVLTx/KBBuZ1IZ2?=
 =?us-ascii?Q?1rAEnoL8P/O0qng1ihAJ0IxvnlGfcQp+AplMOHuVuwZuy5PMLa57LT8yg2rM?=
 =?us-ascii?Q?qFuOinRGXdmfcpZ71vaeUUEErpk4ItmeEqyrTKt0ebBKv2AroHU3tABdPnZJ?=
 =?us-ascii?Q?rs1jkw5032ORUrguzzpEW6kgs3TZQw0NUVB6LtZ4yw9aL9S1f+dSSqbqtvaH?=
 =?us-ascii?Q?3rz4UzyWXoDW2oooC9NHGrmt4lWoapG0bIuuWDML8kw4QglX9k4wiQfSAvdz?=
 =?us-ascii?Q?5IttiG3SegRwwTgcCJHIBCTVMGtxLeyjssM2Dt49EC/rNQpim3wkiYFDHpZm?=
 =?us-ascii?Q?LLCwuIILY7FnDOH508VuQppPKZjq8bz2d+7DvYZumB7kjqtmG459LpxPgiSx?=
 =?us-ascii?Q?hf8PBkJItpZaatOdWQk+JZKYQU1FL99NFstV+5joxdos/DTrn2j5AY/BrGhJ?=
 =?us-ascii?Q?rrHQlTLTlDlYG8DQAIzCYbdvWG2bY7tJzI+DAw3z0mFRsynh8Grss1tCAY2L?=
 =?us-ascii?Q?OtJ0yOHBfBl8s02wM+QwcY8GY9tWGLa6U8lX2+JzOGZI3JvvoqR7f61GfD2/?=
 =?us-ascii?Q?GDtYkTQP93bZG+v+Zos++foDvRSY1LPqq82l6FeuCyUHnttWNBOGP2xs0eAj?=
 =?us-ascii?Q?pCktp3npXiusAGIKAXuAi9SlUyfJoDql/hMpn4ZKP6RmA4i0SBs0mOn7yZVO?=
 =?us-ascii?Q?fg47lkkk7dEDQNwlOs+3epOsV6IJRXq4abRCTO9D/fN+C+4b3AC7FKgHIeZG?=
 =?us-ascii?Q?bMyArxS3kepxzNVVXMem8ijxZ057A64LYgE8wNTs1cRFQpQZBDGomLsRYfT/?=
 =?us-ascii?Q?wLR/O+ANfHmXJ2OiZuEyNtWClWkb7ciec0WE8UY2G4o/ris5UnoAotjw53Oc?=
 =?us-ascii?Q?iLakP64I1Vnty593XbFLvvLMIqmp/cjoysShvYUx6X44dZwpI+l4CcrM4pB+?=
 =?us-ascii?Q?tJgtsTpIo6+Bg9uAz6pqyoxW5fO0VAg2clRghvpIsGql5NHXJ0fEbA+KUluB?=
 =?us-ascii?Q?mvoPKF62v9mpWe9zTVqOM9ot9AdKlBdMjh/+z6fY/3o5OAxlu25UvpfC7+mf?=
 =?us-ascii?Q?A9P+03Pw6H0NRgNd3oKIqYiV27OhzT8AFmR12304VjWRQs2oWMMPQ+21uAvE?=
 =?us-ascii?Q?J2REJrvTRBkVOJHggX+kMj14HSv2tjubfk+thbptO3tPosF9esxVIriWQ6pC?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dc058d-05eb-466a-478f-08ddae60a8c9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 12:07:13.0015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+sIxYhlBEbbtt3QsC+v/sPA1SgH52hpN7gFFgAjoOhKR6HY1w+lwDZVXhWLHKH6HjUzv8KsGUle27LHbQcLdOz/aYljoyJrt7eOJZrUmFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7500
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

Hi,

I'm looking at the am335x cpu, and have a few questions that I hope the
community can answer:

(1) It seems that the ROM code does not support booting from eMMC boot
partitions; I can't find anything about it in the reference manual, and
this ancient thread suggests that it indeed not supported:

  https://u-boot.denx.narkive.com/S8U7Z3Wr/dra7xx-booting-from-emmc-raw-boot-partition

(2) The cpu does support looking at a sequence of offsets (0, 128K,
256K, 384K) for a proper header/image, and will read MLO from the first
such offset. So it is possible to do a safe update of MLO.

However, it seems that MLO will always load U-Boot proper from some
fixed offset (or partition), independent of which offset MLO was loaded
from. So in order to implement an update mechanism for the whole
bootloader which is safe against power failures, one would need to teach
the SPL phase to pick an offset depending on the offset SPL itself was
loaded from. But that in turn requires that the ROM code exposes that
information. 

Does it?

Poking around the reference manual, it seems there are some "tracing
vectors" (0x4030ce40 ..), of which word 2, bits 12-15 are "memory boot
trial 0-3". So perhaps those bits can be used to figure out which offset
the ROM code eventually ended up using? But is there some more
direct/documented approach?

[Alternatively, one would have to build two distinct copies
of U-Boot merely differing in their value of
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, but that's not a very
attractive option].


Rasmus
