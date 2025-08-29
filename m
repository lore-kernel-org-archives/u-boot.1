Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C458CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 16:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1AEC83675;
	Fri, 29 Aug 2025 18:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OnYnMWPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF8D836D3; Fri, 29 Aug 2025 18:00:44 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C16AF8366F
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 18:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxB/DwoS8R1U/AQ4QsVEM5Mt1XcxRu8WXsfv0wXBSXWWI+PE9zSeLVkq6pNpBqQxBkMzfcy+lUXBwO2V/rSfJHKC/84+wjEZ92HR5kAJjIjYHAkBsbT4SvSBPgu7ubJDAFEO1Gt4KiAlnS1rHI57YaIVfhWX2AZQ5pzKH6OUaJxasqqDPshmzazBB9uzfWxDPuBhamVOtFcN+4L4WqTgU/8Suxu4LvCxTvh5ildDuzoNvX6EbPPRWtzqw8D4qIQ1exoKRh1EjjXEfvmTAPaOdWCL0M1tgrtXlrGW6V+uzICeMBmXCEZ7dhnwFLiX4Uhcc5SfFK0e7ho7VBH7aZdhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gll/helAu1DxU2EjaGvqplyv2LdnCpth96kT7zz+UpQ=;
 b=pHPKUHQM2E6Pv4+anXPiyKmIC6ZP0wWg3TSSXlPta7gSHYqMSR0J55wRskObNHz/ByzFWnj2eDeABJB/81pYzkpwUTenyJs4AfZPpKnNW9Zs5iwSl+9ayHl30y/i63KrRm65AMciGExtJznB6GPhNf9ZwWa3d6Xyp4Nrz8Q/8mkAe2yTRwNwD6CuV9pKjq33NIoWv4omBJhaCXIHmKAsSZ/kS7Dj/8TmYuoUhEMuZqc8Zn2kROmN1l2dODSXtJDnVD0crZuZWQ3p14A3qkOYHwkICyeQd+GqWZEaXzDAyrJoalgz3IILJaZ6R0oLDN7FdkDRJsCN9HhL3Jr9ScKsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gll/helAu1DxU2EjaGvqplyv2LdnCpth96kT7zz+UpQ=;
 b=OnYnMWPnT86cwhck3/39EdmROWsOcIJhOmJUuPxIXvF63bT04tq4BjQMFJIKwztP8LwceEPvNJ9OhG28Cm9FgLT2bsZBaDDwmgtTRjrFIc7QZRPdc/GvZYoVuU+JVyDrcV18626G2ssN7SVKUrpkL3YUe3iqxU8DGayvcaq2WBBW3eycmAnF0uViGTwwVRdIlwGWvz+diVT0lUdhA7+IjiNNIbuNFXOsAksAWBpzNbinN9UrpKs9RgEVEukUJ6BOmHCRhTl2SBZpSTmyy3M8ApqnqblDRA0GPqrEn14Q39e8ysrGc7oWab3HoTA6FI3nLicOKa1r7OQe/oUJjwSyIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH7PR03MB7105.namprd03.prod.outlook.com (2603:10b6:510:2b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 29 Aug
 2025 16:00:31 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Fri, 29 Aug 2025
 16:00:30 +0000
Message-ID: <96e25f49-eedf-4b39-aba0-36178aa567b5@altera.com>
Date: Fri, 29 Aug 2025 21:30:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source
 selection
To: Tom Rini <trini@konsulko.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>
Cc: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
References: <20250828135152.8680-1-nareshkumar.ravulapalli@altera.com>
 <CY1PR03MB8121C31811D7EA295EE697C2A73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
 <20250829142640.GU124814@bill-the-cat>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250829142640.GU124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0112.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::7) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH7PR03MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a542022-a5a8-413b-e910-08dde7152da9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1NMbEtLRk05c3U4OE56RmpjQjk3Z3h3ekRxRzlsZFloTVF0amZwcG5pZ1NE?=
 =?utf-8?B?cWpTN05NVXcvcmVHQlN3blR1Y0g3cTNOZWNsSGcwUWI4bWduK1BPY2t1cGhk?=
 =?utf-8?B?UGZsU3FCL001UGk2NXdIdVZqSngxZkY5RVRnVnJoYVZyV1daMnlyQ2VVelF2?=
 =?utf-8?B?NnJFVXczdCswbHpQYW1ONEQ5SUE2MGdaS05UWVZ2NjVwdHZXdE5uS0dJNzha?=
 =?utf-8?B?VDBwSlVuQVN4aEVMd0pNdlNXU2VreElES2pHNHhvaWdKUlE5N1BtdWdhM0V3?=
 =?utf-8?B?TWdoY1hUc1p4SnhKK3dXNFQrT296d1lvQ042VnpJQnNYTy81c0Nad09qRVQ5?=
 =?utf-8?B?VnY4RnZrN3JJcDFIYkxabXgyZGhTRVFYZGgrRCs0OHJpQVVtdEdaN0xFeVZC?=
 =?utf-8?B?Vk5Yck9nYzM3cElrVGIzV1ZseHY1QVpVUXVySFJIZW1IZlliR0RQNjdkaktz?=
 =?utf-8?B?c0kvY0llWWRuRVZWTmRZV2ZURVYxQ2RVa0d0QkphQlRmMkl1eUZPaERzTEdB?=
 =?utf-8?B?SW9nQVZEa2xtYWtMSmt4b0FObkpxN0wzZjN4dWlQeTJrQTR1WTdvejlFdlBR?=
 =?utf-8?B?bXFkTlU2Z08zUTBLbHJqeis4NG16Q05mdGxqZnRmRUdySmR4SVN2VnRNR0VL?=
 =?utf-8?B?OVQ5czlnbkZvU3RsNmVzZ0s3M1FFVUt0c1c2WlRYR0U0RktFdERaWHFsa3dq?=
 =?utf-8?B?QUQ0YXFQcTNXVjJhbzFNQnBuajZSZG9jR1lSUlhJSTFYWVMxUlpxdG1qZ2Nr?=
 =?utf-8?B?bXlBYWRiQXRHVlNicndwUE95aVgxTjRheUFaMXlzWmlhMzRIOURua3BhL1pm?=
 =?utf-8?B?ZDF1MDlJUDlldWFhc0ZGMTEwd1J1Ym11S2RwZVMzT3RZV2ZER25kSTZCMjgz?=
 =?utf-8?B?N2RsNi9Ralg4WlFmeGY4bGhic2NXSFYrQ00yM2szVHhNSTg2dEFkS1dRaFRV?=
 =?utf-8?B?V0c5R2FPZlVRbEs4KzRjZEhMUWZFVWpEUmpQM0VwL1NiYjVIQVhBZmw3MU5Z?=
 =?utf-8?B?Ui9XQURaSzhCVWtXcFV2QVpndmI1R0ZsdG84WFdpSzZZOEl0VTRIR1dHQlcv?=
 =?utf-8?B?SzU5WXFHbm1uNHFLa1E3Tlh4R3pxNEFPWFJUTDlmRElCai9Qb2wwSy9XL0Vi?=
 =?utf-8?B?Yy9Id2dPR2M1bkxiV3NCSDlDWG0rcjdpNDA5enFDbzNKdnBuOXVLV1NRdVVU?=
 =?utf-8?B?ZlpNUUVZY2hKZVpFKzFRNzZnckxTWEhZUERxZnpLakJRYjMrOU4wUWxTaFJB?=
 =?utf-8?B?U0M3ZDRCWXF1YzVwNldFUkdkTlY1M2RsS1Y0Qzl1cjU5ZUoyeEdEUDR5VitP?=
 =?utf-8?B?ayt3YXorOWtXT1JHcFFqNDdpcURTQTdSZTFvNGV1QmROdUE0R2t2V0luNDZn?=
 =?utf-8?B?ZmF5YXJEd0pDcy8wUkNCbnVyRDhTWFBORnoyL2c0MGpaazdBRVU0T01tdTg5?=
 =?utf-8?B?YXcyRFBzMVdtdlMzdGUzQmQwTWs3RnlEYVJITklKL0Fncjlkb2NGZmJhRzdG?=
 =?utf-8?B?V0ZDaEc3OEthR1MyR2U5VDNaRTgrWkVGUDAxdDBLTW1CMkNiV3lxU0ljV0Vw?=
 =?utf-8?B?SEhueFJsemRvdVBpT0hhTnNoTXRBd2FwejNYU2hVSmh4QUJnaVpnVXZXa2hV?=
 =?utf-8?B?UTg5b0QvTDBtTCtiM0pmdW11UVNiWllUMmkyWU5GSlJKN0xpQVNpMHc4dld2?=
 =?utf-8?B?YUxVM08wS0tXYjJuMkM5Zkx3QitBWXBSMUo3SkdCcThLeklxRzh0MFF1a3dk?=
 =?utf-8?B?MjJsM3pkUWlMMkxISlF6U0ZVK210SUZBb05QS3FqNStWWWxRQXJ6R2E2eTZZ?=
 =?utf-8?Q?nrsHQiyR0W84bWSVzlf1tCYJF7a0oAKDiTu8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxORzZsZ0VWbHhxT21rVGZvYUZVa3NTN050SVFwREtpcWxodlR3c1lIMit3?=
 =?utf-8?B?OTBTN0QvSXNublRUbXcvZitBcnJxNG9nbzZIYUJKelBybk84WWQ4R0RaVEV3?=
 =?utf-8?B?SHBOWFUwMUZVUzlTaFNXWXBXVXFkOEZkT1c3RlIzS0FPbm9yL1pKZkVDeTNN?=
 =?utf-8?B?L0gzWEdXQzFmb2JXY1hUekRrTEoweS9zT2JJNDdzVWFjMWdMVFlEYzhSREpk?=
 =?utf-8?B?YXNxdDNZbU40RU5FSmVEOVE1TlRCOUIxZzZaRHFxOEx6VVpRMjhKeDNRay9H?=
 =?utf-8?B?V2tnT2xJdEo4a2dsZVJidCtqcllxUmJoT1NiMEFVNjVtWXVhS2c2bEhmd3ZW?=
 =?utf-8?B?dG5lV2oyVTZVNnM5RndaNk9yc2VpbXk4bDZTRmpDUXBCVDBuc0YxQWdSR2kr?=
 =?utf-8?B?REF0bmpQTGs5elRQcHVaeUR4ejZRc0x5eWQyZG9HNnBJRCtpZHpmSnZyM3F3?=
 =?utf-8?B?U21OeUpnbkVvbDZSZ3dMMlJqQzgyOHZXNWt5d0VpbHFqa21YT1Vwc2FkR1ZQ?=
 =?utf-8?B?ankyTmk0ZHRmcXJYWWFDcWQ1YlljNnp6a3VGSFU0TGVncjk3WnZLZ0UycXNB?=
 =?utf-8?B?THl2aW9sS2g5Y0xjYng4MGYzVnRXbVByWVRuZGU3SlJweDd6UytxTGNEcFll?=
 =?utf-8?B?OTlUTUJVL0liMXVHRmhqZU8vWmdXN1Ftc1ljRmNiNFJnbWw2RU53Z05OOTNv?=
 =?utf-8?B?eVZBdHhTeU8rcS94c2grMERVc3dxL0E4V09RSk1YNEsrNFFMdGdzMFNjQ3hE?=
 =?utf-8?B?Y1VTYWg5TkFqSXY4SEVyMjR3UFpqQWpjelFrY2kzNkFtbjZkSGd5aDc4bGpM?=
 =?utf-8?B?RkJUdTRVY0hLWlIxUTNIbkJ3TkdENy81MHhiSHhSZElLR2Y5MTZrWis0SFBQ?=
 =?utf-8?B?MHRtenN0Uk52UDdaM1djZzB3bmFHV2dPOWtWYVBkOTRtR043T2dUOVRFOXVm?=
 =?utf-8?B?aDZLSGdYYU9GZUl3bWVYcllDR0I2VHloZzErckJ5UlNnNVNwanVCbTdQZVVM?=
 =?utf-8?B?Z210NFhrQ2hIS3pWcy9zaHBOQUdXbTBudzR5N0JRY0ZyMkRqdU0xZ21lT3B6?=
 =?utf-8?B?Q2U5Z3NMelhIaUdZdzcvYTNOVUxRYXVQbXhJWkNPbWw4MDhFMjNFdiswVjF2?=
 =?utf-8?B?ZWZmYlVsS2RkK3hEZ0NUaTg4cWIwZmRpaGVUZFR4bk1icE9seHczaFo0cTNP?=
 =?utf-8?B?L2hQQ3N0QUFnbmFNeGlWczNJTUh3dlVtN0hUSDI4ZW51bVhLb1VTR0M2RTY4?=
 =?utf-8?B?ZkpQVjRITlNJRVhXajJCTjRiQ1daUHZ0S1UrK3d1Z21tVWVqNlg0d1lTUnVa?=
 =?utf-8?B?cWxWa0gycnlLcEtmQVFPOGJVMkw0L0FHUDJSLzhQQkVGajZ1SHJuVGJrM1VE?=
 =?utf-8?B?TnpVZCtYTW0xNTlaN0kxbmNZN2F2VjIybXVudzQrMFNId01ETlg5Wi9zMHQ2?=
 =?utf-8?B?YkxpSkFWdUJXMGxzd2hhdTB3Rk00ZkFKeTkvYUpQYVpMRU1lc2x4aS82ZFVW?=
 =?utf-8?B?bXF4TUM2QzZHMWFhck8rUDZGQlZING9rM1dVZnA5TnNEMGV4am5zQ3g3bG03?=
 =?utf-8?B?aUswcitLRVhUL1VuVEhUK0ZxcTJBVkpJVXVqbzFJWGcvMXU4RURleVdDcDZk?=
 =?utf-8?B?ZDBTZ2pHRlJoWDlxdHhwVWFOSEpuaFAzd2ppM2ViSC8xMU54bXRWN2dYV1g2?=
 =?utf-8?B?KzdIeDFJUm1TdmYrUlgzd2dnQVpxYXlxbFpTdURZY2wybGJMaFV2OHhWUkhF?=
 =?utf-8?B?TFdiUytHVEJjQTRMajgrNDBVaHdvdXNSZTd2WFlOMS9qZGtjc09HYkZlQ1ln?=
 =?utf-8?B?QXlISW9Mdk45cEZTS1Q5czd6TXJ3b1U0aFB3UktSQmRnYnlnZi9IUExpSnRu?=
 =?utf-8?B?WkRUWnVGaEJkbHh0ZlJIbVRwN2tjQ3B5L1RXdUZKSVlYcTh5Z0RWeDA2RGFM?=
 =?utf-8?B?alRTQkNBT0pxWllUZ01COWFoVng3SzhNMjg0NUNoZHI4U3hyWVNaN25lTFA4?=
 =?utf-8?B?UXNhSnZ0YVF5dEVWaDVianY1MVI2ZUtSRVBRQUpUTGZMOFpzemdOWnE4aGk2?=
 =?utf-8?B?clhjbE1jZ2dpc0xzcEk1SDRCc0xhbGZDM2R3OWZKTGF4Z0xiYkVsVjZTZTkr?=
 =?utf-8?B?b0gva1NtRS9HWkQ0VTJWMitaS0hpUE5xcmh3R2R6WmVaaGk2MHJUUk9YSEQy?=
 =?utf-8?Q?ABrN/aFftKoSh/nzh+UI0Vs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a542022-a5a8-413b-e910-08dde7152da9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 16:00:30.7931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cLscDwn8TEig3GGQ5lZq8fK9IpDGYFB98updOSGGRZjn13OMUIWsG90Jt4LA30++sLAgLwQqBpvxQ7MS329Y1u9SEJdsoHumZ9rpkDIEisugpwGJCxYA7tbjFr3NVlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7105
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

