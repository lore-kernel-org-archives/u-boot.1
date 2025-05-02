Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1C2C369DC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 02:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86FCF8059D;
	Fri,  2 May 2025 04:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDvq08B5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8FE801BE; Fri,  2 May 2025 04:50:55 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01E381F0B
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 04:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d93c060279so5833255ab.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 19:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746154242; x=1746759042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOcFOwCHXnDXK9hFSXZvrQzAeAZhrWJvuqJ+x01frs0=;
 b=VDvq08B5ogNDw/bovn279kmKzVL7RQFi9tOnb//glaQQYef4HhUQOeKh/cAkmj+fml
 Ssb/a1XFY9gLfDu8CqLsgVuSHsH/Wy8YP3IXPvvxVk6HhvusVk2sOMU1JgQbciFXb945
 gGDnazKVsCkPype5hhCMaiFsI/IXvot0YXCmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746154242; x=1746759042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOcFOwCHXnDXK9hFSXZvrQzAeAZhrWJvuqJ+x01frs0=;
 b=jY+kv+79GmbIKvykpW0GLVvGc9LntNxtTLjlv4WUh7g3AnaqI28b58mrIbo00iuEog
 FnptZzN38i5iqhlcUTNCn6sOgM7t5+E66Fy7wsGRvQfFlYZxMLiAzUKKrszUucW+jHqT
 qokZC4hC7JsScF9VURw34hyOEd8JKsGY6zfOzVpChja8v6rJODNRDQU1p3FF/nNCndpa
 fNVEGch5sOleFB6LpoIsGn8D/S17iRYsb6Gs2A88Co2IDpS8ucw75GNuwqTIRkqbmXo5
 Ap1W9q6OhDug21cbfoKdDU78j9Vdw9tdCJXJwrObbqh2m+SzSTP6xHcld2tb26hi+qj3
 TAkg==
X-Gm-Message-State: AOJu0YwXRUA4AeNQScC/XGSCJr1t/DdANOPLjPjUTSKfVb4qheo1cITU
 +bRY+ojKnjyWeZBcB42Kzngu9FEFfsQnGc2Xx60cmruo0GWgLhxMZVfytyfEvt4uMqufWQis1g4
 =
X-Gm-Gg: ASbGncu2A9TpQ8GvGNU4soN2d6OjMf+Kl36b4OUnt6KTIIEQH16+9uH0jtYgfQ9GIHP
 R2vEpxzDXm/ArB/7hSuTPp+NNvUzBLC49iKjzbmlz11zi63AIJGpScddlHmqV/9NUr9mxwpiZt9
 GJwx0jfNHPNLPU/Qzg9mqqhsMKOER4Rt0e+HX/7Bus5EWVCMB3LOrsIImeKicVf+VE0nFX3Abx3
 bBxNlbKHXXIamyYx5EVA8f31gr4zY6YEttSJOsiyPVqno4isGZqCDdH7U/m4mjZXs0/yUHaqSok
 7xcLb7GtARG/uWeSTx+iqu5TsIr566Wsf7uj6Jctx65DmJgsYUDVzB/TswwgbKieI15FId7KWgQ
 E9g==
X-Google-Smtp-Source: AGHT+IH1STMNU62nGQKJiv/0oJefrERn4ctkOGb7fyY8mkDuIlHB/vTx1xN9wxiU4/34WoCZmlQAgA==
X-Received: by 2002:a05:6e02:1c22:b0:3d8:18d4:7bce with SMTP id
 e9e14a558f8ab-3d97c12a21fmr15139275ab.2.1746154239121; 
 Thu, 01 May 2025 19:50:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a918039sm166627173.55.2025.05.01.19.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 19:50:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] test: Bring in the test hooks
Date: Thu,  1 May 2025 20:50:17 -0600
Message-ID: <20250502025026.4140184-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502025026.4140184-1-sjg@chromium.org>
References: <20250502025026.4140184-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 May 2025 04:51:26 +0200
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

Bring these in from u-boot-test-hooks commit a7bd2dc

A few changes are included:

- directory permission set to 755
- Contributing.md is dropped since it is no-longer relevant
- the 'src' and 'udev' directories are now inside a 'contrib' directory,
  since they are really just examples.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/hooks/README.md                          | 296 ++++++++++++++++++
 test/hooks/bin/OLI01/conf.mx6qsabrelite_na    |  26 ++
 .../conf.integratorcp_cm926ejs_qemu           |  27 ++
 test/hooks/bin/bill-the-cat/conf.qemu_mips_na |  28 ++
 .../bill-the-cat/conf.vexpress_ca15_tc2_qemu  |  27 ++
 .../bin/common-config.cros-servo-dut-control  |  69 ++++
 test/hooks/bin/common.labgrid-trini           |  35 +++
 test/hooks/bin/console.fvp                    |  28 ++
 test/hooks/bin/console.labgrid-sjg            |  42 +++
 test/hooks/bin/console.labgrid-trini          |  24 ++
 test/hooks/bin/console.picocom                |  42 +++
 test/hooks/bin/console.qemu                   |  35 +++
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
 .../hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc |  35 +++
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
 test/hooks/bin/writer.labgrid-trini.ti-k3     |  35 +++
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
 .../contrib/udev/swarren-lx1/99-ubtest.rules  |  89 ++++++
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
 195 files changed, 5303 insertions(+)
 create mode 100644 test/hooks/README.md
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

