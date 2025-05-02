Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4003EC369DC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 02:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A5B8070C;
	Fri,  2 May 2025 04:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fkVO5sX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4EA38070C; Fri,  2 May 2025 04:50:41 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC87B801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 04:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d4436ba324so13443825ab.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 19:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746154237; x=1746759037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sjQNdwLQR8UyFabS+/JYOybE2yleqn14m9qcPrsFeEk=;
 b=fkVO5sX9t4xltBXQbc8toNn+VngP1sZ7bHsUWd1yOvLYDTu6jGb2gSFVaDdfB+vllh
 BrSM5xCzBf0vXfNc5uG9U5FebKswGackbi4tMQDuBoYDmPer7yRdm4weuHjQi5G7mS9V
 2ebZZueQO045zxo74+54IMW0BDyA+KQsuvm3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746154237; x=1746759037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjQNdwLQR8UyFabS+/JYOybE2yleqn14m9qcPrsFeEk=;
 b=lFYoy4L0VwxO53Mt7ur6RM1XElY1MLJUGYfsrobaSK2khYJb6BmxL+kjk0CIXTRgrb
 1q2uviC5L4Cv+qGqY/0eVBvrO5oMYx5m22YwQnd6yWboFXtw9FRJRjkk/HANEnv545an
 IgJyhjT2JffRjDWq27EYFBKWziceMbal15WPfsIxE/vFOwwFTbSWE8z4dwscst4t/FEt
 qlSqdzwphTitCyvW7ih1pHAfSqz+4dPPy2gnf0Qc5UX0Q60nZqO+DWptHlo4jUrqfTIb
 +e/MQ/1jkDjAHmTOVgzfvzadFPTmol2Tv4+NZyzqErAD7PBLMdIsmFxgQdRGKdXFIL59
 ulrw==
X-Gm-Message-State: AOJu0YxtasygaQKZ2c90MB31XWGRhlfyj/4nnDXMVeNzRd7XWE8s2Nh8
 h9QWB/el1ntNKWy9tmXh+z8mmQue7NSEHLpPOsOzynBhS64NnlLdBZ6bTQYTXGOe26P2KCFl3aU
 =
X-Gm-Gg: ASbGncvVuzcJDTe7TAxvxohmWr6AaLI/o+XAvUzBPqqGLqriVBIiEqx6+nt+OeSLI8b
 7fFaj9f7HHC2pnlqrthupLX+GWH8DnqKf0W1tXkSIPCT7Jldsw9lvbUbN+91GQObo5MgTwseFqB
 JFj9E/P+HazRj6tHQEEd63TL+q0I+hq40PtVrWuacRISUiFg0tU85MvDguFC538MU4leNp44eRU
 ckfVOt/MbaEu8GKmIVSft92GHde/6035ENERBZx9NyXo+6P+JxpLZui7YMqdLZMqI3c0Ir+Ca5C
 YC0y2hWYqgvbizxvitLB/lxS6O8jgza26Tb0uxfN7XqxyhOTSgPyy+SLJg20pXbhFPoJnjyIgdx
 Ltw==
X-Google-Smtp-Source: AGHT+IG/XuhkDfTvDrPDUnNFlqP638R5pQuU++zCJXEay1dwC+vVHrGiaBC7O/j4B5hc28O3Z5QUPg==
X-Received: by 2002:a05:6e02:2307:b0:3d9:2aa3:fe2e with SMTP id
 e9e14a558f8ab-3d97c184cbemr13739455ab.10.1746154237030; 
 Thu, 01 May 2025 19:50:37 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a918039sm166627173.55.2025.05.01.19.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 19:50:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/3] RFC: test: Bring in the test hooks
Date: Thu,  1 May 2025 20:50:16 -0600
Message-ID: <20250502025026.4140184-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

During a recent discussion with Heinrich we discussed why the hooks are
kept in a separate repo.

The amount of code is small, a tenth of the size of the recently added
lwip, just by way of example. Testing is a critical part of U-Boot and
one of the things that distinguishes it from firmware projects that have
not kept up in this area. By having the tests somewhere else, we are
signalling that it is unusual, or difficult, or optional.

The hooks mechanism also needs something of an update to take account of
real boards in 2025. That will be much easier to undertake if the code
that test/py talks to is in the same repo.

This series brings the hook files in as first-class citizens of U-Boot.

