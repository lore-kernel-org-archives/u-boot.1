Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35159606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T4rrV929;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Y9uwdOaJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF07A80E29;
	Mon, 16 Nov 2026 07:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JNfbaFC0ZNUn; Mon, 16 Nov 2026 07:47:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BED880E19
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794815241;
	b=BDQBY+q5W8dIxnCWNSe/T+gl4WIouTfP6MLQZroDXZHfIBbaLodB9CPZrSDcCYQ/Stnk
	 +O12AEJPIy9uuPzXuZdc89m2xYvShf8jMWDIJzPOf0dPpFJQ+nL60RMQhw8SdLiLpNNnG
	 ciDTbGKlooRwIu1TT7TIP+yC8sJ9EeNC9P9ygulv9t3s7Sy2cOimlrB27X3IMnk9YaMkO
	 gEx2Cc7p5riMwjFReUbJpaJD2fsyWlzJCbkMiMLaNTbaHoAJ3Zc0oNjXMDWr8lcvAkARD
	 Vh1ZrRzMKLMueNBXscPU7LfNpzycD0n6juz679SiWf+B0lFDG5vZOPkP1JUzx4OsRhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794815241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AellhbB3sihsGJ9ug221GoJanKfKnKzi+/f6HzlgA50=;
	b=Hj62XhF7jOXZw8hgcPmn/y9G4EH0XH8Hd6rl4qTXL0F6UBC+FKqnFp7/GUieeV2mXm9+
	 yTkIQeI1NtrrGkhWQ6uwtinTi+Fp0jd0equx2MDAZcJlkVV6V1POqGYpSL31X6N3cY3+w
	 pM1XjGU0cWPSYvkR9BQ/LgFMzBo5P58kCI4RnRnzUDXroPFneoMakNOnC3MFrsR/7x65m
	 NyV6w97KU4hFxGH8T+EOHL/qjqHX/e//5zLGYG66gsyhWgOiWkuFiO1MCOH4BxG0xoRjq
	 GxWJI2pYmSMPuGaueMrWIzGp9wkLSIyoU3ERLKPtFo8MnOvatRO0AbOCzqFlCvJEK3g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794815241;
	bh=AellhbB3sihsGJ9ug221GoJanKfKnKzi+/f6HzlgA50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T4rrV929us8S+5kzjAtQFSVb0AkHKWb2MmmvlaXPpyjrU2IsyIJXtv0xQAAMQxQNz
	 z/Y2vl+fGi+jfYoSwsRLl02MFDfPqZ3GukOwzBCmaj9vrxgcVwzzpPdqskd7N1dfoH
	 U8N+MAGEY2MNfeWAxFRHCxj/X2qAKOZZQXf7AeNmj0b4BzYviz6PejWjJ9trOLxLvc
	 rZtVPcZSZxxdZfHI9zND9qPhr0jLQKg7mQcGpDyVjt070keD3sXWw5wlP9g89jms7n
	 onfJN7hYMcKsnDkJ1BT4LbYbm0+dwtuRnGYIOnkUdSyCzYFtvQW2OaEzKQXgyxXHn7
	 Mw0+mt1mIAPkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BED880E19;
	Mon, 16 Nov 2026 07:47:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EAD02D7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3FAC400D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYeEkRtLmIAx for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 07:47:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7539540012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Y9uwdOaJ
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7539540012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:47:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=Y9uwdOaJnE/DjVak5q8idwnHFdCjad+jEPNLhSlhyH3vz4tc7pT1txLhibd3SqgHjCO49HCQRGIdHc4aN/Gb5JSytnHCslBygH04dzy6P5S+sHHGH7SFiUfC2gdPOKgJ8ptGADza818f1v4PqINVuiPbZnIMJA05yLdxsHz8dGQ=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=AellhbB3sihsGJ9ug221GoJanKfKnKzi+/f6HzlgA50=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794815190610880.9233846317147;
 Sun, 15 Nov 2026 23:46:30 -0800 (PST)
Date: Mon, 16 Nov 2026 07:46:15 +0000
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
Message-ID: <avq0xyKg0QOCMKkU@pie>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
 <20261101210449.1235102-2-indrek.kruusa@gmail.com>
 <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
 <20261110220009.50776-1-indrek.kruusa@gmail.com>
 <DMVVCK6FNA7K.3UJ8SKV87RZOE@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMVVCK6FNA7K.3UJ8SKV87RZOE@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 10:53:52PM +0800, Junhui Liu wrote:
