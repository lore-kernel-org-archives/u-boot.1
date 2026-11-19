Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB4606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FJHXuEJG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivRd/ViU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB20440AE6;
	Thu, 19 Nov 2026 14:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8q07Z6p-O6VZ; Thu, 19 Nov 2026 14:21:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 015A640AF6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795098084;
	b=Zv7FwHFs9fruuEeConYLChHXzlzIq3Gzjme+LABZpmXK1noLDglZtz9mxx1K2iXU/rs2
	 fpWTnmQBNuyo3i43fMlObR4fWNWZ0sSHApoXvFSr+DJ16DuteRrhFktd9D8LEZk2yfQfc
	 3OUa1JK+mk9t9i7AvPYcBjm+hq+UqJbAiN1OhEcgOErfeBcLqSqE8V5fbcz7go6bnJYiA
	 bHyTM5OLL+IhYyD1b+RT7Sd01eRR5eoFNWBd31uO5dVk1lWC4Ep9n+1iwRbLrJGzToe7D
	 aFYxrn7EvSwEufP+7OC+VZT8GkW8tgbY3s4Yo+gNo6Y7LpCxtGjPJAM6nSRXeWQIB7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795098084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ldcJIrKZUkZdc4ilhKpwVAvYuTH1B8CmNtsoEva+ip0=;
	b=I/O38dC/fV7ApzaHLnpUBvThiKXuz5Wrej2LbpWGOOmBhjFOAzd2+Er5ota+X1/a0c2p
	 tVUtzZBKmG29RuQLlOQQ9u8BTZijUuoRGUi9HoEc3WR0b9YjEhrz4fi2LY+ac8XE7LiuN
	 phPx5625qgrCgD4JVZ/SD94kqMBp3RdkmPsQMwBMeuLR/+MdO6s12xFXW8O/t2EFA5sCL
	 BDvk+CxpKRiAt2OHjnR794kWrrWs79aC/Y/Tb8FYrqScqVi/OgyNxyS6hPsSPtacJ/G9a
	 a3FQZEM6nEz4ZpJ4XjOHVw24BU+bt6BLQlCtC1TF6pdiVtyWpO7nGvl4dpLOARFSSrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795098084;
	bh=ldcJIrKZUkZdc4ilhKpwVAvYuTH1B8CmNtsoEva+ip0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJHXuEJG8AmN6AVQZj3swJdUA3iY+qpbF79s/5QFPBkEosWiaQ7QBThOYMsiUaxWR
	 2scIJJTvH1meGQSPGhcv/d1g6+vf5pA3LJvDH6gjineTzaQtU3St+hU6XNtxQhvBPR
	 SE4k1dbqsnzHR3B9qLgmKvJcmbiodZ4qz/nD7F0dz2vgugHSuqFIX80hS78M1KeI3O
	 cXIn+/7QmSM4UwEbD+DTTMbMlZMflPdDY7X9XmldFn+/8TrCyj51zsV5y1aMMcc6zM
	 Bt+U3CBETJ+ZjnoOMgerak5iA3Io/4eAjlnEc8PIv8DqiYU9qmAhMYrSR1iFjKLZyj
	 ikzZQe0nC95pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 015A640AF6;
	Thu, 19 Nov 2026 14:21:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF2221C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5A264052F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fUen3D1eDw3 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0B15840527
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ivRd/ViU
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B15840527
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:21:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 504A740773;
 Thu, 19 Nov 2026 14:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F1F1F000C9;
 Thu, 19 Nov 2026 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795098081;
 bh=ldcJIrKZUkZdc4ilhKpwVAvYuTH1B8CmNtsoEva+ip0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ivRd/ViUQ8hLZJ7tK0TqvuKghXKeG5N3wWUQE6rsxCvaxOPqfXbXEf6/gW7skBhcB
 E6TO48wPaKdvNY3lFcI3D+q3/Xt4XetqMGlw7sn0sOWlvX+p71j65SDDlLMBtvqnhG
 V62knqrEXE7e/TI1XQqclFdKCsmDlDRJSerb0VSQF7fehybXlk3Neqxt7kDTuQ9K65
 uYv9sju+EcCXcjZJOISFvQFPJuCBfo9DkLXcu02ohkV076oggE+vA1rezqmb0sX/LS
 1Jz5Or+0d9cNEAHo9ZZAyIAPqR514Ph1ahGz1we83lUfzNORYS/hMGSSYINQNvvKrt
 g8epGBnz83R1A==
Message-ID: <0576c843-db7d-4875-a974-0c497cf69059@kernel.org>
Date: Thu, 19 Nov 2026 15:21:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] powerpc: lib: Add 64-bit division to the private
 libgcc
To: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
 <20261119133310.22732-5-pepe.schlehofer@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261119133310.22732-5-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 19/11/2026 à 14:33, Josef Schlehofer a écrit :
