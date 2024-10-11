Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB956CFD30C
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A3A886DF;
	Fri, 11 Oct 2024 12:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W8qbfBxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4328899C; Fri, 11 Oct 2024 12:22:15 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0AD8837D
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b8be13cb1so21065665ad.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728642132; x=1729246932; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3AQdicwSVNNjO/wJv8yG4y9ma6F1LyA/Ak+bd/NX5Zo=;
 b=W8qbfBxA+nKkM0fzkEXLo5F2WCpTsOuGuwpXQtDMH4e8ETcUcifTLX6kcRSdPZtXNN
 Zv4J9sSTDrqMimcbZjDP4UK6v6jEYTAnqciH8Njv7OWU5aapokL8jFjiOLG+DA/8bf3E
 f/FEc4pwIXHH0GC3IgCnhSghYfWNbNBignBV4+EghTTScJvgRit+tikDfKzm24MJznNy
 STUJZDUOAoqvBu0G17DyinHozirDJe6sV5J9x0TTxdKhBGU0A7TVOVsL2D5JLzMaaRrb
 k1O9fCMMp16UqN/D6+L1sm1cbsuPIBOkNguwZtiU0Y0mdSjuI9GvLNtmt4t8dEBmnjT7
 QgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642132; x=1729246932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3AQdicwSVNNjO/wJv8yG4y9ma6F1LyA/Ak+bd/NX5Zo=;
 b=vOYVstH5/74c3fV2qZ33sQ+Azg/7aa6hq5dijBOnT4epb+bLVAwQbh0kTprFQHPIF3
 hAVe9s9sWGMEdls69tTOEWcaxmztSodnJkVLZSpvMdA/qRv15vqo9ZbiUuWwG+nGmBPR
 ofDGv3YOIzDJ0sHtcxZZbj1S4sEcMz82K7hG4BiqXBOglKzjRC/1YYUEbjT8B+lv8Qvl
 +l3nrFJ29RlQYG5kXZ5TrHzifiXDtXVBrI8j28lLhx2Q9092FjAwitoKgP4uvgKPQGlV
 a0PJ2KwpfJm2AinflhPdfGh3gdYijYwlhu0iQx9xihzP01/GPjySXDmeOITIVGPpU/uO
 NI4w==
X-Gm-Message-State: AOJu0Yw6n6Y5genvdGne2qHurQSyW/UDNDuZFbbtKdTvUEiusIpIUiTh
 yiBlpMtFiqc/T7JnDJWF3jdwhWOaLu7mYjIS8aGESqXk+y3ZUMkIeNzWm9qrm8Zpj2JtZikx5R/
 qYAKjiZoxq0Bqnrxe8Bo2btulDfhWHvRfJaU7RA==
X-Google-Smtp-Source: AGHT+IFxmOC5bBLPj188ZfL+H2hN+wP1KcjYScVwf++xVsgmig0oPkUONP7SVjGhwSsbfO1Og/vBdxqMV05/NcmTl34=
X-Received: by 2002:a17:903:2301:b0:20c:7485:891f with SMTP id
 d9443c01a7336-20ca142d189mr40853525ad.14.1728642131968; Fri, 11 Oct 2024
 03:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-9-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-9-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 13:21:36 +0300
Message-ID: <CAC_iWjLDtFCCwL8+mSwyUN8HbeuKw9W=eJSqA6PQFuT_oOEz+Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] stm32mp: remove efi_add_known_memory() function
 definition
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The efi_add_known_memory() function for the stm32mp platforms is adding
> the EFI_CONVENTIONAL_MEMORY type. This memory is now being handled
> through the LMB module -- the lmb_add_memory() adds this memory to the
> memory map. Remove the definition of the now superfluous
> efi_add_known_memory() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: None
>
>  arch/arm/mach-stm32mp/dram_init.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
> index 198785353f1..3698fc49bf1 100644
> --- a/arch/arm/mach-stm32mp/dram_init.c
> +++ b/arch/arm/mach-stm32mp/dram_init.c
> @@ -86,14 +86,3 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>
>         return reg + size;
>  }
> -
> -void efi_add_known_memory(void)
> -{
> -       if (IS_ENABLED(CONFIG_EFI_LOADER))
> -               /*
> -                * Memory over ram_top is reserved to OPTEE.
> -                * Declare to EFI only memory area below ram_top
> -                */
> -               efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
> -                                  EFI_CONVENTIONAL_MEMORY);
> -}
> --
> 2.34.1
>

TBH we should make efi_add_known_memory() and remove __weak in the
future, unless someone has a very good reason to keep it.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
