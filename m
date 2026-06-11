Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12042CD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 04:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29FFE84874;
	Thu, 11 Jun 2026 06:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tw5bjd2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC7D84895; Thu, 11 Jun 2026 06:12:41 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3845E84825
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9uv4vNmpeSq9OTOwUfYEBDYdf79arXvkMqZkohEAGov1ad7T12TTazkxzoswFX6ivuJ/gc6+oAsOHIP6es0Z2dLMUus+a7UTko1PzuaUkQfh3N+g/IvQ7/0ZBWQ0JvznvScVrzr9O+e8SvrB4uhqY0mhRK8Oxjly7aaOq73tQ/nKLQl8Ddwn7EpcTgtkTs6+xyTA/myoXC6mQaFa8GimeB807hUlDeuILUW0L39/1XNgFgI5T4GzQ3C0sWvJUWwPAFti/m7xTEADvGN/TJOYnlzDhqbE0SN1OYut/e4AS0RDA/8FZHOa+kuqc2SGzToh7b5aA36moot2XnEDxVbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrOlqoyrRI6IMxf0n3RIOy3kCHS+VLtAb5i+jXRzY1I=;
 b=LA3OrRe+swejptCeCKC5zfWMpNMr0j+PhJqNQHJQrnqzntxr8KUGRYDHg/ixWVKXKfAZ0W+BFM7MRNOl3rjsDIavNyIEjDf+dR2eadaI5TKvlZePp90gIPivL0/9rxyyhMn+yOyo90HRWfuss0AGvVlAy2Hqqj5Xsc51Swi9ESfLapfhEvat3wgBsv1/I8TL2IW0l/Gl758I0904S75oVAGqSPZZikdUykT05Ac2BQH9MRALnClMbsuWEogm2yDiOu1OkzZmtf7nzKUa0yYNLI60CkGYtGRTZODA82i2hi41VB5CblIfEaPL2Uyse75bNSYigRohPmmyzjtq1zbzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrOlqoyrRI6IMxf0n3RIOy3kCHS+VLtAb5i+jXRzY1I=;
 b=tw5bjd2m0kOJeV85xaYtdOJiPPybBT6fqgqWuP9Mq8Yz1qCyHyOay//1P74bkIOj/nlzLmh7DTiwFLOQn1HLWJfxIs7HUagKUGXSeIB5Dstxfg6343LSLC2DDGVCHZkQv23lzxuAvfKA9HZbiYG9csgWPo/2vp/MwUtbeKZMdH8ugIbQtAEEsVdQtp6x8SRE2xBc0TgCrOgo2TynOqQWIdr8qpdRPR5xjWJY0dk46zBWksmNSKz9qbShkYkAsXniYdH/1oF6R/WXwJAdi04gDg4hOuBE7pMmT2HvTJSvctHjfiT2hYszvWhEVnRoUikwQ1zcZsyEqqpWp4V3G0gfoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 04:12:37 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 04:12:36 +0000
