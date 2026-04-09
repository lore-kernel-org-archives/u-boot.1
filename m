Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E69DE9DE6C
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 08:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F78F839D5;
	Thu,  9 Apr 2026 10:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mnHObMOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8B983CF5; Thu,  9 Apr 2026 10:53:23 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE47383693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 10:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgXH0qkvCJjosDdpMAM5HXdn6J7qDHtwG9NYuLqveS4o/TdZfj/2jAiQlbvim7VK0qtnubdya3tFcIjV3DyZOcH1ZnExrs+qllKy9Q3Cycz5AdeuoP+WiuTYNQNZHoprOURd0jH+JNALAk7s0YFLfJwcpyACekSRvaPVyX0zIx9L8PDAjqP0xDNF9CBH2wsnS7sPSHdpzkDzyrbB0pYoD5QGyyr4U5zcvWv6sztFdpNwPAlNvAosiRfWlCw+LyFKR/9myHe7/M9/zuUV1nD06gektxsuhrvnCOp/NeGu+CqmswJVHGaYvgvwOA/ZDAFd5ODmcanHIXAkmx/5dZwLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3bEwNqP/hIG4lTdR9MqmbzrwIkjy08GekqK0cgaYk4=;
 b=euBgYJgD8eouclSMdTbC/dN5Fj9uUtl5j6vZ2DOCoEQPUak8kgTw3iLnberubFKZQnunrdF5TNIrSudO3GzOAu9BTjltJmsgkraUJJn5cILkBBL9REOXt89j+L2a5Eg7psEIptNyLPFR+ULG5e7/9cGFhZbYHa0WzPJvepgIgxzVB5L/b/YBTJSGaVMTzoSObhzTPcKK5ZlN6PRNNf89tsrPC8TulJDON4B7mSavgZi+pqwTS8E2RF0XabQLaEPR505yJUaEdkry+IRzfbcMhjqqJ7s7l4NlDKcochjcCz0Cp26cLyPinF/Regb81YgkHCfeyr9pb4Fo+4LXxpHGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3bEwNqP/hIG4lTdR9MqmbzrwIkjy08GekqK0cgaYk4=;
 b=mnHObMOte4U2Qi5u1jx2uV2ErY8qjZTXLmHToxjYHEFipCSvHgg3qwGH25pakbFmLpv8O+I0z+bRh7cG8RDUs4ZAeEdO1Ils/2XgGCwIop9C3d2hcgflRHHwm9BgXFHHG2uej9Op14fN73iTheRnlSEwESIfB7cqpxlyVnqcTNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3679.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:134::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 08:53:15 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 08:53:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
Cc: u-boot@lists.denx.de,  Ngo Luong Thanh Tra
 <S4210155@student.rmit.edu.au>,  Alexander Sverdlin
 <alexander.sverdlin@siemens.com>,  Casey Connolly
 <casey.connolly@linaro.org>,  Simon Glass <sjg@chromium.org>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2] common: cli_hush: fix console_buffer overflow on
 boot retry
