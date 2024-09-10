Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118E4ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BF0B88F75;
	Tue, 10 Sep 2024 11:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="VmiDf0pF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2203C88F77; Tue, 10 Sep 2024 11:34:28 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07F388F74
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGU9Wqttl21QDmH/lgkMOGzz1zATzCqUBzxd1chw/c7jZMx0+VC4ZsGSPcnGyfYnCgFfJJ2fXa6bpmXO1P3Jkbgs3F2DQNJLfbV2n+NPuXOmnGjyyAxFvcHf58AQNdH2f2De85KNMZgAB6l4omVXE8miSdEQPIYjzgm9y1oVi/dnrowpMpFy4QDQvbth+e8QIHwD6ln9utCxhtWn/Zx5cHpRQupMA3rF3RB1coK5OfYf+zFX31ztgrTg0E41d6jF+qxeOZyKd4hzgdMjKvzLmVluqQycLsEkkPsHB+af0u1NeTVLyzleP8YO4bsn/rQH3aO1afYCxSjfGXkFkub0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY0/XwVGnKXwCacYfZN4V1kotgQ2QavSWEh2IbeT/hw=;
 b=yEX48TuGcYAq0RVI/y8bxYWAcCFrazrBmIiGNhhqNKG7uKb504Y4u1WmrBkhR4Qg9ouBFsE4asmBH7Uy9NaR8jrMYMK8jaHM8lgDMabi8xu2SgR3dQt3zz9JaohRlBWvPCa6MjQ4V/Iv36/LqjlWRVjBNMo02z5gooJBF00LqRJJgTfQu0vUuOSr3TWqcEhhlfF57EVNPeNULS8wtXO1R4NpHtZu0H/REQN5cphYJclyAqFx3EuVpx93nYlsFv+HFEFmJvtJGDkhJ4NNhG/N6xkkxnxn3e6cgZIiD7WNxHwZ9UiDXNjJgT/p9mZn91wP4Vln/KcvNYmvVrC5lnFUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY0/XwVGnKXwCacYfZN4V1kotgQ2QavSWEh2IbeT/hw=;
 b=VmiDf0pFCWJQTho/Tny/cXFfFo2dmkAWXb9fVMKHul6eZdV9broVkffwejQW3UCaCOIc2yeaKId9k3NDkv+qts93BKJFyDDthydg1Cz2zIJxnPxuoQ/sOuWridTDgB5GlgZ7ahpY6+HL+sY6byPosj1Dt7ENtylYdtRtiL+Aenk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 09:34:11 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 09:34:11 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,  Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  u-boot@lists.denx.de,  Jaehoon Chung
 <jh80.chung@samsung.com>,  Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
