Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1FACF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 13:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CBB88875;
	Thu,  3 Oct 2024 15:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FW4iDNNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DB588D65; Thu,  3 Oct 2024 15:29:55 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E9F8870D
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 15:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5398b2f43b9so1927953e87.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727962193; x=1728566993; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pvhetk/vqvPZWBMNWE5+2PObRRGPpvq2W4bQ6nMsCWo=;
 b=FW4iDNNa0UdVqIFnGd1QWyCnXGbGSk7OivTbIH8fV4/DidMRhGfELwMx0uFnd5dbGE
 cW6iECNLuWTyvymuEghlqMF/L09qA/DgTmw2nL7TpyK6kAArllVnl7VF5QkIpewSdoiG
 gR/2RT0Y1ukwyZp1On3IDzYkw0/aiPCvqy39iyieJxp6nUkvYNcSqlVdMkSlgn1ymtHl
 b5jtaXJJ3pu1gDyLooFWIk9WWzbN9WRNlj9cI6F6XkJrHUQU/DGoaZjThdP81/ryrIoD
 Sk262LHtQ3wVu4+oV/Zhu3ep8b7tCCQt6cYfvm5jvOY+y7VeVEc8ydPqVbKCg4GD1yn8
 hfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962193; x=1728566993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pvhetk/vqvPZWBMNWE5+2PObRRGPpvq2W4bQ6nMsCWo=;
 b=bqYC6zPj+Uj3IL1BATtLnlD98X3jdG7JdZKf0kpdiGhCvsrdh9g1xtbqGhnwWgvBTp
 WLT2vXQZRCo2TQyPi7B6YvKhN1cr7Ay3QHeoxn9P2qkxYyT/HcrwdgSAEgoKgK308FUY
 arUAh0ksucxWZ33mGEhepKaa6TRPVnLWyldQPhJci/O4dgBzr2maXEc9HLBJlEIENvjG
 zbjcNW9pOWf0m01MZqFFt98OfT9Z8yd7pCtdQgTi4dkjS6yf5s7CScoeyxTIOOYXpMtc
 IUWB7cD9G7c9uR1KT9mZMz9MXvQFm9fR9DHJqC0UambNKXM2z4Iwm54iSeFW7xywqmBL
 TGPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgFUtdY9GIanxb4eYJMiyqKmH5JxL0FUMJXn+8+nhZ2ed+h2cssiJY7FOoReW1LHsooQlYdas=@lists.denx.de
X-Gm-Message-State: AOJu0YxXTz16V7i1N8qmHUVJf8Ttt8NJaVG2wPvPM5HvDFl3cKwD1rav
 vWVzs7khTroz7HI7dw/8/PTT8+nPFL3Ji5m/dB7qnWVi/BXd1N0yxeRQZW4PrkSBcMc6LBgddYh
 Dri7AaToQa6ctd/e/V+UwICSwr4k=
X-Google-Smtp-Source: AGHT+IFVSCiJOT0pQ5VBJMAxP1ob78nYZDHjHUbL01RdhP7htj6v4ll/h0VntXq3YTSTqpObq7ZcuzpE5rWpXPj0P2k=
X-Received: by 2002:a05:6512:334d:b0:539:933c:51c6 with SMTP id
 2adb3069b0e04-539a62772ffmr873306e87.29.1727962193009; Thu, 03 Oct 2024
 06:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241001130758.9810-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241001130758.9810-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 3 Oct 2024 10:29:41 -0300
Message-ID: <CAOMZO5B8afcDSK+APn4wVRALeT1=27RmfgXaWjKZ06RoEWOAqw@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk
 bulk API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 uboot-imx@nxp.com
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

On Tue, Oct 1, 2024 at 9:04=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

>  #if CONFIG_IS_ENABLED(CLK)
>         /* Assigned clock already set clock */
> -       ret =3D clk_get_by_name(dev, "per", &priv->per_clk);
> +       ret =3D clk_get_bulk(dev, &priv->clk_bulk);
>         if (ret) {
> -               printf("Failed to get per_clk\n");
> +               dev_err(dev, "Failed to get clks: %d\n", ret);
>                 return ret;
>         }
> -       ret =3D clk_enable(&priv->per_clk);
> +
> +       ret =3D clk_enable_bulk(&priv->clk_bulk);
>         if (ret) {
> -               printf("Failed to enable per_clk\n");
> +               dev_err(dev, "Failed to enable clks: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D clk_get_by_name(dev, "per", &priv->per_clk);

Now that you use clk_get_bulk(), why must the 'per' clock be retrieved
separately?

I expect that clk_get_bulk() gets all the clocks.
