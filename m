Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555E606A327
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PrDdmLTG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=qvMHM9uC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1C0480F84;
	Sun, 15 Nov 2026 14:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UbulbcYGn_Ni; Sun, 15 Nov 2026 14:55:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF13B80F7E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794754503;
	b=iVlK8Tt0wSkck2nQXzgYbhz4WgnLIa4Lf7uOf5Fna2zCn2i9Vh5kWLC32kZRuiGwwVY4
	 hsZi0Lx2F7dGIOYtV9bYJr5HJ9tPcOsJ0oswVComP1Oj9UQ00vEPA8ISHOiI6DnZ22zQT
	 5Joln6pm/60XIc1pOXt0pKvEuwnP3l6a3xDpiFuneotAIWb8POi6lLNsc4aR62HLWP+Ra
	 QSVd0sctfRnQS4Qsr21bkHW8nn+xreVBC/b5HUu1hZof1zIUXRZobeGUsQVfH3tgrT79L
	 SdLttWRE9+yGb4pd6DMZOCcfJieNtIgm6XF7QrmpKpyZPwOX3JGzyAG/4bUBkG0nWpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794754503;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1Zv4AKHFXPZNlTuSL2b2naQv/2OZ1Pt2CJ1B1ba59/Y=;
	b=RhlfGNp2XfIX5GXKqPF3lW9zyaAzrX9MnPWb0os6rAi+BJEj5xaW+COeyasuGsey3b51
	 5xLfIUD/28qt7t+5gHy6y/b6LpqOHeTXz4DYSLEE3zq1w2mSJ/SYasw1gn6kmmRcosmlW
	 dLMScBFPLRFvC2g6GgXCsu7f19gt7huf2onPn3O5NAybGn+9qnn4O8xrKwb3FPeCu8hRr
	 oBiBThzCSorGL+GXf+j/sGG9EllxBhIl31rh8VXrGOfYyUL7zuKTHQLDZFfegPH0lhdtL
	 vNEQN2dwiw0n1iiIvTco8w5s6FYJ7h1rfZOXUSpnT89aDoX/8YXTOsw0ybzxZmxgWNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794754503;
	bh=1Zv4AKHFXPZNlTuSL2b2naQv/2OZ1Pt2CJ1B1ba59/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PrDdmLTGTHkCyo06A6owkt7hI0anqJV32sbVkosR8Wx7FOB7qV0EWGz8/zn8GbpHw
	 lM4bBX0n+3vy0pixZI7BsvLeFOwWrXtbCGYGzFUrFC9aHYvZ6ZDG7xjL7SvqQWdO1I
	 Pxoatu+yz5QZiCFvcChCC4+PfZV+wqt4eDqfA6TFNlofawS546W4JyRJBA/cTFMRUd
	 8N0kEi2e/0Xh0uSVhDqakB2x6/BtdNfl2LlhCJ+tUjgAvCruqY6a1ECFifrjXLvpDk
	 DtLU7NbVNrwp0ULvr0nFT06NV5ZYohmB638WuVaU/RCD2StFgPb9ITc8WXhgiA1kIQ
	 PfzujZRFJQaag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF13B80F7E;
	Sun, 15 Nov 2026 14:55:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E52C3109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA62660621
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCg2hsRGgR2T for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 14:54:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AED316060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=qvMHM9uC
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AED316060D
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 14:54:56 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=qvMHM9uCG8IZCXvBMlVXPlSH9vwbzE2i9sr+jetFBSJWKw5Km/9EMAWwylrpvlOvpqtCBAP4aM7PSnOZQzEn2ounzEYW7VujJ/fzqkcwHi8eXeBIrOkFsGn9P4UIeocSuoYCFuZd9JK0thpDe9i34e5SY8Ew334bCrSEMnl+dik=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=1Zv4AKHFXPZNlTuSL2b2naQv/2OZ1Pt2CJ1B1ba59/Y=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794754442165963.8176458709165;
 Sun, 15 Nov 2026 06:54:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 22:53:52 +0800
Message-Id: <DMVVCK6FNA7K.3UJ8SKV87RZOE@pigmoral.tech>
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Indrek Kruusa" <indrek.kruusa@gmail.com>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>, <u-boot@lists.u-boot-project.org>
Cc: "Andre Przywara" <andre.przywara@arm.com>, "Tim Ouyang"
 <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>, "Yao Zi"
 <me@ziyao.cc>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Lukasz Majewski" <lukma@nabladev.com>, "Stefan
 Roese" <stefan.roese@mailbox.org>, "Samuel Holland" <samuel@sholland.org>,
 "Tom Rini" <trini@konsulko.com>, "Hiago De Franco" <hfranco@baylibre.com>
Subject: Re: [PATCH 01/10] riscv: cpu: add Allwinner D1/D1s(F133) CPU support
X-Mailer: aerc 0.22.0
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
 <20261101210449.1235102-2-indrek.kruusa@gmail.com>
 <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
 <20261110220009.50776-1-indrek.kruusa@gmail.com>
