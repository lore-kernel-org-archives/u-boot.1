Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77380C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 07:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADCB1886B3;
	Mon,  5 Aug 2024 09:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YenUOHDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A426D887B9; Mon,  5 Aug 2024 09:11:06 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF898854A
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 09:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3685b3dbcdcso5954515f8f.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722841864; x=1723446664; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPBEka04mIms4nEJMPc16MaDlP5DusiXcCyRpQdYuy0=;
 b=YenUOHDQDQ8SvLBTrb3GXvx59mjFOyXi6D3/FhJVBS3O+Vgb5dhIYhWPLHbqCQsuFs
 lgfGh7AAwmN4kAi1BypIPtMYd1p2C0Znrc9bp9qz3lZFwcBocgP7twc7rf1edzQDfUT1
 ea7uAClbrBmGfwb87XbmymQE4R9RccL5fWbWM31WiJy0Y632xyygOKLJYcK6uf3DyN5Y
 maMwBMCVA2H8aU2CG6N+mZfx6QVGSjhPdzdCkkriBu6FEu+lmmm6YX4XlA+vISLTXlPA
 G9rz/4L2cL2u2WxYpVi3QaIdZVX86k2CNAwxa3kIdiRKMJWdjV/OBt97UO00tVbqvVWb
 c+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722841864; x=1723446664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPBEka04mIms4nEJMPc16MaDlP5DusiXcCyRpQdYuy0=;
 b=w5YbquiisN6p9NSFOkZqDwhe0IYJSVaqMQWpUnUIozD761S3nRU9n6+qh8vrS30aMe
 zKGjeL3DyGtAAZMQdKDHF3rhrPiuMXmomL9vJTJvv8N64xpF6g9u86Vik8ADRCJ54oiL
 TaibO84y9D0iKDA4t11okvQm/12oVlXtwUU4P5i9tUOIzFceL02y5K0uF1+ptrjdhbN1
 jmS4m8WMyUmaDrUoHb19FxisM9OVGSTtJ4PvVOJ3Gt1AM02dsh5ZXxSi3gFhnTrVScI+
 PcFSGKg/HoiEub7FSBSaI/85n4waYyV2ST0bMI7NxyHuuKJwQbfdVj1hGGvxH9HI4+Zr
 bwKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsP7smJB0lGJV0vgxG6cWCY7SjM+nk+kHoJzyzQyqfAjfHBiFweodB9qyd1RuZB5d3ejlIMDRi89cVcU3EgFH/8zAsqA==
X-Gm-Message-State: AOJu0YzIxB39NLNf22GSllGtpmJsQeSTY+5VwQCI3l8Y34Gqvs4jM3Mq
 m82xZVrt6wHHQZrajXwsU58aczFoofDiKaxAaS02c2DwR2N2jOY4p+bA9eOVD/XwqeGSrlZJ487
 YDArCvfOUqL775J8k9UoMZR+Bv78=
X-Google-Smtp-Source: AGHT+IE/pXJFoZwAX09RZAoR7mJw37VyjEOeV05+bAjdFyTat68rhq+vYyT7by+5gIzg/S+nMQ6yJ8M6Smyi96AfmJQ=
X-Received: by 2002:a5d:6d87:0:b0:366:e7b5:3b49 with SMTP id
 ffacd0b85a97d-36bbc1c246dmr8815515f8f.54.1722841863684; Mon, 05 Aug 2024
 00:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240801055738.7601-1-clamor95@gmail.com>
 <20240801055738.7601-2-clamor95@gmail.com>
 <20240805053157.GA7516@francesco-nb>
 <CAPVz0n1TQ=bzvEv3OW_k+sBYVx13oRH6Oc_yfrhjNoe5+ujgoA@mail.gmail.com>
 <ZrB5nBI3GLA--gPQ@gaggiata.pivistrello.it>
 <CAPVz0n0s57E=x8cQZO7dzTXTjOkQMtQ6PF4A=8yM6P5an5BbgQ@mail.gmail.com>
 <ZrB6cpRQsO4-uFHM@gaggiata.pivistrello.it>
