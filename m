Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F79AD58D4C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A5A899D0;
	Mon, 25 Nov 2024 14:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P0HiWWld";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39CA48997F; Mon, 25 Nov 2024 14:41:17 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F5389A1E
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 14:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ea39f39666so3486300a91.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732542072; x=1733146872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zL3YQhdMdt04OBP+hyfYs+7P9yJ3+qbMjVMVh6nmsAI=;
 b=P0HiWWldSTj2QwU8/bYO9lpOY7XZU9cMJGhelidyzNplQqG58PJ6krh4+N+IXGkc+R
 dP0hij0Pfgy8Z/KC7pdPkJ9gFONf4fnRBjeNXJxt8I3bvwZcxwbW+fljgQCxxF7zw7KL
 prahK0x99zVRiD2I/GQoqEka3y2WdDLsKNXQU5NzMKqldWAy4cAZKagge0NOUVP6Zbdd
 jEtDdoeKAubEGYsx446ZH7UDKaaHredBWBeBAaAgDP4M5pKJUNaGpzI4AcFQbG5JYpHd
 faLGozy2KJpH5bboiJ4GQ21dKg+TLRqP8852lWjn400YxktA1YakQpQfxu9sCQBQPhpj
 wnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732542072; x=1733146872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zL3YQhdMdt04OBP+hyfYs+7P9yJ3+qbMjVMVh6nmsAI=;
 b=mOmdAcH7mh43M8X0OdC7U+7TvxP2GPTni9wcdgYKQTHiyLnTnP9Gvax+PWBCceUAuq
 VG743MdHIHObpRM/ENuMyVUFpyOWsM0wqiIVDke5vetlfbMQoCO2P5jNae6YQ91i8bcP
 RudyADIRyfJ8W20vfmLyccA63/vtqCQJDdMQK3pMMlu4Gss+ph0nR1ww9jDRYGUdM5cT
 Ts6pk4xZdztFJXt/lKohpKbFE+Qfa7XYih/ca8fGM26e5bAH30zI7Ww0yrlUxUXYh1gU
 TVtVyFnuicHA/dtsnsjQB5zwXuzj68rSpMFBi+LyBRNdhnUnn2DO4751Cvi2OE/Pms5V
 cRBw==
X-Gm-Message-State: AOJu0YxobBYVaHvpMEV36BqmA8p7xFTwMUfheQIIiNzVnyxmnCoWcB7I
 6zlEVxih3b0xNyUzXfKp5cF9UJHrczce2z2VZo2HWwVUOImOsDi8zURal3YO45wn3dsvExGmVpK
 D0rhzbCnH4wNNWwrIUi62Mmmkyskwf8P6+uEf7A==
X-Gm-Gg: ASbGncvD5r/4WDx/vdFVYyVcWrWiv/AiRUySv+extxSkmjKq9DC+zBnnzuL6tWwBsy4
 R55+668hjeqly4NaBmCTsz1F0tKL/+A==
X-Google-Smtp-Source: AGHT+IGDdhZoy9LJmQH8gnD+JIiFCfqG404SEIkI5QnYydQ2NzaS04M/G5Qf47IAyN7vFqJe3w7IFyKK3wpKicIt9yo=
X-Received: by 2002:a17:90b:38cc:b0:2ea:3f34:f18e with SMTP id
 98e67ed59e1d1-2eb0e866c8emr14921165a91.23.1732542070939; Mon, 25 Nov 2024
 05:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-10-mjg59@srcf.ucam.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Nov 2024 15:40:33 +0200
Message-ID: <CAC_iWj+-wS9Kc4PJCi07q+LuJ172wSD5S4-moEFkst236wOJsg@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Matthew Garrett <mgarrett@aurora.tech>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Matthew, Janis,

On Sat, 23 Nov 2024 at 21:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Janis Danisevskis <jdanisevskis@aurora.tech>
>
> efi_bind_block had two issues.
> 1. A pointer to a the stack was inserted as plat structure and thus used
> beyond its life time.

Yep and I wonder how the device_unbind() code managed to survice since
it free that stack allocated memory...
Probably never called.

> 2. Only the first segment of the device path was copied into the
> platfom data structure resulting in an unterminated device path.
>
> Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> index 9704020b749..cc91e1d74b8 100644
> --- a/lib/efi/efi_app_init.c
> +++ b/lib/efi/efi_app_init.c
> @@ -19,6 +19,15 @@
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> +static size_t device_path_length(const struct efi_device_path *device_path)
> +{
> +       const struct efi_device_path *d;
> +
> +       for (d = device_path; d->type != DEVICE_PATH_TYPE_END; d = (void *)d + d->length) {
> +       }
> +       return (void *)d - (void *)device_path + d->length;
> +}

We already define efi_dp_size(), you can use that here.

> +
>  /**
>   * efi_bind_block() - bind a new block device to an EFI device
>   *
> @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
>                    struct efi_device_path *device_path, int len,
>                    struct udevice **devp)
>  {
> -       struct efi_media_plat plat;
> +       struct efi_media_plat *plat;
>         struct udevice *dev;
>         char name[18];
>         int ret;
> -
> -       plat.handle = handle;
> -       plat.blkio = blkio;
> -       plat.device_path = malloc(device_path->length);
> -       if (!plat.device_path)
> +       size_t device_path_len = device_path_length(device_path);
> +
> +       plat = malloc(sizeof(struct efi_media_plat));
> +       if (!plat)
> +               return log_msg_ret("plat", -ENOMEM);
> +       plat->handle = handle;
> +       plat->blkio = blkio;
> +       plat->device_path = malloc(device_path_len);
> +       if (!plat->device_path)

you need to free plat here now

>                 return log_msg_ret("path", -ENOMEM);
> -       memcpy(plat.device_path, device_path, device_path->length);
> +       memcpy(plat->device_path, device_path, device_path_len);
>         ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
> -                         &plat, ofnode_null(), &dev);
> +                         plat, ofnode_null(), &dev);
>         if (ret)
>                 return log_msg_ret("bind", ret);
>
> --
> 2.47.0
>

Thanks
/Ilias
