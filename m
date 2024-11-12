Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2A8D42B81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8AC89431;
	Tue, 12 Nov 2024 14:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JY/sEXQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D64389431; Tue, 12 Nov 2024 14:45:43 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58834891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c70abba48so54635555ad.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731419140; x=1732023940; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6zU2rcpbffTDiC1DJJ+qLQozugl4FfC8cDwuzqNs9Ko=;
 b=JY/sEXQcrMmcgZgcrOaAXNmKe5T/XgXTAxjedMG5mDkbpG6nlhC2UfTJXshyStblta
 Nrf3m+dnEjxAbN6Q3C4giGnhASL6YS9tvOqhl+3oKWcTe7TSo2gqZsTn+cBvwPubsGNm
 Chv8tYITnufMy6QidwAv0futfVHe0wBiSSbCggOShGBvJNp6gaL2g6DuCq6SOjd9YRz6
 4i90Vx2diH8qH7XyS0iN5f2Zyrjt2c2McSonDBRlBF0RZH8Q/zFFbEFGH9B5aRcXuGmq
 cS9rWTdtnz3TKvCBYOBk29fB76Y55P/kwLibDR805gCFweo59YlC5wHu6Kz1y9mJZ878
 4jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419140; x=1732023940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zU2rcpbffTDiC1DJJ+qLQozugl4FfC8cDwuzqNs9Ko=;
 b=eLfSOJDGLInuKXe8xiM7eRKBVzt3ZGWjcaPJV2VRFPfmdoDLLDX6aoeWw3y9+eUkN8
 S/v0QP4FCXjOr97wuSBC9GipytiYJLda8O/Xih+RLPz1Du2d51QQFhdmM3MjpNyWewUo
 t25ldp/YQqVOYjTCErRXLLANxO9ydJlgp8iW0sR0yNhmvUDkzjTGijOevOBCq9HXxf0H
 0s2bkIUZ6/LdUzOfsNjZ4APFOeKRWWesr0HIxr6ev1Hwt5jW0esADULqYIgmOlPFF6wL
 3oiJvnNZyHbklOF7ZQcvO8gMnWpksPWWaz+gQJiD14UT8nyGSawWluQCqTCRL7Os81n4
 KBhg==
X-Gm-Message-State: AOJu0Yy7yjTDi+0qZ5HNZLMOaP37uuxwyvTdyUR9ARMe13K5W1ua0XLM
 qRegBLocfhMm32UHZHpZyZeuzUSzzT63eq8MXFMJh1+M3Hl+/V1RS50Y2HlgHAIkEsipYKN8uSM
 f4VAuLwczbqNV3b71z3LvlTL593PP77vsxjo3eA==
X-Google-Smtp-Source: AGHT+IF12ptPKCNKsCBq8WOCUCfkN4nqH8201v98TgHg6hi0DIBSybsbFXrxA3ZiZci6RBBrwFm2IkFDpshrBXS0zaA=
X-Received: by 2002:a17:90b:1c08:b0:2d8:3fe8:a195 with SMTP id
 98e67ed59e1d1-2e9b16ea69bmr22214153a91.4.1731419139856; Tue, 12 Nov 2024
 05:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
In-Reply-To: <20241112131830.576864-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Nov 2024 15:45:03 +0200
Message-ID: <CAC_iWjLOsWZU+GLGYT8VyiuHOmaYg3mjb4RRSEFT5aKpn1tu9g@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon,

On Tue, 12 Nov 2024 at 15:18, Simon Glass <sjg@chromium.org> wrote:
>
> A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> patch. I am not sure how to investigate it.
>
> The boot hangs at some point during booting of the install image, before
> the Ubuntu logo appears.

Any idea if this is before or after ExitBootServices? The console
prints some efi-stub calls before it jumps into the kernel.
Unfortunately, those aren't preserved in a dmesg

>
> I will sent a series with a script showing how it is run.
>

How can I reproduce this? Run the installer on QEMU on top of U-Boot?
Is U-Boot compiled as an EFI app or not?

> This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.

In theory, the memory map should already be added by LMB. So instead
of reverting this, it would make more sense to compare the memory map
with/without the patch and see if something is missing from LMB

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
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
