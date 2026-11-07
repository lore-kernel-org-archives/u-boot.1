Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAD606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LwrqMj2x;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=mdVHkZTl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8465C810AD;
	Sat,  7 Nov 2026 16:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzE4GITjzkik; Sat,  7 Nov 2026 16:14:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B1888108C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794068063;
	b=g+UzT7BFFyhmvktqTXeRLxrT36UDs8FPmMK/emlN8pIpE6c0NQvEWXbMRPyJWjqSzska
	 zo8fv4cLqPEiaBcXyy/Bb/YJvFFN6Mf+GSgzDaT0PR9zvVB+65a8tqHl0mFCiZtlE3ubM
	 plhA0adoUXHHUGV6pGm+QsEEyyGR5yPjrtdjM/J3s+ryl5avXWSnkTZvC0PlAS0cSL8m2
	 kC9T/7PcH3mAXJSaNwnc4p75IyCiVEbvG4UUUXPwoIxuZgFhif/MyM+SYfOQUuBeXSEUY
	 9QnX5O0iT+UxsEVNc6JoEoKm3tdqjtEBBh9iAktLeBvT6tt3V0ZXOp1WvbrrzkgwBNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794068063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RBJmw9DaHNcWNPWY7kh9ybubHieoelnL1XnrmPAPGWg=;
	b=oPL4He4BnrPYQORZjRr+ml6S4VB99Udkr3AOfGLULkWgwhR+tafziuiu1saQYAyuPXXQ
	 kAVXh3OQA+zgaxYCkGSYdXZLWQQpEirJClH0Jzh4tUKBwFivf02AFOX/IZz7HKqsa6O3S
	 t6XZzdm/7ZTwnsEODWgW3g3HljMYdi1rognqQYbKFcevKJlSv90lAeg9vJ78UQ3nHOdbk
	 RkRy4notGdYiWOCB8A6iPShxq7pSN5LrsbU0qlfz32UwV4ge98Zf0XkU3kj5za3AxVUYm
	 2glv6TD797wBm9u9HJa+v3RL+4ffvN1+GYsJFapu6xM6GY8nvyVrObGDMVDB7peb7yQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=mdVHkZTl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794068063;
	bh=RBJmw9DaHNcWNPWY7kh9ybubHieoelnL1XnrmPAPGWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LwrqMj2xVGKBrd7vbb3HEZWOZR49eT3f8Rblz3X4PQyJKEsR5iahA8BcmMlx+oEe3
	 sboe/eo2NDZ7y6M7CX6gg8N/6SFq0+uQbIOO4ArZ4+uPn9Cm9NKeO6BVoyWRbYeJkd
	 9JTJwE2Eua3fg+ZG2mjd2w3RMaIaX0Cueci7YIAOaW4CWlLV5bcheanyIsZ6bJFO6x
	 onhJGztVuWw5ddrqbRH6TjLlBkuPgb+F1LvEaw/ddux+yinVVXOYfAPA9b9ur0sO4p
	 8AuI/1O6C4y7rgczaX/CsGpFOjmK9kJChttLUk34JhLfIFQkmpjEuqE/VolpRS9hIY
	 rVZFLuXEbwSTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B1888108C;
	Sat,  7 Nov 2026 16:14:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 357FD32A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:14:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26C678108C
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cGJA34U_i4J for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 16:14:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1CC381061
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=mdVHkZTl
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1CC381061
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:14:20 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=mdVHkZTlPjdIMmZiZ4niU9s8ENian0fY+fk4P+OL08TGnNZCscG4oDufOiZFf427ZDK6zBP9m+GwtR0CaaDMD3+mF98S/iSJnuieFdWoS7nA2GD6TCFn+B4PriYRi/uFrcS66ZqFmtrwUCClrAa9GAHyHbHrIzbashNkw0gfmAs=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=RBJmw9DaHNcWNPWY7kh9ybubHieoelnL1XnrmPAPGWg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794068012645435.32638510275797; 
 Sat, 7 Nov 2026 08:13:32 -0800 (PST)
Date: Sat, 7 Nov 2026 16:13:17 +0000
From: Yao Zi <me@ziyao.cc>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>,
 "Indrek Kruusa" <indrek.kruusa@gmail.com>,
 <u-boot@lists.u-boot-project.org>
Cc: "Andre Przywara" <andre.przywara@arm.com>,
 "Tim Ouyang" <tim609@andestech.com>,
 "Leo Liang" <leo.liang@sifive.com>, "Yao Zi" <me@ziyao.cc>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Lukasz Majewski" <lukma@nabladev.com>,
 "Stefan Roese" <stefan.roese@mailbox.org>,
 "Samuel Holland" <samuel@sholland.org>, "Tom Rini" <trini@konsulko.com>,
 "Hiago De Franco" <hfranco@baylibre.com>
