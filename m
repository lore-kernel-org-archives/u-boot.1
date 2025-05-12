Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEDEC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 15:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A8880C83;
	Mon, 12 May 2025 17:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KrdW4qaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCBA81DD6; Mon, 12 May 2025 17:54:10 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08FB5805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 17:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6riMqhHfN514zYyK78VuMJ8trxEDY6Dktmp4Hy7fCtkoycLa2qJO+hqC48Q26nuWtyogEom6IhwQGyT0NMWIXepwHIreJG/WcoEul90QxgTtOUyzvbUfKeFjX9WZjBDuAIbdxiL75TrxMxIsbVLjJtIKtkfhlVqdAKPZdP4Oq4tQ2kdoEmjEWXG8eI0kXAySgP43m7gFjBPIxEtNxSZVdgAnc1Waskvv0uL3aiWNdqM9wGm4xKcGo0hrtKBWbL15Nh6RAfqZOra/3Iw6PvsHFnxFqkHb9n6r3OWjqzfuGPYNWmh3GyeV0DRGH1VcZXnktDBw4wHobECvOhZ5k3dIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIMVhIFToYd0BUDuh/5JtTBNB6MJUZ8jb1ju/SAEVoY=;
 b=EebCApp9CeOW6ypSjmK7YiQl3/CpauZ4TSDZAJ6QHWWjDxgngg7XpD41gO0hnSwDvKB/ORRfKLtehmX3JBVRR81kCEQ5Tyb2pPTm794lyFbEo2Ge/rjd4qKYLXVGEd+Ns3y4ZQ8ABZhkVSZebuRqEWuRdxgmIaQdyptXgi1L5L9K9aj3thIPfbQo3WIVwMBICp+8z7CEskYknoaFEgBiWWFyAEj88Ek3K4p6o/Yh9x6zblQbkg2QIM249Tu6fz4e4NInnHFM+4Zu72WGveJS8z9QoHwE77Vs0WIhDAxxssoHeM4id4tqWQA4s9CYczj22xe+6A3luZu+zKYvHUjODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIMVhIFToYd0BUDuh/5JtTBNB6MJUZ8jb1ju/SAEVoY=;
 b=KrdW4qafqipuOr1XNfYg3OoVuVmjYwLS2lMccz3PwzwxrZpXecckVCs9YjTTk2sqydLeWpm5L5vNYTtGhcTExQv+sdKq9cyKwAd4sgV2YlkTY9Oa1pldRXkndDuCT+eQTw0Jc+rF/YcpHFPp1xpctoaOkPUbGJE0G08i1CFykE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 15:54:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:54:05 +0000
