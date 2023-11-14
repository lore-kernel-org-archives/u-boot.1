Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E437FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 10:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1B68723C;
	Tue, 14 Nov 2023 11:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aCU0YVZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D388743F; Tue, 14 Nov 2023 11:42:17 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C77870F6
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 11:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5875e2b27c5so3074307eaf.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 02:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699958534; x=1700563334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aFA+cnHK2yBtc86/23OAUX7E7fF+vtu/fz0pvdu52xQ=;
 b=aCU0YVZURUDrgmHqnmvHNqMps9ZCQB/eJ6z8AE6xLb+Og+EClLS1iARlt7PbmZA8NU
 0twEw1nUkdoKTpfpEX40hD1ZRUb6pOtmBO58dIFcM+kdrKvgyupVtllXfIS12k+mam+m
 C8AtTRap7i4/VguhgqdhZePOAkGTJzUJBLATw7ujyeZkiebsr8KfdjpKc0PvDVDyBBlt
 2Q5TCVdrQN/BVeBqnfipSFMsNUcUgq+B2vf7iA5KOSR2DQ7ByL6TdIQJuln6riDk/V7m
 Da+IZ6QvpKkNqqKope1y+aSSZWOZqLTKmTa+c2Lux7O1y1jJ9gdj7+Vc8tAJvwfuOX9o
 pTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699958534; x=1700563334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aFA+cnHK2yBtc86/23OAUX7E7fF+vtu/fz0pvdu52xQ=;
 b=jw7JnwyPkBQKDmWCSe0yuNOu5cuKd2ZaCUCQgwygM9BQFbC8I6fDOTrX0DQZOO6eXe
 nnQPXaavJ9mHlsCZdu5RhpFW6y+j6cjbw6bhbyavBlqLYYCAgbXDiHX/58XchAOgrsbv
 CFu0jMjCaMYhEC7pZ7TU/fHknZ3pRtvGnWuuNBatqI2Ogw3ixEkz8UszvbnMWAEB3+HK
 teZohXlv62blCL3APpYrcyHKPEWgNwBIosjJ0DVHHsaG8K0PcHAK4jSiRBpZnxy7WVeD
 bF4ihbLJWIIUWWqXHF83vFHRuD1UaKCLYnRadRvZWuF3BzS9/LP6HFxAOIEPw7eUVXHz
 dukw==
X-Gm-Message-State: AOJu0YyyXUqyJSnzTBpbhQhjCOGtxfTxLkzuZ/QFSQTRP3k+K8S8BVxD
 MkQmJ3UhF62sCsKsIzIXctTnHfX43CCVtLx+5a0=
X-Google-Smtp-Source: AGHT+IEhcdDsdwLDxGRli6byDtjqNkjd9Q330Gz9IMeBRoSHeE/iEAXl8bdcnPYAP0Bu3AVjO9GMBzojsGm49zoW2fo=
X-Received: by 2002:a4a:9d53:0:b0:581:ff09:62e4 with SMTP id
 f19-20020a4a9d53000000b00581ff0962e4mr8628460ook.2.1699958533863; Tue, 14 Nov
 2023 02:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20231107173417.8254-1-semen.protsenko@linaro.org>
In-Reply-To: <20231107173417.8254-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 14 Nov 2023 19:42:02 +0900
Message-ID: <CALrBrZ16kybPYGT3UXk5YBqN+WjmAbNb2t9JORF+pPL-XwpZ6A@mail.gmail.com>
Subject: Re: [PATCH] serial: s5p: Fix clk_get_by_index() error code check
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mark Kettenis <kettenis@openbsd.org>, Minkyu Kang <mk7.kang@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Thomas Abraham <thomas.ab@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi

2023=EB=85=84 11=EC=9B=94 8=EC=9D=BC (=EC=88=98) 03:39, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> clk_get_by_index() returns negative number on error. Assigning it to
> unsigned int makes the subsequent "ret < 0" check always false, leading
> in turn to possible unhandled errors. Change 'ret' variable type to
> signed int so the code checks and handles clk_get_by_index() return code
> properly.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: cf75cdf96ef2 ("serial: s5p: use clock api to get clock rate")
> ---
>  drivers/serial/serial_s5p.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
> index 7aeb8c0f8cb7..fe52580d64de 100644
> --- a/drivers/serial/serial_s5p.c
> +++ b/drivers/serial/serial_s5p.c
> @@ -118,7 +118,7 @@ int s5p_serial_setbrg(struct udevice *dev, int
> baudrate)
>
>  #if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE)
>         struct clk clk;
> -       u32 ret;
> +       int ret;
>
>         ret =3D clk_get_by_index(dev, 1, &clk);
>         if (ret < 0)
> --
> 2.39.2
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