Date: Thu, 11 Jun 2026 12:15:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1 3/3] mx6sabre: Move environment variables to .env files
Message-ID: <aio2dZj+xjIFjO2D@shlinux89>
References: <20260610133336.15999-1-aristo.chen@canonical.com>
 <20260610133336.15999-4-aristo.chen@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610133336.15999-4-aristo.chen@canonical.com>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: ab71b343-a13b-429f-2ccb-08dec76faba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|19092799006|4143699003|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: spjlS2Og3CBvAz/hnTJ/is07tLp8Zx/geKcDsouqUPjNza/8VnBKjPYb2gISqQkB0yBji937qRnd/j7jcUZhVxW746FZPNLayFjL3OWzfDRHpNKrN5pQnX1Y2yTi/b/e7rHzMfykSVbv8P9Xj4qsYI6DgNotTn14MZN4+aQM8LCy0EmOEoio4pZbSMhbQlx259j+/JzRslRIHvfAmW6mapOfyamPbAu5Y9ciumB55FQmcJRkaXQLu5GjFDxgM1NKrrKQUtsu2XB+ihZtil3NiTBCIScPjxdUfbpCqTO0lr4s1brwL+IMI4zxOLtK56SELe0vMtdKjJGKzzqPeyIRRbrZX4P0cyozTL2qZgnAUa8FOBwpQg0uxYXFYWFeXIcB6Eh4r2FfDGyt6vj2kTPWGo755t8DdEEMac8vM3+CN+2hQMiSnXRWoSggTl57u24w6FSocYO6D9gfBIegh20meDthd6xCglDii0JR1TKod841KSE6XpDTuoSNktlr0mIdDZgx+8fTvZZO6UNDQM8PbNoztLpp1GCi1C7Fq47CxaJFuoKyTgMipRdJckeOFeNT0SKzdBhd5Wmie6+p/6irKZ+X5VbDRnPJzhZA3tog/6JOxB//COMi82SDX8bQBCz1g61WFdxHPZvd535closKTuYbqB//NSgBjKlrvHdYFqegpFZ5QtFRlgCz9bfkv29a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(19092799006)(4143699003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vH53VPpbyCuUAALMo6WcRwgifSht4ETvU1CL88+kdWYSkBqQ/yCJNCQECxak?=
 =?us-ascii?Q?DQGT9dDWZhPoNRkpB8lPNVLhV69viYB5hzzu3Op9DlufJcP79qBnygNc7dM2?=
 =?us-ascii?Q?VTzGHZ6iPgAjUh4I4+NjrDIPJtFCI+287NlU1Wr/w67xORUYBB4SlbI01YHP?=
 =?us-ascii?Q?AThgsFge2Gv2Oc51AzAFL5+khQUHcwn9rGowVbxS5iDNQFIC1eOCxuJIhRlh?=
 =?us-ascii?Q?LDDNX+2AY/PryCb6KpjAQuma6MVdEl8Bto+y2jFQfim4C2WF6HONzf7TWODe?=
 =?us-ascii?Q?hGw80slZV3NH1w74iXm86bsGtE4gZLLb57Ld26wSBu3scGZsW9P+8hS59q/o?=
 =?us-ascii?Q?k2UuwXES/vRqOUdTugAiLUeHyDSbBS28zsWNhVq4SZ4xvCWaw1Lve712a3Bb?=
 =?us-ascii?Q?uAqU6aEKoEYjXOLxRCX7xkpmYMay4qdRWTj65g9fiXReBvoif5z1JU/jAeBn?=
 =?us-ascii?Q?Xo4byQuSB5mwISr0xhzNOm6bd+AUcqv3IMCfK8FqWOMPcYsUj4Whw4WaDHXR?=
 =?us-ascii?Q?CNc2zl9skKRAypjIBKJsu33z6sBGAcSELXa/oKJEU37rKFX+N80wQ+ynvc5w?=
 =?us-ascii?Q?sIbWa8kzT8Viz7YGYSnz3aJFXEl5ql5FWQ3ahvYO9wIdzLieQNiw6UGJc8Fi?=
 =?us-ascii?Q?i+p8LPwVEft6gLLekoXXtlMFrUj3SHIYsyfAcLlC6TpJQQjmvJ5oEn7PEpmS?=
 =?us-ascii?Q?qsBkq+rUoOmIT22PozdkHBdSBcLEmRQSP3u259RNOjxSnHqgdO+S0QHJIa/J?=
 =?us-ascii?Q?qoNHqhRi56Y7onEm7kaHEGztMCidr2XErWCR4SNIsUeZGjErwJa1c8Atnfrw?=
 =?us-ascii?Q?vPoR5J+kyfc/HZE6t01UffIaSs6kpOp05V6xOUcFnZxCLClrO/uZNkmvIW9a?=
 =?us-ascii?Q?QJ3CChtkCq6gJTp14tJbvuc/gLdDRODLeDAGwcDBmpKBwOrYqSB5Dg+6XYtX?=
 =?us-ascii?Q?yvzWlTEAbe0126dIqR9s65iD/g10sc2wXa4zw1k6tOBPIjZ13XjOixVPtJAS?=
 =?us-ascii?Q?mQyrhfQBbCK3BjKWvBAGj9F3YMoRfz7adIdpjVfC9t2Bh12XXPmzqZb+otaI?=
 =?us-ascii?Q?s3x5x02kxBD9WvNqaLhAX5ckGCFr0Y9/fTy8IAwlXb/zjHwNkzBNfU6mDtyg?=
 =?us-ascii?Q?QBSkGeTgW6zgj2neOR3Ljp4WUKzHgRBF1+ePqXuHqhMH36QDtFKBWUsQ+6tm?=
 =?us-ascii?Q?1qPRQpgay1P+BDapSOmCp9/glgCZ78YMbfpg/gQN5bWVvkOxkmU1nNRe7of7?=
 =?us-ascii?Q?97SLT4mFaDAFh50NZ7sBHvVUlRwp2wIqY8GQTpvanevBbuno5qHY6G/l/Wbj?=
 =?us-ascii?Q?F5cJ5ELYZGxIvIq8aJ0ZudRmEaG2KGeHA8DXiSFpueSfaGNrkO+NqwXW8aVU?=
 =?us-ascii?Q?83NGtntVlMd6YP4oZmSrYXUaZKafAlHO/YJVQBVPEcNAJG4D8AEa7PaaliRK?=
 =?us-ascii?Q?73ZPpDJ4CsTzE9Go/ZynwfSC0XzNyIx3bHJg9yMVTRIacQt4CWI986mO7QQ9?=
 =?us-ascii?Q?FHyCqqhZ2dRbrVTaOiSIeGlhcUzver/bIKkQZ0RM3Za3pZZjAPre3sy29ZZ7?=
 =?us-ascii?Q?zGUBuPIqP3iwSGY249v/vYGXuAnSJah2Qa8k8GX3RbdogeeVoSZfRmcioSvo?=
 =?us-ascii?Q?JbcuAFj8fs68IE55f9RIRugIacN7SBU4t0uU3JHGvSQKt7Z/WNUOeHtrWDX3?=
 =?us-ascii?Q?KYUkTDzkJuReZNZ1RbJshmO/U/AxTs368zWX0GI+gHTM3/y1CWQIax0G+e/n?=
 =?us-ascii?Q?GKNmhuYvpOc1oUs32vt4gdWC7CDydz9jIfT74JY1VfeINj+ulH/f?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab71b343-a13b-429f-2ccb-08dec76faba4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 04:12:36.9065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UtyjZyDXnaqiY/HCnyY4qV8oVYu3E+7ghEsmVPKL+s6qnet+RZhJTgRNDt/DJs1ARf2LtFTy1BaGDssIjUP5cD4RgGPbHDElho+0sKEFWGs0WENzGaayd/1tAm4sfrC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223
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

On Wed, Jun 10, 2026 at 01:24:24PM +0000, Aristo Chen wrote:
>Move the shared environment from CFG_EXTRA_ENV_SETTINGS in
>mx6sabre_common.h to a common text environment fragment in
>include/env/nxp/mx6sabre_common.env. The mx6sabresd and mx6sabreauto
>board environments include this fragment and add their own console
>setting, which is the only board specific difference between them. The
>eMMC firmware update variables remain guarded by CONFIG_SUPPORT_EMMC_BOOT
>inside the fragment. The now unused CONSOLE_DEV defines and the
>linux/stringify.h include are dropped.
>
>The generated default environment is unchanged for both boards. This was
>verified by comparing the output of scripts/get_default_envs.sh before
>and after the change, which produced identical results.
>
>Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
