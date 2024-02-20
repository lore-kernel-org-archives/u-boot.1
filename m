Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1D2C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD05C87D71;
	Tue, 20 Feb 2024 19:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Ze9qmlsC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="2T2OgFA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0873587FF7; Tue, 20 Feb 2024 19:43:47 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79EFA87FF0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=CZPTATBTduaRhUmY9QCt0/Cx+wcFiWwHnvZwawHtNXrPcTjnNk/kvJQkPi2si1WAePXNvtkwiJKIUHciokuwreBLCkD3Tv4/09c2BaFp5M56b5x/mNwqnhOXxea8xN3mXK5yMsrc5l6ra2jTvof4gStUwOEmrgmRrena8rX3Fqq1BgccRCmHGBgAYJaeHjztsR1vxvyvQqTTm2w8a+2wgw8vZvtyPm7N52DCQNZTzD+XAvELsMqe2UBjzqBS5ofKGo/tQlh4gasXrh8v9JXnxYiBlBTwn3AOoiwFms1/vBhV32npRpq81WonxOvUzyxtRb4rfZEaCMiCA3WyYFX7bA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/c7dIah4s8ey6jydNtWvFQg+bnLQjVIYO261fpAvr4=;
 b=gW0d6SCGK9VqfMq4W6NXPERkiVmaK9b4XxZA/+vDe9s5PapqmwtY50uw4GLq8oxnxeZA/qsC0jZMfqUDJaHbHBiN7XRUeEyBWvpAaKmyxtAJS6BAL1iH1yYpktA2kRIhJZkn4vo8wyfa3G5/sLxTV3SqIM3hhSjHsC01mANL9uzXGFQu/gBLDZftud3jC9z8pfcrATy3f9SdlPADON13ZXyLA/mK2lWZfNvJjLI8PbnfjcEIOtLVZ+QxsA4LKOwmEJmW4q7LcEqClDn1NN9s5wvjlIvYBQpI1cul7vwx3xGkkKO1lHnxKLGwFmRBwa1AinDqibTIjVecLieQyhWk7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=amd.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/c7dIah4s8ey6jydNtWvFQg+bnLQjVIYO261fpAvr4=;
 b=Ze9qmlsCs/0h67rVoWL64+oitrxxCJ7dRAlNqCta11TFdxFV8GldExVH+iTpdcioZv8NsbBaB2bdc3RN/j48aQcmIr/bHy4rBOCP57RW1h2unkp6gdNmMgxldzyvlyhmviluGmWRgUAbQ1dbLa3SkXH0CqHAJmJ7aDto3SHTptZeUzrYogTqtrrCSsQ2jeC5JApKZ1k9SqT8PixI6uGf9bymdQWwLYz8jVox8WuCbjgpsvYBwTQWNEzV6v/3ocdirMNfAHoo8P35Ylxfe4qt1rx51NhtGctMxJW+DjokAp9tUjfDiql4TXjChnxGsCGxVdLeqk1R4Boke7N0O+CwFw==
