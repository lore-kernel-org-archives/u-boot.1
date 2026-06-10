Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF7CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BED2841C2;
	Wed, 10 Jun 2026 10:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Gv3buoRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9582841C2; Wed, 10 Jun 2026 10:52:53 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E006E84874
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7qU/yzoarj24190BFrKUoUMRF6xJ+Q3HCDZfCJ1K69H988UAMSjkP0mrnWv8qAu8TDFFR5Jm8o9pXDPuii1S4rDHs9AXCM9sSO5wtDC/SKGoJ0BJl825VNf4Eq5WiVcRMrz/4/dEkT7mx3fXkCE4kNjhLUqCriIqzKxhINCuwUPRk/PTw7CHvBtANVCoX0t441/keIfHSdKZ7zwW3JS5wQAlForJdEns6rJm2z2W6MfjYzBg3oKmEdLoQiQCT6p8Kvl5VWZ07bBhSCFh9wM8H++cAwtAmKRl4gtzJ8GALXSUq+edbqDDF+hiMS239bzI3Zt6Cz6+kS4WigNdyz3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkUOGF9pbfsccrT4+7S4RkCQhsr+vfqSm6C0uqrvZrE=;
 b=r7LTCCM/kElmcG/HsAdQ2HoGygqQlvINiT9bzly3Ud8J5AMrgNOZG0rWrLcI0MCo0ANFntBFG10YE8H4KTIqPJSdFL0BjjubJWdHYyMWd2P9R9LjTpURPXv/Lj5XREqQuA5nDNQ/rBfvYKDgR4bZS6JQC1OBOHRpn7sU56wS76zC96PAvoj7AUF87dxH+T0CMnGbyIP60lyWU/BfBOSHQBE/v8fTSw8eWNVBN9ltM/tQiltbPDcJV6wMF6By0IQDOS1j7EpaLLqbvQ2D+ZLFfds9zHHBEHbBWDWpua0e6RKPxBqbaVjk45GETQVuhW+VwvWU2hSDYqtE0hWd5Cur3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkUOGF9pbfsccrT4+7S4RkCQhsr+vfqSm6C0uqrvZrE=;
 b=Gv3buoRwbSSCv8gVqkOAHfdORoB5Oy6ESXh6cKzdk32g9/fD8rEKStjY3wdWLdvUB8nV98P+u71/mSMn4s2Il5JbSKYazIynh4INtGerpuYR94zIXrlCuu33gAoKiEDM6BiN+x8Ld6oSg6J3Vc/n3t6MTv4Eks8SfEFbDQVVeh1BHPcIXa2iPavGJx3vuYhy1uSUEaQ+HU9ARam1E3mSQg5F9F8KagHvrjIYrQYin7/B1h0ykHqD19G/+j6iri12uBeECozGn+U0iOajg3FJpdijl/5AQ4sojmOnQtwrgDZhmeLiO8tN55wxN6oOtZIaPjdufO0aPEsXGVYvVtD5LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:52:49 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:52:48 +0000
