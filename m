Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E87D37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F0A8063E;
	Wed, 14 Jan 2026 16:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YeDexSqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 030A1835B3; Wed, 14 Jan 2026 16:02:04 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59FE80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4boCIwBC97XKMijGnvIRZELHg2AIh7SipS4yUtSgTEQVI52nSBczNYicCmfRA3ktOtZrMU1fc0SIJN7G5mBOG3IhMozrdv/u7UWRg5Dgo49+x1f+NTTLVLIeZWOS29Cnl5xzbBXqonhPfyNSrVyQ8LXbwKyFh4SDPO0/KKjFtr6Mr+MndmhM2QuD7HTS1dvLxJ20sAFKiwaq8Spow2va5BL2IcUCsV9albc8oXiX6TuvvwbHlQtNQaUS7kVETlEOwPFHYhri3vRR4rrtcEVIU7lqxPNaEPUMz/mj6+XLIDOYXfxrPUe+08By6uuGftU4FNlroidOb23r4bH7m0y6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oYzYJnMFtevfXI53jiHaSb3SK0BJ94QgdKFS2vHIIE=;
 b=Xp2MgGiLIorr/u21JN3pRNZqEzs3uRl7j7H0xLNhO7W2O4bxFt6xl+274Afn2B78AW6qp7uTMwRzp7bJsArEiqSjm7sE9100Tgue2DG4dWPR4vAXcfdLSc3uPQDXwzPdBtvwWLDNsjuxR5MZrCmZJiSUmdi9KLrNC6er1ASyB/mdo6+8L7vLa5QTRkor4Tru7UZU/XD39c3Nks2EU/ZqM3aiAKfcEjDI0CqVZczLnHUrzHIINudSsYFml8AqGGcdlhMOwG9EB6DHQC7QYsrQ2g9vCyK/ywJNhZE0yd0Z36G7EqIy6JmjUKe3gUpbmrLjGRlqhzMHfQ94TR3Mla19ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oYzYJnMFtevfXI53jiHaSb3SK0BJ94QgdKFS2vHIIE=;
 b=YeDexSqs0ednNicZqBbk2wXmjDi7crq+Qtz19VCgWSkIuvRBTwdJJsLO0EvTMIPN65sVMSx/CIJq+tLj7NHiRtJ1J3JeD710ZBODV8r1Gvjadp1Makdm4RM86WJ6+1iM2KNc/ojl64MYCJI42MdFHg2f0f8qKl8LbllMYYP7otY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by GVXPR04MB10407.eurprd04.prod.outlook.com (2603:10a6:150:1e9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:01:58 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 15:01:58 +0000
Message-ID: <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
Date: Wed, 14 Jan 2026 16:01:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260106203433.3133926-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260106203433.3133926-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::9) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|GVXPR04MB10407:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c3c299-fab8-4b4d-4178-08de537ddd18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEs2SmlnSGRiZ0NsVzdaYXUwRUN4QjByTnNyNXJXV2JaTllCV0xKMGpLNVdD?=
 =?utf-8?B?ZFRCWVpZdVZFR01zQmdIZFNHT2VqeFk0ZjQ0ZTNrVS9WTytCS0huL3JlNHM0?=
 =?utf-8?B?NkhVOTBuenBIaWgrWjIrYXZjZGdXbkZYQ001enFRcHY4dm03M2hiVXF5Rkx2?=
 =?utf-8?B?YU9JaVhUOEU5VElIQW81TDh3N2hIYThObWN5M0ZtbWdjRzZua0xCdDVHcDQ4?=
 =?utf-8?B?R3M3aEEzMElHMGhuSldsWEtNbXZZT0tUSUI2bTc3VnBZa2NodDF3L043OGxD?=
 =?utf-8?B?VDRlR0JuSFQzTjJKSGdjc0hZNVE0eGc1ZWJ6dk90dC9NM0lHaytsOFlxdnFu?=
 =?utf-8?B?Y3Y0dEptYnB2NkROMzFINm1jZlBTWmYxRmp3bEEzei9CK1pLeFkyYkxXZDRC?=
 =?utf-8?B?d1VOSnpXY0RLYjlLSXZDdG50M1h6MUZDSS9ZUlBscXNNRHFzaVN3dUVwV2d2?=
 =?utf-8?B?R1pYcVFsM0FvckxaOG1jcXU5V29qMmc0MlVodStXNW1vS1RxYTN2bHBiVFNU?=
 =?utf-8?B?RnhUSk5oU3o3ZU93Ky9jQldLMjFvVlVwYURuczl3TzFCZ2J1STlpVWtOd0I0?=
 =?utf-8?B?dWhXVHdYT2YvNlNZOEtUaDlacGI1TmcwUWNGV2Q5MmR5dmptb211bDRTTmFY?=
 =?utf-8?B?YnhDR3N2bDRUa0tWOVFMVkJsczhrRmtSc3dOWG10QlNyeXB4ZDRydkNvTzlt?=
 =?utf-8?B?T3NhVDA4ejVCVmlhZCt0ZFllN0szVjczWm5GZHBBRExhUXlqdVFVY2ErZEtO?=
 =?utf-8?B?UzhzeGJvdDZ0Zm9KTVd0T2M0OFZxcnRWa0FFQkJuUEw3UWd4cVRxbkFiaXZQ?=
 =?utf-8?B?SUFDOEZRVWhJT0dGa3dRV2FPbDV0ZDVTZ0sxdEZOZFcrbGhUVEZJTU9MOXE0?=
 =?utf-8?B?T3FHWENXTXcvZ3NmSmRrQzVGbzNMQTh1cmJJdG1iRnN6Z3hBV09xQW1yNFVX?=
 =?utf-8?B?V0E4Qzh4RmFRWFhqUkF1ZE5DbnV6WUF6eVo3Qm1kZWpYYSswYVA2NE1JWVhz?=
 =?utf-8?B?RE5TR0JGbS9Xb09iOENBMFZHWmRaTloxWGNtN2dOYVRjRkVXVXJLSmdjV0V2?=
 =?utf-8?B?Z1E5UnloSW5TTFI5UnlEb1pXSlRkeUJmQVVNWTVOSE5OTnVQSFZWVThWTnU1?=
 =?utf-8?B?QlBpUVJLMUY4S2NmWEg1SnJFdVd5MmZacDdKMG4yRkxYK0ZXWFU3cHdraGc5?=
 =?utf-8?B?NGlPMjJ5ZlVmWnlDdGNWeG1kb1dlajNReUg1bkljTEZhSFdZQWNobmRvWEFG?=
 =?utf-8?B?Z1VaOExoWXhyd1pjOTg5eERYZ0JCR3ZiK2hoODFWbkVVREtsN3RpWG82SHlp?=
 =?utf-8?B?L2F6MzJFa3dDVCtWMEpxY1VTYWVPcCtXVHdjekJMZGRxbzFFYjRKayt3Z251?=
 =?utf-8?B?Y0pndE1QTStqWWt2eTBaMGNQa3d2Tk9HbTNGaVdXSHlVOXNuakROd2g4clFj?=
 =?utf-8?B?QTI5MUk4MmQzUmV0NW1Wbzc0dHRQWWIvS0JkdmR0bkxmNHQwNWwwcjhpbXd1?=
 =?utf-8?B?cm8yRGFySUxibFpIbGRVV0k5djJ1eUNDTkNjRllxQlBvVGdFeXp2QXcwSEE3?=
 =?utf-8?B?eklpK0dHMW9hSENrbnhSOTF6R1hIY3RxbUsrTWg1RW9xMFFpc2R3NUNYTFJZ?=
 =?utf-8?B?cVFQak1DV1hhcHZiQ3IzcHhjVGRvczlFUnEvODBTSEtaSGdIL1dBUDhySEdr?=
 =?utf-8?B?NFpMNnJiZkc2TnVINUkwU1dBNkpaNXQ2OGpPQ0J1RXlmVUE3cUpxamo0OHpV?=
 =?utf-8?B?WnJlRFpHVU94d2lyQ2x0Qm9tdnY1cTJZYnpwMU9tRFlvbjBFS0t1cnUvL0hi?=
 =?utf-8?B?aGM3U1MrblNRSkdFUUpEU3IzTDlJYXNDdGM4NWF2ZXpuUks5bnQ5cHVSS1oz?=
 =?utf-8?B?RXA1aVpxTTJWbi9RMmcyeXAxNGs4ajV1ZjFMRnVuR2FDeGFneWd2WXdCLzgx?=
 =?utf-8?B?YTRSa0ZEMGJKWEVzTXhsNzhrb0p6MXo4bm1jYytkNXcyUHkvZzlZM1FHcFIw?=
 =?utf-8?B?WkJRYURGeHVSUFd3Q0FqM1ZQNlVOblJ0Y1hWYkx6MTBFTTUzRjVlQWlDODFH?=
 =?utf-8?B?QTJBQ21XQVZKeEttaXlyRmVuUGJoamVkV29Yc01uNkgvZGxEOHNoMjMzelI2?=
 =?utf-8?Q?VB88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBSUkpqdzJUZGFxaGNmVTFOdE5IZG9UbzA4cVl1SUN4WmdLTGpTTWpmQ0lH?=
 =?utf-8?B?MW9Jd2I5eGd5SVpXRXdyb1RVUi9yWFFJUXVDMFhLeDhzWU8wbGVKWHRCQ0Uv?=
 =?utf-8?B?M2tyN2FsYTc0RG1XVTZzcitXTjZzT0xCOXpMdnA4N3k3VmpabmI2Vk5YNjN5?=
 =?utf-8?B?UElHRWNFbU0rUC9kamY3a2JnL3ArWndZcnZpYWVsT2d2UFMyZ0hBM21LeU5K?=
 =?utf-8?B?MjV4L2ZEVCsyVkFGcG9VclFrL0c0ZFdDRlJVTzRhWkc2WmZuUkkzODFBZjQv?=
 =?utf-8?B?cjAxRE84Yi92a1RtcVYrRXZJL2IwT0hkRzZLbHNEU3JmVEdNNFl2R1hFNDFC?=
 =?utf-8?B?OFZXOEJxZ2J0TjRFd1daZUlhVEt0WHVnTkE4RFNmSVk5TjZGSEYxVGdHZSt3?=
 =?utf-8?B?c0NPVUxHUDRkTnlUd2x2WHlTZVYveUY1MktvRndjcjVJdmNsem1EZnJOSmZH?=
 =?utf-8?B?ZFo0dmVGQ1N6WEFSL1AwaGhlT01INElHWkM2aUJKcWR4RWxPVkJlanQzV3RT?=
 =?utf-8?B?dkJkYjlTc0RtYTFoQ1F5elNKVGwrMWU2STFJdmlDck1rODlmYU1aUnFzL2lE?=
 =?utf-8?B?Rnp2bHliYVNVNklkN3QxWWFYS055SDJ5cFdjK1QvTWhOazcwcVo5TEZub0lO?=
 =?utf-8?B?dXk4YlZtY3RZVmRrYkt0RDBaMTVNYVVkbGErSW1qcFhuTmV5MzBEaGlMdjZ0?=
 =?utf-8?B?V0c3czliUUNVUVdidEtRc2dadWtMdVdXZG91bkRtYkJlU3F0UFNrTDd3NlN1?=
 =?utf-8?B?YU1uRXJta3hIOE44SW1ZV3ZCSXFna05ETi9NZThlTEJDbW5xOFBwOHFMTmsz?=
 =?utf-8?B?QkloblBaOFQyU3dEMTB2YU9NbzEwUDJseHJiSUxlYWtvY01YQVZmcHk4NXdh?=
 =?utf-8?B?bXliM2JzU2NsUjhYcENkbkw5WHZHTUZ0aUlXWjZOTzBFTU5CWU1wOEpWZDlT?=
 =?utf-8?B?WGxsM1VBUm1aMFF2OFFUeHBlS3k5bXRwL25CQWVLbStabHpER21sRFIwYXZJ?=
 =?utf-8?B?Qi8rL3JRU0RUcEwrVjgremVxa2hFYXdvWWp5WmpPbldoSWNKRjUzSGg3M3pL?=
 =?utf-8?B?M1gxbmhLYnA2c25abURMMGJmVE9KQ2VENHhTSEx0Slo3c29PV29odFUyTGsz?=
 =?utf-8?B?ajJobDBmeDhyTVVMTWtSUFpzUTNJVkc0SXhCejlLZ1NRYU9laVU1TDgra3k4?=
 =?utf-8?B?dk5OaU0wcmY3RS83RnE2L0hIRG1LUkM5NUNXejJHMnkzcDN5WFc3d1NEZ2pm?=
 =?utf-8?B?QXZ0Rnp1WEJQRVA0dVAzbXNGdW12cFJBNXR5YjdEd2pEUU9ZWHM2aksrNXY2?=
 =?utf-8?B?Tm9sRmhrR0RoQ3k2dTBRTVZXcFNBNk95dUt3ZFl5SDNBeWRUUVpleWREZHZB?=
 =?utf-8?B?M0VYN1N1Mkw2MG81a2JWZ2lXQ1luamorSHBBYmkyQnhDeFIzNEhnbHhZNDQ3?=
 =?utf-8?B?OXBDK1crTkxCMGJ1cDRWanMzRkt4STJUb3FJM29mUTdWQ0pJL1FRRXU4VFM5?=
 =?utf-8?B?VTVhaEt6dHo0SGpZb0VQNExyRndQd1U1ZjlwSEdFbmNmTDk5czZZTjNicjRP?=
 =?utf-8?B?UDlZeVBTRVFJWTJ2RkRma1VpNlE3aG9BNE1FZlFFVGhmejF3ayt0RlRhMzdX?=
 =?utf-8?B?WkVXdXVnUnNsSmJ3clF6TDBPSEJyUlZaZjhLN2FEd0JYemk4NzR6N0tmWHNG?=
 =?utf-8?B?dVE2UmxkcmpJZ0d1aEQ5NlYxTHhkSUhNOHJkOWFib2N1UktRelorTkpoendh?=
 =?utf-8?B?clI1aUg2cXAzWVBvNEFPWFZ0NHNYcmtOWUxmZldhd1pEY0s1anRYbmloY3VN?=
 =?utf-8?B?MkFadlpvUmVqakU3WXNRN0dwN1ZoNmRaRGUyb01lc0xkeHI5VFhvUGVtS2Fi?=
 =?utf-8?B?aFBQV1FtOU9TdGJlZ3lMeVQ0bjd6RlFkSW5MaGduQk9hajZrRzFSR3pEWENq?=
 =?utf-8?B?OTM5V3NCRHRmYWJBREZaWFd2Y2MwdlpQS3c0YktnZEhOVGNKN240anplSEE0?=
 =?utf-8?B?WGRKL1FBOHZtWm1SeUU0L04zR1p6MVRHZTV5SzdiZVVmWnNtN1lCUG1mclVL?=
 =?utf-8?B?QktBclVDU1J1Q2oxUlJGM2owN21EZDRWZzNxUUh6RWp4dlp1MzF2SG9WYjFC?=
 =?utf-8?B?bmtKWXpOcGMwMHhhTjJwTGFVcG03TjV6SUdpTFZsNEtBWU5KYTVmSE84VGFH?=
 =?utf-8?B?Y2gzL1lGZlR2TWM2ZldTOFgwSUgzeUNRend3ZHppcUpBMEMyL1J3cElBRi9h?=
 =?utf-8?B?UTJ3dmhjeUg3WUNaOCtqVmQ4dlhGeW5JLzlwazhMOXlnd3h2RFBGZitia2lZ?=
 =?utf-8?B?QmJKUStsWlBQYTRncksrWFJpdzN0WXVDa1p5VFlJWHVkM2hoYXRrdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c3c299-fab8-4b4d-4178-08de537ddd18
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:01:57.9307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBYRizRVkCRLKJ/P7MTVcknMmOE6wwP1qNv3io4GgD/pv3q1gMaQcwbpOYLlIUbgih4InC+lSjy+tgKcVRjphdejmjRwt2eB9Bt76BvhE7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10407
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

