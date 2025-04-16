Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B63DC369C5
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 15:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1CD082F30;
	Wed, 16 Apr 2025 17:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ixnbDM3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B0C82F35; Wed, 16 Apr 2025 17:09:30 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD2D82F00
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 17:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiSJzeSqMhjuy+SHwdjrjwBmGy8ZvYCvtKVzMlZ9ljyMoSsWad4veHDnKtm6G+jeJt2cqBZjwqpJ/g+hkO2lCqAHLFtI6h9QonTGltH5XmsV6JZ7JOaINYmiGx5wxpAPp2pCW374UPfnLDuP0EU7BokMaPt5joiQvb1kJYWKrCpsPBwpNusDw8VvhlwXmTi8Hk1b53Uo+A3ZeWI44MGAnuoDEEQKYsnDJhE9hcnjq7yAogJltEECZeO47EVOl1zvhcMZkGu1R1G5s1m9BJ4Y3LPGp0GGFpFmbaK0Q0nlkwqwAau2iCcW4/VJuLWD8Lz0bm+PYbehYf6Grf72qoh6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLjh5LgpxtBcz8xqLD/6bJaSdPpVGekDIopHNd3rxSo=;
 b=ISaZ5Qi3kea1JQ0sjoE3ZJrPDC9sAovFnQ4S3JLky5UowdadlyN5BNMCf3CgRJO1mmkaeFI8g1NSY054QwHzfbtAgP/j/bpEkPql6hhYBvTIZaMeCfZ78vgZ1V8IvClyN5DeK0VCdw40ouIsDk1rtsD0ZLPa4ZiZVh2JJ6yB5brENqnXESDmh8REjXWHDAiM0rvySNnhVIaLQBj05J16EEKVuJiZxX1rhF+gSnOSf2z+8hQq7ZgSM8BF/i+31J3utKgwXqPyyFd6YS9F/Cid9p1zxFz0XLKgFsC6t+2ont9ymIxMmZ99J0PqR24u0BrUy1Nue4JhPs/U7fYCP90OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLjh5LgpxtBcz8xqLD/6bJaSdPpVGekDIopHNd3rxSo=;
 b=ixnbDM3i9lQZTKQ43bnKnfF35qUK+CpN2Q88wCGvucBFKbumI8lr1QdwCocSASd9qYo+U8xvkUqtLsOY+xrMnLODXSgnPcSNa2xbRn2WEDdMnt1wAad1DOeve0RZGloWCtGYM8UlGUmLZmoJzBFeb0t/dnea8Y+xCHsGF228m54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 15:09:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 15:09:26 +0000