diff --git a/test/hooks/README.md b/test/hooks/README.md
new file mode 100644
index 00000000000..ecf8a46c4a5
--- /dev/null
+++ b/test/hooks/README.md
@@ -0,0 +1,296 @@
+# Introduction
+
+This repository contains working example support ("hook") scripts for U-Boot's
+built-in test framework. That framework is located in the `test/py/` directory
+in the U-Boot source tree.
+
+You may use these examples as a reference when creating your own hook scripts,
+or even derive your own scripts directly from the files in this repository.
+
+# Contributing
+
+See [Contributing.md](Contributing.md).
+
+# Flashing Philosophy
+
+U-Boot may be installed onto a target device either by:
+
+- Writing the U-Boot binary to flash, so that it runs at every cold boot or
+  reset. In this case, flashing is a one-time operation.
+
+- Downloading U-Boot into RAM whenever it needs to RAM. In this case, the
+  download needs to happen every time the target board is reset, since the
+  desired binary is not permanently stored on the system.
+
+The example scripts in this repository take the second approach. This approach
+avoids modifying the device's flash memory for each U-Boot binary to be tested,
+which should increase longevity of the device. This does mean that the
+implementation of the `test/py/` hook scripts is slightly inconsistent with
+their naming; `u-boot-test-flash` does nothing whereas `u-boot-test-reset`
+downloads U-Boot into RAM rather than only performing a simple system reset.
+
+# USB Port Paths
+
+When multiple USB devices of the same type are attached to the same system, some
+mechanism for differentiating between them is required, in order for software to
+choose which device to communicate with. In some cases, the only available
+mechanism is based on the physical USB port to which the device is attached. For
+this mechanism to work, there must be a stable way to uniquely name each
+physical USB port. The naming convention is known as the USB port path.
+
+Each USB bus in the system is assigned a unique number by the Linux kernel.
+These numbers are typically stable across reboots since they are assigned based
+on device creation or probing order, which is usually driven by stable
+BIOS-driven data structures. Changes to system hardware can cause these numbers
+to change though. Equally, it's a good idea to validate the bus numbers after
+reboot. The USB bus number forms the first part of the USB port path.
+
+Each USB controller or hub contains a number of physical USB ports (sockets).
+Each of these has a unique fixed number, per the USB specification. These port
+numbers form the balance of the USB port path.
+
+Linux uses the format `${bus}-${port}.${port}.${port}...` to represent the USB
+port path.
+
+For example:
+
+    +--------------+
+    | PC           |
+    | +----------+ |
+    | | USB ctlr | |
+    | | Bus 4    | |       +----------+
+    | |   Port 1 |---------| USB hub  |
+    | +----------+ |       |   Port 1 |     +-----------------+
+    +--------------+       |   Port 2------ | USB device      |
+                           |   Port 3 |     | Port path 4-1.2 |
+                           +----------+     | Bus/device 4/15 |
+                                            +-----------------+
+
+Note that USB device numbers are not stable; they change each time a device
+appears on the bus, such as when it is power cycled or reset.
+
+To determine the USB port path of your device, first manually identify a device
+node related to your USB device. For example, you might run `lsusb` with the
+device both unplugged and plugged in, find the device's bus and device number,
+and then use device file `/dev/bus/usb/${busnum}/${devnum}`. Alternatively, you
+may find some type-specific device node such as `/dev/ttyUSB2` or `/dev/sdc` by
+experimentation using tools such as `picocom` or `mount` and `ls`.
+
+Once a device node has been identified, use udevadm to query all known
+information about the device, then find an entry with `SUBSYSTEMS=="usb"` and a
+`KERNELS` value in the format of a USB port path:
+
+    $ udevadm info -a /dev/ttyUSB2
+    ...
+    looking at device '/devices/pci0000:00/0000:00:14.0/usb3/3-6/3-6:1.2/ttyUSB2/tty/ttyUSB2':
+        KERNEL=="ttyUSB2"
+        SUBSYSTEM=="tty"
+        DRIVER==""
+
+    looking at parent device '/devices/pci0000:00/0000:00:14.0/usb3/3-6/3-6:1.2/ttyUSB2':
+        KERNELS=="ttyUSB2"
+        SUBSYSTEMS=="usb-serial"
+        DRIVERS=="ftdi_sio"
+    ...
+    looking at parent device '/devices/pci0000:00/0000:00:14.0/usb3/3-6/3-6:1.2':
+        KERNELS=="3-6:1.2"
+        SUBSYSTEMS=="usb"
+        DRIVERS=="ftdi_sio"
+    ...
+    looking at parent device '/devices/pci0000:00/0000:00:14.0/usb3/3-6':
+        KERNELS=="3-6"
+        SUBSYSTEMS=="usb"
+        DRIVERS=="usb"
+    ...
+    looking at parent device '/devices/pci0000:00/0000:00:14.0/usb3':
+        KERNELS=="usb3"
+        SUBSYSTEMS=="usb"
+        DRIVERS=="usb"
+
+Here, the USB port path is "`3-6`".
+
+or:
+
+    $ udevadm info -a /dev/bus/usb/003/086
+    ....
+    looking at device '/devices/pci0000:00/0000:00:14.0/usb3/3-10/3-10.4':
+        KERNEL=="3-10.4"
+        SUBSYSTEM=="usb"
+        DRIVER=="usb"
+
+Here, the USB port path is "`3-10.4`".
+
+# udev Rules
+
+See the `udev/` directory in this repository.
+
+Testing should be performed as a non-root user. This requires that the relevant
+device nodes have non-default permissions. udev rules may be used to achieve
+this.
+
+To save hardware, it is possible to attach multiple Tegra devices to a single
+host machine. This requires that each program that interacts with the device be
+able to communicate with a specific Tegra device.
+
+Some applications allow the USB port path be passed to them as a parameter. This
+requires no configuration via udev.
+
+Some applications use device-specific properties to identify devices, such as
+the serial number encoded into a USB device descriptor. This requires no
+configuration via udev.
+
+Other applications allow a USB device filename to be passed in. udev rules may
+be used to create well-known device filenames based on a device's USB port
+path.
+
+The example udev rules demonstrate both of these types of rules.
+
+# Scripts and Binaries
+
+See the `bin/` directory in this repository.
+
+Scripts exist to power on, power off, flash, and reset Tegra boards, and access
+their serial console. The U-Boot test framework expects these scripts to exist
+in `$PATH`, and executes them at appropriate times.
+
+Note that the test framework itself does not use the power on/off scripts.
+However, they may be used by a companion continuous integration framework that
+triggers the U-Boot test framework. For example,
+https://github.com/swarren/u-boot-ci-scripts.
+
+U-Boot's test framework identifies each board by type (e.g. p2371-2180; the
+engineering name for Jetson TX1) and identity (an arbitrary user-assigned string
+used to differentiate multiple instances of the same board type within a user's
+testing setup). Each script is passed these two parameters to inform it which
+board to operate upon.
+
+Different test setups will use different techniques to control target hardware.
+For example, reset and forced recovery signals may be manipulated through
+NVIDIA's proprietary PM342 debug board, or some form of relay or electronic
+switch board hard-wired to the board's physical buttons.
+
+The scripts are written to be highly generic, and allow sharing of code between
+boards. To this end, the top-level implementation of each script does little
+more than include a board-specific configuration file, and then include another
+file specific to implementation the desired action.
+
+Board configuration files are located in
+`bin/${hostname}/conf.${board_type}_${board_identity}`. These files are
+segregated by hostname so that the repository can be used directly across
+multiple different test machines, without the need for host-specific branches or
+post-checkout configuration.
+
+The board configuration file defines which mechanism is used for each possible
+action, and any parameters associated with it. For example, downloading U-Boot
+into RAM may used either the `tegra-uboot-flasher` tool for boards containing
+T124 or earlier, or L4T's `exec-uboot.sh` for boards containing T210 or newer.
+These scripts. In each case, the directory name where the tool is installed must
+be defined.
+
+Each action is implemented in a script fragment directly in the `bin/` directory,
+with filename `${action_type}.${implementation_name}`.
+
+If using these scripts directly for testing Tegra devices, it is likely that
+you will not need to create new `download.*` implementations, but will need to
+create new `poweroff.*`, `poweron.*`, and `recovery.*` implementations.
+
+Observe that some external tools (`download.*` especially) invoked by these
+scripts must be replicated once per board instance, or their actions somehow
+serialized, since they copy files into their own directories when executing, and
+hence parallel execution would cause incorrect operation.
+
+## Labgrid Integration
+
+Labgrid is a python library for embedded-board-control. It includes a client
+program which is used to integrate with the U-Boot pytests.
+
+Since Labgrid has all the information necessary to build and boot on a lab,
+there is no per-board configuration required. The various flash.xxx and
+recovery.xxx scripts are not used. To set it up, one implementation is:
+
+- In your bin/$hostname directory, create an executable file
+  `common-labgrid-sjg` and set your crossbar and environment information, for
+  example:
+
+      # Hostname and port for the gRPC coordinator
+      export LG_COORDINATOR=kea:20408
+
+      # Environment file for the lab
+      export LG_ENV="/path/to/kea_env.cfg"
+
+      # Location of the U-Boot test hooks
+      export UB_TEST_HOOKS=/path/to/u-boot-test-hooks
+
+      # Make sure only one buildman can run at a time, since it uses all CPUs
+      export BUILDMAN_PROCESS_LIMIT=1
+
+      # Use the internal console since microcom can miss serial input at boot
+      export LG_CONSOLE="internal"
+
+      # Tell u-boot-test-hooks to use the Labgrid-sjg integration
+      export USE_LABGRID_SJG=1
+
+      flash_impl=none
+      reset_impl=none
+      console_impl=labgrid-sjg
+      release_impl=labgrid-sjg
+      getrole_impl=labgrid-sjg
+      power_impl=none
+
+The last 6 lines tell the hooks to use Labgrid for console and board release
+as well as a new 'getrole' hook which is only used by Labgrid. The flash, reset
+and power features of boards are all handled by entirely by Labgrid.
+
+Then create another executable file (in the same directory) called 'conf.all',
+containing::
+
+    .. code-block:: bash
+
+    . "${bin_dir}/${hostname}/common-labgrid-sjg"
+
+That should be all that is needed.
+
+An alternate implementation requires setting the following environment
+variables must be set as per your lab:
+
+- `LG_CROSSBAR` must point at the crossbar service.
+- `LG_PLACE` must point at the device under test.
+- `LG_ENV` must point at the labgrid yaml file that describes your lab.
+
+In order for a given platform to be tested, it must be acquired before starting
+tests and then released once complete. See the bin/konsulko-labgrid directory
+for example boards using this method.
+
+## Dependencies
+
+The example scripts depend on various external tools, the installation location
+of which must be specified in the board configuration files:
+
+- `tegra-uboot-flasher`; see
+  https://github.com/NVIDIA/tegra-uboot-flasher-scripts.
+- L4T's flashing tools. This must be a regular L4T host-side installation,
+  possibly stripped down to contain just:
+  - The top-level directory (which contains `flash.sh` and `*.conf`).
+  - The `bootloader/` directory.
+  - The `kernel/` directory.
+- `imx_usb`; see
+  https://github.com/boundarydevices/imx_usb_loader.
+- As-yet-unpublished scripts to control various USB relay boards.
+
+U-Boot's test framework also requires a `dfu-util` that supports the -p
+command-line option. Most distros provide this nowadays.
+
+# Python Modules
+
+See the `py/` directory in this repository.
+
+A Python module exists for each board and defines numerous parameters used by
+the U-Boot test framework. The framework expects to simply import these modules
+directly, and hence they must be locatable within `$PYTHONPATH`.
+
+These modules are again located in a separate directory for each host, so that
+the repository may be shared across hosts.
+
+For complete details re: the required content of these Python modules, please
+see `test/py/README.md` in the U-boot source tree, and also the comments in some
+individual test files in `test/py/tests/test_*.py`.
diff --git a/test/hooks/bin/OLI01/conf.mx6qsabrelite_na b/test/hooks/bin/OLI01/conf.mx6qsabrelite_na
new file mode 100644
index 00000000000..8f29cb59e9c
--- /dev/null
+++ b/test/hooks/bin/OLI01/conf.mx6qsabrelite_na
@@ -0,0 +1,26 @@
+# Copyright (c) 2016, Guillaume GARDET. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyUSB0
+power_impl=manual
+flash_impl=none
+reset_impl=recovery_download
+recovery_impl=manual
+download_impl=imx_usb
diff --git a/test/hooks/bin/bill-the-cat/conf.integratorcp_cm926ejs_qemu b/test/hooks/bin/bill-the-cat/conf.integratorcp_cm926ejs_qemu
new file mode 100644
index 00000000000..d6e2f19b9e0
--- /dev/null
+++ b/test/hooks/bin/bill-the-cat/conf.integratorcp_cm926ejs_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="integratorcp"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/bill-the-cat/conf.qemu_mips_na b/test/hooks/bin/bill-the-cat/conf.qemu_mips_na
new file mode 100644
index 00000000000..7a0ea036910
--- /dev/null
+++ b/test/hooks/bin/bill-the-cat/conf.qemu_mips_na
@@ -0,0 +1,28 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="mips"
+qemu_binary="qemu-system-mips"
+qemu_extra_args="-nographic -monitor null"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash,format=raw"
+qemu_helper_script="qemu-mips"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/bill-the-cat/conf.vexpress_ca15_tc2_qemu b/test/hooks/bin/bill-the-cat/conf.vexpress_ca15_tc2_qemu
new file mode 100644
index 00000000000..070b78b0741
--- /dev/null
+++ b/test/hooks/bin/bill-the-cat/conf.vexpress_ca15_tc2_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="vexpress-a15"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -m 1G"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/common-config.cros-servo-dut-control b/test/hooks/bin/common-config.cros-servo-dut-control
new file mode 100755
index 00000000000..70826e1b6f1
--- /dev/null
+++ b/test/hooks/bin/common-config.cros-servo-dut-control
@@ -0,0 +1,69 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# This can be included by config files to set the cros_servo_port and
+# console_dev variables.
+
+# It requires:
+# - standalone-hdctools to be installed at the same level as u-boot-test-hooks
+#     (i.e. at /path/to/u-boot-test-hooks/../standalone-hdctools)
+# - a servo board connected. Servo is used to control resetting the board and to
+#     access the serial console
+# - a servodrc also at the directory above u-boot-test-hooks (see sample below)
+# - 'servo_name' variable set to the board name, before including this script
+
+# Install hdctools here
+# https://chromium.googlesource.com/a/chromiumos/platform/standalone-hdctools
+
+# Information on servo here:
+# https://chromium.googlesource.com/chromiumos/third_party/hdctools/+/refs/heads/master/README.md
+
+# the ubtest directory holds u-boot-test-hooks and other things
+UBTEST_DIR="$(dirname "$(dirname "$(dirname "${BASH_SOURCE[0]}")")")"
+RCFILE="${UBTEST_DIR}/servodrc"
+DUT_CONTROL="${UBTEST_DIR}/standalone-hdctools/dut-control"
+
+# Look up the servo_name and get the port number
+cros_servo_port="$(grep ^${cros_servo_name}, ${RCFILE} |cut -f3 -d,)"
+if [ -z "${cros_servo_port}" ]; then
+    echo "Failed to find servo port for ${cros_servo_name}"
+    exit 1
+fi
+
+# Find the console
+console_dev="$(${DUT_CONTROL} -p ${cros_servo_port} cpu_uart_pty |cut -f2 -d:)"
+if [ -z "${console_dev}" ]; then
+    echo "Failed to find console for ${cros_servo_name}"
+    exit 1
+fi
+
+
+# Here is a sample servodrc
+# This file describes servo boards connected to this host.
+#
+# Line text starting with # to end of line is ignored, as well as empy lines.
+#
+# Configuration lines consist of up to 4 comma separated fields, the last
+# two are optional:
+#
+# name serial-number port-number board
+#
+# Remove the # from the next line
+# link, 905537-00223, 9902, link
diff --git a/test/hooks/bin/common.labgrid-trini b/test/hooks/bin/common.labgrid-trini
new file mode 100644
index 00000000000..e07107462a5
--- /dev/null
+++ b/test/hooks/bin/common.labgrid-trini
@@ -0,0 +1,35 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+if [ -z "${LG_CROSSBAR}" ]; then
+	echo "LG_CROSSBAR is unset";
+	exit 1;
+fi
+
+if [ -z "${LG_PLACE}" ]; then
+	echo "LG_PLACE is unset";
+	exit 1;
+fi
+
+if [ -z "${LG_ENV}" ]; then
+	echo "LG_ENV is unset";
+	exit 1;
+fi
diff --git a/test/hooks/bin/console.fvp b/test/hooks/bin/console.fvp
new file mode 100644
index 00000000000..eacae7d107d
--- /dev/null
+++ b/test/hooks/bin/console.fvp
@@ -0,0 +1,28 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# We must be passed the arguments to pass to FVP
+ARGS="${fvp_args}"
+
+"${fvp_binary}" ${ARGS} &
+
+# We need to wait for FVP to have spawned itself before launching telnet
+sleep 1
+exec telnet localhost 5000
diff --git a/test/hooks/bin/console.labgrid-sjg b/test/hooks/bin/console.labgrid-sjg
new file mode 100644
index 00000000000..85e7da54373
--- /dev/null
+++ b/test/hooks/bin/console.labgrid-sjg
@@ -0,0 +1,42 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# The variables here can come from one of two places:
+#
+# 1. When using the ub-xxx scripts (e.g. ub-int) they come from those scripts,
+#    set by the get_args.sh script
+#
+# 2. When running from gitlab, the variables are all empty and so take the
+#    default values below, except for ${strategy} which is set in the gitlab
+#    script
+
+# On input:
+# strategy: Strategy arguments to use, e.g. "-s start". Normally this is
+# "-s uboot -e off" but it can be "-s start -e off" or even empty
+# verbose: Verbose argument to use, e.g. "-v"
+#
+# These variables are set by .gitlab-ci.yml or by
+
+exec labgrid-client -V do-bootstrap ${bootstrap:-1} -V do-build ${build:-1} \
+    -V do-send ${send:-0} -V do-clean ${clean:-0} \
+    -V process-limit ${BUILDMAN_PROCESS_LIMIT:-0} \
+    -r "${U_BOOT_BOARD_IDENTITY}" ${strategy} ${verbose} -a console \
+    ${console_log}
diff --git a/test/hooks/bin/console.labgrid-trini b/test/hooks/bin/console.labgrid-trini
new file mode 100755
index 00000000000..a2678cc6050
--- /dev/null
+++ b/test/hooks/bin/console.labgrid-trini
@@ -0,0 +1,24 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+. common.labgrid-trini
+
+exec labgrid-client console
diff --git a/test/hooks/bin/console.picocom b/test/hooks/bin/console.picocom
new file mode 100644
index 00000000000..5960e9f2aa0
--- /dev/null
+++ b/test/hooks/bin/console.picocom
@@ -0,0 +1,42 @@
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+if [ -z "${console_baud}" ]; then
+    console_baud=115200
+fi
+
+# Some boards have a UART built into them and it doesn't appear until the
+# board is powered on. An example is zynq_zybo. Try to handle this by waiting
+# for the console and then continuing as soon as possible (so we don't miss
+# the U-Boot banner).
+if [ -n "${console_wait}" ]; then
+    for i in {0..99}; do
+        if [ -e "${console_dev}" ]; then
+            break
+        fi
+        sleep .1
+    done
+    if [ ! -e "${console_dev}" ]; then
+        echo "Console ${console_dev} not found"
+        exit 1
+    fi
+fi
+
+exec picocom -b "${console_baud}" "${console_dev}"
diff --git a/test/hooks/bin/console.qemu b/test/hooks/bin/console.qemu
new file mode 100644
index 00000000000..14650a2df59
--- /dev/null
+++ b/test/hooks/bin/console.qemu
@@ -0,0 +1,35 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+ARGS=""
+if [ ! -z "${qemu_extra_args}" ]; then
+  ARGS+="${qemu_extra_args} "
+fi
+
+# We must have these arguments
+ARGS+="-M ${qemu_machine}"
+ARGS+=" ${qemu_kernel_args}"
+
+# If we have a helper script to run, run it.
+if [ ! -z "${qemu_helper_script}" ]; then
+  . "${bin_dir}/qemu.${qemu_helper_script}"
+fi
+
+exec "${qemu_binary}" ${ARGS}
diff --git a/test/hooks/bin/download.imx_usb b/test/hooks/bin/download.imx_usb
new file mode 100644
index 00000000000..06522f1c792
--- /dev/null
+++ b/test/hooks/bin/download.imx_usb
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+# Copyright (c) 2016, Guillaume GARDET. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+sudo imx_usb -v ${U_BOOT_BUILD_DIR}/u-boot.imx
diff --git a/test/hooks/bin/download.l4t-exec-uboot b/test/hooks/bin/download.l4t-exec-uboot
new file mode 100644
index 00000000000..d5ccb979d77
--- /dev/null
+++ b/test/hooks/bin/download.l4t-exec-uboot
@@ -0,0 +1,25 @@
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+link=`readlink "${board_usb_dev}"`
+instance=`echo "${link}" | sed -e "s@bus/usb@@"`
+
+cp "${U_BOOT_BUILD_DIR}"/u-boot{,.bin,.dtb,-dtb.bin} "${download_l4t}/bootloader/t210ref/${board_type}/"
+sudo "${download_l4t}/bootloader/exec-uboot.sh" --instance "${instance}" "${board_type}"
diff --git a/test/hooks/bin/download.tegra-uboot-flasher b/test/hooks/bin/download.tegra-uboot-flasher
new file mode 100755
index 00000000000..53f790e17d9
--- /dev/null
+++ b/test/hooks/bin/download.tegra-uboot-flasher
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+"${tubf_bin}/build" --boards "${tubf_board}" import-uboot "${U_BOOT_BUILD_DIR}"
+"${tubf_bin}/tegra-uboot-flasher" exec --usb-port-path "${board_usb_port_path}" "${tubf_config}"
diff --git a/test/hooks/bin/ellesmere/common-labgrid-sjg b/test/hooks/bin/ellesmere/common-labgrid-sjg
new file mode 100755
index 00000000000..6b3eff5f277
--- /dev/null
+++ b/test/hooks/bin/ellesmere/common-labgrid-sjg
@@ -0,0 +1,46 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Hostname and port for the gRPC coordinator
+export LG_COORDINATOR=kea:20408
+
+# Environment file for the lab
+export LG_ENV=/vid/software/devel/ubtest/lab/cfg/kea_env.cfg
+
+# Make sure only one buildman can run at a time, since it uses all CPUs
+export BUILDMAN_PROCESS_LIMIT=1
+
+# Location of the U-Boot test hooks
+export UB_TEST_HOOKS=/vid/software/devel/ubtest/u-boot-test-hooks
+
+# Use the internal console since microcom can miss serial input at boot
+export LG_CONSOLE=internal
+
+# Tell u-boot-test-hooks to use the Labgrid integration
+export USE_LABGRID_SJG=1
+
+
+flash_impl=none
+reset_impl=none
+console_impl=labgrid-sjg
+release_impl=labgrid-sjg
+getrole_impl=labgrid-sjg
+power_impl=none
diff --git a/test/hooks/bin/ellesmere/conf.all b/test/hooks/bin/ellesmere/conf.all
new file mode 100644
index 00000000000..4a82ee7b30f
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.all
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "${bin_dir}/${hostname}/common-labgrid-sjg"
diff --git a/test/hooks/bin/ellesmere/conf.evb-ast2500_qemu b/test/hooks/bin/ellesmere/conf.evb-ast2500_qemu
new file mode 100644
index 00000000000..7f0f3c56e00
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.evb-ast2500_qemu
@@ -0,0 +1,11 @@
+# Copyright 2019 IBM Corp.
+# Joel Stanley <joel@jms.id.au>
+# SPDX-License-Identifier: GPL-2.0+
+
+console_impl=qemu
+qemu_machine="ast2500-evb"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -m 512M -serial mon:stdio -net nic,model=ftgmac100 -net user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR}"
+qemu_kernel_args="-drive file=${U_BOOT_BUILD_DIR}/flash.img,format=raw,if=mtd"
+reset_impl=none
+flash_impl=qemu_gen_padded_image
diff --git a/test/hooks/bin/ellesmere/conf.qemu-riscv32_na b/test/hooks/bin/ellesmere/conf.qemu-riscv32_na
new file mode 120000
index 00000000000..0646dbcd185
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu-riscv32_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-riscv32_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu-riscv32_spl_na b/test/hooks/bin/ellesmere/conf.qemu-riscv32_spl_na
new file mode 120000
index 00000000000..ceda23fa712
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu-riscv32_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-riscv32_spl_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu-riscv64_na b/test/hooks/bin/ellesmere/conf.qemu-riscv64_na
new file mode 120000
index 00000000000..085574b9eac
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu-riscv64_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-riscv64_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu-x86_64_na b/test/hooks/bin/ellesmere/conf.qemu-x86_64_na
new file mode 120000
index 00000000000..3a1470e9d89
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu-x86_64_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-x86_64_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu-x86_na b/test/hooks/bin/ellesmere/conf.qemu-x86_na
new file mode 120000
index 00000000000..f6e7e5a764e
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu-x86_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-x86_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu_arm64_na b/test/hooks/bin/ellesmere/conf.qemu_arm64_na
new file mode 120000
index 00000000000..cf56db1ebf3
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu_arm64_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu_arm64_spl_na b/test/hooks/bin/ellesmere/conf.qemu_arm64_spl_na
new file mode 120000
index 00000000000..abbbc0247a3
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu_arm64_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64_spl_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu_arm_na b/test/hooks/bin/ellesmere/conf.qemu_arm_na
new file mode 120000
index 00000000000..aa91a9ff653
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu_arm_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm_na
\ No newline at end of file
diff --git a/test/hooks/bin/ellesmere/conf.qemu_arm_spl_na b/test/hooks/bin/ellesmere/conf.qemu_arm_spl_na
new file mode 120000
index 00000000000..e171c5a98d0
--- /dev/null
+++ b/test/hooks/bin/ellesmere/conf.qemu_arm_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm_spl_na
\ No newline at end of file
diff --git a/test/hooks/bin/flash.em100 b/test/hooks/bin/flash.em100
new file mode 100644
index 00000000000..17ab18875e0
--- /dev/null
+++ b/test/hooks/bin/flash.em100
@@ -0,0 +1,30 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Designed for using a Dediprog EM100Pro or Pro-G2 SPI-flash emulator
+# https://www.dediprog.com/product/EM100Pro-G2
+# (the older EM100Pro works but is not listed anymore)
+
+# It requires these tools:
+# em100 at https://review.coreboot.org/cgit/em100.git
+# Instructions at https://www.coreboot.org/EM100pro
+
+em100 -x "${em100_serial}" -s -p LOW -d "${U_BOOT_BUILD_DIR}/u-boot.rom" \
+    -c "${em100_chip}" -r
diff --git a/test/hooks/bin/flash.fiptool b/test/hooks/bin/flash.fiptool
new file mode 100644
index 00000000000..23014f2bbe8
--- /dev/null
+++ b/test/hooks/bin/flash.fiptool
@@ -0,0 +1,22 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Call fiptool to update an existing fip.bin file
+fiptool update --nt-fw="${U_BOOT_BUILD_DIR}/u-boot.bin" ${fip}
diff --git a/test/hooks/bin/flash.flashair b/test/hooks/bin/flash.flashair
new file mode 100644
index 00000000000..8cedbb87a90
--- /dev/null
+++ b/test/hooks/bin/flash.flashair
@@ -0,0 +1,45 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Make sure that the card is available to us now.
+while true; do
+    ping -c 1 ${flashair_ip} >/dev/null 2>&1
+    if [ $? -eq 0 ]; then
+        break;
+    fi
+done
+
+# Make our new holding space.
+UL_DIR=`mktemp -d`
+
+# Run this script to copy files as they must appear on the target into
+# the given directory.
+. "${bin_dir}/${flashair_copy_script}"
+
+# Collect all arguments
+ARGS=()
+if [ ! -z "${flashair_rmlist}" ]; then
+  ARGS+=("rmlist:${flashair_rmlist}")
+fi
+
+ARGS+=("push:${UL_DIR}")
+push-flashair.py ${flashair_ip} "${ARGS[@]}"
+
+rm -rf "${UL_DIR}" "${flashair_rmlist}"
diff --git a/test/hooks/bin/flash.labgrid-trini.sd-mux b/test/hooks/bin/flash.labgrid-trini.sd-mux
new file mode 100644
index 00000000000..a9648dc1dad
--- /dev/null
+++ b/test/hooks/bin/flash.labgrid-trini.sd-mux
@@ -0,0 +1,31 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+. common.labgrid-trini
+
+echo "switching sd-mux to host"
+labgrid-client sd-mux host
+#let mmc have some time to initialize to be available for udisks
+sleep 1
+. writer.${flash_writer}
+
+echo "switching sd-mux to dut"
+labgrid-client sd-mux dut
diff --git a/test/hooks/bin/flash.none b/test/hooks/bin/flash.none
new file mode 100644
index 00000000000..4c3b1b53c33
--- /dev/null
+++ b/test/hooks/bin/flash.none
@@ -0,0 +1,21 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# No flashing needed
diff --git a/test/hooks/bin/flash.qemu_gen_padded_image b/test/hooks/bin/flash.qemu_gen_padded_image
new file mode 100755
index 00000000000..3b413fecdc8
--- /dev/null
+++ b/test/hooks/bin/flash.qemu_gen_padded_image
@@ -0,0 +1,15 @@
+# Copyright 2019 IBM Corp.
+# Joel Stanley <joel@jms.id.au>
+# SPDX-License-Identifier: GPL-2.0+
+
+# TODO: Work out a better temp directory
+FLASH_IMG="${U_BOOT_BUILD_DIR}"/flash.img
+
+# Allow custom flash image size
+FLASH_SIZE="${flash_size:=32}"
+
+# Allow custom U-Boot binaries
+U_BOOT_BIN="${flash_u_boot_bin:=u-boot.bin}"
+
+dd if=/dev/zero of="${FLASH_IMG}" count="${FLASH_SIZE}" bs=1M
+dd if="${U_BOOT_BUILD_DIR}/${U_BOOT_BIN}" of="${FLASH_IMG}" conv=notrunc
diff --git a/test/hooks/bin/flash.recovery_l4t b/test/hooks/bin/flash.recovery_l4t
new file mode 100644
index 00000000000..0c4bd0d0f3a
--- /dev/null
+++ b/test/hooks/bin/flash.recovery_l4t
@@ -0,0 +1,44 @@
+# Copyright (c) 2015-2018, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "${bin_dir}/recovery.${recovery_impl}"
+
+# USB enumeration delay
+for ((i = 0; i <= 100; i++)); do
+    if [ -e "${board_usb_dev}" ]; then
+        break
+    fi
+    sleep 0.1
+done
+sleep 1
+
+cp "${U_BOOT_BUILD_DIR}"/u-boot-dtb.bin "${flash_l4t}/${flash_l4t_uboot_path}/u-boot.bin"
+# FIXME: To speed things up here, we could add "-k kernel" and just reflash the
+# "kernel" partition (which holds U-Boot when it's in use). However, this
+# relies on having the right L4T already flashed, which isn't likely on my
+# system since I use the board for other things.
+(cd "${flash_l4t}" && sudo "${flash_l4t}/flash.sh" --usb-instance "${board_usb_port_path}" -r "${flash_l4t_board}" mmcblk0p1)
+# Prevent the system from booting before the reset script is run. Otherwise,
+# either (a) the test system won't capture the start of the UART log, or (b)
+# U-Boot will start running early, and the test system will start capturing
+# part way through boot, and see extra copies of all the U-Boot messages, and
+# hence fail the boot test. Ideally, flash.sh wouldn't auto-reset/boot the
+# system.
+. "${bin_dir}/recovery.${recovery_impl}"
diff --git a/test/hooks/bin/flash.sdwire_common_mount b/test/hooks/bin/flash.sdwire_common_mount
new file mode 100644
index 00000000000..b76add064fb
--- /dev/null
+++ b/test/hooks/bin/flash.sdwire_common_mount
@@ -0,0 +1,80 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Handles the common SDwire mounting (caller does power control)
+
+mount_dir=/media/${mount_point}
+
+# Switch over to get USB card access
+sd-mux-ctrl --device-serial ${sdwire_serial} --ts
+
+complete=false
+for i in {0..9}; do
+    if out="$(mount UUID=${mount_uuid} 2>&1)"; then
+        complete=true
+        break
+    fi
+    echo $out
+
+    # If it is already mounted, try to unmount it first. It may have been
+    # mounted by another user so we won't have the access we need. If this gives
+    # an error then we know we cannot continue
+    if [[ $out == *"already mounted"* ]]; then
+        umount UUID=${mount_uuid}
+    fi
+    sleep 1
+done
+if [[ $complete = false ]]; then
+    echo "Failed to mount UUID ${mount_uuid} after 10 tries"
+    exit 1
+fi
+
+# Sanity check
+if ! mountpoint -q ${mount_dir}; then
+    echo "Mount ${mount_dir} not available after 'mount'"
+    exit 1
+fi
+
+# Perform the write, pass along as much environment as possible
+. writer.${flash_writer}
+
+complete=false
+for i in {0..9}; do
+    if out="$(umount ${mount_dir} 2>&1)"; then
+        complete=true
+        break
+    fi
+    echo $out
+    sleep 1
+done
+
+if [[ $complete = false ]]; then
+    echo "Failed to umount UUID ${mount_uuid} after 10 tries"
+    exit 1
+fi
+
+# Sanity check
+if mountpoint -q ${mount_dir}; then
+    echo "Mount ${mount_dir} still available after 'umount'"
+    exit 1
+fi
+
+# Back to card access for the DUT
+sd-mux-ctrl --device-serial ${sdwire_serial} --dut
diff --git a/test/hooks/bin/flash.sdwire_digital-loggers_raw b/test/hooks/bin/flash.sdwire_digital-loggers_raw
new file mode 100644
index 00000000000..f9956f7ed04
--- /dev/null
+++ b/test/hooks/bin/flash.sdwire_digital-loggers_raw
@@ -0,0 +1,41 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Designed for using SDwire uSD mux and ykush USB power control:
+# https://wiki.tizen.org/SDWire
+# https://dlidirect.com/products/new-pro-switch
+
+# It requires these tools:
+# sd-mux-ctrl at https://git.tizen.org/cgit/tools/testlab/sd-mux/
+# curl to control the power switch
+
+# Power off
+curl --data ${power_port}=OFF -o /dev/null --silent \
+	http://${power_user:-admin}:${power_pass:-1234}@${power_ip}/outlet
+
+# Switch over to get USB card access
+sd-mux-ctrl --device-serial ${sdwire_serial} --ts
+
+. wait_raw_device
+
+writer.${flash_writer} ${raw_device} ${U_BOOT_BUILD_DIR}
+
+# Back to card access for the DUT
+sd-mux-ctrl --device-serial ${sdwire_serial} --dut
diff --git a/test/hooks/bin/flash.sdwire_poweroff_mount b/test/hooks/bin/flash.sdwire_poweroff_mount
new file mode 100644
index 00000000000..a44a524b7d8
--- /dev/null
+++ b/test/hooks/bin/flash.sdwire_poweroff_mount
@@ -0,0 +1,32 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Designed for using SDwire uSD mux and ykush USB power control:
+# https://wiki.tizen.org/SDWire
+# https://www.yepkit.com/products/ykush
+
+# It requires these tools:
+# sd-mux-ctrl at https://git.tizen.org/cgit/tools/testlab/sd-mux/
+# ykushcmd at https://github.com/Yepkit/ykush
+
+# Power off
+. poweroff.${power_impl}
+
+. flash.sdwire_common_mount
diff --git a/test/hooks/bin/flash.sdwire_poweroff_raw b/test/hooks/bin/flash.sdwire_poweroff_raw
new file mode 100644
index 00000000000..d82a3ef836a
--- /dev/null
+++ b/test/hooks/bin/flash.sdwire_poweroff_raw
@@ -0,0 +1,42 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Designed for using SDwire uSD mux and ykush USB power control:
+# https://wiki.tizen.org/SDWire
+# https://www.yepkit.com/products/ykush
+
+# It requires these tools:
+# sd-mux-ctrl at https://git.tizen.org/cgit/tools/testlab/sd-mux/
+# ykushcmd at https://github.com/Yepkit/ykush
+
+mount_dir=/media/${mount_point}
+
+# Power off
+. poweroff.${power_impl}
+
+# Switch over to get USB card access
+sd-mux-ctrl --device-serial ${sdwire_serial} --ts
+
+. wait_raw_device
+
+writer.${flash_writer} ${raw_device} ${U_BOOT_BUILD_DIR}
+
+# Back to card access for the DUT
+sd-mux-ctrl --device-serial ${sdwire_serial} --dut
diff --git a/test/hooks/bin/flash.sdwire_relay_mount b/test/hooks/bin/flash.sdwire_relay_mount
new file mode 100644
index 00000000000..f75d33f9fd0
--- /dev/null
+++ b/test/hooks/bin/flash.sdwire_relay_mount
@@ -0,0 +1,34 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Designed for using SDwire uSD mux and selected power control:
+# https://wiki.tizen.org/SDWire
+
+# It requires these tools:
+# sd-mux-ctrl at https://git.tizen.org/cgit/tools/testlab/sd-mux/
+# usbrelay
+
+. poweroff.${power_impl}
+
+sleep 0.1
+
+. flash.sdwire_common_mount
+
+. poweron.${power_impl}
diff --git a/test/hooks/bin/flashair.rpi b/test/hooks/bin/flashair.rpi
new file mode 100644
index 00000000000..2c2756c7308
--- /dev/null
+++ b/test/hooks/bin/flashair.rpi
@@ -0,0 +1,47 @@
+#!/bin/bash
+
+# Copyright (c) 2016 Stephen Warren <swarren@wwwdotorg.org>
+# Copyright (c) 2016 Konsulko Group
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions are met:
+# * Redistributions of source code must retain the above copyright notice,
+#   this list of conditions and the following disclaimer.
+# * Redistributions in binary form must reproduce the above copyright notice,
+#   this list of conditions and the following disclaimer in the documentation
+#   and/or other materials provided with the distribution.
+# * Neither the name of the copyright holder nor the names of its contributors
+#   may be used to endorse or promote products derived from this software
+#   without specific prior written permission.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+# POSSIBILITY OF SUCH DAMAGE.
+
+cp "${U_BOOT_BUILD_DIR}"/u-boot.bin "${UL_DIR}"/u-boot.bin
+
+touch "${UL_DIR}/config.txt"
+
+echo "enable_uart=1" >> "${UL_DIR}/config.txt"
+echo "kernel=u-boot.bin" >> "${UL_DIR}/config.txt"
+
+case "${board_type}" in
+rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
+    echo "arm_64bit=1" >> "${UL_DIR}/config.txt"
+    ;;
+esac
+
+case "${board_ident}" in
+3-32-pl011)
+    echo "dtoverlay=pi3-miniuart-bt" >> "${UL_DIR}/config.txt"
+    ;;
+esac
diff --git a/test/hooks/bin/flashair.ti-omap b/test/hooks/bin/flashair.ti-omap
new file mode 100644
index 00000000000..aa271b20b97
--- /dev/null
+++ b/test/hooks/bin/flashair.ti-omap
@@ -0,0 +1,26 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+#
+# This script will copy the 'MLO' and 'u-boot.img' files into the correct
+# location for the flashair wrapper to upload them.  The 'MLO' file is what
+# the ROM found in most 32bit TI platforms (other than the Keystone family)
+# will look for when booting from a FAT partition.
+
+cp "${U_BOOT_BUILD_DIR}"/{MLO,u-boot.img} "${UL_DIR}/"
diff --git a/test/hooks/bin/getrole.labgrid-sjg b/test/hooks/bin/getrole.labgrid-sjg
new file mode 100755
index 00000000000..7cef0a5064d
--- /dev/null
+++ b/test/hooks/bin/getrole.labgrid-sjg
@@ -0,0 +1,34 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+[ -n "${do_configure}" ] && config_arg=",config_file"
+
+# The following spurious output is present with Python 3.12 on Ubuntu 24.04 so
+# use a redirection to drop it:
+
+# Error in sys.excepthook:
+#
+# Original exception was:
+#
+
+exec labgrid-client -r "${target}" -a query -n \
+	UBootProviderDriver:board,board_extra,source_dir,build_dir,build_dir_extra${config_arg} \
+	2>/dev/null
diff --git a/test/hooks/bin/kea/conf.Linksprite_pcDuino3_sjg-pcduino3 b/test/hooks/bin/kea/conf.Linksprite_pcDuino3_sjg-pcduino3
new file mode 100644
index 00000000000..0ef71c9261a
--- /dev/null
+++ b/test/hooks/bin/kea/conf.Linksprite_pcDuino3_sjg-pcduino3
@@ -0,0 +1,33 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyusb_port2
+reset_impl=ykush
+flash_impl=sdwire_poweroff_raw
+power_impl=ykush
+
+flash_writer=sunxi_raw
+
+ykush_serial=YK17698
+ykush_port=2
+
+sdwire_serial=sdwire-7
+
+raw_device=/dev/sdcard0
diff --git a/test/hooks/bin/kea/conf.chromebook_link_sjg-link b/test/hooks/bin/kea/conf.chromebook_link_sjg-link
new file mode 100644
index 00000000000..ac10acbc7a1
--- /dev/null
+++ b/test/hooks/bin/kea/conf.chromebook_link_sjg-link
@@ -0,0 +1,30 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+reset_impl=cros_servo
+flash_impl=em100
+power_impl=cros_servo
+
+em100_chip=W25Q64FV
+em100_serial=DP022781
+
+cros_servo_name=link
+
+. common-config.cros-servo-dut-control
diff --git a/test/hooks/bin/kea/conf.chromebook_samus_sjg-samus b/test/hooks/bin/kea/conf.chromebook_samus_sjg-samus
new file mode 100644
index 00000000000..0e7db499a8d
--- /dev/null
+++ b/test/hooks/bin/kea/conf.chromebook_samus_sjg-samus
@@ -0,0 +1,30 @@
+# Copyright 2021 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+reset_impl=servo
+flash_impl=em100
+power_impl=servo
+
+em100_chip=W25Q64FV
+em100_serial=DP033694
+
+servo_name=samus
+
+. ubtest_common
diff --git a/test/hooks/bin/kea/conf.jetson-tk1_sjg-tk1 b/test/hooks/bin/kea/conf.jetson-tk1_sjg-tk1
new file mode 100644
index 00000000000..1883254d916
--- /dev/null
+++ b/test/hooks/bin/kea/conf.jetson-tk1_sjg-tk1
@@ -0,0 +1,38 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+relay_type=6QMBS_
+
+console_dev=/dev/ttyusb_port3
+reset_impl=usbrelay
+flash_impl=none
+reset_impl=recovery_download
+recovery_impl=usbrelay
+
+usbrelay_power=1
+usbrelay_reset=2
+usbrelay_recovery=3
+
+board_usb_dev=/dev/usbdev-jetson-tk1
+download_impl=tegra-uboot-flasher
+tubf_bin=/vid/software/devel/tegra/tegra-uboot-flasher-scripts
+tubf_board=jetson-tk1
+tubf_config=jetson-tk1
+board_usb_port_path=4-10.1.1
diff --git a/test/hooks/bin/kea/conf.minnowmax_sjg-minnowmax b/test/hooks/bin/kea/conf.minnowmax_sjg-minnowmax
new file mode 100644
index 00000000000..c98df9844d9
--- /dev/null
+++ b/test/hooks/bin/kea/conf.minnowmax_sjg-minnowmax
@@ -0,0 +1,33 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyusb_port7
+reset_impl=digital-loggers
+flash_impl=em100
+power_impl=digital-loggers
+
+power_ip="192.168.4.19"
+power_user="admin"
+power_pass="1234"
+power_port=6
+
+em100_dev=/dev/em100_0
+em100_serial=DP139140
+em100_chip=W25Q64DW
diff --git a/test/hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc b/test/hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc
new file mode 100644
index 00000000000..f168e76335d
--- /dev/null
+++ b/test/hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc
@@ -0,0 +1,35 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyusb_port4
+reset_impl=digital-loggers
+flash_impl=sdwire_digital-loggers_raw
+power_impl=digital-loggers
+
+flash_writer=sunxi_raw
+
+power_ip="192.168.4.19"
+power_user="admin"
+power_pass="1234"
+power_port=1
+
+sdwire_serial=202001064004
+
+raw_device=/dev/sdcard1
diff --git a/test/hooks/bin/kea/conf.rock2_sjg-rock2 b/test/hooks/bin/kea/conf.rock2_sjg-rock2
new file mode 100644
index 00000000000..6cb09021cb0
--- /dev/null
+++ b/test/hooks/bin/kea/conf.rock2_sjg-rock2
@@ -0,0 +1,33 @@
+# Copyright (c) 2020 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyusb_port8
+reset_impl=ykush
+flash_impl=sdwire_poweroff_raw
+power_impl=ykush
+
+flash_writer=rk3288_raw
+
+ykush_serial=YK17698
+ykush_port=3
+
+sdwire_serial=sdwireda10
+
+raw_device=/dev/sdcard3
diff --git a/test/hooks/bin/kea/conf.rpi_3_32b_sjg-rpi_3b b/test/hooks/bin/kea/conf.rpi_3_32b_sjg-rpi_3b
new file mode 100644
index 00000000000..020eca2404d
--- /dev/null
+++ b/test/hooks/bin/kea/conf.rpi_3_32b_sjg-rpi_3b
@@ -0,0 +1,34 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyusb_port1
+reset_impl=ykush
+flash_impl=sdwire_poweroff_mount
+power_impl=ykush
+
+flash_writer=rpi_mount
+
+ykush_serial=YK17698
+ykush_port=1
+
+sdwire_serial=sdwire-18
+
+mount_uuid=B529-9710
+mount_point=rpi3_b_boot
diff --git a/test/hooks/bin/kea/conf.rpi_3_sjg-rpi_3b b/test/hooks/bin/kea/conf.rpi_3_sjg-rpi_3b
new file mode 100644
index 00000000000..d8d2a94f036
--- /dev/null
+++ b/test/hooks/bin/kea/conf.rpi_3_sjg-rpi_3b
@@ -0,0 +1,34 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyusb_port1
+reset_impl=ykush
+flash_impl=sdwire_ykush_mount
+power_impl=ykush
+
+flash_writer=rpi_mount
+
+ykush_serial=YK17698
+ykush_port=1
+
+sdwire_serial=sdwire-18
+
+mount_uuid=B529-9710
+mount_point=rpi3_b_boot
diff --git a/test/hooks/bin/kea/conf.zynq_zybo_sjg-zynq_zybo b/test/hooks/bin/kea/conf.zynq_zybo_sjg-zynq_zybo
new file mode 100644
index 00000000000..4a46374d8dd
--- /dev/null
+++ b/test/hooks/bin/kea/conf.zynq_zybo_sjg-zynq_zybo
@@ -0,0 +1,44 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+set -ex
+
+relay_type=6QMBS_
+
+console_dev=/dev/ttyusb_port5
+console_wait=1
+
+reset_impl=usbrelay
+flash_impl=sdwire_relay_mount
+power_impl=digital-loggers
+
+flash_writer=zynq_mount
+
+usbrelay_reset=6
+
+power_ip="192.168.4.19"
+power_user="admin"
+power_pass="1234"
+power_port=5
+
+sdwire_serial=202001064001
+
+mount_uuid=5203-DB74
+mount_point=zynq_zybo_boot
diff --git a/test/hooks/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na b/test/hooks/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
new file mode 100644
index 00000000000..a7839564e90
--- /dev/null
+++ b/test/hooks/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
@@ -0,0 +1,30 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# List the files to copy
+tispl=tispl.bin_unsigned
+uboot=u-boot.img_unsigned
+tiboot3=tiboot3-am62x-gp-evm.bin
+
+# Use labgrid
+console_impl=labgrid-trini
+reset_impl=labgrid-trini
+flash_impl=labgrid-trini.sd-mux
+flash_writer=labgrid-trini.ti-k3
diff --git a/test/hooks/bin/konsulko-labgrid/conf.am64x_evm_a53_na b/test/hooks/bin/konsulko-labgrid/conf.am64x_evm_a53_na
new file mode 100644
index 00000000000..dac7049be34
--- /dev/null
+++ b/test/hooks/bin/konsulko-labgrid/conf.am64x_evm_a53_na
@@ -0,0 +1,30 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# List the files to copy
+tispl=tispl.bin_unsigned
+uboot=u-boot.img_unsigned
+tiboot3=tiboot3-am64x-gp-evm.bin
+
+# Use labgrid
+console_impl=labgrid-trini
+reset_impl=labgrid-trini
+flash_impl=labgrid-trini.sd-mux
+flash_writer=labgrid-trini.ti-k3
diff --git a/test/hooks/bin/konsulko-labgrid/conf.rpi_4_32b_na b/test/hooks/bin/konsulko-labgrid/conf.rpi_4_32b_na
new file mode 120000
index 00000000000..d33d959874c
--- /dev/null
+++ b/test/hooks/bin/konsulko-labgrid/conf.rpi_4_32b_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/test/hooks/bin/konsulko-labgrid/conf.rpi_4_na b/test/hooks/bin/konsulko-labgrid/conf.rpi_4_na
new file mode 120000
index 00000000000..d33d959874c
--- /dev/null
+++ b/test/hooks/bin/konsulko-labgrid/conf.rpi_4_na
@@ -0,0 +1 @@
+conf.rpi_arm64_na
\ No newline at end of file
diff --git a/test/hooks/bin/konsulko-labgrid/conf.rpi_arm64_na b/test/hooks/bin/konsulko-labgrid/conf.rpi_arm64_na
new file mode 100644
index 00000000000..8c8e1a177d0
--- /dev/null
+++ b/test/hooks/bin/konsulko-labgrid/conf.rpi_arm64_na
@@ -0,0 +1,25 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Use labgrid
+console_impl=labgrid-trini
+reset_impl=labgrid-trini
+flash_impl=labgrid-trini.sd-mux
+flash_writer=labgrid-trini.rpi
diff --git a/test/hooks/bin/poweroff.digital-loggers b/test/hooks/bin/poweroff.digital-loggers
new file mode 100644
index 00000000000..eaf6a392ab8
--- /dev/null
+++ b/test/hooks/bin/poweroff.digital-loggers
@@ -0,0 +1,22 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+curl --data ${power_port}=OFF -o /dev/null --silent \
+	http://${power_user:-admin}:${power_pass:-1234}@${power_ip}/outlet
diff --git a/test/hooks/bin/poweroff.manual b/test/hooks/bin/poweroff.manual
new file mode 100644
index 00000000000..05be7802dd9
--- /dev/null
+++ b/test/hooks/bin/poweroff.manual
@@ -0,0 +1,21 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# We do nothing, and assume the user will power off the board later
diff --git a/test/hooks/bin/poweroff.none b/test/hooks/bin/poweroff.none
new file mode 100755
index 00000000000..cd9733ed034
--- /dev/null
+++ b/test/hooks/bin/poweroff.none
@@ -0,0 +1,22 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# No power-control needed
diff --git a/test/hooks/bin/poweroff.phidgets b/test/hooks/bin/poweroff.phidgets
new file mode 100644
index 00000000000..7d9e7da6c44
--- /dev/null
+++ b/test/hooks/bin/poweroff.phidgets
@@ -0,0 +1,37 @@
+# Copyright (c) 2015-2018, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+export LD_LIBRARY_PATH="${phidgets_dir}/lib:${LD_LIBRARY_PATH}"
+
+# Put board into recovery so it doesn't boot
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_recovery} 1
+sleep 0.25
+# Pulse power button to ensure board is on
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_power} 1
+sleep 0.75
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_power} 0
+sleep 0.25
+# Hold power button to turn board off
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_power} 1
+sleep 15
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_power} 0
+sleep 0.25
+# Release recovery
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_recovery} 0
diff --git a/test/hooks/bin/poweroff.pm342 b/test/hooks/bin/poweroff.pm342
new file mode 100644
index 00000000000..2ebfb7308af
--- /dev/null
+++ b/test/hooks/bin/poweroff.pm342
@@ -0,0 +1,21 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+"${nv_board_automation_bin}/boardctl" --target pm342 --serial "${pm342_serial}" power_off
diff --git a/test/hooks/bin/poweroff.ykush b/test/hooks/bin/poweroff.ykush
new file mode 100644
index 00000000000..fe03df70e2b
--- /dev/null
+++ b/test/hooks/bin/poweroff.ykush
@@ -0,0 +1,23 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Usees YKUSB to power the device off
+
+ykushcmd -s ${ykush_serial} -d ${ykush_port}
diff --git a/test/hooks/bin/poweron.digital-loggers b/test/hooks/bin/poweron.digital-loggers
new file mode 100644
index 00000000000..f7a97f65ac6
--- /dev/null
+++ b/test/hooks/bin/poweron.digital-loggers
@@ -0,0 +1,22 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+curl --data ${power_port}=ON -o /dev/null --silent \
+	http://${power_user:-admin}:${power_pass:-1234}@${power_ip}/outlet
diff --git a/test/hooks/bin/poweron.manual b/test/hooks/bin/poweron.manual
new file mode 100644
index 00000000000..ad5a3251563
--- /dev/null
+++ b/test/hooks/bin/poweron.manual
@@ -0,0 +1,21 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# We do nothing, and assume the user has already powered on the board first
diff --git a/test/hooks/bin/poweron.none b/test/hooks/bin/poweron.none
new file mode 100755
index 00000000000..cd9733ed034
--- /dev/null
+++ b/test/hooks/bin/poweron.none
@@ -0,0 +1,22 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# No power-control needed
diff --git a/test/hooks/bin/poweron.phidgets b/test/hooks/bin/poweron.phidgets
new file mode 100644
index 00000000000..06af8b89142
--- /dev/null
+++ b/test/hooks/bin/poweron.phidgets
@@ -0,0 +1,32 @@
+# Copyright (c) 2015-2018, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+export LD_LIBRARY_PATH="${phidgets_dir}/lib:${LD_LIBRARY_PATH}"
+
+# Put board into recovery so it doesn't boot
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_recovery} 1
+sleep 0.25
+# Pulse power button to turn board on
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_power} 1
+sleep 0.75
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_power} 0
+sleep 0.25
+# Release recovery
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_recovery} 0
diff --git a/test/hooks/bin/poweron.pm342 b/test/hooks/bin/poweron.pm342
new file mode 100644
index 00000000000..de3c11f5ce1
--- /dev/null
+++ b/test/hooks/bin/poweron.pm342
@@ -0,0 +1,24 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Basic power on
+"${nv_board_automation_bin}/boardctl" --target pm342 --serial "${pm342_serial}" power_on
+# Put board into recovery so it doesn't boot
+. "${bin_dir}/recovery.pm342"
diff --git a/test/hooks/bin/poweron.ykush b/test/hooks/bin/poweron.ykush
new file mode 100644
index 00000000000..5a541eccffd
--- /dev/null
+++ b/test/hooks/bin/poweron.ykush
@@ -0,0 +1,23 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Usees YKUSB to power the device on
+
+ykushcmd -s ${ykush_serial} -u ${ykush_port}
diff --git a/test/hooks/bin/push-flashair.py b/test/hooks/bin/push-flashair.py
new file mode 100755
index 00000000000..b71149a4e60
--- /dev/null
+++ b/test/hooks/bin/push-flashair.py
@@ -0,0 +1,118 @@
+#!/usr/bin/env python3
+
+# Copyright (c) 2016 Stephen Warren <swarren@wwwdotorg.org>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions are met:
+# * Redistributions of source code must retain the above copyright notice,
+#   this list of conditions and the following disclaimer.
+# * Redistributions in binary form must reproduce the above copyright notice,
+#   this list of conditions and the following disclaimer in the documentation
+#   and/or other materials provided with the distribution.
+# * Neither the name of the copyright holder nor the names of its contributors
+#   may be used to endorse or promote products derived from this software
+#   without specific prior written permission.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+# POSSIBILITY OF SUCH DAMAGE.
+
+import argparse
+import fnmatch
+import os
+import requests
+import sys
+try:
+    from os import scandir
+except ImportError:
+    from scandir import scandir
+
+def push_file(host, local_path, remote_name):
+    print('..PUSH FILE: ' + remote_name)
+    files = {'file': (remote_name, open(local_path,'rb'))}
+    response = requests.post('http://%s/upload.cgi' % host, files=files)
+    print('.... ' + str(response.status_code))
+    response.raise_for_status()
+    if 'NG' in response.text or 'action=/upload.cgi' not in response.text:
+        print('Upload failed:', file=sys.stderr)
+        print(response.text, file=sys.stderr)
+        sys.exit(1)
+
+def op_push_dir(host, local_dir):
+    print('PUSH DIR: ' + local_dir)
+    for de in scandir(local_dir):
+        if not de.is_file():
+            print('Can\'t handle non-file "%s"' % de.path, file=sys.stderr)
+            sys.exit(1)
+        push_file(host, de.path, de.name)
+
+def op_rm_list(host, rm_list_file):
+    print('RM LIST: ' + rm_list_file)
+    params = {'op': 100, 'DIR': '/'}
+    response = requests.get('http://%s/command.cgi' % host, params=params)
+    response.raise_for_status()
+    lines = response.text.splitlines()
+    if lines[0] != 'WLANSD_FILELIST':
+        print('File list qery failed:', file=sys.stderr)
+        print(response.text, file=sys.stderr)
+        sys.exit(1)
+    existing_files = []
+    for l in lines[1:]:
+        existing_files.append(l.split(',')[1].lower())
+    with open(rm_list_file, 'rt') as fh:
+        for l in fh:
+            l = l.split('#')[0]
+            rmspec = l.strip().lower()
+            if not rmspec:
+                continue
+            for remote_filename in existing_files[:]:
+                if fnmatch.fnmatch(remote_filename, rmspec):
+                    print('..DELETE: ' + remote_filename)
+                    params = {'DEL': '/' + remote_filename}
+                    response = requests.get('http://%s/upload.cgi' % host, params=params)
+                    print('.... ' + str(response.status_code))
+                    response.raise_for_status()
+                    if 'SUCCESS' not in response.text:
+                        print('Delete failed:', file=sys.stderr)
+                        print(response.text, file=sys.stderr)
+                        sys.exit(1)
+
+op_map = {
+    'push': op_push_dir,
+    'rmlist': op_rm_list,
+}
+
+def main():
+    parser = argparse.ArgumentParser(
+        description='Copy files to a Toshiba FlashAir device')
+    parser.add_argument('host', help='The host or host:port of the FlashAir')
+    parser.add_argument('ops', nargs='+', help='''Operations to perform;
+    "dir", "push:dir": push directory, "rmlist:listfile": delete files listed
+    in listfile''')
+    args = parser.parse_args()
+
+    for op in args.ops:
+        if not ':' in op:
+            func = op_push_dir
+            param = op
+        else:
+            (op_name, param) = op.split(':', 1)
+            if op_name not in op_map:
+                print('"%s" is not a valid operation' % op_name,
+                    file=sys.stderr)
+                parser.print_help(file=sys.stderr)
+                sys.exit(1)
+            func = op_map[op_name]
+        func(args.host, param)
+
+if __name__ == '__main__':
+    main()
diff --git a/test/hooks/bin/qemu.swtpm b/test/hooks/bin/qemu.swtpm
new file mode 100755
index 00000000000..c40c537d3de
--- /dev/null
+++ b/test/hooks/bin/qemu.swtpm
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: BSD-2
+#
+# This script launches swtpm to emulate a TPMv2.
+#
+# The parameter -t makes it unload when the connection to QEMU is
+# terminated.
+#
+# To make use of it add
+#
+#     qemu_helper_script="swtpm"
+#
+# to the board script and the following arguments to qemu_extra_args
+#
+#     -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock \
+#     -tpmdev emulator,id=tpm0,chardev=chrtpm \
+#     -device tpm-tis-device,tpmdev=tpm0
+#
+# U-Boot must be built with CONFIG_TPM2_MMIO=y.
+
+mkdir -p /tmp/tpm
+swtpm socket -d -t --tpmstate dir=/tmp/tpm --tpm2 \
+--ctrl type=unixio,path=/tmp/tpm/swtpm-sock
diff --git a/test/hooks/bin/recovery.manual b/test/hooks/bin/recovery.manual
new file mode 100644
index 00000000000..b3d3a14ab3a
--- /dev/null
+++ b/test/hooks/bin/recovery.manual
@@ -0,0 +1,23 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+echo PLACE THE BOARD INTO RECOVERY MODE > /dev/tty
+echo PRESS ENTER WHEN DONE > /dev/tty
+read foo > /dev/tty < /dev/tty
diff --git a/test/hooks/bin/recovery.phidgets b/test/hooks/bin/recovery.phidgets
new file mode 100644
index 00000000000..163fe4a7089
--- /dev/null
+++ b/test/hooks/bin/recovery.phidgets
@@ -0,0 +1,29 @@
+# Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+export LD_LIBRARY_PATH="${phidgets_dir}/lib:${LD_LIBRARY_PATH}"
+
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_recovery} 1
+sleep 0.25
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_reset} 1
+sleep 0.25
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_reset} 0
+sleep 0.25
+"${phidgets_dir}/bin/phidgets-relay" ${phidgets_serial} ${phidgets_relay_recovery} 0
diff --git a/test/hooks/bin/recovery.pm342 b/test/hooks/bin/recovery.pm342
new file mode 100644
index 00000000000..8d7a8aca3c9
--- /dev/null
+++ b/test/hooks/bin/recovery.pm342
@@ -0,0 +1,26 @@
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# The "recovery" command doesn't work on p2771-0000, so do this manually:
+"${nv_board_automation_bin}/boardctl" --target pm342 --serial "${pm342_serial}" recovery_down
+sleep 0.25
+"${nv_board_automation_bin}/boardctl" --target pm342 --serial "${pm342_serial}" reset
+sleep 0.25
+"${nv_board_automation_bin}/boardctl" --target pm342 --serial "${pm342_serial}" recovery_up
diff --git a/test/hooks/bin/recovery.relay b/test/hooks/bin/recovery.relay
new file mode 100755
index 00000000000..df838039097
--- /dev/null
+++ b/test/hooks/bin/recovery.relay
@@ -0,0 +1,39 @@
+#!/bin/bash
+
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+"${recovery_relay_bin}/relayctl.py" "${recovery_relay_type}" \
+    "${recovery_relay_dev}" "${recovery_relay_force_recovery}" on
+
+sleep 0.1
+
+"${recovery_relay_bin}/relayctl.py" "${recovery_relay_type}" \
+    "${recovery_relay_dev}" "${recovery_relay_reset}" on
+
+sleep 0.1
+
+"${recovery_relay_bin}/relayctl.py" "${recovery_relay_type}" \
+    "${recovery_relay_dev}" "${recovery_relay_reset}" off
+
+sleep 0.1
+
+"${recovery_relay_bin}/relayctl.py" "${recovery_relay_type}" \
+    "${recovery_relay_dev}" "${recovery_relay_force_recovery}" off
diff --git a/test/hooks/bin/recovery.usbrelay b/test/hooks/bin/recovery.usbrelay
new file mode 100755
index 00000000000..3b4dcdf13a5
--- /dev/null
+++ b/test/hooks/bin/recovery.usbrelay
@@ -0,0 +1,32 @@
+#!/bin/bash
+
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+usbrelay "${relay_type}${usbrelay_recovery}=1"
+usbrelay "${relay_type}${usbrelay_reset}=1"
+
+sleep 0.1
+
+usbrelay "${relay_type}${usbrelay_reset}=0"
+
+sleep 0.1
+
+usbrelay "${relay_type}${usbrelay_recovery}=0"
diff --git a/test/hooks/bin/release.labgrid-sjg b/test/hooks/bin/release.labgrid-sjg
new file mode 100644
index 00000000000..54e789533f8
--- /dev/null
+++ b/test/hooks/bin/release.labgrid-sjg
@@ -0,0 +1,22 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+exec labgrid-client -r "${U_BOOT_BOARD_IDENTITY}" release -a
diff --git a/test/hooks/bin/release.none b/test/hooks/bin/release.none
new file mode 100644
index 00000000000..284d1b17fad
--- /dev/null
+++ b/test/hooks/bin/release.none
@@ -0,0 +1,22 @@
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# No releasing needed
diff --git a/test/hooks/bin/reset.cros_servo b/test/hooks/bin/reset.cros_servo
new file mode 100644
index 00000000000..c5ff64d0f8d
--- /dev/null
+++ b/test/hooks/bin/reset.cros_servo
@@ -0,0 +1,23 @@
+# Copyright 2020 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Uses servo to reset the board
+
+${DUT_CONTROL} -p ${cros_servo_port} cold_reset:on sleep:.2 cold_reset:off
diff --git a/test/hooks/bin/reset.digital-loggers b/test/hooks/bin/reset.digital-loggers
new file mode 100644
index 00000000000..17129745c68
--- /dev/null
+++ b/test/hooks/bin/reset.digital-loggers
@@ -0,0 +1,25 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+curl --data ${power_port}=OFF -o /dev/null --silent \
+	http://${power_user:-admin}:${power_pass:-1234}@${power_ip}/outlet
+sleep .5
+curl --data ${power_port}=ON -o /dev/null --silent \
+	http://${power_user:-admin}:${power_pass:-1234}@${power_ip}/outlet
diff --git a/test/hooks/bin/reset.labgrid-trini b/test/hooks/bin/reset.labgrid-trini
new file mode 100755
index 00000000000..c17b60324e3
--- /dev/null
+++ b/test/hooks/bin/reset.labgrid-trini
@@ -0,0 +1,24 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+. common.labgrid-trini
+
+exec labgrid-client power cycle
diff --git a/test/hooks/bin/reset.none b/test/hooks/bin/reset.none
new file mode 100644
index 00000000000..32bd386623e
--- /dev/null
+++ b/test/hooks/bin/reset.none
@@ -0,0 +1,30 @@
+# Copyright (c) 2016, Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# You probably should not be using this script. The only exception may be
+# if your console implementation spawns the target device itself (e.g. it
+# invokes an emulator such as qemu) rather than simply attaching to an
+# existing target device (which incidentally may also be possible with
+# qemu). The fact this script does nothing also assumes that U-Boot's
+# test/-py scripts re-invoke the console implementation every time the target
+# is reset, which is true at present, but in theory could be changed in the
+# future.
+
+# No reset needed
diff --git a/test/hooks/bin/reset.pm342 b/test/hooks/bin/reset.pm342
new file mode 100644
index 00000000000..067a5fa1e78
--- /dev/null
+++ b/test/hooks/bin/reset.pm342
@@ -0,0 +1,21 @@
+# Copyright (c) 2015-2018, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+"${nv_board_automation_bin}/boardctl" --target pm342 --serial "${pm342_serial}" reset
diff --git a/test/hooks/bin/reset.recovery_download b/test/hooks/bin/reset.recovery_download
new file mode 100644
index 00000000000..1d4cc8d211d
--- /dev/null
+++ b/test/hooks/bin/reset.recovery_download
@@ -0,0 +1,36 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "${bin_dir}/recovery.${recovery_impl}"
+
+# USB enumeration delay
+for ((i = 0; i <= 100; i++)); do
+    if [ -e "${board_usb_dev}" ]; then
+        break
+    fi
+    sleep 0.1
+done
+if [ ! -e "${board_usb_dev}" ]; then
+    echo "Cannot find device ${board_usb_dev}"
+    exit 1
+fi
+sleep 1
+
+. "${bin_dir}/download.${download_impl}"
diff --git a/test/hooks/bin/reset.usbrelay b/test/hooks/bin/reset.usbrelay
new file mode 100644
index 00000000000..43d3430b18c
--- /dev/null
+++ b/test/hooks/bin/reset.usbrelay
@@ -0,0 +1,26 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Usees usbrelay to assert and release reset
+usbrelay "${relay_type}${usbrelay_reset}=1"
+
+sleep .2
+
+usbrelay "${relay_type}${usbrelay_reset}=0"
diff --git a/test/hooks/bin/reset.ykush b/test/hooks/bin/reset.ykush
new file mode 100644
index 00000000000..f328eec5db8
--- /dev/null
+++ b/test/hooks/bin/reset.ykush
@@ -0,0 +1,25 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Usees YKUSB to power the device off and then on
+
+ykushcmd -s ${ykush_serial} -d ${ykush_port}
+sleep 1
+ykushcmd -s ${ykush_serial} -u ${ykush_port}
diff --git a/test/hooks/bin/swarren-lx1/conf.jetson-tk1_na b/test/hooks/bin/swarren-lx1/conf.jetson-tk1_na
new file mode 100644
index 00000000000..88d0d71d689
--- /dev/null
+++ b/test/hooks/bin/swarren-lx1/conf.jetson-tk1_na
@@ -0,0 +1,36 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/ttyS0
+power_impl=phidgets
+flash_impl=none
+reset_impl=recovery_download
+recovery_impl=phidgets
+phidgets_dir="${HOME}/phidgets"
+phidgets_serial=109237
+phidgets_relay_power=0
+phidgets_relay_recovery=1
+phidgets_relay_reset=2
+board_usb_dev=/dev/usbdev-jetson-tk1
+download_impl=tegra-uboot-flasher
+tubf_bin="${HOME}/ubtest-tegra-uboot-flasher/scripts"
+tubf_board=jetson-tk1
+tubf_config=jetson-tk1
+board_usb_port_path=1-8.3
diff --git a/test/hooks/bin/swarren-lx1/conf.p2371-2180_na b/test/hooks/bin/swarren-lx1/conf.p2371-2180_na
new file mode 100644
index 00000000000..b8e604c94dd
--- /dev/null
+++ b/test/hooks/bin/swarren-lx1/conf.p2371-2180_na
@@ -0,0 +1,57 @@
+# Copyright (c) 2015-2018, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+syms_file="${U_BOOT_BUILD_DIR}/u-boot.sym"
+if [ -f "${syms_file}" ]; then
+  set +e
+  grep -q cboot "${syms_file}" >/dev/null 2>&1
+  grep_ret=$?
+  set -e
+  if [ ${grep_ret} -eq 0 ]; then
+    boot_from_cboot=1
+  else
+    boot_from_cboot=0
+  fi
+else
+  boot_from_cboot=0
+fi
+
+console_dev=/dev/console-p2371-2180
+power_impl=pm342
+recovery_impl=pm342
+nv_board_automation_bin="${HOME}/ubtest-nvidia-board-automation"
+pm342_serial=SRW-0
+board_usb_dev=/dev/usbdev-p2371-2180
+board_usb_port_path=1-5
+
+if [ ${boot_from_cboot} -eq 1 ]; then
+  echo conf.p2371-2180_na: U-Boot branch requires flashing for testing
+  flash_impl=recovery_l4t
+  flash_l4t="${HOME}/ubtest-l4t-r28.1-p2371-2180"
+  flash_l4t_uboot_path=bootloader/t210ref/p2371-2180/
+  flash_l4t_board=jetson-tx1
+  reset_impl=pm342
+else
+  echo conf.p2371-2180_na: U-Boot branch can use USB RCM for testing
+  flash_impl=none
+  reset_impl=recovery_download
+  download_impl=l4t-exec-uboot
+  download_l4t="${HOME}/ubtest-l4t-exec-uboot"
+fi
diff --git a/test/hooks/bin/swarren-lx1/conf.p2771-0000-500_na b/test/hooks/bin/swarren-lx1/conf.p2771-0000-500_na
new file mode 100644
index 00000000000..3c197eacf62
--- /dev/null
+++ b/test/hooks/bin/swarren-lx1/conf.p2771-0000-500_na
@@ -0,0 +1,32 @@
+# Copyright (c) 2015-2018, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_dev=/dev/console-p2771-0000
+power_impl=pm342
+flash_impl=recovery_l4t
+recovery_impl=pm342
+flash_l4t="${HOME}/ubtest-l4t-r28.1-p2771-0000"
+flash_l4t_uboot_path=bootloader/t186ref/p2771-0000/500/
+flash_l4t_board=jetson-tx2
+reset_impl=pm342
+nv_board_automation_bin="${HOME}/ubtest-nvidia-board-automation"
+pm342_serial=SRW-1
+board_usb_dev=/dev/usbdev-p2771-0000
+board_usb_port_path=3-2
diff --git a/test/hooks/bin/travis-ci/conf.M5208EVBE_qemu b/test/hooks/bin/travis-ci/conf.M5208EVBE_qemu
new file mode 100644
index 00000000000..947f13c790f
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.M5208EVBE_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="mcf5208evb"
+qemu_binary="qemu-system-m68k"
+qemu_extra_args="-nographic -serial mon:stdio -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic,model=mcf-fec"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.coreboot_qemu b/test/hooks/bin/travis-ci/conf.coreboot_qemu
new file mode 100644
index 00000000000..76d6927510f
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.coreboot_qemu
@@ -0,0 +1,28 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+# Copyright 2021 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="pc"
+qemu_binary="qemu-system-i386"
+qemu_extra_args="-nographic -cpu qemu32 -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/coreboot.rom"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.evb-ast2500_qemu b/test/hooks/bin/travis-ci/conf.evb-ast2500_qemu
new file mode 100644
index 00000000000..2e9adc6af9b
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.evb-ast2500_qemu
@@ -0,0 +1,11 @@
+# Copyright 2019 IBM Corp.
+# Joel Stanley <joel@jms.id.au>
+# SPDX-License-Identifier: GPL-2.0+
+
+console_impl=qemu
+qemu_machine="ast2500-evb"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -nic user,tftp=${UBOOT_TRAVIS_BUILD_DIR}"
+qemu_kernel_args="-drive file=${U_BOOT_BUILD_DIR}/flash.img,format=raw,if=mtd"
+reset_impl=none
+flash_impl=qemu_gen_padded_image
diff --git a/test/hooks/bin/travis-ci/conf.evb-ast2600_qemu b/test/hooks/bin/travis-ci/conf.evb-ast2600_qemu
new file mode 100644
index 00000000000..386ff7d2577
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.evb-ast2600_qemu
@@ -0,0 +1,13 @@
+# Copyright 2022 IBM Corp.
+# Joel Stanley <joel@jms.id.au>
+# SPDX-License-Identifier: GPL-2.0+
+
+console_impl=qemu
+qemu_machine="ast2600-evb"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -nic user,tftp=${UBOOT_TRAVIS_BUILD_DIR}"
+qemu_kernel_args="-drive file=${U_BOOT_BUILD_DIR}/flash.img,format=raw,if=mtd"
+flash_u_boot_bin="u-boot-with-spl.bin"
+reset_impl=none
+flash_impl=qemu_gen_padded_image
+flash_size=64
diff --git a/test/hooks/bin/travis-ci/conf.integratorcp_cm926ejs_qemu b/test/hooks/bin/travis-ci/conf.integratorcp_cm926ejs_qemu
new file mode 100644
index 00000000000..d6e2f19b9e0
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.integratorcp_cm926ejs_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="integratorcp"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.malta64_qemu b/test/hooks/bin/travis-ci/conf.malta64_qemu
new file mode 100644
index 00000000000..462591d2cfb
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.malta64_qemu
@@ -0,0 +1,30 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+# Copyright (c) 2020 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="malta"
+qemu_binary="qemu-system-mips64"
+qemu_extra_args="-nographic -cpu MIPS64R2-generic -m 256"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw \
+    -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device pcnet,netdev=net0"
+reset_impl=none
+flash_impl=qemu_gen_padded_image
+flash_size=4
diff --git a/test/hooks/bin/travis-ci/conf.malta64el_qemu b/test/hooks/bin/travis-ci/conf.malta64el_qemu
new file mode 100644
index 00000000000..5a35f1d71a6
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.malta64el_qemu
@@ -0,0 +1,31 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+# Copyright (c) 2020 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="malta"
+qemu_binary="qemu-system-mips64el"
+qemu_extra_args="-nographic -cpu MIPS64R2-generic -m 256"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw \
+    -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device pcnet,netdev=net0"
+reset_impl=none
+flash_impl=qemu_gen_padded_image
+flash_size=4
+flash_u_boot_bin=u-boot-swap.bin
diff --git a/test/hooks/bin/travis-ci/conf.malta_qemu b/test/hooks/bin/travis-ci/conf.malta_qemu
new file mode 100644
index 00000000000..a2b39a4ba66
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.malta_qemu
@@ -0,0 +1,30 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+# Copyright (c) 2020 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="malta"
+qemu_binary="qemu-system-mips"
+qemu_extra_args="-nographic -cpu 24Kc -m 256"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw \
+    -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device pcnet,netdev=net0"
+reset_impl=none
+flash_impl=qemu_gen_padded_image
+flash_size=4
diff --git a/test/hooks/bin/travis-ci/conf.maltael_qemu b/test/hooks/bin/travis-ci/conf.maltael_qemu
new file mode 100644
index 00000000000..8b73e51f385
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.maltael_qemu
@@ -0,0 +1,31 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+# Copyright (c) 2020 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="malta"
+qemu_binary="qemu-system-mipsel"
+qemu_extra_args="-nographic -cpu 24Kc -m 256"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw \
+    -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device pcnet,netdev=net0"
+reset_impl=none
+flash_impl=qemu_gen_padded_image
+flash_size=4
+flash_u_boot_bin=u-boot-swap.bin
diff --git a/test/hooks/bin/travis-ci/conf.qemu-ae3xx_na b/test/hooks/bin/travis-ci/conf.qemu-ae3xx_na
new file mode 100644
index 00000000000..cf3c391a187
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-ae3xx_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="andes_ae300"
+qemu_binary="qemu-system-nds32"
+qemu_extra_args="-nographic -m 1G -gdb tcp::5678"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-arm-sbsa_na b/test/hooks/bin/travis-ci/conf.qemu-arm-sbsa_na
new file mode 100644
index 00000000000..fea885ffea0
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-arm-sbsa_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2024 Patrick Rudolph. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="sbsa-ref"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -smp 4 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/secure-world.rom,format=raw -drive if=pflash,file=${U_BOOT_BUILD_DIR}/unsecure-world.rom,format=raw"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-ax25_na b/test/hooks/bin/travis-ci/conf.qemu-ax25_na
new file mode 100644
index 00000000000..6837cb8151e
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-ax25_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="andes_ae350"
+qemu_binary="qemu-system-riscv64"
+qemu_extra_args="-nographic -m 4G -gdb tcp::5678"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-loongarch64_na b/test/hooks/bin/travis-ci/conf.qemu-loongarch64_na
new file mode 100644
index 00000000000..e8860bb4032
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-loongarch64_na
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2024 Jiaxun Yang
+#
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-loongarch64"
+qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-pci,netdev=net0 -device virtio-rng-pci"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-ppce500_na b/test/hooks/bin/travis-ci/conf.qemu-ppce500_na
new file mode 100644
index 00000000000..bcf00206ef8
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-ppce500_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="ppce500"
+qemu_binary="qemu-system-ppc"
+qemu_extra_args="-nographic"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-riscv32_na b/test/hooks/bin/travis-ci/conf.qemu-riscv32_na
new file mode 100644
index 00000000000..23706f38488
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-riscv32_na
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2020 Bin Meng <bmeng.cn@gmail.com>
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-riscv32"
+qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -device virtio-rng-device"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-riscv32_spl_na b/test/hooks/bin/travis-ci/conf.qemu-riscv32_spl_na
new file mode 100644
index 00000000000..cdf285ec10b
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-riscv32_spl_na
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2020 Bin Meng <bmeng.cn@gmail.com>
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-riscv32"
+qemu_extra_args="-smp 4 -m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -device virtio-rng-device"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl -device loader,file=${U_BOOT_BUILD_DIR}/u-boot.itb,addr=0x80200000"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-riscv64_na b/test/hooks/bin/travis-ci/conf.qemu-riscv64_na
new file mode 100644
index 00000000000..97c346912ff
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-riscv64_na
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2019 Heinrich Schuchardt
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-riscv64"
+qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -netdev user,id=net1,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net1 -device virtio-rng-device"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-riscv64_spl_na b/test/hooks/bin/travis-ci/conf.qemu-riscv64_spl_na
new file mode 100644
index 00000000000..cabf17b3ddf
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-riscv64_spl_na
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2020 Bin Meng <bmeng.cn@gmail.com>
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-riscv64"
+qemu_extra_args="-smp 4 -m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -device virtio-rng-device"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl -device loader,file=${U_BOOT_BUILD_DIR}/u-boot.itb,addr=0x80200000"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-x86_64_na b/test/hooks/bin/travis-ci/conf.qemu-x86_64_na
new file mode 100644
index 00000000000..356c5cf47a5
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-x86_64_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="pc"
+qemu_binary="qemu-system-x86_64"
+qemu_extra_args="-nographic -cpu qemu64 -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.rom"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-x86_na b/test/hooks/bin/travis-ci/conf.qemu-x86_na
new file mode 100644
index 00000000000..28a78b3d276
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-x86_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="pc"
+qemu_binary="qemu-system-i386"
+qemu_extra_args="-nographic -cpu qemu32 -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.rom"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu-xtensa-dc233c_na b/test/hooks/bin/travis-ci/conf.qemu-xtensa-dc233c_na
new file mode 100644
index 00000000000..fc3b5880e5c
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu-xtensa-dc233c_na
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2024 Jiaxun Yang
+#
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-xtensa"
+qemu_extra_args="-cpu dc233c -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-pci,netdev=net0 -device virtio-rng-pci -semihosting"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot.elf"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu_arm64_na b/test/hooks/bin/travis-ci/conf.qemu_arm64_na
new file mode 100644
index 00000000000..e195b5e47d7
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_arm64_na
@@ -0,0 +1,30 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu_arm64_spl_na b/test/hooks/bin/travis-ci/conf.qemu_arm64_spl_na
new file mode 100644
index 00000000000..9a0d9b30b99
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_arm64_spl_na
@@ -0,0 +1,32 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+
+# Uses image.bin which contains SPL and U-Boot
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu_arm64_tpl_na b/test/hooks/bin/travis-ci/conf.qemu_arm64_tpl_na
new file mode 100644
index 00000000000..556e15b11f8
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_arm64_tpl_na
@@ -0,0 +1,29 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu_arm64be_na b/test/hooks/bin/travis-ci/conf.qemu_arm64be_na
new file mode 100644
index 00000000000..3929636932e
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_arm64be_na
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2024 Jiaxun Yang
+#
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu_arm_na b/test/hooks/bin/travis-ci/conf.qemu_arm_na
new file mode 100644
index 00000000000..de0694d423e
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_arm_na
@@ -0,0 +1,30 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu_arm_spl_na b/test/hooks/bin/travis-ci/conf.qemu_arm_spl_na
new file mode 100644
index 00000000000..1646ea383b4
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_arm_spl_na
@@ -0,0 +1,31 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci"
+
+# Uses image.bin which contains SPL and U-Boot
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.qemu_mips64_na b/test/hooks/bin/travis-ci/conf.qemu_mips64_na
new file mode 100644
index 00000000000..dd096a8c5a8
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_mips64_na
@@ -0,0 +1,28 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="mips"
+qemu_binary="qemu-system-mips64"
+qemu_extra_args="-nographic -monitor null -cpu MIPS64R2-generic"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw"
+reset_impl=none
+flash_impl="qemu_gen_padded_image"
+flash_size=4
diff --git a/test/hooks/bin/travis-ci/conf.qemu_mips64el_na b/test/hooks/bin/travis-ci/conf.qemu_mips64el_na
new file mode 100644
index 00000000000..a8a213296ce
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_mips64el_na
@@ -0,0 +1,28 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="mips"
+qemu_binary="qemu-system-mips64el"
+qemu_extra_args="-nographic -monitor null -cpu MIPS64R2-generic"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw"
+reset_impl=none
+flash_impl="qemu_gen_padded_image"
+flash_size=4
diff --git a/test/hooks/bin/travis-ci/conf.qemu_mips_na b/test/hooks/bin/travis-ci/conf.qemu_mips_na
new file mode 100644
index 00000000000..a5e2a437b9f
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_mips_na
@@ -0,0 +1,28 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="mips"
+qemu_binary="qemu-system-mips"
+qemu_extra_args="-nographic -monitor null"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw"
+reset_impl=none
+flash_impl="qemu_gen_padded_image"
+flash_size=4
diff --git a/test/hooks/bin/travis-ci/conf.qemu_mipsel_na b/test/hooks/bin/travis-ci/conf.qemu_mipsel_na
new file mode 100644
index 00000000000..6481f24ce3f
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.qemu_mipsel_na
@@ -0,0 +1,28 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="mips"
+qemu_binary="qemu-system-mipsel"
+qemu_extra_args="-nographic -monitor null"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/flash.img,format=raw"
+reset_impl=none
+flash_impl="qemu_gen_padded_image"
+flash_size=4
diff --git a/test/hooks/bin/travis-ci/conf.r2dplus_i82557c_qemu b/test/hooks/bin/travis-ci/conf.r2dplus_i82557c_qemu
new file mode 100644
index 00000000000..85ad999ba3d
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.r2dplus_i82557c_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2020 Marek Vasut <marek.vasut+renesas@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="r2d"
+qemu_binary="qemu-system-sh4"
+qemu_extra_args="-nographic -serial null -serial mon:stdio -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic,model=i82557c"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.r2dplus_pcnet_qemu b/test/hooks/bin/travis-ci/conf.r2dplus_pcnet_qemu
new file mode 100644
index 00000000000..5d208bdc6df
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.r2dplus_pcnet_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2020 Marek Vasut <marek.vasut+renesas@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="r2d"
+qemu_binary="qemu-system-sh4"
+qemu_extra_args="-nographic -serial null -serial mon:stdio -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic,model=pcnet"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.r2dplus_rtl8139_qemu b/test/hooks/bin/travis-ci/conf.r2dplus_rtl8139_qemu
new file mode 100644
index 00000000000..b582eecc2a8
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.r2dplus_rtl8139_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2020 Marek Vasut <marek.vasut+renesas@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="r2d"
+qemu_binary="qemu-system-sh4"
+qemu_extra_args="-nographic -serial null -serial mon:stdio -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic,model=rtl8139"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.r2dplus_tulip_qemu b/test/hooks/bin/travis-ci/conf.r2dplus_tulip_qemu
new file mode 100644
index 00000000000..b04ba0605ca
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.r2dplus_tulip_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2020 Marek Vasut <marek.vasut+renesas@gmail.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="r2d"
+qemu_binary="qemu-system-sh4"
+qemu_extra_args="-nographic -serial null -serial mon:stdio -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic,model=tulip"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu b/test/hooks/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu
new file mode 100644
index 00000000000..e84ce7d6876
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2021 Bin Meng <bmeng.cn@gmail.com>
+
+console_impl=qemu
+qemu_machine="sifive_u,msel=11"
+qemu_binary="qemu-system-riscv64"
+qemu_extra_args="-smp 5 -m 8G -nographic -nic user,tftp=${UBOOT_TRAVIS_BUILD_DIR}"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl.bin -drive file=${U_BOOT_BUILD_DIR}/sdcard.img,format=raw,if=sd"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu b/test/hooks/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
new file mode 100644
index 00000000000..56a7a0c1501
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2021 Bin Meng <bmeng.cn@gmail.com>
+
+console_impl=qemu
+qemu_machine="sifive_u,msel=6"
+qemu_binary="qemu-system-riscv64"
+qemu_extra_args="-smp 5 -m 8G -nographic -nic user,tftp=${UBOOT_TRAVIS_BUILD_DIR}"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/spl/u-boot-spl.bin -drive file=${U_BOOT_BUILD_DIR}/spi-nor.img,format=raw,if=mtd"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.vexpress_ca15_tc2_qemu b/test/hooks/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
new file mode 100644
index 00000000000..55e40038b37
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="vexpress-a15"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -m 1G -audio none -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.vexpress_ca9x4_qemu b/test/hooks/bin/travis-ci/conf.vexpress_ca9x4_qemu
new file mode 100644
index 00000000000..b5ed72934c3
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.vexpress_ca9x4_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="vexpress-a9"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -m 1G -audio none -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.vexpress_fvp_bloblist_na b/test/hooks/bin/travis-ci/conf.vexpress_fvp_bloblist_na
new file mode 120000
index 00000000000..ef6f0a4ee82
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.vexpress_fvp_bloblist_na
@@ -0,0 +1 @@
+conf.vexpress_fvp_na
\ No newline at end of file
diff --git a/test/hooks/bin/travis-ci/conf.vexpress_fvp_na b/test/hooks/bin/travis-ci/conf.vexpress_fvp_na
new file mode 100644
index 00000000000..0f99cc9aead
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.vexpress_fvp_na
@@ -0,0 +1,29 @@
+# Copyright (c) 2025 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+if [ -z "${fip}" -o -z "${bl1}" ]; then
+	echo "The environment must point 'fip' and 'bl1' at existing fip and bl1 files"
+	exit 1
+fi
+console_impl=fvp
+fvp_binary="FVP_Base_RevC-2xAEMvA"
+fvp_args="-C bp.flashloader0.fname=${fip} -C bp.secureflashloader.fname=${bl1} -C bp.vis.disable_visualisation=1"
+reset_impl=none
+flash_impl=fiptool
diff --git a/test/hooks/bin/travis-ci/conf.xilinx_versal_virt_qemu b/test/hooks/bin/travis-ci/conf.xilinx_versal_virt_qemu
new file mode 100644
index 00000000000..0a8ee48eda3
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.xilinx_versal_virt_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2018 Xilinx, Inc. (Michal Simek). All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="xlnx-versal-virt"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-display none -m 4G -serial mon:stdio"
+qemu_kernel_args="-device loader,file=${U_BOOT_BUILD_DIR}/u-boot,cpu-num=0"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.xilinx_zynq_virt_qemu b/test/hooks/bin/travis-ci/conf.xilinx_zynq_virt_qemu
new file mode 100644
index 00000000000..a6af659bddd
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.xilinx_zynq_virt_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Xilinx, Inc. (Michal Simek). All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="xilinx-zynq-a9"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-display none -m 1G -nographic -serial /dev/null -serial mon:stdio -monitor null"
+qemu_kernel_args="-device loader,file=${U_BOOT_BUILD_DIR}/u-boot-dtb.bin,addr=0x4000000,cpu-num=0"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.xtfpga_qemu b/test/hooks/bin/travis-ci/conf.xtfpga_qemu
new file mode 100644
index 00000000000..f2681d538dc
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.xtfpga_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2018 Cadence Design Systems Inc. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="kc705"
+qemu_binary="qemu-system-xtensa"
+qemu_extra_args="-nographic -monitor null -m 1G -cpu dc233c"
+qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/travis-ci/conf.zynq_zc702_qemu b/test/hooks/bin/travis-ci/conf.zynq_zc702_qemu
new file mode 100644
index 00000000000..eef7904d501
--- /dev/null
+++ b/test/hooks/bin/travis-ci/conf.zynq_zc702_qemu
@@ -0,0 +1,27 @@
+# Copyright (c) 2016 Xilinx, Inc. (Michal Simek). All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="xilinx-zynq-a9"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-display none -m 40000000 -nographic -serial /dev/null -serial mon:stdio -monitor null"
+qemu_kernel_args="-device loader,file=${U_BOOT_BUILD_DIR}/u-boot-dtb.bin,addr=0x4000000,cpu-num=0"
+reset_impl=none
+flash_impl=none
diff --git a/test/hooks/bin/u-boot-test-common b/test/hooks/bin/u-boot-test-common
new file mode 100755
index 00000000000..2c3b476bceb
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-common
@@ -0,0 +1,36 @@
+#!/bin/bash
+
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+set -e
+
+bin_dir="`dirname $0`"
+board_type="$1"
+board_ident="$2"
+hostname="`hostname`"
+
+# Use either the Labgrid integration or the traditional hooks
+if [ -n "${USE_LABGRID_SJG}" ]; then
+	. "${bin_dir}/${hostname}/conf.all"
+else
+	. "${bin_dir}/${hostname}/conf.${board_type}_${board_ident}"
+fi
diff --git a/test/hooks/bin/u-boot-test-console b/test/hooks/bin/u-boot-test-console
new file mode 100755
index 00000000000..8b7377a2aba
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-console
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "$(dirname $0)/u-boot-test-common"
+
+. "${bin_dir}/console.${console_impl:-picocom}"
diff --git a/test/hooks/bin/u-boot-test-flash b/test/hooks/bin/u-boot-test-flash
new file mode 100755
index 00000000000..bd89a50e6a3
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-flash
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "$(dirname $0)/u-boot-test-common"
+
+. "${bin_dir}/flash.${flash_impl}"
diff --git a/test/hooks/bin/u-boot-test-getrole b/test/hooks/bin/u-boot-test-getrole
new file mode 100755
index 00000000000..ac8e02a243c
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-getrole
@@ -0,0 +1,38 @@
+#!/bin/bash
+
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Prints the following pieces of information, each on a separate line
+#
+# - U-Boot board name
+# - source path
+# - build dir
+# - filename of .config file
+#
+# For example
+
+. "$(dirname $0)/u-boot-test-common"
+
+target="$1"
+[ -n "$2" ] && do_configure=1
+
+. "${bin_dir}/getrole.${getrole_impl:-none}"
diff --git a/test/hooks/bin/u-boot-test-power-off b/test/hooks/bin/u-boot-test-power-off
new file mode 100755
index 00000000000..83b69c00486
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-power-off
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "$(dirname $0)/u-boot-test-common"
+
+. "${bin_dir}/poweroff.${power_impl}"
diff --git a/test/hooks/bin/u-boot-test-power-on b/test/hooks/bin/u-boot-test-power-on
new file mode 100755
index 00000000000..5a41c3e2de4
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-power-on
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "$(dirname $0)/u-boot-test-common"
+
+. "${bin_dir}/poweron.${power_impl}"
diff --git a/test/hooks/bin/u-boot-test-release b/test/hooks/bin/u-boot-test-release
new file mode 100755
index 00000000000..5a3a849408b
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-release
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+# Copyright 2024 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "$(dirname $0)/u-boot-test-common"
+
+. "${bin_dir}/release.${release_impl:-none}"
diff --git a/test/hooks/bin/u-boot-test-reset b/test/hooks/bin/u-boot-test-reset
new file mode 100755
index 00000000000..77e3f408d8b
--- /dev/null
+++ b/test/hooks/bin/u-boot-test-reset
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+. "$(dirname $0)/u-boot-test-common"
+
+. "${bin_dir}/reset.${reset_impl}"
diff --git a/test/hooks/bin/wait_raw_device b/test/hooks/bin/wait_raw_device
new file mode 100644
index 00000000000..c2921147651
--- /dev/null
+++ b/test/hooks/bin/wait_raw_device
@@ -0,0 +1,34 @@
+# Copyright 2021 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Wait for the device ${raw_device} to become available
+complete=false
+for i in {0..9}; do
+    if dd if=${raw_device} of=/dev/null count=1 >/dev/null 2>&1; then
+        complete=true
+        break
+    fi
+
+    sleep 1
+done
+if [[ $complete = false ]]; then
+    echo "Failed to access ${raw_device} after 10 tries"
+    exit 1
+fi
diff --git a/test/hooks/bin/writer.imx_raw b/test/hooks/bin/writer.imx_raw
new file mode 100755
index 00000000000..4708bab3ca2
--- /dev/null
+++ b/test/hooks/bin/writer.imx_raw
@@ -0,0 +1,39 @@
+# Copyright 2021 Konsulko Group, All rights reserved.
+# Based on writer.sunxi_raw which is
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Writes raw imx images to the board
+
+# Args:
+#  $1: Device path of the sdcard when board is off (e.g. /dev/sdcard0)
+#  $2: U-Boot build directory
+
+set -e
+
+device=$1
+build=$2
+
+echo "Writing to ${device} from build at ${build}"
+
+# At least partially zero out the previous image
+dd if=/dev/zero of=$device bs=1k seek=1 count=128
+dd if=${build}/u-boot-with-spl.imx of=$device bs=1024 seek=1
+sync $device
diff --git a/test/hooks/bin/writer.labgrid-trini.rpi b/test/hooks/bin/writer.labgrid-trini.rpi
new file mode 100644
index 00000000000..83ce516da29
--- /dev/null
+++ b/test/hooks/bin/writer.labgrid-trini.rpi
@@ -0,0 +1,46 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+. common.labgrid-trini
+set -e
+
+build=${U_BOOT_BUILD_DIR}
+configtxt=`mktemp`
+
+echo "enable_uart=1" | tee ${configtxt}
+echo "kernel=u-boot.bin" | tee -a ${configtxt}
+
+case "${board_type}" in
+rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
+    echo "arm_64bit=1" | tee -a ${configtxt}
+    ;;
+esac
+
+case "${board_ident}" in
+3-32-pl011)
+    echo "dtoverlay=pi3-miniuart-bt" | sudo tee -a ${configtxt}
+    ;;
+esac
+
+labgrid-client write-files -T ${configtxt} config.txt
+labgrid-client write-files -T ${build}/u-boot.bin u-boot.bin
+rm ${configtxt}
+echo "Done writing build"
diff --git a/test/hooks/bin/writer.labgrid-trini.ti-k3 b/test/hooks/bin/writer.labgrid-trini.ti-k3
new file mode 100644
index 00000000000..bcaf7a0536b
--- /dev/null
+++ b/test/hooks/bin/writer.labgrid-trini.ti-k3
@@ -0,0 +1,35 @@
+# Copyright (c) 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Ensure we have all environment variables set
+. common.labgrid-trini
+
+build=${U_BOOT_BUILD_DIR}
+
+if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
+    echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
+    echo "per the board documentation."
+    exit 1
+fi
+echo "Writing build at ${build}"
+labgrid-client write-files -T ${build}/${tispl} tispl.bin
+labgrid-client write-files -T ${build}/${uboot} u-boot.img
+labgrid-client write-files -T ${build/_a??/_r5}/${tiboot3} tiboot3.bin
+echo "Done writing build"
diff --git a/test/hooks/bin/writer.rk3288_raw b/test/hooks/bin/writer.rk3288_raw
new file mode 100755
index 00000000000..f77a04829ca
--- /dev/null
+++ b/test/hooks/bin/writer.rk3288_raw
@@ -0,0 +1,40 @@
+# Copyright 202 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Writes Rockchip RK3288 image to the board
+
+# Args:
+#  $1: Device path of the sdcard when board is off (e.g. /dev/sdcard0)
+#  $2: U-Boot build directory
+
+set -ex
+
+device=$1
+build=$2
+
+tmp=${build}
+
+echo "Writing to ${device} from build at ${build}"
+
+${build}/tools/mkimage -n rk3288 -T rksd -d ${build}/spl/u-boot-spl.bin \
+    ${tmp}/out
+cat ${build}/u-boot-dtb.bin >>${tmp}/out
+dd if=${tmp}/out of=${device} seek=64
+sync
diff --git a/test/hooks/bin/writer.rpi_mount b/test/hooks/bin/writer.rpi_mount
new file mode 100755
index 00000000000..ab7c3b5a243
--- /dev/null
+++ b/test/hooks/bin/writer.rpi_mount
@@ -0,0 +1,43 @@
+# Copyright 2019 Google LLC. All rights reserved.
+# Copyright 2024 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+set -e
+
+build=${U_BOOT_BUILD_DIR}
+
+echo "Writing to ${mount_dir} from build at ${build}"
+
+sudo cp -v ${build}/u-boot.bin ${mount_dir}/u-boot.bin
+
+echo "enable_uart=1" | sudo tee ${mount_dir}/config.txt
+echo "kernel=u-boot.bin" | sudo tee -a ${mount_dir}/config.txt
+
+case "${board_type}" in
+rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
+    echo "arm_64bit=1" | sudo tee -a ${mount_dir}/config.txt
+    ;;
+esac
+
+case "${board_ident}" in
+3-32-pl011)
+    echo "dtoverlay=pi3-miniuart-bt" | sudo tee -a ${mount_dir}/config.txt
+    ;;
+esac
diff --git a/test/hooks/bin/writer.sunxi_raw b/test/hooks/bin/writer.sunxi_raw
new file mode 100755
index 00000000000..faa72b76a4b
--- /dev/null
+++ b/test/hooks/bin/writer.sunxi_raw
@@ -0,0 +1,36 @@
+# Copyright 2019 Google LLC. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Writes sunxi image to the board
+
+# Args:
+#  $1: Device path of the sdcard when board is off (e.g. /dev/sdcard0)
+#  $2: U-Boot build directory
+
+set -ex
+
+device=$1
+build=$2
+
+echo "Writing to ${device} from build at ${build}"
+
+dd if=/dev/zero of=$device bs=1k count=1024
+dd if=${build}/u-boot-sunxi-with-spl.bin of=$device bs=1024 seek=8
+sync $device
diff --git a/test/hooks/bin/writer.ti-k3_mount b/test/hooks/bin/writer.ti-k3_mount
new file mode 100755
index 00000000000..791c77aa09f
--- /dev/null
+++ b/test/hooks/bin/writer.ti-k3_mount
@@ -0,0 +1,36 @@
+# Copyright 2022 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Copies MLO to the filesystem
+
+set -e
+
+build=${U_BOOT_BUILD_DIR}
+
+if [ -z "${tispl}" -o -z "${uboot}" -o -z "${tiboot3}" ]; then
+    echo "Must configure tispl, uboot, tiboot3 and optionally sysfw"
+    echo "per the board documentation."
+    exit 1
+fi
+echo "Writing to ${mount_dir} from build at ${build}"
+sudo cp -v ${build}/${tispl} ${mount_dir}/tispl.bin
+sudo cp -v ${build}/${uboot} ${mount_dir}/u-boot.img
+sudo cp -v ${build/_a??/_r5}/${tiboot3} ${mount_dir}/tiboot3.bin
+[ ! -z "${sysfw}" ] && sudo cp -v ${build/_a??/_r5}/${sysfw} ${mount_dir}/sysfw.itb
diff --git a/test/hooks/bin/writer.ti-omap_mount b/test/hooks/bin/writer.ti-omap_mount
new file mode 100755
index 00000000000..7d1dbee8f65
--- /dev/null
+++ b/test/hooks/bin/writer.ti-omap_mount
@@ -0,0 +1,29 @@
+# Copyright 2022 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Copies MLO to the filesystem
+
+set -e
+
+build=${U_BOOT_BUILD_DIR}
+
+echo "Writing to ${mount_dir} from build at ${build}"
+
+sudo cp ${build}/MLO ${build}/u-boot.img ${mount_dir}/
diff --git a/test/hooks/bin/writer.zynq_mount b/test/hooks/bin/writer.zynq_mount
new file mode 100755
index 00000000000..c8395a40680
--- /dev/null
+++ b/test/hooks/bin/writer.zynq_mount
@@ -0,0 +1,36 @@
+# Copyright 2020 Google LLC
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# Writes zynq images to the board
+
+set -ex
+
+tmp=$(mktemp -d)
+
+build=${U_BOOT_BUILD_DIR}
+
+echo "Writing to ${mount_dir} from build at ${build}"
+
+# Copy U-Boot over from the build directory
+cp ${build}/u-boot.bin ${mount_dir}/rpi3-u-boot.bin
+zynq-boot-bin.py -o ${tmp}/boot.bin -u ${build}/spl/u-boot-spl-dtb.bin
+cp ${tmp}/boot.bin ${mount_dir}/BOOT.bin
+cp ${build}/u-boot.img ${mount_dir}/.
+rm -rf ${tmp}
diff --git a/test/hooks/contrib/src/.gitignore b/test/hooks/contrib/src/.gitignore
new file mode 100644
index 00000000000..36606cf14b4
--- /dev/null
+++ b/test/hooks/contrib/src/.gitignore
@@ -0,0 +1 @@
+phidgets-relay
diff --git a/test/hooks/contrib/src/README.txt b/test/hooks/contrib/src/README.txt
new file mode 100644
index 00000000000..5a4b59d6d91
--- /dev/null
+++ b/test/hooks/contrib/src/README.txt
@@ -0,0 +1,13 @@
+# Don't use libphidgets22 since it's stupid and resets the state of all outputs
+# on open and close.
+wget https://www.phidgets.com/downloads/phidget21/libraries/linux/libphidget/libphidget_2.1.8.20170607.tar.gz
+tar xf libphidget_2.1.8.20170607.tar.gz
+cd libphidget-2.1.8.20170607
+./configure --prefix="${HOME}/phidgets"
+make
+make install
+cd ..
+./build.sh
+mkdir "${HOME}/phidgets/bin"
+cp phidgets-relay "${HOME}/phidgets/bin"
+LD_LIBRARY_PATH="${HOME}/phidgets/lib" "${HOME}/phidgets/bin/phidgets-relay" 109237 2 1
diff --git a/test/hooks/contrib/src/build.sh b/test/hooks/contrib/src/build.sh
new file mode 100755
index 00000000000..53d40eaca07
--- /dev/null
+++ b/test/hooks/contrib/src/build.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+gcc -o phidgets-relay \
+    -I "${HOME}/phidgets/include" \
+    phidgets-relay.c \
+    -L "${HOME}/phidgets/lib" -lphidget21 \
+    -lusb-1.0 -lpthread -ldl -lm
diff --git a/test/hooks/contrib/src/phidgets-relay.c b/test/hooks/contrib/src/phidgets-relay.c
new file mode 100644
index 00000000000..77afd0c60a8
--- /dev/null
+++ b/test/hooks/contrib/src/phidgets-relay.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <phidget21.h>
+
+static void usage(const char *appname) {
+	fprintf(stderr, "usage: %s serial relay_id value\n", appname);
+	exit(1);
+}
+
+static void phidgets_error(const char *func, int err) {
+	int err2;
+	const char* error;
+
+	fprintf(stderr, "%s() failed:\n", func);
+	err2 = CPhidget_getErrorDescription(err, &error);
+	if (err != EPHIDGET_OK) {
+		fprintf(stderr, "\tPCPhidget_getErrorDescription() failed: %d\n", err2);
+		exit(1);
+	}
+
+	fprintf(stderr, "\t%s\n", error);
+	exit(1);
+}
+
+int main(int argc, char **argv) {
+	int serial, relay_id, value, err;
+	CPhidgetInterfaceKitHandle ifk;
+
+	if (argc != 4)
+		usage(argv[0]);
+
+	serial = atoi(argv[1]);
+	relay_id = atoi(argv[2]);
+	value = atoi(argv[3]);
+
+	err = CPhidget_enableLogging(PHIDGET_LOG_VERBOSE, NULL);
+	if (err != EPHIDGET_OK)
+		phidgets_error("CPhidget_enableLogging", err);
+	err = CPhidgetInterfaceKit_create(&ifk);
+	if (err != EPHIDGET_OK)
+		phidgets_error("CPhidgetInterfaceKit_create", err);
+	err = CPhidget_open((CPhidgetHandle)ifk, serial);
+	if (err != EPHIDGET_OK)
+		phidgets_error("CPhidget_open", err);
+	err = CPhidget_waitForAttachment((CPhidgetHandle)ifk, 0);
+	if (err != EPHIDGET_OK)
+		phidgets_error("CPhidget_waitForAttachment", err);
+	err = CPhidgetInterfaceKit_setOutputState(ifk, relay_id, value);
+	if (err != EPHIDGET_OK)
+		phidgets_error("CPhidgetInterfaceKit_setOutputState", err);
+	err = CPhidget_close((CPhidgetHandle)ifk);
+	if (err != EPHIDGET_OK)
+		phidgets_error("CPhidget_close", err);
+	err = CPhidget_delete((CPhidgetHandle)ifk);
+	if (err != EPHIDGET_OK)
+		phidgets_error("CPhidget_delete", err);
+
+	return 0;
+}
diff --git a/test/hooks/contrib/udev/swarren-lx1/99-ubtest.rules b/test/hooks/contrib/udev/swarren-lx1/99-ubtest.rules
new file mode 100644
index 00000000000..ec7c6e4b5ca
--- /dev/null
+++ b/test/hooks/contrib/udev/swarren-lx1/99-ubtest.rules
@@ -0,0 +1,89 @@
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+# One line per physical USB port that is attached to any U-Boot device you
+# wish to test (e.g. serial dongle, flashing device, the board's device-mode
+# port, etc.)
+
+# Jetson TK1 (PM375)
+# Serial console
+ACTION=="add", KERNELS=="ttyS0", ENV{UBTEST_DEVICE}="1", SYMLINK+="console-jetson-tk1"
+# Phidgets control board
+ACTION=="add", SUBSYSTEMS=="usb", DRIVER=="usb", KERNELS=="1-8.7", ENV{UBTEST_DEVICE}="1", SYMLINK+="phidgets-jetson-tk1"
+# Device-mode port
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-8.3", ENV{UBTEST_DEVICE}="1", SYMLINK+="usbdev-jetson-tk1"
+
+# Jetson Nano (p3450-0000)
+# Serial console
+ACTION=="add", SUBSYSTEM=="tty", KERNELS=="1-3.4.4:1.0", ENV{UBTEST_DEVICE}="1", SYMLINK+="console-nano"
+# Device-mode port
+ACTION=="add", SUBSYSTEMS=="usb", DRIVER=="usb", KERNELS=="1-3.2", ENV{UBTEST_DEVICE}="1", SYMLINK+="usbdev-nano"
+
+# Jetson TX1 (P2371-2180)
+# Serial console
+ACTION=="add", SUBSYSTEM=="tty", KERNELS=="1-4:1.2", ENV{UBTEST_DEVICE}="1", SYMLINK+="console-p2371-2180"
+# PM342 debug board
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-4", ENV{UBTEST_DEVICE}="1", SYMLINK+="pm342-p2371-2180"
+# Device-mode port
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-5", ENV{UBTEST_DEVICE}="1", SYMLINK+="usbdev-p2371-2180"
+
+# Jetson TX2 (P2771-0000)
+# Serial console
+ACTION=="add", SUBSYSTEM=="tty", KERNELS=="1-7:1.2", ENV{UBTEST_DEVICE}="1", SYMLINK+="console-p2771-0000"
+# PM342 debug board
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-7", ENV{UBTEST_DEVICE}="1", SYMLINK+="pm342-p2771-0000"
+# Device-mode port
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="3-2", ENV{UBTEST_DEVICE}="1", SYMLINK+="usbdev-p2771-0000"
+
+# Jetson Xavier (B)
+# Serial console
+ACTION=="add", SUBSYSTEM=="tty", KERNELS=="1-8.6:1.3", ENV{UBTEST_DEVICE}="1", SYMLINK+="console-xavier-b"
+# FTDI port
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-8.6", ENV{UBTEST_DEVICE}="1", SYMLINK+="pm342-xavier-b"
+# Device-mode port
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-8.5", ENV{UBTEST_DEVICE}="1", SYMLINK+="usbdev-xavier-b"
+
+# Jetson Xavier (C)
+# Serial console
+ACTION=="add", SUBSYSTEM=="tty", KERNELS=="1-8.4:1.3", ENV{UBTEST_DEVICE}="1", SYMLINK+="console-xavier-c"
+# FTDI port
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-8.4", ENV{UBTEST_DEVICE}="1", SYMLINK+="pm342-xavier-c"
+# Device-mode port
+ACTION=="add", SUBSYSTEMS=="usb", KERNELS=="1-8.2", ENV{UBTEST_DEVICE}="1", SYMLINK+="usbdev-xavier-c"
+
+# NVIDIA's PM342 control scripts search for devices with matching USB vendor
+# and device ID, then check each to verify if it matches the requested serial
+# number. If a USB device node isn't r/w for the user running the script,
+# the device can be enumerated, but the serial number can't be queried. The
+# PM342 scripts (or libftdi/libusb called by them) treat this as an error,
+# which stops the script from looking for further PM342 devices. This will
+# sometimes prevent the scripts seeing a PM342, even if that specific device
+# has permissions that allow the serial number to be read. Fix this by opening
+# the permissions for all PM342 devices. Also note that all PM342 devices (and
+# in fact any FTDI devices at least with the same vid/pid) MUST have a serial
+# number defined; an empty serial number in one device also causes failures
+# finding other devices:-(
+ACTION=="add", SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6011", ENV{UBTEST_DEVICE}="1"
+
+# Configure the port with permissions that will allow the test program to run
+# as an unprivileged user. In the example below, all users are given access.
+# If you need more restrictive permissions, set "OWNER" or "GROUP" instead,
+# and run the test as that user/group.
+ACTION=="add", ENV{UBTEST_DEVICE}=="1", MODE:="666"
diff --git a/test/hooks/py/OLI01/u_boot_boardenv_mx6qsabrelite_na.py b/test/hooks/py/OLI01/u_boot_boardenv_mx6qsabrelite_na.py
new file mode 100644
index 00000000000..e0d990fb250
--- /dev/null
+++ b/test/hooks/py/OLI01/u_boot_boardenv_mx6qsabrelite_na.py
@@ -0,0 +1,39 @@
+# Copyright (c) 2016, Guillaume GARDET. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+env__net_static_env_vars = [
+    ("ethaddr", "00:14:6C:8A:CA:D9"),
+    ("ipaddr", "192.168.2.10"),
+    ("netmask", "255.255.255.0"),
+    ("serverip", "192.168.2.1"),
+    ("tftpserverip", "192.168.2.1"),
+]
+
+env__net_tftp_readable_file = {
+    "fn": "linux.vmx",
+    "size": 7368000,
+    "crc32": "ef74eee2",
+}
+
+env__net_nfs_readable_file = {
+    "fn": "/home/guillaume/nfs/linux.vmx",
+    "size": 7368000,
+    "crc32": "ef74eee2",
+}
diff --git a/test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py b/test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py
new file mode 120000
index 00000000000..d6f7a632f39
--- /dev/null
+++ b/test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py
@@ -0,0 +1 @@
+u_boot_boardenv_rpi_arm64.py
\ No newline at end of file
diff --git a/test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py b/test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py
new file mode 100644
index 00000000000..c7985a53734
--- /dev/null
+++ b/test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py
@@ -0,0 +1,84 @@
+# Copyright (c) 2025, Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+
+env__net_uses_usb = True
+
+env__net_dhcp_server = True
+
+# The file 1MiBtest.bin is created with:
+# dd if=/dev/urandom of=1MiBtest.bin bs=1M count=1
+env__net_tftp_readable_file = {
+    "fn": "1MiBtest.bin",
+    "size": 1048576,
+    "crc32": "2fa737e0",
+    "fnu": "ubtest-upload.bin",
+}
+
+# Extracted from a previous U-Boot build.
+env__efi_loader_helloworld_file = {
+    'fn': 'EFI/arm64/helloworld.efi',
+    'size': 4528,
+    'addr': 0x00200000,
+    'crc32': '2b466005',
+}
+
+# Taken from an existing functional binary elsewhere.
+env__efi_loader_grub_file = {
+    'fn': 'EFI/arm64/grubaa64.efi',
+    'size': 724992,
+    'addr': 0x00200000,
+    'crc32': '8db3f0f1',
+}
+
+env__tftp_boot_test_skip = False
+
+# A build of upstream v6.13 arm64 defconfig and image.fit
+env__net_tftp_bootable_file = {
+    'timeout': 50000,
+    'addr': 0x00200000,
+    'fn': 'v6.13/image.fit.arm64',
+    'size': 28574720,
+    'crc32': '8513595c',
+    'pattern': 'Booting Linux on physical CPU',
+}
+
+# Based on the explanation in test/py/tests/test_net_boot.py
+env__net_pxe_bootable_file = {
+    'fn': 'default',
+    'addr': 0x00200000,
+    'size': 64,
+    'timeout': 50000,
+    'pattern': 'Linux',
+    'valid_label': '1',
+    'invalid_label': '2',
+    'exp_str_invalid': 'Skipping install for failure retrieving',
+    'local_label': '3',
+    'exp_str_local': 'missing environment variable: localcmd',
+    'empty_label': '4',
+    'exp_str_empty': 'No kernel given, skipping boot',
+}
+env__pxe_boot_test_skip = False
+
+env__bootstage_cmd_file = {
+    'addr': 0x2400000,
+    'size': 0x1000,
+    'bootstage_magic_addr': 0xb00757a3,
+}
diff --git a/test/hooks/py/swarren-lx1/u_boot_boardenv_jetson_tk1_na.py b/test/hooks/py/swarren-lx1/u_boot_boardenv_jetson_tk1_na.py
new file mode 100644
index 00000000000..6d1e424c9f1
--- /dev/null
+++ b/test/hooks/py/swarren-lx1/u_boot_boardenv_jetson_tk1_na.py
@@ -0,0 +1,110 @@
+# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+env__mount_points = (
+    "/mnt/ubtest-mnt-jetson-tk1-na",
+)
+
+env__usb_dev_ports = (
+    {
+        "fixture_id": "micro_b",
+        "tgt_usb_ctlr": "0",
+        "host_ums_dev_node": "/dev/disk/by-path/pci-0000:00:14.0-usb-0:8.3:1.0-scsi-0:0:0:0",
+        "host_usb_dev_node": "/dev/usbdev-jetson-tk1",
+        "host_usb_port_path": "1-8.3",
+    },
+)
+
+env__block_devs = (
+    # SD card; present since I plugged one in
+    {
+        "fixture_id": "sd",
+        "type": "mmc",
+        "id": "1",
+        "writable_fs_partition": 1,
+        "writable_fs_subdir": "tmp/",
+    },
+    # eMMC; always present
+    {
+        "fixture_id": "emmc",
+        "type": "mmc",
+        "id": "0",
+    },
+)
+
+env__dfu_configs = (
+    # SD card, partition 1, ext4 filesystem
+    {
+        "fixture_id": "sd_fs",
+        "alt_info": "/dfu_test.bin ext4 1 1;/dfu_dummy.bin ext4 1 1",
+        "cmd_params": "mmc 1",
+        "test_sizes": (
+            64 - 1,
+            64,
+            64 + 1,
+            4096 - 1,
+        ),
+    },
+    # SD card, partition 3, partition
+    {
+        "fixture_id": "sd_part",
+        "alt_info": "/dfu_test.bin part 1 3;/dfu_dummy.bin ext4 1 1",
+        "cmd_params": "mmc 1",
+        "test_sizes": (
+            128 - 1,
+            128,
+            128 + 1,
+            4096,
+        ),
+    },
+    # SD card, partition 3, raw device (location overlays partition 3)
+    {
+        "fixture_id": "sd_raw",
+        "alt_info": "/dfu_test.bin raw 4196352 18432;/dfu_dummy.bin ext4 1 1",
+        "cmd_params": "mmc 1",
+        "test_sizes": (
+            960 - 1,
+            960,
+            960 + 1,
+            4096 + 1,
+        ),
+    },
+    # RAM
+    {
+        "fixture_id": "ram",
+        "alt_info": "alt0 ram 80000000 01000000;alt1 ram 81000000 01000000",
+        "cmd_params": "ram na",
+        "test_sizes": (
+            1024 * 1024 - 1,
+            1024 * 1024,
+            8 * 1024 * 1024,
+        ),
+    },
+)
+
+env__net_uses_pci = True
+
+env__net_dhcp_server = True
+
+env__net_tftp_readable_file = {
+    "fn": "ubtest-readable.bin",
+    "size": 5058624,
+    "crc32": "c2244b26",
+}
diff --git a/test/hooks/py/swarren-lx1/u_boot_boardenv_p2371_2180_na.py b/test/hooks/py/swarren-lx1/u_boot_boardenv_p2371_2180_na.py
new file mode 100644
index 00000000000..25ad0d4326d
--- /dev/null
+++ b/test/hooks/py/swarren-lx1/u_boot_boardenv_p2371_2180_na.py
@@ -0,0 +1,110 @@
+# Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+env__mount_points = (
+    "/mnt/ubtest-mnt-p2371-2180-na",
+)
+
+env__usb_dev_ports = (
+    {
+        "fixture_id": "micro_b",
+        "tgt_usb_ctlr": "0",
+        "host_ums_dev_node": "/dev/disk/by-path/pci-0000:00:14.0-usb-0:5:1.0-scsi-0:0:0:0",
+        "host_usb_dev_node": "/dev/usbdev-p2371-2180",
+        "host_usb_port_path": "1-5",
+    },
+)
+
+env__block_devs = (
+    # SD card; present since I plugged one in
+    {
+        "fixture_id": "sd",
+        "type": "mmc",
+        "id": "1",
+        "writable_fs_partition": 1,
+        "writable_fs_subdir": "tmp/",
+    },
+    # eMMC; always present
+    {
+        "fixture_id": "emmc",
+        "type": "mmc",
+        "id": "0",
+    },
+)
+
+env__dfu_configs = (
+    # SD card, partition 1, ext4 filesystem
+    {
+        "fixture_id": "sd_fs",
+        "alt_info": "/dfu_test.bin ext4 1 1;/dfu_dummy.bin ext4 1 1",
+        "cmd_params": "mmc 1",
+        "test_sizes": (
+            64 - 1,
+            64,
+            64 + 1,
+            4096 - 1,
+        ),
+    },
+    # SD card, partition 3, partition
+    {
+        "fixture_id": "sd_part",
+        "alt_info": "/dfu_test.bin part 1 3;/dfu_dummy.bin ext4 1 1",
+        "cmd_params": "mmc 1",
+        "test_sizes": (
+            128 - 1,
+            128,
+            128 + 1,
+            4096,
+        ),
+    },
+    # SD card, partition 3, raw device (location overlays partition 3)
+    {
+        "fixture_id": "sd_raw",
+        "alt_info": "/dfu_test.bin raw 4196352 18432;/dfu_dummy.bin ext4 1 1",
+        "cmd_params": "mmc 1",
+        "test_sizes": (
+            960 - 1,
+            960,
+            960 + 1,
+            4096 + 1,
+        ),
+    },
+    # RAM
+    {
+        "fixture_id": "ram",
+        "alt_info": "alt0 ram 80000000 01000000;alt1 ram 81000000 01000000",
+        "cmd_params": "ram na",
+        "test_sizes": (
+            1024 * 1024 - 1,
+            1024 * 1024,
+            8 * 1024 * 1024,
+        ),
+    },
+)
+
+env__net_uses_pci = True
+
+env__net_dhcp_server = True
+
+env__net_tftp_readable_file = {
+    "fn": "ubtest-readable.bin",
+    "size": 5058624,
+    "crc32": "c2244b26",
+}
diff --git a/test/hooks/py/swarren-lx1/u_boot_boardenv_p2771_0000_500_na.py b/test/hooks/py/swarren-lx1/u_boot_boardenv_p2771_0000_500_na.py
new file mode 100644
index 00000000000..84283cebde4
--- /dev/null
+++ b/test/hooks/py/swarren-lx1/u_boot_boardenv_p2771_0000_500_na.py
@@ -0,0 +1,73 @@
+# Copyright (c) 2015-2018, NVIDIA CORPORATION. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+env__net_uses_pci = False
+
+env__net_dhcp_server = True
+
+env__net_tftp_readable_file = {
+    "fn": "ubtest-readable.bin",
+    "size": 5058624,
+    "crc32": "c2244b26",
+}
+
+env__mmc_rd_configs = (
+    {
+        "fixture_id": "emmc-boot0",
+        "is_emmc": True,
+        "devid": 0,
+        "partid": 1,
+        "sector": 0x10,
+        "count": 1,
+    },
+    {
+        "fixture_id": "emmc-boot1",
+        "is_emmc": True,
+        "devid": 0,
+        "partid": 2,
+        "sector": 0x10,
+        "count": 1,
+    },
+    {
+        "fixture_id": "emmc-data",
+        "is_emmc": True,
+        "devid": 0,
+        "partid": 0,
+        "sector": 0x10,
+        "count": 0x1000,
+    },
+    {
+        "fixture_id": "sd-mbr",
+        "is_emmc": False,
+        "devid": 1,
+        "partid": None,
+        "sector": 0,
+        "count": 1,
+        "crc32": "8f6ecf0d",
+    },
+    {
+        "fixture_id": "sd-large",
+        "is_emmc": False,
+        "devid": 1,
+        "partid": None,
+        "sector": 0x10,
+        "count": 0x1000,
+    },
+)
diff --git a/test/hooks/py/travis-ci/travis_tftp.py b/test/hooks/py/travis-ci/travis_tftp.py
new file mode 100644
index 00000000000..3e1f11d3956
--- /dev/null
+++ b/test/hooks/py/travis-ci/travis_tftp.py
@@ -0,0 +1,31 @@
+import os
+import binascii
+
+def file2env(file_name, addr=None):
+    """Create dictionary describing file
+
+    @filename:  name of the file to be described
+    @addr:      address used for loading the file as int (e.g. 0x40400000)
+    Return:     dictionary describing the file with entries
+                * fn    - filename
+                * size  - file size in bytes
+                * crc32 - checksum using CRC-32 algorithm
+                * addr  - loading address, optional
+    """
+    file_full = os.environ['UBOOT_TRAVIS_BUILD_DIR'] + "/" + file_name
+
+    if not os.path.isfile(file_full):
+        return None
+
+    ret = {
+        "fn": file_name,
+        "size": os.path.getsize(file_full),
+    }
+
+    with open(file_full, 'rb') as fd:
+        ret["crc32"] = hex(binascii.crc32(fd.read()) & 0xffffffff)[2:]
+
+    if addr is not None:
+        ret['addr'] = addr
+
+    return ret
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py
new file mode 100644
index 00000000000..4e100cd410d
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py
@@ -0,0 +1,6 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = False
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py
new file mode 100644
index 00000000000..f4b6b2728b3
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py
@@ -0,0 +1,5 @@
+import travis_tftp
+
+env__spl_skipped = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2600_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2600_qemu.py
new file mode 100644
index 00000000000..396261efa3a
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2600_qemu.py
@@ -0,0 +1,4 @@
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_malta64_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_malta64_qemu.py
new file mode 100644
index 00000000000..5cc141fa1cd
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_malta64_qemu.py
@@ -0,0 +1,5 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot', 0xffffffff81000000)
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_malta64el_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_malta64el_qemu.py
new file mode 100644
index 00000000000..5cc141fa1cd
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_malta64el_qemu.py
@@ -0,0 +1,5 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot', 0xffffffff81000000)
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_malta_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_malta_qemu.py
new file mode 100644
index 00000000000..af9ea6d5439
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_malta_qemu.py
@@ -0,0 +1,5 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot', 0x81000000)
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_maltael_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_maltael_qemu.py
new file mode 100644
index 00000000000..af9ea6d5439
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_maltael_qemu.py
@@ -0,0 +1,5 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot', 0x81000000)
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_ae3xx_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_ae3xx_na.py
new file mode 100644
index 00000000000..97272d548fb
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_ae3xx_na.py
@@ -0,0 +1,6 @@
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_na.py
new file mode 100644
index 00000000000..8e1a7709ec8
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_na.py
@@ -0,0 +1,12 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot.bin', 0x40400000)
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi', 0x40400000)
+env__efi_loader_grub_file = travis_tftp.file2env('grub_arm64.efi', 0x40400000)
+env__efi_fit_tftp_file = {
+    'addr' : 0x40400000,
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
new file mode 100644
index 00000000000..5746b37dbcf
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot.bin', 0x40400000)
+env__efi_fit_tftp_file = {
+    'addr' : 0x40400000,
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm_na.py
new file mode 100644
index 00000000000..718c87bbe14
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm_na.py
@@ -0,0 +1,12 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot.bin', 0x40400000)
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi', 0x40400000)
+env__efi_loader_grub_file = travis_tftp.file2env('grub_arm.efi', 0x40400000)
+env__efi_fit_tftp_file = {
+    'addr' : 0x40400000,
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_ax25_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_ax25_na.py
new file mode 100644
index 00000000000..97272d548fb
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_ax25_na.py
@@ -0,0 +1,6 @@
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
new file mode 100644
index 00000000000..8a9f747f045
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
@@ -0,0 +1,11 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_loongarch64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_na.py
new file mode 100644
index 00000000000..ba6c12249a7
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv32.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_spl_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_spl_na.py
new file mode 100644
index 00000000000..ba6c12249a7
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_spl_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv32.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_na.py
new file mode 100644
index 00000000000..a86e0bd42a6
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_spl_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_spl_na.py
new file mode 100644
index 00000000000..a86e0bd42a6
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_spl_na.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_64_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_64_na.py
new file mode 100644
index 00000000000..a50d60d9b4c
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_64_na.py
@@ -0,0 +1,12 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_check_smbios = True
+env__efi_loader_grub_file = travis_tftp.file2env('grub_x64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_na.py
new file mode 100644
index 00000000000..e2e795b1c10
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_na.py
@@ -0,0 +1,12 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_check_smbios = True
+env__efi_loader_grub_file = travis_tftp.file2env('grub_x86.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
new file mode 100644
index 00000000000..8fdb24b284c
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
@@ -0,0 +1,6 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_i82557c_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_i82557c_qemu.py
new file mode 100644
index 00000000000..8fdb24b284c
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_i82557c_qemu.py
@@ -0,0 +1,6 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_pcnet_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_pcnet_qemu.py
new file mode 100644
index 00000000000..8fdb24b284c
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_pcnet_qemu.py
@@ -0,0 +1,6 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_rtl8139_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_rtl8139_qemu.py
new file mode 100644
index 00000000000..8fdb24b284c
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_rtl8139_qemu.py
@@ -0,0 +1,6 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_tulip_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_tulip_qemu.py
new file mode 100644
index 00000000000..8fdb24b284c
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_tulip_qemu.py
@@ -0,0 +1,6 @@
+import os
+import travis_tftp
+
+env__net_uses_pci = True
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_sdcard_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_sdcard_qemu.py
new file mode 100644
index 00000000000..a86e0bd42a6
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_sdcard_qemu.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py
new file mode 100644
index 00000000000..a86e0bd42a6
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_riscv64.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca15_tc2_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca15_tc2_qemu.py
new file mode 100644
index 00000000000..ffb84d6a242
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca15_tc2_qemu.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_arm.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca9x4_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca9x4_qemu.py
new file mode 100644
index 00000000000..ffb84d6a242
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca9x4_qemu.py
@@ -0,0 +1,10 @@
+import os
+import travis_tftp
+
+env__net_dhcp_server = True
+env__net_tftp_readable_file = travis_tftp.file2env('u-boot')
+env__efi_loader_helloworld_file = travis_tftp.file2env('lib/efi_loader/helloworld.efi')
+env__efi_loader_grub_file = travis_tftp.file2env('grub_arm.efi')
+env__efi_fit_tftp_file = {
+    "dn" : os.environ['UBOOT_TRAVIS_BUILD_DIR'],
+}
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py
new file mode 100644
index 00000000000..6fd75071ce0
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py
@@ -0,0 +1 @@
+env__tpm_device_test_skip=True
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
new file mode 100644
index 00000000000..42685ad42d9
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
@@ -0,0 +1,3 @@
+env__spl_skipped = True
+env__saveenv_test_skip = True
+env__reset_test_skip = True
diff --git a/test/hooks/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py b/test/hooks/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
new file mode 100644
index 00000000000..42685ad42d9
--- /dev/null
+++ b/test/hooks/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
@@ -0,0 +1,3 @@
+env__spl_skipped = True
+env__saveenv_test_skip = True
+env__reset_test_skip = True
-- 
2.43.0