Message-ID: <184faff4-511b-474a-a710-7566a369028d@cherry.de>
Date: Mon, 12 May 2025 17:54:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] doc: pytest: Framework for documenting tests and
 document test_000_version
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-3-trini@konsulko.com>
 <383cc638-2db5-470f-8585-13274a338c6f@cherry.de>
 <20250512140709.GO603748@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250512140709.GO603748@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 55904ac6-7352-4f02-acac-08dd916d3960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUhUMElHaWthQ0dVeHVLam95OExqQVgya2J6QkhmbXo1TjRudVJ4ZlgrT0dS?=
 =?utf-8?B?ZkdzZ1Z5SHVxZGxSbkVXN29Ca0tLSml4a0JkWjhaWlRtTzNtcVZDVjV4WklO?=
 =?utf-8?B?NEVMQXdaRmVoZlBNYTN6V0Y2RUlPejBTOXpmNGRXdWdaSzg4V3AvYkk2ZTU0?=
 =?utf-8?B?ZUw3cFNpOC9UcEZ0eTRJMCtkUFRSRFhWeHpDMWJMNHBtZkhMampRVVY3aUFK?=
 =?utf-8?B?Q1c1dE1ZeXV2eXNnUk0wYUV1ZStlUFo4eUU0MUs1b0pSZStGVStvcExEZUhl?=
 =?utf-8?B?Lzd0ZjBBcytNTStycUxRUDlNUUNtem9qWlEwQnBJOXY5ZVBIOXFnYzBWdkNS?=
 =?utf-8?B?SUZVZlBGYTVSM1NEeHl2M1NvTVF4d05UUkI5RmU5RHVmRW1oRlBjQTRjbWhy?=
 =?utf-8?B?RXlNUGpDZ1oyOEZuZ0hoRlByd3JyeVI3RTlrZWZ2cG9FMWxtT2RxTE0yRERl?=
 =?utf-8?B?U0hldnVxUGp4ck1reGtTcFBPbGxsb3Q3THp5a1c1emJNZkRIVUVTdzZWTyt0?=
 =?utf-8?B?ZlBLUWZhLy83TlFCaUdNNmptQm15R1g4SWM5emJKRnlmZkNhaDJFMWtKR2V0?=
 =?utf-8?B?TkJ0djQvQ1RpTXpYeXNBWVJacHZKZ0c5K0VxeU5rZXlNZXkyYStRYVQvSThx?=
 =?utf-8?B?Z29SUXR5R3hvWWFUMkRFVis0VXp0QzZZSSsvelZqMUU0ck40VUduSDBOYk1D?=
 =?utf-8?B?REJvMURWMW84c2JTcUcwcmsrTll4UEgxRWNVdkVoQllLdkRmeHZyRTJrR3Bo?=
 =?utf-8?B?TXVTRHZETXZhZVI1OEZYeEdWSU1VSFE0T29TK0wzNHR6aTV1YXdUREh6WmtG?=
 =?utf-8?B?V25TSUZSSzlKeGJyRWp6aDlFNWc3VU1HL2xsTjNFNHRReEt4QnNaRVIyR09Z?=
 =?utf-8?B?T05KOHZxRGNNYUgyYmlIM2JFQmpNdmUwTHIwY0VDMEsvR25ucGdaeXJyQ3RU?=
 =?utf-8?B?QWt2bUx5OHlidG9oYXBZbHBvK3lCVldvam1HOWRPckYvbHJlWTVHbzZLL25n?=
 =?utf-8?B?czM5QU5ZV2crQzdUREhzeC9zZWZPaExtbFdIVXlMc1dzbThsL3NmYmpxd0h4?=
 =?utf-8?B?ZzNhYit6SmJqMWVGUFJ3ZDJMK2VKeVVVK1BEQnhKaTg2RXc2MHFaSE5RZlJN?=
 =?utf-8?B?TUJyVVVyaWtLWDBaK0hNdUV1ZWk1UWgzMHZqNXhoZFVQUDhmZzJoTjQxT1Bm?=
 =?utf-8?B?ZTJjd3NzVzdBb3BLODNiUHp0c0xvSzM5ZW01NVpSN0k2SVZZOU1aNGNPRHhM?=
 =?utf-8?B?WHRmWkpQZFVUbXBJbVE0ZkxoZGU3ZFV0bmtOK0lsOHgvbWVCTHdtbC81WVJE?=
 =?utf-8?B?aVRPbzhWVWVlSjFTckk0VEpZSDMranNRK3pJM0NKa3ZYNGx0aCtuejZUZTJI?=
 =?utf-8?B?bWU3cmZPMkhiaytUK1ZhbDhEOFZmYWdjbVlQa05IVTNONDA3RHduZGtEM3N1?=
 =?utf-8?B?bG5oMWxKV0FGdXQzQjFGbHUxaC9YUFlmK1R6OWlidzl4K1hJbnNFTzNTRzlS?=
 =?utf-8?B?UHpXRHhkeGtHUURIdTdtSEtkS0FzSXcxUkdxSkM3blF0UHdXNytWN0FtY3ph?=
 =?utf-8?B?Z3N0aDRobXh5SGpmbGc2RjZGT1NQTjZUOGU4RDVZb29hOWlXYTdaZk9BREcx?=
 =?utf-8?B?dHVySW1KS1VDclpJQmtRZzhiODBreHFWTXpLT2F6UnNkUjU0LzB6SDdiU2lm?=
 =?utf-8?B?NWdibUpocFBWd0MxK09jQ0F5Y0pFYUlRWjhrNzkvdCtpRSt2SnVPRis5RmtX?=
 =?utf-8?B?cnlsVklOdzU3YTFLYVhsS1NWZEtwazdkbDdienlHaXNteHArZVp6UVRWTVBh?=
 =?utf-8?Q?fFwC0BF8fegg+RwJbFmIjNqGPeOAdAvWQ5oiU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJaRW1relZSTFkxVFkyR2wzTStOV2FoQjBpa3Fqdk5PQ3JPUFdRdFhRcDg3?=
 =?utf-8?B?b1Znd05zeHc3MWkyNVN6d3YvT2FXZG1OZ0lEY0NKTjZvZkIvU2dHY2cybzF2?=
 =?utf-8?B?dkg0dHhrd2ttOVl6S0ZMVXU1enlsT1UvRm1xNHpSMTQvS0hZYTJaY1VKenE3?=
 =?utf-8?B?TUU5eFJHTkwrcnoyZ1NCOEt0d29EMTJQY2VuZStFOXZZMG1RMks1T1VNRUVk?=
 =?utf-8?B?c05NUjhnWkQxU3ZoQm9veDcwaWdWTE52NE5hOC9QejllVFlVTXRxSzk3UjNK?=
 =?utf-8?B?YjRaUFFZMTMzZW5MYmp5RGxQWGdVdzA2NGtGc1kwR0Z3S3ZIY0xyalhETm9t?=
 =?utf-8?B?eEZ4ZTk5WVVqYmVvZTVmaUx2VWhRd0YvRW1ndmQ4SllrQmhqczJXc2NGN2th?=
 =?utf-8?B?cm85MXJPR3lxbUJvU2pycmxaQWt6U0poczVNWWRCVlUxaE9CbUFoUWpuZ1ll?=
 =?utf-8?B?OUF6ZzlQQnBhODFLUU9WcTEwREdQL284NUdjS28waUMzZVJ0QlhHZ1RhblAr?=
 =?utf-8?B?V0hNVDdRTmhBZXAwVTlTYktsT0N6ZFpKK3MvVCtGNDcxL3owYm8rUnBYd3dZ?=
 =?utf-8?B?aG1YbjRLaW5rTXJ1eWpWSGVQVjhPMTZ0ckhEalRMZkQ3MWduM09RUFhNL0xs?=
 =?utf-8?B?WlovekRsd3prcGRoY3pJWnNtQlNHM0F4NWpJamtVR0RrbW8zZS8rcXJrSDF2?=
 =?utf-8?B?YzFXekNPeFl1OUE5TWFxQnFJYk1IRndWYzcycnE1cFpQSElKYW11Mmg5RFVY?=
 =?utf-8?B?VmFBUmFHbFV0WDRhcTFyYmJobjRjWXpmM0pHWmI2ZkxYaDY2NWlQNEhuaFhM?=
 =?utf-8?B?Vkt2UzlBLzZGMzZvTkFjTEJkTnN3ZENiN2prc1VDZUFERVNWS0VhZzkxVW8x?=
 =?utf-8?B?UDdYeHRtdWtCbSsvMlM2T1V5K2Fsc1R0dk11eEc4dHRtV0hOblFQY1dUdW9j?=
 =?utf-8?B?THdGdGRNQkNNelFqeFN6dUk5NDdQSElvRURxaVBLcm54OGkvU3h2ZG1WRTVQ?=
 =?utf-8?B?b2pCc2lWSHhoUTYvZndPY1RRSFhTbkk0N2JiZjdhRmJzYitMR1JHTmtGOFBy?=
 =?utf-8?B?dXJ3bW5UeE8vMUs4bU5kQW9aajYwM1gyTVpyVWQwVUJmaHQ4VlVHK0xlMnNK?=
 =?utf-8?B?ZWRoY285WjczTFlIMXIzdG9LSlhySEZSNUJ6YktVUUdxd1N4ejJjaWwzWGE2?=
 =?utf-8?B?eXU2TjljaEhiYVZOVTZCY1ZqdTBENnJFNmxlcmZLd1pDR2pEOTV6WUV1MXli?=
 =?utf-8?B?VTJnTzBRZ3dMZ3NTT2ZFcThLa3VFMnVrelBVd0R4VGJWME9xMXVSRFMwclpp?=
 =?utf-8?B?MFdweW8xSTNrU2VUWkljaWtqQkloL3QyY0R0TTFTeGo4VW9sZmFXSWdac2NF?=
 =?utf-8?B?U0w1MExad2UxdDJnanQ5T1VVYjFPU0o0bHpSZDdHcEUzUGtQOHkwd3JtSHNy?=
 =?utf-8?B?MWhhWjdqZUp0MVhlOS9lc1hZMFc0TDZmZUM1WE5FYTliNFBkY1NJb0JsRk9V?=
 =?utf-8?B?MWYxUWZVSHRVVmNmam1Nd0RHL0FaSWpCdEdUNEp5V1E4ZXliZ0ZJTjNWR1BV?=
 =?utf-8?B?NVVJendMTitOQnBoRTQzbnZUa1lWdHdkMmltbXRMSFVlbzdsTjBab2w3THFW?=
 =?utf-8?B?L3NpOVcrbjdOZFkrQUJOSTg3OVdRNjNyNWV1SG50NUY1VHpQa3gvVEg1QnYv?=
 =?utf-8?B?TFpJQkVQWWFJSGoxUzhUZmppZlk5cXhYOXpaQnNlcXF0bjQ4eGhvdnZ1L2dF?=
 =?utf-8?B?azB6VGRXdWlDdEpWNW5Ic0grelVZQUUycXFFY2hhWHcrY2xMT21nV3Y1dThy?=
 =?utf-8?B?Q2dtY1E2aU9JRHlYKzJURXVTRSthc1p6Q3VpZ0Z5K1dBL3U5dFI0L3dVVURY?=
 =?utf-8?B?L2UzQXVVc0ErSFlqVUIzdmdaRTBOdFJNZGhLeC9NR2FxMkF4Q1ArRStQTkp6?=
 =?utf-8?B?UWpMYnZhSUdpYnJ0aEFaaGZZU3lxdGlXa09PN0RnU1cwT3JUb1BnbnBnb3Zn?=
 =?utf-8?B?cWk5K2V3OWxFNW5GZFZQa3kxZzFwQ1U1NDE3UkE0Q1Z6OThpYXhUR3FZczE2?=
 =?utf-8?B?Q0RkeTJ6YUorTklaajFiSllUUmhGV2lZN0EwYTd1dVVIelZkN1pKYlkyM2N6?=
 =?utf-8?B?aUhTc2pJOCs3VnZ2ZGRWKy94MDFieWJIVE00cmNtNXM1bllHeXdTQm9TV2s3?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 55904ac6-7352-4f02-acac-08dd916d3960
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:54:05.8687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILa9OwpAtAqxIOw3/AtiUmRIBH9KcggKpO6ql3Na8phI22LSDAhKMFYEqrZaurcCo9kniuZz6n+hed5Y6x5LL6SfmIvN9sPpna/8IPjYm/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267
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

