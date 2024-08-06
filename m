Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A557C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712CD88AE4;
	Tue,  6 Aug 2024 23:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eaGyFaEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A195B88AE4; Tue,  6 Aug 2024 23:51:06 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8553088AF6
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2cb4b6ecb3dso928796a91.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981055; x=1723585855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uGk6aWjX4IKbybBy80Xj6ulpGi50aYumOf+CiG47ol0=;
 b=eaGyFaEJNfyHJtMy0sWF43ZTPvPyDA70zjNqGxXgSd/O1HPAbuxKaoFxe0dOmzIa60
 CYCw5fN4t9ac1bjiYzWgtFI1RaljB9aENe4BGw+l9nl2TEfdF99B4yRvG35MnzywXYZK
 L/oGGFsD4HPFW39P2MQZgwCT6V5lFLZODyWVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981055; x=1723585855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uGk6aWjX4IKbybBy80Xj6ulpGi50aYumOf+CiG47ol0=;
 b=KVSjO0CwzvHquIVVoPq/DkFw+KeQn0SsOL892+Zm2FucF36zWCl4l64FFKH1u9w5c/
 OORuZfDHDMQj1+tGtV01M4RmAPj2PVJbBIb0PCfl/zY+64G4I5vqBG06e+iE71W5mN89
 LrtyvI4LohJESHRZnE28RzKBea7h2JvvVKbHcXzyLqfp5vm1imer+Z+07VpH9PIOG4uM
 uThYMWTMHoe95FhM6xNBORHykPgr1ZRxLtojzDIvE0KkZkvB+G0rsU2IfAa1hVHR5H2X
 wWpN+7iNaXRnXAdTDjqbSWfrjB7lOaxBTi6tBmwgnKdylPp3j+qhBZnrVcj3xWCmXKIe
 zL7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWduZswGdr7OC9oP05vYDQXk8P7rX5RquAJGE/DP4NfvIFBguflPGCwYq27HygDG2UbhZoV0BnbZAzrex0K3r29jcKd+w==
X-Gm-Message-State: AOJu0YzZNJ/OGpjtnsK7b//RX57+WNda7aVqLFT7xa6DkSBnk+Sjn3zJ
 wTKaNO6MbiPrDt4N+jUUjCciz9A0zc244wz3MwiaeXPIE/WVWpe918FNcME2JRdlpZ4gP34wMt1
 5jGy2vI1HpOAHD4vpTBjNi9uj6puliZOV+7QQ
X-Google-Smtp-Source: AGHT+IFHKVTcuBKddoSpxfJMm4DU41C1r+4aA5aPEbJnEgu4rbQyTxrjeTivhi0eWsU4u4YdK4cMnFjKR5nmXFYJQM8=
X-Received: by 2002:a17:90b:1e43:b0:2cd:3e75:4e51 with SMTP id
 98e67ed59e1d1-2cff955d116mr17298433a91.39.1722981055067; Tue, 06 Aug 2024
 14:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240802092820.917450-1-admin@hifiphile.com>
 <20240802092820.917450-2-admin@hifiphile.com>
In-Reply-To: <20240802092820.917450-2-admin@hifiphile.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:42 -0600
Message-ID: <CAFLszTj8Cci7_6vpZ+NXndzKxxvAW6oY9BskFjgji=oi1UtPWA@mail.gmail.com>
Subject: Re: [PATCH] dm: core: Show device sequence instead in dm_dump_tree()
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 2 Aug 2024 at 03:31, Zixun LI <admin@hifiphile.com> wrote:
>
> Currently uclass index is shown in DM tree dump which ignores alias
> sequence numbering. The result could be confusing since these 2 numbers
> could be different. Show device sequence number instead as it's more
> meaningful.
>
> Also update documentation to use sequence number.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  doc/usage/cmd/dm.rst | 7 +++----
>  drivers/core/dump.c  | 4 ++--
>  2 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
> index 7651507937..196b22d137 100644
> --- a/doc/usage/cmd/dm.rst
> +++ b/doc/usage/cmd/dm.rst
> @@ -112,9 +112,8 @@ This shows the full tree of devices including the following fields:
>  uclass
>      Shows the name of the uclass for the device
>
> -Index
> -    Shows the index number of the device, within the uclass. This shows the
> -    ordering within the uclass, but not the sequence number.
> +Seq
> +    Shows the sequence number of the device, within the uclass.
>
>  Probed
>      Shows `+` if the device is active
> @@ -366,7 +365,7 @@ dm tree
>  This example shows the abridged sandbox output::
>
>      => dm tree
> -    Class     Index  Probed  Driver                Name
> +    Class     Seq    Probed  Driver                Name
>      -----------------------------------------------------------
>      root          0  [ + ]   root_driver           root_driver
>      demo          0  [   ]   demo_shape_drv        |-- demo_shape_drv
> diff --git a/drivers/core/dump.c b/drivers/core/dump.c
> index 5ec30d5b3c..5cbaa97fa3 100644
> --- a/drivers/core/dump.c
> +++ b/drivers/core/dump.c
> @@ -40,7 +40,7 @@ static void show_devices(struct udevice *dev, int depth, int last_flag,
>         /* print the first 20 characters to not break the tree-format. */
>         printf(CONFIG_IS_ENABLED(USE_TINY_PRINTF) ? " %s  %d  [ %c ]   %s  " :
>                " %-10.10s  %3d  [ %c ]   %-20.20s  ", dev->uclass->uc_drv->name,
> -              dev_get_uclass_index(dev, NULL),
> +              dev->seq_,
>                flags & DM_FLAG_ACTIVATED ? '+' : ' ', dev->driver->name);
>
>         for (i = depth; i >= 0; i--) {
> @@ -129,7 +129,7 @@ void dm_dump_tree(char *dev_name, bool extended, bool sort)
>  {
>         struct udevice *root;
>
> -       printf(" Class     Index  Probed  Driver                Name\n");
> +       printf(" Class     Seq    Probed  Driver                Name\n");
>         printf("-----------------------------------------------------------\n");
>
>         root = dm_root();
> --
> 2.45.2
>
