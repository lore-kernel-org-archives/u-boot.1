Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50981D132BB
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 12:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9409F8885D;
	Mon,  4 Nov 2024 13:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i+ZFtkYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BBF088C9C; Mon,  4 Nov 2024 13:48:46 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C61088785
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 13:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-290d8d53893so1824660fac.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 04:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730724523; x=1731329323; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxkzUJDM6tyFhlfP3V43VDUy1OBfS1F2OZ+5LKkalbI=;
 b=i+ZFtkYAm4nVWvtRH4R/Lm/uVxkduo1r5aFh8kgUAoCYkgOdF2QR1IsPShWTs3ddWo
 ButyYYn5LIKy6TfK3MffQecmnZXaotO43iyeZyE0DpGZKYjuA4BC7Zw70Mjh2hZFi6PT
 3HIXJie9stOXaVqcniDancVhCCch7ppLhgMOuaeq0H/+45dTrGmRWotQh3yCfbb9s94/
 Z8+cVrV1V5fqdwlHG4meHh5CcF3RahBWO8SnSakKM3a+v6tkSzVdC/5zv1VeGS+q8T29
 qOYDEq8fLniFqn6h/H7jacvL1iYzj5t+d8BitmA6tYDGMhGbczQEmq8PmSXKU8ee964i
 SHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730724523; x=1731329323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxkzUJDM6tyFhlfP3V43VDUy1OBfS1F2OZ+5LKkalbI=;
 b=YBHy+MBXrpMDvzmFJy+J2Ng+TdZUYBRBSjN6m3BitD6rtWJqvzlaPiBzbKLdnB6xw8
 GbgkFYCKfidNwjojFgwZNpaAJSodGIjWInOpXhU12kTYpicaN8NXsMz4Q/8efQCUZ6Nj
 tXXu64kSwQzADcYk5z5wLSNFUK00V58g0aTeSE0qCFwbHzQKH0UvNUMyY1AF+O9TPeUP
 AeY68qAaKT2Kc690yocpYrsF3tLw2A7rrI6pzOqfMw/GMT2LzvKNbJaW7yMPSivK4xBi
 tcYf5aHE8Ys9XwRbkrCvDkWOdXW70HaTK842F3r6Wqs0L/LPgDI/ztDN32gDS2lIYGfD
 cLoA==
X-Gm-Message-State: AOJu0YzJWk9aP1H4EYyhJNzliAKb0ImslFFMBxBEdKvmjPf9xES/pcbM
 LWchtQRk5V6BFBK4clIiw8okh/SrHmo39laqZzVNcNO2X+Sc1plu5xmozb/SsMkkF0Bqsawithm
 rJ7SmG6Ez1lwPBdseJeLY7EOUSEPS2o6veeC6go78L5RdU4TwTMk=
X-Google-Smtp-Source: AGHT+IGfLQOy0Zd5TLOG9r33MZmuo6V2swX/vM0lECD1fImO9le3RZ+F+N8Sq3VAHCNFxj0vjxXfhoNqnZ5nN+HrKhk=
X-Received: by 2002:a05:6870:82a3:b0:25a:eca3:6b5e with SMTP id
 586e51a60fabf-29051ace321mr24500062fac.9.1730724522777; Mon, 04 Nov 2024
 04:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20241101142017.79311-1-abdellatif.elkhlifi@arm.com>
 <20241101142017.79311-2-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20241101142017.79311-2-abdellatif.elkhlifi@arm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Nov 2024 13:48:30 +0100
Message-ID: <CAHUa44HB05JZF7d=KAmNW7tBypRukaA_W6k1DJFg-kpN6v+8Ug@mail.gmail.com>
Subject: Re: [PATCH 1/8] arm_ffa: Add NULL pointer check to the driver
 operations
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de
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

On Fri, Nov 1, 2024 at 3:20=E2=80=AFPM <abdellatif.elkhlifi@arm.com> wrote:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Add NULL pointer check for ops
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> ---
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks good.
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Cheers,
Jens

>
> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware=
/arm-ffa/arm-ffa-uclass.c
> index 96c64964bb7..5ec7654ed1c 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-of=
fice@arm.com>
> + * Copyright 2022-2024 Arm Limited and/or its affiliates <open-source-of=
fice@arm.com>
>   *
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> @@ -954,7 +954,7 @@ int ffa_partition_info_get(struct udevice *dev, const=
 char *uuid_str,
>  {
>         struct ffa_bus_ops *ops =3D ffa_get_ops(dev);
>
> -       if (!ops->partition_info_get)
> +       if (!ops || !ops->partition_info_get)
>                 return -ENOSYS;
>
>         return ops->partition_info_get(dev, uuid_str, sp_count, sp_descs)=
;
> @@ -979,7 +979,7 @@ int ffa_sync_send_receive(struct udevice *dev, u16 ds=
t_part_id,
>  {
>         struct ffa_bus_ops *ops =3D ffa_get_ops(dev);
>
> -       if (!ops->sync_send_receive)
> +       if (!ops || !ops->sync_send_receive)
>                 return -ENOSYS;
>
>         return ops->sync_send_receive(dev, dst_part_id, msg, is_smc64);
> @@ -1000,7 +1000,7 @@ int ffa_rxtx_unmap(struct udevice *dev)
>  {
>         struct ffa_bus_ops *ops =3D ffa_get_ops(dev);
>
> -       if (!ops->rxtx_unmap)
> +       if (!ops || !ops->rxtx_unmap)
>                 return -ENOSYS;
>
>         return ops->rxtx_unmap(dev);
> --
> 2.25.1
>
