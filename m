Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A38BC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03AD68496E;
	Wed,  8 Jul 2026 18:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eiNzRXQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E0E849F0; Wed,  8 Jul 2026 18:27:52 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D7F2843B6
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-7370ea43b9cso14359137.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 09:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783528069; cv=none;
 d=google.com; s=arc-20260327;
 b=CJVGXb9LgpVqF0+AUIspAIzuP5xtuam+XoEQ8y4ApI7Nro8SlawTzNRVB+fgsmkLvY
 A9nR71JV1WJ1sRZQlxSuGJwVEzaAJCmJoQGGpN3IEP17Ho3YRYesDDcYqefWKvCBm+1Q
 ld2fp+LDjWZsQmI1YSo2ScDbzBcn79ROaBYrIWDnLgtanjbCnUNo6vdJQ0r5JpbFTvIn
 idh2BsvPdMu9ZcaAspAPDp/EKLEWoy3i1bg9m27O35i/DYIUTAeIqJk0O83zI8Y0Kgym
 sQjRmHt1KH6G9wMa1yhJJs2OZtaMrgkAu5Xat47QyjXgSNASyCLsPpqI0xI0Q2plyUwk
 LoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+G3UW83yYgmZZMzqUwnYRcV/zkxyA2vEFlMKnBkWKSg=;
 fh=LZbEPCewkc/qeyFMw6h0MLrH/Dob+uA1NY7zcWWyQgk=;
 b=R+nbRgjqSAr3SdYU8cKe1twraMXyuSqsfNurh7QDC4Eh6hz581UfOh47P5Ftgj6PpH
 M1eHjKUoql1U9rP+6nVDI9cbw8QxLuLizfpeFD9kvy6nBodhoT3dluO6KJeZp1PWuU6Y
 zIl8QmvhUDPSJAQxQKPGLAavf5egtyA8TVbHl/vo4S3qGeHIusTyQ334+geVcT3tZyJR
 ZwJ9T/ac3PbVG9aX6BesYU3+iZdP1YKF1n0XNq8c4kLeFeCCYyJocnhY44W4yMb5rKw+
 APzikmTIe1kN5NMpwsWq9mVeV4Lj0taMVQfxj37bkkjlnVjnuVTBdrgtyQrQ/AdZ2h8R
 h+Jg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783528069; x=1784132869; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+G3UW83yYgmZZMzqUwnYRcV/zkxyA2vEFlMKnBkWKSg=;
 b=eiNzRXQprvZzhb905A94yDLisd/MGwQA3MdFrKhFFPRgbW7vWa1KpkDRjONP6l7f8f
 X2GEkPcoPCJeNbKqfLrM7I3uj/qkhoLv8R82OETJGST9MDwghOjrKZHz+GI6CFH/A3tq
 X9Lrsr3WwD+GHQ7VDsHZK8IrxYhk2cYxdgPZE9ipXdJ5nEnOB01/2zJTT8EzbXmxCZky
 PZ7yitjy1lKjztSL6FrPsOxrEU094YAF5+Ffk+GBhUYQQ5uyGQgT41j0Z6mlU1A/diQK
 aH/9ydwG8gna2zeOGb0Gtdol8t/fC3IUo0Wp6uZxW69oJIYG7QfSuIcJFysQ4kgSt5tW
 xpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783528069; x=1784132869;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+G3UW83yYgmZZMzqUwnYRcV/zkxyA2vEFlMKnBkWKSg=;
 b=KAepldkptoVMxJnrti20sTIV6Mkn8Fc/kMETwo8sKq0BpVe57yt11RugskTRZil25G
 7S4ay2bop0RkiTAFS1ja56yp0dZSmg4qphuS2MBLczdnc/p9owifISRNVlqz1QwLZpD7
 ZH6HI8clDG4E1l1//W7bYX39YtjL5YRJXdu6U2HybTMIMq8mfZXHPGWz/41tjbWG+XIu
 UM2dh+h2C5aDMhNfoENTBi2qMSsl/WkPc+14tLJ7n5v9lVmVu5O3UwggDHuzaCuS+U9Y
 xkADbs8HCzPRxnllpXyqMdjJKw2B9dW7BkkrRzprsOMi1n94JDX/amNkm/UfsNj+9/lK
 N9tw==
X-Gm-Message-State: AOJu0YyV1Aq2Y0oK7gVDcPhoJYPPkrVvwUKxZ5DGK/u9H9m4cEwTh5t8
 z2DUu85Uax2lWlOwbl3e2Hn7PKbl9tG27wnv/TsLv0JREyjzVBQhkK3qK/c1kU+YW2wJJ5+Z/6M
 Q5DIiKgeQv/gKjHiHSV+9JhcgGx/Lhbw=
