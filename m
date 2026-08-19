Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8060C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 12:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0429C40604;
	Wed, 19 Aug 2026 12:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDu35CMq5Jt2; Wed, 19 Aug 2026 12:49:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787143787;
	bh=zAHAmbec2m+ADdMGpjDtNuWGKq4lTAn0T769Qbs/H3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sj2FIdcH/PmhG1ye65q4hldwEH6CmpZeMPzG8xytfke+/y/8Q1VuLdEWj2Fo4Um6G
	 UIVyURM0QulfntG6ZllThotmiG5Gc66j5BmqV8SEuPoZVYMLhVzE2MdGPTElBuqicm
	 lPGf1DpadtbW9T/s/IUocY/Panay8DDwGMI8eu7crTE65UhCd2buBy7Gt17QIIUCrr
	 kzTia2RjUZFRnZI4vMpuAtRS/znAO3cPTkZl/Mj49L3i3IFYV0erDy3EQEUbV7+Nx4
	 Q1bD+V2qcS8tQ5pipKXNkK9Rx/TOPzsyIfGuKz6BKWPLrz/TMh1ll6nvy5tLypZ5Yc
	 RMmHwurhSB69g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7298405F9;
	Wed, 19 Aug 2026 12:49:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 02CB53AC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD08C40572
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:49:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_Mm8EpfO0y5 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 12:49:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=oBwGAQCM
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4A9A405FF
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ1SOxIWfgXcCiNtjcIE3OZgl4fWGF2BAxELoqRqEIt/IBSRHej15Xiyej2663o/oLw4KuT0PGXnG6L3kuNyaC9qo6gw9lavep3qXEh/ay/khf1PEQidcX/dsrlp+eqiuaUPOYkOMZHYbCROLNeRaS4VBPSm4bC3FBUUEHbJoMkbNRzqeidgwUlGt4/QfY0AXJ52cyInPzX5h0U1XpzSELmZRVEYaUpw2lOHAFgs8GgJiKIj4c5gS8Lges55JhqVz4yARK7u7kFYty8qd4XqNotcxEWYHxLihX4ZQYF8e0R0SJFbxJQJYD6WwQIGmvxohx2bEMjhvRfG/hwVFX2gdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAHAmbec2m+ADdMGpjDtNuWGKq4lTAn0T769Qbs/H3E=;
 b=slVOBm1F39EBtgsY7+8woS+42+cXn35apgeUKt18jkrVoMXZlSKVj+MEcNAHhYWWj5lF8kPrMtUd5d8GNnZIVDLayToKRPsb7tFDNVcc3yJ1dxqqqtpqbsKJssir4nnEatLkik1YboUXdRMWiTXM3y0wVwzd0o9j+o7jr1G9dtMnmmNupubLABG6c5s8AcclVmIueti1uuYoKQt+d48KdZ2KEe9Dko7Lj+UatIocOSbmJ/ytV+i7Hwha9Iqr5MqfljYhTEUf7VN11aJqt7xX04MAq/4xYX8fm9oBKfKu2qVwVTti9JC3Gr+ArFrtrhPN4HVAhDM1sJjizyOBubA26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAHAmbec2m+ADdMGpjDtNuWGKq4lTAn0T769Qbs/H3E=;
 b=oBwGAQCMH4HBWFNSrzStP79mkMy7Y+6J4xNy0f9CZns9eSiSAXtRW2tkHfNLhShkHPJkLxdU5+PQjjhix7wU3Of7+KXy0SnFZRq/o1sCqGvXFdQTAfqwXdeOwAuUKXdfA32mMEZAmTfWrn+/dbt265DCbIKU6tzIPVDwgwcQWDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB057846.eurprd04.prod.outlook.com (2603:10a6:20b:7d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 12:49:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:49:39 +0000
Message-ID: <c885ef7b-5d2c-4a0f-8681-43f3f87c650f@cherry.de>
Date: Wed, 19 Aug 2026 14:49:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] rockchip: doc: add back to ROM section
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com,
 Jonas Karlman <jonas@kwiboo.se>
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
 <483e93ba-a427-4ed1-b5f6-8d6cd11c5a42@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <483e93ba-a427-4ed1-b5f6-8d6cd11c5a42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0026.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36c::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB057846:EE_
