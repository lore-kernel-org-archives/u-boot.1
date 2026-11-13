Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE2606A327
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v2eTV98r;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Uv14pzOU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCF518150F;
	Fri, 13 Nov 2026 15:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gDpyLU3vRgem; Fri, 13 Nov 2026 15:00:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21288814BC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794582017;
	b=MGYZztchHs3eoBjmFv6Dp87+aszjNJr4fPP4QbxKc+YGKH4DmoXNq5IT402Ae4lnUcav
	 G7J4fRaolISXDxUfgb39I4z0WbqmbDKjn7adAIBllpmQKieURdTTOnezbtwBVtbJPcXjx
	 HI9riSh4mratPMLG2xkerAmHEki/zYK4Dhk3UXHifsq9oOpbe1TWk4V4zjWSBwWwi56Hi
	 p+SVuDeUj3rME3BR9ANrzUqlHGlUxm9C22mxjKuL6PvTkW1QRbdy7Njpa/hND3AIPYn7s
	 6LpAibiymYcD2bvkXgCgA1pInau0nYDJ8cJfQZCw8Mk1Akxhyzi/rFZZRtG8it+BhfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794582017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xZLlX2jfdEBTrMTZm8blYC6lKnEakjnE3UeCSUrsl0I=;
	b=Yu03FA+/qvDGRWgMMyLVqQXoz1ACAqmIHf0Hr2v1OAbK7uReg7mRquo7TDCHvii+sDkg
	 A+8pWPN2JfB3MWAiDssfZZzuHiUKT5DZsrCHAFTrIjWcyi4pJSNWBsrmzYq4R8uQ84PwP
	 YhFlZfSqJLh4tiitby3sY656+O+ymVxsKOCakSr691H1p3TCXZ7f5MGNXQ5lLkhHaxDBI
	 Vfiyet6p1sZxh6ipe1WlNIS/u9QPEwvBi7PTNz5jegPJFS9upi9mMKJEagudflDqLAI7t
	 FZzHgTnPQukCcYbV6aPj3akRnNfbx2dA1qdl21E0QrF3Xp5Il55JjP8ZHxFjNh9AJlA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794582017;
	bh=xZLlX2jfdEBTrMTZm8blYC6lKnEakjnE3UeCSUrsl0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v2eTV98rQfFdYDID8S6ISddr0vQy2ulfHzKNFyUMFR/tfZy3HOTvT2hj+6KVxQj4W
	 VF8xjao4C/FT1UI8hadlokogirOzx2dO69anu7thXB8LVrSUpsH7Lx3SU00NRrFmRE
	 lkvISQunU5gLqeqclyWyFZqqey2kS+gzDLo1MtxIsZ7lxXEnIKe68KjAieQOp5jDBF
	 22rir1oE/ICz7su1GhAx+ztnNiyeG46oFAJUanIt4QJ+ogQH4kod+XibqkS14vg5w2
	 vowpETT/Q5F0a5PNRfITfcMZrCU0MPdCJqMFQZoYTIcui1XLwoIxMHphssPDpN7kz2
	 WWLzH8Lk8wV9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21288814BC;
	Fri, 13 Nov 2026 15:00:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 68D2828C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5964360660
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yzmtkw1qLdZX for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:00:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25F6860627
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Uv14pzOU
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25F6860627
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:00:13 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67c2c2ac1c3so867076d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794582012; x=1795186812;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xZLlX2jfdEBTrMTZm8blYC6lKnEakjnE3UeCSUrsl0I=;
 b=Uv14pzOUZxvw1bRiXNn61zbHNenyy21z2gz08ZVwu2klSmCoZtyrdI7d9SdBUXjJ6Q
 7G+4MI6hDFPwDabmoDrNIPKaBmV96LpMmVjkcDgycylDxJp+lbaEH3LoSxAY29nbqpLV
 +gqmm/ybpnFAzKT0TgJgaLwD4MafO8ujfNpLtA4TnxQBM8bfPsg6q3kSOCsnOhVB5cpi
 9U42X+rlTT3XZr4nn5tUlpytP8obL1AklHPQLnehaefNGhpP/K9zZKmtJijcUzeuOwDO
 y/xz64o6GKe0fSwo2wSIbHPxFRp1D3uh3jXDi0SJSj6lQC3Mq8t2oi3LaWb/ZKvHPYBr
 BTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794582012; x=1795186812;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xZLlX2jfdEBTrMTZm8blYC6lKnEakjnE3UeCSUrsl0I=;
 b=bQem9NGxuk3VhzzeRP9pNBmIoIQ2LHyNs2yZx3uG3n3Trqe4xm4tHHh1iTod1Uou+2
 NSCRBO4sIBG9AMxw4tBAHEK1+SWl9a1EaJZef9IveFgFNhGGz4f9huIBqE1KvGhC6MvT
 LHrqAS4FfecZJwtDsm85/PB3QtLpEPI9IKnTl2bKF0Ld4mvndJM3FFO7yTt4KyrPHzGG
 QWjVRm3XLaQky3cDNFchQzWcYxfj8nVJQOky4mj5JuNgVsJGqPatjcDhTGPYcfMRVU70
 6h29iUYt72HASybPpXjikHklC7natA4iw0TdknY6kLx0onmrsPmHxLZS+EJhvKcQc9ud
 g9Qg==
