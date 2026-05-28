Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1B7CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BFBF84702;
	Thu, 28 May 2026 03:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RbD99HHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA0A84886; Thu, 28 May 2026 03:33:38 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A409846E2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMX9Rj3K2ngU/EFSNntrcdY7QGz/Rh3P2oeyD2wh9NWLJ0vplVsYbq9UWKKbRXaIjwioEXqKLZ/Y5z+Rk0+7Iqcn+G2U+TwSaAoCM/qKRkXabfxPhv1inImzM+Z9C0EjZp//q2Hf/f4F+qYeAk+Z9qAN2448hMN85wjCaM8pg5o4f5CbzU4gHI/zA2D6JwOZxP9lFK5ghOvTyvqDxUuEeHnpZqdQiSmK8Sm/GMrx1n+yVEJMZgRpkyBpxg2/1kj/zm09GID7InxOaKRccWLIsW6PYB0uxhdFAvahrwLcZYSQaaL8oycwm+isQCcYOf7y6IzdKIP4CoQNhFwS/PHgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBZ1zSus9/Zc16XXS4qsGc7FYd+IGKNdN+9sqTkfLrU=;
 b=zGUd8oPhVIewbZ3zysNX0YOgwLKxkCc7NC5RrZm4NrOm/xnk/tSeraAmIip+fWs2Lqzp6x5LuK3CCZB6qd9nTec+UASaleoqOiuhz/Xmp+htGrHDTGqrIAzYfcEVaq0pxYZNS/tUYcyE0/q9IOn8rtdlK0zO7g0dfk8KBFrxvIdM3a0vfWJdh5K2LdDtQcMOJDt638NfSTKu0hlGLOC37JWpPTjLY1/gzGVG0CqzuC+MOgzyl8vFrRTzxOodWpFA4Al9gIumSVHh1yuWwi3jP0Di6cPSipdjrCUqNN2aJrKMofJFv0TRZscpZ98/QFpzVelBON8Wkk3qPucxIKWPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBZ1zSus9/Zc16XXS4qsGc7FYd+IGKNdN+9sqTkfLrU=;
 b=RbD99HHJjmaPv3CX0av0gmbMD6qREt980N0OrGzppZv8ixLRNFEcS26fA8FwZ/fdnAvBxwCfjnRwbr6lv+/Gxkr96PtIupqh6a5UUYBa3co2yJseiAJnrQHrPuk/ESa28bs/9977B8MP9jNpUCmmi7WBYCndlYC/sOq2hPDjkWLCItnM6ZVUjJUroJVr6I9Wbg9DQU5vQg4VtJzs7e8UFBFSGqmO3xhfIyYH6O+BsnKrLGds0D/Wjlr1NBSgcxCZWLtPhaEu1XP2WWYWnLSS4BVuzXauru2Mqy/fE3YgdHJsLV/Czf1noCxjLAGoZnMCG6obglqo9Z5AQaQIMTOBnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 01:33:30 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 01:33:30 +0000
Date: Thu, 28 May 2026 09:36:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v1] thermal: qoriq: add Layerscape on-die TMU
Message-ID: <ahecFy5DsUzm/+aG@shlinux89>
References: <20260527134744.511819-1-vjardin@free.fr>
 <20260527150459.GG1858239@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527150459.GG1858239@bill-the-cat>
