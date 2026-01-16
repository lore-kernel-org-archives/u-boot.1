Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9BD4A619
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7298389A;
	Fri, 16 Jan 2026 11:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f0CGt86d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 409AE83952; Fri, 16 Jan 2026 11:00:30 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6308B83015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7927b3e5253so16331977b3.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768557626; x=1769162426; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xU+PlDHQR09ygZogzU6u+1p3z8eXOB0u81jDqpa5bos=;
 b=f0CGt86d12mNNq47sVjSMkL39iGJh9hYBKcYp5frzm0QK9SoxsbDQdrZljawI/K97S
 iVdEwppCh7UDUyWr0JDXtqWMLT7qVdtXm5/r3oG2ocP8dEq5GOAk6iBMetb1TGTSZIYX
 JNRiWjxWHFgECDAUlKaWh6G67Gb0SMGSzzzoBOKE9N20Kqo1Nhi/9YhsYI7O91JEZkLJ
 c6LnhRZYaW6uLMbU1IBlm7y7quL4wEC8tD03nXxUj0FfaPlw4WXoEuivCfPiUnliNj7r
 tUjeHNwvHaWIWx+yDM4g3PVSWjp1VV0v+Q4roaz2woPGClYXZgRgxy1un6iycrz5/rIy
 3FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768557626; x=1769162426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xU+PlDHQR09ygZogzU6u+1p3z8eXOB0u81jDqpa5bos=;
 b=VBJyL7bR8TTUU6v/GVtN73IVzU3IYekUjcwCu58rvXFx4fwobz60ruQqRt0m6VzaVm
 l7TaZqDV2hqk+31ZdxePY+mUj9Cv4iWNbXrR928KcaY09rRzl1NiVlv6ukP9ampEFoFQ
 iEXlJKuNh9Lspr7jQncui65K2hzaPZebKlEOOHikDz1zI9VMsxkYf4MBb9hoQH6R1TDB
 KilI62iaq6Eaxrg7d/t9FdYPgppw4lmai7ktoC0BXj6nGSsj9DFQ25PD63jjGiyoZJPA
 CtemkNLkmIRWc6D6kKrJH0OdsmhgencguERlycyeYShjveaH+s+Hznvv44HsoEW8P7jC
 CKsQ==
X-Gm-Message-State: AOJu0Yw7XNHUS1fgCmdUu8PE99QLZlin2oNr0RrXshl1f8CWc/vdJI1G
 ZLv8Q5HVakf8+/3BnBdLIezsI+YXPS5owmiUbe5bLJhVEKp5+sYGqBrFynqm1WZGOpg1/lojeSk
 7fcrf8diNcii0n9dspJm98a1BsnNSK1m502mHc0INlQ==
X-Gm-Gg: AY/fxX5+PJ4vZ8bZMnKWpDWlmqS4jtX6QmRJzoJwmzA3M3Ofv9DfRlUFRIkBW/98DVe
 F/BulPHO9CaDTvRAGEoMKk0/LVbEbe1XLoLJkv7yuB/tIErVhNJdyZfBaeCWfebUBtqv5w8KTLQ
 OR2ygd9NJD9LnDixTyfjzTCdXgj+hPNm6tIgCu3NuGbby3jAu8AQBnuAzMSmtSKbeCCXL4x6ecF
 BB1jHkpTizzigQ5XSAzvpXkB/aaL4sMh8IhUjYbHMhZdiV4NSbW/dGgB1oZeycfGCy2lRORqWsK
 MUX5MNzTNdnBhXQMRldcoFV0ElSxJV22bchJ7FDkTHdUuANmhvQ3UZOOiXNsMV/4b9F5JmvUy+F
 JgnjSHDO1mZL4ofXqFkl3186js/FVQ1ggtEBLA4wEJiiu2AcFFCh7aiiwnVFWKfReY8mjnaWNUi
 F60oxn1SDcJ0VfxzvnsKfPsW7r+RnA5Vmne/i6jKEsFA+4VCl5hMQVVPDvYX27+aeeKRVO1fdAP
 FnfnI7U995DG3g/qvzrZYzf+loKIy83LS4TqVXckxa4w1E2nHYO2B83cP5vHibCgGNU7Q2PaU+e
 BGE4DVxQ1PAzuX6o/+zZJYJ0xo1xJyFE
X-Received: by 2002:a05:690c:883:b0:78f:f3e2:35e1 with SMTP id
 00721157ae682-793c539349emr19748397b3.36.1768557625983; Fri, 16 Jan 2026
 02:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
