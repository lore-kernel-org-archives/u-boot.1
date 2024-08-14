Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343A8C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4C7889D2;
	Wed, 14 Aug 2024 14:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G4P1FLTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158B9889D3; Wed, 14 Aug 2024 14:35:49 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCCC889AA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso63084305ad.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723638945; x=1724243745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQw143uqoSNTMvi/+ETqt2Owl38KpQ6auVc5y9ukaYs=;
 b=G4P1FLTLX08U6IM+i4Uh0RnVtvJJUQhqZG3tZFMkOvZzepqgR81bj50Qdn1Evp+lqr
 hs0k5F/HmlQlI76o3hXuxGcXew+PdDqNzVZo46XUDqSJVOBpQDellz6XYmSlvxg11zyc
 VoJMVqux/BtFE1wNjHwJLMc5FmYdnq2WVud5G+DOA2u71B4qPYckvgnqATc6mIKwkZ1S
 JNaIoBbSVyL7F6pCMutUrAoBBhlnI1zR5Ze50+R7R8c5P2lMYHjMbIz9e2SwY+strMKK
 +YT6OVyivhwk0Q2lnI+Sn2+2wAUdVqc9jrlbGjIuv8tC19lG3IFfPrp5Ob2IZJgUFYYQ
 HM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723638945; x=1724243745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQw143uqoSNTMvi/+ETqt2Owl38KpQ6auVc5y9ukaYs=;
 b=lKlA0l2jwZXHGDLhk/RCDqq0I6U/3g5QJ1LeHqseZDDc/WswSiXujdNDlqxPzMAy60
 wmczllgW4VGMiXyaLWddGP3Tn+8lnMcgu5tVGGkWjuM1YobFcLrKnaUMmGxoV2zg6/k7
 PS+lDNF3LUGehl6lhVJcOk+9QkHZlGkCFniSH1yJIkHOvkwlwn/+zJZV1a3/wYjwwbJS
 DXHtDWdWc+zEAwxC9GzLvhFYT/A+eb354GsT9fRzlus7/qlMU5Ofd4AL78L0OKcHUw9V
 85ChUp0IKswf6axIuCZi4eai054ysmsDCEKeHPh7KXLhPWuSbe8BNtK9SkIODUedYU/s
 w/Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWESax4i34BThKrLGKnmBgQNC5eKb5Ek1lxlnpGDuWpWqiBeNnekzXOEtHRg9qAhUMwrWfezIYwfI3oKB4lviwQVZRyOw==
X-Gm-Message-State: AOJu0YzNwuE7lY8UHJuY+JaSY1UFWY5PRxwstVR4dVkPX5Wl4pDf165h
 TJI50lc7ZV/5XmudFuX7xqgwcKkIuM4gecqfCURLqn2AcdOjN1BM40gndX/asJYO3j3v5YKX/BT
 rAF5UYHsHdRQ5d/VsmF8NtBkVKAS1GfEP3Bs5Ng==
X-Google-Smtp-Source: AGHT+IGsJl+wnVDw07RdzE4e8xDyuFAF5cNcg5mbuJDZWamGuXQeSgJRHP1NVbV5ebDF0zR6wHH7voJtZ+x6vE/o9Ec=
X-Received: by 2002:a17:903:1211:b0:1ff:39d4:1663 with SMTP id
 d9443c01a7336-201d648b6damr27227835ad.47.1723638944727; Wed, 14 Aug 2024
 05:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240814123344.196991-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240814123344.196991-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 14 Aug 2024 15:35:08 +0300
Message-ID: <CAC_iWjJMw_Hyvb5s+bQ40HxYM-h4hhSpC8Gj2ie1SWAqtSwf0A@mail.gmail.com>
Subject: Re: [PATCH] tools/mkeficapsule: correct printf codes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

Thanks Heinrich


On Wed, 14 Aug 2024 at 15:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> uint64_t is defined as unsigned long long on 32-bit ARM.
> Use PRIX64 for printing uint64_t.
>
> This avoid a build failure on 32-bit systems:
>
>     tools/mkeficapsule.c: In function 'dump_capsule_auth_header':
>     tools/mkeficapsule.c:694:66: warning: format '%lX' expects argument of
>     type 'long unsigned int', but argument 2 has type 'uint64_t'
>     {aka 'long long unsigned int'} [-Wformat=]
>     694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
>         |                                                      ~~~~^
>         |                                                          |
>         |                                                          long unsigned int
>         |                                                      %08llX
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         use PRIX64 to print uint64_t
> ---
>  tools/mkeficapsule.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index f28008a0829..1b53151d41a 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <getopt.h>
> +#include <inttypes.h>
>  #include <pe.h>
>  #include <stdbool.h>
>  #include <stdint.h>
> @@ -691,7 +692,7 @@ static uint32_t dump_fmp_payload_header(
>  static void dump_capsule_auth_header(
>         struct efi_firmware_image_authentication *capsule_auth_hdr)
>  {
> -       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
> +       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08" PRIX64 "\n",
>                capsule_auth_hdr->monotonic_count);
>         printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n",
>                capsule_auth_hdr->auth_info.hdr.dwLength);
> @@ -724,9 +725,9 @@ static void dump_fmp_capsule_image_header(
>                image_hdr->update_image_size);
>         printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
>                image_hdr->update_vendor_code_size);
> -       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n",
> +       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08" PRIX64 "\n",
>                image_hdr->update_hardware_instance);
> -       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
> +       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08" PRIX64 "\n",
>                image_hdr->image_capsule_support);
>
>         printf("--------\n");
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
