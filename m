Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84FB10D14AD
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 13:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D75983DA7;
	Mon, 30 Mar 2026 15:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OiP/S4V2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E593E83DBF; Mon, 30 Mar 2026 15:00:08 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E1383D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 15:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee9yN+QjNRXbVyvfgN7rIOPm7DxdxTbh5/OrwLOTeMI3n3BV8eaxyk4X+08oIXou8kCxEfCkJpTJczapa8z7guAxQcShonj6ua0ksq5sH4WBJ81RWMfEhNgnpwzSYEkmnnyhSW40EnqARFQcLqzv7sIWE1Qs7ytGob5u1zbttag01i1apbGtwIDcMIiFUsHRULS3gODPj658zJfRJIjDttMaL3poOTw0qymFYwdY10bYqquou+qUd0Y9id9jat/hjAdhPqE3F0X28ir4gqsWOmQCkRYQOzwEjJtVh+Aekj417sN+YOQtWugh7ZJQTP2OatrgWhar70Z2ZeGBeRWI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJXlf3mPgWCeYjz8gFJdquzPkf7IgTU2sBhyMRfBkeg=;
 b=R/goQPKLW+EUMMLcj+M9ZtBZsPhgiJrtI4rDSOI3t1Ynr7VXlPkEVFzaotN2PVcpUbvGq27HRu5u0QBx+dmDc7FFTF4gO9jgQb5HWvGH+ezLgbQ5fbLgTZY3BgM4FO/w7i6Jh/PRqKhvp9JX6m5uG9SwEeHNC4Jyznj/7AkdqmFeoyxeTPnCey9on//KHoZ4cDA5c41kNw4b4C5phzUT4DDRyVuDu9LKVGj12P2+OYpaaDrj0xTo2l2cZuycA7iWlNrjqpZZuhWZo77UJNKx0UjcvSa+JZsAaRQhxFagxMAipm3aAzEnwl9Exiqr2YMUWuML+pRG00midQtlkxvgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJXlf3mPgWCeYjz8gFJdquzPkf7IgTU2sBhyMRfBkeg=;
 b=OiP/S4V27Jed37BaTF/siwOAwQdPtiFRs2uiX2zk+v3akGvO0XDFPLVsPZGHM69pq09wQbByxerov0MVM21PPcyzNSzQKfpIz95f3UA/BAiy3ZGIfJBkagSwd2CNIqa29Q54OwDs05xIg5P5oz+bqagAI0V+XUeVnoCASn4uVQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 12:59:59 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 12:59:59 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
Cc: u-boot@lists.denx.de,  Ngo Luong Thanh Tra
 <S4210155@student.rmit.edu.au>,  Casey Connolly
 <casey.connolly@linaro.org>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/3] common: cli_hush: fix console_buffer overflow on
 boot retry
