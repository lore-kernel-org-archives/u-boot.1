Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB54C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7540F84409;
	Thu,  2 Jul 2026 19:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2QRfDLcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F95E8484C; Thu,  2 Jul 2026 19:12:35 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCD984119
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKeK4T7u9dDpcFJcx9tZY+Jbkj7D2fEgWNbaU7jbyW+bGF50NPT/8Kb8ocY0CCexpbsUQB3NABNGxT66PuPbEM3yxlEjRAKVSBbG0WI6X0NwhJnbxlpvAmyBbD7FX1efXKqSCiQPktZAfp/Vwj2x0rmEQ6CGMqMLv1GAGUaVHWo8Pct773flpLFYBGndG50yCaHv+T6opwuH59URD6PAQd7FYTWy8mgoM5NWMBhZ+OfkS8bN9Qp49SOXSuonb+87UHS1Fiy7rbFhvDhYlRiyVJn6B0Vs2pCkS/x5UCp/ChO1j2dUGJvr0S3YoxD7VVGe5kvrU5g2JNh6xKgmH0+Ujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJMy6pqxg9TwAB/Gk/WA92x8v1d9exLD9KUvrBE5+io=;
 b=qScuyOo0xrFxZzNnzn9hhTkctlpJQFhL5daE5xyFZZJNUGsuS08ihfV671sH0a/W+C4RsF52O/PZAJN9aA5ZGj5VtJOzqVai8jh/uqzcwkTcKTuzFCsBfcDtYeZLwCXkarzu8bAFOuzryqUOWHFUFKBBHCM3c5tIT5fPT4G6KeD/4CdhgnUd7qNjABUbblz9U4A4f1QiEH2xFEHVyfDDLYjZ/yOaFHIf73TR1en1L8D0N27m54rec31h164wey7ltGibzkzNzWleVLF/j1ghWNq6yji+WQnephBLpJSmq7guxZDQhtTAHIE38pSrlsHf/EkEK8/EkbvLzc8IZCf3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJMy6pqxg9TwAB/Gk/WA92x8v1d9exLD9KUvrBE5+io=;
 b=2QRfDLcSMj431DYe0Dtc53Uea8RDiw8iYNo6RWllIDKV0EPGYRL/njmQfOay+JCMImZUIoKRf4dcJCUh6Akd9eIkiZ9p6DkLIt+K/WskQ1dcKTFyT8CKj5vl5BODP3ytkDZCs7wBUteDeEpQhw4/Fl05aV6c7r0RFQgivVO6FRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:12:28 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 17:12:27 +0000
