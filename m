Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F31C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0858091B;
	Wed,  5 Feb 2025 14:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e1T+UWgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0543A805D7; Wed,  5 Feb 2025 09:22:48 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C19F80207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so6159616276.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 00:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738743764; x=1739348564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JT0Wz3yeh0hKv0xZzJRg2rp/Vdbg7auROwzkXOpvzyM=;
 b=e1T+UWgu93RysMzFvnoAbUa2WWcllVnBtm+Umv2uQx0gVsCvjDQ7dHdVsvLchC1FpY
 Ry53ys2CM/Nmdqklli2x9WjeT6DrsZuXa9EK7JLm/E43o5owNOD/Hxa+s8pJ2dEq1KGl
 axzqXuAsUQa+OOxVVGpU82pxjBXF5wwI4MuWPeTw4E7rGtv1+SZtcp8Mfe7Ff5cI72pZ
 rqXWvwSF8qY+FRdDv4DNVzx9O3Xv0dmG88hbTuabmUye8p+HPRj0A8LeRjXDKZmjDGd7
 q6CwAMzYhdY5gbUoWgk/9RpTtLpKzOBgyeoX22S+3KsK427AtTn28czUK2IoWbryCx1x
 9iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738743764; x=1739348564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JT0Wz3yeh0hKv0xZzJRg2rp/Vdbg7auROwzkXOpvzyM=;
 b=TbobH9UpViAhTHBihezkpOZ6pKHWVql1eCxPOzv12JIG8KGXLZc9oiiKuFP2mFXa18
 jEEZWPfPyQcOytrLpU+DRTEITJrcja2n1j+91g2yT+eJbQT1ttbYvZnDZpqZia6iMUbn
 MwTQBRLHbkwdYSIDZy0vUF/Y0Ysr4NCB11cPCe4XHTfljuxdl1UMG+As6JEoyM/h0Gtq
 OnphrDo4ryTDVmpQow3kY7M4C+uq0kJ/RU2tHfTUbvsiC02p+EdvXlAcQ+eOJbnDrjmd
 L+ba8t+VW/cI+L2ecQyBaZ+y0S3ze3vMkkqQTAK057JIIsTdZIXSe7vOQYayhMDhErdC
 NvhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhIfaf+KYdsv8bvu+Au3AOL18U7iy2JE6UyQrMiGfaGiMdaemC3dR8BqnRyft/ineiFVf6jBs=@lists.denx.de
X-Gm-Message-State: AOJu0YxW1ECy8Bsp357w/V+tPFmzzkHKiORd+2lM9XIZpSDjCzt+44x7
 3zIuzVkvOm71CN+a1xhxgQXARlWX2E1eSnv5tTiBKRz128O2I4sPou+uTRqThuxxrnGX/kxOcHw
 phtqO3IRQAXY3m+e19DKcSsPL8lFWRyucEV0LGw==
X-Gm-Gg: ASbGncuUqvnEdEqGJBx1Un/K2HafbNPXFwqdNqRZTKnxOtRH2OcA1yAURZkqsFiOP5u
 +tAg7U0x7DVOw6EwJYnIiu465xstGnHvduxnPdvSzhdcsBzV7prUZbF+zI/87QrqDUdBjvZx6
X-Google-Smtp-Source: AGHT+IHAAVQgxqR25GIAonPpQqEaI/8qcUshJPEzqtBGmoMBr7OfHcWM6LUJKher/0nH9lV6Le63p/mzbLzptPSNJ9g=
X-Received: by 2002:a05:6902:2487:b0:e38:b34d:121f with SMTP id
 3f1490d57ef6-e5b25b92168mr1651017276.15.1738743764254; Wed, 05 Feb 2025
 00:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
