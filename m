Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5182EC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2F1581324;
	Fri,  7 Aug 2026 14:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O2fC70QJJCJx; Fri,  7 Aug 2026 14:46:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F0C88130D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786113995;
	bh=CSTjEs8KbB38JTJC5eGxHC4YbUPhMXf4hnLfdCw7o+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wug+u8ptQW1vpuSmKNZmRO+wYxw0xV/PO6ur2MB6tm/ZfctTz1zkGQFykOOrlvXrN
	 kJKMSlV2M7pXiV/duVlTxmXmOZ1P/iUIKwrv2jfZ+bECCzpN3Gw5KAXuR4R3vWv56v
	 cOQPCwnoEt88joyAhKaTus2o3wscnSY0WlFFifINPQ8HgD6h8Zk4Ns/TrKVQxCOAIT
	 aLvJwMhvgjjeBDFdUcwvEX0GSscO3SjBI7sGqGn+4VEWFqw7Zqp+0+VqvyBSfc1gcu
	 hpOxU3I69CaVgvAiu84IDOoHVk06tKj6mAL3n88gOXLX9fqF9nMj9NBrIDNnH+UHy3
	 2+CSLmYnNuD1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F0C88130D;
	Fri,  7 Aug 2026 14:46:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22FDBD3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08F2E60A43
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JNFBq99hCWhU for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:46:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3F93B608D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F93B608D6
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F93B608D6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAa0nR3m4UVYvMZa4jGx5eX/W+4qsYYBP43wwVo0YxmsdkvynazHonAnORmD+2LoElhK+2tPz7LA6KX2fTzQfmBaltCxLcxDvQc4QKSYAPZSj4s28KblxUSOxn2iPuq1gvG7Hkmj1hP5+F++qnJv8C17CUyo4dkFhUjscBKJp35E4FOn609bvJRLsVruqZiEIof4oJf8sDiAl5p7qHluyiYpdXwf0J3Vfv9xXhRmPmaWQGCVlvXJ+J8BqKIfpBXr65ZR6D2TWmYLFBVGnQB0PEanbucqcJXxsdQk3QT8XnpZclHul5JDtrK3k/SzYmmWM8fVPbGbv6jPXyNYsEp24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSTjEs8KbB38JTJC5eGxHC4YbUPhMXf4hnLfdCw7o+8=;
 b=Zb/t/+SEaaMfDF718mNF+869vOM5y01+Irgl4ehd3XGn03NmBpdpkqVEedVuSJ4LXGBsEGMJbov0wzw9p1ob03pSyaWoUUF47dpVdpte/WObVOEsmOXIgdMQ8mMj60oW5vEKgdWYh0wuapi+JDDph2ur20CcbAQ8GD9kX66YzB913CeaZRnwXJV2bvTJl0TKLWdsaFeIyaH867spbS5x6+qgpYCMYR+/KVVQBLL+KPdLUXYSCniUdZSJSlfNLvsE9jHhg9b1JwubBPpty47TePMdEwzhKnhKfYemzRxBmdJFg5IoEODrFkCwfCaY6POjJ9rOlRuIimzDcWCi8VXYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AMBPR04MB11718.eurprd04.prod.outlook.com (2603:10a6:20b:6f4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 14:46:28 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 14:46:28 +0000
Message-ID: <3a564b6d-aa10-44ee-aecf-9740707633b5@cherry.de>
Date: Fri, 7 Aug 2026 16:46:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] clk: rockchip: rk3568: Fix trivial clock
 configuration errors
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0162.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::29) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AMBPR04MB11718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6951820b-a26c-46a1-ca49-08def492a979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|22082099003|18002099003|4143699003|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: DyzmROigTDwjeU+bNRNkhp2PoryN0ld9Y+JGIvvxj6RiD9c6wqr4tIxcKr/3uOY18Pii0laCGbtcnSBYwVGcoPcof1M4HFYrBT4S4i0yrxLslG/hdwERNu7TXTQe5xT/GobYSBjtUb1tzpC0swnsDk1jvkR3fMrpUJFXqDEjpcm7o79Ry6pIJ1efJXkRZPq6Q9PbfnuZxnhlI0S/ZRd35zlDwOn6HmXZe8jjui9EmZFtftik/cSqSHMXZHn8boLLfc4kmfYI3aACz9yIBsdDE9pZTwQPBs0c4v1+Tr8y/S/3UqsSQ/WpSeJQUwgP+E2YRZut0cpGeQFa8Va66iFJmjRfz3UazEvOBI/nuV6onLobv2HyzSdlcavg6B36w2Hgx9A564bHg+STtSic5N5mvgN37l62lCUldLeuVxW/tM9d0wTmzhVzaFwb6Xtu72VAj2fBY8e89rPvR7F/hQs5/Bfk7aJotihMuwVxSYL0wjTIjc3LymJ5qUs7kXPa3n9o/aPa3U1/7kiMh4y21yzVoaIkpm4eMCoDjr+1bthoddBbT7tT90+2wZWAS52mcoGmAIQJKXN6r61KyNy/SMlIeEgmCIAdxOUm2ABUXA90d3GNfXet8+eQqgqupKRFHAXSNYRdXf4Ri9RvowKONBi2yvA1NOjHeQ/DIpGykOtSJr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpWZHVVVFQ1Q3cyK1dzRkVnTmlXNnA2N0gydERpNTRWWktkdEdkS3UzeitX?=
 =?utf-8?B?NDJCYXZNbnVIc1Y1cmNWazJBZTBLNzB2SE15d0JMZ2gwbUxEQlh5cWFhSU5C?=
 =?utf-8?B?cGZzbHJMdmcwTW03OFFTSXVlRXNuVDg2NWgyS2svOEt5U1R1RUNybVAzb3J1?=
 =?utf-8?B?cG9XMmVqbDFJSEk3QVlTZm5XTFZobVN4dDVxMVV4a0RCdFNEbE5kTHJta3F1?=
 =?utf-8?B?Nnd5ZkJPTjB2bGFwR2Z4dkprZjQ2SU9VK1dGUW96REtOM2NwZWk4VURWVXNN?=
 =?utf-8?B?Y1RvODFoVTJ5aVZ5VW1hRVNqcnkzL0pHb09tVDZSMWNGeHMrTnE4Y1kyS2No?=
 =?utf-8?B?K0pueWZhcHBTemNvbktBZGtCZ1RiUE9DSGFFc3VNVFExQUtScmFXWlRsdlZU?=
 =?utf-8?B?WEtsYk90di9oeDU5bVRqRE00MmUrbC93eDM4aGdTUG1iQ3lZeTlLaW1TOXNM?=
 =?utf-8?B?cEsyTmUzdTliOTF4dlpwbCtXYk9Cd0Ewc1hiOGdiT3dobmZ0OGxkNnduYXpm?=
 =?utf-8?B?bm9xYWxrS0dNRU9kcnZIOUJEVFk2VEw5VkNkaUJuV2JKNDk0UGVkYnhEU2tT?=
 =?utf-8?B?bXQweEJoNzB3Uzl5a1RQc3E2c2VpOGNBcERHNUdIKzhxL1Y2eFJ0NmJLQzVa?=
 =?utf-8?B?QzFuenl0c05WQUNob1ZWVWpLbXh6ZFhrMG52b0JaS1dOZGpReGV2bklCOHJH?=
 =?utf-8?B?dEhJZ2R2dDZMWDg5YUhITjdNSDczSE96ajY3Ny8vWjl0YkpZSlFwL1VPUG1Q?=
 =?utf-8?B?NjZXbktUZ05JazQ3NW56aDFuQzQ1cmhvbHkxeFlOSnFFM21YR2wzNUpZMXNn?=
 =?utf-8?B?T3RQWVRQSGd0S3hnNTRjcXRxZUw4UUJjUEdlMDFQbnVqVzFrWWU0TlYvTC9i?=
 =?utf-8?B?dWdkU2NRODQydjdCaW8wMjlnbFVRZThldlB6ZnZpOTZjcmJ1MUlZK2orRkNa?=
 =?utf-8?B?MHNVRnhkcTdUYklGOW9NVHVWNFBIdmROR0R6cnVHaGtDQkJaZnVCQTZYckdn?=
 =?utf-8?B?eittTkMvUHBOekN3MVg3dW9hTTVuZ25sdkhDWnVVMTJ3MFhZRjFiNjVuOHJU?=
 =?utf-8?B?SUZ4R21RQUJlVGJUa3JXYkJBeTRsN2VFdCsxVSs3akVPYkg2eE1qa3dHQjV4?=
 =?utf-8?B?cHVjNUpZNW4zMVRnb0ZoL0tBQkFkbDVzTzB5ZmZ2MktEamd0VzcyZ3BzK1lO?=
 =?utf-8?B?QnhPWkMvTEZZWEhnU3VsbmFNUklPMWZSQlk3Zk4vWUo1MzlXajBaSGJneitY?=
 =?utf-8?B?YzFWcmVtRE5LTnRkd1ZvVVFoZDBvcWlQL2lRdDBOSXB6M2xnNXZTSUV6V21K?=
 =?utf-8?B?ZTMvUWlaZVkwT2VwOHlKa2VnWStRcFJ1WjdJU0VieEd0TmU4NlZ5U1k0VHpZ?=
 =?utf-8?B?TXJUVnpkVlhPU3RxVjlGYzJ1WTdsRitCelZnTStHeXNuTjk0bVlDbTc1UHVv?=
 =?utf-8?B?M3BuQXVBeDFGRUcvZ2hmaktSSm82OTI0ZnVrdW1saGMyZWdBd2N6cTV4elJL?=
 =?utf-8?B?elBOTDN2WHFrOUVPeVZQSmlycUY1Q25YNGJPZU1TMFNTYzdXb0IxVVhmSUx2?=
 =?utf-8?B?dXkySWxRaEs4cWNyQTliTjYvSTc0bmdtR2lYTVhBd2l5NFdvaENEZnRkWU5X?=
 =?utf-8?B?ajVhZ3ZGU1JsenVwZGhHTWVNQ2lKbG5CTytzVHllenh0d2hHQlJ5aFY5bGRZ?=
 =?utf-8?B?RHJCZUJWOE9QMWg1YkdRa01UbU5Hd3B3bzBScmtWRExRYWtpcjZFUkdsRXZj?=
 =?utf-8?B?RVFJdkpuQmNkVTF6dGk2anVjK2I2bzFnam9RNEtHSXdlQzg5c3YzaEQ4N1Vj?=
 =?utf-8?B?bko5KzZtYjhOeEJZbCtQR3pWVlorb2xMZ3JKKzZJM2V6S1BwblRVT1JsM2E2?=
 =?utf-8?B?d1dNWEtQMW1mQ3ZUUnI1b3ZETmRzUFN2TEJSdHlHMVhuSUliMWxCc1o5MWRs?=
 =?utf-8?B?bzM4SUFDRXlXTjZpbE9PKy9wUWhtM1JNUXRzVGhQRXprdTdSYys5NVE3Vkt4?=
 =?utf-8?B?UGlIam1GWnNGRURKeXlSeTB0ckRWTFphUEJ0ZWxKNTFWTzNZaXlDeUxEemJO?=
 =?utf-8?B?TTB3VkdveE9PUWFDcURkS1ZIMWgzRDVlTmxDeEpIZXhGMENldDROVEJ0LzBF?=
 =?utf-8?B?SWVpd3IydnhGcjg2elhxWk92bUtQaU1jZWx5dFR4OHUzUkplVkpCNmFuUE1B?=
 =?utf-8?B?R0pHVlFVbDdHOGVCQlMwMFZZdjJCYXM3RE9UNTJqRXNlL0dxRERXSXFPRTdl?=
 =?utf-8?B?VkZKbHZBb1ZGeFd4OEoxWHl0QmtCT0EvYnZsZ2RBVTZ1ZkFjY2NVeE8vZm1v?=
 =?utf-8?B?ajd1d1pJMy9jNmkrMzM0TXNsaDVFNlM1UnptNjhHQ1VzWk1mRm5lQm5Mb2Vw?=
 =?utf-8?Q?gPXMDddgtfiSeSyW6OddlGquTu5OYj0d/i2HRTSoqtyve?=
