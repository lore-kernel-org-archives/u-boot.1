Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0710DD37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 13:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442BF808AF;
	Wed, 14 Jan 2026 14:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kbHaiXhG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37C983678; Wed, 14 Jan 2026 14:41:19 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C590F8352B
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 14:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv1o+rwww+xsuGRRd1j2+ptxCw0RD5b0g7LKVXq1Vkk+TG0tgLFBQkgJjZ5E9VFInZQHe9h2l139O0Rl2z9guPxvw9PDzyIpBG7pwIKPE9EMxQzCALyBeGSbuTXatMCH7BgQgzu8fuamnaD4unE/mM8FIZ6lT/01/h9/u9OB1Ykxp2GjK+thYQMxBHL4i5S4SN6fukjHxcKBGfbwJ9okxvg4yTFzE4tb1SWelf6pIanZuJuXAekFLyL3u7TQzmN/WjFEV2ZVOSPPcmxurqbQjnwcn7Vb/ArZR8B/8uY7sLKtqb0vH4IOdJ+g9yCk3wJsvB5z1OBgvTorhfGIK7nxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJwGM2eqau9t0N+aX++hOfR7r7TjRqjMvxlvWzVUy+g=;
 b=dz5MYSOS2lMFQQh6DrqqQerd4f4fQfGfrdTfGM8mFNNOKLu1Rh3OvzR4PJ172/p9WZKTzmk16+DhSdUFI+rBv1YTu89wNmoXisPxfiU6KhFVZRG9ZH5VV7jJCu9qu9jzU8erR3iEJuYN5Jyj7eXI7PPkM8GFk6hsXl9H7D5BjadQJ+rIyBhEmxQJ0+N+h2qN/S+H9b16DCZybTJFI1bFdVAuz0LF3e4yKUASE0LSqEp+XSg4BCDPAM1pN2Uq/F2C7+czvDx3/7FKTJAYKLgIwXohjDhlrFZfSNUnpntXH3Um/iwKsfksgLFYIeDvywXspyknf3SEKnAucl7vqF7Ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJwGM2eqau9t0N+aX++hOfR7r7TjRqjMvxlvWzVUy+g=;
 b=kbHaiXhGNwe4HghY090bcuYsMh685h7zMza5BXXXxSOxLEt7sOokMzOhbs9BPpq0gKZF0MQYnqqM6GO0EOayd+DF1rd+SPEEcm4PmUaTgTFZqZvuGn9TfN2r8pddc8S2RaY6BCfsYRVEMyF4lKBOsQdQBDrk/G/P4IBzYsQl5f4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 13:41:13 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 13:41:13 +0000
