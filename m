Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243C0C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 16:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AEF287A4B;
	Tue,  9 Apr 2024 18:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="L7zeFTW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A12B87C7E; Tue,  9 Apr 2024 18:02:39 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D85A87527
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 18:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej/zGyatOEkjmrBUiTOx8AmgurzPgdj3tb1/JfwnO1fM7EFMRVCO55hAtt9vnNwxMIEUldQP5A0o5Nh7boa9OCLSorzsyf5lOOuaaPdsAn5YmvLx2b5GBDJVEe9XKGxX7XfUFJF2yfGHtNEKsTIYMdV45ACTpHaK2oSBNMtsU6ENuThPM1Hoek2YHt2fz0XfrZzzcWw9KQsZx5ffj+8MZ2O80KWY3mOSz3dXvvMmpKl3K4Zh+/cGiqTvYWtgmlUkVL0agOnV/MRYrYUUhUxyHboVgTgU/iwxEhUXOYcq97+pJTdeGhQel6VvSFMPLldQXH9Upbi2dn0VJ/qJMufgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+j+igtBBfB44ztjhtKL5F7vbl//BKvwnuQ6CufWVEg=;
 b=EbIKifkHf1WRye+9bkkpBe+pEy2mTFqDYFDuYWMh1yF9gwFP4zRaZ6HCIwPcV2f9gDFuyAy06dM77//F6nrqJ2j/19PorvZNeS/3GkuHZAWBr3mGzjMhdQZSC4hv7nkHjabmWbK8BaEkq/z1P8XjJUqvwzKrLbZ9PJ83dVWLZ7AvdjyOTHpups+HMIOYmz00NeRjkjIMio3/cTk8TR032tyt4JvAG4+MIhrBFFCVWrzKddejRIC6TPpcaIDbaab9rxLwli9qEv0PnLEkj5USzhYI9F+JE+g3rD5ig1Yo+bSuDAdI2/57d5JMB7GSt92fepSowl3F0tapAPImkyWTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+j+igtBBfB44ztjhtKL5F7vbl//BKvwnuQ6CufWVEg=;
 b=L7zeFTW5NS4JdxmWe3tOKJikr2mi2ywj8yjHBlchNQPXHIGc5PY7SSnjU9oe2x8BL/+vKfK/QTwq6F95w7u5btGXdBTwRvpVX8oumefcc81Kx24+Am6RxSw8NdhAb8m1DXKtloylpM6Pxy+3AvDCsmgbjVj0soKiFIL/BopgSmHAxcJh3csUe9CrFWKVz2CV2YigCxdobSZdLDGaWtcByS3O0GT8C6aANv9KvN3kNAdkcemabeOggjUnvY5I9mDW3h3Z2M0vi/LTDgtRPeoHQJ8oFsPvtuQCfjkBRhea3VaddLgUshkhKNYaP/9QUuQ8Jd0x7080EoDm5/ld0ZTcJg==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 16:02:35 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 16:02:35 +0000
