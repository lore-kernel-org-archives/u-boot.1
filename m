Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF62C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 11:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1128F880F5;
	Sun, 16 Jun 2024 13:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MJNasY9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0053880F8; Sun, 16 Jun 2024 13:01:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473EA8332E
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 13:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718535705; x=1719140505; i=xypron.glpk@gmx.de;
 bh=rSN7Yt2nTLQNjuXTO9i8CRQBHwMzDJncQQvIPanGlYQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MJNasY9YDDXinBUw0qOrjYFP6KgqOF/DflP2uG2DO/EHTzpYX1lydww4+n6w7Rlo
 vWGsFfKwLT6N3iZqVjrRSp5230440lttlB0EiAY/Oo29Hmtum1RYGPhkvHminDXYX
 6PfUT5nqis5oKHxU0Wy8S3J2QHWtTqrWvNaMb5zaOahm66KRAG/ar9pcKS4Iry9pz
 PlAs+5rI/9vWXhUnalEaX46QKcOALmKTW4OSeQOI4fOUm+JU+SkxIUFLx3WwZn9/2
 XEq302h0LJaa/aOvhVDXKjDcwG9mA0i3MUJYZiPQTjHdS4aqNVTDg3YqTNPG7Lm+B
 w5tnRpZjn8UkwM15og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1smPMr0iX6-00bzOi; Sun, 16
 Jun 2024 13:01:45 +0200
Message-ID: <630db8ca-d954-4fe7-b113-0057d5ba9563@gmx.de>
Date: Sun, 16 Jun 2024 13:01:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] LoongArch: lib: General routines
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-7-1407e0b69678@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240522-loongarch-v1-7-1407e0b69678@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aV/VQD/CsRjn+KmD3j5F15jenlpwEIfLS7y1xKpJexO6DLDLSD7
 3avpgL9X0J2PWXAPhLhw7HSmON1gTYwVYwbixYpGjtG3A8TDh1dpakDcnbxszsuc1ZfDHxA
 bsSEJpRB3+A1kMecTRvWlHPLRCWv8Usk4xdHd+ztsZVtHMe89ckzCd+0xre/myusPRrVtKM
 i/iy5YJbbpdrsqbLW7OHQ==
UI-OutboundReport: notjunk:1;M01:P0:E2MeZivIlik=;EzKR0tZfJaDVfMjKmUm7OU/CTln
 0THFx+3aquQYrJwMBEI9cI8frEPr7qrijCYsEB42HT6Ru1NyM0keE9/rcUxVLSgX+gM7oOXDQ
 VNEaDcxhi/GKp3c2BFBeAN541zcdEZRyrc7G5YUoWWUWxjeo5HXJZSuKi9zHph7BCrHW+FVjw
 iszMXtd0r4FpF2ouEcXi14kEF0geJB1n/H/l0rNspjWcd79eKXZuWFntCAvySPSWCObbxUsRt
 2tCwLZIeS4X2QhFz4mihlS7TMXE4vI2UQEBFuihM5He4QtPWJ6QdhHaFTdE2NOrCqoTnQpYcp
 +6E7/5wMTRQ0r1QszWlkXzwpt+NdQOJRdNz9+TMQ467qx+WzD+1Z0Z+cbMMWKmjn1okIzyhMJ
 PHUNjkMza/xu5+CpDukmd4TCnKLIA20VkLQvRDBjsW1Nilmdhqh7i5jIdC7Mifc2DuClTiwgC
 w3Kbn5xn/vsypi8aZ63oTj0kp/Umm6hcY+4HKtWwhpJvlr1wUWtnfpJQA71CpibD7Cu6RTCaE
 QpFpEJ0P3pJzHUFYPz8BShtRrKAjxRX+1JqzRXBN6jNimew24xhtAPNnZdjeU0NobzpQWy3Su
 xykqtn1EHh63kWfLPX/SOStHY1vhgb1ulCsySc29uKe2wIFp3HV+dxbjh6DmNOt7SUpPGLvVS
 JzPG655VXu/OTnHXEzNWFyt5QrlsEs5exs2AOOmI12hsURvM/5zy77qD6xoqmE5tUL07O1lxS
 x5bMZ27BJcRVnfy4rLFZfaI+LPtm7jKAeLrGxPYgAzFB0LDa2NgmbKSx2LCLX0XTyGljoQHlN
 /RCaauAZKWDg+/DaUbUm0t+YhGecKD+uOArZvckkt4oLM=
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