In-Reply-To: <20240909143236.GB4252@bill-the-cat> (Tom Rini's message of "Mon, 
 9 Sep 2024 08:32:36 -0600")
References: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
 <87wmjli59e.fsf@prevas.dk> <20240909143236.GB4252@bill-the-cat>
Date: Tue, 10 Sep 2024 11:34:11 +0200
Message-ID: <87ikv3j1ik.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 373636be-e9f9-4d5c-ecc1-08dcd17bba02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?17FZo21VxUo1MGLkiGTiUhBbmbEW2/tPi7279/LhJCVHycRBwB+gbymJ9Bbk?=
 =?us-ascii?Q?jXKnmYi+j5JgcDZIKCBwzrzkThpHKY0socfDmi4htLqUfM5bOoM49kq4RCKf?=
 =?us-ascii?Q?lHg9htGLSKDaydINI0keoFuu59M88/V4XLnvlD+UcqOdYAISP/iFMa+GYqSe?=
 =?us-ascii?Q?tJucHD/DmlkYDAjkSIqryFl6077wDT/DAOKXTOlDBmyRx9Il02oSJrQR/Dz7?=
 =?us-ascii?Q?mjIBKWewblCNjWqQD2/LNN0K/nPFlELMulpOdd81hNbuElRmbtbpqczhRBuI?=
 =?us-ascii?Q?C/qPKAsP68/0JRWc6PWWBDZUdAxLzPWinrOC9hq9Sa7GwdHDoP1rpWqqV12L?=
 =?us-ascii?Q?y7huuBu9bHS714HE7b8y6EkS6CXj6uKIIZ5fxEr0RTM+rvpLhu/UtXlbKcmi?=
 =?us-ascii?Q?xr3a598i9lPAYMXhMBdNU7IOAXHcSJPu9uHsY1Sz+tHRDC6LhCaAMphZV+QH?=
 =?us-ascii?Q?iPlP+tRmVto9MFfW6P61C6ms/AphrQm7Nd9WdpVHsBKu/LCwpexZ5D3FeEqn?=
 =?us-ascii?Q?/ihANqGV9kfJfGFdHKM95NC/oMtg9Jt8LOoKcH54FzNVvHIL6B+MmwsTMDDr?=
 =?us-ascii?Q?pqtE6Y2bgdrzhjA7K97CZkma5E5wCOmKeKT9acMqIZNEeHrgmxHKEzx8gKHr?=
 =?us-ascii?Q?S4b3xfsTlAV5HlmlhEQ8Npov7Bdkvh0TwC8d570at8cpS51Mv2+VEHUudq+b?=
 =?us-ascii?Q?uPexVDWfFu5vRsjdZVsGba8NG8qFhzV622dTGwu2/82RRRAkkVF5CzB/mps9?=
 =?us-ascii?Q?GhPjIOV0IU3Vr5VRdY9MiY2Zmf+c6WhGe9coO9thiSu0qFS4ksu3UoUoivSA?=
 =?us-ascii?Q?kFJ2THYqq0NjQXfio0FN+2kwsgOSQbTUuBbBYkz7QhRUbInckU50686ZvbZM?=
 =?us-ascii?Q?lBuZE0etrzb0VquuaQWr3jztRUk/4UrmFBbXdZ5+MLaNvVeIcl/omDvOJhx6?=
 =?us-ascii?Q?wq2YTC3R/IO/nVs0/cFg4uPAI8CgKUVeXrMnrbBrFQ72XJo/3PQ+FzZI9Lw5?=
 =?us-ascii?Q?4vKeOu420XrZxQWyNZRDbmog6/cs38VqG5xbv7sJpKgM2RDSKjMu5s+wdKXu?=
 =?us-ascii?Q?Ky6hdzBR13DMe0c53RzoC/KWS7KpRbsROzX1h6cmysstuUw5pNxO4TVVYOw8?=
 =?us-ascii?Q?clscrvCSh8tI2vpUyIKETO/6XCLM+Hlem6xGH2PhvVabBgsesY4t7TAXFhgE?=
 =?us-ascii?Q?s/z7tPNGYgwh9EDiYB+xersiFEHyArOIAd5zSfozXHPT0UCoBAhN0GWOpnul?=
 =?us-ascii?Q?CLGu28eKHiv/DUwk3GlBqhDNCkswiNr42yt7KvTnSqfjr7JICZ2S8Fih6Vno?=
 =?us-ascii?Q?q4+Id87wgTZXoJ/mUwLzmoPA2rMnMfdC5Nol3v4FYfdxgKjPZWt4VzsxIGnz?=
 =?us-ascii?Q?fMC2jcuURPFsTwKoWkJFhw3eeMHp0QtlUcTidjMV6kbir/DsYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H2/2I2b/WQaKRwSo8tuo5CgEKDGIFV9KhXm7I4vlFIIbwo6Qx3YbeFoTNgwW?=
 =?us-ascii?Q?jM242uisssm0cXMvM8qkX0BImyxF35+wVpep6GA8tHMpTS4lOOo+LjncZ3f2?=
 =?us-ascii?Q?Ndg6zR8pX9KWmvXVGWgJbyzBSLMD2IqucMWf0acVYELTTD5Ct0S6178N1loP?=
 =?us-ascii?Q?1jbxSKhdCzO0y7dwIMBtGaiIwS3IeHjodlxHCFUf+DvK+j/0uZytXt1qSQle?=
 =?us-ascii?Q?4W6NTC5ln136KcZ/+z3NABOSyj8cmHgBbaLO4YY4sMicwrBimt3TpUCbFiv2?=
 =?us-ascii?Q?Vzg7Hkqik7g9Tv7kNIQNAL3oM2h2NNIVGlN/e2VZV06/srvZW1nooFnYPQQk?=
 =?us-ascii?Q?M5kJe+qNf5odvBy/lHIH4s4wrf2cxQhh877fOjrXm2T7seIrPAmBXJSq+dx2?=
 =?us-ascii?Q?Kzs0MTSx4CujKoJUgKmSW+g6K4YLdQJMV1bPc9dRItalhz81Hy3U1/6jlCe4?=
 =?us-ascii?Q?jAf1iSlvqZULS3zq3yrtVaeDJA+90P3ifm85waOjeGaUpM3E8c9Jf7NpTwev?=
 =?us-ascii?Q?2QozI8AyMJLINrd3v8hQXV7SIIT87wAKTIybKS0YtxVK9SgV0xEd4OdXqA5/?=
 =?us-ascii?Q?R65LS/JgFQaokomnApUBlpHY2YHUWtrcswvX7oRh6KO4G+wSOYWKFC2j4RZn?=
 =?us-ascii?Q?WOwGEUZuvW/jX+J0HxjUWvwFg9lxzP/lpvBTLs0lPsvf5FcgVxcytzzSze9h?=
 =?us-ascii?Q?RXh5TxPufWBZXlxTeqbDfwsVoNtNLQ8t2kL/O4X4Z0ADWhCdTv2I2V5zXAWd?=
 =?us-ascii?Q?MADAFdMZcwGeNjgjHzM+Uj/iWeGRwFhTFWDD1PsQpFuynImywTbVyOdaUOjs?=
 =?us-ascii?Q?sFUZ7+8eqbPG9ERw+vjn/992Bjzt31DQuQL7WMQakga8+1zeHiuwPwlAzXYT?=
 =?us-ascii?Q?AO2SrHbRbw30YSOFf/5w05owo7KDaRk4tMP3bsZMDgDbdLzT0jhf8ObLYeXA?=
 =?us-ascii?Q?mXysemfzBm62pdXp/PJs1AoZsNKgdEyYbmBoeT32XiDzrC5fESQFwST0JBOZ?=
 =?us-ascii?Q?feKvkOQes85cmiO7xEh2N9TCqW5LLp9u+zPwyC6tmGs/hbW7ZtkyyKEbnDml?=
 =?us-ascii?Q?VJMQTuJ/Aclv4yd1+NBTvhD7xOV+cv5+vB7M6mFPfqSEwJlNte30lpNyDNRr?=
 =?us-ascii?Q?HEvXjFuTe1aQ4iL1CTRZoxuIpWW2LYR8w1dUQFNnpDyWHp0N/nXf0dm+/9N3?=
 =?us-ascii?Q?bFSqXQihFc2f8X1mPhLwaX33bHUAUvgS6O9XhTFMFM+nf9nXZTpnaReXQcIb?=
 =?us-ascii?Q?CJ3jVIuR3TQiwVZ7a315/g6aNdZ4Bw+uTZ8IlVnMhGBMs0psSPbEFzUUV03r?=
 =?us-ascii?Q?JJMA99cE5CZHG6dCkyq2gmK6dnSDxtz8RIBlQgy/J0TcP4BTVeZ+Lb7elCli?=
 =?us-ascii?Q?84rKteB/O/FKYvyfcCDgI1h9W/eks0oUAnH9Ip424/GPVGUVK+lhmWr85Ldb?=
 =?us-ascii?Q?NvF55jmd2n+jjOQ/B5+ye03eNJDAsJl8Dzxp0VqNRH5WdvWEAmlMHF38hHHo?=
 =?us-ascii?Q?2QfIM9SuDf6Dsv0tpIAuaUqX5fAc29FZAwvnvvb+2WXlUzJxDlPseFSsGdkW?=
 =?us-ascii?Q?8T9E7WrhhYiB03jlU63ChOXayA1+eLy5RcULlw3HgEmsVyLsvhETfxDTlVW8?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 373636be-e9f9-4d5c-ecc1-08dcd17bba02
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:34:11.2635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVSUaCMG17qUC/5laXQwfi4rNh1r5Lu/oT3lmLCoYx8cpFJATugH2yApzdPKT+fXptK4CiWQ5uOn0tCZvF846Z301ML68gwacK34X3lYaEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6235
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

Tom Rini <trini@konsulko.com> writes:

> On Mon, Sep 09, 2024 at 10:46:21AM +0200, Rasmus Villemoes wrote:
>> 
>> 
>> Again, just do cyclic_unregister() unconditionally.
>
> The challenge here is that Simon asked for all of this as part of
> feedback for v3. What are your thoughts here, Simon?

No, AFAICT he asked for not adding new ifdefs to C code. But if the
existence of the cyclic member of struct mmc is conditional (whether via
an ifdef or via the CONFIG_IS_ENABLED(FOO, (), ()) construction), one is
forced to have ifdefs or that very same CONFIG_IS_ENABLED(FOO, (), ())
in C code. Which makes the whole thing rather unreadble IMO.

Which is why I did the series to convert the cyclic_info to something
that you embed in your client struct, and which goes away (has size 0)
when !CYCLIC, but still syntactically exists, so C code can still just
do &mmc->cyclic and everything works. No ifdefs or nested uses of
CONFIG_IS_ENABLED() anywhere, and no need to guard the callback function
or mark it maybe_unused.

So I tried fetching this patch, build with and without CYCLIC, then do
all the simplifications I suggest above, and build again with and
without cyclic. No build errors or warning as I expected, but, comparing
the object code does reveal something that I need to ask about.

Assuming CONFIG_CYCLIC and unwrapping all the CONFIG_IS_ENABLED stuff,
mmc_init() does

  if (!mmc->cyclic.func)
     cyclic_register()

while mmc_deinit() does

  if (mmc->cyclic.func)
    cyclic_unregister()

There are some lifetime issues here that I think are pretty
non-obvious. mmc_deinit() can get called from the cyclic callback
itself, but nothing ever clears ->cyclic.func, so can't mmc_deinit()
also later be called from, say, mmc_blk_remove() ?

I also find it a bit odd that cyclic_register() is done regardless of
whether mmc->has_init got set to 0 or 1 (i.e. whether
mmc_complete_init() has failed). So can mmc_init() end up returning
failure, yet still have registered the cyclic function?

And what if mmc_init() is succesfully called, later mmc_deinit()
succesfully called, and then mmc_init() again and finally mmc_deinit()
once more. The first will set ->cyclic.func via the register call, the
second will unregister because ->cyclic.func is set, the third will
_not_ register again because ->cyclic.func is (still) set, and then the
fourth will crash because ->cyclic.func is set so cyclic_unregister() is
called on something which is not in the list. But maybe that simply
can't happen at all because mmc_init() is called at most once? But then
why the conditional on ->cyclic.func in the first place?

Rasmus