Received: from AS4P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::18)
 by AS2PR03MB9223.eurprd03.prod.outlook.com (2603:10a6:20b:5ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 18:43:39 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::f3) by AS4P192CA0030.outlook.office365.com
 (2603:10a6:20b:5e1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Tue, 20 Feb 2024 18:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 18:43:39 +0000
Received: from outmta (unknown [192.168.82.135])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 D536220080F8B; Tue, 20 Feb 2024 18:43:38 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (unknown
 [104.47.0.51])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 308B42008006E; 
 Tue, 20 Feb 2024 18:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+80E4q/wx2221wkZkBxDi7SOhCY5RXJ82oOLjZ91cidRvsIB6dqNCCRsARQwPQPLUuot+sKJTWAKsJ4vmwXW+KINhBaehtz0KLfL+RyCJ2HJfjWQz5JSLhsMJWX59ni+bTArA7axDT+TfIgTvsSJGp36S660Ml5zM8ha830OeNZ88MMImw6B2QhsSQQm4TvHu09uk3aOvFpv09PRv3WgKBrjon7jslX5xxiGi4dknd117b8LCVE+ejF3sNY7DOdeJ+juOloZBChpKFI1SVnaz/fkeY+jKzIXLwSJyEQ6unmfmkHB0TVsWnMejEzUcImNg94ZJ+C04uhJO0UMOLa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCCvjnK4Lkx+dY4KcQuF2FHPOKCRLMuzstwPBKLXqGA=;
 b=Esv7oSZzlxOtlTh94OKIWsdzrA9n6LxYigMNrvpmV4sABbLafISJGl7SQtxxqIVfIGOIFzaKbiKjENzgo6pxdnjasFcn+e9Rrg5UfMBejdbbC6UpTB25ptnUxMbjWI7B9uK+g/MOMA6o+MOsZeJpWCtesGpmtkIhsi+UDGXK4XCsgujmZr3sHXVOyN33SCi/dZwNO0ushH8pFyEUd8Ms+0INKBOinekJhgpUoEr93xjFoAyXohzbjpEdz4LcG4KwTTzl9OX4YxU3AZdhVmVBEbONGpmVmuff7pV5z3VXiVntC5CV/Uk0KLPhXrC53dt6sjWn7BnDZuXtWPhvNAuY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCCvjnK4Lkx+dY4KcQuF2FHPOKCRLMuzstwPBKLXqGA=;
 b=2T2OgFA0WrP6gkhQtL+vwz4L2TRt1o/Cnq3bC7BDOyMnzWAGijX8wLsALAMmUSSH86HbJJ++boSEajZafTLKwnleWD31Fn5ZiQGb+J5k3rvrXTEyYZ1UaJuRSg919T/F0AG/yB8nEN3/H7S8NWh45tFDfNvzU958IbTmed97NjfcdWdZOBjIBj8gYL4ZDDAPwN5LxPih52QcGnOb/osFIX387WDE0wDYU6aUSLdP0wLbfGDhFRdY2Ci4bNJS2Vu4yeLPSROGP5D5hsOtHrKYfcDiB/2hfXx6pIAPR2TAvdEDeSCN77LPg7xQuGSnqFQ/QJl3tFTy54OunwNKpEpF+g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM9PR03MB7694.eurprd03.prod.outlook.com (2603:10a6:20b:41e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 18:43:34 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:43:34 +0000
Message-ID: <84443f0d-817c-42d8-a70f-f656e6ce79b9@seco.com>
Date: Tue, 20 Feb 2024 13:43:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Support semhosting boot method
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20240215171918.3729508-1-sean.anderson@seco.com>
 <3f6a5971-a024-4eb2-bdba-76071fbd9bb2@amd.com>
 <e9fd399c-34e2-4c54-a74e-d1a3b84fbcdb@seco.com>
 <326f67f9-a6de-42e3-a2fb-9d649520557a@amd.com>
 <0ab35778-ae8a-4eb2-a021-ee8e3a9815be@amd.com>
 <4a2e8e89-36e3-4e58-9f14-2151fc907081@seco.com>
 <8561797f-3b77-44af-849b-faa555e244bf@seco.com>
 <5816ffd1-4105-49b9-8026-026a4195fa00@amd.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <5816ffd1-4105-49b9-8026-026a4195fa00@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM9PR03MB7694:EE_|AM4PEPF00027A68:EE_|AS2PR03MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: cb436d52-9e38-47ef-1be0-08dc3243da91
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IY+IutmPOwdKTfLAzWHnS9246qssYZlEgp7wkWHDnFHA3l5Q0LzTUEvtklU9RtXxjhTVSYg5e+p0VLt93KLen2D/aUlqHrQPtRMYJFeh3Mb/fCewZ6ZbS7nyysn6E+2PhlDuIR5+y5PRu38UtSzxQJgf0xpbpF5N2ru30xhxbmvZRCWfFLusMmbUbzEv/4OM9ihM+YvyCbeDl1CargpTj95F9rGXQR8Ph/W7OjjafpABoogOQMx/3YFkUDTj6Qen/WiW9o8H+EXs/nEsPafDLIrCj5OZ4bralgQP+/VtTNG9R4ouKhHvmax/M5ukl4f82WPfNk4u8ujyO1Ngp0IINlgxrqJWDKOAGl/g9igEbElhDRd2BAu2E2dL2gAgSKouz/vSbDwu+F1/Qi/wQYiZpds3QZ+CO2GcGkcLYmpyF9e814BtGgo5irhwKRt65vVYf/aflz6Tumwn2DEwdqZgIKOQlPYZ/9aA3xlCKSUSUZ6DQrvuepc4QbWq4/XR+h4U2/TN3BXxpYd/JZks22OcKv1/OYKBMUK/oPDvF4p48LIV7qqMA5ZXyxHcd2dJJHtNmUsluEK9NMhhZWKSnQGgKuyqZpvDGaDd53R2z/f900w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230031)(230273577357003)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7694
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8792c429-9872-4c97-2b61-08dc3243d793
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JubuHuWIiFbF8Q0UkWnYM7mW+cOw22A3IhZeTlFi09RAZ7DvfRwx5T1kNTCqJ45aVBwQ/CdDaEFfhnzlYJYcPg5Jv9SFTlnUG7LN/OkxnysvylFcRsOFWWAVVsXF4MEmGigNG6/6Gf8Q0i3iJOqbPz2usJ29glmTp0qyNoTV8bNRTy5gJJEJonBEag8OSSGlZUk5AY7bCdo5BvAphPLg4XnWRQOybfnqDa0o1ul45OmXJ8jKVoALrYKj15CoTyry+N12I/6iJ0q+IqlmSCE2oclUFfDuf/74G289CGki97Yu3EDxAfvAeYdV2QqidYgBrdD1yv0OKqScWmg+VmJTlVKPBc617EjKhNUWzomxjzz3S1CgotDYs9jj6WVh8rB5VskCNWlRsxCI4RMrdvcB7t2yJfU/mvIdcv5dX5hiRQXz7JrKMrtwWooZyqEXsnKXBsx1/Jnno1yOMAbke80FRRIocMC0ymkqvU9VAI67O4uqPPnyf2F5gXOi6gDVOtgcEbFVF0k3/VRWS8JMF4z1F9gA3HOzCE9FWJ4Uh62CTxoKVEIM27p9saQgNQOqxH8znUAo+D6pNdWeUx0+CRXGP3MebVnseid4mVr3N4ACu0X6vCOfIB93rEwIE1vn+KJAyNcS+DzLEFQBi41W9ow7w==
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:43:39.0439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb436d52-9e38-47ef-1be0-08dc3243da91
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9223
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

On 2/20/24 13:24, Michal Simek wrote:
>
>
> On 2/16/24 17:09, Sean Anderson wrote:
>> On 2/16/24 11:03, Sean Anderson wrote:
>>> On 2/16/24 10:06, Michal Simek wrote:
>>>>
>>>>
>>>> On 2/16/24 14:48, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 2/15/24 20:31, Sean Anderson wrote:
>>>>>> On 2/15/24 14:08, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/15/24 18:19, Sean Anderson wrote:
>>>>>>>> Currently, when we boot from JTAG we try to boot U-Boot from RAM.
>>>>>>>> However, this is a bit tricky to time, since the debugger has to w=
ait
>>>>>>>> for SPL to initialize RAM before it can load U-Boot. This can resu=
lt in
>>>>>>>> long waits, since occasionally initializing RAM (and other things =
in
>>>>>>>> psu_init) takes a long time to complete and the debugger must wait=
 for
>>>>>>>> this worst case.
>>>>>>>>
>>>>>>>> Support semihosting if it is enabled, as it lets U-Boot tell the
>>>>>>>> debugger when we are ready for the image. This means we don't have=
 to
>>>>>>>> wait any more than necessary. We don't change the default config t=
o
>>>>>>>> ensure we don't break compatibility with existing debuggers that d=
on't
>>>>>>>> expect us to hit semihosting breakpoints.
>>>>>>>>
>>>>>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>     arch/arm/mach-zynqmp/spl.c | 10 ++++++++--
>>>>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl=
.c
>>>>>>>> index a0f35f36faa..5af735aa5ce 100644
>>>>>>>> --- a/arch/arm/mach-zynqmp/spl.c
>>>>>>>> +++ b/arch/arm/mach-zynqmp/spl.c
>>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>>     #include <image.h>
>>>>>>>>     #include <init.h>
>>>>>>>>     #include <log.h>
>>>>>>>> +#include <semihosting.h>
>>>>>>>>     #include <spl.h>
>>>>>>>>     #include <linux/delay.h>
>>>>>>>>
>>>>>>>> @@ -66,6 +67,11 @@ void spl_board_init(void)
>>>>>>>>     }
>>>>>>>>     #endif
>>>>>>>>
>>>>>>>> +static u32 jtag_boot_device(void)
>>>>>>>> +{
>>>>>>>> +       return semihosting_enabled() ? BOOT_DEVICE_SMH : BOOT_DEVI=
CE_RAM;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     void board_boot_order(u32 *spl_boot_list)
>>>>>>>>     {
>>>>>>>>            spl_boot_list[0] =3D spl_boot_device();
>>>>>>>> @@ -75,7 +81,7 @@ void board_boot_order(u32 *spl_boot_list)
>>>>>>>>            if (spl_boot_list[0] =3D=3D BOOT_DEVICE_MMC2)
>>>>>>>>                    spl_boot_list[1] =3D BOOT_DEVICE_MMC1;
>>>>>>>>
>>>>>>>> -       spl_boot_list[2] =3D BOOT_DEVICE_RAM;
>>>>>>>> +       spl_boot_list[2] =3D jtag_boot_device();
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     u32 spl_boot_device(void)
>>>>>>>> @@ -97,7 +103,7 @@ u32 spl_boot_device(void)
>>>>>>>>
>>>>>>>>            switch (bootmode) {
>>>>>>>>            case JTAG_MODE:
>>>>>>>> -               return BOOT_DEVICE_RAM;
>>>>>>>> +               return jtag_boot_device();
>>>>>>>>     #ifdef CONFIG_SPL_MMC
>>>>>>>>            case SD_MODE1:
>>>>>>>>            case SD1_LSHFT_MODE: /* not working on silicon v1 */
>>>>>>>
>>>>>>> Good timing. Can you please tell me how to test this? What's the se=
tup?
>>>>>>> Which debugger are you using?
>>>>>>
>>>>>> I am using OpenOCD with the patches at https://cas5-0-urlprotect.tre=
ndmicro.com:443/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2freview.openocd.o=
rg%2fc%2fopenocd%2f%2b%2f8133&umid=3D6e1be473-0b3f-4bc4-a4f0-403592e74baf&a=
uth=3Dd807158c60b7d2502abde8a2fc01f40662980862-afc15b07b0f91c910f8321859583=
63d84f990a08
>>>>>>
>>>>>
>>>>> I am trying it on the top of the latest git but getting issue with ev=
ent block and no idea how to fix it.
>>>>>
>>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/dig=
ilent_jtag_hs3.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zynqmp=
.cfg
>>>>> Open On-Chip Debugger 0.12.0+dev-01509-g6d288937cb2d (2024-02-16-12:2=
2)
>>>>> Licensed under GNU GPL v2
>>>>> For bug reports, read
>>>>>       https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/q=
uery?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6e1b=
e473-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f406629=
80862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>>> Info : auto-selecting first available session transport "jtag". To ov=
erride use 'transport select <transport>'.
>>>>> wrong # args: should be "-event <event-name> <event-body>"
>>>>>
>>>>>
>>>>> Do you know how to fix it?
>>>>
>>>>
>>>> I actually bisect it and found that it is caused by
>>>> jtag: rewrite jim_jtag_configure() as COMMAND_HANDLER
>>>> ea2e26f7d521f5755b4bfda7bf12d99650277421
>>>
>>> Interesting. I have been testing with 0.12.
>>>
>>>> # sudo openocd -f /usr/local/share/openocd/scripts/interface/ftdi/digi=
lent_jtag_smt2_nc.cfg -f /usr/local/share/openocd/scripts/target/xilinx_zyn=
qmp.cfg
>>>
>>> FWIW after installing the udev rules I do not need sudo
>>>
>>>> Open On-Chip Debugger 0.12.0+dev-01512-g214206ebb972 (2024-02-16-15:38=
)
>>>> Licensed under GNU GPL v2
>>>> For bug reports, read
>>>>      https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/que=
ry?url=3Dhttp%3a%2f%2fopenocd.org%2fdoc%2fdoxygen%2fbugs.html&umid=3D6e1be4=
73-0b3f-4bc4-a4f0-403592e74baf&auth=3Dd807158c60b7d2502abde8a2fc01f40662980=
862-f501ab9aa5516ff666e387e53598fd624398f1bc
>>>> none separate
>>>> Info : auto-selecting first available session transport "jtag". To ove=
rride use 'transport select <transport>'.
>>>> Info : Hardware thread awareness created
>>>> boot_apu
>>>> Info : Listening on port 6666 for tcl connections
>>>> Info : Listening on port 4444 for telnet connections
>>>> Warn : An adapter speed is not selected in the init scripts. OpenOCD w=
ill try to run the adapter at very low speed (100 kHz).
>>>> Warn : To remove this warnings and achieve reasonable communication sp=
eed with the target, set "adapter speed" or "jtag_rclk" in the init scripts=
.
>>>> Info : clock speed 100 kHz
>>>> Info : TAP uscale.tap does not have valid IDCODE (idcode=3D0x48e70126)
>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (X=
ilinx), part: 0x4738, ver: 0x2)
>>>> Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (=
ARM Ltd), part: 0xba00, ver: 0x5)
>>>> Info : JTAG tap: uscale.ps tap/device found: 0x24738093 (mfg: 0x049 (X=
ilinx), part: 0x4738, ver: 0x2)
>>>> Error: JTAG-DP STICKY ERROR
>>>> Error: [uscale.a53.0] Examination failed
>>>> Warn : target uscale.a53.0 examination failed
>>>> Info : [uscale.axi] Examination succeed
>>>> Info : starting gdb server for uscale.a53.0 on 3333
>>>> Info : Listening on port 3333 for gdb connections
>>>> Info : gdb port disabled
>>>>
>>>> but with zcu102 I am still not able to connect because error above.
>>>> The same behavior with recording SOM IDs I see on kv260 (via hs3 cable=
).
>>>> It looks like that not everything is working for zynqmp.
>>>
>>> Is this with the boot mode set to JTAG? If so, you will not be able to
>>> examine any of the CPUs until you have released them from reset. So you
>>> should be able to run
>>>
>>>          targets uscale.axi
>>>          boot_pmu /path/to/pmu-firmware.bin
>>>          boot_apu /path/to/u-boot-spl.bin
>>>
>>> to boot a CPU. If you want to silence the above error, you can add
>>>
>>>          uscale.a53.0 configure -defer-examine
>>>
>>> to your config. So the full command would be
>>>
>>> $ openocd -f interface/ftdi/digilent_jtag_smt2_nc.cfg \
>>>          -f target/xilinx_zynqmp.cfg \
>>>          -c 'uscale.a53.o configure -defer-examine' \
>>>          -c init -c 'targets uscale.axi' \
>>>          -c 'boot_pmu /path/to/pmu-firmware.bin' \
>>>          -c 'boot_apu /path/to/boot.bin'
>>>
>>> Let me know if that works for you.
>>
>> Oh, and I forgot to mention, but if you are testing semihosting then you=
 will need to add
>>
>> -c 'uscale.a53.0 arm semihosting enable'
>>
>> to the end of that. I also find setting the semihosting base directory w=
ith
>>
>> -c 'uscale.a53.0 arm semihosting_basedir $IMAGEDIR'
>>
>> to be helpful.
>>
>> As you can imagine this is a long command line, so I have a config which=
 looks like
>>
>> source [find interface/ftdi/digilent_jtag_smt2_nc.cfg]
>> adapter speed 25000
>> source [find target/xilinx_zynqmp.cfg]
>> uscale.a53.0 configure -defer-examine
>>
>> proc boot {imagedir machine} {
>>          targets uscale.axi
>>          boot_pmu "${imagedir}/pmu-firmware-${machine}.bin"
>>          boot_apu "${imagedir}/u-boot-spl.bin"
>>          uscale.a53.0 arm semihosting enable
>>          uscale.a53.0 arm semihosting_basedir $imagedir
>> }
>>
>> which I invoke like
>>
>> $ openocd -f my_config.cfg -c init -c 'boot /path/to/images my-machine'
>
>
> ok. 0.12.0 version is working better. I am able to load firmware to APU b=
ut I was not able to load pmufw. It was saying timeout like this.
>
>> boot_pmu /mnt/disk/som/pmu_obj.bin
> /usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg:173: Err=
or: Timed out waiting for PMU firmware
> in procedure 'boot_pmu'
> in procedure 'resume_pmu' called at file "/usr/local/bin/../share/openocd=
/scripts/target/xilinx_zynqmp.cfg", line 232
> at file "/usr/local/bin/../share/openocd/scripts/target/xilinx_zynqmp.cfg=
", line 173
>>
>
> Then I looked at pmu and use below snipset which I use on xsdb to make it=
 visible for debugger and also small waiting time.
>
>
> @@ -141,6 +146,13 @@ add_help_text halt_pmu "Halt the PMU in preparation =
for loading new firmware.\
>         This should be matched with a call to resume_pmu."
>  proc halt_pmu {} {
>         set axi $::_CHIPNAME.axi
> +
> +       puts "Enable PMU target"
> +       set val [$axi read_memory 0xFFCA0038 32 1]
> +       $axi write_memory 0xFFCA0038 32 [expr {$val | 0x1C0}]

These should already be set. See table 39-3 in UG1085. Although I seem
to have a combination of 39-2 and 39-3:

    > targets uscale.axi
    > # BOOT_MODE_USER BOOT_MODE_POR
    > mdw 0xff5e0200 2
    0xff5e0200: 00000000 00000000
    > # jtag_chain_cfg jtag_chain_status jtag_sec jtag_dap_cfg
    > mdw 0xffca0030 4
    0xffca0030: 00000000 00000003 0000003f 000000ff

Do you see these values in the JTAG boot mode?

> +       sleep 5

Part of my goal here is to remove "magic" sleeps like this so the boot
process goes faster.

> +       puts "PMU target should be enabled">         set val [$axi read_m=
emory $::IPI_PMU_0_IER 32 1]
>         $axi write_memory $::IPI_PMU_0_IER 32 [expr {$val | $::IPI_PMU_0}=
]
>
> With that I am able to test your patch but it is kind of slow.
> Max freq I am able to use on zcu102 is 2MHz which is far from 15MHz used =
by xsdb.

I have been using the maximum 25 MHz speed without issue.

> After some time I am seeing
>
> Error: Invalid ACK (4) in DAP response
> Polling target uscale.a53.0 failed, trying to reexamine
> Error: Invalid ACK (0) in DAP response
> Error: Could not initialize the APB-AP
> Examination failed, GDB will be halted. Polling again in 100ms
> Error: Invalid ACK (0) in DAP response
> Polling target uscale.a53.0 failed, trying to reexamine
> Error: Invalid ACK (0) in DAP response
> Error: Could not initialize the APB-AP
> Examination failed, GDB will be halted. Polling again in 300ms
> Error: Invalid ACK (0) in DAP response
> Polling target uscale.a53.0 failed, trying to reexamine
> Error: Invalid ACK (0) in DAP response
> Error: Could not initialize the APB-AP
> Examination failed, GDB will be halted. Polling again in 700ms
> Error: Invalid ACK (0) in DAP response

So this indicates the APU is either inaccessable or still in reset. To
confirm, you get this after running boot_pmu and then boot_apu?

For reference I get

Open On-Chip Debugger 0.12.0 (2023-08-14-15:03)
Licensed under GNU GPL v2
For bug reports, read
        http://openocd.org/doc/doxygen/bugs.html
Info : auto-selecting first available session transport "jtag". To override=
 use 'transport select <transport>'.
boot
Info : ftdi: if you experience problems at higher adapter clocks, try the c=
ommand "ftdi tdo_sample_edge falling"
Info : clock speed 25000 kHz
Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (ARM L=
td), part: 0xba00, ver: 0x5)
Info : JTAG tap: uscale.ps tap/device found: 0x04721093 (mfg: 0x049 (Xilinx=
), part: 0x4721, ver: 0x0)
Info : JTAG tap: uscale.tap tap/device found: 0x5ba00477 (mfg: 0x23b (ARM L=
td), part: 0xba00, ver: 0x5)
Info : JTAG tap: uscale.ps tap/device found: 0x04721093 (mfg: 0x049 (Xilinx=
), part: 0x4721, ver: 0x0)
Info : starting gdb server for uscale.a53.0 on 3333
Info : Listening on port 3333 for gdb connections
Info : gdb port disabled
Info : Loading PMU firmware /path/to/pmu-firmware.bin to 0xffdc0000
Info : uscale.a53.0: hardware has 6 breakpoints, 4 watchpoints
Info : uscale.a53.0 cluster 0 core 0 multi core
uscale.a53.0 halted in AArch64 state due to debug-request, current mode: EL=
3H
cpsr: 0x200002cd pc: 0xfffc64fc
MMU: disabled, D-Cache: disabled, I-Cache: disabled
Info : Loading APU0 firmware /path/to/u-boot-spl.bin to 0xfffc0000
semihosting base dir: /path/to/u-boot/

Info : Listening on port 6666 for tcl connections
Info : Listening on port 4444 for telnet connections
Info : accepting 'gdb' connection on tcp/3333

--Sean

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