In-Reply-To: <20250205071714.635518-4-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 10:22:08 +0200
X-Gm-Features: AWEUYZkqbvhgwRL_7S19l6kCVHLNawotXVpcrzblV_3bl5ZHinkZq0cYxJSDl5w
Message-ID: <CAC_iWjJnGGLhSyZFyF3jju9Evq9hY792jsDD4bL33H+6E2x9+w@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
To: xypron.glpk@gmx.de, trini@konsulko.com
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Marc Zyngier <maz@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Sam Day <me@samcday.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>, 
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

I'm just replying to myself here but I'll send a v2 when the patches
are reviewed.

I can add the linker under an ifdef, so u-boot size won't change
unless a Kconfig options is selected

/Ilias

On Wed, 5 Feb 2025 at 09:17, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Upcoming patches are switching the memory mappings to RW, RO, RX
> after the U-Boot binary and its data are relocated. Add
> annotations in the linker scripts to and mark text, data, rodata
> sections and align them to a page boundary.
>
> It's worth noting that efi_runtime relocations are left untouched for
> now. The efi runtime regions can be relocated by the OS when the latter
> is calling SetVirtualAddressMap. Which means we have to configure the
> pages as RX for U-Boot but convert them to RWX just before
> ExitBootServices. It also needs extra code in efi_tuntime relocation
> code since R_AARCH64_NONE are emitted as well if we page align the
> section. Keep it out for now and we can fix it in future patches.
>
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/u-boot.lds  | 29 +++++++++++++++++------------
>  include/asm-generic/sections.h |  2 ++
>  2 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index 857f44412e07..35afc3cbe7ec 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -22,7 +22,7 @@ SECTIONS
>
>         . = ALIGN(8);
>         __image_copy_start = ADDR(.text);
> -       .text :
> +       .text ALIGN(4096):
>         {
>                 CPUDIR/start.o (.text*)
>         }
> @@ -36,9 +36,12 @@ SECTIONS
>                  __efi_runtime_stop = .;
>         }
>
> -       .text_rest :
> +       .text_rest ALIGN(4096) :
>         {
> +               __text_start = .;
>                 *(.text*)
> +               . = ALIGN(4096);
> +               __text_end = .;
>         }
>
>  #ifdef CONFIG_ARMV8_PSCI
> @@ -98,18 +101,20 @@ SECTIONS
>         }
>  #endif
>
> -       . = ALIGN(8);
> -       .rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> +       .rodata ALIGN(4096): {
> +           __start_rodata = .;
> +           *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> +           . = ALIGN(4096);
> +           __end_rodata = .;
> +       }
>
> -       . = ALIGN(8);
> -       .data : {
> +       .data ALIGN(4096) : {
> +           __start_data = .;
>                 *(.data*)
> +           . = ALIGN(4096);
> +           __end_data = .;
>         }
>
> -       . = ALIGN(8);
> -
> -       . = .;
> -
>         . = ALIGN(8);
>         __u_boot_list : {
>                 KEEP(*(SORT(__u_boot_list*)));
> @@ -136,10 +141,10 @@ SECTIONS
>         /*
>          * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
>          */
> -       .bss ALIGN(8) : {
> +       .bss ALIGN(4096) : {
>                 __bss_start = .;
>                 *(.bss*)
> -               . = ALIGN(8);
> +               . = ALIGN(4096);
>                 __bss_end = .;
>         }
>
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 3fd5c772a1af..024b1adde270 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -23,6 +23,7 @@ extern char __kprobes_text_start[], __kprobes_text_end[];
>  extern char __entry_text_start[], __entry_text_end[];
>  extern char __initdata_begin[], __initdata_end[];
>  extern char __start_rodata[], __end_rodata[];
> +extern char __start_data[], __end_data[];
>  extern char __efi_helloworld_begin[];
>  extern char __efi_helloworld_end[];
>  extern char __efi_var_file_begin[];
> @@ -63,6 +64,7 @@ static inline int arch_is_kernel_data(unsigned long addr)
>
>  /* Start of U-Boot text region */
>  extern char __text_start[];
> +extern char __text_end[];
>
>  /* This marks the text region which must be relocated */
>  extern char __image_copy_start[], __image_copy_end[];
> --
> 2.47.2
>
