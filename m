Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF60606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RZ4qRfeS;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UZu/+Y5N
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 586AD60811;
	Mon, 16 Nov 2026 20:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4hqWy0bWZUb; Mon, 16 Nov 2026 20:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 195CB60774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794860257;
	b=npxT+Q9OJzmDz9v5Hbz8enjgGMDZom68gdAaD3XrEAMVyagLL+zqYEDD1KnnxHb2wPPs
	 wR8dIlC8VFoFIzkG/X7a3ymRzaeJ9TIyHEQT2TcoLo4r8/zbEP+DbiRFUypsPScsKlXMx
	 RaIo+HyzQW7mdEV+ajvCOtQyBwCCaav1Bxfa8svzAqJDvECHozhZZj9dctgQFb4lmefxJ
	 ER36u9vqthYvxMWqb3jjWjBBLsPdcrPCfTiSf0+v8E+pK0g37NrYByiPARXEznLF2b9s2
	 PAhxwOz1xPCT0B8mFwn6LuvRdZrhFIzAAXmdZdxNLEkOIMBFy58DxD4FAXGUdmHtmOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860257;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XBvhx/AVX/Y1f+Hi2iuBMZHNw/Vx119yck6RVjSod0g=;
	b=LCpa0bvogwvNp0SD515aW3q1pEpMDJ+D3YvD0TRrwMy6IqkrrRk/TYAP1FjzAET/mCJ1
	 obrJVkLxmX5A3aBCmVlFAvhkN2NX+E+7PwbOptdKnclcdCXRAIgWfn9hcaBmEY4BjZJ99
	 cLH8fHQzU1pnWISQZGclLvbRb1iJED6j0j6JON7s6tAv7y6RckE7HE5MEJkMsUcBhoCP+
	 DbOzviOefRrQwyh3eeW4kM/hscfIw2axLGr0C5oOt2QtlRr2gui5jT564RyXpte6Pkn3m
	 gmfvjBW+NDh2dOEi5Uwka6vPX84L6u+Yt/bmiZcOU4tqYWDCAkKAxbqRSxf4wKwxzEQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794860257;
	bh=XBvhx/AVX/Y1f+Hi2iuBMZHNw/Vx119yck6RVjSod0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZ4qRfeS928/qguGhFNBD/vxVwTLPsWh619OvVHYEANXeMToIsgujhqbKN2rDMQQM
	 dDHjoHx333H8l2iqbLgFBz9zIxVHMJI2HlyZl3V4YYw2+1jIpyrRGdq5qNvPFPqKlW
	 losZRZTHwKwUAOVuBxQ80kD1fxjfXK/8II8f1kGERrSdCSA/qzwzEe4nmc1AEdBJ3G
	 PonoESN8dhPKf/jqRkhl8DnnD3ou20pl65lBuS2TYL1hY4TDFs/Zz9WOzrw0C3qJL/
	 LVRCjPS2ssTKqOc9dfWvoz51xryrBMa8seNW1UkSIEV0hbuIypwaA4nUCQwYqNkjtG
	 sURx9+a9oiJgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 195CB60774;
	Mon, 16 Nov 2026 20:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28657109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22A3F405A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhYwOQJhR0C6 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70BA940588
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=UZu/+Y5N
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70BA940588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:17:34 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3adfc004920so40533421fa.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794860252; x=1795465052;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XBvhx/AVX/Y1f+Hi2iuBMZHNw/Vx119yck6RVjSod0g=;
 b=UZu/+Y5NqIUyu5yRq+TeluTQzLL9f9Ja6/8Uork2CTup9OPPKab52tn3w1SHUGYcD1
 vBRdYnNIaslDwyIiwcHWCgs/30FcUxelOHQi0htjVxkqJrzO1k+D1kEqtl+G7w5KDrxP
 2wpM2mDkbwhDdCP5dBRG29OGO05NVz2qR/PVsBD1URnQrtKQcFQ87p2xX6+1H7JTyD+8
 Ef5F7yS6Dd+LH35HA72aLolCwwnAeCCgL/FADFtSub4Itt8js3zJ2mVqBM31lEckVtdg
 MDs8DsWnmnDkYaP23aSbJGAto+2xG6jhinIfcR2kyyD+vIkVkwTndqeUX06AzvOrUSJU
 9m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860252; x=1795465052;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XBvhx/AVX/Y1f+Hi2iuBMZHNw/Vx119yck6RVjSod0g=;
 b=PXyfr/7PXT5sVjmAlXlaojOQevAEziu97uMWZghTTNm0fK10hkMq2kja+aN4wEpKUM
 YGs2MublWII+q/dH7tkop8HSVMQx1TCQEOoR4n8b9134vil3WGJYJ3sIuCvMsKvJiEWz
 /9yl0Trff8TsX+3wOUto7LNNFxWpeNbIGF5asHUuHNRwjNex7ShJb8k703Ey2ifx1raW
 jXT3ljjh+JWROrbxEEvebOEMcR4PWfaoEl1zA2Gezb8qxe+SNbMeHC0UxwUuJ/5981IV
 8+tIq1xZ/daZK6JJBEwQKpOOVm4SHTXGBXUGvwse0WdDLmkKJpxQsKoJ1Jd7Z5cghBOj
 nRUw==