Subject: Re: [PATCH 01/10] riscv: cpu: add Allwinner D1/D1s(F133) CPU support
Message-ID: <au9OHWLH7vOodDMQ@pie>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
 <20261101210449.1235102-2-indrek.kruusa@gmail.com>
 <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.65.33
X-ZohoMailClient: External
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 05:11:09PM +0800, Junhui Liu wrote:
> Hi Indrek,
> 
> Thanks for your work. I'm very happy to finally see someone proposing
> this work. But for most of the T-Head/XuanTie CPU support, I think it is
> better to make it common code instead of keeping it private to sun20i.
> 
> On Mon Nov 2, 2026 at 5:04 AM CST, Indrek Kruusa wrote:
> > Add the C906 support for the D1/D1s(F133) SoCs:
> >
> > - T-Head cache operations from the custom cache instructions
> > - harts_early_init() programming MXSTATUS, MHCR and MHINT
> > - cleanup_before_linux() disabling interrupts and flushing the caches
> > - dram_init() from the device tree memory nodes
> > - the T-Head CSR, CCU clock and memory map headers
> > - SUN20I Kconfig (cache line size, T-Head CMO support)
> >
> > Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
> > ---
> >  arch/riscv/Kconfig                            |  1 +
> >  arch/riscv/cpu/sun20i/Kconfig                 |  6 ++
> >  arch/riscv/cpu/sun20i/Makefile                |  5 ++
> >  arch/riscv/cpu/sun20i/cache.c                 | 88 +++++++++++++++++++
> >  arch/riscv/cpu/sun20i/cpu.c                   | 44 ++++++++++
> >  arch/riscv/cpu/sun20i/dram.c                  | 21 +++++
> >  arch/riscv/include/asm/arch-sun20i/clock.h    | 71 +++++++++++++++
> >  arch/riscv/include/asm/arch-sun20i/cpu.h      | 18 ++++
> >  .../riscv/include/asm/arch-sun20i/thead_csr.h | 29 ++++++
> >  9 files changed, 283 insertions(+)
> >  create mode 100644 arch/riscv/cpu/sun20i/Kconfig
> >  create mode 100644 arch/riscv/cpu/sun20i/Makefile
> >  create mode 100644 arch/riscv/cpu/sun20i/cache.c
> >  create mode 100644 arch/riscv/cpu/sun20i/cpu.c
> >  create mode 100644 arch/riscv/cpu/sun20i/dram.c
> >  create mode 100644 arch/riscv/include/asm/arch-sun20i/clock.h
> >  create mode 100644 arch/riscv/include/asm/arch-sun20i/cpu.h
> >  create mode 100644 arch/riscv/include/asm/arch-sun20i/thead_csr.h

...

> > diff --git a/arch/riscv/cpu/sun20i/cache.c b/arch/riscv/cpu/sun20i/cache.c
> > new file mode 100644
> > index 00000000000..c961eded109
> > --- /dev/null
> > +++ b/arch/riscv/cpu/sun20i/cache.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> > + *
> > + * T-Head C906 cache operations for the Allwinner D1 (sun20i).
> > + */
> > +
> > +#include <asm/arch/thead_csr.h>
> > +#include <asm/cache.h>
> > +#include <asm/csr.h>
> > +#include <cpu_func.h>
> > +#include <linux/bitops.h>
> > +
> > +/*
> > + * T-Head cache maintenance instructions, emitted as raw encodings because the
> > + * assembler does not know them: dcache.ciall (write back and invalidate all),
> > + * dcache.iall (invalidate all), icache.ipa (invalidate the line holding the
> > + * physical address in a0) and sync.i (wait for the operation to complete).
> > + * They only decode while MXSTATUS.THEADISAEE is set, which harts_early_init()
> > + * does before any of them is used.
> > + */
> > +#define THEAD_SYNC_I            ".long 0x01a0000b"
> > +#define THEAD_DCACHE_CIALL      ".long 0x0030000b"
> > +#define THEAD_DCACHE_IALL       ".long 0x0020000b"
> > +#define THEAD_ICACHE_IPA_A0     ".long 0x0385000b"
> > +
> > +static inline void sync_i(void)
> > +{
> > +	asm volatile (THEAD_SYNC_I ::: "memory");
> > +}
> > +
> > +void flush_dcache_all(void)
> > +{
> > +	asm volatile (THEAD_DCACHE_CIALL ::: "memory");
> > +	sync_i();
> > +}
> > +
> > +void invalidate_dcache_all(void)
> > +{
> > +	asm volatile (THEAD_DCACHE_IALL ::: "memory");
> > +	sync_i();
> > +}
> > +
> > +void invalidate_icache_range(unsigned long start, unsigned long end)
> > +{
> > +	register ulong addr asm ("a0") = start & -CONFIG_SYS_CACHELINE_SIZE;
> > +
> > +	for (; addr < end; addr += CONFIG_SYS_CACHELINE_SIZE)
> > +		asm volatile (THEAD_ICACHE_IPA_A0 :: "r" (addr) : "memory");
> > +	sync_i();
> > +}
> 
> For these cache operations, arch/riscv/lib/thead_cmo.c already contains
> the D-cache range operations. The D-cache all operations and I-cache
> operations added here are common T-Head/XuanTie CMO operations, so I
> think it's better to add them to that common file instead of being
> implemented under sun20i.