In-Reply-To: <ZrB6cpRQsO4-uFHM@gaggiata.pivistrello.it>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 5 Aug 2024 10:10:52 +0300
Message-ID: <CAPVz0n3AVp+wZ=0apbu+rfv06NX1J+T_hKnO6ZKpQ7zwCY4Cjw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] board: tegra: convert tegra-based boards to text
 env
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
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

=D0=BF=D0=BD, 5 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 10:08=
 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Aug 05, 2024 at 10:06:04AM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 5 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 1=
0:05 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon, Aug 05, 2024 at 10:01:27AM +0300, Svyatoslav Ryhel wrote:
> > > > =D0=BF=D0=BD, 5 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=
=BE 08:32 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > > > On Thu, Aug 01, 2024 at 08:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > > > > Convert boards to use text based env. This is the first stage o=
f
> > > > > > conversion, common inclusions should be converted next.
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  board/asus/grouper/grouper.env                | 15 +++
> > > > > >  .../asus/transformer-t20/transformer-t20.env  | 16 ++++
> > > > > >  .../transformer-t30/configs/tf600t.config     |  1 +
> > > > > >  board/asus/transformer-t30/tf600t.env         | 16 ++++
> > > > > >  .../asus/transformer-t30/transformer-t30.env  | 16 ++++
> > > > > >  board/htc/endeavoru/endeavoru.env             | 13 +++
> > > > > >  .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
> > > > > >  board/lg/x3-t30/configs/p880.config           |  1 +
> > > > > >  board/lg/x3-t30/configs/p895.config           |  1 +
> > > > > >  board/lg/x3-t30/p880.env                      | 14 +++
> > > > > >  board/lg/x3-t30/p895.env                      | 13 +++
> > > > > >  board/microsoft/surface-rt/surface-rt.env     | 14 +++
> > > > > >  board/nvidia/cardhu/cardhu.env                |  2 +
> > > > > >  board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
> > > > > >  board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
> > > > > >  board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
> > > > > >  board/toradex/apalis_t30/apalis_t30.env       |  9 ++
> > > > > >  board/toradex/colibri_t20/colibri_t20.env     |  3 +
> > > > > >  board/toradex/colibri_t30/colibri_t30.env     |  9 ++
> > > > > >  board/wexler/qc750/qc750.env                  | 14 +++
> > > > > >  configs/apalis-tk1_defconfig                  |  1 +
> > > > > >  configs/apalis_t30_defconfig                  |  1 +
> > > > > >  configs/cardhu_defconfig                      |  1 +
> > > > > >  configs/colibri_t20_defconfig                 |  1 +
> > > > > >  configs/colibri_t30_defconfig                 |  1 +
> > > > >
> > > > > ...
> > > > >
> > > > > > diff --git a/board/toradex/apalis-tk1/apalis_tk1.env b/board/to=
radex/apalis-tk1/apalis_tk1.env
> > > > > > new file mode 100644
> > > > > > index 0000000000..90db361be3
> > > > > > --- /dev/null
> > > > > > +++ b/board/toradex/apalis-tk1/apalis_tk1.env
> > > > > > @@ -0,0 +1,45 @@
> > > > > > +/*
> > > > > > + * Custom Distro Boot configuration:
> > > > > > + * 1. 8bit SD port (MMC1)
> > > > > > + * 2. 4bit SD port (MMC2)
> > > > > > + * 3. eMMC (MMC0)
> > > > > > + */
> > > > > > +boot_targets=3Dmmc1 mmc2 mmc0 usb pxe dhcp
> > > > > > +
> > > > > > +boot_file=3DzImage
> > > > > > +boot_script_dhcp=3Dboot.scr
> > > > > > +console=3DttyS0
> > > > > > +defargs=3Dlp0_vec=3D2064@0xf46ff000 core_edp_mv=3D1150 core_ed=
p_ma=3D4000
> > > > > > +     usb_port_owner_info=3D2 lane_owner_info=3D6 emc_max_dvfs=
=3D0
> > > > > > +     user_debug=3D30 pcie_aspm=3Doff
> > > > > > +dfu_alt_info=3Dapalis-tk1.img raw 0x0 0x500 mmcpart 1;
> > > > > > +     boot part 0 1 mmcpart 0;
> > > > > > +     rootfs part 0 2 mmcpart 0;
> > > > > > +     zImage fat 0 1 mmcpart 0;
> > > > > > +     tegra124-apalis-eval.dtb fat 0 1 mmcpart 0
> > > > > > +fdt_board=3Deval
> > > > > > +fdt_fixup=3D;
> > > > > > +fdt_module=3Dapalis-v1.2
> > > > > > +uboot_hwpart=3D1
> > > > > > +uboot_blk=3D0
> > > > > > +set_blkcnt=3Dsetexpr blkcnt ${filesize} + 0x1ff &&
> > > > > > +     setexpr blkcnt ${blkcnt} / 0x200
> > > > > > +update_uboot=3Drun set_blkcnt && mmc dev 0 ${uboot_hwpart} &&
> > > > > > +     mmc write ${loadaddr} ${uboot_blk} ${blkcnt}
> > > > > > +setethupdate=3Dif env exists ethaddr; then; else setenv ethadd=
r
> > > > > > +     00:14:2d:00:00:00; fi; pci enum && tftpboot ${loadaddr}
> > > > > > +     flash_eth.img && source ${loadaddr}
> > > > > > +setsdupdate=3Dsetenv interface mmc; setenv drive 1; mmc rescan=
;
> > > > > > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img
> > > > > > +     || setenv drive 2; mmc rescan; load ${interface} ${drive}=
:1
> > > > > > +     ${loadaddr} flash_blk.img &&
> > > > > > +     source ${loadaddr}
> > > > > > +setup=3Dsetenv setupargs igb_mac=3D${ethaddr}
> > > > > > +     consoleblank=3D0 no_console_suspend=3D1 console=3Dtty1
> > > > > > +     console=3D${console},${baudrate}n8 debug_uartport=3Dlspor=
t,0
> > > > > > +     ${memargs}
> > > > > > +setupdate=3Drun setsdupdate || run setusbupdate || run setethu=
pdate
> > > > > > +setusbupdate=3Dusb start && setenv interface usb; setenv drive=
 0;
> > > > > > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img &&
> > > > > > +     source ${loadaddr}
> > > > > > +vidargs=3Dfbcon=3Dmap:1
> > > > >
> > > > > ...
> > > > >
> > > > > > diff --git a/include/configs/apalis-tk1.h b/include/configs/apa=
lis-tk1.h
> > > > > > index 71d4727ca9..4c690a1785 100644
> > > > > > --- a/include/configs/apalis-tk1.h
> > > > > > +++ b/include/configs/apalis-tk1.h
> > > > > > @@ -18,64 +18,6 @@
> > > > > >  #define FDT_MODULE                   "apalis-v1.2"
> > > > > >  #define FDT_MODULE_V1_0                      "apalis"
> > > > > >
> > > > > > -/*
> > > > > > - * Custom Distro Boot configuration:
> > > > > > - * 1. 8bit SD port (MMC1)
> > > > > > - * 2. 4bit SD port (MMC2)
> > > > > > - * 3. eMMC (MMC0)
> > > > > > - */
> > > > > > -#define BOOT_TARGET_DEVICES(func) \
> > > > > > -     func(MMC, mmc, 1) \
> > > > > > -     func(MMC, mmc, 2) \
> > > > > > -     func(MMC, mmc, 0) \
> > > > > > -     func(USB, usb, 0) \
> > > > > > -     func(PXE, pxe, na) \
> > > > > > -     func(DHCP, dhcp, na)
> > > > > > -
> > > > >
> > > > > I do recall that to transition to text env file it was required t=
o move
> > > > > from standard boot to distroboot. Did I recall incorrectly?
> > > >
> > > > Are you 100% sure? Have you tried?
> > >
> > > No, I am not, but Simon in copy knows for sure.
> > >
> > > What I am sure is that I mean migrating from distroboot to standard b=
oot, the
> > > opposite of what I wrote ...
> >
> > Tegra uses standard boot
>
> BOOT_TARGET_DEVICES seems distroboot to me.
>

It seems that Tegra switched to standard boot, but Toradex boards were
not adjusted.

> Francesco
>
