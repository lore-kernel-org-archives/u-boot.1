Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8CBC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 07:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC9D86EF3;
	Tue,  2 Jan 2024 08:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="vF3ad9VD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B6386F28; Tue,  2 Jan 2024 08:27:46 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5828486EEB
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 08:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWsG+70VxX3RhuPC5Lujp0dJv6/g8tpEtFRqWvkVbAy52qTTM9VKU1Hbm/FLB9pdCGs4ueVkfFXbycClBPGY9sbGUHdvXxnhgnKxN7dBt9Mv0+/R7sbiiJyreYxw2HTiajwNOgoYBTCIMKaRhOyURPTVPkvnWl1h9FRsbOUmnXZeRa8PyjpD1fLUOAZgyR6C40LsUuys2LBe0PgvI5vl2ThfZ+jOE/L5Z6pEOx3xfembhTxYsV7aRW7GFf19B6FGpBpZ06jNhYT0J8PD9YPG/qwF31IdpQzZ4Cnxu+ER5ZUjqikBS54pFrwwBiXpUkdjFnSK0BmrjMt0QJ2skxLAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vfRJF3myajJdcjU08WuD2aiI6x2JzcNu/JtFlEvrA4=;
 b=gJJLOHYA+Eyce9YrVIv3xvSoeH8hRktJujQ0Z08MbxeanT8YGtCErUbfj6JdmCjiz74taX/OM0GHCVdTnUH72J9lxFKqLl5GiIgapMhub7q76xzt7dxntQltkTUzq0IeWj9BCAMHmjpjBbYvgp54A8qf3vjluVnHnXKDkAQo2z7etoEz2tBJ85fYsERJBU3tNpX2bw6V6dZr/OHNFgEeAtR5PVBytJgxNt4dJCxiYB743bEfNbLK/0NsVXbm7pnKkAZ8nf8mJy9hxkX9rPkr2czI3L8I5Q/PSqOyZjzG0eNmTuI4jVBnN3VTWaqPgzCal+svqoqoTRb3XT2qUzB90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vfRJF3myajJdcjU08WuD2aiI6x2JzcNu/JtFlEvrA4=;
 b=vF3ad9VDUdN9fgQTvuDE9zco1TxkLRFIKECcNpPaO2G5HxmRCDjEfz74UafgujqWyv2BIIONiUXr0on+M3oiULk2wSC+wbkj8LtPepsvhrXQSSY0oGllsqHBDVvf1H2zw/dFJx3rKOdU85nThDthRx9BnhMqmOv9flWN1YT10sowD9rvbuGJxQGkPzLoaHrNMk50xy5e83T7LOFqnT3ubACEDVThcD8+ITZoBU17LaYk5/yF4TaMpiED+gJlpPtw1exmVjC3n+BvGYRsskpPLVXvDcOdHEdiZsaJw5+T0KmkyGxPD+ThSWIWhvjSnad17U5HPZcES4A/dSzMEg67HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3957.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:165::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 07:27:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 07:27:42 +0000