> Hi Indrek,
> 
> On Wed Nov 11, 2026 at 6:00 AM CST, Indrek Kruusa wrote:
> > Hi Junhui,
> >
> > thanks for the review!
> >
> > On Sat, 07 Nov 2026 17:11:09 +0800
> > Junhui Liu <junhui.liu@pigmoral.tech> wrote:
> >
> >> Hi Indrek,
> >>
> >> Thanks for your work. I'm very happy to finally see someone proposing
> >> this work.
> >
> > Thanks, I appreciate that!
> >
> >> But for most of the T-Head/XuanTie CPU support, I think it is
> >> better to make it common code instead of keeping it private to sun20i.
> >>
> >
> > Agreed.
> >
> > [...]
> >
> >> > diff --git a/arch/riscv/cpu/sun20i/cache.c b/arch/riscv/cpu/sun20i/cache.c
> >> > new file mode 100644
> >> > index 00000000000..c961eded109
> >> > --- /dev/null
> >> > +++ b/arch/riscv/cpu/sun20i/cache.c
> >> > @@ -0,0 +1,88 @@
> >> > +// SPDX-License-Identifier: GPL-2.0+
> >> > +/*
> >> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> >> > + *
> >> > + * T-Head C906 cache operations for the Allwinner D1 (sun20i).
> >> > + */
> >> > +
> >> > +#include <asm/arch/thead_csr.h>
> >> > +#include <asm/cache.h>
> >> > +#include <asm/csr.h>
> >> > +#include <cpu_func.h>
> >> > +#include <linux/bitops.h>
> >> > +
> >> > +/*
> >> > + * T-Head cache maintenance instructions, emitted as raw encodings because the
> >> > + * assembler does not know them: dcache.ciall (write back and invalidate all),
> >> > + * dcache.iall (invalidate all), icache.ipa (invalidate the line holding the
> >> > + * physical address in a0) and sync.i (wait for the operation to complete).
> >> > + * They only decode while MXSTATUS.THEADISAEE is set, which harts_early_init()
> >> > + * does before any of them is used.
> >> > + */
> >> > +#define THEAD_SYNC_I            ".long 0x01a0000b"
> >> > +#define THEAD_DCACHE_CIALL      ".long 0x0030000b"
> >> > +#define THEAD_DCACHE_IALL       ".long 0x0020000b"
> >> > +#define THEAD_ICACHE_IPA_A0     ".long 0x0385000b"
> >> > +
> >> > +static inline void sync_i(void)
> >> > +{
> >> > +	asm volatile (THEAD_SYNC_I ::: "memory");
> >> > +}
> >> > +
> >> > +void flush_dcache_all(void)
> >> > +{
> >> > +	asm volatile (THEAD_DCACHE_CIALL ::: "memory");
> >> > +	sync_i();
> >> > +}
> >> > +
> >> > +void invalidate_dcache_all(void)
> >> > +{
> >> > +	asm volatile (THEAD_DCACHE_IALL ::: "memory");
> >> > +	sync_i();
> >> > +}
> >> > +
> >> > +void invalidate_icache_range(unsigned long start, unsigned long end)
> >> > +{
> >> > +	register ulong addr asm ("a0") = start & -CONFIG_SYS_CACHELINE_SIZE;
> >> > +
> >> > +	for (; addr < end; addr += CONFIG_SYS_CACHELINE_SIZE)
> >> > +		asm volatile (THEAD_ICACHE_IPA_A0 :: "r" (addr) : "memory");
> >> > +	sync_i();
> >> > +}
> >>
> >> For these cache operations, arch/riscv/lib/thead_cmo.c already contains
> >> the D-cache range operations. The D-cache all operations and I-cache
> >> operations added here are common T-Head/XuanTie CMO operations, so I
> >> think it's better to add them to that common file instead of being
> >> implemented under sun20i.
> >>
> >
> > Actually, that's what I initially had in mind, but I didn't feel comfortable
> > doing it. Sure, and as Yao also suggested, I'll move flush_dcache_all() and
> > invalidate_dcache_all() to arch/riscv/lib/thead_cmo.c in the next version.
> >
> > I still need to investigate invalidate_icache_range() and whether I can
> > simply rely on the default implementation in arch/riscv/lib/cache.c. If so,
> > the local cache.c can go away entirely.
> 
> I checked the C906 user manual, and it explicitly states that fence.i
> invalidates the I-cache. Both CV1800B and TH1520 already use the default
> invalidate_icache_range() in arch/riscv/lib/cache.c, so I think D1 can
> use the default implementation as well.

tl;dr I agree.

FYI, see here[1] for a possible defect in xtheadsync documentation,
which considers th.sync.i the only mechanism to order cache operations
with instruction fetches, conflicting with the definition of fence.i in
RISC-V's specification.

Referring to armv8's cache operations and usage of
invalidate_icache_all(), I think we do need the semantics of pipeline
hazard barrier provided for it.

But according to the fact that the current software is written with only
fence.i in mind but still works on HARTs with xtheadsync, I think the
contradiction with fence.i's definition is probably an error in
xtheadsync's documentation.