X-Forwarded-Encrypted: i=1;
 AL+hErEH8lOuL1BktE+DuEz+1jeHibgiPiYPe0vC+aPSwbYcqSkcCK1yBTYs1OvpvsKFqQoqqh6OxQA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9g4OVOETV85atQXcqMB0hxuEcInFFnkYCEIkWWKs4cqSbBJFfK
 8QpW7bYTs+TjMSLg2isc6T2AEqshq9rv8YzgaVEAjUEF1LRf3clFsl1XuCdZTSqzslfDau6S8AR
 //Jup1PjpbfTFCZ2FpDSaFr/CUFZzaNdahAET9OZriZMm/122KyV72p4Z9w==
X-Gm-Gg: AYBFou2XVXT4cCWGFjG+o4AiSOaGAP1TbNjYgDqQs7HrepSlZrpRBnsUBvL538X3Lmk
 hTAvvlp5eLSvgWZ9vR7rxWjaQ/NmtpAUS/wZ+F37KuhXZWEP4rjehk0OHNZp1y0xeuvGf4BU4mR
 qr3gypOacvdHwQnaXVmJNzBxlnSMIR+cBYsayxgfxr/KyfFC2Q0hjvd/FlRPB+BgmBSnpLdmWaY
 8maay/WcxwbdiFbUgu1t8SA4+ResWGkEqZqUDKANwGLCr9SY8Y6AoIs5pDXwV9vxd34I5rJCUGI
 axzUe42/9nxxMDj2Xo3fvrxVmHnk9eS//sqMJy//kCuD5DrHHsNEbAsBrEMTczxSlkWXym+SOes
 ywSks9f5xVUNrdOq1yCIziYt5DkSf+yfB4MpFjDtpLDFHFGY//XKqVa/GO43UYzCE2w24ZUCKwK
 ub8BFS0P7zZ2uvTxpwjTxqlFNqZ9yfFn9TQLtLPSCMreQX7KR6Z5TNRho5SuqaXuCX7H70j6YG/
 2cCKy7zRqprxR91Hyd1OL4lNH+bKyvdH6US5FOG73GrDXgQyR96C2+M9O+qvkPmiq1nusKQWbOC
 fKO9ghvCAUXRCLL5KIqlsbfaxVmQjCQbaXwVuZUPY+8R2Pm1olqT6Sz656gvlCmhFnRbI87ZBad
 JWLEdHw7uGMbswb5RZge31BnAtfIfdz0LPIkD0XxKDcKkazdzpKFDKV1PwY3hd1eqdo2/0th8GL
 O9DNJgJAQWPSB61IMso6V6OpPHSHloigNyx6WwL1opc7AUwbPh7z0EBA==
X-Received: by 2002:a05:690e:1182:b0:67c:1eb5:48d0 with SMTP id
 956f58d0204a3-67d895a730emr1729652d50.21.1794582011532; Fri, 13 Nov 2026
 07:00:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112115438.1837663-1-me@ziyao.cc>
 <20261112115438.1837663-18-me@ziyao.cc>