In-Reply-To: <20261110220009.50776-1-indrek.kruusa@gmail.com>
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Indrek,

On Wed Nov 11, 2026 at 6:00 AM CST, Indrek Kruusa wrote:
> Hi Junhui,
>
> thanks for the review!
>
> On Sat, 07 Nov 2026 17:11:09 +0800
> Junhui Liu <junhui.liu@pigmoral.tech> wrote:
>
>> Hi Indrek,
>>
>> Thanks for your work. I'm very happy to finally see someone proposing
>> this work.
>
> Thanks, I appreciate that!
>
>> But for most of the T-Head/XuanTie CPU support, I think it is
>> better to make it common code instead of keeping it private to sun20i.
>>
>
> Agreed.
>
> [...]
>
>> > diff --git a/arch/riscv/cpu/sun20i/cache.c b/arch/riscv/cpu/sun20i/cac=
he.c
>> > new file mode 100644
>> > index 00000000000..c961eded109
>> > --- /dev/null
>> > +++ b/arch/riscv/cpu/sun20i/cache.c
>> > @@ -0,0 +1,88 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
>> > + *
>> > + * T-Head C906 cache operations for the Allwinner D1 (sun20i).
>> > + */
>> > +
>> > +#include <asm/arch/thead_csr.h>
>> > +#include <asm/cache.h>
>> > +#include <asm/csr.h>
>> > +#include <cpu_func.h>
>> > +#include <linux/bitops.h>
>> > +
>> > +/*
>> > + * T-Head cache maintenance instructions, emitted as raw encodings be=
cause the
>> > + * assembler does not know them: dcache.ciall (write back and invalid=
ate all),
>> > + * dcache.iall (invalidate all), icache.ipa (invalidate the line hold=
ing the
>> > + * physical address in a0) and sync.i (wait for the operation to comp=
lete).
>> > + * They only decode while MXSTATUS.THEADISAEE is set, which harts_ear=
ly_init()
>> > + * does before any of them is used.
>> > + */
>> > +#define THEAD_SYNC_I            ".long 0x01a0000b"
>> > +#define THEAD_DCACHE_CIALL      ".long 0x0030000b"
>> > +#define THEAD_DCACHE_IALL       ".long 0x0020000b"
>> > +#define THEAD_ICACHE_IPA_A0     ".long 0x0385000b"
>> > +
>> > +static inline void sync_i(void)
>> > +{
>> > +	asm volatile (THEAD_SYNC_I ::: "memory");
>> > +}
>> > +
>> > +void flush_dcache_all(void)
>> > +{
>> > +	asm volatile (THEAD_DCACHE_CIALL ::: "memory");
>> > +	sync_i();
>> > +}
>> > +
>> > +void invalidate_dcache_all(void)
>> > +{
>> > +	asm volatile (THEAD_DCACHE_IALL ::: "memory");
>> > +	sync_i();
>> > +}
>> > +
>> > +void invalidate_icache_range(unsigned long start, unsigned long end)
>> > +{
>> > +	register ulong addr asm ("a0") =3D start & -CONFIG_SYS_CACHELINE_SIZ=
E;
>> > +
>> > +	for (; addr < end; addr +=3D CONFIG_SYS_CACHELINE_SIZE)
>> > +		asm volatile (THEAD_ICACHE_IPA_A0 :: "r" (addr) : "memory");
>> > +	sync_i();
>> > +}
>>
>> For these cache operations, arch/riscv/lib/thead_cmo.c already contains
>> the D-cache range operations. The D-cache all operations and I-cache
>> operations added here are common T-Head/XuanTie CMO operations, so I
>> think it's better to add them to that common file instead of being
>> implemented under sun20i.
>>
>
> Actually, that's what I initially had in mind, but I didn't feel comforta=
ble
> doing it. Sure, and as Yao also suggested, I'll move flush_dcache_all() a=
nd
> invalidate_dcache_all() to arch/riscv/lib/thead_cmo.c in the next version=
.
>
> I still need to investigate invalidate_icache_range() and whether I can
> simply rely on the default implementation in arch/riscv/lib/cache.c. If s=
o,
> the local cache.c can go away entirely.

I checked the C906 user manual, and it explicitly states that fence.i
invalidates the I-cache. Both CV1800B and TH1520 already use the default
invalidate_icache_range() in arch/riscv/lib/cache.c, so I think D1 can
use the default implementation as well.

