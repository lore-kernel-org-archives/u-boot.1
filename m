Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B302AD29FBC
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 01:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2336B89035;
	Thu,  7 Nov 2024 02:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCpZWwRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914B0891BC; Thu,  7 Nov 2024 02:56:12 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED5988E2D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 02:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so299843b3a.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 17:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730944568; x=1731549368; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7snodPSkOI47z4nWixzb8GtGtNBmdcZ2A4j8VqHdrY=;
 b=KCpZWwRmKoVMoORxY+LvsgKkAbkEu3d9eQpggbqktNS8vnUkyP9n4ioWdMn6vpotU5
 XVWlYWAhgBZVoyGODyn+adSAgMiwiyGTjzXd3tyHnJZEOZNr7YGVlK7dePu5KZ9AIe7O
 EEbHFWSzsl8h5knWjIsQLH+TmYKsxXrS5i7klTTDUxR/JZTMsQPuCjQXrY+WRgPnfzLw
 AIeYT4EuFasfsRFewWxZu1q5mUIr6z+HOleM3/WreLMSySttplehIuqPKJssFnp48lWB
 JhAk0CwoLu8tn5f4MH+kx7gKQ5RnyMgN2YofR1DfeTT++uS2x69bTOHTIc9hS+xNiTXm
 +ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730944568; x=1731549368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7snodPSkOI47z4nWixzb8GtGtNBmdcZ2A4j8VqHdrY=;
 b=a7+1SiNTA6gbDR+M/9gKZ4PfH/4xOxw9vtXv0UzHdLOj0uFUG2+1h7fuboEttRGAHF
 0ckOCeuMGHOne7SSkUhn7/k/5BFVOdn6Gfm5hhE3g80HtfR16yvk0Igh7UPQiT05NP/a
 mTjdAmPY51PEatTIhV6pmrwH26sbvs1LOVZvGkna+Qy4zWl19lGKLS9GekkdQyoVt0nw
 oQ6FsSqEmr9Wf8XswqMnUqs9tl6dr0iS44fFh1GmXRqfDBF6iujkhOCWAb97QGVPFXNX
 FE8eDRVELgbHN2QgqdjroIQpNoeDB2m/U8R/1X76rffg6tUnalgX/AB7kgURPLhAfW//
 xCeQ==
X-Gm-Message-State: AOJu0Yx7Llc5lILB2U2A+MvTI3yvE5vtdrIpJJzh4dF6V00nSvGmfeam
 7JsKZasZ9L/pVl7yJK2moiRWBjf3k8u6X9tcFR0pZTjklKu/P2PBRa0u7XeLd3bNOKzPEtWKWbg
 8sfRmwDhaDdTAbmSiKuVgvogoB/I=
X-Google-Smtp-Source: AGHT+IGlwgrD3hrg2DNeG0Wij2HRtuoepmtzkNV02BYlgNVZIk6YYpEOABcvrsq7gPAchntp3nKfSP2yh2WcYe3m3mw=
X-Received: by 2002:a05:6a21:339b:b0:1db:ef2f:d6f0 with SMTP id
 adf61e73a8af0-1dbef2fd713mr12241392637.19.1730944567442; Wed, 06 Nov 2024
 17:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20240423183247.335791-1-marex@denx.de>
 <20240423183247.335791-3-marex@denx.de>
In-Reply-To: <20240423183247.335791-3-marex@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 6 Nov 2024 19:55:56 -0600
Message-ID: <CAHCN7x+Moru3HsU8VUZ5z53ix2s09qG0UpwgYeh9dPEC81s3uw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx: Convert i.MX8M flash.bin image
 generation to binman
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, 
 kernel@puri.sm, u-boot@dh-electronics.com, lukma <lukma@denx.de>
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

On Tue, Apr 23, 2024 at 1:33=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Rework the flash.bin image generation such that it uses the new binman
> nxp_imx8mimage etype. This way, the flash.bin is assembled in correct
> order using plain binman, without any workarounds or sections assembled
> in special DT node order.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---

This introduced a regression on the 8M Nano with
CONFIG_FSPI_CONF_HEADER set.  As is, the board doesn't appear to do
anything.

