Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C23DC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49D4160A57;
	Wed, 29 Jul 2026 05:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YwKUFr4q27q; Wed, 29 Jul 2026 05:53:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE83C607BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785304423;
	bh=F2uuqdnyHfPQ7WVDCKD2AjZCp7yH7d9l4ZsfLnykQdE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YZ+/WStQvQN67DaNB5eI7B6qSzxgMCifqBNnD40tov4ptrcS7cqxYA1zoReLXulws
	 RTBP4HU92L+mYHsNCYfV3DoIv4foPccv0lOEvkj7oyheJ+CT9CPeKlVp+zx3yLN8hp
	 ADUP9r5AwO4lr4DFKM6QPg99e160Bn8CztwTv4qlN1AoSNMHnMmF+bPKlf1PTXQUqQ
	 ZD9iZG7w/mkG43PLzwoKMa0B8NQWe/k3n4U2tAByyiu5U3AXAGoM8vUFkRssbbXDiG
	 R1j2cOstMBoLEQpxvVrb+DutogFCh0Qjvj/A2aXXoayS0AxFO8aR4aOv8xwTrpIV82
	 nUrbq7C3zVjDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE83C607BC;
	Wed, 29 Jul 2026 05:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DF5826C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2010840A44
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mLFlKAOUXfKW for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:53:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2A7D140A3B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A7D140A3B
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A7D140A3B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:53:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCFC8494B; Wed, 29 Jul 2026 07:53:37 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAC38404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:53:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQX0Nyv7iNk8WiBn2TULAaxgvvVUFVaXHLP8/OdWdSMkUxeTNSIb20oSMIYb0pRBWneI/rug2VFoQKjOLG6FGuVf4Y5Ca2Iryby/nCK5FO2+RjLVGqlGNYzlvA/UlXiTEM+J2jrCYYVkZxubJK2gjzEeTLfQwNhe0F8rrncS5eGaLO5/QN30O/OogqthquqJ7rZhhrDaYRlVtzQrStVwJo7xH50RGIT+jG4sbu+7YbZks93fqrrISBrprdcgHkWkmjg9mvpNqp2A6cfrj7nC9zSSDWx1upwb9DJV1YzkY7liNQ8TDjxJAnL3Q5NFaZXPQ2AydEoKGB0P1SeYKCdviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2uuqdnyHfPQ7WVDCKD2AjZCp7yH7d9l4ZsfLnykQdE=;
 b=dw5dq0odxYBD9uetV1r010g+WPpLIqHJMv0dfsQnNkRtMQhb/IzA0Ozb9gk16QKzHPA1n/MwNpwFQ9flXFhyGLFp4Ff5OpMhFppOrDJySj7zC5Ai+B/74aQ5/yWltQntZk1ZM0ANO99kPv8dgjGttekmazS4upAGfp6ltTwD0fArRdEPy2qzqx8XQ2UxFNUMaSZZ+3j+bOPEiegYXrwr6knvkolEqI+Hx7Yv7FwqMxiMi9vz+8qUB0yyJOQF/NrcdzRscYzta9tGQl7l8d8TgebDoKOqJkfczW9vkVTMW0jUxaBtoi5Pnfw0kxczdQWdXEwCKqygaEr3Q4pRtKYSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CO1PR03MB5748.namprd03.prod.outlook.com (2603:10b6:303:6d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 05:53:29 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 05:53:29 +0000
Message-ID: <615f70f8-e41c-4b53-952c-e04effbebf4d@altera.com>
Date: Wed, 29 Jul 2026 13:53:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Reset MPFE NoC after programming peripheral
 / combined RBF
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260325054638.13533-1-dinesh.maniyam@altera.com>
 <4d496d68-a6ca-4ff0-a463-aeaca0febf3a@altera.com>
Content-Language: en-US
In-Reply-To: <4d496d68-a6ca-4ff0-a463-aeaca0febf3a@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::9) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CO1PR03MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff6c7df-3526-4ee6-cccd-08deed35b6ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|55112099003|6133799003|3023799007|56012099006|5023799004|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: ce/lfuIQCAcm5MESURVJYb60PYuaULL2i7S8wOeAbdMPvgyRSRKa6X2jAnBjPWWkBWMjza7B/SRlA0CFiLLvIkO3LlI6SX8xR2u9kKWqEvHtihVf6ZQR9pw2dmqCR78/tQaDdnUWrLC3FkBDFLJ2P29do+hzMkioQlGn1FJLwy2ONF/VrtAcDDaUCkKNUU9G4pySlMrDOW+mbcwBY1/uxYVC384f7pfAH5Xz0Xr5yNJeHgD9M27r8UKh/aHmPnvXQsm9G5/pfhehHTLiX+7+7uav5g+8tY6BFn6XiJehwZzNPGRVZ7ff4i/B9cLS0Tkuk+FPhAoWNfqE91/iLY12CNuf4SSXgTmL/wwT0Zkkxxmz987l6b//Oi0bYqMu5K6dh7Q1nDz6nddw3U78M8lMKwqYBKarT2UrOSemu+10MIQSnGo7YS/GSjqdbG67ZGojq81hG6OeXzkwAWmkI3BQsp72ZzATO5EBnRe03dYMsILrTkZPbHfebUNDx9pX8qRKJw0+hi5rzbWjXeqolijm28cr8ggv3HVEycWQo/UAGERWiVEPQ7j+wBnbY9NqqHozfwVqT2ISQYlQA7SLceVaY4t1YemQ/8mJr/SNxsMWY/F83SuVL0YN77CbGsTgtp1375a/X91gLTAdQ2mN3hj7ogexL1TTMJ0yYWayFktFPcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(55112099003)(6133799003)(3023799007)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdYWlppblJ2ckVHSStPbkNMRVI3amhmNDF3NHVtZnlOdWVQRCthNmxKelRL?=
 =?utf-8?B?MWVoTFFhd1p2aWtrSlphZmZoZW1oMTc3Nzk3T29XakdnT2pWaFZRTVlzaCts?=
 =?utf-8?B?QTdJNG1STmlpTTRDc3JyQUlDSmlUTXcvN1FBbmpobmFQZFhqZW90NzRSTWNW?=
 =?utf-8?B?VGFxYlVGYmsyRHgrajlqdmMvZ3JZb0RFNGdMY1hnd0Z4K2VoVldCK1o1Ny9X?=
 =?utf-8?B?UzUrd2lkY0ZzZ1pCeU1HV0NkTEFReFFwUW9tS3hqRjhLZ2w0V3RERlpHcENU?=
 =?utf-8?B?eTNaeU10UWdTejVvSUdvS0g1UWxuRzlDVTh5ZE1mbU1HWDZNdjE1WHN4T2tt?=
 =?utf-8?B?bUVVSWt6U1hpUkdROFhhSm5VSUpyZ1pOQ1c1cGJwaG9iTjRheDNKSGk2Q1NX?=
 =?utf-8?B?YnE5UTdUcTU3Ny9CL3ppSkJGRW5BL0ZXbVd2SkErYUNHTWwzWDliMW0vZ1Jo?=
 =?utf-8?B?bDVnV013SGNDcmsyTERsWEs3SDdpNkRIVGJtdHc2VTg5dHJBSTdFZGZ3YWVX?=
 =?utf-8?B?Vm9ZbERCV2dMWS9HL1lDeEFPK2xlMTg4SEN4ZmViL0VucEswMDV6djlzNXVU?=
 =?utf-8?B?R3EvNGhLZTJHTERBa0FSSWZyV1F1d2NDaEJXcHZBMU1nWkszTS9QUTFpVDdn?=
 =?utf-8?B?U3d4VTBSWFNaK21PK1JNUXBmMW9sQ29GRWE4STQvazhsMjI0S1d4dmFjd2Zp?=
 =?utf-8?B?SGg3SnhaTWRTODdCYnZaREo3VytWNFhqcElpVHBoVzJ0OEY3MCsyR2JzOWVU?=
 =?utf-8?B?bldYRE0yQTZlajRxVXN3RzIya01PTm8zaFNvWERabm5RbU9yTDhxYjBXZ2tR?=
 =?utf-8?B?OWNBUkt4R3Rjb2d3ckpNVmVNRDVJYmtDWVpmTWl0Y0pXd1B1RjNBRTU4UDZ0?=
 =?utf-8?B?UysrTmFuUEw1Qmk1TUs0b0ZsajdkYlVYc2ZTc0REYXJqRWdRb0xXYjlXcmxk?=
 =?utf-8?B?cWVqaHJnWFNDZnEzSlpYeEpzOHR5aFZTTXZBdHpaK0FOTExONmZLQ3liWEpJ?=
 =?utf-8?B?eS9aL1VmTTJPQld4WFVVOGFTOWJRTmhqZWhJdWJsYzNZdVdsL3oraHIrUGxC?=
 =?utf-8?B?WDZqWkI3R216NXFzemNkS2M0aEVCTFVPanpENHVXZUcxZ2MzaG13a083d1lT?=
 =?utf-8?B?ZjQ3ZEI2VkRQN2p3TW1XOGVjNFAyV2xRTUpnZnJuNHlmdDVRa3lzb212N2ZW?=
 =?utf-8?B?aDkwK1BmYjhGRXA0T2pqd09Sd3FCbkVCaE9ueXdjbko0aE5xYzhkZ21aN0hL?=
 =?utf-8?B?QXJrMndnNERRb29VcVhYbWhZNnh0RitVdUllOE5lZExHTTJ0d0FxOTBIMlUx?=
 =?utf-8?B?OGxvV2c1NmZTKzRXSWU0NUI1c3FsUEdlYjdKMk8vTnNTdDhzMVZINmg0N3RL?=
 =?utf-8?B?dnE1cEtIa1dmRDJBOVVJd2FRcVBoOW9rUFlJbGVudmNlYldlTGZGT05UN1dV?=
 =?utf-8?B?NDlzMTdXRGZmNFJyeWZLU3Nrd1lqMFRUaWdIY2NTYUMwWlR1S2dCb2dMN3l1?=
 =?utf-8?B?OXlYZHE2LzZJcWZET21WcjczUENDVG44WTNnRGpWSERtNEtQY2srMmRsK05k?=
 =?utf-8?B?UUFRQy9HQlRwcGFwWXpsQnl4eWVqdnJ4aGQ0b1ppTEJSa0tYQlloSHozRDNQ?=
 =?utf-8?B?NTIwUkNrNFhQd24zclVMbkZqM20zeG92Ui9PV28rZmV5aUF1NGZaakFMZ2Q2?=
 =?utf-8?B?dk9CcE03WXBhZDM5MWlWVmM0djRCNkxQU0VCVUtWNEN2c0lLTXNDa1JtVHdh?=
 =?utf-8?B?UWFMOEJBTU5LeC9vTU5RakdQZjFzTVBPL0YvMTA3d2lsUmR5TWNYWERNOXZR?=
 =?utf-8?B?Um1xSHlmanNicWg1U05RcUV5TGNLdmt5S2ZBR3doRHc5QnNMK0hjTUhnVjRQ?=
 =?utf-8?B?cW4rVzA3a3J6OWZtSndqYXpuLy9lZjdweWRDSDFjV0dBQWtLcDNkMXh4eGpY?=
 =?utf-8?B?d3BZVURuOWZvNHQxeW1QNTNkMVJSc2F5TmV6azNmbjhVNWJuS21OVFNab28y?=
 =?utf-8?B?UnNXWlRzNHR2RUtkd1VvSld4VEtrWWtWcGsxSEd2N0UxaVA3K2d3Nko2S3Y4?=
 =?utf-8?B?Vm90eEx0VURUS1pSbjAzS2d6cXBUT29UbVVxd1NmMmNmZWN1YnZlazEydkZa?=
 =?utf-8?B?QmFTOEJUc0tBR1ZZdkxYWEpaOGppUlNVK21YTWd2eHZockhVTnZubWd1WjRj?=
 =?utf-8?B?R2ZFM3RwcFprUVNUNVVFUmZsZGNjY2RrT1dxcmgzNGNQOHRtSTFDeC9ZYVlX?=
 =?utf-8?B?N0tCSnBCTSsvdWcwM3FaOFgwbk5DaEp4bGl4Q3RUK21tZnpxQXM5NnJkczJr?=
 =?utf-8?B?KzZrOFhhem15M3R2RjZIRmd0UW9OdHBtTWxhdElBR0FCT3FyOVFMaHl6OVBL?=
 =?utf-8?Q?x2Mqmo0Du1Lj9wnw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff6c7df-3526-4ee6-cccd-08deed35b6ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:53:29.6130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5n85MGPZlCr953uwwpWgHK/D1tO4z8zq+qqUblJWD0CdkdXA4v1fKYCBIQmST1nU1AmSqeysavtb+4RZeVhurB//+i6Wz4P/mj9QRPKyYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5748
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2uuqdnyHfPQ7WVDCKD2AjZCp7yH7d9l4ZsfLnykQdE=;
 b=Fq8Dwh3Ny/3n92WTUtFYQM/+HY/iKA/7ZZZSaSnRaVsPhyJCOy2eZCZXl1W99LXdXwCF3Fou2GqDDVdXMvCgS1znKJ9/Kk0kT1NoHoyLyHqbiifiwudz4Dt+14/BE8BO6bYkM1vFZQde9Wj0ElKxW/SuvGLpzBi927S4IHso1cBprICX2JTmnQE6bl+FGvo95zvQ1GkkAroXZ0uuoEw+RMUUVWQukf8IDUOfohol0XGlTHoGwkbwSieLb7idJJPWloQN/Y3nfMeJnf8Ae7iuQvIjfc90bqHDhDUjgUrLinSa1JyYMDoTEKvRRpUO0mecVGWlPG0PWpZHnbHqtNpVwA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Fq8Dwh3N
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="Fq8Dwh3N"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tien Fong,