X-Forwarded-Encrypted: i=1;
 AL+hErF7GtuV8vR0RLoZUyxLOl4xqy0CP3LHfwmEld55IP7hJCjBBCvlLdZ2DMFj0lOKFcbWVK7umIc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8N6FcKaFPr0eERKGWkQBE+8W3yYt4yL5kLSJJsu7v+vpzPvJHf
 G1AUJdvn1G8Y6uRG1JcZ6ZhjY+AtzPyDiPSnCZ/tFtkSN8kXhzCx9ylF
X-Gm-Gg: AYBFou06YmaXEwPkTwifHlOP/BJUUD+Fis2aJy63dGC4xyypHoGPnheyum6xP9raTUo
 ejl0blOYAr4MDPQF68hx8KWHixPQUt+TPNzrraEcnk62XObj9gp/6qKBEp8Xs6K0PuNpOZbK867
 YPn5wLtjO0Hms04f1g/KuS7PB89rg+AefTvwWcq0dEeA7rZViNbj6i63p6O7v59K0p0XUit0TC7
 M+SS7bu/fNfSqwFselMRpIzuw0spIyEZPEhgRnNGn/9AJiOg7mEBMlgAU/Jko5zKuQ+pedT5Rga
 EUrx3/Mu3A/gtUl8Lj6W4bZ+PIveGid1VrwNjwOju4ZH2O7yOg781SWM0gDXTAGiZ2IjFzPFlGp
 xB/Gc0RX+OOI9FjlIAO+MhEG/o2wp5HRgtTu44MnEQdpQmMXHSyLLyQX/7xNE5l1l5vGWg420N+
 VSYE62B/3hzCEq/Fv6jNKNOhUA1zYD4oZkBg30D9DEhhfsE6TgKyTa2xJwaXndJYx/CtJFLUHvb
 bsz3t9C6EXhmOcYjRZnUhXhZt2YqPamA25nIgQ3tP/XGaoCL4/CSCGlFXK3PyySU2oHIDI9wfYj
 +deV5OpgEQgAez27WOa/yUTWLCCg4hRqK0d3Z/1NQdiZG1ECvEYeQFtDDS/9CudntWcHtJ87ScF
 mHx/3VJCqMF1q
X-Received: by 2002:a2e:bccc:0:b0:3ac:f164:4449 with SMTP id
 38308e7fff4ca-3ae2b524a9bmr35276441fa.29.1794860251556; 
 Mon, 16 Nov 2026 12:17:31 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3ae2b780c5csm34742481fa.21.2026.11.16.12.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:17:29 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: "Yao Zi" <me@ziyao.cc>, "Junhui Liu" <junhui.liu@pigmoral.tech>,
 u-boot@lists.u-boot-project.org
Cc: Indrek Kruusa <indrek.kruusa@gmail.com>,
 "Andre Przywara" <andre.przywara@arm.com>,
 "Tim Ouyang" <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Lukasz Majewski" <lukma@nabladev.com>,
 "Stefan Roese" <stefan.roese@mailbox.org>,
 "Samuel Holland" <samuel@sholland.org>, "Tom Rini" <trini@konsulko.com>,
 "Hiago De Franco" <hfranco@baylibre.com>
