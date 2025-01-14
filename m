Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C48EE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B55D380657;
	Tue, 14 Jan 2025 14:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bqdzO2/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3056B80703; Tue, 14 Jan 2025 14:53:53 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AACB8060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJJ+dOogB+5cwyjheoaZ5sBWSTxhzP/ycp2vSKh1gPI6yIjovtlDST2wbshdXPnVH05BvlnjhPspITJ7FpS8bycyona9bJMg+5pH5pZl5OzhbZev/PWlvtloriT3Zg5OIg1D8O7aQ6NcovQylKqUtCIdV9JLDNJ2WKlY37w6YG20ZZVzqfHIqzzS8JuJztxfoxyZdyRFd2VkFAZZ1++iC7ygqQ95hd+aMmS2ARF1IMoBHZW+hNhpw2en7Fp8ytP+WOlKRlenhQ52w/ew/MzDYwkdvEmZF86EtBArQ79pnAakcW0dGEfHgSl3fvVkE6+sXdzHromzEiXm3rUE2jrqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuqvNEGSt3BpMGztEkXy8CGHRpWsHYxRhbPAkUf0GTU=;
 b=wPCgE/o5TnArfyjB2dxknQTEHaPf8snuu/yLuJ/ArxAoJWovKOMWlvK8Y08xA9J5yC8KQZUDQbJIAgBJbVSa94hYKllwj0MwgYAoUiwUcSvszgewrrJQpsE7RwGNK/4Ao460mEN7whuQZHlYya3u5bEJV27vowKsO0uy5njgvek3OWNNSXbqAuDUkAb8/nanT6L3QQMivPVWA7TFjeF9YPR6GavF54e0ECDdNST+6XPEaxGo1QwStfiN5h/5nLMFcWeXiJw8MNRvHi3S+dqjxrjDTta8SflJzOmkGkTjW5LyVOqip8DKbLSHhvkByDFrt73HPilAOUkUTtQfHGgo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuqvNEGSt3BpMGztEkXy8CGHRpWsHYxRhbPAkUf0GTU=;
 b=bqdzO2/jQWgLP1jFtLojkQ56zYmEdEtIX85+I+pB3o0svugAUsms1DxGpMoBh/Hzg1Gc5fygVZ54jtDHRYZx0vmsj5h2NaUqo/6GYNLIILqc49o0zK9mxxBHmfNZKdB4nBdwd90ai/yRHFpIgN+XCscGyjtifxNkgsy7YntMIgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8125.eurprd04.prod.outlook.com (2603:10a6:102:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:53:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:53:49 +0000
Message-ID: <2b3e1050-7cbe-4dde-a298-5efb63cb4ebd@cherry.de>
Date: Tue, 14 Jan 2025 14:53:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] block: Remove "select BLK" from non-block drivers
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-7-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241220222612.1757884-7-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a6db0c-3e07-426d-dc14-08dd34a2df5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWZwZjRiZVVac0ZBbndtL2w2TUJvdFdwOWhpeHhPcVA0OENTUDNnd2UzQzc2?=
 =?utf-8?B?ZzdDMmZ3ejhKVTRKbzQwVWVpQ2Z2QnozSTdJcnkyejRjTm4xdUlUREIzUS9a?=
 =?utf-8?B?aHdoNHhwdUhZRThzcEt5UnhrYmRnTEYrRGZEaVVjMERpS1ZwTi95MWQvMm9l?=
 =?utf-8?B?TnZBMW9uS3NRQktKOWdvVnh2YVMvNSt6SUdUaDZHdnRSc3cydXVCM2d4Qkdo?=
 =?utf-8?B?MmszMkxRQlh6ZWhqY0x2dFNONDdHY0V0TTFxZ28wYlZFMjB4TFUzL0ZsUDBB?=
 =?utf-8?B?aFVqN3BSdXRsYmNvazdXckc5ZkJrRUlubFhWMW56TktnbFJsQUhqRmlhSzRO?=
 =?utf-8?B?Y0pLcFpyTDJkN0tTU20zelA0MmNJTURpMzROem9RWS82T1BUYnRrWHU2T3R3?=
 =?utf-8?B?b0V6eHRqazl5MXpvMVpGVGxwa0VOMi9udzlFZFlxMzA5Vmhvc0JiMm56enZu?=
 =?utf-8?B?UXU4OHBlR1dKYjVvU0RlT0Q5akRWaG5zbG9hc2cxa0tFNHJOOFZsOUQ1ZWNw?=
 =?utf-8?B?WldJN0trMzNqdHVFU1A2YU4wNkg4RTdsN1dhMFA4c1lweWlJMEMySWhtaklH?=
 =?utf-8?B?RS9JVC9hZU1GbVpIanlHU2RrUkZiUDNDNnVpUkFlc0NKNmNDcmtNMm1QYURP?=
 =?utf-8?B?d3FadHdPemVhbVZTa28vVzJrQ1FkTnJiWmxLS0lkZ0FvNExVcnV5RFljUlVu?=
 =?utf-8?B?QUMzYnFXRk1PYUtCQ3YyZUpsT3VlcmVvWEY1eHNsd0ZMZExUcTQ5djZ4YkVU?=
 =?utf-8?B?WWd1Zi9PTlJLdUMzY0R4N2FwNGF1cFBLMkYwaXdKTEduT2VYMjJLZWFCTlZr?=
 =?utf-8?B?V3RpTmtDdWJnQjc4eU1OdUVac21JMnJNOEZ4Y2k3K1N1MjBxem81cDljZUZx?=
 =?utf-8?B?S0xCcGprUUFuRU0yZmxVUjV5clFTd0NGbml2WTlaZHNpWWJ1T3VrcmRNK1B2?=
 =?utf-8?B?M2ZDc2hhNk1vWEJSZFBJdTlEalRsNEFQalQraDZUSjRRZGRvM3hjN3lHZHBv?=
 =?utf-8?B?T0xMT0treWIvQngvaDVWV3pkQzhROFc4K0tUTG1OSFZDNmwyaVBvSVVzZ2hY?=
 =?utf-8?B?N3V1VllxOVAvMEhIamNZd0FMcjFqWmgxYk80Uk1Cc3Vod2dEaUt2K1BHU1dl?=
 =?utf-8?B?a1p1dW91ekQrbVJPbGVUOUJndElreXdCV0djVGR3aGVEQzg4TVZ3QkUrbkRi?=
 =?utf-8?B?ME1EdllPLzZLbm1TNlcrUTFUY0IycGhxNngvT2d2ekRBS3VOVTdSR0RTUFFh?=
 =?utf-8?B?cEdTSU5qWi9tOUFXWW5sY3lLNXpFelFhOUI3dmZQdlNhSExFd3NUbHd6bFhP?=
 =?utf-8?B?LytyWHh6blNVNDU1cFQ1SDd2N2Q3cDlSSElTRXpvZEh4a1EwcEFheVFPNFd2?=
 =?utf-8?B?NEZsYWZVbEZ2VS81T2w1UG9XY0VWcFZaZ2xzeWZoMXFvT0JsZTFlS1JuU1ZM?=
 =?utf-8?B?eWduZ1JoWWc0Skd4Q0JSbG9YZEpEZVgxa0NlRnFBeno1T2FWOEJ5dTdMVWpK?=
 =?utf-8?B?amNIZVFNZDRqVlB2NWcyL0FEV2MvZ29QUUo1T21MR3ArL0NmTGFsc0VISlZ3?=
 =?utf-8?B?SDRzanVjYjVHL3VLWjg0OUplVVZmTUZkSFBHYWJZYlRVN1BDazZUQjBpc2Fh?=
 =?utf-8?B?ckxoOFhPZWNrSVNpR1dTU3cwV2Z0NHdxdzl0YlJIQkx2VU0weldqL3NKdkFP?=
 =?utf-8?B?SkpvUHBxYjNsWldzVzNRM2pEMS9IYjJOdENLbE9EeCs5Sk5oR0I4bFo2WTRw?=
 =?utf-8?B?MG54NHBBN3k4Z1oxVE9lVWRzZlBRa1RTTmxGcWxNZ1V2Z2JSYTJTU0ZYSWhx?=
 =?utf-8?B?Q09hU0JQZUQwSWQxemZyeTdzRi93SzUrd0FUUWp0Tjd4SkFKbHl6VEF6U0Vk?=
 =?utf-8?Q?bpaCHPvk/AFVk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGwxZ1dZdjI4WER5Rm9pcWkydFkvcFJFSHl4NUZYMWlHODd0Y3p0bkE0SDNM?=
 =?utf-8?B?bE0yTTRYVDgwTm5DL0hIUVo3SW0zaFN3WEJKUUEvVFpxOG04TlNqRkVySkpt?=
 =?utf-8?B?YmZINEFDcm9JV1VlRENJRExIZ01UbS8rZUNWSVZ0VUE0bVZnU3ZvRGRDek9Q?=
 =?utf-8?B?dzd2OEVEMDhvRVBPK29RM0VkbEtRVU00QnBXSEVBYTZ1cjdQMGFjZTNrbG1V?=
 =?utf-8?B?MzJjMkYwT2RvSEJkNklxY2t4L3VFTVJ4UmJQYkkza1RmNlZLOStub0JNM2tR?=
 =?utf-8?B?UnhRZWJVVThhK3ZXT3h0bVZlamgrRFlqRVEwaGw2MFhLM0NNbk1wME1FWGtO?=
 =?utf-8?B?VkxNRS94K0IvMW5JaHA3c0E2L2tuOVY3dmlaL0MxeEgrVW1ZdEROZkczL0px?=
 =?utf-8?B?dmxyY0lqcTdjYlAxdndqbnJXMjhHa2Q5d2svMGxUWms4cXo0MzFqV3pKczFQ?=
 =?utf-8?B?ZGlHc05KcXQzRGJOQWI0N1NiT09ORTh4bFJSMTlUTkd2TkFlT1lIckhjdmox?=
 =?utf-8?B?SHIweHluV3Qxd1FQMDkxUFNtYms4MjZ1b1JNMjYrczRrL0pxZGMvaW5ma0FI?=
 =?utf-8?B?OE5XOWQyMkFPSERLdjRBWVZrMFRZSU4rOVRYWnFjTzhtNEhNRmF0ejBsWllM?=
 =?utf-8?B?cHpxL3QzWXRDbFJPb2RVYmdkclBFY0dYSXArOWw2NnBvL0t3RXlhOGJCaFAx?=
 =?utf-8?B?bDkyMFgzYWsvc0pMN25vcytyMnQyRXgwVTFBOUNrblBzOU5aVlFDTitGWmZG?=
 =?utf-8?B?Uy9URkI1UFNaenNXUVBWOGp1bE5IeDlVYXRnK0g4a1ZJSXA5dGxLaG1xS0pn?=
 =?utf-8?B?ZkxpNllWMXgwU3E4anU5a0p2aUxMUjFTemxRNTRYOVpJQVQ5VGsvaUxtYXRJ?=
 =?utf-8?B?dEVyRFhlV21ZUWVlNHNCRzd2dk5pUUExaWlLWU12VXNYNWxJRHRZN2I0NXIw?=
 =?utf-8?B?T1VlQnB1ODJKaUF2bzZ2QzAvNEsvb2JWUEhuTXg1My9sVys4RS9yWHRXRHBS?=
 =?utf-8?B?c3JEa1k5TG9Ic2cySWpyS1Jqc2tVMlF5QkVYZ2VpaWtGTWdPZFE0SjJCeWxu?=
 =?utf-8?B?U0xpWUhhVUVvcUc3YTNvZ1N3NCt3OVFXVEFQNDRxdHdDODh5YUJFMWI0UEpz?=
 =?utf-8?B?azEybjFzR0V5blZyczBVZ0VLU1ZDVnU3WkRuS0FOK1RLWXZYUXpPbDlBVXV0?=
 =?utf-8?B?RWNFemQ1YXA1S1pSU1NZdmMvV21saUJJZ1RSUHpDcitPNDl3Z21yRUdQSGpV?=
 =?utf-8?B?NUU1SDRVaHJKckNKSk5JOERmR1pOMDlKSGZRODFsV3hWMUJEOG5YQUw0MzFV?=
 =?utf-8?B?Yzhrc1g0cGZBRUllQ0paak0yd1hhSFhSb1RWM2hCOTZmRW0vWHBUbTcxK2tG?=
 =?utf-8?B?SkYwMWNtWWRwRHh4Q2tOUGEyU0FySnNrRG1RTmxMZHhSMHoyS2doY3lsbngz?=
 =?utf-8?B?dVY4dkJ5dVo4SU54cmp6WVZ3TFFVSGtFNXJKcjVZWUYzQWpSZkRBME1MelhC?=
 =?utf-8?B?RVp2TTkraFhQcUdKOWlXTmVRT2NPWFN6Q2k1VEdSNTZnV0M5WE1ZUFovR205?=
 =?utf-8?B?dWx5WU96elhRVG5udmxhSWQzZGtZMUhSaU9VVm9iaUdNdHBDME03VUpSQWJO?=
 =?utf-8?B?WUFEUFV6S0o0aHAwUTB5REErL0I3WDVwbFZ6aCtZVUhnc3JLU3dkNEFJeG1J?=
 =?utf-8?B?QlZmQ2lBOERFSzYrSEhaTllLZ3VraHo0U0g5VTlwZ1BpZ2lyMmdKbmVvcEJn?=
 =?utf-8?B?c20wTFFybndaTi9hRkhldExEY09WM3Jta2JDbjJPYTJMeHgyYmtpUXVWTFBK?=
 =?utf-8?B?d1FHZ2ZWU3dxVCt6WGNRS0hnY2JJT3BrVFQzNlBMSWQ2b3NIYTBqNHhTeFJ2?=
 =?utf-8?B?VVVORlFrNWt0UzI5UnhiYWw1WDFVazllbzZFK0Jxd2lpVmV6VVp3VVB3bnFn?=
 =?utf-8?B?VUI0cy9oaktUeGJBbEYwMEh0U3VNbDdKMVdzb3JzbG9kQ1NWU3h5Z1BJa2xN?=
 =?utf-8?B?ODlwUkFQblBrRUxORjNIWHdpZmRuK2hvMys1R29xK3JXVmJIZWtKZklrcmg0?=
 =?utf-8?B?ZHpMTlBIZ055cVVVSXl5NnlRWlJZMS9MNWc4NGhVVE5aNUVFVmh0bUx5U2t4?=
 =?utf-8?B?Qld6UVpTT2R0VDJIQkZsOStFalhGNERxdlV2Z0JLSVUwTFgrWG94TjJVOFY3?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a6db0c-3e07-426d-dc14-08dd34a2df5d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:53:49.4531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQZJlE5JCrrzK8yxDpxREQINhbhF8IsmT7LHvaCR/dEvn1uT9abYGiLQM5V3mJpaP+JD+OhE8TNK39JXizpNHAbQXugoifWrOBnhBFZNLv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8125
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

On 12/20/24 11:22 PM, Tom Rini wrote:
> Now that block drivers are all selecting the BLK symbol, there's no need
> for other options to be select'ing BLK so that other required
> functionality can be enabled. Remove these places.
> 

We have multiple commands depending on the BLK symbol.

BOOTSTD also depends on it, but I assume we should be able to network 
boot without HW block drivers?

CMD_UFETCH wouldn't be usable without those drivers as well.

Should we do something about that by making them not depend on BLK e.g. 
use CONFIG_IS_ENABLED in the right places? Not sure if all devicess 
based on those archs have at least one HW block driver enabled. I guess 
checking if all .config before and after that change are identical would 
help us figure out if this could introduce a regression?

Cheers,
Quentin