In-Reply-To: <20260328060139.63221-3-S4210155@student.rmit.edu.au> (Ngo Luong
 Thanh Tra's message of "Sat, 28 Mar 2026 13:01:33 +0700")
References: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
 <20260328060139.63221-3-S4210155@student.rmit.edu.au>
Date: Mon, 30 Mar 2026 14:59:57 +0200
Message-ID: <87bjg55v76.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0008.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 6828131f-6285-469d-c31e-08de8e5c3f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|56012099003|18002099003|22082099003|10062099007;
X-Microsoft-Antispam-Message-Info: 32iZa9e45xV6vxsjlc/12RfJgt0FUMO7GtJnPcuCOLZvERDD67LBkqf/jZEgIRBAgAXTrp0gcGewaR31fiboW0kLu9tsJGYHC0rolguNyK1VBskgSccZfylUcGHANI6o2G3a4SzVPb0I/VEqXADYnAoc2+H+Iy36WmNUDVsvEoARUvenHYX++4q4PQWBX6rslQGOee00b5Br+kk5LcAudFWOIVqhRmQhj/3eoA9jN42kPmuv2UTx5VbG/tdn1DnihsXSmgV1hzCNHGC305vRf69xuUQrEi0h5MEU12FO1Zq/nw5JHP4AL9Is/JQ8BEEUitZsWpvrjzsK9rA9f1rI29KPZYpqBrTIoH9/xNGJ8hs7rsO9OZkPYdRZcgOSTkSVErsEH8T1FW9tuS04xxCV2DoM1jLG6UCoTq3qb1I7xbL8iVtWyNBj6CEWYm8aGQkFEzSy4Omi5G7UQcKM5NXshBqvtpueddrXf9frQsiHZ8UP5dXOfqxMIV/b38Qs39o1cRU5o2g5DeQeXjr8V74aQDo4pzcvuZbsC9exKMmId8g5o0PauFVi5VaT5//zLE9javTowNgjmn1vh/6ANmkMc3aR6O3kmMode21R4TSBvgTHXKTTJQV6WOkuniSVBqzM1Edp3NMpEaXl0IqiLrdZ5ehPkl/5/sgn1K2GP2MT/x1V8kNU8w7HzhctXhK5yiJREfq4J60pKeGjQrzsDfd0dyKalworIBTy+r049hc52D1M0+1aFutWQEbOUPT4w7KwoW42OGSC9XTDeNYx/ybxJr4fKFIePgxWpr7Jv572Wqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003)(10062099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oci9ZztLOQ7pKgAGrIUEYjCo+AP3p+MCx7Gv1BUttUWtYvTD7Be1ulnZIhy6?=
 =?us-ascii?Q?/otAndLU02zvJnaOZ/NYhIrcQ0IQT102t/brEVyQG4shS0KEpAX5ODb5S9ox?=
 =?us-ascii?Q?cbQ0OzhzfZeDOZGtBdaQFT7kPX36hkwOsPSE4/lRig0bHmYPeUEsXQNSscwz?=
 =?us-ascii?Q?1Z6h8y59CfS0G/jaI5o7EX73BCV5dI6jl5zbhHV7QlVA2pAHSVGHokW78nRo?=
 =?us-ascii?Q?+x2oN5BABdOgcEYGcQakdoBKCSwHpSTLOlIVuitik3N0OjCtz6k+36SmmXTu?=
 =?us-ascii?Q?m1dTCM7BeAzi5FfWuhZn/eSzJ/T8/zbpznMiWpcEjDh+6U4T4Mb+wOGVYag0?=
 =?us-ascii?Q?d07ejJIW0U04YQDt54egEzglXdIiGtCidzrFtYh8raYesIzHzUnc4OLo2iJo?=
 =?us-ascii?Q?7fDvr3gmB2nPYul0Z81MPsdtTcJ4ck9MvoWkBcRmmyBLDQCaf5d8ETi6JFNZ?=
 =?us-ascii?Q?W1u9Pp0+INdYZGd2I0PDreMpNEYyBQRl2mO4vXo5JGmRDii/BPs+swZEKyny?=
 =?us-ascii?Q?uj7qpNEqxSkUb3Um++iAA3tI42m4gKN9qTuG+hmFh+TE6StQeiWJWTXXIUlj?=
 =?us-ascii?Q?aO+22zCC0tHF16WLIgx7Qdhx8XKbeP8AuzXiWIG5zTz5aDK0NyOgC8Ihihqg?=
 =?us-ascii?Q?NqrJQmmGp49H/3dolAx/XgA/VFFJ20EZWEOI8xsPshRJIa6j+NBvUwMvMmot?=
 =?us-ascii?Q?GICu5w1qYf47KSrFDrzNGumf9KfDFbRXcfcYzfOtl85pyMxib7HaPWT/Io+k?=
 =?us-ascii?Q?yvq88j3ctYQWX0csJtgUBINOPEJ0LfP5cFcCFiaXxmQbTzFstAvlpS5byOPX?=
 =?us-ascii?Q?HTY0eVw+L8L0iMbMKy6gnFb0quxh3c3TdphG7xL6f8t4hNNApaUV27udctVo?=
 =?us-ascii?Q?udZtXJX5yXlWDS453KsK1NWwpI0WLa6U8u2pkArxGW2VZSrYddTKkFuLQY4+?=
 =?us-ascii?Q?4spB/uo5mX48LSMPto52EkmMoWjazxg39UpfZiUwlGnfGTA16TENF8nkiZn6?=
 =?us-ascii?Q?gJszCPV7LgWjUTytPy+y3kKwq60CcmfmHnDeJvhzTyPYkXt80kyUqEOqlcIl?=
 =?us-ascii?Q?x+y5X083bylie08xxd40wg2eyjcYwt9aG4rBRVEO8EPuFZknKR/0fSHzWxW9?=
 =?us-ascii?Q?QXkTSU1qNThPBTM4ZiX9QqWaRt7OLGfYudQKnbAVqav5/0zH/iPTsb4BX1O8?=
 =?us-ascii?Q?lDvNx6ILLfltwf3VuQ4m94hAdgFKFXyDchlYoYaCLlqzIqpPO83x+SqPkAq2?=
 =?us-ascii?Q?d7Ujl7nMV8bRHM9AeAlEPDnL65HPcqBxOkMxYxCbn2GHGqzxaRiyKN2qNrzr?=
 =?us-ascii?Q?Si62VIvo/BCWvvxz2UQhYQIDfGDMi17K0ndPWAHfTiimgsLD9qYKI57EerUv?=
 =?us-ascii?Q?7YiLNioR/MfIDhYBzAh1pTu18DzUGdpY8DC2sYy7YY8r0DsjNaYQBr57ux2p?=
 =?us-ascii?Q?D2bsmuVkEDUyXBAD/UP1z5XVMTN5SZSgd68J/z9Ko0Ti/hy7xDkVmFNBfjb3?=
 =?us-ascii?Q?LMXhNNJFjI71uqWp+0PH5+1LeX76gAdqPGTzShW5Z2y9eEWEWFirsXy3NIU1?=
 =?us-ascii?Q?aj0j3kMcngfz8KDPhQMOCt3AWsNhG41YI+bns8T8xhMgZEKWV08Elk8oRr/E?=
 =?us-ascii?Q?MscTMzxcGzqI2k+e75e/CzBz0tfH2jwaYSznZ+WYCYALhDcC8lWEOvlPb7Ya?=
 =?us-ascii?Q?K6CmmYIhusxAhSuKaoJdR5zl6fdgFmXNa6r3rNnw4udvTtoSWavRu38tic6R?=
 =?us-ascii?Q?dSQHV8CJ/Q2NTxj93zSzI35jXX8CDYA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6828131f-6285-469d-c31e-08de8e5c3f95
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:59:59.1664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH6wkRWtIMs6a6u1GL5LyI7KcxNl1tQLFjnIqImBR+pMZJmDzgk0lmgweJSzL8w739PwALrg9rfbRCNh2TdlBZm6Y0nRccwl1Fx7tcTR6Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8589
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

On Sat, Mar 28 2026, Ngo Luong Thanh Tra <ngotra27101996@gmail.com> wrote:

> Replace strcpy() with strlcpy() when injecting the boot retry
> command into console_buffer. Add a BUILD_BUG_ON() to catch at
> compile time any configuration where CONFIG_SYS_CBSIZE is smaller
> than the retry command string, and use a named constant for the
> command so that the size check stays in sync if the string is
> ever changed.
>
> Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
> Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
> To: u-boot@lists.denx.de
> ---
>
>  common/cli_hush.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/common/cli_hush.c b/common/cli_hush.c
> index 7bd6943d3ed..6141c2959df 100644
> --- a/common/cli_hush.c
> +++ b/common/cli_hush.c
> @@ -84,6 +84,7 @@
>  #include <cli_hush.h>
>  #include <command.h>        /* find_cmd */
>  #include <asm/global_data.h>
> +#include <linux/build_bug.h>
>  #endif
>  #ifndef __U_BOOT__
>  #include <ctype.h>     /* isalpha, isdigit */
> @@ -1029,7 +1030,10 @@ static void get_user_input(struct in_str *i)
>  #  ifdef CONFIG_RESET_TO_RETRY
>  	  do_reset(NULL, 0, 0, NULL);
>  #  elif IS_ENABLED(CONFIG_RETRY_BOOTCMD)
> -	strcpy(console_buffer, "run bootcmd\n");
> +	static const char retry_cmd[] = "run bootcmd\n";
> +
> +	BUILD_BUG_ON(sizeof(retry_cmd) - 1 > CONFIG_SYS_CBSIZE);
> +	strlcpy(console_buffer, retry_cmd, sizeof(console_buffer));

Have you compiled this?

The declaration of console_buffer in include/console.h does not include
the size, so you should get a build error like

  error: invalid application of 'sizeof' to incomplete type 'char[]'

And exactly because that declaration doesn't include the size, the -1
and the comparison to CONFIG_SYS_CBSIZE looks rather fishy.

If anything, one should start by making the size of console_buffer part
of the declaration, so that users such as here could actually do
sizeof(console_buffer), and then one should not use or need to know that
the size if defined in terms of (but not exactly equal to)
CONFIG_SYS_CBSIZE.

Also, I generally think that this whole "must use strlcpy because
safer!" is broken when everything in sight are compile-time
constants. Because the compiler knows about strcpy(), so it can optimize
a strcpy() with a literal as source into a sequence of a few immediate
stores, which is often smaller code than emitting the string literal to
.rodata.str and emitting an actual strcpy() call with all the register
save/restore that requires. It knows nothing about strlcpy().

Unfortunately, U-Boot builds with -Wno-array-bounds, so just declaring
console_buffer with its actual size is not enough to trigger a build
error with the current strcpy(). But if you want to improve stuff in
this area, do something like creating a const_strcpy() helper macro
which will enforce that

  (a) The source is a string literal
  (b) The destination is a char array of known size
  (c) Makes it a build-time error if it doesn't fit
  (d) Uses __builtin_strcpy(dst, src) to tell the compiler that this
  really is just a strcpy(), even if -fno-builtin is in effect, and let
  the compiler optimize as it sees fit - including eliminating the whole
  thing as dead stores if it sees that the destination is not actually
  used.

Something like

#define const_strcpy(d, s) ({ \
  static_assert(__same_type(d, char[]), "destination must be char array"); \
  static_assert(__same_type(s, const char[], "source must be a string literal"); \
  static_assert(sizeof(d) >= sizeof("" s ""), "source does not fit in destination"); \
  __builtin_strcpy(d, s); \
})

Rasmus
