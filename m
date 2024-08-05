Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24BFC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 07:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BDA8886A;
	Mon,  5 Aug 2024 09:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PyS1vs81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84BC8886A; Mon,  5 Aug 2024 09:01:41 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45CC88850
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 09:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368712acb8dso5354507f8f.2
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722841299; x=1723446099; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SeITE8JnehcZh+zNE7mrGwB7vGFu7QGUOJmZzy3Los=;
 b=PyS1vs8169FbC13gkRGAH30IRGLwL693xRmJND3DnfQFabaR52OulzcqngBlvlaTs6
 xg4itixXvilIVXVYg7yQcTvyY4/aVjRW/skrtQHLe+NPT6Ag0ZRkzpIXetBpG5KQaLy4
 svoRWff3QDKyrct+NqSpMw4Z9uUh4E5a20hgfnKsRqnaBCEKjtIKJq9QrWn8EQ3IinMd
 EotYUeFNMFvXm1xXmuveag8evYKke1AZXyWJH+JD9TmEiBlQObBsuTk0byD1UkM/BYzs
 xmXM7Q8nOnXjRnDMmDmPRbRRCLtk3QfLSbm5eC7Ff07yBbCsxiVqF/8N5+Z8zwGp0rgo
 cVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722841299; x=1723446099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SeITE8JnehcZh+zNE7mrGwB7vGFu7QGUOJmZzy3Los=;
 b=c5yRjZR7YTTkiuKtXJdRYfGbNgC6wRDZ7NhBvAyub4ZVRhEgF+8QhSm6sQAuLd0r/5
 f2L1FsPhV/xn5LnnELxLjei7RAHbUzKTAMmRPeMZQ1UwMeCVHq5mVoOCzaSfYRp81/GD
 dLIpZLES4C3ZGZBju9P2Pak2TQ6GOWwY8oYbe8yWeoKHnwxWqSIuD+fsijZkAoYrlkzf
 LxwA413KTjctRwDhlT4t9xk9U8sLsR05nkvvll1LwzTq+CSndmViN7fXA4xDMjDxmgOq
 Hqm9Qdgw/RvgpLUsRoAXvbiIQ3WAmjQqQxiAH2KN/kQeVA3quUIHPzWyhxHezGzoend0
 KuaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUZk+lFQ7/Aa80pgWLns9PYz4Hafj1LXtRKkz2zFCAce3X8OUxILWUIylu86CUUXsUSPL/LzyZCmHb1GiTeYOEAzlqfg==
X-Gm-Message-State: AOJu0YxHw65VANj1uHAFjApp0xK71Fg8m46xglvXppUV0IYjONmbWcjv
 fiQIMIVfHNWaaU26nM3ovNtkDyEmcXQeN3CLdAVPVq10+jTv4CRPhko0Vjm0ruqgi2NNhaWivFB
 cIHE77SV8Y4HLL0XWGuhUUQhdPI0=
X-Google-Smtp-Source: AGHT+IFt3YKZ21NPJt5BFI9xzcIOQtfWFa2xEw93TZCml0vGp3LMlelsrKNkgaW0GOCSe6q3bGMI7FyLpqbKrBdnZGg=
X-Received: by 2002:adf:f910:0:b0:36b:3395:537a with SMTP id
 ffacd0b85a97d-36bbc1633f2mr5928235f8f.45.1722841298796; Mon, 05 Aug 2024
 00:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240801055738.7601-1-clamor95@gmail.com>
 <20240801055738.7601-2-clamor95@gmail.com>
 <20240805053157.GA7516@francesco-nb>
In-Reply-To: <20240805053157.GA7516@francesco-nb>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 5 Aug 2024 10:01:27 +0300
Message-ID: <CAPVz0n1TQ=bzvEv3OW_k+sBYVx13oRH6Oc_yfrhjNoe5+ujgoA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] board: tegra: convert tegra-based boards to text
 env
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
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

=D0=BF=D0=BD, 5 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 08:32=
 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello Clamor,
