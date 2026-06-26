Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1A9C43327
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 16:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6D884704;
	Fri, 26 Jun 2026 18:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lQEpGRVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2449C84894; Fri, 26 Jun 2026 18:09:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809238404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 18:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJnkq6Ov3m3+Aglj/xUkTjexjdSJdh9Wm44c9/dqqvupCdnKXXuGPmGfS+ndsPJ+4ND8xLsnZfivOeTl+gTvv/8V5VnwP0KBKnYkBofFL0he2tlRk67W0vm5ueZ0+81wM3M+dPvGEcox8Av/Z8mnGaOQwPX4vMZug3Sg6VqvyRwPj/98AxRT0U3lOw7cWMqwGriJqca/wSys9h2n4pKKEwhUJgJi/7ruQZXun/m9PCF599lE/hJmwsK1B8Rhrh6zeuPg+c65wle56jNMhK1v+65ui6hBncZdV+V/WWKz+5GQEkJ2keFEuELgRPgkyydr79NYOBXYY6LNkQ+55XGPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HihysN8GcNTWZaqyFYC2lZ1tYqy6qTwkDGZSC3IwSk=;
 b=sEv5JSOi3s7I5VZvam16NNLsB3A3WnLQLMw46kNpS1OLEIalFMqHtGnbD5KbDugFuC17K06NrrKupl/VmkO/CYGjAl/r+M6D2RCi/mzwQWJzGu5QwNsdT6RaqEDJUeGuB2vqp7R6ie0gqGwP/tsHgobd4rxAJDZSwHOVIF2QX1YCMlKEiF22c5T9WCaBr4ZqUvS742uhK/DBI/jb6TBnCoqRmpK9IodsK0Sz9K8ouII9uvfZcgtTQFEIHJZqj+3hIK7UuKzRMklgdCfi6vv3DMqAqicQ/o+TBRYfuufiLeOz/Q8ZP0PkQ0mROLrvT7WNwEW6hydl0ZJNuQ9U+4cFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HihysN8GcNTWZaqyFYC2lZ1tYqy6qTwkDGZSC3IwSk=;
 b=lQEpGRVNty/F0RVy92iq+4sFfJsq7egIqr9jmNqnwEOK/fSDSm0vC3v8lghCrWEdV62e/cpItMDU/88MMXaqyvYVdHr13hdQGi1I0puDuvYKV4M2qR6jjtYKguEKMy2UfaAGHlK33C4ql6C0PGA1SUiFEYj5GJR+ik57lejSoxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:09:24 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 16:09:24 +0000
