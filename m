Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF7ACD54BE
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 19:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8807286B53;
	Mon, 25 Sep 2023 21:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="EsxNY63c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBFE386B89; Mon, 25 Sep 2023 21:05:12 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::707])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BBC86B4E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0YLtqLo1toN4ydpDt2wwhMbRz6WqhML5vknMAhXwkJfs4dyGNbXuYVVeEdzb2pH9yeaj9Hy6CBSpv0u8ocCu3tLQXHXVP/utY/zqRi5jODZGMcEQhPIH5pYXKqKKk3h/VJlxdmLDy4e5LSxPTxpo4w2jUhcBX1G3Xy49asyEkmFXcSsP2sOhNEJ2gXteuhrBt9y6ki5xmqYINcYHO8osQBcQOQfEyTT8d45NZmijq7qGJf1fuHAD9M0QFKEzqGrsv6Rxx/XD7k1MdZIaWvTLWjKBM4H5IUw/mbQqGxhx7GxZhfbaAPw4N9CsHXaCkchKnRT2iMe+vtReUZ3VZ20IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+tbrQe3fniD9+HQQ8WCelVKonYWKuF5KgP/vKFBUz8=;
 b=c75RxLfbVO7JaqIBLUBzKrqG2r+EuXstKfMwcMCpms1ak9FR8TqIu0OHu7F8lXs5HVof0wOuXevCKhdTJikymujBZ4KiuYjURYwunhnSdOsLtoQWnKBVRlLcPYWD602fNTT3j18jCA8wPUg959ebEjAJ/ewM0EK/jzdZe8iqPaeeBb7E4ZupfkDOTLUbnwhYBir9IPsTZP6RiAoYSFCJVqOgENjIP81JR+iXdRRf3de9W0phmCHN+9ITNEhQJa3Aw7F1Tm6+zyr0ogHEXPDaAVffKJXJymLNQrBbVKq9j9OThxO/qE8w9GRP60J3rrvBa2gN2uKdmQNx+JsI3/iwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+tbrQe3fniD9+HQQ8WCelVKonYWKuF5KgP/vKFBUz8=;
 b=EsxNY63ckYa4eUhS+VLXBQqrS4BrNKcaNzsB8tht+KFgxBu1NCioBL/XDW1xi0FQyr21s53QLlK76A4QSYmdWMxvQuk9ZURFgF59QbndhhZzlb4xS5ofpFaVfQip504z/aeZ6WuNMH2pQtskMtem0o093R4Y/lLkgOk3ppmtRng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM7PR10MB3301.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 19:05:08 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 19:05:07 +0000