Message-ID: <292e396d-5c02-4d10-a027-1391292e5d6f@cherry.de>
Date: Wed, 16 Apr 2025 17:09:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/make_pip: Use venv when invoking pip
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250416-ubuntu-24-04-v2-1-bad2be600857@kernel.org>
 <7278a03f-57d3-4e50-9c84-8b329c2032e8@cherry.de> <87cydc4264.fsf@kernel.org>
 <b9421f29-1b84-478b-8237-782b3fd0bbb2@cherry.de> <87a58g4036.fsf@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87a58g4036.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c0ee72-370b-4be2-3775-08dd7cf8ad55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rmo1RGpPWEFBMmJ3eXNwRVRJQis4SGRtem53UDVNQkNYaE1pVUh4YlVMUzRV?=
 =?utf-8?B?U3Z4OTlGMTJ6bmp0MC9WYjY5bVdJYUVoQTdnYXNlbG5MZGp1YkZ2TGJPZHlw?=
 =?utf-8?B?aXNLaDZJbVUra2tqMHh1QVlDY2ZhZUpJRkROT21mdVdOcTVsM3F4cVRNeHY1?=
 =?utf-8?B?N0YyOG5kODVWV1dieU5VVTV6YVMrVTBWNFF5Z29zTDRUOFhmcmVhalk0d0Rs?=
 =?utf-8?B?THF3dGw4d2J3YkxsVDlNbnJZcWI1WGMyZnE5SDh6RU1VUW03Wkh3ZVVwazV6?=
 =?utf-8?B?QTBBRkx4bXdWbkRDR1BTcjd6b1liWkl4SWJjWlNoUzF3cjVzRHVzdklrWmdV?=
 =?utf-8?B?eTMremhNdTdkNWF4U3FIMEJpQzc2dVBCS0toN1NxT2g3VlUvWnlyR3V4eUha?=
 =?utf-8?B?cHhidTc4SW15V3d1YUJablVJUGdSQVFGZ2NWREZZdmpOQXI0dCtzR09iNWhs?=
 =?utf-8?B?aHB6TkE0QUJ2eVRTa1l4UnVkd0tVLzJtZzdNR1EvNFVDNHlIRWtlNTExWkFs?=
 =?utf-8?B?NUF1L1U0Q1JjdnlGSGIydW02d3krSnpTbmFhTXJDYSsvcjEySGtRTW9yODB3?=
 =?utf-8?B?WVBQUHBwZ01mQVNiMjlvSDEzY0REeTlzOFVTWm1tejR6WmNkbG84WURnWENQ?=
 =?utf-8?B?TmZIRkk3OW5RaWIrQVhSMGpmRFBQblN3ajlMeElvNFBWMEZDSVMxcTNXMnpa?=
 =?utf-8?B?NHM1dDVtaTdxUG1pMWhrQTZoYTBkMjNGOFFEdjFNT00vY3p5UmwvNHJzQkJG?=
 =?utf-8?B?U1FGMmZlVWk4dHJZMGNhbHNVOVZ2RTlzWkpXRS9BUDJ6QStld21oYkRqaURH?=
 =?utf-8?B?dnZad2I0MkI4MWdQcGJacFR2L1R1K3VoSTV6NUlWYk83NHFHZ3hwb0I3RTgx?=
 =?utf-8?B?bmtXeWVaRFRwZk10Y2FuZ04wSXlPcjFpdGhuTkhnOTN2cmdXV2dZdi9pa09O?=
 =?utf-8?B?UTNxNVNuSFFpWjhxTSswQ1hjQUtRTHhOc0VnWThuTWJTSURvajlKOXpDQ1lE?=
 =?utf-8?B?cldRT0dIZ1ZuOVZkd1ZDVE9wckRsL25vMVNwV01zaDNvcnd2bWV5NFRvMUtS?=
 =?utf-8?B?RGVkRTF5WnhTWVV0UmpLWEp5VmMzWFpTUVlrTW5wcGZKQUVNVFFyTmJBVmly?=
 =?utf-8?B?Q1MxUzJZSDNXZW9vNW16WGdMM05kbzhUbmZ0NXkvdXdtZnIySFJua2VmTldB?=
 =?utf-8?B?Qlp5QWhoV09IN0FsTmdIVzhMTkplOENZSndTblhuVjhqY1ZISmZXeXNzWUNh?=
 =?utf-8?B?NE9zZnpUWjlRS1dveENvbzZwbzhITFFERUJla29hZ2MyS3ZiazBDYzBpdGs4?=
 =?utf-8?B?OXBiY0hYcEtaVmZGYVNBK2VoOHFkY2cvWHV1ZmJxSWxzQ0Rocnh6cFNtUU1s?=
 =?utf-8?B?U2taTHdIdjdmdlhQTWZNcHltc1hjRVgzN0RaS2xsMHB4bUFEVlZnSmF2cnQw?=
 =?utf-8?B?K3c5T0VJTkdNc3J3U1NEWjJsSURWM3NPVkxEOGJ4YmNIZjR0WDlERXNBL0Vp?=
 =?utf-8?B?QnMyQlZTTnRhODlEYTRtT2hYbHJYTElHRVRaYzRFMkp0NUwzNDVpZzlTSktQ?=
 =?utf-8?B?dHBGd2Jmb3ptWGREZ2NkREhBZ3A3c0orbTNrbTVQT0JpSGtBODBXMVN1SnN4?=
 =?utf-8?B?RUFkZGxVUU1Ddjg4MVUxSDRrcUt3YjRBSnAvMkFPNlpJQUhpRCtxaWM3NTJx?=
 =?utf-8?B?aDUweVQ0TWNpQ3BuSUZnSWlMb1ByYU5Wei9NMGwySkRNRTBIU1NiaC8yOFFV?=
 =?utf-8?B?YkZiNjZ0UHRsdVg2SndBNnlwQ2xvWTdjYWkyTEQ3YTlCTUxTeEVqMURxZHVI?=
 =?utf-8?Q?d0SI7C0YVDyeY7YqVExHyuyhfo+J/UK3jqCqU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVVSkh0VnJ5UStCK0lJMHYrVWRnN3Z1SlNVQkdnd1Q4WHRyUnJQcWI2THNQ?=
 =?utf-8?B?dzQ3MjFUdVY2OWF6ME9tQ3oyUDFhMG1RcTVNK3RnYTlwU0tpUzl5cUFMTzZ6?=
 =?utf-8?B?bWttR3l6L1g4T3lJVVljV1dMVklhSkFkNjFnM0wzM2xFN2FRVTRML3lBVTdN?=
 =?utf-8?B?aVFsSHJYUk9PbUc0MWczV1orWi9xOFRYYlBMbDVqVEJiNkNhVDBPWmNQZnRv?=
 =?utf-8?B?bU9IWXZUWnFGbWFqUi8yMjltNjJ6RmN1QjRHdURJZC82eVA2S1BNS25ZUnBO?=
 =?utf-8?B?TEFmRWFSYkdubDZnR1MxL2x4K05BaUllRmMyZmhTb3JWekNmRm5ybnhtTG1m?=
 =?utf-8?B?VW9kbHVyVkYyOEhhTkdhK2NheDVlOWZIQWRtSFp6cUtGbm5WaTZ2bGpYbm9P?=
 =?utf-8?B?S3c1eUNiQTFxeFNIajZMT3FxTEN3TDZkQ0d6djMzYU5OaFk4WFhRTGVLMFBw?=
 =?utf-8?B?OG4yWFBmWFVDczErSjZ4azQ0TDlBNG9tTnZzalFiK0NtajVtbk52TXk1TW5S?=
 =?utf-8?B?OVNzWDg4d2xOeTI4d3NUYXBaU1JBczhwVEZ5WXdlWXlvRzVnaENENW9WanYw?=
 =?utf-8?B?S1BlMWowaWoxQjN6bytQeGY0cGhlWEx3YnAvbkM1SkxGcmFVKytLR1lYY0VI?=
 =?utf-8?B?M1JmVWppMUt2ZU1XMDREamlrTmpDcmwxT2hvRVgwQjBmdTlIUGR1eGpHUXRq?=
 =?utf-8?B?UkdJczlTR01DZk5ycnFVV0h3OXpkKzNRTytKOVlZWGdJQmhkRFJ4S2YxZGRY?=
 =?utf-8?B?VUZURitXZEZKSG13RDRibENVZmNxWXZFK2JTZlFPR0czblZ2YmdPUEJLMXlz?=
 =?utf-8?B?L2hhbm5aOG9KRjRuUjNLNXc0SWtXNVExb0lBWUpwajlabldaWVJYVnp3amN6?=
 =?utf-8?B?dk5xR2t4V0xxc3NPQzhMV2RwNzlZRXo0V2ZSeWpxRVJJV25mVmw3TG4yOTM1?=
 =?utf-8?B?NWZsaG9VcU5uQ2lrMTZUYW9tTmxzaFJzcVkwZjZDQnZMT08wVC8yUVQ4TnlV?=
 =?utf-8?B?WjR4QytlbjM3dnhwTEhTK1NCT3FFaitGYjdpWUVsT0FIM05pbWZPdThLUDZr?=
 =?utf-8?B?VGVBbUR3MVM2SVR2dUFzejVDMGhsMFRsbHpQTDNUbG43bkJiWVVLRDlIRjY4?=
 =?utf-8?B?N2hnZ0xwamJMME45eTVPdGxOem5PZGFpVGVoU21MNDc5dUdwZUpWNUxNQ0Fy?=
 =?utf-8?B?dHRTNFdTRzBuMVB3QXZqSWZCZFdsQ2lUN09mbytQcnF2anRQd0dkV0dSVHl0?=
 =?utf-8?B?MktFVEtxeGNZcTluVDh6Y1FwYkp4Y1lsd2ZibGRIMEp2dXl1WlNUNDlGbUx1?=
 =?utf-8?B?N2s2c1F1ekpJTmxyamRDWndVYTd6WTVkMkQ2K2dtTGhjSWh2KzNzQm1PcTBZ?=
 =?utf-8?B?WHkveHBTZ3drMmxQcVNLUHdxOTZjd0g1YkxNaXZVUnZyTjhHTDVzVkZ6cEZP?=
 =?utf-8?B?OUZtQkNnVUwrM29OL1BuSTNYRHpFM3BuZHNpalF5SnVsajBqVFVpRFdIaWth?=
 =?utf-8?B?b3huc3JUUzdzbXI5M1BXNmVkN2RCNDFkUlBIZjRXWmJqNno3VytQcy9YRDcw?=
 =?utf-8?B?bjhPZWlwbUpkRDhDNWNrMTNLZkd2Y0lvMWFyWVVIR2l3cm85TCthUmZTU3Zu?=
 =?utf-8?B?VmVhVC9jbDRDVHNFTDZvUTVkS25ManRuSjBsQmN6YWJUWm1jenJDV3RaS3ZL?=
 =?utf-8?B?aEJiUHUyempmMEVvRzMwNjZBZlJhSDV4VkRQK2lDZFlKMnhIa3NkeWo2UkZ0?=
 =?utf-8?B?V0JUNGF4V0pIeUNneHViUmVRRHVPelgzbldBTzFoZE85QVlCZmdCczJaVUVK?=
 =?utf-8?B?UEk4aFpUUFhWVzdwTTVLenowS3Q5TDZVQy9lZVVBeW5iNGFGaDNnSDA2VE9m?=
 =?utf-8?B?SjB2Y0Q3R3RlOFJ1RkpRSFVFVG9nVjAxQzIzNDd4U2NJc1pybG9LY1dYTzRR?=
 =?utf-8?B?UE5TdmZUQWFZVzBzcjNuZjZmVk95dytpaDJWUm5aZzZoTmZ4SkFxTlFuMXZ0?=
 =?utf-8?B?Q2NZUnlZemxMN1FLYWtDSk4vaGs2REpkVFFLTEJhcUZFbkVGV3gzcFhhSStF?=
 =?utf-8?B?ZXEzWUloVyttNGtjVnVxNyszVzFGaWxUcFFrVTdXQjU1ZytuTDFGZTFTVDVB?=
 =?utf-8?B?VGYydDdPZ3JZd05WcllaNFNjTFZYeWN2VnVValpvc1BFVllGTEN0K0lraGor?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c0ee72-370b-4be2-3775-08dd7cf8ad55
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 15:09:26.0385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pa1y0yXybnF1WlNbP3F3Ieovtz65Z1RYDavIFYIwuwU8+LIr/BFzxv/FNkG/BCJIESPz8F/3EXeZnEGgVNt5YZuLsqmYrpIQxpjtS+U2nS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963
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

