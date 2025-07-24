Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A6DC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97D983622;
	Thu, 24 Jul 2025 04:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WDv7pOzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D6B835FE; Thu, 24 Jul 2025 04:29:11 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2516783666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xefan/lCf+fI8EF08Sq514SsGH+BxnBsKrU5IoiQFPRERqa7ooDo85ZErB1GkCTTMPWrdgGUN/2xMl0PTkY04ohOGqVYB/XMq0REgFqlXqmGZi/RLrYPBCL75O9W84BAXCpU534MviqAGIUr+GWU1xBYgJ2V+1FI6jCdifGXA+291XajG6UScPSN5OLvYQIdRLJHKdiezkSyvb/TwEiu4fr0iLbcUtEif+yhR5T/PikLt1C4GkEhAU8UmOZbdrzjplagrQpA/Ea08siLXu5eaCitA7z7FJ+T9S7gFfGNBhkQpgyCbFAm7YauPRFS87F7yDvtG/+VLnMmTDd/Lk5Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYlAll+3otWO0ktxEO4Lb66cylPENZCMvr/1MPk5nTY=;
 b=pU45vO6p4y9aIgqx3lulKgZ8TuT4Mq9q+gDBYfVcK+0TCh3m6Tf6iFzLfdiuI68m7vgYF6Tr96/pJSsnNXYkazZkOPe+vjS71GWm3FC2YEpsNBHATNx/EFf91Z33kr2abjjI48b5l1YEbQ4JLiBf9zbCIkHwstSrAux2HYCMop0cRnRQ3yUnLGUVJtPLG/zeeRgYTQ2SLiZy3al2ZuL6KU4bqpD+kFOLY5JtpkCX7qjb/Qlt/elcO5GCVaAho3wfxIWakljmku8sWw/W4gbCFjJO/8Ay0rtFU6j+f1+1Xaf5DRH11fz9e1ERAJQrVgLiRJIQeFWlvB9TFFIjPkFokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYlAll+3otWO0ktxEO4Lb66cylPENZCMvr/1MPk5nTY=;
 b=WDv7pOzdDZcjhWMEM91vsgcU++Q7N0GAA7/Sv417TVaUQAU3/BSrbduinMwmrNySsdtc4qnVB6t9sA/nTNZZltFxXXK5xTjBoXfvZfhk5gG3CuI3THBl3F4IRzJcT+i2iKqldw1MU+zi8Cp3to99yo1ozjLC9/KND/7FOGW9es+HcL1u1dbzFWMZ+SfDC+7c+WZX1+gCRRFn9quxJf8azgZiuje91qpk7MONz3LVvfN3qK8pFpk/i4BXsIEgKC6QjWhVohtTX+XRY4Wsr9rIukicc132isMkRkgFAufpUUTEbplrgWtnkEW/Ns57zLjBXgV08z0b8xrkabGJb9YF2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10450.eurprd04.prod.outlook.com (2603:10a6:150:1e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 02:29:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:29:04 +0000
Date: Thu, 24 Jul 2025 11:39:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Fabio Estevam <festevam@denx.de>, Greg Malysa <malysagreg@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2 1/2] imx6dl-sielaff: Convert to OF_UPSTREAM
Message-ID: <20250724033935.GF18395@nxa18884-linux.ap.freescale.net>
References: <20250722103915.105561-1-frieder@fris.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722103915.105561-1-frieder@fris.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::36) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10450:EE_
X-MS-Office365-Filtering-Correlation-Id: aebd4e42-8280-4bc0-98a5-08ddca59db9d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1EfkS0Jip+on14gQT8tKA9wG3ePAnNZfl4jTU6HUBLjy2wcP+f9aGvXzOuOj?=
 =?us-ascii?Q?MYBRobFs1qpP5VaYC3XgzCmktV2nJ6fMTQqdV6d9Tx4mEsbw+s1w7JBP1l79?=
 =?us-ascii?Q?JzD2BtogAxCyzsbzLGpA/YwZRwzz0yj9vxtWxLvVeBKlTC00pdSxTTi8c2xq?=
 =?us-ascii?Q?HLvNslOIvPEbzvJYfQ7bs7fufNTzZCS7yo33XHJ98SOYhJ+i7L2ORkPRw3Z/?=
 =?us-ascii?Q?cL/oL5Khtwtpc9SCxWDadkaZr9q7Z2XdhuNsXjuNXMPlvQsljvZx9cPoDtdl?=
 =?us-ascii?Q?JJikzinFGFS6bpcCk07O5NKqj3QxMFZ1NMWwqUSpNsYSeM2uFyQjYoPKzG+q?=
 =?us-ascii?Q?TlMGuTu3y2ZOYa9RiWxKM+YWGvK/iFcAgWihQoFTeAE7xZ8axEfmrf9OK8lm?=
 =?us-ascii?Q?Uvct9xELhKSBL1e1JXMuVzuu9fcA5qo5eaER83XkUUapP4hBXrXO0/Wmw/C7?=
 =?us-ascii?Q?+t+2GXNVWUVH+WVjnGhztAi50gG2e4mSlKUQhThBRQ/IDWgUGs0jqtqaR2Jw?=
 =?us-ascii?Q?MMQEJfaCyermg9So4ILlhinnwggwnVCeGrQJT01NeZFAS6XOSfKf6LTnPxjU?=
 =?us-ascii?Q?MHJm8M3DgecQMkX+quMZD+k+x3haBD7xhv2ES+mo2aB0EvD4qo91aXI7bTxn?=
 =?us-ascii?Q?Nk5xpq9FzDOfU+FSny1UR5jP7pRsXW5+LFVlzngJyYMVcSLLOvdML3peavbX?=
 =?us-ascii?Q?B1lsQ6Mv9Y0Bmu/5RQ8XwIgsyF0CiSW3ZYGilkBybJ+MQoMqquyFCDyltUvB?=
 =?us-ascii?Q?hYhFz0RcdiEaJVy1goDIRPYglS3RCOnoJGbh7DDUbP/WV/X1AqGLBQnxxOB1?=
 =?us-ascii?Q?YpUIYv6TkoB9nrczpPZnIVo32tHJ1xsFRRVeBaV45jn9zNEd13SKNYAG3Cjf?=
 =?us-ascii?Q?zBsPXXNEYrhbETLQ+58ahwgssXeX53Q+OT0KGxjHk3RnjSHGRH6kkTVVsvdS?=
 =?us-ascii?Q?/3VQsqka5pNNIUjfRsbVX+whsVD362XPsalI7gq6Xtul+sE4h3bO/W+hag9W?=
 =?us-ascii?Q?clJoxYstoBGgA7il0DUjmGVSW+7sG+Z4V0+D4jgMRqdfn7x9Ss9ME4DEmjmu?=
 =?us-ascii?Q?2iSlhGEfiAYEd07BoZBB7KBrWkigIbpB/qzvSHFcL1RSqxdsPlWy7N7201CK?=
 =?us-ascii?Q?kD3Cd/cr1GrumS6e1wtci2JzNgx6JVO4kTERzaCHPGhjt6LzvNpj4WerutxD?=
 =?us-ascii?Q?ZlS48iLJIqnwSkj+Y2h9M0CeVhCCGcGs8LACSx4vGKsyUV54GIBWHYJGxno/?=
 =?us-ascii?Q?nJzVQI+WSxyiphXVnClsVgy4JyumwSLKfVx8lD59bisThJV0yg3QPChgtU7D?=
 =?us-ascii?Q?lRsjca2aWiRavqz98gs+okSm0LQc/omHtVnPa/PLAsbt3FBMaSH0HYGJeiIA?=
 =?us-ascii?Q?zHHalvkPVTEA5hecPJyvpgn32rW9kc82HvapPQ7pADVLMvszDVVx5iyYDI1S?=
 =?us-ascii?Q?SDXJLxZYLstS0tJmjypyYJrIWRRW7HpMqFp2IyVDKxMiG+/EQKhH4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UNWfe2sTjlJRxtGeCdqWSDuTEFP6xY6af/GTZv9lo0/Cv21Pr9ATCYjf3iBE?=
 =?us-ascii?Q?jpDa82RK9nu0LxbgJw4doHgl3ij101Yg4txexXWD5rOLdshfNA8CTVB3O3XW?=
 =?us-ascii?Q?AZ1OA4XMSnj8kXS8rH973Mo03c9DExqPevTMmieC6lqXXW5a+uHTurYjfVFo?=
 =?us-ascii?Q?6aqmpR4Q9DtZhBwFjKpDA5/ax453NYMm+RSmoyLKUpGYAyjQnprWA0PwCKS7?=
 =?us-ascii?Q?zi56G8zZJJRaanKpm1JCKCjtLqVJ/MnohRnAEV692/Y9N+BQ3FcPB9YqKVsv?=
 =?us-ascii?Q?/Kp9zeqH9yuje3ylxDjakS7IHRYXb/K4xxR/G7Msx8R+EKbkc0A/13WcOpJT?=
 =?us-ascii?Q?Fc+dA5pFRx7yc/9ZbLD3HRGfyDWCJvWIE0HIhDzJ27OiPXHYeXQPNrin+tMi?=
 =?us-ascii?Q?tJ57iAC3ePN8TANTUQLD5cO7W5nzEnaUC6ra1lDTZAGMDV9gs54sE4YajtT7?=
 =?us-ascii?Q?besHZ3mYgqe4BIK2MTFX8YnDS6prQfAsGudogg3a3Asht3oJCqxQjjZXJsPG?=
 =?us-ascii?Q?N+09887or7t0ZIyoGPfdrGurVYqAkYIQtNfIOjHEa3jKzJ5s6SU4jzdxnKsD?=
 =?us-ascii?Q?VXCkUUy6spZZbJ5F46rEHUaffHScHs89+R1x8oICZZkcez5uTf0ed+PSYEJH?=
 =?us-ascii?Q?8BIvhsAW6DEi1//9arFl7+FxCDvfZsDShbs3U+lIxuJHqKXNxLlVECpJdrca?=
 =?us-ascii?Q?7cHuJp8pzynpRtqQ8JMu6k6Yh5PTNqoZiDmgZ3lFIHE3EiL1Pu1gzBSUJtRk?=
 =?us-ascii?Q?Gija9JFJrKDG8rP/mcrjE5VvW83og5Jo5TWj3rQ0d6b5JkDfL/0/+vuxO/3e?=
 =?us-ascii?Q?rUaDRLJNMe4RQORw0JmyqwWebgDmGY34ANOAEzS29bNHYQPjDNDkFHoumBzZ?=
 =?us-ascii?Q?J9QCzQBwazxFm2Cw41fD4J7bs4BuHRmzT1ebHAe8wwxAprp7DtgmFwwgOjYy?=
 =?us-ascii?Q?CAokOlSiqc70oCtaNTH5R4Oyaf/HjIMRvHtfLREjmX6vm/Z3K4y5wYFkETDi?=
 =?us-ascii?Q?Gvwyo/JJ8XqeIb65BtuqxGos1f46X4haMzPLScj76nr0PENStpjGtOkJkq56?=
 =?us-ascii?Q?5Bs/VkxASvqB/hj52Y6Nq2cRUQARbsgR+nOpR3cUfZsNCc4CapSPqwVeWsJj?=
 =?us-ascii?Q?lqNJiSueXUhlcjbGQZohjAoF/xxRlDsJ2906h3gAC8fKOYJqA0Q/McGiXF0Q?=
 =?us-ascii?Q?nLZoVMgav7k0vLZfWD3Rsh5NscvO8z0x8pmHGh6NMgAk0SQv8AECZXPQVR+g?=
 =?us-ascii?Q?M7NOCoXn3STJRvCjg18hbMjnm24ekK/SaQoGHREXvKYu34NSOkYIZuXfZgXQ?=
 =?us-ascii?Q?TOu215dxLFot+bjWSej0U8iWaecUV8GdLEolH4rCn0y6kEr3BnR7uEtRKdRK?=
 =?us-ascii?Q?i8668A0O73+PgHeSM+BocCUeKgaE8gzACeVmnWscWSZAUkRZwYKW5R0T8xe0?=
 =?us-ascii?Q?KPJGzNWLHiKjCsQ3b1q7Ndqj7DaTq3UDd2ITjP871/ER555pOJmEGxHpvWRc?=
 =?us-ascii?Q?xCvEyCCw6mNu0D7/WMOr/bZ2DBU6Tby+Gvhdl5SN88LrtgbnIBLivHSh2eWx?=
 =?us-ascii?Q?GZrTONrRlQbRNXMPIQi4LkqKvsZPKjcBeN3I1CKH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebd4e42-8280-4bc0-98a5-08ddca59db9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:29:04.3847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2yi9vbnAXRYXiXRVRBqItH4XvIZO3aWWLJza6emLMeT4iTiOqWVoXt1VM72TIqXgejaXA/6L/KyTsXyoDG1QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10450
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

On Tue, Jul 22, 2025 at 12:39:10PM +0200, Frieder Schrempf wrote:
>From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>Switch to OF_UPSTREAM to make use of the upstream devicetree.
>
>Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
