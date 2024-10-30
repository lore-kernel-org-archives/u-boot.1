Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3857CD6B6DB
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930638924F;
	Wed, 30 Oct 2024 22:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BHAYX2Zo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCDC88F47; Wed, 30 Oct 2024 22:34:05 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47115891E2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STuURN1Arr1hAbREGDjqvTl/GvUhyBQXzA2vZPrOx9b1fovyqhmd5ykdHP0OR54y52GD07NxQoUZZM0zGrvpBtDDPOel0XFKEExBGN6QVFidRRqki6mlqiPHawxx57rz1hqbdAnaq1Ccd/YhYQSVi++0TKZ2yy5s+i3D8PygW8m7tIh107+PB2DTVnfssivavgBaUeaPGrRWTrO1jO1LEtYI5vl0TmbihEUJjmtQEkdfyBPEDrTAZn0o0HjocCC0ef1vxAygKImV5PbvE523uDqGm7K3M99ZzLM0HXlaQqK3cLcn3d5N+bS9dcl7yvGV8pE81VXjsmIovFStuK4e2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5Ox2tA9RAzA3ZMRwhDcfrkRRagAbyCRVdkQczL+O3M=;
 b=qP8J+AammPKTAwcReZUBC3cp7v0aJRlFm4L8CInu/8THBCI6aNr1DMrnhL0ovZlrSoNVQIZbZbWCAgKPYpjOU1h0r+fFYffOwjfsAM+rSQSZu/TIA8ORO00I8dfLt5ESWb3lUs9DEcpcuBrDuYt6ASwg10J5k8DTVuIeiaBSygSlS++Eg7yVxxf1U5eCVY6vePMpHm/kJq1Z/55yMO+Rg1yCzmJsN1eAlB6mzGfPUaSFplkpTHIaSyffMv5VUSwUEJaLA/qW/Z67LxykfOXb42fOIvX4i/ewi+2ZX3P6PgrXF1kcEvDjjeouEC6QpNK+5xAyfkpvH3uvp6Vr8/gr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5Ox2tA9RAzA3ZMRwhDcfrkRRagAbyCRVdkQczL+O3M=;
 b=BHAYX2Zo2vQtOG4VYAriR0xGZztrCnqWJl30R0JfK5PKWbKMK8+eeVnMuHWUpH8FftGU6Urd3h1zhhXnQn4VnJhd8jxzMiy0nMOguQNAr6/VspTlcyeaZuylc159pbPJ56eNoY40FBWpvhhpucFQAFOCjbQwwKJXZygjd7mHw5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 21:34:01 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 21:34:01 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/3] teach 'env default' to optionally keep runtime variables
