Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA64106ACC8
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 16:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766988426E;
	Thu, 12 Mar 2026 17:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NiD/X7au";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528C98426E; Thu, 12 Mar 2026 17:11:33 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FF08423C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 17:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwn2111udpEfvXy70J1RNkRGAFPuM4SeWbzQc9cAO5DZnc93i/k6ph+tD1DoyVOBAJugq/rV84oKewfESXIEAK9MNLnIuhAIxtSEn524f0b4bHYv+evZkl3NRIM69NKitc+FyzdJ5ocF9NkS3s/Y+YO8FEPNu2B3l83DIRSSo3AfS8swq8CzHRiUGIGlvXl38UdEFmQOoL05lOmMRifUSCUsxmj1rTtNSaSvXKZze7J/Q1f/tuHZOb7K7lxGQm9rKk/EYO1fXchKQ8fDq1Fty957xUq01UrO3jKn2vRVnnFBGzQvgGku5npf3XJ5kecLsRZdrYGo1E22+l/joVRf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/um0STQjkUfoOnEBYs2DaF8Rahxy/9Vrsqf+a7hTOeI=;
 b=GkYT2HT3g2/XMBiZH/2CGBA4K4qfecizhFkB4KEjVZNAa8q4q6V+gzFJ9AJIvyDL2euQ6qpVajf8PrZWKBUdCon1Re/pH7Kgth6O/XgL0fLc59hDxYQfnTkf3pjDqUyNb7y1C7/FF9Mytu++Fv6+hUmssuvlOjsl3TvqlwbE3jiXAwtBu6Od/RCR30IbMR58CKQjn6a7trYDmesEHsgaKO9R6+qdizSZXAwZ8groMmJQUjqyAqf8sMhM8UMyfK+9tSOl1WKIFWcWhXKVTIzFDpjODdNe4pIwJFOjE8ggPJwNRpSoSs8sGAiFPS1IZQRaNYUmobjTx/ZVO1vsGgnbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/um0STQjkUfoOnEBYs2DaF8Rahxy/9Vrsqf+a7hTOeI=;
 b=NiD/X7au8QU5XIG5Qcyuhr1NS2J2+9uyS8nK7sDMXRkG/kmazq40bw9oG90kzIgHutYA3EfIBApnK1lBTnNcskX8tuquwhnY9iZZ/4ybYeV7vJ10KwN6MmsRRuau4sMSUh2tuYjyNVUbNmRpJsrFzxWeC2evOqGATELVh6qUvMOLOgzob/P2o9mSsyOhMwRpZAETvIKwMn/kLwNG1s/oLtwmdcybbN8/Rlea3KVnoFIma+MaIeFJOQo2cG/jVDPwsEtJuN2PcoDTabn0MFRnsfkNy+Y0wqw2zrpQAJxOdfxHUWOHFkLOaEC0PP2IY6nSegFa3W4wGz7UKG8tn39ppg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11278.eurprd08.prod.outlook.com (2603:10a6:150:2f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:11:24 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 16:11:24 +0000
Message-ID: <f2780969-05e4-41b6-abd1-1e09aea706dc@iopsys.eu>
Date: Thu, 12 Mar 2026 19:11:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] net: pcs-airoha: unify code using SCU regmap
 helper
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: nd@arm.com
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
 <20260211182230.968921-10-mikhail.kshevetskiy@iopsys.eu>
 <49412867-f5cc-4f80-bd41-3cf0f027479a@arm.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <49412867-f5cc-4f80-bd41-3cf0f027479a@arm.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11278:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a7459e-87ff-4fa6-fe68-08de805201bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: hwaaZ1jVV2yYUHYu3Wr2Wd7rYYv6qBq60aDdOfgHY36lhKeQKt8PfBIvNtFRf3bzUravSGmf/GIRpUK2dTTf57kWOrf8DU8CKPp8r+7g06dHc+Kbj1KVCbhB+2+ASuwnf/vGXI8KGWpvBFsdPkVh7Lwwmm723tb9jCY6y6ZLmzX0uNvwBbBliqXPugVljF0AwlwCXjg04ItIPnzNAi6iXPsBBV62bkX5UL1s4LoViS34iSLycgB9it6YXgN7wxCjY3RbqhE8QKLpV6zssS6vrsTS2KrPdTy+xuwp/586AnU6LlfiJbk3mD53Ij/7wuXcrqd/0OZ+B/+5Xal52dZpDBxtKl1x2n+DyZnU6zBsbPeIqNdZuuTZfC8Sa1c28hm01XcPp0Xpb7isyNPgyQ8FITul2AC5usU0Wb4+LuKJ69hTCCwOZ/lKTfcCNVbswZsFdAVXlpPW6R7038YTUBAiwKAPTwhcLVklBcd+PD1HDMoG51D3ZzRX8nJUShV1z1JbxqH8QHdz9L4SoNDJcLc6AnBQXIux2tLn1IoL+VzEJgMzzK/TxdIqvN6hZh3dSjNootdtyHQkxpRhkN8FlujRYbLfEQP74eBagHi4+lRNS3LDhMuMg1svAQPYAFhl5OIOzigadJtYU0jRA1Mg39IG/xJMsOrFjy7K4Uj3+B7saBdHdPOdeNeSjjx3rVQtN5QQr/1jU91HaEwiSMsWOlT9z6gvLR+7mTqXe3Tb9KyEOoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTYxZjAvTTZIMWVjQmo3Y29ZSmZ6OHFkL0Z1Ym42SUxuQ3ptSU01L0NiZkpL?=
 =?utf-8?B?NjdxTCtybnNJa1FSbURZNzBMREJWcjZ4T0QyNjViWWdqaDJyejl2dkZ6L0N5?=
 =?utf-8?B?SzYrYVRzZEx6Z2ZJdW1hREErbDhnZTJPc3hMamhBMFVRamZYNWx6Qm55cmxP?=
 =?utf-8?B?NzFmUkV5NGs5b09SYXQ4N1U3WGZKREV0RVBRMHBOZE82YUJsMkt4VHZaTGNk?=
 =?utf-8?B?OWRLMUNHVDAxVktLZTRvVk9KV0tnTUZMdndZbDQyVkJDdFBXSDNWR1A3MCsy?=
 =?utf-8?B?M2tyanNqT254SGF3VE9oTTlLZmdzVS9ybGtQQ0pBRzIvT0tzSTV5OGJmRUlj?=
 =?utf-8?B?TFRCaTlITGhNQzlETFFISE5hNHdKdTU2bHV0Z1AwV21pTmRscFFqQkIyL015?=
 =?utf-8?B?QUwzVUIrMEkrK3M2dHc1cUhKRk5yMUt4WVNybXpzNklRaWxQeDhrMFVzdUxM?=
 =?utf-8?B?K1l5RWJoWWxTc1I3RE5TQkEzenJjMy9ZZlB2dW4yM3VFSTJ0TkE3Tk9xU3cy?=
 =?utf-8?B?SHFKK0N3WVBLYXYza3dmYXkvSHdFMVo4YzBQZlRGLzQrZjREcnJiTHJCTThr?=
 =?utf-8?B?NGtCSlBSZEl4Ly9JbWswQ1JpVSt6bXFXUzUwYTFSWVdlTjlwWStyOW1qaEtW?=
 =?utf-8?B?bmVZbkFvM3lNQTFsNk5laHBvWjJVVDNBaWZXUmMrbHFHRVR1L1ptNFNDOThT?=
 =?utf-8?B?NTRWRTllR1ZUaFpMSERQd2t0a0VjcFFHRkVRejJMemcwWThmMjl0aW44NkVC?=
 =?utf-8?B?aEE1T0ZIcE92aXNIdm9Lb2MrQ1BKRmw4RVA4LzF3VXlNV1p6My9yY2dIMTUz?=
 =?utf-8?B?bTN1ZzVFaVVDRTdmRkJkL1VMN0U2blczZmFiaDl6ZmYrai9wbXdQM2c4TVpD?=
 =?utf-8?B?aDRUT2oxQXdxL1l2dkJVRnBmNnJVUWZTL3dod1ZQMDlhZVdHLzVRQWFaMS94?=
 =?utf-8?B?VXh0VFF0K3VQM2FyTW5xRXRRUU1reEVmMkFRamQ2SmpXUEthWmE5V1Jsc3Fy?=
 =?utf-8?B?QiswTi90aDAzS2NOOXNtYjF3a0RXOFNQSUZkYnNXT3NKbFNCVjNOSE4rREVZ?=
 =?utf-8?B?YWFWKzNSSUpNTzhhWS94SE9HWVk0a0FhaWp6NGdRRnl6UHBpcUhzVVNQa2pi?=
 =?utf-8?B?VlI1M0UvMGszZStjenZoMzZIcFQ5cXNOS1Bad1ZOSnZyUmZ5WDNDalM2RTB6?=
 =?utf-8?B?ZGxyZ0dLVk1vcEZYam1SNCtyTVUwNC95MmNGRzdZRm53dVNXVHR3SDhvTmhS?=
 =?utf-8?B?VjdXd2phMTdIS252aHBkQlNET0ZHZjV6WFpiNzhheGU1eXVwaHlqZVpJVmxj?=
 =?utf-8?B?SVBmVDIxQU4waWFVQVkzYzhpcjhYOStQNk5SSnNiOVBxL0hyQUNQYVZtbGcx?=
 =?utf-8?B?ZVZ2ODByL2lDY2wyV3NRTkV2a1hWbkVZZnJvZTdoSXRIQ0tOcC9zdEw5Tm5s?=
 =?utf-8?B?VWVrYU5vdDcrQ2hNdzE2UUdPWGdvWkM1Y2hyUEY5NjV4aGFjN3NoREdFTXJy?=
 =?utf-8?B?NS9qMFpFNWxwSDEwRDBZMllSN1h6UVkvTkVFQW9sOXFVemR3R3VPdHdTMjVW?=
 =?utf-8?B?a21vSTRVYTNuRUdheU1BRGxQUHlOV2czNDVmMmZYZktFZ29Ec210S3Z0Tmhy?=
 =?utf-8?B?bWg3WmFIbW54LzJYM2Q2ZHBoanJlUFNDa05KZHUzZE5MWlZ5Nncva3Ivamlq?=
 =?utf-8?B?Rk1qcTlsQzZ6djg5MTJRREROeG1SeTJxODFmUk5RUU91NnRHTUFDOWxic3ZI?=
 =?utf-8?B?dHgwT0o0S09JMVZVYnNXNVJITXlDVXBVYnducUFaZTZtdHg0YkdyeFVHR053?=
 =?utf-8?B?ZjVtTVNWMTk0RXNpTC8xa3FLa0RMQjN6Y0ROM1R4UW9rZVN0ejZzNmNnZG1r?=
 =?utf-8?B?TkpQY0hybjJyS1EyWGN3bkxIVEJLU1YxVEo5dEYxYW1XK1ZHYXl6Tk80bGZY?=
 =?utf-8?B?anZCRGZHOG5idWo2czc2V281OGFxeUo3RWFLQ1o5Y1J0NXNqZzBNS05EdUFF?=
 =?utf-8?B?MnNtZjI1NWRCY3NvcWV2SDVTaEJpc28yempMRkRNNkZmVjIxbW9Vck5wTUda?=
 =?utf-8?B?ZmdCdHdmNWRndERTVXVtOERabHBDTFdpR3RTek9jcXU3VDBxaTlEYk5CNUo5?=
 =?utf-8?B?RUgrV0h2U01UMTRLbUpUaXJEblhrYlhDUE5CdzRSY3JpS3ZLMnFhcmR5SGpa?=
 =?utf-8?B?eFJkUGc0MlZIL2huV0ljQUNSc1ljK25qN05Db1lUWlpzajZFRStJaVYwZVZh?=
 =?utf-8?B?bWE1SFlhNFk0Z2VHU2JzNG0xQ3R4VHgrdTFYaTQ4YXhNelJjQjgwLzdTMEkr?=
 =?utf-8?B?LzlRbnBsR3ZMUU5RTXVXampSNVBzS0VZdmlZR0tQdmp4Y0FxcVpCdVVIVEhS?=
 =?utf-8?Q?hWn3gI0G5HXrH0Mk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a7459e-87ff-4fa6-fe68-08de805201bf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:11:24.0283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uykwy1UkJo+jSThJ9KoGXM6v2Jf8QxCHGXteNmzNZ64+SqCJesO7Xl/L4VnIFe1DIYWnrK9K9A8ya0yB2ctjniJvXFB7KPjIZyaILt5Crig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11278
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

Hi Jerome,

This is quite significant patch. If it possible, could you delay pushing
of all the series a bit.
I'll look on this patch (and maybe update a little other) tomorrow and
sent an update.

On 3/12/26 19:05, Jerome Forissier wrote:
> Hi Mikhail,
>
> On 11/02/2026 19:22, Mikhail Kshevetskiy wrote:
>> Use common code to get CHIP_SCU registers instead of driver one.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/net/airoha/pcs-airoha-common.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> FYI, I had to left this patch out of my pull request to Tom [1] due to
> a CI error [2]. The root cause is not obvious to me, and since it is
> just some code cleanup I decided to take all the other patches and defer
> that one.
>
> [1] https://lore.kernel.org/u-boot/91fa5175-5eb1-4991-9467-fc3fe4f52105@arm.com/T/#u
> [2] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1396757#L1193
>
>
> Thanks,