Message-ID: <ca4ab5b1-6286-4e26-8836-f802d2ac4e0c@cherry.de>
Date: Fri, 26 Jun 2026 18:09:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] cros: add common helpers for GPT flags
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-2-dmukhin@ford.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260605033907.1909319-2-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B72.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::60c) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9af590-3dcf-481c-0c50-08ded39d4a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|13003099007|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: F6QmJIMSawHaVdRBnJEBABnkOrK+VQYNsQq2msogVfffobGRwjsxP8wu3DP/FtzZlyrCLMtlxXLHRe421/01W+FyfIzrqGZQWTC1rlDy5RoL8QfVyvKtOzAEStSDu5FmnkB0EeE0D2hnLrBQ9aAbO3AvyiYBPvtVH0D3ZgtYE3u3C8Mz834kCyOjH6XqyHrXnwc+gt+pN8ar89M1CX9CaBrF+VT0XXtcqCQ8B7s1E7gF1AKt5ogy1WxF1GxtsQqxGoJq6GdAd9OQbXScmxsUMQ5iJppzCzDW388D+HmpFveucx/xy6UyfrN2BrOjCVaorqBJalGNUuHK/eIRHSJKrO0R3J2Wg65EW39IMGcqooy6fTLlAkfZYscCTamWKD2UHDEHMRcNLpkIujaPHU087mqeqXfPY3ji0okB0y4BGuLxUxUXpWmL3HLo+rkMi51jpRpNiVsKUInaPl1EpjU3doEGFKEJ/GD98H1Uzeh+qW/5SgHGDXHOVoIUdLuGrDjks2kpBxIiasVSp9Yz36dpijgCyzoeYSFyt/OAAh8lzC1X4g9hNQby1pTUyVTNY7UD0zpswGuHePb7OfkaSLj8GSn2zalf+OW33Wc9Hfw+H6zc8+s35+12UXtm0mOFeuXo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(13003099007)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dngrakp4SHdTZStieC8ydTdCcnNyVUpLU1h4RW1FeEFpdFlpNWFWelVlV2dC?=
 =?utf-8?B?MEJhQ1JVZ3VJSmtRTDhIN2tMc0Z4U1p5WHF3ekpWK1EvbWROd1R0UlNZMzB1?=
 =?utf-8?B?eUtXRStyeXBUaERyV0s0d0l4T3NyZURMTDlxTTJJQmtrdUpCWURoU01oNy85?=
 =?utf-8?B?ZEdNTDZ5VnpaOW9DTXkrVVVWd1o5cmliQlBzSituNE1BWkJjbURjemtrUnZF?=
 =?utf-8?B?ZjZkZ3dCTjVUMXllcWxNUStJNThDdW4ySXIyR0ZyYnFIeGovSDhYUzczeWJC?=
 =?utf-8?B?NHBDMkFIVmZXNnRBSXBmRzBEcnFUOTFkcXVNYWQwTFFPSXdBVVZvR3k3a3BE?=
 =?utf-8?B?ZFJ2aFhRMWFzekFBREg3WDFOQXVrM1MxL0IrMzlXYk1BTVNGcGszVmVsOGtB?=
 =?utf-8?B?MDVZVWVYZkwzcExUcHZQSkZhZXV3TDJmeENQRVFpVFFNMjFzUUcxand6Ymw5?=
 =?utf-8?B?OFgyMlZJZjhYRzRjcWZ1TnFsUTl1WnlhdmVMTkVuOUZ2bzhoT1FlSElkVnJ0?=
 =?utf-8?B?T0dGMlpERGVJbkFic1NBaFJ0Zk1lMkFkODQ3YzgzREFKNDEzZFY3VnErbVBX?=
 =?utf-8?B?TWNuVzN6SFlqak4xcHFkUXBWY2JMUGdLT3YyVzhkZno1VTk5amhYTWlwS0E0?=
 =?utf-8?B?U0hoZTFrV0FFSGFDV0NOc1VHWW1SRXAreTArSk9sZDdhS0JvL0gwcHNmckxT?=
 =?utf-8?B?cXdmaSt3cHNFUjlka0k4UFpMVFRza0VEYm9RVGppUGd4eXdvT042M2ZyZWZL?=
 =?utf-8?B?WE96Z3p4NW1sSGVGZ09hQTNqMW96Ykc2VEFCd0tRSjVrNGZ0MWZyRlB2SUJG?=
 =?utf-8?B?M0ladFdXa2oyZUpEVEp6TTNBUk13dklSU0MvOXg1V28vSGZ2SFhkemZvMVhX?=
 =?utf-8?B?aFZlTXVRR2NxMjIvdEZyQ25yT1NNUXJpYTRXVUd4VE0yeDR5Qzk4aGJUOWU2?=
 =?utf-8?B?MXVvOXhzOVRHbzZKNitSUys0Ukphb3Flb0w1S21DamQwOWlMNWpucHBRV0kr?=
 =?utf-8?B?U0dVYzg4Tm5JUnRJdE5sdDNZV24zcVNWTWhvTWw1N0hLR1Y1TXNJWm1BNk1Z?=
 =?utf-8?B?UlRBSGUxc0tmV2wwTHI3M2tjMTUyclFBWVNpTGRLdE1vWDdTRjZjSk4xRWdL?=
 =?utf-8?B?Sjd3UEpFWGwrYm4xUDZVN09YR1FrME9pa0Z4ZWs5cTMvV1Bock1DbE9BVE40?=
 =?utf-8?B?RGF4T0VCZi9WeDRtdTVZKzlqQ3poRTZpWEZ0WEs0Z0daTTVKdUl5TXg4MWpl?=
 =?utf-8?B?YXRXRkdjRHdyZ3FiVFBSdmRnRVU4OHJWWlhLUjd1VjFJeG5BdEFLeXFDL01a?=
 =?utf-8?B?dFdPRmpPRUJ3Q0NnWFRNS0VITS9YcUx6RG1OOXpLQUlZTXFYaDg3S0hEeEx4?=
 =?utf-8?B?Y29LQ1FIUEEzdk1tSHNiTTZVRk1YVFlZM3l6ajVFUEpaandwZVN4OEE2ZTcz?=
 =?utf-8?B?em5JNmhCTFdGY0JiTDYvR1MwcjBJb0VRUGljL1R1ZnNrVVVJWHBzTktNeVNE?=
 =?utf-8?B?WDFaaE1MUkMxNVAzbGx6K3F5Wnc1eGlUOHRxdlNIUEg2K0pCalg2LzFjN2sy?=
 =?utf-8?B?R00yQXFYMERYWUJzUEdLK2QwcHhVN3k0c3I3bTZhcllDUStRODdlN2NBM2pq?=
 =?utf-8?B?OSt0NkJRbmYrWGdrV29tVzB4OU1la3MreGpxWTdzM1p4b1hLNHJsSWRTVW1F?=
 =?utf-8?B?Z0FqNE9wbGo0OG9WSndOTm5iMkl6ZGVjM3RKeGdPT3lzdGVOMURlcWFpaW91?=
 =?utf-8?B?SDZKTjUrZnhWTnZoWWhSZGZtQ29ybEpDaWdGeFBQSHE4UVdWZmxJdUQ2eWYv?=
 =?utf-8?B?VUFzNTE2dDVSNTlPZ2wycDlqREE5akRoa0lkWkQ5Z1FHZ2xHUkNwUjczUlFH?=
 =?utf-8?B?Y0dlTHY5aTFocGgxY2Y1KzZxR0hDOWlMRHBhTiszL0VSRFA0WnQ0b2pXMzQ4?=
 =?utf-8?B?WXdXMFNhR3Bvb01TOTQ2VWFQZHl5bnJjRFRMSnF0akZVY2FlVGQvaUd3Q2pn?=
 =?utf-8?B?aXRTRGc5NVhXQVBHdVN0emJ0TkNkREhsZENvWW81SmRKWFNhcVlNRmFNTVFF?=
 =?utf-8?B?aEZveUM2QVNnMHJ2YkNZR1YxY0FnM3YydnBKRWtVTnBhYkZJUWJicTJJNEw3?=
 =?utf-8?B?QXpnWWdVQ1I2Znk2RWZyTjFMeVRlMFRBQjJMT2hrL0F6dFRyWWFxRjB4blRs?=
 =?utf-8?B?QUFiczE3YkdTYXc4WmlXZ2hOVkoxUEpmdCtseURSWXhhWEhmVmcrV1FWTVRT?=
 =?utf-8?B?T2ZGRlFXU24vZ2tuWnU2bWpwcW9ZZGVqZDUvRVljc2xORzVoaUFmaG1tSWdV?=
 =?utf-8?B?Uy9oZTUrMjhINExYdTAzazRGbUtyRlZvS09RdU9LeWh6TVBVOWQvdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9af590-3dcf-481c-0c50-08ded39d4a5c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:09:24.5458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HnF0RbKFl+V5V4OmFIdjwjlmjpobygNmYVUz6lQUkBNRrJZFmOluaJWicO5mLz6W/5Eaob6HKhyJzAMrcyOMOXQj87AUxtMq/NcFJDiFbSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
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

