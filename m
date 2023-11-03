Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9DCC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 18:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E8158711B;
	Fri,  3 Nov 2023 19:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNQ7GTwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C526C87157; Fri,  3 Nov 2023 19:12:29 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366548711A
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 19:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-280c371ff69so389207a91.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699035139; x=1699639939; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+vBGHMyk14TAZ0XHn0xx2XijRJqxZ1bceljMxX+0Ro=;
 b=gNQ7GTwUo0FEC8M+4EfOjTO4apbO40UB7rEsKMXUyJOh1U8KAQyQGzJZPHwtnTLU1t
 D9TKfpoetX/qtZnPQlJxyV46asaPvSSWTpbISSVatu195PsBAG5r+T67dlZatB97XAsr
 GKQuDzhEYOtFlYgR04g5P7WXe39bROxLkNhpmu/rc1KcI3LTwW1J8M+GOLDHdrr/IMvU
 /SodnzUBecsTmrrFAieDhNp9VsP2frMh2wZnG3qV4OS84yBeZ/ZWEvyFfYDneOODTz42
 eRy+kLgNiGaL37ic0ZvA+CYCE9/23XumXlo0NVDU4uSGl5ltlBs1grWlCU53ncVlKtBp
 CbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699035139; x=1699639939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+vBGHMyk14TAZ0XHn0xx2XijRJqxZ1bceljMxX+0Ro=;
 b=rUE9g+jh/OwWXY4Uq2wJrOznLFYN60ViZWA+FU8T31TbRjidOBQNzvdE26hxY/Fphw
 G6uWiYgvKzganjfF+TjsZ/WMYxiSIVlsw1fYxtggWnwPhIAAQMfGrVr1exPBjxpQhpxp
 nU2DSSFXJWtpVYrqxwJN/1sPoUqzFizDPmHidR4xpFLU7u3qMkDuDJwAVHab4adPoNUM
 FCla2Cgl3/bnXS6+Nh+MwKvx1wOFLU0DQZb/njD7kIKlAJAXHq8H4t4+x/EYfBTSwOm4
 ZIUyVE79W4Sp8NCFH54ABx5E8E5nR6O7V9qCUJskLEecNe6661CBwnG/jp1eSt7uhFaM
 pLFg==
X-Gm-Message-State: AOJu0YwJa8+EwwrvkjJG3T9l/QmmdRV7ydhBwpBhJxRiBESCNVNkjL5E
 q4rhQTIsbTnIOkoJuPq8JfgEZeekOV0SqaYlypxlpsuo24c=
X-Google-Smtp-Source: AGHT+IETq/+pfs00j35ECm7vZcjR2ttFBYJ/CiaWvet3b04kv/s6rsF0s5WOgON2/wRTQPzVYUb2fbFbf07agiMqAkg=
X-Received: by 2002:a17:90a:fb49:b0:263:730b:f568 with SMTP id
 iq9-20020a17090afb4900b00263730bf568mr22263936pjb.3.1699035139509; Fri, 03
 Nov 2023 11:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231102204454.269-1-egyszeregy@freemail.hu>
In-Reply-To: <20231102204454.269-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 3 Nov 2023 15:12:08 -0300
Message-ID: <CAOMZO5BXL8v21bVNXzbG8dZHa8Jespzeugw1FHjNBhi6SCa9vw@mail.gmail.com>
Subject: Re: [PATCH 1/1] [u-boot][master][PATCH v6] pico-imx7d: add baseboard
 SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

In the Subject: simply remove the [PATCH 1/1] [u-boot][master] text as
it is not useful.

On Thu, Nov 2, 2023 at 5:45=E2=80=AFPM <egyszeregy@freemail.hu> wrote:

> -    aliases {
> -        mmc0 =3D &usdhc3;
> -        usb0 =3D &usbotg1;
> -        display0 =3D &lcdif;
> -    };
> +       aliases {
> +               mmc0 =3D &usdhc3;
> +               mmc1 =3D &usdhc1;
> +               usb0 =3D &usbotg1;
> +               display0 =3D &lcdif;

The indentation change should be on a separate patch.

> -       /* To enable AR8035 ouput a 125MHz clk from CLK_25M */
> +       /* To enable AR8035 output a 125MHz clk from CLK_25M */

This typo also should be part of a separate patch as well.

I applied your patch against U-Boot master and tried to build
pico-pi-imx7d_defconfig, but it failed:

/usr/bin/arm-linux-gnueabihf-ld.bfd:
board/technexion/pico-imx7d/pico-imx7d.o: in function
`mmc_get_env_dev':
/home/fabio/denx/u-boot/board/technexion/pico-imx7d/pico-imx7d.c:227:
multiple definition of `mmc_get_env_dev';
arch/arm/mach-imx/mmc_env.o:/home/fabio/denx/u-boot/arch/arm/mach-imx/mmc_e=
nv.c:21:
first defined here
  AR      spl/drivers/usb/host/built-in.o
  AR      spl/lib/built-in.o
make: *** [Makefile:1765: u-boot] Error 1
make: *** Waiting for unfinished jobs....
  AR      spl/drivers/usb/gadget/built-in.o
  AR      spl/drivers/built-in.o
  LD      spl/u-boot-spl
/usr/bin/arm-linux-gnueabihf-ld.bfd:
board/technexion/pico-imx7d/pico-imx7d.o: in function
`mmc_get_env_dev':
/home/fabio/denx/u-boot/board/technexion/pico-imx7d/pico-imx7d.c:227:
multiple definition of `mmc_get_env_dev';
arch/arm/mach-imx/mmc_env.o:/home/fabio/denx/u-boot/arch/arm/mach-imx/mmc_e=
nv.c:21:
first defined here
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
make: *** [Makefile:2054: spl/u-boot-spl] Error 2
