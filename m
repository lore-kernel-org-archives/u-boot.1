Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82019C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D33889D1;
	Wed, 14 Aug 2024 13:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NxhBkfZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D292E88A27; Wed, 14 Aug 2024 13:05:02 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F8688763
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef248ab2aeso101128351fa.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723633500; x=1724238300; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2zTanF4GgxBEtPjgAOqcdryl9iQlc+5wIWhHg0GGbg=;
 b=NxhBkfZPCKxCMsYrTydlRpQKP4P8KfYhByaHKb83dtFAv7r5JtBxV3nBmDWGvTSF4y
 NzLcfBMdjjXov0GZ25ml04yOSMshT66IlMwTo/wopSr1rziTguxJr+VbYOuq2zHJMpWl
 BeLHAyD7+TThYzzOLjdKv3D/eEGoHEXDlmq/9OT/FC54+jpc0emv8vC68djmRqEHB5ys
 smeGUY72CnLvJR0EJXGbdePGE0j/4MmWvyR54zdqiJqrci0He2Kls5JzSzwL8t4wTT20
 PMNnlaYjLkeii3YM2kXO13Nh3w5oxKpm6CDffxFM3hsXneRExalQfl3SMT5iqhCPeMa3
 Lzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723633500; x=1724238300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2zTanF4GgxBEtPjgAOqcdryl9iQlc+5wIWhHg0GGbg=;
 b=PCqKu1NnVsm2WrVaORG3LJMtFaIab+92Ph7Oac39063HjiA7luokBkxzwjN5rhGGuL
 NAt0Gg0rJfLOWR+QwmSLo/4HpGh9g/jAd75Hu5B8NxY8Z9YsAPGud2ys43zI7+IS3eWU
 V2Ci7tdGb+lrXJY7B3Wl6AOScCXcSObkLANSbIHOO3Q3mfS2azMsOuXhhOF/R3pB/iOw
 txEuQtpmmFCUAP/VXtH1jwundXQooSifBcCH8VWS02dDURsc24znmUHLav5tM6CuXPug
 FdkWSng9+i/BARz3fxBW5epY6srdKfnvoTq9mq3+w2I0y72vJwR2czlxHW/H5jzEDMUZ
 6Fiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCysp4UkheuNsk9XyZ93uKOn2lxMwnxX6eGWF7QZ11dWQAJqf15XdyYnxHGeBvv19ODLRj6ur70WQjBx3v3Twk8D7XFw==
X-Gm-Message-State: AOJu0YzmWRB4Y59IGOp3vRqxt/s9J72vzpTMwz7tBelKJPiO5loATKUv
 yQhHIfZxd5Y6CBKgt7lQ5SDbDT0dRwombNPDjMMQ9654fje0gKW7gSV42HkUC5YOqs67YFpuQGL
 Zm5SvCqDAveS1312hDRNaaS+Fl5tXggV5juckkQ==
X-Google-Smtp-Source: AGHT+IFYRNxoNllbS744F0Q3EZQMhJZna4a3YRrkrWKf6z1Lb32z8/FAsyog3EXj1bxOLnOYj3pmWaNJsBdc5ADVvx0=
X-Received: by 2002:a05:651c:10b0:b0:2ef:2e98:9718 with SMTP id
 38308e7fff4ca-2f3aa1df0f0mr16708531fa.15.1723633499813; Wed, 14 Aug 2024
 04:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 14 Aug 2024 16:34:48 +0530
Message-ID: <CADg8p94Ku8uVBXPYs9LuRTJgFenmLH-4wbNr4v0HBEEC8_gBzw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/mkeficapsule: correct printf codes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 12:44, Heinrich Schuchardt
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

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Interesting that the tools are being built on a 32 bit host :)

-sughosh

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
>
>         printf("--------\n");
>         if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTICA=
TION) {
> --
> 2.45.2
>
