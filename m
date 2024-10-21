Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E319D17128
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 19:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C28688A3C;
	Mon, 21 Oct 2024 21:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LwWnY1HD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ED89885F4; Mon, 21 Oct 2024 21:01:35 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5CE888D56
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 21:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilles.talis@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so671203066b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729537292; x=1730142092; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZXQZUkYWkb4NBpB+693nz7Xb+u6FH6p0ft7RuLBEkw=;
 b=LwWnY1HDikq3TFy/0zDnnURFzT7Jh9YhbreleoHhZI4VRYAERylsFLT0gie/dPMiUK
 ijlU3lSxtNWo7HiQgz7y6nCihZ1Jn4GDAAVJCwjhYclZnT9rkY+eB/t6hi0W4CdFj7RZ
 /yyuQqUC8fXX0VMPYcYjnWsr+EwnHWncBSPqQZua9ndLdbP6hQXbr3ILq5aHCAiTVg/B
 sHYGpa31N15+GRyf30G1b4VLncncF4rM9y/HPecpKSuXXbdNuNOrE2Vy/RlXMQ4917e7
 Cao8lIPBRYA0nyUZuenJrWamXz2RCq8yrqQYswJnnPgE5TQjV18wc0h+8cKKndCsz/6Y
 +ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729537292; x=1730142092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZXQZUkYWkb4NBpB+693nz7Xb+u6FH6p0ft7RuLBEkw=;
 b=eBmSuMTIk9ikuxeDpEmhMN5EJuP/YWKCs18VASt96Wq6k1DLc71+ZSpjRsYtZp2zhH
 jg/yIFx4T5N3Tk8XGEIvBC94HM/B/852CBQ5tigHEjDTeoSGNTmRu6qMXU80gGr1Pfbs
 Kzq34xxpTtruxiWZX1kZW+ljvcmtzl/NTjiYU8Fmw2uKhG8nsl+RV/xKb1aMRtu2zAD2
 r6scm0piY8WUpBJjlcfscoXnJPeh+Rr78Q5AAbGKlq9NwxQ69skiW8mAx8TzBf6zVz1e
 vEq7r4vsCAG3iCvhPs16UabeEDOGbHzDEfcUN7Sd7MjpA9FJuoSqtYNQQ6KZJ/a1CUse
 y0wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX97CAZWaGqiCRUPjcRBdPTxBG6M0ImZlBPir8p5Uz2AiICx16Eo45ewLrS3RNyPod0hY0gPfg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/MlZdaCrcvqPLBnDJkivAlrnZmDoU0XiRMRZl/MWrxvFiELdG
 OWw2g9GYIUGxvGdI2ZC8l0imrPuqWTOSWj36Xl2PaSxO8sd7wal4em6q2I8WCTHig8i0kL12tPh
 PVOZ7eF+DTW8dG3CZ6/hEARBxzZtD8Qxb
X-Google-Smtp-Source: AGHT+IEvYBgY28KJ935LmRT05jYVVLHYUMsud5Ls7wBobZumJQYJqzTLsjgvF4iJXeSelxc+3SQCEL25dh4MNp4VCIU=
X-Received: by 2002:a17:907:9345:b0:a99:46dd:f397 with SMTP id
 a640c23a62f3a-a9a69caa3f8mr1118267466b.64.1729537292088; Mon, 21 Oct 2024
 12:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241020200818.278197-1-gilles.talis@gmail.com>
 <CAOMZO5CZ80f+TefL_ndid_AeuEGntDwGFJj19ErR07YV-oRhVQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CZ80f+TefL_ndid_AeuEGntDwGFJj19ErR07YV-oRhVQ@mail.gmail.com>
From: Gilles Talis <gilles.talis@gmail.com>
Date: Mon, 21 Oct 2024 15:01:20 -0400
Message-ID: <CAKcgs2yAjuMYjUOxeZaM6bWOapqahBJD1ZJRheJY0fURrp1Nqw@mail.gmail.com>
Subject: Re: [PATCH] board: emcraft: Add support for Emcraft Systems NavQ+
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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
thanks for the review.

Le lun. 21 oct. 2024 =C3=A0 08:21, Fabio Estevam <festevam@gmail.com> a =C3=
=A9crit :
>
> Hi Gilles,
>
> On Sun, Oct 20, 2024 at 5:10=E2=80=AFPM Gilles Talis <gilles.talis@gmail.=
com> wrote:
>
> > +/ {
> > +       wdt-reboot {
> > +               compatible =3D "wdt-reboot";
> > +               wdt =3D <&wdog1>;
> > +               bootph-pre-ram;
> > +       };
>
> Please add a blank line here.
Noted.

>
> > +       firmware {
> > +               optee {
> > +                       compatible =3D "linaro,optee-tz";
> > +                       method =3D "smc";
> > +               };
> > +       };
> > +};
>
> > +&usdhc3 {
> > +       bootph-pre-ram;
> > +       mmc-hs400-1_8v;
> > +       mmc-hs400-enhanced-strobe;
>
> Why are the 2 properties above only present in the U-Boot dtsi and not
> in the kernel devicetree?
I think it is copy/paste without further verification :-)

>
> > +#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
> > +int board_phy_config(struct phy_device *phydev)
> > +{
> > +
> > +       /* enable rgmii rxc skew and phy mode select to RGMII copper */
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x1f);
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x8);
> > +
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x00);
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x82ee);
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x05);
> > +       phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, 0x100);
>
> Are these board code settings needed? Can't this be derived in the
> devicetree instead?
Yes, they are needed. I don't know how they can be derived in the
devicetree, but I will check.

>
> > +int board_late_init(void)
> > +{
> > +       return 0;
> > +}
>
> This can be removed, along with CONFIG_BOARD_LATE_INIT=3Dy.
OK. Will do.

>
> > diff --git a/board/emcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg b/board=
/emcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg
> > new file mode 100644
> > index 0000000000..999cb630fe
> > --- /dev/null
> > +++ b/board/emcraft/imx8mp_navqp/imximage-8mp-lpddr4.cfg
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2021, 2024 NXP
> > + */
> > +
> > +
>
> Remove the double-blank line.
OK.

>
> > +Get and Build the ARM Trusted Firmware (Trusted Firmware A)
> > +-----------------------------------------------------------
> > +
> > +.. code-block:: bash
> > +
> > +    $ echo "Downloading and building TF-A..."
> > +    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-=
a.git
> > +    $ cd trusted-firmware-a
>
> Please specify a specific branch of the trusted-firmware-a repo.
OK.

>
> > +/* Initial environment variables */
> > +#define CFG_EXTRA_ENV_SETTINGS         \
> > +       BOOTENV \
> > +       "scriptaddr=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> > +       "kernel_addr_r=3D" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> > +       "image=3DImage\0" \
> > +       "console=3Dttymxc1,115200 earlycon=3Dec_imx6q,0x30890000,115200=
\0" \
> > +       "fdt_addr_r=3D0x43000000\0"                       \
> > +       "boot_fdt=3Dtry\0" \
> > +       "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
> > +       "initrd_addr=3D0x43800000\0"              \
> > +       "bootm_size=3D0x10000000\0" \
> > +       "mmcpart=3D1\0" \
> > +       "mmcroot=3D/dev/mmcblk1p2 rootwait rw\0" \
>
> Please move the above variables to
> board/emcraft/imx8mp_navqp/imx8mp_navqp.env instead.
OK. Will do.

thanks
Gilles.
