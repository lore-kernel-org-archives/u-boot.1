Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05E8C531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 18:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 057F381128;
	Thu, 23 Jul 2026 18:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHYJcuM59hh8; Thu, 23 Jul 2026 18:15:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E133381122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784830536;
	bh=Zmx9qsDWH6tV1DoNymlsTa/RTatyuXmCF0tH1fdFEn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tzBy9a8ijSuS8qjx3fBTNarQZWXvd+SplcfTNVucFytUOZ7MJoLe+Ho5o7BMlf1Y6
	 AUT9uL9FTpkJo5qInofOkWG9j8U+So0qkD+nZw+1fZq/uq9CDc6tNQHH8ixag7GbuQ
	 z53LL6CRSCBSCgR9AQWDmyJ862+KsrV40uSXW9Xh3spXvOJoWsaSnOGmQZbZ8KWHnR
	 h2G5TilfyTFf1oCFh14TpTfGa82MRjmMCuUad4jOGrcx6IGZrI5v/qCiq6L0q1jOTP
	 KZYxMmYfL9gNDJxK2O+AwKW0jd4MrXgqx57H8O5Iq096kcWJ/p54wfDyBZwNSyixJ0
	 LUGa9G3Vd8hfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E133381122;
	Thu, 23 Jul 2026 18:15:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26F6142A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C3B88111D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNQKB80gQ0W4 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 18:15:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A91768111A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A91768111A
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A91768111A
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 18:15:28 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39b22d0e488so9030091fa.3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784830524; cv=none;
 d=google.com; s=arc-20260327;
 b=FtgdSquSAns4UCqs4HBmrGfBdB6uI6wpw3M2BmkRqSyxLQdywdnpYiBy8rKk/l0Jgp
 nK0CUatUoE9kmCfAJQpIRRWV7zN8mEfF8gq19c42DyUI0wgy1/Fb/9dMzIb9XJn8oxwc
 iloGE4GtnFC9e66KRiVjNOkAsHYJSAHBFoTX58g3uZCssdCJwCyj6vaLTQjPW2bixjMM
 NjfKLijYjKy2K29gRPJyyOX5JzWe81JpTKdU6ozdAzFDMlB5b0nkSR8h9oQrKrGu8JJm
 L2Xw0VlaCmFH4RXccQGM4Q4co3O+T/mQxurbtEMR7GzbGkaRmXaTomFNbiQaX/PRV+hY
 04VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zmx9qsDWH6tV1DoNymlsTa/RTatyuXmCF0tH1fdFEn4=;
 fh=T8oHIU+IajErGkolg6zkWFTX4XkNdjfbHTy4V4lCKQU=;
 b=o3wcBIGeK9inw9zI7XrcYLPgWvOAaXOqZzwlQKLY08wMm2Cg4XsI0h2gx4wQi5S5Ri
 QixL/h8YW7oZvmaPl8vm+UKDwfTq3kbj7T4ONha4TQKkkw/wxS4X/pQRLhfuYVfPpi6C
 43H0PJv+FQvQ5GH9qhlSR5GHnRzafCchOxMTtxd7G55GNMmtmDtXQRc9H4ndWN4uFDkj
 Yk9No21xLWDdi3xSmgpjtyS9YtMpH6m3QA80/4DKBMZol89vWTMsjNR5zZVQDt7JiCwx
 g9a0Ooeq0AvZL057IiCjEPA+ZAtlFV+HhuvD9PzLsw/6sbeZ2zBcY2XOLBc1WPbEUocz
 itrw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784830524; x=1785435324;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zmx9qsDWH6tV1DoNymlsTa/RTatyuXmCF0tH1fdFEn4=;
 b=YnM1rE095rOGpD3rGc+jSKLLS0CmzWmIoOarfURU0dMY55TAPvbY0ZG8wQ6WQpDHUi
 0q2ojcnN7YY4Ny2HAp9TDnFujiGNzFF3nYqQ30fgaVQXOMMdnF06MHxZZwTjg8G6Y7lf
 JWbcW6cPDkEWSPvJEXizLK+in2uOgT9EFMcjtmnCyUydnIySDNJjvm7IE34Mx5OLhMl7
 5DccdAE+3aforh0kvIbsIjQYPqJ5vEnl7ZQvAsTSe237AtFsBczRq1CD4qLI22uqUL30
 kEIZgxYtpupYJXRB0+LfFIHilsJOqVHMTE8/ETs2AwCI6ii5wetUvueTDx0UsOrayEsc
 f4fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpORuJSkWWyKxTKFRMU2lyLO/fKJtnYKXjnWDB5axAuU+JhWIVucnbmVNu4NaqYuN8D0d482a4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw3VYO/viLqYY4ywcPhdh0hsZyr7oSIbmNqE82Gv5zwgVf4239S
 /ifhcNURITUPtAjwgkHjRejxvn2f2KusrGYPoaq9NOaCO27miKhGFJDY1uIWgJ/q7qlZ9x6LKgA
 YtNscWzQFX5SaipDcqZAHLiLT788bYuA=
