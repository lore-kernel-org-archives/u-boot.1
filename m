Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D0ED4A619
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E418C83015;
	Fri, 16 Jan 2026 10:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dtb69hJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036168309A; Fri, 16 Jan 2026 10:50:11 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC4182BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:50:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fba1a1b1eso28771087b3.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768557005; x=1769161805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Je9PjHbKRgczDnE8utREKZ6unrll4pQ7futG2JqlvDI=;
 b=Dtb69hJeabxlWmZaQ/YI+mJeQoAen0ct+8YxDiEMuqM40B/73yMOpuRzkDJ5cuAwTS
 TaG7kuKyWYhm7vIChDzm9MTLuMu7bahyZ+nxxtA0StKx8hROgrRVMGTu2jnw2VP5OUY9
 oKcEakrPHZ0CC+u6f6yCsjxg38rdurGsdl+x1yv1H4BRKKDZSaTXSFUewc4ule2RXRV6
 I5ZciMcyAHZfCNmmiVyrMXcWR/ViW2SjeFG1cmDAdZGPoV4eYU1dJ27HXyGGc3Fx16Dl
 M/o/Pszpb4tyiwx1PerP4f5dcH5Q2RFl3NBqMBMJ6OZCzEmEvpVEHAd6Pf07GJWLQ3fl
 DNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768557005; x=1769161805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je9PjHbKRgczDnE8utREKZ6unrll4pQ7futG2JqlvDI=;
 b=Ia0HyODhE0lQBC3mOA9uLksh5h5z8bY2jOnJjsehT9gAVB5ffk1Pff/jXgS0PaReMb
 /QKU+rV9+Irg9hBEVKhlsGZF7crcXx7jhvpWnqcxuYNX4ktuyvlZc1KhOUcKpxuY6zFV
 sMar3oMGW6toqS2JKeeB0CWI6l0lp6UF92KGwNYyN6MHdAQrCBARUEeGR6eXQPnJcZgQ
 S9OSduZdU+lEWlQSjV02FLPZIzsRw+On8vkC+chnwXnA7osUfuKRXfQAFtupVkJdMAio
 9cz2wzcTzFfsBqhptHBxqCYjBPJ3/C2fAdonDK8asDVi0RAW2R4sLozbtRRSo8xw/aK3
 6+zw==
X-Gm-Message-State: AOJu0YzynGcFwfII852AsmS/Il4hXuwW9NJR09ZjzMO0jJgzwctN99ua
 Sgq/FoPTjVMm7NLlhyp5OK8Y40kWp/bLnKDlDKLPluDbypm8m1aMdmLCyqxjl3GhB5huX4LiEwJ
 1n6jUzABv7AeMS+uG0ckdBCKMWPJymOXg+gk8p7NRzQ==
X-Gm-Gg: AY/fxX5muuAXiDyr00kFNSoOzW0SPO/hibV8r+yMmx3hjA2L0PbLE6dcpmHR8/kDV8u
 lQah5Qmd9RC0mI/JB+Q2pwNqAwaC35vtZJaYZ9xa+mZcCzMNSQeMlUXzyWyy7WN1QEweucRyqhB
 2y4HjSafZeZFk5CPEiAqYAEcnM0FVABt6XoIMBYD7sCDF7VQrd41DJXdWPjOlyagPBdzcWaRGPK
 jZaatipefJPIQMu7aSdL5ljqtf98hSGcgBTgStq3+EcOc6Np4224ao1Ou1i5Ifpn4oMxfGASooE
 sSu6BOTIYwzluIY7eP4wEnbaw70NXCnKd9ay4h9dRKbqv0gkxdN9ojthWHfS32Aj1UW01kQ08bB
 o4yz86xfn0MXVtPXJ80wyRsTwVuR+084KSW9mSSGlQ2fNTgep0XonKghH23CdhtA/RGpkVAg12Z
 NVwRls6eTcxBE2FOm5KKlirXY3woh+bm25LpAS6bVzBgBS+myv1GPUJNqRaXljY7I5Tqo4Ba/BA
 giNW64ZhiTCn+qHW6676Azqh/he0LkHAX2KF1feT5dkmlDmKok8osy0EIzWRT0R0c4888YF6NOq
 BkAmdzdh3MteREP33kAnpIVlQr/xIOuZ
X-Received: by 2002:a05:690c:2702:b0:792:7329:b294 with SMTP id
 00721157ae682-793c58ffe11mr21529137b3.30.1768557005470; Fri, 16 Jan 2026
 01:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-9-trini@konsulko.com>
In-Reply-To: <20260115222828.3931345-9-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 16 Jan 2026 11:49:29 +0200
X-Gm-Features: AZwV_Qj6i_opZl9TviHrIJToj0orFHmKAkxkD6metEgqgxB01yL3vLwAOPTYdNo
Message-ID: <CAC_iWjLcHA+Uin+NDLTMdVORC7eYiQVxgJDKupZgQg8bppsw4g@mail.gmail.com>
Subject: Re: [PATCH 08/10] riscv: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, Leo <ycliang@andestech.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>
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

On Fri, 16 Jan 2026 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Aligns the final section before _end (for U-Boot) or _image_binary_end
>   (for xPL phases) by 8-bytes by adding '. = ALIGN(8);' to the final
>   section before the symbol.
> - Remove a now-spurious  '. = ALIGN(x);' statement that was intended to
>   provide the above alignments.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>   aligned we fail to link (and explain why).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Leo <ycliang@andestech.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Rick Chen <rick@andestech.com>
> ---
>  arch/riscv/cpu/u-boot-spl.lds | 4 ++++
>  arch/riscv/cpu/u-boot.lds     | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
> index 0717833df556..35de28db8f3a 100644
> --- a/arch/riscv/cpu/u-boot-spl.lds
> +++ b/arch/riscv/cpu/u-boot-spl.lds
> @@ -43,6 +43,7 @@ SECTIONS
>                 __binman_sym_start = .;
>                 KEEP(*(SORT(.binman_sym*)));
>                 __binman_sym_end = .;
> +               . = ALIGN(8);
>         } > .spl_mem
>
>         _end = .;
> @@ -56,3 +57,6 @@ SECTIONS
>                 __bss_end = .;
>         } > .bss_mem
>  }
> +
> +ASSERT(_image_binary_end % 8 == 0, \
> +       "_image_binary_end must be 8-byte aligned for device tree");
> diff --git a/arch/riscv/cpu/u-boot.lds b/arch/riscv/cpu/u-boot.lds
> index b11ea8b56d25..c299c00fa298 100644
> --- a/arch/riscv/cpu/u-boot.lds
> +++ b/arch/riscv/cpu/u-boot.lds
> @@ -73,10 +73,9 @@ SECTIONS
>                 __dyn_sym_start = .;
>                 *(.dynsym)
>                 __dyn_sym_end = .;
> +               . = ALIGN(8);
>         }
>
> -       . = ALIGN(8);
> -
>         _end = .;
>
>         .bss : {
> @@ -86,3 +85,5 @@ SECTIONS
>                 __bss_end = .;
>         }
>  }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> --
> 2.43.0
>
