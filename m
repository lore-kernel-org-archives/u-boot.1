Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11618C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 10:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C5E480AE0;
	Tue, 13 May 2025 12:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nxmzlOks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574E080AE0; Tue, 13 May 2025 12:40:20 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3DF8091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amsUV0qni6MqCaEVQ4jg6NCACxW93oLh4tK2Ic32JEqXVOGBxo25IFiuBSTD+kCZVjm8k2RDXiGNgOp2ZFAvHZXojLHUEPSRfePO9cC8vJD4aPyiJUkXb1QfPAU41zPwg/DgnpMupAmXClbHJnqVHdpNW5d2VSgpFlfwnwZh2DBbrNptBapLLySPBb0QQvdkEUtlyEVeWh89ng0WiAYSk+zWwUpjnCrut+OB8DqLcL668ta4teJN9mJwfPUzdAhYDuvU8Ywqk0K52HAMFurZRwvczavFs2zD0db8oGbxkGzFi04RJml2wi1Jh68xpoQSH9t7TOLuXogB9RUm1rZ63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81I/jblcWAW84P0WaRVSOtQuAxaAKz3egB9Brhf9avw=;
 b=MAVNOs/Miz7sLw4GayS5gLMT7+rys3lMWGObaZz6qs21wR7QDQcFuhM2VjHsCI3lFFe//uRP1W8pFPSzzCmUd6awOL+bonPs5ieNchPsV/BinqMsfPOJ1F6DcvNOiFb5jSaLqi6IcjzOcPa/PTTLo4oKrm7z6VhPEVzOrmyjr78mPXWAHb8BiDxuC9HiL5NiW5g0atGa4vpIGNOpsYa9jLHFE8Y3dnx01T21gD1DLADl7ztApo9IHXZyx2Vp/+hZkZUg+fgo8hrx3Pi/hqQ27Y4W/+hxFNVGsa+UOsiPVyVNvv2H/phBFP1ms9/1GRfl63OTzwpUenyl8TrX/VGzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81I/jblcWAW84P0WaRVSOtQuAxaAKz3egB9Brhf9avw=;
 b=nxmzlOksY4nUcTpVL8F2+ixRtgy74/Xz7kuqG905xfqtQVJ56jmn3QtfBPMPgq8zfbeMk57G6IKjMXRSGhb6Hduz4XRTliEPtU0uxufFWDIL+mOlbYpPgi+RlPZMKg5CAywPLAgGoFoxP+NtShuEnZdpUqn8fml0Fr5wxQIXX0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9119.eurprd04.prod.outlook.com (2603:10a6:150:26::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 10:40:14 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 10:40:14 +0000
Message-ID: <a3940636-92c2-4b7e-abe2-8357580c9f48@cherry.de>
Date: Tue, 13 May 2025 12:40:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com
References: <20250512115028.1783305-1-m-shah@ti.com>
 <20250512115028.1783305-2-m-shah@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250512115028.1783305-2-m-shah@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: b1218398-9aac-4eef-1f6d-08dd920a8b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eU8yazQvZ2FpL2l1VkwvOElGaDhZZ0FrUllybFhaSUFtcFFJQUhhUlN5Vjdx?=
 =?utf-8?B?L3NIM25icWVYK2c3Nzdrdnp4ZmM3ZTIrMWw0NFdwcU1MWXk1eW9IbHNFUEpF?=
 =?utf-8?B?WlhLMUR0R05yY0srL3daelNpQi9WaWVjbXRWRnNjSjBDeTVUWlI3M0pZdUc5?=
 =?utf-8?B?NEhiRnNrRldOVVpPQmtYcStJYytUOGNhUk02OUtwVE55T1BJN2x6UldlaFUv?=
 =?utf-8?B?R3RUcEhhUFVaZmkwYmR0UHd2NlIzOUhUY2tucW1jVVpQR2RJcHdxZ3pPS29G?=
 =?utf-8?B?T1ZmbFNzSC8wQ2dmRzNtM3ZYQ2QrUEQxSzE0MklqajRjTmE5cXAyQmVNa1Q0?=
 =?utf-8?B?bmh2Uk1ZdGlpWDhCTDQ2RVBnc1ROazZtbHpMMXRQeFdSTlNWVmNUdW5EMFl5?=
 =?utf-8?B?WUoyTzlIWWFKSS9IM1lTekhMLzlVTERsbkdYOFdlVEUzdUFpbG0xSXpFYlFO?=
 =?utf-8?B?SGNjaGVEU0NldmRGSWgyaWswMUF0bURYeVVLZDgwV2NjdFR0OVdGZHUxZmps?=
 =?utf-8?B?eFg4QS9DdFcwT1d0bDNDdllpeElaTjl6bk1lZnE3UE1FR3F3RGM3TTROTFZK?=
 =?utf-8?B?dzlQWmljTGNRTERkOXZUMUpaK051MFlPeHlVdHJ0M3R5MksyY1dZL3BGY29N?=
 =?utf-8?B?SnpFMi9rbXBtWkNDMnJFNlhFcyswU2gvWnF4SE5VUHk4VkljZlVPN1E0WnJp?=
 =?utf-8?B?K3BTSHExOE5rRVcrUmVhUy9TSmZBcXRFbzNJVE52V1FiOU11d01ueitUWUJH?=
 =?utf-8?B?OGVDYnNxMGtUa2FSMFFickxnS1QrSVlCK3oxTlVZVGd4REtMWldNN2o0QW9L?=
 =?utf-8?B?Y2RSd0M0ZDRyQWNZNkxFRTN0RnBjRmxuMXphWGdZZjR1aEZZNmdFc0JYTjBE?=
 =?utf-8?B?VGk5MkFDK3BvM3l4cWpaVjlxa2M5dFZ4YzZGSFVYRHY3cGo1N3JtYk9zMnBq?=
 =?utf-8?B?UngxQXJ6NXYxNnNLOStOMzBkK1lZdVhVZ3pMcmhyb21aazZhcUhydUgzSkVQ?=
 =?utf-8?B?Z3d5Zy9CT1o5NmxSeVN0K2lrTEkrT2RJNW43a0pFY011dDExNEw3Q3VMZFQ2?=
 =?utf-8?B?dXkyV3F6bzROMG5kcDNnVTJYZW1FLzd1bUw4djN5NW5JaklNaEdyWG1IbEtG?=
 =?utf-8?B?bUwxUGZoekJsanZ5MmVwOEI1ZHJQSW1obDRtVm9wZEpGUXQyc2xRY3g3RmhY?=
 =?utf-8?B?WEZ4aGFQSFMrcmhJZnlrU21HNXpWcG4vV1BvMTBBR3hGWDQxd3M5WDd5R0pG?=
 =?utf-8?B?VDRFMTJERzhreWVLM1M5K0lITWFLbGNVc1hmT1l5a21IbmFrbHA1c2lUenpS?=
 =?utf-8?B?a2l5Q0M3Vm1qY3FwOFY0UmI2S3djM3NseEVQaEFmdmV5K25UZzg3cVV2L1cr?=
 =?utf-8?B?MHo1bDlNSm9zRDdDdnNkZ205WnFnY01FN3AraHdUeG04Qzh0UWM4aU04VFlG?=
 =?utf-8?B?TnYrU0RRSHlhRkNoNXdtWXVzRVA5VlZaVlMwUDUxM2oxS3pMNFpsMjdaZTBz?=
 =?utf-8?B?dGVKeUIyNG42NkJPMkZLVS84WTJidkR0SlpwcnU2R0NBaWRnLytranBWSG5H?=
 =?utf-8?B?UWRnRjJGci92a2VSdWdzSGNXVnBHTCtmRkNwS0xOZ1dlZFhBWU93WTVTU0tW?=
 =?utf-8?B?ZmdMWWRhRlJRSC9vUkRjNzZVOWloZk1iMzJndFJyUFRzZDk0MGxQWkh1ampY?=
 =?utf-8?B?NGtHMFEwcWZWcUZERjNmZUN5dlJBQ3E0TVg2eVhCZmV1SkRmanYrdi9Td09R?=
 =?utf-8?B?R253SlhPUWgyaTh1VFZLbGlNVTJjS2M1bXhHZ2FIYVE0d0Nrd3MyVTlUenJC?=
 =?utf-8?B?UUpqLzhoSnFqSGpJTktyQkRmenpZbkxROGRRcWFDVnhERkM4TTFIM1RJVzdO?=
 =?utf-8?B?aXlFaXdnUEJlenV1ZXhWMFhaWXl5VzllS0pPbVVmOU9nK29XdlBjUVFtTFh4?=
 =?utf-8?Q?3paDpLMcdTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJZR0tnNmM1Y1BDUGZsNHFKUTdBeFFpSW5WYzNDSEFGWnNzZkIzSUo5eFox?=
 =?utf-8?B?N1F5ckJlVnlZQ1R2SXQ2VFlvVWhrdjFHSGduQXNjYUIrWW10SXhlRkpIbG1U?=
 =?utf-8?B?U2poRXdydld5UHBjVm02RXBqWEFOQ0N5UVhYU3l0T2dxNnplNDhCYVlHRDVE?=
 =?utf-8?B?WDhXWlhVTzZkS21tOWZwUERUV0VxWnJVcG85NE9qaGk1U0JrSWxXTXhTbG1U?=
 =?utf-8?B?a0FjczVUU010cW1KeG1BVU9SSFIwYmpyaEtLWTVZMXlGU3RaSlRlTmhibFBk?=
 =?utf-8?B?S05vdTR2dXM4WWliODFvRTdydGVHcUpjOTlrYVd4eThFeFZLb280SWlYVm9U?=
 =?utf-8?B?cVdZajRhYy9UcjFFWEo4UFNlNDRkZEZKMWNiT0lFeHJ1YXFCNFVYYmRmQkd1?=
 =?utf-8?B?QkZ1Z2hzMTM3RkxMMS9YL2FKbU8xbHhTM2FKZEFibUtoQ3lqOHpWb2tyTXJP?=
 =?utf-8?B?Wm1KczhETTRFTVJyNUNOV2RuZ0dIZlh2N1VkT0VKM0FzQklEaGxqMWZpQjN5?=
 =?utf-8?B?RURxY0I2eVovK2JxcHF1aDV0T1hUa1hPM1A4cWVYRFphV01SUnlSTXA1ZmdW?=
 =?utf-8?B?M0dKZkZORGFzSVMxREFnbzJCRFJkQU1MR280MENCb1ZmRVA2SS8xNTBSdnEx?=
 =?utf-8?B?OTB6YTRuYXY0aDNITEp4eGsrMDJFWHByRExXdkcrYXBpZEpuUjJmN0x0UStW?=
 =?utf-8?B?dC91OXZXZzN5OXMxN0IxNGhKRVUrN001SjZYSkFGdHpLaWorRDBzVjhwU2xy?=
 =?utf-8?B?RWNJSjZ1ZkNqNzlBc3BVR2RiUCtaU2RvUE9JU3JGaVB4MHM5aWhtWTNiWDd1?=
 =?utf-8?B?U1liM1IrK21ENHEyNEZ0cURYcU1vMFpYU2xkaml2RklnKzBKdmtBMU42YWsr?=
 =?utf-8?B?aWh0UEYyVUpmak5sTGZWWlYwdzQ5Z3dyVVQ0MG1BS2EzKzA5cW5CZExGbVA3?=
 =?utf-8?B?S25teXl1dVQvdGpmaW43UjBjdTZBK0UzZlpDcTJoNmlRTmxmKzh1all4Y3la?=
 =?utf-8?B?Q3kvTHF0Y0txcjJHOTFDK01mdm5tT1ZmSzZ4bHNCNS85Z0ZYMlIyQ09zSjNu?=
 =?utf-8?B?N254YnlLK1ZOb3pyZnZEZlF5WmhNRUN2d1FYeGg2Zm1KeEo3a0dlaTZza25j?=
 =?utf-8?B?OWMxb0ZYdTkzcExHYlVtZloydGtyUVJmTi9WTnRlem5FaEdMejNEd253OEIz?=
 =?utf-8?B?UUw2UmFnaXVkUWlSSUJtRkNTUG9pVkljVytpR3VNKzYzN3pFc2Jmb2ZtdG5l?=
 =?utf-8?B?SVVydUJOalFQeHlWcklHWEY1eENYVmhReTJIRFhTYmttMWlxTk4rRkdZUVFs?=
 =?utf-8?B?R1VGNmdkVEJtRkhTQ1RpaFlvbEVwVGtuRFVDZHBTNzRwVWNvcjI3RXl4anpq?=
 =?utf-8?B?ZVNKQlhzNDlMQTlnZFdyODhub1YvY0l5SlhRRzNESHgwSjNwTkl6MW5XQzJm?=
 =?utf-8?B?U2NURkd1SitIZGZPMzVuRjh1eDNJS1ZvOHp6ci8zYUQ3WFdQb04xOEZCemZW?=
 =?utf-8?B?UXJhNVNDdEh3QThZeTNueVB5QlhBeGMvUXg0aWRyYXRDdWErMXdpQTdZSWp4?=
 =?utf-8?B?L0FhN0Z5TlBEQnJ0anF2amNxMXI5d1l6YVhIRkVKa1kzcGt5WHMvVTZsTTZJ?=
 =?utf-8?B?YXB3ZUprZDhPRUpTa0dUMjBWTEFYOU1wcmJXbDJqL0tsdmswcG1JeXdWdnQ3?=
 =?utf-8?B?VTI2WVhyekl3SjVILzhFTFlqNHM2RHlRSjUwd1BsQ05yeXdCTEN6c3BSeFFt?=
 =?utf-8?B?MlYrd3VRbzVPOXRkK3hWQzV6cmQzcFY5eFV3dFRzZmppL1krOUhBN1BVWkxh?=
 =?utf-8?B?VEZDSEszNEVKZFJUbkRQd0swYzc1NGMyKzJOK0RBNjJwT3BOUkdiSHREWFBW?=
 =?utf-8?B?b2NlZXV3dGN1OXB6L0JRekZ5RHJwUjhxMmZaN1gzeFVHNHZIRm5uenpWZWRF?=
 =?utf-8?B?VFYxdWloZnltUEk3QkxTWHhySFcxMHpyMnlhRmZSbGdDd0xkTXA3MHVudGJu?=
 =?utf-8?B?U1JzK2NvT0wxcVZOT2dQTXphWHQ0NXhvaExxWjJvVzlXVHVIU1pmTUNVQlR1?=
 =?utf-8?B?WGt2VHp4MWd0VnJ1K2hMUkdxRXN0YlRjUVdjN2ovUHZwWmgxaHZab1FWUEps?=
 =?utf-8?B?LzY0a3A4bVd0ZFpSVUZLeldMU0FDdytQdDh2Qkl4TmVNRnhXWlJ6SFl0NXAx?=
 =?utf-8?B?RVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b1218398-9aac-4eef-1f6d-08dd920a8b39
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:40:14.0991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWSvu0RUyqNFR/gxJyPTjFdXeULRlkNs6To1+u8EQcotnGNDeP5qGQhVLee1/XHLznGfjs/wVwBSrVQojKS9pVxVjQCxiC/peAsmOI3/EZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9119
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

Hi Moteen,

On 5/12/25 1:50 PM, Moteen Shah wrote:
> Add a function to scan through all the nodes in the device-tree
> for bootph-* property. If found, propagate it to all of its parent

It's not scanning for bootph-* properties. It's scanning for two 
specific bootph properties, so try to update the commit log and comments 
so it's not misleading.

The commit log is lacking information as to why we need to do this, what 
this helps with and why this is specific to bootph-all and bootph-some-ram.

We need to be able to look at this patch in 5 years and have a clue of 
why this was required.

> nodes up the hierarchy.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>   tools/binman/control.py | 51 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index 81f61e3e152..ccf081cb686 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -530,6 +530,54 @@ def _RemoveTemplates(parent):
>       for node in del_nodes:
>           node.Delete()
>   
> +def propagate_bootph(node, prop):
> +    """Propagate bootph-* property to all the parent nodes up the hierarchy
> +

Misleading, it's not propagating bootph properties, it's propagating the 
prop passed as an argument to the function, so rename to something like 
propagate_prop and update the comment.

Be clear also that this is expected to be a boolean property (because of 
AddEmptyProp).

> +    Args:
> +        node (fdt.Node): Node to propagate the property to

Specify that all its parents (recursively) will have this property 
propagated to.

> +        prop (str): Property to propagate
> +
> +    Return:
> +        True if any change was made, else False
> +    """
> +    changed = False
> +    while node:
> +        if prop not in node.props:
> +            node.AddEmptyProp(prop, 0)
> +            changed = True
> +        node = node.parent
> +    return changed
> +
> +def scan_and_prop_bootph(node):
> +    """Propagate bootph properties from children to parents
> +
> +    The bootph schema indicates that bootph nodes in children should be implied

s/nodes/properties/

> +    in their parents, all the way up the hierarchy. This is expensive to
> +    implement in U-Boot before relocation, so this function explicitly

I think the point here is "at runtime" which is missing.

> +    propagates these bootph properties upwards.

at build time :)

> +
> +    This is used to set the bootph-* property in the parent node if a
> +    "bootph-*" property is found in any of the parent's subnodes.
> +

This is all misleading, we aren't propagating all bootph properties

> +    Args:
> +        node (fdt.Node): Node to propagate the property to

Same remarks as for the propagate_bootph method above.

> +        prop (str): Property name to propagate
> +
> +    Return:
> +        True if any change was made, else False
> +
> +    """
> +    bootph_prop = ['bootph-all', 'bootph-some-ram']
> +

Please explain why those only.

> +    changed = False
> +    for prop in bootph_prop:
> +        if prop in node.props:
> +            changed |= propagate_bootph(node.parent, prop)
> +
> +    for subnode in node.subnodes:
> +        changed |= scan_and_prop_bootph(subnode)
> +    return changed
> +

I have a gut feeling this is suboptimal, though simple and easy to maintain.
We currently go up to the root node for each and every found 
bootph-{all,some-ram} property. We could simply divide this by half (or 
more if there are more properties to propagate in the future) by passing 
the props to propagate instead of just one. We can keep track of which 
node has propagated the property already and, for its children, stop the 
propagation at that level instead of going up to the root node all the 
time. I'm not sure typical Device Trees are deep enough for us to care 
about that kind of optimization for now, especially since it'll be 
running at build time only?

Cheers,
Quentin
