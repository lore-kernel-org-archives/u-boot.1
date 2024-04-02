Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1546AC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 16:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B6CF88166;
	Tue,  2 Apr 2024 18:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="h1ObuLy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B63D788166; Tue,  2 Apr 2024 18:42:58 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF0B88022
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 18:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB6nZZv8DUDoszGpTemmdrgX5aEQvPA5kDQ7WqgJylmeVlA3pOzr+5vD9B1pItkbOVkJZs2oRWQLOSn6I9lEhPtbxCy33oToEj9nBk2I/z668e1A/pSWACuCnfmK7VbPzoGHiNzgGk4iKcNB9dhZehMgA9J4S6JzBzFm2cBxPo2VuhWMvUn4keeFAvlz5+xE3zOtphxA8lufv84CLOcC6sFxJnXLaRw4K2vbUbJKCbVoP9MCC36gL7QuwUB5ofuwKwaI3uMut/QumLl+Gyj8DQwGZ4HvRYSApTHUOBtbeCOUyqkzHR4hiW/dDuDQRIjHpIKt6ONVRMnV+lEjmcMwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NkSW/5WpF8+voNFhyU1s7WE8l0hfmZr+CSpxTYBH1E=;
 b=mjiubvjrPK8KebQdrt6saTqgJt+2IUFWHIiMuhIurXXkt32tQAmAyMU/zqgE9c2nrocRpab9IVGnoWOnqdHmPkLUDKWaKx4BwUFkUpreR18evEfU208Y1jbpj+5VmYOSAz4UH9jCwyo/P6fIZ0W/zbVxLXsL+7n9KvYMSc2w2Q8SWAUk0olYDQbA84u4X5ovNtifPIjoXTwkHB3cyNT6b/cwnTK7nUDCrXIEPiOhIvM2Cp9i2VJpkkjV9lQzhEq3RVh6LSF7ZqqQbD1KLMxLbA2/tBL0xk4/N5MkC3oKRcoAiQyipgc54wLESSyoOE0ECdqLlq9ZOZOY2v8dimMp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NkSW/5WpF8+voNFhyU1s7WE8l0hfmZr+CSpxTYBH1E=;
 b=h1ObuLy89+OqiUdfs7IPsM9LbSA4P2ZhaTu0w7M56+TssSrCZTkWesvETBqaP7fxb41N7JbvfhtHh6TCmSR6g6rUjUcdgY4RTlTUaSSZDOBKhCutQCgq7JmrIqF//A3/0BGta4l1yH1/6PzFMWcmbNYOGTo6/DgqgwsoITfLs+muz9AHctWJWB1kLQZaxUHe/SW1RNZw8gXsUoI7edKgLO95tZ9LUug0K0PHI6KIkMsdruEAMUkNlLmEiJ1xrgayd6OxbDWdMvTPDtkewdMown7Q2fmQyGi5XVvSLmxX67p0bvdXF1AxROZlZJ39FGi2jiFH/GxvpgClhWZcnSEREQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7396.eurprd04.prod.outlook.com (2603:10a6:20b:1da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 16:42:54 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:42:54 +0000
