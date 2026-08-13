Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0264EC5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 12:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8465260AF6;
	Thu, 13 Aug 2026 12:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOeAWtc4lb7V; Thu, 13 Aug 2026 12:53:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC261608AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786625581;
	bh=BYNnx0OWtNrsptJhQnymNop3/yZs8Oc6tr7nIG/p1FQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lC5eFbfJBQVSPG9yda+lkmRwo3MJnzg9LatYOCeZAxpNWkTql7IyJLEG9Cw4fx22h
	 Nwi8AFzPNTBRimUFjdh/mXhhW82HAijQSwueRPy8DrWRcXYgr1cSqD7qRZMBoVyftF
	 7UyPLvXogpYTz3UCAZ+itozCh+yrs9DMmTKBsDw9cLTPeQdUsc5qrJHHU2WHTz6DOV
	 3Aky9LfLPcawExww4FdMHP7X8vE8n70vGSF5hae2QFUPFtGJSNEFSH4oqLC71MmbER
	 emWs3TcYouR5lCh5rFOOCmPHPIlSwPNdJRspnDcvZSukbGvpfpFAMGdS3H6FPvyoRj
	 XNvdOdRdmonoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC261608AE;
	Thu, 13 Aug 2026 12:53:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8813AEC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C572811C0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1cVUbT8uS2d for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 12:40:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=petko.manolov@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A31AD81190
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A31AD81190
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A31AD81190
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 12:40:16 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so2606219a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 05:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786624814; x=1787229614;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BYNnx0OWtNrsptJhQnymNop3/yZs8Oc6tr7nIG/p1FQ=;
 b=jPIaFb4orzjtAqyIHE/M+QFksshlgzwAE8wDu4AJH9rq6vjPhJEXHMjxhKM8b5ygDR
 xd2jQIVx6xy7owuFXofhKmjgX0ILEcwMmEOnHSYiXiKkW4fvw8TP94anlpj37KX3WSBP
 D0tEkOSqj5WtTmWa9g6VZ/X3XFsR102TXkFDZwRN7atUMmU8nSYKuwzrBXevwAqlQezR
 WklK49g4OKKwPvUUz3s3XsCM9Ywz3/NA47pwkyVnrm8jPiLL5jNLfL6XlzBOfEjJCPcJ
 nYNrZvUDl4DzhnVslRk3UXkulr1Il56bNHEEA71UWdW7MY/jJ/yfSrnM8wRFra/y0yCB
 GZFg==
X-Gm-Message-State: AOJu0YxCq2hxZxRsvUrlTadAhyWpewCDzAV38JVwfE/wtUnXdEZkuB4J
 uPXSsF88ZTUiO9o6TI5zFzlCW5GnBo13RYBlGaOlMb1N0NYNOheuCVc8bQ8ELv5C1ZoHmaK8CHW
 kbs7h8Uc=
X-Gm-Gg: AR+sD114jJ3wGXTAdBU024gGW/kaf8KdDI69hhkqS6ZBrtpd/mVAye6vK7/Yc1GQjcM
 cOTKAKMGYvVtscJ+IXHfPBphYiq781JnUiK2gZtpAsfDnMmVnIvmuBuCx6ghcft7+LjJsAxbVod
 XcNXAvxjPQA3dhqUWdhk6XXRhjGr2z7EZZI2hs58C5dKXU3+ZK1FfhxrziHrmn5rP0NmNDrSnoi
 bjkhk/ah+prCSFeLs3bL8ob6IDpLSQwbZjndc7CUTewZGt7OoX7JHeeQWGLQn2UlX89DBf/Kbqr
 OZ2qXSJ1GJ3RJ6DTPP5Wdwk6/s6pJmB2wmE6fZI1KZilNTydJewnHMNwygc6U5VtPfMlI6tU9Vi
 1DO54BBowoaGdMviwaVxU6b9nK4vwmK1L8XOdtd0qd4imVfeqliz/+FJ1y4PO8SKc+rhIU+juz9
 7Rtxx/xDdWGyLuNnkP8I8AmKNpEX2j8zQ/BMFcH7mjeSz27crgxQu9FAmvMIuc4/IhdXA=
X-Received: by 2002:a05:6402:454f:b0:6a0:d40e:9c0b with SMTP id
 4fb4d7f45d1cf-6a380618f68mr2289520a12.16.1786624814231; 
 Thu, 13 Aug 2026 05:40:14 -0700 (PDT)