X-Gm-Gg: AfdE7ck/57Z9aBDnxwZbemFfrw0dn0rokThbu64CtGJ4lnpcpT7tnQCf1HU34YLmYKK
 hQhvwle7c5Y9FIVya3sU7PzACLAqYrAoBrre9FxjvFB4R3mSWVOUwgv1tqRiJgB+EGsALmj4HXN
 CB57cM44bxtWm8ZPUQrxQiPvVzsh3NDPbSRKT8kkPKHOf12MdJQxIQXgA6UOY8Mxp87kHe/Ir1G
 Ias2jJG0xvZz9NYGwAuh035EtObTij+8MzJ2+yBDdR+vbFXjchFu2oC26HEK67ZHyhJkBz76zN0
 OdCcmkc=
X-Received: by 2002:a05:6102:5492:b0:73e:bba6:bd59 with SMTP id
 ada2fe7eead31-744dcbc8ce1mr1989605137.3.1783528068854; Wed, 08 Jul 2026
 09:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260708013019.288985-3-trini@konsulko.com>
In-Reply-To: <20260708013019.288985-3-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 8 Jul 2026 12:27:37 -0400
X-Gm-Features: AUfX_mya4w0x7hDlF8pvJLigV9juS2OYlwq_je6dCVsFMb5JC6iK6kMv1t1kGaQ
Message-ID: <CAMDkj5zYbRL3u6iUKt11Kn+RqDGVMjGcAOpEWt9k-oSR8smy-g@mail.gmail.com>
Subject: Re: [PATCH 2/7] vexpress64: Correct CONFIG symbol logic around device
 tree passage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Feng <fenghua@phytium.com.cn>, 
 Linus Walleij <linusw@kernel.org>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 7, 2026 at 9:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> When we don't have BLOBLIST_PASSAGE_MANDATORY enabled, then we're being
> passed the device tree in some other manner, via OF_HAS_PRIOR_STAGE.
> Correct our logic around which symbols are used to guard what is
> generated / used and when.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: David Feng <fenghua@phytium.com.cn>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Peter Hoyes <Peter.Hoyes@arm.com>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  board/armltd/vexpress64/Kconfig      | 2 +-
>  board/armltd/vexpress64/Makefile     | 2 ++
>  board/armltd/vexpress64/vexpress64.c | 4 ++--
>  3 files changed, 5 insertions(+), 3 deletions(-)
>

Sounds good to me.
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Regards,
Raymond


> diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kc=
onfig
> index 49c7fda0b83a..a988c7198498 100644
> --- a/board/armltd/vexpress64/Kconfig
> +++ b/board/armltd/vexpress64/Kconfig
> @@ -31,7 +31,7 @@ choice
>  config TARGET_VEXPRESS64_BASE_FVP
>         bool "Support Versatile Express ARMv8a FVP BASE model"
>         select VEXPRESS64_BASE_MODEL
> -       imply OF_HAS_PRIOR_STAGE if !BLOBLIST
> +       imply OF_HAS_PRIOR_STAGE
>
>  config TARGET_VEXPRESS64_BASER_FVP
>         bool "Support Versatile Express ARMv8r64 FVP BASE model"
> diff --git a/board/armltd/vexpress64/Makefile b/board/armltd/vexpress64/M=
akefile
> index b0dd1d0af879..5f9dc2af930a 100644
> --- a/board/armltd/vexpress64/Makefile
> +++ b/board/armltd/vexpress64/Makefile
> @@ -5,6 +5,8 @@
>
>  obj-y  :=3D vexpress64.o
>
> +ifeq ($(CONFIG_BLOBLIST_PASSAGE_MANDATORY),)
>  obj-$(CONFIG_OF_HAS_PRIOR_STAGE)       +=3D lowlevel_init.o
> +endif
>
>  obj-$(CONFIG_TARGET_VEXPRESS64_JUNO)   +=3D pcie.o
> diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress=
64/vexpress64.c
> index d68da0e3d650..8b6b96d757d5 100644
> --- a/board/armltd/vexpress64/vexpress64.c
> +++ b/board/armltd/vexpress64/vexpress64.c
> @@ -97,7 +97,7 @@ int dram_init_banksize(void)
>   * Push the variable into the .data section so that it
>   * does not get cleared later.
>   */
> -#ifdef CONFIG_OF_HAS_PRIOR_STAGE
> +#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
>  unsigned long __section(".data") prior_stage_fdt_address[2];
>  #endif
>
> @@ -150,7 +150,7 @@ static phys_addr_t find_dtb_in_nor_flash(const char *=
partname)
>  }
>  #endif
>
> -#ifdef CONFIG_OF_HAS_PRIOR_STAGE
> +#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
>  /*
>   * Filter for a valid DTB, as TF-A happens to provide a pointer to some
>   * data structure using the DTB format, which we cannot use.
> --
> 2.43.0
>
