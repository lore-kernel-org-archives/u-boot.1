Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9132C2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63DA58832D;
	Mon, 17 Jun 2024 15:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nkYHUPgS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674E78835D; Mon, 17 Jun 2024 15:53:44 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10710882FE
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-62ffc495935so45949777b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718632421; x=1719237221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Nos9FoyWcD5fiYt+Mid6Lk1MgEaE/EY2unqIMiJteI=;
 b=nkYHUPgSAIPneXw9Fv7TpHTGQwI59PsA+pIWoErwTjlzKTRIBesEbDpYm79xMlchbY
 ZDK7N+kxixIs9mnXQe0iHh0pIx0Gl1eeu2yPWVsIUoGz9b4prKXifpmjDNAQOKIP74Us
 eKblGeXDH/JDUBQKXsRdcQ3y1AlJhlvYk9vYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718632421; x=1719237221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Nos9FoyWcD5fiYt+Mid6Lk1MgEaE/EY2unqIMiJteI=;
 b=plwHsPlhXGSs2UN8kIcyk/HycoWOMiXuQjFYURO5s+LF3dLNfYyNzKpWCwuUpgIXfM
 ushA2d54fBi3rUOMz0HNCl5TeB+5bljrA/sUicI/Zlj/75jvjfuviw3JT1S1rndomdig
 nZvqld8UKBEjYznsznIXVMCPNkufpxL/Yr4SXib64PATca6W4xpzxIY/B89BOeq9VIPx
 veGVVXEq0HsVGBKTUAwlxqPx3bfQlH8zxNJfCA6uZgYP7PhFNyWR6AtkTf505jyIRZ52
 3t75XGXA04rQq+Kk5UT3kRxROtEoSHWgxhdDdjHJkCm9jrbaG0QUltV0V04uzdfg2jNO
 taJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPEAGKn2quVevXgAKy5O8M6h8vAArxYHSxMQhNpC7J3o1D7imxsKLHnFqubqvbVZsEI7K8h5b49b5i2jA+Qr2Ox3pfJw==
X-Gm-Message-State: AOJu0Yy6oH7RPBRx1khfw2Mx8Zd7C1gUU0Mrz/xviXCdb3E1l+l0+L+g
 +HBC6jT4I853ESl9QOmcSL/SSgKvVi5GaLU4wA0IyUTRp72Za3eYtVs7fJJQ2pYI+JiZOClW520
 dYM13v0o7/kmxQGtVG6R6QWvcrR4WKxkLfnBo
X-Google-Smtp-Source: AGHT+IGu4/grWc8cE9zn6eT9VkEpZdKxz65L9d997cAtV61TRdngmuW/6TQtPQhYXbxykCG78uzpWoCQuHpZnueeVgk=
X-Received: by 2002:a0d:fdc2:0:b0:627:7f2a:3b0a with SMTP id
 00721157ae682-6322354a8f9mr84779227b3.31.1718632420926; Mon, 17 Jun 2024
 06:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240613080604.3828083-1-d-gole@ti.com>
In-Reply-To: <20240613080604.3828083-1-d-gole@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Jun 2024 07:53:30 -0600
Message-ID: <CAFLszTji3HoiGk46hRsAka=PT-zf5suC9iCei5SEsC8QJdE5Jg@mail.gmail.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
To: Dhruva Gole <d-gole@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Vibhore Vardhan <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nishant Menon <nm@ti.com>, c-shilwant@ti.com, 
 m-chawdhry@ti.com, vigneshr@ti.com, Judith Mendez <jm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>
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

Hi Dhruva,

On Thu, 13 Jun 2024 at 02:06, Dhruva Gole <d-gole@ti.com> wrote:
>
> The Kernel Image and DTB files are supposed to be picked from the rootfs
> of the SD Card, this fails in legacy boot flow because bootpart is set
> to 1:1. Fix it.
>
> Fixes: a200f428b5b21 ("board: ti: am62x: Add am62x_beagleplay_* defconfigs and env file")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  board/beagle/beagleplay/beagleplay.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

What is the legacy boot flow?

> diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
> index bbf6b925d02c..190181c8ad0c 100644
> --- a/board/beagle/beagleplay/beagleplay.env
> +++ b/board/beagle/beagleplay/beagleplay.env
> @@ -11,7 +11,7 @@ set_led_state_start_load=led led-0 on; led led-1 off;
>         led led-2 on; led led-3 off; led led-4 on
>  boot=mmc
>  mmcdev=1
> -bootpart=1:1
> +bootpart=1:2
>  bootdir=/boot
>  boot_targets=mmc1 mmc0
>  bootmeths=script extlinux efi pxe
> --
> 2.34.1
>

Regards,
Simon
