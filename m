Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD810C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 06:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 458F382EB8;
	Wed, 13 Aug 2025 08:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gfa0IFVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57696831BB; Wed, 13 Aug 2025 08:21:17 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD13E82E34
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 08:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e8e1ae319c6so5011686276.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 23:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755066074; x=1755670874; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l0XsqmjKzY9ukhYz+FkYsE6XLbVEDfw5GURI9XWWlHc=;
 b=gfa0IFVr69dC0BGVNGW+w9AvhY4W35Rw2/VjzLM2EGngYKVBe0+iGBlsbw2ytkWQcy
 HvvC1FwJb577ejCkWxiVJhL1VDACBLyDV0TiHqjOaOEPkkzCQKNQAleASCgyqEWX1i/L
 BPbo8ToZSq0ZOqURuRucJhHS6z6fJ2U+AIAv+UEIT0ladtWWV+9C7SmWwhHhpmq/U8zn
 t6CrnvK1R5T4Z31YEjVKRzr7zE6ibS23d77BNmeWMT8sv4EnyzWIB9euvoA+PUuadgQS
 UGtt7sP9rljBgTOFcZN4AiFmLoMWiEH9ixJn6C9pdW9EnHT+rg74XJ+MGQQ8EAqZszzc
 dojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755066074; x=1755670874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l0XsqmjKzY9ukhYz+FkYsE6XLbVEDfw5GURI9XWWlHc=;
 b=HGAl7XJt4PVSQHBGjC1CVP/AmiFDp++lbp5hhJcNfti9YnPXnReB5u0x6r0OzM4Z1p
 a7NKtJoxRazfx8556PqVql0DR4DaKXsghfdfVmXeCPniF6coYcnm7S6yMzwN6GRqGDm8
 NDr1CBigPm7ydeFqsSM70VbWbiTm0fIXbQZnn3OzlarhtTnYZ69UkXeEnnIi0BNjeLl2
 zxifo5Bj7YsMjbVBjykdI+HtHBhksAVIyRoyYpODdgnHx/nLAHP9qaKNoqrUvIi6XEwR
 ZQiaw4+tMeIKmYEYgjLm+p7lIWWDqIMADy3ZxBFJgaPiZVzn8o8UkSzFmij3igNKQnce
 +fig==
X-Gm-Message-State: AOJu0Yy0Nej5Rq7DRVYWbtkJaTDvKYuFYKG0F0l8B76vbt6eE5hLuNvb
 UvWnhdxZkbsjU58FaMYvIDw1tboHXx01IFd4xXKn2W5sDJpSzEOubBj2bI++GvqW2nJ3epFCW/5
 e2KiiyBX2kHJJjSa9fGJnExnocOga0GqsBZyMkRqbUQ==
X-Gm-Gg: ASbGncuZ6BMD0U13UCKn4Kwrc8jIxoWOgRN7Z+gCYQDCOR9fyNB7te1yNzjLQnBcs9P
 OmF4mJUjLYc+Bi8URhhYsesa6zQt10ioxQJZKWiHsVd3YBc6uMWqYpgU7KR0Du0+J/hEmDFtVPT
 Psz1SR6ll0dRpZThCn1PVm3l9Nt4ObPAKMEcGudDkMF7F7CwAFhmJuxAeO94K5xcLP1csL/gzOW
 WERAJBe
X-Google-Smtp-Source: AGHT+IGKk2bAnv/bZgo+HxWyLizPc3dZgLjRa9kAiYURNIcT2xfpPo4t6PQ05iOSQD2Y2EDFzStQA0IooUmTy29KcDI=
X-Received: by 2002:a05:690c:6511:b0:71c:1395:c8bf with SMTP id
 00721157ae682-71d4e3f6182mr20498947b3.4.1755066073686; Tue, 12 Aug 2025
 23:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250812180132.3057893-1-trini@konsulko.com>
In-Reply-To: <20250812180132.3057893-1-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Aug 2025 09:20:37 +0300
X-Gm-Features: Ac12FXx83oxKu-ONUc3nG_ZBn3TbaP3MH3qSG9R7sdNsE0nziW71aODgg42B8UE
Message-ID: <CAC_iWjLv5YQEe=p80c4Wn5Bnm=wTqK5+_o-KWYUVHMBaXdxxFA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Make EFI_VARIABLES_PRESEED depend on
 !COMPILE_TEST
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 12 Aug 2025 at 21:01, Tom Rini <trini@konsulko.com> wrote:
>
> When doing compile testing build we cannot rely on having a valid file
> for EFI_VAR_SEED_FILE to exist, so disable this option when doing
> compile tests.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This was found when working on "allyesconfig" and the issue is that the
> file in EFI_VAR_SEED_FILE will not exist.
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c2aa88f59fbb..a7092c2e8a8a 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -195,6 +195,7 @@ endchoice
>
>  config EFI_VARIABLES_PRESEED
>         bool "Initial values for UEFI variables"
> +       depends on !COMPILE_TEST
>         depends on !EFI_MM_COMM_TEE
>         help
>           Include a file with the initial values for non-volatile UEFI variables
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
