Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469E606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gqjnzZws;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=pteIcjhy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBDC180E36;
	Wed, 25 Nov 2026 15:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2plyt2ldb0sk; Wed, 25 Nov 2026 15:01:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D151280C0F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795618909;
	b=f/F3AdxKWCfHdtL6i7PTE+1gQerSGJBmf/Yp0sMLxMNNuUOR3Eb3CxN/xR3ZVvuTAjeM
	 /RVy7jvGnXWwxPIyDp5DhLHf7EPktTnbj+OT8e1WjJcj5jrWHWn3JQZlZHRR9EOVf6v4n
	 VGib/CFm054ua8gOg0aVmb3I1+N0wlIA01P+MsZgAvI6j/1QSpJs8gW92iTOIA5ckcwiu
	 CGzEiyPpToSebUNuzE5TCs0Ro10kidS6jVCYvKG6oINZoDRNiXa/ItU+qttpDwabNWMnk
	 ABeWrpq8YET5EA2bHZmhzjVi+iioZ5++U1liRlLBiFHXJUctG5bgFy8NWKG0AHaeCsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795618909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KT1yaHWlLNEXXpUaeKSwURZyk6ZZOwvhTf1TmJHyr8w=;
	b=Ikjc7z3iEzDFBeeyjd8fiLsJRiEMuuJ8ykAd3f4PLdxy6ftVotcw0577PJ8/mW5gAyqk
	 v7p5H6Br7ywSReyvYFv+PED17hDPcwNzFNGNQ9VVHhgC/6ii8Yc6zLD2NnBBmCRDCOBg3
	 h1drW052qOuxPPzfG+Y4lTnJ6dhiXomRV6Qntwxag8GeisOw5zQzmamy+caAfUhLCX9Tm
	 YA+dI6o58BDkawaLRSVvWdnKL8zXP4gI7ltvEAnS41/VKNO/pxQafzyOzBpQma15/1QK0
	 z8J1Es1p6Ar213VlYpXhX0BNgngkeW8sg4aSDgYdmFR2IMDcilHVlVW6KpVSzrBauVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795618909;
	bh=KT1yaHWlLNEXXpUaeKSwURZyk6ZZOwvhTf1TmJHyr8w=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqjnzZwsb/+qvB6blfzoRwaEIGnlY+brSTtp3e05fMxoAbW+miqkpejJcOTMpPzkV
	 8U6YZ4/48tRjxc4lW3Q4y4dXcPcGnYlgUeArK8S532LeUcKjTHY+a/2DNdT+UC3pUj
	 wE1nCtz7jWYvWWGxI3HKIeDeYNzZly3ACREmiKgleUKy5/hAwREd1R3+nXcdgQ7+Bl
	 KJYlEGg9nVv0vBHnK7TbbPaT62KP4kpZw2oJw5+JlGsjIiV2tkRjMNrldS4QqfiJii
	 p4fYo68ZCZ9KK/Ql1rChweK4vNW2dNc4VCMxOxlMD4wDbN+cb01TVgDC/KYfBXR7Qp
	 kAsTQGGGd8ojQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D151280C0F;
	Wed, 25 Nov 2026 15:01:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFCC843
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A242B4066D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJk7J2QN3vzN for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A646A40588
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=pteIcjhy
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A646A40588
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:01:40 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=pteIcjhy8dczTyyUPCerdKZCXDhqRYvPANWYx3UQZnw0OkzuGDQKqfouMD7FI9AnPUIHb4Fa0fk/prxsCasQsFeVvKLCRSb4U1SNfNE+DXarHef27N9iNsmtZ+kOMdvYh+0/AnsZv6j7bBJI4JQj9CGuraf+OMBW2uBvx7DIwpw=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=KT1yaHWlLNEXXpUaeKSwURZyk6ZZOwvhTf1TmJHyr8w=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795618848436761.1489205540908;
 Wed, 25 Nov 2026 07:00:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 23:00:41 +0800