Date: Wed, 30 Oct 2024 22:34:01 +0100
Message-ID: <20241030213404.2894247-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3201:EE_
X-MS-Office365-Filtering-Correlation-Id: f60644ae-85d0-4a10-f3b4-08dcf92a91fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eYBDKjFwjhIXpgU22BAE0ERoaDLEzzRDA4dByfnBoomhwTWJ7fKDuKi+26lD?=
 =?us-ascii?Q?9ar8qZwrhwlhXlAXFkk3oxM7Vbycqj8GRfoyduPjm3beG+tXEhyNUqELahIo?=
 =?us-ascii?Q?TI5UOMApKq1B+GTZ1UUB7PmItGjy00bAWKr4wAtFmug1Xwwjtb+2m9ow35oL?=
 =?us-ascii?Q?2WIb3Hh0IX0CFd5KGumB9tKYguVNR2J7MaFbrtCnizsgBbTqYnRkTEvCskOV?=
 =?us-ascii?Q?G3iFloLZKA6z2mU0ORBktHGC3lli++LeAtZvh4s/iySBc6osaHob52AFUsOV?=
 =?us-ascii?Q?BT9Ih9CU9CqULljfvqCK6S/5k6BdZ4T6cZKgamB8L+jdnXm683p6hxl46IdK?=
 =?us-ascii?Q?3Ll2uyu+C6jFl0borzXX7bmPUCu7epbufkPk18B+uk4GHb4uRm21ChBQUbR5?=
 =?us-ascii?Q?Xqr/8Y1GIydxsRyQcazGxyZLrPhFs6eL2mlx9c9rXLnGJihWbi3ncLEKi60D?=
 =?us-ascii?Q?GNTVSVxgi2sKO+wNJXdj6xBovHuj+XbtBfKmdPneUfIrcHiTS8yqXQeSHr9o?=
 =?us-ascii?Q?VXwspUPIZe/hhRdZ7KXIuITXo7Zh/FrAd1H9evNhNHNvfrFZNNncVoqgB5hx?=
 =?us-ascii?Q?TC0YSHjPhmAYM4lnNJyWGs5iU5mUN94e0eXEt2FE137/VeVl/J1t5Qar6yk8?=
 =?us-ascii?Q?YpWq7ohCZwnvfo9AuF63QtoBDHD5Oho0exlL7bGmYQoGRdJ8mDH7HvU4szno?=
 =?us-ascii?Q?pYieW8pDfnoFXg6NdGXHRb9jZAgFfRsFGvDHJP0OAWwttsZNavruXVojXoLC?=
 =?us-ascii?Q?RsF/3IAQqwXFNC8PKKJAdshfMcTQ8wpac3t+VFIlzE1ryxJKeNdf7RINmgOS?=
 =?us-ascii?Q?8tOFFoslSr58eTuH413A/Z1ZuRD63xEIB74KXA/GkZ9aoav4Y//ulqqyrMp4?=
 =?us-ascii?Q?UKmEuEuBNzW/VKrS8p5rkFHKGOOUI0j/iM3VUVI1uy/1ll5ThN6ZSqK0aH0v?=
 =?us-ascii?Q?/wIv/nvhm+QylMPxZKEh/YcDc41205co5eALjSBano/EpTRBEsME59YoiKc7?=
 =?us-ascii?Q?kaq1/0GkNVvWEwgnvHYudp93+oEsfwvRVJuvl1UaFVKb8c9yXMkERXh4bomr?=
 =?us-ascii?Q?w/8S1F9load0rtBuuu90E21xlt96XhL1QNCXaP6EFOcK+qyv4Cn61tXI1aDN?=
 =?us-ascii?Q?Ao3gJk4mHunk5xZaV5/yUASLIUQW2dx3qePSiabn8pl31KuWAd8REj1YCw0u?=
 =?us-ascii?Q?/oxwItDSc2/UVFt3kguoeo+KJfOTh7x9eiz9xO8/NF8+w2XQszNxpyJdF6IN?=
 =?us-ascii?Q?uNiZQ7cmKoe9rmsafMVFt2NXMfFdvJhsDyeG8UXa1laOu+Y1bIUXTERCq57e?=
 =?us-ascii?Q?aRWPm3PMXfMP/NJ9V/tZ4XsXHg8R6ttl/yLxBaI71tVwFXS2VVfxmaLJhCg4?=
 =?us-ascii?Q?yt/a2qs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fik+DVst3YHlaRV8LXkuI2zipz5AEaL8I9ONR8jAvulhQ4v7QkPgBqHjk+i4?=
 =?us-ascii?Q?x6fhy1IpTCOGhXjfXItFRmV9QH0WzrkZ9pQ2UmNV1UCrWTlM4RutpY/7NKEe?=
 =?us-ascii?Q?8XwpRWIvraamCX0Rt0zV1QL+XObOP5YzVFqb/aOSw9lp9cPnSywx+G8uCTrH?=
 =?us-ascii?Q?i2Il0MXdnPqSydB42SpRYj//VDph6jVudWLkbso+A4frgcWot4FwmJANto5H?=
 =?us-ascii?Q?7BeZNmLKCcZcCSU/wEd4GpGlXucYFnDXL74ubXbycqk1bL1FZAML/QGw4R3H?=
 =?us-ascii?Q?kL0WBNCCpwDhOvx6H0bi4expZPVrJzF52Ow3v0/o/2Dg5c8ZnWMKeLy43gI+?=
 =?us-ascii?Q?74FTiPKGg8+e8T0GYjnXXinwUs+MMG/96gVrRI5MhgR1A2A8+haar4kwZ9Uz?=
 =?us-ascii?Q?QwBmxJsWN9IeH7UPxPiv63Ye2rbx4bkRxFMzsnNmPIKRfJjDQ8i6lyBpdMWY?=
 =?us-ascii?Q?HXODqG3I2ZIWr6jiP9RnO33yI4pm9Sd9vdKosmE2qf2Es/jck4cGaB45+WUV?=
 =?us-ascii?Q?NXQLH3hsqxcAdTDb3W+2arGQKwRiqpWzR3sZXRsfkqFPliERUE2cAQ7IWZxm?=
 =?us-ascii?Q?/C49etsrj76j5vxUdZFttFm65rtlbzO2zqibqYAilH4RkujmbG8Pups1l6bX?=
 =?us-ascii?Q?lsWUPPrVHIxvNL9aDfcCUY94iw5kUsl5cUlBoC0QDrsK/OVwDLdqD/P9y5lq?=
 =?us-ascii?Q?8sdwdowIuDs31EXbzNTPhSwYBPqRPJy3tn+yJF+XcKZjXvPnDq+h2jnw6ukL?=
 =?us-ascii?Q?oVxrkHQAexlVIrHPdGm3FGIZqWNrPp9vkzYQy2kKCKcABYNchB9qr77liPcZ?=
 =?us-ascii?Q?efkk3jueI0hNz2YpY5haca1+DffHh6csvqULpjGE3ubJSa0M2rZtXkTSfPjJ?=
 =?us-ascii?Q?TINryRU2gOnfCF+sedWVIa3p23BJE8UPHCbhbZzBbeINsdBlodR38hT7wcpc?=
 =?us-ascii?Q?/gep95RvTqaSLddsH5ckFxQNSJ+d4emG+F3rK9aUz+m/X9fI0gZYFvJVJwus?=
 =?us-ascii?Q?DTSaxi29zAuRUxgCUJ/hKwYsAAykIINQUKyCHj/S12dTkSuJzbEwBRpbI63o?=
 =?us-ascii?Q?wx+k9LZE+PZByWTPIUUUx6z8teW7/Ef/ob0ofLawbSYUW89G/YS+qfkpozgb?=
 =?us-ascii?Q?nNBFAeYolChe4NVzo6EPT5xU5LExlZpOt0/gLEBi5KzxYm/elsJ6K7qwEsq6?=
 =?us-ascii?Q?uzhymkg8c9vgHdIorQYe9Qzy2y+6ekWDSzu93rjXCqGFwxvSxLltlYJQP5Kn?=
 =?us-ascii?Q?rEIK8AUUjUCYvG14CQsqPs8ZxfBI8thLsOohZYkx9FNgM98eh2fLwJVxJrDa?=
 =?us-ascii?Q?K2iLC01q36hCciXRu2tAaEWKUjaX8x0tt5T2D8UVA0bvD3HJoRREnlARVnAy?=
 =?us-ascii?Q?fMDGG9V3w534w+M9bFxkQrkaUJHA4YdkUEpWldSccNGDTTQKK3Gmw8XlZjnK?=
 =?us-ascii?Q?6FzkInLsEsx6/+aN8erpr9jjKiENi4iN5jUJ8A/1NMSR14Xvr7OvKRc8CPNw?=
 =?us-ascii?Q?6H6FW++UdRbbroLWYdPPaqQAON2TL7cIruQycaidVM0XZaEc2TSbBbpxGU45?=
 =?us-ascii?Q?KUMEnzKigy/IPC6cB0C94kAyX97/tiQKP6OjUDfLGeEus1lSijva01iWIDRz?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f60644ae-85d0-4a10-f3b4-08dcf92a91fd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:34:01.4116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIHoWgJfMGTacD/H2S9SpyB+/YjJ/lPaJ1MCOSCywOP/LPMKUXX9pGWwNWQcsvwqjWIdfosxiBw4E+LMDaJ3h6vsoJii68RAtbPjrT5yMTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3201
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

Doing bringup of a board, part of my bootstrap logic is in U-Boot. So
when tweaking that logic, I was bitten by a previous completed
bootstrap having left a copy of the environment on the device, which
was imported and thus overrided the new logic.

So I thought, "ok, I'll just make sure to put 'env default -a' as the
first part of the bootstrap logic so I'm not bitten again". Alas, my
logic also relies on certain variables that are set by C code
(e.g. for detecting board variant), and doing 'env default -a' also
eliminates those.

Looking around, the hashtab code already supports a flag that does
exactly what I need, and exposing that is (morally) a one-liner.

Rasmus Villemoes (3):
  cmd/nvedit.c: teach 'env default' to optionally keep runtime variables
  test: env: check that non-mentioned variables to "env default" are
    preserved
  test: env: add some test cases for new "env default -k" flag

 cmd/nvedit.c          |  8 ++++++--
 test/env/cmd_ut_env.c | 45 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.47.0

