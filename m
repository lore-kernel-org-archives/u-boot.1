Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC96D6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86F689257;
	Wed, 30 Oct 2024 22:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dksVCkDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E828924B; Wed, 30 Oct 2024 22:22:14 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D9C88E17
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pwildt@google.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso2293775e9.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730323331; x=1730928131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j4ee5KwmK/azNOYhZPmz9VPUTTng1D4M6vGiodTJsWA=;
 b=dksVCkDhDlgT4isYmVsX1fekrLsSrtvNJsEQKGdUu5Tg5zxHj0q/hO/hXzaUa5cNeP
 vN8seqlvFyHRxOKNiWJVus5oQdP3ytQsjCXoUlmXwoKmkOVpw+59Bli1QHn+A8BVDRQx
 ahh7GdFAHadbT+RkqSbf/0XglQWB4qrGxl52Frym6J5Lvmdql+zVXB8vhYm5F39J7QlM
 HM4IwRCZtzucI34bt2Se0FaDkudk7Q8PWe6FSSRGI3Plb1Ginn00sLtwnQAELNPcovSZ
 5vrwDNWKbJDC2IVT8B8p8a7h7KWzYNGB+1FvNAavQ3E+GAvBXZihfQGzEJIaci47Y7zW
 RMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730323331; x=1730928131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j4ee5KwmK/azNOYhZPmz9VPUTTng1D4M6vGiodTJsWA=;
 b=ggY6CJwsrlC27RTziiN99hIegEpV6+M07fUxgLgUltW0lurh7tQ4ZRwpgL7Qd0M0Zf
 b54+H4bcEriVUZ8f3WFL6b3mWEUYpM8jFd9vuioY4cgRKn3puAElryRlLQgKux8BOoYL
 FxvolC34uazIla4HKnTI0CXNZEzVLhBQZT3a4/WweFWutYmaS7Yp3eImbDWz0gMldxJq
 kTwbsDJzJKTD3FoHmlk8hzPDb1mSPTeULO2WnaPCyl4IVp/ZX0tqY4nl3kX4MY3zXLNC
 b84aUUrTpd+djCLCC6iTXg4Txcp7rZTbCI1sVatZr973qrE8EKtAyw72mhrgXj13cFLO
 4cQA==
X-Gm-Message-State: AOJu0YxaXeEOE5P32oI7S50wQvyxFcuBAsJ1CPXyZD9xGu4qRgO488k2
 9l3e08yDDVwklrO/JAokmXKvXSw5JJeNSaiSnSkkOgGoPu22qmes3h44u8FWe4k4AyXVVKI9ltj
 B2by+rYXyccu8kf13EdIVGfCMVorUjBjr8Svo
X-Google-Smtp-Source: AGHT+IHyV+Ov0nAplV5aec38hhCYriK6N8ytJySewiPOhCu+WSp/7YTuY4HMT2YNOFr61YQPMeEkXBMnGpGlbT/jYjo=
X-Received: by 2002:a05:600c:5246:b0:428:f0c2:ef4a with SMTP id
 5b1f17b1804b1-4319aca5a1fmr150674695e9.13.1730323330546; Wed, 30 Oct 2024
 14:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241030211748.1264005-1-moritzf@google.com>
In-Reply-To: <20241030211748.1264005-1-moritzf@google.com>
From: Patrick Wildt <pwildt@google.com>
Date: Wed, 30 Oct 2024 22:21:59 +0100
Message-ID: <CAK47JV4KNDE=GF4mXx8kL+XdbHBXFbpL8v7XXHysL6xFve=j4g@mail.gmail.com>
Subject: Re: [PATCH v2] lib: efi_loader: Fix efi_dp_from_mem() calls
To: Moritz Fischer <moritzf@google.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com
X-Mailman-Approved-At: Wed, 30 Oct 2024 22:32:57 +0100
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

On Wed, Oct 30, 2024 at 10:18=E2=80=AFPM Moritz Fischer <moritzf@google.com=
> wrote:

> The function expects an end address but is being called with
> an size instead.
>
> Fixes: 6422820ac3 ("efi_loader: split unrelated code from efi_bootmgr.c")
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
>
> Changes from v1:
> - Fixed second callsite
> - Remove superfluous cast
>
> ---
>  lib/efi_loader/efi_bootbin.c     | 1 +
>  lib/efi_loader/efi_device_path.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index a87006b3c0..bf38392fac 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -137,6 +137,7 @@ efi_status_t efi_run_image(void *source_buffer,
> efi_uintn_t source_size)
>                  */
>                 file_path =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
>                                             (uintptr_t)source_buffer,
> +                                           (uintptr_t)source_buffer +
>                                             source_size);
>                 /*
>                  * Make sure that device for device_path exist
> diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> index 9de3b95d07..d7444588aa 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1073,7 +1073,8 @@ efi_status_t efi_dp_from_name(const char *dev, cons=
t
> char *devnr,
>                 efi_get_image_parameters(&image_addr, &image_size);
>
>                 dp =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> -                                    (uintptr_t)image_addr, image_size);
> +                                    (uintptr_t)image_addr,
> +                                    (uintptr_t)image_addr + image_size);
>         } else if (IS_ENABLED(CONFIG_NETDEVICES) && !strcmp(dev, "Net")) =
{
>                 dp =3D efi_dp_from_eth();
>         } else if (!strcmp(dev, "Uart")) {
> --
> 2.47.0.163.g1226f6d8fa-goog
>
>
Looks good to me, thanks!

Reviewed-by: Patrick Wildt <pwildt@google.com>
