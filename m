Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CA7C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 892E8889B4;
	Tue, 16 Jul 2024 09:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A1rQEUJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B106788939; Tue, 16 Jul 2024 09:42:43 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C398B889B8
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so40304115e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115761; x=1721720561;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0CtHy6ynGzTD69LPMShq33Su3UWWYmfkdf4SkJhcMP0=;
 b=A1rQEUJlRHR6xG4hnr51ds8/5B8XD02D09UljQ+GL2aKcP/pH/ezu+W2F9xLJrhBID
 r2Zi4EO13GdkhF+YuTeoc4cZ51d6dxN23VjJtEp7xB779b4v9vO65m8tZkwR98ZymHhj
 gKAxT2EhMpW0IGvQgjEjfHi0F/SJRhoxY2tyfwV/2FGi0IPCWk3LXvG/I7W38oOlrCEM
 5h7SgOFiUA5/w3ISbJu5YoeckDV8NpLFuzlfmCZXOcbYBUH6aWtvhEnAwA1JHDaTIVSn
 OD46WbGnRaWLIXZzWT3IxnKxwXuG5fpBu8cOtwx7aQ42ZxkUon6cJF3oWS/TUvZ5BYzI
 VS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115761; x=1721720561;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0CtHy6ynGzTD69LPMShq33Su3UWWYmfkdf4SkJhcMP0=;
 b=LrT5HI5Q+k4GdvJddqvOJp/aGeO8XO24JO4pyHk7OFiEqD8NeUoe5IV75/zT1ulfF8
 KiMYApjinW26nx94ufW8UmYdUyFxG8vHFSXipadvGblOMM34klIiYgoekdyh3zUG1e32
 z+QS2TIjsbZDyiwNUw51MjOnOklbIHcoaL4AZMzQ7yq+0afZjvdJxYrfMxs28QySzsjp
 cH96qqG4L1M5Lb+C6lk8TNlMWkIbYMxEeQaVk0MztrMnzz96qzyXi8XJbEIFfAVnmj9H
 yj5g4PIG1Hs3zJFNdJrQ11AnfqBPldp9qKqtzai36AXupDx5O9Ekw2DwzmXb3+KlFJNv
 366Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW+/iNWjo41d9D6D1KChe9kQk68lfJYjaZe4SPbhn+99BnN7V7gOcQMyqWLoVS0AvbzH2KgYsOmgwovNfI35TkQfFBag==
X-Gm-Message-State: AOJu0YxBkNu1sDrSppbvt7kjXnS/iS3gHt0dHQTzkh1CbEGzIlOJ8jE0
 AJgxce63y15qS0cYM7e+XqBroTOTpFQrCapGDVOzDS+6jfcrpTXLSUGA96XI0Pc=
X-Google-Smtp-Source: AGHT+IF/iyxMN+NIBEhZZXiBfe37b4Y1Mqv2/gUmMheouRjWveTyc7OhMWwqKTDtdvQlzpy59LiKfQ==
X-Received: by 2002:a05:600c:1ca5:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-427ba6f2dc6mr9955475e9.30.1721115760925; 
 Tue, 16 Jul 2024 00:42:40 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27846bsm147719425e9.25.2024.07.16.00.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:42:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 09/14] bootstd: Tidy up comments on the boothmeth
 drivers
In-Reply-To: <20240716070419.1897560-10-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-10-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:42:37 +0200
Message-ID: <87ikx5n5oy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Thank you for the patch.

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> Fix a typo in the comment and add one to the EFI driver too.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  boot/bootmeth_efi.c      | 1 +
>  boot/bootmeth_extlinux.c | 2 +-
>  boot/bootmeth_script.c   | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 5a4c125835a..56a6e47f5b2 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -394,6 +394,7 @@ static const struct udevice_id distro_efi_bootmeth_ids[] = {
>  	{ }
>  };
>  
> +/* Put a number before 'efi' to provide a default ordering */
>  U_BOOT_DRIVER(bootmeth_4efi) = {
>  	.name		= "bootmeth_efi",
>  	.id		= UCLASS_BOOTMETH,
> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> index 9b55686948f..fbb05ef928e 100644
> --- a/boot/bootmeth_extlinux.c
> +++ b/boot/bootmeth_extlinux.c
> @@ -183,7 +183,7 @@ static const struct udevice_id extlinux_bootmeth_ids[] = {
>  	{ }
>  };
>  
> -/* Put an number before 'extlinux' to provide a default ordering */
> +/* Put a number before 'extlinux' to provide a default ordering */
>  U_BOOT_DRIVER(bootmeth_1extlinux) = {
>  	.name		= "bootmeth_extlinux",
>  	.id		= UCLASS_BOOTMETH,
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 0e05d28d4d9..24da47c7259 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -250,7 +250,7 @@ static const struct udevice_id script_bootmeth_ids[] = {
>  	{ }
>  };
>  
> -/* Put an number before 'script' to provide a default ordering */
> +/* Put a number before 'script' to provide a default ordering */
>  U_BOOT_DRIVER(bootmeth_2script) = {
>  	.name		= "bootmeth_script",
>  	.id		= UCLASS_BOOTMETH,
> -- 
> 2.34.1