Message-ID: <f23d4fe2-a735-44ed-95d3-146a13764544@theobroma-systems.com>
Date: Tue, 2 Apr 2024 18:42:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [V2 PATCH 2/2] rockchip: Switch RK3568 and RK3588 to new RAM bank
 logic
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: naoki@radxa.com, cym@rock-chips.com, gajjar04akash@gmail.com,
 frattaroli.nicolas@gmail.com, jagan@edgeble.ai, cnsztl@gmail.com,
 andyshrk@163.com, chenjh@rock-chips.com, frank-w@public-files.de,
 jjriek@verizon.net, eugen.hristev@collabora.com, tom@tom-fitzhenry.me.uk,
 jonas@kwiboo.se, inindev@gmail.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240401181435.553351-1-macroalpha82@gmail.com>
 <20240401181435.553351-3-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240401181435.553351-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7396:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN1bnN40O+ZByGLEvwLe5c9sD6jy/2dz35fYBhlGsh0mwOKBS0ZK8Egd8Fua7/p87qAOKkBKD7ggXPu3AM4OXbaHdWTTkSJeyykq4j8ka/1ye0G+qz0qJelmLvFB6JZqB2kK7u+cb0av1l1//QkquiR1mdsi7na3OmvTJO/D1Lpt5IPPzaavMxYlcroRQLGjKaBWra7tJTiqGRvGEqm2CDQ7hPoTfWCHbBWnlWBt10fMQCfMBHyRpvkXeNbfExW+SGfr5h0DfOwgh0Ku/O64U8awuS43CFwygggKk8MgrqRP64pCfvqkqR3cQg3WIvKASz1qdTWWe4oc3984F8fvZvDPEeGPpfpY3dnu4Gy+1+RrFtqIS/0q9EbzqdCf51lp2GOtKtxAsA35UP/23MncwFwVMbWQZAiZGcibTkxZI9Ex2oikf4oLWMDE1+0IKfKasXFmnYmvaf3N21X9Pi6e+gxCWPoKWW2ET3GFdmiiv6JtTlYTdNNgl1dFVvJX+e3MpaaZE1nbehuFBEn3+IbBUv/srh/qExRwXYggVNGuUi+8j8ewUy4Bt7/aDOenL5NF2qHcrCGn1Sk043HOdxN3uKsE5ZYz0soqlR4PbmnCN/O11mrdR8TLzozRivg/eezMn8vnYr3sGCP076AK+Fq8n88bGiBncMNe18VVC6V2/JM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklRTXNIUVdIUG5PeGJRdytzWEFlbDZycm53bjFpNVpFb3NwYUdrVGprdXVN?=
 =?utf-8?B?UTZYdkRGc0pyd3F5bnAxWldySy8zbGlkcG5QbjNpT2ljTXZoVUxPUndZUzdn?=
 =?utf-8?B?YVRCMUxnZHNCQXFnQkk0K2JGUFB6cnNQKzBqV3IyWFpnSlZaeEVpcEpUWTY2?=
 =?utf-8?B?Q2pkbW90NXpnV2VaSmJQMFh2UTFDZkUxQ2xZTWtsSmliTkdoUGlpOHI2K0VU?=
 =?utf-8?B?d0VPRVpUZE8vbXBCVG9jUTVBbDl4UzJKSHRqVjMxVGFKUVBhVW41UjZGK1FP?=
 =?utf-8?B?R0F1eEVKbFE5NWd0aWwxY3F6RWw4RTdudVhKWis5L3ZEd3padlMzNkI1R0tF?=
 =?utf-8?B?dzJmM25QNi9UUmpFdmg5VlduL3dKWFlWVVlZYUFZM2F3dU56SGloL2J5R0dm?=
 =?utf-8?B?eVVnM3RJTEdrZTFMdTR6S3k0dGJ6L1grRS9tdlQ0OW5KM1ZaSmtrNVNIcDF1?=
 =?utf-8?B?TDJEcVFsNnQ0bTl6c2huNlVNbnF6eDFmSTExeXc5emJnNHQvZjBZZmN1NGZC?=
 =?utf-8?B?SVNPaFdFdTVyNjRHZmdMbmZ0TU9sT3F5SUM4V2lxM0JiN1ZxQ0hQTloxZUpm?=
 =?utf-8?B?dGFHU3hwUDJnajBaQStrYUpRd25reXhERE5PVTBJZ0YyaURPTDZDNTJKY2ho?=
 =?utf-8?B?WjJtNFJ6WWg5WTBaLzBTWFNFVHRTRW03WHB4c0FBdTV5RlFKbzUyMUIwc3lW?=
 =?utf-8?B?TTEzSDZadkNsMDE0dlh0cnJCdVV0VUdXbTRhdzhCdXpiNUFoOHo2L1JIMndp?=
 =?utf-8?B?ZHN3VXdHTWpPWkUvN1hCWFJPUEtKdFpTdFlnOFBXSDg3ZUIwbkozR2dkR3Va?=
 =?utf-8?B?S2xjZWtEby81bXZPbEZoRUNPNUtWZDA2aFBHL3o5S1VWNFhkK3NlZGQxR0NN?=
 =?utf-8?B?RDhmZnJSMlhOQkFVN0xDenZxUmZXWmhHK0VqRDl6dU5qQ1NxM1lPdEZpOGdU?=
 =?utf-8?B?N2Ztc2tqM1lFZ3FuNG5VbXVoaVNlZFZicUhFZ1ovalpmV1k5TnFRNmZUSnBC?=
 =?utf-8?B?ZElpKzFqL29oMmpFcU82cnFLUmxFdkpGaVBySkQxcUtldEFDaFZqRTArRHd6?=
 =?utf-8?B?QmxnWXFlZVBrVHkvckhqRTI5cHZMMnRONjhicGR4YUx0Q3ducmpCak1BcGZy?=
 =?utf-8?B?K0l5VDZqRnB0Q1llb0s1MktSVGlEZHU3aXo1QW5sTWR4dDJUOFJtSjNUYitU?=
 =?utf-8?B?amlBSEJKU0k5d2M3eDlRUnZ0UzQ1cVlYcHZOcFd4aTRQbS9MYnMvRVN3SXpW?=
 =?utf-8?B?WWJueUlJSC9oa2N3YjA5YlpMQ2FPSVNCY1VNak5EdUxZanZXa25kejNDaHQv?=
 =?utf-8?B?ODFpdG1nTWhOemVmNC9FdlM1NlF0QlplUWtYOUVadlRhV0Yvb3N1eUc4V0w1?=
 =?utf-8?B?MVI2eHMyeUlKajh1K1lyeTd3RDVwVm56RTVmd2dvSG1JRWtNN3Q1Q202M21m?=
 =?utf-8?B?TWtRY0Zaa2RjLzliajRaUjAyWnlveXYrWU5JaG5LdXQxczhIYVBJd1RicWI1?=
 =?utf-8?B?dGY0akFQUUZISDZhYkc4U3FZYzFFbGJQejRiN3NrRmxCNXprTzBET2V6OThm?=
 =?utf-8?B?UXRLTWZjQmVWaVBUVlhLSDlGTnBXYWpCbnd0WU1zUHlrUXdCeGMzSFZ4RDNj?=
 =?utf-8?B?SmNVMktJVkh2TlFXTUJvSzgyUzFTVTRpaVp0MVByNTlhTi84Ym1tdkJBV1Fp?=
 =?utf-8?B?eG5MK25CZ3IvSGlMRW56Wmx1cWI3SDd2b0NhU1lvei9pUjRITForMEV1dVRN?=
 =?utf-8?B?U1B4c3JJbXJwNE9yajNrRHkzTHVIVXpybUFFYll0TWhEZmpVcmZSMVhCVFdS?=
 =?utf-8?B?eUk5eGxuRTN2WEgrb1dHUlBTemZwL0dRd28yZjdHc0VhZDF2UzRHNno0OG9U?=
 =?utf-8?B?U3pZT3RzdnJ4dUhneDV5SDMva2J2eXU3VXg0cUFoaWl5WXlKRWFCd0d2ZVhM?=
 =?utf-8?B?MHJQZTgwSTNvUlBvY1dUcXJDOS91S2JWV0lyeUZLZHBZSERhblhWTXFBaEpJ?=
 =?utf-8?B?VC91UUFwNjdDZjhTVnhaK3N6SEhNUURzMUFlaVIrMks4SDNMTHVwRDk1ZWFB?=
 =?utf-8?B?K3FrVEwvS3c4OXVKM1Z2bUJrM3lmWmV4Uzd1NHpHWHc2cDIyQXN0cFViNzNC?=
 =?utf-8?B?VFZ4WGErMUtTM1J1VGlzekd1VjlWWDJmR0piWDRFZFR3TjAyWGQxYVFuZmNk?=
 =?utf-8?Q?9S6PacHg9cN+pyQ9hkmOvzA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b952b1dc-51c2-4f98-a477-08dc5333f1e5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:42:54.7604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aVDR4/It8r8jng4LtvAFLx7hrwP1dfqSTnOixsNuUVK/jdFND3MyS1ZbGn2rxDfE4dVMjGixy99RbhdOfLrFyQF6l8D1ehcWF15i6njQKFif8dviYCMW5GeqT0xpVix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7396
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

