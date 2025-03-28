Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93322C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E9481951;
	Fri, 28 Mar 2025 13:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gq+ya/My";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF25C81951; Fri, 28 Mar 2025 13:42:08 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89F98003E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so2081384276.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743165725; x=1743770525; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FTxq8yAfS/jffXKB2bwGyo/EnAR5LebbPfMEvYObf0U=;
 b=gq+ya/MyxzRBRLkK86d+svSq5f+uKCeet/bnEAZGaz3jrxHkem4TCKGy3pQW9aqQtz
 j9abDwY46dT2T4bmMEYGZAAf4T15zvijXsNPoOADqT7wShB+2PWXzISw78pPLH4R0OuB
 kMKZq73WIn30pgh6EWJXGUfq3M0X/Qmje7QTRA3NiY9XZZbRRNwqfLeYI5Vy9Msg0NBU
 QtkvaKETqO0l72c0tidZFhkO063V7Dsof6hP3z237mEQk+7gk7TNJ1ShMKrNyFH59rs+
 a82E5WjJkUIj0CqLsDMS1UCDZCI0Exgjm5Mnh8iAMPUDEHFp/7LwCpDgGg7iG5CFrvL/
 ph/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743165725; x=1743770525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTxq8yAfS/jffXKB2bwGyo/EnAR5LebbPfMEvYObf0U=;
 b=tzV8b8OEwama2cW7olBpTRJbW6GJ35Bf5ZtAHF1zV36MqtdzlrSQgKcJAwSIO72ve6
 B7yoSqP+vMHXCLQBaypNxg743p+Y9CU2JlcKN85dKVSWoDjZ0hWrVHT9VuALoKG0izEl
 qsCIDvflF41Q5FBUdy/tRak+DEjG0D+qIU+3UPHux4HxUCVtUQVqVAMWM4CtCyW374b8
 dOZElAnlgFeIkvw+7EaEKHaG3amIe3AK++UEyQveMjwZK3qirNP06iHIvqG35JGYzlx5
 7jVZWeJDKCqLaxI9v5UbOC+BQ02IXFUTwQyeA2GjmSagEw4w1/fxsOQr5eVHBcGdX5uH
 +BEA==
X-Gm-Message-State: AOJu0Yx2Tzn0LOVgxdBGuJSVHlGjxMyn3ZmnvSXD7aU4c2Aq1euwt+pu
 w9vOjHYSrQ8d1VB9ER+88VWMUv4P6XVbn/TkpqFWGdbgaw3f3122AxmyXPuNYXNz9pAQUd67fOE
 fwT67UgBMNFY2GJVZcT0QUg1Ugzc/pV/CAfY83bja+IHH2xBDvYo=
X-Gm-Gg: ASbGncudhvshlMNSZstMAEQb0KknwKsKtZ6T5sZ7cPWRdw3Ta3/HvBbD+0a5atR4avW
 F7EYmYTuaRLIkm96p+QXYt7rhxy8M47w9qCQ1rC2LBz4bvqVnhxZbbhBsq2G286E281UyEt3bpX
 TvVWmDaTAl2IPHOwakVLEld8+9
X-Google-Smtp-Source: AGHT+IHPj1yIcztVQBaFQKo3dv5hiywk3Da74cRq1Q+zWnQDnCNFBONEfEAzaZNNiXsuDtCizMuP8Pc9/ZA+MY95QHQ=
X-Received: by 2002:a05:6902:2610:b0:e63:d10e:edc4 with SMTP id
 3f1490d57ef6-e694353e604mr10252454276.10.1743165725390; Fri, 28 Mar 2025
 05:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
 <20250319144501.32277-4-adriano.cordova@canonical.com>
In-Reply-To: <20250319144501.32277-4-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:41:28 +0200
X-Gm-Features: AQ5f1JoKxnNtc7uX7u947_dY5SbXHNTtLZPsBr9v7KAmUrGwRK2iBpnBQp9j1WM
Message-ID: <CAC_iWjLpgJD=5xOVKjXhrpP5=QO+ZuFZ1nUfrtZbgFfa8fr8Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] bootm: add support for initrd in do_bootm_efi
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

On Wed, 19 Mar 2025 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Pass a pointer to a memory mapped initrd and its size to
> efi_binary_run. The EFI stack will register an EFI_LOAD_FILE2_PROTOCOL
> for the next boot stage to access this initrd.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>
> (no changes since v1)
>
>  boot/bootm_os.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index f403f352be1..35a32f8c912 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -508,7 +508,8 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>         ret = efi_binary_run(image_buf, images->os.image_len,
>                              images->ft_len
>                              ? images->ft_addr : EFI_FDT_USE_INTERNAL,
> -                                NULL, 0);
> +                                (void *)images->initrd_start,
> +                                (size_t)(images->initrd_end - images->initrd_start));
>
>         return ret;
>  }
> --
> 2.48.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