In-Reply-To: <20261112115438.1837663-18-me@ziyao.cc>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Nov 2026 16:59:34 +0200
X-Gm-Features: AclHuK_SzDmHwicIZPpH5zmoc_CLpiJnUQusO62kH2oEY2wBIxmuz1M-EObN8u0
Message-ID: <CAC_iWjJ3fO3nPxOOcMU_rzsTJ3iLw1t+o5=AwDtDdKVnYkVGgQ@mail.gmail.com>
Subject: Re: [PATCH v7 17/20] efi: LoongArch: Implement everything
To: Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 13:58, Yao Zi <me@ziyao.cc> wrote:
>
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Implement crt, relocator, linker scripts, and handling of PE relocation
> IMAGE_REL_BASED_LOONGARCH64_MARK_LA. Wire things up in Makefiles and
> Kconfig. The relocator originates from gnu-efi project.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> #for the efi
loader bits
>
> No changes since v6
>
> Changed from v5:
> - Remove unnecessary settings of extra-$(CONFIG_*) in
>   arch/loongarch/lib/Makefile for EFI applications
> - Whitespace/empty line clean up
> - Localize the temporary variable used only by loongarch in
>   efi_loader_relocate()
> - Fix grammar nits in the commit message
>
> No changes since v4
>
> Changed from v3
> - Read addend from Rela entry when processing relative relocations in
>   reloc_loongarch_efi.c
>   - This has been submitted to gnu-efi upstream[1]
>
> Changed from v2
> - Mention IMAGE_REL_BASED_LOONGARCH64_MARK_LA handling in the commit
>   message, explain the instruction sequence in comments
> - Mention the origin of reloc_loongarch_efi.c
> - Fix typo in copyright of crt0_loongarch_efi.S
> - Clean up whitespaces in crt0_loongarch_efi.S
> - Fix SPDX identifier for reloc_loongarch_efi.c
> - Drop the meaningless branch for DT_PLTGOT in reloc_loongarch_efi.c
>
> Changed from v1
> - Replace obsolete macro __loongarch64 with __loongarch__ and
>   __loongarch_grlen
> - Support relocation of IMAGE_REL_BASED_LOONGARCH64_MARK_LA
>
> [1]: https://github.com/ncroxon/gnu-efi/pull/109
> ---
>  arch/loongarch/config.mk                 |   4 +
>  arch/loongarch/lib/Makefile              |   8 +
>  arch/loongarch/lib/crt0_loongarch_efi.S  | 182 +++++++++++++++++++++++
>  arch/loongarch/lib/elf_loongarch_efi.lds |  76 ++++++++++
>  arch/loongarch/lib/reloc_loongarch_efi.c | 101 +++++++++++++
>  lib/efi_loader/Kconfig                   |   2 +-
>  lib/efi_loader/efi_helper.c              |   3 +
>  lib/efi_loader/efi_image_loader.c        |  33 ++++
>  8 files changed, 408 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/lib/crt0_loongarch_efi.S
>  create mode 100644 arch/loongarch/lib/elf_loongarch_efi.lds
>  create mode 100644 arch/loongarch/lib/reloc_loongarch_efi.c
>
> diff --git a/arch/loongarch/config.mk b/arch/loongarch/config.mk
> index 7c247400e361..bae4566e9b62 100644
> --- a/arch/loongarch/config.mk
> +++ b/arch/loongarch/config.mk
> @@ -21,3 +21,7 @@ endif
>  PLATFORM_CPPFLAGS      += -fpic
>  PLATFORM_RELFLAGS      += -fno-common -ffunction-sections -fdata-sections
>  LDFLAGS_u-boot         += --gc-sections -static -pie
> +
> +EFI_LDS                                := elf_loongarch_efi.lds
> +EFI_CRT0                       := crt0_loongarch_efi.o
> +EFI_RELOC                      := reloc_loongarch_efi.o
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index 9eb9662066a5..d67cfa9ed18c 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -12,3 +12,11 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
>  obj-y  += reset.o
>  endif
>  obj-y  += setjmp.o
> +
> +# For building EFI apps
> +CFLAGS_NON_EFI := -fstack-protector-strong
> +CFLAGS_$(EFI_CRT0) := $(CFLAGS_EFI)
> +CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
> +
> +CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
> +CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
> diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/lib/crt0_loongarch_efi.S
> new file mode 100644
> index 000000000000..ba3d9b4ad71d
> --- /dev/null
> +++ b/arch/loongarch/lib/crt0_loongarch_efi.S
> @@ -0,0 +1,182 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * crt0-efi-loongarch.S - PE/COFF header for LoongArch EFI applications
> + *
> + * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <asm-generic/pe.h>
> +#include <asm/asm.h>
> +
> +#if __loongarch_grlen == 64
> +#define PE_MACHINE     IMAGE_FILE_MACHINE_LOONGARCH64
> +#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR64_MAGIC
> +#define IMG_CHARACTERISTICS \
> +       (IMAGE_FILE_EXECUTABLE_IMAGE | \
> +        IMAGE_FILE_LINE_NUMS_STRIPPED | \
> +        IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
> +        IMAGE_FILE_LARGE_ADDRESS_AWARE | \
> +        IMAGE_FILE_DEBUG_STRIPPED)
> +#else
> +#define PE_MACHINE     IMAGE_FILE_MACHINE_LOONGARCH32
> +#define PE_MAGIC    IMAGE_NT_OPTIONAL_HDR32_MAGIC
> +#define IMG_CHARACTERISTICS \
> +       (IMAGE_FILE_EXECUTABLE_IMAGE | \
> +        IMAGE_FILE_LINE_NUMS_STRIPPED | \
> +        IMAGE_FILE_LOCAL_SYMS_STRIPPED | \
> +        IMAGE_FILE_DEBUG_STRIPPED)
> +#endif
> +
> +       .section        .text.head
> +
> +       /*
> +        * Magic "MZ" signature for PE/COFF
> +        */
> +       .globl  ImageBase
> +ImageBase:
> +       .short  IMAGE_DOS_SIGNATURE             /* 'MZ' */
> +       .skip   58
> +       .long   pe_header - ImageBase           /* Offset to the PE header */
> +pe_header:
> +       .long   IMAGE_NT_SIGNATURE              /* 'PE' */
> +coff_header:
> +       .short  PE_MACHINE                      /* LoongArch 64/32-bit */
> +       .short  3                               /* nr_sections */
> +       .long   0                               /* TimeDateStamp */
> +       .long   0                               /* PointerToSymbolTable */
> +       .long   0                               /* NumberOfSymbols */
> +       .short  section_table - optional_header /* SizeOfOptionalHeader */
> +       .short  IMG_CHARACTERISTICS             /* Characteristics */
> +optional_header:
> +       .short  PE_MAGIC                        /* PE32(+) format */
> +       .byte   0x02                            /* MajorLinkerVersion */
> +       .byte   0x14                            /* MinorLinkerVersion */
> +       .long   _edata - _start                 /* SizeOfCode */
> +       .long   0                               /* SizeOfInitializedData */
> +       .long   0                               /* SizeOfUninitializedData */
> +       .long   _start - ImageBase              /* AddressOfEntryPoint */
> +       .long   _start - ImageBase              /* BaseOfCode */
> +#if __loongarch_grlen != 64
> +       .long   0                               /* BaseOfData */
> +#endif
> +
> +extra_header_fields:
> +       LONG    0
> +       .long   0x200                           /* SectionAlignment */
> +       .long   0x200                           /* FileAlignment */
> +       .short  0                               /* MajorOperatingSystemVersion */
> +       .short  0                               /* MinorOperatingSystemVersion */
> +       .short  1                               /* MajorImageVersion */
> +       .short  0                               /* MinorImageVersion */
> +       .short  0                               /* MajorSubsystemVersion */
> +       .short  0                               /* MinorSubsystemVersion */
> +       .long   0                               /* Win32VersionValue */
> +
> +       .long   _edata - ImageBase              /* SizeOfImage */
> +
> +       /*
> +        * Everything before the kernel image is considered part of the header
> +        */
> +       .long   _start - ImageBase              /* SizeOfHeaders */
> +       .long   0                               /* CheckSum */
> +       .short  IMAGE_SUBSYSTEM_EFI_APPLICATION /* Subsystem */
> +#if CONFIG_VENDOR_EFI
> +       .short  0                               /* DllCharacteristics */
> +#else
> +       .short  IMAGE_DLLCHARACTERISTICS_NX_COMPAT
> +#endif
> +       LONG    0                               /* SizeOfStackReserve */
> +       LONG    0                               /* SizeOfStackCommit */
> +       LONG    0                               /* SizeOfHeapReserve */
> +       LONG    0                               /* SizeOfHeapCommit */
> +
> +       .long   0                               /* LoaderFlags */
> +       .long   0x6                             /* NumberOfRvaAndSizes */
> +
> +       .quad   0                               /* ExportTable */
> +       .quad   0                               /* ImportTable */
> +       .quad   0                               /* ResourceTable */
> +       .quad   0                               /* ExceptionTable */
> +       .quad   0                               /* CertificationTable */
> +       .quad   0                               /* BaseRelocationTable */
> +
> +       /* Section table */
> +section_table:
> +
> +       /*
> +        * The EFI application loader requires a relocation section
> +        * because EFI applications must be relocatable.  This is a
> +        * dummy section as far as we are concerned.
> +        */
> +       .ascii  ".reloc"
> +       .byte   0
> +       .byte   0                       /* end of 0 padding of section name */
> +       .long   0
> +       .long   0
> +       .long   0                       /* SizeOfRawData */
> +       .long   0                       /* PointerToRawData */
> +       .long   0                       /* PointerToRelocations */
> +       .long   0                       /* PointerToLineNumbers */
> +       .short  0                       /* NumberOfRelocations */
> +       .short  0                       /* NumberOfLineNumbers */
> +       .long   0x42100040              /* Characteristics (section flags) */
> +
> +
> +       .ascii  ".text"
> +       .byte   0
> +       .byte   0
> +       .byte   0                       /* end of 0 padding of section name */
> +       .long   _etext - _start         /* VirtualSize */
> +       .long   _start - ImageBase      /* VirtualAddress */
> +       .long   _etext - _start         /* SizeOfRawData */
> +       .long   _start - ImageBase      /* PointerToRawData */
> +       .long   0                       /* PointerToRelocations (0 for executables) */
> +       .long   0                       /* PointerToLineNumbers (0 for executables) */
> +       .short  0                       /* NumberOfRelocations  (0 for executables) */
> +       .short  0                       /* NumberOfLineNumbers  (0 for executables) */
> +       /* Characteristics (section flags) */
> +       .long   (IMAGE_SCN_MEM_READ | \
> +                IMAGE_SCN_MEM_EXECUTE | \
> +                IMAGE_SCN_CNT_CODE)
> +
> +       .ascii  ".data"
> +       .byte   0
> +       .byte   0
> +       .byte   0                       /* end of 0 padding of section name */
> +       .long   _edata - _data          /* VirtualSize */
> +       .long   _data - ImageBase       /* VirtualAddress */
> +       .long   _edata - _data          /* SizeOfRawData */
> +       .long   _data - ImageBase       /* PointerToRawData */
> +       .long   0                       /* PointerToRelocations */
> +       .long   0                       /* PointerToLineNumbers */
> +       .short  0                       /* NumberOfRelocations */
> +       .short  0                       /* NumberOfLineNumbers */
> +       /* Characteristics (section flags) */
> +       .long   (IMAGE_SCN_MEM_WRITE | \
> +                IMAGE_SCN_MEM_READ | \
> +                IMAGE_SCN_CNT_INITIALIZED_DATA)
> +
> +       .align          12
> +       .globl  _start
> +       .type   _start, @function
> +_start:
> +       PTR_ADDI        sp, sp, -(3 * LONGSIZE)
> +       LONG_S          ra, sp, 0
> +       LONG_S          a0, sp, (1 * LONGSIZE)
> +       LONG_S          a1, sp, (2 * LONGSIZE)
> +
> +       move            a2, a0          /* a2: ImageHandle */
> +       move            a3, a1          /* a3: SystemTable */
> +       la.local        a0, ImageBase   /* a0: ImageBase */
> +       la.local        a1, _DYNAMIC    /* a1: DynamicSection */
> +       bl              _relocate
> +       bnez            a0, 0f
> +
> +       LONG_L          a0, sp, (1 * LONGSIZE)
> +       LONG_L          a1, sp, (2 * LONGSIZE)
> +       bl              efi_main
> +
> +0:     LONG_L          ra, sp, 0
> +       PTR_ADDI        sp, sp, (3 * LONGSIZE)
> +       jr              ra
> +       .end    _start
> diff --git a/arch/loongarch/lib/elf_loongarch_efi.lds b/arch/loongarch/lib/elf_loongarch_efi.lds
> new file mode 100644
> index 000000000000..050e5a52a0b3
> --- /dev/null
> +++ b/arch/loongarch/lib/elf_loongarch_efi.lds
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +/*
> + * U-Boot LoongArch
> + *
> + * Modified from arch/riscv/lib/elf_riscv64_efi.lds
> + */
> +
> +OUTPUT_ARCH(loongarch)
> +
> +PHDRS
> +{
> +       data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
> +}
> +
> +ENTRY(_start)
> +SECTIONS
> +{
> +       .text 0x0 : {
> +               _text = .;
> +               *(.text.head)
> +               *(.text)
> +               *(.text.*)
> +               *(.gnu.linkonce.t.*)
> +               *(.srodata)
> +               *(.rodata*)
> +               . = ALIGN(16);
> +               *(.dynamic);
> +               . = ALIGN(512);
> +       }
> +       .rela.dyn : { *(.rela.dyn) }
> +       .rela.plt : { *(.rela.plt) }
> +       .rela.got : { *(.rela.got) }
> +       .rela.data : { *(.rela.data) *(.rela.data*) }
> +       _etext = .;
> +       _text_size = . - _text;
> +       . = ALIGN(4096);
> +       .data : {
> +               _data = .;
> +               *(.sdata)
> +               *(.data)
> +               *(.data1)
> +               *(.data.*)
> +               *(.got.plt)
> +               *(.got)
> +
> +               /*
> +                * The EFI loader doesn't seem to like a .bss section, so we
> +                * stick it all into .data:
> +                */
> +               . = ALIGN(16);
> +               _bss = .;
> +               *(.sbss)
> +               *(.scommon)
> +               *(.dynbss)
> +               *(.bss)
> +               *(.bss.*)
> +               *(COMMON)
> +               . = ALIGN(512);
> +               _bss_end = .;
> +               _edata = .;
> +       } :data
> +       _data_size = _edata - _data;
> +
> +       . = ALIGN(4096);
> +       .dynsym   : { *(.dynsym) }
> +       . = ALIGN(4096);
> +       .dynstr   : { *(.dynstr) }
> +       . = ALIGN(4096);
> +       .note.gnu.build-id : { *(.note.gnu.build-id) }
> +       /DISCARD/ : {
> +               *(.rel.reloc)
> +               *(.eh_frame)
> +               *(.note.GNU-stack)
> +       }
> +       .comment 0 : { *(.comment) }
> +}
> diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarch/lib/reloc_loongarch_efi.c
> new file mode 100644
> index 000000000000..72acfe525c3f
> --- /dev/null
> +++ b/arch/loongarch/lib/reloc_loongarch_efi.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* reloc_loongarch.c - position independent ELF shared object relocator
> +   Copyright (C) 2018 Alexander Graf <agraf@suse.de>
> +   Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
> +   Copyright (C) 1999 Hewlett-Packard Co.
> +       Contributed by David Mosberger <davidm@hpl.hp.com>.
> +
> +    All rights reserved.
> +
> +    Redistribution and use in source and binary forms, with or without
> +    modification, are permitted provided that the following conditions
> +    are met:
> +
> +    * Redistributions of source code must retain the above copyright
> +      notice, this list of conditions and the following disclaimer.
> +    * Redistributions in binary form must reproduce the above
> +      copyright notice, this list of conditions and the following
> +      disclaimer in the documentation and/or other materials
> +      provided with the distribution.
> +    * Neither the name of Hewlett-Packard Co. nor the names of its
> +      contributors may be used to endorse or promote products derived
> +      from this software without specific prior written permission.
> +
> +    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> +    CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
> +    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
> +    MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> +    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
> +    BE LIABLE FOR ANYDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
> +    OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> +    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
> +    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> +    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> +    TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> +    THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> +    SUCH DAMAGE.
> +*/
> +
> +#include <efi.h>
> +
> +#include <elf.h>
> +
> +#if __loongarch_grlen == 64
> +#define Elf_Dyn                Elf64_Dyn
> +#define Elf_Rela       Elf64_Rela
> +#define ELF_R_TYPE     ELF64_R_TYPE
> +#else
> +#define Elf_Dyn                Elf32_Dyn
> +#define Elf_Rela       Elf32_Rela
> +#define ELF_R_TYPE     ELF32_R_TYPE
> +#endif
> +
> +efi_status_t EFIAPI _relocate(long ldbase, Elf_Dyn *dyn)
> +{
> +       long relsz = 0, relent = 0;
> +       Elf_Rela *rel = 0;
> +       unsigned long *addr;
> +       int i;
> +
> +       for (i = 0; dyn[i].d_tag != DT_NULL; ++i) {
> +               switch (dyn[i].d_tag) {
> +               case DT_RELA:
> +                       rel = (Elf_Rela *)
> +                               ((unsigned long)dyn[i].d_un.d_ptr
> +                                       + ldbase);
> +                       break;
> +               case DT_RELASZ:
> +                       relsz = dyn[i].d_un.d_val;
> +                       break;
> +               case DT_RELAENT:
> +                       relent = dyn[i].d_un.d_val;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       if (!rel && relent == 0)
> +               return EFI_SUCCESS;
> +
> +       if (!rel || relent == 0)
> +               return EFI_LOAD_ERROR;
> +
> +       while (relsz > 0) {
> +               /* apply the relocs */
> +               switch (ELF_R_TYPE(rel->r_info)) {
> +               case R_LARCH_NONE:
> +                       break;
> +               case R_LARCH_RELATIVE:
> +                       addr = (unsigned long *)
> +                               (ldbase + rel->r_offset);
> +                       *addr = ldbase + rel->r_addend;
> +                       break;
> +               default:
> +                       break;
> +               }
> +               rel = (Elf_Rela *)((char *)rel + relent);
> +               relsz -= relent;
> +       }
> +       return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c4b0c2137b87..6a417e75bf46 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -7,7 +7,7 @@ config EFI_LOADER
>                         SYS_CPU = arm1176 || \
>                         SYS_CPU = armv7   || \
>                         SYS_CPU = armv8)  || \
> -               X86 || RISCV || SANDBOX)
> +               X86 || RISCV || LOONGARCH || SANDBOX)
>         # We have not fully removed the requirement for some block device
>         depends on BLK
>         # We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index bc48e265b901..641b001a9a16 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -44,6 +44,9 @@
>  #elif HOST_ARCH == HOST_ARCH_RISCV64
>  #define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
>  #define HOST_PXE_ARCH 0x1b
> +#elif HOST_ARCH == HOST_ARCH_LOONGARCH64
> +#define HOST_BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
> +#define HOST_PXE_ARCH 0x27
>  #else
>  #error Unsupported Host architecture
>  #endif
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index bed5f1817266..612e0cfec2ce 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -19,6 +19,7 @@
>  #include <crypto/mscode.h>
>  #include <crypto/pkcs7_parser.h>
>  #include <linux/err.h>
> +#include <linux/bitfield.h>
>
>  const efi_guid_t efi_global_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
>  const efi_guid_t efi_guid_device_path = EFI_DEVICE_PATH_PROTOCOL_GUID;
> @@ -231,6 +232,38 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
>                                         return EFI_LOAD_ERROR;
>                                 }
>                                 break;
> +#elif defined(__loongarch__) && __loongarch_grlen == 64
> +                       case IMAGE_REL_BASED_LOONGARCH64_MARK_LA: {
> +                               uint64_t tmp;
> +
> +                               if (virt_size - offset < 16) {
> +                                       log_debug("relocation address out of bounds\n");
> +                                       return EFI_LOAD_ERROR;
> +                               }
> +
> +                               /*
> +                                * Apply an offset to a 64-bit immediate loaded
> +                                * by four instructions, lu12i.w, ori, lu32i.d,
> +                                * and lu52i.d.
> +                                */
> +                               tmp = FIELD_GET(GENMASK(24, 5), x32[0]) << 12;
> +                               tmp |= FIELD_GET(GENMASK(21, 10), x32[1]);
> +                               tmp |= FIELD_GET(GENMASK(24, 5), x32[2]) << 32;
> +                               tmp |= FIELD_GET(GENMASK(21, 10), x32[3]) << 52;
> +                               tmp += (uint64_t)delta;
> +
> +                               x32[0] &= ~GENMASK(24, 5);
> +                               x32[0] |= FIELD_PREP(GENMASK(24, 5), tmp >> 12);
> +                               x32[1] &= ~GENMASK(21, 10);
> +                               x32[1] |= FIELD_PREP(GENMASK(21, 10), tmp);
> +                               x32[2] &= ~GENMASK(24, 5);
> +                               x32[2] |= FIELD_PREP(GENMASK(24, 5), tmp >> 32);
> +                               x32[3] &= ~GENMASK(21, 10);
> +                               x32[3] |= FIELD_PREP(GENMASK(21, 10),
> +                                                    tmp >> 52);
> +
> +                               break;
> +                       }
>  #endif
>                         default:
>                                 log_err("Unknown Relocation off %lx type %x\n",
> --
> 2.56.0
>
