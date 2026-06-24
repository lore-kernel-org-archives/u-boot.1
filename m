Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410A2CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EC83849C5;
	Wed, 24 Jun 2026 06:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="KgRhxZ32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5C4848DC; Wed, 24 Jun 2026 02:46:55 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3DE680398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 02:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5ad4c89ecd8so408869e87.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 17:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782262012; cv=none;
 d=google.com; s=arc-20240605;
 b=ANM+j1Qn8CBA8Pm27+xvOBWJ4Mh0Y1rPRgwv8iXfyV0rjbb/apOxZxi5tZP+X6BOPv
 08vCy1wSFIaiwZtQL6eg9t1z0tUiGFvTCPG07KmL2H3cn8L8tQLPb7khi5SqeiIdjYTD
 iZooW52NK0rkQIC49x3rcfjvlQOj5bQHRAbWUvF29C4jZS9dDb+F+a2sUZnJ3W2MerIP
 bKFa8IJ3o7tAZrdnQoDGofsgp1zboUuO50d678281/ebqCWxyPWqtj9K85SUt7cSQMzr
 bQ8Pb8uo/fvwydgt7CVHwudaXhei4VzYdHmdOHSNSMU7wCLoScaxr5VgiumNzH/FA6iM
 /d4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6lFtzZVNAcAvGIsrrplWLS6ONU78gALxJNkw7TBZ3XU=;
 fh=QIMOlvdDqyZo7chEADu8YgAKD0SmGz7tUU3v5ADtivM=;
 b=N1Sp5AdPzK5m5n67Ysukaa436iRdZCo9DaaPvth1VIA9x8TZgNFhmqY1EQMxokp6fr
 p9WCLc8rGIL7HHqsNqVnJmMV6+jYHAVC6sqy1WEuOXV7xNmpqkr900b8xQodYVaxmm9f
 dzUWlvw8Qs4QTj7DQcfQTvbZrJmbfpnBgKTaYfMeH8sFZ4FMbtMQLCz/0Ao3bD/6LYSI
 YMCHR2LpMO10ho/Wt0AH+4cotkaiA+ToTnduGInXLlN6j24q277rxY9Lm0m/hCszaRIP
 3aEKsn7iaqNrXnkkKldlvpSBmOT/kTUtvgmlknGXlY1ObQJD9A10bzH8RPb5hrXDfDx6
 D6/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782262012; x=1782866812;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lFtzZVNAcAvGIsrrplWLS6ONU78gALxJNkw7TBZ3XU=;
 b=KgRhxZ32UgOshsGa3OSkbsT8nBrskVX1TlLaFmZuaVaqv+DmWt9+S7/bwjYo3Xy0gR
 IlqLz58lzSLpp54LzdkKuWFVUmZxNgUMVUI6+Lr8LAm2tjb9cVWF/ubc7C+Ydo82FTB4
 7KfeYkE1ZlFqpexkNvyfNWPe+rF6iYwurhuHrb0fbIK9eQtKS9Ssre2Pp+I+85/lGBkY
 dl3IhkqIv0S8qbg5zChsmuqEH9KE8lfHep/ix6gI6F0nGBJDzkTKayAgwvSr+qhFmDSR
 +eXra5TF3v0f7bAqlOK+baTotmvh+A5x/QSWlI0Xz/e6LGpaiWin//3lI9Zz3EprqH1b
 i/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782262012; x=1782866812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6lFtzZVNAcAvGIsrrplWLS6ONU78gALxJNkw7TBZ3XU=;
 b=fRBAP8NfPjq0vHSmK9IdXL7LaylM3R/aayXxkLuDti6lWQvGepbWZC11BWGTyjKouA
 VjyiO3C7T1FFNkJ/+RPpoIdzmQnTm/vLfZGuF30A+grsKkhjT8cTuxyUAj9cLvfexMAH
 FGWIeU/uEAjWGG5ysusmCNTJeCf/LerkOoZ27ozyu4AswfXDffNw5E+5cYdzKAqM1zIx
 BTuPt0tPJT6asO6l+G+XFIdzdeU6Xh7DN3N/r1mi5IZ7wjVW1za3VZ7TUCrDTCyr19gM
 EfiQLkH4hp1mPHNKNkYBSd9LymiKBgqA4ldYS+OddgywpuiynrRRhXOQ/7+G9Lpdamp8
 BU8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hhY0x4pEiP9iH6MQvVC1n9xVLDLJ1zqTo2CD2mZ6Et0S6tSupXY4Vuw/xaMOR7UVQGvciEfE=@lists.denx.de
X-Gm-Message-State: AOJu0YxpzrMSAW31rDMgNPRFmXBZU52XCZJSUys5QNe5kLIg/HXGo3KS
 7v/Po7pmKj/s1urdPlb6Ik2fMHWft51iSHaYzMjU7FhMWoB26tQ8elkf+B7Oy/ksbq0/T3xx9ew
 DJ7QHx8PcnGFWoeS2vm7xl/BT1+LZqXBnrWo/fLJ7NQ==
