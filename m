Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830DEEDF020
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 02:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6440F83A47;
	Thu, 12 Feb 2026 03:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VNCmz9t4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E5783B64; Thu, 12 Feb 2026 03:57:06 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C355383981
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 03:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkuUAkrS7myB9nd+9r2ZBKMaREdsS8gRa/DZ0aPrqMRgurIR4KeJgqyQtnjr3YPnyEtBZterqqbfz2wy6qsUwzKn8ytYpLKTbvn/EXPCvivJ7dReIe7DkVf2r2WMZFWZ6qiuaIsFEQwZEvdgKSO3NG6AglKZCG3GJV1tcaJKNySbpLK8H7M0/su+YZqqv69kj9wk897YeVWibQM1G/du7BrpaKi/FIJWwYtclof2Vre9UzZ4EqPtItd+3PysbZJgjF9aH17R0v5Toaaf9tLdXJFnRAYuibmRzdxtsCCXvn1RF1/wWEAuGSstdC5w2QS+DuT0mMOXWpXH1AkZ9+rrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzD0hoK8qWeUYsYDBNziHXkc1G2ZaudhTY4/0FzoV/o=;
 b=hnNQwFPt3C3KryoiQgyJV35ntNrIXlaQfTPZR9fx0fm1Y+wHkkFPv0yN4MbIK0baRuU2tcEiC3k41omKD5ccwZZ4DzahRhW9sutTp1RPVe5m8OWLzqHyiBhjgDYwHNIkHK9jqZkYVYGJ3rkG4K9pn8I+VeF2Rlc4kyRWwWIRdlRdcliePH94U6fIrAwQ7apCGBbqaQ2KaNfuh9pQp19vRCAbuvOGgyxocuYyXuMR6EtPqr7vblFuCMzh6jK0dfFRWKOepy8s2Dxi5YodnGJfljjEFOu9vwppSu6JKhqTtIl1S6TC/KHzk3PoRmDI0hGHGikLwaa5bzhG6fi2j7YEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzD0hoK8qWeUYsYDBNziHXkc1G2ZaudhTY4/0FzoV/o=;
 b=VNCmz9t41i21jmu7SdfatFyvm8r6sohYEkSBEEekjoK4oDy8BB2swKWlJ6V57KIKp/Za6k1laTDSjBFd4v4azRfa2vkG2/zMwPYopGOC+qFbMTurAGWgjbGs6puF7nW6r2VAkV9dFkc5RPlTp5D9ee5aR+QmmeLUEc0M5zb5Y8IMrEF60xRKlZdFxSH0rub8/3/y5XplXhBgtLxRI+uMd0hgCnzE6ouyBTzum87VSnHrdjYyMDzBDbjSFTEsfuxlmmUdFNEo3LHZ2419/+gF5IGpf7DQecCnR2uMCi5xeUdwqyOpLJJZWz3O8MfcS52RVTENDcbv4H3kKbs8BHihtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10381.eurprd04.prod.outlook.com (2603:10a6:150:1e1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 02:56:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 02:56:58 +0000
Date: Thu, 12 Feb 2026 10:58:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Dominik Haller <d.haller@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Gilles Talis <gilles.talis@gmail.com>, Joseph Guo <qijian.guo@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Teresa Remmet <t.remmet@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, upstream@lists.phytec.de
Subject: Re: [PATCH] board: Correct usage of fdtfile=CONFIG_DEFAULT_FDT_FILE
Message-ID: <aY1BYfCkBgHD4nen@shlinux89>
References: <20260211221135.1738981-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211221135.1738981-1-trini@konsulko.com>
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10381:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0e770f-4607-4e11-5c93-08de69e262f1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4QFhvoKluMpH+xO7orp0SYCE/wJInyuYIeab9hizMufAhCnMCMSItWdnbCMH?=
 =?us-ascii?Q?uhHxAvZi3uTj09Ivf4S9u/DBAB6w7BLEvcQV/l8L4zMLf5u/UzOIbvtkIEm/?=
 =?us-ascii?Q?3O5ZVxfNd9ssmGxn3545xmNuKVnHkpAti0ejZADupBTJrw2YwVz84nlvabgR?=
 =?us-ascii?Q?pLT/qfjsKXtmQADkzcO1gkhAYTvAzPjqrtJUzrNatBFpenmHcFdQcgE6V6xw?=
 =?us-ascii?Q?RUrNTk/tGnVGKJm5er/S1/Ob0GbPzrGgVft6AlzKuBs5wNQW3mZVC35CJ9xE?=
 =?us-ascii?Q?7zV4pIyLcQjhYGggtPuN01htTJpx4RJWSkHtBUue6wrziXpCiYTl8G3QGxwW?=
 =?us-ascii?Q?qgxmrmE/2gG6n2QlbT7tG4qyP7eS1qGV3u4SgwR0nwfbq9dUil6aTTEogy1Y?=
 =?us-ascii?Q?HNInPu9PVToooMq+yF8+c1tuJMWiIKLOh5LrK5PkHiq0WhKHfgA2crTXbCMW?=
 =?us-ascii?Q?GNsn6ynXPPIE0MmPXEdsDYFkqrg3vqCjQk5NRx4lZHa77ZHRptiqwGMEoYMv?=
 =?us-ascii?Q?3kmMKk4pgqFtuhATzqDpBN3MAcXH3bq0dUUK7QLC6nDntxrP1vns9D+YJqKK?=
 =?us-ascii?Q?xItEj+L93sd1oOQNxtWoUSyKvqgfUy0El4QDtOXsf8RUHvuzCOcwhMnDNLRb?=
 =?us-ascii?Q?MyDMhL83B6sXaeRgmaJeU0qar0LK/eVKcmIOfLUHlDD6z01fPAXSKKvDcki9?=
 =?us-ascii?Q?o2ogdNTg3OvCsYITvnEBDZ31Dq775RUspeZ6RyqM0Q0i/4a9cAAXr4S5Je9U?=
 =?us-ascii?Q?+9KI62B1uNYGuGCfDEA0uWvnNh7L9lq4nG19INiphlP65E4tp4RjlUqKPqyE?=
 =?us-ascii?Q?p2GSZtryNy88+J58scjoGlFgGexGzfpSSEB8Nz95+TsiUTj936LYkTkAsBTk?=
 =?us-ascii?Q?Cfw0eoyrUe53lI3fTsl07ysd44ZJGfrW+onEjAxaaXPLB/56CjFNtDzmLMHt?=
 =?us-ascii?Q?6L+xRL1FEseNteWGUr0JlMA/EHTjFhR+u84NYmyxgg00Mtb1fyeEjxokuwuz?=
 =?us-ascii?Q?53U3Db2QE7MQmofuU/rhMs2iBkArxiU2U/L2IEIJdLOFgt1E0awoDgyVDCRd?=
 =?us-ascii?Q?ga4ZtOx8LgZfZN1+f69LLEpvwxgsuqSRe4PpOfd8oeB6LGCaRA/1gluCLnBy?=
 =?us-ascii?Q?GxH3hu+5YQWRUEVH3zmqIlhJx+mN1wXaAM/lHrszVQ0S0jR0PDV2iv5yJv0q?=
 =?us-ascii?Q?pSq3ALPXm9+bhCSO88M25udQ7KB7R40fOZ74RKi7upqUBvfziq4TQ8XHDf+C?=
 =?us-ascii?Q?cALX2nseV6zv6pIc3BZjQynsWUr3zMCXUulMrnCR2oco8s9f69Bd5XjkkZPj?=
 =?us-ascii?Q?z1RvxafgflkqKqJqLHMJGfEd4ZC2h/KdV0lOGm2/Tw/YniPcoYJ90+Yca5NI?=
 =?us-ascii?Q?4Kd5sQoApq1xcuKA/GFzThwpYGRZzjuRqQTXf/m82CDqP2yaeunIEzfnVgk2?=
 =?us-ascii?Q?pcg1vZFJvVGOrIl6ZdtQTvz1zklrnnpur5hNeiFJSJ/ZEBsD3YdtQ6yj5Qi6?=
 =?us-ascii?Q?jL7/sQNv1PfX/Uz8BVk6hkz4D9MX8tL+S2Tbb8yDc/wyHbF/6XSgcts3Px/t?=
 =?us-ascii?Q?3z9rjvdgmtP41UvbkzqtY1CJMod2CrNHuL4/WrdVKr2xozq3nYPt1aYxEOKA?=
 =?us-ascii?Q?s15tub1/Dp20sLvc7U7FmFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odHAuqg1WCtMViS9G1YeabxxrkLvZ8SiWsXXmO/VX20SXZ/0Ux4hvrQZ21eF?=
 =?us-ascii?Q?aFMkX+62YewGu3fOdo+u0O8l8CGRlpQ68rHbsrSmQMaGkURyvlGZGJ7ISB+Z?=
 =?us-ascii?Q?oWcEIOAOaphv47Fa67kIFNiIsZtMoOfok7kIx0B5B7r/03gvCxiza/QIb4Bq?=
 =?us-ascii?Q?YyDIqTSjJf1IWGS9u/XD5PGYmrPo+5XiYbcO0R290x/bOPiEm7EjU8J+2wBs?=
 =?us-ascii?Q?iZnTZHbCCyMrg4lo0zedEnV3yDNCp0EeB6MyFH8X8bhACScnX5WUh1R3Z/fJ?=
 =?us-ascii?Q?ssK5+AV56qzyps78R096G2TIvqKIWK/h7veCze+pTxiIgsnT0j0jhLMg9isq?=
 =?us-ascii?Q?wGa2oBA1FMJWNmmYRcMn00Icfd9vD2brzZeQ5Tk5dVx4bdU3n34ryXvIZnk1?=
 =?us-ascii?Q?qmRwUu8WtD0IoSbaujRp6qc329P9db27d74+sdaJobHElSN/ZbLyxKbzEKjF?=
 =?us-ascii?Q?sISaGmXXWOLKcrvymwccDQpMe7nv7pSwWuWav0J6XvAJF14s5psGXaokcC3O?=
 =?us-ascii?Q?20pYIhOFSCjIsyw+yVH9CkXi7/RfAPCMSGXb3UL//yleY9OIz5ahCqJN26kj?=
 =?us-ascii?Q?7ddpcTqOnDsu4f9LlSxcVQSH0Ny8Z9dk5uV3zgNcUfBUvfeVx4o57kgMlW5f?=
 =?us-ascii?Q?Wz+0tJRNhLdmk303TOkSbloMcAIOV4DTzi0wA1M6p3+BusLp4APtvYl1E8IX?=
 =?us-ascii?Q?SFLv3h2G4768g4JQqgkKPOWhByWnlEBMHOiOJhnNDIbxxbLUxueqms7aVQr+?=
 =?us-ascii?Q?o2DiVPfE4e2AlA8bvsoEArpynD0G/o7R22j78fii1TQjAGVSUysqktCsmt20?=
 =?us-ascii?Q?AeX+2YkzbmNRW9aAYs1lpv3Wf5BuK9/tWVVz52OpIdRGKJiENT7JQ+iJjWYu?=
 =?us-ascii?Q?xqCJfllDpXlSQOrDJZl6eiwdF2Hv8XDP6Dy/74/D2KMfpX+Q7Iw/DPqI1rx2?=
 =?us-ascii?Q?fx0VF8Pe0cP+xgWwb5mC/d8x2DZm+U0hr+NGWqDkW+0GiAMOqs9Imj/Nj14/?=
 =?us-ascii?Q?sg2lM3pl4sBe8b4X2qfVuEuTo6bOJ4AAxCM5bCW/TDdwl9Nu+do4MfiW8PcN?=
 =?us-ascii?Q?x9Pc1Ox4HKi2nCN+V274VDoJg1QNc5sjpzH3BjbM4ew50YV1Pa7AQcVsVLWM?=
 =?us-ascii?Q?pUgYz+5H3bhtoJMVEbF45PkDKUfecSMNay8MPBTgOsuIoOf9ebEGfSjNXfv8?=
 =?us-ascii?Q?y0EckSqfZ4Ey6SZMyOT5i5zWmKzoXKQr3nli0Ely3oMhZZsxowvJyvL+d1E2?=
 =?us-ascii?Q?OQ1cQiROxk3SHSHR2g6hd5egrm/RY/v82fzhM2l0fHWa6OXr9RA/qzqO57+s?=
 =?us-ascii?Q?vnlI0dxMIaQ4C3/s0VTyUa5aAwxxEnM8jn+3UwuoUv7asNu6DP644rFBBL5w?=
 =?us-ascii?Q?yN/DX1VJ2CLKwzGlVDvKnT+WEjrdOqJApapgblLNy2Di1ofsv6IWUiXrR3Lg?=
 =?us-ascii?Q?QreK4bfhvDEdvCODPe+8h8d2ORScKWf8pkQ5Korm7KotJ6cRDd7i9zuO6wLX?=
 =?us-ascii?Q?dyqeelvEJAOGVtzNX1bQwHRRPfmmopcRa4wU2cWQVVvs2UL0IhWoMTUWmf+f?=
 =?us-ascii?Q?4W/Rihme/AaFTgoJB+/xa027Pz4mUerclhc/uhcm/uHVY/v9Q6var1+yNioK?=
 =?us-ascii?Q?Yy4D3f2vXir91nTgyLhjYAiyFoGaTSuCwckAEPiH/VgxTU6dbGyzQY4jIden?=
 =?us-ascii?Q?fgm501L05CPiDOzqwXl3N6znq7G5Wlv/9XFKMPk7NYYDamfHFX4p1bBjTHfO?=
 =?us-ascii?Q?RRps66Xdew=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e770f-4607-4e11-5c93-08de69e262f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 02:56:58.1878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uop4d0MG8AazV0V/cSNxB+hFfo8lkZo3XmX26raWCHB/HLf6mUxgYzG+5S2Es+MnUY1OP+vYV6+/mcw3Vd90Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10381
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

On Wed, Feb 11, 2026 at 04:11:35PM -0600, Tom Rini wrote:
>As explained in commit 03d2d5fc003f ("board: sifive: unmatched: set
>fdtfile with unquoted variable.") using the syntax of
>'fdtfile=CONFIG_DEFAULT_FDT_FILE' in the plain text environment files
>will lead to extraneous and problematic "s in the output. This is fixed
>by using fdtfile=DEFAULT_FDT_FILE which was introduced recently.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>
>---
> board/nxp/imx8mm_evk/imx8mm_evk.env                  | 2 +-
> board/nxp/imx8mn_evk/imx8mn_evk.env                  | 2 +-
> board/nxp/imx8mp_evk/imx8mp_evk.env                  | 2 +-
> board/nxp/imx8mq_evk/imx8mq_evk.env                  | 2 +-
> board/nxp/imx8ulp_evk/imx8ulp_evk.env                | 2 +-
> board/nxp/imx91_evk/imx91_evk.env                    | 2 +-
> board/nxp/imx91_frdm/imx91_frdm.env                  | 2 +-
> board/nxp/imx93_evk/imx93_evk.env                    | 2 +-
> board/nxp/imx93_frdm/imx93_frdm.env                  | 2 +-
> board/nxp/imx93_qsb/imx93_qsb.env                    | 2 +-
> board/nxp/imx94_evk/imx94_evk.env                    | 2 +-
> board/nxp/imx95_evk/imx95_evk.env                    | 2 +-

For nxp boards:

Acked-by: Peng Fan <peng.fan@nxp.com>
