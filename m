Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DF8CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 09:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC0A835B3;
	Thu, 16 Oct 2025 11:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kk8mn1ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEEC835A2; Thu, 16 Oct 2025 11:17:29 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D736835A2
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 11:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ4aE+qwdpx9eMfwHU+L1myeT27f5XndnYR68YgG1qO/rJXVD5R3/f95xgd+BDqAQ+0FWBJxSp0GOZTLTfxmP6RemHQdKhtUkxWCf9W7SPU3+0WEaaPqVm5CPRg+Mf9x1hcZSSgAHoar+P9SbbXuUzdCNt2tLwk0abj3aAq1qCsXL5RGypUp3ezimRX3dcYKTn23mdSmMNkXbGUjFth4+XSPezHJZ8G8Fcljf7AxlVNeHMkZLS4wOoU2xyRRgtujxHwp52Md1RRVBSyRSV0weX3c+dWe0PdzzCoX2+W/nukfPp7hb15RppQpLthXvUdTLP+/BJrwgoFKVto7AwtUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCF8yli0GajeWHnt5XBTWg5GQsGQFf0sb1NrrEjNAJA=;
 b=Pc/rYOrNRvNeFn17HBxSPAhz7yH6oee487u2de6mujsH8aSpam7NA5xDMxut2wZ4RQsIn2djv/HZjaCWAqTTiPV2peT2hF/0AEJ0PoqgczPkb3uPdqo8SU6slvgBJ6dY8UOcSKwULgSeKUKAR8eUTytroO63GZ6MS8RPU/U5ju7lryzcOJF+oFo/jjQ23SVFc7/OcR8EcBV3MSGoBhxP/wAzLhSismgyMaDhoWBF5hnUKLipKFQo93obdFftSq0q4Pu787BZN6xw0TXMuF6ulvRmHejWTbizyjSJ4Xajvkw/kAdNYn23BGYENv0vWuFlZFbFK5zSGI6UloHsMFVbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCF8yli0GajeWHnt5XBTWg5GQsGQFf0sb1NrrEjNAJA=;
 b=kk8mn1ectR/jMzxeLvngzD3p7bdF1DNSE1QhIjV7HICHh3KfsREdDmiVtbR/ZEIuLqft37x29zNI4vyzuvgkjfq8uVjXxQ9/qOJ9cCgQbkJHuHDE3r3Cn0sCBSZwxnHJneJ/+XfWiPFnT5EgiWoh8hcXGQ2lVVwU7h7UzYJDoCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB7437.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 09:17:17 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.005; Thu, 16 Oct 2025
 09:17:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] gpio: search gpio-line-names property in
 dm_gpio_lookup_name
In-Reply-To: <20251015210812.GA748494@bill-the-cat> (Tom Rini's message of
 "Wed, 15 Oct 2025 15:08:12 -0600")
References: <20251007102637.792524-1-ravi@prevas.dk>
 <20251015210812.GA748494@bill-the-cat>
