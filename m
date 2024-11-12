Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C49D32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A051D89040;
	Tue, 12 Nov 2024 19:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WXsHtoEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0126E89040; Tue, 12 Nov 2024 19:46:33 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEE78902D
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 19:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cacb76e924so8931580a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 10:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731437190; x=1732041990; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDEC1GhR0VjFKJ0RqKCTNyAg5Z/HcNsRSm7u/vur/U0=;
 b=WXsHtoEI+q3yvDJymS09rQjnJuXfBHS3bdGJbMHnD2qaQ5cYcRLnixfN8CUXcJt4pO
 IbBeAs180/nX68KW06iH1RN5lTmegS6qDXhr6Xa8SJa94cDEgUskAyOEMVEaRGmJM1Ur
 +78o8QDUhjSlAn4p3CDbkWKFzBCHZ75TKzmtLV5aCvdHLA5Nqq9sX53TtJJ4HcNqjpJH
 02tR8TMTC51XjxDS5NTreo++U2/WGiipxvGm4az4TBBWS4jMaxiXjSKMX5lOR2OdFV4r
 TFyzK/zSLPxybmrQehQf4A1fiAfz8ojTsJ7F8ppGAycfrF9ZRaDORnsIWgOseHSY+3dG
 LZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731437190; x=1732041990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDEC1GhR0VjFKJ0RqKCTNyAg5Z/HcNsRSm7u/vur/U0=;
 b=xCFt4iX2ADoL10+NDC1HErVZQfUAvtQ8gMzcr7zv5cm+SoQoObb07Uh6g/BQv7n9GN
 4sPahrTBsR4DdrBCDUi1sbzUvIJqb+qHWlyykF7IrIyZHTlrJAfRaXkVodnGOTq2Ku4R
 Rs5OsIk0tL5AESgENM5lPRibU8+VI142UCkyXZ9U/rMO4Vq9zYvwRTaVydiOR7ydo49y
 RngfrENgC6r3ovOYCxdpQJUcwo29KuZj7gRaUTsOS9AlVES2zVlAVSQF8P9WX+eYlEL/
 WHDs8M2z8qofZx/lxUrVsCW0bAELaa872MISPx+R+3MWo6F3tEUiRMYFwsPicmoCRRlB
 vcHQ==
X-Gm-Message-State: AOJu0YzsGNdOZompm66eBL9B0hLP0cIn1YqXvy6L3NgroHnQTnp9M6fW
 tOwgpogFoRa45yfirOTYWEEMzNdhlnEZkoLNRzl7vnnFDaqKWiHVfAyz7Vhh6ey2SZv4mhQyyMR
 LMsWXNRk2ddfpYkuSLjCNsSV5S58Fawvy1A3Yvg==
X-Google-Smtp-Source: AGHT+IHEQlKKKBhQllGX0NkBoIaEW6z1IwGq8tXOyh9ntxthpFT+goDYeGlF/dL+5prkQygJtozN3XHARE3KUPoLnNA=
X-Received: by 2002:a05:6402:5255:b0:5ce:de18:3fb7 with SMTP id
 4fb4d7f45d1cf-5cf0a4475a7mr13450207a12.21.1731437190421; Tue, 12 Nov 2024
 10:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
In-Reply-To: <20241112131830.576864-1-sjg@chromium.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 13 Nov 2024 00:16:19 +0530
Message-ID: <CADg8p949qx=irjZKgf9-B4wtCYx1pDj29LFH86YR4T1zyKtAvg@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
>
> A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> patch. I am not sure how to investigate it.
>
> The boot hangs at some point during booting of the install image, before
> the Ubuntu logo appears.
>
> I will sent a series with a script showing how it is run.
>
> This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

This seems to be an issue specific to the x86 architecture. The
installation works on arm64 and riscv (confirmed by Heinrich)
architectures. I checked the output of the EFI memory map with the
above commit against the master branch, and the only difference is
that with this revert, the EFI memory map has the u-boot memory region
marked as EFI_BOOT_SERVICES_CODE, whereas without this commit, that
region is marked as reserved. I need to look into this in more detail,
but it would seem like the x86 kernel (or some efi stub code ?) is
expecting some region of memory marked as EFI_BOOT_SERVICES_CODE,
which is not the case for other architectures.

-sughosh

>
>  lib/efi_loader/efi_memory.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index d2f5d563f2a..c7400ec9854 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -809,6 +809,16 @@ static void add_u_boot_and_runtime(void)
>  {
>         unsigned long runtime_start, runtime_end, runtime_pages;
>         unsigned long runtime_mask = EFI_PAGE_MASK;
> +       unsigned long uboot_start, uboot_pages;
> +       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> +
> +       /* Add U-Boot */
> +       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> +       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> +                             false);
>
>  #if defined(__aarch64__)
>         /*
> --
> 2.34.1
>
