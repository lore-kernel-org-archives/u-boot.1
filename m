Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE1BCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B41783621;
	Fri, 26 Sep 2025 17:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vxn1hVIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5435836D1; Fri, 26 Sep 2025 17:46:20 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A60AE835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-62fc0b7bf62so3255001a12.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758901578; x=1759506378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy56Whx5hgJwwN7QnLzrQK8ANyZ8FJ3F8yd9vtq+iZM=;
 b=Vxn1hVIJgTLlOv+g6nkPsUHTKCHDTgABGHCaqBM07z5iMAOGwD9uQFAaR3yv/P0Hrx
 xk8yjPBUyVy6t6cXbiEBl8ucxx2nlfnLqwg2wWCSP+gEkN+zTEXbUuk4IJYtLvVPpxmj
 ELrB0o1ISk7qz1B6Lt/gmrVkOeyHxyaN6N3XbsJ+dGElUnSb3/AGC504C9TfzktRmIdb
 u2ivHRWahB0IgU6G3dywtz5IXJkPvgyhNYnBRv2qDvZEPumjLXYte0donaDvJdqZdxQ5
 R8GLRRUPzfmvfaKGEVKk6o+XG66uAKvSgSRYgw//r1Q55cwEQ7RHXoo7s9jm6sYNnZLW
 phfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758901578; x=1759506378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iy56Whx5hgJwwN7QnLzrQK8ANyZ8FJ3F8yd9vtq+iZM=;
 b=PCEMv2LXl/3tPNBrWSsfKrzKQQ7hxZtDORm8aGTjZdrknRalXbDIs87temiWOMZsig
 OjikWzEk/beRXXKdUIO3cfN10H8IkvpslzWotyrYExIZpBhPwvLzbW6Bkf/X+QZSJubg
 IGolTkcLDrXWBGQUglANsKZfxrzHjW8enNTYvYBWE/UcS/FKg5nt6XE6WBHGOsSf1zSr
 EKf1Vg3nz49lwmRMl8RHsvLT+xruOeNhivATEJj0OO1SN/Fp76Uzte32NAyO76J99zeO
 KbJlkpV4EX5OkhIXeE+VIGejQz1dJalixZzfe0QwY01Hqj3dMVcgEQw19af/gvOJkBG3
 iChw==
X-Gm-Message-State: AOJu0Yzh+w0gMKcMkZYsR5CoTfcJm+HICgB0c2tbMQ7NzlfWpB9WRdHe
 n3H8x0QJwW2ATTa2sS4dc7N+A3OvMY8Xl9Tcr5u5l0QOrhRAwkCsC7KecKi1wW3HunScCyRgneF
 J3KUDnuIjY9KnrIn72JaN79Ma09WyqYE=
X-Gm-Gg: ASbGncvbVCybsfY4IGcDZwgB+tEDJpgVSwE4CX2SwcNGMaI0s1BVzs0mRg5ZRoSjAZV
 wNe9YnNhRNVZ/+yKEDkKFxAftal0y01ATlnjBKQDlbx1WH5/VrNOCVy1fIgP5WDn3qoLBc4RGq5
 A8ZIT54DGoNjO2KhpVDajkjVUtKlZsOMIpdL66Ctvdrt7FO1WRqg0pokfNh+5oWgIug1cWiSVfq
 MldlsTtBRaRdU6t6GSf7weBb/FL20ppBcWEWGw/Olzx6HvC4uxT7Ul3FOxqQCy3jh3WmDLhTwjh
 EuLcSXM4rcWOKgFg2WdhvX+6ObyGiomWAOgp
X-Google-Smtp-Source: AGHT+IF+XyXpsgIy1rSCrPDbT2OV2zTdsnr6bXGwyuWHk0kVUSA6Ij6LuaQB2ron/vYYU8L7yi4Gv+EnvYijYG9Kt5s=
X-Received: by 2002:a05:6402:184e:b0:626:8e29:8d42 with SMTP id
 4fb4d7f45d1cf-6349fa9e8f4mr5251688a12.37.1758901577744; Fri, 26 Sep 2025
 08:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250926153034.3680674-1-trini@konsulko.com>
 <20250926153034.3680674-4-trini@konsulko.com>
