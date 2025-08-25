Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0EDCA0EED
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 02:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E258082E37;
	Mon, 25 Aug 2025 04:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUpRa3ov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9FA383013; Mon, 25 Aug 2025 04:17:26 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E0182DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 04:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-333f92a69d4so28358621fa.2
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 19:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756088244; x=1756693044; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bp2cXfifYZg9P1A6IYwLKTDGBvgayv2zW82Fwpi0JDk=;
 b=GUpRa3ovCpQqsjA9BUNAC7PXBPO2BFtKmAnK4TGvUcIYNfMo1kUnBPXv8bz+xHeuuH
 31ut7kXsj0kuXRJ+OPVFtpB1EJtE3BLwf6v7KEdx7Fi0pyCUEQFz4rkoMWMu6F7TuVYp
 YBt4PN0jBcTLRO1ibg8YXR3kq1aTERtPFN8enO89qQN59hPzfb9fw38VJxLIRCwLZpHB
 /WNdXrmG5f7MPT/PbaiuIEFJ1NrLKUrvakyLamgrL3xa/xAOfL+mnccn6VUQ7tsocoQQ
 w8wHNauwbOLjH2D5zCpZpSs8qcmU5qSem3eKCs4MVBMufVzq3UExYM39AMBJQtTAKtBg
 Kqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756088244; x=1756693044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bp2cXfifYZg9P1A6IYwLKTDGBvgayv2zW82Fwpi0JDk=;
 b=OI6YDrAogiPh9nUJfdS0ydl17UurNCuSkOq6XyM8zZxs5+5ueqaLJpvlHLAU0aKhUd
 2ZpyRM0F5pnjtwkxcbXVlOanLq6+vthG4vGMNHi9trB5vMSEg4yfdnxGjRpXJrtYw8Fj
 oIKZgpmW0Voc5sNFi8HRfCyj19vHs9ho629hFPaLdswnGxnOn7UoFnWFaqVracbVZ2B2
 SpyNgHmV+Ak/Ez1VivOPF+BdQGBs/zo2qOuyO6efhjvoURuZHFl0dkjquBfcjVv7gbk/
 BEQmhX6kAXyme9rRPtt77AEqP5myEbefC8+3XL6BkF8zjuKplUxI00VCDqRA8DToC3C9
 +JFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUcW7vdG58CydzNX/HjghsigUw+fKponX0p6DpTj2XFChVaLcSstAplHSiXNQJ32clXWs7uJY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxya5H1b60gSF14WODMLl6z4J1mBOnrtLhbS7UMsBT3gujX/f8q
 3eOU12KLUWBb6rXb7yzm9HsX6PY9HtjyH0ANjV5usKn1h5mXJYL3ElHf8lhx8h75NWnL8FGTwXo
 M2lpWWBvgugW+F+OGiHIv1aVx94AjuNe7MQ==
X-Gm-Gg: ASbGncuXwVVQkI4O9Y4x3sg5MnuLWfQMOJEGCCSoJ7P2Jw7//6ifd65EvnZeiiGLxT7
 xLA2rSC8OOtA8zPHTJmW/Uxv7+oUwOtZC4nIpRIbcX20FcqWdSfPndzGAaFHGpeVgzO4E6rfJN4
 cLLa299qiDBZ0LgXSA/JqDJmV4agXXEFIe5mVFEjCvAEi/2V2dTKgAVB+LD8WG5u32Yw6vRnsM9
 V+OP0YbxH41zvh88Ec8+j2w3kHpNzIZ1xemPnF2
X-Google-Smtp-Source: AGHT+IFaIJLvtIWYE82lVkh4QKRH2SGSastvqLe7e5XRQSPc2cvw24+ozHEqo/oCdTnpfe9apf1CkSYQpoGBLPFZNaY=
X-Received: by 2002:a05:651c:419a:b0:332:3417:2800 with SMTP id
 38308e7fff4ca-33650ec0ef2mr21859881fa.17.1756088243698; Sun, 24 Aug 2025
 19:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250812-exynos_spi-v1-1-bd0813ff6593@linaro.org>
In-Reply-To: <20250812-exynos_spi-v1-1-bd0813ff6593@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 25 Aug 2025 11:17:12 +0900
X-Gm-Features: Ac12FXz8LOwZFEp1R7NSKnwJI7opAH8nylkpIkLchzKfccmpwbXVNcIZ6zNQ-CI
Message-ID: <CALrBrZ3GHjVGWvSrn-oeDAycRv=h_1vMcDeeNvX9V6peYOXMfQ@mail.gmail.com>
Subject: Re: [PATCH] spi: exynos: Remove extra term from test
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2025=EB=85=84 8=EC=9B=94 12=EC=9D=BC (=ED=99=94) 21:01, Andrew Goodbody <an=
drew.goodbody@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> In spi_rx_tx there comes a test for execution of a code block that
> allows execution if rxp is not NULL or stopping is true. However all the
> code in this block relies on rxp being valid so allowing entry just if
> stopping is true does not make sense. So remove this from the test
> expression leaving just a NULL check for rxp.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/spi/exynos_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/exynos_spi.c b/drivers/spi/exynos_spi.c
> index 1b9bf004b7c..d11952afe5d 100644
> --- a/drivers/spi/exynos_spi.c
> +++ b/drivers/spi/exynos_spi.c
> @@ -166,7 +166,7 @@ static int spi_rx_tx(struct exynos_spi_priv *priv, in=
t
> todo,
>                                                 stopping =3D 0;
>                                         }
>                                 } else {
> -                                       if (rxp || stopping) {
> +                                       if (rxp) {


then, isn't the stopping variable no longer necessary?


>                                                 if (step =3D=3D 4)
>                                                         *(uint32_t *)rxp =
=3D
> temp;
>                                                 else
>
> ---
> base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
> change-id: 20250812-exynos_spi-8172ecb31a83
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>

Thanks.
Minkyu Kang.
