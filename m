Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D83C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 15:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4133F8341A;
	Wed, 21 Jan 2026 16:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CQ3Ptu2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18367839DF; Wed, 21 Jan 2026 16:44:38 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0875C80077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 16:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBcW40GlPSny63ujChrGIrJ5AMdEtLA6LoujTREyk/oFLBscQkYwEQq8DvWPtpktd4rMGuXJUVWpfeOagOntoWva+n9umt5cbBAmeqgmnBbBsk6a6lgIrsit6y86u6wvISe3yTG6566n+LZXemEsZmfG0P1XCEgnRhO6k42Q2hj1b90sHBtJjCcrFQ5hNsJlPR3mTHbwOXLhhNvd102U2eYhfrir3SLETTgvHP0ppzHVlvLDn27OwheAwXYjD++xF3EPXIEO9ygscBgpry5g4TV0NcrX1e6wmXqDB+veqAUnSfejEw/+1E2nurF2P4TvweKKsdC/zGLJKCrLNk22Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Beb5t+SVCGTrireGw1vstGgu79gg6TO0KRFgQXfsurA=;
 b=TP49OmP+xl9AGZrPaBNTILcrpLPGwad6e9A8h9uxJn4JoY1BiejdQL50mdE7gcLqjWeAtE6IrFv+HzsT4T8Z2uPIV0sX39ZoecqufynCGbsfd313IEInvJHGnXpIPMXjAfsmiGY9QIy68U+0GhfQ8w/yHAet//opTFjPzGQ/XetGXRY19OHlf1Cktl0i8AdUZ2kVwqLV/M9J1IWvy1sE+t4MP4yphoVU4uvTlW3PuhIijuBQj15qCqt77uCEzUzaQ29WwQrXYuMTsGai2dLK3sfyuCp6CGqqUwcFg5A0Bjl0nGvyzB+nsDOOM2A5T5y2dyBUKoBWGF9aDP0Mi4OAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Beb5t+SVCGTrireGw1vstGgu79gg6TO0KRFgQXfsurA=;
 b=CQ3Ptu2TGbiKINpdoPzL1NFTeFDsIVztdUYRiwoDHUaXzWDPz8OpqRMvaqw4U9VceK5obiFdYqnsoA6I0rWFM9FlAtRv84vk9bbLpTZz/dpqctD+NRjqHbBGqoZ9IrEwrAPdj23yBKzJnmtsoYny6ye6au2hV8A8dWJBlciPj2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB9589.eurprd04.prod.outlook.com (2603:10a6:102:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 15:44:31 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 15:44:30 +0000
Message-ID: <981e1e27-60c7-4e35-b579-cc374930517e@cherry.de>
Date: Wed, 21 Jan 2026 16:43:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .b4-config: Add some patchwork related settings
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260121151930.566075-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260121151930.566075-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: c13fd57d-688d-49fd-2c1b-08de5903f783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGVNSUpKNFVEcHF4aXRTaGtmdVNuOSt0c0ltaXF1cERFM2hnWGZmQkk3eDY5?=
 =?utf-8?B?Y2JVbzNtUXZtdW1XZFAvVllXMmx5NUxvdkIzeDdzM2NMNDdHR3BZcldXaDMz?=
 =?utf-8?B?Qk4yclMrL2Y1alpkQ3ZsMEZEeVMvaS9Wc2VLNGdPczJMWWgweE9vYmFuVVZU?=
 =?utf-8?B?NXZZK1M5aDVTeTJHbksrWWRkOElGNXJaQUxkVUhDQ0lTdi9xOUN6OU5VS0hw?=
 =?utf-8?B?MTYyakVvekpOZmk3NE9nNjAyVGpIRldCa0d0eklOeEZQNWVSY1E4cnFuenNh?=
 =?utf-8?B?RmRyY3Y2QllySTZid3UrU1BQa1AwRk1mN3NiTk5sdG1ITENlcWZTK0h2cTlY?=
 =?utf-8?B?dUdid2RoQnh4ajZvMlh2MU1PN1dJZjZZNFhSVEgwdHo3UnNJMkFHaTVPWS9o?=
 =?utf-8?B?UVEyLzVkMUQyZkh3cG1GQlpRVlUrL21QZDBoZWxJTURlcGxtT0FRRVlVSmZq?=
 =?utf-8?B?T1JLd3lzQ2RhQm1KNmtwcVB6bWVLQlZidFU1TkhQeXdBZHhYRC8xckVuUVJs?=
 =?utf-8?B?VjFuVVhBZ0VTTm1HcklGTy9lS0NoSlFseDA0Q2JEdVpvaDEwd0gzWVliQm9y?=
 =?utf-8?B?d1g4YVBOWE9oRjZRUlcrdko2aU9FTU9CRlJRVmZ4UUk2aFkxVkxLeFlUWUJD?=
 =?utf-8?B?MzFlaWgwYm5PSE1ySno5RXpaMzJSZ1ZHbTJyR1VjSkhUbHFWREtLUlVTZkdV?=
 =?utf-8?B?dGU0cFZZMWVOZCtoRlUySkJmUkhZcEpzSDJtKzR3eW9ZbEFoNi93TE5wSzlj?=
 =?utf-8?B?UlBhZkZkbkhoeU9vbE1XMTd1WGp6VGJ0UUlhT28raHYzQWtxOHRYeFgrbVN6?=
 =?utf-8?B?c2NpUzNlUWJzckgxTGxiYkpLdVJBTTJFVVpTWFpqUmI2OGN5NGNZWGozYWlU?=
 =?utf-8?B?L2x3RUM2SmJCUFQ1Zm51ZmZRWExKK3Z6dm1FUFlBeElwUFlBdi9MSndHdUlx?=
 =?utf-8?B?dllOdnNMd3d1b042VUhKL29GZEx4eWh0bVJwV0l4K0VqMjVEZjJoSXBqaUdP?=
 =?utf-8?B?WHpybEU3UUtTT0lwZ2wvS2w3RDNzOUVDYzFpZzJTYTl1d0dQT09hM0tudHVk?=
 =?utf-8?B?MFp0TFlwQ2FvUkhlbXF0NEd4NVhTRGJRVkFRdHFtVHBjSWJ6VG9UQkFrUnBz?=
 =?utf-8?B?eHVaR2VCM3ZYeEpCa1Q0djZvQ1VzaVN3cm83VGw4djhNK0FVbHdhV0F3bjJ2?=
 =?utf-8?B?c3orSXJDenA2VEJzdTFSLzJaamlXcGs3UHhpM21VaFhGUXErT21NWG9rZDNS?=
 =?utf-8?B?UU9QVHA3amN5U0ZoNzc3eCtVYkhkL2M4cjRhbFhQVnQrZGhoN25aVGI0dkc2?=
 =?utf-8?B?bytRM1pLRUN2QlBBRlpVUlN3cDEwUitBekJpVmVhRTJ2SGRRWFdSZVhHbFo0?=
 =?utf-8?B?dkQ2OFVza0ZZRGFoMER5TWpCZHhydCtaNDZNVU1oTWVHYzkxVW4zcG9WNmZO?=
 =?utf-8?B?Z1dUWjBqK0hxWTFwa1ZOYkxBdVFvdHEweldSZTZHSG5FbUJIdDAxN3FxbFJt?=
 =?utf-8?B?Z3I3Uk1iOVd2V1k1Q0JKT1pwdEczOXFMa3RqVW1FdE1mMXJDT2JsQW9FRDFv?=
 =?utf-8?B?a01KNmxiTlNRYmdNTEN5MzNRbXVxKytvdHd1ZnhnQkZ5Qm41U1psdWlXUk5Q?=
 =?utf-8?B?Uk5wbUJGOEtnQUUvYUdkZjJPQUtOR0RNWVNwR0lLS3RCLzN3VmdFcHpJY0lI?=
 =?utf-8?B?S2ZZUGpoUnlLTUh1aGtlZGp1U3gvVHVZRmtaMzVNamltc2pvWFk5YUFsSXgv?=
 =?utf-8?B?U1hvNHVrVCs5bkd0L05ZV0NCUmRBN2NEbGJoaUd1T2Z6Zm83SmExQlo1dThN?=
 =?utf-8?B?T0VBYndLZEZZSFFmRjFrdTVPbG5QSVh0VlpLUXFoQ1gxblZleW9SeFFYSHp0?=
 =?utf-8?B?dVpTejdiRHBKYXhJcll3QXQ3QkhDNHdPbnBRZ25BWVNtM3VYQk9vQVlIRUoy?=
 =?utf-8?B?UG5YaFQ5NVowdFp0UTVvTXlBMFRBa0ZsZm5ITk9CazM3NU5FbFpmWC9lQitY?=
 =?utf-8?B?UkRtYURWZDlnMkNuY0gvQk9MamhnRWJGb1pTWjFBU29iSGJQZFArTm5mVERH?=
 =?utf-8?B?cGZPVnpyTTJ2WXEwZjc2OGFhWVVtdHIwaFFRZ1ZkRnhqVmJ6RWNJZmdKekVS?=
 =?utf-8?Q?PeqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlQxb0tTMHdiNlVXWEFjMjhLbFZ4em5iZHh5OFI3VXA1Y3BINmtMUm01dDFQ?=
 =?utf-8?B?dk02dHNLTFF2eTJOaERWQ1BOTTA4YVdZc0NTWE9HYm5pT0lGLzdnazR6b1Jq?=
 =?utf-8?B?aXROTnd0Qnoyb25BMGhuWFJia0pPalhUK1d5SkprYXBLK3VvV2I4MnZMS2ZP?=
 =?utf-8?B?T0hxbFVKQjI2bjFyLzVrK1kvYUhjQUl2eE5CZTlUWDJFTFBadVdENmJqaHQr?=
 =?utf-8?B?Y0M0NFZlSFJhSUIxNERPS2pLM2RHTjN1dWJDMGdFTXJnZWl1QmlPSE83aTJR?=
 =?utf-8?B?YXI2aWFuYnFvZVBHMDhnRWZnbzZVeGFNa2tVTWdYWEdCcWdpckVhL1dzOTY2?=
 =?utf-8?B?a3VQdms2WURrRUJQMlJ4SVU2VXpROFpOOWZ4dU1INVVHTFpaeFlqaXh1SStl?=
 =?utf-8?B?S21zMWdWRDBVdnhZaGlESlRadzhhVXFXRWNtdmd6dG1FYmVKbzZUbXFIbDM1?=
 =?utf-8?B?MVkrZysydjMyMUFPOWgvb3V4a1ZBUHlEQXcreVhHSEJ2M2REM0JldXB1RnpC?=
 =?utf-8?B?dmRKZWJORHRiRW5sU2YvbWF1UTJENHpVN3Z5N1djQkJHUHkwNVRTdWFNZGZU?=
 =?utf-8?B?dnBWR2VpKzR4U01TR09MUUdXS1hzM1VzZkQxNCthZWFoMFkySDh1Z2xUWHp4?=
 =?utf-8?B?K2R1NHJFenJZaDJMZXdFZFpSSjdSVElINndncHhUck1jb3h4Y0hTQktkWnN0?=
 =?utf-8?B?di83VG9LQ2M2VCtnb3RBTXBvU2tHbjhFbkNQM2x2TG0ramRESWJXTlNDU3dY?=
 =?utf-8?B?a2pxYU5WODFNeGRXVEFmd012TlByclFCcXROZmliU1ZaRkJVWnlVcmRTWXpE?=
 =?utf-8?B?TVpwOGJEc3BCUEE5VjVKSkJyQkZIcHFQdkN4VkZRMU43SjY3aDcxeWliM2NQ?=
 =?utf-8?B?RDZkSWdyY1pSU2p2QjRGb2JqZzN0M1MyRWIvL3BwNkx1MkdZd0dHUGZjOG05?=
 =?utf-8?B?TEp0S3lRRGt3cURWVy9EYzdqQ1RtOStUZ1pqOGJodE5RaE4yQWc2b0RXeHVq?=
 =?utf-8?B?Yk9PbE1TRmNoMWN2d05BTG9sSTZHOTVsWjNVcUhCVjJ0RkVPUjcyKzE5L25W?=
 =?utf-8?B?Z254c1hLeWYwdjl6eFdZS1VjNFJGL2tudnVsSFBMZG1JOTZtbmh1UEY4RjVC?=
 =?utf-8?B?NjEvcGI4cWFXTVdzS1ZNSHFjYjFDSXpNVkJpMnVSMUhKeElTbitudXBoZ005?=
 =?utf-8?B?aW1XSWJRamlJL0UzQ3psZjdtcm9uNE9LQlhZbVlVdmxxR0IxQjlneWpQSWNJ?=
 =?utf-8?B?UlRrRncwaEFaQjE0bDdQTk1qMDFYK0JTSE0vTHRhN3lkTDNrT0E3Uk5QT0tJ?=
 =?utf-8?B?VmNJeGtwWm4rS2d6YmNSVzFydGlsZGlOTG5QdTZReUhHYzlvTFlHVW1TT0Fz?=
 =?utf-8?B?dUJKVkx0cER6bUZpSXdJbEpSVHBXQUxYZDgzS2FoM0JPdzZiRHA4YW51WWlW?=
 =?utf-8?B?bWdxYmk3S0xMajZvNVB4dFdOVG9yRGxrUmIxbElBamhkUjdkUTVFQnR6dVJi?=
 =?utf-8?B?RW1MVXNaNHlLajZ2M2J5T1I3dTJVa3p6OFc5TXhzZ0VJRmhDaVNyc0NPUmxI?=
 =?utf-8?B?cDcyb2VSTVRlWEhteCtXN3BQbHhPOW16cHFzc0owZXNsTEhXYTJZS25RbFU3?=
 =?utf-8?B?ZFlyYVlXVksxaDEyWUFjZ1ptUkE5MlpvLzkvNEViWGRzZU82K2doWFVKTkFR?=
 =?utf-8?B?cGlDbHV4OXFlMDJZSE10NUVueUhuZStqYURhaTRYRWhZRWorU09sQmNzTkdI?=
 =?utf-8?B?NG53YTBnUzlZaVlNNUFJNlFjdXdhY01NYXBsSVBWaTc1ZzVvK0paRXlLN1BL?=
 =?utf-8?B?Y2xDSWtKR1JWM1BZdGsvcm8zUnZkWkRvREcvdTFTZ3l1WGtBSHV5UFNGOVd4?=
 =?utf-8?B?RW5HRUIrSmRRTTFZN0R0dVRDRVNSSDdnQUtNUExFZnhyQmd6Z0xQRmpnSDZ0?=
 =?utf-8?B?OHBtZXEwd3lsMmlWWUMvOG9aWlpUeHZmRFN4UFppTldyZjEwRitqekV0RkJr?=
 =?utf-8?B?U25ZNlZDR3hDTEpGOFVnUUlpSDU4MXV1ZDVtVXZsN0djcFp3bldUaGd4Ykph?=
 =?utf-8?B?SUVaSmhVeFJJYTJ3Rk1hNTZsbWdTT3JlSjEzS3FodVNXcWxUbFJHZ1g1RTBM?=
 =?utf-8?B?M1VJb0JDYkZCZFgxNW9kNDNZNzVSLzNJOXJ5c3hmbWZ2QXNrSEpiaGs0ZTFz?=
 =?utf-8?B?WVdFemMyZTRFcXplMWhZaGdNUVBQV0c3Z1ducGhRWCtMaUlPZVFLL05oUFVX?=
 =?utf-8?B?QXlvSjBoa0R0ckVJNjFwcUt3bCtEaDBSRG1lRHZ0R1F6blRCazZZV3ExcVJ5?=
 =?utf-8?B?a3MxbUthSzZhd0s4VGM3OE9QbHBROStPWXdrei9KYjB1Vlc2bTFvNmJnUFBJ?=
 =?utf-8?Q?zTglPsFANXS6RTy3ksoqpnQcdDLpy8o/mm67/?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c13fd57d-688d-49fd-2c1b-08de5903f783
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:44:30.7100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N24RAK6YEKbZLZlr9tnvr+nfJ6FCfIH9qTzX2I9CRk8aVDsSYv/7/MWMhJ+aow3SLIRuDEtnbWzdop1vnohZM7L75rxZ2DoO2IlO1m87E9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9589
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

Hi Tom,

On 1/21/26 4:19 PM, Tom Rini wrote:
> To make it easier for custodians to use b4 with patchwork, add some
> defaults to the in-tree .b4-config. The API key will still have to be
> configured.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Tom Rini <trini@konsulko.com>

I cannot test this myself, but it looks good to me. Maybe Casey or 
Mattijs can tell us whether they're also using this :)

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

FWIW, I'm still planning on writing how I use b4 as a contributor and 
reviewer in the U-Boot docs with what I find most useful.

Thanks!
Quentin
