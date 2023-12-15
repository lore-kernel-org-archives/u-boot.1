Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00BCC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 10:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E748C87B68;
	Fri, 15 Dec 2023 11:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FKmpufXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6462C87B6D; Fri, 15 Dec 2023 11:10:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F7EA87B2B
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 11:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702635026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0B1sCJIuwPMZJzlQxbovHMdlee85Xsh7DaewztpzIM=;
 b=FKmpufXSPWSRiEYxS0NBbsj80sxSykMjgRiUd41NmnnD9GBNksXnXCdS0MZ79E/dLE9fh/
 hPkylJcI4zNbcKvAplqyV0Xt6haT/UMM2lPcYADguWx7zibCTh7BTwtEiI5FfLWoOjgsoC
 bI+dOAXgkNv++ZzKpsvcUhUgivpsOGw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-Bj49wQWqMsmJtgQdZv2qbA-1; Fri, 15 Dec 2023 05:10:24 -0500
X-MC-Unique: Bj49wQWqMsmJtgQdZv2qbA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6da52d3f5daso270865a34.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702635023; x=1703239823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0B1sCJIuwPMZJzlQxbovHMdlee85Xsh7DaewztpzIM=;
 b=XqEN+B6hlIpQt/JumJyPNDYkO3f5KWNovwKW559JNc2hL69GngkkDuGJxj0zdUVsit
 e9H0I8+jAM07ZdbWVjRv/IsRFe8mvJSpB4IVa0NIP+XMqapsRij77oHC8oWxeGBqwoEy
 t9r5KBSU+WmSohqer6hDxfMOhT/XzWfOQltGmx2M6z9/Xsj4ng14GQC1xdy89sozxyGo
 z4w5x8uXGvJMHFXPKYEretm4ruC7UDIj5h/0VN3UhWeU2grFXH3kx/nf+cdbsWzh59r8
 s8TC6Rib7ZgKbqdDbdbksvx3PknrVxFvdVZXyAx1Rw1Ax1CjEA79rApbAFXd0+Y7F6Od
 qjMQ==
X-Gm-Message-State: AOJu0YyDrlDRUwowgkX19YGSH0VQs1XB+gOXrNeV6jnXViJT4w+Pys95
 0ewoj6vglunX20bGI0A3I1OnMBFIyLrYTtBuVRI69QnYwrS99GvOSt/cbnO14UasdEqnfpOomcx
 T/fEwO0bybVKb7pVKw2Fdy75vSHGPJA==
X-Received: by 2002:a9d:7596:0:b0:6da:54f0:5a47 with SMTP id
 s22-20020a9d7596000000b006da54f05a47mr93584otk.33.1702635023600; 
 Fri, 15 Dec 2023 02:10:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoEawrkF19nigEy0iAJrHRfaQsRM31xgV0eojZ2MJCX1EdPocxQTg+Qq3CFRsjxprgpDNln0SL+25/hWGCcPo=
X-Received: by 2002:a9d:7596:0:b0:6da:54f0:5a47 with SMTP id
 s22-20020a9d7596000000b006da54f05a47mr93567otk.33.1702635023274; Fri, 15 Dec
 2023 02:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20231206123753.1486031-1-a-nandan@ti.com>
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Fri, 15 Dec 2023 11:10:12 +0100
Message-ID: <CALE0LRuSnxtkO8Mi9a0MSrnzWyDbi91PvXBzA2zhffur29v0cQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
To: Apurva Nandan <a-nandan@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de, 
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

Hello Apurva,