Message-ID: <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
Date: Mon, 25 Sep 2023 21:05:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Content-Language: en-US, da
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <9658c219-1de8-3bdf-3beb-0c1e2a128569@prevas.dk>
 <20230425200932.GM1134230@bill-the-cat>
 <c3c94614-9916-7316-e009-04ddbdc205bc@prevas.dk>
 <20230427162100.GE1134230@bill-the-cat>
 <20230427173113.GG1134230@bill-the-cat>
 <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230925181940.GH305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::12) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM7PR10MB3301:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c0736b-4e2c-4ec9-64b7-08dbbdfa5580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjLJ4dn2IVYuH1nttZ/GKbpjlKo+fu4/spDqIcu1BNuhLXGRlMIUY0YURs5TqARGlJzJHqD5O4z2RoIkEKCEB8R/IsK0oRXKRSE+e+s2O3vEXKBholHW11iHbgimwU8lnuvNkfUnwm7oqY1pFvSVdpFnpg8Ts+elHe7KnwvVfHw0IGe7iTClWtp51cNhRMli5nq4kdwwV6CBgDYZDF/DLohoTIBhP8zr5cSHyx1bFwxLw+8cQnk9f+4lLJIPe556/hNEaSjsied18cIe4+AE+WLxTKtAg14ljpys5L5e3ZXyftxtZlCkuCfOGCo73XTOe9nl0rv+UDVdef2P8mABkxboZYMUdOC+7lE2Sy0kQkd55K2lNcLcm34tL76HS2rXfkLEPQudebiq2COq66ohkb2uMBbkRwLg42OMUSJDIky3LW20jgHzIIjncWHGuGfwYV5qVhBAOJepcKHLQSTkghalUNW+CZZ1KHTnUcX2ozHocZS4+Kv6izVEuUz9scMXvIyFIzHKQc9O+3HLLMK1Q0jcWrtoHcrQTbG69AVZoLu80DZlZQeMfY9JGIAcxUF2a+rGrx6mzCEoTT0i6OfljKWYA3iT/gUtSaiOJnFCUNiuVn5pYGBGFhQluc3aCVzhj6R6ht5RsJI339az5RHVvdlAoIe5oN356VtOsIYVqok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(31686004)(2906002)(5660300002)(316002)(41300700001)(44832011)(8676002)(8936002)(8976002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(31696002)(6486002)(966005)(110136005)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlYK2JVaEFUM20va0NMbFlPSEVyOFdTampzZWNsaEk1RGg1TEoxVmxtTXFP?=
 =?utf-8?B?L2s3Q2JnaU5TV2lRRjFUU3k2OWhZK1l2ZloyQjdrcmNKU2p6SnVhNmM3MVpN?=
 =?utf-8?B?S2ZkSGRZNEhDdDIrN3c3bE91OFYyOGlHcWFrWFV2MVRMQ1M3bzlpZlpmSDBu?=
 =?utf-8?B?RkI4cEhwYVFwUFlLUHhMK0NSZVU0Q3RUSHl6aldDelpLenRySnhFTE41WTRD?=
 =?utf-8?B?czF6Z1dKRDFNcm5KVzh4WGRMcEJCQld1VjZETlhMb294TWNRbzduU3JUR1No?=
 =?utf-8?B?UlIzR2FJU3gyQXpaYndWSGtTVDg1K2tHRnNza01tVjRZYkt5a1VreEJwVXVX?=
 =?utf-8?B?UUJ3TklUdFlKWUJtSnlNUnM5TmdwL3lOWWYyNGxLWGM5NXJBV2daWUZQQlpt?=
 =?utf-8?B?WUdVYlc2WVJkODdwYzVuK2J3Z3lMNG1tcStwa2xyQmlnR2JaeVZjakY1NTYw?=
 =?utf-8?B?dk5ZQ1I1UWEzU1lORGN0UWxqbzRpa20zK0krQnBNWFZGMXgrVFFOTjNCT1Jn?=
 =?utf-8?B?VmxiRzJGa25NNTkrN0I2a1VROWMwNkZQaFBrTzY2RG5MVnFraXhka3BXVVFF?=
 =?utf-8?B?RjhCL1pmaDc3dDhrcTlVOEcxK0o2K3RXUTBvSk9nUXgxbW51Yk11cGJBS1Nv?=
 =?utf-8?B?RlNLdDNqdVdCTFg1am1kbWlaKzdxdEdIalhsQzRacGxoWVZnUFE5dmkvVnZz?=
 =?utf-8?B?UWlEQjBoSVlkeVJ0WGVVSW9LVHQ4VTEyN1ZSQ3Zpck1HdWw4VFJ2aTVoU3Bq?=
 =?utf-8?B?bjNkcmpOdk5OamRtS0xTSC9rTkxLZWZxZHpuWWgwTHlLTmJYWXY5TU9oMSsr?=
 =?utf-8?B?dDNjMUdqV3hjU0swMzkxRjdGaFpZMHpRNUU0WThYNDNqVmJxQ0M1a1RYdDRZ?=
 =?utf-8?B?ZTduM0ROWDMrU2d3MGRtRnVEZFV6L3JheGVXVHpyQUN1Ym5ET1Noa0FMRHY1?=
 =?utf-8?B?TmRRdk9YM1hVNnZiQ1ZjUEdhR0oxRnNUbWNibjhaeXNVWWFDNmtORTdFWUND?=
 =?utf-8?B?UENtWlM1NGt4anA2eExGbmFQZmRlSmppd2hBSGphakdqdWpZUjBDTWdmd0Ew?=
 =?utf-8?B?WWxITFdNMjdOQWZZMktSSlcxUkxUaWJEWDFYZkVoNngwTkZrc1B4TXNhSlJQ?=
 =?utf-8?B?cThOMUJVOGlYZ3pIUFZYeXJFQXl2WDN1TjJOSzgxa0FFZG1qbnkyS21XY3FT?=
 =?utf-8?B?d2E0dWtzcDg1ZFNPZU9zM0ZjSVBUTHNMS2R2RklEQ29KZXRGRk9VTDVtV1FR?=
 =?utf-8?B?SnBrV0pBR2dIYm5hdEduajNWT05ocHF0TzRNTlgrQ3dKaHU2MloyT1VESnp3?=
 =?utf-8?B?NSszMXVBWDBOM0syeTNPUWFveS95eHdnRG5BbUpiNEQxUGExMnNWRVNLMmQ3?=
 =?utf-8?B?UTRtbUpROG1RTzRCcjh3SVRxY1FabVBnMkEvSmNtQkZ5ZU5mSWlJYWRHRVZl?=
 =?utf-8?B?UEs3UlBwZFU5WFcvSU1YRlVDN1RkcWp4b2ltVXNGR3VlNDZZVHNFUjU0Qy9o?=
 =?utf-8?B?b3BvQjBGdTMxY0VjWnQ1QnJxNWRqekwrQkN4VkN0cjl6N3BKMUs4NklCMWR4?=
 =?utf-8?B?cUlFNTh5NVhtTytRWXl5RldUQTIvNnAzYmdvbHk3eTFsMU1JNUhNUThHdHVZ?=
 =?utf-8?B?ZGpSc3dyT0RkUkFrb3kwbDdYV1QzYlJVOWxTRlErUE1HejFkcWZRaGFDZ0ZI?=
 =?utf-8?B?V01sQmFhWTg4YnA0UHZvOFYwWnhBNXdyOWwyVk41Wlh6ZWRvVW1HdzArbUtp?=
 =?utf-8?B?QUdLVlVPOU50VTIwRkZobVhSZUtUak5tdWQwM1ZFdzFnZmVPNnRoU3psK3A3?=
 =?utf-8?B?eDlDclZMRDBUR3EyMkt4S1c3Wkl0RjQxRm1obHMxVFltRFF0SDNvSXc3b1pV?=
 =?utf-8?B?Tks4eWt0cC80ekgrYU9IWW5zcUhYMXlTd3Jib0YxTkJ3YXp5MUxRVkthQkdX?=
 =?utf-8?B?eUlhTElXR2wrTVhzOVU3NWd4aFRObGJkQ2ZLNHJYZS9xcnJZNUpQcTFiYVFy?=
 =?utf-8?B?NHJCOHU0Mmt1YW9ZMGxtZzc1cXRJNGdSQWoyOURNdjNwdmVsZTI5Z1hBRmxF?=
 =?utf-8?B?RjBJeTRUdm5NRXNUOWNXYUNJSkZXaG9xcXZ3YWdJRE43MUVTUmpRMU9LY0tz?=
 =?utf-8?B?ejdBNFFrQ1M2VVZZdzhtZ3hyS1pma09HNUJlZXBrZ2JnWEFlTHUwTlBwU1Fw?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c0736b-4e2c-4ec9-64b7-08dbbdfa5580
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:05:07.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbUSQp8ROqxRZ2QM0WpiG6+KLQ7zV9JvS+GBgFol+qexh981ZMrk7Zm6QcGTg5rC+/6V/z1hT6E7Qo6fzaQnvNP0wNQWbpd9w83rTuv5VoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3301
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

On 25/09/2023 20.19, Tom Rini wrote:
> On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
>> On 04/05/2023 14.35, Rasmus Villemoes wrote:
>>> On 03/05/2023 16.54, Tom Rini wrote:
>>
>>>> The one last problem now is on stm32mp15_dhcor_basic which is a
>>>> defconfig missing one from OF_LIST but including it in the its file, so
>>>> the above is the patch we need.
>>>>
>>
>> Hi Tom
>>
>> Can I persuade you to try something like
>> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a1076f9cab0005f400fa072
>> again, but leaving the .dtbo targets in there?
>>
>> I could send a patch, but it's entirely mechanical, and not really meant
>> for being applied until we know if there's more to be cleaned up.
> 
> So what ended up being the problem I think is the case Simon pointed out
> where we do take the output from "make all" and concatenate one of the
> dtbs that was generated with u-boot.img or so, and it works.  But maybe
> that should just list all of the valid DTBs that it needs in the
> defconfig to start with? I don't quite know, it was a case I hadn't
> considered at the time.
> 

Re-reading the thread, I can't see where that was mentioned.

But yes, if some boards (still) need that, and have more than one
possible .dtb, the board can't set an OF_LIST different from the default
consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
SPL_LOAD_FIT || MULTI_DTB_FIT.

How do we figure out if such boards even exist?

Rasmus

