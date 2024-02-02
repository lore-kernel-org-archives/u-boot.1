Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159B0C47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 04:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A74C87C56;
	Fri,  2 Feb 2024 05:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Vz+Td2W9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E7387C66; Fri,  2 Feb 2024 05:17:05 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9763987C13
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 05:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-21499c9650cso953789fac.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 20:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706847421; x=1707452221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S2OLfGQKAgCfwtj1/Iyu1B8P9JPv/rSM/r0qw5HDqZs=;
 b=Vz+Td2W9X9F1Uf8ftvQ1DGq8SUYKpEEUTlX+TqmrCngNOoS4hh/Gqzb+yxm3sIEgTS
 Dvebu7SrZY/Mn2u9S9ws7Gi9y9q3gfPn54p/rTvsZkz8CxEHTqNneBAE0zTDNDnv8l3b
 fswgGgJLS+FXIYfrQB7u759lBv91dur7n9jYezCloIGsRIO1BiRw3CfXfgQ7Tw6N15IT
 o5cmCXlar4qLl5bfO2WqRfjtEi02Z0vTBacn26Ori3S+nchBfI+0ag1qQAWpMs8iB4qP
 y6Sce8q46X7Rl+GFPli5bXGTCRRZoVsrTpKekuAVRE1VzzHqnxx0GHGJzJIkXvku2gyS
 PAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706847421; x=1707452221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S2OLfGQKAgCfwtj1/Iyu1B8P9JPv/rSM/r0qw5HDqZs=;
 b=PRvQ9g4+CCF393n/k2Na1MTgy+j3owvfFFT4/IpfWtfkqRgRjnQcjM7iUS4AF4lRU4
 7UIPd+3HnaOuChtruk1evUXReBLOQVskH3ZPdCvWd4KyhlHLKPc915toDp0vONTRs4V6
 +DwIJq67QiGZusYlIiiM1YPgb1mXFyG/7qZeoiBO1PN1GnHEbJuD+IaKKKSHiyaK/nkz
 85OLQ3GLOMDk8oxvFjpggNcoxKw9Kyjojwfb35HlUx3DMUuHkY60ao6Nwisa0xxSMeFn
 RUra50tgwujkGD3hp9UT5yW3kowrhXmJFuOinxA6A4UFcsigCH6zXvsdAZGQQisGg82H
 ZOSQ==
X-Gm-Message-State: AOJu0YwzD5KZzVJbCQ3NDe9d4cUZYYwu0NWf+9xkjyFGYaCbUVvNcxhR
 SykRNixiDOB8HTcRt3TMPm88jv+Lv9UF435Vs64RjXuwTTgmnPSHYXxTK+9jds3Di19pKjl/kBn
 VSM+g+hCqjyx364vExbKx7h0gEm8qJu+IPFc82T5yVB5zi3+nLUY=
X-Google-Smtp-Source: AGHT+IH/jkdp15/0IUI/hf+sMGAYILKq6xpsmgJLRFsWfiDBeCtw6SCaVFyYOhH/opZOVQxjZA0W0OBo8r2iP2nNht0=
X-Received: by 2002:a05:6870:3045:b0:214:27cf:bd1d with SMTP id
 u5-20020a056870304500b0021427cfbd1dmr886152oau.25.1706847421156; Thu, 01 Feb
 2024 20:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20240201124054.2094572-1-igor.opaniuk@foundries.io>
In-Reply-To: <20240201124054.2094572-1-igor.opaniuk@foundries.io>
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Date: Fri, 2 Feb 2024 06:16:49 +0200
Message-ID: <CAOF=9AtCdqhNTK34niKXew1kuDMckOh9jjmfvD4fBb7j56tjEw@mail.gmail.com>
Subject: Re: [PATCH v2] qemu-arm: round down memory to multiple of 2MB for LPAE
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, ardb@kernel.org,
 jens.wiklander@linaro.org, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, Feb 1, 2024, 14:41 Igor Opaniuk <igor.opaniuk@foundries.io> wrote:

> QEMU's -m option can take fractional megabyte values,
> and lowest granularity seems to be 0x2000.
> For example, run qemu with amount of memory set to 100005k (0x61A9400):
>
> $ qemu-system-arm -machine virt -cpu cortex-a15 -m 100005k \
> -bios denx/u-boot.bin -nographic
>
> => fdt addr $fdt_addr
> => fdt print /memory@40000000
> memory@40000000 {
>         reg = <0x00000000 0x40000000 0x00000000 0x061aa000>;
>         device_type = "memory";
> };
>
> When LPAE is enabled, 1:1 mapping is created using 2 MB blocks.
> In case amount of memory provided to QEMU is not multiple
> of 2 MB, hang occurs during MMU initialization.
>
> How to reproduce:
> qemu-system-arm -machine virt -m 1058 -nographic -bios u-boot.bin - boots
> qemu-system-arm -machine virt -m 1057 -nographic -bios u-boot.bin - hangs
>
> DRAM:  1 GiB
> initcall: 60011df8
> initcall: 60011904
> New Stack Pointer is: 80fffe90
> initcall: 60011a20
> initcall: 60011bcc
> initcall: 60011bd4
> initcall: 600119b4
> Relocation Offset is: 22042000
> Relocating to 82042000, new gd at 81001ed0, sp at 80fffe90
> initcall: 60011b8c
> initcall: 82053ea0
> initcall: 82053ea8
> initcall: 60012040 (relocated to 82054040)
> dram_bank_mmu_setup: bank: 0
> - hang here during mmu init -
>
> This patches rounds down to the nearest multiple of 2MB when
> CONFIG_ARMV7_LPAE=y.
>
> Fixes: 3fa914af82("arm: qemu: implement enable_caches()")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io
<igor.opaniuk@foundries.io>>

> ---
>
> Changes in v2:
> - Adjust commit message, add more details
>
>  board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/board/emulation/qemu-arm/qemu-arm.c
> b/board/emulation/qemu-arm/qemu-arm.c
> index 942f1fff571..ecfd19f1a7e 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -127,6 +127,18 @@ int dram_init(void)
>         if (fdtdec_setup_mem_size_base() != 0)
>                 return -EINVAL;
>
> +       /*
> +        * When LPAE is enabled (ARMv7),
> +        * 1:1 mapping is created using 2 MB blocks.
> +        *
> +        * In case amount of memory provided to QEMU
> +        * is not multiple of 2 MB, round down the amount
> +        * of available memory to avoid hang during MMU
> +        * initialization.
> +        */
> +       if (CONFIG_IS_ENABLED(ARMV7_LPAE))
> +               gd->ram_size -= (gd->ram_size % 0x200000);
> +
>         return 0;
>  }
>
> --
> 2.34.1
>
>
