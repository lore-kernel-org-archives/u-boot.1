Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCECCDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A9A8460E;
	Wed, 24 Jun 2026 09:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="MGaPS/eS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE5984671; Wed, 24 Jun 2026 09:26:04 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DD080287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5aa2c25c632so683924e87.1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 00:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782285956; cv=none;
 d=google.com; s=arc-20240605;
 b=ROdPgHfgbNFkbVBHS4NJmW8lvqYhGiPmOmpfgaCgjuWLQvElUWaMd1tcxWzG9kQHoI
 oDRUkieB8+nZNPy/3yuO3tjOvDp7fVV0ExBzllBOvvD+bD5nx/cTjkftX8Xbgfkn6Tl3
 mq9WPIoQe1mAUqP2pR8Oo/ey4orSE8Ngxh2SrV1odgGj9Q0SjX2vk5tymAWjNfwvtxcg
 jZo9b+JIEUZWBWCvG/z5BArlxP4cqkjqWBtZSa/7X7DWsTfwE1mBE+QW5SGBg792MrUI
 X2192iwq60qJQRiUA68M43glnDUNCLVkXxBEIiWvkDJegWHOpl+VS4X4Ji3yM0JKv2+j
 JFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iOK/p/mgHsH2KufZeHLljOIxp5gI43acyDMqBdDG/hU=;
 fh=ZADCylbINlJ1lUV7lYqvxrRz9Xg2SHqJs4yArFKHN3k=;
 b=OpuD0XPFSSUm2Wf+R54kZ3/48xh7FsJvFPaW8kz/sU0vjk0eZ5VH7o/2ySAqDXWnGk
 mi75XfS4jRnQvutlqlKN3Gz8SxwJKFoPzvJQTmcjQJGqpQkfX3cOOm4quDwNV8ktxDba
 EbMIYQKYVBIrlEmkOCGqkUJT50UZppCDV90h5XKg3KcKmzPzo6e3zVraW8w3d5foD00b
 UprRw7x6VTuy52+r28lgVO0YeS7JC2vzPx70fn/xvClaV5XeQ3kVjTtUl3Dj3TGQxPrg
 8+oypWUNRRR1OSnmEc0G13JF/5Iej++oyrVGaPLNZIJkuSFMvb5st1xfyRrkFF7nlZnm
 Ak6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782285956; x=1782890756;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOK/p/mgHsH2KufZeHLljOIxp5gI43acyDMqBdDG/hU=;
 b=MGaPS/eSdA55BFg5uj+iQkipBeHau9nMYuO/cus+8/Aqhys8DtDeV1/xozl/JCUXGC
 uZEgYFzPywUzoQ0ypq+ctzS9f3UGkxTntY65JMt/YJIz1T+k4Ud/zvIwd7Ei9uiyNbuK
 FM40IexkBMD+WGa0WHIutE5AZ5P1PoUz5POOpxRpdWmg/EQ+6skW/imDZNH+FE+Z0MfM
 UKqsq2ITaaXq1RDhCGpOnNPVOW0v6zL654pAh6PsmQoRG3Y7+IDCKMamArm+pKOHdAZK
 s/d+yphWHn5RalXgZ1X62Fx9voNk11+9JMkGj5yQr/8c9pWH8Mso+mDnh2iB1Tl+TXrI
 UjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782285956; x=1782890756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iOK/p/mgHsH2KufZeHLljOIxp5gI43acyDMqBdDG/hU=;
 b=b/rIZzE0IG9AKY9qMK8rN38FPmUGKvxkEz67iGMBjITYjYqk4NjhIX7CweQeCzEL5Z
 yIK0JLWeR4I/xhMQoAr3gLTWxIe0l+rjGuLtq7HUl5wX0dTmBdPmjEt5BMM4HY3eQdG6
 VNQ8ob+kqfouo9g5U/NNFDZFqCk0wqvUoJJ3LeEttRva7h9/JbcUg2iijzd7r01gk7Mp
 UYEF3qbiK1MZ8EyFtmj37PvxQcjdzGA5gjHbuVqLLKbRQXiXOUwJYo2ZKlPgy2jgiL5P
 H4X41cP61TcOYqtyWmgAwDh+LW2HSWX7BifmAd0JrVMjR2UO/Bn5bDmTQE5rqui5CgmK
 oxxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cCyQ99nMDCmeS96JOtlkHTi1xQvUSwSweDS0LPZt8ydA1C32OdYPP4DbfucuAnXHRHKn6RGM=@lists.denx.de