Subject: Re: [PATCH 01/10] riscv: cpu: add Allwinner D1/D1s(F133) CPU support
Date: Mon, 16 Nov 2026 22:17:06 +0200
Message-ID: <20261116201708.1040974-1-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avq0xyKg0QOCMKkU@pie>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
 <20261101210449.1235102-2-indrek.kruusa@gmail.com>
 <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
 <20261110220009.50776-1-indrek.kruusa@gmail.com>
 <DMVVCK6FNA7K.3UJ8SKV87RZOE@pigmoral.tech> <avq0xyKg0QOCMKkU@pie>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yao Zi, Junhui,

thanks for the feedback.

On Mon, 16 Nov 2026 07:46:15 +0000
Yao Zi <me@ziyao.cc> wrote:

> On Sun, Nov 15, 2026 at 10:53:52PM +0800, Junhui Liu wrote:
> > Hi Indrek,
> > 
> > On Wed Nov 11, 2026 at 6:00 AM CST, Indrek Kruusa wrote:
> > > Hi Junhui,
> > >
> > > thanks for the review!
> > >
> > > On Sat, 07 Nov 2026 17:11:09 +0800
> > > Junhui Liu <junhui.liu@pigmoral.tech> wrote:
> > >
> > >> Hi Indrek,
> > >>
> > >> Thanks for your work. I'm very happy to finally see someone proposing
> > >> this work.
> > >
> > > Thanks, I appreciate that!
> > >
> > >> But for most of the T-Head/XuanTie CPU support, I think it is
> > >> better to make it common code instead of keeping it private to sun20i.
> > >>
> > >
> > > Agreed.
> > >
> > > [...]
> > >
> > >> > diff --git a/arch/riscv/cpu/sun20i/cache.c b/arch/riscv/cpu/sun20i/cache.c
> > >> > new file mode 100644
> > >> > index 00000000000..c961eded109
> > >> > --- /dev/null
> > >> > +++ b/arch/riscv/cpu/sun20i/cache.c
> > >> > @@ -0,0 +1,88 @@
> > >> > +// SPDX-License-Identifier: GPL-2.0+
> > >> > +/*
> > >> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> > >> > + *
> > >> > + * T-Head C906 cache operations for the Allwinner D1 (sun20i).
> > >> > + */
> > >> > +
> > >> > +#include <asm/arch/thead_csr.h>
> > >> > +#include <asm/cache.h>
> > >> > +#include <asm/csr.h>
> > >> > +#include <cpu_func.h>
> > >> > +#include <linux/bitops.h>
> > >> > +
> > >> > +/*
> > >> > + * T-Head cache maintenance instructions, emitted as raw encodings because the
> > >> > + * assembler does not know them: dcache.ciall (write back and invalidate all),
> > >> > + * dcache.iall (invalidate all), icache.ipa (invalidate the line holding the
> > >> > + * physical address in a0) and sync.i (wait for the operation to complete).
> > >> > + * They only decode while MXSTATUS.THEADISAEE is set, which harts_early_init()
> > >> > + * does before any of them is used.
> > >> > + */
> > >> > +#define THEAD_SYNC_I            ".long 0x01a0000b"
> > >> > +#define THEAD_DCACHE_CIALL      ".long 0x0030000b"
> > >> > +#define THEAD_DCACHE_IALL       ".long 0x0020000b"
> > >> > +#define THEAD_ICACHE_IPA_A0     ".long 0x0385000b"
> > >> > +
> > >> > +static inline void sync_i(void)
> > >> > +{
> > >> > +	asm volatile (THEAD_SYNC_I ::: "memory");
> > >> > +}
> > >> > +
> > >> > +void flush_dcache_all(void)
> > >> > +{
> > >> > +	asm volatile (THEAD_DCACHE_CIALL ::: "memory");
> > >> > +	sync_i();
> > >> > +}
> > >> > +
> > >> > +void invalidate_dcache_all(void)
> > >> > +{
> > >> > +	asm volatile (THEAD_DCACHE_IALL ::: "memory");
> > >> > +	sync_i();
> > >> > +}
> > >> > +
> > >> > +void invalidate_icache_range(unsigned long start, unsigned long end)
> > >> > +{
> > >> > +	register ulong addr asm ("a0") = start & -CONFIG_SYS_CACHELINE_SIZE;
> > >> > +
> > >> > +	for (; addr < end; addr += CONFIG_SYS_CACHELINE_SIZE)
> > >> > +		asm volatile (THEAD_ICACHE_IPA_A0 :: "r" (addr) : "memory");
> > >> > +	sync_i();
> > >> > +}
> > >>
> > >> For these cache operations, arch/riscv/lib/thead_cmo.c already contains
> > >> the D-cache range operations. The D-cache all operations and I-cache
> > >> operations added here are common T-Head/XuanTie CMO operations, so I
> > >> think it's better to add them to that common file instead of being
> > >> implemented under sun20i.
> > >>
> > >
> > > Actually, that's what I initially had in mind, but I didn't feel comfortable
> > > doing it. Sure, and as Yao also suggested, I'll move flush_dcache_all() and
> > > invalidate_dcache_all() to arch/riscv/lib/thead_cmo.c in the next version.
> > >
> > > I still need to investigate invalidate_icache_range() and whether I can
> > > simply rely on the default implementation in arch/riscv/lib/cache.c. If so,
> > > the local cache.c can go away entirely.
> > 
> > I checked the C906 user manual, and it explicitly states that fence.i
> > invalidates the I-cache. Both CV1800B and TH1520 already use the default
> > invalidate_icache_range() in arch/riscv/lib/cache.c, so I think D1 can
> > use the default implementation as well.
>
> tl;dr I agree.
>

