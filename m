Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798C1D42B89
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F414389440;
	Tue, 12 Nov 2024 15:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="viREB8Z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96E288EDD; Tue, 12 Nov 2024 15:22:11 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F2489445
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manuel.Traut@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6d0IqInOCKyAGb8PZMZrkZZK3NH0WOOMwvylj49Ns/bZYPDoM/Q+Gk1EGVo6w1ZokhOqo3R+mFbXbUw6aE2GGqTs37VEy6UVVKb0njiF8iOQYI4jLbZx8Q56fETjPuP6XMvfJZcAOgaBb9TirMS4+E1wVtyx7oyLyMEoOzut6sd7dIwvz3UnuiVKroXvcfk8/8GJfzAjnCeIVGetdryrfwHyCZpMSvmCc41kogWDwbgB0UIjQZRAnitzzr8OUW05jRlkUh044SFmxR/0PPcVppXf+kP117CmWzG1trmr1E2Xtu2g5obGNllRwHBJ/tAKi6wIHZRWuxbKnSt/rwx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fOu9Ysh4Jj8JSq2pPv8j8finMkb5yVQroM3ovsmQlU=;
 b=ZyX+8ZtLGXYwZ+PJwrJ+iGC8i3KLDP7OpiPiTVK1f4/Z35mlYLBalIh8ZLySagnCvQwQK+dy+r61e65eRKpM1JFMspISHhr7QTIyYubuQPWYQ7T6Q6w33xpfIgpr7kSQPexSDIHPCTSzWWU2sdG92LKLUVYZY5hXGB+hqGawkw5G6PBL/5ucou4g8btSLFnp3JXTeCL1QZt5q9gUu/wtpWFtXZDAmm2U6+FOBmt32WmTnBCSnhEtWOBqiBLYPd8vVCHizmi+VkjQYDnKUq4VxApoGrk7GAsnUMEiF+pxMBiiWXDTa35TNdyS83CwyNN5NDvrE15Pw3mianrgcf0ECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fOu9Ysh4Jj8JSq2pPv8j8finMkb5yVQroM3ovsmQlU=;
 b=viREB8Z1qfzl1rEy5lqH+HGtWHvpiTVmaH8ZJW7+jCMbdow4J7M84dCvObPv0BXdNSJ7RQzWWRznXckJ9qePWGrsZDgww5+XcFcQmYPx4C1amzDmxv+nJ7T7yqx9jElnZDLchO0wdlTA/yd+yepcKwqxjL+YEmV/70ueJ5CiVU+qePD0hW9OTOwcaFKNe583jnc5XjrlLmj7UueOeF/EkXr1jW7ZcK6Jj9EaquVRodIrRBv/rv74DpXc1ATSG6bZ8u24ta7kvtoqzf+zPOCVO604ToVykHyoXReqs1djA4NiI2W/3aeb3dp0FjZLdd8A+vIls8sE42oqlsfs+WJjEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com (2603:10a6:102:f0::8)
 by DU0PR03MB8812.eurprd03.prod.outlook.com (2603:10a6:10:40f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 14:22:07 +0000
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b]) by PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b%3]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 14:22:07 +0000
Date: Tue, 12 Nov 2024 15:22:05 +0100
From: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>,
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>, Manuel Traut <manut@mecka.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Burak Gerz <burak@gerz.io>
Subject: Re: EFI File renaming
Message-ID: <ZzNkjdHYGXQy_kUa@mt.com>
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
 <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
