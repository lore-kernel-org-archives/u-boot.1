Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D620ECF3187
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 10:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2532283BD2;
	Wed, 19 Nov 2025 11:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BhgOQwmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C3A683DBF; Wed, 19 Nov 2025 11:15:37 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E08832AD
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLONQ47uElA/OK5fXhVWv22LTt22nY2O1+1qgQSP0uzwJUo58wS+zURyoKt4CdZaKCu7tPgjD9vZCt3i86SRnqVVF4fqrxY0TFsS+SBFZzJ4HCtrUFs1ZSZOa8jR8T2i83qinzmZPes/A/vtPEY6cpDMQSNy28LMfaUiJ4Xv52Z00v99xePROy8LdUtSFGxG/PiSX0+AcJqGAShLBJu77HDVE+gh6e2elHIVghGcCmt+IgaZDAKnNk116ZK+JTIMLWF8Ekq44z5392+xF25CGsU/u84NtsQ4Irea+bUhSiofmZVQJbaMBG8/fH6dvJIWWbSTRmTlGk/gFJfNGS31aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltvkBVf/7CT9AV6hvvlTBh6UTq9SgeVegn8eTJ1A02c=;
 b=vyhiCCrlGR1rPgYXKF0ZbkNHy5fyxiK32mol562QZ1mtISMkjI5QONpXPFPG8nUDoBvV57XM45IEjLLYCrxLgZc9Cjexu49WD5dSLf9yAb86eeUfDa7zjOUvLn8d/IbYslZydkLYVh7VE2DtXka+jStjyGI0w8iHNLCvxDEeTHn4nyDUCqLU4ChsVrpN9Mn+GWtk37eKuUT4nwdUjH018msO1AG3yF+3R4ub7JF65ugKDJIY9j8FkkQ0A8bTmOWUhp2p5p1TuZb+4Q5ErzKyeUR0fApMIBXLIUQc5IavDxb8TGDUTOiENi03aDRI/kJCIEAKqBv+tLow1IPaTXbSiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltvkBVf/7CT9AV6hvvlTBh6UTq9SgeVegn8eTJ1A02c=;
 b=BhgOQwmJ5rOdCpxrl9Jj/761TOzgqOfewcwMaYohcmOsu1qB9i4L2rD02yF6HM69FFf7NzVWhAWAhPOBSTVIiEPcxsfg+gDPQAa7Ln5e5Ns7DR1AeZqx88QKhXweKUfD+8IfCK3QyBWbn8pxLqVGNXNT01JvnfgIAoKFnjj2kvQ=