On 5/22/24 17:34, Jiaxun Yang wrote:
> Add some common library routines for the architecture.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/loongarch/lib/Makefile      |  7 ++++
>   arch/loongarch/lib/asm-offsets.c | 66 ++++++++++++++++++++++++++++++++=
++++
>   arch/loongarch/lib/boot.c        | 14 ++++++++
>   arch/loongarch/lib/cache.c       | 73 ++++++++++++++++++++++++++++++++=
++++++++
>   arch/loongarch/lib/reset.c       | 14 ++++++++
>   arch/loongarch/lib/setjmp.S      | 52 ++++++++++++++++++++++++++++
>   6 files changed, 226 insertions(+)
>
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index 3dbed94cc624..3c17b9cd85af 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -3,3 +3,10 @@
>   # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
>   #
>
> +obj-$(CONFIG_CMD_GO) +=3D boot.o
> +obj-y	+=3D cache.o
> +obj-y	+=3D interrupts.o
> +ifeq ($(CONFIG_$(SPL_)SYSRESET),)
> +obj-y	+=3D reset.o
> +endif
> +obj-y	+=3D setjmp.o
> diff --git a/arch/loongarch/lib/asm-offsets.c b/arch/loongarch/lib/asm-o=
ffsets.c
> new file mode 100644
> index 000000000000..e3f4c629b63d
> --- /dev/null
> +++ b/arch/loongarch/lib/asm-offsets.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + * From arch/x86/lib/asm-offsets.c
> + *
> + * This program is used to generate definitions needed by
> + * assembly language modules.
> + */
> +
> +#include <asm/global_data.h>
> +#include <asm/ptrace.h>
> +#include <linux/kbuild.h>
> +
> +static void __used output_ptreg_defines(void)
> +{
> +	COMMENT("LoongArch pt_regs offsets.");
> +	OFFSET(PT_R0, pt_regs, regs[0]);
> +	OFFSET(PT_R1, pt_regs, regs[1]);
> +	OFFSET(PT_R2, pt_regs, regs[2]);
> +	OFFSET(PT_R3, pt_regs, regs[3]);
> +	OFFSET(PT_R4, pt_regs, regs[4]);
> +	OFFSET(PT_R5, pt_regs, regs[5]);
> +	OFFSET(PT_R6, pt_regs, regs[6]);
> +	OFFSET(PT_R7, pt_regs, regs[7]);
> +	OFFSET(PT_R8, pt_regs, regs[8]);
> +	OFFSET(PT_R9, pt_regs, regs[9]);
> +	OFFSET(PT_R10, pt_regs, regs[10]);
> +	OFFSET(PT_R11, pt_regs, regs[11]);
> +	OFFSET(PT_R12, pt_regs, regs[12]);
> +	OFFSET(PT_R13, pt_regs, regs[13]);
> +	OFFSET(PT_R14, pt_regs, regs[14]);
> +	OFFSET(PT_R15, pt_regs, regs[15]);
> +	OFFSET(PT_R16, pt_regs, regs[16]);
> +	OFFSET(PT_R17, pt_regs, regs[17]);
> +	OFFSET(PT_R18, pt_regs, regs[18]);
> +	OFFSET(PT_R19, pt_regs, regs[19]);
> +	OFFSET(PT_R20, pt_regs, regs[20]);
> +	OFFSET(PT_R21, pt_regs, regs[21]);
> +	OFFSET(PT_R22, pt_regs, regs[22]);
> +	OFFSET(PT_R23, pt_regs, regs[23]);
> +	OFFSET(PT_R24, pt_regs, regs[24]);
> +	OFFSET(PT_R25, pt_regs, regs[25]);
> +	OFFSET(PT_R26, pt_regs, regs[26]);
> +	OFFSET(PT_R27, pt_regs, regs[27]);
> +	OFFSET(PT_R28, pt_regs, regs[28]);
> +	OFFSET(PT_R29, pt_regs, regs[29]);
> +	OFFSET(PT_R30, pt_regs, regs[30]);
> +	OFFSET(PT_R31, pt_regs, regs[31]);
> +	OFFSET(PT_CRMD, pt_regs, csr_crmd);
> +	OFFSET(PT_PRMD, pt_regs, csr_prmd);
> +	OFFSET(PT_EUEN, pt_regs, csr_euen);
> +	OFFSET(PT_ECFG, pt_regs, csr_ecfg);
> +	OFFSET(PT_ESTAT, pt_regs, csr_estat);
> +	OFFSET(PT_ERA, pt_regs, csr_era);
> +	OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
> +	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
> +	DEFINE(PT_SIZE, sizeof(struct pt_regs));
> +	BLANK();
> +}
> +
> +int main(void)
> +{
> +	output_ptreg_defines();
> +	return 0;
> +}
> diff --git a/arch/loongarch/lib/boot.c b/arch/loongarch/lib/boot.c
> new file mode 100644
> index 000000000000..327be16bb59f
> --- /dev/null
> +++ b/arch/loongarch/lib/boot.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <asm/u-boot.h>
> +
> +unsigned long do_go_exec(ulong (*entry)(int, char * const []),
> +			 int argc, char *const argv[])
> +{
> +	cleanup_before_linux();
> +
> +	return entry(argc, argv);
> +}
> diff --git a/arch/loongarch/lib/cache.c b/arch/loongarch/lib/cache.c
> new file mode 100644
> index 000000000000..54566edef8a3
> --- /dev/null
> +++ b/arch/loongarch/lib/cache.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <cpu_func.h>
> +#include <asm/cache.h>
> +#include <asm/loongarch.h>
> +
> +void invalidate_icache_all(void)
> +{
> +	asm volatile ("\tibar 0\n"::);

According to
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#=
_dbar
this is not invalidating the instruction cache.

After loading an image into memory and before executing it we must
invalidate the instruction cache to ensure that the newly loaded code is
executed.

I guess you want to use CACOP here.

> +}
> +
> +__weak void flush_dcache_all(void)