X-Gm-Message-State: AOJu0YwpaD6ANiySqJouqYt6dgVp82g0JzX/srK7XSKTHy4kKCYGzCSC
 b7U3Z2cmgsw7NhA4/zwZtKXGILN9vAUIpWeoEYGVC19hTTJGomov8Wy7HzSYJGzLdpSQluQitDU
 BaydCHSxmUEHNO6X+7dk5v5LTIQGufuIoQcEwpayImQ==
X-Gm-Gg: AfdE7cmrPVIxoNOlz+bglstT07l1bem3o/koSedr3RPNmFZlhiJE0WTQOujvI4keguT
 31FjeQCJdNM7HS4NPlMcYsm/SIt8VXtwHPwsGWyDRkczEXiS/WLXLQFMbixY0/d9ZCIc95bbpdR
 Y/nDMB5CcW+wN5BmUa/qCEG3lcc6o4N1Dx5vFrm0Awl5BsB5HCOQJZtgzBnoWcllEruxYezhZb5
 qfXwYa+fF7vgPUmwqw8EYADBwuqP/GbwX4wBMPWEOK3tHLFd/nXg2OBF8gU77Mm/cSGGKSLs83t
 3npgLM4mbEdLorWqow+nIA9BmeSOcikRBF9BAiP3Dpm9aq2osECSvUQ8/U/iC7j2V6Fgn5B8YA=
 =
X-Received: by 2002:ac2:4883:0:b0:5ad:68a7:e0fe with SMTP id
 2adb3069b0e04-5ae9d5886b0mr335919e87.37.1782285956174; Wed, 24 Jun 2026
 00:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-2-raymondmaoca@gmail.com> <aizTnMlko1Pg9pMb@pie>
 <CAH22mJxFe79308nCXOpCtgrHhvw86EXjKZz5XAKKTVnGx_MzHA@mail.gmail.com>
 <ajteq071XCoIDM8-@pie>
In-Reply-To: <ajteq071XCoIDM8-@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 24 Jun 2026 15:25:43 +0800
X-Gm-Features: AVVi8CfBDko_6pBWEZKF_O925z5iv-Je5uC1ua-p9m835XtFw0tP4jmpLGB8CR4
Message-ID: <CAH22mJw48+TQN=3BOETgc5RvD_U_keTraFusBiM2N08EKsFfrw@mail.gmail.com>
Subject: Re: [PATCH 1/8] spacemit: k1: select boot device via config registers
To: Yao Zi <me@ziyao.cc>
Cc: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de,
 uboot@riscstar.com, 
 u-boot-spacemit@groups.io, raymond.mao@riscstar.com, rick@andestech.com, 
 ycliang@andestech.com, trini@konsulko.com, lukma@denx.de, hs@nabladev.com, 
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de, 
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech, 
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org, 
 Guodong Xu <guodong@riscstar.com>
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