If we do go ahead with this, I will send a different series which has
separate commits (with correct author) in the u-boot-test-hooks repo.


Simon Glass (3):
  test: Bring in the test hooks
  doc: Tidy up the hooks documentation
  CI: Update to use the hooks in the U-Boot repo

 .azure-pipelines.yml                          |  15 +-
 .gitlab-ci.yml                                |  16 +-
 doc/develop/index.rst                         |   1 +
 doc/develop/py_testing.rst                    |  22 +-
 doc/develop/test_hooks.rst                    | 306 ++++++++++++++++++
 test/hooks/bin/OLI01/conf.mx6qsabrelite_na    |  26 ++
 .../conf.integratorcp_cm926ejs_qemu           |  27 ++
 test/hooks/bin/bill-the-cat/conf.qemu_mips_na |  28 ++
 .../bill-the-cat/conf.vexpress_ca15_tc2_qemu  |  27 ++
 .../bin/common-config.cros-servo-dut-control  |  69 ++++
 test/hooks/bin/common.labgrid-trini           |  35 ++
 test/hooks/bin/console.fvp                    |  28 ++
 test/hooks/bin/console.labgrid-sjg            |  42 +++
 test/hooks/bin/console.labgrid-trini          |  24 ++
 test/hooks/bin/console.picocom                |  42 +++
 test/hooks/bin/console.qemu                   |  35 ++
 test/hooks/bin/download.imx_usb               |  23 ++
 test/hooks/bin/download.l4t-exec-uboot        |  25 ++
 test/hooks/bin/download.tegra-uboot-flasher   |  24 ++
 test/hooks/bin/ellesmere/common-labgrid-sjg   |  46 +++
 test/hooks/bin/ellesmere/conf.all             |  24 ++
 .../hooks/bin/ellesmere/conf.evb-ast2500_qemu |  11 +
 test/hooks/bin/ellesmere/conf.qemu-riscv32_na |   1 +
 .../bin/ellesmere/conf.qemu-riscv32_spl_na    |   1 +
 test/hooks/bin/ellesmere/conf.qemu-riscv64_na |   1 +
 test/hooks/bin/ellesmere/conf.qemu-x86_64_na  |   1 +
 test/hooks/bin/ellesmere/conf.qemu-x86_na     |   1 +
 test/hooks/bin/ellesmere/conf.qemu_arm64_na   |   1 +
 .../bin/ellesmere/conf.qemu_arm64_spl_na      |   1 +
 test/hooks/bin/ellesmere/conf.qemu_arm_na     |   1 +
 test/hooks/bin/ellesmere/conf.qemu_arm_spl_na |   1 +
 test/hooks/bin/flash.em100                    |  30 ++
 test/hooks/bin/flash.fiptool                  |  22 ++
 test/hooks/bin/flash.flashair                 |  45 +++
 test/hooks/bin/flash.labgrid-trini.sd-mux     |  31 ++
 test/hooks/bin/flash.none                     |  21 ++
 test/hooks/bin/flash.qemu_gen_padded_image    |  15 +
 test/hooks/bin/flash.recovery_l4t             |  44 +++
 test/hooks/bin/flash.sdwire_common_mount      |  80 +++++
 .../bin/flash.sdwire_digital-loggers_raw      |  41 +++
 test/hooks/bin/flash.sdwire_poweroff_mount    |  32 ++
 test/hooks/bin/flash.sdwire_poweroff_raw      |  42 +++
 test/hooks/bin/flash.sdwire_relay_mount       |  34 ++
 test/hooks/bin/flashair.rpi                   |  47 +++
 test/hooks/bin/flashair.ti-omap               |  26 ++
 test/hooks/bin/getrole.labgrid-sjg            |  34 ++
 .../kea/conf.Linksprite_pcDuino3_sjg-pcduino3 |  33 ++
 .../bin/kea/conf.chromebook_link_sjg-link     |  30 ++
 .../bin/kea/conf.chromebook_samus_sjg-samus   |  30 ++
 test/hooks/bin/kea/conf.jetson-tk1_sjg-tk1    |  38 +++
 .../bin/kea/conf.minnowmax_sjg-minnowmax      |  33 ++
 .../hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc |  35 ++
 test/hooks/bin/kea/conf.rock2_sjg-rock2       |  33 ++
 test/hooks/bin/kea/conf.rpi_3_32b_sjg-rpi_3b  |  34 ++
 test/hooks/bin/kea/conf.rpi_3_sjg-rpi_3b      |  34 ++
 .../bin/kea/conf.zynq_zybo_sjg-zynq_zybo      |  44 +++
 .../conf.am62x_beagleplay_a53_na              |  30 ++
 .../konsulko-labgrid/conf.am64x_evm_a53_na    |  30 ++
 .../bin/konsulko-labgrid/conf.rpi_4_32b_na    |   1 +
 test/hooks/bin/konsulko-labgrid/conf.rpi_4_na |   1 +
 .../bin/konsulko-labgrid/conf.rpi_arm64_na    |  25 ++
 test/hooks/bin/poweroff.digital-loggers       |  22 ++
 test/hooks/bin/poweroff.manual                |  21 ++
 test/hooks/bin/poweroff.none                  |  22 ++
 test/hooks/bin/poweroff.phidgets              |  37 +++
 test/hooks/bin/poweroff.pm342                 |  21 ++
 test/hooks/bin/poweroff.ykush                 |  23 ++
 test/hooks/bin/poweron.digital-loggers        |  22 ++
 test/hooks/bin/poweron.manual                 |  21 ++
 test/hooks/bin/poweron.none                   |  22 ++
 test/hooks/bin/poweron.phidgets               |  32 ++
 test/hooks/bin/poweron.pm342                  |  24 ++
 test/hooks/bin/poweron.ykush                  |  23 ++
 test/hooks/bin/push-flashair.py               | 118 +++++++
 test/hooks/bin/qemu.swtpm                     |  23 ++
 test/hooks/bin/recovery.manual                |  23 ++
 test/hooks/bin/recovery.phidgets              |  29 ++
 test/hooks/bin/recovery.pm342                 |  26 ++
 test/hooks/bin/recovery.relay                 |  39 +++
 test/hooks/bin/recovery.usbrelay              |  32 ++
 test/hooks/bin/release.labgrid-sjg            |  22 ++
 test/hooks/bin/release.none                   |  22 ++
 test/hooks/bin/reset.cros_servo               |  23 ++
 test/hooks/bin/reset.digital-loggers          |  25 ++
 test/hooks/bin/reset.labgrid-trini            |  24 ++
 test/hooks/bin/reset.none                     |  30 ++
 test/hooks/bin/reset.pm342                    |  21 ++
 test/hooks/bin/reset.recovery_download        |  36 +++
 test/hooks/bin/reset.usbrelay                 |  26 ++
 test/hooks/bin/reset.ykush                    |  25 ++
 test/hooks/bin/swarren-lx1/conf.jetson-tk1_na |  36 +++
 test/hooks/bin/swarren-lx1/conf.p2371-2180_na |  57 ++++
 .../bin/swarren-lx1/conf.p2771-0000-500_na    |  32 ++
 test/hooks/bin/travis-ci/conf.M5208EVBE_qemu  |  27 ++
 test/hooks/bin/travis-ci/conf.coreboot_qemu   |  28 ++
 .../hooks/bin/travis-ci/conf.evb-ast2500_qemu |  11 +
 .../hooks/bin/travis-ci/conf.evb-ast2600_qemu |  13 +
 .../travis-ci/conf.integratorcp_cm926ejs_qemu |  27 ++
 test/hooks/bin/travis-ci/conf.malta64_qemu    |  30 ++
 test/hooks/bin/travis-ci/conf.malta64el_qemu  |  31 ++
 test/hooks/bin/travis-ci/conf.malta_qemu      |  30 ++
 test/hooks/bin/travis-ci/conf.maltael_qemu    |  31 ++
 test/hooks/bin/travis-ci/conf.qemu-ae3xx_na   |  27 ++
 .../hooks/bin/travis-ci/conf.qemu-arm-sbsa_na |  27 ++
 test/hooks/bin/travis-ci/conf.qemu-ax25_na    |  27 ++
 .../bin/travis-ci/conf.qemu-loongarch64_na    |  12 +
 test/hooks/bin/travis-ci/conf.qemu-ppce500_na |  27 ++
 test/hooks/bin/travis-ci/conf.qemu-riscv32_na |  11 +
 .../bin/travis-ci/conf.qemu-riscv32_spl_na    |  11 +
 test/hooks/bin/travis-ci/conf.qemu-riscv64_na |  11 +
 .../bin/travis-ci/conf.qemu-riscv64_spl_na    |  11 +
 test/hooks/bin/travis-ci/conf.qemu-x86_64_na  |  27 ++
 test/hooks/bin/travis-ci/conf.qemu-x86_na     |  27 ++
 .../bin/travis-ci/conf.qemu-xtensa-dc233c_na  |  12 +
 test/hooks/bin/travis-ci/conf.qemu_arm64_na   |  30 ++
 .../bin/travis-ci/conf.qemu_arm64_spl_na      |  32 ++
 .../bin/travis-ci/conf.qemu_arm64_tpl_na      |  29 ++
 test/hooks/bin/travis-ci/conf.qemu_arm64be_na |  13 +
 test/hooks/bin/travis-ci/conf.qemu_arm_na     |  30 ++
 test/hooks/bin/travis-ci/conf.qemu_arm_spl_na |  31 ++
 test/hooks/bin/travis-ci/conf.qemu_mips64_na  |  28 ++
 .../hooks/bin/travis-ci/conf.qemu_mips64el_na |  28 ++
 test/hooks/bin/travis-ci/conf.qemu_mips_na    |  28 ++
 test/hooks/bin/travis-ci/conf.qemu_mipsel_na  |  28 ++
 .../bin/travis-ci/conf.r2dplus_i82557c_qemu   |  27 ++
 .../bin/travis-ci/conf.r2dplus_pcnet_qemu     |  27 ++
 .../bin/travis-ci/conf.r2dplus_rtl8139_qemu   |  27 ++
 .../bin/travis-ci/conf.r2dplus_tulip_qemu     |  27 ++
 .../conf.sifive_unleashed_sdcard_qemu         |  11 +
 .../conf.sifive_unleashed_spi-nor_qemu        |  11 +
 .../bin/travis-ci/conf.vexpress_ca15_tc2_qemu |  27 ++
 .../bin/travis-ci/conf.vexpress_ca9x4_qemu    |  27 ++
 .../travis-ci/conf.vexpress_fvp_bloblist_na   |   1 +
 test/hooks/bin/travis-ci/conf.vexpress_fvp_na |  29 ++
 .../travis-ci/conf.xilinx_versal_virt_qemu    |  27 ++
 .../bin/travis-ci/conf.xilinx_zynq_virt_qemu  |  27 ++
 test/hooks/bin/travis-ci/conf.xtfpga_qemu     |  27 ++
 test/hooks/bin/travis-ci/conf.zynq_zc702_qemu |  27 ++
 test/hooks/bin/u-boot-test-common             |  36 +++
 test/hooks/bin/u-boot-test-console            |  25 ++
 test/hooks/bin/u-boot-test-flash              |  25 ++
 test/hooks/bin/u-boot-test-getrole            |  38 +++
 test/hooks/bin/u-boot-test-power-off          |  25 ++
 test/hooks/bin/u-boot-test-power-on           |  25 ++
 test/hooks/bin/u-boot-test-release            |  26 ++
 test/hooks/bin/u-boot-test-reset              |  25 ++
 test/hooks/bin/wait_raw_device                |  34 ++
 test/hooks/bin/writer.imx_raw                 |  39 +++
 test/hooks/bin/writer.labgrid-trini.rpi       |  46 +++
 test/hooks/bin/writer.labgrid-trini.ti-k3     |  35 ++
 test/hooks/bin/writer.rk3288_raw              |  40 +++
 test/hooks/bin/writer.rpi_mount               |  43 +++
 test/hooks/bin/writer.sunxi_raw               |  36 +++
 test/hooks/bin/writer.ti-k3_mount             |  36 +++
 test/hooks/bin/writer.ti-omap_mount           |  29 ++
 test/hooks/bin/writer.zynq_mount              |  36 +++
 test/hooks/contrib/src/.gitignore             |   1 +
 test/hooks/contrib/src/README.txt             |  13 +
 test/hooks/contrib/src/build.sh               |   7 +
 test/hooks/contrib/src/phidgets-relay.c       |  81 +++++
 .../contrib/udev/swarren-lx1/99-ubtest.rules  |  89 +++++
 .../OLI01/u_boot_boardenv_mx6qsabrelite_na.py |  39 +++
 .../konsulko-labgrid/u_boot_boardenv_rpi_4.py |   1 +
 .../u_boot_boardenv_rpi_arm64.py              |  84 +++++
 .../u_boot_boardenv_jetson_tk1_na.py          | 110 +++++++
 .../u_boot_boardenv_p2371_2180_na.py          | 110 +++++++
 .../u_boot_boardenv_p2771_0000_500_na.py      |  73 +++++
 test/hooks/py/travis-ci/travis_tftp.py        |  31 ++
 .../u_boot_boardenv_M5208EVBE_qemu.py         |   6 +
 .../u_boot_boardenv_evb_ast2500_qemu.py       |   5 +
 .../u_boot_boardenv_evb_ast2600_qemu.py       |   4 +
 .../travis-ci/u_boot_boardenv_malta64_qemu.py |   5 +
 .../u_boot_boardenv_malta64el_qemu.py         |   5 +
 .../travis-ci/u_boot_boardenv_malta_qemu.py   |   5 +
 .../travis-ci/u_boot_boardenv_maltael_qemu.py |   5 +
 .../u_boot_boardenv_qemu_ae3xx_na.py          |   6 +
 .../u_boot_boardenv_qemu_arm64_na.py          |  12 +
 .../u_boot_boardenv_qemu_arm64be_na.py        |  10 +
 .../travis-ci/u_boot_boardenv_qemu_arm_na.py  |  12 +
 .../travis-ci/u_boot_boardenv_qemu_ax25_na.py |   6 +
 .../u_boot_boardenv_qemu_loongarch64_na.py    |  11 +
 .../u_boot_boardenv_qemu_riscv32_na.py        |  10 +
 .../u_boot_boardenv_qemu_riscv32_spl_na.py    |  10 +
 .../u_boot_boardenv_qemu_riscv64_na.py        |  10 +
 .../u_boot_boardenv_qemu_riscv64_spl_na.py    |  10 +
 .../u_boot_boardenv_qemu_x86_64_na.py         |  12 +
 .../travis-ci/u_boot_boardenv_qemu_x86_na.py  |  12 +
 .../u_boot_boardenv_qemu_xtensa_dc233c_na.py  |   6 +
 .../u_boot_boardenv_r2dplus_i82557c_qemu.py   |   6 +
 .../u_boot_boardenv_r2dplus_pcnet_qemu.py     |   6 +
 .../u_boot_boardenv_r2dplus_rtl8139_qemu.py   |   6 +
 .../u_boot_boardenv_r2dplus_tulip_qemu.py     |   6 +
 ...t_boardenv_sifive_unleashed_sdcard_qemu.py |  10 +
 ..._boardenv_sifive_unleashed_spi_nor_qemu.py |  10 +
 .../u_boot_boardenv_vexpress_ca15_tc2_qemu.py |  10 +
 .../u_boot_boardenv_vexpress_ca9x4_qemu.py    |  10 +
 ...u_boot_boardenv_xilinx_versal_virt_qemu.py |   1 +
 .../u_boot_boardenv_xilinx_zynq_virt_qemu.py  |   3 +
 .../u_boot_boardenv_zynq_zc702_qemu.py        |   3 +
 199 files changed, 5340 insertions(+), 27 deletions(-)
 create mode 100644 doc/develop/test_hooks.rst
 create mode 100644 test/hooks/bin/OLI01/conf.mx6qsabrelite_na
 create mode 100644 test/hooks/bin/bill-the-cat/conf.integratorcp_cm926ejs_qemu
 create mode 100644 test/hooks/bin/bill-the-cat/conf.qemu_mips_na
 create mode 100644 test/hooks/bin/bill-the-cat/conf.vexpress_ca15_tc2_qemu
 create mode 100755 test/hooks/bin/common-config.cros-servo-dut-control
 create mode 100644 test/hooks/bin/common.labgrid-trini
 create mode 100644 test/hooks/bin/console.fvp
 create mode 100644 test/hooks/bin/console.labgrid-sjg
 create mode 100755 test/hooks/bin/console.labgrid-trini
 create mode 100644 test/hooks/bin/console.picocom
 create mode 100644 test/hooks/bin/console.qemu
 create mode 100644 test/hooks/bin/download.imx_usb
 create mode 100644 test/hooks/bin/download.l4t-exec-uboot
 create mode 100755 test/hooks/bin/download.tegra-uboot-flasher
 create mode 100755 test/hooks/bin/ellesmere/common-labgrid-sjg
 create mode 100644 test/hooks/bin/ellesmere/conf.all
 create mode 100644 test/hooks/bin/ellesmere/conf.evb-ast2500_qemu
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu-riscv32_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu-riscv32_spl_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu-riscv64_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu-x86_64_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu-x86_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm64_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm64_spl_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm_na
 create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm_spl_na
 create mode 100644 test/hooks/bin/flash.em100
 create mode 100644 test/hooks/bin/flash.fiptool
 create mode 100644 test/hooks/bin/flash.flashair
 create mode 100644 test/hooks/bin/flash.labgrid-trini.sd-mux
 create mode 100644 test/hooks/bin/flash.none
 create mode 100755 test/hooks/bin/flash.qemu_gen_padded_image
 create mode 100644 test/hooks/bin/flash.recovery_l4t
 create mode 100644 test/hooks/bin/flash.sdwire_common_mount
 create mode 100644 test/hooks/bin/flash.sdwire_digital-loggers_raw
 create mode 100644 test/hooks/bin/flash.sdwire_poweroff_mount
 create mode 100644 test/hooks/bin/flash.sdwire_poweroff_raw
 create mode 100644 test/hooks/bin/flash.sdwire_relay_mount
 create mode 100644 test/hooks/bin/flashair.rpi
 create mode 100644 test/hooks/bin/flashair.ti-omap
 create mode 100755 test/hooks/bin/getrole.labgrid-sjg
 create mode 100644 test/hooks/bin/kea/conf.Linksprite_pcDuino3_sjg-pcduino3
 create mode 100644 test/hooks/bin/kea/conf.chromebook_link_sjg-link
 create mode 100644 test/hooks/bin/kea/conf.chromebook_samus_sjg-samus
 create mode 100644 test/hooks/bin/kea/conf.jetson-tk1_sjg-tk1
 create mode 100644 test/hooks/bin/kea/conf.minnowmax_sjg-minnowmax
 create mode 100644 test/hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc
 create mode 100644 test/hooks/bin/kea/conf.rock2_sjg-rock2
 create mode 100644 test/hooks/bin/kea/conf.rpi_3_32b_sjg-rpi_3b
 create mode 100644 test/hooks/bin/kea/conf.rpi_3_sjg-rpi_3b
 create mode 100644 test/hooks/bin/kea/conf.zynq_zybo_sjg-zynq_zybo
 create mode 100644 test/hooks/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
 create mode 100644 test/hooks/bin/konsulko-labgrid/conf.am64x_evm_a53_na
 create mode 120000 test/hooks/bin/konsulko-labgrid/conf.rpi_4_32b_na
 create mode 120000 test/hooks/bin/konsulko-labgrid/conf.rpi_4_na
 create mode 100644 test/hooks/bin/konsulko-labgrid/conf.rpi_arm64_na
 create mode 100644 test/hooks/bin/poweroff.digital-loggers
 create mode 100644 test/hooks/bin/poweroff.manual
 create mode 100755 test/hooks/bin/poweroff.none
 create mode 100644 test/hooks/bin/poweroff.phidgets
 create mode 100644 test/hooks/bin/poweroff.pm342
 create mode 100644 test/hooks/bin/poweroff.ykush
 create mode 100644 test/hooks/bin/poweron.digital-loggers
 create mode 100644 test/hooks/bin/poweron.manual
 create mode 100755 test/hooks/bin/poweron.none
 create mode 100644 test/hooks/bin/poweron.phidgets
 create mode 100644 test/hooks/bin/poweron.pm342
 create mode 100644 test/hooks/bin/poweron.ykush
 create mode 100755 test/hooks/bin/push-flashair.py
 create mode 100755 test/hooks/bin/qemu.swtpm
 create mode 100644 test/hooks/bin/recovery.manual
 create mode 100644 test/hooks/bin/recovery.phidgets
 create mode 100644 test/hooks/bin/recovery.pm342
 create mode 100755 test/hooks/bin/recovery.relay
 create mode 100755 test/hooks/bin/recovery.usbrelay
 create mode 100644 test/hooks/bin/release.labgrid-sjg
 create mode 100644 test/hooks/bin/release.none
 create mode 100644 test/hooks/bin/reset.cros_servo
 create mode 100644 test/hooks/bin/reset.digital-loggers
 create mode 100755 test/hooks/bin/reset.labgrid-trini
 create mode 100644 test/hooks/bin/reset.none
 create mode 100644 test/hooks/bin/reset.pm342
 create mode 100644 test/hooks/bin/reset.recovery_download
 create mode 100644 test/hooks/bin/reset.usbrelay
 create mode 100644 test/hooks/bin/reset.ykush
 create mode 100644 test/hooks/bin/swarren-lx1/conf.jetson-tk1_na
 create mode 100644 test/hooks/bin/swarren-lx1/conf.p2371-2180_na
 create mode 100644 test/hooks/bin/swarren-lx1/conf.p2771-0000-500_na
 create mode 100644 test/hooks/bin/travis-ci/conf.M5208EVBE_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.coreboot_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.evb-ast2500_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.evb-ast2600_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.integratorcp_cm926ejs_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.malta64_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.malta64el_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.malta_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.maltael_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-ae3xx_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-arm-sbsa_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-ax25_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-loongarch64_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-ppce500_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv32_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv32_spl_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv64_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv64_spl_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-x86_64_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-x86_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu-xtensa-dc233c_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64_spl_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64_tpl_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64be_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm_spl_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mips64_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mips64el_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mips_na
 create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mipsel_na
 create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_i82557c_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_pcnet_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_rtl8139_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_tulip_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.vexpress_ca9x4_qemu
 create mode 120000 test/hooks/bin/travis-ci/conf.vexpress_fvp_bloblist_na
 create mode 100644 test/hooks/bin/travis-ci/conf.vexpress_fvp_na
 create mode 100644 test/hooks/bin/travis-ci/conf.xilinx_versal_virt_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.xilinx_zynq_virt_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.xtfpga_qemu
 create mode 100644 test/hooks/bin/travis-ci/conf.zynq_zc702_qemu
 create mode 100755 test/hooks/bin/u-boot-test-common
 create mode 100755 test/hooks/bin/u-boot-test-console
 create mode 100755 test/hooks/bin/u-boot-test-flash
 create mode 100755 test/hooks/bin/u-boot-test-getrole
 create mode 100755 test/hooks/bin/u-boot-test-power-off
 create mode 100755 test/hooks/bin/u-boot-test-power-on
 create mode 100755 test/hooks/bin/u-boot-test-release
 create mode 100755 test/hooks/bin/u-boot-test-reset
 create mode 100644 test/hooks/bin/wait_raw_device
 create mode 100755 test/hooks/bin/writer.imx_raw
 create mode 100644 test/hooks/bin/writer.labgrid-trini.rpi
 create mode 100644 test/hooks/bin/writer.labgrid-trini.ti-k3
 create mode 100755 test/hooks/bin/writer.rk3288_raw
 create mode 100755 test/hooks/bin/writer.rpi_mount
 create mode 100755 test/hooks/bin/writer.sunxi_raw
 create mode 100755 test/hooks/bin/writer.ti-k3_mount
 create mode 100755 test/hooks/bin/writer.ti-omap_mount
 create mode 100755 test/hooks/bin/writer.zynq_mount
 create mode 100644 test/hooks/contrib/src/.gitignore
 create mode 100644 test/hooks/contrib/src/README.txt
 create mode 100755 test/hooks/contrib/src/build.sh
 create mode 100644 test/hooks/contrib/src/phidgets-relay.c
 create mode 100644 test/hooks/contrib/udev/swarren-lx1/99-ubtest.rules
 create mode 100644 test/hooks/py/OLI01/u_boot_boardenv_mx6qsabrelite_na.py
 create mode 120000 test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py
 create mode 100644 test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py
 create mode 100644 test/hooks/py/swarren-lx1/u_boot_boardenv_jetson_tk1_na.py
 create mode 100644 test/hooks/py/swarren-lx1/u_boot_boardenv_p2371_2180_na.py
 create mode 100644 test/hooks/py/swarren-lx1/u_boot_boardenv_p2771_0000_500_na.py
 create mode 100644 test/hooks/py/travis-ci/travis_tftp.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2600_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_malta64_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_malta64el_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_malta_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_maltael_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_ae3xx_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_ax25_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_spl_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_spl_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_64_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_i82557c_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_pcnet_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_rtl8139_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_tulip_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_sdcard_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca15_tc2_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca9x4_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
 create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py

-- 
2.43.0

base-commit: 9b9647c89cbe785fd935f70e16d08cf9812b9fda
branch: tes
