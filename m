Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4BACD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 04:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73AF80433;
	Thu, 11 Jun 2026 06:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YG+rzste";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF073839A8; Thu, 11 Jun 2026 06:10:14 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7C580086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktX5LWwxuO1QDfOWC9RCDPbMEKKgLNUHBOVlE7Ow3aJLRlmf2cgqnCavyY2gc3ARSmwQxkAJ+kPpUFJiPHDnuDYortktEcFF5jqpfthv0cVG2TT7SDQdc+UeGLNhxVHHeibkty8jWhSGTR49VyhyaoI8t36290wTYpUAp+FDH1yk1c0gqAtKs8gaDAbA/wmS+ODrm/PLKYrfZsfxSeAdDl4dGm+/6VHwlJulIb8E9nLjkgplNXo41RjUDubcRAtNZ7TXIxDN8A78/3W5JGX6UXoKu+pw4YkTH052j9sGHTE50MKrs7iT368ESNIxZRxg5mbkdloK2BKQe1eE7aAROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hZcFnp6td9+J8zpJknQL28bj2IG2eAFp98KvVqVtXo=;
 b=VVLs5RoidOHm8NA2dHAfBuNAriivHVyu20lbZgM6Bmu5wzFJyzyBtkkKl+fbKXAoKkVgHfqNOJmUTMk+wRLnjp7d6lzkXw1TE6CtihsOJcUZDHj7uhEp0xLOVnHI3xQ1embB/5kAUTFLiGYG6rO5BhCrQJCwAKEvFX7QT6pzcz5zYLBs3TsnBO7PMVxCxYetHJiY/wsExu18FRzJLvb/CD8eZlBRuVdCx2zwHHBHvGSDvA0xik4yZNbFhFfVXR1FcKnApMrIDbXGXbrhjrnXra6oBXz56xAYGGHef+v5e93uv0NxP0S5lv+Q9xL9xXENUVs+K/tfb4cIkIpb4pQfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hZcFnp6td9+J8zpJknQL28bj2IG2eAFp98KvVqVtXo=;
 b=YG+rzste2iovEnlHkscrfvMAio1aYZYECWEfuS5biZC8FXQybn0F47uSp0KtKCiAS/OE7lNbTwe5TJUjIvruoBJEQKp/djfMmAYvDu0+/LlsZj2t97FbcQzpTEbCTgQ/9Siae2ZC2S/9tCTp/l+k5riiguZU8+xt3S0E3ri3yH2KTGJGx6Glwk6iSCqxWBnXhwkIQywMOBSlj0wijO+8QY/X/IY1KyAleXOOwrN5WhdbaJT/HtnmPM5RtDSG+SK0awJcBoaxZCA11vXJc9bqZSnjG4j1ZrQFukddVMh+OlsTzRMfUE/brpfnRavD+Klukl0B704yNkwhe1RJjvc5dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 04:10:10 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 04:10:09 +0000