On Wed, Dec 6, 2023 at 1:38=E2=80=AFPM Apurva Nandan <a-nandan@ti.com> wrot=
e:
>
> Hello Everyone!
>
> This series will introduce basic support (SD and UART) support for Texas
> Instruments J784S4 EVM.
>
> The J784S4 SoC device tree patches are taken from kernel patch submission=
s
> and will be updated as they are accepted and merged to the kernel tree.
> All other patches are specific to SPL and u-boot and do not have
> dependency on other trees. Appreciate a review for acceptance to u-boot
> tree.
>
> Here are some of the salient features of the J784S4 automotive grade
> application processor:
>
> The J784S4 SoC belongs to the K3 Multicore SoC architecture
> platform, providing advanced system integration in automotive,
> ADAS and industrial applications requiring AI at the network edge.
> This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> raising performance and integration while providing interfaces,
> memory architecture and compute performance for multi-sensor, high
> concurrency applications.
>
> Some highlights of this SoC are:
> * Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F =
MCUs,
>   4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) =
for
>   deep learning and CNN.
> * 3D GPU: Automotive grade IMG BXS-4-64 MC1
> * Vision Processing Accelerator (VPAC) with image signal processor and De=
pth
>   and Motion Processing Accelerator (DMPAC)
> * Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and on=
e
>   DPI interface.
> * Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
>   support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-rol=
e
>   device subsystems, Up to 20 MCANs, among other peripherals.
>
> See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
> for further details: http://www.ti.com/lit/zip/spruj52
>
> In addtion, the J784S4 EVM board is designed for TI J784S4 SoC. It
> supports the following interfaces:
> * 32 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mod=
e
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x2 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>   UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * 40-pin User Expansion Connector
> * x2 ENET Expansion Connector, x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances
>
> Schematics: https://www.ti.com/lit/zip/sprr458
>
> eMMC UDA moode bootlog: https://gist.githubusercontent.com/apurvanandan19=
97/3cffada252d50a8aa0c00a91f1f2f856/raw/
>
> Changes in v6:
> 1) Move bootph-all of memory node to u-boot.dtsi
> 2) Used a while loop for DRAM controller init, instead of hard-coding for=
 4 DRAM
