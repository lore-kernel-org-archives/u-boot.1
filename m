Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44ECC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 14:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A2EF82BA7;
	Tue, 29 Jul 2025 16:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GWQ1rS/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E084482C65; Tue, 29 Jul 2025 16:59:43 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0878682BA1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 16:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZWSV0YzSvZ8V9Sqnq6VxTWjQCBQXUOUZAk4VM7CUiiW3gfQDKTxXhiYzycPm2sTdgYl35j1TW2EFH8wBKTYqIjdfDC1jN8jVLv+dSTqifHHWbElyTIwM8VrQxaXn6iCqr9zLk5W9CtSW1PT6gZphQdtvQJkFl6v/MKLvdU/1EWZY8/rwHDXzUkKT5BWo9D9A6bVqe/AZJNxJRj5CI9DYtVgYk49jLdHFI0q9LODN3+GTmIM80iGW8avVTEfBbesxXRPVWgX4eiSvj5qVXPx9hSn5R0bbef9nnuCbSbzTKVehg6DaEhEofCPsLZmXcN9U8NA2ZajOIUepM+fZrfBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmqQpy53ZT/fLDsqkvQZtNuZNI9jNb2/ulO40Ga3zIU=;
 b=dqLF14TTz6eAu+I0sUZXCofECw3C6t6X0jW57PDy76yWn0DlDj4XpBOWwbS8tqLu1ZakCABflxNkJhyToTRTKPIgzV2GF7M+qY4jVO/5FWxsdyPauf8aH0mXUmp1VJN7N69nLIGePm6dK7veJzReN7S4Tq3dl1jSx69tpF4SXAfsPKZccPV8Ew1pmO0KauesFWViGmG9J4rylFZiCM2TV7wWnebisvHadoete51/WPK2Nh/PXLccA+/HQKdMcFUD8/0GJmHDQjTV3CNC268eCfWKoTa+pjrrLZv5+EA9C2lJKaKeRVR34L1FCTsD19yOrJfrTsVcKwjOi3g96dqr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmqQpy53ZT/fLDsqkvQZtNuZNI9jNb2/ulO40Ga3zIU=;
 b=GWQ1rS/n8feFn3C0KrMaohWtb9WfmIGAp6aAhB873alFJ2kWfhnqPfD2gQnmvcIMIpHZ3Q1tHPA/P67IuHKaQmQWR9DSaaW4aUsv+oXh29iJSnowdNlnWox/VrV9nq2qOKuZZWVWqeoqKjDg+Vqhh/8jreu9+pajrklj1n+QZJAHrQVr7/LwHtGOHENkABq/8svKpZTo/0FRxPRRGekCvU+sVYs2ZgEd5mam+F+lizUD1HMKfSsgyyEV6TiRRXPqlJ6EBNc8Y0g+U95IFijlWhA3FGZc3m2HpWynxIeuKd6PS6WEg9txRf+Ns39H96etmkv+KaXzXp03MmxMNq9RCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 14:59:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 14:59:40 +0000