Message-Id: <DN4DR7Y17SY4.2ZHAVQDW8UMV1@pigmoral.tech>
Cc: "Yao Zi" <me@ziyao.cc>, "Tom Rini" <trini@konsulko.com>, "Han Gao"
 <gaohan@iscas.ac.cn>, "Kongyang Liu" <seashell11234455@gmail.com>, "Junhui
 Liu" <junhui.liu@pigmoral.tech>, "Samuel Holland" <samuel@sholland.org>,
 "Andre Przywara" <andre.przywara@arm.com>, "Hiago De Franco"
 <hfranco@baylibre.com>, "E Shattow" <e@freeshell.de>, "Yixun Lan"
 <dlan@kernel.org>, "Raymond Mao" <raymond.mao@riscstar.com>,
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH 1/4] riscv: thead: add a common header for the C9xx CSRs
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Indrek Kruusa" <indrek.kruusa@gmail.com>, "Tim Ouyang"
 <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>
X-Mailer: aerc 0.22.0
References: <20261124195237.692679-1-indrek.kruusa@gmail.com>
 <20261124195237.692679-2-indrek.kruusa@gmail.com>
In-Reply-To: <20261124195237.692679-2-indrek.kruusa@gmail.com>
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

Hi Indrek,

Thanks for doing these!

On Wed Nov 25, 2026 at 3:52 AM CST, Indrek Kruusa wrote:
> Add a header with the register numbers and bitfields currently used by th=
e
> C9xx ports. It is placed in asm/ so that both SPL and U-Boot proper can
> include it. M-mode only.
>
> Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
> ---
>  arch/riscv/include/asm/thead_csr.h | 105 +++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 arch/riscv/include/asm/thead_csr.h
>
> diff --git a/arch/riscv/include/asm/thead_csr.h b/arch/riscv/include/asm/=
thead_csr.h
> new file mode 100644
> index 00000000000..32d3bf773ee
> --- /dev/null
> +++ b/arch/riscv/include/asm/thead_csr.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 Yao Zi <ziyao@disroot.org>
> + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> + *
> + * T-Head C9xx machine-mode control registers.
> + *
> + * Register numbers are shared, but the fields defined here are only tho=
se used
> + * by the in-tree ports. Availability and layout may differ between core=
s. Any
> + * known differences that could cause incorrect configuration are noted =
at the
> + * corresponding definitions.
> + */
> +
> +#ifndef _ASM_RISCV_THEAD_CSR_H
> +#define _ASM_RISCV_THEAD_CSR_H
> +
> +#include <linux/bitops.h>
> +
> +/* M-mode control registers */
> +#define CSR_MXSTATUS		0x7c0
> +#define CSR_MHCR		0x7c1
> +#define CSR_MCOR		0x7c2
> +#define CSR_MHINT		0x7c5
> +
> +/* not decoded by every core */
> +#define CSR_MCCR2		0x7c3
> +#define CSR_MHINT2		0x7cc
> +#define CSR_MHINT4		0x7ce
> +#define CSR_MSMPR		0x7f3
> +
> +/* MXSTATUS - machine-mode status */
> +#define MXSTATUS_THEADISAEE	BIT(22)	/* T-HEAD ISA extensions enable */
> +#define MXSTATUS_MAEE		BIT(21)	/* MMU honours the PTE memory type */
> +#define MXSTATUS_CLINTEE	BIT(17)	/* CLINT extension enable */
> +#define MXSTATUS_UCME		BIT(16)	/* user-mode cache ops enable */
> +#define MXSTATUS_MM		BIT(15)	/* misaligned access enable */

Could you keep Ziyao's original style, with the bit definitions grouped
under each CSR definition? That makes it easier to see which register
each bit belongs to.

Could you also keep the existing names, e.g. CSR_MXSTATUS_THEADISAEE?
Then patches 1 and 2 could be combined into a straightforward move of
the definitions into the common header, without renaming their uses
in arch/riscv/cpu/th1520/spl.c. Any new definitions could be added in a
separate patch, or later in the D1 series when needed. This keeps the
code move separate from other changes and makes it easier to review.