X-Gm-Gg: AR+sD10wKoDYRh6qmP5eGB51vqlGL7dpmzFTtjUTTJMvAKMk9ary7iwqvwalhzNg+qn
 kT08OI2+DeHByCP9LsNY72U46LP11Vld57jpv/RiRwKAgMSAMyn6R8lSXNe0pwnbEV7BErD7Q+b
 cAV2uqIgO7cDjVT2UPpEgMGUGa1x/0RCIZXObBNKgUMN3/3I5FGZFBVHXrKgYlInqlZnX2k87XN
 52FO2z3AcrKMMCPMMAAWyt+/N33+PnJ5xcBGwFAzS/M3jkwpdpDcJUeNf7NhH1BhTG3cF6Ij/aQ
 T4XSjBuHqoBwAA2OgOnTK5nLU3g2KWDXb5XnRy4bbgdmpTcD/czPjDi5ideadZsn/qDWFis=
X-Received: by 2002:a05:651c:23c3:20b0:39c:805f:ecfe with SMTP id
 38308e7fff4ca-39f07c7ef4fmr7637031fa.28.1784830523694; Thu, 23 Jul 2026
 11:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
In-Reply-To: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 23 Jul 2026 15:15:12 -0300
X-Gm-Features: AUfX_mwPFqKDexC9cbY6SwAcBebReoUPoLu1c2fNp5VSaAcp4_CfY9eGSDtB4BU
Message-ID: <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
Subject: Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Joseph Guo <qijian.guo@nxp.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784830524; x=1785435324;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zmx9qsDWH6tV1DoNymlsTa/RTatyuXmCF0tH1fdFEn4=;
 b=Hk2ABZFe4JPHgB7PCnojfVHmeC9b/a2gbXfsjnnSZ0F/CaN6VROiHRr0wMdBs8GBFp
 wt9VW8klN7GsG/2+UvGl3Gt4T9h3qNLs/Tza5/0d5Iz5OwWBAvLzmPTDq6CYjxt321mC
 HUps2w2E62XjHI90IufShNit8BozOQhcanFqvp7sf3N09Xo8wEkaHP2YIE0zcfmQN6HW
 5cTCDWf3SQQrHYs8x2c+FyIJdkA9N2niOCcex9XwYeUsseXh64WHUn0Ni01RmOPBF1gS
 veO7Pf7TzvxM09ye1AxIu+MqVElHiOtVMjoi84HC7TmfokkKPULy3F640/HQqTPk16L1
 CbpA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Hk2ABZFe
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Joseph,

[No need to have such a long CC list. Reducing it]

Thanks for working on this.

On Wed, Jul 15, 2026 at 11:55=E2=80=AFPM Joseph Guo <qijian.guo@nxp.com> wr=
ote:
>
> Add boot support and peripherals like eMMC/SD, UART, I2C, GPIO, ENETC0/1
> and PCIE0/1 for iMX95 15x15 FRDM.
> Updated doc for build instructions.
>
> Signed-off-by: Lei Xu <lei.xu@nxp.com>
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>

I tested this patch:

U-Boot SPL 2026.07-00872-gc20daeac29e7 (Jul 23 2026 - 14:52:43 -0300)
SYS Boot reason: por, origin: -1, errid: -1

I know this is not related to your patch, but please suppress this
origin and errid information. They are just noise.

WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
Normal Boot
Trying to boot from MMC2
Load image from MMC/SD 0xd5800
NOTICE:  BL31: v2.12.0(release):lf-6.18.2-1.0.0
NOTICE:  BL31: Built : 14:51:35, Jul 23 2026


U-Boot 2026.07-00872-gc20daeac29e7 (Jul 23 2026 - 14:52:43 -0300)

CPU:   NXP i.MX9596 Rev2.0 A55 at 1800 MHz
CPU:   Extended Industrial temperature grade (-40C to 125C)
Model: NXP i.MX95 15X15 FRDM board
DRAM:  Delete node /soc/pcie@4c380000
Delete node /soc/pcie-ep@4c380000
7.8 GiB
ERROR: reserving fdt memory region failed (addr=3D88000000 size=3D8000 flag=
s=3D2): -22
ERROR: reserving fdt memory region failed (addr=3D88008000 size=3D8000 flag=
s=3D2): -22
ERROR: reserving fdt memory region failed (addr=3D88010000 size=3D8000 flag=
s=3D2): -22
ERROR: reserving fdt memory region failed (addr=3D88018000 size=3D8000 flag=
s=3D2): -22
ERROR: reserving fdt memory region failed (addr=3D88020000 size=3D100000
flags=3D2): -22
ERROR: reserving fdt memory region failed (addr=3D88220000 size=3D1000 flag=
s=3D2): -22

