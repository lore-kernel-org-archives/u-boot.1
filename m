Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B4DCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673418004F;
	Tue,  4 Nov 2025 16:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HLLDuG9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BBF4835B3; Tue,  4 Nov 2025 16:09:42 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E9E8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-559748bcf99so1205940e0c.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762268979; x=1762873779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=30yEE8CNPFN/zEAjCGtStklYPelBDsCtj6cY1ZjtyoE=;
 b=HLLDuG9VCyUssKajMz7dszf4BA5EQKh+LiqE2pMuNTrS1lBeIGsg1RMrXnPzi4in7C
 KkkRNyxjyOy9lw3hCe//RLr95J4l/o+fKTyDqBWiw+SjAZ8wNBHBuj9JbVYwF9EMM/x2
 kepNd+Oyoyi/A3PyQ9uZtkd8z2GkHpRJS26havNnO1R8hppDrFfNBsxphKp0nnZiQTi9
 gcMq8AkgsOWOX0UT3lj6TrWsX5x3rsHdbGzImWz2xEulWhXeKdIKNfuCUWMw/CB06xZ+
 jN3Go9X+SBUYZFy4sS4vfEGkCVTEVCXJBC7gyxbgsI/kv1VI98pzZt6t+/+rJNFqQmt7
 zzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268979; x=1762873779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30yEE8CNPFN/zEAjCGtStklYPelBDsCtj6cY1ZjtyoE=;
 b=DC0CXdCjfbyB+m68SsZ5j9KNGFCapum8bth2644o9Szbqj7+D2l+E9BXOtim/6wbgm
 Lol5SQYEPDBZHRiBzz4DLGGVe56hl9PoNz9SbUtCr3g3pebHgnkv8BpJwbbkNXrntt27
 K7Cdg1JrpMROkXLUT0xKJuatELkqHkpY8H8fjsENqsWAQu6wEDuRXKzWqQSecZ/AfJao
 cEokWKMTemk6k86DWQEHAnHglCCQkNQyR8LfxErxH2ZSafPcwtB+exriNPao1+tiZKO4
 fvIYRM8+tvWv1Z4PKmlPYkKgfDMzfxSNS0IywPWXq0bP2Br1UJsJ1/Ypi0hVmnj124O1
 +k5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoC7AP0nR6W6QdZWv1PP16KugWpcu98wDdCNT3vS4UvCFGvMNQ77GxAvBfgDJy+ySGX0+/RSc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2Paxv/V0edV7Li/8QcX/lJCyG+KuoNZ0ELsz0i7wnZ41iczAZ
 2sQ35onXUgk2frxgQ++IQzG9tFGOQyyv7goW0W3AHuFamKLhsUVfSqTgoXOkicuLorji3KRz/AY
 SU+34xO0z6QhJ9eIulKdCNP462LQnAHI=
X-Gm-Gg: ASbGncsHHVW/9dz55gNigSi2nIwYIoxWPo4SkMor5fF2IaNGDaPWx53gdejUrVMC/qQ
 EXjj/wxiaT0L9ut9Sx22iH/v9j2y6WoayMugf6vBQXXFjdbnknkdBnUr4n3afRhyuwKXNAJOyLw
 t/z2R/29yiFT0R+6hRK6D57f/F39g/4yyqEHCj3b21V/Huw9t8WF1osWtQ0jf76hesOnqN1enkF
 XXgkYNrQqijIC0L7onNbCgMHmpS06WoyiY+KcKt5Kiql+r0G2v0iq/LrVw=
X-Google-Smtp-Source: AGHT+IF2u+OP/gNKX4hrQVNXCJtn9/oZtDh71YUogMJ9/ktdc7MEEyCPQsCa6dU86JWJb8CC69qvLYE0c/J5AQNVCTo=
X-Received: by 2002:a05:6122:d85:b0:537:b2b6:e387 with SMTP id
 71dfb90a1353d-5593e2cf599mr5064860e0c.6.1762268978827; Tue, 04 Nov 2025
 07:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20251104150404.3355422-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20251104150404.3355422-1-ilias.apalodimas@linaro.org>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 4 Nov 2025 10:09:29 -0500
X-Gm-Features: AWmQ_bkQkRb7QWqW40vgaFyIi91vaMg1DSXa0_Sbsp1smTQoJ5LJeI3ewWZigfQ
Message-ID: <CAMDkj5xVvjfLWSfYMn__3e7wV8NgJm1xv2CgnKuRjm46fgCknA@mail.gmail.com>
Subject: Re: [PATCH] armv8: Fix transfer list passing with KVM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, Xu Zhang <423756212@qq.com>,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ilias,

On Tue, Nov 4, 2025 at 10:04=E2=80=AFAM Ilias Apalodimas <
ilias.apalodimas@linaro.org> wrote:

> When loading U-Boot in a low memory address, the adpr instruction
> to preserve saved_args[] end up within the memory space of QEMUs
> mapped pflashes. As a result the following store pair instructions
> lead to a crash since instructions that modify more than one registers
> can't trap into KVM.
>
> This problem can be solved with loading U-Boot with -kernel
> and defining a different text base address. But when running with
> -bios we always start from 0x0. So let's postpone the calculation
> of saved_args[] post relocation, where we will have an address that
> doesn't collide with the QEMU flashes.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/start.S | 8 ++++----
>  arch/arm/lib/crt0_64.S     | 4 ++++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> index 40c342e97e9b..ef335de16b79 100644
> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -387,10 +387,10 @@ ENDPROC(c_runtime_cpu_setup)
>  WEAK(save_boot_params)
>  #if (IS_ENABLED(CONFIG_BLOBLIST))
>         /* Calculate the PC-relative address of saved_args */
> -       adrp    x9, saved_args
> -       add     x9, x9, :lo12:saved_args
> -       stp     x0, x1, [x9]
> -       stp     x2, x3, [x9, #16]
> +       mov     x0, x19
> +       mov     x1, x20
> +       mov     x2, x21
> +       mov     x3, x22
>  #endif
>         b       save_boot_params_ret    /* back to my caller */
>  ENDPROC(save_boot_params)
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index 3e7627aa389b..d6246010f368 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -132,6 +132,10 @@ ENTRY(_main)
>         b       relocate_code
>
>  relocation_return:
> +       adrp    x9, saved_args
> +       add     x9, x9, :lo12:saved_args
> +       stp     x19, x20, [x9]
> +       stp     x21, x22, [x9, #16]
>
>
Acked-by: Raymond Mao <raymondmaoca@gmail.com>

Raymond


>  /*
>   * Set up final (full) environment
> --
> 2.43.0
>
>