Message-ID: <b4068fbd-e008-47a3-b2bc-b6c97f44df11@siemens.com>
Date: Tue, 2 Jan 2024 08:27:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] sync am65x device tree with Linux v6.7-rc1
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass
 <sjg@chromium.org>, "Su, Bao Cheng (RC-CN DF FA R&D)"
 <baocheng.su@siemens.com>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221200056.GM2513409@bill-the-cat>
 <20231227123928.rt2wgr3qa7rw5jmf@imitate>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231227123928.rt2wgr3qa7rw5jmf@imitate>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b393814-b094-47d1-9c3f-08dc0b644ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTvSxK3riRbfQH3ETBdlH2PHF4wdrm4vCwe/ObgTlIbMxBwSBYmxh1KFIQv6asX+N9Nk/3w+i5uPVsGA5DDDkbaMR9i4KfCUt11F+TDdziwqOcCFu0cO10yCY0TJU+A0zfhJa3T7rwU2as0YN3f/9qNwxeTeiUhYBZwhI4UyRx8INH7aO5P/cL4jLjsRNsGDhdW/0IYWIwdEGMPjW+mPJ7KTf5FpfMWjjG9v2ez2WF/dIax+QlijaOejQbvPS7Cly7ts9LcDJd6TOnS0Ewnzy5IW21zz/ICTb35kIIifroDmsae8qsL23NWEjdldVcAgRkxCUcrKKOD/Jtm1NU1i41oJv6Mfe3lET+tseUaYrnNgd9XDhJwmnqOTOqJQXkbrFZyES3WzkfG3E1Mrf3yC4detY9QVDw2xdJJmDeAmQ2shwQIckZjD6sPBrDWp4Y35QzmY0Y2Mi3X3zuoBzbi9ocjUGQLieWGyWX09CtfhkQktWlezzc8+2vjhNn/Oycqb7O+tiVi+wmE8RtOX9utsGzW8xOUgw16mt0WbrOOgX2Z++NLfrcu8rLH2lNP8wdvsbPdDSiGx30KVRUitrkylNfatmbX//Wg23X6OtsUUkUB/UNfcF44D4diU/tYlWOPg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(31686004)(66476007)(66946007)(66556008)(53546011)(6512007)(6506007)(6486002)(86362001)(31696002)(82960400001)(38100700002)(83380400001)(2616005)(107886003)(26005)(2906002)(7416002)(4326008)(5660300002)(6666004)(478600001)(966005)(44832011)(41300700001)(110136005)(316002)(54906003)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0JPN2N2MjNTTFA3MStOTHA3NHlyNjBrN3NLNUp0S3lPZkNRZ3pRVEliajZx?=
 =?utf-8?B?NzEvdkljRjE3eFlnYVpNdEt5d1pseGE1dUhuTkpLeXF1TzZITmZUWUNjbmVY?=
 =?utf-8?B?MmNXdS9HckhSbVRsUHJ4UVZ6RkVBbmdrMVF0c3ZZRDMrTXFMT3N1RU9ZVms1?=
 =?utf-8?B?bnVhYnJ1VE81UFBVTHh6dnpCajdYVHBUMjA2MTkxTHcvd0NHT1BWRmRKWUhl?=
 =?utf-8?B?Q2RBemJ6ak1obkRZTmtEUVpJL1FXczV4QmZON2E0K1VVTWo4VmRKRWwrQ0cz?=
 =?utf-8?B?OC9HRUhSMjNncjRDZk52Rk8zNFhNS00yenBQaGp4ditFZVpzQVJEY2NiSzZx?=
 =?utf-8?B?eUxsemhsWHZ2NnFKU0gwSkhvcVdTQnFHZmMxeW16TTRXRWZVQkJ3QmkzQWZ6?=
 =?utf-8?B?TG5wWWxxOW9IK25DYmdiWG8xMExPclI4K0xIMTdTMHRrWkhtaU56eUhFTDhh?=
 =?utf-8?B?N1laVnkyaU5oa0dyTXhkTGpsU3hTT1pML2dOUENieG9aRVBXSTlieGNhYmtX?=
 =?utf-8?B?K3k0b245NFZRUzJTRmxHU2hPVHZJVWp1YjRieE0xWUR1QWllNW5idnhOMmxl?=
 =?utf-8?B?cEZJQVhqV1YwRXVvU2NmODQxVDFKVy9aa0U2UnZXMW41OHJyZFBwYjh1T0V6?=
 =?utf-8?B?MUd0V0JENzJWanpHQ3ZrbTBzY3B4NWFrT1VodW1CRVo2ZXJVSkxqTFV5QmZr?=
 =?utf-8?B?N2xnSDdGTWtGNXQ5eEQxclJSeThiWTU3d0Q5dVdJNnhydE9QcmR1aGhVVmtw?=
 =?utf-8?B?U2ozUzExdnVXQlVVcnJSdkVqemF3SWx0S1BRbElPRWNrYXYyVG9wM2NValhO?=
 =?utf-8?B?N0x6R0owNUZFT29HRkJMa05teFhVdjEwNWxraDZ1QkI5b2dONldNbitTZVpR?=
 =?utf-8?B?aWI1Wm1XazYzYUZUM2NoNVUyNlppV0NINkNlL0tXNjR2cUNJZThNVC9QWThv?=
 =?utf-8?B?bzV5UWtjVDFVRUlyWGNNMGJXSFdNWVc2WlJ0ZWJ5L0xwdU5TZ2k2L2VzeDk0?=
 =?utf-8?B?YzZoVFZYK3E4UDJtMEZKN2FhTnduVVA0dXl4TjMvZVJkNWgvWmFadHBuc0g3?=
 =?utf-8?B?dXFwVkZTVmxoRWpkR2ZZRDRRc2ZGenY1UnVCcEtuRVhjd1RTVGNFZXhacnZX?=
 =?utf-8?B?RzMrcHpLTStEUzNLR1p5Z3dyS1lJalhSK3ZKanljNnNXUStJcDhnb2pKSGx0?=
 =?utf-8?B?VVFpT2ZCYlV0QkxDRHNscnVSVVd4Z0h5ekdjeVBsaUNZRWx5Ujg0dDZwYmRH?=
 =?utf-8?B?b2NsMmtKdnVzT01ZRTh3bm9zSThzS3RlWjd4bWNoVUZTQjhYVXNHdEZFalV1?=
 =?utf-8?B?YmtETStLWW1qd1ozM1RSWG90UGhUVHRtS1NZcmFhYnFvUGdwTGJzdis3MGZi?=
 =?utf-8?B?aG5pVzF4akF3dHpTdHdHQ0ttS3lieVNTQ0UwV3AwdEFpaWYrNklOYVFHMFlY?=
 =?utf-8?B?Q3hiNGpmOXl6SVJHZXVWNW1YcEprQm93MXdGejJ4VXBTeDhQazZGa2J4cTZ0?=
 =?utf-8?B?cGlmbHdwV3BycHd3Q1hyL01iT083U1l4dHZNQ0x4cjB5TjJTMGh6Q2FPRWNG?=
 =?utf-8?B?VDdUWm10dHV5YW5KcGorQkE5cDBWSVFpV0lZeGhzVEpHQkVobzVCb0h6Sktk?=
 =?utf-8?B?VWJUcnZzdGVObUlJeXAvWWs5VjQzOUMzNnR2aVZiMGRnY0JIMHNBUWVOYkFa?=
 =?utf-8?B?eXRZVTFYRGVjdTAxYi9GcGlYV21Fc0RXVzBrMXpGKzljRmd6S09rWDRkYjE1?=
 =?utf-8?B?UTlJN1poVzRnRE5rYzlKcFNpWVArVmNGY1k0SzA0L1VNUHd6dk5PRTUyejlr?=
 =?utf-8?B?Qk1MNE56aUJJODdxSmRrcGFjQkg3MUZvUHR1M3NsRVh1eVhYVXFXdHIvOFc5?=
 =?utf-8?B?MTRhWkRKeEhqcldGSVpOczVteXc3bXVmS3lQdGFZMXJoYitGd3JkRnBpVlpG?=
 =?utf-8?B?NW5ZVkxUNzRzTHQrSTErYnd1Z3FTdC95UWZTbjJ1L0dhYi9FWGFKR3BPR0Y0?=
 =?utf-8?B?VnREMDRla1VxcUhPdU4yMmp3Ylo1aHQxOUZMM1JWQUgxWFcvbnZqWHF4REl1?=
 =?utf-8?B?MWY5ajZqOUVabmovL0tnbHhpYWVmc2JZeUZTMFZVMHJIQjFwK2ZYVVNlU2NU?=
 =?utf-8?B?QURFdk1yeTA1eFh6d2Y4dTlxd0Z1SVZsNjZNRFFQb0lGNkJmN2ZJZVZycDhX?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b393814-b094-47d1-9c3f-08dc0b644ebc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 07:27:42.6368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebN3h/8rymhxwvf3zxm4ZytggYLoPGNbiwFD0YFCFuAYMXSO/8S1Mwxg08cURlE+jG91xSdG+PhOob6EkNpdUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3957
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

