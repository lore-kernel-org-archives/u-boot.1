Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 11:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9296D8801E;
	Fri, 12 Apr 2024 13:13:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HpA28/DI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE44F87F4B; Fri, 12 Apr 2024 13:13:38 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9724C87F8E
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 13:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a58d2e5be8so214255a91.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712920415; x=1713525215; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxboKk31XxkQ4aryTzl3suDy/6ZAEoADrYzmjmJcgR0=;
 b=HpA28/DIPaJ0UZbOOp7ZuosyuZyO93qGFsIi6ZoP+HVKzpWBz6Pg+aaJddZeMXzjff
 Oi7EGXu3v4gb+RY+1PHcDdhfK9MHk5oarDNLdVS/pfIGY54DamzCvKolRS59ycrD0Bg4
 ugvvYLqdeKHzfhPt4IjHgQyIRQR3fSqyPyvK/ydGmLP6zwhkGsUFkeLoBLUzSn/sFf6O
 Hd0iLZNL5J3RPHNbFxIAPHdk34SBhRTnZzU7KN7FIa2zCrRhDMkMNMcq4rIdhyek75tC
 9Q9RQvT99d787VXN624JMXscR0wAitLhnQlJ687cODOSaA9gMrHkzENyNUvOGjqfITGC
 Okvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712920415; x=1713525215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxboKk31XxkQ4aryTzl3suDy/6ZAEoADrYzmjmJcgR0=;
 b=i8ye2a3Gi2VLgEE74D/oT5OL+WoLBDxTGSzGY8zc7yCDwJyWR2QbtarYYRNgxU8UHx
 RXeQ15LRDVrGIIt958nfDAUxy7/E9P6/Oo+/KOaq99HSxxOmntFz9CxWT4CQ3QuoVTLz
 yBJLeATG3cgxIS33em62DXhhpGxsbOrYCOr8wb0ZPgr0yY94R8zNzEy2I82PUYqtcWJK
 YG4iNGkbcSEwSoSH4qARjdzjYyERhEQt/wjZwYYsn5qM+Khy1yTOCMPILS5wtVIT9jPi
 7BDrg7ZofVsYZr15yMGoWV4RW/wAHBLf3OOXqlRj8uHqnLSXqPF47kF4YA8h5i0r6Sea
 1jEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqa7vP7zDEYX1/bS1nH7+ewj2pPIrEheZH0Mb42jKv/3D+s7B7ed+pWa1QyaWTKHHUmmw4SNZ02WbHO9Gp3WorUTdRcw==
X-Gm-Message-State: AOJu0Yw2SCzJ6g2q/CfrA2c9x9FnPXLQQaUN4oe0aF7/D8W49Gmt0/2u
 ZKdjF2Kmm1kzLa9XEu5RhvUFOE0lK5xmdh70ilp4re+6q1vKoyCiJZey+nunYbgoxagj8o36ZxD
 4ng+C3sQ7iXaKomc5/YJZ+2b61+Q=
X-Google-Smtp-Source: AGHT+IEqRbYYSiJd6usYO3lbvPkf/CptYZysYF4GRNZUXZRw2sSFmr7Lh2ck9G0hxZF5vG1lKtxio1Ptij3PWyJyNoc=
X-Received: by 2002:a17:90b:3548:b0:2a4:949f:3220 with SMTP id
 lt8-20020a17090b354800b002a4949f3220mr2016303pjb.3.1712920415003; Fri, 12 Apr
 2024 04:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
 <20240411-imx93-of-v2-v5-2-9eb3c64ff160@nxp.com>
In-Reply-To: <20240411-imx93-of-v2-v5-2-9eb3c64ff160@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Apr 2024 08:13:23 -0300
Message-ID: <CAOMZO5DDwsopWC8xnVhKsDtCCXLv3pVRxHt2ij6sJBCYBVRLYw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] serial: lpuart: use ipg clk for i.MX7ULP
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Thu, Apr 11, 2024 at 12:23=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> To i.MX7ULP compatible lpuart, there is only ipg clk, no per clk.
> So add a devtype check for i.MX7ULP.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/serial/serial_lpuart.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuar=
t.c
> index ce08a6b4486..891352293f9 100644
> --- a/drivers/serial/serial_lpuart.c
> +++ b/drivers/serial/serial_lpuart.c
> @@ -111,11 +111,18 @@ u32 __weak get_lpuart_clk(void)
>  #if CONFIG_IS_ENABLED(CLK)
>  static int get_lpuart_clk_rate(struct udevice *dev, u32 *clk)
>  {
> +       struct lpuart_serial_plat *plat =3D dev_get_plat(dev);
>         struct clk per_clk;

You ignored my previous comment. Here I go again:

Please rename 'per_clk' to 'clk'.

>         ulong rate;
>         int ret;
> +       char *name;
> +
> +       if (plat->devtype =3D=3D DEV_MX7ULP)
> +               name =3D "ipg";
> +       else
> +               name =3D "per";
>
> -       ret =3D clk_get_by_name(dev, "per", &per_clk);
> +       ret =3D clk_get_by_name(dev, name, &per_clk);

... because it is confusing that per_clk can be ipg or per clock.

>         if (ret) {
>                 dev_err(dev, "Failed to get per clk: %d\n", ret);

And then also change the error message to "clk".
