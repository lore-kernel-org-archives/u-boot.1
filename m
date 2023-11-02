Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D4AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 11:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C06F8763E;
	Thu,  2 Nov 2023 12:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Sp2TUvSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D389A8774E; Thu,  2 Nov 2023 12:15:31 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108BD8761B
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 12:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d8a000f6a51so811540276.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698923724; x=1699528524;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75PKxrjbYy3XkgFQ0IkxCacpGljEcOpx1mryDx2b10A=;
 b=Sp2TUvSQ7RoW4+G5+fog7rqLdKOTK/zC+Srmyd6j3KNvqzxE9K8tOMvOyTAbK5KMCM
 mf4DQJdODPXvL7TK4G6h26SZ3nBOM2roLaeLVLLPBd0pXk0nk0C5kjUHjGTMvf25WkmR
 8xbrh3ztnPORmlTpr6nGrYa2A/sbyPxcaKygA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698923724; x=1699528524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75PKxrjbYy3XkgFQ0IkxCacpGljEcOpx1mryDx2b10A=;
 b=Ic/2fkB5MMNOEYIvMymoeXfLQ8J4sev1BM6ca5wYUfZaIRu+UNuMFIrhDWdfutMyNw
 SHYXGtsx+pcGAhGteImrTcIEQTU1F/zWS20QRUObFHQCEqEMRodyuTf0P+kvdmiulEHh
 /N1T+zq9YS0LfCGPBNJv4KEmHTqNFkzLqHrKl51QNPpt5E9un32pfHrKmBYAsQ1icoPN
 e8QTV4AIzC81YudWwTjDYFwusHU3shBCIwuDAaydb5QIYkobB3aWH5SdRUqLy5nGOeAa
 dJU/Z0cCJ9QzowtBNYQWhuqCl7Ed0R+4ja50E04PO6lQVRtYcjSe7kNcJmX00ES60x22
 c3fg==
X-Gm-Message-State: AOJu0Yz/HbRElkMb/nR8fWF2bfuc2JkaFJAeD3H8cO96QP0Cx0fTJ4JY
 XGWpPSbSS7tE5z57WWGTwcvsvihPWXIZWsKKq3jJkA==
X-Google-Smtp-Source: AGHT+IGT2wWk5NG3WAlr+/nDJ8gEf2hqEOL6kXtd9STF4A1pJEiQnkZmCZdk0ZNoNcT6robi9uEJW1EfBWASe4yN/bA=
X-Received: by 2002:a25:fc12:0:b0:da0:4ba8:35fe with SMTP id
 v18-20020a25fc12000000b00da04ba835femr16979328ybd.60.1698923724357; Thu, 02
 Nov 2023 04:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-15-seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-15-seanga2@gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 2 Nov 2023 12:15:11 +0100
Message-ID: <CABGWkvq=GpMYjXhjjqH7k37fw4YbToh1Didz+3iBy1rVhM9P-A@mail.gmail.com>
Subject: Re: [PATCH 14/15] nand: Add sandbox driver
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>
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

Sean, All

