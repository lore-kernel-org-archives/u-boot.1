Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8123CCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA94D8323A;
	Wed, 22 Oct 2025 09:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wzfLKAXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF7E82E34; Wed, 22 Oct 2025 02:58:49 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D7D3800B6
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 02:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQpdDypaiMCjVh5xa5N7eMgek0oHgMDA6VHGW+2ILeKRhPP3/+nqAJpi6KfBxIuY82pRp+z3aGNWKoeRUj0nD5IptoH/szE8szyNtQ8LbT8gG2BlbJpHgF1e8QwI890Wf8mXiVqqYccdpSdgpdfdRrTgz5KBFvJ+CQkKdiT3AFSpUc2fYfP7MnsaVSn7pTRhvByoJ4BcDgyj5mYzyyKj55ZGRbIf07LJSM5KLhUcIBu80eiKRXWThkghMNQy179lpvfd+85dT1+0b1Ng3OsoP6Fcc57B+mW0Sag22x3ozYVq32oDs0qdGpFS8IKmGXbrXEPu84Mbky8Tn4tBgqxnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsIVKiUC3MUTnB5D2eI/6otuY8AzcJbs+IBSRin60Kw=;
 b=EdYvYiBDJw4Dx80kl4cSQKhftNpMrHEMJzey2HrOUidANhtWgMn7Y29gmxnfP5S0Sez7xlcte9Y9mPaNaIjPa6VHZ6zv8PjrEE+z4tDbihANuwG0S8rdVYLA2DOztG2PgZDs2y7z7+zgl+fDk6zno/oaF2KszyGheAstosx+BkFAXBHAsnpyZM6X+SdaGC/dCj1enCvR5myzJ9bQHbfvuPvSvYAod9xTkWLz4oyrWzOcYgEFXd91SYMFymS2mhMR8u97aN1/bmNqoVW+HSJfgh3sl64JhFdFmIRC2UzkFJ/kAwtLILDCsXUc4sAwkIfi01s0e8eOZfh8Z7D/7gDDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsIVKiUC3MUTnB5D2eI/6otuY8AzcJbs+IBSRin60Kw=;
 b=wzfLKAXo8L4tqnPbX7dGbkkXGIvv/9lf5ELBCUbBdEILQqD3o7h1UnviGu48YHgYyBuNODAmHg11UL0f8qfXwHfD9o6gMVBaARbebanQyDRZYGfdtBlGNlSt9iI+STdCbTUIZGGzg5nqdd4X4y6sPUzCLzH935AYFO0jeW63tcdo4MfGhUzlDeom+blFgAdi0bq9yB0mSRW6HQP+sh8lqtLCnkhr5Jf5gPzpzPzCY+LhKbnLs4K7TG5Cakz94hpLmaIA1sm7aOCK+k1xv7G+jghH3fapdXu3N+20EfrkwRd+8IKvFIlEZmF+2ukULg6oChvWDIhvSaaw428NN7ucKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9073.eurprd04.prod.outlook.com (2603:10a6:102:225::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 00:58:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 00:58:44 +0000
Date: Wed, 22 Oct 2025 10:10:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH] doc: board: nxp: Add remoteproc guide
Message-ID: <20251022021015.GA15054@nxa18884-linux.ap.freescale.net>
References: <20251020-rproc-doc-v1-1-61fbaec7c40c@nxp.com>
 <20251020142651.GV6688@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020142651.GV6688@bill-the-cat>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: a208ba98-ecc3-4554-405e-08de11062676
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GsPyjzDA6ntBpxEN14zlBvPLaKQr+eZfSNDei99LCb1XL2dAWXBVgybR252G?=
 =?us-ascii?Q?kBSD+eOQqB94A4xuOeN8VLWkOqxBrE9kuRtnX+8+dE399bxuNv+RQGj2wpa6?=
 =?us-ascii?Q?FgVfMCWyxzTlBt6ZvyQHMoxX8osWfs5zyjWEiI/PS6q21ArVojllLHixFYyn?=
 =?us-ascii?Q?E9Tw+CpNu5vDv0Sxc7XQtELq0VjU1KyZ3vgYmbbhM+v5bRRC95PY1TpNKQx/?=
 =?us-ascii?Q?sURp+FIXjVKrDfIi9nlBwjSFgBvEENuTptIrVhxNTnnONNEeEESY4yv5QRoW?=
 =?us-ascii?Q?BsXYjYujgCEsWbw6gR+yoF4MEcW1PdwQr6C/ZDk7DeW1oaAyiP6Eb1PeXTvq?=
 =?us-ascii?Q?9tJzMMAm2ZzitxC+UqluJ7Ho3Te8UgeJ16RQk2dLsUADVyp+WUiX5cw7and3?=
 =?us-ascii?Q?3u5670uAE3sHyY4Y+M/9rBeWTnmg564zrx1DloYlR6QigNcQitKJW/Gyng6D?=
 =?us-ascii?Q?Kim4GeRUhwRiU2LjkId3XO0jZ36kVJ23rFFvgzYNcd5PrRV8HfxEKkxYlqX4?=
 =?us-ascii?Q?CvW8SPuRjn812enb0WAe/hBeHUpNwAi5jlPkLzRbqCL1TCXRRTCU99mjpPwu?=
 =?us-ascii?Q?dayfWOSMQnvIfysHaIOjP4QZgZHvhJ32AwAVMgzJxmi/PfnluktCyhYuHsX7?=
 =?us-ascii?Q?0gYahAjHM81bJ4oDKChRnNQjK31elq2HZI39Szh2hHFuWq/EHU0Q/xK02M1e?=
 =?us-ascii?Q?sizvbaEwI4OLmTbDVfjuilcdWuAnUKsIlG47nGPVAnMcyjcXgAGp4xmNS9BA?=
 =?us-ascii?Q?qDXcaT6uqswkSoq2AH32lMXlY8LnP8YvrN3fFceiTBUc8MqED8Fh4lnnA+n9?=
 =?us-ascii?Q?kFTX/pGiBnFGITbA4TV5eCF04NJm97y6SQy7F2+7GDbXPqNPaQI/26x2ogtg?=
 =?us-ascii?Q?cyRisVE5xcM72I7jjNw39Yvu0wJKX58XW81Ss4QO3RYpxrXiofMd4yT0ZXzX?=
 =?us-ascii?Q?l4zJqv3m/7UqGX45tZ8pdXehW/Fh54wb1KkzQGpbsBVZGmf2hq6Wki1AHlw5?=
 =?us-ascii?Q?9SDpcTRQHjvmO7eROnUf8AJPLYoEWM7CL9qbenDMHXZgKxF7o6hKz3+m954D?=
 =?us-ascii?Q?e/qDlU18f/4D3gCdVCUsnyHRWewkqweyeHopXRZJ4VwuiHU8NZi6OjdPX8I5?=
 =?us-ascii?Q?uVt3K5TZpkb2qh4emZ1Eceq6Pygdictm1CTz55GytJWE2WL7ZbVeWzVu7iAG?=
 =?us-ascii?Q?v4s5VJ77POXqC4VnOT+dCNbrwT3/8eS6tVwYImwUcBmLrzV2zQDtxunXToq/?=
 =?us-ascii?Q?8Qb82iJF756rfBsW6g1xqONwJDCVqI7uJbT3V2psX1r1HgbCqXaQaBKMAiTA?=
 =?us-ascii?Q?MJbt+26IoVWsfPDwCo5TMj1kTTB0iKq2Kl5gOIFn0LPyqzCMWu/XdIOIlwpF?=
 =?us-ascii?Q?K2h+2aWyg3Jo4Xud/WqWWlvXu0NnYtr0wiW2ubHBgTi8ogyA0kw/bnqxm/OU?=
 =?us-ascii?Q?XVGazxHNH+mzgEJim/alhY/dXuZvg19DB6OW5lS284Fb6TpSvP+mh/RoLcXj?=
 =?us-ascii?Q?FdcQKw0rskjyG2SZORjnGs5wzqjyMeWxd2C5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sMY5WJ+bzm70dbYqY2hTizKkQGjsNgaFlvr/otKHxQ+Qcyp+Aic8v/mz1JpQ?=
 =?us-ascii?Q?gwXlnM9YbK71v7xZu8Biy+lYGdXfGNFRCXqnvLvZGfXVGzv8ypEcQ87SAz/u?=
 =?us-ascii?Q?HCtCEqSNcisY41owLxl9ueqvXyt+6iOUlLbIuumMiOfcl0pLI1hryKdBSd0X?=
 =?us-ascii?Q?2VW6VxVyFq5j4EYBqehUe0nbt2yLb5Nb2GP3UvxdLU+kXgf5eUVq7LPpUkWP?=
 =?us-ascii?Q?2QzinLS5Z/+0ogDEeMwNPp1OowjUZ4KiVxgmjn3rtdJOVdAMzvh2+LAORxQK?=
 =?us-ascii?Q?DqUsRvBhd030Jc1zB9ZG/X3TUKXptRZdWPpdRnI7KB/IX3XGKlDXS3dJSgdT?=
 =?us-ascii?Q?y9OAmxOVD/700Qmgl9XuGIgjk2qba46dN4BWDSfwqvRIZmHUtzM9L9jhm/wZ?=
 =?us-ascii?Q?6MNsyFR12p13eF/GkbSZD3kY0a1HRqp/q+DtszlkQvVZA4X5rDird4yAHYLn?=
 =?us-ascii?Q?U95w6TGMFaFtIKZz5zlogY79+02B2GENWXhCcUYsoZ8tYOintjQ91cP4Fbsg?=
 =?us-ascii?Q?qi0Ags6JSR4JCJMxJDnBeXWHu5FI7vWdUutWvd3QviYpPku1o675r1l1dr2B?=
 =?us-ascii?Q?YGvQDmYMWZkr3HMvRq2SKL2ynnSgkce5xBZUxFedBqZy3kbUcoIe5lgM/5nq?=
 =?us-ascii?Q?pRWb66y0LR7FdJAG9BJHpk5TWC7FXnD1SWzqTDV2lIje2iARxAZJuX8OD+Ic?=
 =?us-ascii?Q?mSpH2AKusltTycUVb5ge3Rux07E+UN3RfvpFizKo01ec7uI8pU8sQzvrCgLa?=
 =?us-ascii?Q?KQ0JS/wB91Ri7nkpdUN2Le37UTey4zOpWazyKsuZ3lafNYG0m4dFhrEEHyin?=
 =?us-ascii?Q?+CuuRLBp6+orV+j+Ss0tt2SidttPyI4g6Nwn+B2mmZDkML6BAUV8JcsZVLRC?=
 =?us-ascii?Q?6jx4U8duShysZKB7os8pBXDFa+X1hZWFGM43ZP2aaB6s26lSkVjfw9tdJnSc?=
 =?us-ascii?Q?buD4pRF3lsuJJXRLudnYIqMa0LYJO27eCnA/eeDmVf4q6ZjmdCaCmnwUmxwo?=
 =?us-ascii?Q?IjN0F7BkrMHg9gVtQfdI6LE1wPOh3uLtRqBAXguUB87+xWKU/Fo/Nlv0CXBH?=
 =?us-ascii?Q?iOKhClRdbCVRve8dMWiCfEgmRsiAJq357GYEeMvbI4Hz0alySeuVgS5SdjKu?=
 =?us-ascii?Q?yd4+rB4eEiRpvZUvi9e+gFh5mED8d8Mn+g8PmZu4XDj2HIv9eks7JIEphAC5?=
 =?us-ascii?Q?mct2Xh4sCiqx0d5AJmit+k6/w94JW9BoXPYhGxzfFogq4fcs1MIWs8LVr3Em?=
 =?us-ascii?Q?V8XRcEX2Fdkq2slyGHityp2YkYMM40wlPnclUY5vPENdU6D6qhBkJUnFvbwF?=
 =?us-ascii?Q?Y7Ka9e0kkJJ1BEZMJSNyewysPFuvoLRf33Qiua8YYVCO6XUfJaaab5wk6sbu?=
 =?us-ascii?Q?vwu7TpNT4iLPBuJL7HJd8DFKoHxdXa1hs+rNc1INyo1SHYcinK0athrU8j4t?=
 =?us-ascii?Q?D4Hz6e63PuvaoacHHSvgRg3YRAx7DZKT3BJUD7hADIAIMbASvpCtet5tfszH?=
 =?us-ascii?Q?k9x1rkP3leW6+vBj1pcyKm3/zDSAqb5rWCX//45grzEz3DfVc9rQCJ5xNOTQ?=
 =?us-ascii?Q?mnf+Y3YpOxm6421N0msbvu56fImhzAAoDc1s7sID?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a208ba98-ecc3-4554-405e-08de11062676
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 00:58:44.8567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r0N+w8Bj2f2RUZzvrvufSngIjYIB6BJBhxRLsfG0ns6fbIDJfnOMRpKFYrH7XM9ISt2aoMyvkLFvg2JM1Yqjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9073
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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
On Mon, Oct 20, 2025 at 08:26:51AM -0600, Tom Rini wrote:
>On Mon, Oct 20, 2025 at 11:26:58AM +0800, Peng Fan wrote:
>
>> Add guide on how to use the Remote Processors on i.MX8M and i.MX93.
>> 
>> Update MAINTAINERS to include doc/board/nxp.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  MAINTAINERS             |  1 +
>>  doc/board/nxp/index.rst |  1 +
>>  doc/board/nxp/rproc.rst | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 71 insertions(+)
>
>The NXP examples are good, can you also please add
>doc/usage/cmd/rproc.rst in general, and then reference back to it in the
>NXP example?

I posted this together with i.MX8M/93 patchset

https://lore.kernel.org/u-boot/20251022-imx-rproc-v3-v3-12-92273a82c5da@nxp.com/

Thanks,
Peng

>
>-- 
>Tom


