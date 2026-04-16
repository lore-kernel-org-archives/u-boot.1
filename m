Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6241F433E1
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 04:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB7583EEF;
	Thu, 16 Apr 2026 06:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EEAPoczA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2B384105; Thu, 16 Apr 2026 06:15:07 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F0683B99
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 06:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3dKGuHJ1uvTkEAd/sWNILQZW7BLgqq88YXN11SZmg1AVRCVZpFA4CY5Pnnc2AwWElM981Gykkj5GTk/ItLZ7fWe7KnTN/ga4s65E6LNy1NlHm9qakLYgTszvVCSCL5fFV1lDVrvCbnsTXqpbC7krAwfVJXTJ4qYRxOdiD5PG2+3kgaiW25jMNYOoMEq5WFA13/pBqAzcTAmQXwKxGlyN6PX+fsnmjjg8kzkcDv3rejLmBz/Eo65okz2h9eeK7CD10arNByTqSoFhhE4p8OGXZINo+iwMgcprH2oquk4Xw5Ub7QMp/F9b8FSTlm7YPQg3NMaVXLMP74Gd5LzLNDWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMNgQwCTF/IVA8EcFJNaOrlML665QObQ2I4vrOLoL8s=;
 b=UXThv8XmsHVweGsBA64b4c0XMN2WsmYjAMoSIp2sv6EdL3ZnOxJMzg3RfOeftMaxf8kvA76GLX9TL9qlZG621fIjhqWApuC8OblYZ9J9mGST26UdKRjR4AXtFmqAsqvhlqEW+WPzwMICoGdldZtKW4FrxapKi5QmnxcCw6Mq3wa5OHHhrZHeRdZ8dwVpcK4Y3LYd/Ldb3bPLHiYH3hlIjbKcvQTQrpcu8tLzZNNfyh3eQmnorQbqBrQAUIUmTjETjm3ATbUXLNKDJNtbSVR43khaHMPB+9A2FoXnCObMYmoo9RL98G79iXtjgPwfU4JuE2JsN/8So6UQF8EBLJebHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMNgQwCTF/IVA8EcFJNaOrlML665QObQ2I4vrOLoL8s=;
 b=EEAPoczAFPc0Aj/JIJjAD0mi0ON0yJ9JjJAofyZV3dbTdpxpzb6O0hwsCFClKfyg2xPxZydn6KrVzwKlP2yyovfYe+usxMGt7MiOP9eFpFjsS+koGJvOcsrbK9byV9JZ9TB7Ni/UqVL+7uSRjt/7F7Hv/AOEbAqNMp8aV4vgubcQkkvhDneUxQ32rrtbk3pZn+9EwKMBo142+WTj8NmoTJ365Zui8zPEaNKBxP+qpknb2eY4+qcDpPSxbWMHH5gUObKHZDM6IJbEpG0omuIlfKnuxMs5NcfNlwytb+4O6bdD0b3/LFYLR0DVSpl9CSxiczGwOkYQu5ahuHG++97dIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS4PR03MB8397.namprd03.prod.outlook.com (2603:10b6:8:328::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 04:15:00 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 04:15:00 +0000
Message-ID: <d0931b53-54bb-4fe6-bcd1-ebd38025ac17@altera.com>
Date: Thu, 16 Apr 2026 12:14:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Ensure FPGA in user mode before enabling
 the bridges
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260304034354.2871-1-dinesh.maniyam@altera.com>
 <a5545cd8-9a37-4793-b020-98a577598e11@altera.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <a5545cd8-9a37-4793-b020-98a577598e11@altera.com>
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS4PR03MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 6553c4f1-9e14-4caa-e64d-08de9b6eb9ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: DjpYkTyLmE+pNUnjIzhzS+M5RXVLiNA/TTNZHRTKv928qZQ6ZzpUBsMM6PxZjiGlm4oLDigFxjDylIpsrZ0Xs+hH8JfZ8627z5V2ahK1A4i8zjlw5lSyWJIuAmnyDvC1KK3Djd3VxeKuOw60TypMzgD/uEOCJoQPTcgK4V8LB7VKdU06fDxfHRNkwjswfT8Knl7765HDqJunV1tc0a1LzQ0xZOk/ps88mhk9WywcWueWK7FmfjobjL7MEj/RGcCQRImWUl09DcT7g32Ez2wIZj+VEZ6Z81pMzLr+V+rdxG84kAsu2x8kU+SzigY+6Wo+fVmbZcMVN0Y/DoNbLHvP8wxwb4HhT7ERe3YVwWGbm/vN0lpfylR6oMcxv4LwQkz0DyKBNTyqx9vTfmUWuskwBV3eO4z4mZQRQAGjDM6o8qHDxzKplj0i8H+beQjFu8dBgah1bYX4JFNIKCmcJyUHcR3lnUAkzQ3yjuE/fhw27QQBpm1WfdIO7KAG0m8mW7tphopTRUXol63qsaYIVvmKw0XHEeJdfiAyPIh9AZ8p2NSUiIVn/K4G50e0SdOnDBBNe5QdyTB8SyvJFPk2y+t27qDiYL5jGrQ1TF84W7w/gv3JYUPvtb8KpXDRMyPVJmDJCSNwMnnyFfBhMvOK55Cq33L8HCgstWCBp/BdrgFD/a5rzWlADtSCnA11+Tx9z0qT7b9sLFJjg90qn86tyzRCYcPjkmhmeVbIyLR639GZh/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpXeVIxR3B5MS9xWmVqbHRRbnk4aW9jNDlIMThvc0tOeEF3WGtXN21ZbGZi?=
 =?utf-8?B?Vyt4a2gzYTdIazlmUjV2TGN2anAxN09xdEZXQzE1Vnc4eGFCVjcvNGpZQjVS?=
 =?utf-8?B?L0ZUR0VvY1RiNG9wVldmM3lySHhVazl5RHVFWDdTR3hYT3hEdTY5cmlJanl0?=
 =?utf-8?B?Y2N0YXBROVlYOUtDNjl0NGF5cjZIRjJmYlByN2Y4eS96elRtQzRLQ1FuWndq?=
 =?utf-8?B?MGwzUUxRUkd6dE4vd0VRM2o5T1U4VldraUF3SVJaSG1VRjBqM1BDS1VnSUJD?=
 =?utf-8?B?V1dMMzNhNUZ5cURQdzZiczR5ajJjeFh4cVZJL1hGVDZrejNQaUpCOGJJQlB3?=
 =?utf-8?B?SEUrZUpZQ1draUVnN00waVJQSXY3Q0pISjV3MHdUeDdLSUJyZVJWYnkwRkJY?=
 =?utf-8?B?WHFiK2dFVFUzNDJsbllQeVhsckZGc1EwMGRxbk5pZWNDR0xVWVMyM05GLzN5?=
 =?utf-8?B?OWs0V0Z5TzZQcEJudS8yemdkRm5FcEdNVUs4cU05Q1YvbzBMdDdweUdPbjJU?=
 =?utf-8?B?WHNGYWhxMTlncEZjV2g0NnNROGtDYkJRelJ2bUhCUTRXQW1FR3pjajE2K3Jv?=
 =?utf-8?B?clBNcUM1SmVYL2xIWUhFOXRMVlgvRm4rZXA0WXRmK0lxZUp6azR3MVZ6RzBW?=
 =?utf-8?B?VFpOZGE0NVdMeC9vY0lNQW9yWUVva2JXVDNFOUZHdnhrejZrWHoxdDVxOGFh?=
 =?utf-8?B?THo2cS9rK0lKV01HWVBZZ1hsbGFJeW5WUElTenI2WHA3Z005WVBZTmo3QjU3?=
 =?utf-8?B?VjZWOVZxWUIzQ05aS3h0MThCTkZ5THBIbFFMa0pVcXFNYklaNVNmNlUwWldh?=
 =?utf-8?B?YkVjZzBpclFZTFAvd01FU3VhUEJva240QjYrajdJdGhHcFlUcUFxdGFXa2Yw?=
 =?utf-8?B?N255b0VIUE1YaHRLdWpJUVhZU2R5RWl6cXgxalhiVUE0TmJiTFpuK2NtODE4?=
 =?utf-8?B?ZWVDMjdtNUpZMkZXLzRMaHAzRTB6dVRjTjVmTnppWEM4bnhWb0JBeTVScERt?=
 =?utf-8?B?bW1OVzdMOUV1SGtWczlkVlVJYWJJWlR5V0xka1hCSmVvdXJKRGpaM2Zrb011?=
 =?utf-8?B?Mjdscjd5SVErMktBeVBCd3dqRG9aMnROL2pCd2VMT2tKOFVGMXdnTnJYQ1ha?=
 =?utf-8?B?bTRmZmVvaGZXaFpGSFVxVDQ1R1k3WFF6M2lSMGdhaTBSYktpMXZZVlNTVHRo?=
 =?utf-8?B?K3BqMC85bVhtZjJSUDE1SUdYUzVoY1dIUlQ3OWxtdWFkQlk2WllSNTdkVzFi?=
 =?utf-8?B?MWQwNk5wN2U2dGQ0a3RFNVhMdnBXZ1NxY04vNmNkb2IzQTJaTGhPNWdFZkNG?=
 =?utf-8?B?bUhydUNrY1dUSDJyRExRcWJrYXJMbEkxRVh6OUZMV0EyQ2dLWkV5SGRISGRj?=
 =?utf-8?B?RnV5VU9hTnJ6K2lKQXdtNXhRS2ZMSjZXT0VYcHpQdk1qNDJ2TW80c1RLN2FS?=
 =?utf-8?B?TkhBeW1Jd3NrN3FLcytMUm9QQVc1K25MeFUzOFoxVWJhdWl0aWt2djdqMnNi?=
 =?utf-8?B?bzlVSm9LWDA0YXVNdXdOelNBUWtudGpnYTJXYWdxa0hqTElzL3cybUlIWW5D?=
 =?utf-8?B?ZmpjbEJ0cG8rQ2RLY1p2eDg3VVNuVWRnYXpZUUkvQ3JQTXpVQzdibUw4TW9M?=
 =?utf-8?B?bmZId1Q3WmVyTWxVQXliOEcwMEROelcvUHNxbktXdVZkb3ZNK2txaW9zM0ZB?=
 =?utf-8?B?TjBwMHdXeFFKNHRaeTQvQWdyODNwSHRub1YybVlGK3FERSt4SVVwbk1JNUxF?=
 =?utf-8?B?bGRZb0JmR1dRWjUxME5obGtvV1UxRnVSNllSeGZEQmVxWTlLY2F3bEVNRjJM?=
 =?utf-8?B?MnoySWNRTE43SHhmSGgxdmhjYVFuME1oUnNUU3VPOUNBYWg2enBBYW1JTTlU?=
 =?utf-8?B?MHJ2Um5ETGR1SHZVU3FZL2FxK0thN0dkRUZkRnZSU2pKUG5xL2w0dDNEQnRM?=
 =?utf-8?B?T0RBRXBvNjFaaGZ2UEgvUnlzOUNPNjJvblBZaWsxRUkvVDFKOXFYTTAyblJH?=
 =?utf-8?B?S0Vra1QzWmpUUVdFMlhhZFJJa2NRZ0hDRlorRDlTWERvS1lrclhabHZMN3E3?=
 =?utf-8?B?c2VHNklsMWJHYkNrQk9ZYXo2d2pyQ1NOdmdXMzNVVndHbXI2MWdzSGhONjF2?=
 =?utf-8?B?ZXZoVkFnQzNjT2lUeHdqSHFlSFNlc1VpNWM4Z1JWM0VSZHB5SDRxb01UajZy?=
 =?utf-8?B?cUlCWC9Dc2xObisyazFtNTBQckpGcW8vUzJNNjRJRmV5eUpwcHFMVmJ4cnpi?=
 =?utf-8?B?MjFXYUl3VVhMOWNneWJXanJYWHd0c24zbnFhS1BkaGlleWpmcmhOaEFoUjM3?=
 =?utf-8?B?ZWMyeGJad3Q4R2p2NStqQmp4WVBkUUJMOVI4Z1ZzdjZQZGZRUXlNYVY2S3Ur?=
 =?utf-8?Q?4CRgnLeh0CjU+FiM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6553c4f1-9e14-4caa-e64d-08de9b6eb9ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 04:15:00.6897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzagYSnMMydL5uBfW+eJrRqvpKHC2Mo9YojI7P07Js5Xfi7v0/Xe8R5K/9ONRgIOubNiwwAb7LmNZi2xw9WzWx4oIlD7egENhHXamkPpOW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8397
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tien Fong,

On 15/4/2026 3:47 pm, Chee, Tien Fong wrote:
> Hi Dinesh,
>
> On 4/3/2026 11:43 am, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> Unexpected behavior and error can occur if FPGA is accessed in unknown
>> state.Always checking with FPGA in user mode is required to ensure
>> system stability.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   arch/arm/mach-socfpga/misc_arria10.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-socfpga/misc_arria10.c 
>> b/arch/arm/mach-socfpga/misc_arria10.c
>> index 7e0f3875b7c..6b25ab917ca 100644
>> --- a/arch/arm/mach-socfpga/misc_arria10.c
>> +++ b/arch/arm/mach-socfpga/misc_arria10.c
>> @@ -13,6 +13,7 @@
>>   #include <ns16550.h>
>>   #include <spi_flash.h>
>>   #include <watchdog.h>
>> +#include <asm/arch/fpga_manager.h>
>>   #include <asm/arch/misc.h>
>>   #include <asm/arch/pinmux.h>
>>   #include <asm/arch/reset_manager.h>
>> @@ -126,10 +127,16 @@ int print_cpuinfo(void)
>>     void do_bridge_reset(int enable, unsigned int mask)
>
>
> mask is unused on Arria 10—please mark it __maybe_unused so we do not 
> trip -Wunused-parameter while keeping the shared API.
>
> Example: unsigned int mask __maybe_unused
>
>
>>   {
>> -    if (enable)
>> -        socfpga_reset_deassert_bridges_handoff();
>> -    else
>> +    if (enable) {
>> +        if (is_fpgamgr_user_mode()) {
>> +            socfpga_reset_deassert_bridges_handoff();
>> +        } else {
>> +            puts("Bridges: Failed to enable because FPGA is not ");
>> +            puts("in user mode\n");
>
>
> Single line puts is preferred
>
> Example:
>         puts("Bridges: failed to enable because FPGA is not "
>                 "in user mode\n");
>
> Best regards,
>
> Tien Fong
>

Thanks for the review. I’ll update the patch to mark |mask| as 
|__maybe_unused
|and combine the |puts()| calls as suggested.

Best regards,
Dinesh