This error is unrelated to your patch and others have reported.

Core:  272 devices, 23 uclasses, devicetree: separate
WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Reading from MMC(1)... Loading Environment from MMC... OK
clk_register: failed to get hsiopll device (parent of hsio_blk_ctl_clk)
PCIe PLL lock timeout
pcie_dw_imx pcie@4c300000: failed to wait pll lock

Please fix this PLL lock error.

In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000

BuildInfo:
  - ELE firmware version 2.0.2-2a118457

switch to partitions #0, OK
mmc1 is current device
Net:   eth0: enetc-0 [PRIME], eth1: enetc-1
Hit any key to stop autoboot: 0
u-boot=3D>

> --- /dev/null
> +++ b/arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2026 NXP
> + */
> +
> +#include "imx95-u-boot.dtsi"
> +
> +/ {
> +       aliases {
> +               pci0 =3D &netc_bus0;
> +               pci1 =3D &netc_bus1;
> +       };
> +};
> +
> +&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem} {
> +       filename =3D "lpddr4x_imem_v202409.bin";
> +};
> +
> +&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem} {
> +       filename =3D "lpddr4x_dmem_v202409.bin";
> +};
> +
> +&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb} {
> +       filename =3D "lpddr4x_imem_qb_v202409.bin";
> +};
> +
> +&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb} {
> +       filename =3D "lpddr4x_dmem_qb_v202409.bin";
...
> +&pinctrl_reg_usdhc2_vmmc {
> +       bootph-pre-ram;

Please help upstream the alias and bootph-pre-ram properties in the kernel.

> +#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
> +int board_fix_fdt(void *fdt)
> +{
> +       /* Remove nodes based on fuses. */
> +       return imx9_uboot_fixup_by_fuse(fdt);

Shouldn't this be done at SoC level instead of per board?

> +++ b/board/nxp/imx95_frdm/imx95_frdm.env
> @@ -0,0 +1,93 @@
> +sec_boot=3Dno

Could you please add i.MX95 Secure Boot via another series?

Has Secure Boot been tested with mainline U-Boot?

If secure boot is not planned to be added for now, please remove sec_boot.

> +imx95_frdm
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Please align the underline with the title length; otherwise, building
htmldoc will warn.

This applies globally.

For v4, please make sure it passes CI and share the green CI URL.

> +
> +U-Boot for the NXP i.MX95 15x15 FRDM board
> +
> +Quick Start
> +-----------
> +
> +- Get ahab-container.img
> +- Get DDR PHY Firmware Images
> +- Get and Build OEI Images
> +- Get and Build System Manager Image
> +- Get and Build the ARM Trusted Firmware
> +- Build the Bootloader Image
> +- Boot
> +
> +Get ahab-container.img
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0=
.2-89161a8.bin
> +   $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
> +
> +i.MX95 A0 silicon version
> +
> +.. code-block:: bash
> +
> +   $ cp firmware-ele-imx-2.0.2-89161a8/mx95a0-ahab-container.img $(srctr=
ee)

Please remove this. There is no A0 FRDM board in production, right?

Keep only the B0 instruction.

> +
> +i.MX95 B0 silicon version
> +
> +.. code-block:: bash
> +
> +   $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctr=
ee)

> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz

I had to install 15.2.Rel1 instead. Please update.

> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ export TOOLS=3D$PWD
> +   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
> +   $ cd imx-oei
> +
> +i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
> +
> +.. code-block:: bash
> +
> +   $ make board=3Dmx95lp4x-15 oei=3Dddr DEBUG=3D1 r=3DB0 all
> +   $ cp build/mx95lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
> +
> +Get and Build System Manager Image
> +--------------------------------------
> +
> +Note: srctree is U-Boot source directory
> +Get System Manager from: https://github.com/nxp-imx/imx-sm
> +branch: master
> +
> +.. code-block:: bash
> +
> +   $ sudo apt -y install make gcc g++-multilib srecord
> +   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel=
1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
> +   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz

No need to install the toolchain twice.

> +--------------------------
> +
> +i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
> +
> +.. code-block:: bash
> +
> +   $ export CROSS_COMPILE=3Daarch64-poky-linux-
> +   $ make imx95_15x15_frdm_defconfig
> +   $ make
> +
> +Copy imx-boot-imx95.bin to the MicroSD card:
> +
> +.. code-block:: bash
> +
> +   $ sudo dd if=3Dflash.bin of=3D/dev/sd[x] bs=3D1k seek=3D32 conv=3Dfsy=
nc
> +
> +Boot
> +----
> +
> +Set i.MX95 boot device to MicroSD card

Better explain to the users here how to force the SW1 switch to SD card boo=
t.

> +#ifndef __IMX95_EVK_H
> +#define __IMX95_EVK_H

This is not the EVK.

Tested-by: Fabio Estevam <festevam@gmail.com>
