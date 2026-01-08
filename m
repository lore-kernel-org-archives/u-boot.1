Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D17D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F75B8422D;
	Thu,  8 Jan 2026 14:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="avX1nORY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F08D84119; Thu,  8 Jan 2026 13:51:36 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF5883B8A
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 13:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5LY4Wruueff7JmqHsuGWO0uzFGeq2JF0KBCpzBpE5G4GzK1txhqge5sSqnDusfMSGbGno4c71sLwIcJ2jW0CdATsFooG6z+SiyT4U0RZINNaoeSLRcD7IQhMUZoFS9RwHP9HPcddYezINAG1c2vDzLK7oi1SRgkY+JZr/WjcwUAXtHTBginvnM725BIaeRaMNTPm29FGJhM0rkyr/r+vmjqAYCEKPWhXTeXYRb7KzVZhyalT/WhfLA8iFwtRzMyAoIy92WID+NpWneqpSdbO5tEgWZyno7s+z6tgEVnY1uOJFqnWx6fewzaOhXfuJznReQiDtYRwSKfWek0fwps1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io3tMfj19TuP+alElKBLZ42BZAkL1y6sqKlx1/pAUJA=;
 b=VSDD7ND08dmXJGXpG76NoW13xic4fJia3LsmhLyBKtC2SlRqYfh2HIttDLJ9MIp/mab2+K3fkglU8tfBycODXSrs6xIfjuD0X3sEHf6fFA4bvFXxEK1cMYzBi5g/RfKYrVGu4bTRZfbR1TGpNX8s26ZvV1wPdUhTB8S+75nqlsQyCNcHKk1sZeNehONbnspDLfQ/KRQW+kZMw0rVr5kf0NGNRI4khbiziv4lpNIIPAemMmgcyn2NsWoVPLbaoAjhV0mkq5RrVwSpAX4fDgt5RY4JazJC9BNoHUKQnQhB2cTD5A7sUrr/w1FwlD2vSwdmk3kMOkGGjfw26hTz2HvI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io3tMfj19TuP+alElKBLZ42BZAkL1y6sqKlx1/pAUJA=;
 b=avX1nORYrgJlqBbllqqG0YFoBepSo1sWOnCjW1YqI+RvCAD1qxzuWB7UvedbGhUcIrXzIENTJMi8M03eNJFqjPVvuHIqJGQOZGb/5W9R/F8+ZVt30mIp52dIZRhBm8KBT+w9VVS+YjTnQbYOY6E6S3EPN/ykz+4LMOeqw+b3iVksJ3XX/3HDO+UbiKEaapbTG2fLQggUGhgNDTROf5NS0pSf8+IVLH5kXPXcNpZszqXytakBqGqjkV5TnoSZ3PF4DnwHQBR31cX/khFY8lx3twFlNbgecSRLi+3WkdTvyl5cM84PPKfjRwdj6fGCn2/Yay/L9tNHDY3PgbUgc9LHyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI2PR04MB10146.eurprd04.prod.outlook.com (2603:10a6:800:229::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 12:51:29 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 12:51:29 +0000
Date: Thu, 8 Jan 2026 22:05:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: mmc_spi: Select CRC16 if CRC checking is enabled
Message-ID: <aV-5riVvdJFJEQG2@nxa18884-linux.ap.freescale.net>
References: <20251227105946.332061-1-daniel@thingy.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227105946.332061-1-daniel@thingy.jp>
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI2PR04MB10146:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c742f5f-9336-44df-2cca-08de4eb4a401
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qvep9mXTsfZCXoP7vsJHIWk5DBvDBd/sEqj5MZ/cX9d6BYYm5ELrBpa5f3r0?=
 =?us-ascii?Q?fvXXcFYEmou/HO1aVCIGFSLM0H889deuHC/8fOx9Otb0OpUmRzd4/jrQQF+z?=
 =?us-ascii?Q?97PSFwZ2IwzZEUnoir2hqFDeeQWy3F0IeQ3OUXXZaNsavMKZ6qaBorIhR3Ty?=
 =?us-ascii?Q?CJs2dzUKPqkE6QHZQWTa1wu3ro8JUTmMhRofgBExyGFVd6uhHjut3pipn4jA?=
 =?us-ascii?Q?ZW6ahiCo9+0cqJjrAFnRLapf63pQU00VEhP/H072axy1jLg25Coov565lV3z?=
 =?us-ascii?Q?w8ldCcA9aC6E+YoSt3ed2wSEeVqTzxWtKmR8lbyGsJpMYsPn/szsEGoXOYrW?=
 =?us-ascii?Q?PwzqX4kHs0wg3GWJxbbKhvZdlrFhgyEHAiywwrQQB+f80LhcSzv7Gh6awyk+?=
 =?us-ascii?Q?8UYqvu0F8Rax/Ss2EbdU3BU1ZfmTbLYY79ogq1D5wq3f465uypDBHW0cUpGg?=
 =?us-ascii?Q?G2boRBwYgYEsEMWcJyGtapb8Zafun7Fb8Su68Ix1N1ItMqJ/AuYO7OuWC4D6?=
 =?us-ascii?Q?BnbpSCb46OpkpaUuHcG2WVpvLD4dLpxTDWJQ9FVTi5YPkAhj9jGPDz2BlutC?=
 =?us-ascii?Q?FmmsHHAkceJRO+YnnNcC4R4M4ZrV2idFK731AlNhfyNf/fLhryLEk0CYR+c+?=
 =?us-ascii?Q?xksE+z63z2L+2wWvibNRwEdVx5Ut4jh7BdPD1HGGFABnIcCb7DdNatnG2Pbs?=
 =?us-ascii?Q?yYAgDQuCuiySn6MH+5jsPCLCUIKPYkYjwFOFsU2khMZmt+vS28TzQ6e3114G?=
 =?us-ascii?Q?vHqVmJVshOq/kASXjFHs0/Q/AJtBpq3X+RJdyOFFG0us1rykKXO7zFISbZUp?=
 =?us-ascii?Q?Y/Yw0ju4LHgRuDlctVvN7Xoc9DQwLSuq2ORGTNwEPN89PKLR/dfxWtBGYFJ4?=
 =?us-ascii?Q?RBbOuaa5p3evdkOy6cJBCzWw5y3biThsfHCeCk7bvvYQwoiaodojxIXz3Sfs?=
 =?us-ascii?Q?FtzxO2LEKxvJaG/BaH/KkXdr7uNJuI2j3qT+R1yFfGdjXC3hcrLGuDzRI75P?=
 =?us-ascii?Q?YtyKkOho0Kbg9HAFOYyNyly6awSf45sdUFeL6x1DyeHtECFy0lM1pBaWvD/J?=
 =?us-ascii?Q?eQXJqP/QHM2FZOeVCzFkDvySqBFqQXs51LkfDZRSpMQycLC5yZMCSNmMnM8G?=
 =?us-ascii?Q?H92t1ZPTEoNvdh6uH8zkq5nMgDyOv2lQY+93rNDavg4gg5tIAaBbT2rgSLxa?=
 =?us-ascii?Q?/p1EgJShO1QaSCujUDKawCKC9wiRuEUMSKKqz+kyTiAjnrIR6oE/BzzPVddM?=
 =?us-ascii?Q?ETa34Eosn+6Ja23EonGesG8tMr1DE99rKNDvnV22RHn5CpphMhc9XeSATBez?=
 =?us-ascii?Q?9RVV+NBsnGkbfQVaa2fk0RZ5IlcbcfjKj7kxRuJwccy/ZiuBwMroD/HWJB/O?=
 =?us-ascii?Q?yaClLSRZ+tmVMW7i4NV3fYLx2CFYPpZXflJPKr9aj+dNt2BBFJNz9VylwFT+?=
 =?us-ascii?Q?OrrMGoXq+ijatDJ5Skz43I9+77CpP6jHUf+dAAQE7iVj7eWl7F4wicckKRor?=
 =?us-ascii?Q?CUEUYbRVjo7RuGMd5uYyCnFrvEgiHvx5Fx8f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZIH9uhSzyh3IPYRM8lAfD+mnUmmrvm1t2+0R5aa6aLQDzH8O4ZJxMEVnrda?=
 =?us-ascii?Q?1iAkKz11jzxR6sGDmobRqBUhRIjGe3EMsU463GRpp5FXjg6Y/+Qn/+PmKJ4+?=
 =?us-ascii?Q?hGCBj1vdjflY3bidRq4KktrV33AkdXdUb3uedFI2yXJ9NPieZtGR3t5SmTyY?=
 =?us-ascii?Q?yKryVjB6bQXu8Y0dosQIIZpE4mhwd3l4S1mbXqM/oBaQO+jJ3dlM5gzgShKg?=
 =?us-ascii?Q?QpYHm4ugVAn4iKPekxsIHRvOIiCjade3WBy3mdxkrZmhveIsqsJpmAtm8ZGY?=
 =?us-ascii?Q?/eb5weiaHEH0QmbkBxUFRVTYMBffLreoBZ5K9QI/PhPZyzDEpo+hnAWBBwhC?=
 =?us-ascii?Q?nSHPbpKgpEyzC0qA0RGMtdcoGBKxKpYyA8r4Whr0SxD1CUV2D8PU/3PgRqzs?=
 =?us-ascii?Q?6+OTHtASoWnfqGl8y4Mw7DkZbXQUeRKMqpHRlKMmsLsal8QqE1Jx//EJ34B2?=
 =?us-ascii?Q?TT3hBWeb0XS2RqowPxl3CQ69J1NETsrqKG+4YuF84xAdN3cUrJCXDvyvWk5Y?=
 =?us-ascii?Q?mRiF8zp3F2ElOPWL586rgb9HsVDx/VDYbyCPI62FomqFmpKaownAeOBd7dbI?=
 =?us-ascii?Q?IJJFdeP/hvH8ylWgKft9wjOmEhsiMWoFcEiuZjrQKK17GFNXeWUcpS4qKbVo?=
 =?us-ascii?Q?My2LAggJjlTy3Vktq34jP8YX2J+w73MkIUQYSKzeUruYpOO34p8Y2zldhIJi?=
 =?us-ascii?Q?v0LVvRs77h8iQjnBKIETBT+cURsQ7Xqz6s/wgR01AW11ls6urLNMKtVT0n33?=
 =?us-ascii?Q?70csMYOlQZbtBF1qW8Lv9suOQB1I9Z+ZWgS/E7p+k8TgTymWnBPCcjORxYD3?=
 =?us-ascii?Q?DH44hVhuZz8/gfiqM9hjc+4IqJW93/M3OtId7/MQa9qp8I0dT4lgNx87A+Hm?=
 =?us-ascii?Q?zkT0HftkQS02UukAc9QJ6S8RlILlaUHBUIZDQO0fkI/naDwbEST1bFr1NCue?=
 =?us-ascii?Q?+G2yCOOPdgOhEgdaQmxFRYwmuI2bD00f89EL0p+PxGD2nEhoSvP3jeWkg3ic?=
 =?us-ascii?Q?rlQQgO83rdk0WqFa4V8dVc1KgV34b10zCi4Bebn4w7ExefetkpFXUz9c2J69?=
 =?us-ascii?Q?ZXT9ALqz0vsRLdMXiDWS3oUJLZXg8lCXBi0sqCADISwC/ChCr2nyRA0PWtm1?=
 =?us-ascii?Q?KEJuTrGHfmkXvS/GXgrNF/zfPQ7YF2SdKGjZ0cNDCYe6nu/n0bZqxLgdaRXV?=
 =?us-ascii?Q?vLJuItuikXvOy6aidfp9jFbzKyhuvQlBtVV+vxHVGJo8PNXijt4oeQo61Dol?=
 =?us-ascii?Q?azYUWdm1pymYa1CA1zRjT6TUKCs04ryAmbFxoDrKtOHlAPZdRK/Ptl0Cx4GI?=
 =?us-ascii?Q?DaeVjomoSPS5qXG572UFvERKudtuPQmQChCm9tu6yk5q6tIgSzSMyz5d94k1?=
 =?us-ascii?Q?TpZe1EfOkMLZJ2nNQXncyfcoVIxTzQcI33Vo/Lm6OJFfcAj4O5yVsAO55fVQ?=
 =?us-ascii?Q?urORjnntxjQw5lkSaviMAyMI80z/b8pAt2oN368e5I/OEnQgmfs/msVkwiwz?=
 =?us-ascii?Q?ZuwYCBq+2kPIy8FoZtACQd7nnBq6DNvluCf16LPHGTjbG+64APDMB2HnTPBC?=
 =?us-ascii?Q?MMOqrZxiE84ufwMUdmZ97T2zVGLSa48YYqflHZ+ZcNbSxICWbybsmWr4qvyP?=
 =?us-ascii?Q?voMnXWJckzNn3p1KDFHPxhNLDQSmMBW9h6tYacLjuNEnEZ//BwwskmIfmxF4?=
 =?us-ascii?Q?8MZlM17Cj6AWdsfoise3qUGpxT6TybtnBPfRb1WnQbbr4cE/RgSs1K57whqY?=
 =?us-ascii?Q?ZqYh3TZFUg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c742f5f-9336-44df-2cca-08de4eb4a401
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 12:51:29.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xwt1vSQyeLRsv+hPdgsWtQ07O0oRuWNgeZ+GAFC4KRNzWUT3V17ATMWO1fE6qEu7aR7kI/b/AwvQG/UJ18ey6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10146
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

On Sat, Dec 27, 2025 at 07:59:46PM +0900, Daniel Palmer wrote:
>Currently CRC16 is not selected when CRC checking is enabled and
>if it wasn't enabled in the config otherwise the build will fail
>because of references to crc16_ccitt() that doesn't exist.
>
>Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