OK, clear then, thanks!

> FYI, see here[1] for a possible defect in xtheadsync documentation,
> which considers th.sync.i the only mechanism to order cache operations
> with instruction fetches, conflicting with the definition of fence.i in
> RISC-V's specification.
>

Wow, OK! That's beyond my technical comfort zone, but good to know.

> Referring to armv8's cache operations and usage of
> invalidate_icache_all(), I think we do need the semantics of pipeline
> hazard barrier provided for it.
>
> But according to the fact that the current software is written with only
> fence.i in mind but still works on HARTs with xtheadsync, I think the
> contradiction with fence.i's definition is probably an error in
> xtheadsync's documentation.
>
> > >
> > >> > +
> > >> > +#if CONFIG_IS_ENABLED(RISCV_MMODE)
> > >> > +
> > >> > +void icache_enable(void)
> > >> > +{
> > >> > +	invalidate_icache_all();
> > >> > +	csr_set(CSR_MHCR, MHCR_IE);
> > >> > +}
> > >> > +
> > >> > +void icache_disable(void)
> > >> > +{
> > >> > +	csr_clear(CSR_MHCR, MHCR_IE);
> > >> > +}
> > >> > +
> > >> > +int icache_status(void)
> > >> > +{
> > >> > +	return csr_read(CSR_MHCR) & MHCR_IE;
> > >> > +}
> > >> > +
> > >> > +void dcache_enable(void)
> > >> > +{
> > >> > +	invalidate_dcache_all();
> > >> > +	csr_set(CSR_MHCR, MHCR_DE);
> > >> > +}
> > >> > +
> > >> > +void dcache_disable(void)
> > >> > +{
> > >> > +	flush_dcache_all();
> > >> > +	csr_clear(CSR_MHCR, MHCR_DE);
> > >> > +}
> > >> > +
> > >> > +int dcache_status(void)
> > >> > +{
> > >> > +	return csr_read(CSR_MHCR) & MHCR_DE;
> > >> > +}
> > >> > +
> > >> > +#endif
> > >>
> > >> For this part, arch/riscv/cpu/th1520/cache.c already has related
> > >> functions. Can we extract them into a common file, for example
> > >> arch/riscv/lib/thead_cache.c, and provide a THEAD_CACHE config for the
> > >> platforms that need it to select?
> > >>
> > >
> > > I had a look: th1520/cache.c has only the _enable() and _status() half, and
> > > cv1800b has no cache.c at all (it relies on the defaults in
> > > arch/riscv/lib/cache.c).
> > > Yes, having a common thead_cache.c with all six functions and a THEAD_CACHE
> > > symbol would give all three SoCs the same implementation.
> > >
> > > I can add the THEAD_CACHE symbol and arch/riscv/lib/thead_cache.c, but I'm
> > > not sure about touching the other SoCs in this series. What do you think? I
> > > can prepare a separate series if that would be a better way to handle this
> > > consistently across all three SoCs.
> > 
> > I would prefer a separate series for the common T-Head/XuanTie support,
> > so it can be reviewed and applied independently and benefit other SoCs
> > as well. The D1 support series can then depend on it.
>
> This sounds good to me.

