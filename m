Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14556C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 07:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 654838873C;
	Thu, 25 Jul 2024 09:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="h9+x6ly/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2020884A9; Thu, 25 Jul 2024 09:32:09 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49AD88717
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 09:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so27913066b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721892727; x=1722497527;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grxW84I1/4IrqTUwJ51NHaxINctPkmhIaKO/wvxm4Gc=;
 b=h9+x6ly/vGNMxWNTvJ+xcygKteie9CkMaIF6nMeojf3HNfWHHsyogfzV5jrUX4ozcC
 4CIHPzdqlpzKPxLLO3/5HkB43Ge1VsfOw5Ux9SX+IY04vM2d5nIAaLe1uRmvY29z99y0
 8vg4uFfUv1qlcr1VGmDLn/hE6lfsFewhU9Vy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721892727; x=1722497527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grxW84I1/4IrqTUwJ51NHaxINctPkmhIaKO/wvxm4Gc=;
 b=EDyp859uC9kE/EHhIDbJuko81smHFAI8AnKbdLxZNXa+aIysa5soq/YwIYUJPsLNmd
 RnSzPqtpMLTyENxLiNF5GVQa9SIWvZm6Pz9OFAq4rD7t9wVuX2BK5OUAa/ldQ5FlgkH/
 mma2FQsS5434gmVgenN6ZKpdX7sp7KyKsL53WsoTN664Gi6ouVshmcOSppkilMfxy3UB
 ij58x9+OueSia64cxG5wM7xN2dhggULp8zp7WOGThfRbWVfuTYWuIWu9JMcDLiUB6tt/
 FttBkE/Rq9CxYrnFas5nZUbSlfYm4MWqHq2iJMuIhqWtrDOaIl7WWf2xn1S8KEUTmLd4
 Hkpw==
X-Gm-Message-State: AOJu0Yw3vAYz8S3VGCMewwXS4GOob+UbwoDMVcYP8tU1UE88LqWzCgFe
 IMRNb8XE2V1S6xwO85/mXII7Q5fJbUEmP7F7JAnplqU8wTr188T8+XwmlvLq5BzMoD6/vWXo7hi
 +wcYq8g0G+4FJrZqXlxU/aNdl/NOFvCmQcjElse6XYQC7QbFm5C4=
X-Google-Smtp-Source: AGHT+IEJR0VnwoJlCXsfb8et91pm55eaXZoBM3Ad0AEC8ipj6/2I9/rmKFy5rXgbYSYD2YCaG85dd8/KNpYLRSrjW4U=
X-Received: by 2002:a17:907:7296:b0:a77:db36:1ccf with SMTP id
 a640c23a62f3a-a7ac5049d22mr127573066b.42.1721892726564; Thu, 25 Jul 2024
 00:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240725073707.26040-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240725073707.26040-1-Zhiqiang.Hou@nxp.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 25 Jul 2024 09:31:55 +0200
Message-ID: <CAOf5uwm-kedmeH7at0F5+zfuJ9218NwRSJjA4_vjTGvpsJ7msA@mail.gmail.com>
Subject: Re: [PATCH] clk: fix ccf_clk_get_rate
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, seanga2@gmail.com
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

Hi

On Thu, Jul 25, 2024 at 9:16=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> As the type of return value is 'ulong', when clk_get_by_id() failed,
> it should return 0 to indicate the get_rate operation doesn't succeed.
>

I understand your point here but the clk_get_rate that can call the
ccf clk_get_rate
can already return -ENOSYS.

Michael

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/clk/clk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b8c2e8d531..4c2c372cd3 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -84,7 +84,8 @@ ulong ccf_clk_get_rate(struct clk *clk)
>         int err =3D clk_get_by_id(clk->id, &c);
>
>         if (err)
> -               return err;
> +               return 0;
> +
>         return clk_get_rate(c);
>  }
>
> --
> 2.17.1
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
