Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1C9CA0ECD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DE888D43;
	Fri, 30 Aug 2024 03:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WHfPCzSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B8188D3D; Fri, 30 Aug 2024 03:06:20 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC65588D17
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf9db9740aso6390676d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979977; x=1725584777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zuP6YTbr9o7wHl/8TqMIXzszg1I9H7mM3WPQbrILYv8=;
 b=WHfPCzSwKUcVUHKwejAgpcIfWwbu8+D+j7VgTjIMJbuvr23FAumsMAUfhy+R0z5WOi
 iZgVOrTi4ED5IyMgrC7mX0JgpHcEmBWgFrJwS1FbRX7Rc0EoM9uMJ16YJeqL4DeuRO22
 VPzAfiBIfr7XrmSgoCQDTJhIsR6qsO3FvsU58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979977; x=1725584777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zuP6YTbr9o7wHl/8TqMIXzszg1I9H7mM3WPQbrILYv8=;
 b=O2mBXSqo5RyWtfxlQhGOQYRcb8SwlQrjUs344TF2jL6EHBk4noGLKAKGb1fhQmpBrt
 nAD4iZ4eQ82PZwust24+o017mYcIStJKMoPdo12jTfwXVLqT3FWRmwa5gEv9Y6tUYvIP
 J5ffwM2jJf3l09Qul2KuM98+Jz6ESkeZiXWzarNplVTyAVmHQKoW1nAvVtSADH1DI2ja
 8e3O9ydloklWzTVHO4CXibjruT8Cu9tgC8/Rdz0h2vIFcrEiVjoEwt45w+d0Xw+OKuhV
 CEOWH2zPBJaWT+bJ2QUCwIGjG0ZA7ReCtMiFAj3aSl9ykJW9NMcPIrwfiPSqmOgUz7yN
 8KXw==
X-Gm-Message-State: AOJu0YxHs80mHBzXWcpLgzNDO3zmsZIh51nPBAfjcNRSy4DLh1D7M5Wx
 pADXArmM6eb7VvdMHNLVd1+z6zioKylF+6MOGGEV5x30mgPQEfPqh9DOo2gCeMAAyELK7K/BKzR
 VjnOQIxALD5JAlOiQQiHYcNoz8zG6FPvmR0YxeVH2lAHHC0Y=
X-Google-Smtp-Source: AGHT+IEi20SeUXIUTSl+e7rozTYbjhJT7zmrZ73Tc2QZfzyZWVzrZFbgFi0CcaOpAZamI5ohI+B2TgcpyhOu05WpDQ4=
X-Received: by 2002:a05:6214:2f0f:b0:6bb:79b4:156a with SMTP id
 6a1803df08f44-6c33e6439bcmr53875296d6.27.1724979977570; Thu, 29 Aug 2024
 18:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240829185602.3179812-1-trini@konsulko.com>
In-Reply-To: <20240829185602.3179812-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:06:06 -0600
Message-ID: <CAFLszThtfWK7pm-JV35Z083G43TL3ySfcuX9a83-rcMHmh=OnA@mail.gmail.com>
Subject: Re: [u-boot-test-hooks][PATCH 1/2] bin/writer.rpi_mount: Use kernel=
 and simplify logic
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 29 Aug 2024 at 12:56, Tom Rini <trini@konsulko.com> wrote:
>
> Rather than guess what we need to name our u-boot.bin file as for it to
> boot make use of the kernel= option to always call it u-boot.bin and
> then on 64bit platforms (and since future platforms use rpi_arm64 this
> list should not grow) also pass in arm_64bit=1.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  bin/writer.rpi_mount | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/bin/writer.rpi_mount b/bin/writer.rpi_mount
> index 73fb8bf6af04..ab7c3b5a2430 100755
> --- a/bin/writer.rpi_mount
> +++ b/bin/writer.rpi_mount
> @@ -25,30 +25,17 @@ build=${U_BOOT_BUILD_DIR}
>
>  echo "Writing to ${mount_dir} from build at ${build}"
>
> +sudo cp -v ${build}/u-boot.bin ${mount_dir}/u-boot.bin
> +
> +echo "enable_uart=1" | sudo tee ${mount_dir}/config.txt
> +echo "kernel=u-boot.bin" | sudo tee -a ${mount_dir}/config.txt

Does this keep appending more and more lines?

> +
>  case "${board_type}" in
> -rpi)
> -    kernel_dst=kernel.img
> -    ;;
> -rpi_2)
> -    kernel_dst=kernel7.img
> -    ;;
>  rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
> -    kernel_dst=kernel8.img
> -    ;;
> -rpi_3_32b|rpi_4_32b)
> -    kernel_dst=kernel8-32.img
> -    ;;
> -*)
> -    echo Unknown Pi \""${board_type}"\"
> -    exit 1
> +    echo "arm_64bit=1" | sudo tee -a ${mount_dir}/config.txt
>      ;;
>  esac
>
> -sudo rm -f ${mount_dir}/kernel*img
> -sudo cp -v ${build}/u-boot.bin ${mount_dir}/${kernel_dst}
> -
> -echo "enable_uart=1" | sudo tee ${mount_dir}/config.txt
> -
>  case "${board_ident}" in
>  3-32-pl011)
>      echo "dtoverlay=pi3-miniuart-bt" | sudo tee -a ${mount_dir}/config.txt
> --
> 2.34.1
>

Regards,
Simon