In-Reply-To: <20260331032525.62304-1-S4210155@student.rmit.edu.au> (Ngo Luong
 Thanh Tra's message of "Tue, 31 Mar 2026 10:25:11 +0700")
References: <20260331032525.62304-1-S4210155@student.rmit.edu.au>
Date: Thu, 09 Apr 2026 10:53:12 +0200
Message-ID: <87zf3co6pz.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CPCP307CA0001.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::11)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3679:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e84c9e9-1ce7-45e1-6c90-08de96156f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vfFfV2xpQWnKu9mBLs8410airlbDpwQqwTk1g2lqTyj+/1KukZM36hRJcUKqRcCL6HkvD+eK02E/N7sBMRPGDT4ES6zMql6r7xjJrsaZNb+311GZFvyqgW1Icsg7/9YVP58fwZ6MFLOHq/OO57gnjMnlql/gF2V+BnAztdhOFw7MTrJFR7JcJstGMMTCDpjb3Pd7ckDKf1HB9+ExRL4mRgFt5M3nyYAWto0B/TS7pGRR96jr6m/4ThdmtsuFLoDbVXQdgcllz279CSRqGIky2yP9KSEVwioJzAIbKHY5N4lTxeUwHUqTH2I83uyRCGSlBmZ2EwEhaGbkcFT/q+2KCeX4mulUbXONFxiN/gx4OdWTm4oc48ZYBkh+FnPX80yxGlHh9iR1t4xRfclTH17BiJBjKub4vBTpPezeLM5L26yBxkvsIzaIE4j5CMolSOBds7PE+oX23cpnPmxbeVjKXHfANPjCxG0j5RiF9N0eRCgcD9f3JPwDMpPHQ7MP7B65kNt4WTlS4QAiTh8onLDaaCJxR5gEaX/YTJjTNcfi6u40u9331rHCvwCNMPH7faVWbbrjPZfgO2CwBBBIHyGQ1S6BxzmpHmOxXNbWFo27azHR1CrEfT9NwS51zbn1zL3wa2x1sqk6zPUdeGDxZ7t6MBa8c5m7VLvlQBNNb7v58RrW+/6jR5XFQyRYEQ8muxk1O491B1UkOn49MNS8gynZmrwbmHmxonQ7Jdz1fRkLfh2OSTmgpbJNscORfm4/1Xrmk1RjZI+tg2XPG3qrIQuB5uxuDlzjigu56gq9zWnNibI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JkZFIyc0JpcklzT0VUdnVDNnc4LzJRL0FtdTJZMW9BZnRMc1g1WUsxTlRi?=
 =?utf-8?B?Ny84UE04d3E2YkM5TVBObE1VTXNFL0FsYWVDenNlMW14eE94MzhwTFhBc04v?=
 =?utf-8?B?d2tlNHBkeXhSdTlsZzR3Y0FoeE4va2EyMmFxcW1EWVAzNnIzUmxvNElRVllw?=
 =?utf-8?B?WGt0L1J6UTMrbEgzMHBJd2xMTWtERis1cUVoRjlJR09ZdjNybTdRTlpmaGw0?=
 =?utf-8?B?bkxXdmVNMXE4aXBTZXlwVnFGNW5xalhmcUhpKzFhcFlaUlJsRWpkVjExSTVo?=
 =?utf-8?B?d2RKcmJGdWdjZEd0TkYrOVArWDNNZ1oxUEVLRTIva29FRU5ML3lib25BVEdM?=
 =?utf-8?B?Q1FObHdwdDNyQkpQZWg2T25xNkl4Z3E0dXEzUGJ5a1VFbVdEK3dRbyszYm03?=
 =?utf-8?B?d3hlZlVIZW5FYVEzd0N0YVRNN0VFK0FocEV6b1loYytTaXFKc0oxMjJZVEJN?=
 =?utf-8?B?OFQwbGVjcjlycTJqeVdBS1NUb1NXR0Z2YWFUUFNMUEJRdUJPWjhXT29hcEY5?=
 =?utf-8?B?NW9EOXMyS2VUWUdBZmFiVE1rSUlpelhlTDQ5M0NocXorRGd3UzNhZDhLMjJW?=
 =?utf-8?B?aE1naEpCM01FK1dJNGZrSnlUMnRqNk90ZTlEQkw5VGJUSmR3OU5WaDg0cHVR?=
 =?utf-8?B?WWVZNTFPd0g1K0FoODRzaktWdndKQ1VXVm0rRnVBaGtRbEtjaktvSXNocTVz?=
 =?utf-8?B?ZDRkZ1FjU0pGQUFPTjhEWEJyZGJ3dFVVbEFCOXJMN1R2SkpBdHZqYkVMbEpJ?=
 =?utf-8?B?Q0RsS09DdTJ6MGhCMjhkTUdiTmUyODRtT2hmY3ltY1o1MDhVZnRpVm5FRnpV?=
 =?utf-8?B?dldZQkRrRjRqU01BRDQ2OUdYUk1oTFFTZ3lTSUczaEdGT29pdkV5dGhaZitY?=
 =?utf-8?B?aUdGL1Y1d3F4ait1ZHh2STlUa2wwWFZrWXBJSHljNnF5bUdGelMwOGh4RDZ2?=
 =?utf-8?B?bjYxWmhLaDJCWXptZlc2d3I5QVczNmMyKzlHaTl0cDF0T042RjY4TC9rdVFD?=
 =?utf-8?B?QlBCOFJVbEtVcVVqNzQzem45WGhNY3NQZ0Q0Z0gvNVFXQzdtUUNoTUprMTRn?=
 =?utf-8?B?NzFKN2NzaFl6cGJWUzBRZkhMaEptL2xGQ3ZzQVl2R3IxakE4czFlTi9xalYw?=
 =?utf-8?B?VVY3VTRVSDl4a3NMT0YrYlJ6UjM4QlpXVHAzZkRCcHlyeFB4aWQrUlhwSEZ4?=
 =?utf-8?B?bTlDUU5Dc3g2OGVUZ0lNSWNvenRKM3E4K2U1M3FzcFI4Zms1THF6bTJSd1Bi?=
 =?utf-8?B?K1REeUI4NWROMDNOdFpnb3FWUmhNZmphRFRvZ3ZWbXBoeGtwNHRTSVJYSGlF?=
 =?utf-8?B?anhHOVE3UURDc09pZUJJRXhxbGUxVHhjS2Z3Y1pTbCtwNVpTcVMrVmR5NkFI?=
 =?utf-8?B?M1AvdFpud0s5L3NidHhWVmE3dzFkSzY1RFlxWjlIbmN5S1NFUWM2UUY0b1JN?=
 =?utf-8?B?V2JWbkUzbWJ2OTZCSElUeEZKMTRzaXFORGlvTjJ1WlJhKzMxT1FEaGxsdCtL?=
 =?utf-8?B?TklMWkJma1ZPMzVwZmxmYm85YU1vaVBDMUVuazkzQWdDWkZVck4rd3NmK2ow?=
 =?utf-8?B?VmVKUmRoVTBDYUV6OUxXVVI0VnJTU3U1c1FMVnFMSXl4STlmZG1Vb3cwais2?=
 =?utf-8?B?NVpua01Lb1R4M1R6MUY4a3lzakdpdExRNURRTnFmU3I2THFxcitxblJHRWV3?=
 =?utf-8?B?V0xHTTdiaUxiOTZZK2ZjZjdVMHpMM0I3ZkxCT1ZDdW5aLzNMa3o0RWh4YUp5?=
 =?utf-8?B?RHhINGVZeklUOW16clM4Y25jaEdpQ1g2SkJLVUMwNHp5NGJaeU55RmV0Nk5Y?=
 =?utf-8?B?UUZwbVQzTHFMRVBDZGR1R2lDS1BGeFRtQ0UweDJldkd2UTdtQ1BCOG1Wd3li?=
 =?utf-8?B?UVRHOG9ZN1ZCWmFlK2xSL3dpd3pSMmRoc3ErR05KbTFHZ2MrR1RhQVRIWFhn?=
 =?utf-8?B?dGxNN2lYTGo4dmMwcFdvdlY2TU9lZXlVd2p4bW82cDNsVStDT0IvODl0RGNj?=
 =?utf-8?B?eXBJZ295OVY2ZzYxOWZFVzN4ZllZb3lneHZjWUU1WDlua2tWaHNjTXZkM1Jv?=
 =?utf-8?B?ZW9NNmJMZm1GQWhmTjZjN3l5TlRLc00rcmQyckp3WmkwNWVVRGJBL3hadFlR?=
 =?utf-8?B?ZWpyaTB1SEwzNUhTVkNwdTJmcFdVUGVQeEttRVU3RXBFNDZXQUdMOURHUVRJ?=
 =?utf-8?B?cENvanZGNkcxWHJmNXZveHdIbEk0bDFKbzJvbFVpaTdTZmVhd0lDcVRUUCtT?=
 =?utf-8?B?QS9GNjMvZUlWYTJyUG95bm9NS3lTZCtJc2o1aHJsbXE5RVFrTUxrTDlqR0pH?=
 =?utf-8?B?UTcvNG4za01IRmovSE42T2VrY0oydGM0dlF1UFBid0piOC9GMzBkYWlSTktI?=
 =?utf-8?Q?6IAIgaJZBmoBCi1s=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e84c9e9-1ce7-45e1-6c90-08de96156f27
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:53:14.5683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BAQwCxGC7Rkzl7BglR2RdxW1z0AAtQlVtQjcUeYNqw9PGRHX4Uo6nmv5r0+7jpzK5SVoy35v+baZ2xHIjPonKHV3w4zLo0hkge5273zNpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3679
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