> >
> >> > +
> >> > +#if CONFIG_IS_ENABLED(RISCV_MMODE)
> >> > +
> >> > +void icache_enable(void)
> >> > +{
> >> > +	invalidate_icache_all();
> >> > +	csr_set(CSR_MHCR, MHCR_IE);
> >> > +}
> >> > +
> >> > +void icache_disable(void)
> >> > +{
> >> > +	csr_clear(CSR_MHCR, MHCR_IE);
> >> > +}
> >> > +
> >> > +int icache_status(void)
> >> > +{
> >> > +	return csr_read(CSR_MHCR) & MHCR_IE;
> >> > +}
> >> > +
> >> > +void dcache_enable(void)
> >> > +{
> >> > +	invalidate_dcache_all();
> >> > +	csr_set(CSR_MHCR, MHCR_DE);
> >> > +}
> >> > +
> >> > +void dcache_disable(void)
> >> > +{
> >> > +	flush_dcache_all();
> >> > +	csr_clear(CSR_MHCR, MHCR_DE);
> >> > +}
> >> > +
> >> > +int dcache_status(void)
> >> > +{
> >> > +	return csr_read(CSR_MHCR) & MHCR_DE;
> >> > +}
> >> > +
> >> > +#endif
> >>
> >> For this part, arch/riscv/cpu/th1520/cache.c already has related
> >> functions. Can we extract them into a common file, for example
> >> arch/riscv/lib/thead_cache.c, and provide a THEAD_CACHE config for the
> >> platforms that need it to select?
> >>
> >
> > I had a look: th1520/cache.c has only the _enable() and _status() half, and
> > cv1800b has no cache.c at all (it relies on the defaults in
> > arch/riscv/lib/cache.c).
> > Yes, having a common thead_cache.c with all six functions and a THEAD_CACHE
> > symbol would give all three SoCs the same implementation.
> >
> > I can add the THEAD_CACHE symbol and arch/riscv/lib/thead_cache.c, but I'm
> > not sure about touching the other SoCs in this series. What do you think? I
> > can prepare a separate series if that would be a better way to handle this
> > consistently across all three SoCs.
> 
> I would prefer a separate series for the common T-Head/XuanTie support,
> so it can be reviewed and applied independently and benefit other SoCs
> as well. The D1 support series can then depend on it.

This sounds good to me.

> Best regards,
> Junhui Liu
> 
> >
> >> [...]
> >>
> >> > diff --git a/arch/riscv/include/asm/arch-sun20i/thead_csr.h b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
> >> > new file mode 100644
> >> > index 00000000000..4d6e15aab1c
> >> > --- /dev/null
> >> > +++ b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
> >> > @@ -0,0 +1,29 @@
> >> > +/* SPDX-License-Identifier: GPL-2.0+ */
> >> > +/*
> >> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> >> > + *
> >> > + * T-Head C906 CSR definitions for the Allwinner D1 (sun20i).
> >> > + */
> >> > +
> >> > +#ifndef _ASM_RISCV_ARCH_THEAD_CSR_H
> >> > +#define _ASM_RISCV_ARCH_THEAD_CSR_H
> >> > +
> >> > +#define CSR_MXSTATUS            0x7c0
> >> > +#define CSR_MHCR                0x7c1
> >> > +#define CSR_MHINT               0x7c5
> >> > +
> >> > +#define MXSTATUS_THEADISAEE     BIT(22) /* T-HEAD ISA extensions enable */
> >> > +#define MXSTATUS_MAEE           BIT(21) /* MMU honours the PTE memory type */
> >> > +#define MXSTATUS_MM             BIT(15) /* misaligned access enable */
> >> > +
> >> > +#define MHCR_IE                 BIT(0)  /* icache enable */
> >> > +#define MHCR_DE                 BIT(1)  /* dcache enable */
> >> > +#define MHCR_WA                 BIT(2)  /* dcache write allocate */
> >> > +#define MHCR_RS                 BIT(4)  /* return stack enable */
> >> > +#define MHCR_BPE                BIT(5)  /* branch prediction enable */
> >> > +#define MHCR_BTB_C906           BIT(6)  /* branch target prediction enable */
> >> > +
> >> > +#define MHINT_IPLD              BIT(8)  /* icache prefetch enable */
> >> > +#define MHINT_IWPE              BIT(9)  /* icache way prediction enable */
> >> > +
> >> > +#endif /* _ASM_RISCV_ARCH_THEAD_CSR_H */
> >>
> >> A number of these CSR definitions already exist in
> >> arch/riscv/cpu/th1520/spl.c and arch/riscv/cpu/th1520/cache.c. Can the
> >> common register numbers and bitfields be moved into a common header,
> >> such as arch/riscv/include/asm/thead_csr.h, instead of placing them
> >> under arch-sun20i?
> >
> > Agreed. I'll create arch/riscv/include/asm/thead_csr.h in the next version,
> > identify the common register definitions and bitfields, and move them there.
> >
> > Again, I'm not sure I'd want to convert the other SoCs in the same series.
> > Would a separate series be better?

A separate series makes sense.

> > One thing I should flag while we're on this: my patch 1 defines
> > `MHINT_IWPE` as `BIT(9)`.
> > I did some AI-assisted investigation into these fields, and the finding was:
> > "In the OpenC906 RTL, bit 9 is LPE (its write decode is commented out and
> > the field is tied to zero), while bit 10 is IWPE."
> > So, according to this finding, the series as posted never actually enables
> > I-cache way prediction. That's a bug in my patch, will fix it.
> >
> >>
> >> -- 
> >> Best regards,
> >> Junhui Liu
> >>
> >
> > Thanks,
> > Indrek

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

[1]: https://github.com/XUANTIE-RV/thead-extension-spec/issues/81
