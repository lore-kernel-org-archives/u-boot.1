Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8BEC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA0687C2D;
	Mon, 10 Jun 2024 11:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMKJJtkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A5B87EBD; Mon, 10 Jun 2024 11:20:28 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BF686EB5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35f1d407fc2so170085f8f.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011226; x=1718616026; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aaW6doY18gKSFWWZcGipPg35/3Euq6516g8BSOPqmI=;
 b=AMKJJtkVYR0lekNiaLFc6qOggVi2hVr9ImKVQZG6+nSTNhTGRXkhOQcMYhesAN6CYZ
 2n2OJ4bx0ymr+ep06IqTurbkD4kzoQXNQdIJBDTOZ30d4zP2MNT7P6hlflE1yVNxLhzJ
 q/uTNpun+XVT0UTYopn/1gpWnmd8d/r+6syRh/HFzAiDopCNgYgM7cIxY5YwSP/a7Avk
 lOxBwW++d/wbjkzd3sB8X9NBREvAIONU3zywEfoj254iFrgdcMvFWgizq9Sq7ltdtRsi
 ELR6Kwvchos9pSBVgoM4EaW5f7p75zMSEqKeUtJUSKn9UVi6uZiDkOIB2w6vzG+tPsIL
 bVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011226; x=1718616026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5aaW6doY18gKSFWWZcGipPg35/3Euq6516g8BSOPqmI=;
 b=WPlABxNgoXYPkgoFr4mE/WdItVLmfvieSkLdof7v0oQbZ69s5S85aiY41wEPXjIk1D
 GM9Zu75nsZwiXz6zBqyFC4taDU4Fluxd9pvuCl9b8pzYO4uittM8+tJmg2BIaUW0WlYl
 rZJLG+Kc8M5Zomtnv8GPd52CfI+umYouQlgPwTgZc7bmgx1K/GUT5Eri23vLHUrSu4CS
 FUBdzOqOMVrKKDsHFZVXi+gmju22HqH6SiupCLvY979X29gei6XnW3njcVx9fipVAg2j
 kddnxMogfusyFm4+i1s1BThe6oUh5HyesYImpZBgKtQLx0Vz1NGAP2rU1ue3ycHBeHVM
 DW2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtBzAuHonAwcgUiyTYXV2RKD8Tqfc6rxG70/WkmwiOjcSKLBHh5lpCe9w/IgqWKsKQPmoOKeAuMfR0kUvheK6YQL0Zhw==
X-Gm-Message-State: AOJu0YwWj2Ek94lYJchy3f2/mY2Y8dfNdTwqkGznOUEndHvba2FdkwCc
 9mqr6uwE8HOxNjHnf6XimV4f20DZlNXoEWOtM1jzn0I1TwgJyh4Yp6zk0bXoZoQO3BMIHPa9eVs
 K/n4giPtNBoOBWgLTks8l+PF6Xv4=
X-Google-Smtp-Source: AGHT+IGXMTg2l+HMBUBQ+pCoWRA/keefHxar5cjVhDiMEkHMt3iIABPqSRaMjHKAPolKT8uz2HfKXFIek/YfZJxvQEA=
X-Received: by 2002:a05:6000:2ad:b0:35f:1edb:4695 with SMTP id
 ffacd0b85a97d-35f1edb47dbmr2686053f8f.6.1718011225531; Mon, 10 Jun 2024
 02:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-2-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-2-0c69d4457cc5@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 11:20:14 +0200
Message-ID: <CAByghJa6gLyJHB7z3ME0JPewZ3JJizmY54XBO3MeX3TMrzB_tA@mail.gmail.com>
Subject: Re: [PATCH 2/6] boot: android: Add image_android_get_version()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, u-boot@lists.denx.de
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

Hi Mattijs,

On Thu, Jun 6, 2024 at 2:24=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When reading a boot image header, we may need to retrieve the header
> version.
>
> Add a helper function for it.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/image-android.c | 7 ++++++-
>  include/image.h      | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/boot/image-android.c b/boot/image-android.c
> index ddd8ffd5e540..4f8fb51585eb 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -185,7 +185,7 @@ bool android_image_get_data(const void *boot_hdr, con=
st void *vendor_boot_hdr,
>                 return false;
>         }
>
> -       if (((struct andr_boot_img_hdr_v0 *)boot_hdr)->header_version > 2=
) {
> +       if (android_image_get_version(boot_hdr) > 2) {
>                 if (!vendor_boot_hdr) {
>                         printf("For boot header v3+ vendor boot image has=
 to be provided\n");
>                         return false;
> @@ -203,6 +203,11 @@ bool android_image_get_data(const void *boot_hdr, co=
nst void *vendor_boot_hdr,
>         return true;
>  }
>
> +u32 android_image_get_version(const void *hdr)
> +{
> +       return ((struct andr_boot_img_hdr_v0 *)hdr)->header_version;
> +}
> +
>  static ulong android_image_get_kernel_addr(struct andr_image_data *img_d=
ata)
>  {
>         /*
> diff --git a/include/image.h b/include/image.h
> index acffd17e0dfd..18e5ced5ab42 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1963,6 +1963,13 @@ bool is_android_boot_image_header(const void *hdr)=
;
>   */
>  bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
>
> +/**
> + * android_image_get_version() - Retrieve the boot.img version
> + *
> + * Return: Android boot image header version.
> + */
> +u32 android_image_get_version(const void *hdr);
> +
>  /**
>   * get_abootimg_addr() - Get Android boot image address
>   *
>
> --
> 2.45.0
>
why introduce a helper function if there is only one user of it?

android_image_get_data() expects andr_boot_img_hdr_v0 anyway,
as it has an explicit check for it in the very beginning
(is_android_boot_image_header()).

Have you considered adjusting android_image_get_data() declaration, and jus=
t use
andr_boot_img_hdr_v0 *boot_hdr as first param instead (like it's done
for example in
android_boot_image_v0_v1_v2_parse_hdr()) and then rely on implicit
cast when this
function is used.

this is of course all a matter of preference, just thinking out loud

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