X-ClientProxiedBy: MA5P287CA0253.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::7) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 32758aa3-1715-4330-47a1-08debc591fc6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|19092799006|1800799024|38350700014|18002099003|4143699003|56012099006|11063799006|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: pf011Ql4kqJe9LjhpEP7QtUBCKI/rv7ILiFLjd4Dw4Id3aW49AIxTZM+T50sNqik2RP3HuRrEX5YiMaPMMPkdF7YVS3IFg2ZRjEGLm/sqSEvKM/k+PTp4SbDNYQNlRJPTfmn7b2DXVyxtlP+92yj0vGDeJc6T9hQ2/TTRR8sNATMXaPydeedGXyiLelxqZTC3zLdkXO1RqtXSIveSA11saXUweXPaCjRU3CwELswKyegntLJ3vmAY6y4Q5XGeyZpkdGQCYopihRXmT5Xb0tLS6tnvApE80DrWyJFVxcTVraju5Zuc6n03a+k+fOy+/9XZPPJXc+MZHotlvYTYjZwBUrROyN7W5vBKIYmfk8bL0p5OIvYZX0CIfnrDLL2KjBb1Z14T50Ld7h2ma77uexc3IRaT0t6ZrvFBTuAp3RQ1jzTL48etEidJNtE22ezfkzA/lkh3UiZBLithRjU9pX4/aeFlX2hBin3rdr3lDmFo/hx6Ybz5r6ecN8FrjY/wUGBYHOJMGLRK9lcCDjQM4QUyezlU5RGqRQO2JKkLtw/FsKmhBpnfjt/wOpRRcRwjUDX4v87RCqmfiBRGvT7YnacoT+IWGK+m7DM6uXG6LT9liTVsVKo/OKKRhKTi/XqnALa1yp4l3EZJobHwpay8kp8HIhN/A4ZA1iZ9ftBSwA4+06NfAOqiL+u5gYlDrnqDXO7zcLYFEIGOnfFyXxtLuEbozR/SX3J5Hzxx9Wja0Mr/tQR42gofcxuK0E2k8bdts1zbQklazCH+u91L1IB9Hei5Zls/OMkOtJLmKTli4l5Aag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(19092799006)(1800799024)(38350700014)(18002099003)(4143699003)(56012099006)(11063799006)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?axliNs67uOwFQ36t3JRhzZLG2YIACUfxittJfIsDEy428zopfV2jxpuNceJE?=
 =?us-ascii?Q?SQq1K5+D+VENirSBpgZ8zCjaZuAxUKpMN0qo8TCXjjODRikik9H638sUWuGr?=
 =?us-ascii?Q?1XSi75Rtksj1QeKC+bZdpXZRxpoinNHq530zo4DvpWnJY97owqz3AXZdF/Sw?=
 =?us-ascii?Q?ebU4HzXX/uz9Md6BHpTrAdUbtCymwYuW7jc3IXYlGUaMHchwhDtn+FHO7n8J?=
 =?us-ascii?Q?H/DRCfJo6rvqO5Yv3jnRR/gH/CRTCnekimWeOrjFwVOUm/Mz13jNMBsH/vMa?=
 =?us-ascii?Q?ewpdhzl3c+k0wezR9cnGAJJrBxrqwKTuEcbb3ToGS/7h8kjEIxptc/SiiIx5?=
 =?us-ascii?Q?QW+wuTtWWjyvQuNigITJ28jH1Um1OHUclHdqkayQ0gFIrT+DtLyecuK0JmHy?=
 =?us-ascii?Q?YY4RZ1ukbTr7IYas25FpthiqatbH0/X41yzpVlC6BkDXvadBBs8bvFpqo/E4?=
 =?us-ascii?Q?QSqZdH5w+r/GTuCRr7+wqYvcMng+xKHbVwohYSMBek/LupJ3w9Z5cBumv2Dl?=
 =?us-ascii?Q?KKHR+kZJQDRlcW7vKMIlf9OivHRrYzfv+rd16C8CjpOGZrrDua1pDjUYPMJB?=
 =?us-ascii?Q?IUPGLfdJx0gcs+JoN1UgYJFP1BIWbBiLdqPYldS3F4nxgZN3vKX1TK/kw0yS?=
 =?us-ascii?Q?BpoAbW5KeH76jlKQh2v9LjwXjiegN8n3f3ymcmloCTrom8RPstyJs/9L+tgc?=
 =?us-ascii?Q?QszmtQvn6Ts/tZGRkM9KNH9cqKj1VDXEU2kVcJ/du/lIliQgrcKpo1DDJ3xe?=
 =?us-ascii?Q?tVScFSClFLpUe0kvw4uC6vp9IYCWXGc2ULLyrx3lcfa1oHUXeIknG3CKsjui?=
 =?us-ascii?Q?OcrT++0+B1DnNoJtdMPqTei2lmvdtyyuKEZbrYxnIVBnpDOnpMoRlpAtpPc5?=
 =?us-ascii?Q?MFQh8UIh9oBfZM44nhdw68FflprZX8dJjR8uTYi0GHqNzSCr2sZfTZVgga1y?=
 =?us-ascii?Q?YiwRf8dEyxAK+IAJXNxf7u/p4Ph3OUxm//0xUDjSJUBbgpPVyMnTPjGWDXk+?=
 =?us-ascii?Q?X+12hQwfzsPiJUdPNTtr/s89WEqHBacgkZXkp0dfFmftYBNXM7gZDp4u6zRS?=
 =?us-ascii?Q?QqOgyO1k7eRcz40azlUcQ7aWK5q5+x8WjTuJkCMxuHn2rX7jmKQOciHPrXmh?=
 =?us-ascii?Q?gyc80FjYRVfRLxOlTM9ixLpWzhAmO94Ne2g/aSzgCs4QKG4WRoEHYnX2d9Nu?=
 =?us-ascii?Q?vfzoWLVHrxgyR8c3MlgN5sj8Fz93zjVzJWNwH6joqfBBGYrQXKy3MO8AyrS9?=
 =?us-ascii?Q?aGQaeHXgJ7LPVGgIMiY6VF5wGWt40e/y/aqFtbCyzndDwtQSdgG2ViqcjKiN?=
 =?us-ascii?Q?5CT0+cVX9crqovqPfoBfmHWncvdvCf2EtWpS83Uu3Pd4uo0D8IvWyKiIijnP?=
 =?us-ascii?Q?e7FyLaXO9lF46GE0fAWYL2tz4c9EVIrkq9tFChe7gzG1nFl4rSQ7HCh69GfA?=
 =?us-ascii?Q?+oOqR6ULns5Bz9BLZWQcX7OpsP8QfAa6f6lBU5PRHURch274I/0bwIsfx/jS?=
 =?us-ascii?Q?L4C3tLqKfb2BjX9D/H8SmvZ81wvdd0N/Lu9T58YEpiK5PRO0qSaK5ve0bodJ?=
 =?us-ascii?Q?rRBdG/f9QztLvn1LSBZpl4PTMdqtBqstud6XjSwO8WVGXHh2ZxBmulGQ44dH?=
 =?us-ascii?Q?6CmWf0oYuH4rdNxfWAIUvpKQaUkzNBpncR7V1vxB1L1mKkvn6HwuyYGXPq1q?=
 =?us-ascii?Q?QDbnnwYnqfekGWX5rUHgh3QgtSipdoiRNl5e4ihL+vuA7NnKa56zoL3l5yks?=
 =?us-ascii?Q?CHAgmplYeQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32758aa3-1715-4330-47a1-08debc591fc6
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:33:30.5564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsXpzRXFFRy+EJ1G1f55N0CI+H2aW/O4tp0r3Uow5VBqWemrnHPCFMSEeBnea28U5/DWx7dtEnz8UlL8gADJ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667
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