On 1/6/26 9:34 PM, Jonas Karlman wrote:
> With the legacy networking stack, it is possible to use USE_SERVERIP,
> SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
> specific TFTP server ip.
> 
> Using the lwIP networking stack use of the 'tftpserverip' environment
> variable provide the closest equivalent functionality.
> 

It does read serverip environment variable if it's set, so this should 
match the behavior with the legacy network stack no?

As for BOOTP_PREFER_SERVERIP, this would need to be implemented in lwip 
and isn't covered by this new variable is it?

This patch is fine, I'm just challenging the justification in the commit 
log.

> Add USE_TFTPSERVERIP and TFTPSERVERIP Kconfig options that can be used
> to add the 'tftpserverip' environment variable to force use of a
> specific TFTP server ip.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   include/env_default.h |  3 +++
>   net/lwip/Kconfig      | 12 ++++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/include/env_default.h b/include/env_default.h
> index 7f8dc1c35a74..014873e304d8 100644
> --- a/include/env_default.h
> +++ b/include/env_default.h
> @@ -58,6 +58,9 @@ const char default_environment[] = {
>   #ifdef	CONFIG_USE_SERVERIP
>   	"serverip="	CONFIG_SERVERIP			"\0"
>   #endif
> +#ifdef	CONFIG_USE_TFTPSERVERIP
> +	"tftpserverip="	CONFIG_TFTPSERVERIP		"\0"
> +#endif
>   #ifdef	CONFIG_SYS_DISABLE_AUTOLOAD
>   	"autoload=0\0"
>   #endif
> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> index 5789766fe624..0cfd3eb2684f 100644
> --- a/net/lwip/Kconfig
> +++ b/net/lwip/Kconfig
> @@ -72,4 +72,16 @@ config LWIP_TCP_WND
>   	  but QEMU with "-net user" needs no more than a few KB or the
>   	  transfer will stall and eventually time out.
>   
> +config USE_TFTPSERVERIP
> +	bool "Set a default 'tftpserverip' value in the environment"
> +	depends on CMD_TFTPBOOT
> +	help
> +	  Defines a default value for the IP address of a TFTP server to
> +	  contact when using the "tftpboot" command.  (Environment variable
> +	  "tftpserverip")
> +

Does it support IPv4 *and*/or IPv6?

Cheers,
Quentin