> +
> +/*
> + * MHCR - machine-mode hardware configuration
> + *
> + * WB and WBR are read-only and always read back as 1.
> + */
> +#define MHCR_IE			BIT(0)	/* I-cache enable */
> +#define MHCR_DE			BIT(1)	/* D-cache enable */
> +#define MHCR_WA			BIT(2)	/* D-cache write allocate */
> +#define MHCR_WB			BIT(3)	/* D-cache write back */
> +#define MHCR_RS			BIT(4)	/* return stack enable */
> +#define MHCR_BPE		BIT(5)	/* branch prediction enable */
> +#define MHCR_BTB		BIT(6)	/* branch target buffer enable */
> +#define MHCR_WBR		BIT(8)	/* write-back read allocate */
> +
> +/*
> + * MCOR - machine-mode cache operation
> + *
> + * The address is common but the encoding is not: the C906 decodes a sin=
gle
> + * INV and CLR bit qualified by a cache select field, the C910 four sepa=
rate
> + * invalidate bits.  The layout below is the C910's; a core whose manual
> + * documents the C906 form must not reuse these bits.
> + */
> +#define MCOR_CACHE_SEL(n)	((n) << 0)	/* 1: I-cache, 2: D-cache, 3: both =
*/
> +#define MCOR_INV		BIT(4)		/* invalidate the selected caches */
> +#define MCOR_BHT_INV		BIT(16)		/* branch history table */
> +#define MCOR_BTB_INV		BIT(17)		/* branch target buffer */
> +#define MCOR_IBP_INV		BIT(18)		/* indirect branch predictor */
> +
> +/* MCCR2 - machine-mode L2 cache configuration */
> +#define MCCR2_RFE		BIT(0)		/* read allocate enable */
> +#define MCCR2_L2EN		BIT(3)		/* L2 cache enable */
> +#define MCCR2_DLNTCY(n)		((n) << 16)	/* data RAM latency */
> +#define MCCR2_DSETUP		BIT(19)		/* data RAM setup time */
> +#define MCCR2_TLNTCY(n)		((n) << 22)	/* tag RAM latency */
> +#define MCCR2_TSETUP		BIT(25)		/* tag RAM setup time */
> +#define MCCR2_IPRF(n)		((n) << 29)	/* instruction prefetch lines */
> +#define MCCR2_TPRF		BIT(31)		/* tag RAM prefetch enable */
> +
> +/*
> + * MHINT - machine-mode implicit operation
> + *
> + * AMR selects how many consecutive stores to the same 4 KiB region make=
 the
> + * core stop allocating cache lines for the rest of it.  It is a two-bit=
 field
> + * on the C906 but the C910 only decodes bit 3.
> + *
> + * Some of the fields the C906 does not have also mean something else th=
ere:
> + * bit 20 is L2STPLD on the C910 and AEE on the C906, so it is left unde=
fined
> + * until one of them needs it.
> + */
> +#define MHINT_DPLD		BIT(2)		/* D-cache prefetch enable */
> +#define MHINT_AMR(n)		((n) << 3)	/* write-allocate adjustment */
> +#define MHINT_IPLD		BIT(8)		/* I-cache prefetch enable */
> +#define MHINT_LPE		BIT(9)		/* loop prefetch enable */
> +#define MHINT_DCACHE_PREF_DIST(n)	((n) << 13)	/* in 64 B lines */
> +/* not decoded by every core */
> +#define MHINT_L2PLD		BIT(15)		/* L2 prefetch enable */
> +#define MHINT_L2_PREF_DIST(n)	((n) << 16)	/* in 64 B lines */
> +#define MHINT_NSFE		BIT(18)
> +#define MHINT_TLB_BROAD_DIS	BIT(21)		/* keep TLB ops hart-local */
> +#define MHINT_FENCERW_BROAD_DIS	BIT(22)	/* keep fence rw hart-local */
> +
> +/* MHINT2 - per-unit clock gating */
> +#define MHINT2_LOCAL_ICG_EN(n)	BIT((n) + 14)
> +
> +/* MSMPR - machine-mode SMP control */
> +#define MSMPR_SMPEN		BIT(0)		/* cache snooping enable */

I think most of the comments in this file can be dropped. The CSR and
bit names are generally clear enough, and the details are available in
the XuanTie manuals. Brief notes about differences between cores should
be enough.

> +
> +#endif /* _ASM_RISCV_THEAD_CSR_H */

--=20
Best regards,
Junhui Liu

