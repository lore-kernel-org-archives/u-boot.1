Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F554CA0EED
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 07:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CE083020;
	Mon, 25 Aug 2025 09:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="cgrDvNAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2001983043; Mon, 25 Aug 2025 09:50:47 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC8383020
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 09:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1rljdQtV1UWj6D/u+h1AJpHpyKWJGLHTUkM7ce8y6Xffm8bbpaRJpysky66Dpp3M6j2RHyFqyk1yQlUoAtRWaXTVzs+/ZFu8ktyeUIP7Htq3/uBrv4Ai+o0pP3J97l195CgJ3b07dqG0Czp3lzaQecCS50I1nCxLqjAbSR8+XGsyEXUGhx9HxZTKjgzeo3F4oge6AYIXXngj/f6VIhqrGA45PNMe28MYV4dXsPX5ZNOvBWj1usH6r3xOF6AzarTVjGrrzQu6oLpFc6BPTW7ECf1DULsOIsUQ5QLAgSygyHqG9/Q5lgRIyOtOrt7yjPdPIK0d1mCmdUWES0yEbMpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amLUyPwdRPvpyCbzdnuRtmaDT183u0PfsN1p2YtAeq4=;
 b=VA093JuwDbj/nqGBMZHQAMPoOhDbY6MLFamC9n3A4z+QVXzuRC30Yfyv3tzXoE9uW1jgR9I1UmK0JP0pyOgAplez2DHnhus3vqhfSeR/CUy0TJX9KjMAyfPc9lSP8sIe4M7UCdxl+1RSFJaoovdquxvhfgmWTdsXygerQV6J1wUyoS7MfO5uC04o6b/7VvQF83gj5XZZ5nDfhzRTVQwBg/I8ZTW/64wbl19RS/JKXFP77FF2ZpF/hs5W2XTKh2PLUL6+Crp9+hPeR1eA/VlqAgRzNpgRV+7VLD/EpIEBOcXwRCpWRTVurQbf1mBmnxPwfu5gHSTV34l/zc4s3AEdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amLUyPwdRPvpyCbzdnuRtmaDT183u0PfsN1p2YtAeq4=;
 b=cgrDvNAsFAoYCnD0pYGifve8uYkpf3GmVmrEoyEtjt4uMSGpKlkzXig4NT4Y4MkCJBrXLL9dksFAnWEjpi2X9sdnljCA/GUPmHsSOJYu89k1qqR+2Wv/yu6DsVCXH4ysCVb177J62tpjJAZbJRcE/BCW+scHrOFPATy3QLTVZNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB5867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:56::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 07:50:42 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 07:50:42 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: E Shattow <e@freeshell.de>
Cc: Tom Rini <trini@konsulko.com>,  <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] scripts/Makefile.lib: add CONFIG_SYS_CONFIG_NAME
 prefix to dtsi search
In-Reply-To: <20250825040122.303437-1-e@freeshell.de> (E. Shattow's message of
 "Sun, 24 Aug 2025 21:01:14 -0700")