In cmd/cache.c we have another __weak implementation. How is the linke:w
meant to know which one to use?

I guess we need to fix cmd/cache.c. But that is beyond the scope of this
series.

> +{
> +	asm volatile ("\tdbar 0\n"::);

CACOP?

Best regards

Heinrich

> +}
> +
> +__weak void flush_dcache_range(unsigned long start, unsigned long end)
> +{
> +	/* Placeholder */
> +	flush_dcache_all();
> +}
> +
> +__weak void invalidate_icache_range(unsigned long start, unsigned long =
end)
> +{
> +	/* LoongArch mandatory hardware I-Cache coherence */
> +	invalidate_icache_all();
> +}
> +
> +__weak void invalidate_dcache_range(unsigned long start, unsigned long =
end)
> +{
> +	/* Placeholder */
> +	flush_dcache_all();
> +}
> +
> +__weak void cache_flush(void)
> +{
> +	/* Placeholder */
> +	flush_dcache_all();
> +}
> +
> +__weak void cache_invalidate(void)
> +{
> +	/* Placeholder */
> +	flush_dcache_all();
> +}
> +
> +__weak void flush_cache(unsigned long addr, unsigned long size)
> +{
> +	cache_flush();
> +}
> +
> +__weak void dcache_enable(void)
> +{
> +}
> +
> +__weak void dcache_disable(void)
> +{
> +}
> +
> +__weak int dcache_status(void)
> +{
> +	return 0;
> +}
> +
> +__weak void enable_caches(void)
> +{
> +	cache_invalidate();
> +	/* Enable cache for direct address translation mode */
> +	csr_xchg64(1 << CSR_CRMD_DACM_SHIFT, CSR_CRMD_DACM, LOONGARCH_CSR_CRMD=
);
> +}
> diff --git a/arch/loongarch/lib/reset.c b/arch/loongarch/lib/reset.c
> new file mode 100644
> index 000000000000..ddf29ee41d95
> --- /dev/null
> +++ b/arch/loongarch/lib/reset.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <command.h>
> +#include <cpu_func.h>
> +
> +int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const arg=
v[])
> +{
> +	reset_cpu();
> +
> +	return 0;
> +}
> diff --git a/arch/loongarch/lib/setjmp.S b/arch/loongarch/lib/setjmp.S
> new file mode 100644
> index 000000000000..12981d0013fa
> --- /dev/null
> +++ b/arch/loongarch/lib/setjmp.S
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <config.h>
> +#include <asm/asm.h>
> +#include <linux/linkage.h>
> +
> +.pushsection .text.setjmp, "ax"
> +ENTRY(setjmp)
> +	LONG_S		s0, a0, 0
> +	LONG_S 		s1, a0, (1 * LONGSIZE)
> +	LONG_S		s2, a0, (2 * LONGSIZE)
> +	LONG_S		s3, a0, (3 * LONGSIZE)
> +	LONG_S		s4, a0, (4 * LONGSIZE)
> +	LONG_S		s5, a0, (5 * LONGSIZE)
> +	LONG_S		s6, a0, (6 * LONGSIZE)
> +	LONG_S		s7, a0, (7 * LONGSIZE)
> +	LONG_S		s8, a0, (8 * LONGSIZE)
> +	LONG_S		fp, a0, (9 * LONGSIZE)
> +	LONG_S		sp, a0, (10 * LONGSIZE)
> +	LONG_S		ra, a0, (11 * LONGSIZE)
> +
> +	move		a0, zero
> +	ret
> +ENDPROC(setjmp)
> +.popsection
> +
> +.pushsection .text.longjmp, "ax"
> +ENTRY(longjmp)
> +	LONG_L		s0, a0, 0
> +	LONG_L 		s1, a0, (1 * LONGSIZE)
> +	LONG_L		s2, a0, (2 * LONGSIZE)
> +	LONG_L		s3, a0, (3 * LONGSIZE)
> +	LONG_L		s4, a0, (4 * LONGSIZE)
> +	LONG_L		s5, a0, (5 * LONGSIZE)
> +	LONG_L		s6, a0, (6 * LONGSIZE)
> +	LONG_L		s7, a0, (7 * LONGSIZE)
> +	LONG_L		s8, a0, (8 * LONGSIZE)
> +	LONG_L		fp, a0, (9 * LONGSIZE)
> +	LONG_L		sp, a0, (10 * LONGSIZE)
> +	LONG_L		ra, a0, (11 * LONGSIZE)
> +
> +	/* Move the return value in place, but return 1 if passed 0. */
> +	li.w		a0, 1
> +	beqz		a1, 1f
> +	move		a0, a1
> +1:
> +	jr		ra
> +ENDPROC(longjmp)
> +.popsection
>

