Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD2606A320
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Srwf9hJD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDDctKrD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21AC140A3D;
	Tue, 10 Nov 2026 22:00:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PoWMNpExuY4k; Tue, 10 Nov 2026 22:00:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBEAB405DF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794348034;
	b=ddE4Rcq7ZQpUs0n+hNJu7CbwqSr53+mfEik6yuTvvybial11DRFaNXjHnP9TrENPkhOL
	 l3pvSyrHifaFoCcnoG+PTn4IkjW/89TR7humbGnQtlrcJxI8t02u+1SxIaG2rejlsddqL
	 AFmKICupGWsyQ+mjiQh9p5uUYeGe/dLtZHaDIogCwgjV8zBe3uTbNS4hmjjDtuWgAdY/l
	 xfikvgtNuRxhT6Xc7R53r5KGCB0g//3t4huCJ0xI2IcYm44oUsyE45MrS0HqnK3QSn3Gx
	 EDpy21TB29TLIrZaGrBpWmpHUcrzXoQXfPrT/MxgaHwNvgtpBqPEdW/Zr0Q7GpOHmPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794348034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w4798AoAI3bh7jRQUCI9xKZi8u+FNKanAtkr9ZrX7RI=;
	b=fICSW+KFFOzVPXOPeL6gXdKU2k+d7VOz+zN+7Z+XrqnMo+YezyBvGZ6qSM7paMr7+Q9O
	 rtsHmJSeFW0ij12y+awUnpa+JIxtAv3aQfGugM3lfhcPuE+O4Nle8DYAOSSsd5Sn6K25E
	 7Nbr/cYSaUZbNRuiWG1zYP0uFaNVgBiEP/w3Cnd+BoMgreXriNoUZpKlaxIEY7xUHlU8I
	 VGt7i7ec6WgZwmuaw4GIW4Pb17+WETAa+WP7YyWKI0Xx52Sr7dcpxgVJ7/12u91JNNuAy
	 wIhM2bycQ1Ie+1vMJY4AG3bjX7wl2a2843SJtzHRe2vX1XLBBL68yitXGDfw1N7JezA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDDctKrD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794348034;
	bh=w4798AoAI3bh7jRQUCI9xKZi8u+FNKanAtkr9ZrX7RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Srwf9hJDMlrxuzDo3ofsYkCIjSwA4NM1Al04MbsiB+QJfudwJHFkPKt8nub3R0KPq
	 1ZsvKbJ9FDuLVuR01YXMjjrZ0/qK6WSLXYRYU4siN2/I8H21y3E/JCzM9LD/DLRq8a
	 LUzQSLEgPGmGRJeRK21nQ6apHo4snISE1SOR9zJgmtMhHqQKkagbKXIDowOruze6iE
	 XylXmU/z+QRtsgaM76m0DAuakA2P0HHIEaS7pO774lXcewMFJagA5YpI7o75nWw5cn
	 pSNIymVgIXrsH/eELLT4zqFHHZGi7D36PiqbuVS3TzLfx3ldLqOcU61X4MUy0GHCRg
	 Jx/iZLQfCnIqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBEAB405DF;
	Tue, 10 Nov 2026 22:00:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B337F731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9877B405DF
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNMlKBN0k84K for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 22:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 52778405D6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=PDDctKrD
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52778405D6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 22:00:30 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3ab27e45e7cso19440421fa.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794348028; x=1794952828;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w4798AoAI3bh7jRQUCI9xKZi8u+FNKanAtkr9ZrX7RI=;
 b=PDDctKrDdJEgCfyoFrtGnI1FzrAXkLCWj5XIJcLTWcvVUnb6f3anTIJpylaOveL/SP
 /6K4/haRp7rDS0zWv3PZ8kdLF/qC8X/pfS5oVugCnoLi5aiUedrmX/AXpxWPrxBPtBBi
 dGVsFjexD7pgkMZ3N0FooMiQaAVYDLre14uQO0YjuUELElWUgbYMEkrd3tRukwk5A0i4
 rb5ws3Rh6H4cexCN8QMRNjQRbZmMfK7eTowU2mI3ZDZ7ZvTXI6PTIGXjwlcH1ElouiMC
 g1EVLgX7uT2RhURDDUgR+kKkNcC/YzjxVvdDhbS6CrG1oRd/m9zirLeDCVemB6c+Y+R5
 qhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794348028; x=1794952828;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w4798AoAI3bh7jRQUCI9xKZi8u+FNKanAtkr9ZrX7RI=;
 b=pcbJp6nBAFBjuMVB+0Q8JEugSKMnRDB9arZpAk9SRxw+wRRvtUC3zNWBvsc2NsKCJs
 HC7dYVqtb9chVaMze6v0m+pYa3cmXKZd5AH6gOw7jXYhH5AoS4AsmmQX692y4rSSPc0Q
 QlcX5PHSXVmheuZZAKwwV+DXtciVntmRcPyU2NTrXLsy0OmvwsujyW6TquOWiQW12v5z
 Yj2MGbkfzs9TbnLXQRZSZYBNC/Wbl9/K1Fu3GS1Es/ZZtJzYWpx5t0wrh/XM8P42mtEQ
 ziMhQRGGJ4ZWLUtxu5R+R4nhxk4gq/1U7B0BCJcH8pFDaS+gNcvNv+spMrtdHdnldxMd
 GMcw==
