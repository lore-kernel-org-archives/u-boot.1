Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D47BCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 13:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A630083211;
	Mon, 22 Sep 2025 15:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mCeq6zBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE916832F9; Mon, 22 Sep 2025 15:48:23 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E1A82CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 15:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqdppj4i4poLgS/G6xlFilWeig4Zb7OJmX6ZimYfOfnBdAx4+gyiUFgWSb3hub56CDzIsx0UVX1XU4pLW5l1wo0SjGVQXbWnBkSTz0XWGuK6eULWQtlbSqzuqI9oP+Pp1i1ErUqXrixc1/CrzWxavuWlrAEMNaEJgPQ5W0KBiXX1t0YqgiGxxq8Z+nGJj+N9WC+IlRWfsttKENO3r/mCyrA4GBZKy8j4d8yKegvgj6TCOokMxoSRZkji3nB1ajY7jTDvImtXxa3sMGu2FmVYM6bvQMSJ3uzeNP/DITdQSh/QbcefkV3VYmP3448XIVgEJA2zgmVErnMe8rxZ8Gzgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60eUO0B4LhU+F2FVSIPVSRpuD2nXYt8MqM+oa+KbuVw=;
 b=RKQOLZc0pLbYJYypadv1edgJYw9S7qznInCa7zapsrkQK/QAW/qYuDq9RTohBhhoAywV3wMntrUI0EXbM8q50hwXsMZGlmg0D7A3mLsABDQFCvuEGfHQdojemqiwjceE12sVlmO1FEv7LFifjSPcOjd6OuHqs2rRVQkooXUjPHmt7Z7wYw3DhTe6qLGxdNPHVForKvpP1vElqN76DzUfnt3g7G751FuRGfBA8E9cfiIIjv7P5b6cOW9rZXAhyecihVfaZFJiVClVknz3+cQrdGRg1CIGkyWNUc1hSU3Cz4L1lWmyrcqoBaSr8lo1/eHf968TUkr1yLXv9jR4EXdUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60eUO0B4LhU+F2FVSIPVSRpuD2nXYt8MqM+oa+KbuVw=;
 b=mCeq6zBx3vV+7Rao0Z8czzNlvEp2WKmN1yha8Q5sA9efhMwRYTNZOH/tzhDl1hPSqILKkwScsGRTqYnK/GYcYAN+DcHhbAKnCJic4ikoEsdSLgTh6pfHB14vTbmH4FWMp3/GH2A8q0JLPzpB6Iptb0W1Zk5lBKN2nRiCHFykZxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 13:48:19 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 13:48:19 +0000
