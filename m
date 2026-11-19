Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF660A3830
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yTptb25V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YqmQT4xB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F01781465;
	Thu, 19 Nov 2026 16:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeEg4ubWWlE6; Thu, 19 Nov 2026 16:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 301708145C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795104120;
	b=KGy1Wf5K3kqjQuTzKYoxe8j6lcRAvTqEdM6PB82Hv8K/DhwyaQzkKgwe2I+rxt5GyPpr
	 fRG+itzW2RJnugBQWk4jFI8nUV45hJmdGI+6F7RyUOpMXnzW0xayQfVZtDROLtY+EiTae
	 Wx8a3DjezMYS9vXnJ4VD3mKwN6guRYPu7uZ2zirCbBLlsGLQsdwTf1htdis849fQvSjk7
	 J4QcmxbGh6o2yNGk1H/FOx9Ih5XvOrb3qS/qldHLM0W7NEaC1rbFKhw4XUGqota8P8kNH
	 bQzhqORAmkVdEuVesgK+jVJA84dUVnD9YCQT1L6h+ionLjxILeRmf2UKbXlIhMS/K2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795104120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bLqFiGYlocLguHtp9mJqrMj6rN7cOzA2/vIcUU/6Ktw=;
	b=IYF+9tFqZbMuuaMfrFvU0W12HrNIpz/gsGFsV/jFHndbGUkv9QAy2rX+j9C2pZrumyk1
	 +mhKRIYsx9xe33s7mTxez+qBKHU0HsgP6tuC4OrPVdQvK+J1RgyvrDTFgtBCi3vqo8rBk
	 w4MYnVZh7oiMnGqcUoamsWe3icaNjoUk5xE0oVLryft6W4poyL06G//sV8srNv6bxCEE9
	 1kGNDCgxvar/jBHvAWw0nfk7HMJFB07777mzcBQpX3hqmf6GQ/zDltdin9wBBzo/h2KdF
	 4qor0+B061dsDK6F2tokzjTOZ/svLV5ttZtjSOTZeN3ELCFMqsyUTQW3LeNZDF7tVPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795104120;
	bh=bLqFiGYlocLguHtp9mJqrMj6rN7cOzA2/vIcUU/6Ktw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yTptb25VgDefrANIp9oGptrJ1nsloS3JQ3hx8HB2Ci0ncs0veDy2GuxOiwruGym9+
	 kwOxKDnbPS7+q/vMGbBVXTl0yxglK6do9vzNHbLhxTH9hSVs2d0GNwEKjWIB+xSO3W
	 x/IYtg3+aItiArmjNpt5TH3H8VD5rbS/vbyrzfAXZISVsRn7FLV3DzHMKqYO0Dtluy
	 Y8xODGqAmzRRQuuU/cV9HoMtR07Sr4v/J9gW6DccDTUjdzFVTXYxsBJ1Eaq0GrbEbd
	 PsKLACWBGzsgftIpYTvGp/fFvfTw1s/hTWYeLPOzmY85pJ92AhippHHnaPyC9bUBOp
	 mqo7qR3+RKQHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 301708145C;
	Thu, 19 Nov 2026 16:02:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1273122B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E893F60D98
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 09s1TmErseWy for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73D0360D94
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=95.215.58.149
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.149;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=YqmQT4xB
Received: from mta1.migadu.com (out-149.mta1.migadu.com [95.215.58.149])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73D0360D94
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:01:55 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=NCnyveWhvrBxLsLMnYwW1RTiNhZGjO7uVO/zb8z6MOk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795104113; v=1; x=1795708913;
 b=YqmQT4xBEYky1jDTlli/+cGVz+EJNgqwHrPi7M3wOv/j/y+Mf5EfxKB7Z1Ml0LLC8+FIiw7d
 Os8B6DjxwAwvsjndacliGcIZuUp/tS/13kRg9tt/U233WPGVDY7vLJ7TYpeG5CnqA9PJrv35oBw
 ISENUjEfaemCLVf0htrwxR2Y=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 6407bda8ae7be967;
 Thu, 19 Nov 2026 16:01:53 +0000
X-Mizu-Trace-ID: 6407bda8ae7be967
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 16:01:52 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org
CC: Tom Rini <trini@konsulko.com>,
 =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 =?ISO-8859-1?Q?Marek_Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_04/14=5D_powerpc=3A_lib=3A_Add?=
 =?US-ASCII?Q?_64-bit_division_to_the_private_libgcc?=
In-Reply-To: <0576c843-db7d-4875-a974-0c497cf69059@kernel.org>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
 <20261119133310.22732-5-pepe.schlehofer@gmail.com>
 <0576c843-db7d-4875-a974-0c497cf69059@kernel.org>
