Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9BDC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 13:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0969287E6D;
	Fri,  9 Feb 2024 14:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="IzKo5bJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD73787E6B; Fri,  9 Feb 2024 14:46:49 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59DD687E73
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 14:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6kORhA8rByvgGa99xktsLykEVBbPpTlwkODYGpcZCdPvmFbxAARyggzLHaRAVy8USCUZ/y8oIMZuDgfRjq8U/V7P6CHgEFnA24rp5rC9GSPewEOhEHnWaYJZgaM4r1s6OuXt5ZP6hwxPoG/gZtBaLYM7mL/lwP+lV3RRs+iXd4e3D8OZUyddZqPuQeYWa1LsrnyKB+RbC5ixIoPTW8990442Alex1v0FykZ0v1q7VhOiZxH3upZ8dhEoVqEDHLs4SBMPpLa7Xkd08nMgkGMXQberIci5uWkWdjEVHF51hoX76AafsXg3rkGe+P28DEDSG5M1lI5UvhJZ4zarz99qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uQLRpvAvyXGKdqx5hFcLC+DcZtsBd8ZcNES8tXH+04=;
 b=MXUEOhbpMf1+4cYD+gBR9YpMszUeGtgJAoHqZ1JNUIcEpwgoiiasBVW7djkbvOGjj0CEo7/MAqU4TRwAOQoacef2ChP4/JzLRT204w4Tf3ukqA75D2Bd6FvrheklyIsGdTqCtlpGY/K6sUncd6WsHxIJ+fmpHsamnFSOJQtfUKW9sA+7iGvIjwdm73u/8q+EeQkOodBQyuGZKEoyoGT9fBloJhzorEydYkMqUbydnee5+v51wiJJOSDymBv83rxLL5wTTKrTgwfICL93o7+XRDq675uXGHym9GdCbUZGthvmuPaHIcGKDG+PO82yOLGD8OKPvk1WvdVCgUjE7kVgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uQLRpvAvyXGKdqx5hFcLC+DcZtsBd8ZcNES8tXH+04=;
 b=IzKo5bJJ0/z9a2M8nRrhzVGbIXyTLp/BUXPpRkLiNbKYxGf66+M5KpAIWkzGX+dVezBHDmTJpNnd1b8xXN7CcwFwbDH8Lllwp5aVn9r3X5yFgC2IMpYIw0RYOUv55lmM8Zc4LZItZbWi2koylctvZHgpvshPPoDNxRLdgqWYUkf/L4Wmbfh+t3JYV5uo98Bn7CVcM2132Q/yJSADMMWvMsIlMPktGIMcMCSPZoE+gZBnw3GppIN07C7GpqR9ecAp8fct3K5ISBrQ8GVKEx5/Zh3JKL4pi7Mw+ZZgegytKDWwTbQjTjmd40GfAw0iBXNsrzhudsUySTgdonha/ENe3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS5PR04MB10043.eurprd04.prod.outlook.com (2603:10a6:20b:67f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 13:46:44 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 13:46:44 +0000
Message-ID: <51c116ce-db96-4c74-9b96-1d2013e84fa2@theobroma-systems.com>
Date: Fri, 9 Feb 2024 14:46:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] rockchip: migrate hardware.h inclusion into
 appropriate files
Content-Language: en-US
To: Johan Jonker <jbx6244@yandex.com>, Quentin Schulz <foss+uboot@0leil.net>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-13-6c9ffe09b924@theobroma-systems.com>
 <715e6edd-4b5c-46bb-a245-3427175423c9@yandex.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <715e6edd-4b5c-46bb-a245-3427175423c9@yandex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS5PR04MB10043:EE_
