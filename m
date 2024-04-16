Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E07C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 06:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4E6882FD;
	Tue, 16 Apr 2024 08:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6j0jCrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FAD882D3; Tue, 16 Apr 2024 08:32:43 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C824B882E9
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyCRjQ2oyeBP5RGiYXcqrIh2nIsmrQLH7Xx04sMQVE/ZzfC1oUW2bB96ZstR1UogkCslNBwcwl5s+UlASvRFPRaZgcSWZ1AULtuzLE4chqTXV6sqxOcufH2yUhrmh8REN4qvw/fvJdkTb1KsFSjoO+brCJFwnrWqlZsntCJ1gZYef/w3wBRUdVF5F8H3odtfNlyF08SgS9tRlZWx+uqIlqBKnr/IA5LWqvf3N6SWB8iVrjT+/9ltDmimwE/ZVRarlWHb5q0/KBPs7il7b6j9OtYx233+JYBEPeTMEZJVs9xyFOyl6jdRLrLsVqLtUr7SjWn54mFti6gWeUI6VtSfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx25ultpgFgEGb1oK7+WZ+ktV5dfw0EfTNFG3eMkO2g=;
 b=do5c8QzqhVsqVpf3BfOKyBQoRux5eFv//5ZH+3VJassOrb/EQLHMiLXSdUkXf6dy5T+9hIXTSwqurNtjP+YChKMvYaT6Tnabo3czPRsT5PCtf+V+V0YOsmw2nWOgrNb/6iiBVvfbDrkzMUKc1l2c+0DTpc4F69WHNpiXyYCBsBk6IZQUAU/t7yMFBwumdXnJVLnlcvcBDDEOyygxvY/9RvG5SfIEZ1yj1kMtKvql6EEwohokj8VgRn2z/5sjFSLlzdk58Y5uZK55o6PMnepxLX6kBzYq6fQcAwxRwrT7BrROI8Kir139huB1VO1iMpTwR8Dp+i6rNGcZ8Ntwn0Y7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx25ultpgFgEGb1oK7+WZ+ktV5dfw0EfTNFG3eMkO2g=;
 b=A6j0jCrHk4HhcxiPx6A2IUuDqM6gsYVWiD4aV+41FSS2vw2DKIMDweanBXV8mr3+fROwQq8Sp54n8mlKM/vZWFOkwFhq6nYnXp1RH5My90kdBuPXMMf7Opy/V8/m2r0Vy0AaUSLXBJW2iXl3GiP3RJXiUXwN99Yeu1FCjyccqEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:32:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.046; Tue, 16 Apr 2024
 06:32:32 +0000