Message-ID: <1f3eb96d-13fb-476f-9da3-da3765e2f535@altera.com>
Date: Wed, 10 Jun 2026 16:52:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] spl: s10: Enhance watchdog support in SPL for
 Stratix 10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-10-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-10-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::7) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: f623c49f-00c8-4343-68a9-08dec6cda590
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: JJRIQKd56/ktMqiy2W9Rf0nQ2GW8S3BsF1K/CX8OMII1VotOCEHzcYhvb8v4uTvrKHtK7W/qqIdIO2ZKhHYXXftrMSryfhzWPbRD2ey4GWAUu0COBc6Bykz0yhM2a3KZOYC8UViCwqH/fYXdFgSd0Kc1wB7Geh+YqHpSGU43JR6bUrQhZ8dO7CuVXx2thDFksP2dOWLdgQVk84//PRvauUnnJ3Ihh1fjnvWN6kflm+xTRCjoS9INYEycEeWoL+x2VZUFgX2IVoOLlCD0/OyNv+RR/asiTu8yE0dJYJYnACWceKaNdZ/GwGh3wH6fkOjqHlwI2j/8SomHhjMEsHK/nmg7DYk480LbquEQYu8Q22fj9gtOGjCRHNzOmuTXBj3DMqs3n6jT4/Bh4MSjz9soCMw34pi0dZJDJEwn1BgIry/KqQH2tWWT2AA+86aRTijop393t/DydImySnjcuzcjKmZq9YiWBYS1vMFG3UpchuItvyXql09Hqk9VtZwtzbo/noGFtwMqO0pkFP4jfb9dI5X8fqeUFFBc1FeDWm14mu9i8Rhjvao7yg9GG7bPoHG3ckDrX4jgyh7J22pP056rJ5ED0f+Vu+EUs+F1mvHFVeIb/sFpHn8XCw48K5VXoVuJBR/mLdOsSBSNL9dNrdEu/rbSyPmdHY7AxC8uOLVY9ElBecQniXy1Y0xqoocBvWdm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QSthS2x5Ny8vNS9SVUpyK1AySVNqR2E3WnBxQmFZYk5PZzBXeW1jTmZFbVNL?=
 =?utf-8?B?SW1jVDJzdWk0cVduSTRvdFpHZE12eDBidlUzY0Y3Nm5oNlVlNnNKZHdzRnlq?=
 =?utf-8?B?eDNQRlJIdUgwQ05RQ1ZTU0hyR3VhdU5uZVdEc1NhLzNsdWdFM2xHNWptTHl6?=
 =?utf-8?B?YVJ1R0JHaHVFNDMza21ISEZnbE15VVRlR0g4TERIRVdncHEvWUZCZTkwWE5Z?=
 =?utf-8?B?NXNKYVhZK3BwUDVEMFc3Wjk0bDR2cWpHc3FZM25NcFhicHVHeEFwVUdFRm9W?=
 =?utf-8?B?TnlIL0NWb3lzak1Xc0h2Y0lZQmRJTml3VWtabXpWR0dhVzJ2UTA4d1ZkMUhI?=
 =?utf-8?B?dW1UM002azExQ2N1b3Vuc3lKd0RTdWtLaFNnUFVYQWFKZENwSWJZS0xtTk50?=
 =?utf-8?B?OC9mNmxqVld3TTF4RHRYY3VDN0RyNDhUMEZEOWEwdG9nNnRKVkpCSnkwM1pm?=
 =?utf-8?B?NVAyL1liMGluVWdVOFBVMWNrUnMya1BYZVFSUDQyaGpyYmFvN242ZTVTNHZF?=
 =?utf-8?B?WThWOFBJRGRSTVlDRnNONVZzVVF4RkdYT0NNWEFDSWk0K3Z0TTA1VzV2U2c1?=
 =?utf-8?B?Uzh4akdWS21rSnlRVTdxeHk0cXo5Q2gzODN2dFZTL0Vsc3BpVHMrcEMwNjNr?=
 =?utf-8?B?anpWYWRKTVRZWHUxVHBLSVdsdHdjSSszcTVlWXhpTmZMK05JM1RQQ0pXYmp0?=
 =?utf-8?B?QjN6Q0hyZmkrU0VPZWxYSkNNeFhOQUZQaTV2YkZFRWlQeE1WRHZjTmI5RnA3?=
 =?utf-8?B?REN6QktaZ3NaL056WnR2YUpFVjBSU1ZjNFFXanQzTWxLWmtDVm54ZE02R0J0?=
 =?utf-8?B?b0tFd3VuM3dpVjV0aC94M3dMREI0cjNxdE5id2YvNnBvbmtGVW4yazJHQktU?=
 =?utf-8?B?T0ZYZ2pBTE5JZEdiamgzeURRSVR2eHNJMkFMM0ZDVkwvREx6Wng0d2Z6a0oz?=
 =?utf-8?B?U2FPSmZpSUFUSU9YTUNnWllnRlVjZklNZ2JuR3Q2WDg1SWlvTDlQM0o4QUR6?=
 =?utf-8?B?SkdKTUxmby9LVDF1NVB6Y0JqanJKSC9sdTMzclFVZEpmd0lRWG11Y0xpTFA0?=
 =?utf-8?B?eWNBY1NmdHNqa0xlUFFaSUdsaFc2empvS2J5dUtTNlNsRHRkUEdiS2RkaDNt?=
 =?utf-8?B?VlZscmdkUklLbXNUS2I1MGZ2V3g2d2NnUjh3V1NGL2toZVl1TzhjMGY5L2xT?=
 =?utf-8?B?Vm56SU5TQ1NLbHFZRFZMU1FhQndEVTNhWXovRkNLVkhZNHAyU1JHd29seFdy?=
 =?utf-8?B?amdmVWx4Rzg5ZDZxVHNCWFpsenA2NW5TVUwycU10L0ljNExYZWROa09zS256?=
 =?utf-8?B?a0N1RjdaOUsydGZCRGo0eHdNeTFFU0FWMWtPZTVWQkpUenVKOXJ3TFdVY3oz?=
 =?utf-8?B?T0lOZjZaR3E5UDJ6YkJlL3JRRmFDcUlVbDRLaVMzNHNRMm5acFNLTlNjYzlM?=
 =?utf-8?B?SllWNSs4V095alNWYUQvVDBBVjBWaGNoTWIyMjFaamZSNzY5Z1ptT1RlNHVa?=
 =?utf-8?B?VXJhOHFpK09WYm9xNDdOdWFNUWtTQUUwOVE2aVpxcEVxaHV0b3BjYnp3SU90?=
 =?utf-8?B?Nnh3RzJJSWRZZGoxOWxNVVpnM0FNL3dSM2lURUIrZU14dXkzaW9KYUdtQ2tG?=
 =?utf-8?B?Nm1MTk0xQ20zZ1hTaWlYWTBwMTVuSW5RaHBZOHN4ckRLWkFZeXc5dGNxSWt5?=
 =?utf-8?B?ZTl0d2d6ZFJhbGV2QnZxTkwzRTZvbXZUNlFWbE9SK1gvRCtzbU5sQUR4ckpL?=
 =?utf-8?B?OGlYRmFlZVFUdm9Mc1ZNeGRVSENud0Y1eEs4SzZuU0F6UXlLZU1nU0dUZ3FJ?=
 =?utf-8?B?TDJxSEtPTENHdEMxbEoxTEFkaElmOFBPWjlIYnhKNGNlWGl3UWxsa3pTUnFU?=
 =?utf-8?B?UUJ1YUhKYTJOajhTWFNlTjdzcFZLeUtEcE15M3NUa1lzNFdjVG5rTUhTUGk0?=
 =?utf-8?B?Nm9QUldidlAvZDgzV2s1L2RBSitLeExFSDFvVXpieTVZMW5oY25jTGRFalkx?=
 =?utf-8?B?bHM0czI1TmN5LytnTnpWZktIYTUxUXorQjI0b3BjSVhaUUUzOXFEV3NxSDl0?=
 =?utf-8?B?ZDlMM0FoKzFBcWdSR0h5Kytwb01PRTU4UFgySUdQOVVnUDVDUVlyK1IveWJ1?=
 =?utf-8?B?cHhuRFRiY3NmQ1JYUzhxSUN3ZkVUTTFNV3NDT1ZBcUl4SGt3eWcxYjVacG1E?=
 =?utf-8?B?MW13UHl4MUFqWlJYT1VIdFhaaElpUXFHaWs3dEUvUC9CUDlBQm9EZlVrd1BU?=
 =?utf-8?B?WjhSWjZraHp4WEh2aFVtS3dNY2ZpVlVpc2g4VXg1OUZPSkErVWdQdzl3Sk1x?=
 =?utf-8?B?dnZOejlIL3c4RUxtTXZxYWZ6c3RiNG1OeEJ0WXRlRXlpOVNGMnNrRDhCb0hB?=
 =?utf-8?Q?B8JLUoZ59aMTpT2E=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f623c49f-00c8-4343-68a9-08dec6cda590
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:52:48.4218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BkVlbCO/B2t9nrkQlOjxYjxLKFKeGhOKIhP/9vAnxHA4RkgstQ2jQKdB5iaSlwMALGJOOJ+XxEUDUfOQLXXFPHzsd/18i2R5jMA5Pjhcj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6324
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