Hi Denis,

On 6/5/26 5:39 AM, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Add common helper to decode/encode ChromuimOS-style GPT attributes
> similarly to [1].
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/vboot_reference/+/master/cgpt

Can you tell us *which* commit you used in the commit log. I'm assuming 
master is a moving branch so this makes it harder to look for future fixes.

> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
>   include/cros_flags.h | 74 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)
>   create mode 100644 include/cros_flags.h
> 
> diff --git a/include/cros_flags.h b/include/cros_flags.h
> new file mode 100644
> index 000000000000..e9355fa5e908
> --- /dev/null
> +++ b/include/cros_flags.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Bit definitions and masks for GPT attributes for Chromium OS.
> + *
> + *  63-61  -- (reserved)
> + *     60  -- read-only
> + *  59-58  -- (reserved)
> + *     57  -- error counter
> + *     56  -- success
> + *  55-52  -- tries
> + *  51-48  -- priority
> + *   47-3  -- UEFI: reserved for future use
> + *      2  -- UEFI: Legacy BIOS bootable
> + *      1  -- UEFI: partition is not mapped
> + *      0  -- UEFI: partition is required
> + *
> + * Reference:
> + *   https://chromium.googlesource.com/chromiumos/platform/vboot_reference/+/master/cgpt

Possibly here as well so we don't get confused if this differs from 
master of vboot in years from now?