>
>> > +
>> > +#if CONFIG_IS_ENABLED(RISCV_MMODE)
>> > +
>> > +void icache_enable(void)
>> > +{
>> > +	invalidate_icache_all();
>> > +	csr_set(CSR_MHCR, MHCR_IE);
>> > +}
>> > +
>> > +void icache_disable(void)
>> > +{
>> > +	csr_clear(CSR_MHCR, MHCR_IE);
>> > +}
>> > +
>> > +int icache_status(void)
>> > +{
>> > +	return csr_read(CSR_MHCR) & MHCR_IE;
>> > +}
>> > +
>> > +void dcache_enable(void)
>> > +{
>> > +	invalidate_dcache_all();
>> > +	csr_set(CSR_MHCR, MHCR_DE);
>> > +}
>> > +
>> > +void dcache_disable(void)
>> > +{
>> > +	flush_dcache_all();
>> > +	csr_clear(CSR_MHCR, MHCR_DE);
>> > +}
>> > +
>> > +int dcache_status(void)
>> > +{
>> > +	return csr_read(CSR_MHCR) & MHCR_DE;
>> > +}
>> > +
>> > +#endif
>>
>> For this part, arch/riscv/cpu/th1520/cache.c already has related
>> functions. Can we extract them into a common file, for example
>> arch/riscv/lib/thead_cache.c, and provide a THEAD_CACHE config for the
>> platforms that need it to select?
>>
>
> I had a look: th1520/cache.c has only the _enable() and _status() half, a=
nd
> cv1800b has no cache.c at all (it relies on the defaults in
> arch/riscv/lib/cache.c).
> Yes, having a common thead_cache.c with all six functions and a THEAD_CAC=
HE
> symbol would give all three SoCs the same implementation.
>
> I can add the THEAD_CACHE symbol and arch/riscv/lib/thead_cache.c, but I'=
m
> not sure about touching the other SoCs in this series. What do you think?=
 I
> can prepare a separate series if that would be a better way to handle thi=
s
> consistently across all three SoCs.

I would prefer a separate series for the common T-Head/XuanTie support,
so it can be reviewed and applied independently and benefit other SoCs
as well. The D1 support series can then depend on it.

Best regards,
Junhui Liu

>
>> [...]
>>
>> > diff --git a/arch/riscv/include/asm/arch-sun20i/thead_csr.h b/arch/ris=
cv/include/asm/arch-sun20i/thead_csr.h
>> > new file mode 100644
>> > index 00000000000..4d6e15aab1c
>> > --- /dev/null
>> > +++ b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
>> > @@ -0,0 +1,29 @@
>> > +/* SPDX-License-Identifier: GPL-2.0+ */
>> > +/*
>> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
>> > + *
>> > + * T-Head C906 CSR definitions for the Allwinner D1 (sun20i).
>> > + */
>> > +
>> > +#ifndef _ASM_RISCV_ARCH_THEAD_CSR_H
>> > +#define _ASM_RISCV_ARCH_THEAD_CSR_H
>> > +
>> > +#define CSR_MXSTATUS            0x7c0
>> > +#define CSR_MHCR                0x7c1
>> > +#define CSR_MHINT               0x7c5
>> > +
>> > +#define MXSTATUS_THEADISAEE     BIT(22) /* T-HEAD ISA extensions enab=
le */
>> > +#define MXSTATUS_MAEE           BIT(21) /* MMU honours the PTE memory=
 type */
>> > +#define MXSTATUS_MM             BIT(15) /* misaligned access enable *=
/
>> > +
>> > +#define MHCR_IE                 BIT(0)  /* icache enable */
>> > +#define MHCR_DE                 BIT(1)  /* dcache enable */
>> > +#define MHCR_WA                 BIT(2)  /* dcache write allocate */
>> > +#define MHCR_RS                 BIT(4)  /* return stack enable */
>> > +#define MHCR_BPE                BIT(5)  /* branch prediction enable *=
/
>> > +#define MHCR_BTB_C906           BIT(6)  /* branch target prediction e=
nable */
>> > +
>> > +#define MHINT_IPLD              BIT(8)  /* icache prefetch enable */
>> > +#define MHINT_IWPE              BIT(9)  /* icache way prediction enab=
le */
>> > +
>> > +#endif /* _ASM_RISCV_ARCH_THEAD_CSR_H */
>>
>> A number of these CSR definitions already exist in
>> arch/riscv/cpu/th1520/spl.c and arch/riscv/cpu/th1520/cache.c. Can the
>> common register numbers and bitfields be moved into a common header,
>> such as arch/riscv/include/asm/thead_csr.h, instead of placing them
>> under arch-sun20i?
>
> Agreed. I'll create arch/riscv/include/asm/thead_csr.h in the next versio=
n,
> identify the common register definitions and bitfields, and move them the=
re.
>
> Again, I'm not sure I'd want to convert the other SoCs in the same series=
.
> Would a separate series be better?
>
> One thing I should flag while we're on this: my patch 1 defines
> `MHINT_IWPE` as `BIT(9)`.
> I did some AI-assisted investigation into these fields, and the finding w=
as:
> "In the OpenC906 RTL, bit 9 is LPE (its write decode is commented out and
> the field is tied to zero), while bit 10 is IWPE."
> So, according to this finding, the series as posted never actually enable=
s
> I-cache way prediction. That's a bug in my patch, will fix it.
>
>>
>> --=20
>> Best regards,
>> Junhui Liu
>>
>
> Thanks,
> Indrek