On Wed, Jun 24, 2026 at 12:36=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Wed, Jun 24, 2026 at 08:46:40AM +0800, Eric Chung wrote:
> > On Sat, Jun 13, 2026 at 11:51=E2=80=AFAM 'Yao Zi' via uboot <uboot@risc=
star.com> wrote:
> > >
> > > On Fri, Jun 12, 2026 at 04:18:54PM -0400, Raymond Mao wrote:
> > > > From: Guodong Xu <guodong@riscstar.com>
> > > >
> > > > Add logic to determine the current boot device by reading the
> > > > SoC's configuration registers, rather than using a hardcoded
> > > > default.
> > > >
> > > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > > ---
> > > >  board/spacemit/k1/spl.c | 77 +++++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 76 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> > > > index 0db362130e4..d5e87d79fa2 100644
> > > > --- a/board/spacemit/k1/spl.c
> > > > +++ b/board/spacemit/k1/spl.c
> > >
> > > ...
> > > > +             switch (sel) {
> > > > +             case BOOT_STRAP_MODE_EMMC:
> > > > +                     mode =3D BOOT_MODE_EMMC;
> > > > +                     break;
> > > > +             case BOOT_STRAP_MODE_NAND:
> > > > +                     mode =3D BOOT_MODE_NAND;
> > > > +                     break;
> > > > +             case BOOT_STRAP_MODE_SPI:
> > > > +                     mode =3D BOOT_MODE_SPI;
> > > > +                     break;
> > > > +             case BOOT_STRAP_MODE_SD:
> > > > +             default:
> > > > +                     mode =3D BOOT_MODE_SD;
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +     /* TODO:
> > > > +      *   The current upstream DTS file only contains the eMMC nod=
e. When
> > > > +      *   the SD node is added via an overlay, the eMMC device end=
s up as
> > > > +      *   MMC1 in SPL.
> > >
> > > Why not fix this with an extra alias in the overlay dt?
> > >
> >
> > That approach doesn't really help =E2=80=94 with the alias, mmc0 and mm=
c1 get
> > swapped, which ultimately breaks ABI consistency.
>
> Sorry I didn't read you correctly, I'm not sure which you are trying to
> keep consistency with.
>
> I did a check in Linux next-20260623, and the aliases for bananapi-f3
> look like,
>
>         aliases {
>                 ethernet0 =3D &eth0;
>                 ethernet1 =3D &eth1;
>                 serial0 =3D &uart0;
>                 spi3 =3D &spi3;
>                 i2c2 =3D &i2c2;
>                 i2c8 =3D &i2c8;
>                 mmc0 =3D &emmc;
>                 mmc1 =3D &sdhci0;
>         };
>
> and for musepi-pro,
>
>         aliases {
>                 ethernet0 =3D &eth0;
>                 serial0 =3D &uart0;
>                 i2c2 =3D &i2c2;
>                 i2c8 =3D &i2c8;
>                 mmc0 =3D &emmc;
>                 mmc1 =3D &sdhci0;
>         };
>
> So both of them assign emmc to mmc0 and sdhci0 (SD) to mmc1.
>
> As a summary of the situation,
>
> - Linux before SD card support is merged: emmc becomes mmc0 (without
>   other hotpluggable devices present), no SD card
> - Linux after SD card support is merged: emmc becomes mmc0, SD becomes
>   mmc1
>
Because I don't know there's a new alias in upstream DTS.
OK. I can use the alias in uboot.

> But PATCH 3 in the series assigns SD to mmc0 and emmc to MMC1, this
> instead looks like an ABI breakage, and would go away as long as you
> change the aliases? At the same time the comment here could be dropped.
>
> > The hack on MMC1 only affects its role in SPL and doesn't impact the
> > ABI in the devicetree. It's just a workaround. Eventually, both the
> > overlay and the hack will be removed once the upstream DTS is robust
> > enough.
> >
> >
> > > > +      *   However, the SD device should be the first device (MMC1)=
.
> > > > +      *   This sequence needs to be corrected once the SD node is =
merged
> > > > +      *   into the upstream U-Boot DTS file.
> > > > +      */
> > > > +     switch (mode) {
> > > > +     case BOOT_MODE_EMMC:
> > > > +             ret =3D BOOT_DEVICE_MMC1;
> > > > +             break;
> > > > +     case BOOT_MODE_NAND:
> > > > +             ret =3D BOOT_DEVICE_NAND;
> > > > +             break;
> > > > +     case BOOT_MODE_SPI:
> > > > +             ret =3D BOOT_DEVICE_SPI;
> > > > +             break;
> > > > +     case BOOT_MODE_USB:
> > > > +             ret =3D BOOT_DEVICE_USB;
> > > > +             break;
> > > > +     case BOOT_MODE_SD:
> > > > +             ret =3D BOOT_DEVICE_MMC2;
> > > > +             break;
> > > > +     default:
> > > > +             ret =3D BOOT_DEVICE_MMC1;
> > > > +             break;
> > > > +     }
> > > > +     return ret;
> > > >  }
> > > >
> > > >  void spl_board_init(void)
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Regards,
> > > Yao Zi
>
> Regards,
> Yao Zi
