Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6447606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RGOzbY+q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=nshTAWHa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87171606CF;
	Sat,  7 Nov 2026 09:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cKWkzG-p4NYh; Sat,  7 Nov 2026 09:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DE9F606AA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042717;
	b=IGCrTnsNEJCaX2qHe+AuneG7AuKnmXOTaWL299pJLgqR11BSbiTTN3eppEMs/sYuNTFW
	 SQLi551u1j37dU0boc2LCh+9/TnFbDNRdfRLDHuLvy2diDNW1I7s8X2C4IpXN3bARbFvX
	 R44cCr6ZVit2u8HctACrKwKHZVGDUSDn2ZPIwKMptbLVw9mpw4GepORTDZBKCDHSmxeBp
	 U/IluRPeKATUVHfG+Cs3j4U74qBYbkcjOWu9ZAzpb6Ucdq3ULfSZIRuvJsGjkNc4n87Ya
	 6E1Vd7yq9ynKsTHnCLqCKWz9YC44hGS74GAzAmGXWyS8+cgiI+LEw+yn+NeOIx+24ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2kihS9aSK74km2BzdmgciEIJLg1Zp5hcZNM5ac9I9H4=;
	b=frFKh8YJzn5i1BkVpwY4mG0t+8Hj0Ais1TpoeAxcRBdna6kL4A6k8HnV41KH8WLVGAVz
	 8u8Pmhnl38ztgdUETpqNp2FigcPrKn8Btc7jEctsiX2Z3mR15CT2OT3VpX9N9Cq6qtVMu
	 4AL7/B4zcXJO2Yra+NrSgtpjV+iQlwLZwxgNCwA874/Ng8BawnWPY8iz6Sed/L1IZxykb
	 /TAtlsRxfAnxys3OOUU0RntDl2zAbi0+HG0pMvCHFZqvgV05iRpKjM5mS8N1D2KGPkBQM
	 e1YlrhBO/lrDbJJ44vL9ewhxb+nU4kc52qhPDthZ8R66s9z4fYe8WFAUnP35MDBN1YA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042717;
	bh=2kihS9aSK74km2BzdmgciEIJLg1Zp5hcZNM5ac9I9H4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RGOzbY+qH2m6oVVRL1UVWrvhBM256eRRHx0T8jm9ViW/Ywf8t42JDKXSPyItezgoV
	 72oU77okgb/BKZslmSuuE/p6cYim89INv9rEl5ZX50ZjaBnioY3ayi4swvoG8mn+b8
	 uQvuzxrRcTn7wdlg5+YFJGqZc5tou39IAzjjkZP6BWp+xOnOetpzPVJelwBSvTyNlm
	 zkrnemSTUE+rCDUEn5U0OSg11LYE+ev6xmh9syX5U/QEG/9swpFUM1VrMLPugvPXl5
	 pchcqoWa0/8JOiV0vzPfBI2HM4ec3+7zGUC8/D/E3utDIPosCfz3kXOq7aZ1BFpHQl
	 bNQpl1r4RcsWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DE9F606AA;
	Sat,  7 Nov 2026 09:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E4C92E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8045C406AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2CD15IzE7lig for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8776B406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=nshTAWHa
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8776B406A0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:11:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=nshTAWHa21LW1m1oZ5MG1mAjqn8c+jVzIM3PzD1scbFlN0VSgqiSRdRh+0H15BnRfbAhGK0npAybR+kLxmlBEK/5xpXZooduzxY0p2e2Q92RjPNNli+xRCdiW2R3huHTqKLRQsloOS4OUsC9SraGYPdn3XoDdt76uTfXBmCgrg0=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=2kihS9aSK74km2BzdmgciEIJLg1Zp5hcZNM5ac9I9H4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794042674503543.9601163387505;
 Sat, 7 Nov 2026 01:11:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 17:11:09 +0800
Message-Id: <DMOV1SBS6QJO.MFJO4I90QL0P@pigmoral.tech>
Cc: "Andre Przywara" <andre.przywara@arm.com>, "Tim Ouyang"
 <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>, "Yao Zi"
 <me@ziyao.cc>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Lukasz Majewski" <lukma@nabladev.com>, "Stefan
 Roese" <stefan.roese@mailbox.org>, "Samuel Holland" <samuel@sholland.org>,
 "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH 01/10] riscv: cpu: add Allwinner D1/D1s(F133) CPU support
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Indrek Kruusa" <indrek.kruusa@gmail.com>,
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.22.0
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
 <20261101210449.1235102-2-indrek.kruusa@gmail.com>
In-Reply-To: <20261101210449.1235102-2-indrek.kruusa@gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Indrek,