In-Reply-To: <20250926153034.3680674-4-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 26 Sep 2025 16:46:06 +0100
X-Gm-Features: AS18NWDyfJCodQOMEXKkVw3vIbcXdo5_tvJ3xlBqNgXRveQpMPKH8Pqbb1tLvJc
Message-ID: <CALeDE9M=1oZ53WU+1J=4BUeQrSN8h2TvE6nL3WyNsci6qiFaow@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] usb: host: xhci: Make U_BOOT_DRIVER entries unique
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
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

On Fri, 26 Sept 2025 at 16:37, Tom Rini <trini@konsulko.com> wrote:
>
> All instances of the U_BOOT_DRIVER must use a unique name or they will
> lead to link time failures due to name space conflicts when both are
> present. Most of the XHCI drivers follow pattern of xhci_xxx in their
> name, but a few used "usb_xhci". Change these to follow the pattern of
> the rest of the XHCI glue drivers.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> Changes in v2:
> - None
>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> ---
>  drivers/usb/host/xhci-brcm.c    | 2 +-
>  drivers/usb/host/xhci-exynos5.c | 2 +-
>  drivers/usb/host/xhci-generic.c | 2 +-
>  drivers/usb/host/xhci-mtk.c     | 2 +-
>  drivers/usb/host/xhci-mvebu.c   | 2 +-
>  drivers/usb/host/xhci-rcar.c    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
> index 2ffad148dea6..595839fac3c9 100644
> --- a/drivers/usb/host/xhci-brcm.c
> +++ b/drivers/usb/host/xhci-brcm.c
> @@ -85,7 +85,7 @@ static const struct udevice_id xhci_brcm_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_xhci) = {
> +U_BOOT_DRIVER(xhci_brcm) = {
>         .name                           = "xhci_brcm",
>         .id                             = UCLASS_USB,
>         .probe                          = xhci_brcm_probe,
> diff --git a/drivers/usb/host/xhci-exynos5.c b/drivers/usb/host/xhci-exynos5.c
> index 6a2d422c4b8e..9a7c0f29dc8f 100644
> --- a/drivers/usb/host/xhci-exynos5.c
> +++ b/drivers/usb/host/xhci-exynos5.c
> @@ -247,7 +247,7 @@ static const struct udevice_id xhci_usb_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_xhci) = {
> +U_BOOT_DRIVER(xhci_exynos) = {
>         .name   = "xhci_exynos",
>         .id     = UCLASS_USB,
>         .of_match = xhci_usb_ids,
> diff --git a/drivers/usb/host/xhci-generic.c b/drivers/usb/host/xhci-generic.c
> index 355d4883176d..8bb4e2774230 100644
> --- a/drivers/usb/host/xhci-generic.c
> +++ b/drivers/usb/host/xhci-generic.c
> @@ -61,7 +61,7 @@ static const struct udevice_id xhci_usb_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_xhci) = {
> +U_BOOT_DRIVER(xhci_generic) = {
>         .name   = "xhci_generic",
>         .id     = UCLASS_USB,
>         .of_match = xhci_usb_ids,
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index 7e288f0575b6..ffe80c0bbdc6 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -357,7 +357,7 @@ static const struct udevice_id xhci_mtk_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_xhci) = {
> +U_BOOT_DRIVER(xhci_mtk) = {
>         .name = "xhci-mtk",
>         .id = UCLASS_USB,
>         .of_match = xhci_mtk_ids,
> diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
> index 1338b1021c64..12dc61aee9db 100644
> --- a/drivers/usb/host/xhci-mvebu.c
> +++ b/drivers/usb/host/xhci-mvebu.c
> @@ -87,7 +87,7 @@ static const struct udevice_id xhci_usb_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_xhci) = {
> +U_BOOT_DRIVER(xhci_mvebu) = {
>         .name   = "xhci_mvebu",
>         .id     = UCLASS_USB,
>         .of_match = xhci_usb_ids,
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> index b72807053c42..95dfa2c3f874 100644
> --- a/drivers/usb/host/xhci-rcar.c
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -149,7 +149,7 @@ static const struct udevice_id xhci_rcar_ids[] = {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_xhci) = {
> +U_BOOT_DRIVER(xhci_rcar) = {
>         .name           = "xhci_rcar",
>         .id             = UCLASS_USB,
>         .probe          = xhci_rcar_probe,
> --
> 2.43.0
>