X-MS-Office365-Filtering-Correlation-Id: b09d280e-5bf0-4ed4-ce94-08defdf05520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: GL1i5kith/bbGfS7zfNwxkeJmvDvYiegH5+xHUsQkbAx39O9ysOsc8KsF+EXjFgp5SVFYeUqdMxEPGiLnZI44Jo1Ui5MFKgrtW+fAbT4Ovajsl+UkmHpdpDm/Or2XvL+ajHaM383iaKEtQ81qLMwnt9UjeLiOsFz7we+0UJd7JSm4Af7d65jDbocjZf2jx9c26f8VLuOkWCduxtUDLJvH0jbuwKMXNAVIcP40p2La7lJr3c4DDcCD/sD/7j65VqMDhgoS9Kpk3u25YEwGGltUDJD/YNjuYzG+SB39uA3iQFqzNPdwod1aHElTKcGuwqKBaUL38JJ+bTnyjk38CICMcmCZ+NKNcqXK3KxQGN7ttUsNWN7zz0GyOapB8KEsLprv247wOibkv9jCvj18yZxG7hprCAfe7CM0VUCcAYhH1H7+g/npkMnziL6S40lBYGJA57lYRSvjXigLC7+18mlQvjeKv4Z5Cx5ngrzYz/rDTbR532whjyz9wsUIljXFAecZ8GsJs8GyFG9Ao3QV9P+H47Mv891Lfa1H3oKhop6h4R0dxs95jxfK6M6hOyOC61BOmIJpr1lR/z42GC5bgcqlNju624PcHLOQhtOVcLoPGqjplBBaLU/omD2KF/Pu9ozJXCv8wtuipTjrxczmLAnoSYKZYT6z8R2BwWcF/z8R4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZSenc5QkQ0MlQ3T1NjRHlsMkF3OGc1Y0pMVzJjZTFpWGJaVEpzaUVhWHhC?=
 =?utf-8?B?TGorbE9QMjdmTlIyZ29qOWZVSkJGME1zd3ZLNTZDd0UrNGFtSERQZE5oejBE?=
 =?utf-8?B?cDY4S0pGNXlBRFA0ZHFTc2gzUE5rYmw2MTVTVzd6MnB2QnJYQkg1bDFMd0NC?=
 =?utf-8?B?YTNZKzZGRGtPK040MWlrS05jRWc0QzJXTk1sUG4wSExxcyt0ZXBpWUttZDQ4?=
 =?utf-8?B?L2NEWGhOZXdRWWFSNEhVK3JOaEJaOU1tVVlmeWtHSitHUmJIbXNtY3RtOWps?=
 =?utf-8?B?cWtTK20vVzdZQ0d3eUVjWU5jSG9qa1d3akE0Y21HbEZmQnNoQmNlOXBrWGcw?=
 =?utf-8?B?YmhxVUpkRUlOUUNrNklzQXlqQkFoSmk5MWkyUUN3REJ1bGd1S1A5SVNMeFhw?=
 =?utf-8?B?VjlaZ3VFczQvMmtZMVh3YlIxYWNnVmZFdUdPOHpIYzZXT1VITmN3aWhWWFIv?=
 =?utf-8?B?YVFvc2tUWGt2UkYxV0VJWS94OWpDbzU1eW4rcld4WXpiSUNrMmg4UTc3Q1do?=
 =?utf-8?B?S2p2WjcrTFdKLzJ0NlZ0b2FzZVlNQjdSMzNCWUJGQmxZemdLTGlNa2cvVjZM?=
 =?utf-8?B?OVVEN3dFU01ySSs5cjhoa2lIVmFGempSRVZEd1hqM0ROSXhOZVFzcElCbjha?=
 =?utf-8?B?ZFRiY3BwaktyYTdMa0ZTKzRPM1JGWUZHdkpsQVdocW1oVHFQaWl3aE5tWVZL?=
 =?utf-8?B?TXhCYjJlRlhqa2lmNEN5aHI2VE5WQzh6c2pDQzgwamVHRkh4eTcrc1NDeWpB?=
 =?utf-8?B?SFNRQ1MxL0lEOC8vbzRid1Q3NlBHY2NxY1dLeVFyMG5vU1l5MXRucUVzYk50?=
 =?utf-8?B?Wk1YbnRHWDhhb2JnYmpCcnRWMEdZRmZMZlJRNFBzZWc0bzlGQ1BibzdqcUQ5?=
 =?utf-8?B?R25lYmxWVkxJVnpJN0FQQ1U4Sll2U1NhWTBiUENrTGhjSHRvY0xoZWZYRVBo?=
 =?utf-8?B?eTVtbTV2TE42WkNITFdjZmQxcUhyajJBZjVzZ1RFN0RTRldyNWlSeDVKRWJW?=
 =?utf-8?B?dVBkUDZ4SWlFdElIQzJoWkJpeVk1eXlYRGhKVWlkQ1JTUVBDcUcxR0t4WkNJ?=
 =?utf-8?B?MFBhckkxZ2VGTWU3T0JicHNscGUrNTFwNUY2M3RjUjBrRXp3Tm56dVdQaGZs?=
 =?utf-8?B?RHVCVHdaVkNzelArQVJmeTQ3K2pBc1lFdnlybWxKNEt3MHR5VHlxeHhjc29I?=
 =?utf-8?B?VVhNdVpUWHpXZ2Zvd2xOTTBBWHBZQmtyUFdCWTdXV2hXeWVvTTVaYnVFNUNN?=
 =?utf-8?B?OEQwYnRHNmYxb2pWMktFa1l3NFV0N001RnBGV2hBZWFKcGI3blZwa3dBSkgz?=
 =?utf-8?B?N2JSNGx5NUVIVEFnZ2VtNXhiRU1pWDAvb0pWdG1qc2NoUmFRV2ZBcVF3L0M1?=
 =?utf-8?B?bE8zcEI1emtkNkNPbnlwV0R3RlJNTk13QUU1MUx2dnVoc2duT0ZaWnRyNW9n?=
 =?utf-8?B?NFVlUmlEZ3pPT2c3WUxYTjJoZndURk11RC9kUWtUcy9XNEtwUnFvaExqUUhl?=
 =?utf-8?B?bkE2c1I4N1kySG90cVE1KytKSGxvTm9ZbWs4OEdHUGFXNnlqYTlheXpCN1VP?=
 =?utf-8?B?eW9RSWxmeUgzekVOQkFmR2ZuT1pHWlpKU3A0WGdjWnB6YVRheDNxcFBWUkVO?=
 =?utf-8?B?SS9jaUNVNndRQ2VSQjJTMVJwRllQWWNoMk5xc2hkSUU0M3kzcTRydmRESkcx?=
 =?utf-8?B?OXFGY1ArWENaMTZZdGJLRnEzOVZ3aUkvSjNpUVFzZFc3aDJIcjNXYnBDY3Fs?=
 =?utf-8?B?bXFyb3dhOUFOQVExUTd5R2ZWOHBKV0tWS1JwNCsrY25USmFYdTRTUlhER3BV?=
 =?utf-8?B?YjlhSmt1TlNoR0J0SVArM29QT1pKNFZtSmRQcTJIN0JBKzQvU2FjVzV3ZWZ4?=
 =?utf-8?B?bmo1aDZyQyt0d2g3aWNyRlZhNStiaC81TUZiYWh1S250U1ZwSDVpcEJKS1pn?=
 =?utf-8?B?YVhjK3BqV0JNUUZoS3ZXU0ZQd3VNbC8vRUpTMnVrWG5KQTRmcnQ5Z2JRdnV2?=
 =?utf-8?B?a0lZTnNxUVdPbmxVMnRDV2VSQm1hTGtieFZPa2JRV3ljTEI5WExpSWZqYTZB?=
 =?utf-8?B?dHRuWWdBTmcwdkpDK2N5bjAyaEtLSllvYlVzK3VFVU9Rdi83RnZXeVoxZnZD?=
 =?utf-8?B?eXlpMVludlFXM3MwV2h0aE12YVN3YlB3Nm5DNmxIQlRHMDQ2ZVJpQkd2Tmpj?=
 =?utf-8?B?ZGhJTmt4YU1adnp6UzlBejJUNjFyeVNITkRtTE1wRW9maUNiS056NGRwNTBP?=
 =?utf-8?B?ZTFDSkEwWS9uT3Q1Njc5elo0SEgzNk04bzJqMUhaNGl6dzRRWDduRVN1WVNK?=
 =?utf-8?B?alp4ZlpyN1g1ME9DMTU5bjVuRFVMYTkrcDEyTHZLY1Nub3VHUGJwVi96YkhB?=
 =?utf-8?Q?ZfsDx6KPQ/ivMPqz5cQu3uQvuQNKK550E+ZExdHylUyih?=