On Tue, Mar 31 2026, Ngo Luong Thanh Tra <ngotra27101996@gmail.com> wrote:

> Add const_strcpy() macro to <linux/build_bug.h> that enforces at
> compile time that the destination is a char array (not a pointer),
> the source is a string literal, and the source fits in the
> destination including the NUL terminator. It uses __builtin_strcpy()
> so the compiler can optimize the copy.
>
> Fix the console_buffer extern declaration in <console.h> to include
> the array size so that sizeof(console_buffer) is valid at call sites.
>
> Replace the unbounded strcpy() in cli_hush.c with const_strcpy() to
> catch at compile time any configuration where CONFIG_SYS_CBSIZE is
> smaller than the boot retry command string.
>
> Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
> Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
> To: u-boot@lists.denx.de
> ---
>
[snip]
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index 20c2dc7f4bd..d775bf1bf91 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -76,4 +76,27 @@
>  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #e=
xpr)
>  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
> =20
> +/**
> + * const_strcpy - Copy a string literal to a char array with compile-tim=
e checks
> + * @d: destination char array (must be a char array, not a pointer)
> + * @s: source string literal
> + *
> + * Enforces at compile time that:
> + * (a) @d is a char array, not a pointer
> + * (b) @s is a string literal (adjacent string concatenation trick)
> + * (c) @s fits in @d including the NUL terminator
> + *
> + * Uses __builtin_strcpy() so the compiler can optimize the copy into
> + * immediate stores rather than emitting a function call.
> + *
> + * Note: @s is used twice in the macro expansion but this is intentional
> + * and safe: the ("" s "") trick enforces at compile time that @s is a
> + * string literal, and string literals have no side effects.
> + */
> +#define const_strcpy(d, s) ({						\
> +	BUILD_BUG_ON(__builtin_types_compatible_p(typeof(d), char *));	\
> +	BUILD_BUG_ON(sizeof(d) < sizeof("" s ""));			\
> +	__builtin_strcpy(d, s);						\
> +})
> +