On Sun, Oct 29, 2023 at 4:49=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> Add a sandbox NAND flash driver to facilitate testing. This driver suppor=
ts
> any number of devices, each using a single chip-select. The OOB data is
> stored in-band, with the separation enforced through the API.
>
> For now, create two devices to test with. The first is a very small devic=
e
> with basic ECC. The second is an 8G device (chosen to be larger than 32
> bits). It uses ONFI, with the values copied from the datasheet. It also
> doesn't need too strong ECC, which speeds things up.
>
> Although the nand subsystem determines the parameters of a chip based on
> the ID, the driver itself requires devicetree properties for each
> parameter. We do not derive parameters from the ID because parsing the ID
> is non-trivial. We do not just use the parameters that the nand subsystem
> has calculated since that is something we should be testing.
>
> Despite using file I/O to access the backing data, we do not support usin=
g
> external files. In my experience, these are unnecessary for testing since
> tests can generally be written to write their expected data beforehand.
> Additionally, we would need to store the "programmed" information somewhe=
re
> (complicating the format and the programming process) or try to detect
> whether block are erased at runtime (degrading probe speeds).
>
> Information about whether each page has been programmed is stored in an
> in-memory buffer. To simplify the implementation, we only support a singl=
e
> program per erase. While this is accurate for many larger flashes, some
> smaller flashes (512 byte) support multiple programs and/or subpage
> programs. Support for this could be added later as I believe some
> filesystems expect this.
>
> To test ECC, we support error-injection. Surprisingly, only ECC bytes in
> the OOB area are protected, even though all bytes are equally susceptible
> to error. Because of this, we take care to only corrupt ECC bytes.
> Similarly, because ECC covers "steps" and not the whole page, we must tak=
e
> care to corrupt data in the same way.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  arch/sandbox/dts/test.dts        |  67 +++
>  configs/sandbox64_defconfig      |  10 +-
>  configs/sandbox_defconfig        |   9 +
>  configs/sandbox_noinst_defconfig |  10 +-
>  drivers/mtd/nand/raw/Kconfig     |  14 +
>  drivers/mtd/nand/raw/Makefile    |   1 +
>  drivers/mtd/nand/raw/sand_nand.c | 682 +++++++++++++++++++++++++++++++
>  test/dm/Makefile                 |   1 +
>  test/dm/nand.c                   | 106 +++++
>  9 files changed, 898 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/sand_nand.c
>  create mode 100644 test/dm/nand.c
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 5b54651a1da..5fba2943fad 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -1900,6 +1900,73 @@
>                                 compatible =3D "sandbox,arm-ffa";
>                 };
>         };
> +
> +       nand-controller {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               compatible =3D "sandbox,nand";
> +
> +               nand@0 {
> +                       reg =3D <0>;
> +                       nand-ecc-mode =3D "soft";
> +                       sandbox,id =3D [00 e3];
> +                       sandbox,erasesize =3D <(8 * 1024)>;
> +                       sandbox,oobsize =3D <16>;
> +                       sandbox,pagesize =3D <512>;
> +                       sandbox,pages =3D <0x2000>;
> +                       sandbox,err-count =3D <1>;
> +                       sandbox,err-step-size =3D <512>;
> +                       sandbox,ecc-bytes =3D <6>;
> +               };
> +
> +               /* MT29F64G08AKABA */
> +               nand@1 {
> +                       reg =3D <1>;
> +                       nand-ecc-mode =3D "soft_bch";
> +                       sandbox,id =3D [2C 48 00 26 89 00 00 00];
> +                       sandbox,onfi =3D [
> +                               4f 4e 46 49 0e 00 5a 00
> +                               ff 01 00 00 00 00 03 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               4d 49 43 52 4f 4e 20 20
> +                               20 20 20 20 4d 54 32 39
> +                               46 36 34 47 30 38 41 4b
> +                               41 42 41 43 35 20 20 20
> +                               2c 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 10 00 00 e0 00 00 02
> +                               00 00 1c 00 80 00 00 00
> +                               00 10 00 00 02 23 01 50
> +                               00 01 05 01 00 00 04 00
> +                               04 01 1e 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               0e 1f 00 1f 00 f4 01 ac
> +                               0d 19 00 c8 00 00 00 00
> +                               00 00 00 00 00 00 0a 07
> +                               19 00 00 00 00 00 00 00
> +                               00 00 00 00 01 00 01 00
> +                               00 00 04 10 01 81 04 02
> +                               02 01 1e 90 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 00 00 00
> +                               00 00 00 00 00 03 20 7d
> +                       ];
> +                       sandbox,erasesize =3D <(512 * 1024)>;
> +                       sandbox,oobsize =3D <224>;
> +                       sandbox,pagesize =3D <4096>;
> +                       sandbox,pages =3D <0x200000>;
> +                       sandbox,err-count =3D <3>;
> +                       sandbox,err-step-size =3D <512>;
> +                       sandbox,ecc-bytes =3D <7>;
> +               };
> +       };
>  };
>
>  #include "sandbox_pmic.dtsi"
> diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
> index 1a01f51a0b7..d4e5eb3000b 100644
> --- a/configs/sandbox64_defconfig
> +++ b/configs/sandbox64_defconfig
> @@ -1,4 +1,5 @@
>  CONFIG_TEXT_BASE=3D0
> +CONFIG_SYS_MALLOC_LEN=3D0x6000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"sandbox64"
> @@ -50,7 +51,7 @@ CONFIG_CMD_GPT_RENAME=3Dy
>  CONFIG_CMD_IDE=3Dy
>  CONFIG_CMD_I2C=3Dy
>  CONFIG_CMD_LOADM=3Dy
> -CONFIG_CMD_MBR=3Dy
> +CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_OSD=3Dy
>  CONFIG_CMD_PCI=3Dy
>  CONFIG_CMD_READ=3Dy
> @@ -168,6 +169,13 @@ CONFIG_PWRSEQ=3Dy
>  CONFIG_I2C_EEPROM=3Dy
>  CONFIG_MMC_SANDBOX=3Dy
>  CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_MTD_RAW_NAND=3Dy
> +CONFIG_SYS_MAX_NAND_DEVICE=3D8
> +CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
> +CONFIG_NAND_SANDBOX=3Dy
> +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> +CONFIG_SYS_NAND_PAGE_SIZE=3D0x200
>  CONFIG_SPI_FLASH_SANDBOX=3Dy
>  CONFIG_BOOTDEV_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_ATMEL=3Dy
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index e3a2f9eb170..1c71f0542a3 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -1,4 +1,5 @@
>  CONFIG_TEXT_BASE=3D0
> +CONFIG_SYS_MALLOC_LEN=3D0x6000000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"sandbox"
> @@ -73,6 +74,7 @@ CONFIG_CMD_IDE=3Dy
>  CONFIG_CMD_I2C=3Dy
>  CONFIG_CMD_LOADM=3Dy
>  CONFIG_CMD_LSBLK=3Dy
> +CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_MUX=3Dy
>  CONFIG_CMD_OSD=3Dy
>  CONFIG_CMD_PCI=3Dy
> @@ -215,6 +217,13 @@ CONFIG_MMC_PCI=3Dy
>  CONFIG_MMC_SANDBOX=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_MTD_RAW_NAND=3Dy
> +CONFIG_SYS_MAX_NAND_DEVICE=3D8
> +CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
> +CONFIG_NAND_SANDBOX=3Dy
> +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> +CONFIG_SYS_NAND_PAGE_SIZE=3D0x200
>  CONFIG_SPI_FLASH_SANDBOX=3Dy
>  CONFIG_BOOTDEV_SPI_FLASH=3Dy
>  CONFIG_SPI_FLASH_ATMEL=3Dy
> diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_de=
fconfig
> index db05e630832..09ebafeccca 100644
> --- a/configs/sandbox_noinst_defconfig
> +++ b/configs/sandbox_noinst_defconfig
> @@ -80,7 +80,7 @@ CONFIG_CMD_GPIO=3Dy
>  CONFIG_CMD_GPT=3Dy
>  CONFIG_CMD_IDE=3Dy
>  CONFIG_CMD_I2C=3Dy
> -CONFIG_CMD_MBR=3Dy
> +CONFIG_CMD_MTD=3Dy
>  CONFIG_CMD_OSD=3Dy
>  CONFIG_CMD_PCI=3Dy
>  CONFIG_CMD_REMOTEPROC=3Dy
> @@ -181,6 +181,14 @@ CONFIG_PWRSEQ=3Dy
>  CONFIG_SPL_PWRSEQ=3Dy
>  CONFIG_FS_LOADER=3Dy
>  CONFIG_MMC_SANDBOX=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy
> +CONFIG_MTD_RAW_NAND=3Dy
> +CONFIG_SYS_MAX_NAND_DEVICE=3D8
> +CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
> +CONFIG_NAND_SANDBOX=3Dy
> +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> +CONFIG_SYS_NAND_PAGE_SIZE=3D0x200
>  CONFIG_SPI_FLASH_SANDBOX=3Dy
>  CONFIG_SPI_FLASH_ATMEL=3Dy
>  CONFIG_SPI_FLASH_EON=3Dy
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index ee484dc0f51..6b34aa6782c 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -447,6 +447,20 @@ config NAND_PXA3XX
>           This enables the driver for the NAND flash device found on
>           PXA3xx processors (NFCv1) and also on Armada 370/XP (NFCv2).
>
> +config NAND_SANDBOX
> +       bool "Support for NAND in sandbox"
> +       depends on SANDBOX
> +       select SYS_NAND_SELF_INIT
> +       select SYS_NAND_SOFT_ECC
> +       select BCH
> +       select NAND_ECC_BCH
> +       imply CMD_NAND
> +       help
> +         Enable a dummy NAND driver for sandbox. It simulates any number=
 of