> 3) Fixed build error by adding board/ti/j784s4/Kconfig
> 4) Trimmed out j784s4_evm.h
> 5) Fixed checkpatch warnings
>
> Link to v5:
> https://patchwork.ozlabs.org/project/uboot/cover/20231130115552.3580995-1=
-a-nandan@ti.com/
>
> Changes in v5:
> 1) Incorporated Andrew Davis' "Move R5 specific code into new r5/ directo=
ry" and
>    "Move board selection to mach-k3" series changes.
> 2) Incorporated Neha Francis' "Move to using templated FITs" series chang=
es.
> 3) Synced device tree files with Linux v6.7-rc1
> 4) Changed ti_mmc to mmc1 target from bootstd
> 5) Updated doc based on review comments
> 6) Removed remoteproc support from the series
> 7) Splitted board files patch into smaller patches
> 8) Trimmed j784s4.env to necessary variables
> 9) Used fdtdec_setup_mem_size_base fdtdec_setup_memory_banksize in evm.c
> 10) Trimmed down evm.c to essential header files.
> 11) Switched to multi-dtb fit compilation with config fragments
>
> Link to v4:
> https://lore.kernel.org/u-boot/20231001165545.494212-1-a-nandan@ti.com/
>
> Changes in v4:
> 1) Cleaned up Copyright and SPDX identifiers
> 2) Synced the device trees to Linux v6.6-rc1 tag
> 3) Added cleanup patch for sorting SoC JTAG ID entries
> 4) Removed EEPROM board detect from evm.c and added am69 config fragments
> 5) Updated MAINTAINERS files and commit messages
> 6) Removed struct renaming in ti_k3_r5f_rproc driver
>
> Link to v3:
> https://lore.kernel.org/u-boot/20230908110551.861575-1-a-nandan@ti.com/
>
> Changes in v3:
> 1) Added AM69 SK support in the series
> 2) Switched from distroboot to bootstd support
> 3) Added remoteproc support for J784S4
> 4) Added documentation for both SoCs
> 5) Added binman support
> 6) Removed unnecessarry nodes from r5-evm.dts and evm-u-boot.dtsi
> 7) Added HS device support
> 8) Added env file for environement variables
> 9) Removed ti-serdes-mux bindings
> 10) Cleaned up all files and synced with latest
> 11) Addressed all previous review comments
>
> Note: The base dts files have been sync from next-20230905 linux tag as p=
er review comment received
> on previous re-roll:
> https://lore.kernel.org/u-boot/20230321155227.GV8135@bill-the-cat/
>
> Link to v2:
> https://lore.kernel.org/u-boot/20230321141028.24456-1-hnagalla@ti.com/
>
> Changes in v2:
> - Refactored environement scripts to 'j784s4.env' and removed scripts not
>   needed for basic board bootup.
> - Imported the J7874S4 basic device tree files from v6.2 linux kernel.
> - Moved j784s4 clock definitions and clock data into one patch/commit.
> - coalesce board commits into one commit.
>
> Apurva Nandan (14):
>   arm: dts: Introduce j784s4 dts from linux kernel
>   arm: mach-k3: Add basic support for J784S4 SoC definition
>   arm: mach-k3: Sort SoC JTAG_ID entries
>   soc: ti: k3-socinfo: Add entry for J784S4 SoC
>   arm: mach-k3: j784s4: Add clk and power support
>   drivers: dma: Add support for J784S4 SoC
>   board: ti: j784s4: Add board support for J784S4 EVM
>   board: ti: j748s4: Add board config yaml files
>   board: ti: j784s4: Add boot environment variables
>   arm: dts: Introduce j784s4 u-boot dts files
>   arm: dts: Add bootph-all for memory node
>   configs: j784s4_evm: Add defconfig for j784s4 evm board
>   doc: board: ti: k3: Add J784S4 EVM and AM69 SK documentation
>   board: ti: j784s4: Add MAINTAINERS file
>
> Dasnavis Sabiya (3):
>   arm: dts: Introduce am69-sk dts from linux kernel
>   arm: dts: Introduce am69-sk u-boot dts files
>   configs: Add am69_sk_* defconfig fragments
>
>  arch/arm/dts/Makefile                         |    4 +
>  arch/arm/dts/k3-am69-r5-sk.dts                |  105 +
>  arch/arm/dts/k3-am69-sk-u-boot.dtsi           |   31 +
>  arch/arm/dts/k3-am69-sk.dts                   |  900 ++
>  arch/arm/dts/k3-j784s4-binman.dtsi            |  435 +
>  arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi  | 8757 ++++++++++++++++
>  arch/arm/dts/k3-j784s4-ddr.dtsi               | 8858 +++++++++++++++++
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |   31 +
>  arch/arm/dts/k3-j784s4-evm.dts                |  981 ++
>  arch/arm/dts/k3-j784s4-main.dtsi              | 2068 ++++
>  arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi        |  743 ++
>  arch/arm/dts/k3-j784s4-r5-evm.dts             |  105 +
>  arch/arm/dts/k3-j784s4-thermal.dtsi           |  101 +
>  arch/arm/dts/k3-j784s4.dtsi                   |  294 +
>  arch/arm/mach-k3/Kconfig                      |   17 +-
>  arch/arm/mach-k3/Makefile                     |    2 +
>  arch/arm/mach-k3/arm64-mmu.c                  |   52 +
>  arch/arm/mach-k3/include/mach/hardware.h      |   13 +-
>  .../mach-k3/include/mach/j784s4_hardware.h    |   60 +
>  arch/arm/mach-k3/include/mach/j784s4_spl.h    |   47 +
>  arch/arm/mach-k3/include/mach/spl.h           |    4 +
>  arch/arm/mach-k3/j784s4/Kconfig               |   35 +
>  arch/arm/mach-k3/j784s4_fdt.c                 |   15 +
>  arch/arm/mach-k3/j784s4_init.c                |  335 +
>  arch/arm/mach-k3/r5/Makefile                  |    1 +
>  arch/arm/mach-k3/r5/j784s4/Makefile           |    7 +
>  arch/arm/mach-k3/r5/j784s4/clk-data.c         |  428 +
>  arch/arm/mach-k3/r5/j784s4/dev-data.c         |   98 +
>  board/ti/j784s4/Kconfig                       |   37 +
>  board/ti/j784s4/MAINTAINERS                   |   25 +
>  board/ti/j784s4/Makefile                      |    7 +
>  board/ti/j784s4/board-cfg.yaml                |   37 +
>  board/ti/j784s4/evm.c                         |   38 +
>  board/ti/j784s4/j784s4.env                    |   18 +
>  board/ti/j784s4/pm-cfg.yaml                   |   13 +
>  board/ti/j784s4/rm-cfg.yaml                   | 3058 ++++++
>  board/ti/j784s4/sec-cfg.yaml                  |  380 +
>  board/ti/j784s4/tifs-rm-cfg.yaml              | 2656 +++++
>  configs/am69_sk_a72.config                    |    3 +
>  configs/am69_sk_r5.config                     |    3 +
>  configs/j784s4_evm_a72_defconfig              |  180 +
>  configs/j784s4_evm_r5_defconfig               |  163 +
>  doc/board/ti/j784s4_evm.rst                   |  303 +
>  doc/board/ti/k3.rst                           |    1 +
>  drivers/clk/ti/clk-k3.c                       |    6 +
>  drivers/dma/ti/Makefile                       |    1 +
>  drivers/dma/ti/k3-psil-j784s4.c               |  166 +
>  drivers/dma/ti/k3-psil-priv.h                 |    1 +
>  drivers/dma/ti/k3-psil.c                      |    2 +
>  drivers/firmware/ti_sci_static_data.h         |   34 +
>  drivers/power/domain/ti-power-domain.c        |    6 +
>  drivers/ram/Kconfig                           |    2 +-
>  drivers/soc/soc_ti_k3.c                       |    3 +
>  include/configs/j784s4_evm.h                  |   15 +
>  include/k3-clk.h                              |    1 +
>  include/k3-dev.h                              |    1 +
>  56 files changed, 31675 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am69-r5-sk.dts
>  create mode 100644 arch/arm/dts/k3-am69-sk-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-am69-sk.dts
>  create mode 100644 arch/arm/dts/k3-j784s4-binman.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-evm.dts
>  create mode 100644 arch/arm/dts/k3-j784s4-main.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
>  create mode 100644 arch/arm/dts/k3-j784s4-thermal.dtsi
>  create mode 100644 arch/arm/dts/k3-j784s4.dtsi
>  create mode 100644 arch/arm/mach-k3/include/mach/j784s4_hardware.h
>  create mode 100644 arch/arm/mach-k3/include/mach/j784s4_spl.h
>  create mode 100644 arch/arm/mach-k3/j784s4/Kconfig
>  create mode 100644 arch/arm/mach-k3/j784s4_fdt.c
>  create mode 100644 arch/arm/mach-k3/j784s4_init.c
>  create mode 100644 arch/arm/mach-k3/r5/j784s4/Makefile
>  create mode 100644 arch/arm/mach-k3/r5/j784s4/clk-data.c
>  create mode 100644 arch/arm/mach-k3/r5/j784s4/dev-data.c
>  create mode 100644 board/ti/j784s4/Kconfig
>  create mode 100644 board/ti/j784s4/MAINTAINERS
>  create mode 100644 board/ti/j784s4/Makefile
>  create mode 100644 board/ti/j784s4/board-cfg.yaml
>  create mode 100644 board/ti/j784s4/evm.c
>  create mode 100644 board/ti/j784s4/j784s4.env
>  create mode 100644 board/ti/j784s4/pm-cfg.yaml
>  create mode 100644 board/ti/j784s4/rm-cfg.yaml
>  create mode 100644 board/ti/j784s4/sec-cfg.yaml
>  create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
>  create mode 100644 configs/am69_sk_a72.config
>  create mode 100644 configs/am69_sk_r5.config
>  create mode 100644 configs/j784s4_evm_a72_defconfig
>  create mode 100644 configs/j784s4_evm_r5_defconfig
>  create mode 100644 doc/board/ti/j784s4_evm.rst
>  create mode 100644 drivers/dma/ti/k3-psil-j784s4.c
>  create mode 100644 include/configs/j784s4_evm.h
>
> --
> 2.34.1
>

Thanks for sending these patches, this has been tested against AM69-SK
board, so for the full series you can also add:

Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>

While here, it would be really nice if you can send the required
firmware (ti-sysfw and ti-dm if I'm not mistaken) to linux-firmware.

Thanks,
  Enric