+1 for the explanations you've added, that was very much my intention
that you should write something like that. (Note that d is also expanded
multiple times, but only _evalutated_ exactly once, since it appearing
inside typeof() or sizeof() does not cause it to be evaluated).

That said, I really think you should use the static_assert() version I
proposed. (Yes, there was a missing closing parenthesis that needed
fixing, other than that it seems to work).

That is evaluated much earlier by the compiler, and gives a more
to-the-point error message, instead of all the gunk that the
__attribute__((__error__)) implementation gives. For example, I just
tried adding

extern char *test_dst_p;
void test_const_strcpy(void)
{
	const_strcpy(test_dst_p, "foo");
}

to lib/string.c. With the BUILD_BUG_ON version, that gives

=3D=3D=3D
In file included from lib/string.c:21:
lib/string.c: In function =E2=80=98test_const_strcpy=E2=80=99:
include/linux/compiler.h:346:45: error: call to =E2=80=98__compiletime_asse=
rt_0=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: __builtin=
_types_compatible_p(typeof(test_dst_p), char *)
  346 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler.h:327:25: note: in definition of macro =E2=80=98__co=
mpiletime_assert=E2=80=99
  327 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler.h:346:9: note: in expansion of macro =E2=80=98_compi=
letime_assert=E2=80=99
  346 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:38:37: note: in expansion of macro =E2=80=98compi=
