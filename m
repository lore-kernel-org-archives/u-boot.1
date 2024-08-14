Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDA9C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210DD889AE;
	Wed, 14 Aug 2024 13:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GooNiqD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C5788440; Wed, 14 Aug 2024 13:40:56 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BA9889B8
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso5041607b3a.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723635653; x=1724240453; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJJ0IZv+OLK2/SZYHsaKhXfSQWVwOzKTWJVsNUIwiWw=;
 b=GooNiqD5ji8f7W7FoLSSUTYUCUucRj0r9cCf3/pn2rFt2NFWkE90l0OHnVjkBMErQb
 ZPsXFz7vXo8vmJpgEFnnQ/vX344BeZNz6Cz6Y80oIWKUdPrOtyNqLbCc8DzSs4IcoD6l
 XanjTMM2jvcJKuGzqya++kS8GBgdVHvOoaf6k2XPGFVOM4AhbBCCKIio0LPj0ezIMSPS
 pa+0ibllf6VeZFV+LWtJ7GOuAaJHUNGAfdQzdQ/LMmFCydvL6CyBEr1orIk+vOyOetSM
 x46AuqiEH8t6upq0rfwq53ChIMYngmvKQX9+GzJ93c8lbI9VdkVL+MxREU1oko7oUAjn
 XOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723635653; x=1724240453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJJ0IZv+OLK2/SZYHsaKhXfSQWVwOzKTWJVsNUIwiWw=;
 b=mdm4kA0xxjFQP0gx0/wWEiVcu52vHF0hBcvHegWsQchDfuRVHdkNoET1RhIfFCEVMP
 3lt6q/YfwZEd8Q00sU2lx6miPWjH344X4xxxiKBEdZmRsn1ujmqAsV20fLQ7wxXR/BoR
 KwqEXcWjAE6XD2OU/u5FKDWZdmu3EdJBeTrO5pseZ8hz9MVn2hfkM42dUZiedSxPjcub
 El/mG08xP6xZ9x7U2yPoHhVi2XiSc/keu5T21eiuc7fyyt0Y4tT51L8DQEZrj0jcboAR
 M5SSkQI3EJOgCePPaQAG/05wkV6t4IQ2+sik6/gMWSnRUejAOIxz9+qEFsh4An16Qx8M
 WKGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULjUZDV76zTTqa3X2fCGPEj1yr4HJWxb/XvLE+o4CR0vH95P5CzVwgEMG9nKO9KMMSmfJ1mO8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1mOu4rqtfUX/Jtk0Wzz4uuPng0EfqDiDSX6pgc1isQK5nYxQS
 EqbsPMsD29LJzd1VG/jxYaIndOrybzMFF7UF9cIczI4Ei2WZcg7R8iQrIICYJMfjYAIBXHxBB4e
 LfQMOEEwh8d6FIoWtyj10VnmeQly8l//xn5nFng==
X-Google-Smtp-Source: AGHT+IGwDSaVmxj7qhmlaJf5knUCYAkQ5zl9fwwLY6pJ9lsWeQHyOslCeXKeMl5Rhmfn0K/i6Cdt7vL3N3F23s9oc5E=
X-Received: by 2002:a05:6a20:6f8a:b0:1c4:f299:70b2 with SMTP id
 adf61e73a8af0-1c8eae85ef0mr3315350637.12.1723635652443; Wed, 14 Aug 2024
 04:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 14 Aug 2024 14:40:16 +0300
Message-ID: <CAC_iWjJ8iCYb0HyaGWq+yCwfPVk25MUsLjdTEjN+ctxdGnrR+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/mkeficapsule: correct printf codes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 10:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> uint64_t is defined as unsigned long long on 32bit ARM.
> Convert uint64_t values to unsigned long long and use %llX for printing.

Why do we need to convert? uint64_t is a fixed width type

Thanks
/Ilias
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
>
>         printf("--------\n");
>         if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTICA=
TION) {
> --
> 2.45.2
>