Hi Mattijs,

On 4/16/25 5:06 PM, Mattijs Korpershoek wrote:
> On mer., avril 16, 2025 at 16:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
>> Hi Mattijs,
>>
>> On 4/16/25 4:21 PM, Mattijs Korpershoek wrote:
>>> Hi Quentin,
>>>
>>> Thank you for the review.
>>>
>>> On mer., avril 16, 2025 at 14:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>
>>>> Hi Mattijs,
>>>>
>>>> On 4/16/25 2:36 PM, Mattijs Korpershoek wrote:
>>>>> Recent Ubuntu versions (24.04+) disallow pip by default when
>>>>> installing packages. The recommended approach is to use a virtual
>>>>> environment (venv) instead.
>>>>> Because of this, "make pip" is failing on such versions.
>>>>>
>>>>> To prepare CI container migration to Ubuntu 24.04, use a venv in the
>>>>> make_pip script.
>>>>>
>>>>> Note: This has been reported on [1]
>>>>>
>>>>> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>>>>>
>>>>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>>>> ---
>>>>> This has been tested in docker on ubuntu:24.04 after running:
>>>>> $ apt install python3 python3-venv
>>>>>
>>>>> with:
>>>>> $ ./scripts/make_pip.sh u_boot_pylib "-n"
>>>>>
>>>>> And shows:
>>>>> Successfully built u_boot_pylib-0.0.6.tar.gz and u_boot_pylib-0.0.6-py3-none-any.whl
>>>>>
>>>>> Also tested with "$ make pip".
>>>>> ---
>>>>> Changes in v2:
>>>>> - Use venv instead of virtualenv (Tom)
>>>>> - Link to v1: https://lore.kernel.org/r/20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org
>>>>> ---
>>>>>     scripts/make_pip.sh | 6 ++++++
>>>>>     1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
>>>>> index d2639ffd6e43..33ad51ada703 100755
>>>>> --- a/scripts/make_pip.sh
>>>>> +++ b/scripts/make_pip.sh
>>>>> @@ -106,6 +106,10 @@ fi
>>>>>     mkdir ${dir}/tests
>>>>>     cd ${dir}
>>>>>     
>>>>> +# Use virtual environment
>>>>> +python3 -m venv .venv
>>>>
>>>> Do we want to make sure there are no leftovers from previous runs? If
>>>> so, maybe add --clear here?
>>>
>>> I've thought about this, and looking at the script itself it already
>>> suffers from those issues. For example, the $dir created with mktemp is
>>> also not removed.
>>>
>>>>
>>>>> +source .venv/bin/activate
>>>>> +
>>>>>     # Make sure the tools are up to date
>>>>>     python3 -m pip install --upgrade build
>>>>>     python3 -m pip install --upgrade twine
>>>>> @@ -122,6 +126,8 @@ if [ -n "${upload}" ]; then
>>>>>     	echo "Completed upload of ${tool}"
>>>>>     fi
>>>>>     
>>>>> +# Finish using virtual environment
>>>>> +deactivate
>>>>
>>>> Maybe you want this in a trap so that if we exit early (which may happen
>>>> due to the script doing `set -e`), we're out of the venv?
>>>>
>>>> And I tested otherwise, with:
>>>>
>>>> #!/usr/bin/env bash
>>>> python3 -m venv .venv
>>>> source .venv/bin/activate
>>>>
>>>> and it seems that once I exit the script it's deactivated anyways?
>>>
>>> Ah, interesting to know. I just added it to have a "symetric cleanup".
>>>
>>
>> Yup, absolutely makes sense.
>>
>>>>
>>>> So, I guess no need for the trap or the deactivate, but we can play it
>>>> safe and still have it :)
>>>
>>> I think using a trap makes sense, but this should also be done for the
>>> ${dir} directory.
>>>
>>
>> Indeed.
>>
>>> I'd also argue that this would more be the candidate for another patch
>>> than to be part of this one.
>>>
>>
>> Fair enough. I believe the --clear addition to python3 -m venv .venv
>> would still make sense though? What do you think?
> 
> Hmm I'm a bit mixed about that one:
> - .venv will be in a folder created via "mktemp -d"
> - this folder will be different each time we run the script
> 

I clearly have missed this was running from an "mktemp -d"'ed directory. 
So it's useless indeed :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