letime_assert=E2=80=99
   38 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:49:9: note: in expansion of macro =E2=80=98BUILD_=
BUG_ON_MSG=E2=80=99
   49 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
include/linux/string.h:163:3: note: in expansion of macro =E2=80=98BUILD_BU=
G_ON=E2=80=99
  163 |   BUILD_BUG_ON(__builtin_types_compatible_p(typeof(d), char *)); \
      |   ^~~~~~~~~~~~
lib/string.c:31:9: note: in expansion of macro =E2=80=98const_strcpy=E2=80=
=99
   31 |         const_strcpy(test_dst_p, "foo");
      |         ^~~~~~~~~~~~
=3D=3D=3D

whereas with static_assert(), one gets

=3D=3D=3D
In file included from include/linux/string.h:6,
                 from lib/string.c:23:
lib/string.c: In function =E2=80=98test_const_strcpy=E2=80=99:
include/linux/build_bug.h:77:41: error: static assertion failed: "destinati=
on must be char array"
   77 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
include/linux/build_bug.h:76:34: note: in expansion of macro =E2=80=98__sta=
tic_assert=E2=80=99
   76 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS_=
_, #expr)
      |                                  ^~~~~~~~~~~~~~~
include/linux/string.h:156:3: note: in expansion of macro =E2=80=98static_a=
ssert=E2=80=99
  156 |   static_assert(__same_type(d, char[]), "destination must be char a=
rray"); \
      |   ^~~~~~~~~~~~~
lib/string.c:31:9: note: in expansion of macro =E2=80=98const_strcpy=E2=80=
=99
   31 |         const_strcpy(test_dst_p, "foo");
      |         ^~~~~~~~~~~~
=3D=3D=3D

That's much fewer lines of gunk, and moreover, the very first "error:"
line explains the problem, contrary to the rather opaque

  error: call to =E2=80=98__compiletime_assert_0=E2=80=99 declared with att=
ribute error: BUILD_BUG_ON failed: __builtin_types_compatible_p(typeof(test=
_dst_p), char *)

And as others have pointed out, we really want to positively assert that
the destination has type char[], not merely that it is not char* - and
the documentation for __builtin_types_compatible_p explicitly says that
int[5] is compatible with int[], so even though we obviously want the
destination to have a known size, the type comparison to char[] is ok.

I also don't think this belongs in build_bug.h. It's a string operation,
so it's more natural in linux/string.h, where you must then add an
include of linux/build_bug.h to make that header self-contained. Or
maybe there's some other more appropriate header, but build_bug.h is not
it.

Another thing: You _can_ elide the type check for s as you've done as
the ""s"" trick _mostly_ does enforce it to be a string literal, but

(a) the error message one gets when there's a syntax error, e.g. when using
some const char* variable, is not as nice as what one can get from a
static_assert() ; something like

lib/string.c:34:38: error: expected =E2=80=98)=E2=80=99 before =E2=80=98tes=
t_src_p=E2=80=99
   34 |         const_strcpy(test_dst_array, test_src_p);

vs

include/linux/build_bug.h:77:41: error: static assertion failed: "source mu=
st be a string literal"
   77 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)


(b) there are evil ways to defeat the ""s"" trick:

    extern char test_dst_array[12];

    const_strcpy(test_dst_array, ""[0] + "foo bar baz frobble");

Since the s expression here both starts and ends with a string literal,
the concatenation trick works. However, ""[0] is simply another way of
spelling the integer 0 (because it's the nul terminator in the empty
string), and adding that to a string literal produces a value of type
"const char *", pointing to that string. So the sizeof("" s "") will
evaluate to 4 or 8, hence the size comparison will succeed, even though
the pointed-to string is actually longer than the destination array. So
this should not compile, but does, without the explicit type check.

Rasmus