Message-ID: <21f23ce2-d573-4774-9f7b-c786e3e73d1d@amd.com>
Date: Thu, 2 Jul 2026 19:12:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: versal: Fix snprintf invalid size argument
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB280518E35381D7CF2CB50C60DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ce38a9bb-4d54-44b8-b6e1-b88d8eeb9c83@amd.com>
 <BESP194MB2805AA926AB13692A1DB397EDAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <BESP194MB2805AA926AB13692A1DB397EDAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0106.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 1557e9b6-42e5-4dca-3b36-08ded85d1786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IZ1u47FcyRboW6YLjSFodD3PqIdILnUtQTODyN/7lqBw7H3wOkErEBV17T5BbJVz0U1yQFSYuNAGCUceA2ACyWmz8XWYwp95CiuQLCaqd1QGJaNXAAdK3IRp4OAibhvk/NbjB81hTczcej+2cfuRpEh6h0FQLsh8Ab37m6nOJUJNvNm0mQPOR1DYD8OiF53eYRv2dQuhutCkqVIx2B2nh8LeMbrULHhY5OZin+O5vFf3WkA5Y4zmiw2zpFW3h72kMCleon5P/i1EvZ+s3db8a1rmx5oZRwlRt7HGHgWMqr4MNGBsDP6PkMW7EtGmTzg3nsRwvTYdpIrU+g1tNrYCYe1ZlvGDYulQWy0khLfPA0/YUX9zLQPTGt8+B5Q2KJhcMrgeNWw0ZIo73VKVLXJyxcw8x0zLpYWy21XIEAvovMtLl5UjHuWwU5zV5hhZITX8CGWYSYQTy9p1fR7wj3R0hdoPJdYk1HQ1qT0O/5zMOrfMfq1dmykEsoBrsQHpBSl6ZA3pJieMK4sDDat9HW42zOW/dc8outREZxipbK90aTOeL1aOXYDp4i/h7VNYiVMUKOBcc+0n1TRg26Sudmrl4llF9wDuM+DOPyCgIe2VA210qnj/zThMF9a1GeQbqBBUv5MABqB3M88tFycEEYd8uSM4hS5PoKMgenDWmyC986w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZpZkwramNtVmZuNGdvOGV6TzVFUHZUb05GVUw4SXMxbUJ6Q3hySzFrWXR1?=
 =?utf-8?B?ejJEUkRKVWNFQlFkZTl2ZVZGbkRWWGcraUw2aDZxVzlwa1JRQUVpTzV5Sm5H?=
 =?utf-8?B?S2pPWngveGptU0l1OEtKWTQvQkMyWDF5RC92ZUxwdlZ6UCtVZkhtb1I1a1R4?=
 =?utf-8?B?UWhyM3FzZGZoRWxPSTdjWnFuZERYT0NoSEZ3Q1hoT28xRkhzYkdJdGZNeHB6?=
 =?utf-8?B?TEs1aEoreURBN3JuNy8ycVJ6eUsxZzJLcjN0TWZ6Sjc2a2x5Ni9KbElzbUtP?=
 =?utf-8?B?eGJuZzJ5bEtsMnMwOWlYdkZXRlV4bStmZllxdzdJSjNMbGpsdFo1UmcxS3o2?=
 =?utf-8?B?WmI0cWtYZS9IcmoreDg0OGFtSUkzVlFJdk9rSkRoZFBIbUliN2t5S2d4OWVU?=
 =?utf-8?B?MElSdkxuQ0p2REVGVWNQdU0wWVNQbXB1ZHNRdnBkLzhLZ3VVWE5SeDkrS3pX?=
 =?utf-8?B?OWNQNTczZlpiVmVzdVZVMlRFS3NtQ01ZS01GYW8yM3NqcHpPYzFIRUx3ZURZ?=
 =?utf-8?B?OVpIb3FlUHZUUVNBdXZoNE43c3ZuaGQrQlpDUDNCSWxNcE9EaGtJTzh4YTVF?=
 =?utf-8?B?bit5enFXczhTR25VVmpoZFVwRmYxYUEvSHBVRGhPTjVXRVA1SGhhWnhKNmdr?=
 =?utf-8?B?S25sOFZGVjVZYTlBbTVnNjhvaWViQWQrWWE1RGQvRlJ6ZWovclhmbjdRWE9y?=
 =?utf-8?B?MjVaUndoRnB2WjVrN0pJeU5adDFzWmlISUllN3VQcHRaUFNuYktLVkR0cHdT?=
 =?utf-8?B?S3NrZnE2UmVsQzNIUCtNL2RxS0VQWlZvK1lRK0FSejg3UkJHN2ZYbDlzU2Vh?=
 =?utf-8?B?aVhmc3hQaWRpaEpjRzFzeUJ6cy9uSFpCay9tdnZsZjI5SlFJZVgxVFRuMVJL?=
 =?utf-8?B?Yk0wZ2Z1dC9DUXgvbzJ2MDR6NXpCYjNkTGNBeUozUVZWd2ZMdHVXNGkyem1w?=
 =?utf-8?B?Q25lUXRQc3p6b25zaHJDRnV1b2pTcStxZktkcWI5aFJEVHlUUml6QVZ4WUMx?=
 =?utf-8?B?NkhOanVQK2FhZjBEamNGaEN6cVo4TGZIeVR1SFIyYjgwMURuenJwWTdBV09F?=
 =?utf-8?B?eFcvSXk1S2k5VVlrWVl4ZVlXQ240RUUwRFBGcW93L29vWUtlcW5ZS0lXcmEx?=
 =?utf-8?B?dXZPc0t3dE93eDZkUXhiaktMWmtuY3BUYXNnVzN0MEhzcklnNWM4aXpXOWdt?=
 =?utf-8?B?aHN4YU83eDJ2VEpxMTkvbkN6NDJaOTZJeFh1UldiRkYxTUpERVlISHhQbWpW?=
 =?utf-8?B?VDJhL3VvOGJmYmhDQmJZK3FYSGJJMmJQYkEybnhtMmFyUG5ydWppMHFiMUhq?=
 =?utf-8?B?bHdUOC9IMWRlL3VrWldkRkY5OEhhU2RVZVkzZE9pdnlaUjNLdStHdVlRSkpS?=
 =?utf-8?B?dmR6dkJ0SW9jTXRrZXRlLytDcjN4M3VJL2orVGdUcktFVGUzOHhBUG90cVly?=
 =?utf-8?B?aXgzeHV1NDl3QkpRMlIrU3hvUmpEdXQ1T0VRU1gxczNSeEd6U2psRDNVbDBn?=
 =?utf-8?B?N09WU2xFRnNIYk4yRnhzWFZZQkpCZkp3dkJsc3NVNXlLanducjQrMzQvOXBx?=
 =?utf-8?B?a3NURVRZKzhob0JYM2czdzB0Skg3YTJIT3N0L2xySEpsS004aEJibkFiVjR0?=
 =?utf-8?B?eGh2dU91d0F1Ty8zVkJ3N0g1RmY5Y1B0OWIrVHByNUVEN2lTNzJ6SDM0TTFF?=
 =?utf-8?B?TCtSSW9yVWZpaWVQOG1HQ3NqbFM3ZUxEQ0o0NHZGTHBwQ1JHTldSbi9RRmFH?=
 =?utf-8?B?a3FidXVPVGJNR2l5ODk1V1lEajNyS0FrNG41eFNocFZncE85ZUo4WEMyeEJq?=
 =?utf-8?B?MEp1eU45QXZqNURxYkxWclBHTjREZldicExQclVNdGpENzNSTlNXUWpaUXNM?=
 =?utf-8?B?MmFKM1VMaGVDZFJTb0pvUEN6SDhPU1k1MmsrNVRHWTdNdHRhS290aDlDblVw?=
 =?utf-8?B?dUVhZ3VieFIyY0MvNWtxaHhvNkViV1hBUUMrcEV6My93RTVyUGRGaURaeWRZ?=
 =?utf-8?B?MFA4NDdxenkwbkpOVE1WVWx0SytxcGs0bjBzQlBVd1ozMENVdEoxOExVUkNp?=
 =?utf-8?B?L3hWeFhqbjhZTk41aHRyM0Jsc1FtUmcvaDdZZXduVERYOHVHaVVWaHJDY1lj?=
 =?utf-8?B?KzNrR3hyaXpsMjBkTUI4QzZSdWdYQk96amZONWJ5blF1R0FjR3hjbEUyTzhD?=
 =?utf-8?B?blFoaFhOZFc4TDZFMk5iNDM1N0EvNTkzbmpKb2hKSTlIWlRvMkl1VmJ0djRB?=
 =?utf-8?B?NHVYVHBIRXorSWM4Z2FWV1dZSFJBMDRFSzRna2RjWmxYQ3czRy9aQlMyZDFV?=
 =?utf-8?B?QjdjcFlkYUg3L2EybzJabm5wdDBEbDdHUG1BSGN2QkpJbGlWOGk4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1557e9b6-42e5-4dca-3b36-08ded85d1786
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:12:27.2536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wxvhugyn4TATwP67IT7mTwjaWnet2UncFGLzbyQKpWN+I5AwY1TyPsWKSZo1LtMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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



On 7/2/26 17:28, Francois Berder wrote:
> Hello Michal,
> 
> 
> On 7/2/26 16:40, Michal Simek wrote:
>>
>>
>> On 7/2/26 15:54, Francois Berder wrote:
>>> buf is an array of size DFU_ALT_BUF_LEN bytes.
>>> It is gradually filled with data using snprintf but the
>>> size argument to snprintf is kept at DFU_ALT_BUF_LEN,
>>> making it possible to overflow the buffer.
>>> Fix this bug using the correct buffer size:
>>> DFU_ALT_BUF_LEN - len.
>>> Also, replace snprintf by scnprintf, otherwise len
>>> variable is incremented incorrectly. It is now
>>> incremented by the actual character count written
>>> in buf.
>>>       v2: Replace snprintf by scnprintf
>>
>> this should be below --- not to be the part of commit message.
>>
>> M
> 
> Do you mean the last line v2: Replace snprintf by scnprintf ?
> 
> Francois

I meant version changelog shouldn't be the part of commit message.

M