Date: Wed, 30 Jul 2025 00:10:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: bcm2835-host: Remove duplicate NULL test for cmd
Message-ID: <20250729161021.GB31189@nxa18884-linux.ap.freescale.net>
References: <20250729-mmc_bcm2835-v1-1-2184f316fc21@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729-mmc_bcm2835-v1-1-2184f316fc21@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 437311f9-07d7-432b-a637-08ddceb08b54
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B71tek8dLmaGJ4yBcAG3K2HxuOLmVi95a6UrFi2nYuXeZrInU43P/0kaJaZx?=
 =?us-ascii?Q?StZKqQC2qPjlklFKKLGjmpI768U0mFE4a8vgL6noC7sKTCZe1jGgFeTliiS6?=
 =?us-ascii?Q?iQlUxJB4AYodex2wQEZ67shGByYkDdcu+/YudSdFnmkXFBackKCoVeMGQhml?=
 =?us-ascii?Q?H0huWyepzxZ2Ed+cFsImOG4zbMO06KULkr3H8gcEYoT3lO12QmoGx6Pwp+Mc?=
 =?us-ascii?Q?lAc2K02+0qO6eWkk06JF25gPED+aJMJTfUPS6AlR0rYek1LYPJjICzl2cshp?=
 =?us-ascii?Q?olvADf/k+pbnqoGpWBE/6mkAey6oPDlMW1SFYSSV2uVLbNZ4kWwQz5hxekHv?=
 =?us-ascii?Q?bZLMTwKi+FsIVSk75Rw6EcKJtMY1fug//r28j2AnjcF+lwfNyOhIFapzGLTS?=
 =?us-ascii?Q?UT34fla+7vAw417Q3v70mTTgBRIf6rmr5v4irqc00VLymaCcqXBMNgMz/Zng?=
 =?us-ascii?Q?1xT3T42TBf/CE0CNlvrOAuW3MMrWuCvQukekKLiORo84t22TpbDpJ7Jn4xmZ?=
 =?us-ascii?Q?YnfsjdN3V/WYKDxZYZ61xcltQgWJi0QIOFmE1OQP7+HjRQUiM+jDYQD1oVgc?=
 =?us-ascii?Q?RX2RojtJwjKf+slMB64pZ0E6K6Sxw+559XKo8nxl/dEwMj9DzNQuJfr+8U9s?=
 =?us-ascii?Q?fd0QVwDhQS/N+NRcxBkgt0vja+hLcaZ5TkKcrdqjQcBTkQ1+Hrb+om21Adeo?=
 =?us-ascii?Q?2FF1v3CkAjjd8RG5FnpWFhn+LOQMbZf1N8I8/YBhhxYbuve7fL0900RJYlSC?=
 =?us-ascii?Q?bcQi6fRR6DmMoMmciyKsaQ8fuUNCQDgDP1iE2JkS+4NHOynoaULNOQSL3JKB?=
 =?us-ascii?Q?ShkhF2sRtVAhOsRUMb7VnWud27bYrfjla2eJcDeOHgCihjgdVjBL3oUP3wjl?=
 =?us-ascii?Q?ajl9QIm05gNy/7F4wu9d10hPNDpXowGwSNgw2tRZCNF6iQvtvSLAG2ni0Xm3?=
 =?us-ascii?Q?JIaeDQbq73e8xMGpyAoThjb+s35YEhqfzQ6Lr9w7PVHQeZUnIybo/0mAPTOk?=
 =?us-ascii?Q?FBbH/5BflXbdPsBAyDFt5CTr6Sh72bbsYpkRK1U614oWrJo73QYGeqLNnjcT?=
 =?us-ascii?Q?eacuCum8ivHZsJP+DsaferPp8Lrgoi63el5hbJq0qf/hrEPqHVsmE0EaTZCJ?=
 =?us-ascii?Q?E8uc6MEExgDmVBHV6QXiLa6oEcomVzSQYUZycguP2oIn7L2DnoxJ7HBdQoT2?=
 =?us-ascii?Q?STyJSnrTZJc1HM6bsLXskuFhXpAYGDk26cUIzX6LzJYk3/zqG9MMSjJvZX3L?=
 =?us-ascii?Q?YFYiCwsLcOHXltgo2akJXLQGaIGWO/796vZ9dM/yGQCJ+A4r3oFTxaQV+GlV?=
 =?us-ascii?Q?kgKB5++iMpg+tj3tUUd722BvLxqOycbbn/S/EC1ZkXG/IgHyS4VG0AODD+oT?=
 =?us-ascii?Q?sn57mjaVQsfOSNn8eRM2NMHMXJCuEeW9gY9gAwb1b5WbOp4ebIdJI0Y2N3Vr?=
 =?us-ascii?Q?CINgqcrK4k0RBK8tmJbb1F7doEMnaRO/jjOMwsCFG0GPX+cGYiQUQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKtwYkfeMY3VVSkXgDFcqqGk/QJFjvsugz1HV2/Sbc38lwlpyHTzRN2yd5s+?=
 =?us-ascii?Q?LRUlJKJTqro6GVfOEjgPez696q33chuvndATSX8xH0kUjoiSr9ujjsDHrcRe?=
 =?us-ascii?Q?sB6vj0Jd9iZCm1FeXDHS6ysWEm2/GqiIsIaOUszbcusluvwWIgsY/ErVYyrO?=
 =?us-ascii?Q?oxoL39FLuoCMznrz4xXVPvPRlgm+BDci7SGmDvzSNKGEzR3Mxc2rAFa8PNRg?=
 =?us-ascii?Q?T4u+z4aeE/t1uyMEtjKOX5FYTIiTIskf4B1hgnMHbtompvrOjQPs1HOGVs4e?=
 =?us-ascii?Q?VMx/seJKl26RgrTRTOd2Gl+CDmJ692oqy88AojuV0bBJkp8Ysi4uRiXjJVHJ?=
 =?us-ascii?Q?gG7t+ytQs+QU8FolVc0yiZn7lixEnAxSN/US1IwOBm0Vx5xUgXyvP4JwTdca?=
 =?us-ascii?Q?yEB6c9EeA7NWM+8trYv6CoZBR5Zyj6i95ywfuf2leXbImqJlB/HlMMIh3R85?=
 =?us-ascii?Q?dova6JTP13yPZStd/n2LPpRpi/r3aofElkmflOvLifPWvwm68eSXcNI8QDNz?=
 =?us-ascii?Q?vIBLd5xE8w9+FGmkfEjgCNleWsn4EDNUr5neBQW+k+QqcOKCptf/gB2Ehu77?=
 =?us-ascii?Q?TgTdpvhkBZm8ckuKW5wgb5wmF8KqcL0qiB3WGBTKHkw9vGC/SqPUIZmFvNpN?=
 =?us-ascii?Q?XFbZdkKuZB6AWAtnxZKePjSOoJ3cN+O49Alw3pd+Lsub9cEwbRyyt9UP/MIB?=
 =?us-ascii?Q?4aK7BV4UXX9EWjufIWFYPIB95I5fOzJKRpBKlsEsx77zcjrI+6LREwX2Gce2?=
 =?us-ascii?Q?9z6D4lgWNL+ieEw2YVQH6wVdHv/y+AvAUVRvHckZuwAmF5lNftdeqG2h979L?=
 =?us-ascii?Q?99a+ZBSHMhgrncidDDrNwICuyutmgscPCYcPYUuvn4jUF1rlu7APA5o/apZn?=
 =?us-ascii?Q?3tnJ/Gsa8YAHjhq+2DUYukELPaNL6+wtOVPe3vLvkYeNTGkLadXZL4jj8HQw?=
 =?us-ascii?Q?qFDydBcbGPwhXnJzayarKE2INyKbzGnKyNLFfnpDC63+JzvY2Q0B58DZcLZ3?=
 =?us-ascii?Q?8GpPLV56HNCaZAJRvVl+sozYCXKHIUc8lfckhA0HYxlmifPkxtcTtHZ7CO4u?=
 =?us-ascii?Q?XM9nPDFabLvLlvA57lYkJgroohrX2Uku+XosNcau9KokHMSMvT1bvZYM42wm?=
 =?us-ascii?Q?SzhyrT/zsUMhIjy/+Kofzh0TkNjotodMOgwncP2dUpuIQRCWut8EIXlyw/P8?=
 =?us-ascii?Q?Th60u1ewiOVDqnvaK4FxXG6ZrDyzgdTIB8ZUdLGfV9OiLYhmdqw0Hn80EM1c?=
 =?us-ascii?Q?gUYbZEZTBuZJRWuP8lL5t+Ic1kfrSfN2ZaJ4m/PMS3aS4zTpyX4Zb+64ySEC?=
 =?us-ascii?Q?PswXxQrhhh+x+05WQNeeCFic+Nm0R8Qd6vzdursZpWCENlnrJ4lVeYq2VopP?=
 =?us-ascii?Q?4SqRgE0ur5gZlwi7Cod0pRsmD8X2snjm5u3eOCz+uuSBrl6fuwkQPVtMuvLd?=
 =?us-ascii?Q?Rx5wwnukP/hx78Fj/5oDixuQTCsyFB7pag1fU4y57JfDmh4Ei16rdT5WhPar?=
 =?us-ascii?Q?NcSDHtCoXd4I+icAIGY0UjeImNgMXw5c5aJlQnn8lBp9gch5H1TT/XDceHN7?=
 =?us-ascii?Q?yX0p0oY6Du7udGqF5I6Uv6Rt07RTNT2pNBO7JDkG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437311f9-07d7-432b-a637-08ddceb08b54
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:59:40.4858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfBZZDeJqG7xB1aXC2bZ8Zz6wG+8Md4dfTqifcQpYWOl4aMyQdgaD3artDqldzm/sozfMiQEJe4Vnk1luv22pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226
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

On Tue, Jul 29, 2025 at 01:05:13PM +0100, Andrew Goodbody wrote:
>In bcm2835_send_cmd the test for a previous command not being complete
>depends on cmd not being NULL so a second test in the code block is
>redundant as it is guaranteed to be true. Remove the test and the
>unreachable code following it.
>
>This issue was found by Smatch.
>
>Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