On Wed, May 27, 2026 at 09:04:59AM -0600, Tom Rini wrote:
>On Wed, May 27, 2026 at 03:46:45PM +0200, Vincent Jardin wrote:
>> Add the support for lx2160 and other layerscape for:
>>   => temperature list
>>      | cluster67-thermal   | qoriq_thermal | tmu@1f80000
>>      | ddr1-cluster5-...   | qoriq_thermal | tmu@1f80000
>>      ...
>> 
>>   => temperature get cluster67-thermal
>>      cluster67-thermal: 56000 mC
>> 
>> It is designed as a generic UCLASS_THERMAL driver for the
>> QorIQ/Layerscape on-die Thermal Monitoring Unit (TMU).
>> 
>> It is similar to the "regs_v1" variant already implemented in
>> drivers/thermal/imx_tmu.c, but the i.MX driver depends
>> on <asm/arch/clock.h>, is_imx8m*() arch helpers, and OCOTP fuse
>> reads that do not exist on Layerscape.
>> 
>> Rather than #ifdef the QorIQ bits, this driver is a clean Layerscape
>> counterpart binding the standard "fsl,qoriq-tmu" compatible used by
>> the Linux qoriq_thermal driver and by the existing fsl-ls10{28,88}a
>> DTSIs too!
>
>Are there parts of the other driver that could be split out to a new
>file/header and shared? Or are the i.MX portions too deeply embedded and
>cannot be easily abstracted? Thanks!

QorIQ TMU and i.MX8MQ TMU shares same IP, with only minor differences.
As I recall, the differences are in calibration part.

Current imx_thermal driver is too deeply embedded, not in a good shape.
Need to give a look to clean it up.

Thanks,
Peng

>
>-- 
>Tom


