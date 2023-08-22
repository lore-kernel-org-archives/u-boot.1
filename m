Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B68BEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 02:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC2686F16;
	Tue, 22 Aug 2023 04:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jRqfbow8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4838C870AF; Tue, 22 Aug 2023 04:33:20 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0ABF867E2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68824a0e747so912193b3a.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 19:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692671595; x=1693276395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ld/CmeCQPQx3Z4k6LXwTbJvue7rTlStd3hnippcOj9Q=;
 b=jRqfbow8TyHQDl6icAqy5GJeDDPpJV/W/vNmg1QRVKUGL2fSMoHDWygtz3fKdOGt5/
 FKH2ANrzznq3/nvw/HOMPOP+A1QPtmvHxeT2/O1mgdjr+n4cYspAha015zQLutkqLjJ+
 d3Dqw8rVKL/GOwNePYTGvoJx0+EJckF/jVVFcFpuyG7plfjCBCIp5OoWdhRtcEyqUND2
 1ynNyDgM9EppdMxzyPJljQcHLIiOpS4wi2uV0I7HEwc1NUfZJlzqLx6W+dvcbRkAzjfx
 fk5+hAp456Sw+fUNeC13b9Ebx0s/Q3ulJjBBzi/sBMe3Brttrja11LPBp+fcIzRu6C6p
 fz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692671595; x=1693276395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ld/CmeCQPQx3Z4k6LXwTbJvue7rTlStd3hnippcOj9Q=;
 b=LN8sFzyYf9sZREdfWwgxFjYw70pX1TdK2ExY/h3soC6RnXkX9hD3ljljwkppNXEgGU
 JhCt1edOsRc4niDugJ58XlfDlQwDFNYS7DZrw+I5O0m41yAu1HRAlsN6+EkYpEWNAcEo
 JE9jynCryAg5swpiQ40LLa3FVxfMTBXzG5FdEgV+gJP2gIxPQVslt8MCZObEZ+ZYp+7L
 Jv25IiLmip/Mt3y98+XAUQuJ7Pg7yV+HssbUMY8aZzWhYieXkoEdde6zTc1Q/0yYGdX7
 J23PlVNOv3X+oqflO9dFxOJqXWSC64QFkTEZJKkYEVCbDMrrJqkBxPYg1HGDRZDvSz0H
 WZaw==
X-Gm-Message-State: AOJu0YzER3YXku8SAVKhUr5+0YU8zo8dPPeOecXEyVvQnd73xg4Z3vJE
 u7PiG/S1wzqZFUjr6Fo9Z9URTUoCmBwpgi3ZhOsWjwajNgw=
X-Google-Smtp-Source: AGHT+IHwDDzG0+C/uupPVOjbvjUliQzAEo0oSx7oYjqWNRpZ6lu+JYR/9kc/Z1cMj9RxBph1G1HUYmVafonfwcM1gso=
X-Received: by 2002:a17:90a:7524:b0:26b:27f6:9027 with SMTP id
 q33-20020a17090a752400b0026b27f69027mr7375434pjk.1.1692671594948; Mon, 21 Aug
 2023 19:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
In-Reply-To: <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 21 Aug 2023 23:33:02 -0300
Message-ID: <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Rogan Dawes <rogan@dawes.za.net>
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

Hi Rogan,

On Fri, Aug 18, 2023 at 10:45=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net> w=
rote:
>
> Circling back to this, I wanted to get a modern u-boot running on the
> Wink Hub v1 as well. Since it is possible to invoke SDP over USB
> (having soldered on a suitable microUSB connector), I have no concern
> about bricking it now. It's also a LOT easier than JTAG!
>
> I tried to build and flash the mx28evk_defconfig, but failed to get
> any output on the serial console. This is likely to be unsurprising,
> due to the already established alternative configuration of the UART
> identified by Fabio.
>
> I then patched imx28.dtsi to add duart_pins_c as per Fabio's previous
> patch for the Linux kernel:
>
> + duart_pins_c: duart@2 {
> + reg =3D <2>;
> + fsl,pinmux-ids =3D <
> + MX28_PAD_I2C0_SCL__DUART_RX
> + MX28_PAD_I2C0_SDA__DUART_TX
> + >;
> + fsl,drive-strength =3D <MXS_DRIVE_8mA>;
> + fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> + fsl,pull-up =3D <MXS_PULL_DISABLE>;
> + };
> +
>
> And updated mx28evk_defconfig to use duart_pins_c instead of
> duart_pins_a. However, I still got no output after using:
>
> sudo $(which snagrecover) --soc imx28 -f
> src/snagrecover/templates/imx28-evk.yaml

I am not familiar with this tool. I was only aware of the one below:

https://source.denx.de/denx/mxsldr

Are you able to load the original vendor U-Boot with it?

Also, is the original vendor U-Boot source code available?

It is important to re-use the same DDR initialization from the original U-B=
oot.

> with u-boot.sb in the current directory.
>
> I also tried using the complete imx28-wink-hub-v1.dts as created by
> Fabio, and updated the .config to reference that instead of the
> imx28-evk, but I suspect that I may not have made the updates
> sufficiently well, if the name of the board needs to correspond with
> any details of the device tree? Neither of these resulted in any
> output.
>
> Any other suggestions?

Please check board/freescale/mx28evk/iomux.c:

const iomux_cfg_t iomux_setup[] =3D {
/* DUART */
MX28_PAD_PWM0__DUART_RX,
MX28_PAD_PWM1__DUART_TX,

The DUART pins need to be changed here as well.