On 5/12/25 4:07 PM, Tom Rini wrote:
> On Mon, May 12, 2025 at 11:12:50AM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 5/8/25 12:08 AM, Tom Rini wrote:
>>> In order to easily document pytests, we need to include the autodoc
>>> extension. We also need to make sure that for building the docs, CI
>>> includes pytest and that we have PYTHONPATH configured such that it will
>>> find all of the tests and related files. Finally, we need to have our
>>> comments in the test file by in proper pydoc format in order to be
>>> included in the output.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> ---
>>>    .azure-pipelines.yml                    |  2 +-
>>>    .gitlab-ci.yml                          |  2 +-
>>>    Makefile                                |  3 ++-
>>>    doc/conf.py                             |  2 +-
>>>    doc/develop/pytest/index.rst            |  8 ++++++++
>>>    doc/develop/pytest/test_000_version.rst |  8 ++++++++
>>>    test/py/tests/test_000_version.py       | 10 ++++++----
>>>    7 files changed, 27 insertions(+), 8 deletions(-)
>>>    create mode 100644 doc/develop/pytest/test_000_version.rst
>>>
>>> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
>>> index 5e1938b05262..9c136513bb9e 100644
>>> --- a/.azure-pipelines.yml
>>> +++ b/.azure-pipelines.yml
>>> @@ -92,7 +92,7 @@ stages:
>>>              set -e
>>>              python3 -m venv /tmp/venvhtml
>>>              . /tmp/venvhtml/bin/activate
>>> -          pip install -r doc/sphinx/requirements.txt
>>> +          pip install -r doc/sphinx/requirements.txt pytest
>>
>> Shouldn't we force a specific version of pytest like we would if it were
>> part of doc/sphinx/requirements.txt?
> 
> It's a good question. I don't know and I didn't want to drag the whole
> of test/py/requirements.txt here nor have to worry about the pin in 2
> places. I am hoping that for documentation needs this will be OK.
> 