X-MS-Exchange-AntiSpam-MessageData-1: dyGw39S4fqNaXA==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b09d280e-5bf0-4ed4-ce94-08defdf05520
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:49:39.6948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88f+SDelY/OzzSATBCrz13m6aJwYNLEIDYHQBDi1ClMvuId9eVB9BIbBL1hNH/8P9ViT2iuM6mif9njydl4lYHprEyxbbPnZJYgBNyP98v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB057846
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

Hi Johan,

Please incorporate Jonas's comments made on the v6: 
https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/

This also applies to patches 2 and 4's content and commit titles/logs. I 
won't repeat his review here.

On 8/15/26 3:08 PM, Johan Jonker wrote:
> Add a back to ROM section to rockchip.rst
> Correct Kconfig text.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changed V7:
> Move under a 'Boot flow' heading
> Remove "Some"
> ---
>   arch/arm/mach-rockchip/Kconfig  | 16 ++++++++--------
>   doc/board/rockchip/rockchip.rst | 11 +++++++++++
>   2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 1a2e7847c9e7..c1dbcce1e27c 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -600,26 +600,26 @@ config ROCKCHIP_USB_UART
>   	  SoCs will enable this routing as a debug measure.
>   
>   config SPL_ROCKCHIP_BACK_TO_BROM
> -	bool "SPL returns to bootrom"
> +	bool "SPL returns to boot ROM"
>   	default y if ROCKCHIP_RK3036
>   	select ROCKCHIP_BROM_HELPER
>   	select SPL_BOOTROM_SUPPORT
>   	depends on SPL
>   	help
> -	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
> -	  SPL will return to the boot rom, which will then load the U-Boot
> -	  binary to keep going on.
> +	  Rockchip SoCs have the ability to load a second loader binary