Looking at the binary blob that is generated, the offset for the SPL
phase is missing, so SPL starts at 0x5c0 instead of 0x1000, but adding
offset =3D <0x1000> isn't sufficient.

Adding the offset =3D <0x1000>  starts the SPL phase, but it hangs right
away and doesn't past the version message:
U-Boot SPL 2024.07-rc1-00155-g37e50627ef-dirty (Nov 06 2024 - 19:16:52 -060=
0)

<hangs here>

I have only tested this on a Nano, but I think the issue would likely
affect Plus since their boot ROM is similar.  I currently don't have a
Mini in my possession right now, so I cannot verify the behavior on
it.

From what I can tell, reverting this patch appears to restore boot
operation.   I don't know enough about the mkimage tool, but I have
tried changing  nxp,boot-from and that doesn't seem to fix it either.

When I diff the binaries, it looks like a fairly significant about of
the values have changed, but the various magic numbers and offets
appear correct.  This makes me wonder if setting the offsets being
passed to mkimage are getting in the way.

If remove the references to  CONFIG_FSPI_CONF_HEADER in the device
tree, a regular image is built.  I then use dd to create a new file
which has the FSPI header at 0x400, and moves the beginning of the
rest of the image to 0x1000.  This process boots the board just fine.
This leads me to believe that something in the imx8 mkimage tool is
doing something different when fspi is enabled.

U-Boot SPL 2024.07-rc1-00155-g37e50627ef-dirty (Nov 06 2024 - 19:43:47 -060=
0)
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x1000, pagesize 0x1, ivt offset 0x0
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: lts-v2.8.10(release):lts-v2.8.10-327-g0d8623944
NOTICE:  BL31: Built : 21:43:36, Nov 13 2023


U-Boot 2024.07-rc1-00155-g37e50627ef-dirty (Nov 06 2024 - 19:43:47 -0600)

CPU:   Freescale i.MX8MNano Solo rev1.0 at 1200 MHz
Reset cause: POR
Model: Beacon EmbeddedWorks i.MX8M Nano Development Kit
DRAM:  1 GiB
Core:  110 devices, 26 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from nowhere... OK
In:    serial@30890000
Out:   serial@30890000
Err:   serial@30890000
SEC0:  RNG instantiated
Net:
Warning: ethernet@30be0000 (eth0) using random MAC address - de:2b:92:7d:8d=
:fe
eth0: ethernet@30be0000
Hit any key to stop autoboot:  0
u-boot=3D>


I'd like to rework the binman to build a standard flash.bin without
the Flexspi stuff, then create a second file like fspi.bin (or
something similar) which inserts the FSPI header at 0x400 and then
just places the entirely of flash.bin contents placed at 0x1000 in a
way that doesn't pass these offsets to imx8 mkimage tool.

Any ideas how to do this?  I am not all that familiar with binman.  A
similar question was asked before on another thread too.

adam


adam

