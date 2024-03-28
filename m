Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1D5C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 00:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDA38808D;
	Thu, 28 Mar 2024 01:14:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ou5e21do";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF6E88073; Thu, 28 Mar 2024 01:14:13 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BD5880A3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 01:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so68117a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711584848; x=1712189648; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKwKFhlkesJYyWTRbdsozqS5r9qwxPdaV6+iWhE1aSs=;
 b=Ou5e21doQdGVuVavXjETdCS5M0h+YpA9HZY4Kc/8lj7lKrlMQS50ko0SVx7Fdkz98F
 5s+dwaUF6crswV1pbGsdYygi64MbXiVAkJdPeJzttAJv8cm3nYQOAj1FyqDry86REA77
 TsRmLVdaLahGx8v+kwDvW8JTYX/lKCHm7hRcNScPWL6yihSrJj/TRKtdkmc3EZ8UMund
 7AaSGLV9+gPvzJEeuuVqZJJV6kyeboEJ0wD1bYnroqM3lVoeyRaioqgS9RH9fPNQ4wgT
 QHIG22xPdX/Ny3NoZ1HKMpEeJjeP+spWOO1LQuydMU+KQrqECMQFdKZd/YA1MFWBN403
 oiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711584848; x=1712189648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKwKFhlkesJYyWTRbdsozqS5r9qwxPdaV6+iWhE1aSs=;
 b=Hum65wFGY+VlHLJjXK/0wucVl+iGA6EwkRXLgnF5JpblPK/QxgmK5UoVZVHqYepVI+
 jDDhUpuI0vP5u3D3lgHyfjN/Pq9y+b4+V34NhtdLm68i0NcY83cNbJ1L0j/YpBH1Yyep
 +Wu9DWfTAa/xdiaiD2bn8DjsLbHo8wZNLxbGH2xDCsXmb5mgqfP2jFBwE29vab5RAlhc
 vUETNGt10birHknp2qwRTmo/9iGFQM0HgzRsQMToyEDhIJ4qfQnStF1eTOez+l2QDO1x
 5sWwwYrFupVLt4jW4kQAfQ1iP4yxLqrS1sXUfb67AvS7UVryzMLOAJO7HyuAUVSrzpRJ
 lYcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoL6XFT7tUwqLZMOXODem9i/mqzjGHJLkTo6ii5NV9bJzybIkzfu6/jYOpurEINHhz5sk9J/WN9nNMoVK/W24zzKTvag==
X-Gm-Message-State: AOJu0YzlBIcYq36Sf3ujectyQ+ROM+/YykmmxyduzW4n5OON1ZHnWR/k
 TAOVAigof2spZYnHf80xV1H/CKP+njEtgnOKuf+XTomitOgk1P4i9tcuSf+okWBRW1ziUHFRGvU
 qF59I/HZrUINA6ccydQDFDjFxJ/A=
X-Google-Smtp-Source: AGHT+IGZEjgndveD7DArqgzKJNRBFxAwLV+0bEXQBClxaZ6tMbtRftPNtqPCABHmGK+OdhyXNWp/W9K1mGgCWfenIkw=
X-Received: by 2002:a05:6a20:daa9:b0:1a3:b00a:7921 with SMTP id
 iy41-20020a056a20daa900b001a3b00a7921mr1777890pzb.5.1711584848544; Wed, 27
 Mar 2024 17:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
 <20240328-imx93-of-v3-6-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-6-4e7f341ed7ea@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 21:13:58 -0300
Message-ID: <CAOMZO5CXyBTm7JnfYB60hx3oipY76RSY0U-GPaoVJO=Agwr4Vw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Wed, Mar 27, 2024 at 8:53=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> +&lpi2c2 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       clock-frequency =3D <400000>;
> +       pinctrl-names =3D "default", "sleep";
> +       pinctrl-0 =3D <&pinctrl_lpi2c2>;
> +       pinctrl-1 =3D <&pinctrl_lpi2c2>;
> +       status =3D "okay";
> +
> +       pmic@25 {
....
> +       adp5585gpio: gpio@34 {
> +               compatible =3D "adp5585";
> +               reg =3D <0x34>;
> +               gpio-controller;
> +               #gpio-cells =3D <2>;

Please add a comment saying these nodes are already available in 6.9-rc1.

> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -31,6 +31,7 @@ choice
>  config TARGET_IMX93_11X11_EVK
>         bool "imx93_11x11_evk"
>         select IMX93
> +       imply OF_UPSTREAM

Sumit and I asked you to add OF_UPSTREAM to all imx93 boards, not just this=
 one.

Please don't ignore review comments.