Received: from BN9PR03CA0929.namprd03.prod.outlook.com (2603:10b6:408:107::34)
 by CH2PR10MB4294.namprd10.prod.outlook.com (2603:10b6:610:a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:15:31 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::7b) by BN9PR03CA0929.outlook.office365.com
 (2603:10b6:408:107::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 10:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Wed, 19 Nov 2025 10:15:30 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 04:15:22 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 04:15:21 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 04:15:21 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AJAFH3c1716339;
 Wed, 19 Nov 2025 04:15:18 -0600
Message-ID: <d0c47377-57f6-44f4-93e8-119366f09ecc@ti.com>
Date: Wed, 19 Nov 2025 15:45:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
To: Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>,
 <trini@konsulko.com>, "Dixit, Tanu Hari" <thdixit@ti.com>, "Hegde, Saurabh"
 <s-hegde1@ti.com>
CC: <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-5-b-padhi@ti.com> <D9PTUSDYSWS0.J9VVKD57OPPM@ti.com>
 <218f2201-6094-4a93-aae6-e919cbeeda56@ti.com>
 <2fb353e4-b119-40d8-9eb2-717ec2422eaa@ti.com>
 <D9QRG0VOG7FQ.3G9WFJ8ZYUBDZ@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <D9QRG0VOG7FQ.3G9WFJ8ZYUBDZ@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CH2PR10MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d23d07-e07f-4701-3157-08de27549148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFl1Wk0wY3dXQ1IxWStqK0N0L3RTRURzdUVTeFNnM2RNb0lYZHpJaWkzeHQx?=
 =?utf-8?B?ZTBXZzZKWG80MTJxVlVMT0gzRlAyY1BYSVVIUFRBMS9HZkZRakM4dnR3b2tY?=
 =?utf-8?B?c2U4TE1aSVNtRU5WSGk3MFhBQTRyaHV3MlBFeTRxWDEzck81SUpLUy9TU09P?=
 =?utf-8?B?ekdlU3RTcVk1M0pXTm9TTGhmeUIxU045MHpncFhHU05GelVZMW1DMDFBMlZB?=
 =?utf-8?B?K1FTdDZDZ0pzM1IvdTdVSlVOdXM2M0tCUFhwQVJ3ZFVzdWJnMTVwdUJyVGVM?=
 =?utf-8?B?T1pkRjhkTkRUWVlsSUhCSU9jeGZLU2d2aWUzdXJOVzZJRXQ0R2xBODQxaWt4?=
 =?utf-8?B?N0llMXNYZUg2OFVsQ21ZZ3FVakd0QVhXZ2x2U2FvSzEzUURJeTZKSEg5WG5n?=
 =?utf-8?B?V0I5WVdLVFF6T3U1STYzUndkY3hQUHpMdE1NeUU0dm8vWjc0TE5xTFp2TUxK?=
 =?utf-8?B?K043eUplc2w0UEhTT1VoVGh0c29yTjE3ZnpsTzdTSHp0NG50elpYVWJpeEQ4?=
 =?utf-8?B?YnJuVElzVTF2VGF4VWlQSWZQNXU3Q0Y1K25VbFVKdXV2d1lvR0VxNzJKcEFn?=
 =?utf-8?B?dWtWOFRQbnVrc3pML1ZtMUUySXJmZE9UaXVJQmFDSmd4ZVUxV21yLytEbUlL?=
 =?utf-8?B?cHdlclovU0VZeFhDSDFIYS9uUkYrZDMramN5TXJRK0lCNDVTTlJoVTRqZHFZ?=
 =?utf-8?B?NW1uZUM0bStnSG9OTzdPN1ZDMXg2cEFTNThDNmxuUU1YdUZZU1FDdHY1bDVI?=
 =?utf-8?B?aXRMWUZOMndQM1JhaFlHaHdpdStGY05OMGcxcjZVcWhFTjFzN25YL250dXVo?=
 =?utf-8?B?Q1gzd29Jb09HYnM3Y0E4RlIwdkVkMHArMmxYOGJzQnVFR3E4WUJhcEQ3bDRC?=
 =?utf-8?B?a2xkS0Qyelg4Z2hTL0lnN2lvYk1DWDRFMVBMTDc3am9GSStJNitMcEd5RGFm?=
 =?utf-8?B?V04zYlJINzlIMDl6Y2dlUDl4aFZwbllwWWN3b29ZOFd3QjkyRjhVUDl5V01o?=
 =?utf-8?B?ZU02THdzVzZ1dGJlOTRUMFZSeVcrMmRiNHVKMW9QZytQYWczR0VQTFZ2alpC?=
 =?utf-8?B?c1ptQXVrTVJaZjJRQzJ5V2QrbGdXcWhvN1B2Q3kxVkhRUVJESFNpSFd4cHNL?=
 =?utf-8?B?SDVWNlhWUm9BY3lmaDJvZ1Zyc2VwQTZsb0JsQ3ZyTld3bWZMWUYyVjg0RDNq?=
 =?utf-8?B?K1A3U1o2WEJKSE9KNHRtTzRsUStRaDVoZUQxMEF3eFVYZS9tbU9qMGlRSXor?=
 =?utf-8?B?eTVJWjJONXVXTy9WcDV6ZjJHVXZUZUtnbGpzQ2ZJQ0lTUUZkS0hWRkkvdVE1?=
 =?utf-8?B?Q0szZmFSUUVKb05vMTh2OEtqN0IrRGZqNXpic1VlNGZDZHBGZlJIMzAzcU03?=
 =?utf-8?B?T2gxcDN5N01xTVNkSkF6RUQ5UGtQNWdicU40Yko5SzZYQjRGQ3dVM2VnV0ZM?=
 =?utf-8?B?dnVNWFVlcXNrdTdEM2IwTGN1L3hLaG53OEQySmxOQnhxUWRiNGdMNlY3a21N?=
 =?utf-8?B?Q2FUY2VrM2N5OTZvL1hmeEF6Rmt3TVhZdGtZTG5KVkdBRUo1UXlSVytUdWhL?=
 =?utf-8?B?anQ2akVNbUxQbVBhby9jSWhzSENRUUJRODBaQWx2RjVyNGZIYVkrZzB4ZTdC?=
 =?utf-8?B?RzJRUS9WQWZUZitpMHBjNnRLcmVKTFFDVmpNQmE1bWdaWjd6WVIxSGdoQmJm?=
 =?utf-8?B?WGUzUU5KamF5SmxidlZ3RExYVUFmc1QrLzVOSkJxZUtTSWhpcWQ0b0s1YUJC?=
 =?utf-8?B?WnpBRG9wcm4rV1NFNXloY08wYmpUMzF4OEc0QUJQcUd1Z0hkM00wYlhFZmNQ?=
 =?utf-8?B?VW9Fd2pqSnB6WEp1YS9EV01ZY0R5TXk3MFQrWk8xL2Z0UkV3NHRQTnVnTzZP?=
 =?utf-8?B?dzk1b0xFMmZMRVlpTXFaRVZOMmlHcG4yVUVVRHA1Q2FFSUg0blp0K2MyN205?=
 =?utf-8?B?Y3lYQXYvMy9nOXhsdUNNRlM0S3dGYXFnWW9SWTdoZmUvS05PbnpSSzhvM3Ux?=
 =?utf-8?B?dkhIYXowNkd0MVl6UjNyV3U1UnBwU2NUQUZOUTVHelVSOWZhYUdCc3lDbmNS?=
 =?utf-8?B?T21uaXBNUWVVLzBJMFA2NHQreng0QXRZT0VLRVFhbm9yNUlWODRkNWEwTEJy?=
 =?utf-8?Q?5Kf4=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:15:30.0128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d23d07-e07f-4701-3157-08de27549148
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
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

Hi Andrew, Anshul, all

Reviving this old thread, this is ready for a re-spin
now as unsigned HSM firmware is available.
Please see below.

On 08/05/25 17:29, Anshul Dalal wrote:
> On Wed May 7, 2025 at 8:53 PM IST, Andrew Davis wrote:
>> On 5/7/25 9:56 AM, Beleswar Prasad Padhi wrote:
>>> On 5/7/2025 3:09 PM, Anshul Dalal wrote:
>>>> On Tue May 6, 2025 at 4:11 PM IST, Beleswar Padhi wrote:
>>>>> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
>>>>> and used by R5 SPL to boot the HSM core. By default, point to the
>>>>> firmware for HS-SE device type. This needs to be changed to point to
>>>>> appropriate firmware when using a different device type.
>>>>>
>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>> ---
>>>>> v2: Changelog:
>>>>> None to this patch.
>>>>>
>>>>> Link to v1:
>>>>> https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/
>>>>>
>>>>>   arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>>>>>   arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>>>>>   2 files changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
>>>>> index 73af184d27e..9c8b29f53bb 100644
>>>>> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
>>>>> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
>>>>> @@ -273,6 +273,14 @@
>>>>>                       };
>>>>>                   };
>>>>> +#ifdef CONFIG_K3_HSM_FW
>>>>> +                hsm {
>>>>> +                    hsm: blob-ext {
>>>>> +                        filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
>>>>> +                    };
>>>>> +                };
>>>>> +#endif
>>>>> +
>>>> Why do we have the hsm binaries pre-signed? Having a common binary like
>>>> the DM with signing using ti-secure might be a better option.
>>>
>>> Andrew can correct me if I am wrong,
>>> HSM is meant to run secure software stack and services like Authentication etc. It is a +1 to TIFS. To establish ROT, we need the HSM binary to be encrypted, and authenticated by TIFS first before it can do stuff by itself. DM is not a secure entity, so signing the image doesn't make sense for me.
>>>
>> I think Anshul is not suggesting that the HSM binary be unencrypted/unauthenticated.
>> Rather that the encrypting/signing be done here in binman like we do with TF-A/OP-TEE.
>> (which both are part trusted images to be loaded by TIFS).
>>
>> To that suggestion I agree, the customer will be doing the signing of this binary, right?
>> If so then since all other customer signing is done as part of binman, it makes sense
>> to also sign HSM firmware here too.
>>
>> Andrew
> Yeah, that is what I was going for. With that change it could be
> possible to also have a single binary for all platforms (gp, hs, hs-fs)
> in ti-linux-firmware?


I don't think its possible to have a single HSM firmware
for all device types currently. GP devices might not use
all security IPs which the hs-se device uses. So having
a common firmware would mean we sacrifice using
those secure services on a HS-SE capable device
as well. Of course, whenever we can support a single
TIFS binary for all device types, we can support a single
HSM too. I have copied firmware folks here (@Tanu,
@Saurabh) who can help in answering this query better,
if any follow up.

But yes, we do have the unsigned HSM firmware for each
device type now[0]: GP, HS, HS-FS. Which means we can
add the signing support here in U-Boot to match the flow
with other components like ATF/OPTEE/DM etc.

So, I will re-spin the v3 for this patch series with following
changes:
1. Dedicated remoteproc driver for booting HSM M4 core.
2. Signing HSM binary in binman/U-Boot.
3. Other minor code comments from Anshul/Andrew.

Note: We will continue to pack the HS-SE variant of HSM
firmware in tispl.bin fit image by default. Any other
variant can be packaged by changing the path in binman
node to corresponding firmware blob.

Let me know, if you have any comments over the above,
otherwise I will send out an v3 soon. Thanks!

[0]: https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/ti-hsm?h=ti-linux-firmware&id=560c226d763018de7adb892fc215b31286cc2831

Thanks,
Beleswar