Thanks for your work. I'm very happy to finally see someone proposing
this work. But for most of the T-Head/XuanTie CPU support, I think it is
better to make it common code instead of keeping it private to sun20i.

On Mon Nov 2, 2026 at 5:04 AM CST, Indrek Kruusa wrote:
> Add the C906 support for the D1/D1s(F133) SoCs:
>
> - T-Head cache operations from the custom cache instructions
> - harts_early_init() programming MXSTATUS, MHCR and MHINT
> - cleanup_before_linux() disabling interrupts and flushing the caches
> - dram_init() from the device tree memory nodes
> - the T-Head CSR, CCU clock and memory map headers
> - SUN20I Kconfig (cache line size, T-Head CMO support)
>
> Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
> ---
>  arch/riscv/Kconfig                            |  1 +
>  arch/riscv/cpu/sun20i/Kconfig                 |  6 ++
>  arch/riscv/cpu/sun20i/Makefile                |  5 ++
>  arch/riscv/cpu/sun20i/cache.c                 | 88 +++++++++++++++++++
>  arch/riscv/cpu/sun20i/cpu.c                   | 44 ++++++++++
>  arch/riscv/cpu/sun20i/dram.c                  | 21 +++++
>  arch/riscv/include/asm/arch-sun20i/clock.h    | 71 +++++++++++++++
>  arch/riscv/include/asm/arch-sun20i/cpu.h      | 18 ++++
>  .../riscv/include/asm/arch-sun20i/thead_csr.h | 29 ++++++
>  9 files changed, 283 insertions(+)
>  create mode 100644 arch/riscv/cpu/sun20i/Kconfig
>  create mode 100644 arch/riscv/cpu/sun20i/Makefile
>  create mode 100644 arch/riscv/cpu/sun20i/cache.c
>  create mode 100644 arch/riscv/cpu/sun20i/cpu.c
>  create mode 100644 arch/riscv/cpu/sun20i/dram.c
>  create mode 100644 arch/riscv/include/asm/arch-sun20i/clock.h
>  create mode 100644 arch/riscv/include/asm/arch-sun20i/cpu.h
>  create mode 100644 arch/riscv/include/asm/arch-sun20i/thead_csr.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 386241efd4a..14c8ca817fb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -144,6 +144,7 @@ source "arch/riscv/cpu/jh7110/Kconfig"
>  source "arch/riscv/cpu/k1/Kconfig"
>  source "arch/riscv/cpu/k3/Kconfig"
>  source "arch/riscv/cpu/k230/Kconfig"
> +source "arch/riscv/cpu/sun20i/Kconfig"
>  source "arch/riscv/cpu/th1520/Kconfig"
> =20
>  # architecture-specific options below
> diff --git a/arch/riscv/cpu/sun20i/Kconfig b/arch/riscv/cpu/sun20i/Kconfi=
g
> new file mode 100644
> index 00000000000..7f459518cfe
> --- /dev/null
> +++ b/arch/riscv/cpu/sun20i/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +config SUN20I
> +	bool
> +	select SYS_CACHE_SHIFT_6
> +	select SYS_CACHE_THEAD_CMO if !SYS_DCACHE_OFF
> diff --git a/arch/riscv/cpu/sun20i/Makefile b/arch/riscv/cpu/sun20i/Makef=
ile
> new file mode 100644
> index 00000000000..556aa842ec1
> --- /dev/null
> +++ b/arch/riscv/cpu/sun20i/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y +=3D cache.o
> +obj-y +=3D cpu.o
> +obj-y +=3D dram.o
> diff --git a/arch/riscv/cpu/sun20i/cache.c b/arch/riscv/cpu/sun20i/cache.=
c
> new file mode 100644
> index 00000000000..c961eded109
> --- /dev/null
> +++ b/arch/riscv/cpu/sun20i/cache.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> + *
> + * T-Head C906 cache operations for the Allwinner D1 (sun20i).
> + */
> +
> +#include <asm/arch/thead_csr.h>
> +#include <asm/cache.h>
> +#include <asm/csr.h>
> +#include <cpu_func.h>
> +#include <linux/bitops.h>
> +
> +/*
> + * T-Head cache maintenance instructions, emitted as raw encodings becau=
se the
> + * assembler does not know them: dcache.ciall (write back and invalidate=
 all),
> + * dcache.iall (invalidate all), icache.ipa (invalidate the line holding=
 the
> + * physical address in a0) and sync.i (wait for the operation to complet=
e).
> + * They only decode while MXSTATUS.THEADISAEE is set, which harts_early_=
init()
> + * does before any of them is used.
> + */
> +#define THEAD_SYNC_I            ".long 0x01a0000b"
> +#define THEAD_DCACHE_CIALL      ".long 0x0030000b"
> +#define THEAD_DCACHE_IALL       ".long 0x0020000b"
> +#define THEAD_ICACHE_IPA_A0     ".long 0x0385000b"
> +
> +static inline void sync_i(void)
> +{
> +	asm volatile (THEAD_SYNC_I ::: "memory");
> +}
> +
> +void flush_dcache_all(void)
> +{
> +	asm volatile (THEAD_DCACHE_CIALL ::: "memory");
> +	sync_i();
> +}
> +
> +void invalidate_dcache_all(void)
> +{
> +	asm volatile (THEAD_DCACHE_IALL ::: "memory");
> +	sync_i();
> +}
> +
> +void invalidate_icache_range(unsigned long start, unsigned long end)
> +{
> +	register ulong addr asm ("a0") =3D start & -CONFIG_SYS_CACHELINE_SIZE;
> +
> +	for (; addr < end; addr +=3D CONFIG_SYS_CACHELINE_SIZE)
> +		asm volatile (THEAD_ICACHE_IPA_A0 :: "r" (addr) : "memory");
> +	sync_i();
> +}

