Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958F606A33C
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X0DZzsxK;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ZwmX57Oi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B867810F7;
	Thu,  5 Nov 2026 11:00:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01QL9hfs8mpL; Thu,  5 Nov 2026 11:00:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3880F810DF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793876439;
	b=lhoCWOUxh8EUzlXQLmtdGe9Od3WBLRFhbKzvT6j7QYL/n+lSMoiBcO9JkXy7OvIQmLVr
	 QZcduZEbryCPGMSpCMN0aeMVoipzPP1nrpwXWCuhPLIo6O1yzlvtzZG/gpzPefsllFwcc
	 tp2Fzdx/6UdR8DhSEEwhmHWIFAXDzoqSP53n76tvT4my0NbnMQ6xKYvXx8u6+Y/OU7wSK
	 X7RsgWd5QIiO0RXNXYfcW+RJGKJjhG3KDax3hX5YJrrqU4NGWowotkGx+u304x/7o4rx5
	 zblYNzt9uqa9zhUGSEhwT46/FhGsF66ESRfKtt4AxcDIFMhXlfmeBMXveeVUeRkP5xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QieZ3i4xrpl9dnc7dP2YO7u+ootgv7XBpBAwYWdjiFA=;
	b=mx1NHDFH8JStxArmRsNTXCag8gGKjpzkuQz2RIdfWaumeYW0eI9x21uNHqbJ526wegGX
	 1+xg9MCB4WEAj5FS5Xd8yI5C1O1m4lKuKQ/3P0ZJf2TpCxgypim1mPcXU9sI2mGgrxhCh
	 ORPiqiffBI43bh+nEZqzbRweXejhfqwHtSxT5RvFAPMISjEf9m1kh8/aXvktbkzJXyCuJ
	 kSO4JLXbwthaJY7HpgQQxIW8p2OGscgD0hT78X1iD5hqjtml5qk7+APrZzLrdN9ob9EMx
	 +DFT1XgiBURbjI4RSXtCaGwbYrh2mpUX4KVN6qjmAML9m2bne9Bn1Tlnkl5w+rOqt5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ZwmX57Oi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793876439;
	bh=QieZ3i4xrpl9dnc7dP2YO7u+ootgv7XBpBAwYWdjiFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X0DZzsxKg8x59JbsmNDHAh3wjWjT6WRGzt+dJuZy460A+lsNZrNMcKG1BNtboVvUo
	 6H2K1OsSRVwizRtRX+VBztltiJEGIjNn6ya30NPArCbGmS/y60eUfEt/WAodpPrNVH
	 GJTdjJ3kCUivnZqS7kTJSgRRMGueomawDos8jgBj3TzeObxIzb7J0KnLmuEsDDhW8c
	 upvLv3/OQ8k5bRVfJeDm4xQ8IE3SME+kdjo3ofQkJJ+PQ2/ZBdfV9I1HupZ4cde7ge
	 kxWgbOJ9HhMXbfWSatyP7ryrB216nwLUM2H+QYO9VK4uwdQExYEeDKcnsSP46NHX0V
	 YaYtn+I8U+WpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3880F810DF;
	Thu,  5 Nov 2026 11:00:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D85E1779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32E2A810DF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3fE63-YrvrKY for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 11:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F1BD810A0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ZwmX57Oi
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F1BD810A0
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QieZ3i4xrpl9dnc7dP2YO7u+ootgv7XBpBAwYWdjiFA=;
 b=ZwmX57Oit4MCT11HCRDKgbka+YTdjFwpqq6wdANSCe+5v+S3/rvBgP2W4vZUcVX6URTDcyXtewQjFhvJF/XT0E3sNpym8uZvRolKwJnh7Tfl5ZOuExdaZL1DMwwgg5G492Ain4297rICgMIdxiLpFmsN0qO8iyI/FCBETg+5Ry0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU4PR04MB11981.eurprd04.prod.outlook.com (2603:10a6:10:617::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 11:00:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 11:00:28 +0000
Message-ID: <76240a0d-96ed-4a8b-9336-8cc96c6e6e4f@cherry.de>
Date: Thu, 5 Nov 2026 12:00:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: develop/sending_patches: add tips for series
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, E Shattow <e@freeshell.de>
References: <20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR03CA0069.eurprd03.prod.outlook.com
 (2603:10a6:803:50::40) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU4PR04MB11981:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0bf49f-26d7-4635-d518-08df3b2c00be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261021130227099003|261022113327099003|261022105027099003|261022075727099003|261022115727099003|261021133027099003|261021135927099003|261021123027099003|261009223027099003|261021121427099003|261026135527099003|261026140227099003|261026121527099003|261026130827099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|6133799003|4133799003;
X-Microsoft-Antispam-Message-Info: 1+VBGl6uTY/adGbVhID3VCa9vy5NGdcWxRd86qHVsdwcrF4AgfbpPtwswrmaiBrvJFSOQaa35AkHU1/eKJ/n+HkkI2fYa6y5h2ZZLZFXrQ2EyG68hKHpi14lgJCT5xHdDeU6Z/8UL0HqCwkMHAMKob3J8ANI8DOtS7Fh6zsiaQTJpzu6uB+IRXkFqjhUd/2pCmfM2VrrfjOZaCRWo8RWfMSjIrqOor08c86QKJKyycEFSFohR5qOIFgej+afVkx6os/dErWYAOYPcWSvi4PnjO1h8cmTzL0hVEbJNSywFkmIyM2eM5CRFoJBbfbpVFE5K8ph+NfRXRakTXa6+mU9Gs8BRatJs8WOrfh7SAfrgH2rVzkpOzrdvGvofo/xJDfZxtz7KVwnlfBiSU4YckjLbR0CZWFYxSc0/pjwMjj4dCLjr6W1uPJZIG0P9tOXqG4qdEth2r/IH/H4rg0snLMX04X4bVMI8Gu4I9RY+49RbXh1wpCMywzA8KllV6afJvG7Whyduy758aaNHol4tCmYGkzsU2MAoYFNX0J1v3qT6rvluNFEgwrJo9zN7fPv9VmPay2Z5ujnH96XvM2Olk1zkszrA6FeIyiiQ40GkMR8MPTh8IgT62vnQyOjgwM9iBxg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261021130227099003)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003)(261021133027099003)(261021135927099003)(261021123027099003)(261009223027099003)(261021121427099003)(261026135527099003)(261026140227099003)(261026121527099003)(261026130827099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdmVUxGdXVtejFndHZaK2JzNmZNdUFMTnJJRDBYbWNrNjdRZmVyVFdMQW14?=
 =?utf-8?B?ZEIxTDkwdjU3cVluU0ZhUm9CQXFDQU5DZkt1cEpLYmtpZk11RUVrUFBtTFJz?=
 =?utf-8?B?dEdYVnNiZ3gzbXlsMHVUcG5WNllMcTBtUk9EMVZHNmcwQnM1QXFPeFZFV24w?=
 =?utf-8?B?K05IdVpUTUpGWWp2SjhpVTRQSDMzVVBMM1I3UDFSTUo1UVJnV3dTdStjclhQ?=
 =?utf-8?B?MVhCd1Z3dUhFVGY0ZHNTdTVxdXpicEYzR2h0S3VRaVMwY2h1MEIxS1h6QWVF?=
 =?utf-8?B?Z2xMWjFuSWhkanNmRnhjTWIvaU82UlhsODQ4b3RBV3R5MTR6b0hVTTAwcnhy?=
 =?utf-8?B?bVBpLytDRG1mNHViYi95anZoV0NnaEVKYnFyVFl6ZjI3TVZPeFRUK3dJZksw?=
 =?utf-8?B?aUdHRUN2S1hPV1JMbmV1WWtNMnFzdlBsTEt1dWJvYlFySnhKeTd0Zk9wTmZ0?=
 =?utf-8?B?aDVCVmNBaHZicThyWmNaaS9RQzhKUWV3WXIrcWcwdE0xWHFiNmZINjRyZEpW?=
 =?utf-8?B?eC9Hak5RdjYyN1RWWDhzdTBEQUlBaXRFNEJtajhRRFQ2bjVTVnB0djBvdENU?=
 =?utf-8?B?SmVtRGU1c2piU1NVbWxUR2oyWEt3SVhKU24xWUpmRHJ0MkdkeVRoako4dzMr?=
 =?utf-8?B?MHcweVdBOFhNUDE3N0gyM3pNVXRXcU5yenU2L1ZiQ2FQMTE4bXliTXU5ZVV0?=
 =?utf-8?B?K1BVR0NJUXhGajBtejZUdStnL2RLN2lsdFF1bW9vOTc4N0VDOHA0SzEyWlRD?=
 =?utf-8?B?ZkZlZElKbFZJbEwxaWZ4ejFhZGMxSDJlcW9iSk0va0RrVkJKVjM3azY2enpn?=
 =?utf-8?B?OGQxZ280VjNkYkhha1BRUmpjWTR2cFJzOHFRL2htMkpjUTN4b2YyanQ1U0pu?=
 =?utf-8?B?QmY5VVlCRGFHbHhsMVRmRHkxUkx4R3dhN0FYTDJZRXNxbjFRdG1qK3VSQXB3?=
 =?utf-8?B?UHp2UCtKR1BVVnFjdzNYWHpiS0JRRDJZU3RYVS9DTW9pM1NCaWx0a3FyamVw?=
 =?utf-8?B?VFVzRisvRlY4c3phSWsvemFpcDFRdEdTQzZ4bjBVNGdPZ3loeSthYm15ZERz?=
 =?utf-8?B?MWRXTy9SNWM1Mm91MFZkS2M2clVEdGJKVC9zN0wxbHJRaldZc3orZVhHeTlS?=
 =?utf-8?B?RGFaeW02cy8wZ0RVVE9Qb3lFbk9iM1dUMzdqQWFiSzlSQnRyVlRCMmxvbGM2?=
 =?utf-8?B?QzE2WE1mdjU3b1dSdGZzQ3R0SVY3b0xxNHFjU3Z3R1g5czlib3p4MGFLaTRz?=
 =?utf-8?B?Njlkd2l3TTErVnlWZEk0R0xrL0c4NzlFSCt3Zk5WOVdBdFBZT1ViVlQzejBq?=
 =?utf-8?B?WWlMaWVHY0R0VWhDZ3crZkRndnF5V0hRUEhGSFdNZVZKVFRMdTlQeHJjNCtG?=
 =?utf-8?B?WHRXSUxrNTBtS2doL1ovYWZ2OGEzblI1d3ZpYUFhMVcrdzdhMENKK1ZqNzNm?=
 =?utf-8?B?alk0S3dVcUxBQ0ZrUkJaZEVEaDN0MXN4U1YxQlZDcHp4M3dwa21PS3kxV0s4?=
 =?utf-8?B?T09kTmlTMTJteFI2bFBUMjV1QUFkL0xLUmczMXVvNlNlZGQ1TTJyM2kxSUQr?=
 =?utf-8?B?cEdJRVNGalBFcUEvQzUrVUI2SklZcW1pTFRJdmYrYzlBdmpvTDVnMU52Q3VY?=
 =?utf-8?B?RllMQ2RyVXJjcEs3bVlJRDlvZW02WEZXYzVEc2g3M1dkYkFJVXl5bFdPRUUv?=
 =?utf-8?B?R2kxSGlTcE1JT2xDODR5eFIxV3JYMXZDbzhvOWhJcWJlWFFuR0Mxa2JtQUsy?=
 =?utf-8?B?MjBKRXppMFBaSTJwekl6U3h6RVRnSEl2SDVlMmo2L1E1dnFvd21TaGFpb05T?=
 =?utf-8?B?ZXRvLzNCMUY4bVhGeWo0NFZLTmVoYWY3TW96eHRQdXI0NUZGZVo1VFF5dG1p?=
 =?utf-8?B?czVseDcyaXVMMVZsLzBpZkxnemZDKy9wQkZaTTMvYit5SWhDblBjeUFkQ2Vs?=
 =?utf-8?B?OVVNOCtaTGxxNjU1aVcrTHY3NUV3NlBHUFJ3TzRXZjU5UUM1aDJ1TWNCZDJK?=
 =?utf-8?B?VFF5OUM1ajQrT0M4Mm9NK1R3NWp1U1Y5a3BJeFFiUEZ4R3NlQ29rSElMbVo3?=
 =?utf-8?B?WVlPS1MzMituMTV0OEhOb1FIeFlrU0dXSHUwWlhSSUVzc0VPclU3VFpEY0h0?=
 =?utf-8?B?aUQ0cTBpeGd5cmxhRVl2djI5eWRENXNhWWpOWml3VVA1c1p0SkFVcVVST1VL?=
 =?utf-8?B?akdtWkdqeTFPTjZFL2NzdWlQRVQ2S1hZR0paSDVvRHJUY0wzNVA5bUs4YzBh?=
 =?utf-8?B?bCtTYktWbThCZUZaOXBnNnlza0Uwa2Rqa0I3ZFA4NU9MZ2lJNFpKVmZjSHdh?=
 =?utf-8?B?ZFN6NGQ4SFErUmtHZVgyUTZhZU5yM0d6WStadDBXSEozTTAzTUIrQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0bf49f-26d7-4635-d518-08df3b2c00be
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:00:28.8280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb2IanMx25Oq/oYsWmgij1b6282jHLGf5iikZvRX1xB7CgdLUJvZ9g4jjUc/XOd/KQMTEGMtUaJWnn0i96xbuKLGrOjmEpk0vDWfMwOlUi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11981
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ralph,

First, thanks for following up with the discussion we had on IRC, much 
appreciated!

On 11/4/26 8:48 PM, Ralph Siemsen wrote:
> Related patches can be grouped into a "patch series". Add some tips on
> how to decide how much belongs into a "patch series".
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> Reviewed-by: E Shattow <e@freeshell.de>
> --
> Changes for v2:
> - small wording changes to help non-native English speakers
> - add R-b
> 
> Link to v1:
> https://patch.msgid.link/20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org
> 
> ---
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
> To: u-boot@lists.u-boot-project.org
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   doc/develop/sending_patches.rst | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index b4f82eb18e1..92bb2e203b8 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -184,6 +184,38 @@ General Patch Submission Rules
>     cases, you did something wrong if your patch exceeds this limit. Think again
>     if you should not split it into separate logical parts.
>   
> +Tips for creating patch series
> +------------------------------
> +
> +A series of related patches can be sent as a "patch series", as described
> +above. Individual patches should be small and self contained. Likewise,
> +this also applies to each "patch series". Keep the following in mind:
> +
> +* large series are harder to review. Maintainers are busy and may postpone
> +  large reviews, whereas smaller reviews are more easily accommodated.
> +
> +* tools like ``b4`` and ``patman`` will collect reviewers for each patch,
> +  but then send the entire series to all reviewers found. This is not ideal
> +  since it floods maintainers with patches they might not care about.
> +
> +A better approach is to break up a large series into smaller sub-series,
> +for example by subsystem (clock, pinctrl, reset, etc.). This allows better
> +targeting of only the relevant reviewers for each sub-series.
> +
> +Of course there are sometimes cases where a large patch series is okay:
> +
> +* when the changes are all in a specific area: for example when fixing a bug
> +  in a driver, but also doing some refactoring or cleanup in the same code
> +

issue: This is typically the things we don't want to see I believe. 
Separate bugs from refactoring, cleanup, and new features. The argument 
is: we want the bug to be fixed as soon as possible, but we *reaaaaally* 
like to merge full series at once, so having this kind of changes mixed 
in a series means it's likely we'll either ask the contributor to split 
the series, or if the non-bug-fixing part of the series is controversial 
or not in a good state yet, unnecessarily postpone the merging of the 
bug fix.

> +* when there are unavoidable dependencies between patches: keeping them
> +  together avoids having to explain how multiple series are dependent
> +

thought: People usually struggle to detect the *actual* dependencies and 
are usually leaning too much on "I need those two drivers to be merged 
for the board to work" for example. We've seen this more recently with a 
full SoC bring-up being sent as one series. Yes, the SoC is unusable 
without all the minimally required drivers, but each individual driver 
can and should be sent a separate series. I'm not sure how we can word 
this better, maybe providing a real-life example would be nice. This can 
always be improved later on, so not a blocker.

With the issue in the previous paragraph fixed, I think this is a good 
improvement and we should merge as soon as possible.

Cheers,
Quentin