References: <20250825040122.303437-1-e@freeshell.de>
Date: Mon, 25 Aug 2025 09:50:40 +0200
Message-ID: <87sehf4z73.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0021.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::26) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e535a72-070b-4f2f-85f3-08dde3ac1735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ssK/So/4PQ2av8WSRZX0ToT6CLGdjcvh3+c3Gj0ywOvZXWWniqT+TfP0IFJa?=
 =?us-ascii?Q?cFEq8Sm20eog/t8CDEaDEL0W7KYZPJLsVup8qgqFzwB+7D5aZob69KW68Qwg?=
 =?us-ascii?Q?lrLKQjcnHMqnJS7Ac/OyKvFSQcSye9wdEscXaks/sfWO7Lec3eNAmoIWGkRm?=
 =?us-ascii?Q?fnKe0XFtwW2HGiT9WyfPV3M6uVvIQOSAbm2zee5n6Cd+d91jKqO+wTeNF3dc?=
 =?us-ascii?Q?3NAq5myytaLzVxMD0IKdsXJR5U4YujdIxuBqxSL2wEuvslBkX8h2kYab2VUQ?=
 =?us-ascii?Q?HAFMPRibkwvOFuoatdAow58/ZzpnWyupDScUzuQUqQCiF20NQ3T4nj0WbsoW?=
 =?us-ascii?Q?SwWEtWP10oWLz8j3ZJcVCAkqSzMNkjKwZjM5SKLjHsSMPJnb3YOAXDY/ZSim?=
 =?us-ascii?Q?2rCwWbUIgak5Ycm1B0Gj7vVQUWlzsc5EQ4lV/KuO/oRGBd2Rt+rBDXg9wPPt?=
 =?us-ascii?Q?92qjO3W0svGiQNYd2UADYTMNiPvNGrATsgAONC5UwIE9vBjwTkFNgRy+a/u0?=
 =?us-ascii?Q?wxcjPHs1fyvruaOBa2cT3Mgn/8WAs3kCv7ESQSLorw5kkJ47/Ekt34Tl4+/D?=
 =?us-ascii?Q?umi52NuYcrdLA54JOmUtDfxb458renNHNMkSCnPeJYkLUGSWXQ1pzYB9cJfb?=
 =?us-ascii?Q?LNPhEPrPUkzlEqwL/pw+ubLOTeAzIuUpQ1wiVp+sYqCEmiV2KUXfodSKNaAo?=
 =?us-ascii?Q?mFvlA6YxUhyMC5TbAB3VNsGThOiA+826eWPRKDRrCCMf5uOt9TDZbO4t9cF9?=
 =?us-ascii?Q?sMQhJtcJcT6ueZgLbEuLyXS/N5NR6sTHtSNxRU03SPqnRYVyo8/PxEaCEm/4?=
 =?us-ascii?Q?LCI7HXhhwaqzg8Yn3mLttH6pW2l9Y0kvdpEzG4Iz3UBtwMJe0GrlRNYghLxZ?=
 =?us-ascii?Q?7FB9L8Z2kdOTckFjTvmgE5LenjRwsoaP5hUvIpMuF26MjxBjoIhnyPkMJteG?=
 =?us-ascii?Q?X3N2YOg0WgjQC+GhkstjoD72jrn12M5KL5P/2w1/SDxUSNQ8gdsnZkc0XuK4?=
 =?us-ascii?Q?H+A6YcLQ7CrfWPAE7XZkLzqeXF/vjzZARe1qLRTwrVFJB1Z0s7ifIGt8r2zH?=
 =?us-ascii?Q?zOIoWN536UDd4vFcHek4tbTuHbo4yop+/nghZzcHDw3tC8b2PnZ+a6+oqhSR?=
 =?us-ascii?Q?Y6zoktlDkVT0evPWELLTTimhMhby2kNC1k0fLEkLjRMCK94TJxUK7bfFg2gu?=
 =?us-ascii?Q?I8O9Ej47iiQMqs/b0kyei3NE97JzACH5KyS7rTdezqk6gy9m0fQvQZGfvgkj?=
 =?us-ascii?Q?doXhIBIr/dJIIDKoGfHPt/yUz1Ih8SIai2YF3m0SLpc7HMGdabGU1GKZEux4?=
 =?us-ascii?Q?A2qGWtZ1tzzRhPqrQuncFmi7Y1KdbBWe8Wz4jdXlSK29SCs4q5WzPDwtRWRA?=
 =?us-ascii?Q?6McGRm0knjCWaQRDOgVdSLmhLXnjaz7BlYJmdv0UdAYMf+SzoncqT/XbeNY3?=
 =?us-ascii?Q?0BfA3m+Jx+nutT1ZItpPOVXofKnKbtKBD9+tQD4zLayjkeLUSs97LVGBctyM?=
 =?us-ascii?Q?B9GtEuXE5Z/xENo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uJiYLL8y7Vd1g521LQH72g59Ms59Yt7gYT4wbKTlMcem+N8xu6oK6j7HbDYb?=
 =?us-ascii?Q?cerJs3jbHiWusDQe5GScD04BIiYBgQPHe20Q0GV0Vkb7EBnPJH8kouf00Qkx?=
 =?us-ascii?Q?vcfSqDzObzwIG3jd+aOwFOCZeSzoUTVIxab+HKL6xN3vnc8V9gQF9jQ2ifey?=
 =?us-ascii?Q?0owp5Z/JZAdHkvLW0yKOY7vwO0BhoNCY14JozHBvTXo92wPfniZXrHFs2U6x?=
 =?us-ascii?Q?8OtqxEyY6r86GtWBvenS7jTtnZrZW0rngCUMlF3R6JrZ9gGUxYUE5qel2yZp?=
 =?us-ascii?Q?SHS+luoVzpBXGYJXQcOEmtojakInEJA0g0TjOvTLRjIk8Gt1Xtf1FdbEi+JX?=
 =?us-ascii?Q?+E5eIIH30/iY6ZC2xdigUYqHe189ZUGwjgUHypngvexDiY8OlK2JrkbxKl/4?=
 =?us-ascii?Q?1tMG7bZiXC6czBRSKXzFf245jEG7wriyzxnQsUdtJtJcxRai63t+XxX++C/K?=
 =?us-ascii?Q?z0o870SHHqmX4l3thrAmK34FUG0nIb1+sp5m0ggeCEwJEY6vweLdDUBNb7FC?=
 =?us-ascii?Q?saxlneV1Dkyt1krfc7WhJgNlj2QxNhEoIsq9paJoY0Q+kx1S+GWJlNneqI7O?=
 =?us-ascii?Q?TuF5Yz1J/G8HEfVSehv2UBkIupcb+w5S7/pl2cBfbc97KKM5Pjmxkrv/mOOD?=
 =?us-ascii?Q?nlAQjaQO7wjXRAXNw7EHZq3omnlSffqJmYDfbTtlMbNkwCrAVVs4GysVSkyy?=
 =?us-ascii?Q?VNu+NCpRgPW51cFXkvGuiuXWhgUMA7AP73b3c1oN79wMc6dksKe8611NDrjB?=
 =?us-ascii?Q?8Euyc6JqhpUTR7RWY3nsmjBbCEgN24+ROldOhitoWHC21RJJoKopo+tWrimL?=
 =?us-ascii?Q?MUccJyENXdDou5Z2FUBNp8lvBHoD92GaNn7FF8M8jkwz34fnrVfD/T2oSBoU?=
 =?us-ascii?Q?HB6oAUsBxXbbiraOwniQOvcWsgk8/0wLPkbPrc2T++24u2E69ffuBXRr3/LT?=
 =?us-ascii?Q?WcNzXVejarHQrF8qJqrzqIgizesA8sPvUXZVMTGTGHJpcjxmZnv9fPSep+v/?=
 =?us-ascii?Q?oLem80Vwm1f6alxPDsX6NWV94XBemF7Ne0gZFHq2RizipF0cDtaB6Bo/pdl/?=
 =?us-ascii?Q?Cw5R9nSBVUKnFhSH/N1ypyPkokmBOHbi+WZmIkLcubqiv+e6rfWgQCH/BA4F?=
 =?us-ascii?Q?7GCstw2IC01W2FNDAmp9LKe4UxbAcTJ6c46f6FXzLzUjIeuvvmlx3ARqha8b?=
 =?us-ascii?Q?OztSy0Yl1bSfXa7T4I45jzAAbAwWMQs/+XgBhdqKUomaX1yVw7xd6GNm/cvT?=
 =?us-ascii?Q?084VLJRJ46yset5bimUPySNt+Sq+dulOPqs+fM8moX4zTXVD8z1fem5e3hBg?=
 =?us-ascii?Q?t7AU/By8+dU5F7AyCDDPUBNGqR490T6GEE6SvqAWcvuWxkI2HcnSjR/eNLfZ?=
 =?us-ascii?Q?5dFIAbF2BEyETUTmLQ7T8bhGN2NFQy1mOq3CoqJyNL0/GiSPGPXSQZaTVNKO?=
 =?us-ascii?Q?Fpd2CXvqC32fo7ZGcT6mHwx0cxpAUADIFTeUNLKyc9sL2g7ygnpEe+mHptVi?=
 =?us-ascii?Q?FHdMHOFOYknb0Ufqj0qhx4WV3rUWYQoTMuv3XFRZuwVHXgxSBxFnaHJq0Zp+?=
 =?us-ascii?Q?NJlKaPsiz8hFrOLqnXDABJkL7NoYcXSnRTlLT1LLPBncIuhFvT6y+mwEcsgt?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e535a72-070b-4f2f-85f3-08dde3ac1735
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:50:42.1841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6KX9vYDfFepCCON7GhiJ1st8/xpIBcTfawWwkHL6FEjsrrtVlYovQs2SRS5glWJy6P/7TujS6Dc/ZAQpksrQxoS5f9fSIh3VKyfXI/70nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5867
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

On Sun, Aug 24 2025, E Shattow <e@freeshell.de> wrote:

> Add ${CONFIG_SYS_CONFIG_NAME}-u-boot.dtsi into dtsi include search order:
> dtsi location, SYS_SOC, SYS_CPU, SYS_VENDOR, (SYS_CONFIG_NAME), no prefix
>

I tried that, with CONFIG_SYS_BOARD, but for my use case I wanted it to
have higher priority than something "just" matching SOC or CPU.

  https://lore.kernel.org/u-boot/20230317102639.464263-1-rasmus.villemoes@prevas.dk/

Can you explain what board(s) you are going to use this for? Because
this having lower priority than SOC, CPU, VENDOR seems wrong, and if
there already is some soc-dtsi file for you board, this won't have any
effect for you.

The problem with my patch was that we build a lot of completely
unnecessary .dtb files, and the build of those unneeded dtb files break
if/when the .config we're building causes an unrelated .dtsi file to be
included (most often because it refers to nodes that do not exist). I've
suggested several times that we just nuke most of that dts/Makefile
because it's really not useful, it still contains typos, and nobody
notices because we nowadays have build logic to automatically build all
the .dtbs that are actually relevant to the .config we're building.

Rasmus