Message-ID: <a77efae2-6c83-4c18-852c-db83034475ef@cherry.de>
Date: Wed, 14 Jan 2026 14:41:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disk: part: fix partition search boundaries
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20260106051457.3600260-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260106051457.3600260-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|AS1PR04MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: cdaaa5b5-3e44-48ab-1fce-08de537295ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnozSnUvZEpSSjJINnlSMUJxWkFOY0U0L2FJN2FSZll3NmZramNESjA1R05D?=
 =?utf-8?B?bi85bVFSYXlKYkdtbGJqVnJqcHdWNENTa3FOdGdpeHRlZkx6cUtLa1VDKzBD?=
 =?utf-8?B?UkJNeWg3MG5OYlVIODYyQWM3Nnl2MVJJVkZrdis0SFlqeUlYU3l0Smw0ZWJD?=
 =?utf-8?B?TnV3WDVHZENXVnBkL2lkSmJJdjU5TjYyM3ZVeHluengxNUhibTJoS3owem5h?=
 =?utf-8?B?aURFSkR6ekJnaFlvcG9yUEdrUlpCVmV6S2pYT2hjVEhLNGpWR1lnNnBwdFl1?=
 =?utf-8?B?TWZRWWtOUGtITlZYUGhkOXB3S0ZRWjJZYlJhRFAvNk1VbVlMem1TUktnbmtt?=
 =?utf-8?B?TW1EaGZzbDRXaWVUUXRJU01maEJtS0JaSWZUb20wRDBiZWlQQ1N5a0w0dzNZ?=
 =?utf-8?B?UDNiOXJGcVlYMEZiQlNEYW50ajZYU1Rhb3Ezc1RkN0NMM3UwdWdObDZnWE9S?=
 =?utf-8?B?UWZqYzZyZFdsTTcrQVZZeDdRbll1NGdvOTIyTWJHbUJuaVJXcGdvZFhDa2tr?=
 =?utf-8?B?R1Yrb0s5Sk1sZ1JTZkc2RGpiSTZnQjZHTi9TbllzYlBLVEhiaEZrMGw2NmZ3?=
 =?utf-8?B?SEJreXM2akRPUThXUkdXK2lhMStIYkNYTGtZQnQwOWFwSDJOeCsrclRKd1oz?=
 =?utf-8?B?V0I4ZjgzNnBXdC9YSXpIODM1VDM5YXhUbndnaDg1Yks1N0hicFlFL1VwNjl1?=
 =?utf-8?B?OGNlL2lkZGZZSThWaUNYNi9OV3Fydk96Qm84WndCK1hGdDMzMUI0NDNNZTNu?=
 =?utf-8?B?MG55OXJCSVBXQVlFdFhlY2l1aFJrN3NuQzRDQURSQTJOeHM0U3F3a2JpeTBF?=
 =?utf-8?B?ZGNyQWZsOU9WQjNidnZuSGNhZGordWJSYWZiY0hGVFFDenJuZmlQT3cvQUcx?=
 =?utf-8?B?ZUhPSFZFSFIwa29yV1diZ0Q3OEVqdmNUV2ZOSEIrVWZMTm5HZU9seUVZcXJU?=
 =?utf-8?B?WGdpRjh2T3JRendoV0E3T3lRamZFby9BSGp1Sk9uV3JSS1A5ejYxWjRKWU5G?=
 =?utf-8?B?a3JsTVY0NEpsWjVaNzZudWhvSnliTTVPNlQ3OUg3c3h2SWpnS1JweFFqUWEw?=
 =?utf-8?B?aWxoUjhFK0U2ajZueWZVWkZ2bG5za2xTWTIvaWNVSzVzZG1vOHd5RlZuT2Fr?=
 =?utf-8?B?OHE2SWhPdGdaNjQ4MXpiWEtlQkJONHBKZEszaEltNFpwNy80d2Z5MTNjdHdG?=
 =?utf-8?B?Vk5jSTgxTi9GR01WVmlXU2pGbHE4by9oL1lQRU4vVDB3ZTQ4Skp3WXlPM2li?=
 =?utf-8?B?akNIRnlKUTBsRTlJVnhxNmNPVlUwNVExY2xTd3V6bHZWYk44VjdEVFFWMCtv?=
 =?utf-8?B?QTdmZjlmOHliZC9KY0x3NDFvY2VCQTBsZkRJMFpSd2s2T2duMWg5aW9TVHl3?=
 =?utf-8?B?cHhrL2Q5NGhsaVRhZXNIZkhVbGFCdGNRZWhOcy9jRTBTRTdjS1FNcmZqZzFZ?=
 =?utf-8?B?dU9CYlJHUXZJWVBVVTNrVExpTkVHNDN1bERBaWIxWE5WdjBqQm8zanAvUkoy?=
 =?utf-8?B?K2lUWUZYK1d1ckFvMlozZjZqLy9JakpNZm8wWDNsNWFLTmNrNXM5NVBSaXZZ?=
 =?utf-8?B?YUk2Ulc2MmhsSUhHbS9IOGZsVDF3ZzU2b3dndWdOeTh2TWtJOEhDaE5LVmtW?=
 =?utf-8?B?Y0NXMmVsTTBNUnFIaW5Ld0Z5TnorQ3lXM3EvWWtDT3dzOHJOQWZHdFl0K09v?=
 =?utf-8?B?SFYrNU43OSt6cERPOHhZRERtMzZpaXBUOExEaTdrSXQ1ekVCOEc4MC9VZFdS?=
 =?utf-8?B?bndyV1hpb0Q1NGNYd0N3NUY5cDE2S08wSDZNL09lU3l5eGkvZDhaLzIwSUQ3?=
 =?utf-8?B?dVAxTVRPaEplaW1oZ0RTcnVjeGZZZUZhSVA4ZUtQNHJtNFBUSGErZTJBQ3lq?=
 =?utf-8?B?SnkzVlFuaFZPK3JkWEZ0STQvcldEemkyend5S2ptTXVvREpZelBFeUZKQmk2?=
 =?utf-8?B?aEdadE5BVjBKZHJuR3grV20vMS9VSVU4MlI4eXpBVEZIMFpGOHV0UTJBYXYw?=
 =?utf-8?B?cUNZZzIyTDVWR2o1NXdBSjh1MlRTcW5VOTRwRUZwQmRKYTl5K3NxcWliTFRT?=
 =?utf-8?Q?DLMOjL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZFdVZubDJNSG9ibnhoUmJZMmt5dm16aHdSSTBOQVNrd1V4dFR4ZWF0Y0hj?=
 =?utf-8?B?RkpDWmpLd2o4STFURmYyZjRiZlBzckV0TFpvcWp2Y3RUeXpQRDdFRENGb1Bp?=
 =?utf-8?B?UTlyTmVqRUhDaVJ5TUlaQUg1Rlk2SFdnbGFyQ3hGNXNxTUh5SjBpbk94aHc4?=
 =?utf-8?B?VmI1alpFY3FwQjNta2FmY3VIRjcycTJuUnQ2V21renlIakFiREVwVEQwaUxq?=
 =?utf-8?B?bDBZd2JlNVBwUGlNcGdJLzBKUkRYdUdrOHpXcUtXRzUxbVR6My9BVVpSRjA4?=
 =?utf-8?B?cUQ2REI4bzdjc3E5N3l5UENidm1MNlFkR2JFRkJ5a1FvTUJyR3Rzb1FGTzY0?=
 =?utf-8?B?Y0ZhNDlyNFZId1FaWDU5N3lDUWJMaDR0QWpHMFpVQitNbXgwQXRzZ1FpMEJN?=
 =?utf-8?B?OThkcHowSmpDTHdNYmVIY2gzRDNkQ0E5WWdNOXdyd2JaWDQ2ejM1RkZ1WFdh?=
 =?utf-8?B?UnplK1lidHR4S3pEY2RleitmNkxwSHZiOFJ2ekl2V2tQcFBndnJDQTRIUW4z?=
 =?utf-8?B?N3NEaHZha05vSlhKT1VkbHBuUGpBUUM3cThGSU1KVTdRdE1LQThEOElMdDZa?=
 =?utf-8?B?NnlnSS9HbWxsTGFmaXhHS1crK2dVYzhrQ0cxbVNLZENNK3VteVZlVkFiQ0E5?=
 =?utf-8?B?eDJ5cGlReXpja0lrNlBYVUJpOU1UK1hMSHBWSU13R3NaSUsrNXpMUGhZMU1F?=
 =?utf-8?B?eTVYNUFORHRaM2drYkhjb2FXOFRyUHV3LzZDcEpGWnBRVE50Uis0azdxK1dr?=
 =?utf-8?B?cnlyQjRkOURnYzdCV1FWZWZNNkd3R3ExR0VqaG9NSHMvbkVNU3h6MlFUU01R?=
 =?utf-8?B?REpIVnZJeHdCU3JySWxUTUt0eFVTb280c1hBeGErUURHb2NxSEIvcmlocWJS?=
 =?utf-8?B?WmE5dVRpUkltbXRWWXlIc1NwaUwxQUl2V3dnWW91UTJ1TVBObk1uUmdnaWlW?=
 =?utf-8?B?enBNZ0h0MVBBNW5MQkRWMnk4TUE2eEhnOGZleitmTFZuaGtzblJ2djdWMk1s?=
 =?utf-8?B?U1BzYTQxL2JxR2F1ZjdXWFRMMk5iN09JcUJETWI4SEdvUVJ3T25raVRESUR6?=
 =?utf-8?B?VGtTL1BpeEJBTlAxb3RGQzBNUXJYTnVDckxOT00rWlhwbWVaSUljampuYWNP?=
 =?utf-8?B?TjY5T3hEc05VZVM1dlRseldMZHU1Y2o3MHpkMlYxelZwc20ybHRvOERpOFJ4?=
 =?utf-8?B?ZmpzMmxjY2FMSlYzcjdCRGRkNFIwQWUwd1dYNG1zQThzbHZmTVhQaVhFTEVi?=
 =?utf-8?B?WGFJVXlZUkNQUnM3cE1KbWZoSmFsNGVTSmM3aUFCN0g4SytJdE0yWXVmUmR0?=
 =?utf-8?B?aE4ydUhTTGU0STFYb2s1OE03VkZBaWs0dWhYcXc0Q3BzcmVvSU5NNDE4aVdW?=
 =?utf-8?B?Y2NXNThDRENlemFHVVdVbEZqTjJTOWRVQllzTysxOHgyTjgvM2ZTNXVxdzdV?=
 =?utf-8?B?enBMSlRudERqdDd2akNTVy9iZkR0TjFHUHBXbDNsZ0QyUTZ4b2lOTEFSUUtE?=
 =?utf-8?B?SmRRczZVaHBuL2ZyZjNyVHNBdWlUUWNRUEpsOVdJTXJoSVltNUZpUVlnRGtX?=
 =?utf-8?B?NVIwZStZVFVrTmphdHdUVjlXQkFoaGd6bVVGckF6M1MwT1k5VENxWWRWMmMz?=
 =?utf-8?B?MmVuMGc2eXhQcG5wc3Vjb1BjckhKeXIrelhEaDFkVjdOWjJUWkVCRjhpTkUz?=
 =?utf-8?B?M1p4Vmp1UWZMTjk4TCt1WGdJejlJQXc2eVpnTTFpTHhJdURQc2pCQldmT2k0?=
 =?utf-8?B?K3U5YzhTZ2ZVWkQrQjJvdDhyYVNWdGUwTnNjdnY1MjJWZ0l3cUR1YU1qWWFO?=
 =?utf-8?B?M0h1RUV4V3ZiVEhQQmhUSEtXM2xxMFB1aFZSeTcvV292K0ZjemdFK0tzVGd0?=
 =?utf-8?B?M3FRVUo3Q1VNK1pjRTZiRmFGRzRxb3YzbE1obnVzcVQwZk5wVTFUSFZDd1hK?=
 =?utf-8?B?Z0dvODZzMGdrdkxTSXNZR0RhUW9DdTFUOER0L0V1VE5VRSt0cWhXeUFpN0t4?=
 =?utf-8?B?dTl2dVcvb29WSE1kMUpmY3JBZFZ0bjM2TTg4aGVwMW9jMVlDc3ZveEVrYm5y?=
 =?utf-8?B?QVFvNXZuNEg3emZSc01OT1FtNWNvYjRLYzRzWTNpR0lyWTRMaElId2YybW9l?=
 =?utf-8?B?S3lGNXc5UWJEd3NOMElRYTRVTDZFUTFuVnB2bjM5Wm9qZmhDTUJnQXVyR0F1?=
 =?utf-8?B?eEwyeHlMd1dnUytZMmVTOUUvQXJ6ZTUweENzczZpWlZTMXlLNWVNbnA1N0Qx?=
 =?utf-8?B?ODM1WDhya3VsV1F3cytVOXJXNlFxa2xuVUNKdkZsN3M4dFlkeDFmYyt3VGxI?=
 =?utf-8?B?N25weVlwcFFCM0orbDI0WGpXU0x3RzhGWUNBcVpNZW1pUEgvTzRWZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaaa5b5-3e44-48ab-1fce-08de537295ad
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 13:41:13.6450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQTJCr/NFVDF/wJWE9ifWCYoLc725QbItF7lF4rPzB+SW1qlQnKJdi2LvZ3bSISFTNmEttm6iomxa+aJdugKzOs+uV5/eiL3p+5rQBINW6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
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