In-Reply-To: <20260115222828.3931345-3-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 16 Jan 2026 11:59:49 +0200
X-Gm-Features: AZwV_QiwrGwYJmE5utfK9PsZCpOttIfJyyQg7GyMtYIp2xivwIFc-aYS9qCDFbY
Message-ID: <CAC_iWjLUX38Z0ucpN37EsKE8T8w+Qw5hpteFRm=5uaf+Yfnv7g@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

Hi Tom,

arch/arm/cpu/armv8/u-boot.lds and arch/arm/mach-omap2/u-boot-spl.lds
can use the same alignment. Is the omap2 case covered by the TI
patches? I think it's better if you bundle this up in this series

Cheers
/Ilias

On Fri, 16 Jan 2026 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Expands some linker sections to be more readable when adding a second
>   statement to the section.
> - Aligns the final section before _end (for U-Boot) or
>   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
>   '. = ALIGN(8);' to the final section before the symbol.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>   aligned we fail to link (and explain why).
> - Remove now-spurious  '. = ALIGN(x);' statements that were intended to
>   provide the above alignments.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> The only part of this I am only mostly rather than fully confident in is
> having caught all cases of having SPL_SEPARATE_BSS being false. I
> believe I have as the generic ARM SPL linker script enforces the BSS
> ending with 8-byte alignment, and the point of the ASSERTs here is to
> catch the case where the section we're adding the ALIGN to ends up being
> empty and so that ALIGN would become useless.
>
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Stefano Babic <sbabic@nabladev.com>
> ---
>  arch/arm/cpu/arm1136/u-boot-spl.lds            | 8 ++++++--
>  arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      | 5 ++++-
>  arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds    | 5 ++++-
>  arch/arm/cpu/armv7/sunxi/u-boot-spl.lds        | 5 ++++-
>  arch/arm/cpu/armv8/u-boot-spl.lds              | 4 +++-
>  arch/arm/cpu/armv8/u-boot.lds                  | 2 ++
>  arch/arm/cpu/u-boot-spl.lds                    | 5 ++++-
>  arch/arm/cpu/u-boot.lds                        | 4 ++++
>  arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 4 ++++
>  arch/arm/mach-at91/arm926ejs/u-boot-spl.lds    | 9 +++++++--
>  arch/arm/mach-at91/armv7/u-boot-spl.lds        | 9 +++++++--
>  arch/arm/mach-omap2/u-boot-spl.lds             | 3 +++
>  arch/arm/mach-rockchip/u-boot-tpl-v8.lds       | 5 ++++-
>  arch/arm/mach-zynq/u-boot-spl.lds              | 6 ++++--
>  arch/arm/mach-zynq/u-boot.lds                  | 3 +++
>  board/davinci/da8xxevm/u-boot-spl-da850evm.lds | 4 ++++
>  board/samsung/common/exynos-uboot-spl.lds      | 5 ++++-
>  17 files changed, 71 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/cpu/arm1136/u-boot-spl.lds b/arch/arm/cpu/arm1136/u-boot-spl.lds
> index b7af29183a97..22a9302275ae 100644
> --- a/arch/arm/cpu/arm1136/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm1136/u-boot-spl.lds
> @@ -30,8 +30,10 @@ SECTIONS
>         .rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) } >.sram
>
>         . = ALIGN(4);
> -       .data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
> -       . = ALIGN(4);
> +       .data : {
> +               *(SORT_BY_ALIGNMENT(.data*))
> +               . = ALIGN(8);
> +       } >.sram
>         __image_copy_end = .;
>         _end = .;
>
> @@ -44,3 +46,5 @@ SECTIONS
>                 __bss_end = .;
>         } >.sdram
>  }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> index 7c6309246f8b..b4adae272eba 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> @@ -45,7 +45,7 @@ SECTIONS
>                 . = ALIGN(4);
>                 __bss_start = .;
>                 *(.bss*)
> -               . = ALIGN(4);
> +               . = ALIGN(8);
>                 __bss_end = .;
>         }
>
> @@ -62,3 +62,6 @@ SECTIONS
>         .gnu : { *(.gnu*) }
>         .ARM.exidx : { *(.ARM.exidx*) }
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
> index cf65e8c46281..2225985c79c0 100644
> --- a/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm926ejs/sunxi/u-boot-spl.lds
> @@ -31,9 +31,9 @@ SECTIONS
>         . = ALIGN(4);
>         __u_boot_list : {
>                 KEEP(*(SORT(__u_boot_list*)));
> +               . = ALIGN(8);
>         } > .sram
>
> -       . = ALIGN(4);
>         __image_copy_end = .;
>         _end = .;
>         _image_binary_end = .;
> @@ -47,3 +47,6 @@ SECTIONS
>                 __bss_end = .;
>         } > .sdram
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds b/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
> index fb7a789b28b8..e69291d8be6d 100644
> --- a/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv7/sunxi/u-boot-spl.lds
> @@ -40,9 +40,9 @@ SECTIONS
>         . = ALIGN(4);
>         __u_boot_list : {
>                 KEEP(*(SORT(__u_boot_list*)));
> +               . = ALIGN(8);
>         } > .sram
>
> -       . = ALIGN(4);
>         __image_copy_end = .;
>         _end = .;
>         _image_binary_end = .;
> @@ -56,3 +56,6 @@ SECTIONS
>                 __bss_end = .;
>         } > .sdram
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> index c4f83ec9cfc4..d9963846c4f4 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -52,9 +52,9 @@ SECTIONS
>         __u_boot_list : {
>                 . = ALIGN(8);
>                 KEEP(*(SORT(__u_boot_list*)));
> +               . = ALIGN(8);
>         } >.sram
>
> -       . = ALIGN(8);
>         __image_copy_end = .;
>         _end = .;
>         _image_binary_end = .;
> @@ -89,5 +89,7 @@ SECTIONS
>  #endif
>  }
>
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
>  ASSERT(ADDR(.bss) % 8 == 0, \
>         ".bss must be 8-byte aligned");
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index f4ce98c82c8d..704e0bf9468d 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -175,3 +175,5 @@ SECTIONS
>  #include "linux-kernel-image-header-vars.h"
>  #endif
>  }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index 5aecb61ce902..d780a5060774 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -51,9 +51,9 @@ SECTIONS
>                 __rel_dyn_start = .;
>                 *(.rel*)
>                 __rel_dyn_end = .;
> +               . = ALIGN(8);
>         }
>
> -       . = ALIGN(8);
>         _image_binary_end = .;
>         _end = .;
>
> @@ -80,6 +80,9 @@ ASSERT(__image_copy_end - __image_copy_start <= (IMAGE_MAX_SIZE), \
>         "SPL image too big");
>  #endif
>
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>  #if defined(CONFIG_SPL_BSS_MAX_SIZE)
>  ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
>         "SPL image BSS too big");
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 78aad093d3b2..8e2266a90fe2 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -164,6 +164,7 @@ SECTIONS
>                 __rel_dyn_start = .;
>                 *(.rel*)
>                 __rel_dyn_end = .;
> +               . = ALIGN(8);
>         }
>
>         _end = .;
> @@ -192,3 +193,6 @@ SECTIONS
>         /DISCARD/ : { *(.ARM.exidx*) }
>         /DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> index 9502a7384b53..c9664a6ce566 100644
> --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> @@ -59,6 +59,7 @@ SECTIONS
>                 __rel_dyn_start = .;
>                 *(.rel*)
>                 __rel_dyn_end = .;
> +               . = ALIGN(8);
>         } > .nor
>
>         _end = .;
> @@ -79,6 +80,9 @@ ASSERT(__image_copy_end - __image_copy_start <= (IMAGE_MAX_SIZE), \
>         "SPL image too big");
>  #endif
>
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>  #if defined(CONFIG_SPL_BSS_MAX_SIZE)
>  ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
>         "SPL image BSS too big");
> diff --git a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> index 09cf838cf96e..1af4f7b6524c 100644
> --- a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> +++ b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> @@ -29,9 +29,11 @@ SECTIONS
>         .data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
>
>         . = ALIGN(4);
> -       __u_boot_list : { KEEP(*(SORT(__u_boot_list*))) } > .sram
> +       __u_boot_list : {
> +               KEEP(*(SORT(__u_boot_list*)))
> +               . = ALIGN(8);
> +       } > .sram
>
> -       . = ALIGN(4);
>         __image_copy_end = .;
>         _end = .;
>         _image_binary_end = .;
> @@ -51,6 +53,9 @@ ASSERT(__image_copy_end - __start <= (IMAGE_MAX_SIZE), \
>         "SPL image too big");
>  #endif
>
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>  #if defined(CONFIG_SPL_BSS_MAX_SIZE)
>  ASSERT(__bss_end - __bss_start <= (CONFIG_SPL_BSS_MAX_SIZE), \
>         "SPL image BSS too big");
> diff --git a/arch/arm/mach-at91/armv7/u-boot-spl.lds b/arch/arm/mach-at91/armv7/u-boot-spl.lds
> index 460a91d93ec4..287764df48ff 100644
> --- a/arch/arm/mach-at91/armv7/u-boot-spl.lds
> +++ b/arch/arm/mach-at91/armv7/u-boot-spl.lds
> @@ -36,9 +36,11 @@ SECTIONS
>         .data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
>
>         . = ALIGN(4);
> -       __u_boot_list : { KEEP(*(SORT(__u_boot_list*))) } > .sram
> +       __u_boot_list : {
> +               KEEP(*(SORT(__u_boot_list*)))
> +               . = ALIGN(8);
> +       } > .sram
>
> -       . = ALIGN(4);
>         __image_copy_end = .;
>         _end = .;
>         _image_binary_end = .;
> @@ -52,3 +54,6 @@ SECTIONS
>                 __bss_end = .;
>         } >.sdram
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
> index 5ad169a37b73..86ab692ae390 100644
> --- a/arch/arm/mach-omap2/u-boot-spl.lds
> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> @@ -55,3 +55,6 @@ SECTIONS
>                 __bss_end = .;
>         } >.sdram
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> index 958a1b70aefe..2c0f5c3e5f32 100644
> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> @@ -42,9 +42,9 @@ SECTIONS
>         __u_boot_list : {
>                 . = ALIGN(8);
>                 KEEP(*(SORT(__u_boot_list*)));
> +               . = ALIGN(8);
>         }
>
> -       . = ALIGN(8);
>         __image_copy_end = .;
>         _end = .;
>         _image_binary_end = .;
> @@ -69,6 +69,9 @@ ASSERT(__image_copy_end - __image_copy_start < (CONFIG_TPL_MAX_SIZE), \
>         "TPL image too big");
>  #endif
>
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> +
>  #if defined(CONFIG_TPL_BSS_MAX_SIZE)
>  ASSERT(__bss_end - __bss_start < (CONFIG_TPL_BSS_MAX_SIZE), \
>         "TPL image BSS too big");
> diff --git a/arch/arm/mach-zynq/u-boot-spl.lds b/arch/arm/mach-zynq/u-boot-spl.lds
> index d96a57702886..17f0d7c9b72f 100644
> --- a/arch/arm/mach-zynq/u-boot-spl.lds
> +++ b/arch/arm/mach-zynq/u-boot-spl.lds
> @@ -39,10 +39,9 @@ SECTIONS
>         . = ALIGN(4);
>         __u_boot_list : {
>                 KEEP(*(SORT(__u_boot_list*)));
> +               . = ALIGN(8);
>         } > .sram
>
> -       . = ALIGN(4);
> -
>         _image_binary_end = .;
>
>         _end = .;
> @@ -62,3 +61,6 @@ SECTIONS
>         /DISCARD/ : { *(.interp*) }
>         /DISCARD/ : { *(.gnu*) }
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index f52523edf490..2a8e3399e0bf 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -66,6 +66,7 @@ SECTIONS
>                 __rel_dyn_start = .;
>                 *(.rel*)
>                 __rel_dyn_end = .;
> +               . = ALIGN(8);
>         }
>
>         _end = .;
> @@ -98,3 +99,5 @@ SECTIONS
>         /DISCARD/ : { *(.ARM.exidx*) }
>         /DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
>  }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
> index 56d6f4f114b9..d1a82e118af1 100644
> --- a/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
> +++ b/board/davinci/da8xxevm/u-boot-spl-da850evm.lds
> @@ -43,6 +43,7 @@ SECTIONS
>                 __rel_dyn_start = .;
>                 *(.rel*)
>                 __rel_dyn_end = .;
> +               . = ALIGN(8);
>         } >.sram
>
>         __image_copy_end = .;
> @@ -58,3 +59,6 @@ SECTIONS
>                 __bss_end = .;
>         } >.sdram
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/board/samsung/common/exynos-uboot-spl.lds b/board/samsung/common/exynos-uboot-spl.lds
> index 9d3b57e98dbb..62e150bcf335 100644
> --- a/board/samsung/common/exynos-uboot-spl.lds
> +++ b/board/samsung/common/exynos-uboot-spl.lds
> @@ -48,7 +48,10 @@ SECTIONS
>                 . = ALIGN(4);
>                 __bss_start = .;
>                 *(.bss*)
> -               . = ALIGN(4);
> +               . = ALIGN(8);
>                 __bss_end = .;
>         } >.sram
>  }
> +
> +ASSERT(__bss_end % 8 == 0, \
> +       "__bss_end must be 8-byte aligned for device tree");
> --
> 2.43.0
>