X-Gm-Gg: AfdE7clNZb7/S5mgv0Jb9RanO2DFOURwfLZ+qkiNiMKXojBgF/9U9p2zTHPT4NCTbxk
 tan/WhcxdJeYU1zgcxiXqMvOjHbKlWj6P8KkPcPpYwmPYATKMXsyMTiWDjU4zYlRLpFNoiBEYNy
 NXJdDVvGHoU1P7s53tguQTE0WIPqLTJbZipP9glykas/Vnjvm8sSDhab48ERYgSWxUoYvsBCfh4
 PIVaq5LZ2Z3fKPgRmbc71+gyio4/BG17CScCoadaVEuexiZ20vFOwI2p/cO//pHfTurly2mZTQb
 EM+MdA/yPrn0ugbP6L5eB6NY6ukN9qh4AMeN20w3k0npKbZ7kwO4iLDknvSX+rHESbDEI1LKQw=
 =
X-Received: by 2002:ac2:5981:0:b0:5aa:64cb:9594 with SMTP id
 2adb3069b0e04-5ae9d57862cmr131943e87.15.1782262011993; Tue, 23 Jun 2026
 17:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-2-raymondmaoca@gmail.com> <aizTnMlko1Pg9pMb@pie>
In-Reply-To: <aizTnMlko1Pg9pMb@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 24 Jun 2026 08:46:40 +0800
X-Gm-Features: AVVi8CdK1Ip8F-6O10QCCdNqnXdeLjVhzOQY0OoCRluaUvBDNU1a6i3KCdNKRTU
Message-ID: <CAH22mJxFe79308nCXOpCtgrHhvw86EXjKZz5XAKKTVnGx_MzHA@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 24 Jun 2026 06:48:40 +0200
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

On Sat, Jun 13, 2026 at 11:51=E2=80=AFAM 'Yao Zi' via uboot <uboot@riscstar=
.com> wrote:
>
> On Fri, Jun 12, 2026 at 04:18:54PM -0400, Raymond Mao wrote:
> > From: Guodong Xu <guodong@riscstar.com>
> >
> > Add logic to determine the current boot device by reading the
> > SoC's configuration registers, rather than using a hardcoded
> > default.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> >  board/spacemit/k1/spl.c | 77 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 76 insertions(+), 1 deletion(-)
> >
> > diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> > index 0db362130e4..d5e87d79fa2 100644
> > --- a/board/spacemit/k1/spl.c
> > +++ b/board/spacemit/k1/spl.c
>
> ...
>
> > @@ -379,7 +401,60 @@ void board_init_f(ulong dummy)
> >
> >  u32 spl_boot_device(void)
> >  {
> > -     return BOOT_DEVICE_SPI;
> > +     void __iomem *boot_dev =3D (void __iomem *)BOOT_DEV_FLAG_REG;
> > +     void __iomem *boot_strap =3D (void __iomem *)BOOT_PIN_SEL_REG;
> > +     u32 mode, sel, ret =3D 0;
> > +
> > +     mode =3D readl(boot_dev);
> > +     if (mode =3D=3D BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
> > +             sel =3D readl(boot_strap);
> > +             sel >>=3D BOOT_STRAP_MODE_OFFSET;
> > +             sel &=3D BOOT_STRAP_MODE_MASK;
>
> Is FIELD_GET() helpful here?
>
Yes, we can use FIELD_GET().

> > +             switch (sel) {
> > +             case BOOT_STRAP_MODE_EMMC:
> > +                     mode =3D BOOT_MODE_EMMC;
> > +                     break;
> > +             case BOOT_STRAP_MODE_NAND:
> > +                     mode =3D BOOT_MODE_NAND;
> > +                     break;
> > +             case BOOT_STRAP_MODE_SPI:
> > +                     mode =3D BOOT_MODE_SPI;
> > +                     break;
> > +             case BOOT_STRAP_MODE_SD:
> > +             default:
> > +                     mode =3D BOOT_MODE_SD;
> > +                     break;
> > +             }
> > +     }
> > +     /* TODO:
> > +      *   The current upstream DTS file only contains the eMMC node. W=
hen
> > +      *   the SD node is added via an overlay, the eMMC device ends up=
 as
> > +      *   MMC1 in SPL.
>
> Why not fix this with an extra alias in the overlay dt?
>

That approach doesn't really help =E2=80=94 with the alias, mmc0 and mmc1 g=
et
swapped, which ultimately breaks ABI consistency.

The hack on MMC1 only affects its role in SPL and doesn't impact the
ABI in the devicetree. It's just a workaround. Eventually, both the
overlay and the hack will be removed once the upstream DTS is robust
enough.


> > +      *   However, the SD device should be the first device (MMC1).
> > +      *   This sequence needs to be corrected once the SD node is merg=
ed
> > +      *   into the upstream U-Boot DTS file.
> > +      */
> > +     switch (mode) {
> > +     case BOOT_MODE_EMMC:
> > +             ret =3D BOOT_DEVICE_MMC1;
> > +             break;
> > +     case BOOT_MODE_NAND:
> > +             ret =3D BOOT_DEVICE_NAND;
> > +             break;
> > +     case BOOT_MODE_SPI:
> > +             ret =3D BOOT_DEVICE_SPI;
> > +             break;
> > +     case BOOT_MODE_USB:
> > +             ret =3D BOOT_DEVICE_USB;
> > +             break;
> > +     case BOOT_MODE_SD:
> > +             ret =3D BOOT_DEVICE_MMC2;
> > +             break;
> > +     default:
> > +             ret =3D BOOT_DEVICE_MMC1;
> > +             break;
> > +     }
> > +     return ret;
> >  }
> >
> >  void spl_board_init(void)
> > --
> > 2.25.1
> >
>
> Regards,
> Yao Zi
