Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDD7CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 09:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C43B84843;
	Wed, 10 Jun 2026 11:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LA1ZWQfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C63484874; Wed, 10 Jun 2026 11:38:04 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B005B807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 11:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+3bcY8YKmgNGPFwVMFZZ/hsUz2yl/m3aECrIKeCsHnHsyp+EJHC9xdQe3i+G+L8c5oTMYs0b+rQZYfmuCxk4AYOfvq3ktI4aKsoJg5PbzicTcJIgKAtWUat7cs2dKAiOTNfR6YOTJQVIkvDm9teSe3ePYk4sX8dh+9cokFIwWzBdMCX7/oxtOJyXqPTRq0MGXQuAnI9YoGOcc+fLSPTDAGCCMnlibE/c5XD2qayfzRXeCiCUS7IDCWWa7Y1cUWeMz2YxTCl3GP2TQK8L5MH/AijHq2ndc3kOEH/wYnIYUMaIAZ9nE8gKMBaVErSQlFPq8JRSVJXNOL95IyaWIc3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqa5kwGQF/QRMAsOHVOHoKLNgSUZOenCDiHZ/JXHCUE=;
 b=F7WJNalC4XAuJRoAYJoyXjFuL0ywhp5Bu8zca3geYTVy1ccvvwsrrhMbI3BvjaiAVihVxxGFAthkDGejp418gke2YMelqDdh9lcBqoBWT8oCgwi4FCbjA33Glxoe65VHgmH7DkC64wvQV6bo7ZO2A5THa41PdHtbzUIqe7ac3XdwpWdnAJiezVrwU9G4IcqSHsdiV/Iv8s3SifE8j99fpUomd0rZAHAQZ97uh24CiF+SXmhBD8AYgHBpLsrcUuAy/mS/db2heYvdOsc1RkLM8PQBN6vn11vnErVL2A5KgXFfUmwpQT4SXiFlEDLRpka05XE2zBHiBWWY4nG/BfSXBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqa5kwGQF/QRMAsOHVOHoKLNgSUZOenCDiHZ/JXHCUE=;
 b=LA1ZWQfNP1lVipyP1zbutgvldC61311ZoXgmg5tpdv8N/l9duQb6ifS1bi6/AUB1fbN/9DaGQYdJEMrRvuXRDorR0kdk17nDQ0c8raSvnuOY86dFhTMJQtYk4MCiHRiUuTma221CCsJkPTiA0sfjhURMayHzHmcYhkIkry1Pelc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAXPR04MB9374.eurprd04.prod.outlook.com (2603:10a6:102:2b4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:37:57 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Wed, 10 Jun 2026
 09:37:57 +0000
Message-ID: <d750d3a9-d69a-429a-a5ab-046a4542af0e@cherry.de>
Date: Wed, 10 Jun 2026 11:37:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
To: Daniel Palmer <daniel@thingy.jp>
Cc: Tom Rini <trini@konsulko.com>, sjg@chromium.org, u-boot@lists.denx.de
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
 <20260608140454.GH382693@bill-the-cat>
 <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
 <CAFr9PXn2j1B6WxRdPFabHJg7Ym5KJYgDQTJ16A0uN7Tz-Ot+Vw@mail.gmail.com>
 <364e247b-7cff-4711-9d1a-2a1c9b6544f9@cherry.de>
 <CAFr9PXk+k2yhuxTiZGJ-m7+pAb-rUpGRfrFgTHJzpaOxmgg-xg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFr9PXk+k2yhuxTiZGJ-m7+pAb-rUpGRfrFgTHJzpaOxmgg-xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::13) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAXPR04MB9374:EE_