X-MS-Office365-Filtering-Correlation-Id: 600ffe68-e9de-464f-cb6f-08dc29758da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ly74AN3XBtgktBFgwWIOfgLG+ajl/XI9PynS2OyxhUdWtk5IoCmuqKaOKbHCYMmuhF6M7UWk6snajpzNDLCGpOCIzwjzD5OIddSDgsuL9B/aC25KgtPwC4XFbwBrPoFImf5GFdqM+y7hBIn1xHzsHiodMfab4ODph0RJJlNSOHdnL6FlY62tuMeBSz6QwE4UeNJVOxfRI+u70j8R362swhgadsof/w69uKfNfkO5EmQHokImbvTXnVs6zSOwF+Dp7hdBIVnklHT5DgRQV+7dNRCZ8RwLZG8FoYGZZ4T/NJt7iG5sTjmiA6UHuNIfk7dUOw92rYXLrLJXZzWudjdg9Tz2PtiDya5qtMKv1WHPRl9uVmIpPFr8gjKjPSmY00s8A/IJ8zKwFPnIwlV0yu8hV8tIQp9cwt8PxFBC385jIYJingrOfyZH08k0TnI/lx7bJGcXALW/DSJTpdWqYdqYJUYCXr6ZFIaBQtCVjKPCRBTq7gkLOokOZFswvdeuOCph3D1JqFqyMK4/WP9kNEPtITr2r8QQkvfe1ROW2AzBvm9hCC/60ATUVvVGv74C9SJh3xctG3lVmfBg8edtw49UstMZbKRyyuncd8efU5QaaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(396003)(39850400004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6512007)(6506007)(6486002)(478600001)(53546011)(83380400001)(2616005)(41300700001)(44832011)(2906002)(7416002)(5660300002)(110136005)(316002)(6666004)(66476007)(66556008)(66946007)(8936002)(4326008)(8676002)(36756003)(921011)(38100700002)(31696002)(86362001)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxlK2w3NFJHakF3clA1NW8vbUVackJEZ2VUNEZ3K2Z4Tm5VNXlsUDJpalBw?=
 =?utf-8?B?SlNMV3BnQ1BJM2ZPc3JGdXJSdGFLQm1VWnREdmtYZm9JR0hOUEl1LzFFcmlt?=
 =?utf-8?B?dmZPMC9aZXFFOFhiaDVQMGlWMUhmR2ZOK1piUUZtSVRDZDNySitDbXpHVVdB?=
 =?utf-8?B?cFY0RnBrLytLbkVBWExRRFR6V0s4UWlYREhyZHo0QzM0QVhzSyt6WStjazVX?=
 =?utf-8?B?b2ZvUDBQbXladzRkVitzcUw3aDMxQ0pUK29jdDhjOHJzL1E2WU0rZ2x5KzBi?=
 =?utf-8?B?a0FubkJMS0FqbE1OQmozbm8rdUNHdW1xY25Oa3JHTHoybmkvTXJrKzdrMXZW?=
 =?utf-8?B?L1Babk1LSDZvN205ZGpnUVkvM3RkQllLaGRYWk5tcy9JdllieDlZaUJmWFZy?=
 =?utf-8?B?aThXUjNBdmd5akFPeEZyVVp3czZqRUdKa1RLejhzV3lYTkdqUWtnWnJ5aVdp?=
 =?utf-8?B?N1VEOTNWSng3MGQ4bjhodFgvUkZ2U1duNFQ5dUJZcEJvb0lqTkV2cXFmOFJX?=
 =?utf-8?B?ZGJEb2F0WXhmV2czMEYzQk1KM0FPb3BPN2JHbWZFUVQ4T09BNFdmQ2ZiS3l0?=
 =?utf-8?B?dDJsVCs2U08xa09EYjlHYVowZE1TSExWcVc0b255OXFQQm90Z2daUzBZMVhL?=
 =?utf-8?B?UDZkRUNWRXE5ZVQwRTNCV1lrMzdtcjB6OXNWejBFMHJNdGlzWGlIb2NvWi9M?=
 =?utf-8?B?Y1lhSWQvNVJRcmQrK05lVGRKWHdkMjVEU3RiQkg2cWhtTC8wS3FvZzZtSE91?=
 =?utf-8?B?ejZHNlpKRXVpbWJGd3cweHZlOXYrYmhHTENGNFhkeGV0b0t5bThwSnU3a2tx?=
 =?utf-8?B?L1ZHM1htOFpabmZvOGI4eTcrQ0tNSnNSRUtGNGkrN2svaWVDLzZDNTBjWlBS?=
 =?utf-8?B?VjhLN0tlN1FUeEJMQkZSVjk5NmR1Y2dWMmhhVmJxUXdXcit5Nm5MRXBkMXQ5?=
 =?utf-8?B?bUdHdlZ2RUFWMnVab0s1YnNPUDFwQjJyellSVkVtcVBTWW9TcllFa1c5ZHFm?=
 =?utf-8?B?MDRxOEU2NjBocyticnNLMHU1Ry9QaUlMTjBqY2pBVFdsWDV0WTVFSVlLeUw4?=
 =?utf-8?B?NFRBQXJMSjMvY2ZNR2NKd0d5bGR4M29NajJRaHdMYVF2VWRCVHQ0VFF5VUxk?=
 =?utf-8?B?YzBObHhjRUV3L053ZGZWYmV1WkdxYUtvM2IvWFdnRkIyUW90RkZJRU1CUmM5?=
 =?utf-8?B?Yndvc2xYV01TaGM1MXlNMUM3aVYyL2xkcGRReGZVa3c0MjBaUkN4a0xEQU5z?=
 =?utf-8?B?UFdtR09ML28xRWcrc0ZnNTdQcnRMK2tIYW5WVE00NS9GYVB6VUpRL3A0Z1ZP?=
 =?utf-8?B?QlhiZzhTVDB0VXFyZERvcU85ay91Q053V1JoUUF0S0VGM09JY0lSZjg5c09S?=
 =?utf-8?B?c0RzQVFVRzBrcDcrNGtHNUlNYVlhZXhMS0lrVm1nYXZDVnBoYVlFK2NpK295?=
 =?utf-8?B?TVNvS0ZZR3VSc2x2cWpVK29qelZDYTR6SmFLcXN5aExiMzA2VGh1eVFRVlVx?=
 =?utf-8?B?Tk83L3dkUG9mWXByc0llUlZXTzJsQnhBREtzV1J1MDlXVHRsQ014cFdSaTZE?=
 =?utf-8?B?WnZhK1UxVW9YSXdxdndTV0RoRS8xc2pQOXFaTTdrYkhMNlNQTTY3ay9SbmZw?=
 =?utf-8?B?OWJlenBkRXBxU0UxTWwyekZPRzd5d0hkWGErUFVBZjNVNlVhelpoVXNQa2Ns?=
 =?utf-8?B?ZHNtSGV0RFpiZHhaQzM5L0EwV0VYZzFFS2dZOHVVVnpzTmFXRmpteC9TS05w?=
 =?utf-8?B?a3BnbWNhWXpQakRGT2dmbmJZNldhenhmVVNFVkNtK1FqNW5yU2RlOUpFbEZ0?=
 =?utf-8?B?eW83WEJlN0FWL0gvS2pUcnk1Mkl6c1FPb05mOWR1dVhkQ2VKRWl6ZW4wd1dJ?=
 =?utf-8?B?RFhyaHRJY0h6UnZwWFZNQjdSZjEvWVNpcjYweWtxekI0djFLejlQdzEzVEdK?=
 =?utf-8?B?MS83eG0xNzlMNzRXZVRmMDJnUzlXYUhRTU1sMktsb3hVUjJ1M0xrMWF2Skdz?=
 =?utf-8?B?d3kxck9TVnNmdXVXS0FPLzNkVUJOYi9PUGNWK0hnT3lQcnhuazhDTklwRGVY?=
 =?utf-8?B?ZmdBNkZXOWUyR3lIczArbDMwSmtlOWRRVE5nb3c3eEROanJYRGcwYVlNaVh5?=
 =?utf-8?B?VyswcG5yTjIreEFlWm4vQ3I5bEgzUDZmdzFUdXZxQ05HVmFRVzNzWlRJL3ZN?=
 =?utf-8?B?VjFSMDFueU1GNEFJT0xNbGdjaWg4QklUcXltS01IWlRTVnpKZkJlTncvZHIv?=
 =?utf-8?B?RHBrRTRmdkdvQTlWV2lQbGo3RUt3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600ffe68-e9de-464f-cb6f-08dc29758da6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 13:46:44.5688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvPoF1A9lsLk2EjSXohGOnZdzI0uIoYfXUZ2BxijmhqmacdebIHv1N8NkCAf8qYvJ5GPCeebuK0BF2pis+VBZRHk0pRNEm4ieQc879tMwfszOga9N4ZQv8BqjT/M32EP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10043
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