OK, a separate series for arch/riscv/lib/thead_cache.c it is. Will do. Let's see how it goes.

>
> > Best regards,
> > Junhui Liu
> > 
> > >
> > >> [...]
> > >>
> > >> > diff --git a/arch/riscv/include/asm/arch-sun20i/thead_csr.h b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
> > >> > new file mode 100644
> > >> > index 00000000000..4d6e15aab1c
> > >> > --- /dev/null
> > >> > +++ b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
> > >> > @@ -0,0 +1,29 @@
> > >> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > >> > +/*
> > >> > + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> > >> > + *
> > >> > + * T-Head C906 CSR definitions for the Allwinner D1 (sun20i).
> > >> > + */
> > >> > +
> > >> > +#ifndef _ASM_RISCV_ARCH_THEAD_CSR_H
> > >> > +#define _ASM_RISCV_ARCH_THEAD_CSR_H
> > >> > +
> > >> > +#define CSR_MXSTATUS            0x7c0
> > >> > +#define CSR_MHCR                0x7c1
> > >> > +#define CSR_MHINT               0x7c5
> > >> > +
> > >> > +#define MXSTATUS_THEADISAEE     BIT(22) /* T-HEAD ISA extensions enable */
> > >> > +#define MXSTATUS_MAEE           BIT(21) /* MMU honours the PTE memory type */
> > >> > +#define MXSTATUS_MM             BIT(15) /* misaligned access enable */
> > >> > +
> > >> > +#define MHCR_IE                 BIT(0)  /* icache enable */
> > >> > +#define MHCR_DE                 BIT(1)  /* dcache enable */
> > >> > +#define MHCR_WA                 BIT(2)  /* dcache write allocate */
> > >> > +#define MHCR_RS                 BIT(4)  /* return stack enable */
> > >> > +#define MHCR_BPE                BIT(5)  /* branch prediction enable */
> > >> > +#define MHCR_BTB_C906           BIT(6)  /* branch target prediction enable */
> > >> > +
> > >> > +#define MHINT_IPLD              BIT(8)  /* icache prefetch enable */
> > >> > +#define MHINT_IWPE              BIT(9)  /* icache way prediction enable */
> > >> > +
> > >> > +#endif /* _ASM_RISCV_ARCH_THEAD_CSR_H */
> > >>
> > >> A number of these CSR definitions already exist in
> > >> arch/riscv/cpu/th1520/spl.c and arch/riscv/cpu/th1520/cache.c. Can the
> > >> common register numbers and bitfields be moved into a common header,
> > >> such as arch/riscv/include/asm/thead_csr.h, instead of placing them
> > >> under arch-sun20i?
> > >
> > > Agreed. I'll create arch/riscv/include/asm/thead_csr.h in the next version,
> > > identify the common register definitions and bitfields, and move them there.
> > >
> > > Again, I'm not sure I'd want to convert the other SoCs in the same series.
> > > Would a separate series be better?
>
> A separate series makes sense.

I'll send the arch/riscv/include/asm/thead_csr.h and related changes as a separate series as well.

>
> > > One thing I should flag while we're on this: my patch 1 defines
> > > `MHINT_IWPE` as `BIT(9)`.
> > > I did some AI-assisted investigation into these fields, and the finding was:
> > > "In the OpenC906 RTL, bit 9 is LPE (its write decode is commented out and
> > > the field is tied to zero), while bit 10 is IWPE."
> > > So, according to this finding, the series as posted never actually enables
> > > I-cache way prediction. That's a bug in my patch, will fix it.
> > >
> > >>
> > >> -- 
> > >> Best regards,
> > >> Junhui Liu
> > >>
> > >
> > > Thanks,
> > > Indrek
>
> -- 
> Thanks,
> Yao Zi
>
> Meow-mrrp-mrow, I'm a cat.
>
> [1]: https://github.com/XUANTIE-RV/thead-extension-spec/issues/81
>

Thanks,
Indrek