Date: Thu, 16 Oct 2025 11:17:14 +0200
Message-ID: <87ikgfnr39.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::22) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 09782665-9f08-43a4-70f5-08de0c94cd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YeP/AcBM0Fo4BubLGMGmSLzTQO9bWr+hEPW7YAcVrBCKGjScLHk1HX7d9ggV?=
 =?us-ascii?Q?Rh+9pVkFhpePZ3DE+tB2Tsg7bjxkNovSDEYDY6N0dLI6fNtyiFqsgcVHz+np?=
 =?us-ascii?Q?9ml2UCkR+Hy1mUoIIE+6FVEhhLye1+AjqhuiwYV/Jppu4aidZNyIo1hC8pmZ?=
 =?us-ascii?Q?g3ZH8qfd+N/AbvS4tovmWOUXeAWaV4F9J8ny5VjQR+3Y0KtibJbHAyiUuqEG?=
 =?us-ascii?Q?S/S/SGV+OrrFs4+P2HFP7LM0EVPZaXataHlnysvsVej3YgVQNgjEGDHFG1oj?=
 =?us-ascii?Q?kseqG+fyPWK6AcFSbJw35C0Wadt6WBC0GKKyGXPyZFcJx3kmu5/eVZsYX+iP?=
 =?us-ascii?Q?hiWn+C1o6vx0CiDz66li089bMG/cxQmVJPJCq9gWLsOhLeVbiE6Ed3dYVcp5?=
 =?us-ascii?Q?avb0FybjjFYxIsk+acyANA0y093K+d9eueYsQvU/2zGf2NSoTSKqL+kWASKu?=
 =?us-ascii?Q?EceuaqAI5gFb2X4DC6S5fepk3JL8fiZxYutZ2cRX4EgXQlXR8+SJa5MkzrR9?=
 =?us-ascii?Q?t6c4sf7q2pQAW+rGOPU76pXUQKdMmp1lpho/MYdFWQo2iMOPONi1h8JWVLo3?=
 =?us-ascii?Q?k3rYAw0VPyRol8MWt6/gyNhVl0F/TGfuwdPVX4EdcXk1iJE2LMZ5Q44NN/7m?=
 =?us-ascii?Q?JalkGm98ZFEnLR5knGUjjLkbtJxRGogkpJEkN2Z9u5XF7PSbGnmwAwCcYsi5?=
 =?us-ascii?Q?iZP/FM35813LDSHE3Iaf2dDMFJnR62ENx0c/7ZR/VUKBRkg3f3d/Od+QK4sr?=
 =?us-ascii?Q?vhLrW91yrQGBAd4F4An6i3SUeXXNvPiHoBioWtbqCwv1guFbTwhlOb77QRac?=
 =?us-ascii?Q?G/1lDWPNdt4/g59Z6d4l/4RtHeLC0NpbLcsnv7GUSuhLqMJbI5TMYtmPGeNn?=
 =?us-ascii?Q?X12jZ1VNsMQgHxE1Vfa7sXA7Qp/jC/V559B1dgfVgtx+TJ1ilH9GlnHsGYAS?=
 =?us-ascii?Q?jVY9gVRGWRIxMSI5bgzyzdEGCQ+OonFTe08l0We1oxB7Nx9WPuXDTVqkWHZQ?=
 =?us-ascii?Q?JW2YMSKJ7yrSUSjZqoEht8H4Vzy9Ut49h1MgLa6sjmjJaFMamEkmzQ1nsoEr?=
 =?us-ascii?Q?cjeMBxVlkxou6kk8+lNaGstMarn7gLCKBjkZNQVARFa939zn2iQOmx3pe0L7?=
 =?us-ascii?Q?4jVrhN5hzBKq2osxqbFe3UUsSHhaQ73C7T1GbxmfTqdL3foboepkWudNHQa3?=
 =?us-ascii?Q?nKfpXVDmZ+S2xHTcS9l+tGRlO05u4yZIu5m0kuieyxTL3R33+7qN8MowTtnG?=
 =?us-ascii?Q?h2g6L30IA/QHEY3j7Nwjnx+j9/WUPT2TL2zYoONMvqoFfAJtOS+r5Khb1pNV?=
 =?us-ascii?Q?w0l99HI4mU/PjHyRLJIODwk4ITol76Kv9si0p5AO9aAzaioHOFU9Nd2Uid5w?=
 =?us-ascii?Q?bOupNGomJD4ZKu/msVi69m07X9alpJye0ufdO9I5mcsfqDrRYQ3/6IP0OfMy?=
 =?us-ascii?Q?v9b5GKlrusZtqTdPPWdA/2gySCw/ovudPc0u374+9kaiqr5inSPmMhd+ZCdN?=
 =?us-ascii?Q?LjeJZW4T9EydDsxJW7+ORdfYd+Pm2jKtpLvL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OTFtaHAo46HrX7t/YYR4nWNxR3xqbdIsq7S7Piw6t0DIYgZWuIkszFvVR20D?=
 =?us-ascii?Q?vasRw49COQ/T1DgJOlNnk8c53uygNlqrbQWuZwr7SVQAkofVLJ1fbAMjKO9p?=
 =?us-ascii?Q?DX/PxQp1TMxyswbZCWr08/9FveuQ+FDd9yz4qVVtedODj6hhrQCm7xQ/2Vf2?=
 =?us-ascii?Q?C1yg0GaTP46wHd3ZDwg3uyUqS2UbqOi/R4olcPjSQbffYaFxszEnAl6aXzA2?=
 =?us-ascii?Q?JWnQ8hKiF2hJ9WHpzuxAt9OFuOoxFJiTtPbeYkGh6IQk+RwD5s8iQf4J5XU7?=
 =?us-ascii?Q?jlppctigy+oPxkF+jsmrLjUCCQLSMsCRfRRr6n6wO+/XwfjdB9BvvaQNvNv7?=
 =?us-ascii?Q?Yo5nsgOyBihAr/2/86R32ZicEHa2nUbwa4vD+J8q8yLrQ2YL+oxwKtMFswJ3?=
 =?us-ascii?Q?cUbWtn0fJbAOLhITlsqqqDD7cjxr5pfWeZ5awb4LBdL0+/wFQ45nkC4HyCyN?=
 =?us-ascii?Q?AK1vcQhAjL2YQlNg79ZDC07k9lulfr30kyQytw4sznDn9X3M3BjdAg9SqXl0?=
 =?us-ascii?Q?97nYViEzrlF7NrmXTcumXXOAUddkcyFDXIxh2NvycC06nwVvfMtw509IqJ9P?=
 =?us-ascii?Q?A/Pi+H9+vuWnWcCcdPXtkPoKw4Rhm4jjDCCj+YK2cu//HOob9uG90KdqQ5mH?=
 =?us-ascii?Q?5huDvNhZ07uLjPW7nTHlJfixmJCj5nPZuynyN/F4C0t9pReTIc9buN1few9X?=
 =?us-ascii?Q?gka0Sk1dWxLFrE1aq9t9REZvyHKquxOm5rOWpXSKEARNlKHzbwcd+WeEWn/T?=
 =?us-ascii?Q?4b0pMJzBPK3HDrr5Syh5tPGn9IsDPfs5mmOjg/VbLeKHWmFN2KmhJUjvzH/u?=
 =?us-ascii?Q?UC6ASzOyd3Js2WSLDkFpLaFQFM9I2yTmQ+8uW4BpMJpIGFggHCdDb94VX37Z?=
 =?us-ascii?Q?FuwMThm4H33xglNjhxapTwugN4QBIpJD2lRIpPJooRHKiyMsRTeLuZHw30x/?=
 =?us-ascii?Q?hz3G+Yn1LItYoT/bixfNc/F51m8VG+8Ed4g61J53gGGsKUDQEw9bUUtwmYm+?=
 =?us-ascii?Q?BJ05R5vf4VA+sJN9GyW2qfe3scVlE7gb4m3ceYkXvZXYNPnwuUuzPYRcq8EQ?=
 =?us-ascii?Q?3r4F7f6WirtxWyepbxyBU5hanFdXkdohvb7SckhWIZ7YMiBC01Uw8wIiZz9F?=
 =?us-ascii?Q?sS/wye4xM0K5w7tVb1TcRs3JbW+gBakYURecRHPpvV4F6KrsHsowifloX0Vp?=
 =?us-ascii?Q?Aw/p6ifrRW9cWE4agxuQuLaV+5Ec/8DrqnA0oeGM/96bmH9nKZdKjl0w15F3?=
 =?us-ascii?Q?nUkF3RiiapQa+DJVcvfz0Fe+UR9pi+WNQMiW3yA5AQkZOtFPxKIOjTrSbLya?=
 =?us-ascii?Q?GAkzAxYEqViTa2WREzqdsyUfFs7nPjiypJ+g9hlJciBmLVq2nPIAU7mgv2aN?=
 =?us-ascii?Q?+UdqkBNEju1o0eiMNpA5sXLdCd+fNj1C7PLMRxnR8aTrb/gnyjSWrajehYLW?=
 =?us-ascii?Q?LwAelAJw1+keV0RWIZjx2H9RRMwQmJ9yB1rS3BrHQFc6b//UnvfJIIn3dkTJ?=
 =?us-ascii?Q?dFrDrZKd02RRZzLrF5SbBwnB7PaMP0mHjSUN8CdaiSXYv1dQSskMk0DkArHp?=
 =?us-ascii?Q?PKhcgCE3+QwGiTcFfpBtNPavhYOg/QDXjQcssa2iiup6xJzutR1/2vNNSbWB?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 09782665-9f08-43a4-70f5-08de0c94cd1b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:17:17.1455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNybl1A5gTnZhBmjAg5yzPYGwg2tqUXWWAks2YA2p5KDXuf63PpmI8q24Hun4IW/otU95hAxxamcg6YAa4JjoEsJU55mcoK/xwEQrQynkwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7437
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