> WARNING: This is very likely to break corner case uses, so please do
>          test this on your platform.
> NOTE: This also opens the implementation for proper CST signing etype,
>       the CST signing would look similar to nxp-imx8mimage section, and
>       it would likely wrap the whole topmost section {} in the binman
>       node.
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: kernel@puri.sm
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/dts/imx8mm-u-boot.dtsi               | 126 ++++++---------
>  .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |   8 +-
>  arch/arm/dts/imx8mn-u-boot.dtsi               | 147 +++++++-----------
>  arch/arm/dts/imx8mp-dhcom-u-boot.dtsi         |   2 +-
>  arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi    |   2 +-
>  arch/arm/dts/imx8mp-u-boot.dtsi               |  96 +++++-------
>  arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi    |  15 +-
>  arch/arm/dts/imx8mq-u-boot.dtsi               | 109 +++++--------
>  8 files changed, 203 insertions(+), 302 deletions(-)
>
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot=
.dtsi
> index 06f2f73a03f..6ab8f66256e 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -5,7 +5,6 @@
>
>  / {
>         binman: binman {
> -               multiple-images;
>         };
>
>  #ifdef CONFIG_OPTEE
> @@ -43,56 +42,61 @@
>  };
>
>  &binman {
> -       u-boot-spl-ddr {
> -               align =3D <4>;
> -               align-size =3D <4>;
> -               filename =3D "u-boot-spl-ddr.bin";
> -               pad-byte =3D <0xff>;
> -
> -               u-boot-spl {
> -                       align-end =3D <4>;
> -                       filename =3D "u-boot-spl.bin";
> -               };
> +       filename =3D "flash.bin";
> +       section {
> +               pad-byte =3D <0x00>;
>
> -               ddr-1d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_imem.bin";
> -                       align-end =3D <4>;
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +               fspi_conf_block {
> +                       filename =3D CONFIG_FSPI_CONF_FILE;
>                         type =3D "blob-ext";
> +                       size =3D <0x1000>;
>                 };
> +#endif
>
> -               ddr-1d-dmem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_dmem.bin";
> -                       align-end =3D <4>;
> -                       type =3D "blob-ext";
> -               };
> +               nxp-imx8mimage {
> +                       filename =3D "u-boot-spl-mkimage.bin";
> +                       nxp,boot-from =3D "sd";
> +                       nxp,rom-version =3D <1>;
> +                       nxp,loader-address =3D <CONFIG_SPL_TEXT_BASE>;
> +                       args;   /* Needed by mkimage etype superclass */
>
> -               ddr-2d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_2d_imem.bin";
> -                       align-end =3D <4>;
> -                       type =3D "blob-ext";
> -               };
> +                       section {
> +                               align =3D <4>;
> +                               align-size =3D <4>;
> +                               filename =3D "u-boot-spl-ddr.bin";
> +                               pad-byte =3D <0xff>;
>
> -               ddr-2d-dmem-fw {
> -                       filename =3D "lpddr4_pmu_train_2d_dmem.bin";
> -                       align-end =3D <4>;
> -                       type =3D "blob-ext";
> -               };
> -       };
> +                               u-boot-spl {
> +                                       align-end =3D <4>;
> +                                       filename =3D "u-boot-spl.bin";
> +                               };
>
> -       spl {
> -               filename =3D "spl.bin";
> +                               ddr-1d-imem-fw {
> +                                       filename =3D "lpddr4_pmu_train_1d=
_imem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
>
> -               mkimage {
> -                       args =3D "-n spl/u-boot-spl.cfgout -T imx8mimage =
-e 0x7e1000";
> +                               ddr-1d-dmem-fw {
> +                                       filename =3D "lpddr4_pmu_train_1d=
_dmem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
>
> -                       blob {
> -                               filename =3D "u-boot-spl-ddr.bin";
> +                               ddr-2d-imem-fw {
> +                                       filename =3D "lpddr4_pmu_train_2d=
_imem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
> +
> +                               ddr-2d-dmem-fw {
> +                                       filename =3D "lpddr4_pmu_train_2d=
_dmem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
>                         };
>                 };
> -       };
> -
> -       itb {
> -               filename =3D "u-boot.itb";
>
>                 fit {
>                         description =3D "Configuration to load ATF before=
 U-Boot";
> @@ -101,6 +105,11 @@
>  #endif
>                         fit,fdt-list =3D "of-list";
>                         #address-cells =3D <1>;
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +                       offset =3D <0x58C00>;
> +#else
> +                       offset =3D <0x57c00>;
> +#endif
>
>                         images {
>                                 uboot {
> @@ -166,43 +175,6 @@
>                         };
>                 };
>         };
> -
> -       imx-boot {
> -               filename =3D "flash.bin";
> -               pad-byte =3D <0x00>;
> -
> -#ifdef CONFIG_FSPI_CONF_HEADER
> -               fspi_conf_block {
> -                       filename =3D CONFIG_FSPI_CONF_FILE;
> -                       type =3D "blob-ext";
> -                       size =3D <0x1000>;
> -               };
> -
> -               spl {
> -                       filename =3D "spl.bin";
> -                       offset =3D <0x1000>;
> -                       type =3D "blob-ext";
> -               };
> -
> -               binman_uboot: uboot {
> -                       filename =3D "u-boot.itb";
> -                       offset =3D <0x58C00>;
> -                       type =3D "blob-ext";
> -               };
> -#else
> -               spl {
> -                       filename =3D "spl.bin";
> -                       offset =3D <0x0>;
> -                       type =3D "blob-ext";
> -               };
> -
> -               binman_uboot: uboot {
> -                       filename =3D "u-boot.itb";
> -                       offset =3D <0x57c00>;
> -                       type =3D "blob-ext";
> -               };
> -#endif
> -       };
>  };
>
>  &clk {
> diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/d=
ts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> index 8b397f535c1..90183aff8bc 100644
> --- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> @@ -35,8 +35,12 @@
>         bootph-pre-ram;
>  };
>
> -&binman_uboot {
> -       offset =3D <0x5fc00>;
> +&binman {
> +       section {
> +               fit {
> +                       offset =3D <0x5fc00>;
> +               };
> +       };
>  };
>
>  &gpio1 {
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot=
.dtsi
> index 96b1a1bc802..ba9967dbe4a 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -5,7 +5,6 @@
>
>  / {
>         binman: binman {
> -               multiple-images;
>         };
>
>  #ifdef CONFIG_OPTEE
> @@ -92,78 +91,83 @@
>  };
>
>  &binman {
> -        u-boot-spl-ddr {
> -               filename =3D "u-boot-spl-ddr.bin";
> -               pad-byte =3D <0xff>;
> -               align-size =3D <4>;
> -               align =3D <4>;
> -
> -               u-boot-spl {
> -                       align-end =3D <4>;
> -                       filename =3D "u-boot-spl.bin";
> +       filename =3D "flash.bin";
> +       section {
> +               pad-byte =3D <0x00>;
> +
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +               fspi_conf_block {
> +                       filename =3D CONFIG_FSPI_CONF_FILE;
> +                       type =3D "blob-ext";
> +                       offset =3D <0x400>;
>                 };
> +#endif
>
> -               ddr-1d-imem-fw {
> +               nxp-imx8mimage {
> +                       filename =3D "u-boot-spl-mkimage.bin";
> +                       nxp,boot-from =3D "sd";
> +                       nxp,rom-version =3D <2>;
> +                       nxp,loader-address =3D <CONFIG_SPL_TEXT_BASE>;
> +                       args;   /* Needed by mkimage etype superclass */
> +
> +                       section {
> +                               filename =3D "u-boot-spl-ddr.bin";
> +                               pad-byte =3D <0xff>;
> +                               align-size =3D <4>;
> +                               align =3D <4>;
> +
> +                               u-boot-spl {
> +                                       align-end =3D <4>;
> +                                       filename =3D "u-boot-spl.bin";
> +                               };
> +
> +                               ddr-1d-imem-fw {
>  #ifdef CONFIG_IMX8M_LPDDR4
> -                       filename =3D "lpddr4_pmu_train_1d_imem.bin";
> +                                       filename =3D "lpddr4_pmu_train_1d=
_imem.bin";
>  #elif CONFIG_IMX8M_DDR4
> -                       filename =3D "ddr4_imem_1d_201810.bin";
> +                                       filename =3D "ddr4_imem_1d_201810=
.bin";
>  #else
> -                       filename =3D "ddr3_imem_1d.bin";
> +                                       filename =3D "ddr3_imem_1d.bin";
>  #endif
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>
> -               ddr-1d-dmem-fw {
> +                               ddr-1d-dmem-fw {
>  #ifdef CONFIG_IMX8M_LPDDR4
> -                       filename =3D "lpddr4_pmu_train_1d_dmem.bin";
> +                                       filename =3D "lpddr4_pmu_train_1d=
_dmem.bin";
>  #elif CONFIG_IMX8M_DDR4
> -                       filename =3D "ddr4_dmem_1d_201810.bin";
> +                                       filename =3D "ddr4_dmem_1d_201810=
.bin";
>  #else
> -                       filename =3D "ddr3_dmem_1d.bin";
> +                                       filename =3D "ddr3_dmem_1d.bin";
>  #endif
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>
>  #if defined(CONFIG_IMX8M_LPDDR4) || defined(CONFIG_IMX8M_DDR4)
> -               ddr-2d-imem-fw {
> +                               ddr-2d-imem-fw {
>  #ifdef CONFIG_IMX8M_LPDDR4
> -                       filename =3D "lpddr4_pmu_train_2d_imem.bin";
> +                                       filename =3D "lpddr4_pmu_train_2d=
_imem.bin";
>  #else
> -                       filename =3D "ddr4_imem_2d_201810.bin";
> +                                       filename =3D "ddr4_imem_2d_201810=
.bin";
>  #endif
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>
> -               ddr-2d-dmem-fw {
> +                               ddr-2d-dmem-fw {
>  #ifdef CONFIG_IMX8M_LPDDR4
> -                       filename =3D "lpddr4_pmu_train_2d_dmem.bin";
> +                                       filename =3D "lpddr4_pmu_train_2d=
_dmem.bin";
>  #else
> -                       filename =3D "ddr4_dmem_2d_201810.bin";
> +                                       filename =3D "ddr4_dmem_2d_201810=
.bin";
>  #endif
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>  #endif
> -       };
> -
> -       spl {
> -               filename =3D "spl.bin";
> -
> -               mkimage {
> -                       args =3D "-n spl/u-boot-spl.cfgout -T imx8mimage =
-e 0x912000";
> -
> -                       blob {
> -                               filename =3D "u-boot-spl-ddr.bin";
>                         };
>                 };
> -       };
> -
> -       itb {
> -               filename =3D "u-boot.itb";
>
>                 fit {
>                         description =3D "Configuration to load ATF before=
 U-Boot";
> @@ -172,6 +176,11 @@
>  #endif
>                         fit,fdt-list =3D "of-list";
>                         #address-cells =3D <1>;
> +#ifdef CONFIG_FSPI_CONF_HEADER
> +                       offset =3D <0x59000>;
> +#else
> +                       offset =3D <0x58000>;
> +#endif
>
>                         images {
>                                 uboot {
> @@ -237,42 +246,4 @@
>                         };
>                 };
>         };
> -
> -       imx-boot {
> -               filename =3D "flash.bin";
> -               pad-byte =3D <0x00>;
> -
> -#ifdef CONFIG_FSPI_CONF_HEADER
> -               fspi_conf_block {
> -                       filename =3D CONFIG_FSPI_CONF_FILE;
> -                       type =3D "blob-ext";
> -                       offset =3D <0x400>;
> -               };
> -
> -               spl {
> -                       filename =3D "spl.bin";
> -                       offset =3D <0x1000>;
> -                       type =3D "blob-ext";
> -               };
> -
> -               binman_uboot: uboot {
> -                       filename =3D "u-boot.itb";
> -                       offset =3D <0x59000>;
> -                       type =3D "blob-ext";
> -               };
> -#else
> -
> -               spl {
> -                       offset =3D <0x0>;
> -                       filename =3D "spl.bin";
> -                       type =3D "blob-ext";
> -               };
> -
> -               binman_uboot: uboot {
> -                       offset =3D <0x58000>;
> -                       filename =3D "u-boot.itb";
> -                       type =3D "blob-ext";
> -               };
> -#endif
> -       };
>  };
> diff --git a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi b/arch/arm/dts/imx8mp-=
dhcom-u-boot.dtsi
> index b05be57e71b..cb37e28f28f 100644
> --- a/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-dhcom-u-boot.dtsi
> @@ -136,7 +136,7 @@
>  };
>
>  &binman {
> -       itb {
> +       section {
>                 fit {
>                         images {
>                                 fdt-dto-imx8mp-dhcom-som-overlay-eth1xfas=
t {
> diff --git a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi b/arch/arm/dts/im=
x8mp-rsb3720-a1-u-boot.dtsi
> index 22171bd344e..aff5dcf615d 100644
> --- a/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-rsb3720-a1-u-boot.dtsi
> @@ -136,7 +136,7 @@
>  };
>
>  &binman {
> -       itb {
> +       section {
>                 fit {
>                         images {
>                                 fip {
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot=
.dtsi
> index 4fadcaea509..c4c1a177102 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -6,7 +6,6 @@
>
>  / {
>         binman: binman {
> -               multiple-images;
>         };
>
>  #ifdef CONFIG_OPTEE
> @@ -83,55 +82,52 @@
>  #endif
>
>  &binman {
> -        u-boot-spl-ddr {
> -               filename =3D "u-boot-spl-ddr.bin";
> -               pad-byte =3D <0xff>;
> -               align-size =3D <4>;
> -               align =3D <4>;
> -
> -               u-boot-spl {
> -                       align-end =3D <4>;
> -               };
> +       filename =3D "flash.bin";
> +       section {
> +               pad-byte =3D <0x00>;
>
> -               ddr-1d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_imem_202006.bin=
";
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> +               nxp-imx8mimage {
> +                       filename =3D "u-boot-spl-mkimage.bin";
> +                       nxp,boot-from =3D "sd";
> +                       nxp,rom-version =3D <2>;
> +                       nxp,loader-address =3D <CONFIG_SPL_TEXT_BASE>;
> +                       args;   /* Needed by mkimage etype superclass */
>
> -               ddr-1d-dmem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_dmem_202006.bin=
";
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> +                       section {
> +                               filename =3D "u-boot-spl-ddr.bin";
> +                               pad-byte =3D <0xff>;
> +                               align-size =3D <4>;
> +                               align =3D <4>;
>
> -               ddr-2d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_2d_imem_202006.bin=
";
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> +                               u-boot-spl {
> +                                       align-end =3D <4>;
> +                               };
>
> -               ddr-2d-dmem-fw {
> -                       filename =3D "lpddr4_pmu_train_2d_dmem_202006.bin=
";
> -                       type =3D "blob-ext";
> -                       align-end =3D <4>;
> -               };
> -       };
> +                               ddr-1d-imem-fw {
> +                                       filename =3D "lpddr4_pmu_train_1d=
_imem_202006.bin";
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>
> -       spl {
> -               filename =3D "spl.bin";
> +                               ddr-1d-dmem-fw {
> +                                       filename =3D "lpddr4_pmu_train_1d=
_dmem_202006.bin";
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>
> -               mkimage {
> -                       args =3D "-n spl/u-boot-spl.cfgout -T imx8mimage =
-e 0x920000";
> +                               ddr-2d-imem-fw {
> +                                       filename =3D "lpddr4_pmu_train_2d=
_imem_202006.bin";
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>
> -                       blob {
> -                               filename =3D "u-boot-spl-ddr.bin";
> +                               ddr-2d-dmem-fw {
> +                                       filename =3D "lpddr4_pmu_train_2d=
_dmem_202006.bin";
> +                                       type =3D "blob-ext";
> +                                       align-end =3D <4>;
> +                               };
>                         };
>                 };
> -       };
> -
> -       itb {
> -               filename =3D "u-boot.itb";
>
>                 fit {
>                         description =3D "Configuration to load ATF before=
 U-Boot";
> @@ -140,6 +136,7 @@
>  #endif
>                         fit,fdt-list =3D "of-list";
>                         #address-cells =3D <1>;
> +                       offset =3D <0x58000>;
>
>                         images {
>                                 uboot {
> @@ -195,21 +192,4 @@
>                         };
>                 };
>         };
> -
> -       imx-boot {
> -               filename =3D "flash.bin";
> -               pad-byte =3D <0x00>;
> -
> -               spl {
> -                       filename =3D "spl.bin";
> -                       offset =3D <0x0>;
> -                       type =3D "blob-ext";
> -               };
> -
> -               binman_uboot: uboot {
> -                       filename =3D "u-boot.itb";
> -                       offset =3D <0x58000>;
> -                       type =3D "blob-ext";
> -               };
> -       };
>  };
> diff --git a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi b/arch/arm/dts/im=
x8mq-librem5-r4-u-boot.dtsi
> index e3341a46d63..1a4568dac65 100644
> --- a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
> @@ -11,14 +11,13 @@
>  };
>
>  &binman {
> -       /delete-node/ signed-hdmi;
> -
> -       signed-hdmi {
> -               filename =3D "signed_hdmi.bin";
> -
> -               signed-dp-imx8m {
> -                       filename =3D "signed_dp_imx8m.bin";
> -                       type =3D "blob-ext";
> +       section {
> +               nxp-imx8mimage {
> +                       section {
> +                               signed-hdmi-imx8m {
> +                                       filename =3D "signed_dp_imx8m.bin=
";
> +                               };
> +                       };
>                 };
>         };
>  };
> diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot=
.dtsi
> index 90b2274754b..48dbe94f0c4 100644
> --- a/arch/arm/dts/imx8mq-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mq-u-boot.dtsi
> @@ -5,7 +5,6 @@
>
>  / {
>         binman: binman {
> -               multiple-images;
>         };
>
>  };
> @@ -35,65 +34,58 @@
>  };
>
>  &binman {
> -       u-boot-spl-ddr {
> -               align =3D <4>;
> -               align-size =3D <4>;
> -               filename =3D "u-boot-spl-ddr.bin";
> -               pad-byte =3D <0xff>;
> -
> -               u-boot-spl {
> -                       align-end =3D <4>;
> -                       filename =3D "u-boot-spl.bin";
> -               };
> +       filename =3D "flash.bin";
> +       section {
> +               pad-byte =3D <0x00>;
>
> -               ddr-1d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_imem.bin";
> -                       align-end =3D <4>;
> -                       type =3D "blob-ext";
> -               };
> +               nxp-imx8mimage {
> +                       filename =3D "u-boot-spl-mkimage.bin";
> +                       nxp,boot-from =3D "sd";
> +                       nxp,rom-version =3D <1>;
> +                       nxp,loader-address =3D <CONFIG_SPL_TEXT_BASE>;
> +                       args;   /* Needed by mkimage etype superclass */
>
> -               ddr-1d-dmem-fw {
> -                       filename =3D "lpddr4_pmu_train_1d_dmem.bin";
> -                       align-end =3D <4>;
> -                       type =3D "blob-ext";
> -               };
> -
> -               ddr-2d-imem-fw {
> -                       filename =3D "lpddr4_pmu_train_2d_imem.bin";
> -                       align-end =3D <4>;
> -                       type =3D "blob-ext";
> -               };
> +                       section {
> +                               align =3D <4>;
> +                               align-size =3D <4>;
> +                               filename =3D "u-boot-spl-ddr.bin";
> +                               pad-byte =3D <0xff>;
>
> -               ddr-2d-dmem-fw {
> -                       filename =3D "lpddr4_pmu_train_2d_dmem.bin";
> -                       align-end =3D <4>;
> -                       type =3D "blob-ext";
> -               };
> -       };
> +                               u-boot-spl {
> +                                       align-end =3D <4>;
> +                                       filename =3D "u-boot-spl.bin";
> +                               };
>
> -       signed-hdmi {
> -               filename =3D "signed_hdmi.bin";
> +                               ddr-1d-imem-fw {
> +                                       filename =3D "lpddr4_pmu_train_1d=
_imem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
>
> -               signed-hdmi-imx8m {
> -                       filename =3D "signed_hdmi_imx8m.bin";
> -                       type =3D "blob-ext";
> -               };
> -       };
> +                               ddr-1d-dmem-fw {
> +                                       filename =3D "lpddr4_pmu_train_1d=
_dmem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
>
> -       spl {
> -               filename =3D "spl.bin";
> +                               ddr-2d-imem-fw {
> +                                       filename =3D "lpddr4_pmu_train_2d=
_imem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
>
> -               mkimage {
> -                       args =3D "-n spl/u-boot-spl.cfgout -T imx8mimage =
-e 0x7e1000";
> +                               ddr-2d-dmem-fw {
> +                                       filename =3D "lpddr4_pmu_train_2d=
_dmem.bin";
> +                                       align-end =3D <4>;
> +                                       type =3D "blob-ext";
> +                               };
>
> -                       blob {
> -                               filename =3D "u-boot-spl-ddr.bin";
> +                               signed-hdmi-imx8m {
> +                                       filename =3D "signed_hdmi_imx8m.b=
in";
> +                                       type =3D "blob-ext";
> +                               };
>                         };
>                 };
> -       };
> -
> -       itb {
> -               filename =3D "u-boot.itb";
>
>                 fit {
>                         description =3D "Configuration to load ATF before=
 U-Boot";
> @@ -158,21 +150,4 @@
>                         };
>                 };
>         };
> -
> -       imx-boot {
> -               filename =3D "flash.bin";
> -               pad-byte =3D <0x00>;
> -
> -               spl {
> -                       filename =3D "spl.bin";
> -                       offset =3D <0x0>;
> -                       type =3D "blob-ext";
> -               };
> -
> -               binman_uboot: uboot {
> -                       filename =3D "u-boot.itb";
> -                       offset =3D <0x57c00>;
> -                       type =3D "blob-ext";
> -               };
> -       };
>  };
> --
> 2.43.0
>