X-MS-Exchange-AntiSpam-MessageData-1: JfHhPPP3TzJ+9YUhS/WI3rKUJvQlSUaikeA=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6951820b-a26c-46a1-ca49-08def492a979
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:46:28.1069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6smlamOI8MwqneDmHrj6vUUxrdeEDdLHHaYCQtgfYUoH7HP4ditVjhIHHgjwVLvNiPYCGwe9XdQDb41ENK43y5fR+JEaVDuYFuLzdpB2Ufw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11718
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSTjEs8KbB38JTJC5eGxHC4YbUPhMXf4hnLfdCw7o+8=;
 b=OoMe7bV3boGZ0SMEE6uaOj+GuS3pLCdzv1r+rVzob1A2lqQkpePIMov9ccAxB6jp1/DsIMsN8Xblw4khaTbsu62m3jhejLrahxTspQG5jyh6mzTAU1JuJO9GN5I7lqXuzi5kCK3AmKJtQgiTbddHbGq3Id5+1btgjCPquZj1q4w=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=OoMe7bV3
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The RK3568 clock driver has a few trivial copy-paste mistakes in its
> clock handling.
> 
> Fix the trivial clock configuration errors:
> - use correct pll_id for GPLL
> - use correct shift macro for PWM0 div
> - use correct pll rate for GMAC src clock
> 

If you need to list things you're doing in a commit log, it means you 
need to split the changes in multiple commits.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")

Please split in four and add my Reviewed-by:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