X-ClientProxiedBy: ZR2P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::6) To PA4PR03MB6784.eurprd03.prod.outlook.com
 (2603:10a6:102:f0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB6784:EE_|DU0PR03MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 174fa95a-a9ef-41d3-b654-08dd03256368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ETyrnpdh4mayjn2UUdCRDo2kWPu6Pi5PdRsppW8DnPtQjSicQ3Aw1o2wrj8M?=
 =?us-ascii?Q?Do8IbgVGg6yROHek1qgAZdButbwdqEMAvc/+x8CuCp4lPfvBKNG8SMEFO2oL?=
 =?us-ascii?Q?Cy7YoGZT8CKXgr6wr2c8IE7pcdmoeUpRAi2idCmoQ+njn7uOCCpJLoQhnLyC?=
 =?us-ascii?Q?IrWGqeWdZdre5shsoahqWFR2nXgawK8bzY3ZdjP8RTS3zgvZL80TNA96gLOK?=
 =?us-ascii?Q?fSLGzbxE+0jEqVjiDDKfZ5nDCN2o6DvWs8qc8c+Xoz7Hx+COi9mw11FLz0nI?=
 =?us-ascii?Q?RH1qgikQu2vNbqj2AwwXQJrDJu8hid5xxbhQp1ToYa5+Cwz0Ex3wz0TF5DYT?=
 =?us-ascii?Q?aC0TvfcQyr5fKQBpjd7ip/8NThU+GJA+i3P5KqSl3LVu4xJsrRI+Sel4HorA?=
 =?us-ascii?Q?GFOb/aQsgFfdS2EBfFnFox9PVZTOp3qP4iB62/PmmE2uDT1f7yC7Bl2kkcZH?=
 =?us-ascii?Q?UgQztLr5val2v0iacKL++1+t9TniJrSTRPAvmwQrnjXV7WeZ5d5CuMnylAir?=
 =?us-ascii?Q?v9kJT3f4vpHYCWVFXd+6mCk6IW3CIlL+SzaKz+k3+RyFvNgN+Vbxt7xgRHvl?=
 =?us-ascii?Q?l8AaYNP94bQ2ObSW6aJo//lPnt3giBqOw9+Bn9ZxCrDFC4WflCE9022GYvYL?=
 =?us-ascii?Q?oTIIm5Uf5UpV/e7UTJqKy1jitEuEr2oI3L0YK/K0Kafz9d8/iX2umA694MpX?=
 =?us-ascii?Q?rVi5OKSmbVfW5hcAf/kTHHpp9T8+JuyWaFY+PwWf69brUONkXnYZ3L9dQuDs?=
 =?us-ascii?Q?Uof8gCY6rUtgZVfUgH1Vt5A7IRQyefJa16NN2kehqnwqg7kZA3QwMnorCeah?=
 =?us-ascii?Q?d8WQIBg7uBuUYLqPCv7l9zShYxV/ypIwj2xQ2BbEM2/RoFLJfrRxAadtu+fV?=
 =?us-ascii?Q?QFBb6ps/1MDqAd6NIJxv507Rfxy4pX25xB9M3E12h6ou2eDljhHqkTgOePg9?=
 =?us-ascii?Q?E6ceA0R6icuOjEbvpI8JIgjxEPJxNqG3gqt02e2wSVuYyz2C2YR2AyX5u9EB?=
 =?us-ascii?Q?CHPiLNNcG00hYUZTJ6OuAEBozAQVZaY86KyNDHlOdQRZAmuMR8BK3I70N94d?=
 =?us-ascii?Q?RSTiMgfmgu4Be4RN7glcA2qSnaOKkjIVX1T0S3sJS+6y38WeQ6yT7tEL4vHc?=
 =?us-ascii?Q?42nEQxF7E2CcYb58NV/X5+b52VYsZx+2TOsBkQlrX+R5gEOdcjiNNyYh9jgv?=
 =?us-ascii?Q?aPGG9YKb941Iry/yCAokYOCqAnXOekWdDcvO9nzQGYqudpuSmn+TWOfJiI2z?=
 =?us-ascii?Q?ZulMueBRLCElRKNdDmSa4JGYl6Dd/B7YnFQux91NE9/qIxcUwo5J7DFP1b2j?=
 =?us-ascii?Q?jOlpVnSTRbVEHsDMA16rqlg/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR03MB6784.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7kEbSvaMz44Jq/7EAvtao+jEhpaNSeu80qOfMjtnJDWTynxLSKVfLUVwohmI?=
 =?us-ascii?Q?Z7myKoCUO5LrBs/dUSAT2SMTcodVCQhjq+bNk5u/BLODfqIpG//g2Z1rI+jo?=
 =?us-ascii?Q?7saJ9ICSY2zzLRxYHpL4bkTc+4cj7q/rouVZCP2TDt7TXekgV1JHckaGagxS?=
 =?us-ascii?Q?O8YK3CFJbEtLwt9vLFot87wkQGzMEVk0iSAk3wGyjcyX3eOkv/bhraBwRAYK?=
 =?us-ascii?Q?cxeYY0ASPBkD+3fU4BXZY42peWpb/D705lbnxajUErgkjxX+NjfUZJujpw3Z?=
 =?us-ascii?Q?P8i7njI3NhDiEGTLw5ghPKRpufPWoMbBR8NKqeuNb6pNAPnI/t8qBovnvKvI?=
 =?us-ascii?Q?kekMZ1pTL9tkOZZM8ut52wC8ivCjMUEjIXg7Zs9ybsrZPDdiFvAv+KZv8dhV?=
 =?us-ascii?Q?wqP5aogmc0PzOEb7ltBPN1RdzpGoLRs/TFLHs+R9QFG6eA/McwamrC//+/OM?=
 =?us-ascii?Q?Q7svhjBoDIYG+IzWx2lEQQ0T46iA6UuL3HqerLmyR7FlZW7ovsUG0Ovk+fao?=
 =?us-ascii?Q?JKLOgKJMP9ZNFVRfClcXhSvg3iQ5MKVRkwmMLQZbM0Z+NSBm4gaz+BNTUv3o?=
 =?us-ascii?Q?VEC9Q354TLzaDA8LqftbFofjuzJ6gpYlLcWDn2bO0RmxciYN0PZOIcO2ufAM?=
 =?us-ascii?Q?+sDNjSgtfe/zyDghK1JH5H4ct6Z/dGXTSzemD5eNZHSmlYnvvIUwMUWrkFZE?=
 =?us-ascii?Q?AgffWAsVYXl1DvIiXRkf5SxwOQVEWy3a1tmdp2FLvm7ybHAIcYVpevEODP8V?=
 =?us-ascii?Q?7b1xR5jl8S38ZLs0bbfsOvZV7xo5W4OTazWTsXRMD/GpsrgFROr9pbp360Bp?=
 =?us-ascii?Q?kQyPKYaK/zIC2lWgi6h4Y9iaADWkOqCUUOfuFOZzuBamxnb7IkyGlbGqrjRW?=
 =?us-ascii?Q?rCxIzmZW+zCU8J72NUWwZXLaHMkxAYUEHYWE9jC1gmMfxR6xHIkOCdyqi/kq?=
 =?us-ascii?Q?up+2j7aWeNGN6503SdoWHUoCdpoDF2MyApnnobWeKodU4j/JVfljfHOoS3jl?=
 =?us-ascii?Q?LvGLmE5LwhDPRvTKVzLMapoPPGplbp9oKHZOB556JK4o2yJKfFbzJd5pE1I8?=
 =?us-ascii?Q?SQaLfJtIMoVGymr9lLGKZKNwEMtO2dbgVmcXGpJotUJHExGbvu86Rd0EEQXj?=
 =?us-ascii?Q?6AGm9RSm4gFUSZ2lxxxWmSkLP9Cp3KawRWDeb5PslsUAAufyzWXgXpYRD8Yv?=
 =?us-ascii?Q?qgxcVOd5G4iDpA+5TmpLtsigD5UnZZvoB/vS9TqfpZtl1zfBV1KWwQynLkeo?=
 =?us-ascii?Q?hIooIWhYrqqFmLIUnRlqcfyOpMDAUEQz5JwQM9SKPXqtdOaPFzpQ/EV4yWvg?=
 =?us-ascii?Q?fyl+UX0PXxiTurdSF1oNRQVXIkx7W9JCOGsHL40BJJOqx09ZSS1SV1sIIdy8?=
 =?us-ascii?Q?PUYe8CvWOsJkmBMRM4LHJt79SNTAR7tH+w0nS/vTO+lfezAttS9hZeiqITmG?=
 =?us-ascii?Q?2qp0Ru5Uxh7rK+/ofGZnuGX0IgNVSlgaHu5cd5g5S/QkHGqq1thn3vaYjg1E?=
 =?us-ascii?Q?8rmZ7q8Ehm4l8btTv/BwzmAZleE3t6bYdnxq1a4UiAU9G8NNJHNSu4bX3fC6?=
 =?us-ascii?Q?W6kUklJboXp680VfdicFlD7Ei+qxps1ftsSKpUd/?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174fa95a-a9ef-41d3-b654-08dd03256368
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6784.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 14:22:07.4126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mt8eBaGqfTZFYAQr4l1Qhw+HFLRDdnOnQ34YHZjpSkZWJk+ZWNhet3KErjH0fUq4SjFY9R3G13SB0weN3RGOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8812
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

Hi Ilias,

On Tue, Nov 12, 2024 at 03:46:48PM +0200, Ilias Apalodimas wrote:
> Hello Manuel,
> 
> On Tue, 12 Nov 2024 at 15:21, Traut Manuel LCPF-CH <Manuel.Traut@mt.com> wrote:
> >
> > Hi,
> >
> > systemd-boot counting logic requires [0] to be implemented.
> >
> > Is anybody already working on this?
> 
> I am not aware of any patches

thanks for the quick response.

> > If not we plan to add the functionality in fs/fs.c and fs/fat - correct?
> 
> We don't have plans for it, but explaining any use cases you have might help

systemd-boot is able to do bootcounting by renaming the UKI image [0]
the code that triggers the not implemented code section is here [1].

With this it is possible to have watchdog based A/B switching on systems
without a writeable u-boot environment. And therefore it is a nice
method to implement measured boot.

Regards
Manuel

[0] https://uapi-group.org/specifications/specs/boot_loader_specification/#boot-counting
[1] https://github.com/systemd/systemd/blob/3304a029b847e87da51f7a8ad8c118111508e009/src/boot/boot.c#L1407

> Cheers
> /Ilias
> >
> > Cheers
> > Manuel
> >
> > [0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/efi_loader/efi_file.c#L971
