Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DDBC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 15:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE9788155;
	Mon,  5 Aug 2024 17:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cozy4d1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ABAC88247; Mon,  5 Aug 2024 17:07:48 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E5E88107
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 17:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42812945633so74436545e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722870466; x=1723475266; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDAGYgWOzqLDP603I48jA1A5nQuIbciEEIqPlMiT2aE=;
 b=cozy4d1YECzpb5hjUUhUQ6BBfN9SAuhY3q8zlaaDe3Fb6COWK1QNuQ2TIfZ9o+IN3W
 7afw5Dbr02bArrcv97x6+2VwTg+U0ErPxDqnRHfJ603ukZ6WeTBlZujXw2ZgC3SubiI5
 sZPvQ9SMTFVUf/12k43XhQqU53gE6tsG/hh4qSvQtwDR6tyip+TzVwe/kySRpQlumN9a
 DYOI7YIZacha25C9F6xBvXzRbIEY4dPffgPBl40shyVjT/9k3Na4w5Do+lW6W97jfkr4
 eRBSKA6/jzkBbLmxau/+OLOQsfnvCSbrcTsVBw2fCo/RieL/DTqgq7pYxfax34HS/AME
 bAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722870466; x=1723475266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDAGYgWOzqLDP603I48jA1A5nQuIbciEEIqPlMiT2aE=;
 b=SkExkp1eeFtSppiDVIDliVSEc/EWUmIzFlGx9V0Fx/ueb00Q3kJc8WiYXggn9IM1uw
 v9pYX2t4tp7hCbNIewDeAEFTWSXMtQCtMXco4LVeTsvFZaHf4LK8JMhU3r5/IsSbqhZU
 TY6VJKf43tigmJU2KzbDdCCy1jYGgzIbprRY7JR+M4cFabnO8Lonlxka1pRi/rQlMarM
 V0Stjp+XRKuhlbXzh3dCtSV9WkReK6M3f3fWc82GsACQh1ZCKBURTmU5v1rCuU7dLvlW
 LYzqxKv48G9/kiXeyhi08pknj0i+i14NbhF78fGoxT7U5Oe95CjBvu1zDD8+9TCR7f90
 izsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUERUxGIxTj9uQzLSmLemrKamHmVqxZ6TlD5eWsMZU+5qK2QcIZYgb9aBKOw9B0Iu+v7JZvweryE5nM/mxUeefqDtdIGg==
X-Gm-Message-State: AOJu0YxhJJnltDQjWNA2z0gGxr2Ci12OS3Cti8pM41kREEd+15I3iN+l
 L1Fhgkh3mzBtm16V1n8dy76La0H3DL+OxMt2S9S9VKKh81ekPEjzR+zAtblhrbtqdA+syH8MhI7
 0XnshTMIK0bFfm/eWoC2PQWVaK/k=
X-Google-Smtp-Source: AGHT+IFRWdD5Uj6gINEdghUvkXK5fXfRLfmgwQfFQTW0UvNnFwLJumdNwJ1/JPhNmbxGC1JfzToFmH45NONs4OMTWP0=
X-Received: by 2002:a05:600c:4752:b0:426:5471:156a with SMTP id
 5b1f17b1804b1-428e6af0f33mr82148985e9.13.1722870465543; Mon, 05 Aug 2024
 08:07:45 -0700 (PDT)
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
Date: Mon, 5 Aug 2024 18:07:34 +0300
Message-ID: <CAPVz0n1O8efBVhqJ0tNLNsW+caywLoE=zVx=Mrq0fdqn5RkpFw@mail.gmail.com>
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
> Francesco
>

If you own Apalis TK1 board, may you test

CONFIG_BOOTCOMMAND=3D"setenv fdtfile
${soc}-${fdt_module}-${fdt_board}.dtb && bootflow scan"

in defconfig along with this commit. This should fix the device.
