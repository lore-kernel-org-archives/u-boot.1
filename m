Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6960C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 06:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B0780BA8;
	Sun, 30 Mar 2025 08:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O08C0jR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F7380F9C; Sun, 30 Mar 2025 08:47:05 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD1F800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 08:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e6582542952so2395432276.3
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743317221; x=1743922021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jL+xCBCA60fuGAbpvqmuODDWMlFZ6NBPduwzULnXXCo=;
 b=O08C0jR6eAFWzw9OMg4s4zwDp7mD+bSYcS2mGKtrT1iOswz9dYLtpgEIJjji13bUFa
 UMkcA/zEtlrYqKNmz6ebvzynqLZOrR/TQhR3HGvnzjbnNWgSCqYQjR2VdT38jWVdsWYK
 jMqCfvuUuUO8YbTABwTqskNbbJ5nJHZPN7bClXMSWD8pzSNnOgav3z0mj+9Qcgx+NVnI
 pFNeuJpAkRRjJBnTeQ/xQT4wUfVylPU2akfOUyhJJ5J2FpF+XDt/W9GHYNrDiVHd2G4R
 3oCEKLm/VlXW2n26AlI/GzLqDdrO6QLzv74/QJLY83cPpx17b6rG/pibw/SAjgdYNFoQ
 j8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743317221; x=1743922021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jL+xCBCA60fuGAbpvqmuODDWMlFZ6NBPduwzULnXXCo=;
 b=iln4FFWNdXgMUeVBxbdEEQ87iquMlRc4eTNfbsvSQhzlaSe8EYMYdifECRvTspbnDN
 SToXpTWtBTmJhuR14gMWeDgizTqNEYwqp7PJLnaDV3YArik7Z+XoXIZUtLR+VXQcy8kG
 zdyBKCnXNdio0iF4DqONC7pArupOhq66wSduU4GcTsdWzMc4MOxl+CXswG3QqYxb9Bl4
 xvxN0xeEGN/TKtZPsoJfHDois4G05HdFTeBspxtiim3kJykXorUgDEPslraQNU+dCgfG
 RNd6oH5MqnXN2E7fAcXg820WMA5n0i+zt28a14FTXSVIZQQEeo7UhyXs1GhiMEtiZ64S
 rTng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbZl2ZokwamQeCivXFP7bAyxssKjB6y6UjaAwK3mxtI1vktF1qj9C/eyJLFKHUKlVO1G4XLUo=@lists.denx.de
X-Gm-Message-State: AOJu0YyHVbAfbfIAaVQNCSMyoeeovtxMzf3PDuJTpY1voMrslku0qSIQ
 v9DhnE9iaTxMjA0aZCkuvtHSG5W1m4bKXGvcdmZ5/ORJVjOARQ5RZ/SbaeXZZRwDXcf9j3c0Sq0
 +XMyMuA3v8yzD1OCuDxPuOYpsxw9u7+XHIN5F/Q==
X-Gm-Gg: ASbGnctmA3whskaM/B/3kZYEo1LsJa8rEW2o5kXLNjXwtV0OQ2ABLDPeJIhDbS6L+Kk
 lw2Gy2F5i+lpxZ6q7Rzw/Ty4sbw2S+w1wqivRdNxghWvxYvgHQ/MXeM/EhEt5+xa9eAnswdwIMC
 Wrfj5WGSI9XGrm/0l2i85nt8Rv9Q==
X-Google-Smtp-Source: AGHT+IHI/MF7Rqil9OXT2mvcCCJJvkbeDTFjqxI5Ne5FSrW8/R5g4+h1pFh93ATfrAvKd8V1/RelkIRC0yQ6gFXCNdc=
X-Received: by 2002:a05:6902:1b93:b0:e3c:9fb5:837a with SMTP id
 3f1490d57ef6-e6b83a96e19mr6543005276.41.1743317221587; Sat, 29 Mar 2025
 23:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250315221813.1265193-1-CFSworks@gmail.com>
 <20250315221813.1265193-7-CFSworks@gmail.com>
In-Reply-To: <20250315221813.1265193-7-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 30 Mar 2025 09:46:25 +0300
X-Gm-Features: AQ5f1JqVj9sZMFK4W4Q0yqeaHo0mj3Iw9FlQG-n9sWAGgGk_ve3S18WJ7a8cZdU
Message-ID: <CAC_iWj+WknqSxPE+W_KN1LS3beNZSMxZC7wnKkQ+P0uLfDZhWw@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: Replace 'adrl' in EFI crt0
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
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

On Sun, 16 Mar 2025 at 00:18, Sam Edwards <cfsworks@gmail.com> wrote:
>
> LLVM's IAS does not (and cannot easily) support the 'adrl'
> pseudoinstruction, and ARM developers generally do not consider it
> portable across assembler implementations either.
>
> Instead, expand it into the two subtract instructions it would emit
> anyway. An explanation of the math follows:
>
> The .+8 and .+4 refer to the same memory location; this is because the
> .+4 expression occurs in a subsequent instruction, 4 bytes after the
> first. This memory location is the value of the PC register when it is
> read by the first sub instruction. Thus, both inner parenthesized
> expressions evaluate to the same result: PC's offset relative to
> image_base. The subtract instructions then remove one byte each
> (low, then high) of the total offset, thereby getting the absolute
> address of image_base loaded in r0.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/lib/crt0_arm_efi.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index 91b0fe12c51..235b3a0c48f 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -149,7 +149,8 @@ _start:
>         adr             r1, .L_DYNAMIC
>         ldr             r0, [r1]
>         add             r1, r0, r1
> -       adrl            r0, image_base
> +       sub             r0, pc, #((.+8-image_base) & 0xff)
> +       sub             r0, r0, #((.+4-image_base) & 0xff00)
>         bl              _relocate
>         teq             r0, #0
>         bne             0f
> --
> 2.48.1
>