Hi Mikhail,

On 1/6/26 6:14 AM, Mikhail Kshevetskiy wrote:
> GPT disk partition with max available number (ex: /dev/mmcblk128) can't
> be read/write from U-Boot using read/write command. Here is an example:
> 
>    => mmc part
> 
>    Partition Map for mmc device 0  --   Partition Type: EFI
> 
>    Part	Start LBA	End LBA		Name
> 	Attributes
> 	Type GUID
> 	Partition GUID
>    1	0x00001000	0x000013ff	"env1"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb02
>    2	0x00001400	0x000017ff	"env2"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb03
>    .................
>    8	0x00158000	0x0034bfff	"apps"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb09
>    128	0x00000420	0x00000fff	"fip"
> 	attrs:	0x0000000000000000
> 	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> 	guid:	5452574f-2211-4433-5566-778899aabb01
> 
>    => read mmc 0#fip ${loadaddr} 0 4
>    Could not find "fip" partition
>    ** Bad device specification mmc 0#fip **
>    ** Bad device specification mmc 0#fip **
>    Couldn't find partition mmc 0#fip
> 
> The error is caused by invalid boundary checks. This patch fixes an
> issue.
> 
> Fixes: 43fd4bcefd4e ("disk: part: implement generic function part_get_info_by_uuid()")
> Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   disk/part.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/disk/part.c b/disk/part.c
> index 49a0fca6b89..4923dc44593 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -674,7 +674,7 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
>   	if (!part_drv)
>   		return -1;
>   
> -	for (i = 1; i < part_drv->max_entries; i++) {
> +	for (i = 1; i <= part_drv->max_entries; i++) {
>   		ret = part_driver_get_info(part_drv, desc, i, info);
>   		if (ret != 0) {
>   			/* -ENOSYS means no ->get_info method. */
> @@ -709,7 +709,7 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>   	if (!part_drv)
>   		return -1;
>   
> -	for (i = 1; i < part_drv->max_entries; i++) {
> +	for (i = 1; i <= part_drv->max_entries; i++) {

This *seems* to be fine but I'm wary of the change.

Are we sure **all** partition drivers understood this the right way and 
did store the maximum number of entries in that variable? This could 
open the door to out-of-band access/buffer overflow if we have some 
arrays of size max_entries for example (thus accessible 
array[max_entries] is an out-of-band access for example).

For example the AMIGA partition driver seems to be saying there can only 
be 8 partitions, while 
https://amitools.readthedocs.io/en/latest/tools/rdbtool.html#info-show-information-of-the-rdb-data-structures 
shows 9 partitions, starting at 0 instead of 1 even. We have max_entries 
set to AMIGA_ENTRY_NUMBERS (8) so I guess 1-7 is currently covered, but 
this would then cover 1-8 which hopefully is still fine (we would still 
be missing partition 0 if that one is actually possible).

So we need careful consideration on the impact of this patch across all 
types of partitions.

Finally, I'm pretty sure we may need something similar in cmd/gpt.c 
since the same check is made there?

Cheers,
Quentin
