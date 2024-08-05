Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF339C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 07:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B34881A1;
	Mon,  5 Aug 2024 09:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kmV0gz54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA1188677; Mon,  5 Aug 2024 09:06:19 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D8B880E6
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 09:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ef23d04541so116155031fa.2
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722841576; x=1723446376; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4gerDH71MDuDVabRP2yV38txUTDskecZlOQ9qcROTZ8=;
 b=kmV0gz5474qke+FQkEO7hx7xDaYW/o146PCldQirsZ06lPkTVcPpnFRCF4qklaHv4J
 YeHEqx7lgn5kw3CwFyQR97wofcUTvleP9hD3/lybSvPUNknAhXceCrfpNvmom/l7Fe+t
 /T0tyJ68nobsuUCmDCmEuJhLqh3NMjuD61AmXAURLdVIEwXYBbs4/uCKfVPvd0CcHUCb
 mzrKkKEEKUqyD8AU2PV/+xHZBNfkXbT1yVg84u4OAxOW54nwN045gqNA9iYZi+n+024e
 7MU0jBZvs7kU7C7NHp21zLdsUxynXTT5joD5UsZYlT/L8ksarv5kF4k+DOTPHI2DT0wU
 bisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722841576; x=1723446376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gerDH71MDuDVabRP2yV38txUTDskecZlOQ9qcROTZ8=;
 b=IBwuCwo88iYy9x0ICTR+04u4U2WFY4z+AYlkeqqJKxCJXL6t6hd9rTzWw0HImlhV4e
 hskbq+sJblcliR28i/ShCzosGTwvhtUNM86dUpKzAAxQBveLNR7iQXzPD6V83AWwZ413
 Dd+ZYVTbafaABdMcPnD0U2b3wLGCu4zs6Xn7Bodlutp3yyPE6rXydnO/tclE1+Kpf2DL
 HW/vNry8wnjrWN8Rd0R9toyxjQoqpVwsHO9aLJW1fshOOnq9hAUog725LNPNWEyONK1s
 y6Jc+3e+4kZ5SBoF03VBAhZLk9KrlQEW3ZpQkBwoBr99d9z5aOea5DwTh6L5Pw30SF0Y
 x/eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViXtM99lQm444gdxmHlfxFuHhp8N1BziDnEKPUqgSPShNbKN9Hhzu2H58xPF+qNMia1rJUX3AKgD3bVqc2G6XgkBQ1Yw==
X-Gm-Message-State: AOJu0Yxi2pKm/DF56Vdz4Zw3B5m14uLUzpRQzfJsw5W8LQ1v++KA3RSi
 3F1xPzL1SLXrv7gB54lwf7cIkZv1Qfz3vbyitPvo/WMOq3foDVdLtfuNTa2tOC/DUGWl+PtJilm
 jO3v9FIXq7fY+Es4spS10HtXn+XU=
X-Google-Smtp-Source: AGHT+IHvMi9juCDJqkQ6+9/VnhlSjB07reS2zlfy3JVISNyCku80fWZI4cqNa29l1koTjftg0E5TmKvFddiw7+OVBvo=
X-Received: by 2002:a05:6512:b08:b0:530:ae99:c7fa with SMTP id
 2adb3069b0e04-530bb362e5fmr7457224e87.10.1722841575697; Mon, 05 Aug 2024
 00:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240801055738.7601-1-clamor95@gmail.com>
 <20240801055738.7601-2-clamor95@gmail.com>
 <20240805053157.GA7516@francesco-nb>
 <CAPVz0n1TQ=bzvEv3OW_k+sBYVx13oRH6Oc_yfrhjNoe5+ujgoA@mail.gmail.com>
 <ZrB5nBI3GLA--gPQ@gaggiata.pivistrello.it>
In-Reply-To: <ZrB5nBI3GLA--gPQ@gaggiata.pivistrello.it>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 5 Aug 2024 10:06:04 +0300
Message-ID: <CAPVz0n0s57E=x8cQZO7dzTXTjOkQMtQ6PF4A=8yM6P5an5BbgQ@mail.gmail.com>
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

=D0=BF=D0=BD, 5 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 10:05=
 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Aug 05, 2024 at 10:01:27AM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 5 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 0=