Date: Thu, 11 Jun 2026 12:13:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Krzysztof =?utf-8?Q?Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Subject: Re: [PATCH v2 0/2] imx93: Add support for OPTEE
Message-ID: <aio14JOnz0Tpe103@shlinux89>
References: <20260610-mathieu-optee-fix-v2-0-197aee94b7ad@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-mathieu-optee-fix-v2-0-197aee94b7ad@bootlin.com>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: d870a553-235d-4010-6267-08dec76f53f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|19092799006|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mO5xmigXudyRFNIRbIsc37INdCiIg1Iw+rtM/NKFXPpXuexUcXwlaeRlWtuhXJso/ZJTwG9t8wFT1SJCX2jdpbqxBYPnzkee0qZQobPisy/xJLyCSrbg00iEN43cTOnuUrBsMNwRO9wrHX92Hllb7LI1fPffZ8QjP8AtyCr/Vtb1CvMYhyBzHRd01coBcyHu5dK9SHtmQYTdqsAXAnZXdE2hvPhCb5ApLK8I9YqgYz49+XMZ2KJ6AZ35GdarPc3x9qCUldp7zXv6piACwpAy2T99ikBL7iW99yJhDeWT1MaTrcPCX8hHDCXOEilOFc0+r27WXctPj8x5cxg6UUD1I/k9RoDOcnQddpGWuulfOxKM0YN7fgy3E84j/OCvz7wMOOXfrZmBsl9UiF+mJD4CR5r1Bcel0TvT/ldbIOgJFqx5ldFgaGgfrtJnx4B7UPpM3di4EmYxoY2Z4BwY2CMt24OPHMY+UiB11RqfpGFowAyA38RZmAEI7XFlMwF+ICx0D2/DCmKslZRydKzzmYNxUpBKHKd64l8JB0vO6w1qj1/098H+y+weUo1T9CC1e1vys/Ly+n5TT6geBAX473Wnr4yhu+CLJ5PXdcLcNxCeimg534uRGT8nmTbYgRVpdFC0oM7d5TBSF8Bambc2MjyoCFmeLNe7GRy8jcnBp87C1SMDcURr0pImPm5Dap0QOH6trO5QBtW6It5ispjVYr4tJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(19092799006)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89mKnVaCZF5T0YScYmoQgB0D57zovUNIurwqAaVHkptKtM/ooBtTnVfFMvX4?=
 =?us-ascii?Q?BL4REwR2SwhZqiFK7zdQ678P/XEP30uvCDQgF5loNNg8kaS6NFkuW38Uhqin?=
 =?us-ascii?Q?Jp0Y4/Fh47zjown/G2JKTWl7xx1Nyxcr7bX8RH6DnP1FfSHhJhpJYg9ihsUF?=
 =?us-ascii?Q?4nxnQnNqg1L6cU82xUiFz+v5yhC3WQoAGJPJWocnBsSp/YjC0S3NPbHIOZi0?=
 =?us-ascii?Q?HS+3D3k6i8MBWieYN9pUZNgvdv7Ev+eoBMu5OVBllz4f0SCmKjmQFlhgajo/?=
 =?us-ascii?Q?F/Cv77eM7JCt9WCtXWsuRViMXEjTWTAWg5/WQbdLhWH+N/JbecLsqwutRcCy?=
 =?us-ascii?Q?pLVzkG4joxdJk6dSXPizwGxcgfOZwguOShR8n15Vp3XuBO3nRkffo856ZHXt?=
 =?us-ascii?Q?AhwdGSwp+Nc/948U7qZPGVe11MFBgYCDB2zX7nni6ESGqK0Ztfg3KGxfKs4/?=
 =?us-ascii?Q?COfVL98Lddd2JW6MFqrLNEr6/9gpkO/3ZI2VY1vImIqCo3cJQzx6xNvomFXv?=
 =?us-ascii?Q?SNfFj8fJxJsIpvnHCrhNt/2hb9u0WYQo47KteOqzU4MTVdxJFQj+9E8g3O9l?=
 =?us-ascii?Q?cdVePaLQEh6ANf6LKc9xPv45lKFVm05o+a/1qMG/vhDPx1TbHrpCr8YOJnOU?=
 =?us-ascii?Q?rm7ySw9EDuT1VFGTpe1DYU9yPD1iu0xFiRSckZFEE+ibHNB+T9bf8FC50xCi?=
 =?us-ascii?Q?GkWDRsrEmlkmw/8jlJqm4QKBCKXgaHbDFBqwBP3F1vZRH12y3nh8VNxPUaTi?=
 =?us-ascii?Q?/2CGm0svqfEDGx+XaklSyMtOk3SE84bu+aDfzRXM0cLiAqCpV3zj7W2m4Czy?=
 =?us-ascii?Q?Lbfgtx1LZ1m0mYLTKFbwRagvIdPocT4ZBi/JSJhFCe+sJRJmduVQ/Mgcw+pW?=
 =?us-ascii?Q?x/QHFHzv3O5PDrClbz96dE/5zI57jxYL2w4Y4qBjHHevGiHbUPeltxRvpgOe?=
 =?us-ascii?Q?LI46FA/Gt1n4mRc3JrGPoIh2hQMRqKZYMDT+rOOLJcKjMSUDOqb3L9OcUrbp?=
 =?us-ascii?Q?Ai02U+d/lottsmZ+OfglJifaYxrmPoQW7zxJWIa3xdthJ1TrkHd3IJf1Ijzz?=
 =?us-ascii?Q?T4ZsKwddmOFIgOd0wzV6Zar8AuNl9YSjiN4AQuO3ldbYp3couCE+KW3O+5Ka?=
 =?us-ascii?Q?MMYVfL2F4JJmxJlOqFlLlYvW96DkIuJa5KQf8Vqy7H3FL/9+wQV3hnVifybV?=
 =?us-ascii?Q?nAytJQIQxi7lsDWEahOBkIN2EwaZlgEYGI4LAz3Bzth2DlyDkjXkT4yBjhFS?=
 =?us-ascii?Q?IJrKGUlFoBDUgZV8rwMdqdI/dcsdSc6LxQzmNyX0oOY/tlHcXSedFvB37HkI?=
 =?us-ascii?Q?YOX6srMjhH2CLOXHFKeD2GL/gJn9SAf5ndD+ncUtJt5JNg9+NcfA4d39xLMJ?=
 =?us-ascii?Q?RVXCf7x7ZvtvLU2x6ASQWJVZu0DQ7EN00UcwBr69xRUU4b2pK+1oqyK72L3A?=
 =?us-ascii?Q?VdJeh6mZbAD5eZ3VTbk8gFCxeuPxFXn7EfYcPFltoeb9mQypWV9jlR50136g?=
 =?us-ascii?Q?VZ2WID1DJCjb2n2+M1Y0oNPbTSz48Ke7F8U8wI4bDKjMqkDS/H2jIAGmoVLS?=
 =?us-ascii?Q?AuCnFRO2YB/+s8N05dwyRt3Fc7EmOtXzg0dkE3P1FcXErsaVipon7dXrkX4P?=
 =?us-ascii?Q?5opbXRxu8KTDAYCn7Y25jyu2FjEQE5wnpLfXI/ncCYZIjZbu3nOg2lNwx6Br?=
 =?us-ascii?Q?3d6ZgJLwqNV4JGzxPZxBTE86tsoJmshp/gAjhZzsJKu2IEcziqnJRxyOAlAw?=
 =?us-ascii?Q?8cIH6kIukuMsPDScEOacY/YDpderJM1u7FjDNxU1mOGoeC48QgYo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d870a553-235d-4010-6267-08dec76f53f8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 04:10:09.9049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkbcqIx0aWTKE01jUDc0om0D4a+M3Q6JvE4BWopppQiCEpdMRctpA9ZDp1/D16JWdmpmDa83GodhlkY+1HUqT2Y0Mcj17wTflIHx/jVharIAijFGJfVu0ddaxlg6DtYt
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

On Wed, Jun 10, 2026 at 04:17:08PM +0200, Mathieu Dubois-Briand wrote:
>Changes in v2:
>- Fixing build when the optee image is not present
>- Link to v1: https://lore.kernel.org/all/20260414155928.1391211-1-krzysztof@kd-solutions.pl/
>
>Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
