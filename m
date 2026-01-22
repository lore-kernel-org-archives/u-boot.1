Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE082C44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 02:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1EA8313B;
	Thu, 22 Jan 2026 03:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SKqRWMca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 219BE8341A; Thu, 22 Jan 2026 03:14:03 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979EB80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 03:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsvpqbNGXpVmHePGUvs98CdInjWQQnn8IsBWzTMfwwV/PC/h3lFvgnKvgpaI0bZmV1ySie/JkCrakKLlG0BP0E8uSMPak5TZUsq0+eHDkY38ti+HWOE5SytlZiZi8OLinlSU9cQrEp1Ypu1pOtpoYkTwpKXZxhLkwhvJ562xhp0g07Lae+/LZXNpsoD7g/yRvo01+SW8FPz+nYisW7VDk7xwlWjyxlyDvDa/0rvEX4Bl+SFykRXqmTE4OFhKWpBtET3CnXEpbVCpt7663GJIVbz7uUt7YZp+KQQqnd9ZF5JBz7p155T5KuGWpHhoyj8oQ+aumfQcrqYoCR5+9m+P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J42dmjQy76hYXWmrZwEQ9BDGMrqguP9QKgxt5Av7OFo=;
 b=xFzzEf1ut2LhGTkaRnTW/P8RI+GOfDFazd7rc+aZtz9nFwMp4zQ/D5Qq6JFOacJ6i3jqXHRfev2lDlViCzFsSkYZzBp4za+KZDn/ApDQWHjZcNgs2rd+/aLO9joXdyS5Tt1DFtg0ywMX2zAhovBPFMVRppDiCNw/fhhdieRH8cDeFyK5OF6nUcOfsLJMZmXiEABgDs24MIwHbTaqJezMTDWIkWk8ZFFA6QMHo72Tg/504+wBaIzPixVB1371qWQy26vMqWqr5MGwpEznRohUh0bRXeJojX6RhhsuGa6DR3y98A5YOc5WedJBV5lMHeOfDxqpXJhRVHoDNZY+bdAnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J42dmjQy76hYXWmrZwEQ9BDGMrqguP9QKgxt5Av7OFo=;
 b=SKqRWMcacdoM6HFPYOm3cXQyDw0Dw2N2MgPrxAsgZk7aNtaG2g8xA5M1QybFH+cg9qFdLbJgwHz8nQZPaRDOXVLsumeppkBiyUsvaLjxhFFZxeYWV9KL4ZTeUf8q6oq8jquwO9EXcMFvvdk25GVesTxQzblo8d+lbdNEquD3fRjha3uSpl6nAGqEHMrGyGDwyrNgmhQSxOsNP2Oy11Z+SVsI13lUFGOLD/cbQzU9p6xoK4fW29LZbM222GNoDIme/5HL8jaMExDenCgBn+B+sexxQ6KOjzzKVlxJi0mJwA5QycikXe+CGKQl8g+KC8uOV1QBj8NYFyFtDoMaped4Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10700.eurprd04.prod.outlook.com (2603:10a6:102:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 02:13:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 02:13:54 +0000
Date: Thu, 22 Jan 2026 11:28:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mateus Lima Alves <mateuslima.ti@gmail.com>
Cc: alison.wang@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot
 board.
Message-ID: <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
References: <20260113142303.441190-1-mateuslima.ti@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113142303.441190-1-mateuslima.ti@gmail.com>
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10700:EE_
X-MS-Office365-Filtering-Correlation-Id: 81133f57-2b75-4975-80cd-08de595be2b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wo+bOCTzJV4ofKWyIgoGOq4sbVvhJS+BRgaFbufGZz9FQDzqWi43iR9VcDeM?=
 =?us-ascii?Q?NPFMcsOs1d+4b3Vk4PtpeYL/KEN8Z3wu8s5ohxpOM2PyM3STRtEwTPe7pet2?=
 =?us-ascii?Q?Zm9X9gGvojtT5l0YCsdjTqK7hUdo/YdFvoON4D4ijtox34ZVlowp7xHM7veK?=
 =?us-ascii?Q?r1f0kD+o5p8NZgJ3MU2itYYrl1xGH7vCZQymMTmI9tP7LRQBCSFEkkq5+7oA?=
 =?us-ascii?Q?1e+s7NpCfiqoumLFMCRRiv5MnTmo2G6PVI/8X1xIgBkkAw6vHErPwUojkb/4?=
 =?us-ascii?Q?Um38l5dCmwxI6D21KS7LR/08lG9qOSGn7+DMFfS4SO8aTZV0b1nI1W/ai8Qv?=
 =?us-ascii?Q?hvBaibBt1oaR1zaoea2G/ivzCH1wE45mzvxPa3E3/jYEOgaW30e3SSlMljXB?=
 =?us-ascii?Q?XI4In4s2IDS9rEiJ2QOr4lxJT1KUE6LH13RQ9iLwMGMcLiZYUWGzvx9a6LM/?=
 =?us-ascii?Q?ER0SrvVd8CuIQ6bkArt+1RKwjZ7di9LgbMcfuNMKlhxlHfbWCaYf98wRx/QA?=
 =?us-ascii?Q?RiDoYPMqABwAADBv7AmsC1zpbTVZ4lCyNAlqweTx+5XKe2/Pd8ADgu4/h0OI?=
 =?us-ascii?Q?chAaKWHuOSmVW1Dm3ohrX87JS90TpQhwPDBOl1eYRGXywvvHCoNOLZUL97xO?=
 =?us-ascii?Q?FKuF6254eOfAA/yUtliE3t63hMTqccmpJOHZ68EWP2rqICUnNItYZmBS3AiN?=
 =?us-ascii?Q?yYILwcLMX1YX5Mw5FST+lOST4G5TYvg8anM7rM0lMYiDZ/bHZqe/bmOiSnUL?=
 =?us-ascii?Q?8aiAF28JIKdIWVQy23R8rPkxbVgC8F8FqvLwEzFrIhh3Q0fBVbNYB6XRwQ5Q?=
 =?us-ascii?Q?K8PMyMrEEofZk/aLG+ByW+61T63wWYixmu7iTO/mWvZ46ofJFK1PYyVSdagd?=
 =?us-ascii?Q?qPUqg8hEw0fGYl9UhsyPhdAG/1gzTqcyB3XYCtHxI90pxQVo2ATP+74cDqcm?=
 =?us-ascii?Q?v7Qg9hMD/B9swgWevaXCNAJ11sYi41uXBNg4oJNv8UfV0N64rIQEeZLOK326?=
 =?us-ascii?Q?ebvEQuqIj8azoT3zPYKo9v60EedkBnDUsRqIFZe2XrK5z4CQF9MUbq8EsP6h?=
 =?us-ascii?Q?PKeCX04oI+tGaAOLc1GKFvNDuUeyq5TxfpBPpxkf399oYhGS8RBYuF9lZGcL?=
 =?us-ascii?Q?8nGwg+dQ8Jsy4KwGF7NKlki/y6J5jmZ8I4hB9zx9lHtCoyLTILh043o6Y2xr?=
 =?us-ascii?Q?dYqYLJOzmSGCHRQZkE6KTtBzRShca8D1bxuDKPNX0UsO/ZDSfLo0O/LMY+3A?=
 =?us-ascii?Q?+GiqgHa7JeaBYnk3ONPNMN/+iAACePHwIdEsCNyGRb9zmiwywi6FmdEKksbd?=
 =?us-ascii?Q?v5rs94HaQtG2pn3Mgd8XZGKYgscreTMTKAPhSLjOVcSUs5dow8KDvcbrt5if?=
 =?us-ascii?Q?JI1nWL6lOjoMq4Nq5TMVQxaVaBx5wbPOhx0k8yXgWE6VughXmbT0qBHjg1Fl?=
 =?us-ascii?Q?UVGz9iDQje7Y+yO/uJ900X/PI1w07ix1FTbVDvpFAs+Bo5gomzdytYdFLVLW?=
 =?us-ascii?Q?d0uSPNIC9YVAjUIgC9H0gVLvT649z+CdJgbZdFHHUFbnem+PCOGI298gs/J5?=
 =?us-ascii?Q?iistY/5hh1TUodQxXeBs2w18HaWkd5mq7L0VO9s1rio7PDKI/e+tM5o+X7aX?=
 =?us-ascii?Q?OL+mjYsGHOBTo3kYxFDh4+c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zxlJHr/5dnLkjA7kUjiOzw08emV+8xGUxjmQ+o7EhCI7A7hF7Gw9EszXOgu?=
 =?us-ascii?Q?t26dw+rERfN+uN6ti6Z70k3i8hgcNFcifr5OarIh4OOSlf5OlAiC8VyOOhzk?=
 =?us-ascii?Q?lhx/u0Hfrkg90C7eldq03PkulYUTd+3jmur6lAQF0m8OKcQs/1Svp9f5xlTH?=
 =?us-ascii?Q?7eF4BDz5omM2V2pD0izxrqeduQg/IV/crnSgT2D1RzG6DAYncJcc9KG08RG7?=
 =?us-ascii?Q?Ma7Nzmtw5qLsig82Y5exV4zEaDH9NOIkxxNWCtkSeuuJYYC9zRlvR4+Rgnsd?=
 =?us-ascii?Q?B/PEps42961AHceo1k/8rFPO3SxkCa4G0OPZC17hDHzdy5/6wqOlDOzAHydM?=
 =?us-ascii?Q?ceNfYKBI9QFgjqXGs7i8QpTPfQrpyoQRpv/YkhFdeXTGoavP88aNH6PPuefq?=
 =?us-ascii?Q?9/vBk4QcG3lKJRDhVyBLHX7aftB4P4F3rzjdzgzlWyayG7yK9klG7SRWA3mH?=
 =?us-ascii?Q?u2S41+u29b/U/uVijSOIM9EeBqZnq4v0IMsZuZ51dol81SEzyJIFkH3bIBNe?=
 =?us-ascii?Q?8ofTfeJqYXw3yfivTqCGN7bWISVZmZx/UBZP4Cue22soBaK3uHW6Q7qpnLRZ?=
 =?us-ascii?Q?bVzRIFPtk3rxZ/fuXkKviSkXwKobKPZiDC61ulSxegsOsyWH0TtnHcsrm08F?=
 =?us-ascii?Q?V6ltXohUq3Cyq67lnVy3AfMOYHk/tnukSVrueVTMcANJW5RvQWvXGmlbIO9z?=
 =?us-ascii?Q?6XE4PcsMwNIp2hnDZeFviW0TYr84eMALLqhL6Vfih0b6yYXaCjuxbTVxYcNT?=
 =?us-ascii?Q?LKdmNkleWb1TvZotzVd87M5NEntL9D7rlmPbirCIgJr65hQiQVwlZxmaRbTb?=
 =?us-ascii?Q?tFq2HaJzWFt0Hu2V0GeMSaxzxWppUPMTLPht/ZWCcnbfVqV9MeZpioJxztdV?=
 =?us-ascii?Q?hUMJuQvQouSy8BorkGtaHNavHzWr4HYZcIfVYQr6+kDXuXx6gqesdHU1Ef48?=
 =?us-ascii?Q?wtNkeG6aya3KR8aGbBFyD2bF1l7yybWE+SmwrvD7WxwmwatN0fGKLoCgdwjo?=
 =?us-ascii?Q?mySwvrrhA9QPQgZUXhqFK9sM83v9UoGdLn69w3XXOOwlot483tFvx8mOUnaV?=
 =?us-ascii?Q?dSqWZJEzPCnyVYK8Be7maQjLD8aQ0kqlMHnrAYPMX5NRn+CVsG6iJF85p7Ro?=
 =?us-ascii?Q?5B/5lTcE4zvz+ViRRcwRjU1RKSNOwjCQEUBabqo9/kBS/mEOnVcy4+ZQxgL9?=
 =?us-ascii?Q?oTAXivL/UZOo8P5r9FMUxMtwRYPqaEW9EVCFPIRdO9nCJ+cXxZ1GCT0ljYxx?=
 =?us-ascii?Q?mwxYADjkVDWS/PEPeWZ+4sQQadGvBILD3ag4v7Zn/yTfQlTQKwFBnsulGXWO?=
 =?us-ascii?Q?asDzzK5It2zxQZRFJb50JclEADeyyYFzmJJIzOM9SI8a+zrmnzzbYmUmt6Ii?=
 =?us-ascii?Q?s8uIi7LOsLFbp+flO9qI8GzhUUUmOou7v3vSRylP8Jf25pJXJhi1VVcjez+K?=
 =?us-ascii?Q?GzdMztmcVQH0etSh6ppZMxiuRlx6Lra+1gwmPNBMxFUeD61AXsYa35oo2T44?=
 =?us-ascii?Q?MDDLs8GTNKqPr1bcyGfPNzdUN55DihNgsv41pLkb1ITihK30rVgWmoNIJ1te?=
 =?us-ascii?Q?TwAigjjWi9NC62+ofQkPY7At/DnkAIKfxk+/qAqPDocW9j3pZtT9Tb8Ur6MG?=
 =?us-ascii?Q?KJiqdZxT0jCWYcZZqNya61S7K4FN5zXUFAgiFqQFSLRyeKfQ7xemFtaUeIJP?=
 =?us-ascii?Q?RKGdSjcxHmTbczqATtfK5SKQKj3D3gsuwhiuSZb1wyE939bq340/YBzfVkpV?=
 =?us-ascii?Q?bRrYZg/NYQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81133f57-2b75-4975-80cd-08de595be2b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 02:13:54.7957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eztDBRxhDVz4FYR6wjMvhzJm32RSEISry3/yhwcOb8YdsffhpEJfnEAPKLeOEYJuGrjODvrhQzWAIiALI502Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10700
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

On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
>This patch adds CPLD support via IFC to the ls1021a-iot board.
>
>Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>

CI report build failure.

  CC      drivers/video/hitachi-tx10d07vm0baa.o
In file included from drivers/misc/fsl_ifc.c:8:
include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or directory
   16 | #include <asm/ppc.h>
      |          ^~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o] Error 1
make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      drivers/rtc/ht1380.o
  CC      drivers/video/hitachi_tx18d42vm_lcd.o
  CC      drivers/rtc/i2c_rtc_emul.o

make[1]: *** [Makefile:2191: drivers] Error 2
make: *** [Makefile:362: __build_one_by_one] Error 2
Cleaning up project directory and file based variables

Regards
Peng