X-MS-Office365-Filtering-Correlation-Id: b23ad2f9-2a53-42ee-48df-08dec6d3f471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|5023799004|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GbjLg4AL+zcKnXLidsiYZ8228DDwriE52+xtLGy5m9cj1YCTHZ6pCxmRXHXd4RQipahMhx0JTN5MsHWE/BGHj8NpZgeFhZbZx13oJmlXH62OdhFkZeeY9ISTI8oeIh+B7pfFntMdLIltUCeeTp6v7jv1OuxO0UBpBiZnK/qK+vPH+cJ8jnLsIiFfyC4ilM6wW4OESTN4Zf+h/YSaLcUQhpUoBs0mMF+JL+KXz7hNy+YNAuZdAkkezbE8/eXFXen1cBGa42oBE+0BEYe8ZDkXe3m8WjF0EwdN17sPALa1wTAaGlz5aB9+kRxoDayQzvilLDigfyJxy3n7hQ/NYUeVin5/eNKzqdIKnGOagtQhFJDkMliLNnBTwIpyS+nhtu/K20JFK46Gxa0Bh63jkUT6t7/y/Mj1JABir0PI8AqN7O+u/XNAQhLp9Dwz+qV0hW7lvm1mHphyOrrrP+DweEWbcrUlQbj3L/jBhT440UK6HFkjoIht0nvMQC9sZ9m/PukJAxBW2KrAYBTBtvBHXunbQcmIi7aYlfh9EPqZPMijGAPwaeSMqZnunh7SvBSQaudB+0LLBz4pSAsJq+y911VIfJ5370p0PCkf90EVpXAc08FTiqaWnek9BCUjufHRpvArLIumJ8SPBkVzo92wWpBOm/sHSWxjvLCPDT4PbT2r8PPkKDNn02uyAYWvZzPyJZKtNRk8K0BIUIw8zcNJ+KgyIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2VMMFZFUDlpWHVsWE1tWTkzMUtzR3lBc09SRmJSRldTSE5NM2JTRmQ5T1FK?=
 =?utf-8?B?aUpMTDJoQ0lVZVkwT0dCdEtMOEtHemJMSERnZnFTQmIvTzdNR2VHU0Y1RlFl?=
 =?utf-8?B?RlZrbERHUWRvbVM1KzBTRUNWTjFwMnhmR042ckJnK2ZxQ1lvaVF6eFVTandS?=
 =?utf-8?B?QTM3Y1Y1VG14a2x3N0xqaUZZNVgwWVJVZ1hVN2Y4NkwzNEJ6ZVBvS250QWt3?=
 =?utf-8?B?akQwNnZSeUdxRDVPakp2WU5MendVT1lrdFM1OUFWNzYwNmpvVEpITEMzNVlR?=
 =?utf-8?B?NTZlZkxEb0w3TTJkZElIUFhEc0hSMnlML0FrRWtEUDVxcjR3UFJvR3cyc1hq?=
 =?utf-8?B?azdrbHk4eStnVGM1V3pWTUpKSXQyOXhmTWV4dmYwenNFNTFOU0JlT3VIMnpr?=
 =?utf-8?B?dG5nRnFSUUxoQlBvRlRoTEV0eEEvN3ZWZjQ0RGVjMUxTakM0dUFhY0tHV0xK?=
 =?utf-8?B?UERrNmR0SXpORU00TXFXWTFVQU9INi8vR3pTbmJiQ05Sb1hyRSs4SFhIMit4?=
 =?utf-8?B?NFViWHNSQmVwdUxnRW9WOFpPUWR2aCt3K3d5Rzl6eUxMUnFGS29EcVowdlhr?=
 =?utf-8?B?a1pTUzdxdUxaT2pWOUVCa1hhNXRZdDBRU3ZxTmJWOWRaS1MxZEFRMTVBMzRQ?=
 =?utf-8?B?bjN1cXFRS1JTOUFUN1l4YlUxcy80ZEZSczVmTTA2ZDJYeGVtaHZ0OHJObnpw?=
 =?utf-8?B?aVRwdnhQSHlXaUFQT3d5TmhkSGgxd0tIQ2NzVTdFaVBORHlWRUhGMnN4RGs1?=
 =?utf-8?B?aDI3bnZ5TVJUcGpocUlyYlRjWS9wWDFKK3N3OGZWaUZTUjROdlZBbmdSMjFQ?=
 =?utf-8?B?MUVJYks0OGI2T3QwdlJKZERjcXpZdW9EVXIxQTB6YTJpME5wdytEZkd1OHNV?=
 =?utf-8?B?NlVqQ1ZKOGxnUTIwbnhQcFhST1NvaEh3ekhqUDVzcG9UZE85QW96RG90c1Vq?=
 =?utf-8?B?dUtxdVhyaUhEZk1GMldKV3M4Vi9HRldjVis4eFBEeitGMEc4YThKbVpOcFFJ?=
 =?utf-8?B?ZDNpeEFXd1RDRGVjMitmZU5ZQkUxbVZsY0tOTUJSZ2swRkQ3M1BaSFkwT0NG?=
 =?utf-8?B?LzVmQ1B6cWM2VExML1FoUWFWMHIwMnU0UUpoK2wxSVRrSGZFbVZqSWpCT210?=
 =?utf-8?B?T2Y4cURYUTZwUEtWSTd6MmpseTRDOFRGRDJJMVFTeFFWOUNhbnpMZzVnSmRD?=
 =?utf-8?B?Sk9rR0dKVWtVYmkrTXM1cFltTnRIVVhFZWUvVmhhaFpZYis4ZlhmYTRoZlhG?=
 =?utf-8?B?NnNBQmZXVE50UWgwWmRnUDBVOEdpOWxIaTc5Z2RtdXpmb0FRMUc5YW1RbGlt?=
 =?utf-8?B?MXJaZ1hVRkFIMWpOc0NKWU5qM2JRSnNxdEhUK0FVRjV4c1hyKzhHRFJLSnly?=
 =?utf-8?B?TjJXK2Q1OWZnaHBJVm1xZWVob1VlMDJzcHM4VUZBY3FpdVdjam4zaUZJYzhP?=
 =?utf-8?B?N0ZOeWlaMWpEeWlCWEJydVQvZVNQd0h5NVovWXJKVDR3L3JiZmRLZXh0dlo1?=
 =?utf-8?B?OEVWdkViTlJBaHBVVDhiV0FWMUxoZHVOVEdoc2JlWUt4U1B3Q0dTV2ZYNFp5?=
 =?utf-8?B?WGUrRXRZYWx0cnkzekorTFU5dCtzaUtLVHJjYWJSOU1ZMmpwbzViTGJoYVJr?=
 =?utf-8?B?cmxhZEZUSXlxYlh0UktaWFZCWktpbWl4K2t1aEhlVEkwdXFGbGtOMXdoMDJM?=
 =?utf-8?B?Vk5ONUdTTGtUMlkwOVRKTkdJQzNzLzJ1M0ZJejBXWHhabkd4RXZGbUxqODBu?=
 =?utf-8?B?blY2YVBwck9EZHVKVFI0TzhwYVQzMzJuY0xQSkRGcCtEa29CZ2dLZUVwNExs?=
 =?utf-8?B?YjEvYnhHL0gweXhCMUp0MlgzMjM2N3EvUkNSNWFzQUxET1dubVVRemUyK0hG?=
 =?utf-8?B?MUZ2OS9Pa0I5eG9OakZtTVlocWtKQ1RsTnJsUnI5VG1FV1lRcTB2aEk1MEZ0?=
 =?utf-8?B?YXZnMktLRHkxRERnK2FjVGp1aVNnT0Ryd1dmR0tpZXkwNHVYZmtCU3hVYkpT?=
 =?utf-8?B?VkdrU2NTNlcrdk4wV1lWZys1c2lVcDhYU2xzTlZIZE9SQzVCRlFMbkp4Kzc4?=
 =?utf-8?B?dE5tbXVhVHErNW80L3g5RXQvOXZ4SmJOK3lINDI0c2x0QUxwTE84QlFFN2RJ?=
 =?utf-8?B?Q041RTBGWlloendZZHYrY3Nad3N4aC9jbDVuTHhpb0ZOc2hKeEpBVGh2d1ox?=
 =?utf-8?B?Z2VWNGlOVlY0UkQzeVRLdEJ4cHBKTVJLcmUyVklXNUl0Y2JTQUFSZ0Y1THNB?=
 =?utf-8?B?anhhaGNuVDNDSFQ0NGxGNVRUb210ZUliVmdpQ09BcWlGU05LL3ltS050ME1E?=
 =?utf-8?B?RHJBWStEaEFEbGJ1OWZMcmFieE4yWkRGVEhIKy9HWUxSeTZoNkx3QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b23ad2f9-2a53-42ee-48df-08dec6d3f471
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:37:57.5505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ik4JpAvWew8DNd4431UjVBWJEecvKKpi27F+qTnWCWwFC/b6FQ4rWai6hqQEiQw6Rv3H8l5CzA5qdD65ByXYqSeJ3aGAqqxclWbPTeDagw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9374
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