Hi Tom

On 29-Aug-25 7:56 PM, Tom Rini wrote:
> On Fri, Aug 29, 2025 at 04:58:07AM +0000, Chee, Tien Fong wrote:
>>
>>> -----Original Message-----
>>> From: Ravulapalli, Naresh Kumar<naresh.kumar.ravulapalli@altera.com>
>>> Sent: Thursday, August 28, 2025 9:52 PM
>>> To:u-boot@lists.denx.de
>>> Cc: Marek Vasut<marek.vasut@mailbox.org>; Simon Goldschmidt
>>> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
>>> <tien.fong.chee@altera.com>; Tom Rini<trini@konsulko.com>; Ravulapalli,
>>> Naresh Kumar<naresh.kumar.ravulapalli@altera.com>
>>> Subject: [PATCH v2] drivers: clk: agilex: Correct EMAC clock source selection
>>>
>>> Fix the incorrect bit masking and bit shift used to compute EMAC control
>>> which in turn is used to select EMAC clock from EMAC source A or B.
>>>
>>> Signed-off-by: Naresh Kumar Ravulapalli
>>> <nareshkumar.ravulapalli@altera.com>
>>> ---
>>>   drivers/clk/altera/clk-agilex.c | 13 ++++++-------
>>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
>>> index e1ddd02f356..2ad8cfd8856 100644
>>> --- a/drivers/clk/altera/clk-agilex.c
>>> +++ b/drivers/clk/altera/clk-agilex.c
>>> @@ -1,6 +1,7 @@
>>> -// SPDX-License-Identifier: GPL-2.0
>>> +// SPDX-License-Identifier: GPL-2.0+
>>>   /*
>>>    * Copyright (C) 2019 Intel Corporation <www.intel.com>
>>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>>>    */
>>>
>>>   #include <log.h>
> This is a NAK here. You can't just change the license, especially
> without calling it out in the commit message. And I'm not pleased with
> "make a small change, add/extend copyright". I'm not going to run around
> NAK'ing everything else you've sent but I'm going to ask you to stop
> doing that for changes that are not significant in size or scope.

Patch is about an important bug fix but I agree with your thoughts on 
license extension. I will revert the changes.

Kind Regards
Naresh