Agree. The only piece we miss in thead_cmo.c should be
flush_dcache_all() and invalidate_dcache_all().

> > +#if CONFIG_IS_ENABLED(RISCV_MMODE)
> > +
> > +void icache_enable(void)
> > +{
> > +	invalidate_icache_all();
> > +	csr_set(CSR_MHCR, MHCR_IE);
> > +}
> > +
> > +void icache_disable(void)
> > +{
> > +	csr_clear(CSR_MHCR, MHCR_IE);
> > +}
> > +
> > +int icache_status(void)
> > +{
> > +	return csr_read(CSR_MHCR) & MHCR_IE;
> > +}
> > +
> > +void dcache_enable(void)
> > +{
> > +	invalidate_dcache_all();
> > +	csr_set(CSR_MHCR, MHCR_DE);
> > +}
> > +
> > +void dcache_disable(void)
> > +{
> > +	flush_dcache_all();
> > +	csr_clear(CSR_MHCR, MHCR_DE);
> > +}
> > +
> > +int dcache_status(void)
> > +{
> > +	return csr_read(CSR_MHCR) & MHCR_DE;
> > +}
> > +
> > +#endif
> 
> For this part, arch/riscv/cpu/th1520/cache.c already has related
> functions. Can we extract them into a common file, for example
> arch/riscv/lib/thead_cache.c, and provide a THEAD_CACHE config for the
> platforms that need it to select?

Agree, too. I've suggested[1] Hiago, who is working on CV1800B support,
to do similar things. Ccing him here so you could coordinate with each
other to avoid duplicated work.

...

> > diff --git a/arch/riscv/include/asm/arch-sun20i/thead_csr.h b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
> > new file mode 100644
> > index 00000000000..4d6e15aab1c
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> > + *
> > + * T-Head C906 CSR definitions for the Allwinner D1 (sun20i).
> > + */
> > +
> > +#ifndef _ASM_RISCV_ARCH_THEAD_CSR_H
> > +#define _ASM_RISCV_ARCH_THEAD_CSR_H
> > +
> > +#define CSR_MXSTATUS            0x7c0
> > +#define CSR_MHCR                0x7c1
> > +#define CSR_MHINT               0x7c5
> > +
> > +#define MXSTATUS_THEADISAEE     BIT(22) /* T-HEAD ISA extensions enable */
> > +#define MXSTATUS_MAEE           BIT(21) /* MMU honours the PTE memory type */
> > +#define MXSTATUS_MM             BIT(15) /* misaligned access enable */
> > +
> > +#define MHCR_IE                 BIT(0)  /* icache enable */
> > +#define MHCR_DE                 BIT(1)  /* dcache enable */
> > +#define MHCR_WA                 BIT(2)  /* dcache write allocate */
> > +#define MHCR_RS                 BIT(4)  /* return stack enable */
> > +#define MHCR_BPE                BIT(5)  /* branch prediction enable */
> > +#define MHCR_BTB_C906           BIT(6)  /* branch target prediction enable */
> > +
> > +#define MHINT_IPLD              BIT(8)  /* icache prefetch enable */
> > +#define MHINT_IWPE              BIT(9)  /* icache way prediction enable */
> > +
> > +#endif /* _ASM_RISCV_ARCH_THEAD_CSR_H */
> 
> A number of these CSR definitions already exist in
> arch/riscv/cpu/th1520/spl.c and arch/riscv/cpu/th1520/cache.c. Can the
> common register numbers and bitfields be moved into a common header,
> such as arch/riscv/include/asm/thead_csr.h, instead of placing them
> under arch-sun20i?

I'll second it.

> -- 
> Best regards,
> Junhui Liu

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

[1]: https://lore.kernel.org/all/aunnaN0SOzsRBtlG@pie/
