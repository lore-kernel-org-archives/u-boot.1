Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE8BC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 17:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38259876A9;
	Mon, 12 Feb 2024 18:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="M5wRJse/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3B4876E7; Mon, 12 Feb 2024 18:22:45 +0100 (CET)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01olkn20819.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::819])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D204875FC
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 18:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRBnQFzoXKnZx4oWK4Wwg5Sv5bmPw/VuAQL9T1BBh5wMXBRvL7jDqabcpCedJaCFqJvJmPazF1p+CV4AJnblOHqh4SKOxgOQRIlZ+YeDQ4GU4JZDB9RVxtmn8mMEBZaI11+UmcK4wyxofjuNCPJEW8xLa/sbmaaZwyD18ssqwk0rsZ+ygdoxOuu4N8T+aeqIep0+vCm/mrqk/yGlXxkg+uqXzUUMsc09PLw31waGtIxVnUvxRzNBQmJPx2In/vSXmB1g2EPOos/addZrI7crs6evfvY3IvYrSKwLpudDblG+FP27L6rMQkeA/yrUEAcKBDZWWofgtEEU351OtdoFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXG81bduB0umzoPgD112t0hShohUSAYQ78MwTx/0XLc=;
 b=Z8QlLDJj4sGCz1neT7GczDG+hD0HfcPCQD+M199V2SZJ7LVMd8K0kuqejIxxlWC4ODZR9WvvifjCrlQJIAOEmIrwiwu73/Ac1P1DKbPvRKvQNbWlCtxgn9BCayZPK9z/baGv7GiDHWtTkfjNx1+D4mvAL/7pgmtXTsQUSsBb+bwm8VKh94fwIQ4mfDV8c+9YPP79V6mvTGbOqyTFGxfmyDNVC2p8MqAGD5j6keJgerEjxOf4tG54xBF2m/w88pzIkDB7yru+hWP/HfjFyhAAbVQg6eztyq+k4G50q7e+ZP9z5M/FBwUQ7fkfGv9pYYVaih/YLsd3dpZ/cgk84QoUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXG81bduB0umzoPgD112t0hShohUSAYQ78MwTx/0XLc=;
 b=M5wRJse/rXYmtyZXBozFUoJHpfaQgW7dyIFXuumc02KSbjM9YCf5bqkBiq7D08HixIpSic2fFMZ1A/KW36axAL2DJ+wJvdv7byTcndlCVCUg2CJgELlE2MJii2m3u4nDqCDFt2kbXINVHhmhdrH2dm/OOWAPzHbltmBJe1ytCCctHQ1/cHXJ4sEWW5v6XwtcoDVikfrLgcdpQGX47Z9oNNrARnbrdvOjQ+koOWKJ5PSGg9DFUGC17tk+3mEWf/JAsp1mEWCZg/0MqtVEjHOLt3qpJm4TPkzsoXVEUndAW/sRou7beg0jTOuZ+NrLSa2NMkNJf13ROY6lob2U5aDGyw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYUPR06MB6099.apcprd06.prod.outlook.com (2603:1096:400:356::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 17:22:39 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 17:22:39 +0000
Message-ID: <SEZPR06MB6959171348810A80B898980C96482@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Tue, 13 Feb 2024 01:22:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] pinctrl: add support for HiSilicon HiSTB SoCs
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
References: <20240213-pinctrl-v1-1-e71c8ead72f2@outlook.com>
 <20240212165827.GJ3040305@bill-the-cat>
 <SEZPR06MB69597D40FEF2059B89BC68D196482@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <20240212170814.GK3040305@bill-the-cat>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240212170814.GK3040305@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [/3i+oDc5ezPbsEVEsYpaLKF7DAApWI71jkTRBPM+h8GPU25RuoGEsOZKAUq+LZZA3SoGXkY0+xM=]