On 5/6/2026 9:55 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Watchdog should be primed before longer, failure-prone steps such as
> firewall, SDRAM or QSPI initialization so that if a hang occurs in one of
> those steps, it is able to trigger a reset.
>
> Switch from the legacy hw_watchdog_init() path to the driver-model WDT
> (initr_watchdog()). This requires clocks and reset to be valid for
> the L4 watchdog block, and so it must run after the clock manager
> (uclass_get_device(UCLASS_CLK)) succeeds.
>
> Enabling watchdog immediately after clock init keeps watchdog coverage as
> early as possible.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Commit message improvement
>
>   arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index d803c13cdd9..1711688cecd 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -18,7 +18,7 @@
>   #include <asm/arch/misc.h>
>   #include <asm/arch/reset_manager.h>
>   #include <asm/arch/system_manager.h>
> -#include <watchdog.h>
> +#include <wdt.h>
>   #include <dm/uclass.h>
>   
>   u32 reset_flag(u32 flag)
> @@ -54,13 +54,6 @@ void board_init_f(ulong dummy)
>   	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
>   	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
>   
> -#ifdef CONFIG_HW_WATCHDOG
> -	/* Enable watchdog before initializing the HW */
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> -	hw_watchdog_init();
> -#endif
> -
>   	/* ensure all processors are not released prior Linux boot */
>   	writeq(0, CPU_RELEASE_ADDR);
>   
> @@ -80,6 +73,13 @@ void board_init_f(ulong dummy)
>   		hang();
>   	}
>   
> +	/*
> +	 * Enable watchdog as early as possible before initializing other
> +	 * component.
> +	 */
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();
> +
>   #ifdef CONFIG_DEBUG_UART
>   	socfpga_per_reset(SOCFPGA_RESET(UART0), 0);
>   	debug_uart_init();


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