If I'm not mistaken, it can go back to BROM more than once? I vaguely 
recall the maximum supported number of images in the rk header to be 4 
from a discussion we had with Jonas but cannot find a source anymore :/

Maybe we should reword this to "have the ability to go back after SPL to 
BootROM and have it load and execute the next binary in the image 
(typically U-Boot proper)"?

> +	  after the SPL phase. If enabled, SPL will return to the boot ROM,
> +	  which will then load and execute the U-Boot binary.
>   
>   config TPL_ROCKCHIP_BACK_TO_BROM
> -	bool "TPL returns to bootrom"
> +	bool "TPL returns to boot ROM"
>   	default y
>   	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>   	select TPL_BOOTROM_SUPPORT
>   	depends on TPL
>   	help
> -	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
> -	  SPL will return to the boot rom, which will then load the U-Boot
> -	  binary to keep going on.
> +	  Rockchip SoCs have the ability to load a second loader binary
> +	  after the TPL phase. If enabled, TPL will return to the boot ROM,
> +	  which will then load and execute a SPL binary.

Maybe we should reword this to "have the ability to go back after TPL to 
BootROM and have it load and execute the next binary in the image 
(typically U-Boot SPL)"?

>   
>   config ROCKCHIP_COMMON_BOARD
>   	bool "Rockchip common board file"
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 5e16e860bfd5..d5945e805ba8 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -560,5 +560,16 @@ config-flash.ini:
>           PATH=RK30xxLoader_uboot.bin
>   
>   
> +Boot flow
> +---------
> +
> +Back to ROM
> +^^^^^^^^^^^
> +
> +Rockchip SoCs have the ability to load a second loader binary.
> +If enabled, the TPL/SPL code will return to the boot ROM, which will then
> +load and execute a SPL or U-Boot binary.

Maybe we should reword this to "have the ability to go, after a binary's 
been already loaded and executed, back to BootROM and have it load and 
execute the next binary in the image (typically SPL/U-Boot proper)".

@Jonas, does that make sense?

Cheers,
Quentin