Message-ID: <16770e65-e68a-4709-a1ac-cce1aa0c319a@cherry.de>
Date: Mon, 22 Sep 2025 15:48:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix RMII help text
To: yegorslists@googlemail.com, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com
References: <20250922133229.4180942-1-yegorslists@googlemail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250922133229.4180942-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 45df3291-0176-49a8-bdde-08ddf9deaff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NldxK25XT3lvaU83RUpwRFRFTkxlN2pzbjBJQkppaHFna050SG9TdHF0Y0xZ?=
 =?utf-8?B?SGFlcnJCZFpYYWZHZ1V2L3V3K3M5OStlM0Z1MEJCOHZnZ3JYUjJXQmhCZU9K?=
 =?utf-8?B?QnRzUVNORUVVN3Y0WkNlSWpUVGFRQy9yUXFEYisrakxwSDFTUEFxd2g4c1FL?=
 =?utf-8?B?cFpVcmZmY0dJNWQxVFplRkNxWWUwUks0UlUraVE4QzhvWmhrRm40RldKQ21M?=
 =?utf-8?B?enBYT0k5Rm9BajJzMXhnZGRmT3p2dzBuNnBYMmttRXlzQnFCcjdmQ2lWUVNU?=
 =?utf-8?B?bDZnYUNMa1NzeUxMSVE0ZUVUdU15alBmeXh4RE5leU9UaW9FQU94bzJoaG0z?=
 =?utf-8?B?SUhVbDVtSlAwQzZEaDd2RlBKSE90VXFIb3JFUFNoVnR5Rk1Xd3dCTWhpc1Ns?=
 =?utf-8?B?YldjNVVKSkpCRjJFeUt5QTUvYkowQ1NwTUV3cGlMeDJ4cmErOUg0YlIvYXVP?=
 =?utf-8?B?b3VJZGhTOXdLR1RVWGc2bTZRa3lMUjltMnBNUXN3TEVrem9lWTZwTDhTaUV2?=
 =?utf-8?B?c2lHZHlKRjdQWnRmZ0U1MnpqN1FTT2ZEZy9LN01JeDNOMHlSWnFqRWQxeVBi?=
 =?utf-8?B?Y2xIN3UxSFdjbXh2ZXRTd1VrTjByTU82dkg4THB4Z0FnV01PS1lnYVdCVXJp?=
 =?utf-8?B?YkwxR3BtRFlBQ0IySWJhN214YVhQbVNxUklXY1VPeTZVQXVIVkVWUHhqd0dV?=
 =?utf-8?B?cUo5Yk1Lam9penNiWElvL3ZTYUw1cVZIVGtGY1BqZDRlalNrUnpSNW9LNnFD?=
 =?utf-8?B?aUU2UnY1Tnl2T2VLNFNEeUQ1YmdxMXBYWjNTVy9xNVE5TkNEUjRxZWJubFMy?=
 =?utf-8?B?cTJRdjlzb3ZTcW1GaDdyazFpZGF6WkxKN0NYUlprTVFscTNiKzg5bE1Zdlgx?=
 =?utf-8?B?Y3NuWER6a0QzUmVxTmFMRS9iWGJaTVE1TzFKOWJFOG10UjJYQ3h6N29vMndz?=
 =?utf-8?B?dURtWUovdW40RldmSzZVMWwvM2xTeTV1aHNqME9acTFtTDhmZnJVOVYySzEw?=
 =?utf-8?B?bWYyT0FZLy9mWmcvM0dNbHQraCtjY3cvV1ljMFI2eUJHWWxRRHJJU3VJL1hx?=
 =?utf-8?B?K2dQb0dIY0M0SXZhMGtuV1hna1YydG8za05ETHIyYmd5djVERSs3NjRzZktJ?=
 =?utf-8?B?VDVENU1pYTQ1b1BLQUFudGhRejBhd2lPQ2MxOHorUVd1WG4rQkJ4SUhDTXBY?=
 =?utf-8?B?WXRQMGkzQVZNUUExbTNQdWtsamZ3bFZvNFB2M2JyV3V1RDBLcmlUMjhPTUdF?=
 =?utf-8?B?VkRaYTlSV01nMGJnMi9WZnJ1Q2V3OVh3RWZscWYrUmgvbk5vNy90LzFEeFZn?=
 =?utf-8?B?QmpMeSs0b3M4alkxdFUvbGEvcG5OZ3dvQmZMUWtPZUNjdVhFZHBpQll6WVpF?=
 =?utf-8?B?Nm5Qa0hRMXk1L0QrZEVGbXNiT2ZPcWdBS3RTYVlXcG5PeVNqUW1WYS93NENa?=
 =?utf-8?B?KzJLMVRqL1RZWnRocVZyVWJFL2FNeXRWdm9XT0lrbkszVWFadGxNY2RQbmxO?=
 =?utf-8?B?MksxR29CV3l5cDhLK1BWT1F0MmdYbUp6K20vdmVHb2NRVWl4QU5QYTVldzE5?=
 =?utf-8?B?bk1PNmxUaTJXOXJVOS9lVmdpMGJObkpmdndjTXVTZ1BDMlNhcVNCQkpBSFFP?=
 =?utf-8?B?TEwvWGlKUGdEWHowQ1d4MDc3TWhqNnh4NmVwaHRSRE93NTJpWUNiOUdmNE96?=
 =?utf-8?B?dnpKV2lVd0V2SW9jMjBtL215WVZzRGoySjd5SE93cjdnWUdQYlRDQUJoL3da?=
 =?utf-8?B?UkdDS3p4MFZ0REZ0TlRKdGU5b1ROeDYrUXczOVkxSFJhOTVEbTJPSWRpcWZp?=
 =?utf-8?B?dG9OTlRQNVBpQ3ZMZWRRSXhmVzRDKzBDaVJ1aVZlQ25LMk9HeG1GZWFJL1hr?=
 =?utf-8?B?NXhXcitsTThCQTZiVE1wZjZLbFJqTjJ3RDV6VUc2eE9GUlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0J2WVEvekdJS1hnaURJb2lVM2drY3IydnlRUWFxQ1VpSjZNRGhHY083QklJ?=
 =?utf-8?B?OEswRTBHd2lLK0hNdjREZ3VnQ1VqUktIcldwNElKYWJEQ0tSZkVFblFPWmhT?=
 =?utf-8?B?b3RwdWtBeUhFbTJGRzZyWFFEaStoSmR4T3hQTHFVbWt5Q0I2ZExmQ3cxWCtP?=
 =?utf-8?B?QzFFRFYvdUNiQVIrT1RwclhWbS9RZ1FiMk54cWw4eWJpTWR1Q3VuN09KUkZI?=
 =?utf-8?B?NnpBV2lKem5oRDFUYVd1WXNucjZDSnVMRzlCQXRwamhJY01CSUlnamIreVFt?=
 =?utf-8?B?bVhRY205TDJWRjVlN3lSVEIrVnBpSitZamkxVnI5WVVUMzQwYUFZNjQrdVgv?=
 =?utf-8?B?SjNvSDdaemdZQTRrb2d6a1d1RTNpR3BobE8yV1h1U1JwMnA2T3c2dkZrdS9a?=
 =?utf-8?B?c2xmemxFVVoxbGZSNEdXeWJlWWlqQjF2akdIem9hdE02aFVFNjFta0xPWHY2?=
 =?utf-8?B?MWt0RmgzbUJ0Sjl3MjFDbmREWW1yZ2dqL05WQ0cvbVZWSHVWWTF1QWgzK2J3?=
 =?utf-8?B?TGNTQjJMU3RrbkE1NEtlRmdIb3ZkZHg0aTFXM08wT2JGSk42YzIrTys2WExn?=
 =?utf-8?B?djV0LzVBVVM1TXNJeXZCek4rNTRNVHhHcXRZN0hEV1ZwTjdDcStYZDFmOFdB?=
 =?utf-8?B?QURHTDFxTTlTUjlrM0wyMmI0R2ZucmMxdFlpWWJsaExCVHdKa1dkdVpDOGNk?=
 =?utf-8?B?YS9kVWxjVk00QmhZOEFYSGJRN2krRmFrYmgvMXBERllCWnJhNlE1dU5TSlNY?=
 =?utf-8?B?VnlhT3ZMdktuSVBEY1plZ28xMmlLSURXcER3TTA2Z0ZSZkZtQkozTHF2U3hy?=
 =?utf-8?B?aUhEbU9VVlFXQ1FxNHRYS1VVUjNaeGZ0VDZ2TXNGclJlYzNpNVNyZ1F5WHdL?=
 =?utf-8?B?YzlDdWI2ZzlTT21nUU9hOU9UWmxPd01wZE80YnYxVUtYT1lUd1dZb1lVallz?=
 =?utf-8?B?djZvVzN6TTUxWVh6WFI5RDJpYnhqeXBvTlBxWkRGK2c4QXJHMjdyVWF4ZU50?=
 =?utf-8?B?RzlRM2xYYWMwN3dmRUp2Q0JDOXQ3eWFvZnVRTk5mbGZuY0xoVzhlbjBITXJa?=
 =?utf-8?B?dXV2Q1ROdDZMV2dvV3M5S01xaXRiU29oZVA4NVhYTVYwa3lycGZhSDBCb3lj?=
 =?utf-8?B?ZEJQRDN6KzZSRWdYcVZlbkRGQU43RjJSOUxESllGL0Y5ZTZZV3N5ZWhoMlVr?=
 =?utf-8?B?dElOSjZLVkdib1JvaDd4UktLeENkTGNYVy9LWjNZWks0SXExZ0QwWHZGK0ZF?=
 =?utf-8?B?enpEenhOMWZXWGp4YVZZbTAxa0Y5dDB0LzhPTGpMNHA1NXBtWTBoVW5yTSt2?=
 =?utf-8?B?VWxlV0toUWQ3aDNUT01XZ2dzS3E1dXNjbnJnWVNRUDZ5VGJ0QThROEVZZGVX?=
 =?utf-8?B?UnYzMWZFMSs0ekN5c05zcEJHWWxSTTlhaVVHcFdxbFZ3aWVYamhLWWdCKy94?=
 =?utf-8?B?UEpqT3JhWDlPRWxudGI5RklkaUdhNGdFb0ZrTXpzTnB3dXJmNDFYd2M5ZzdO?=
 =?utf-8?B?QnFBalg0cU9NUHdZcVRXRjg5MzdGeDZJR0xsRGVYRXlNK2JJcUpYWklzbVY0?=
 =?utf-8?B?bW93c3BCV1dZcnprRnR6Q205em1HTTdMUFFaNWl5SUUyUFVhRGFCaEdZZnhS?=
 =?utf-8?B?czc2SjRqNkJpdWwza3RBbDV1eEFtYnl6SG9Hc3lyZG4zOER0WDlPUHlLT3Nl?=
 =?utf-8?B?ZnJBTktNZlp5RkJMNVNmM2p3a3VmVEVEeGZFWG5JWCtqc2tRc212a3ZYRDQw?=
 =?utf-8?B?cW8wd3RwbUJwVjBhRTcxS0JaY09sU3NHeERqNlR2N3V1aDFKdmNMU0lGZ081?=
 =?utf-8?B?WG1hZmNaODZoWHg3eW1qcFVUNE1TdGJtQnY5TmR3UUQxL0lvK29QYWhMN2Fq?=
 =?utf-8?B?R2JiaGh4ZzVDcy94M2hkaUcvTE1tY2ZkalJVaGJqY2E1a2o2UUV3cTNWYVds?=
 =?utf-8?B?V25HeFRGQmZFaFhqVHB3U1FFaHM0b09OQmlLdnZVd1BVa25yL25pUzkrUW5q?=
 =?utf-8?B?by9udEwzbkg0bkl2SVVtT3QzYVdpaVEwNWNWSEZJN1krMlY1cndXSXJJVzcy?=
 =?utf-8?B?UVlsMzdyY2tQb1NVbGNkWllOKzR4cGN4ZFpiNktORW1KT1Z5QXkwNmtTTmtI?=
 =?utf-8?B?SEJFTXBOVjhVK1NBaW5YSVJUQi9Fb3hqalAvTnh6QVdSanpzRzFaQlZtQ0ww?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 45df3291-0176-49a8-bdde-08ddf9deaff9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:48:18.9327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: an73pqMpWLl3LAvY4xazgmS/rH6ZbunqSSxyyvP28Y2HE1vZJIlFwybqc9atOlz7QQBLOKhrcqFNW9/MwxHj2Wh9CrKbk+2fnazEJS6PXIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013
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

Hi Yegor,

On 9/22/25 3:32 PM, yegorslists@googlemail.com wrote:
> [You don't often get email from yegorslists@googlemail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Replace MII with RMII as it is a Reduced Media-Independent Interface.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
