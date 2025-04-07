Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9489C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 10:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A1F82CF4;
	Mon,  7 Apr 2025 12:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N0TjE7WK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A39B82CF4; Mon,  7 Apr 2025 12:49:59 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B1C82DF2
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 12:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso6907144a12.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744022997; x=1744627797; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L0Ffg4vb/pf/z8k7I4gqxxG8VnH788BPvbqGoji/4G0=;
 b=N0TjE7WKGPzizf4TjaCGGPjJv81gt/rTcdTJU23DFtISjRf6wBLCert33h30SbfmGt
 m6ouS8Tw0EcPBCPHyvRe0CZ7V45ho6pUMGQ/fz8geti+g54lhWbqkWmG9Nj14ZNpsuIM
 8ssJx5CcFYjFcAvh1TDpRGadB3gpq4rW2fsQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744022997; x=1744627797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L0Ffg4vb/pf/z8k7I4gqxxG8VnH788BPvbqGoji/4G0=;
 b=mjxdjc4zitoeRug5u4vUnateEiklran/7Kf4yhmJvoMDfFeG793gVQCXn7qb2OcHP4
 BW6lx+GCm3HhSblX0dx6S2IFALcAGfEEXFsjy6PBD3R7ji0+TqjTT99+a1nJ/BGvI+zi
 kbUzHv0CsITfaVkhV00TU8HAUXaXDNvbWAP1u6VJVWYJUVVQ9Uzt8OxQ6ARZ9OdMP98W
 MaTYRwqwrT2ulUPz+kgDzifq9vpucgmAcVYVgSXY2RJAC8cTekgBKMwFqgGkDunIXp/c
 1v+SQ25QL2OsxJN8VNeU/mYsg6LU9dIo4NtS7FGD+AxPWOFkZqAWK7aXi/NPyGc/UODU
 2Pgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzRzB+Xl1Forrflvi7KWIpbARWNn9ryc06cgFOsCXLYR36TO0S8NKj9WbsLedHmz4VpA8Sttw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyri+mAyL7lftFRYEKkukyobxPCXohc7Vg4FOBfJlWC4wt9DlXN
 /DZcfh5EwHi7xvmlzJVyWWPkChU5UcBruFH7a4pmNpIxfy7AHueCuYy6ds/Gcr17DGJvmKuwTbM
 +XqQHe1oQfrH44CEp4SLRxosdOctcUQjBYetI
X-Gm-Gg: ASbGncv4fV4KjOe4tTp4/MK8h2xWJldpgN6/G13SnzQ/xkrqM9qoItzJKMQBK00RAdf
 LWNldlmCO4UloYmsRnJhOchexP7BBQSOkLfPNVY67FnqzEw/JyKmGmcRWRsX0vl6K6zM+DTktDh
 QnVDF5G3/boDfIcVK1GAdzoqjy5Tw=
X-Google-Smtp-Source: AGHT+IFUP8lzQAWvysKUMybOHDbixKXT6nYvodbxOSWR4x9fMumun5GZRtCI2NmotazoZOG1vY9wjfxuI0pHfopuZPg=
X-Received: by 2002:a17:907:60d1:b0:ac2:66ff:878 with SMTP id
 a640c23a62f3a-ac7e77b48afmr823274466b.50.1744022996725; Mon, 07 Apr 2025
 03:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-3-ziyao@disroot.org>
In-Reply-To: <20250407033744.4025-3-ziyao@disroot.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 22:49:44 +1200
X-Gm-Features: ATxdqUHBndGH3M3yg9d0pG0_1DP8BPBhpzV0BtwGs4DIJFGo9xlJCt_5d7hKt_s
Message-ID: <CAFLszTidOt+CeMEVuWr-iYrgkR+kpe2vpRAL8vdaBs+b32ucGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Provide __image_copy_{start_end} symbols in
 linkerscript
To: Yao Zi <ziyao@disroot.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Trevor Woerner <twoerner@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

+Heinrich Schuchardt

On Mon, 7 Apr 2025 at 15:38, Yao Zi <ziyao@disroot.org> wrote:
>
> Binman looks for __image_copy_start to determine the base address of an
> entry if elf-base-sym isn't specified, which is missing in RISC-V port.
> This causes binman skips RISC-V SPL entries without filling addresses
> into its .binman_sym_table section.
>
> This patch defines __image_copy_start in linkerscript of both SPL and
> proper U-Boot to ensure binman_sym functions correctly with the default
> binman.dtsi. The paired symbol, __image_copy_end, is introduced as well
> for completeness.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/cpu/u-boot-spl.lds | 2 ++
>  arch/riscv/cpu/u-boot.lds     | 3 +++
>  2 files changed, 5 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
> index 907094620bd..18eb62c01c6 100644
> --- a/arch/riscv/cpu/u-boot-spl.lds
> +++ b/arch/riscv/cpu/u-boot-spl.lds
> @@ -16,6 +16,7 @@ ENTRY(_start)
>  SECTIONS
>  {
>         . = ALIGN(4);
> +       __image_copy_start = ADDR(.text);
>         .text : {
>                 arch/riscv/cpu/start.o  (.text)
>                 *(.text*)
> @@ -46,6 +47,7 @@ SECTIONS
>
>         _end = .;
>         _image_binary_end = .;
> +       _image_copy_end = .;
>
>         .bss : {
>                 __bss_start = .;
> diff --git a/arch/riscv/cpu/u-boot.lds b/arch/riscv/cpu/u-boot.lds
> index 2ffe6ba3c8f..b11ea8b56d2 100644
> --- a/arch/riscv/cpu/u-boot.lds
> +++ b/arch/riscv/cpu/u-boot.lds
> @@ -10,6 +10,7 @@ ENTRY(_start)
>  SECTIONS
>  {
>         . = ALIGN(4);
> +       __image_copy_start = ADDR(.text);
>         .text : {
>                 arch/riscv/cpu/start.o  (.text)
>         }
> @@ -57,6 +58,8 @@ SECTIONS
>                 __efi_runtime_rel_stop = .;
>         }
>
> +       __image_copy_end = .;
> +
>         /DISCARD/ : { *(.rela.plt*) }
>         .rela.dyn : {
>                 __rel_dyn_start = .;
> --
> 2.49.0
>