Hi Daniel,

On 6/10/26 10:59 AM, Daniel Palmer wrote:
> Hi Quentin,
> 
> On Wed, 10 Jun 2026 at 17:47, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>> I'm fine fixing what needs to be fixed now and improvements later on.
> 
> Ok, I'll wait for if/when Tom replies and maybe send a v3 just fixes
> the main u-boot part.
> 
>> Note that we generally do not like complete rewrites in one patch but
>> rather small incremental changes (which may end up in the same result,
>> but is "more reviewable"). We don't have a maintainer for that feature,
>> though Tom is the "catch-all" maintainer, so maybe you can convince him
>> a full rewrite is ok. In any case, I'm sure we would really appreciate
>> tests (I don't think we have any from the cursory check I just made) so
>> make sure to include some (especially for the issues you encountered so
>> we don't regress!).
> 
> I haven't touched it for a long time. But from what I remember fixing
> the issues in it was basically rewriting it because of the code style
> etc being so different from the rest of u-boot.

Different code style is not an issue. I'm sure lwip and mbedtls have a 
different coding style than U-Boot, yet they are still part of it 
because we imported them and don't want to modify them too much from 
their respective upstream.

It's unclear if there's an upstream for XYZ modem. But in any case, 
different coding style isn't a sufficient reason for doing a full rewrite.

I guess it might be ok if it's incremental changes that are doing 
nothing but changing the coding style (but then, is it really worth it) 
and they are reasonably easy to review. Confidence in the patches doing 
nothing but changes the coding style would be increased if tests are 
written for the current state of the xyz modem support with the old 
coding style and making sure they still pass after the "rewrite".

> Maybe I can use AI for good and have it generate a series of patches
> from my version. I'm assuming sensible non-spam AI assisted changes
> are ok :)
> 

The current somewhat-official-but-not-written-down stance of the project 
on that topic is "don't", see 
https://lore.kernel.org/u-boot/20260520143639.GM1858239@bill-the-cat/.

There are a quite a few defconfigs which enable 
CONFIG_SPL_YMODEM_SUPPORT so we need to have a good confidence in the 
patches not breaking existing boards, and the use of AI is not really 
inspiring trust in that.

Cheers,
Quentin
