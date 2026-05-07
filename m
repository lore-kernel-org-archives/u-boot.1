Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D88CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C95F84BA3;
	Thu,  7 May 2026 18:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DyF/4MMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2EE384B5D; Thu,  7 May 2026 18:41:11 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A9884BA3
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcERLQbNhkuxXWQcaEYIn2Gt4FCy/iCc+MiGD1dOh31hQPO/dlnwxoKfSCv0PHkgCgknSsWUjNcOVsRMVdpwOtKtUcnRRJM1jaZ+EexUebT5+rbn9pDw7ZJr+xCnCrMKmPcw6ljC0Kh4bxwF0x/1Ieurtk/Cb9bZ3a4hCXrXKoOZZ/plKSOgGveUIaBKNFRH70Fmgd5q6cncQCeUHonpF2KgIRedP6S7gWqIzjAsJwZMBTcAVxvA+EHN7U22r505l3/x7Rn4PPr1UABwmYXkYBZQQOow3sfnxgoTpq77zPEYsUmw0iQ9ToebKhz1udM7viqTQGS0zH89L/7lXBUjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28Lo3SZPTD5V4ARRX8lnas0LSASbf4/9Di6p7tqRWSo=;
 b=W6aIpI0oSooDtHEVUqBMGMbgFOFm/SSXau+w3zWj4emdpeqVAibdNxRnKL58lFLdYEPm4/lR90YC/Ltk8xe/tWQMO37S1WDvo9oceKN+M+EoJvLfME3AYxIT80hcUOduBiDiPaag288oHfYYnqwLsRX/jfWAAgOmpYyVvpMyteyG/ToOmJMq/oTJwkeMOUN2rZjXTktYKsKIU1ShCPn40KH5h3dF9dRi4NGmaqPhGD2V+a1O1dsU0c4sJaxJzZIHfEe7tPqC20vkVm+lShAYiITYvErEYmSCMnjJmAI8sipT5x8/pOi3+WWwYZPdFyIHcqCCKIO3VTPU0hpFFw4MFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28Lo3SZPTD5V4ARRX8lnas0LSASbf4/9Di6p7tqRWSo=;
 b=DyF/4MMkyagJGMmhSnyeEmJThJBIqKjdIM+dT5a9Lj40wJGnBJSfFhuZI4whfU+spa9ZNMvHYXAxXtJUynQLaCYvxyXnO9Qow0QRLAxclO2Q5+2SKoWoP+h6r46dK0xJadvfSOsJU9/et5IECCaBS8oFsljfuEO4AQZjTU2JOz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB10840.eurprd04.prod.outlook.com (2603:10a6:10:58a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 16:41:06 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:41:06 +0000
Message-ID: <e56575db-0e48-48e0-98d6-a5dfca06dd27@cherry.de>
Date: Thu, 7 May 2026 18:41:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cros_ec: Sync ec_commands.h from upstream Chrome OS EC
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260430113937.1274693-1-sjg@chromium.org>
 <20260430113937.1274693-3-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260430113937.1274693-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed8370f-6904-40fd-e5d3-08deac576f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: CcfscwXOMbBpRBHfTkMpzksAJfgvufeQitzYVgNYHG4euNhwSZDpFkpTZGZnk6ov+E60fBzsx9EmRThk61NMhxo7Pd+NcGsLPAvm5W1FSXTqo0XD9ZdqRMm6ENHHvedyU/mdN/Rf7fLNfRSgRlXswHqTt8fp4TRmsBj37Hj41JszeE8nGnIP0zrui3TY4r8ceTm1ngGnMYWC0w+LNIurrrjS9IM9JjZPX/ukYABs6zXH9z2DlZuybtMjrGt7F0hDclp238ePmy7cDL40lU6fai19p9eQsIpwtVftDhRwa2QxFGarzlLftAF7PDq+s+tPN8QrFVyFhmgfLoEQ6tqhKHiESX5sEsvAV9NndimuGQ74R0GCb24efKKAkZ3gV5umPJRE4vtkob3TQSX0OhXhAQh0PPocsZ9zb1BDP/XVxXmWUqPabo4rnuNphSd8bkoh8IuM4QTQQjSh/fpondS2T5b1qzQspEmAKdpJFS44VCSPU/WR1IrGQZTtRQwXRkcEMnccEDXn17OQPwP89ijaQrjNI5hbHEK3Usdw8GPYJm89o9Br8XVXP+FAFFqpUBmV4JwwBLYFJlyN/fS6FKejyQnFwiKHV6eCUWqRIherb4O4Qn5Z5LGbCBIS+Ir240SFGbQlenoL9LjGzjq0UY7Ixw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdFWjVMdEZ3cXlySXFTRHM0WjlkTGpUTmY2NEdRNlpIakVWdHVMOTJLQXBx?=
 =?utf-8?B?WDNoMzVXeUZPV1ZZQXRHZWM4N2I0NGNjenFEVFgvSDFKM1VUaDk0WEd2QnIx?=
 =?utf-8?B?OFB2WlRDNS94cnlUaDdRT0JzMmhuM0NIQ0JHRU5qdzhxV0tvMHhjeVhiUEFN?=
 =?utf-8?B?TlFTVmdVTEI4aGRtWWVBT0VqYTVBTytwejA2dlgwbmlmK0pCampjLzN0eXpH?=
 =?utf-8?B?SVUrUHZsdnNiRURaNDhVSzVXeTRvYktXV1JaYjJaS0ovTDk5MGZUa24yNHF5?=
 =?utf-8?B?cTNiODdwbklPVE8yL3I0cXE2SnVNSzY5ZHJyb0ZLOHZSanl6MjRIaWhGMjdh?=
 =?utf-8?B?dGpDdXdNTGpCQStrV3dZNm1FMXNGN1FOVXVGeDQ1b05pd1FoTlB0MlNOMnNV?=
 =?utf-8?B?bzYwS2lKa1NpMW5zQm1pai9BTzJieVh3NHY1Ty9SdStSS0JxRXZvSVdIL2tw?=
 =?utf-8?B?WVdBVVpoSEJhcVl6RXRBREtEUzJHZVlsRUFHVGQ5OTFMcVdhdkI2UXR4Ukpq?=
 =?utf-8?B?TjdjU3FjdVlDbHo2eStoSWRHbUx5eGVkUk0waTZXWnp2dzNkd2lXdWFvOVBB?=
 =?utf-8?B?dWFoLy9GTDJWUVBUdksyMWs0Y09FTGtFeklHQW5EN1VrM2hSQzBJajY3Sy8w?=
 =?utf-8?B?bUN1dHJ6SHBzbm9FSVpCV2R5S2M5TWJlUXZRb0I3UitmdlZySjl6QWJmQWdV?=
 =?utf-8?B?QXhxWDdFbTNtRlNhMzVLaVBaV2NPWmU0ZnYwaHBjQTVwS3hBdytrb1E1cWZy?=
 =?utf-8?B?dFM4STJRRW1nTHM1MHhoYWtrdzdVQmhhbVpkWlFyeGphK096czZSZGVlZDJ5?=
 =?utf-8?B?NWliRXdmR1dwc3p6bnpjanlreFlaOGEvcVdlckFnaEsxY0ZnMmdqT1lMRVFK?=
 =?utf-8?B?bzF4cFVmNERZK1NzbDhOdEtTRkFQU0VuMVRoSGVnY05HWUZ2eW9RcVV3djFF?=
 =?utf-8?B?MDNXSGpxRVhpN3JWWld5YUozY3hpTlpGSWp5RW84T3pVK1lWYnVoaXhnQjBp?=
 =?utf-8?B?WG5PbWZQMlJYNUxKUHpiR1JKSjlKSUtTUVkvVnhVVVUzV0l5Vm04TUx4YUlI?=
 =?utf-8?B?Y2VmRVRNZlVoMFJvWFBUQUNQWCswcEhoL2F5eExsQy8wYm1EZXBhMnlDaWNL?=
 =?utf-8?B?VjFDNk1YOW1IZ0FzSDRROWpTdEczRkV0U2Z3MFlDcWVVRUwwdGNPMTEzaElh?=
 =?utf-8?B?MGM2dkhyM1BaUHhFQVJEZHN0MWVWbVRTNnYvUVZhdzdpeFNOOVZlcVBNWHVP?=
 =?utf-8?B?MjBlczlkd2lObTFVUEREMnNnNEJKcElOVlM2MUxJK2twUU5McERCNmltSWZE?=
 =?utf-8?B?dzUzNm9CRmJENEVudlQ0dWw0YVJkNzZwMzhxOVhEeDZVU1p1M3FSeEhSSGly?=
 =?utf-8?B?Mnlyci9ONFFxQWQzTkFTQ1VKQWZVWFJBdWhscm5ES2tkQzhGRWVoNWZ4enBm?=
 =?utf-8?B?bW1ZYlZlWlVsWFJyTzNXYkVwdDdwWnpIdkQ0RHVKQlEyTncxaHAxR0d6L1Fv?=
 =?utf-8?B?b1V3R2dpcTMyeXdsdFIzZ0ZVTStwcWN6VHB6anc2ODEwL2dLWmFQakluVm40?=
 =?utf-8?B?anBWRkI2UVJjb0dvRXpqRUtURVE0dWl0anFtTDhsSGJ6cmJpMG9HTFM5cGZQ?=
 =?utf-8?B?T2I3b2tKNUM2MEFndHlJWlJwb0hKQ1JGYjkxU1lUYWMvaG1Mdk9oV1NMSDN3?=
 =?utf-8?B?dHpHN1EyVTVSdzZQcFBWZTI4WGNqNGVObXE2M3dWa3VhajZsNGUveEN4VFlF?=
 =?utf-8?B?VWlTTTF4QS9zRDV4WXJQMlRGMDdBdlFIOGNCWWQ5eW4wTnZQaDBQRFdKeDV0?=
 =?utf-8?B?UFBPb0hYdnUycnRZb3ErUlNQUnFuei9mQXZLclRxdmtVWlBXcUZQcmVGM1Z1?=
 =?utf-8?B?WmlGbnpyaDhlaUxlN3Z5dmMwZ1haUGE4WTQwLzZ0Mnprc3dkblRKanFnN1RD?=
 =?utf-8?B?b3liRjFoUnczY2VRQ2NFOG1vVnVVLzJnaTVyeFVQSERGNXE2TXVVcitSYkxs?=
 =?utf-8?B?NXpJK3JTQ1grUUtyQ0FVbHI3dnkzYWNod1pvVVIvdEdhTysyamN4WXExaXFR?=
 =?utf-8?B?b3FDNmlHREtOVjFNRkx5UkQ4WjJOVERGUkFIb1Yva1J2Z3NzTTBoT1dkZFZZ?=
 =?utf-8?B?aVRzZzNtUHpyd1BTQ2s2ZGNqRnRuMURwa0wwUTNBeVNDWkMzNkowMFhJcmJz?=
 =?utf-8?B?aGt5K0RJV0hBWXlLc1dabFZlcUV3VG00MFhud3paQ1pCM1JKckNIZHRFTkox?=
 =?utf-8?B?R1lxV0tJc2J3WnVLVVFnM0lhbFRVV2RwQ1hiMGh5MDBBKzAwcnhFMHhqUXcr?=
 =?utf-8?B?cHlLRjFoMlhULzBIc2cra3dzelhJaHhQWGhSclB6MVRSVDExLzBLUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed8370f-6904-40fd-e5d3-08deac576f50
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:41:06.3861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udKWj+94s/zGoPH1k2zNl1dFLdWjyYqJymdEaVr7fV7hhgySqQLvI1vTzOxfYxos/oReIp9k8chmVB/o6Bal+BvWMygZTUX5fIfSrmmsEZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10840
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

Hi Simon,

On 4/30/26 1:38 PM, Simon Glass wrote:
> Sync include/ec_commands.h from upstream commit 4f3d17aa34
> ("skywalker: set SLEEP_TIMEOUT_MS to 50 seconds"). The new file makes
> two build assumptions that do not hold for U-Boot.
> 
> It gates '<linux/limits.h>' on '#ifdef __KERNEL__' for the Linux
> kernel. U-Boot also defines __KERNEL__ but has no <linux/limits.h>,
> and the file references no limits.h symbol; widen the gate with
> '!defined(__UBOOT__)'
> 
> It also hides '<stdint.h>' from __KERNEL__ builds, leaving UINT16_MAX
> (used by EC_RES_MAX) undefined for U-Boot; tighten the gate to
> '!defined(__KERNEL__) || defined(__UBOOT__)'
> 
> Adapt callers to two interface changes. The 'ec_current_image' enum
> tag is now 'ec_image' (EC_IMAGE_* constants unchanged); rename it in
> affected files to match. The VBNV-context interface was dropped

Idly wondering if we can have a patch doing an enum alias? A "pre-patch" 
that adds this alias, this patch which syncs the file from upstream, 
then a "post-patch" which removes the alias and rename it. Not sure it's 
worth it but was wondering if this was something C could do (typedef 
likely won't work because it removes the enum part when specifying it?)

[...]

> diff --git a/include/ec_commands.h b/include/ec_commands.h
> index 23597d28b2c..b131aa0a414 100644
> --- a/include/ec_commands.h
> +++ b/include/ec_commands.h
> @@ -1,31 +1,91 @@
> -/* Copyright (c) 2018 The Chromium OS Authors. All rights reserved.
> +/* Copyright 2014 The ChromiumOS Authors
>    * Use of this source code is governed by a BSD-style license that can be
>    * found in the LICENSE file.
>    */
>   
>   /* Host communication command constants for Chrome EC */
>   
> -#ifndef __CROS_EC_COMMANDS_H
> -#define __CROS_EC_COMMANDS_H
> +#ifndef __CROS_EC_EC_COMMANDS_H
> +#define __CROS_EC_EC_COMMANDS_H
>   
> +#if !defined(__ACPI__) && (!defined(__KERNEL__) || defined(__UBOOT__))
> +#include <stdint.h>
> +#endif
> +
> +#ifdef CHROMIUM_EC
>   /*
> - * Protocol overview
> - *
> - * request:  CMD [ P0 P1 P2 ... Pn S ]
> - * response: ERR [ P0 P1 P2 ... Pn S ]
> - *
> - * where the bytes are defined as follow :
> - *      - CMD is the command code. (defined by EC_CMD_ constants)
> - *      - ERR is the error code. (defined by EC_RES_ constants)
> - *      - Px is the optional payload.
> - *        it is not sent if the error code is not success.
> - *        (defined by ec_params_ and ec_response_ structures)
> - *      - S is the checksum which is the sum of all payload bytes.
> - *
> - * On LPC, CMD and ERR are sent/received at EC_LPC_ADDR_KERNEL|USER_CMD
> - * and the payloads are sent/received at EC_LPC_ADDR_KERNEL|USER_PARAM.
> - * On I2C, all bytes are sent serially in the same message.
> + * CHROMIUM_EC is defined by the Makefile system of Chromium EC repository.
> + * It is used to not include macros that may cause conflicts in foreign
> + * projects (refer to crbug.com/984623).
> + */
> +
> +/*
> + * Include common.h for CONFIG_HOSTCMD_ALIGNED, if it's defined. This
> + * generates more efficient code for accessing request/response structures on
> + * ARM Cortex-M if the structures are guaranteed 32-bit aligned.
> + */
> +#include "common.h"
> +#include "compile_time_macros.h"
> +
> +#else
> +/* If BUILD_ASSERT isn't already defined, make it a no-op */
> +#ifndef BUILD_ASSERT
> +#define BUILD_ASSERT(_cond)
> +#endif /* !BUILD_ASSERT */
> +#endif /* CHROMIUM_EC */
> +
> +#if defined(__KERNEL__) && !defined(__UBOOT__)
> +#include <linux/limits.h>

I think we want

#if defined(__KERNEL__)
#if !defined(__U_BOOT__)
#include <linux/limits.h>
#endif
#else

here. Such that the BIT/BIT_ULL/GENMASK and other macros aren't defined 
and then you wouldn't need the first patch in this series.

> +#else> +/*
> + * Defines macros that may be needed but are for sure defined by the linux
> + * kernel. This section is removed when cros_ec_commands.h is generated (by
> + * util/make_linux_ec_commands_h.sh).
> + * cros_ec_commands.h looks more integrated to the kernel.
> + */
> +
> +#ifndef BIT
> +#define BIT(nr) (1UL << (nr))
> +#endif
> +
> +#ifndef BIT_ULL
> +#define BIT_ULL(nr) (1ULL << (nr))
> +#endif
> +
> +/*
> + * When building Zephyr, this file ends up being included before Zephyr's
> + * include/sys/util.h so causes a warning there. We don't want to add an #ifdef
> + * in that file since it won't be accepted upstream. So work around it here.
> + */
> +#ifndef CONFIG_ZEPHYR
> +#ifndef GENMASK
> +#define GENMASK(h, l) (((BIT(h) << 1) - 1) ^ (BIT(l) - 1))
> +#endif
> +
> +#ifndef GENMASK_ULL
> +#define GENMASK_ULL(h, l) (((BIT_ULL(h) << 1) - 1) ^ (BIT_ULL(l) - 1))
> +#endif
> +#endif
> +
> +#endif /* __KERNEL__ */

Cheers,
Quentin