Message-ID: <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
Date: Tue, 9 Apr 2024 18:02:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0026.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::22) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBBPR04MB7546:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SW1i+q0a0skj7TBDMjuzT5bdWkAq43vUGLoNxzigvm5zeTLMHTzWVkUUY9cqu388cDWCokLNKzvX4fxudapdEiLlKoCdXidhCcPsqn1OwZwE3XzdzlsYxJtGGo0wiNbDE26Sa4ybqyfdN36ww84zVGgZDDEBMP/z3AB1DWyBYTvsRG6FNPWPKjbSoWerCBQG8OW5PfGIncb+MUYuF7rW6mc07442M071fR4NjLPsT4luHn7/ps+4FbM9I03e2IlS4cH6wLPmsbukp4TrvmmbAodSBMI5tKipQH9pqh1HMQudwIv7w4vX06pq6P5LzQrAjN6EnbB70V+Xnjw6BX6458JGpoqUPwnyVJlndUzQpknDDSnhmfz32/FfeaL0aZjZwEsfYo6y+Auk5yKmgIu2Yuxekd7RcpJIQCdYFvU8P6vx2Nz3PzKCR4hnwCcZI/+kqVpUkGD8ENIttHO2DLrdgTCGprAaIRTSJ/AV3unhN0E2LTkvQMDOv9qDtCPsRVlQOty2MwzYONYtbPH8hn4UGXjm0AFKLLGVOrEvNVgSfkaZCw8zhDBgC2W1Aa5v5K106OJ+obN4VAlW9mtOZDFUlXmE0T29vmXn3fhQCnHZiFiXU8xcawXMVQM9rXIGpw2xifsx2muxQ6D7LsdQN/OBwxVmNDzqjwQ7Q7W1400I9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFA2cENyK01Za0Vud3o2U3h3bUdkbWoremVQUE1WUXNUMS9ISGoxY0tRTWdL?=
 =?utf-8?B?QklXSmtkaEtxYk9pSysxak9mQUlxSEw1VDQ0U1IrbGNUWGRVT01ud1VBeEZL?=
 =?utf-8?B?RGZERGZHaUdNWnowVlY4YnFyeDNjR0NPMHNScER1ZXlGYTd4Wm5naVRuK0lE?=
 =?utf-8?B?emhLMUFvTjhMTVVvTWNpeW5LWXdFNXhDT0J6dmREd1F4cVVDTm02emZaS3Vs?=
 =?utf-8?B?UGJiM0xsYTJpblFwbHFaRkRGcmovdXgvQnlRcWpyRXRGTnYwQ1d3bytYdzNK?=
 =?utf-8?B?TTc4Z2tUTE1RVHE4SDRscFViaVUrNmtXUVZvcVBsNTFGeVRSbUFUVG1pSjA1?=
 =?utf-8?B?dVMycW5hekx4TFFITGxWNzR1UVFtNHRMbEFObmFQUmpXejBJcTNJZm8yRFRk?=
 =?utf-8?B?bUZpNjdSaWR6bVUvY0lKYWExRXRZV3BKQXRXbDhZbXhXWkMzUXlic3AwN2JD?=
 =?utf-8?B?YWNHdms0dlRYSXlCQllMM2tlcnFCVzUyQkRHcXRPYmhJSjFFaFV4TDdpa3Av?=
 =?utf-8?B?VFZaRjVvZkV4UEJxbzl4UjJGRnNKK20wdWMxYmw0VmtjNFhtelNHaW1ONit4?=
 =?utf-8?B?MGNiMkFROEJGNThacWFXUXRzZ0pZZ2h6MExNWHBpVjlwdXArTkM2UFRyOFlZ?=
 =?utf-8?B?OGdodW1qdGJxZTBmYWVlV2J2TG4xSUZMcnlKVml2M3FZUjJ3V3RpYWgvSnRI?=
 =?utf-8?B?K1FBazlzWmQ4a0p4UzBMNFJqS3NWcHJpdTJHT2ZkV0xmdCtaZHVnblZvWVNX?=
 =?utf-8?B?MERjNHc5dUlBUUpXUE9GZG42amo2dnNtZ2NXRG52ZG5hbDBWNWxaR2FpQ09s?=
 =?utf-8?B?emxvd0tJcWdRTHg2czl4Zm5rSnhaMUNxb1RaandjeGxOZXRNejRQMmVsVllj?=
 =?utf-8?B?NjlVdnI3NGlHckZ6ZERzeTRiTFFjeWMwMnhhTFNlSXVpQ0RQeFhLWHRTR0w4?=
 =?utf-8?B?bjRSd1FpZlZLWXM1L2xxWTdzODRVNWY0Q2J4N3RKRGdwTDYwejZZQnB2OFJ6?=
 =?utf-8?B?bGJOOFZHcXNXdVlMQVlWRmdTT2VnYTE4U2dIaUZIemxmcS9iOCttK3phVmdM?=
 =?utf-8?B?Z3VJdEZCbDc0YzJyTDJyYmEvT3oydjVnSjNSaERrbUtqR3AydVdCS1p3TDNN?=
 =?utf-8?B?L2FKcVI2WlhBZFZlZ3BtSyszaU4yajVhRWRlK1FKM2ltUUp1dk1Sa3QwZzlY?=
 =?utf-8?B?VlE1NmdWaVNBbXRLNGZNKzRyTU5sWFdrdCtkZk1FblZESE50MFE3TnAwTE1L?=
 =?utf-8?B?MHdaV0hXRkNmWkhmL0svWHdWZjRrTm1Jb1lSVS9aQ2d6bzZaY3JIY21yTGsw?=
 =?utf-8?B?OHlnbUpZK25HWG9SZk5pcXhoQjFoNEtxb29tQ0pQSWphYzEvTXBkOUJ5ZFFY?=
 =?utf-8?B?VjFZNVd4MEF6S1J1ckdDRFE1QkVRRnJ4RmgvRE1RMEZ2NEx1WWNzWXN0QUIw?=
 =?utf-8?B?Y1h3SmdOei9LUG9qZ0NSYjVSeFZkYWxjMXdXVGljL2FjOFVKNXRhQkozK2Rp?=
 =?utf-8?B?dU1IOWtkMjhnK0lCMGVkWXVhbnAxMXBoSE5sOHlhd2NHUzlSSUNQRk1JcjQ4?=
 =?utf-8?B?c3VDa1dvdjZlbVFlTzFzZjRVQm96amdLeVVVNDQyYkZuK0ZpWlRxRXZqNnk1?=
 =?utf-8?B?d0dOanJxNTd3Si9xc28wSHRIdnMySXF2RS9QQlFXc1NUSmJVMHRvMlpRNzNK?=
 =?utf-8?B?K3BjQk1zRnNQMUkxTW1CbVZ0QWJMWHQyUllJbWc4Qk9iWjcxNDVJZ0JhNHVX?=
 =?utf-8?B?cWw3bFRjZkNtczVhVnE5QUZGYnJvd2IwaitaSEYwMTEwVmdMVUpQTG1ZU0JE?=
 =?utf-8?B?dnBCcGN3a1ptRFpYVk5URFVFbHE2MUxZN1RRak9vQWxOZXdRWC81MC83dVMz?=
 =?utf-8?B?bE9BclNnSlBxeTVCVjJ4Uis2dCtRNWZSVklNWE85WEF6QytBMGhNUW4wS0lR?=
 =?utf-8?B?TWc2K2lDUnJZMmE5Y0lwWFRlL2Zwd0NtU2dHeUVkdGROMnVtd1UrSFUwWmt5?=
 =?utf-8?B?dXhscXpJREpTRzJSMEMreFBZY2p1Z0IwTWh4YUxFRDJ1dnExTWZ1V05rVFE1?=
 =?utf-8?B?bnhFUktqS2RQTVM4OENHU3J5YzE2a0J4SEZRbS9LMkJJWHJ1UDhMWEJTZytl?=
 =?utf-8?B?WkxoVG10YzliTjVWK1M5RHU3OWRFOVlZYkFUUVMvNjQyTGc2Z1lOSjVoa08r?=
 =?utf-8?Q?BMVi9C7ylNjnOXL9iN+YKL4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4d725b-0290-4203-ad90-08dc58ae78c7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 16:02:35.5339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIEQ5eqnRvy8TWYSzvdjuUErprqru47atL5UGVTy+CwcGyDpxTlSsfbx3bZ/YcJ3bdk8xFvEtcX46+hHHgRE9Rl9+BkvY6hFD3tRjSBZxkkH7d5bUvuGJMUJR7sbRuQf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
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