> +         arbitrary NAND chips with a RAM buffer. It will also inject err=
ors to
> +         test ECC. At the moment, only 8-bit busses and single-chip devi=
ces are
> +         supported.
> +
>  config NAND_SUNXI
>         bool "Support for NAND on Allwinner SoCs"
>         default ARCH_SUNXI
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefil=
e
> index add2b4cf655..ddbba899e58 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_NAND_PXA3XX) +=3D pxa3xx_nand.o
>  obj-$(CONFIG_TEGRA_NAND) +=3D tegra_nand.o
>  obj-$(CONFIG_NAND_OMAP_GPMC) +=3D omap_gpmc.o
>  obj-$(CONFIG_NAND_OMAP_ELM) +=3D omap_elm.o
> +obj-$(CONFIG_NAND_SANDBOX) +=3D sand_nand.o
>  obj-$(CONFIG_NAND_SUNXI) +=3D sunxi_nand.o
>  obj-$(CONFIG_NAND_MXIC) +=3D mxic_nand.o
>  obj-$(CONFIG_NAND_ZYNQ) +=3D zynq_nand.o
> diff --git a/drivers/mtd/nand/raw/sand_nand.c b/drivers/mtd/nand/raw/sand=
_nand.c
> new file mode 100644
> index 00000000000..f1855877630
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/sand_nand.c
> @@ -0,0 +1,682 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) Sean Anderson <seanga2@gmail.com>
> + */
> +
> +#define LOG_CATEGORY UCLASS_MTD
> +#include <errno.h>
> +#include <hexdump.h>
> +#include <log.h>
> +#include <nand.h>
> +#include <os.h>
> +#include <rand.h>
> +#include <dm/device_compat.h>
> +#include <dm/read.h>
> +#include <dm/uclass.h>
> +#include <asm/bitops.h>
> +#include <linux/bitmap.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/sizes.h>
> +
> +enum sand_nand_state {
> +       STATE_READY,
> +       STATE_IDLE,
> +       STATE_READ,
> +       STATE_READ_ID,
> +       STATE_READ_ONFI,
> +       STATE_PARAM_ONFI,
> +       STATE_STATUS,
> +       STATE_PROG,
> +       STATE_ERASE,
> +};
> +
> +static const char *const state_name[] =3D {
> +       [STATE_READY] =3D "READY",
> +       [STATE_IDLE] =3D "IDLE",
> +       [STATE_READ] =3D "READ",
> +       [STATE_READ_ID] =3D "READ_ID",
> +       [STATE_READ_ONFI] =3D "READ_ONFI",
> +       [STATE_PARAM_ONFI] =3D "PARAM_ONFI",
> +       [STATE_STATUS] =3D "STATUS",
> +       [STATE_PROG] =3D "PROG",
> +       [STATE_ERASE] =3D "ERASE",
> +};
> +
> +/**
> + * struct sand_nand_chip - Per-device private data
> + * @nand: The nand chip
> + * @node: The next device in this controller
> + * @programmed: Bitmap of whether sectors are programmed
> + * @id: ID to report for NAND_CMD_READID
> + * @id_len: Length of @id
> + * @onfi: Three copies of ONFI parameter page
> + * @status: Status to report for NAND_CMD_STATUS
> + * @chunksize: Size of one "chunk" (page + oob) in bytes
> + * @pageize: Size of one page in bytes
> + * @pages: Total number of pages
> + * @pages_per_erase: Number of pages per eraseblock
> + * @err_count: Number of errors to inject per @err_step_bits of data
> + * @err_step_bits: Number of data bits per error "step"
> + * @err_steps: Number of err steps in a page
> + * @ecc_bits: Number of ECC bits uper @err_step_bits
> + * @cs: Chip select for this device
> + * @state: Current state of the device
> + * @column: Column of the most-recent command
> + * @page_addr: Page address of the most-recent command
> + * @fd: File descriptor for the backing data
> + * @fd_page_addr: Page address that @fd is seek'd to
> + * @selected: Whether this device is selected
> + * @tmp: "Cache" buffer used to store transferred data before committing=
 it
> + * @tmp_dirty: Whether @tmp is dirty (modified) or clean (all ones)
> + */
> +struct sand_nand_chip {
> +       struct nand_chip nand;
> +       struct list_head node;
> +       long *programmed;
> +       const u8 *id;
> +       u32 chunksize, pagesize, pages, pages_per_erase;
> +       u32 err_count, err_step_bits, err_steps, ecc_bits;
> +       unsigned int cs;
> +       enum sand_nand_state state;
> +       int column, page_addr, fd, fd_page_addr;
> +       bool selected, tmp_dirty;
> +       u8 status;

I see a character "^L".
Please remove it.

Thanks and regards,
Dario

> +       u8 id_len;
> +       u8 tmp[NAND_MAX_PAGESIZE + NAND_MAX_OOBSIZE];
> +       u8 onfi[sizeof(struct nand_onfi_params) * 3];
> +};
> +
> +#define SAND_DEBUG(chip, fmt, ...) \
> +       dev_dbg((chip)->nand.mtd.dev, "%u (%s): " fmt, (chip)->cs, \
> +               state_name[(chip)->state], ##__VA_ARGS__)
> +
> +static inline void to_state(struct sand_nand_chip *chip,
> +                           enum sand_nand_state new_state)
> +{
> +       if (new_state !=3D chip->state)
> +               SAND_DEBUG(chip, "to state %s\n", state_name[new_state]);
> +       chip->state =3D new_state;
> +}
> +
> +static inline struct sand_nand_chip *to_sand_nand(struct nand_chip *nand=
)
> +{
> +       return container_of(nand, struct sand_nand_chip, nand);
> +}
> +
> +struct sand_nand_priv {
> +       struct list_head chips;
> +};
> +
> +static int sand_nand_dev_ready(struct mtd_info *mtd)
> +{
> +       return 1;
> +}
> +
> +static int sand_nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
> +{
> +       u8 status;
> +
> +       return nand_status_op(chip, &status) ?: status;
> +}
> +
> +static int sand_nand_seek(struct sand_nand_chip *chip)
> +{
> +       if (chip->fd_page_addr =3D=3D chip->page_addr)
> +               return 0;
> +
> +       if (os_lseek(chip->fd, (off_t)chip->page_addr * chip->chunksize,
> +                    OS_SEEK_SET) < 0) {
> +               SAND_DEBUG(chip, "could not seek: %d\n", errno);
> +               return -EIO;
> +       }
> +
> +       chip->fd_page_addr =3D chip->page_addr;
> +       return 0;
> +}
> +
> +static void sand_nand_inject_error(struct sand_nand_chip *chip,
> +                                  unsigned int step, unsigned int pos)
> +{
> +       int byte, index;
> +
> +       if (pos < chip->err_step_bits) {
> +               __change_bit(step * chip->err_step_bits + pos, chip->tmp)=
;
> +               return;
> +       }
> +
> +       /*
> +        * Only ECC bytes are covered in the OOB area, so
> +        * pretend that those are the only bytes which can have
> +        * errors.
> +        */
> +       byte =3D (pos - chip->err_step_bits + step * chip->ecc_bits) / 8;
> +       index =3D chip->nand.ecc.layout->eccpos[byte];
> +       /* Avoid endianness issues by working with bytes */
> +       chip->tmp[chip->pagesize + index] ^=3D BIT(pos & 0x7);
> +}
> +
> +static int sand_nand_read(struct sand_nand_chip *chip)
> +{
> +       unsigned int i, stop =3D 0;
> +
> +       if (chip->column =3D=3D chip->pagesize)
> +               stop =3D chip->err_step_bits;
> +
> +       if (test_bit(chip->page_addr, chip->programmed)) {
> +               if (sand_nand_seek(chip))
> +                       return -EIO;
> +
> +               if (os_read(chip->fd, chip->tmp, chip->chunksize) !=3D
> +                   chip->chunksize) {
> +                       SAND_DEBUG(chip, "could not read: %d\n", errno);
> +                       return -EIO;
> +               }
> +               chip->fd_page_addr++;
> +       } else if (chip->tmp_dirty) {
> +               memset(chip->tmp + chip->column, 0xff,
> +                      chip->chunksize - chip->column);
> +       }
> +
> +       /*
> +        * Inject some errors; this is Method A from "An Efficient Algori=
thm for
> +        * Sequential Random Sampling" (Vitter 87). This is still slow wh=
en
> +        * generating a lot (dozens) of ECC errors.
> +        *
> +        * To avoid generating too many errors in any one ECC step, we se=
parate
> +        * our error generation by ECC step.
> +        */
> +       chip->tmp_dirty =3D true;
> +       for (i =3D 0; i < chip->err_steps; i++) {
> +               u32 bit_errors =3D chip->err_count;
> +               unsigned int j =3D chip->err_step_bits + chip->ecc_bits;
> +
> +               while (bit_errors) {
> +                       unsigned int u =3D rand();
> +                       float quot =3D 1ULL << 32;
> +
> +                       do {
> +                               quot *=3D j - bit_errors;
> +                               quot /=3D j;
> +                               j--;
> +
> +                               if (j < stop)
> +                                       goto next;
> +                       } while (u < quot);
> +
> +                       sand_nand_inject_error(chip, i, j);
> +                       bit_errors--;
> +               }
> +next:
> +               ;
> +       }
> +
> +       return 0;
> +}
> +
> +static void sand_nand_command(struct mtd_info *mtd, unsigned int command=
,
> +                             int column, int page_addr)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct sand_nand_chip *chip =3D to_sand_nand(nand);
> +       enum sand_nand_state new_state =3D chip->state;
> +
> +       SAND_DEBUG(chip, "command=3D%02x column=3D%d page_addr=3D%d\n", c=
ommand,
> +                  column, page_addr);
> +
> +       if (!chip->selected)
> +               return;
> +
> +       switch (chip->state) {
> +       case STATE_READY:
> +               if (command =3D=3D NAND_CMD_RESET)
> +                       goto reset;
> +               break;
> +       case STATE_PROG:
> +               new_state =3D STATE_IDLE;
> +               if (command !=3D NAND_CMD_PAGEPROG ||
> +                   test_and_set_bit(chip->page_addr, chip->programmed)) =
{
> +                       chip->status |=3D NAND_STATUS_FAIL;
> +                       break;
> +               }
> +
> +               if (sand_nand_seek(chip)) {
> +                       chip->status |=3D NAND_STATUS_FAIL;
> +                       break;
> +               }
> +
> +               if (os_write(chip->fd, chip->tmp, chip->chunksize) !=3D
> +                   chip->chunksize) {
> +                       SAND_DEBUG(chip, "could not write: %d\n", errno);
> +                       chip->status |=3D NAND_STATUS_FAIL;
> +                       break;
> +               }
> +
> +               chip->fd_page_addr++;
> +               break;
> +       case STATE_ERASE:
> +               new_state =3D STATE_IDLE;
> +               if (command !=3D NAND_CMD_ERASE2) {
> +                       chip->status |=3D NAND_STATUS_FAIL;
> +                       break;
> +               }
> +
> +               if (chip->page_addr < 0 ||
> +                   chip->page_addr >=3D chip->pages ||
> +                   chip->page_addr % chip->pages_per_erase)
> +                       chip->status |=3D NAND_STATUS_FAIL;
> +               else
> +                       bitmap_clear(chip->programmed, chip->page_addr,
> +                                    chip->pages_per_erase);
> +               break;
> +       default:
> +               chip->column =3D column;
> +               chip->page_addr =3D page_addr;
> +               switch (command) {
> +               case NAND_CMD_READOOB:
> +                       if (column >=3D 0)
> +                               chip->column +=3D chip->pagesize;
> +                       fallthrough;
> +               case NAND_CMD_READ0:
> +                       new_state =3D STATE_IDLE;
> +                       if (page_addr < 0 || page_addr >=3D chip->pages)
> +                               break;
> +
> +                       if (chip->column < 0 || chip->column >=3D chip->c=
hunksize)
> +                               break;
> +
> +                       if (sand_nand_read(chip))
> +                               break;
> +
> +                       chip->page_addr =3D page_addr;
> +                       new_state =3D STATE_READ;
> +                       break;
> +               case NAND_CMD_ERASE1:
> +                       new_state =3D STATE_ERASE;
> +                       chip->status =3D ~NAND_STATUS_FAIL;
> +                       break;
> +               case NAND_CMD_STATUS:
> +                       new_state =3D STATE_STATUS;
> +                       chip->column =3D 0;
> +                       break;
> +               case NAND_CMD_SEQIN:
> +                       new_state =3D STATE_PROG;
> +                       chip->status =3D ~NAND_STATUS_FAIL;
> +                       if (page_addr < 0 || page_addr >=3D chip->pages |=
|
> +                           chip->column < 0 ||
> +                           chip->column >=3D chip->chunksize) {
> +                               chip->status |=3D NAND_STATUS_FAIL;
> +                       } else if (chip->tmp_dirty) {
> +                               memset(chip->tmp, 0xff, chip->chunksize);
> +                               chip->tmp_dirty =3D false;
> +                       }
> +                       break;
> +               case NAND_CMD_READID:
> +                       if (chip->onfi[0] && column =3D=3D 0x20)
> +                               new_state =3D STATE_READ_ONFI;
> +                       else
> +                               new_state =3D STATE_READ_ID;
> +                       chip->column =3D 0;
> +                       break;
> +               case NAND_CMD_PARAM:
> +                       if (chip->onfi[0] && !column)
> +                               new_state =3D STATE_PARAM_ONFI;
> +                       else
> +                               new_state =3D STATE_IDLE;
> +                       break;
> +               case NAND_CMD_RESET:
> +reset:
> +                       new_state =3D STATE_IDLE;
> +                       chip->column =3D -1;
> +                       chip->page_addr =3D -1;
> +                       chip->status =3D ~NAND_STATUS_FAIL;
> +                       break;
> +               default:
> +                       new_state =3D STATE_IDLE;
> +                       SAND_DEBUG(chip, "Unsupported command %02x\n", co=
mmand);
> +               }
> +       }
> +
> +       to_state(chip, new_state);
> +}
> +
> +static void sand_nand_select_chip(struct mtd_info *mtd, int n)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct sand_nand_chip *chip =3D to_sand_nand(nand);
> +
> +       chip->selected =3D !n;
> +}
> +
> +static void sand_nand_read_buf(struct mtd_info *mtd, u8 *buf, int len)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct sand_nand_chip *chip =3D to_sand_nand(nand);
> +       unsigned int to_copy;
> +       int src_len =3D 0;
> +       const u8 *src =3D NULL;
> +
> +       if (!chip->selected)
> +               goto copy;
> +
> +       switch (chip->state) {
> +       case STATE_READ:
> +               src =3D chip->tmp;
> +               src_len =3D chip->chunksize;
> +               break;
> +       case STATE_READ_ID:
> +               src =3D chip->id;
> +               src_len =3D chip->id_len;
> +               break;
> +       case STATE_READ_ONFI:
> +               src =3D "ONFI";
> +               src_len =3D 4;
> +               break;
> +       case STATE_PARAM_ONFI:
> +               src =3D chip->onfi;
> +               src_len =3D sizeof(chip->onfi);
> +               break;
> +       case STATE_STATUS:
> +               src =3D &chip->status;
> +               src_len =3D 1;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +copy:
> +       if (chip->column >=3D 0)
> +               to_copy =3D max(min(len, src_len - chip->column), 0);
> +       else
> +               to_copy =3D 0;
> +       memcpy(buf, src + chip->column, to_copy);
> +       memset(buf + to_copy, 0xff, len - to_copy);
> +       chip->column +=3D to_copy;
> +
> +       if (len =3D=3D 1) {
> +               SAND_DEBUG(chip, "read [ %02x ]\n", buf[0]);
> +       } else if (src_len) {
> +               SAND_DEBUG(chip, "read %d bytes\n", len);
> +#ifdef VERBOSE_DEBUG
> +               print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, len);
> +#endif
> +       }
> +
> +       if (src_len && chip->column =3D=3D src_len)
> +               to_state(chip, STATE_IDLE);
> +}
> +
> +static u8 sand_nand_read_byte(struct mtd_info *mtd)
> +{
> +       u8 ret;
> +
> +       sand_nand_read_buf(mtd, &ret, 1);
> +       return ret;
> +}
> +
> +static u16 sand_nand_read_word(struct mtd_info *mtd)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct sand_nand_chip *chip =3D to_sand_nand(nand);
> +
> +       SAND_DEBUG(chip, "16-bit access unsupported\n");
> +       return sand_nand_read_byte(mtd) | 0xff00;
> +}
> +
> +static void sand_nand_write_buf(struct mtd_info *mtd, const u8 *buf, int=
 len)