>
> On Thu, Aug 01, 2024 at 08:57:38AM +0300, Svyatoslav Ryhel wrote:
> > Convert boards to use text based env. This is the first stage of
> > conversion, common inclusions should be converted next.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  board/asus/grouper/grouper.env                | 15 +++
> >  .../asus/transformer-t20/transformer-t20.env  | 16 ++++
> >  .../transformer-t30/configs/tf600t.config     |  1 +
> >  board/asus/transformer-t30/tf600t.env         | 16 ++++
> >  .../asus/transformer-t30/transformer-t30.env  | 16 ++++
> >  board/htc/endeavoru/endeavoru.env             | 13 +++
> >  .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
> >  board/lg/x3-t30/configs/p880.config           |  1 +
> >  board/lg/x3-t30/configs/p895.config           |  1 +
> >  board/lg/x3-t30/p880.env                      | 14 +++
> >  board/lg/x3-t30/p895.env                      | 13 +++
> >  board/microsoft/surface-rt/surface-rt.env     | 14 +++
> >  board/nvidia/cardhu/cardhu.env                |  2 +
> >  board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
> >  board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
> >  board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
> >  board/toradex/apalis_t30/apalis_t30.env       |  9 ++
> >  board/toradex/colibri_t20/colibri_t20.env     |  3 +
> >  board/toradex/colibri_t30/colibri_t30.env     |  9 ++
> >  board/wexler/qc750/qc750.env                  | 14 +++
> >  configs/apalis-tk1_defconfig                  |  1 +
> >  configs/apalis_t30_defconfig                  |  1 +
> >  configs/cardhu_defconfig                      |  1 +
> >  configs/colibri_t20_defconfig                 |  1 +
> >  configs/colibri_t30_defconfig                 |  1 +
>
> ...
>
> > diff --git a/board/toradex/apalis-tk1/apalis_tk1.env b/board/toradex/ap=
alis-tk1/apalis_tk1.env
> > new file mode 100644
> > index 0000000000..90db361be3
> > --- /dev/null
> > +++ b/board/toradex/apalis-tk1/apalis_tk1.env
> > @@ -0,0 +1,45 @@
> > +/*
> > + * Custom Distro Boot configuration:
> > + * 1. 8bit SD port (MMC1)
> > + * 2. 4bit SD port (MMC2)
> > + * 3. eMMC (MMC0)
> > + */
> > +boot_targets=3Dmmc1 mmc2 mmc0 usb pxe dhcp
> > +
> > +boot_file=3DzImage
> > +boot_script_dhcp=3Dboot.scr
> > +console=3DttyS0
> > +defargs=3Dlp0_vec=3D2064@0xf46ff000 core_edp_mv=3D1150 core_edp_ma=3D4=
000
> > +     usb_port_owner_info=3D2 lane_owner_info=3D6 emc_max_dvfs=3D0
> > +     user_debug=3D30 pcie_aspm=3Doff
> > +dfu_alt_info=3Dapalis-tk1.img raw 0x0 0x500 mmcpart 1;
> > +     boot part 0 1 mmcpart 0;
> > +     rootfs part 0 2 mmcpart 0;
> > +     zImage fat 0 1 mmcpart 0;
> > +     tegra124-apalis-eval.dtb fat 0 1 mmcpart 0
> > +fdt_board=3Deval
> > +fdt_fixup=3D;
> > +fdt_module=3Dapalis-v1.2
> > +uboot_hwpart=3D1
> > +uboot_blk=3D0
> > +set_blkcnt=3Dsetexpr blkcnt ${filesize} + 0x1ff &&
> > +     setexpr blkcnt ${blkcnt} / 0x200
> > +update_uboot=3Drun set_blkcnt && mmc dev 0 ${uboot_hwpart} &&
> > +     mmc write ${loadaddr} ${uboot_blk} ${blkcnt}
> > +setethupdate=3Dif env exists ethaddr; then; else setenv ethaddr
> > +     00:14:2d:00:00:00; fi; pci enum && tftpboot ${loadaddr}
> > +     flash_eth.img && source ${loadaddr}
> > +setsdupdate=3Dsetenv interface mmc; setenv drive 1; mmc rescan;
> > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img
> > +     || setenv drive 2; mmc rescan; load ${interface} ${drive}:1
> > +     ${loadaddr} flash_blk.img &&
> > +     source ${loadaddr}
> > +setup=3Dsetenv setupargs igb_mac=3D${ethaddr}
> > +     consoleblank=3D0 no_console_suspend=3D1 console=3Dtty1
> > +     console=3D${console},${baudrate}n8 debug_uartport=3Dlsport,0
> > +     ${memargs}
> > +setupdate=3Drun setsdupdate || run setusbupdate || run setethupdate
> > +setusbupdate=3Dusb start && setenv interface usb; setenv drive 0;
> > +     load ${interface} ${drive}:1 ${loadaddr} flash_blk.img &&
> > +     source ${loadaddr}
> > +vidargs=3Dfbcon=3Dmap:1
>
> ...
>
> > diff --git a/include/configs/apalis-tk1.h b/include/configs/apalis-tk1.=
h
> > index 71d4727ca9..4c690a1785 100644
> > --- a/include/configs/apalis-tk1.h
> > +++ b/include/configs/apalis-tk1.h
> > @@ -18,64 +18,6 @@
> >  #define FDT_MODULE                   "apalis-v1.2"
> >  #define FDT_MODULE_V1_0                      "apalis"
> >
> > -/*
> > - * Custom Distro Boot configuration:
> > - * 1. 8bit SD port (MMC1)
> > - * 2. 4bit SD port (MMC2)
> > - * 3. eMMC (MMC0)
> > - */
> > -#define BOOT_TARGET_DEVICES(func) \
> > -     func(MMC, mmc, 1) \
> > -     func(MMC, mmc, 2) \
> > -     func(MMC, mmc, 0) \
> > -     func(USB, usb, 0) \
> > -     func(PXE, pxe, na) \
> > -     func(DHCP, dhcp, na)
> > -
>
> I do recall that to transition to text env file it was required to move
> from standard boot to distroboot. Did I recall incorrectly?

Are you 100% sure? Have you tried?

> I commented on apalis-tk1, but from a quick look other boards would have
> the same issue.

Maybe it is worth looking deeper?

> Thanks,
> Francesco
>