On 27.12.23 13:39, Nishanth Menon wrote:
> On 15:00-20231221, Tom Rini wrote:
>> On Thu, Dec 21, 2023 at 11:43:46AM -0600, Bryan Brattlof wrote:
>>
>>> Hello Everyone!
>>>
>>> This series gets the am65x booting again along with syncing the device
>>> tree files with v6.7-rc1 Linux.
>>>
>>> The bulk of these patches unify the WKUP SPL board file with the arm64
>>> files to make future syncs from Linux much easier. In the end the DTBs
>>> should look a lot like what the DTBs look like for the am64x which
>>> is fairly similar to the am65x.
>>>
>>> For those interested in what UART boot looks like:
>>>    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc
>>>
>>> Thanks for reviewing and happy holidays
>>> ~Bryan
>>
>> For the series,
>> Tested-by: Tom Rini <trini@konsulko.com>
>>
>> Nishanth, does this path work for you?
>>
> 
> Other than the minor comments provided in the relevant patches,
> 
> The following files also need sync up with v6.7-rc1.
> 
> k3-am65-iot2050-common-pg2.dtsi
> k3-am65-iot2050-common.dtsi
> k3-am6528-iot2050-basic-common.dtsi
> k3-am6548-iot2050-advanced-common.dtsi
> k3-am6548-iot2050-advanced-m2.dts
> 
> Jan - could you look at syncing those once an update to this series is
> posted? We could probably have a smoother v6.8-rc1 from then on.
> 

We currently plan to sync once support for the new SM variant is in the
upstream DT. Do you see other changes that would benefit from an earlier
sync?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

