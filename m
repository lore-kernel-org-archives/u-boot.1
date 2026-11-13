Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CA606A337
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xm0Sh6UR;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D3cCLW96
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9178240889;
	Fri, 13 Nov 2026 15:01:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FzAAIpdE2sAz; Fri, 13 Nov 2026 15:01:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B62AB40891
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794582094;
	b=amTl5uXuNoDi01m+CPTazmKCmNYambHcReKf5BIlNBCGjKXLw9nLT98sLMYweVPcOQx/
	 0wrcrAwZruHBoErJCQxkX9WYJfhddTBTVOKl5qHqcXK2nlAMpidLzYXhOrmwSdYYrbHoh
	 1iIEkAXcFGVgLL4lh5xAOMAcaPszT6qq70YZW9CAMq0Cni8Ngc+bjYxKZn0PZUZ2pO6MR
	 yqix8y/yxPJkBVzcebJbkO+73KRYVtnGesjNvr6+5WgmxYR9GBZC0Gs9cx0GZZH7TXMw1
	 CbdVelU8BT8cEUG4HrtZO8NLZUZ32VvQ1F3aCKkFru8cWKAGNcc1H+Sd/OHy4+cRWmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794582094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZWl0PqltbyAi3p/ard/xdwMOTtvX8C2Od0RQejyU59g=;
	b=Mi/mPkpc5s/krPIfYE/V+LSOzDn7aNsWBLIFBMWlxv6/9uRNFG64SMFK7MmrW1Zdjx/5
	 xPChT2yeGk/2FKZvSq14TgQu5ZOmirP+5QJjFZZyvHiiOyCuTfqc0Dr9JQKVY1in7szTu
	 OoYG+or7rAAx9Jhz1RxqtjqXnlsgAF/hkM+R2cH6kY70abI1OASKv8e5zfqRlVoXFS/Xm
	 +/duRPx3u5G/7/rmdhTTay2+Q32QnElkepySg2kJmG2h30UEl7XA8HUnfMiuyK360ISrx
	 zhzmmof2s1G4wF0kYl4DEEIINxolalrEsI39kOu52luw6vAZjko50/z52mWyGWXcZnQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D3cCLW96;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794582094;
	bh=ZWl0PqltbyAi3p/ard/xdwMOTtvX8C2Od0RQejyU59g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xm0Sh6URulNWOUsMVaOujTpDxvVGpV6QTC3Izk1giMx6sKxrx65yEKsN7/5VQNFzs
	 0RP9+YxnOz2uRDY0zYAW2wGhSEIVBXLC7aszOSPX9PAlfouScTRecb6mcncIFgh+Hw
	 BzjckuVzFW/OVfcb7vANm3pg7Yhr8pfFKrisTYcDr2Ii5VzzSmMI+B6KgqH4lSS/ud
	 jzRPZw1UtwJxb4IBzyPomAUYH44snOz8dqhjgLzxxG0qCRPAwiXe7tL69de2sko+ip
	 eQrVaU6xB5jyBhYnj8wwTdGybFns8yfDcRLucqANATeuloc67nRZbojLUAo/24iqtm
	 +mox5T/p0/L8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B62AB40891;
	Fri, 13 Nov 2026 15:01:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 704452FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 568F840891
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:01:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMOIVyzj1EfD for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:01:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C8E540889
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=D3cCLW96
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C8E540889
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:01:31 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67be4686827so980655d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794582091; x=1795186891;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZWl0PqltbyAi3p/ard/xdwMOTtvX8C2Od0RQejyU59g=;
 b=D3cCLW96N/WOr3aysT7Mmv8CfGwnEciJjMlClow5dGTfxKG4N97bHtGxd89zbN6OEP
 V8Pjmue3qimYA83hK2oValWjZH64s4ryeNxyo3B1VB7VxRd/Z7PNMZgE0jE3TK25EiJA
 +PhdzmFAnrkQFBruVAm39Yxv+gRGmDum/guSBLWHZGD8Qi7T/R41Z14Li3iMc5w4u7k6
 /mMpKZP/6uJ3D1/o0qWZuZYMm2awYhbAOsukvs/WBcOOsmTtnHZ8c98msX9TBknqvUN0
 HfsFSYGXLyLIyO8awheifGYeADa40meFwhln5lFO7HW32RD3k4De74G37Rf8t/csbkDr
 DXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794582091; x=1795186891;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZWl0PqltbyAi3p/ard/xdwMOTtvX8C2Od0RQejyU59g=;
 b=QcOczh6xjfh2ybxE+qO4PrjshjP3Ps79rbn+82o18oJR8h5kQFkc6q5+HaMx9uGN1Q
 1A56NyJ0kH4ymAU9B8NcpKStPcO7QT0HHqjInXlju8atDSY+kZ6T6SwrIh70OqnUJL0W
 DKgxOg/RAO2jw1lceeTl/IMsOVoi7KnGnxM79d66BWMpVh6jfh2DfDS1Vl5sNBE0xQtJ
 6ckT7BFOuCnWbB2vBD84XE9VrZIsuiluF0rCCIDXiezTXy9X0GywG7AihndKpir9oo6b
 HTdvqadvwtSN17Af/7wDBnXM4DgbHf8YYsqqUO6+qWLPf6KWBrPF0V9kiD3D/EFkZiOO
 JwAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGuO83SY/Kr48iyaRcFSTUAL7dXMlN1643kfzW9AioPKDI8r0tDMUgThrkylM2pCBft4g7vvxs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/5ncs8Ney3KBC9KzKIANTUM5lTSYYiJtdbKxPJVgC6Vhc0OmX1
 yzKzn7TtI5dHrnHRxAOusQ4eDjHlfV+nLD4s8zBYOUNKltGS3NQcNIZOa6rAllLaZiFFX6fARvA
 HpkljSX3/EM309TSoIqydUu+FEsRX7wPw3RXxOGPGiA==