On 17/4/2026 4:42 pm, Chee, Tien Fong wrote:
> Hi Dinesh,
> 
> 
> On 25/3/2026 1:46 pm, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> This patch triggers warm reset to recover the MPFE NoC from corruption
>> due to high frequency transient clock output from HPS EMIF IOPLL at
>> VCO startup after peripheral RBF is programmed.
>>
> 
> As described in the commit message is not acceptable until the 
> warm-reset / NoC recovery logic appears in the
> 
> series or the message is narrowed to “add SYSMGR ROM-code offset 
> definitions for …”.
> 
> 
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   arch/arm/mach-socfpga/include/mach/system_manager_arria10.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
>> index 0afe63e647e..73e953465a4 100644
>> --- a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
>> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
>> @@ -37,6 +37,10 @@
>>   #define SYSMGR_A10_ISW_HANDOFF_BASE		0x230
>>   #define SYSMGR_A10_ISW_HANDOFF_7		0x1c
>>   
>> +#define SYSMGR_A10_ROMCODE_CTRL			0x204
>> +#define SYSMGR_A10_ROMCODE_QSPIRESETCOMMAND	0x208
>> +#define SYSMGR_A10_ISW_HANDOFF			0x230
> 
> 
> Redundant offset / naming: SYSMGR_A10_ISW_HANDOFF is 0x230, the same 
> value as SYSMGR_A10_ISW_HANDOFF_BASE
> 
>> +
>>   #define SYSMGR_SDMMC				SYSMGR_A10_SDMMC
>>   
>>   #define SYSMGR_SDMMC_SMPLSEL_SHIFT	4

Confirmed against current master -- SYSMGR_A10_ROMCODE_CTRL and
SYSMGR_A10_ROMCODE_QSPIRESETCOMMAND already exist, and the warm-reset /
MPFE-NoC-recovery sequence this was meant to add is already implemented
in spl_a10.c (the "MPFE hang workaround" block, gated on
is_fpgamgr_early_user_mode() || is_fpgamgr_user_mode(), which already
covers both peripheral and combined RBF). Withdrawing this one --
nothing left to add.
We can drop the patch!

Regards,
Dinesh