Hi Chris,

On 4/1/24 20:14, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Switch all RK3568 and RK3588 boards to use the ATAGS based RAM bank
> logic. This allows us to access all RAM when >= 4GB of RAM is available
> while also automatically creating the memory holes when >= 16GB of RAM
> is available.
> 
> Remove the board specific logic that previously created the memory
> holes, and update the CONFIG_NR_DRAM_BANKS to 10 which is the maximum
> supported number of banks using the ATAGS method. Only the number of
> banks found by the RAM init code will get added.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Could you please rebase on top of next to have all new boards as well? I 
don't see my Jaguar in there and it feels sad being left on the side :( 
You may want to have your Indiedroid Nova patch based on that series as 
well?

Half wondering if we shouldn't have CONFIG_NR_DRAM_BANKS=10 forcibly set 
when ROCKCHIP_EXTERNAL_TPL is used?

> ---
>   board/friendlyelec/nanopc-t6-rk3588/Makefile  |  6 ---
>   .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       | 39 -------------------
>   board/pine64/quartzpro64-rk3588/Makefile      |  3 --
>   .../quartzpro64-rk3588/quartzpro64-rk3588.c   | 39 -------------------
>   board/radxa/rock5a-rk3588s/Makefile           |  6 ---
>   board/radxa/rock5a-rk3588s/rock5a-rk3588s.c   | 39 -------------------
>   board/radxa/rock5b-rk3588/Makefile            |  6 ---
>   board/radxa/rock5b-rk3588/rock5b-rk3588.c     | 39 -------------------
>   board/rockchip/evb_rk3588/Makefile            |  6 ---
>   board/rockchip/evb_rk3588/evb-rk3588.c        | 39 -------------------
>   board/turing/turing-rk1-rk3588/Makefile       |  6 ---
>   .../turing-rk1-rk3588/turing-rk1-rk3588.c     | 39 -------------------
>   configs/anbernic-rgxx3-rk3566_defconfig       |  2 +-
>   configs/bpi-r2-pro-rk3568_defconfig           |  2 +-
>   configs/evb-rk3568_defconfig                  |  2 +-
>   configs/evb-rk3588_defconfig                  |  3 +-
>   configs/generic-rk3568_defconfig              |  2 +-
>   configs/lubancat-2-rk3568_defconfig           |  2 +-
>   configs/nanopc-t6-rk3588_defconfig            |  3 +-
>   configs/nanopi-r5c-rk3568_defconfig           |  2 +-
>   configs/nanopi-r5s-rk3568_defconfig           |  2 +-
>   configs/neu6a-io-rk3588_defconfig             |  2 +-
>   configs/neu6b-io-rk3588_defconfig             |  2 +-
>   configs/odroid-m1-rk3568_defconfig            |  2 +-
>   configs/orangepi-5-plus-rk3588_defconfig      |  3 +-
>   configs/orangepi-5-rk3588s_defconfig          |  3 +-
>   configs/quartz64-a-rk3566_defconfig           |  2 +-
>   configs/quartz64-b-rk3566_defconfig           |  2 +-
>   configs/quartzpro64-rk3588_defconfig          |  3 +-
>   configs/radxa-cm3-io-rk3566_defconfig         |  2 +-
>   configs/radxa-e25-rk3568_defconfig            |  2 +-
>   configs/rock-3a-rk3568_defconfig              |  2 +-
>   configs/rock5a-rk3588s_defconfig              |  3 +-
>   configs/rock5b-rk3588_defconfig               |  3 +-
>   configs/soquartz-blade-rk3566_defconfig       |  2 +-
>   configs/soquartz-cm4-rk3566_defconfig         |  2 +-
>   configs/soquartz-model-a-rk3566_defconfig     |  2 +-
>   configs/turing-rk1-rk3588_defconfig           |  3 +-
>   38 files changed, 26 insertions(+), 301 deletions(-)
>   delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
>   delete mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
>   delete mode 100644 board/pine64/quartzpro64-rk3588/Makefile
>   delete mode 100644 board/pine64/quartzpro64-rk3588/quartzpro64-rk3588.c
>   delete mode 100644 board/radxa/rock5a-rk3588s/Makefile
>   delete mode 100644 board/radxa/rock5a-rk3588s/rock5a-rk3588s.c
>   delete mode 100644 board/radxa/rock5b-rk3588/Makefile
>   delete mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c
>   delete mode 100644 board/rockchip/evb_rk3588/Makefile
>   delete mode 100644 board/rockchip/evb_rk3588/evb-rk3588.c
>   delete mode 100644 board/turing/turing-rk1-rk3588/Makefile
>   delete mode 100644 board/turing/turing-rk1-rk3588/turing-rk1-rk3588.c
> 
> diff --git a/board/friendlyelec/nanopc-t6-rk3588/Makefile b/board/friendlyelec/nanopc-t6-rk3588/Makefile
> deleted file mode 100644
> index c1c49b1970..0000000000
> --- a/board/friendlyelec/nanopc-t6-rk3588/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier:     GPL-2.0+
> -#
> -# Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
> -#
> -
> -obj-y += nanopc-t6-rk3588.o
> diff --git a/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c b/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
> deleted file mode 100644
> index 99bbef964e..0000000000
> --- a/board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Copyright (c) 2023 Rockchip Electronics Co,. Ltd.
> - */
> -
> -#include <fdtdec.h>
> -#include <fdt_support.h>
> -
> -#ifdef CONFIG_OF_BOARD_SETUP

I think it may now be possible to remove this symbol from the 
appropriate defconfigs? Not sure though.

Cheers,
Quentin
