Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8E3C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 18:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4B2884AE;
	Thu,  9 May 2024 20:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pFtPUYYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25864884B1; Thu,  9 May 2024 20:15:44 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A898822D
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 20:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so285512566b.0
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715278541; x=1715883341; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJo+H1H2kMY/mRP+Ufr6EX/xCAkb2XHOUr02qpCr1Bs=;
 b=pFtPUYYcVCWYTUyAl4O5bRPcKWwHQiCxhH9qvB0byJqtZqaSsX3DFcfKrMapmM2TtB
 eMPyb00b1sOwKZMIaBRhA5vThKk2XafPGGa8xK4bAjgM2u+lVEgCR5on59CPQOFMslLE
 8esMom2nSe8dYU4i0BLie+mh2FUwU6YoWIpNGSh3BmSF7JPlqRL7yG68sx9xK17NAlJV
 rUMg4luDK3pDewOwGD6kIoaMPiuWD4RyUwmeMJyryOGk95QWBsu69Trgg9B7bJKUjYe8
 ClwjORXi+aOdoPOv1kXE/4vioCSRlOBm//0te8JOKv/GLuuGQbvdp3picfhhT3RL/KXj
 DNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715278541; x=1715883341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJo+H1H2kMY/mRP+Ufr6EX/xCAkb2XHOUr02qpCr1Bs=;
 b=V/SDm2J0iJ97PB1zpyHPAMeevPS355BJuWjpdpyz8DMqtGTVQxLlpWbWkN6NjCaa1m
 czcLzgn2XQu1I1919wKismjx0zYQZhKjS4YyNoC+rBp/qJ4JnHNq/5dEKmPQKzUsVTpj
 itZ8MH90dE7vbxOj61mOY+y8pg3YlPN+0p8eYxRm7IF01UjGxbkok/vD6i7XlHxZvDSe
 LSXbcvQ5RCSbYhUNyA2BubEsTiuGf67kZjAfDFHvYaZ+7IDcrCrUKe1TnG7IBkNo4IYq
 2NeKFp+NTR7UvqBLBHnlDNLiOFlFfpLFBPPvPut9oAMtKDcM7RnxR8Cy7cEM3ysU4csF
 5rBQ==
X-Gm-Message-State: AOJu0YwRMJecQqv7clvdKh9dQFUAa1eGtxW+EkuJXVhgGC919MishU5K
 aBH1uOcCAulMTHr/TQ0UgLZp/8zJc+ghxrwUhLjl7E/nO6BWktRaWYby2XIAs7G3X3TGIpz2nGg
 tv4Qdm7gctmoc4oLjdf2ZjmXLgrXMc7s7t3kVOg==
X-Google-Smtp-Source: AGHT+IEJF6Vw3dci43Gn8+wch4CIFAjQboGyqhq9eAOr2FfmZxGaNKxpaMU+uH5zUJa6xDuDUk16oi2KddrSftFXIUs=
X-Received: by 2002:a17:907:d22:b0:a59:aa9d:3142 with SMTP id
 a640c23a62f3a-a5a2d5cb794mr29229666b.37.1715278541111; Thu, 09 May 2024
 11:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-5-raymond.mao@linaro.org>
In-Reply-To: <20240509143743.1496210-5-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 21:15:04 +0300
Message-ID: <CAC_iWjL+kbQLG=QwBGfrcRpFU3bhCCcyXLCtwxdY86JcC=0Kmg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm: EFI linker script text section alignment
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
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

Hi Raymond,

Try not to post the same patches without the fixes that were asked
[0], at least not without an explanation.

On Thu, 9 May 2024 at 17:38, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add text section alignment to fix sbsign signing warning
> 'gaps in the section table may result in different checksums'
> which causes a failure of efi_image_verify_diges()
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  arch/arm/lib/elf_aarch64_efi.lds | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
> index 5dd98091698..bffd9a0447a 100644
> --- a/arch/arm/lib/elf_aarch64_efi.lds
> +++ b/arch/arm/lib/elf_aarch64_efi.lds
> @@ -28,6 +28,7 @@ SECTIONS
>                 *(.dynamic);
>                 . = ALIGN(512);
>         }
> +       . = ALIGN(4096);

This is not what you want. There's already an ALIGN a few lines below
and you must include the symbols for _etext and _text_size.
You have to move the rela.* sections after the alignment. IIRC those
were inspired by [1], so you can look for guidance there.
On top of that riscv will need similar fixes (and any other
architecture that uses those)


>         .rela.dyn : { *(.rela.dyn) }
>         .rela.plt : { *(.rela.plt) }
>         .rela.got : { *(.rela.got) }
> --
> 2.25.1
>

[0] https://lore.kernel.org/u-boot/CAC_iWjK+14L6mEi8GQN-McF-SChvhnjJ79nE1tWLV+kgWZKVew@mail.gmail.com/
[1] https://git.code.sf.net/p/gnu-efi/code

/Ilias