> +{
> +       struct nand_chip *nand =3D mtd_to_nand(mtd);
> +       struct sand_nand_chip *chip =3D to_sand_nand(nand);
> +
> +       SAND_DEBUG(chip, "write %d bytes\n", len);
> +#ifdef VERBOSE_DEBUG
> +       print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, buf, len);
> +#endif
> +
> +       if (chip->state !=3D STATE_PROG || chip->status & NAND_STATUS_FAI=
L)
> +               return;
> +
> +       chip->tmp_dirty =3D true;
> +       len =3D min((unsigned int)len, chip->chunksize - chip->column);
> +       memcpy(chip->tmp + chip->column, buf, len);
> +       chip->column +=3D len;
> +}
> +
> +static struct nand_chip *nand_chip;
> +
> +int sand_nand_remove(struct udevice *dev)
> +{
> +       struct sand_nand_priv *priv =3D dev_get_priv(dev);
> +       struct sand_nand_chip *chip;
> +
> +       list_for_each_entry(chip, &priv->chips, node) {
> +               struct nand_chip *nand =3D &chip->nand;
> +
> +               if (nand_chip =3D=3D nand)
> +                       nand_chip =3D NULL;
> +
> +               nand_unregister(nand_to_mtd(nand));
> +               free(chip->programmed);
> +               os_close(chip->fd);
> +               free(chip);
> +       }
> +
> +       return 0;
> +}
> +
> +static int sand_nand_probe(struct udevice *dev)
> +{
> +       struct sand_nand_priv *priv =3D dev_get_priv(dev);
> +       struct sand_nand_chip *chip;
> +       int ret, devnum =3D 0;
> +       ofnode np;
> +
> +       INIT_LIST_HEAD(&priv->chips);
> +
> +       dev_for_each_subnode(np, dev) {
> +               struct nand_chip *nand;
> +               struct mtd_info *mtd;
> +               u32 erasesize, oobsize, pagesize, pages;
> +               u32 err_count, err_step_size, ecc_bytes;
> +               off_t expected_size;
> +               char filename[30];
> +               fdt_addr_t cs;
> +               const u8 *id, *onfi;
> +               int id_len, onfi_len;
> +
> +               cs =3D ofnode_get_addr_size_index_notrans(np, 0, NULL);
> +               if (cs =3D=3D FDT_ADDR_T_NONE) {
> +                       dev_dbg(dev, "Invalid cs for chip %s\n",
> +                               ofnode_get_name(np));
> +                       ret =3D -ENOENT;
> +                       goto err;
> +               }
> +
> +               id =3D ofnode_read_prop(np, "sandbox,id", &id_len);
> +               if (!id) {
> +                       dev_dbg(dev, "No sandbox,id property for chip %s\=
n",
> +                               ofnode_get_name(np));
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +
> +               onfi =3D ofnode_read_prop(np, "sandbox,onfi", &onfi_len);
> +               if (onfi && onfi_len !=3D sizeof(struct nand_onfi_params)=
) {
> +                       dev_dbg(dev, "Invalid length %d for onfi params\n=
",
> +                               onfi_len);
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +
> +               ret =3D ofnode_read_u32(np, "sandbox,erasesize", &erasesi=
ze);
> +               if (ret) {
> +                       dev_dbg(dev, "No sandbox,erasesize property for c=
hip %s",
> +                               ofnode_get_name(np));
> +                       goto err;
> +               }
> +
> +               ret =3D ofnode_read_u32(np, "sandbox,oobsize", &oobsize);
> +               if (ret) {
> +                       dev_dbg(dev, "No sandbox,oobsize property for chi=
p %s",
> +                               ofnode_get_name(np));
> +                       goto err;
> +               }
> +
> +               ret =3D ofnode_read_u32(np, "sandbox,pagesize", &pagesize=
);
> +               if (ret) {
> +                       dev_dbg(dev, "No sandbox,pagesize property for ch=
ip %s",
> +                               ofnode_get_name(np));
> +                       goto err;
> +               }
> +
> +               ret =3D ofnode_read_u32(np, "sandbox,pages", &pages);
> +               if (ret) {
> +                       dev_dbg(dev, "No sandbox,pages property for chip =
%s",
> +                               ofnode_get_name(np));
> +                       goto err;
> +               }
> +
> +               ret =3D ofnode_read_u32(np, "sandbox,err-count", &err_cou=
nt);
> +               if (ret) {
> +                       dev_dbg(dev,
> +                               "No sandbox,err-count property for chip %=
s",
> +                               ofnode_get_name(np));
> +                       goto err;
> +               }
> +
> +               ret =3D ofnode_read_u32(np, "sandbox,err-step-size",
> +                                     &err_step_size);
> +               if (ret) {
> +                       dev_dbg(dev,
> +                               "No sandbox,err-step-size property for ch=
ip %s",
> +                               ofnode_get_name(np));
> +                       goto err;
> +               }
> +
> +               ret =3D ofnode_read_u32(np, "sandbox,ecc-bytes", &ecc_byt=
es);
> +               if (ret) {
> +                       dev_dbg(dev,
> +                               "No sandbox,ecc-bytes property for chip %=
s",
> +                               ofnode_get_name(np));
> +                       goto err;
> +               }
> +
> +               chip =3D calloc(sizeof(*chip), 1);
> +               if (!chip) {
> +                       ret =3D -ENOMEM;
> +                       goto err;
> +               }
> +
> +               chip->cs =3D cs;
> +               chip->id =3D id;
> +               chip->id_len =3D id_len;
> +               chip->chunksize =3D pagesize + oobsize;
> +               chip->pagesize =3D pagesize;
> +               chip->pages =3D pages;
> +               chip->pages_per_erase =3D erasesize / pagesize;
> +               memset(chip->tmp, 0xff, chip->chunksize);
> +
> +               chip->err_count =3D err_count;
> +               chip->err_step_bits =3D err_step_size * 8;
> +               chip->err_steps =3D pagesize / err_step_size;
> +               chip->ecc_bits =3D ecc_bytes * 8;
> +
> +               expected_size =3D (off_t)pages * chip->chunksize;
> +               snprintf(filename, sizeof(filename),
> +                        "/tmp/u-boot.nand%d.XXXXXX", devnum);
> +               chip->fd =3D os_mktemp(filename, expected_size);
> +               if (chip->fd < 0) {
> +                       dev_dbg(dev, "Could not create temp file %s\n",
> +                               filename);
> +                       ret =3D chip->fd;
> +                       goto err_chip;
> +               }
> +
> +               chip->programmed =3D calloc(sizeof(long),
> +                                         BITS_TO_LONGS(pages));
> +               if (!chip->programmed) {
> +                       ret =3D -ENOMEM;
> +                       goto err_fd;
> +               }
> +
> +               if (onfi) {
> +                       memcpy(chip->onfi, onfi, onfi_len);
> +                       memcpy(chip->onfi + onfi_len, onfi, onfi_len);
> +                       memcpy(chip->onfi + 2 * onfi_len, onfi, onfi_len)=
;
> +               }
> +
> +               nand =3D &chip->nand;
> +               nand->flash_node =3D np;
> +               nand->dev_ready =3D sand_nand_dev_ready;
> +               nand->cmdfunc =3D sand_nand_command;
> +               nand->waitfunc =3D sand_nand_wait;
> +               nand->select_chip =3D sand_nand_select_chip;
> +               nand->read_byte =3D sand_nand_read_byte;
> +               nand->read_word =3D sand_nand_read_word;
> +               nand->read_buf =3D sand_nand_read_buf;
> +               nand->write_buf =3D sand_nand_write_buf;
> +               nand->ecc.options =3D NAND_ECC_GENERIC_ERASED_CHECK;
> +
> +               mtd =3D nand_to_mtd(nand);
> +               mtd->dev =3D dev;
> +
> +               ret =3D nand_scan(mtd, CONFIG_SYS_NAND_MAX_CHIPS);
> +               if (ret) {
> +                       dev_dbg(dev, "Could not scan chip %s: %d\n",
> +                               ofnode_get_name(np), ret);
> +                       goto err_prog;
> +               }
> +
> +               ret =3D nand_register(devnum, mtd);
> +               if (ret) {
> +                       dev_dbg(dev, "Could not register nand %d: %d\n", =
devnum,
> +                               ret);
> +                       goto err_prog;
> +               }
> +
> +               if (!nand_chip)
> +                       nand_chip =3D nand;
> +
> +               list_add_tail(&chip->node, &priv->chips);
> +               devnum++;
> +               continue;
> +
> +err_prog:
> +               free(chip->programmed);
> +err_fd:
> +               os_close(chip->fd);
> +err_chip:
> +               free(chip);
> +               goto err;
> +       }
> +
> +       return 0;
> +
> +err:
> +       sand_nand_remove(dev);
> +       return ret;
> +}
> +
> +static const struct udevice_id sand_nand_ids[] =3D {
> +       { .compatible =3D "sandbox,nand" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(sand_nand) =3D {
> +       .name           =3D "sand-nand",
> +       .id             =3D UCLASS_MTD,
> +       .of_match       =3D sand_nand_ids,
> +       .probe          =3D sand_nand_probe,
> +       .remove         =3D sand_nand_remove,
> +       .priv_auto      =3D sizeof(struct sand_nand_priv),
> +};
> +
> +void board_nand_init(void)
> +{
> +       struct udevice *dev;
> +       int err;
> +
> +       err =3D uclass_get_device_by_driver(UCLASS_MTD, DM_DRIVER_REF(san=
d_nand),
> +                                         &dev);
> +       if (err && err !=3D -ENODEV)
> +               log_info("Failed to get sandbox NAND: %d\n", err);
> +}
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index cb82d839f8a..a3ce7b3889f 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_CMD_MUX) +=3D mux-cmd.o
>  obj-$(CONFIG_MULTIPLEXER) +=3D mux-emul.o
>  obj-$(CONFIG_MUX_MMIO) +=3D mux-mmio.o
>  obj-y +=3D fdtdec.o
> +obj-$(CONFIG_MTD_RAW_NAND) +=3D nand.o
>  obj-$(CONFIG_UT_DM) +=3D nop.o
>  obj-y +=3D ofnode.o
>  obj-y +=3D ofread.o
> diff --git a/test/dm/nand.c b/test/dm/nand.c
> new file mode 100644
> index 00000000000..a1304965072
> --- /dev/null
> +++ b/test/dm/nand.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
> + */
> +
> +#include <nand.h>
> +#include <part.h>
> +#include <rand.h>
> +#include <dm/test.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +
> +static int dm_test_nand(struct unit_test_state *uts, int dev, bool end)
> +{
> +       nand_erase_options_t opts =3D { };
> +       struct mtd_info *mtd;
> +       size_t length;
> +       loff_t size;
> +       char *buf;
> +       int *gold;
> +       u8 oob[NAND_MAX_OOBSIZE];
> +       int i;
> +       loff_t off =3D 0;
> +       mtd_oob_ops_t ops =3D { };
> +
> +       /* Seed RNG for bit errors */
> +       srand((off >> 32) ^ off ^ ~dev);
> +
> +       mtd =3D get_nand_dev_by_index(dev);
> +       ut_assertnonnull(mtd);
> +       size =3D mtd->erasesize * 4;
> +       length =3D size;
> +
> +       buf =3D malloc(size);
> +       ut_assertnonnull(buf);
> +       gold =3D malloc(size);
> +       ut_assertnonnull(gold);
> +
> +       /* Mark a block as bad */
> +       ut_assertok(mtd_block_markbad(mtd, off + mtd->erasesize));
> +       /* Save the OOB for later */
> +       ut_assertok(mtd_read_oob(mtd, mtd->erasesize, &ops));
> +
> +       /* Erase some stuff */
> +       if (end)
> +               off =3D mtd->size - size - mtd->erasesize;
> +       opts.offset =3D off;
> +       opts.length =3D size;
> +       opts.spread =3D 1;
> +       opts.lim =3D U32_MAX;
> +       ut_assertok(nand_erase_opts(mtd, &opts));
> +
> +       /* Make sure everything is erased */
> +       memset(gold, 0xff, size);
> +       ut_assertok(nand_read_skip_bad(mtd, off, &length, NULL, U64_MAX, =
buf));
> +       ut_asserteq(size, length);
> +       ut_asserteq_mem(gold, buf, size);
> +
> +       /* ...but our bad block marker is still there */
> +       ops.oobbuf =3D oob;
> +       ops.ooblen =3D mtd->oobsize;
> +       ut_assertok(mtd_read_oob(mtd, mtd->erasesize, &ops));
> +       ut_asserteq(0, oob[mtd_to_nand(mtd)->badblockpos]);
> +
> +       /* Generate some data and write it */
> +       for (i =3D 0; i < size / sizeof(int); i++)
> +               gold[i] =3D 0;//rand();
> +       ut_assertok(nand_write_skip_bad(mtd, off, &length, NULL, U64_MAX,
> +                                       (void *)gold, 0));
> +       ut_asserteq(size, length);
> +
> +       /* Verify */
> +       ut_assertok(nand_read_skip_bad(mtd, off, &length, NULL, U64_MAX, =
buf));
> +       ut_asserteq(size, length);
> +       ut_asserteq_mem(gold, buf, size);
> +
> +       /* Erase some blocks */
> +       memset(((char *)gold) + mtd->erasesize, 0xff, mtd->erasesize * 2)=
;
> +       opts.offset =3D off + mtd->erasesize;
> +       opts.length =3D mtd->erasesize * 2,
> +       ut_assertok(nand_erase_opts(mtd, &opts));
> +
> +       /* Verify */
> +       ut_assertok(nand_read_skip_bad(mtd, off, &length, NULL, U64_MAX, =
buf));
> +       ut_asserteq(size, length);
> +       ut_asserteq_mem(gold, buf, size);
> +
> +       return 0;
> +}
> +
> +#define DM_NAND_TEST(dev) \
> +static int dm_test_nand##dev##_start(struct unit_test_state *uts) \
> +{ \
> +       return dm_test_nand(uts, dev, false); \
> +} \
> +DM_TEST(dm_test_nand##dev##_start, UT_TESTF_SCAN_FDT); \
> +static int dm_test_nand##dev##_end(struct unit_test_state *uts) \
> +{ \
> +       return dm_test_nand(uts, dev, true); \
> +} \
> +DM_TEST(dm_test_nand##dev##_end, UT_TESTF_SCAN_FDT)
> +
> +DM_NAND_TEST(0);
> +DM_NAND_TEST(1);
> --
> 2.37.1
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