8:32 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Thu, Aug 01, 2024 at 08:57:38AM +0300, Svyatoslav Ryhel wrote:
> > > > Convert boards to use text based env. This is the first stage of
> > > > conversion, common inclusions should be converted next.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  board/asus/grouper/grouper.env                | 15 +++
> > > >  .../asus/transformer-t20/transformer-t20.env  | 16 ++++
> > > >  .../transformer-t30/configs/tf600t.config     |  1 +
> > > >  board/asus/transformer-t30/tf600t.env         | 16 ++++
> > > >  .../asus/transformer-t30/transformer-t30.env  | 16 ++++
> > > >  board/htc/endeavoru/endeavoru.env             | 13 +++
> > > >  .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
> > > >  board/lg/x3-t30/configs/p880.config           |  1 +
> > > >  board/lg/x3-t30/configs/p895.config           |  1 +
> > > >  board/lg/x3-t30/p880.env                      | 14 +++
> > > >  board/lg/x3-t30/p895.env                      | 13 +++
> > > >  board/microsoft/surface-rt/surface-rt.env     | 14 +++
> > > >  board/nvidia/cardhu/cardhu.env                |  2 +
> > > >  board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
> > > >  board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
> > > >  board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
> > > >  board/toradex/apalis_t30/apalis_t30.env       |  9 ++
> > > >  board/toradex/colibri_t20/colibri_t20.env     |  3 +
> > > >  board/toradex/colibri_t30/colibri_t30.env     |  9 ++
> > > >  board/wexler/qc750/qc750.env                  | 14 +++
> > > >  configs/apalis-tk1_defconfig                  |  1 +
> > > >  configs/apalis_t30_defconfig                  |  1 +
> > > >  configs/cardhu_defconfig                      |  1 +
> > > >  configs/colibri_t20_defconfig                 |  1 +
> > > >  configs/colibri_t30_defconfig                 |  1 +
> > >
> > > ...
> > >
> > > > diff --git a/board/toradex/apalis-tk1/apalis_tk1.env b/board/torade=
x/apalis-tk1/apalis_tk1.env
> > > > new file mode 100644
> > > > index 0000000000..90db361be3
> > > > --- /dev/null
> > > > +++ b/board/toradex/apalis-tk1/apalis_tk1.env
> > > > @@ -0,0 +1,45 @@
> > > > +/*
> > > > + * Custom Distro Boot configuration:
> > > > + * 1. 8bit SD port (MMC1)
> > > > + * 2. 4bit SD port (MMC2)
> > > > + * 3. eMMC (MMC0)
> > > > + */
> > > > +boot_targets=3Dmmc1 mmc2 mmc0 usb pxe dhcp
> > > > +
> > > > +boot_file=3DzImage
> > > > +boot_script_dhcp=3Dboot.scr
> > > > +console=3DttyS0
> > > > +defargs=3Dlp0_vec=3D2064@0xf46ff000 core_edp_mv=3D1150 core_edp_ma=
=3D4000
> > > > +     usb_port_owner_info=3D2 lane_owner_info=3D6 emc_max_dvfs=3D0
> > > > +     user_debug=3D30 pcie_aspm=3Doff
> > > > +dfu_alt_info=3Dapalis-tk1.img raw 0x0 0x500 mmcpart 1;
> > > > +     boot part 0 1 mmcpart 0;
> > > > +     rootfs part 0 2 mmcpart 0;
> > > > +     zImage fat 0 1 mmcpart 0;
> > > > +     tegra124-apalis-eval.dtb fat 0 1 mmcpart 0
> > > > +fdt_board=3Deval
> > > > +fdt_fixup=3D;
> > > > +fdt_module=3Dapalis-v1.2
> > > > +uboot_hwpart=3D1
> > > > +uboot_blk=3D0
> > > > +set_blkcnt=3Dsetexpr blkcnt ${filesize} + 0x1ff &&
> > > > +     setexpr blkcnt ${blkcnt} / 0x200
> > > > +update_uboot=3Drun set_blkcnt && mmc dev 0 ${uboot_hwpart} &&
> > > > +     mmc write ${loadaddr} ${uboot_blk} ${blkcnt}
> > > > +setethupdate=3Dif env exists ethaddr; then; else setenv ethaddr
> > > > +     00:14:2d:00:00:00; fi; pci enum && tftpboot ${loadaddr}
> > > > +     flash_eth.img && source ${loadaddr}
> > > > +setsdupdate=3Dsetenv interface mmc; setenv drive 1; mmc rescan;
> > > > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img
> > > > +     || setenv drive 2; mmc rescan; load ${interface} ${drive}:1
> > > > +     ${loadaddr} flash_blk.img &&
> > > > +     source ${loadaddr}
> > > > +setup=3Dsetenv setupargs igb_mac=3D${ethaddr}
> > > > +     consoleblank=3D0 no_console_suspend=3D1 console=3Dtty1
> > > > +     console=3D${console},${baudrate}n8 debug_uartport=3Dlsport,0
> > > > +     ${memargs}
> > > > +setupdate=3Drun setsdupdate || run setusbupdate || run setethupdat=
e
> > > > +setusbupdate=3Dusb start && setenv interface usb; setenv drive 0;
> > > > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img &&
> > > > +     source ${loadaddr}
> > > > +vidargs=3Dfbcon=3Dmap:1
> > >
> > > ...
> > >
> > > > diff --git a/include/configs/apalis-tk1.h b/include/configs/apalis-=
tk1.h
> > > > index 71d4727ca9..4c690a1785 100644
> > > > --- a/include/configs/apalis-tk1.h
> > > > +++ b/include/configs/apalis-tk1.h
> > > > @@ -18,64 +18,6 @@
> > > >  #define FDT_MODULE                   "apalis-v1.2"
> > > >  #define FDT_MODULE_V1_0                      "apalis"
> > > >
> > > > -/*
> > > > - * Custom Distro Boot configuration:
> > > > - * 1. 8bit SD port (MMC1)
> > > > - * 2. 4bit SD port (MMC2)
> > > > - * 3. eMMC (MMC0)
> > > > - */
> > > > -#define BOOT_TARGET_DEVICES(func) \
> > > > -     func(MMC, mmc, 1) \
> > > > -     func(MMC, mmc, 2) \
> > > > -     func(MMC, mmc, 0) \
> > > > -     func(USB, usb, 0) \
> > > > -     func(PXE, pxe, na) \
> > > > -     func(DHCP, dhcp, na)
> > > > -
> > >
> > > I do recall that to transition to text env file it was required to mo=
ve
> > > from standard boot to distroboot. Did I recall incorrectly?
> >
> > Are you 100% sure? Have you tried?
>
> No, I am not, but Simon in copy knows for sure.
>
> What I am sure is that I mean migrating from distroboot to standard boot,=
 the
> opposite of what I wrote ...

Tegra uses standard boot

> Francesco
>
>