X-Gm-Gg: AYBFou1wFz4Ia+l1GWjrjx3Gdui78XMAK9PFJ9t4ra5c/khKEPJDGdwZ0k8Bv3Pes1Q
 yFRiHj+ThKCtlZQ9ghTnsRm4jRLyK3d5bmF/Z5C79NEUjP0p35ww7emULNDiopqdn26qCyV93aJ
 Pvgi3rknVl69fYM9gISPluvHs4lZVY8/ABbOQsDeS/aDNFViwxgFhZe0rxflupwQfPnlDasWH9s
 ygIiizt5gqwRLyL2mKpLmmQZu42bMmefXMBUQtQAYTfVODqbor5HQAb7GrQt/1paHVezjR8Wi+U
 FSnuFtQSkhnMqP8UI2wiFhJn2ewVUzqRLsp1bk9ThWfiJB/cAorS7e6gRdwN1l+N0Rz9Una44Ib
 laFOjALklj/bhguJ2X6HLE3Yq8am3XBk3f2L97S79/y8aLyYwUFQwHmhiu6EBav8L63mUeJLCLl
 2vxFmHsVttzpU6ihG6MMXHlnjIxclumUcjgeUhgOUhKx0QIC/+TUeXhZ1skhOmmcoQUFNJ2A7Xf
 hrGO1brF4NMrn77bbKyHEChp7taYSbPVrdgDr/Kq3wBI+w8FmZY6Rqimsnj5x+aRWt/jvzyfwxY
 vwE4rWvh9ejtJluQElrf4gcc61ea8Su5M6jt4ide1IbohA77ipDAU42uJFoIwa0dQ9qR70dNUm8
 3fb9rGPGU5z5YBGRaf8PMUvf74VGtC1iU4Kz0/bFWAEPDBwHefhwz8jhsGYmO6xiw5nRDnovPUQ
 xexA3rkVpbAtZzWTmoz5DxcFBTSZHSSjGI
X-Received: by 2002:a05:690e:47a0:20b0:67b:f621:8d50 with SMTP id
 956f58d0204a3-67d896a4108mr1267671d50.30.1794582088990; Fri, 13 Nov 2026
 07:01:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112115438.1837663-1-me@ziyao.cc>
 <20261112115438.1837663-17-me@ziyao.cc>
