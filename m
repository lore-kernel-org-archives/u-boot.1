Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D94C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D08889ED;
	Wed, 14 Aug 2024 14:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C4vxpoIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112F8889D2; Wed, 14 Aug 2024 14:40:26 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EA588A08
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e05f25fb96eso6245733276.1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723639222; x=1724244022; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtmTgrvtgH1NMhXV73HBUlGufmyd4Sx3tl+UBWDAS3U=;
 b=C4vxpoIfvH9ZPX/+WUHVHDX7PCbIFAQgT1NpEKBNFDbhveLLlDk8q/7ECdpzUa1o7z
 nFXQcrwbAez22fTS8Bq0lXCW5OYFRH8HkJqp5vGGNd1zuoMBxM06XpfD0ZwKaHO69t3F
 uvbRtmgqj5utPigwpwfYG1ylEMRBAOO52Y4sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723639222; x=1724244022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtmTgrvtgH1NMhXV73HBUlGufmyd4Sx3tl+UBWDAS3U=;
 b=Jee2Tc15C4g8mQXELq5dOiHPSOIxZ3zVxIpgx+qptsrNmBjoShikx9z6Pzrk8j1aID
 Jv6jM2yBvjjWWUu9x5IahWpfipyGXY7wqUmsU0/iZDKKSXvvqb4WsmZCa2tpqdIOPjYu
 KEoiQXvkTE8ewcC4YCxhSCYszjxmp41VPiTjVJlbJfKD5afNMcEWlVM7V1s+e8E3NTxq
 IdAaYmDlB0j028WukStZ/IaDk614ZGiHJCeCYlGeeHWs5U8BG21sjckN5MNn9o/9FQYx
 nzRBE7t/kPnWa9jhBqY6dsE479TYqhJELjoJSjK6Zaumd5AkmIUiV0umV1F+A7NbKgiB
 ffqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4DSIPbllMsOT7aKSm447ijcuqTMlX80Vc/EWnYO3GS0fEWBSp4f1Q4n0w6Mq/dcvkbvpAAVc3baUWTi9fY3i7Q4Pbzw==
X-Gm-Message-State: AOJu0Yz3G/7tQECFvKFb3wMdHvfaxK/NLkwcqHuevT8BdDONv7mDn+63
 a4LqeFX6x0TVZdUJbTh5BRH/88Iy7FeWs7CNtCKuzgtB0RGlpQfQ9euwYwG03g7ErQcifyBhgJj
 08eVlBX1yQ9IbTpwmAliaZrdERv/2ZLjTcs1N9DXBue3pYc0=
X-Google-Smtp-Source: AGHT+IHlOSkQjZ6Umr1zvE9D8SoG8sLCGewf7Mo1EyoLTAOBiPNZeKsajSV2OQUYutNMyoTDB0NExjnGsTt/0AO3v3k=
X-Received: by 2002:a05:6902:2742:b0:e0e:9196:ee4 with SMTP id
 3f1490d57ef6-e1155b91b43mr2546908276.39.1723639221838; Wed, 14 Aug 2024
 05:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 Aug 2024 06:40:11 -0600
Message-ID: <CAFLszTgd7S8RQFJnpVfH-wRirrZ0VQ=kN=mK2TOqmHkr85OBcQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/mkeficapsule: correct printf codes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 14 Aug 2024 at 01:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> uint64_t is defined as unsigned long long on 32bit ARM.
> Convert uint64_t values to unsigned long long and use %llX for printing.
>
>     tools/mkeficapsule.c: In function =E2=80=98dump_capsule_auth_header=
=E2=80=99:
>     tools/mkeficapsule.c:694:66: warning: format =E2=80=98%lX=E2=80=99 ex=
pects argument of
>     type =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =E2=
=80=98uint64_t=E2=80=99
>     {aka =E2=80=98long long unsigned int=E2=80=99} [-Wformat=3D]
>     694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
>         |                                                      ~~~~^
>         |                                                          |
>         |                                                          long u=
nsigned int
>         |                                                      %08llX
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/mkeficapsule.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index f28008a0829..d346c217f09 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -691,8 +691,8 @@ static uint32_t dump_fmp_payload_header(
>  static void dump_capsule_auth_header(
>         struct efi_firmware_image_authentication *capsule_auth_hdr)
>  {
> -       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
> -              capsule_auth_hdr->monotonic_count);
> +       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08llX\n",
> +              (unsigned long long)capsule_auth_hdr->monotonic_count);
>         printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n"=
,
>                capsule_auth_hdr->auth_info.hdr.dwLength);
>         printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION\t: %08X\n=
",
> @@ -724,10 +724,10 @@ static void dump_fmp_capsule_image_header(
>                image_hdr->update_image_size);
>         printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
>                image_hdr->update_vendor_code_size);
> -       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n=
",
> -              image_hdr->update_hardware_instance);
> -       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
> -              image_hdr->image_capsule_support);
> +       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08llX\=
n",
> +              (unsigned long long)image_hdr->update_hardware_instance);
> +       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08llX\n",
> +              (unsigned long long)image_hdr->image_capsule_support);

These should be in lower-case hex, by the way. Also see inttypes.h

>
>         printf("--------\n");
>         if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTICA=
TION) {
> --
> 2.45.2
>

Regards,
SImon