For these cache operations, arch/riscv/lib/thead_cmo.c already contains
the D-cache range operations. The D-cache all operations and I-cache
operations added here are common T-Head/XuanTie CMO operations, so I
think it's better to add them to that common file instead of being
implemented under sun20i.

> +
> +#if CONFIG_IS_ENABLED(RISCV_MMODE)
> +
> +void icache_enable(void)
> +{
> +	invalidate_icache_all();
> +	csr_set(CSR_MHCR, MHCR_IE);
> +}
> +
> +void icache_disable(void)
> +{
> +	csr_clear(CSR_MHCR, MHCR_IE);
> +}
> +
> +int icache_status(void)
> +{
> +	return csr_read(CSR_MHCR) & MHCR_IE;
> +}
> +
> +void dcache_enable(void)
> +{
> +	invalidate_dcache_all();
> +	csr_set(CSR_MHCR, MHCR_DE);
> +}
> +
> +void dcache_disable(void)
> +{
> +	flush_dcache_all();
> +	csr_clear(CSR_MHCR, MHCR_DE);
> +}
> +
> +int dcache_status(void)
> +{
> +	return csr_read(CSR_MHCR) & MHCR_DE;
> +}
> +
> +#endif

For this part, arch/riscv/cpu/th1520/cache.c already has related
functions. Can we extract them into a common file, for example
arch/riscv/lib/thead_cache.c, and provide a THEAD_CACHE config for the
platforms that need it to select?

[...]

> diff --git a/arch/riscv/include/asm/arch-sun20i/thead_csr.h b/arch/riscv/=
include/asm/arch-sun20i/thead_csr.h
> new file mode 100644
> index 00000000000..4d6e15aab1c
> --- /dev/null
> +++ b/arch/riscv/include/asm/arch-sun20i/thead_csr.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2026, Indrek Kruusa <indrek.kruusa@gmail.com>
> + *
> + * T-Head C906 CSR definitions for the Allwinner D1 (sun20i).
> + */
> +
> +#ifndef _ASM_RISCV_ARCH_THEAD_CSR_H
> +#define _ASM_RISCV_ARCH_THEAD_CSR_H
> +
> +#define CSR_MXSTATUS            0x7c0
> +#define CSR_MHCR                0x7c1
> +#define CSR_MHINT               0x7c5
> +
> +#define MXSTATUS_THEADISAEE     BIT(22) /* T-HEAD ISA extensions enable =
*/
> +#define MXSTATUS_MAEE           BIT(21) /* MMU honours the PTE memory ty=
pe */
> +#define MXSTATUS_MM             BIT(15) /* misaligned access enable */
> +
> +#define MHCR_IE                 BIT(0)  /* icache enable */
> +#define MHCR_DE                 BIT(1)  /* dcache enable */
> +#define MHCR_WA                 BIT(2)  /* dcache write allocate */
> +#define MHCR_RS                 BIT(4)  /* return stack enable */
> +#define MHCR_BPE                BIT(5)  /* branch prediction enable */
> +#define MHCR_BTB_C906           BIT(6)  /* branch target prediction enab=
le */
> +
> +#define MHINT_IPLD              BIT(8)  /* icache prefetch enable */
> +#define MHINT_IWPE              BIT(9)  /* icache way prediction enable =
*/
> +
> +#endif /* _ASM_RISCV_ARCH_THEAD_CSR_H */

A number of these CSR definitions already exist in
arch/riscv/cpu/th1520/spl.c and arch/riscv/cpu/th1520/cache.c. Can the
common register numbers and bitfields be moved into a common header,
such as arch/riscv/include/asm/thead_csr.h, instead of placing them
under arch-sun20i?

--=20
Best regards,
Junhui Liu
