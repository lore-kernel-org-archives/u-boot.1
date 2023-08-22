Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D06EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E282286484;
	Tue, 22 Aug 2023 11:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dawes-za-net.20221208.gappssmtp.com header.i=@dawes-za-net.20221208.gappssmtp.com header.b="IsGLDc+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9438648C; Tue, 22 Aug 2023 11:43:05 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B697486438
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogan.dawes@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bcb5df95c5so3376997a34.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dawes-za-net.20221208.gappssmtp.com; s=20221208; t=1692697375; x=1693302175; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESCMbgEPgbT2mulfYKcU36MwAHb4nePROSB7KddwREc=;
 b=IsGLDc+mOVDFWJZgbrKgr8MNL6IL6o8po25bwzo9nyIHdwVNimiAQOaGwY7woO2dbq
 0lQD976u7zcvZlf2LWI+jHUlqhqCGC57BTRcx7809zJMBaNvmMOuLKAcMzdpF/GQbg9N
 TxGmu16mxPw87V2x5Hru2wlkq3O+I/mmwEfKP9wAcl//jjouz8A94hcqgYbWfyEbnj4K
 CICV3VkHl/ZYP52TYzQs0oE39AU0wUMOtRIBfq7C0CfEn2haKGZPhscyWoXebrGgMEw9
 NygaCf41OV08IePEhLOJis0F1NjwhDyF/6vhdWaAFlv2ep412PCJyyQlZsXWXgzuanIX
 SUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697375; x=1693302175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESCMbgEPgbT2mulfYKcU36MwAHb4nePROSB7KddwREc=;
 b=A1sY6ScvWbebrrw19zgjw+PfzuNdfVKUliCYFONuooj1WdSrp1iLDzLjEg3Xu2jVNd
 6KHMS00ZxOeBLZYuNB9xrdk1NXnnm3B4UOqN/eY0ZwvtEt9KuGb+YvqJnmc0BRhJznb+
 PWePymsV6X94fk54aC2p0hu+xvdriweOCNTV7isGxpVgZxBd14QbNwywfRK2ntt8dWWt
 L/wWeoegsXBAj/aYfyw9FvCRlwAcya9xg4YjM81rYtargIFJw043xw4RI9Q9BeaLAvjC
 cZP2MamQL+S+KjMRVlPQr7jE9kBqtnbi4qCkHdReHpUAUhgQT1V2r6pj4nZzZDIwJFTG
 D6SA==
X-Gm-Message-State: AOJu0YyTh/W4DKlCHMlb4rNEglCjSmonFLY3AiiUYhuSoc+4ZV9jj/Xo
 Ks+bQTEWpgqOxXcri4bXe/isWYMKQhFELMmEUwY=
X-Google-Smtp-Source: AGHT+IGqQPQLB8rKKpcbV5pcwZZYVw5UEkU9zyhHjcCDblQSdl4HxMmsYzXRnIKvC0hceS96OfgGs1GjyPva8jo4OcA=
X-Received: by 2002:a05:6830:1e57:b0:6bc:de9b:a3e6 with SMTP id
 e23-20020a0568301e5700b006bcde9ba3e6mr11073060otj.24.1692697375266; Tue, 22
 Aug 2023 02:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
From: Rogan Dawes <rogan@dawes.za.net>
Date: Tue, 22 Aug 2023 11:42:43 +0200
Message-ID: <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Fabio Estevam <festevam@gmail.com>
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

Hi Fabio,

As far as I am aware, the U-boot source for the Wink hub has not been
made available anywhere. That said, the RAM chip in use on the board
is marked D9LPX, which apparently corresponds to the following item:
https://media-www.micron.com/-/media/client/global/documents/products/data-=
sheet/dram/ddr2/512mbddr2.pdf?rev=3D2c70f8a2b207452584b2bf040de8d771

I did try to change the iomux_cfg_t as suggested above, built using
make mx28evk_defconfig && make u-boot.sb, and used mxsldr to try load
it, to no avail. There was no output on the serial port at all, or any
other suggestion that anything was running.

Any other suggestions?

Regards,

Rogan

On Tue, 22 Aug 2023 at 04:33, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Rogan,
>
> On Fri, Aug 18, 2023 at 10:45=E2=80=AFAM Rogan Dawes <rogan@dawes.za.net>=
 wrote:
> >
> > Circling back to this, I wanted to get a modern u-boot running on the
> > Wink Hub v1 as well. Since it is possible to invoke SDP over USB
> > (having soldered on a suitable microUSB connector), I have no concern
> > about bricking it now. It's also a LOT easier than JTAG!
> >
> > I tried to build and flash the mx28evk_defconfig, but failed to get
> > any output on the serial console. This is likely to be unsurprising,
> > due to the already established alternative configuration of the UART
> > identified by Fabio.
> >
> > I then patched imx28.dtsi to add duart_pins_c as per Fabio's previous
> > patch for the Linux kernel:
> >
> > + duart_pins_c: duart@2 {
> > + reg =3D <2>;
> > + fsl,pinmux-ids =3D <
> > + MX28_PAD_I2C0_SCL__DUART_RX
> > + MX28_PAD_I2C0_SDA__DUART_TX
> > + >;
> > + fsl,drive-strength =3D <MXS_DRIVE_8mA>;
> > + fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > + fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > + };
> > +
> >
> > And updated mx28evk_defconfig to use duart_pins_c instead of
> > duart_pins_a. However, I still got no output after using:
> >
> > sudo $(which snagrecover) --soc imx28 -f
> > src/snagrecover/templates/imx28-evk.yaml
>
> I am not familiar with this tool. I was only aware of the one below:
>
> https://source.denx.de/denx/mxsldr
>
> Are you able to load the original vendor U-Boot with it?
>
> Also, is the original vendor U-Boot source code available?
>
> It is important to re-use the same DDR initialization from the original U=
-Boot.
>
> > with u-boot.sb in the current directory.
> >
> > I also tried using the complete imx28-wink-hub-v1.dts as created by
> > Fabio, and updated the .config to reference that instead of the
> > imx28-evk, but I suspect that I may not have made the updates
> > sufficiently well, if the name of the board needs to correspond with
> > any details of the device tree? Neither of these resulted in any
> > output.
> >
> > Any other suggestions?
>
> Please check board/freescale/mx28evk/iomux.c:
>
> const iomux_cfg_t iomux_setup[] =3D {
> /* DUART */
> MX28_PAD_PWM0__DUART_RX,
> MX28_PAD_PWM1__DUART_TX,
>
> The DUART pins need to be changed here as well.