Hi Jonas,

On 4/9/24 17:58, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-09 17:27, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 4/8/24 23:06, Jonas Karlman wrote:
>>> eMMC nodes in linux device tree files typically only contain a mmc-hs400
>>> prop to signal support for both HS400 and HS200. However, U-Boot require
>>> an explicit mmc-hs200 prop to signal support for the HS200 mode.
>>>   > Fix this by follow linux and imply HS200 cap when HS400 cap is signaled
>>> using a mmc-hs400 prop.
>>>
>>
>> Technically speaking, the DT binding should be the one and only source
>> of truth and should be implementation-agnostic.
>>
>> There it says:
>> """
>>     mmc-hs400-1_2v:
>>       $ref: /schemas/types.yaml#/definitions/flag
>>       description:
>>         eMMC HS400 mode (1.2V I/O) is supported.
>>
>>     mmc-hs400-1_8v:
>>       $ref: /schemas/types.yaml#/definitions/flag
>>       description:
>>         eMMC HS400 mode (1.8V I/O) is supported.
>> """
>>
>> So I'd say, the DTs should be fixed to add mmc-hs200 as well wherever it
>> makes sense.
>>
>> The point of the DT/DT binding is to be system-agnostic and
>> representative of the **HW** implementation. At least that's what the DT
>> people want it to be.
>>
>> If the eMMC standard doesn't allow to have HS400 without HS200, then I
>> think this change is acceptable as is, because it is the reality of the
>> HW standard. Couldn't find this implied in the standard though (but I
>> just skimmed through).
>>
>> It's also quite surprising, as it's not because the eMMC works with
>> HS400 that it necessarily does with HS200 or that it's desired (EMI,
>> signal integrity/stability, etc...)?
>>
>> Now, it wouldn't be the first time U-Boot follows whatever is done in
>> Linux, so... up to you/the maintainers :)
> 
> Agree that implying HS200 does not fully make sense, however it was part
> of the original Linux binding when HS400 was added in v3.16-rc1 [1] so I
> think that this is the expected behavior and changing it may be an ABI
> breakage.
> 

I'm not advocating undoing the kernel "hack", but rather make it so that 
we add hs200 to DTs where it's actually supported instead of doing the 
same hack the kernel does. In that case, we wouldn't need the hack anymore.

(well maybe it isn't a hack per-se, but for lack of more info on that, I 
call the kernel implementation this :) )

Cheers,
Quentin