Received: from carbon.k.g ([85.187.61.220]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f7f0fe4sm860036a12.10.2026.08.13.05.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:40:12 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:40:10 +0300
From: Petko Manolov <petko.manolov@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, ilias.apalodimas@linaro.org
Subject: perp work for submitting Draeger imx6-related patches
Message-ID: <20260813124010.GA8626@carbon.k.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 12:52:59 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786624814; x=1787229614;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BYNnx0OWtNrsptJhQnymNop3/yZs8Oc6tr7nIG/p1FQ=;
 b=bCXbySD3YOVQR4avOiSNvpxyRojksuhx7aV7HNSLBkZGvlrjJNJEVahq2aGGDXyg9U
 uuld4WQw+40wHsY4wvn9aKd3ZKRrh7EUStHIUC11sPrGd3yP1aLTRulGlUKBxmQHarvJ
 5dSDaCU/N9wVj2uT4CDbouvt7OnIrPXsFjMqI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bCXbySD3
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

	Hello guys,

I am tasked with submitting the patches Draeger (Dräger) applied to u-boot for
their imx6-based product line.  I've already spoken to Tom Rini about how to
approach the upstreaming them, but would like to get your opinion as imx6
maintainers.

The patch series touch quite a few files and some changes are not suitable for
mainlining in their present form and thus i'll have to rework them.  I'll start
with sending (below) the short diff stat just to give you an idea about what's
been changed.


cheers,
Petko


---
 arch/arm/Kconfig                                   |     1 +
 arch/arm/dts/Makefile                              |     5 +-
 arch/arm/dts/imx6dl-draeger-m48.dts                |    23 +
 arch/arm/dts/imx6q-draeger-m48.dts                 |    23 +
 arch/arm/dts/imx6qdl-draeger-m48-u-boot.dtsi       |    20 +
 arch/arm/dts/imx6qdl-draeger-m48.dtsi              |   354 +
 arch/arm/dts/imx6qp-draeger-m48.dts                |    87 +
 .../dts/socfpga_cyclone5_draeger_m48-u-boot.dtsi   |    66 +
 arch/arm/dts/socfpga_cyclone5_draeger_m48.dts      |   134 +
 arch/arm/include/asm/arch-mx6/mx6-ddr.h            |     1 +
 arch/arm/include/asm/arch-mx6/mx6dl-ddr.h          |     2 +
 arch/arm/include/asm/arch-mx6/mx6q-ddr.h           |     2 +
 arch/arm/include/asm/mach-imx/mxc_i2c.h            |     1 +
 arch/arm/mach-imx/i2c-mxv7.c                       |    51 +-
 arch/arm/mach-imx/mx6/Kconfig                      |    14 +
 arch/arm/mach-imx/mx6/clock.c                      |     4 +
 arch/arm/mach-socfpga/Kconfig                      |     7 +
 arch/arm/mach-socfpga/spl_gen5.c                   |     4 +
 board/draeger/common/Makefile                      |    11 +
 board/draeger/common/draeger_common.c              |   549 +
 board/draeger/common/draeger_common.h              |    59 +
 board/draeger/common/draeger_m48_pmstruct.h        |    77 +
 board/draeger/common/draeger_post_memory.c         |    28 +
 board/draeger/imx6m48/Kconfig                      |    21 +
 board/draeger/imx6m48/MAINTAINERS                  |     6 +
 board/draeger/imx6m48/Makefile                     |    15 +
 board/draeger/imx6m48/clocks.cfg                   |    41 +
 board/draeger/imx6m48/imx6_dp.c                    |   495 +
 board/draeger/imx6m48/imx6m48.c                    |  1330 +++
 board/draeger/imx6m48/imx6m48.h                    |    67 +
 board/draeger/imx6m48/imx6m48_spl.c                |   674 ++
 board/draeger/imx6m48/imx6m48_spl_cfg.h            |    45 +
 board/draeger/imx6m48/imx6m48dl_spl_cfg.c          |   969 ++
 board/draeger/imx6m48/imx6m48q_spl_cfg.c           |   975 ++
 board/draeger/imx6m48/imx6m48qp_spl_cfg.c          |   619 ++
 board/draeger/imx6m48/imx6m48spl.cfg               |    27 +
 board/draeger/socfpga_m48/MAINTAINERS              |     6 +
 board/draeger/socfpga_m48/Makefile                 |     8 +
 board/draeger/socfpga_m48/socfpga.c                |  1294 +++
 boot/bootm_os.c                                    |    35 +
 cmd/diag.c                                         |     1 +
 cmd/net.c                                          |    14 +-
 cmd/sf.c                                           |    16 +-
 common/spl/Kconfig                                 |     6 -
 common/spl/spl.c                                   |     7 +
 common/spl/spl_spi.c                               |    16 +-
 configs/draeger_imx6m48_defconfig                  |  2006 ++++
 configs/draeger_imx6m48_revoke_defconfig           |  2006 ++++
 configs/draeger_socfpga_m48_defconfig              |  1932 ++++
 draeger/FPGA/m48_test/bin/m48_cv_se_a2.img         |   Bin 0 -> 4244884 bytes
 draeger/FPGA/m48_test/bin/m48_default_system.img   |   Bin 0 -> 4244884 bytes
 draeger/FPGA/m48_test/bin/m48_default_system.jpg   |   Bin 0 -> 1053337 bytes
 draeger/FPGA/m48_test/bin/m48_default_system.rbf   |   Bin 0 -> 4244820 bytes
 draeger/FPGA/m48_test/bin/preloader-mkpimage.bin   |   Bin 0 -> 262144 bytes
 draeger/FPGA/m48_test/quartus/m48_cv_se_a2.qsys    |  1605 +++
 draeger/FPGA/m48_test/quartus/m48_soc.qsys         |  1605 +++
 draeger/FPGA/m48_test/scripts/buildFPGAImage.cmd   |    79 +
 draeger/FPGA/m48_test/scripts/buildPreloader.cmd   |    59 +
 .../m48_test/scripts/create_quartus_project.tcl    |    13 +
 draeger/FPGA/m48_test/scripts/m48_cv_se_a2.tcl     |   929 ++
 .../FPGA/m48_test/scripts/m48_default_system.tcl   |   929 ++
 .../FPGA/m48_test/scripts/prepareIpSearchPath.cmd  |    29 +
 .../m48_test/src/m48_default_system_timing.sdc     |   507 +
 draeger/FPGA/m48_test/src/m48_top.v                |   659 ++
 .../m48_test/src/my_ClkDivider/my_ClkDivider.qip   |   338 +
 .../m48_test/src/my_ClkDivider/my_ClkDivider.v     |   255 +
 .../my_ClkDivider/my_ClkDivider_0002.qip           |     4 +
 .../my_ClkDivider/my_ClkDivider_0002.v             |    90 +
 draeger/FPGA/m48_test/srcPreloader/build.h         |   167 +
 .../m48_test/srcPreloader/iocsr_config_cyclone5.c  |   675 ++
 .../m48_test/srcPreloader/iocsr_config_cyclone5.h  |    38 +
 draeger/FPGA/m48_test/srcPreloader/pinmux_config.h |    75 +
 .../m48_test/srcPreloader/pinmux_config_cyclone5.c |   241 +
 draeger/FPGA/m48_test/srcPreloader/pll_config.h    |   108 +
 draeger/FPGA/m48_test/srcPreloader/reset_config.h  |    82 +
 .../FPGA/m48_test/srcPreloader/sdram/alt_types.h   |    51 +
 .../m48_test/srcPreloader/sdram/sdram_config.h     |   108 +
 .../FPGA/m48_test/srcPreloader/sdram/sdram_io.h    |    54 +
 .../FPGA/m48_test/srcPreloader/sdram/sequencer.c   | 10739 +++++++++++++++++++
 .../FPGA/m48_test/srcPreloader/sdram/sequencer.h   |   648 ++
 .../m48_test/srcPreloader/sdram/sequencer_auto.h   |   228 +
 .../srcPreloader/sdram/sequencer_auto_ac_init.c    |    72 +
 .../srcPreloader/sdram/sequencer_auto_inst_init.c  |   163 +
 .../srcPreloader/sdram/sequencer_defines.h         |   162 +
 draeger/FPGA/m48_test/srcPreloader/sdram/system.h  |    38 +
 draeger/FPGA/m48_test/srcPreloader/sdram/tclrpt.c  |  1130 ++
 draeger/FPGA/m48_test/srcPreloader/sdram/tclrpt.h  |   581 +
 draeger/Jenkinsfile                                |   251 +
 draeger/M48Test/iocsr_config_cyclone5.c            |   675 ++
 draeger/M48Test/iocsr_config_cyclone5.h            |    38 +
 draeger/M48Test/pinmux_config_cyclone5.c           |   241 +
 draeger/M48Test/pll_config.h                       |   107 +
 draeger/M48Test/reset_config.h                     |    82 +
 draeger/M48Test/sdram/sdram_config.h               |   113 +
 draeger/M48Test/sdram/sequencer_auto.h             |   228 +
 draeger/M48Test/sdram/sequencer_auto_ac_init.c     |    72 +
 draeger/M48Test/sdram/sequencer_auto_inst_init.c   |   163 +
 draeger/M48Test/sdram/sequencer_defines.h          |   162 +
 draeger/build/README.md                            |    52 +
 draeger/build/SyncSourceToArtifactVersion.sh       |    40 +
 draeger/build/build_all.sh                         |    62 +
 draeger/build/conan_v1/conanfile.py.in             |    39 +
 draeger/build/conan_v1/copy_gcc_copyright.sh       |    12 +
 draeger/build/conan_v1/create_conan_package.cmake  |    73 +
 draeger/build/conan_v1/gcc_package_skeleton.yml    |    19 +
 draeger/build/conan_v1/package_uboot.yml           |   355 +
 .../plain/cmake/container_images.properties        |     1 +
 draeger/build/conanfile.py                         |   176 +
 draeger/build/create_conan_package.cmake           |     9 +
 draeger/build/getBuildId.sh                        |    65 +
 .../0_m48_up1_field_return.cmm                     |    41 +
 .../imx6FieldReturnScripts/calculateresponse.cmm   |    10 +
 .../imx6FieldReturnScripts/imx6_attach_secured.cmm |   Bin 0 -> 6712 bytes
 draeger/build/imx6FieldReturnScripts/readme.txt    |     5 +
 .../build/make_up2_preloader_with_synced_source.sh |    77 +
 draeger/build/mkuboot.sh                           |   195 +
 draeger/build/startDockerContainer.sh              |    62 +
 draeger/draco.json                                 |    15 +
 draeger/scripts/UpdateUBootSD.scr                  |     5 +
 drivers/clk/imx/clk-imx6q.c                        |    39 +-
 drivers/clk/imx/clk-pllv3.c                        |     5 +
 drivers/crypto/fsl/jr.c                            |    20 +-
 drivers/crypto/fsl/jr.h                            |     4 -
 drivers/ddr/altera/sdram_gen5.c                    |     2 +-
 drivers/ddr/altera/sequencer.c                     |    15 +-
 drivers/ddr/altera/sequencer.h                     |     3 +
 drivers/gpio/Makefile                              |     2 +
 drivers/i2c/mxc_i2c.c                              |     7 +
 drivers/mmc/fsl_esdhc_imx.c                        |    21 +-
 drivers/mtd/spi/sf-uclass.c                        |    13 +
 drivers/mtd/spi/sf_internal.h                      |     2 +
 drivers/mtd/spi/sf_probe.c                         |     8 +
 drivers/mtd/spi/spi-nor-core.c                     |    18 +-
 drivers/mtd/spi/spi-nor-tiny.c                     |     5 +
 drivers/net/phy/micrel_ksz90x1.c                   |   316 +-
 drivers/net/phy/phy.c                              |    26 +-
 drivers/serial/serial_mxc.c                        |    44 +-
 drivers/video/imx/ipu.h                            |    36 +-
 drivers/video/imx/ipu_common.c                     |    94 +-
 drivers/video/imx/ipu_disp.c                       |    44 +-
 drivers/video/imx/mxc_ipuv3_fb.c                   |    75 +-
 drivers/watchdog/imx_watchdog.c                    |     2 +-
 env/sf.c                                           |     1 +
 include/configs/draeger_imx6m48.h                  |   185 +
 include/configs/draeger_socfpga_m48.h              |   138 +
 include/env_default.h                              |     2 +
 include/fsl_esdhc_imx.h                            |     1 +
 include/spi_flash.h                                |    22 +
 lib/display_options.c                              |     2 +-
 lib/tiny-printf.c                                  |     1 +
 net/net.c                                          |     6 +-
 post/drivers/memory.c                              |     4 +-
 post/tests.c                                       |    12 +-
 scripts/Makefile.lib                               |     1 +
 tools/logos/imx6m48.bmp                            |   Bin 0 -> 38778 bytes
 155 files changed, 40997 insertions(+), 239 deletions(-)
---