/me shrugs

Time will tell.

>>
>>>              make htmldocs KDOC_WERROR=1
>>>              make infodocs
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index 6f11331514b8..7aadd5d8b735 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -164,7 +164,7 @@ docs:
>>>      script:
>>>        - python3 -m venv /tmp/venvhtml
>>>        - . /tmp/venvhtml/bin/activate
>>> -    - pip install -r doc/sphinx/requirements.txt
>>> +    - pip install -r doc/sphinx/requirements.txt pytest
>>>        - make htmldocs KDOC_WERROR=1
>>>        - make infodocs
>>> diff --git a/Makefile b/Makefile
>>> index 15c7e633b874..bd136a48982a 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -2448,7 +2448,8 @@ DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
>>>    	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
>>>    PHONY += $(DOC_TARGETS)
>>>    $(DOC_TARGETS): scripts_basic FORCE
>>> -	$(Q)$(MAKE) $(build)=doc $@
>>> +	$(Q)PYTHONPATH=$(srctree)/test/py/tests:$(srctree)/test/py \
>>> +	$(MAKE) $(build)=doc $@
>>>    PHONY += checkstack ubootrelease ubootversion
>>> diff --git a/doc/conf.py b/doc/conf.py
>>> index 3cb9b2bb65e5..84d028feda83 100644
>>> --- a/doc/conf.py
>>> +++ b/doc/conf.py
>>> @@ -48,7 +48,7 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>>>                  'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
>>>                  'maintainers_include', 'sphinx.ext.autosectionlabel',
>>>                  'kernel_abi', 'kernel_feat', 'sphinx-prompt',
>>> -              'sphinx_reredirects' ]
>>> +              'sphinx_reredirects', 'sphinx.ext.autodoc' ]
>>>    #
>>>    # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
>>> diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
>>> index 435d84fc619f..ca45e157d3be 100644
>>> --- a/doc/develop/pytest/index.rst
>>> +++ b/doc/develop/pytest/index.rst
>>> @@ -10,3 +10,11 @@ General
>>>       :maxdepth: 1
>>>       usage
>>> +
>>> +Individual tests
>>> +----------------
>>> +
>>> +.. toctree::
>>> +   :maxdepth: 1
>>> +
>>> +   test_000_version
>>
>> Can I recommend using a glob here to avoid having to constantly modify the
>> index.rst whenever a new file needs to be added to it?
>>
>> .. toctree::
>>     :maxdepth: 1
>>     :glob:
>>
>>     test_*
>>
>> for example, c.f. https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-option-toctree-glob
> 
> Oh neat. Yes, that should be done instead. I wasn't expecting Heinrich
> to pick it all up so quick, do you want to post a patch or should I do
> it and Suggested-by you? Thanks!
> 

Please go ahead with posting the patch :)

Thanks!
Quentin