> On 32-bit PowerPC, GCC lowers '/' and '%' on unsigned 64-bit operands
> to calls to __udivdi3() and __umoddi3(). U-Boot's private libgcc lacks
> these routines, so turris_1x_sdcard fails to link with
> CONFIG_USE_PRIVATE_LIBGCC=y:
> 
>    undefined reference to `__udivdi3'

Why do we need __udivdi3() at all ? Can't we just avoid / and % on 
64-bit operands and use __div64_32() or equivalent instead ?

Christophe


> 
> Implement both with a copy of __div64_32() from lib/div64.c whose
> divisor is widened to 64 bits. The copy keeps the private libgcc
> independent of lib/, which not every xPL phase links.
> 
> Build the file without LTO, as ARM does for eabi_compat.o: LTO can
> drop these functions before GCC generates the calls that need them.
> 
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Behún <kabel@kernel.org>
> ---
> Changes in v3:
> - name lib/div64.c as the source of udivmod64() more clearly
> - explain in the comment why the high word is only divided first when
>    the divisor fits into 32 bits
> 
> Changes in v2:
> - new patch
> 
> At -Os the two take 300 bytes, against 1036 and 992 bytes of
> _udivdi3.o and _umoddi3.o in Debian's libgcc 14.2.
> ---
>   arch/powerpc/lib/Makefile  |  3 +-
>   arch/powerpc/lib/udivdi3.c | 85 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 87 insertions(+), 1 deletion(-)
>   create mode 100644 arch/powerpc/lib/udivdi3.c
> 
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 90f0e1e5fa9..23e62996701 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -6,7 +6,8 @@
>   ## Build a couple of necessary functions into a private libgcc
>   ## if the user asked for it
>   lib-$(CONFIG_USE_PRIVATE_LIBGCC) += _ashldi3.o _ashrdi3.o _lshrdi3.o \
> -				    crtsavres.o
> +				    crtsavres.o udivdi3.o
> +CFLAGS_REMOVE_udivdi3.o := $(LTO_CFLAGS)
>   
>   MINIMAL=
>   
> diff --git a/arch/powerpc/lib/udivdi3.c b/arch/powerpc/lib/udivdi3.c
> new file mode 100644
> index 00000000000..4b02c61bcba
> --- /dev/null
> +++ b/arch/powerpc/lib/udivdi3.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * 64-bit unsigned division and modulo for the private libgcc
> + *
> + * GCC calls __udivdi3() and __umoddi3() for '/' and '%' on unsigned 64-bit
> + * operands on 32-bit PowerPC.
> + *
> + * udivmod64() is a copy of __div64_32() from lib/div64.c, changed to take a
> + * 64-bit divisor. Its shift-and-subtract loop already works with one. Like
> + * __div64_32(), the functions are not instrumented, as tracing code may
> + * divide. The copyright notices below are those of lib/div64.c.
> + *
> + *   Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
> + *
> + *   Based on former do_div() implementation from asm-parisc/div64.h:
> + *	Copyright (C) 1999 Hewlett-Packard Co
> + *	Copyright (C) 1999 David Mosberger-Tang <davidm@hpl.hp.com>
> + */
> +
> +#include <linux/types.h>
> +
> +static notrace u64 udivmod64(u64 n, u64 base, u64 *rem)
> +{
> +	u64 b = base;
> +	u64 res, d = 1;
> +	u32 high = n >> 32;
> +
> +	/*
> +	 * Divide the high word first, as __div64_32() does. This is a 32-bit
> +	 * division, so it is only valid when the divisor fits into 32 bits.
> +	 */
> +	res = 0;
> +	if (!(base >> 32) && high >= base) {
> +		high /= (u32)base;
> +		res = (u64)high << 32;
> +		n -= (u64)(high * (u32)base) << 32;
> +	}
> +
> +	while ((s64)b > 0 && b < n) {
> +		b = b + b;
> +		d = d + d;
> +	}
> +
> +	do {
> +		if (n >= b) {
> +			n -= b;
> +			res += d;
> +		}
> +		b >>= 1;
> +		d >>= 1;
> +	} while (d);
> +
> +	*rem = n;
> +	return res;
> +}
> +
> +/**
> + * __udivdi3() - divide two 64-bit unsigned integers
> + *
> + * @n:		dividend
> + * @d:		divisor
> + * Return:	quotient
> + */
> +notrace u64 __udivdi3(u64 n, u64 d)
> +{
> +	u64 rem;
> +
> +	return udivmod64(n, d, &rem);
> +}
> +
> +/**
> + * __umoddi3() - remainder of the division of two 64-bit unsigned integers
> + *
> + * @n:		dividend
> + * @d:		divisor
> + * Return:	remainder
> + */
> +notrace u64 __umoddi3(u64 n, u64 d)
> +{
> +	u64 rem;
> +
> +	udivmod64(n, d, &rem);
> +
> +	return rem;
> +}