> + */
> +
> +#ifndef _CROS_FLAGS_H
> +#define _CROS_FLAGS_H
> +
> +#define CROS_FLAG_PRIORITY_MASK      0x000fU
> +#define CROS_FLAG_TRIES_MASK         0x00f0U
> +#define CROS_FLAG_SUCCESSFUL_MASK    0x0100U
> +
> +#define CROS_FLAG_PRIORITY_SHIFT     0U
> +#define CROS_FLAG_TRIES_SHIFT        4U
> +#define CROS_FLAG_SUCCESSFUL_SHIFT   8U
> +
> +static inline unsigned int
> +cros_flags_get_priority(unsigned int flags)
> +{
> +	return (flags & CROS_FLAG_PRIORITY_MASK) >> CROS_FLAG_PRIORITY_SHIFT;
> +}
> +
> +static inline unsigned int
> +cros_flags_set_priority(unsigned int flags, unsigned int priority)
> +{
> +	flags &= ~CROS_FLAG_PRIORITY_MASK;
> +	flags |= (priority & 0xf) << CROS_FLAG_PRIORITY_SHIFT;
> +	return flags;
> +}
> +
> +static inline unsigned int
> +cros_flags_get_tries(unsigned int flags)
> +{
> +	return (flags & CROS_FLAG_TRIES_MASK) >> CROS_FLAG_TRIES_SHIFT;
> +}
> +
> +static inline unsigned int
> +cros_flags_set_tries(unsigned int flags, unsigned int tries)
> +{
> +	flags &= ~CROS_FLAG_TRIES_MASK;
> +	flags |= (tries & 0xf) << CROS_FLAG_TRIES_SHIFT;
> +	return flags;
> +}
> +
> +static inline bool
> +cros_flags_get_successful(unsigned int flags)
> +{
> +	return (flags & CROS_FLAG_SUCCESSFUL_MASK) >> CROS_FLAG_SUCCESSFUL_SHIFT;
> +}
> +
> +static inline unsigned int
> +cros_flags_set_successful(unsigned int flags, bool ok)
> +{
> +	flags &= ~CROS_FLAG_SUCCESSFUL_MASK;
> +	flags |= ok << CROS_FLAG_SUCCESSFUL_SHIFT;
> +	return flags;
> +}
> +
> +#endif /* _CROS_FLAGS_H */

Would it make sense to use the nice GENMASK, FIELD_GET, FIELD_PREP 
macros from Linux for bitfield and masks?

Cheers,
Quentin