X-ClientProxiedBy: TYCPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:405::13)
 To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <12b0d63e-1e3c-4306-b9f2-ba4edb24733d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYUPR06MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8a3660-524b-430f-5006-08dc2bef3670
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzFAja16Y3H5lWfOjeApkwEg16ByxVSXqjIPdG6YYQkcM7hFDZ9KkjFX0puhpUai9JE7MZ+1Zga5kf0AAbJBpNTZQmHLMFT2iJYbZlSqLCepTLAWOypM4XPHpH9VYeGEMmYVnB+ddDhXF+SWkkzc6OByMcSm1QvSFC1WctQp6jQckJVnQKe6upowag/JokAwsRAXfFgwZPAqMHG9BMPdwChmD8+9bKXnsep8qriqGf552GII6Vj3Zrl65L2lZRonXwqAGDlLyPFoTv0tkL+Rm/V/d/mttrBU3wbnjE9H04VjQXQR3G3P0V92pgKPBQ4pcNPk0Z2jvcByW6I2gg8l1omvcEAnmmB1H1lpacbkoF7hR8hSi8k7v6kIdgNVTmJsvIhC9udc9Axr1DiZ1skrtEVplPqbZFG1U8nX7vJAKVRrKmcpFN6EsPcwQHLHHhaFq9gQ/9wi0RgHYsopJtrXfmq0PIoz/GQ0DsxrXCtdUNAJ/45cH+Kjl1HEEDD0hhPz9wOCxZKWs/IKa+bWRObMiy10MIcd3TuTICTgaVJGc2nxOty7eCIQsFCAtdt0rsqN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29CQjgwcGVDMjhHVy9TQVhHbGRveUcwUi9ndGFHL0VHdFl1ek9pUE9qYUpZ?=
 =?utf-8?B?b3JpWXN3TGJqVGtCSFhUVVpjL0NnQTM4Z0FvNjE3OWFERk8weDFUSDgvZDZp?=
 =?utf-8?B?ZGt4NVgyVE9FYktJWDkxL0ZDak5OVnlZclFsVkYycW02dmZiS01velZkd0RF?=
 =?utf-8?B?T0dHazJzYlJxb2kvMTF6UDd3LzlxQWsxVTJPZzRoOE1GeUhrQ2NWSmFxRklw?=
 =?utf-8?B?c1ZQNkYyY1FMREZ1M0UzbjdVMmVMTnI4NzN4cVBOcHVObmVaeFdibmtZTmR4?=
 =?utf-8?B?aE14UllDeHovaW9RbG5nM1hYN1NYdjdGQzdlTUMvWGdWU1lwbFdwQ0h2aEFQ?=
 =?utf-8?B?SnRFaWFERzNzNmFDenVCcXNTQis2Z1VPTC9DYlJ1bHBBbGszUzk4ZlhGTm5a?=
 =?utf-8?B?SHBJYjlSbitvZWtkclhReVBCSDZvaU96bkFBWlRBRnphWTJmS3NSWUIyU1E2?=
 =?utf-8?B?ODN6aEdhZHRsQnNCVU5oQUpMYkd6RHk1UFRKdlQ0RXpoYmU3MWRtRVJmVThT?=
 =?utf-8?B?a0owMnBybTNqYzhUVU81M2FSNmdjdDJJL1Y4MWdMSHhqQkNzSUhRVms1c1Nh?=
 =?utf-8?B?YkpFYkZ5VE5pdit6d2loY0ZQZ1NQbTBETWJMOW5iTWw3WEY5OUpidDZSWG94?=
 =?utf-8?B?WS9LMzVXcVE4czg2RUNNUjNMR0YvQzJRR0xYczdRYlBwd3E0ZzBqNm9HaTU2?=
 =?utf-8?B?bmNIczlQenVsM0F4dTg0bGVBaklkbmZGcW9pUXRkWUo0VmNFSUpkS3MyL3hk?=
 =?utf-8?B?WHJMQnZzd01FbmFoUTh5Q3c4K2xHZzcxcmdEMTZia1YzdFFZcXlxZ3NvOFEr?=
 =?utf-8?B?MWJ0djRiSFl1YTY1ZVg2YUhmSUlPYzJZWTRjd01QYk00ZXE2N0ZzSXlxV3BJ?=
 =?utf-8?B?TDVoSE9pSG1HbW50TmgvTGRBSWdscFU3dXdrTjRUQmtxaWdxSDBnZXd4REJ1?=
 =?utf-8?B?dUc0aXhGckh3MjdnNUdWN3JwQ0thMnlWZFE3akpEclB5TmpkM2grUTltQlg1?=
 =?utf-8?B?cHZlbG1kbCt0TERRcTRra0JxOGcwYnl5eHpka3A3akkySnVDRTJaaFh0cUVz?=
 =?utf-8?B?dUs3RlkxT3BxM1d3ZW5Sa1VvSjZzaldqdGxnNEE4aFJScjljYTdZcGpKOVhk?=
 =?utf-8?B?bVA2Y0V3aTNjV2Z0d3RHNGl1elRFRjZoeDhaWHJqV1VwWHZaTERuOUZoR0F1?=
 =?utf-8?B?MmFhS3JsRlBCZE1kOFhRMFkwdElYQmxEbUd2NExoUGZjUWJHaU8xaUlkT3pF?=
 =?utf-8?B?L0VmWUlRNGY1c0dndW56RWZ5ZEVSU1RxVEtScVpiZThOMnM0ZktrQ3RnUTRO?=
 =?utf-8?B?YzVQa0E3MVlIYXNWamhSeVl6bUU5UHZMNUJOT1hpNVJyR2pCbldvNHNnOE92?=
 =?utf-8?B?dnlpNDJQMklsMnFzaWNybzJWUEkwaFR1a3Z2eDJwSUxOMkx4QkVjUmVsWFhO?=
 =?utf-8?B?YVVoZ25WQ1hLWldvWGN0M3ZpaDJaUlpxeU03NFd4dklTeVhxa1BtamZtVE9U?=
 =?utf-8?B?Tlg2ZVdMMkJiSUI0bHdjYkJ3S1FsZFlZcXhVTytHeklwbFFuQVgwUXhsOWcy?=
 =?utf-8?B?UmNHb3V6WUlXaGthNDgzY0JFS2JZZjZCaWhGMVppNFZ2ZVpBazZ2MVFDcnVa?=
 =?utf-8?B?cGNvVmYwNHRQY0NVRmMyUFhWTGl6ZE83S2d4eFcrOG4rL0l6WVhNT0dDcEdm?=
 =?utf-8?B?REdmOHQ2My9KSFluSDBaS1FrTGlITm1BdDM5NGJSTUZ6QTFVTlFoWXNISkV1?=
 =?utf-8?Q?7T12pg4Ij7G3Nu55GibhQ5p12vq2sg5IyqWtvVy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8a3660-524b-430f-5006-08dc2bef3670
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:22:39.1481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6099
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

