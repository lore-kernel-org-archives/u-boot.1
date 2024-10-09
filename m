Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56061CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD4B89023;
	Wed,  9 Oct 2024 03:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iL+QcHkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE7A89023; Wed,  9 Oct 2024 03:51:55 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 434F689041
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e06ba441cso2109824b3a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438709; x=1729043509; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+ZOqTcYbCmzteEZTtGZ2lZGL1Nm8AehlDnY4ivDKW4=;
 b=iL+QcHkE0E3rYn5zpljb9iE7m4Ryrq7zkd7QElhWUaQ1qd65C20NUKE3JB6ui48f5c
 Q5qO/wIqSLnYJRZqz6N87mGXOVd2VWZQGivmrV/rTweL0vQRYQ8D/VgD4Turqmvqsx6K
 ba8TxjEii+uKHsZAIoEVT79Bo1nMsHY7s8OCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438709; x=1729043509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+ZOqTcYbCmzteEZTtGZ2lZGL1Nm8AehlDnY4ivDKW4=;
 b=t2WZBWJioTZOClC7F2QrUw7kwUJ6vL3Lct3wIvAhn5eY1tZg87KwhefT3avtl9GVM5
 Belrc8/ykLoln8wKVhnGhJFYdK3d8Xd+M/VLLJt1oO7FzoH5hKAbd5EEPv6LMatvoRKp
 XCLIO5SlMvSvwRV2wKRtM7M0DvBCJh1Aj281DkGFp5m3iGGetB/8FXXdSiikkPRgPykQ
 qiz237ENfOVHxmYNVB24TCV6RRNIYxy2X8wrMO/PYzcf6HzOuNvx+TbzeeKEs0/xJf7q
 O3Gtz5T09uZtpUQnWXOVfDVb9X2LeQAM7uryKwfaqYzWS4TaHgXVxySJ6X9Ndf1gppSC
 5iNQ==
X-Gm-Message-State: AOJu0YwMxmPyVun+d1H4u0EUJpdsLqPlVA20XwPBbD2ciOQ/G/vm/zzo
 GgzIePppP23GUUTotlbeC45bgAoCLvErsDZkq2Fsi4+0aDT1Zs+JQbo02MBZJikbWF8oTiA9ec+
 10Ib6HwYE8AMbGYxqG9/z/lolnnZLRDUg5bQf
X-Google-Smtp-Source: AGHT+IHX90gb8IZd6X2EaPDPT/DuvPAWDhykaRiM7TE+zAufD2FkE8Bt2XOJ6TOoyej/UWMyUnSInov4xqLi8K/pM9M=
X-Received: by 2002:a05:6a00:3d51:b0:71e:f7d:5c64 with SMTP id
 d2e1a72fcca58-71e1db648bamr1260713b3a.6.1728438708694; Tue, 08 Oct 2024
 18:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241003141029.920035-1-ravi@prevas.dk>
 <20241003141029.920035-4-ravi@prevas.dk>
In-Reply-To: <20241003141029.920035-4-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:04 -0600
Message-ID: <CAFLszThL0DYTkeu682Fk_V+4nKV81Zpef23E8_bn9w_aC3SPuA@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: add build-time sanity check of
 CONFIG_SERIAL_RX_BUFFER_SIZE
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 08:11, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> The help text says it must be a power of 2, and the implementation
> does rely on that. Enforce it.
>
> A violation gives a wall of text, but the last few lines should be
> reasonably obvious:
>
> drivers/serial/serial-uclass.c:334:9: note: in expansion of macro =E2=80=
=98BUILD_BUG_ON_NOT_POWER_OF_2=E2=80=99
>   334 |         BUILD_BUG_ON_NOT_POWER_OF_2(CONFIG_SERIAL_RX_BUFFER_SIZE)=
;
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/serial/serial-uclass.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclas=
s.c
> index 28d7a202afc..484f0f7d3e8 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -18,6 +18,7 @@
>  #include <dm/lists.h>
>  #include <dm/device-internal.h>
>  #include <dm/of_access.h>
> +#include <linux/build_bug.h>
>  #include <linux/delay.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -330,6 +331,8 @@ static int _serial_tstc(struct udevice *dev)
>         struct serial_dev_priv *upriv =3D dev_get_uclass_priv(dev);
>         uint wr, avail;
>
> +       BUILD_BUG_ON_NOT_POWER_OF_2(CONFIG_SERIAL_RX_BUFFER_SIZE);
> +
>         /* Read all available chars into the RX buffer while there's room=
 */
>         avail =3D CONFIG_SERIAL_RX_BUFFER_SIZE - (upriv->wr_ptr - upriv->=
rd_ptr);
>         while (avail-- && __serial_tstc(dev)) {
> --
> 2.46.2
>
