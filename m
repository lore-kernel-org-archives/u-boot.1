Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56685D729EC
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 17:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16618941F;
	Fri, 29 Nov 2024 18:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U3MdRGo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156F489461; Fri, 29 Nov 2024 18:26:24 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E0D089410
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 18:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cfa1ec3b94so2282036a12.2
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 09:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732901181; x=1733505981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A4T8+nnbNrcNKl6tJBaPS2u3PRW8Oz6Uu0xPne8+U4c=;
 b=U3MdRGo6eus3uelV6Y4pHbZ+cnZNeNvEbrw7fyhralUANDsHsuwvF2hOUz8uuFlcxi
 W/l0slF3rSG4sKXzl4jNtzEjq+mcK67AdKrUOCe4p39rF9ZSq/qsj0MxW1LC6sH8FFIL
 EpSKb0TmtBVntUV6+IrpYdYPBhTZpg0OyY0UvJBpLAKl2OInuQpShbNewU9fN4Yo1a3Q
 NuMXWl0/Ec+AVkSSFl7194XMWj6eobmBnaMneSow0OkzU2ONVvi0Wvc56HigmAcLaaiI
 x3kc1jfDUzGOeZBO0Efz2EHxk5Pzn1GtOEzlc5Y8fAC8BD48Oeeoy3yRzi7qG5yPqCbS
 6cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732901181; x=1733505981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A4T8+nnbNrcNKl6tJBaPS2u3PRW8Oz6Uu0xPne8+U4c=;
 b=UOFxyXq1XsDBl6eci16rPGKCHWrM+unD2U1TRC8OAMRqPuiKjhnhhRs574mW+lYcgL
 u84p3WPUpJ02eYqMVYv4qd5Y5mZij47Z2YLF9gpWu7al24LArULvfCn9jUj7DsdebqfQ
 +tkfEH9etSxoB2x4+R/mzdPaIIbycrIbFyakJkIFUbfiJL0uCiOYlMhu5meoNvKqLhMO
 ZqzLBEsRAWkLbZZFoiLxKQPhix+ddSFlrBCCBC9XTA20nPVGo6rTmBZyN843JEXkrv62
 w5hKGPyvpkaLrxURuKbpjV5pTntwOkxJXxvkZcOsGIviPpSdPm5N4iI5sd8cbUCCz8Ja
 DWSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnAQ3ZbgZmH6Doj00s81gDoWFYnprTYi5T2GnF0sy6303b+KBpyAPC2RNCkSR7Uvjg7WmWigA=@lists.denx.de
X-Gm-Message-State: AOJu0YwZs0wMg2Jje/ooGZE9lHWlJyqLZNdNaVFPXOdpmkqp9T4lc3oz
 AI43OALPYrOdkeqPGR8nC9AHBAiFALXWNVHFo0a8SagXZ4EJ3lOagV6idx7fX3lHVNOZWEjdXnG
 L9yO16R2Jv3GFbY9mSOvph+sMPzYv9s6q5cbGjQ==
X-Gm-Gg: ASbGncsV8AonRLsX2teQo9RtICy2YglbPbEMgyJ2ggcE1Digu5BBDqjMPa2usi/QCrq
 zAMm+j6Bnfme2ZfaOd0d1eBx+pLhp+ahn
X-Google-Smtp-Source: AGHT+IFOPjeWddUVBKI+WyUA/zZZWEEdXDxTlyfh+WR1Bty6DnuiZgqo37N+xJKdpwYDIS7kZ1g9r0jnyJy39iN0VZ4=
X-Received: by 2002:a05:6402:5002:b0:5d0:8f17:eb1f with SMTP id
 4fb4d7f45d1cf-5d08f17eda2mr10606999a12.32.1732901180813; Fri, 29 Nov 2024
 09:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 29 Nov 2024 22:56:09 +0530
Message-ID: <CADg8p97prO=W-Qx2vqwZCnHFXhLvw2dy69UEB9f2rMH3CNZpPw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Add U-Boot memory to the EFI memory map
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Fri, 29 Nov 2024 at 22:38, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> This code was removed when the EFI subsystem started using LMB calls for
> the reservations. In hindsight it unearthed two problems.
>
> The e820 code is adding u-boot memory as EfiReservedMemory while it
> should look at what LMB added and decide instead of blindly overwriting
> it. The reason this worked is that we marked that code properly late,
> when the EFI came up. But now with the LMB changes, the EFI map gets
> added first and the e820 code overwrites it.
>
> The second problem is that we never mark SetVirtualAddressMap as runtime
> code, which we should according to the spec. Until we fix this the
> current hack can't go away, at least for architectures that *need* to
> call SVAM.
>
> More specifically x86 currently requires SVAM and sets the NX bit for
> pages not marked as *_CODE. So unless we do that late, it will crash
> trying to execute from non-executable memory. It's also worth noting
> that x86 calls SVAM late in the boot, so this will work until someone
> decides to overwrite/use BootServicesData from the OS.
>
> Notably arm64 disables it explicitly if the VA space is > 48bits, so
> doesn't suffer from any of these problems.
>
> This doesn't really deserve a fixes tag, since it brings back a hack to
> remedy a situation that was wrong long before that commit, but in case
> anyone hits the same bug ...
> Simon sent the original revert in the link, but we need a proper
> justification for it.
>
> Link: https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
> Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Like you mention in the commit message, I don't think it warrants a Fixes tag.

-sughosh

> Apologies for sending v2 so fast but we need this in for the release
> Changes since v1:
> - reword the commit message and fix spelling
>
>  lib/efi_loader/efi_memory.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index e493934c7131..edd7da7d8c6e 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
>  {
>         unsigned long runtime_start, runtime_end, runtime_pages;
>         unsigned long runtime_mask = EFI_PAGE_MASK;
> -
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
>  #if defined(__aarch64__)
>         /*
>          * Runtime Services must be 64KiB aligned according to the
> --
> 2.45.2
>
