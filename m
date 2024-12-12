Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349C8E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 07:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E47800D9;
	Thu, 12 Dec 2024 08:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R7OaDXeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC74800DF; Thu, 12 Dec 2024 08:41:27 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 403E5800D6
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3fd6cd9ef7so185101276.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733989284; x=1734594084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sq4Go58qR83auWRU5mHloXbNNsXMb75Fi2L/pQivj3A=;
 b=R7OaDXeB2aQkaG8I9hUaU12t3T1xrtiFjV8xzLERoV7YhyrSG0Or8yEYGqQUzasqWK
 MDS4GMxqx085qAMA8mF3PYxrOqnlWfQYtJqzp3R7IIbZdUGD2Ib0NTjtoHFoJ3AEHIYh
 09smHSuhs8WxzCmlRmmZ1+PpQ72SBFMTI+PINayL3tUJq/PBif8oiaxLAlk7OMUkevmW
 3o0F8iVYSCX9ti4zZLQlK2Z0Tx2ZN+bDhQY1LaiZU8O1d3GZvOuQEKzmlBjFhjAFIjY0
 5bn+eSCOua0dsNMztnsX/91/kPvaWiBs4E9sHMQ+5be+A6q5w7vmjnXgJQ2VecbW4hrj
 OJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733989284; x=1734594084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sq4Go58qR83auWRU5mHloXbNNsXMb75Fi2L/pQivj3A=;
 b=FcbCmTXGoeTRYKo1tWdjJLgedorwS5m5HvZ3dm9NaAm1GuqrRH8416iFbXSieRgeKE
 XvHqhVZv8HBB2Ey3IqridYTpof3/x4DdBxLTMlk+2mVQMN0Yzk2jwEMWiTo0QZbtNPi0
 yodxfkp7WhOR2heL1hBsgpLQiQZA8xrbTDZgqRXK05f61KamkD4PWg7i0df5AX3xGfMU
 MdnrLUwPZrH1wKewI0nIZ3GAwf7JGALEsE4XWCCfeLBnawZTqyuIzR5MLl9VlRmVzGBE
 fcN/hXDjU3rr88mYacRgnTrVLaxLxgbCv1nRJ/DklnF6oct5+Bza5uDG5ML245vkfxoJ
 be5Q==
X-Gm-Message-State: AOJu0YzJnRIf6FHtE96dYXT/ssPIPVk1ojSRYd+/Zdg20BJo+gyKiJLa
 MNh0pXZnEUol4ZXCREF1qImJo8P6pvLGISHUWjU6eA6ookmpWgfKHiPHEkylu/LFJToU1QsHyMP
 TcFJhhtnXc0j71xuyUfUIht1zBeaOdmAN21eR6A==
X-Gm-Gg: ASbGncuONTexOojUI3V4C/7gQmnWQVpdmJs3gSjfHDzvP/XKfZaK27/YPHKHQ7XlKKl
 /3+tl14fbakg9jftzikbHTNapU58K5bHL6ymdRQ==
X-Google-Smtp-Source: AGHT+IEzDzKCKGJ5GjRoWOFDfUSfT4G97WpDr3UxgHodIDFlnkDU4oLIpZQ7OylgTmgSw7pkchSx6k+YbRHdJyemOa8=
X-Received: by 2002:a5b:bcf:0:b0:e30:cc41:2abe with SMTP id
 3f1490d57ef6-e3dda4c75d7mr1518152276.16.1733989284039; Wed, 11 Dec 2024
 23:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-2-sjg@chromium.org>
In-Reply-To: <20241211223822.2446254-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 12 Dec 2024 09:40:48 +0200
Message-ID: <CAC_iWj+CpxZ4nd9Y+k+=2cEuWMGknPjqtHt+hvkJ+vEW9kGv_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] efi_loader: Refactor device and image paths into a
 function
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>
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

Hi Simon,

On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
>
> Move this code into a function so it can be called from elsewhere.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_bootbin.c | 53 +++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 7e7a6bf31aa..afb13a008c2 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -44,12 +44,46 @@ void efi_clear_bootdev(void)
>         image_size = 0;
>  }
>
> +efi_status_t calculate_paths(const char *dev, const char *devnr, const char *path,
> +                            struct efi_device_path **device_pathp,
> +                            struct efi_device_path **image_pathp)
> +
> +{
> +       struct efi_device_path *image, *device;
> +       efi_status_t ret;
> +
> +       ret = efi_dp_from_name(dev, devnr, path, &device, &image);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
> +       *device_pathp = device;
> +       if (image) {
> +               /* FIXME: image should not contain device */
> +               struct efi_device_path *image_tmp = image;
> +
> +               efi_dp_split_file_path(image, &device, &image);
> +               efi_free_pool(image_tmp);
> +       }
> +       *image_pathp = image;
> +       log_debug("- boot device %pD\n", device);
> +       if (image)
> +               log_debug("- image %pD\n", image);
> +
> +       return EFI_SUCCESS;
> +}


This needs an entry in a header file and a description. Also, we
usually keep DP related functions to lib/efi_loader/efi_device_path.c

[...]

Thanks
/Ilias