Hi Johan,

On 2/9/24 14:07, Johan Jonker wrote:
[...]

> 
>  From codingstyle.rst:
> 
> You should follow this ordering in U-Boot.
> The common.h header (which is going away at some point) should always be first,
> followed by other headers in order, then headers with directories, then local files.
> Within that order, sort your includes.
> 

Good catch indeed. I'll avoid resending a 20-patch series today though.

I have the following diff that can be applied on top of that commit:

"""
diff --git a/drivers/ram/rockchip/dmc-rk3368.c 
b/drivers/ram/rockchip/dmc-rk3368.c
index 74d8aed571c..859fc47030f 100644
--- a/drivers/ram/rockchip/dmc-rk3368.c
+++ b/drivers/ram/rockchip/dmc-rk3368.c
@@ -17,10 +17,10 @@
  #include <asm/arch-rockchip/clock.h>
  #include <asm/arch-rockchip/cru_rk3368.h>
  #include <asm/arch-rockchip/grf_rk3368.h>
+#include <asm/arch-rockchip/hardware.h>
  #include <asm/arch-rockchip/ddr_rk3368.h>
  #include <asm/arch-rockchip/sdram.h>
  #include <asm/arch-rockchip/sdram_rk3288.h>
-#include <asm/arch-rockchip/hardware.h>
  #include <linux/bitops.h>
  #include <linux/delay.h>
  #include <linux/err.h>
diff --git a/drivers/ram/rockchip/sdram_rk3188.c 
b/drivers/ram/rockchip/sdram_rk3188.c
index 16a68885f1f..d23d4231798 100644
--- a/drivers/ram/rockchip/sdram_rk3188.c
+++ b/drivers/ram/rockchip/sdram_rk3188.c
@@ -22,10 +22,10 @@
  #include <asm/arch-rockchip/cru_rk3188.h>
  #include <asm/arch-rockchip/ddr_rk3188.h>
  #include <asm/arch-rockchip/grf_rk3188.h>
+#include <asm/arch-rockchip/hardware.h>
  #include <asm/arch-rockchip/pmu_rk3188.h>
  #include <asm/arch-rockchip/sdram.h>
  #include <asm/arch-rockchip/sdram_rk3288.h>
-#include <asm/arch-rockchip/hardware.h>
  #include <linux/delay.h>
  #include <linux/err.h>

diff --git a/drivers/ram/rockchip/sdram_rk3288.c 
b/drivers/ram/rockchip/sdram_rk3288.c
index ec6bdcb2015..3177051dd12 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -22,10 +22,10 @@
  #include <asm/arch-rockchip/cru.h>
  #include <asm/arch-rockchip/ddr_rk3288.h>
  #include <asm/arch-rockchip/grf_rk3288.h>
+#include <asm/arch-rockchip/hardware.h>
  #include <asm/arch-rockchip/pmu_rk3288.h>
  #include <asm/arch-rockchip/sdram.h>
  #include <asm/arch-rockchip/sdram_rk3288.h>
-#include <asm/arch-rockchip/hardware.h>
  #include <linux/delay.h>
  #include <linux/err.h>
  #include <power/regulator.h>
"""

You'll note that drivers/ram/rockchip/dmc-rk3368.c currently already 
doesn't follow the coding style :)

@Kever, up to you if you want me to send a v3 for that or if you can 
apply the diff above yourself before merging.

Cheers,
Quentin