Message-ID: <4EDA2004-7420-4BE7-BDD2-B71240E69107@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19 November 2026 14:21:14 GMT, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> wrote:
>
>
>Le 19/11/2026 à 14:33, Josef Schlehofer a écrit :
>> On 32-bit PowerPC, GCC lowers '/' and '%' on unsigned 64-bit operands
>> to calls to __udivdi3() and __umoddi3(). U-Boot's private libgcc lacks
>> these routines, so turris_1x_sdcard fails to link with
>> CONFIG_USE_PRIVATE_LIBGCC=y:
>> 
>>    undefined reference to `__udivdi3'
>
>Why do we need __udivdi3() at all ? Can't we just avoid / and % on 64-bit
>operands and use __div64_32() or equivalent instead ?

Oh yes. That's right. What's the point OF using __udivdi3()..

Also, a potential user of this file is the arch/powerpc/lib/time.c file.

It's a pain to do the dividing maths, and we need a "fast(er)" non
overflowy way to do usec2ticks(), see the comment.

/*
 * This function is intended for SHORT delays only.
 * It will overflow at around 10 seconds @ 400MHz,
 * or 20 seconds @ 200MHz.
 */

A patch I self-naked did 64 bit div math but it was slowww..

From a look of this. This looks slightly feasibler as a option, well, this
just came into my head.

>
>Christophe
>
>
>> 
>> Implement both with a copy of __div64_32() from lib/div64.c whose
>> divisor is widened to 64 bits. The copy keeps the private libgcc
>> independent of lib/, which not every xPL phase links.
>> 
>> Build the file without LTO, as ARM does for eabi_compat.o: LTO can
>> drop these functions before GCC generates the calls that need them.
>> 
>> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Marek Behún <kabel@kernel.org>
>> ---
>> Changes in v3:
>> - name lib/div64.c as the source of udivmod64() more clearly
>> - explain in the comment why the high word is only divided first when
>>    the divisor fits into 32 bits
>> 
>> Changes in v2:
>> - new patch
>> 
>> At -Os the two take 300 bytes, against 1036 and 992 bytes of
>> _udivdi3.o and _umoddi3.o in Debian's libgcc 14.2.
>> ---
>>   arch/powerpc/lib/Makefile  |  3 +-
>>   arch/powerpc/lib/udivdi3.c | 85 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 87 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/powerpc/lib/udivdi3.c
>> 
>> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>> index 90f0e1e5fa9..23e62996701 100644
>> --- a/arch/powerpc/lib/Makefile
>> +++ b/arch/powerpc/lib/Makefile
>> @@ -6,7 +6,8 @@
>>   ## Build a couple of necessary functions into a private libgcc
>>   ## if the user asked for it
>>   lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o \
>> -				    crtsavres.o
>> +				    crtsavres.o udivdi3.o
>> +CFLAGS_REMOVE_udivdi3.o := $(LTO_CFLAGS)
>>     MINIMAL=
>>   diff --git a/arch/powerpc/lib/udivdi3.c b/arch/powerpc/lib/udivdi3.c
>> new file mode 100644
>> index 00000000000..4b02c61bcba
>> --- /dev/null
>> +++ b/arch/powerpc/lib/udivdi3.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * 64-bit unsigned division and modulo for the private libgcc
>> + *
>> + * GCC calls __udivdi3() and __umoddi3() for '/' and '%' on unsigned
>64-bit
>> + * operands on 32-bit PowerPC.
>> + *
>> + * udivmod64() is a copy of __div64_32() from lib/div64.c, changed to
>take a
>> + * 64-bit divisor. Its shift-and-subtract loop already works with one.
>Like
>> + * __div64_32(), the functions are not instrumented, as tracing code
>may
>> + * divide. The copyright notices below are those of lib/div64.c.
>> + *
>> + *   Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
>> + *
>> + *   Based on former do_div() implementation from asm-parisc/div64.h:
>> + *	Copyright (C) 1999 Hewlett-Packard Co
>> + *	Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +
>> +static notrace u64 udivmod64(u64 n, u64 base, u64 *rem)
>> +{
>> +	u64 b = base;
>> +	u64 res, d = 1;
>> +	u32 high = n >> 32;
>> +
>> +	/*
>> +	 * Divide the high word first, as __div64_32() does. This is a 32-bit
>> +	 * division, so it is only valid when the divisor fits into 32 bits.
>> +	 */
>> +	res = 0;
>> +	if (!(base >> 32) && high >= base) {
>> +		high /= (u32)base;
>> +		res = (u64)high << 32;
>> +		n -= (u64)(high * (u32)base) << 32;
>> +	}
>> +
>> +	while ((s64)b > 0 && b < n) {
>> +		b = b + b;
>> +		d = d + d;
>> +	}
>> +
>> +	do {
>> +		if (n >= b) {
>> +			n -= b;
>> +			res += d;
>> +		}
>> +		b >>= 1;
>> +		d >>= 1;
>> +	} while (d);
>> +
>> +	*rem = n;
>> +	return res;
>> +}
>> +
>> +/**
>> + * __udivdi3() - divide two 64-bit unsigned integers
>> + *
>> + * @n:		dividend
>> + * @d:		divisor
>> + * Return:	quotient
>> + */
>> +notrace u64 __udivdi3(u64 n, u64 d)
>> +{
>> +	u64 rem;
>> +
>> +	return udivmod64(n, d, &rem);
>> +}
>> +
>> +/**
>> + * __umoddi3() - remainder of the division of two 64-bit unsigned
>integers
>> + *
>> + * @n:		dividend
>> + * @d:		divisor
>> + * Return:	remainder
>> + */
>> +notrace u64 __umoddi3(u64 n, u64 d)
>> +{
>> +	u64 rem;
>> +
>> +	udivmod64(n, d, &rem);
>> +
>> +	return rem;
>> +}

Other than that, this file really looks good!

>
>

--- Thanks!