On Wed, Oct 15 2025, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Oct 07, 2025 at 12:26:37PM +0200, Rasmus Villemoes wrote:
>
>> In scripts as well as interactively, it's much nicer to be able to
>> refer to GPIOs via their names defined in the device tree property
>> "gpio-line-names", instead of the rather opaque names derived from the
>> bank name with a _xx suffix. E.g.
>> 
>>   gpio read factory_reset FACTORY_RESET
>>   if test $factory_reset = 1 ; then ...
>> 
>> versus
>> 
>>   gpio read factory_reset gpio@481ac000_16
>>   if test $factory_reset = 1 ; then ...
>> 
>> This is also consistent with the move on the linux/userspace side towards
>> using line names instead of legacy chip+offset or the even more legacy
>> global gpio numbering in sysfs.
>> 
>> As this seems to only add about ~50 bytes of code to U-Boot proper,
>> and dm_gpio_lookup_name() most often ends up being GC'ed for SPL, so
>> adds no overhead there, adding yet another config knob (or two, if it
>> also needed an SPL variant) for this does not seem warranted.
>> 
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> On a few platforms we now get a failure to build:
>        arm:  +   work_92105
> +(work_92105) arm-linux-gnueabi-ld: drivers/gpio/gpio-uclass.o: in function `dev_read_stringlist_search':
> +(work_92105) include/dm/read.h:1078:(.text.dm_gpio_lookup_name+0x8c): undefined reference to `ofnode_stringlist_search'
> +(work_92105) make[1]: *** [Makefile:2029: u-boot] Error 1
> +(work_92105) make: *** [Makefile:198: sub-make] Error 2

Hm, interesting. The same call is already being done in the same .c
file, and AFAICT not under any different #ifdef conditions.

But I suppose it's possible that gpio_request_by_line_name() always end
up being GC'ed on those platforms, but dm_gpio_lookup_name() (probably
via gpio_lookup_name) does not.

ofnode_stringlist_search is available whenever CONFIG_OF_CONTROL, which
probably explains why you say "a few". And I guess it kind of makes
sense to at least make this conditional on there _being_ a dt node
associated to the udevice. I'll send a v2 with the block wrapped in if
(CONFIG_IS_ENABLED(OF_CONTROL)).

Rasmus