Message-ID: <887b8a9f-a256-4fed-ba7d-e2422ada0d8a@amd.com>
Date: Tue, 16 Apr 2024 08:32:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Lunn <tim@feathertop.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
 <3df9f51d-d37b-41da-94a1-f05936ebd0d6@amd.com>
 <20240416003619.GK1054907@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240416003619.GK1054907@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0239.eurprd08.prod.outlook.com
 (2603:10a6:802:15::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 7105da36-e7e0-45a1-84a8-08dc5ddefec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAa3yxNw0XLJUAzqGSI2XyP1ykSSA5tuwoeM3A3Qg93RAD+0i2zygefC1kI9cfsC+K32L2BoKKitd++lMW/MIhHwxWarauOi7PpaP7eppEdgUq/FWbhYk58qXA0MogR4+/iDh7nybJ7uNvemufo0qSW1EepJ3SIqAGsOlzF1AQB5Tt+LG2DBQDdeWBcrYQyVwXgBBEun8qPnlJ+IaPz9SUaR1pXnSB6oj63ukcA96/X5OFLhF9KtWQgKBaYDi/x8D3RTIgKhPAJRgrsQEmiIvQbb5qlADn4gTL+aXBEWCWiLefA7jXozODsUd5cl9gBEtbtUd2QsrVovWTnTe0v4/zFz5Am7LifSYK1SlHwSdWvJwjKP4t+oFeYxql5/JnVYENTcdyJWl3lxFH3XPKSWTY0j8XuqQbovvLncErnQmcP8kmGgKvBoHAEr0HUX7XRaWecZCRlzWR5lSdSWF2Dfbp4sTIkgz0reGTi1LwnV7+H6kddP/belDCeqR3eLp3ncFfigkRMl4pqu5lxC+iZabEJtaU/IjPZNlnWXhVOG4LA1urgun5SmywDBecRyTdZtTpKE1XY+1WWeywc+ComXeua4W0duj22arxpX8Z7i46fnrK/cENf7vg06g0TQwtEf93ts66A+Bd4WWL8TEZ4lsI5N+0owSwD8vMtTZBSzHek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXo3dkNmQi9WSThqZ0FjL0VaU0ttRWtzMGZHZG9JWVJVckh1a2JadHNmbGFh?=
 =?utf-8?B?TGsrWnRhMXZ0NWpBVitvOTdqTHJoVFFObXE2ckhNMGFKUFFEd0h6QjRNWVFC?=
 =?utf-8?B?VEY0MHFldzRMb0xrM0h5MXp5RlM1WGFQZlgzdWlNUHRtaEVPaHYwV3k4dGsr?=
 =?utf-8?B?cWphb0UvY1RzTXI5a2E4T2owZE83ajh0SG5IQm1BL2wybURtRGRLOGF3TVhB?=
 =?utf-8?B?Wkg4VkNvcWtBbkpZZVBDbVNFN0laTnVjS3hlU1dsK0VXd0RLWU9JejE4ODda?=
 =?utf-8?B?aTY5NDhqQkZGbDJUYUVxRTkvMElzYjZwdHFYSkdYUkJ1RU9vZ3NRUXFVUDhP?=
 =?utf-8?B?WDJ1dTdnRmRaVEc1Z0d3N0x4UTRObDJSUDg2MHVxb3FuZFRmTjlWV0dHRnBE?=
 =?utf-8?B?OFdSR1liYjhOYXdyei9kRUVVYkh1ZHZyUEtHMzJWelFIMHk1aU5MaFN5ZTB3?=
 =?utf-8?B?bUorTVBGdUpQYkQ0YWphY0ZWd2JTSHdMZ242N08zUm4xVUNjZitqdXIyMVll?=
 =?utf-8?B?TENlNFBpVk54aVhkaXgrVFZFa0FwYjV3R1U3YlFFU29uUVJwUkQ2VE9zRU1t?=
 =?utf-8?B?eXo1QmorV1lNcE5UVDFrYXdldFl2bUtBSm9pd1hINkFiSlNMWm5WQXhIaEhQ?=
 =?utf-8?B?dHZmYTVMNC9JRnVUeGxuemlkRVdoN2dRa2wvMFlNV29lWnRXMlJORHhwOHo5?=
 =?utf-8?B?NkpWWnBwdzF3NVRWYzF3bElheXlYeTVWK0JKTlZtVU9NN2tFZ3VYRTJLNTVp?=
 =?utf-8?B?azFYa0diUi8rQUdmRUlpOGxvRGMxYU9Zb2RoTmE5VmZSZngyREVpSzBmZ0cz?=
 =?utf-8?B?NDUyV3VOT2liYUhnRTlLcVdhUlBFV2JDZitMcVNCTysrdVNMbGVrdW5udGYv?=
 =?utf-8?B?MGV4QlA3MHJFNk5jZzhtZGtXK2xIbzVVZVA5dG1rN1NQY2tkTUh4MnlCWVhy?=
 =?utf-8?B?Unk2aVdENitIK2tEKzZ2MWxrQUFiTXBSNW5VWWVqcDNxZ1JSeWxacnRyemJ5?=
 =?utf-8?B?bE5DV0F3VytsVWxBbnNIN1pJWVZWd2pJUXBXMHZqU0NnSTAycWZ0SnRheEdZ?=
 =?utf-8?B?dTNPSlJHQU5HV3gxbDhIVVhEek5ySW9DM2xtTmJTaDRiZDdKTDhOdXIxUWhK?=
 =?utf-8?B?Z1pOQTdVSGMwY2tGMGdHV2ZBL3k5U2Fnbm1oa2pEZ1FrUkpGQzNBR1J5Y2tj?=
 =?utf-8?B?UEVUbHJpK2drZ3J5S1ZUMzRUYmJHUncrK0tCYllFcXFuV0o5UHh6L0FRMDVq?=
 =?utf-8?B?MjI1TjNwdzJrVXozZnY0NjBBYnZYUm9malFGakhDaGwzOHd2bmpIR2FTSE8y?=
 =?utf-8?B?ZGluRDErdjJ6WjBUR3RlNS9pRjlNMStKRjJqaUt0aE9NU1QxdDVHLy8rS1Jy?=
 =?utf-8?B?NlJQWmd3Nkk0OUJ4dkQxY3dEQ1lvVFRVSjdUZ2NnTzdobjMxbjd6WnRIMjBu?=
 =?utf-8?B?aWdLOWV0VEtyWGNjYk4xUkNONlkveTl3cThGY1N5cGE4a1hZSnpnVFRxTjd6?=
 =?utf-8?B?bXcvVE9DZkhzRnY5NUlyZ0NWNGVYZG10WC9leXBKdnUwUEs0Rk9UYS9WOFFj?=
 =?utf-8?B?SmtoWTFTcG52T08xZ1o0REhENnhVdmxGTXBNdjhOR3d4ME1HZWlqYzFFNWRY?=
 =?utf-8?B?WTRTZExLYm9tWE5pbXBzTWNaWWhFMDN1elpwOGFzdlhHdlY4VGY3cFlJR3ZL?=
 =?utf-8?B?QW5qRTUzSlNKVEhrRytUMElyeHZNeEFROERKQXZhNlJtYVJiNDZYb2gySko0?=
 =?utf-8?B?SDNwQnFHVHZVbVpRZ1JrR1UvOURmTk9oRzEveDFTVE5jZmdod1dTS1ZxTjNM?=
 =?utf-8?B?d3VjSDdPQVAzZm9nTzhSQU9UbG5LWnJxWHlWN3lYTFFLdFZndUJWVlZPM3FT?=
 =?utf-8?B?bHlYVjVCQkhWL1E4b1dNQ3RKdXNiaU9ScEZPTW9ZS01GYlFuSXNYd0FneFo0?=
 =?utf-8?B?bWNsY1RFTEZjT1VZajBjOG8vLzhHVmFXelAzbWN1N3dHQTB4eWsxU2NFZGdv?=
 =?utf-8?B?Z3lJdENNNENxU2h4OXJ4ZTR5YVBsOHJlUzVVcDVyMEZoUjlrQjIwd1lnRjl0?=
 =?utf-8?B?alZIaTR6RWlhVi9tbHdncmZvdURHQVVyNEUybEVoNlBSclNpL3dqYWhzc3NP?=
 =?utf-8?Q?jDsCY7e4lRmFG5yMtlLxOMlW8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7105da36-e7e0-45a1-84a8-08dc5ddefec6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:32:32.0836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sqnAXWGjMPISXx356EsjQJs9SnMSQdp3l+V2KwQwv957XBURYIJsf4qRb4s0RU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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



On 4/16/24 02:36, Tom Rini wrote:
> On Mon, Apr 15, 2024 at 02:49:13PM +0200, Michal Simek wrote:
>>
>>
>> On 4/15/24 14:22, Heinrich Schuchardt wrote:
>>> On 15.04.24 13:35, Michal Simek wrote:
>>>> Some of Kconfigs are using utf-8 encoding because of used chars. Convert
>>>> all of them to ascii enconging.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>> There are other files which are using utf-8 enconding and pretty much I
>>>> think we should convert all of them because there is no reason to use utf-8
>>>> encoding.
>>>
>>> Hello Michal,
>>>
>>> The commit message does not explain why we should refrain from using UTF-8.
>>
>> that's a good point. I was thinking about the reason for it and pretty much
>> wanted to get feedback from Tom about it.
>>
>> In doc/develop/sending_patches.rst is said that patches should be sent as
>> plain text but encoding is not specified. Traditionally this was ASCII and I
>> pretty much don't see the reason to use UTF encoding (even my name has
>> special czech char which I am not using, the same is for Marek Vasut).
> 
> My point of view is that I think ASCII should be used in general, with
> the exception being names (I won't force people to ASCII-ize their
> names, modern systems handle UTF-8 just fine). I actually don't know if
> we should also exclude rST doc files from this rule as well as UTF-8
> should render fine and for example "°C" reads nicely in web/PDF/etc.
> 

I think that people the most of time just simply don't know that they are using 
non ASCII chars. Anyway let me send v2 with also patch for .c and .h when 
appropriate.

Thanks,
Michal