In-Reply-To: <20261112115438.1837663-17-me@ziyao.cc>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Nov 2026 17:00:52 +0200
X-Gm-Features: AclHuK8a7dgw8vKjd2hU9huc8tIZcWwXA3NZXuKD8FYJ3LGdHNrypYMzx8QAuFM
Message-ID: <CAC_iWj+e7FZXJ8k9x2aXH7adKKZ2Zytoersf869J1UD4rfCwkw@mail.gmail.com>
Subject: Re: [PATCH v7 16/20] efi: LoongArch: Define LoongArch bits everywhere
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 14:02, Yao Zi <me@ziyao.cc> wrote:
>
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> Add PE machine type, removable boot image name, vendor class identifier,
> client architecture identifier, relative ELF relocation, and undefined
> instruction for LoongArch. They are all coming from UEFI specification,
> PE-COFF specification, or IANA websites.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> No changes since v3
>
> Changed from v2
> - Describe what has been added in commit message
> - Drop extra paretheses in elif condition in config_distro_bootcmd.h
> - Define IMAGE_REL_BASED_LOONGARCH32_MARK_LA as well in include/pe.h
>
> Changed from v1
> - Reword commit message, replacing "PE spec" with "PE-COFF specification"
> - Replace obsolete __loongarch64 macro with __loongarch__ and
>   __loongarch_grlen
> - Use a true undefined instruction in efi_selftest_miniapp_exception.c
> - Define HOST_BOOTEFI_NAME and HOST_PXE_ARCH
> - Introduce definition for IMAGE_REL_BASEd_LOONGARCH64_MARK_LA
> ---
>  include/asm-generic/pe.h                          | 2 ++
>  include/config_distro_bootcmd.h                   | 5 +++++
>  include/pe.h                                      | 2 ++
>  lib/efi_loader/efi_helper.c                       | 4 ++++
>  lib/efi_loader/efi_image_loader.c                 | 7 +++++++
>  lib/efi_loader/efi_runtime.c                      | 4 ++++
>  lib/efi_selftest/efi_selftest_miniapp_exception.c | 3 +++
>  7 files changed, 27 insertions(+)
>
> diff --git a/include/asm-generic/pe.h b/include/asm-generic/pe.h
> index cd5b6ad62bf0..fb93f2621715 100644
> --- a/include/asm-generic/pe.h
> +++ b/include/asm-generic/pe.h
> @@ -38,6 +38,8 @@
>  #define IMAGE_FILE_MACHINE_ARM64               0xaa64
>  #define IMAGE_FILE_MACHINE_RISCV32             0x5032
>  #define IMAGE_FILE_MACHINE_RISCV64             0x5064
> +#define IMAGE_FILE_MACHINE_LOONGARCH32 0x6232
> +#define IMAGE_FILE_MACHINE_LOONGARCH64 0x6264
>
>  /* Header magic constants */
>  #define IMAGE_NT_OPTIONAL_HDR32_MAGIC          0x010b
> diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
> index 8d6f80a0ce5c..0eb6bd742b9f 100644
> --- a/include/config_distro_bootcmd.h
> +++ b/include/config_distro_bootcmd.h
> @@ -118,6 +118,8 @@
>  #define BOOTEFI_NAME "bootriscv32.efi"
>  #elif defined(CONFIG_ARCH_RV64I)
>  #define BOOTEFI_NAME "bootriscv64.efi"
> +#elif defined(CONFIG_ARCH_LA64)
> +#define BOOTEFI_NAME "bootloongarch64.efi"
>  #endif
>  #endif
>
> @@ -371,6 +373,9 @@
>  #elif defined(CONFIG_ARCH_RV64I) || ((defined(__riscv) && __riscv_xlen == 64))
>  #define BOOTENV_EFI_PXE_ARCH "0x1b"
>  #define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00027:UNDI:003000"
> +#elif defined(CONFIG_ARCH_LA64) || (defined(__loongarch__) && __loongarch_grlen == 64)
> +#define BOOTENV_EFI_PXE_ARCH "0x27"
> +#define BOOTENV_EFI_PXE_VCI "PXEClient:Arch:00039:UNDI:003000"
>  #elif defined(CONFIG_SANDBOX)
>  # error "sandbox EFI support is only supported on ARM and x86"
>  #else
> diff --git a/include/pe.h b/include/pe.h
> index 086f2b860e99..eac9eb25ce47 100644
> --- a/include/pe.h
> +++ b/include/pe.h
> @@ -194,6 +194,8 @@ typedef struct _IMAGE_RELOCATION
>  #define IMAGE_REL_BASED_THUMB_MOV32             7 /* yes, 7 too */
>  #define IMAGE_REL_BASED_RISCV_LOW12I           7 /* yes, 7 too */
>  #define IMAGE_REL_BASED_RISCV_LOW12S           8
> +#define IMAGE_REL_BASED_LOONGARCH32_MARK_LA    8 /* yes, 8 too */
> +#define IMAGE_REL_BASED_LOONGARCH64_MARK_LA    8 /* yes, 8 too */
>  #define IMAGE_REL_BASED_MIPS_JMPADDR16          9
>  #define IMAGE_REL_BASED_IA64_IMM64              9 /* yes, 9 too */
>  #define IMAGE_REL_BASED_DIR64                   10
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 44b806aadc4f..bc48e265b901 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -62,6 +62,8 @@
>  #define BOOTEFI_NAME "BOOTRISCV32.EFI"
>  #elif defined(CONFIG_ARCH_RV64I)
>  #define BOOTEFI_NAME "BOOTRISCV64.EFI"
> +#elif defined(CONFIG_ARCH_LA64)
> +#define BOOTEFI_NAME "BOOTLOONGARCH64.EFI"
>  #else
>  #error Unsupported UEFI architecture
>  #endif
> @@ -94,6 +96,8 @@ int efi_get_pxe_arch(void)
>                 return 0x19;
>         else if (IS_ENABLED(CONFIG_ARCH_RV64I))
>                 return 0x1b;
> +       else if (IS_ENABLED(CONFIG_ARCH_LA64))
> +               return 0x27;
>
>         return -EINVAL;
>  }
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index f9a2d2df405d..bed5f1817266 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -51,6 +51,13 @@ static int machines[] = {
>  #if defined(__riscv) && (__riscv_xlen == 64)
>         IMAGE_FILE_MACHINE_RISCV64,
>  #endif
> +
> +#if defined(__loongarch__) && __loongarch_grlen == 64
> +       IMAGE_FILE_MACHINE_LOONGARCH64,
> +#endif
> +#if defined(__loongarch__) && __loongarch_grlen == 32
> +       IMAGE_FILE_MACHINE_LOONGARCH32,
> +#endif
>         0 };
>
>  /**
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 73d4097464c0..de50d72d634a 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -78,6 +78,10 @@ struct dyn_sym {
>  #else
>  #error unknown riscv target
>  #endif
> +#elif defined(__loongarch__)
> +#define R_RELATIVE     R_LARCH_RELATIVE
> +#define R_MASK         0xffffffffULL
> +#define IS_RELA                1
>  #else
>  #error Need to add relocation awareness
>  #endif
> diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> index f668cdac4ab2..648206c17098 100644
> --- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
> +++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
> @@ -35,6 +35,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>         asm volatile (".word 0xffffffff\n");
>  #elif defined(CONFIG_X86)
>         asm volatile (".word 0xffff\n");
> +#elif defined(CONFIG_LOONGARCH)
> +       /* ud 31 */
> +       asm volatile (".word 0x386007ff\n");
>  #elif defined(CONFIG_SANDBOX)
>  #if (HOST_ARCH == HOST_ARCH_ARM || HOST_ARCH == HOST_ARCH_AARCH64)
>         asm volatile (".word 0xe7f7defb\n");
> --
> 2.56.0
>