On 2/13/2024 1:08 AM, Tom Rini wrote:
> On Tue, Feb 13, 2024 at 01:02:50AM +0800, Yang Xiwen wrote:
>> On 2/13/2024 12:58 AM, Tom Rini wrote:
>>> On Tue, Feb 13, 2024 at 12:30:15AM +0800, Yang Xiwen via B4 Relay wrote:
>>>
>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>
>>>> The first supported SoC is Hi3798MV200.
>>>>
>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>> ---
>>>> This patchset adds support for HiSTB ioconfig module. The module is used
>>>> to set pins config(e.g. pull-up, pull-down, drive-strength etc..) and
>>>> pinmux.
>>>>
>>>> The first supported chip is Hi3798MV200. Adding support for Hi3798CV200
>>>> should be also easy.
>>>>
>>>> Below is an example of the dts node:
>>> [snip]
>>>
>>> Has this binding already been accepted to the kernel? Thanks.
>>>
>> No, I've not wrote the driver for linux yet. That's why it is RFC now. But
>> it is expected to be soon. I'm going to finish u-boot part first and work on
>> linux kernel later. After that, i can sync linux dts and bindings back to
>> u-boot.
> How soon before you start on the Linux side of things? Given that this
> wouldn't be merged for v2024.04, there's plenty of time to get that
> Linux side going (or at least the binding reviewed and accepted to -next
> or similar) before merging here, and for U-Boot the biggest feedback
> (aside from anything checkpatch.pl may say) would be to get the binding
> reviewed.
>
Sadly, it's not on my urgent list, since we only need to setup pinctrl 
stuff once during boot. Not even this SoC(Hi3798MV200) is supported in 
mainline Linux yet. I'm keeping working on this, but I really can't say 
how soon i can start working on Linux side. Though I can say it's not 
going to be very soon if i'm the only one who is working on this platform.

Maybe Jorge and Igor can join and speed up the process. Since 
Hi3798CV200 is supported by mainline(This SoC is used by 96boards 
poplar), writing a pinctrl driver for that SoC would receive more 
comments and reviews.

-- 
Regards,
Yang Xiwen