X-Forwarded-Encrypted: i=1;
 AL+hErFugTy0J4ocG/B/0Y7Kqgjr1Tr86IlgPGogKTO8awb/utH3VW1664n4eMllAU5oIVpldP0lPq0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9o4p+eY5KjMA6PU8yyaYUCToaIOvMoWxxe+Qa9PXW4Pr2alZwz
 ITp5mE0HfrYir7PctsCQBxdZwJ4P56yLV6dBdShIHuDhx8/sTWjYHrNn
X-Gm-Gg: AYBFou2aUQaOrM9+9NYCVjOUMPAyq/Wlc94DIaR0aJ6hptBwpGb+lCCMbip3JmI9NGW
 xB+Tk4kEK2MOBfNceXWKpG3sS8bgnbxzCyQkSYRbkqRyAhSmZeRxa5SyrKCbq2EKmjNEkp5l6kU
 zmBhHlhkJi2LpQnac/wiao65cSDROfc1qKjwHWFRmmm4+QuhuUEjP2DuaU5eafX00uUP375O5ON
 pSd3zYUOUtvFKIlOc0xGE+DVjR+/0GLX0Wb3vwv5PQNBZqClIXKL4cuKUOPObWRqspzVR3WpNf0
 grd416Ct7pR/qXarDoo53g2t21dbxpHKDOZlRs3PJe3xd/wxryhrN7bRSazHFwsTG07Wn9+BIvl
 ESnQk18v1U4CfFsvSE55129X4eA4oBtC5uUi6epGSRc1Uh9TAzbWpsgYW2OAO5RmmSaGmO9Ri8d
 foe7ORC8GavDicyyPL2G6+hFNochfurLg7QS66wEd3IVzMXgtqS8lxSGqoBE6YcaEj4H5/WqXLA
 9csSqhr2c3/gFF9d6zDwvjv1B1gzs4+SZnzeHFBrJNvomHT4NB6LA3uK9eHYXn0jq+Azo5zDbUb
 WxGHzu66gO3oxghCJyyO6IEwgu9hI4eeAPD0Gbf/iNIC3z4suy+ovCCNIFffb0zqNG8=
X-Received: by 2002:a05:651c:885:b0:3ac:e902:f22d with SMTP id
 38308e7fff4ca-3ae126e3235mr319061fa.27.1794348028286; 
 Tue, 10 Nov 2026 14:00:28 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3ae092783c2sm8150161fa.29.2026.11.10.14.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 14:00:27 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>,
	u-boot@lists.u-boot-project.org
Cc: Indrek Kruusa <indrek.kruusa@gmail.com>,
 "Andre Przywara" <andre.przywara@arm.com>,
 "Tim Ouyang" <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>,
 "Yao Zi" <me@ziyao.cc>, "Peng Fan" <peng.fan@nxp.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Lukasz Majewski" <lukma@nabladev.com>,
 "Stefan Roese" <stefan.roese@mailbox.org>,
 "Samuel Holland" <samuel@sholland.org>, "Tom Rini" <trini@konsulko.com>,
 "Hiago De Franco" <hfranco@baylibre.com>
Subject: Re: [PATCH 01/10] riscv: cpu: add Allwinner D1/D1s(F133) CPU support
Date: Wed, 11 Nov 2026 00:00:06 +0200
Message-ID: <20261110220009.50776-1-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
 <20261101210449.1235102-2-indrek.kruusa@gmail.com>
 <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junhui,

thanks for the review!

On Sat, 07 Nov 2026 17:11:09 +0800
Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> Hi Indrek,
>
> Thanks for your work. I'm very happy to finally see someone proposing
> this work.

Thanks, I appreciate that!

> But for most of the T-Head/XuanTie CPU support, I think it is
> better to make it common code instead of keeping it private to sun20i.
>

Agreed.

[...]

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
>

Actually, that's what I initially had in mind, but I didn't feel comfortable
doing it. Sure, and as Yao also suggested, I'll move flush_dcache_all() and
invalidate_dcache_all() to arch/riscv/lib/thead_cmo.c in the next version.

I still need to investigate invalidate_icache_range() and whether I can
simply rely on the default implementation in arch/riscv/lib/cache.c. If so,
the local cache.c can go away entirely.

> > +
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
>

I had a look: th1520/cache.c has only the _enable() and _status() half, and
cv1800b has no cache.c at all (it relies on the defaults in
arch/riscv/lib/cache.c).
Yes, having a common thead_cache.c with all six functions and a THEAD_CACHE
symbol would give all three SoCs the same implementation.

I can add the THEAD_CACHE symbol and arch/riscv/lib/thead_cache.c, but I'm
not sure about touching the other SoCs in this series. What do you think? I
can prepare a separate series if that would be a better way to handle this
consistently across all three SoCs.

> [...]
>
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

Agreed. I'll create arch/riscv/include/asm/thead_csr.h in the next version,
identify the common register definitions and bitfields, and move them there.

Again, I'm not sure I'd want to convert the other SoCs in the same series.
Would a separate series be better?

One thing I should flag while we're on this: my patch 1 defines
`MHINT_IWPE` as `BIT(9)`.
I did some AI-assisted investigation into these fields, and the finding was:
"In the OpenC906 RTL, bit 9 is LPE (its write decode is commented out and
the field is tied to zero), while bit 10 is IWPE."
So, according to this finding, the series as posted never actually enables
I-cache way prediction. That's a bug in my patch, will fix it.

>
> -- 
> Best regards,
> Junhui Liu
>

Thanks,
Indrek
