Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF0D65C6D
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C72289612;
	Thu, 14 Nov 2024 11:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p1iNZpLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA83489607; Thu, 14 Nov 2024 11:35:23 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BB1895B7
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 11:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 53B5740039; 
 Thu, 14 Nov 2024 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731580515;
 bh=O+lVxkEXSzFMn+6grKBh9+KWBMZWVv0/Z3bqa55P+ME=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=p1iNZpLXnbUafxMRqP6fanmFYDLmpo4h2AZ5pJZKX5T6Z6dS2dlYsD2hQ41NqdjTC
 tcV9hT72NIpeG3nJn8+HYoubYUDbGpnui9/BO54/FwGicwhd2a5IfDb0KVMMH3CIvo
 s/foGi09ZaCIZ9pLHyzI0AtGRvLsdwiMHpbAluKQPIYIWRs6OR9/T5MpOwE5B+Bdgp
 sJFSPiyG//7UdGyRQJSVLnYbWMwoK9QZQ9X3/ENTlZROyfm4l9dEyUaIbQCJV4g28q
 W7Yq7Orj5R3E4p1JA9s7wDTIVjyzwnjlewBlrDHEBmLrEN0BJtREvbFO/MI2QFWRh1
 LN3whm1AAT20A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: replace invalid GPL-2.0+ SPDX identifier
Date: Thu, 14 Nov 2024 11:34:59 +0100
Message-ID: <20241114103501.10014-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Nov 2024 11:38:48 +0100
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

GPL-2.0-or-later is the correct spelling of the SPDX specifier.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/README.autoboot                                   | 2 +-
 doc/README.console                                    | 2 +-
 doc/README.dfutftp                                    | 2 +-
 doc/README.esbc_validate                              | 2 +-
 doc/README.gpt                                        | 2 +-
 doc/README.iomux                                      | 2 +-
 doc/README.mediatek                                   | 2 +-
 doc/README.nand                                       | 2 +-
 doc/README.power-framework                            | 2 +-
 doc/README.pxe                                        | 2 +-
 doc/README.rockchip                                   | 2 +-
 doc/README.usb                                        | 2 +-
 doc/README.video                                      | 2 +-
 doc/android/ab.rst                                    | 2 +-
 doc/android/avb2.rst                                  | 2 +-
 doc/android/bcb.rst                                   | 2 +-
 doc/android/boot-image.rst                            | 2 +-
 doc/android/fastboot-protocol.rst                     | 2 +-
 doc/android/fastboot.rst                              | 2 +-
 doc/android/index.rst                                 | 2 +-
 doc/api/bootcount.rst                                 | 2 +-
 doc/api/clk.rst                                       | 2 +-
 doc/api/dfu.rst                                       | 2 +-
 doc/api/dm.rst                                        | 2 +-
 doc/api/efi.rst                                       | 2 +-
 doc/api/event.rst                                     | 2 +-
 doc/api/getopt.rst                                    | 2 +-
 doc/api/index.rst                                     | 2 +-
 doc/api/interrupt.rst                                 | 2 +-
 doc/api/led.rst                                       | 2 +-
 doc/api/linker_lists.rst                              | 2 +-
 doc/api/lmb.rst                                       | 2 +-
 doc/api/logging.rst                                   | 2 +-
 doc/api/nvmem.rst                                     | 2 +-
 doc/api/part.rst                                      | 2 +-
 doc/api/pinctrl.rst                                   | 2 +-
 doc/api/rng.rst                                       | 2 +-
 doc/api/sandbox.rst                                   | 2 +-
 doc/api/serial.rst                                    | 2 +-
 doc/api/sysreset.rst                                  | 2 +-
 doc/api/timer.rst                                     | 2 +-
 doc/api/unicode.rst                                   | 2 +-
 doc/arch/arc.rst                                      | 2 +-
 doc/arch/arm64.ffa.rst                                | 2 +-
 doc/arch/arm64.rst                                    | 2 +-
 doc/arch/index.rst                                    | 2 +-
 doc/arch/m68k.rst                                     | 2 +-
 doc/arch/mips.rst                                     | 2 +-
 doc/arch/nios2.rst                                    | 2 +-
 doc/arch/riscv.rst                                    | 2 +-
 doc/arch/sandbox/block_impl.rst                       | 2 +-
 doc/arch/sandbox/index.rst                            | 2 +-
 doc/arch/sandbox/sandbox.rst                          | 2 +-
 doc/arch/sh.rst                                       | 2 +-
 doc/arch/x86/index.rst                                | 2 +-
 doc/arch/x86/x86.rst                                  | 2 +-
 doc/arch/xtensa.rst                                   | 2 +-
 doc/board/actions/cubieboard7.rst                     | 2 +-
 doc/board/actions/index.rst                           | 2 +-
 doc/board/advantech/imx8qm-dmsse20-a1.rst             | 2 +-
 doc/board/advantech/imx8qm-rom7720-a1.rst             | 2 +-
 doc/board/advantech/index.rst                         | 2 +-
 doc/board/allwinner/index.rst                         | 2 +-
 doc/board/allwinner/sunxi.rst                         | 2 +-
 doc/board/amlogic/aml-a311d-cc.rst                    | 2 +-
 doc/board/amlogic/aml-s905d3-cc.rst                   | 2 +-
 doc/board/amlogic/bananapi-cm4io.rst                  | 2 +-
 doc/board/amlogic/bananapi-m2pro.rst                  | 2 +-
 doc/board/amlogic/bananapi-m2s.rst                    | 2 +-
 doc/board/amlogic/bananapi-m5.rst                     | 2 +-
 doc/board/amlogic/beelink-gskingx.rst                 | 2 +-
 doc/board/amlogic/beelink-gt1-ultimate.rst            | 2 +-
 doc/board/amlogic/beelink-gtking.rst                  | 2 +-
 doc/board/amlogic/beelink-gtkingpro.rst               | 2 +-
 doc/board/amlogic/boot-flow.rst                       | 2 +-
 doc/board/amlogic/index.rst                           | 2 +-
 doc/board/amlogic/jethub-j100.rst                     | 2 +-
 doc/board/amlogic/jethub-j80.rst                      | 2 +-
 doc/board/amlogic/khadas-vim.rst                      | 2 +-
 doc/board/amlogic/khadas-vim2.rst                     | 2 +-
 doc/board/amlogic/khadas-vim3.rst                     | 2 +-
 doc/board/amlogic/khadas-vim3l.rst                    | 2 +-
 doc/board/amlogic/libretech-ac.rst                    | 2 +-
 doc/board/amlogic/libretech-cc.rst                    | 2 +-
 doc/board/amlogic/nanopi-k2.rst                       | 2 +-
 doc/board/amlogic/odroid-c2.rst                       | 2 +-
 doc/board/amlogic/odroid-c4.rst                       | 2 +-
 doc/board/amlogic/odroid-go-ultra.rst                 | 2 +-
 doc/board/amlogic/odroid-hc4.rst                      | 2 +-
 doc/board/amlogic/odroid-n2.rst                       | 2 +-
 doc/board/amlogic/odroid-n2l.rst                      | 2 +-
 doc/board/amlogic/p200.rst                            | 2 +-
 doc/board/amlogic/p201.rst                            | 2 +-
 doc/board/amlogic/p212.rst                            | 2 +-
 doc/board/amlogic/pre-generated-fip.rst               | 7 ++++---
 doc/board/amlogic/q200.rst                            | 2 +-
 doc/board/amlogic/radxa-zero.rst                      | 2 +-
 doc/board/amlogic/radxa-zero2.rst                     | 2 +-
 doc/board/amlogic/s400.rst                            | 2 +-
 doc/board/amlogic/sei510.rst                          | 2 +-
 doc/board/amlogic/sei610.rst                          | 2 +-
 doc/board/amlogic/u200.rst                            | 2 +-
 doc/board/amlogic/videostrong-kii-pro.rst             | 2 +-
 doc/board/amlogic/w400.rst                            | 2 +-
 doc/board/amlogic/wetek-core2.rst                     | 2 +-
 doc/board/amlogic/wetek-hub.rst                       | 2 +-
 doc/board/amlogic/wetek-play2.rst                     | 2 +-
 doc/board/anbernic/index.rst                          | 2 +-
 doc/board/anbernic/rgxx3.rst                          | 2 +-
 doc/board/andestech/adp-ag101p.rst                    | 2 +-
 doc/board/andestech/ae350.rst                         | 2 +-
 doc/board/andestech/index.rst                         | 2 +-
 doc/board/apple/index.rst                             | 2 +-
 doc/board/apple/m1.rst                                | 2 +-
 doc/board/aspeed/ibex-ast2700.rst                     | 2 +-
 doc/board/aspeed/index.rst                            | 2 +-
 doc/board/asus/grouper.rst                            | 2 +-
 doc/board/asus/index.rst                              | 2 +-
 doc/board/asus/transformer_t20.rst                    | 2 +-
 doc/board/asus/transformer_t30.rst                    | 2 +-
 doc/board/atmel/at91ek.rst                            | 2 +-
 doc/board/atmel/index.rst                             | 2 +-
 doc/board/beacon/beacon-imx8mm.rst                    | 2 +-
 doc/board/beacon/beacon-imx8mn.rst                    | 2 +-
 doc/board/beacon/beacon-imx8mp.rst                    | 2 +-
 doc/board/beacon/index.rst                            | 2 +-
 doc/board/beagle/am62x_beagleplay.rst                 | 2 +-
 doc/board/beagle/index.rst                            | 2 +-
 doc/board/beagle/j721e_beagleboneai64.rst             | 2 +-
 doc/board/broadcom/bcm7xxx.rst                        | 2 +-
 doc/board/broadcom/index.rst                          | 2 +-
 doc/board/broadcom/northstar.rst                      | 2 +-
 doc/board/broadcom/raspberrypi.rst                    | 2 +-
 doc/board/bsh/imx8mn_bsh_smm_s2.rst                   | 2 +-
 doc/board/bsh/index.rst                               | 2 +-
 doc/board/cloos/imx8mm_phg.rst                        | 2 +-
 doc/board/cloos/index.rst                             | 2 +-
 doc/board/congatec/cgtqmx8.rst                        | 2 +-
 doc/board/congatec/index.rst                          | 2 +-
 doc/board/coolpi/genbook_cm5_rk3588.rst               | 2 +-
 doc/board/coolpi/index.rst                            | 2 +-
 doc/board/coreboot/coreboot.rst                       | 2 +-
 doc/board/coreboot/index.rst                          | 2 +-
 doc/board/emcraft/index.rst                           | 2 +-
 doc/board/emulation/acpi.rst                          | 2 +-
 doc/board/emulation/blkdev.rst                        | 2 +-
 doc/board/emulation/index.rst                         | 2 +-
 doc/board/emulation/qemu-arm.rst                      | 2 +-
 doc/board/emulation/qemu-mips.rst                     | 2 +-
 doc/board/emulation/qemu-ppce500.rst                  | 2 +-
 doc/board/emulation/qemu-riscv.rst                    | 2 +-
 doc/board/emulation/qemu-sbsa.rst                     | 2 +-
 doc/board/emulation/qemu-x86.rst                      | 2 +-
 doc/board/emulation/qemu-xtensa.rst                   | 2 +-
 doc/board/gateworks/imx8mm_venice.rst                 | 2 +-
 doc/board/gateworks/imx8mn_venice.rst                 | 2 +-
 doc/board/gateworks/imx8mp_venice.rst                 | 2 +-
 doc/board/gateworks/index.rst                         | 2 +-
 doc/board/google/chromebook_coral.rst                 | 2 +-
 doc/board/google/chromebook_link.rst                  | 2 +-
 doc/board/google/chromebook_samus.rst                 | 2 +-
 doc/board/google/index.rst                            | 2 +-
 doc/board/highbank/index.rst                          | 2 +-
 doc/board/htc/endeavoru.rst                           | 2 +-
 doc/board/htc/index.rst                               | 2 +-
 doc/board/index.rst                                   | 2 +-
 doc/board/intel/bayleybay.rst                         | 2 +-
 doc/board/intel/cherryhill.rst                        | 2 +-
 doc/board/intel/cougarcanyon2.rst                     | 2 +-
 doc/board/intel/crownbay.rst                          | 2 +-
 doc/board/intel/edison.rst                            | 2 +-
 doc/board/intel/galileo.rst                           | 2 +-
 doc/board/intel/index.rst                             | 2 +-
 doc/board/intel/minnowmax.rst                         | 2 +-
 doc/board/intel/slimbootloader.rst                    | 2 +-
 doc/board/kontron/index.rst                           | 2 +-
 doc/board/kontron/pitx-imx8m.rst                      | 2 +-
 doc/board/kontron/sl-mx6ul.rst                        | 2 +-
 doc/board/kontron/sl-mx8mm.rst                        | 2 +-
 doc/board/kontron/sl28.rst                            | 2 +-
 doc/board/lenovo/ideapad-yoga-11.rst                  | 2 +-
 doc/board/lenovo/index.rst                            | 2 +-
 doc/board/lg/index.rst                                | 2 +-
 doc/board/lg/x3_t30.rst                               | 2 +-
 doc/board/mediatek/index.rst                          | 2 +-
 doc/board/microchip/index.rst                         | 2 +-
 doc/board/microchip/mpfs_icicle.rst                   | 2 +-
 doc/board/microsoft/index.rst                         | 2 +-
 doc/board/microsoft/surface-rt.rst                    | 2 +-
 doc/board/nxp/imx8mm_evk.rst                          | 2 +-
 doc/board/nxp/imx8mn_evk.rst                          | 2 +-
 doc/board/nxp/imx8mp_evk.rst                          | 2 +-
 doc/board/nxp/imx8mq_evk.rst                          | 2 +-
 doc/board/nxp/imx8qxp_mek.rst                         | 2 +-
 doc/board/nxp/imx8ulp_evk.rst                         | 2 +-
 doc/board/nxp/imx93_11x11_evk.rst                     | 2 +-
 doc/board/nxp/imx93_9x9_qsb.rst                       | 2 +-
 doc/board/nxp/imxrt1020-evk.rst                       | 2 +-
 doc/board/nxp/imxrt1050-evk.rst                       | 2 +-
 doc/board/nxp/index.rst                               | 2 +-
 doc/board/nxp/ls1046ardb.rst                          | 2 +-
 doc/board/nxp/mx6sabreauto.rst                        | 2 +-
 doc/board/nxp/mx6sabresd.rst                          | 2 +-
 doc/board/nxp/mx6ul_14x14_evk.rst                     | 2 +-
 doc/board/nxp/mx6ullevk.rst                           | 2 +-
 doc/board/openpiton/index.rst                         | 2 +-
 doc/board/openpiton/riscv64.rst                       | 2 +-
 doc/board/phytec/imx8mm-phygate-tauri-l.rst           | 2 +-
 doc/board/phytec/imx93-phyboard-segin.rst             | 2 +-
 doc/board/phytec/index.rst                            | 2 +-
 doc/board/phytec/phycore-am62x.rst                    | 2 +-
 doc/board/phytec/phycore-am64x.rst                    | 2 +-
 doc/board/phytec/phycore-imx8mm.rst                   | 2 +-
 doc/board/phytec/phycore-imx8mp.rst                   | 2 +-
 doc/board/purism/index.rst                            | 2 +-
 doc/board/purism/librem5.rst                          | 2 +-
 doc/board/qnap/index.rst                              | 2 +-
 doc/board/qnap/ts433.rst                              | 2 +-
 doc/board/qualcomm/board.rst                          | 2 +-
 doc/board/qualcomm/debugging.rst                      | 2 +-
 doc/board/qualcomm/dragonboard410c.rst                | 2 +-
 doc/board/qualcomm/index.rst                          | 2 +-
 doc/board/qualcomm/rb3gen2.rst                        | 2 +-
 doc/board/renesas/index.rst                           | 2 +-
 doc/board/renesas/renesas.rst                         | 2 +-
 doc/board/renesas/rzn1.rst                            | 2 +-
 doc/board/rockchip/index.rst                          | 2 +-
 doc/board/rockchip/rkmtd.rst                          | 2 +-
 doc/board/rockchip/rockchip.rst                       | 2 +-
 doc/board/samsung/axy17lte.rst                        | 2 +-
 doc/board/samsung/e850-96.rst                         | 2 +-
 doc/board/samsung/index.rst                           | 2 +-
 doc/board/schneider/hmibsc.rst                        | 2 +-
 doc/board/schneider/index.rst                         | 2 +-
 doc/board/sielaff/imx6dl-sielaff.rst                  | 2 +-
 doc/board/sielaff/index.rst                           | 2 +-
 doc/board/siemens/index.rst                           | 2 +-
 doc/board/siemens/iot2050.rst                         | 2 +-
 doc/board/sifive/index.rst                            | 2 +-
 doc/board/sifive/unleashed.rst                        | 2 +-
 doc/board/sifive/unmatched.rst                        | 2 +-
 doc/board/sipeed/index.rst                            | 2 +-
 doc/board/sipeed/maix.rst                             | 2 +-
 doc/board/socionext/developerbox.rst                  | 2 +-
 doc/board/socionext/index.rst                         | 2 +-
 doc/board/sophgo/index.rst                            | 2 +-
 doc/board/sophgo/milkv_duo.rst                        | 2 +-
 doc/board/st/index.rst                                | 2 +-
 doc/board/st/st-dt.rst                                | 2 +-
 doc/board/st/stm32_MCU.rst                            | 2 +-
 doc/board/st/stm32mp1.rst                             | 2 +-
 doc/board/starfive/index.rst                          | 2 +-
 doc/board/starfive/milk-v_mars.rst                    | 2 +-
 doc/board/starfive/milk-v_mars_cm.rst                 | 2 +-
 doc/board/starfive/pine64_star64.rst                  | 2 +-
 doc/board/starfive/visionfive2.rst                    | 2 +-
 doc/board/ste/index.rst                               | 2 +-
 doc/board/ste/stemmy.rst                              | 2 +-
 doc/board/tbs/index.rst                               | 2 +-
 doc/board/thead/index.rst                             | 2 +-
 doc/board/thead/lpi4a.rst                             | 2 +-
 doc/board/theobroma-systems/index.rst                 | 2 +-
 doc/board/theobroma-systems/jaguar_rk3588.rst         | 2 +-
 doc/board/theobroma-systems/puma_rk3399.rst           | 2 +-
 doc/board/theobroma-systems/ringneck_px30.rst         | 2 +-
 doc/board/theobroma-systems/tiger_rk3588.rst          | 2 +-
 doc/board/ti/am335x_evm.rst                           | 2 +-
 doc/board/ti/am43xx_evm.rst                           | 2 +-
 doc/board/ti/am62ax_sk.rst                            | 2 +-
 doc/board/ti/am62px_sk.rst                            | 2 +-
 doc/board/ti/am62x_sk.rst                             | 2 +-
 doc/board/ti/am64x_evm.rst                            | 2 +-
 doc/board/ti/am65x_evm.rst                            | 2 +-
 doc/board/ti/dra7xx_evm.rst                           | 2 +-
 doc/board/ti/index.rst                                | 2 +-
 doc/board/ti/j7200_evm.rst                            | 2 +-
 doc/board/ti/j721e_evm.rst                            | 2 +-
 doc/board/ti/j721s2_evm.rst                           | 2 +-
 doc/board/ti/j722s_evm.rst                            | 2 +-
 doc/board/ti/k3.rst                                   | 2 +-
 doc/board/ti/ks2_evm.rst                              | 2 +-
 doc/board/toradex/index.rst                           | 2 +-
 doc/board/variscite/imx8mn_var_som.rst                | 2 +-
 doc/board/variscite/imx93_var_som.rst                 | 2 +-
 doc/board/variscite/index.rst                         | 2 +-
 doc/board/wexler/index.rst                            | 2 +-
 doc/board/wexler/qc750.rst                            | 2 +-
 doc/board/xen/index.rst                               | 2 +-
 doc/board/xen/xenguest_arm64.rst                      | 2 +-
 doc/board/xilinx/index.rst                            | 2 +-
 doc/board/xilinx/xilinx.rst                           | 2 +-
 doc/board/xilinx/zynq.rst                             | 2 +-
 doc/build/documentation.rst                           | 2 +-
 doc/build/index.rst                                   | 2 +-
 doc/build/tools.rst                                   | 2 +-
 doc/chromium/chainload.rst                            | 2 +-
 doc/chromium/index.rst                                | 2 +-
 doc/chromium/overview.rst                             | 2 +-
 doc/chromium/run_vboot.rst                            | 2 +-
 doc/develop/binman_tests.rst                          | 8 ++++----
 doc/develop/bloblist.rst                              | 2 +-
 doc/develop/board_best_practices.rst                  | 2 +-
 doc/develop/bootstd/android.rst                       | 2 +-
 doc/develop/bootstd/cros.rst                          | 2 +-
 doc/develop/bootstd/extlinux.rst                      | 2 +-
 doc/develop/bootstd/index.rst                         | 2 +-
 doc/develop/bootstd/overview.rst                      | 2 +-
 doc/develop/bootstd/pxelinux.rst                      | 2 +-
 doc/develop/bootstd/qfw.rst                           | 2 +-
 doc/develop/bootstd/sandbox.rst                       | 2 +-
 doc/develop/bootstd/script.rst                        | 2 +-
 doc/develop/cedit.rst                                 | 2 +-
 doc/develop/ci_testing.rst                            | 2 +-
 doc/develop/codingstyle.rst                           | 2 +-
 doc/develop/commands.rst                              | 2 +-
 doc/develop/config_binding.rst                        | 2 +-
 doc/develop/crash_dumps.rst                           | 2 +-
 doc/develop/cyclic.rst                                | 2 +-
 doc/develop/designprinciples.rst                      | 2 +-
 doc/develop/devicetree/control.rst                    | 2 +-
 doc/develop/devicetree/dt_qemu.rst                    | 2 +-
 doc/develop/devicetree/index.rst                      | 2 +-
 doc/develop/devicetree/intro.rst                      | 2 +-
 doc/develop/distro.rst                                | 2 +-
 doc/develop/docstyle.rst                              | 2 +-
 doc/develop/driver-model/bind.rst                     | 2 +-
 doc/develop/driver-model/debugging.rst                | 2 +-
 doc/develop/driver-model/design.rst                   | 2 +-
 doc/develop/driver-model/fdt-fixup.rst                | 2 +-
 doc/develop/driver-model/fs_firmware_loader.rst       | 2 +-
 doc/develop/driver-model/i2c-howto.rst                | 2 +-
 doc/develop/driver-model/index.rst                    | 2 +-
 doc/develop/driver-model/livetree.rst                 | 2 +-
 doc/develop/driver-model/migration.rst                | 2 +-
 doc/develop/driver-model/nvme.rst                     | 2 +-
 doc/develop/driver-model/nvmxip.rst                   | 2 +-
 doc/develop/driver-model/of-plat.rst                  | 2 +-
 doc/develop/driver-model/pci-info.rst                 | 2 +-
 doc/develop/driver-model/pmic-framework.rst           | 2 +-
 doc/develop/driver-model/remoteproc-framework.rst     | 2 +-
 doc/develop/driver-model/serial-howto.rst             | 2 +-
 doc/develop/driver-model/soc-framework.rst            | 2 +-
 doc/develop/driver-model/spi-howto.rst                | 2 +-
 doc/develop/driver-model/usb-info.rst                 | 2 +-
 doc/develop/driver-model/virtio.rst                   | 2 +-
 doc/develop/environment.rst                           | 2 +-
 doc/develop/event.rst                                 | 2 +-
 doc/develop/expo.rst                                  | 2 +-
 doc/develop/gdb.rst                                   | 2 +-
 doc/develop/global_data.rst                           | 2 +-
 doc/develop/historical/generic_board.rst              | 2 +-
 doc/develop/historical/index.rst                      | 2 +-
 doc/develop/index.rst                                 | 2 +-
 doc/develop/init.rst                                  | 2 +-
 doc/develop/logging.rst                               | 2 +-
 doc/develop/menus.rst                                 | 2 +-
 doc/develop/package/index.rst                         | 2 +-
 doc/develop/printf.rst                                | 2 +-
 doc/develop/process.rst                               | 2 +-
 doc/develop/python_cq.rst                             | 2 +-
 doc/develop/qconfig.rst                               | 2 +-
 doc/develop/security.rst                              | 2 +-
 doc/develop/sending_patches.rst                       | 6 +++---
 doc/develop/smbios.rst                                | 2 +-
 doc/develop/system_configuration.rst                  | 2 +-
 doc/develop/testing.rst                               | 2 +-
 doc/develop/tests_sandbox.rst                         | 2 +-
 doc/develop/tests_writing.rst                         | 2 +-
 doc/develop/trace.rst                                 | 2 +-
 doc/develop/uefi/fwu_updates.rst                      | 2 +-
 doc/develop/uefi/index.rst                            | 2 +-
 doc/develop/uefi/iscsi.rst                            | 2 +-
 doc/develop/uefi/u-boot_on_efi.rst                    | 2 +-
 doc/develop/uefi/uefi.rst                             | 2 +-
 doc/develop/vbe.rst                                   | 2 +-
 doc/develop/version.rst                               | 2 +-
 doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml       | 2 +-
 doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml  | 2 +-
 doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml | 2 +-
 doc/index.rst                                         | 2 +-
 doc/learn/index.rst                                   | 2 +-
 doc/learn/talks.rst                                   | 2 +-
 doc/mkeficapsule.1                                    | 2 +-
 doc/sphinx/parallel-wrapper.sh                        | 2 +-
 doc/usage/blkmap.rst                                  | 2 +-
 doc/usage/cmd/acpi.rst                                | 2 +-
 doc/usage/cmd/addrmap.rst                             | 2 +-
 doc/usage/cmd/armffa.rst                              | 2 +-
 doc/usage/cmd/askenv.rst                              | 2 +-
 doc/usage/cmd/base.rst                                | 2 +-
 doc/usage/cmd/bdinfo.rst                              | 2 +-
 doc/usage/cmd/bind.rst                                | 2 +-
 doc/usage/cmd/blkcache.rst                            | 2 +-
 doc/usage/cmd/bootd.rst                               | 2 +-
 doc/usage/cmd/bootdev.rst                             | 2 +-
 doc/usage/cmd/bootefi.rst                             | 2 +-
 doc/usage/cmd/bootflow.rst                            | 2 +-
 doc/usage/cmd/booti.rst                               | 2 +-
 doc/usage/cmd/bootm.rst                               | 2 +-
 doc/usage/cmd/bootmenu.rst                            | 2 +-
 doc/usage/cmd/bootmeth.rst                            | 2 +-
 doc/usage/cmd/bootz.rst                               | 2 +-
 doc/usage/cmd/button.rst                              | 2 +-
 doc/usage/cmd/cat.rst                                 | 2 +-
 doc/usage/cmd/cbcmos.rst                              | 2 +-
 doc/usage/cmd/cbsysinfo.rst                           | 2 +-
 doc/usage/cmd/cedit.rst                               | 2 +-
 doc/usage/cmd/cli.rst                                 | 2 +-
 doc/usage/cmd/cls.rst                                 | 2 +-
 doc/usage/cmd/cmp.rst                                 | 2 +-
 doc/usage/cmd/coninfo.rst                             | 2 +-
 doc/usage/cmd/cp.rst                                  | 2 +-
 doc/usage/cmd/cpu.rst                                 | 2 +-
 doc/usage/cmd/cpuid.rst                               | 2 +-
 doc/usage/cmd/cyclic.rst                              | 2 +-
 doc/usage/cmd/dm.rst                                  | 2 +-
 doc/usage/cmd/ebtupdate.rst                           | 2 +-
 doc/usage/cmd/efi.rst                                 | 2 +-
 doc/usage/cmd/eficonfig.rst                           | 2 +-
 doc/usage/cmd/event.rst                               | 2 +-
 doc/usage/cmd/extension.rst                           | 2 +-
 doc/usage/cmd/fatinfo.rst                             | 2 +-
 doc/usage/cmd/fatload.rst                             | 2 +-
 doc/usage/cmd/fdt.rst                                 | 2 +-
 doc/usage/cmd/font.rst                                | 2 +-
 doc/usage/cmd/fwu_mdata.rst                           | 2 +-
 doc/usage/cmd/gpio.rst                                | 2 +-
 doc/usage/cmd/gpt.rst                                 | 2 +-
 doc/usage/cmd/history.rst                             | 2 +-
 doc/usage/cmd/host.rst                                | 2 +-
 doc/usage/cmd/imxtract.rst                            | 2 +-
 doc/usage/cmd/itest.rst                               | 2 +-
 doc/usage/cmd/load.rst                                | 2 +-
 doc/usage/cmd/loadb.rst                               | 2 +-
 doc/usage/cmd/loadm.rst                               | 2 +-
 doc/usage/cmd/loads.rst                               | 2 +-
 doc/usage/cmd/loadx.rst                               | 2 +-
 doc/usage/cmd/loady.rst                               | 2 +-
 doc/usage/cmd/mbr.rst                                 | 2 +-
 doc/usage/cmd/md.rst                                  | 2 +-
 doc/usage/cmd/meminfo.rst                             | 2 +-
 doc/usage/cmd/mmc.rst                                 | 2 +-
 doc/usage/cmd/msr.rst                                 | 2 +-
 doc/usage/cmd/mtest.rst                               | 2 +-
 doc/usage/cmd/mtrr.rst                                | 2 +-
 doc/usage/cmd/panic.rst                               | 2 +-
 doc/usage/cmd/part.rst                                | 2 +-
 doc/usage/cmd/pinmux.rst                              | 2 +-
 doc/usage/cmd/printenv.rst                            | 2 +-
 doc/usage/cmd/pstore.rst                              | 2 +-
 doc/usage/cmd/qfw.rst                                 | 2 +-
 doc/usage/cmd/reset.rst                               | 2 +-
 doc/usage/cmd/rng.rst                                 | 2 +-
 doc/usage/cmd/saves.rst                               | 2 +-
 doc/usage/cmd/sb.rst                                  | 2 +-
 doc/usage/cmd/sbi.rst                                 | 2 +-
 doc/usage/cmd/scmi.rst                                | 2 +-
 doc/usage/cmd/scp03.rst                               | 2 +-
 doc/usage/cmd/seama.rst                               | 2 +-
 doc/usage/cmd/setexpr.rst                             | 2 +-
 doc/usage/cmd/sf.rst                                  | 2 +-
 doc/usage/cmd/size.rst                                | 2 +-
 doc/usage/cmd/sleep.rst                               | 2 +-
 doc/usage/cmd/sm.rst                                  | 2 +-
 doc/usage/cmd/sound.rst                               | 2 +-
 doc/usage/cmd/source.rst                              | 2 +-
 doc/usage/cmd/tcpm.rst                                | 2 +-
 doc/usage/cmd/tftpput.rst                             | 2 +-
 doc/usage/cmd/trace.rst                               | 2 +-
 doc/usage/cmd/ums.rst                                 | 2 +-
 doc/usage/cmd/unbind.rst                              | 2 +-
 doc/usage/cmd/upl.rst                                 | 2 +-
 doc/usage/cmd/ut.rst                                  | 2 +-
 doc/usage/cmd/wdt.rst                                 | 2 +-
 doc/usage/cmd/wget.rst                                | 2 +-
 doc/usage/cmd/xxd.rst                                 | 2 +-
 doc/usage/cmdline.rst                                 | 2 +-
 doc/usage/dfu.rst                                     | 2 +-
 doc/usage/environment.rst                             | 2 +-
 doc/usage/fdt_overlays.rst                            | 2 +-
 doc/usage/fit/beaglebone_vboot.rst                    | 2 +-
 doc/usage/fit/howto.rst                               | 2 +-
 doc/usage/fit/index.rst                               | 2 +-
 doc/usage/fit/kernel.rst                              | 2 +-
 doc/usage/fit/kernel_fdt.rst                          | 2 +-
 doc/usage/fit/kernel_fdts_compressed.rst              | 2 +-
 doc/usage/fit/multi-with-fpga.rst                     | 2 +-
 doc/usage/fit/multi-with-loadables.rst                | 2 +-
 doc/usage/fit/multi.rst                               | 2 +-
 doc/usage/fit/multi_spl.rst                           | 2 +-
 doc/usage/fit/overlay-fdt-boot.rst                    | 2 +-
 doc/usage/fit/sec_firmware_ppa.rst                    | 2 +-
 doc/usage/fit/sign-configs.rst                        | 2 +-
 doc/usage/fit/sign-images.rst                         | 2 +-
 doc/usage/fit/signature.rst                           | 2 +-
 doc/usage/fit/uefi.rst                                | 2 +-
 doc/usage/fit/update3.rst                             | 2 +-
 doc/usage/fit/update_uboot.rst                        | 2 +-
 doc/usage/fit/verified-boot.rst                       | 2 +-
 doc/usage/fit/x86-fit-boot.rst                        | 2 +-
 doc/usage/measured_boot.rst                           | 2 +-
 doc/usage/os/plan9.rst                                | 2 +-
 doc/usage/os/vxworks.rst                              | 2 +-
 doc/usage/partitions.rst                              | 2 +-
 doc/usage/semihosting.rst                             | 2 +-
 505 files changed, 513 insertions(+), 512 deletions(-)

diff --git a/doc/README.autoboot b/doc/README.autoboot
index 5e9a5e1cf7f..d6d6910f144 100644
--- a/doc/README.autoboot
+++ b/doc/README.autoboot
@@ -1,4 +1,4 @@
-SPDX-License-Identifier: GPL-2.0+
+SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright 2001
  * Dave Ellis, SIXNET, dge@sixnetio.com
diff --git a/doc/README.console b/doc/README.console
index 9f5812c89d1..acb71e2d639 100644
--- a/doc/README.console
+++ b/doc/README.console
@@ -1,4 +1,4 @@
-SPDX-License-Identifier: GPL-2.0+
+SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright 2000
  * Paolo Scaffardi, AIRVENT SAM s.p.a - RIMINI(ITALY), arsenio@tin.it
diff --git a/doc/README.dfutftp b/doc/README.dfutftp
index 12065079117..991afdaf0cc 100644
--- a/doc/README.dfutftp
+++ b/doc/README.dfutftp
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #  Copyright (C) 2015
 #
diff --git a/doc/README.esbc_validate b/doc/README.esbc_validate
index 540923215e7..d4ea8436ff5 100644
--- a/doc/README.esbc_validate
+++ b/doc/README.esbc_validate
@@ -1,4 +1,4 @@
-SPDX-License-Identifier: GPL-2.0+
+SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright 2015
  */
diff --git a/doc/README.gpt b/doc/README.gpt
index 386ac2e0fc8..062036cf713 100644
--- a/doc/README.gpt
+++ b/doc/README.gpt
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #  Copyright (C) 2012 Samsung Electronics
 #
diff --git a/doc/README.iomux b/doc/README.iomux
index c428811ce4c..9cc1f1e1a25 100644
--- a/doc/README.iomux
+++ b/doc/README.iomux
@@ -1,4 +1,4 @@
-SPDX-License-Identifier: GPL-2.0+
+SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright 2008
  * Gary Jennejohn, DENX Software Engineering GmbH <garyj@denx.de>
diff --git a/doc/README.mediatek b/doc/README.mediatek
index 246579d4be2..c7ffc00f63b 100644
--- a/doc/README.mediatek
+++ b/doc/README.mediatek
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (C) 2018 MediaTek Inc.
 # Ryder Lee <ryder.lee@kernel.org>
diff --git a/doc/README.nand b/doc/README.nand
index 37657512533..b93402bd042 100644
--- a/doc/README.nand
+++ b/doc/README.nand
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 NAND FLASH commands and notes
 
 See NOTE below!!!
diff --git a/doc/README.power-framework b/doc/README.power-framework
index 1f6fd432031..5511d20544f 100644
--- a/doc/README.power-framework
+++ b/doc/README.power-framework
@@ -2,7 +2,7 @@
 # (C) Copyright 2014 Samsung Electronics
 # Lukasz Majewski <l.majewski@samsung.com>
 #
-# SPDX-License-Identifier:      GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 
 Introduction
diff --git a/doc/README.pxe b/doc/README.pxe
index af2e64a5776..5c4909540b4 100644
--- a/doc/README.pxe
+++ b/doc/README.pxe
@@ -1,4 +1,4 @@
-SPDX-License-Identifier: GPL-2.0+
+SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2010-2011 Calxeda, Inc.
  */
diff --git a/doc/README.rockchip b/doc/README.rockchip
index 96fa49d697b..a544809e9bf 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (C) 2015 Google. Inc
 # Written by Simon Glass <sjg@chromium.org>
diff --git a/doc/README.usb b/doc/README.usb
index 650a6daae0a..71a22af4850 100644
--- a/doc/README.usb
+++ b/doc/README.usb
@@ -1,4 +1,4 @@
-SPDX-License-Identifier: GPL-2.0+
+SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright 2001
  * Denis Peter, MPL AG Switzerland
diff --git a/doc/README.video b/doc/README.video
index ced35bd2db5..adaf34ac94b 100644
--- a/doc/README.video
+++ b/doc/README.video
@@ -1,4 +1,4 @@
-SPDX-License-Identifier: GPL-2.0+
+SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * (C) Copyright 2000
  * Paolo Scaffardi, AIRVENT SAM s.p.a - RIMINI(ITALY), arsenio@tin.it
diff --git a/doc/android/ab.rst b/doc/android/ab.rst
index 7fd4aeb6a72..911d6add6c8 100644
--- a/doc/android/ab.rst
+++ b/doc/android/ab.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Android A/B updates
 ===================
diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 4aca7a5c660..1046c29a392 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Android Verified Boot 2.0
 =========================
diff --git a/doc/android/bcb.rst b/doc/android/bcb.rst
index 2226517d39f..866ab6a1fba 100644
--- a/doc/android/bcb.rst
+++ b/doc/android/bcb.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Android Bootloader Control Block (BCB)
 ======================================
diff --git a/doc/android/boot-image.rst b/doc/android/boot-image.rst
index 8f247c70933..d4240d78f40 100644
--- a/doc/android/boot-image.rst
+++ b/doc/android/boot-image.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Sam Protsenko <joe.skb7@gmail.com>
 
 Android Boot Image
diff --git a/doc/android/fastboot-protocol.rst b/doc/android/fastboot-protocol.rst
index 8bd6d7168f1..c4723cecc74 100644
--- a/doc/android/fastboot-protocol.rst
+++ b/doc/android/fastboot-protocol.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 FastBoot Version 0.4
 ====================
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 6f92cd28eb1..c1b4d5fc24c 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Android Fastboot
 ================
diff --git a/doc/android/index.rst b/doc/android/index.rst
index 225d6f125a9..19b10898f2c 100644
--- a/doc/android/index.rst
+++ b/doc/android/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Android-specific doc
 ====================
diff --git a/doc/api/bootcount.rst b/doc/api/bootcount.rst
index 968c679c3c6..c5d2307bcf1 100644
--- a/doc/api/bootcount.rst
+++ b/doc/api/bootcount.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Boot Count Limit
 ================
diff --git a/doc/api/clk.rst b/doc/api/clk.rst
index 7c27066928e..c87e7bb5715 100644
--- a/doc/api/clk.rst
+++ b/doc/api/clk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Clock API
 =========
diff --git a/doc/api/dfu.rst b/doc/api/dfu.rst
index 5bd9e292a57..4878161915b 100644
--- a/doc/api/dfu.rst
+++ b/doc/api/dfu.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Device firmware update
 ======================
diff --git a/doc/api/dm.rst b/doc/api/dm.rst
index df605dae9d6..50ea885b4a3 100644
--- a/doc/api/dm.rst
+++ b/doc/api/dm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Driver Model
 ============
diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 43d6f936fb0..f62e54584dd 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 UEFI subsystem
 ==============
diff --git a/doc/api/event.rst b/doc/api/event.rst
index 8a57d438322..7e8aaf9f94a 100644
--- a/doc/api/event.rst
+++ b/doc/api/event.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Events
 ======
diff --git a/doc/api/getopt.rst b/doc/api/getopt.rst
index 773f79aeb63..2fbd5defab2 100644
--- a/doc/api/getopt.rst
+++ b/doc/api/getopt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
 
 Option Parsing
diff --git a/doc/api/index.rst b/doc/api/index.rst
index a108718ea99..7e6040c19d0 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot API documentation
 ========================
diff --git a/doc/api/interrupt.rst b/doc/api/interrupt.rst
index 5721231d919..91a15d5b5a3 100644
--- a/doc/api/interrupt.rst
+++ b/doc/api/interrupt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Interrupt API
 =============
diff --git a/doc/api/led.rst b/doc/api/led.rst
index e52e350d1bb..54648e627d4 100644
--- a/doc/api/led.rst
+++ b/doc/api/led.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 LED
 ===
diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
index 3cd447f187d..3a89ec92f8a 100644
--- a/doc/api/linker_lists.rst
+++ b/doc/api/linker_lists.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Linker-Generated Arrays
 =======================
diff --git a/doc/api/lmb.rst b/doc/api/lmb.rst
index 2095bfa1618..13b602a6672 100644
--- a/doc/api/lmb.rst
+++ b/doc/api/lmb.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Logical memory blocks
 =====================
diff --git a/doc/api/logging.rst b/doc/api/logging.rst
index 1e6cbc4931c..2ae3eca23c0 100644
--- a/doc/api/logging.rst
+++ b/doc/api/logging.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Logging API
 ===========
diff --git a/doc/api/nvmem.rst b/doc/api/nvmem.rst
index d9237846524..720ab02bb33 100644
--- a/doc/api/nvmem.rst
+++ b/doc/api/nvmem.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 NVMEM API
 =========
diff --git a/doc/api/part.rst b/doc/api/part.rst
index d1df1d84945..0cd12fc89e9 100644
--- a/doc/api/part.rst
+++ b/doc/api/part.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Partition API
 =============
diff --git a/doc/api/pinctrl.rst b/doc/api/pinctrl.rst
index 043bd57efab..4db52c81684 100644
--- a/doc/api/pinctrl.rst
+++ b/doc/api/pinctrl.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Pinctrl and Pinmux
 ==================
diff --git a/doc/api/rng.rst b/doc/api/rng.rst
index b826d4fd4a5..06f70a4f7d6 100644
--- a/doc/api/rng.rst
+++ b/doc/api/rng.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2018 Heinrich Schuchardt
 
 Random number generation
diff --git a/doc/api/sandbox.rst b/doc/api/sandbox.rst
index 724776399be..20c26188046 100644
--- a/doc/api/sandbox.rst
+++ b/doc/api/sandbox.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sandbox
 =======
diff --git a/doc/api/serial.rst b/doc/api/serial.rst
index ed34e592a44..b737d5a21bb 100644
--- a/doc/api/serial.rst
+++ b/doc/api/serial.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Serial system
 =============
diff --git a/doc/api/sysreset.rst b/doc/api/sysreset.rst
index a51b06c3870..db1755bd924 100644
--- a/doc/api/sysreset.rst
+++ b/doc/api/sysreset.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 System reset
 ============
diff --git a/doc/api/timer.rst b/doc/api/timer.rst
index b0695174d7d..c8d5e2f4c37 100644
--- a/doc/api/timer.rst
+++ b/doc/api/timer.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
 
 Timer Subsystem
diff --git a/doc/api/unicode.rst b/doc/api/unicode.rst
index 3fb6745f847..3f52f41fdd0 100644
--- a/doc/api/unicode.rst
+++ b/doc/api/unicode.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Unicode support
 ===============
diff --git a/doc/arch/arc.rst b/doc/arch/arc.rst
index f8e04a34f14..c698b7b3e28 100644
--- a/doc/arch/arc.rst
+++ b/doc/arch/arc.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 ARC
 ===
diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
index f966f8ba6af..01beac27ea9 100644
--- a/doc/arch/arm64.ffa.rst
+++ b/doc/arch/arm64.ffa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Arm FF-A Support
 ================
diff --git a/doc/arch/arm64.rst b/doc/arch/arm64.rst
index 19662be6fc6..37081f432b0 100644
--- a/doc/arch/arm64.rst
+++ b/doc/arch/arm64.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 ARM64
 =====
diff --git a/doc/arch/index.rst b/doc/arch/index.rst
index 60c93b3b664..0954de4e497 100644
--- a/doc/arch/index.rst
+++ b/doc/arch/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Architecture-specific doc
 =========================
diff --git a/doc/arch/m68k.rst b/doc/arch/m68k.rst
index de7eb384955..8de169fe6ea 100644
--- a/doc/arch/m68k.rst
+++ b/doc/arch/m68k.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 M68K / ColdFire
 ===============
diff --git a/doc/arch/mips.rst b/doc/arch/mips.rst
index aeb58247943..4426c6d69d6 100644
--- a/doc/arch/mips.rst
+++ b/doc/arch/mips.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 MIPS
 ====
diff --git a/doc/arch/nios2.rst b/doc/arch/nios2.rst
index 34a75e7fb00..43c7e5e3e2c 100644
--- a/doc/arch/nios2.rst
+++ b/doc/arch/nios2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Nios II
 =======
diff --git a/doc/arch/riscv.rst b/doc/arch/riscv.rst
index af0c48b8982..109dd83d2f6 100644
--- a/doc/arch/riscv.rst
+++ b/doc/arch/riscv.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2023, Yu Chien Peter Lin <peterlin@andestech.com>
 
 RISC-V
diff --git a/doc/arch/sandbox/block_impl.rst b/doc/arch/sandbox/block_impl.rst
index 344c74f718b..72151aa08dd 100644
--- a/doc/arch/sandbox/block_impl.rst
+++ b/doc/arch/sandbox/block_impl.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ */
+.. SPDX-License-Identifier: GPL-2.0-or-later */
 .. Copyright (c) 2014 The Chromium OS Authors.
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
diff --git a/doc/arch/sandbox/index.rst b/doc/arch/sandbox/index.rst
index 1f1f5de4b03..96a75aba159 100644
--- a/doc/arch/sandbox/index.rst
+++ b/doc/arch/sandbox/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ */
+.. SPDX-License-Identifier: GPL-2.0-or-later */
 .. Copyright 2022 Google LLC
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index a8b0d7f0395..45d5a06d2c5 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ */
+.. SPDX-License-Identifier: GPL-2.0-or-later */
 .. Copyright (c) 2014 The Chromium OS Authors.
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
diff --git a/doc/arch/sh.rst b/doc/arch/sh.rst
index 3e3759d68b2..a8340a308b4 100644
--- a/doc/arch/sh.rst
+++ b/doc/arch/sh.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2007,2008 Nobuhiro Iwamatsu <iwamatsu@nigaur.org>
 
 SuperH
diff --git a/doc/arch/x86/index.rst b/doc/arch/x86/index.rst
index 69db0a5d648..152ca47982f 100644
--- a/doc/arch/x86/index.rst
+++ b/doc/arch/x86/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ */
+.. SPDX-License-Identifier: GPL-2.0-or-later */
 .. Copyright 2023 Google LLC
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index f67216d6ce0..aaba78db88d 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2014, Simon Glass <sjg@chromium.org>
 .. Copyright (C) 2014, Bin Meng <bmeng.cn@gmail.com>
 
diff --git a/doc/arch/xtensa.rst b/doc/arch/xtensa.rst
index 176410d96b9..dddb47c6489 100644
--- a/doc/arch/xtensa.rst
+++ b/doc/arch/xtensa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Xtensa
 ======
diff --git a/doc/board/actions/cubieboard7.rst b/doc/board/actions/cubieboard7.rst
index 1f73fc40f8c..a3df6476210 100644
--- a/doc/board/actions/cubieboard7.rst
+++ b/doc/board/actions/cubieboard7.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2020 Amit Singh Tomar <amittomer25@gmail.com>
 
 CUBIEBOARD7
diff --git a/doc/board/actions/index.rst b/doc/board/actions/index.rst
index e925fcd0f68..9ddcdf4757e 100644
--- a/doc/board/actions/index.rst
+++ b/doc/board/actions/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2020 Amit Singh Tomar <amittomer25@gmail.com>
 
 Actions
diff --git a/doc/board/advantech/imx8qm-dmsse20-a1.rst b/doc/board/advantech/imx8qm-dmsse20-a1.rst
index b83e678cd9a..32a5d381cc2 100644
--- a/doc/board/advantech/imx8qm-dmsse20-a1.rst
+++ b/doc/board/advantech/imx8qm-dmsse20-a1.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 NXP i.MX8QM DMSSE20-a1 board
 ============================
diff --git a/doc/board/advantech/imx8qm-rom7720-a1.rst b/doc/board/advantech/imx8qm-rom7720-a1.rst
index 13ea2eb19e4..783932ba5b3 100644
--- a/doc/board/advantech/imx8qm-rom7720-a1.rst
+++ b/doc/board/advantech/imx8qm-rom7720-a1.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the NXP i.MX8QM ROM 7720a1 board
 ===========================================
diff --git a/doc/board/advantech/index.rst b/doc/board/advantech/index.rst
index 125b98c1f76..0a659be3629 100644
--- a/doc/board/advantech/index.rst
+++ b/doc/board/advantech/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Advantech
 =========
diff --git a/doc/board/allwinner/index.rst b/doc/board/allwinner/index.rst
index 7352ccd5c0a..904b3f3ddfa 100644
--- a/doc/board/allwinner/index.rst
+++ b/doc/board/allwinner/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Allwinner (sunxi) boards
 ========================
diff --git a/doc/board/allwinner/sunxi.rst b/doc/board/allwinner/sunxi.rst
index d0c89b956b1..2d828a36d0c 100644
--- a/doc/board/allwinner/sunxi.rst
+++ b/doc/board/allwinner/sunxi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2021 Arm Ltd.
 
 Allwinner SoC based boards
diff --git a/doc/board/amlogic/aml-a311d-cc.rst b/doc/board/amlogic/aml-a311d-cc.rst
index 25c1e01906a..0b1bdb310bb 100644
--- a/doc/board/amlogic/aml-a311d-cc.rst
+++ b/doc/board/amlogic/aml-a311d-cc.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Libre Computer AML-A311D-CC 'Alta' (A311D)
 =====================================================
diff --git a/doc/board/amlogic/aml-s905d3-cc.rst b/doc/board/amlogic/aml-s905d3-cc.rst
index 083a591fc52..9b794a15844 100644
--- a/doc/board/amlogic/aml-s905d3-cc.rst
+++ b/doc/board/amlogic/aml-s905d3-cc.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Libre Computer AML-S905D3-CC 'Solitude' (S905D3)
 ===========================================================
diff --git a/doc/board/amlogic/bananapi-cm4io.rst b/doc/board/amlogic/bananapi-cm4io.rst
index 672cbee7d8e..02a8c2d2dab 100644
--- a/doc/board/amlogic/bananapi-cm4io.rst
+++ b/doc/board/amlogic/bananapi-cm4io.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for BananaPi CM4 with CM4IO (A311D)
 ==========================================
diff --git a/doc/board/amlogic/bananapi-m2pro.rst b/doc/board/amlogic/bananapi-m2pro.rst
index 6c35943bac8..517742988fe 100644
--- a/doc/board/amlogic/bananapi-m2pro.rst
+++ b/doc/board/amlogic/bananapi-m2pro.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for BananaPi BPI-M2-PRO (S905X3)
 =======================================
diff --git a/doc/board/amlogic/bananapi-m2s.rst b/doc/board/amlogic/bananapi-m2s.rst
index 4a1be47b350..c8363e9b31e 100644
--- a/doc/board/amlogic/bananapi-m2s.rst
+++ b/doc/board/amlogic/bananapi-m2s.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for BananaPi M2S (A311D & S922X)
 =======================================
diff --git a/doc/board/amlogic/bananapi-m5.rst b/doc/board/amlogic/bananapi-m5.rst
index 009ea0ba947..3918444084d 100644
--- a/doc/board/amlogic/bananapi-m5.rst
+++ b/doc/board/amlogic/bananapi-m5.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for BananaPi BPI-M5 (S905X3)
 ===================================
diff --git a/doc/board/amlogic/beelink-gskingx.rst b/doc/board/amlogic/beelink-gskingx.rst
index 8a8296e8630..fb04b191a50 100644
--- a/doc/board/amlogic/beelink-gskingx.rst
+++ b/doc/board/amlogic/beelink-gskingx.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Beelink GS-King-X (S922X)
 ====================================
diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst b/doc/board/amlogic/beelink-gt1-ultimate.rst
index a78a1a2ff25..8e220ed9777 100644
--- a/doc/board/amlogic/beelink-gt1-ultimate.rst
+++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Beelink GT1 Ultimate (S912)
 ======================================
diff --git a/doc/board/amlogic/beelink-gtking.rst b/doc/board/amlogic/beelink-gtking.rst
index 8171b698c76..ebc699d3dd8 100644
--- a/doc/board/amlogic/beelink-gtking.rst
+++ b/doc/board/amlogic/beelink-gtking.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Beelink GT-King (S922X)
 ==================================
diff --git a/doc/board/amlogic/beelink-gtkingpro.rst b/doc/board/amlogic/beelink-gtkingpro.rst
index eb0b7d4fd1f..b8e1d2f1fcb 100644
--- a/doc/board/amlogic/beelink-gtkingpro.rst
+++ b/doc/board/amlogic/beelink-gtkingpro.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Beelink GT-King Pro (S922X)
 ======================================
diff --git a/doc/board/amlogic/boot-flow.rst b/doc/board/amlogic/boot-flow.rst
index 041297c512c..cd5c858a0f0 100644
--- a/doc/board/amlogic/boot-flow.rst
+++ b/doc/board/amlogic/boot-flow.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Amlogic SoC Boot Flow
 =====================
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index dcd935224ac..2674e6d7a7b 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Amlogic
 =======
diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
index cbf1ea76107..9d987c07087 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for JetHub J100/J110 (A113X)
 ===================================
diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
index 9195df69050..505393bfd29 100644
--- a/doc/board/amlogic/jethub-j80.rst
+++ b/doc/board/amlogic/jethub-j80.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for JetHub J80 (S905W)
 =============================
diff --git a/doc/board/amlogic/khadas-vim.rst b/doc/board/amlogic/khadas-vim.rst
index 20370ed49a8..3ea54e28ea5 100644
--- a/doc/board/amlogic/khadas-vim.rst
+++ b/doc/board/amlogic/khadas-vim.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Khadas VIM (S905X)
 =============================
diff --git a/doc/board/amlogic/khadas-vim2.rst b/doc/board/amlogic/khadas-vim2.rst
index 58f18701f7c..f4f7ad8b6f7 100644
--- a/doc/board/amlogic/khadas-vim2.rst
+++ b/doc/board/amlogic/khadas-vim2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Khadas VIM2 (S912)
 =============================
diff --git a/doc/board/amlogic/khadas-vim3.rst b/doc/board/amlogic/khadas-vim3.rst
index 4959590b8b3..1b98a52b0a2 100644
--- a/doc/board/amlogic/khadas-vim3.rst
+++ b/doc/board/amlogic/khadas-vim3.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Khadas VIM3 (A311D)
 ==============================
diff --git a/doc/board/amlogic/khadas-vim3l.rst b/doc/board/amlogic/khadas-vim3l.rst
index cd21466f70b..66819f5ca58 100644
--- a/doc/board/amlogic/khadas-vim3l.rst
+++ b/doc/board/amlogic/khadas-vim3l.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Khadas VIM3L (S905D3)
 ================================
diff --git a/doc/board/amlogic/libretech-ac.rst b/doc/board/amlogic/libretech-ac.rst
index fa151c0d008..d18726f5330 100644
--- a/doc/board/amlogic/libretech-ac.rst
+++ b/doc/board/amlogic/libretech-ac.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for LibreTech-AC 'LaFrite' (S805X)
 =========================================
diff --git a/doc/board/amlogic/libretech-cc.rst b/doc/board/amlogic/libretech-cc.rst
index 08a84a41c06..a1421530c8e 100644
--- a/doc/board/amlogic/libretech-cc.rst
+++ b/doc/board/amlogic/libretech-cc.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for LibreTech CC 'LePotato' (S905X)
 ==========================================
diff --git a/doc/board/amlogic/nanopi-k2.rst b/doc/board/amlogic/nanopi-k2.rst
index 53a0a41c889..35859ed749a 100644
--- a/doc/board/amlogic/nanopi-k2.rst
+++ b/doc/board/amlogic/nanopi-k2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for NanoPi-K2 (S905)
 ===========================
diff --git a/doc/board/amlogic/odroid-c2.rst b/doc/board/amlogic/odroid-c2.rst
index 922ab0c0b40..c8fb0a9df99 100644
--- a/doc/board/amlogic/odroid-c2.rst
+++ b/doc/board/amlogic/odroid-c2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for ODROID-C2 (S905)
 ===========================
diff --git a/doc/board/amlogic/odroid-c4.rst b/doc/board/amlogic/odroid-c4.rst
index 6994b958cf8..6ca05f9a842 100644
--- a/doc/board/amlogic/odroid-c4.rst
+++ b/doc/board/amlogic/odroid-c4.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for ODROID-C4 (S905X3)
 =============================
diff --git a/doc/board/amlogic/odroid-go-ultra.rst b/doc/board/amlogic/odroid-go-ultra.rst
index caf0e38dee6..e325eb06a14 100644
--- a/doc/board/amlogic/odroid-go-ultra.rst
+++ b/doc/board/amlogic/odroid-go-ultra.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for ODROID-GO-ULTRA (S922X)
 ==================================
diff --git a/doc/board/amlogic/odroid-hc4.rst b/doc/board/amlogic/odroid-hc4.rst
index 1d37be2d80e..6ee9b893e6a 100644
--- a/doc/board/amlogic/odroid-hc4.rst
+++ b/doc/board/amlogic/odroid-hc4.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for ODROID-HC4 (S905X3)
 ==============================
diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
index 883720f8fbf..6f5e1041522 100644
--- a/doc/board/amlogic/odroid-n2.rst
+++ b/doc/board/amlogic/odroid-n2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for ODROID-N2/N2+ (S922X)
 ================================
diff --git a/doc/board/amlogic/odroid-n2l.rst b/doc/board/amlogic/odroid-n2l.rst
index 6d581759741..946999c2391 100644
--- a/doc/board/amlogic/odroid-n2l.rst
+++ b/doc/board/amlogic/odroid-n2l.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for ODROID-N2L (S922X)
 =============================
diff --git a/doc/board/amlogic/p200.rst b/doc/board/amlogic/p200.rst
index e223897a19f..dd037ebb57f 100644
--- a/doc/board/amlogic/p200.rst
+++ b/doc/board/amlogic/p200.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic P200 (S905)
 ==============================
diff --git a/doc/board/amlogic/p201.rst b/doc/board/amlogic/p201.rst
index 13b732fc7e4..376cc98410d 100644
--- a/doc/board/amlogic/p201.rst
+++ b/doc/board/amlogic/p201.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic P201 (S905)
 ==============================
diff --git a/doc/board/amlogic/p212.rst b/doc/board/amlogic/p212.rst
index a872f32f0f4..083322ba526 100644
--- a/doc/board/amlogic/p212.rst
+++ b/doc/board/amlogic/p212.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic P212
 =======================
diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/amlogic/pre-generated-fip.rst
index 6a43d776d43..b29d908db90 100644
--- a/doc/board/amlogic/pre-generated-fip.rst
+++ b/doc/board/amlogic/pre-generated-fip.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Pre-Generated FIP File Repo
 ===========================
@@ -76,8 +76,9 @@ The following files are generated from the Amlogic U-Boot fork:
 - bl301.bin: Contains the DVFS & suspend-resume handling code for the board
 - bl33.bin: U-boot binary image
 
-The acs.bin and bl301.bin files use U-Boot GPL-2.0+ headers and U-Boot build system and
-are thus considered to be issued from GPL-2.0+ source code.
+The acs.bin and bl301.bin files use U-Boot GPL-2.0-or-later headers and U-Boot
+build system and are thus considered to be issued from GPL-2.0-or-later source
+code.
 
 Amlogic alo provides pre-compiled x86_64 and Python2 binaries:
 
diff --git a/doc/board/amlogic/q200.rst b/doc/board/amlogic/q200.rst
index 32ea4722e40..bc544de3cc8 100644
--- a/doc/board/amlogic/q200.rst
+++ b/doc/board/amlogic/q200.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic Q200 (S912)
 ==============================
diff --git a/doc/board/amlogic/radxa-zero.rst b/doc/board/amlogic/radxa-zero.rst
index 14ce3cfd492..1e907b39432 100644
--- a/doc/board/amlogic/radxa-zero.rst
+++ b/doc/board/amlogic/radxa-zero.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Radxa Zero (S905Y2)
 ==============================
diff --git a/doc/board/amlogic/radxa-zero2.rst b/doc/board/amlogic/radxa-zero2.rst
index dccf5924597..fdc2b4526ff 100644
--- a/doc/board/amlogic/radxa-zero2.rst
+++ b/doc/board/amlogic/radxa-zero2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Radxa Zero2 (A311D)
 ==============================
diff --git a/doc/board/amlogic/s400.rst b/doc/board/amlogic/s400.rst
index 205e7c38fa3..b343839b222 100644
--- a/doc/board/amlogic/s400.rst
+++ b/doc/board/amlogic/s400.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic S400 (A113X)
 ===============================
diff --git a/doc/board/amlogic/sei510.rst b/doc/board/amlogic/sei510.rst
index 87cb701a086..7452f74195d 100644
--- a/doc/board/amlogic/sei510.rst
+++ b/doc/board/amlogic/sei510.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic SEI510 (S905X2)
 ==================================
diff --git a/doc/board/amlogic/sei610.rst b/doc/board/amlogic/sei610.rst
index 64f62575e2c..b16957584a5 100644
--- a/doc/board/amlogic/sei610.rst
+++ b/doc/board/amlogic/sei610.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic SEI610 (S905X3)
 ==================================
diff --git a/doc/board/amlogic/u200.rst b/doc/board/amlogic/u200.rst
index 8254d4dfdb5..118706b1216 100644
--- a/doc/board/amlogic/u200.rst
+++ b/doc/board/amlogic/u200.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic U200 (S905X2)
 ================================
diff --git a/doc/board/amlogic/videostrong-kii-pro.rst b/doc/board/amlogic/videostrong-kii-pro.rst
index 1c6adac996c..88d3201c3f2 100644
--- a/doc/board/amlogic/videostrong-kii-pro.rst
+++ b/doc/board/amlogic/videostrong-kii-pro.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Videostrong KII Pro (S905)
 =====================================
diff --git a/doc/board/amlogic/w400.rst b/doc/board/amlogic/w400.rst
index d2a8107b58c..671980e7a2b 100644
--- a/doc/board/amlogic/w400.rst
+++ b/doc/board/amlogic/w400.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Amlogic W400 (S922X)
 ===============================
diff --git a/doc/board/amlogic/wetek-core2.rst b/doc/board/amlogic/wetek-core2.rst
index 137262ec307..e3cdceb4ede 100644
--- a/doc/board/amlogic/wetek-core2.rst
+++ b/doc/board/amlogic/wetek-core2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for WeTek Core2 (S912)
 =============================
diff --git a/doc/board/amlogic/wetek-hub.rst b/doc/board/amlogic/wetek-hub.rst
index 212f0447815..d51897a0176 100644
--- a/doc/board/amlogic/wetek-hub.rst
+++ b/doc/board/amlogic/wetek-hub.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for WeTek Hub (S905)
 ===========================
diff --git a/doc/board/amlogic/wetek-play2.rst b/doc/board/amlogic/wetek-play2.rst
index 74580b9d959..6de0e9a2705 100644
--- a/doc/board/amlogic/wetek-play2.rst
+++ b/doc/board/amlogic/wetek-play2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for WeTek Play2 (S905)
 =============================
diff --git a/doc/board/anbernic/index.rst b/doc/board/anbernic/index.rst
index 03758d86137..733192f8a37 100644
--- a/doc/board/anbernic/index.rst
+++ b/doc/board/anbernic/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Anbernic
 ========
diff --git a/doc/board/anbernic/rgxx3.rst b/doc/board/anbernic/rgxx3.rst
index 1e63e6951e2..3fa7d211ea7 100644
--- a/doc/board/anbernic/rgxx3.rst
+++ b/doc/board/anbernic/rgxx3.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Anbernic RGxx3 Devices
 =================================
diff --git a/doc/board/andestech/adp-ag101p.rst b/doc/board/andestech/adp-ag101p.rst
index f867eeae3eb..692f01c1fec 100644
--- a/doc/board/andestech/adp-ag101p.rst
+++ b/doc/board/andestech/adp-ag101p.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 ADP-AG101P
 ==========
diff --git a/doc/board/andestech/ae350.rst b/doc/board/andestech/ae350.rst
index 99622fd3258..7b5dc2a0e42 100644
--- a/doc/board/andestech/ae350.rst
+++ b/doc/board/andestech/ae350.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 AE350
 =====
diff --git a/doc/board/andestech/index.rst b/doc/board/andestech/index.rst
index cacc5791a91..c7be43e5a7f 100644
--- a/doc/board/andestech/index.rst
+++ b/doc/board/andestech/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Andes Tech
 ==========
diff --git a/doc/board/apple/index.rst b/doc/board/apple/index.rst
index 84468478182..07e39675aa0 100644
--- a/doc/board/apple/index.rst
+++ b/doc/board/apple/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Apple
 =====
diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 8fa7637629e..c8aa6f0e513 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Apple Silicon Macs
 =============================
diff --git a/doc/board/aspeed/ibex-ast2700.rst b/doc/board/aspeed/ibex-ast2700.rst
index 511bd081ba2..d3ea62d3182 100644
--- a/doc/board/aspeed/ibex-ast2700.rst
+++ b/doc/board/aspeed/ibex-ast2700.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 IBex AST2700
 ============
diff --git a/doc/board/aspeed/index.rst b/doc/board/aspeed/index.rst
index d784c88494f..5619153d419 100644
--- a/doc/board/aspeed/index.rst
+++ b/doc/board/aspeed/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Aspeed
 ======
diff --git a/doc/board/asus/grouper.rst b/doc/board/asus/grouper.rst
index d56a9ca3921..57bf24ea613 100644
--- a/doc/board/asus/grouper.rst
+++ b/doc/board/asus/grouper.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the ASUS/Google Nexus 7 (2012)
 =========================================
diff --git a/doc/board/asus/index.rst b/doc/board/asus/index.rst
index 2cac04ce04a..991c3f2e0ff 100644
--- a/doc/board/asus/index.rst
+++ b/doc/board/asus/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 ASUS
 ====
diff --git a/doc/board/asus/transformer_t20.rst b/doc/board/asus/transformer_t20.rst
index d4bc12d1619..39751e8c46e 100644
--- a/doc/board/asus/transformer_t20.rst
+++ b/doc/board/asus/transformer_t20.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the ASUS Eee Pad Transformer device family
 =====================================================
diff --git a/doc/board/asus/transformer_t30.rst b/doc/board/asus/transformer_t30.rst
index bebc4b9fad3..5cd2bca367d 100644
--- a/doc/board/asus/transformer_t30.rst
+++ b/doc/board/asus/transformer_t30.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the ASUS Transformer device family
 =============================================
diff --git a/doc/board/atmel/at91ek.rst b/doc/board/atmel/at91ek.rst
index a500b2f8950..c86ca13e0b3 100644
--- a/doc/board/atmel/at91ek.rst
+++ b/doc/board/atmel/at91ek.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 AT91 Evaluation kits
 ====================
diff --git a/doc/board/atmel/index.rst b/doc/board/atmel/index.rst
index 8ba00fc2275..6acfd52053a 100644
--- a/doc/board/atmel/index.rst
+++ b/doc/board/atmel/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Atmel
 =====
diff --git a/doc/board/beacon/beacon-imx8mm.rst b/doc/board/beacon/beacon-imx8mm.rst
index 8bf983bff77..5949f6f51d8 100644
--- a/doc/board/beacon/beacon-imx8mm.rst
+++ b/doc/board/beacon/beacon-imx8mm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the Beacon EmbeddedWorks i.MX8M Mini Devkit
 ======================================================
diff --git a/doc/board/beacon/beacon-imx8mn.rst b/doc/board/beacon/beacon-imx8mn.rst
index bb4a86369bb..c1c134c5876 100644
--- a/doc/board/beacon/beacon-imx8mn.rst
+++ b/doc/board/beacon/beacon-imx8mn.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the Beacon EmbeddedWorks i.MX8M Nano Devkit
 ======================================================
diff --git a/doc/board/beacon/beacon-imx8mp.rst b/doc/board/beacon/beacon-imx8mp.rst
index 375931c07d1..c0bea526060 100644
--- a/doc/board/beacon/beacon-imx8mp.rst
+++ b/doc/board/beacon/beacon-imx8mp.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the Beacon EmbeddedWorks i.MX8M Plus Devkit
 ======================================================
diff --git a/doc/board/beacon/index.rst b/doc/board/beacon/index.rst
index bf62b09fbad..68476aa09fb 100644
--- a/doc/board/beacon/index.rst
+++ b/doc/board/beacon/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Beacon
 ======
diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index bc71aabaac3..6a8ead6c9ec 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Nishanth Menon <nm@ti.com>
 
 AM62x Beagleboard.org Beagleplay
diff --git a/doc/board/beagle/index.rst b/doc/board/beagle/index.rst
index 9124546ebc7..305080a569f 100644
--- a/doc/board/beagle/index.rst
+++ b/doc/board/beagle/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 BeagleBoard.org
 ###############
diff --git a/doc/board/beagle/j721e_beagleboneai64.rst b/doc/board/beagle/j721e_beagleboneai64.rst
index 090b2b3b86a..400350c67f0 100644
--- a/doc/board/beagle/j721e_beagleboneai64.rst
+++ b/doc/board/beagle/j721e_beagleboneai64.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Nishanth Menon <nm@ti.com>
 
 J721E/TDA4VM Beagleboard.org BeagleBone AI-64
diff --git a/doc/board/broadcom/bcm7xxx.rst b/doc/board/broadcom/bcm7xxx.rst
index f1994d9f975..62232912e00 100644
--- a/doc/board/broadcom/bcm7xxx.rst
+++ b/doc/board/broadcom/bcm7xxx.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2018, 2023 Thomas Fitzsimmons <fitzsim@fitzsim.org>
 
 BCM7445 and BCM7260
diff --git a/doc/board/broadcom/index.rst b/doc/board/broadcom/index.rst
index ca34afc82be..4415003f4d2 100644
--- a/doc/board/broadcom/index.rst
+++ b/doc/board/broadcom/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2022 Matthias Brugger <mbrugger@suse.com>
 
 Broadcom
diff --git a/doc/board/broadcom/northstar.rst b/doc/board/broadcom/northstar.rst
index f4bc0acd010..9ed39f91921 100644
--- a/doc/board/broadcom/northstar.rst
+++ b/doc/board/broadcom/northstar.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2023 Linus Walleij <linus.walleij@linaro.org>
 
 Broadcom Northstar Boards
diff --git a/doc/board/broadcom/raspberrypi.rst b/doc/board/broadcom/raspberrypi.rst
index 1d00b38bb23..b6b29984b3f 100644
--- a/doc/board/broadcom/raspberrypi.rst
+++ b/doc/board/broadcom/raspberrypi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2022 Matthias Brugger <mbrugger@suse.com>
 
 Raspberry Pi
diff --git a/doc/board/bsh/imx8mn_bsh_smm_s2.rst b/doc/board/bsh/imx8mn_bsh_smm_s2.rst
index 1db1c8299c7..c43fc27c568 100644
--- a/doc/board/bsh/imx8mn_bsh_smm_s2.rst
+++ b/doc/board/bsh/imx8mn_bsh_smm_s2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mn_bsh_smm_s2
 =================
diff --git a/doc/board/bsh/index.rst b/doc/board/bsh/index.rst
index 570ee4d72ed..4ceb88ba0e5 100644
--- a/doc/board/bsh/index.rst
+++ b/doc/board/bsh/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 BSH Hausgeraete GmbH
 ====================
diff --git a/doc/board/cloos/imx8mm_phg.rst b/doc/board/cloos/imx8mm_phg.rst
index 173f02d4aed..a6fb1430396 100644
--- a/doc/board/cloos/imx8mm_phg.rst
+++ b/doc/board/cloos/imx8mm_phg.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Cloos i.MX8MM PHG board
 =======================
diff --git a/doc/board/cloos/index.rst b/doc/board/cloos/index.rst
index 02c84152db6..7a06f35c6d6 100644
--- a/doc/board/cloos/index.rst
+++ b/doc/board/cloos/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Cloos
 =====
diff --git a/doc/board/congatec/cgtqmx8.rst b/doc/board/congatec/cgtqmx8.rst
index a970cb82a12..2dfe69432af 100644
--- a/doc/board/congatec/cgtqmx8.rst
+++ b/doc/board/congatec/cgtqmx8.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the Congatec conga-QMX8 board
 ========================================
diff --git a/doc/board/congatec/index.rst b/doc/board/congatec/index.rst
index cc57b36b2e5..1cab3e868c3 100644
--- a/doc/board/congatec/index.rst
+++ b/doc/board/congatec/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Congatec
 ========
diff --git a/doc/board/coolpi/genbook_cm5_rk3588.rst b/doc/board/coolpi/genbook_cm5_rk3588.rst
index a02e561051a..debc350d787 100644
--- a/doc/board/coolpi/genbook_cm5_rk3588.rst
+++ b/doc/board/coolpi/genbook_cm5_rk3588.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 GenBook
 =======
diff --git a/doc/board/coolpi/index.rst b/doc/board/coolpi/index.rst
index 9c9593fd6aa..dd5008f766a 100644
--- a/doc/board/coolpi/index.rst
+++ b/doc/board/coolpi/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Cool Pi
 =================
diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index f52b24ff43d..aae45fcab02 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 Coreboot
diff --git a/doc/board/coreboot/index.rst b/doc/board/coreboot/index.rst
index d148db95f36..dec234b0c2f 100644
--- a/doc/board/coreboot/index.rst
+++ b/doc/board/coreboot/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Coreboot
 ========
diff --git a/doc/board/emcraft/index.rst b/doc/board/emcraft/index.rst
index 564552cb369..8625aa1457b 100644
--- a/doc/board/emcraft/index.rst
+++ b/doc/board/emcraft/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Emcraft
 =======
diff --git a/doc/board/emulation/acpi.rst b/doc/board/emulation/acpi.rst
index 17b68e1b780..7bc489b7a90 100644
--- a/doc/board/emulation/acpi.rst
+++ b/doc/board/emulation/acpi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 ACPI on QEMU
 ============
diff --git a/doc/board/emulation/blkdev.rst b/doc/board/emulation/blkdev.rst
index f187ff22a86..017161bd137 100644
--- a/doc/board/emulation/blkdev.rst
+++ b/doc/board/emulation/blkdev.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Emulation of block devices
 --------------------------
diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index f8908166276..8a22cca0670 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Emulation
 =========
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 1c91c7f3ac6..a94b83d126b 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2017, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
 
 QEMU ARM
diff --git a/doc/board/emulation/qemu-mips.rst b/doc/board/emulation/qemu-mips.rst
index 5fd8a0a23bf..d40c9560a67 100644
--- a/doc/board/emulation/qemu-mips.rst
+++ b/doc/board/emulation/qemu-mips.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
 
 QEMU MIPS
diff --git a/doc/board/emulation/qemu-ppce500.rst b/doc/board/emulation/qemu-ppce500.rst
index 82b50a01de7..4b0b82c2a36 100644
--- a/doc/board/emulation/qemu-ppce500.rst
+++ b/doc/board/emulation/qemu-ppce500.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2021, Bin Meng <bmeng.cn@gmail.com>
 
 QEMU PPC E500
diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index 8388e13d96d..e3688f0bbb6 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
 
 QEMU RISC-V
diff --git a/doc/board/emulation/qemu-sbsa.rst b/doc/board/emulation/qemu-sbsa.rst
index fe1dc3249e4..e97a78cc963 100644
--- a/doc/board/emulation/qemu-sbsa.rst
+++ b/doc/board/emulation/qemu-sbsa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2024, Patrick Rudolph <patrick.rudolph@9elements.com>
 
 QEMU ARM SBSA
diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
index c604e42990e..a6b70292608 100644
--- a/doc/board/emulation/qemu-x86.rst
+++ b/doc/board/emulation/qemu-x86.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 QEMU x86
diff --git a/doc/board/emulation/qemu-xtensa.rst b/doc/board/emulation/qemu-xtensa.rst
index fff23c1a9b0..5bfd55a914d 100644
--- a/doc/board/emulation/qemu-xtensa.rst
+++ b/doc/board/emulation/qemu-xtensa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
 
 QEMU Xtensa
diff --git a/doc/board/gateworks/imx8mm_venice.rst b/doc/board/gateworks/imx8mm_venice.rst
index ea78dfd7ae6..0917ed230e3 100644
--- a/doc/board/gateworks/imx8mm_venice.rst
+++ b/doc/board/gateworks/imx8mm_venice.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mm_venice
 =============
diff --git a/doc/board/gateworks/imx8mn_venice.rst b/doc/board/gateworks/imx8mn_venice.rst
index 7015f4ef31c..e10fd64df7d 100644
--- a/doc/board/gateworks/imx8mn_venice.rst
+++ b/doc/board/gateworks/imx8mn_venice.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mn_venice
 =============
diff --git a/doc/board/gateworks/imx8mp_venice.rst b/doc/board/gateworks/imx8mp_venice.rst
index a219caadff2..6cf85a7ad80 100644
--- a/doc/board/gateworks/imx8mp_venice.rst
+++ b/doc/board/gateworks/imx8mp_venice.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mp_venice
 =============
diff --git a/doc/board/gateworks/index.rst b/doc/board/gateworks/index.rst
index 6cf0839814d..a3032b78dbb 100644
--- a/doc/board/gateworks/index.rst
+++ b/doc/board/gateworks/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Gateworks
 =========
diff --git a/doc/board/google/chromebook_coral.rst b/doc/board/google/chromebook_coral.rst
index 1eda769c752..164b58e1c2e 100644
--- a/doc/board/google/chromebook_coral.rst
+++ b/doc/board/google/chromebook_coral.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
 Chromebook Coral
diff --git a/doc/board/google/chromebook_link.rst b/doc/board/google/chromebook_link.rst
index 16080304d6e..3f87bb79025 100644
--- a/doc/board/google/chromebook_link.rst
+++ b/doc/board/google/chromebook_link.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
 Chromebook Link
diff --git a/doc/board/google/chromebook_samus.rst b/doc/board/google/chromebook_samus.rst
index 822ba575e2f..fc3001fe5e7 100644
--- a/doc/board/google/chromebook_samus.rst
+++ b/doc/board/google/chromebook_samus.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
 Chromebook Samus
diff --git a/doc/board/google/index.rst b/doc/board/google/index.rst
index 061c7977187..68397f70ad3 100644
--- a/doc/board/google/index.rst
+++ b/doc/board/google/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Google
 ======
diff --git a/doc/board/highbank/index.rst b/doc/board/highbank/index.rst
index b6975ca4964..89305e8f965 100644
--- a/doc/board/highbank/index.rst
+++ b/doc/board/highbank/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Highbank
 ========
diff --git a/doc/board/htc/endeavoru.rst b/doc/board/htc/endeavoru.rst
index e0edefe28ae..7300e8cc6dc 100644
--- a/doc/board/htc/endeavoru.rst
+++ b/doc/board/htc/endeavoru.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the HTC One X (endeavoru)
 ====================================
diff --git a/doc/board/htc/index.rst b/doc/board/htc/index.rst
index 955c9b9e03d..e0b5c2181c1 100644
--- a/doc/board/htc/index.rst
+++ b/doc/board/htc/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 HTC
 ===
diff --git a/doc/board/index.rst b/doc/board/index.rst
index b54c1748d57..8c0607a8ed3 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Board-specific doc
 ==================
diff --git a/doc/board/intel/bayleybay.rst b/doc/board/intel/bayleybay.rst
index db97f645fdf..dba00b73942 100644
--- a/doc/board/intel/bayleybay.rst
+++ b/doc/board/intel/bayleybay.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 Bayley Bay CRB
diff --git a/doc/board/intel/cherryhill.rst b/doc/board/intel/cherryhill.rst
index 151f0613f8c..b1391380a9e 100644
--- a/doc/board/intel/cherryhill.rst
+++ b/doc/board/intel/cherryhill.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 Cherry Hill CRB
diff --git a/doc/board/intel/cougarcanyon2.rst b/doc/board/intel/cougarcanyon2.rst
index 5e3e7a18204..2eba7e3dbc1 100644
--- a/doc/board/intel/cougarcanyon2.rst
+++ b/doc/board/intel/cougarcanyon2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 Cougar Canyon 2 CRB
diff --git a/doc/board/intel/crownbay.rst b/doc/board/intel/crownbay.rst
index 4fcf9811c1a..47452c8af24 100644
--- a/doc/board/intel/crownbay.rst
+++ b/doc/board/intel/crownbay.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 Crown Bay CRB
diff --git a/doc/board/intel/edison.rst b/doc/board/intel/edison.rst
index 782d75a6745..ebe355168f0 100644
--- a/doc/board/intel/edison.rst
+++ b/doc/board/intel/edison.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 
 Edison
diff --git a/doc/board/intel/galileo.rst b/doc/board/intel/galileo.rst
index f51a06bb9e8..6a236e315d3 100644
--- a/doc/board/intel/galileo.rst
+++ b/doc/board/intel/galileo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 Galileo
diff --git a/doc/board/intel/index.rst b/doc/board/intel/index.rst
index f545dee87ab..be8ae19f0f5 100644
--- a/doc/board/intel/index.rst
+++ b/doc/board/intel/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Intel
 =====
diff --git a/doc/board/intel/minnowmax.rst b/doc/board/intel/minnowmax.rst
index d0286bd9937..d30d722a38c 100644
--- a/doc/board/intel/minnowmax.rst
+++ b/doc/board/intel/minnowmax.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
 Minnowboard MAX
diff --git a/doc/board/intel/slimbootloader.rst b/doc/board/intel/slimbootloader.rst
index 87d71a55bdc..23c0ab3f746 100644
--- a/doc/board/intel/slimbootloader.rst
+++ b/doc/board/intel/slimbootloader.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Aiden Park <aiden.park@intel.com>
 
 Slim Bootloader
diff --git a/doc/board/kontron/index.rst b/doc/board/kontron/index.rst
index cb1906e626b..d07f7eb23e6 100644
--- a/doc/board/kontron/index.rst
+++ b/doc/board/kontron/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kontron
 =======
diff --git a/doc/board/kontron/pitx-imx8m.rst b/doc/board/kontron/pitx-imx8m.rst
index b90221b165e..cd83e6d66ac 100644
--- a/doc/board/kontron/pitx-imx8m.rst
+++ b/doc/board/kontron/pitx-imx8m.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kontron pitx-imx8m
 ==================
diff --git a/doc/board/kontron/sl-mx6ul.rst b/doc/board/kontron/sl-mx6ul.rst
index b0b0f44db2c..b9786e2b818 100644
--- a/doc/board/kontron/sl-mx6ul.rst
+++ b/doc/board/kontron/sl-mx6ul.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kontron Electronics SL i.MX6UL/ULL SoM
 ======================================
diff --git a/doc/board/kontron/sl-mx8mm.rst b/doc/board/kontron/sl-mx8mm.rst
index 702db60fe38..9c8a8e8a02e 100644
--- a/doc/board/kontron/sl-mx8mm.rst
+++ b/doc/board/kontron/sl-mx8mm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kontron Electronics i.MX8MM SoMs and Boards
 ===========================================
diff --git a/doc/board/kontron/sl28.rst b/doc/board/kontron/sl28.rst
index 2cb8ec62be4..ec6c8a1d50d 100644
--- a/doc/board/kontron/sl28.rst
+++ b/doc/board/kontron/sl28.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kontron SMARC-sAL28
 ===================
diff --git a/doc/board/lenovo/ideapad-yoga-11.rst b/doc/board/lenovo/ideapad-yoga-11.rst
index 94bf171b35f..1710300b02d 100644
--- a/doc/board/lenovo/ideapad-yoga-11.rst
+++ b/doc/board/lenovo/ideapad-yoga-11.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the Lenovo Ideapad Yoga 11 tablet
 ============================================
diff --git a/doc/board/lenovo/index.rst b/doc/board/lenovo/index.rst
index 2ce457ab045..2be128cc997 100644
--- a/doc/board/lenovo/index.rst
+++ b/doc/board/lenovo/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Lenovo
 =========
diff --git a/doc/board/lg/index.rst b/doc/board/lg/index.rst
index 3af3681e0bb..54bd08921aa 100644
--- a/doc/board/lg/index.rst
+++ b/doc/board/lg/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 LG
 ==
diff --git a/doc/board/lg/x3_t30.rst b/doc/board/lg/x3_t30.rst
index 618b00d34e3..107d908dd32 100644
--- a/doc/board/lg/x3_t30.rst
+++ b/doc/board/lg/x3_t30.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the LG X3 T30 device family
 ======================================
diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
index c55d5aeb5c4..31ab632ec91 100644
--- a/doc/board/mediatek/index.rst
+++ b/doc/board/mediatek/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Mediatek
 ========
diff --git a/doc/board/microchip/index.rst b/doc/board/microchip/index.rst
index affc5a9e014..da6d90c296e 100644
--- a/doc/board/microchip/index.rst
+++ b/doc/board/microchip/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Microchip
 =========
diff --git a/doc/board/microchip/mpfs_icicle.rst b/doc/board/microchip/mpfs_icicle.rst
index 1464e536e94..39d8818eab4 100644
--- a/doc/board/microchip/mpfs_icicle.rst
+++ b/doc/board/microchip/mpfs_icicle.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Microchip PolarFire SoC Icicle Kit
 ==================================
diff --git a/doc/board/microsoft/index.rst b/doc/board/microsoft/index.rst
index 107f3527852..5024dd9280d 100644
--- a/doc/board/microsoft/index.rst
+++ b/doc/board/microsoft/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Microsoft
 =========
diff --git a/doc/board/microsoft/surface-rt.rst b/doc/board/microsoft/surface-rt.rst
index b5645e79340..e0014f42b25 100644
--- a/doc/board/microsoft/surface-rt.rst
+++ b/doc/board/microsoft/surface-rt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the Microsoft Surface RT tablet
 ==========================================
diff --git a/doc/board/nxp/imx8mm_evk.rst b/doc/board/nxp/imx8mm_evk.rst
index bb11029fbcd..870aec51d66 100644
--- a/doc/board/nxp/imx8mm_evk.rst
+++ b/doc/board/nxp/imx8mm_evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mm_evk
 ==========
diff --git a/doc/board/nxp/imx8mn_evk.rst b/doc/board/nxp/imx8mn_evk.rst
index 4f225ea6601..d5abc2239ce 100644
--- a/doc/board/nxp/imx8mn_evk.rst
+++ b/doc/board/nxp/imx8mn_evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mn_evk
 ==========
diff --git a/doc/board/nxp/imx8mp_evk.rst b/doc/board/nxp/imx8mp_evk.rst
index 72175dbe78f..707494ff19b 100644
--- a/doc/board/nxp/imx8mp_evk.rst
+++ b/doc/board/nxp/imx8mp_evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mp_evk
 ==========
diff --git a/doc/board/nxp/imx8mq_evk.rst b/doc/board/nxp/imx8mq_evk.rst
index 4b0624e7e86..5fd5de2195d 100644
--- a/doc/board/nxp/imx8mq_evk.rst
+++ b/doc/board/nxp/imx8mq_evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mq_evk
 ==========
diff --git a/doc/board/nxp/imx8qxp_mek.rst b/doc/board/nxp/imx8qxp_mek.rst
index bdd38368f1a..251016956fa 100644
--- a/doc/board/nxp/imx8qxp_mek.rst
+++ b/doc/board/nxp/imx8qxp_mek.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8qxp_mek
 ===========
diff --git a/doc/board/nxp/imx8ulp_evk.rst b/doc/board/nxp/imx8ulp_evk.rst
index a9f5546311d..fdd99065cd3 100644
--- a/doc/board/nxp/imx8ulp_evk.rst
+++ b/doc/board/nxp/imx8ulp_evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8ulp_evk
 =======================
diff --git a/doc/board/nxp/imx93_11x11_evk.rst b/doc/board/nxp/imx93_11x11_evk.rst
index 171645ad06c..05efe310509 100644
--- a/doc/board/nxp/imx93_11x11_evk.rst
+++ b/doc/board/nxp/imx93_11x11_evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx93_11x11_evk
 =======================
diff --git a/doc/board/nxp/imx93_9x9_qsb.rst b/doc/board/nxp/imx93_9x9_qsb.rst
index e4dfe473bc0..6819672d873 100644
--- a/doc/board/nxp/imx93_9x9_qsb.rst
+++ b/doc/board/nxp/imx93_9x9_qsb.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx93_9x9_qsb
 =======================
diff --git a/doc/board/nxp/imxrt1020-evk.rst b/doc/board/nxp/imxrt1020-evk.rst
index 267f80c5170..05b66284162 100644
--- a/doc/board/nxp/imxrt1020-evk.rst
+++ b/doc/board/nxp/imxrt1020-evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imxrt1020-evk
 =============
diff --git a/doc/board/nxp/imxrt1050-evk.rst b/doc/board/nxp/imxrt1050-evk.rst
index e0cafe1035d..a12be841ce6 100644
--- a/doc/board/nxp/imxrt1050-evk.rst
+++ b/doc/board/nxp/imxrt1050-evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imxrt1050-evk
 =============
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 734bab69807..b82ed163059 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 NXP Semiconductors
 ==================
diff --git a/doc/board/nxp/ls1046ardb.rst b/doc/board/nxp/ls1046ardb.rst
index 8c0bc82dde7..2201612d51b 100644
--- a/doc/board/nxp/ls1046ardb.rst
+++ b/doc/board/nxp/ls1046ardb.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 LS1046ARDB
 ==========
diff --git a/doc/board/nxp/mx6sabreauto.rst b/doc/board/nxp/mx6sabreauto.rst
index fe4cd9d2141..ef827c9682c 100644
--- a/doc/board/nxp/mx6sabreauto.rst
+++ b/doc/board/nxp/mx6sabreauto.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 mx6sabreauto
 ============
diff --git a/doc/board/nxp/mx6sabresd.rst b/doc/board/nxp/mx6sabresd.rst
index c9869f4a73a..36fcb5ebe3e 100644
--- a/doc/board/nxp/mx6sabresd.rst
+++ b/doc/board/nxp/mx6sabresd.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 mx6sabresd
 ==========
diff --git a/doc/board/nxp/mx6ul_14x14_evk.rst b/doc/board/nxp/mx6ul_14x14_evk.rst
index c135a21bf5b..bcdb6a3d499 100644
--- a/doc/board/nxp/mx6ul_14x14_evk.rst
+++ b/doc/board/nxp/mx6ul_14x14_evk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 mx6ul_14x14_evk
 ===============
diff --git a/doc/board/nxp/mx6ullevk.rst b/doc/board/nxp/mx6ullevk.rst
index a26248a1e3b..0d15a5e6294 100644
--- a/doc/board/nxp/mx6ullevk.rst
+++ b/doc/board/nxp/mx6ullevk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 mx6ullevk
 =========
diff --git a/doc/board/openpiton/index.rst b/doc/board/openpiton/index.rst
index c469102c4b0..fdaf6837843 100644
--- a/doc/board/openpiton/index.rst
+++ b/doc/board/openpiton/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 OpenPiton
 =========
diff --git a/doc/board/openpiton/riscv64.rst b/doc/board/openpiton/riscv64.rst
index c379fbf9ffe..d8d406c6a9b 100644
--- a/doc/board/openpiton/riscv64.rst
+++ b/doc/board/openpiton/riscv64.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Openpiton RISC-V SoC
 ====================
diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index 28b614fd144..0af491731a9 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 phyGATE-Tauri-L-i.MX 8M Mini
 ============================
diff --git a/doc/board/phytec/imx93-phyboard-segin.rst b/doc/board/phytec/imx93-phyboard-segin.rst
index ce17fbec78d..a655376348f 100644
--- a/doc/board/phytec/imx93-phyboard-segin.rst
+++ b/doc/board/phytec/imx93-phyboard-segin.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 phyBOARD-Segin-i.MX93
 =====================
diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index 99848a9e958..c960f09b8bc 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 PHYTEC
 ======
diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index 56c1fd8354b..3e54ea6c061 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
 
 phyCORE-AM62x
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index 01c42b90660..f626761f171 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
 
 phyCORE-AM64x
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index e9dc2259907..493a458ea0e 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 phyCORE-i.MX 8M Mini
 ====================
diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index fda751aeffb..2ec2f1ad2e6 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 phyCORE-i.MX 8M Plus
 ====================
diff --git a/doc/board/purism/index.rst b/doc/board/purism/index.rst
index a9cdc312d46..8bc0432c267 100644
--- a/doc/board/purism/index.rst
+++ b/doc/board/purism/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Purism SPC
 ==========
diff --git a/doc/board/purism/librem5.rst b/doc/board/purism/librem5.rst
index a7975e1659b..cc6523d3b5d 100644
--- a/doc/board/purism/librem5.rst
+++ b/doc/board/purism/librem5.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Librem5
 =======
diff --git a/doc/board/qnap/index.rst b/doc/board/qnap/index.rst
index 652ea11a056..c7bb7e8583b 100644
--- a/doc/board/qnap/index.rst
+++ b/doc/board/qnap/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Qnap
 ====
diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
index 1e1bfbb9190..1e09410262f 100644
--- a/doc/board/qnap/ts433.rst
+++ b/doc/board/qnap/ts433.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for Qnap TS433 Devices
 =================================
diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index 4d793209f9e..3a5f3b7b923 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
 
 Qualcomm generic boards
diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
index 1c35d1909d1..af6f3d26d71 100644
--- a/doc/board/qualcomm/debugging.rst
+++ b/doc/board/qualcomm/debugging.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
 
 Qualcomm debugging
diff --git a/doc/board/qualcomm/dragonboard410c.rst b/doc/board/qualcomm/dragonboard410c.rst
index 34629241110..9ec32532b4f 100644
--- a/doc/board/qualcomm/dragonboard410c.rst
+++ b/doc/board/qualcomm/dragonboard410c.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Stephan Gerhold <stephan@gerhold.net>
 
 DragonBoard 410c
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 8c7969987a9..eaba9f046d0 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Qualcomm
 ========
diff --git a/doc/board/qualcomm/rb3gen2.rst b/doc/board/qualcomm/rb3gen2.rst
index 4240606224f..a22dce6b36b 100644
--- a/doc/board/qualcomm/rb3gen2.rst
+++ b/doc/board/qualcomm/rb3gen2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
 
 Qualcomm Robotics RB3 Gen 2
diff --git a/doc/board/renesas/index.rst b/doc/board/renesas/index.rst
index fb6558ec11b..948c6fe0592 100644
--- a/doc/board/renesas/index.rst
+++ b/doc/board/renesas/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Renesas
 =======
diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 7d961e862e4..157b2d5a355 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Renesas
 =======
diff --git a/doc/board/renesas/rzn1.rst b/doc/board/renesas/rzn1.rst
index e6d636b89e8..e62cf67caba 100644
--- a/doc/board/renesas/rzn1.rst
+++ b/doc/board/renesas/rzn1.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Renesas RZ/N1
 =============
diff --git a/doc/board/rockchip/index.rst b/doc/board/rockchip/index.rst
index 9a87a035e95..e2daa6d5e1c 100644
--- a/doc/board/rockchip/index.rst
+++ b/doc/board/rockchip/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
 
 Rockchip
diff --git a/doc/board/rockchip/rkmtd.rst b/doc/board/rockchip/rkmtd.rst
index 1481380ba6c..0749c6e9224 100644
--- a/doc/board/rockchip/rkmtd.rst
+++ b/doc/board/rockchip/rkmtd.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2023 Johan Jonker <jbx6244@gmail.com>
 
 RKMTD
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9bab86d2347..670c8b7766e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
 
 ROCKCHIP
diff --git a/doc/board/samsung/axy17lte.rst b/doc/board/samsung/axy17lte.rst
index b7f299d1c7d..91788252d83 100644
--- a/doc/board/samsung/axy17lte.rst
+++ b/doc/board/samsung/axy17lte.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
 
 Samsung 2017 A series phones
diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 0a7b6fc0c9d..f49dfc7b837 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Sam Protsenko <semen.protsenko@linaro.org>
 
 WinLink E850-96 board
diff --git a/doc/board/samsung/index.rst b/doc/board/samsung/index.rst
index a1c9636b050..2dffd95f26b 100644
--- a/doc/board/samsung/index.rst
+++ b/doc/board/samsung/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Samsung
 =======
diff --git a/doc/board/schneider/hmibsc.rst b/doc/board/schneider/hmibsc.rst
index f09fb5af1b3..addb65cebc5 100644
--- a/doc/board/schneider/hmibsc.rst
+++ b/doc/board/schneider/hmibsc.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Sumit Garg <sumit.garg@linaro.org>
 
 HMIBSC
diff --git a/doc/board/schneider/index.rst b/doc/board/schneider/index.rst
index 55792ed3100..5d2e17f6751 100644
--- a/doc/board/schneider/index.rst
+++ b/doc/board/schneider/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Schneider Electric
 ==================
diff --git a/doc/board/sielaff/imx6dl-sielaff.rst b/doc/board/sielaff/imx6dl-sielaff.rst
index 699079b3271..3f5ba0accd7 100644
--- a/doc/board/sielaff/imx6dl-sielaff.rst
+++ b/doc/board/sielaff/imx6dl-sielaff.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sielaff i.MX6 Solo Board
 ========================
diff --git a/doc/board/sielaff/index.rst b/doc/board/sielaff/index.rst
index a8376484d88..36f17859ea7 100644
--- a/doc/board/sielaff/index.rst
+++ b/doc/board/sielaff/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sielaff
 =======
diff --git a/doc/board/siemens/index.rst b/doc/board/siemens/index.rst
index 082936ea7e7..4b634eb61af 100644
--- a/doc/board/siemens/index.rst
+++ b/doc/board/siemens/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Siemens
 =======
diff --git a/doc/board/siemens/iot2050.rst b/doc/board/siemens/iot2050.rst
index 37b23f6146b..2c99af6acdd 100644
--- a/doc/board/siemens/iot2050.rst
+++ b/doc/board/siemens/iot2050.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Jan Kiszka <jan.kiszka@siemens.com>
 
 SIMATIC IOT2050 BASIC and ADVANCED
diff --git a/doc/board/sifive/index.rst b/doc/board/sifive/index.rst
index a43937a3e0a..671e0339d06 100644
--- a/doc/board/sifive/index.rst
+++ b/doc/board/sifive/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 SiFive
 ======
diff --git a/doc/board/sifive/unleashed.rst b/doc/board/sifive/unleashed.rst
index ce38b701d78..9ea1a6bd543 100644
--- a/doc/board/sifive/unleashed.rst
+++ b/doc/board/sifive/unleashed.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 HiFive Unleashed
 ================
diff --git a/doc/board/sifive/unmatched.rst b/doc/board/sifive/unmatched.rst
index c515949066f..6a13696abec 100644
--- a/doc/board/sifive/unmatched.rst
+++ b/doc/board/sifive/unmatched.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 HiFive Unmatched
 ================
diff --git a/doc/board/sipeed/index.rst b/doc/board/sipeed/index.rst
index 3518e2d8f4d..8f4522783c6 100644
--- a/doc/board/sipeed/index.rst
+++ b/doc/board/sipeed/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sipeed
 ======
diff --git a/doc/board/sipeed/maix.rst b/doc/board/sipeed/maix.rst
index 4568bb3e4b7..61dd1eed65b 100644
--- a/doc/board/sipeed/maix.rst
+++ b/doc/board/sipeed/maix.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
 
 MAIX
diff --git a/doc/board/socionext/developerbox.rst b/doc/board/socionext/developerbox.rst
index 863761c6e27..35e9683a5d4 100644
--- a/doc/board/socionext/developerbox.rst
+++ b/doc/board/socionext/developerbox.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Introduction
 ============
diff --git a/doc/board/socionext/index.rst b/doc/board/socionext/index.rst
index 4673dcc45be..3765c97a19b 100644
--- a/doc/board/socionext/index.rst
+++ b/doc/board/socionext/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Socionext
 =========
diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
index e097afdac64..d6c6805c4aa 100644
--- a/doc/board/sophgo/index.rst
+++ b/doc/board/sophgo/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sophgo
 ======
diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
index cb2ed1ad987..89c415a5673 100644
--- a/doc/board/sophgo/milkv_duo.rst
+++ b/doc/board/sophgo/milkv_duo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Milk-V Duo
 ==========
diff --git a/doc/board/st/index.rst b/doc/board/st/index.rst
index 2a8a4ef3b84..0a39d450c8c 100644
--- a/doc/board/st/index.rst
+++ b/doc/board/st/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 STMicroelectronics
 ==================
diff --git a/doc/board/st/st-dt.rst b/doc/board/st/st-dt.rst
index 2a285c81807..3c96372c3c9 100644
--- a/doc/board/st/st-dt.rst
+++ b/doc/board/st/st-dt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Patrick Delaunay <patrick.delaunay@foss.st.com>
 
 U-Boot device tree bindings
diff --git a/doc/board/st/stm32_MCU.rst b/doc/board/st/stm32_MCU.rst
index 61650bc8011..93bed8d3acf 100644
--- a/doc/board/st/stm32_MCU.rst
+++ b/doc/board/st/stm32_MCU.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Patrice Chotard <patrice.chotardy@foss.st.com>
 
 STM32 MCU boards
diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
index 8cf71299233..d778d9ade26 100644
--- a/doc/board/st/stm32mp1.rst
+++ b/doc/board/st/stm32mp1.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Patrick Delaunay <patrick.delaunay@foss.st.com>
 
 STM32MP1xx boards
diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 72ab6ddfbf6..dd4d81b9e70 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 StarFive
 ========
diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
index 554932ecfd4..b63b1dcce01 100644
--- a/doc/board/starfive/milk-v_mars.rst
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Milk-V Mars
 ===========
diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/milk-v_mars_cm.rst
index 52d4e5e9098..282c8b8d3dc 100644
--- a/doc/board/starfive/milk-v_mars_cm.rst
+++ b/doc/board/starfive/milk-v_mars_cm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Milk-V Mars CM
 ==============
diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine64_star64.rst
index 52e9a907917..4c1fffb6d62 100644
--- a/doc/board/starfive/pine64_star64.rst
+++ b/doc/board/starfive/pine64_star64.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Pine64 Star64
 =============
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 2c68df3ce4d..f8f00e4e79b 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 StarFive VisionFive2
 ====================
diff --git a/doc/board/ste/index.rst b/doc/board/ste/index.rst
index bef520ce63f..0f781e3499c 100644
--- a/doc/board/ste/index.rst
+++ b/doc/board/ste/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 ST-Ericsson
 ===========
diff --git a/doc/board/ste/stemmy.rst b/doc/board/ste/stemmy.rst
index 6d77fe9c831..562ba215409 100644
--- a/doc/board/ste/stemmy.rst
+++ b/doc/board/ste/stemmy.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Stephan Gerhold <stephan@gerhold.net>
 
 ST-Ericsson U8500 Samsung "stemmy" board
diff --git a/doc/board/tbs/index.rst b/doc/board/tbs/index.rst
index b677bc624fd..b588aa8af55 100644
--- a/doc/board/tbs/index.rst
+++ b/doc/board/tbs/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 TBS
 ===
diff --git a/doc/board/thead/index.rst b/doc/board/thead/index.rst
index 2c4b3fb8cb3..31a58896351 100644
--- a/doc/board/thead/index.rst
+++ b/doc/board/thead/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 T-HEAD
 ======
diff --git a/doc/board/thead/lpi4a.rst b/doc/board/thead/lpi4a.rst
index e395c6ae12c..04935d04eff 100644
--- a/doc/board/thead/lpi4a.rst
+++ b/doc/board/thead/lpi4a.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sipeed's Lichee PI 4A based on T-HEAD TH1520 SoC
 ================================================
diff --git a/doc/board/theobroma-systems/index.rst b/doc/board/theobroma-systems/index.rst
index 73e07f7ebfa..324017b2634 100644
--- a/doc/board/theobroma-systems/index.rst
+++ b/doc/board/theobroma-systems/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Theobroma Systems
 =================
diff --git a/doc/board/theobroma-systems/jaguar_rk3588.rst b/doc/board/theobroma-systems/jaguar_rk3588.rst
index db15f945d3b..a751342878d 100644
--- a/doc/board/theobroma-systems/jaguar_rk3588.rst
+++ b/doc/board/theobroma-systems/jaguar_rk3588.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 SBC-RK3588-AMR Jaguar
 =====================
diff --git a/doc/board/theobroma-systems/puma_rk3399.rst b/doc/board/theobroma-systems/puma_rk3399.rst
index 5bc6385e451..ef61db8f89b 100644
--- a/doc/board/theobroma-systems/puma_rk3399.rst
+++ b/doc/board/theobroma-systems/puma_rk3399.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 RK3399-Q7 Puma
 ==============
diff --git a/doc/board/theobroma-systems/ringneck_px30.rst b/doc/board/theobroma-systems/ringneck_px30.rst
index c16b9ed17ed..d856cdb2e21 100644
--- a/doc/board/theobroma-systems/ringneck_px30.rst
+++ b/doc/board/theobroma-systems/ringneck_px30.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 PX30-uQ7 Ringneck
 =================
diff --git a/doc/board/theobroma-systems/tiger_rk3588.rst b/doc/board/theobroma-systems/tiger_rk3588.rst
index a73eec7fb9b..bec133344da 100644
--- a/doc/board/theobroma-systems/tiger_rk3588.rst
+++ b/doc/board/theobroma-systems/tiger_rk3588.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 SOM-RK3588-Q7 Tiger
 ===================
diff --git a/doc/board/ti/am335x_evm.rst b/doc/board/ti/am335x_evm.rst
index 7a3125d705b..8e64c79be33 100644
--- a/doc/board/ti/am335x_evm.rst
+++ b/doc/board/ti/am335x_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Tom Rini <trini@konsulko.com>
 
 AM335x Generation
diff --git a/doc/board/ti/am43xx_evm.rst b/doc/board/ti/am43xx_evm.rst
index 543526cd281..e2e67f44124 100644
--- a/doc/board/ti/am43xx_evm.rst
+++ b/doc/board/ti/am43xx_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Neha Malcom Francis <n-francis@ti.com>
 
 AM43xx Generation
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 262340ef59a..871867874f7 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Jai Luthra <j-luthra@ti.com>
 
 AM62A Platforms
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index 99bdc034869..3b5dba63311 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Bryan Brattlof <bb@ti.com>
 
 AM62Px Platforms
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index dab2970a85c..7f280bd96b8 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Vignesh Raghavendra <vigneshr@ti.com>
 
 AM62 Platforms
diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 65c4c456528..178cc8c9f54 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Nishanth Menon <nm@ti.com>
 
 AM64 Platforms
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 60b08ceebf0..ac3eea9ca6d 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Neha Francis <n-francis@ti.com>
 
 AM65x Platforms
diff --git a/doc/board/ti/dra7xx_evm.rst b/doc/board/ti/dra7xx_evm.rst
index 8e5d95535fa..7a91102998f 100644
--- a/doc/board/ti/dra7xx_evm.rst
+++ b/doc/board/ti/dra7xx_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Neha Malcom Francis <n-francis@ti.com>
 
 DRA7xx Generation
diff --git a/doc/board/ti/index.rst b/doc/board/ti/index.rst
index b9cdf23e68f..033d8ad7f54 100644
--- a/doc/board/ti/index.rst
+++ b/doc/board/ti/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Texas Instruments
 #################
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 4fd2aff8354..54f314b2f40 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Udit Kumar <u-kumar1@ti.com>
 
 J7200 Platforms
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 41c8d4c72a8..5b2c34f0890 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Lokesh Vutla <lokeshvutla@ti.com>
 
 J721E Platforms
diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
index 21683b90b1a..66a9cc8d13b 100644
--- a/doc/board/ti/j721s2_evm.rst
+++ b/doc/board/ti/j721s2_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Manorit Chawdhry <m-chawdhry@ti.com>
 
 J721S2 and AM68 Platforms
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index e5a1be50c4f..1658816bbc6 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Jayesh Choudhary <j-choudhary@ti.com>
 
 J722S-EVM Platform
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 5d01f487622..55be2cac3eb 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Bryan Brattlof <bb@ti.com>
 
 K3 Generation
diff --git a/doc/board/ti/ks2_evm.rst b/doc/board/ti/ks2_evm.rst
index 16c2e57d09d..bad7b009da3 100644
--- a/doc/board/ti/ks2_evm.rst
+++ b/doc/board/ti/ks2_evm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
 .. sectionauthor:: Neha Malcom Francis <n-francis@ti.com>
 
 Keystone II EVM Generation
diff --git a/doc/board/toradex/index.rst b/doc/board/toradex/index.rst
index 89fbdcbb9e9..d493a4b87f7 100644
--- a/doc/board/toradex/index.rst
+++ b/doc/board/toradex/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Toradex
 =======
diff --git a/doc/board/variscite/imx8mn_var_som.rst b/doc/board/variscite/imx8mn_var_som.rst
index 1b656f0be5f..986a66d04ad 100644
--- a/doc/board/variscite/imx8mn_var_som.rst
+++ b/doc/board/variscite/imx8mn_var_som.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx8mn_var_som
 ==============
diff --git a/doc/board/variscite/imx93_var_som.rst b/doc/board/variscite/imx93_var_som.rst
index 02309f2ad87..4419e7f93c4 100644
--- a/doc/board/variscite/imx93_var_som.rst
+++ b/doc/board/variscite/imx93_var_som.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 imx93_var_som
 =============
diff --git a/doc/board/variscite/index.rst b/doc/board/variscite/index.rst
index f84ebe7eb62..5d703e197af 100644
--- a/doc/board/variscite/index.rst
+++ b/doc/board/variscite/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Variscite
 =========
diff --git a/doc/board/wexler/index.rst b/doc/board/wexler/index.rst
index 308aad79e19..bd4742985fe 100644
--- a/doc/board/wexler/index.rst
+++ b/doc/board/wexler/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 WEXLER
 ======
diff --git a/doc/board/wexler/qc750.rst b/doc/board/wexler/qc750.rst
index b61e40176b0..ff8ce1de63d 100644
--- a/doc/board/wexler/qc750.rst
+++ b/doc/board/wexler/qc750.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot for the WEXLER QC750 tablet
 ==================================
diff --git a/doc/board/xen/index.rst b/doc/board/xen/index.rst
index e58fe9e3512..e9f78f58ef6 100644
--- a/doc/board/xen/index.rst
+++ b/doc/board/xen/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 XenGuestARM64
 =============
diff --git a/doc/board/xen/xenguest_arm64.rst b/doc/board/xen/xenguest_arm64.rst
index 92be9d43769..de74bb9afc9 100644
--- a/doc/board/xen/xenguest_arm64.rst
+++ b/doc/board/xen/xenguest_arm64.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Xen guest ARM64 board
 =====================
diff --git a/doc/board/xilinx/index.rst b/doc/board/xilinx/index.rst
index 2e31fe3f3a4..1a95c52e538 100644
--- a/doc/board/xilinx/index.rst
+++ b/doc/board/xilinx/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Xilinx
 ======
diff --git a/doc/board/xilinx/xilinx.rst b/doc/board/xilinx/xilinx.rst
index 5464625ac12..2fc484be083 100644
--- a/doc/board/xilinx/xilinx.rst
+++ b/doc/board/xilinx/xilinx.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 ..  (C) Copyright 2019 Xilinx, Inc.
 
 U-Boot device tree bindings
diff --git a/doc/board/xilinx/zynq.rst b/doc/board/xilinx/zynq.rst
index 76d67bd62ee..8129983a18f 100644
--- a/doc/board/xilinx/zynq.rst
+++ b/doc/board/xilinx/zynq.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 ..  (C) Copyright 2013 Xilinx, Inc.
 
 ZYNQ
diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 098c96a4c4f..7d7aca96138 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Building documentation
 ======================
diff --git a/doc/build/index.rst b/doc/build/index.rst
index 7a4507b5746..41067592e4e 100644
--- a/doc/build/index.rst
+++ b/doc/build/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Build U-Boot
 ============
diff --git a/doc/build/tools.rst b/doc/build/tools.rst
index 5bfa05b2325..281f4708801 100644
--- a/doc/build/tools.rst
+++ b/doc/build/tools.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 Host tools
diff --git a/doc/chromium/chainload.rst b/doc/chromium/chainload.rst
index b00ee94eaa4..b41f4f3a4f5 100644
--- a/doc/chromium/chainload.rst
+++ b/doc/chromium/chainload.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2020 Google LLC
 
 Running U-Boot from coreboot on Chromebooks
diff --git a/doc/chromium/index.rst b/doc/chromium/index.rst
index 0722c250033..95fb6f415c9 100644
--- a/doc/chromium/index.rst
+++ b/doc/chromium/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2020 Google LLC
 
 Chromium OS-specific doc
diff --git a/doc/chromium/overview.rst b/doc/chromium/overview.rst
index 790233cb668..5eba4c6624d 100644
--- a/doc/chromium/overview.rst
+++ b/doc/chromium/overview.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2020 Google LLC
 
 Chromium OS Support in U-Boot
diff --git a/doc/chromium/run_vboot.rst b/doc/chromium/run_vboot.rst
index a9e4408d55f..4bb342a61e3 100644
--- a/doc/chromium/run_vboot.rst
+++ b/doc/chromium/run_vboot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2020 Google LLC
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index a632694a6fe..ee152a7c17b 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. toctree::
    :maxdepth: 1
@@ -410,7 +410,7 @@ This test deliberately tries to provoke an error. The image description is:
 
 .. code-block:: devicetree
 
-    // SPDX-License-Identifier: GPL-2.0+
+    // SPDX-License-Identifier: GPL-2.0-or-later
     /dts-v1/;
 
     / {
@@ -461,7 +461,7 @@ Example from ``tools/binman/test/339_nxp_imx8.dts``:
 
 .. code-block:: devicetree
 
-    // SPDX-License-Identifier: GPL-2.0+
+    // SPDX-License-Identifier: GPL-2.0-or-later
 
     /dts-v1/;
 
@@ -614,7 +614,7 @@ In the above example, here are some possible steps:
 
    .. code-block:: devicetree
 
-       // SPDX-License-Identifier: GPL-2.0+
+       // SPDX-License-Identifier: GPL-2.0-or-later
 
        /dts-v1/;
 
diff --git a/doc/develop/bloblist.rst b/doc/develop/bloblist.rst
index 28431039adc..64adc13697c 100644
--- a/doc/develop/bloblist.rst
+++ b/doc/develop/bloblist.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Blob Lists - bloblist
 =====================
diff --git a/doc/develop/board_best_practices.rst b/doc/develop/board_best_practices.rst
index 09632c80ce7..82959704dd0 100644
--- a/doc/develop/board_best_practices.rst
+++ b/doc/develop/board_best_practices.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Best Practices for Board Ports
 ==============================
diff --git a/doc/develop/bootstd/android.rst b/doc/develop/bootstd/android.rst
index 41701d5bdff..d96554ac346 100644
--- a/doc/develop/bootstd/android.rst
+++ b/doc/develop/bootstd/android.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Android Bootmeth
 ================
diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
index 85af10588c1..0b872742735 100644
--- a/doc/develop/bootstd/cros.rst
+++ b/doc/develop/bootstd/cros.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 ChromiumOS Bootmeth
 ===================
diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
index bf27dc57aaa..8ed12107885 100644
--- a/doc/develop/bootstd/extlinux.rst
+++ b/doc/develop/bootstd/extlinux.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Extlinux Bootmeth
 =================
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 4c4e26ccdb7..048efd66f4f 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Standard Boot
 =============
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index a2913cd47be..c35ccd050c1 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Standard Boot Overview
 ======================
diff --git a/doc/develop/bootstd/pxelinux.rst b/doc/develop/bootstd/pxelinux.rst
index c4b7fbb4c9c..bb30e31ab91 100644
--- a/doc/develop/bootstd/pxelinux.rst
+++ b/doc/develop/bootstd/pxelinux.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 PXE Bootmeth
 ============
diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
index 70086ad1817..9802817657e 100644
--- a/doc/develop/bootstd/qfw.rst
+++ b/doc/develop/bootstd/qfw.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 QFW Bootmeth
 ============
diff --git a/doc/develop/bootstd/sandbox.rst b/doc/develop/bootstd/sandbox.rst
index d501518c39a..11175bfb7e4 100644
--- a/doc/develop/bootstd/sandbox.rst
+++ b/doc/develop/bootstd/sandbox.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sandbox Bootmeth
 ================
diff --git a/doc/develop/bootstd/script.rst b/doc/develop/bootstd/script.rst
index 47f3684b86b..5a89508d63f 100644
--- a/doc/develop/bootstd/script.rst
+++ b/doc/develop/bootstd/script.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Script Bootmeth
 ===============
diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 1ac55ab1219..0b5154db0fa 100644
--- a/doc/develop/cedit.rst
+++ b/doc/develop/cedit.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Configuration Editor
 ====================
diff --git a/doc/develop/ci_testing.rst b/doc/develop/ci_testing.rst
index ffaacedc3d8..a1512cddd85 100644
--- a/doc/develop/ci_testing.rst
+++ b/doc/develop/ci_testing.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Continuous Integration testing
 ==============================
diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index fa3cd6aec82..13b659c2a61 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot Coding Style
 ===================
diff --git a/doc/develop/commands.rst b/doc/develop/commands.rst
index 77a7a4d9c02..1f7c620db72 100644
--- a/doc/develop/commands.rst
+++ b/doc/develop/commands.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Implementing shell commands
 ===========================
diff --git a/doc/develop/config_binding.rst b/doc/develop/config_binding.rst
index c90e99c7baa..92bd98a7bf4 100644
--- a/doc/develop/config_binding.rst
+++ b/doc/develop/config_binding.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot configuration node
 =========================
diff --git a/doc/develop/crash_dumps.rst b/doc/develop/crash_dumps.rst
index 4237b073bc9..01bdba36cc5 100644
--- a/doc/develop/crash_dumps.rst
+++ b/doc/develop/crash_dumps.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2020 Heinrich Schuchardt
 
 Analyzing crash dumps
diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 6f1da6f0d9b..db20223e9b0 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Cyclic functions
 ================
diff --git a/doc/develop/designprinciples.rst b/doc/develop/designprinciples.rst
index f01d562d6f0..a2dfcb27571 100644
--- a/doc/develop/designprinciples.rst
+++ b/doc/develop/designprinciples.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot Design Principles
 ========================
diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 0233945f8b6..5cd15718aa3 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Copyright 2011 The Chromium OS Authors
 .. Copyright 2023-2024 Linaro Ltd.
 
diff --git a/doc/develop/devicetree/dt_qemu.rst b/doc/develop/devicetree/dt_qemu.rst
index 8ba2b225590..58ba6dc0006 100644
--- a/doc/develop/devicetree/dt_qemu.rst
+++ b/doc/develop/devicetree/dt_qemu.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Devicetree in QEMU
 ==================
diff --git a/doc/develop/devicetree/index.rst b/doc/develop/devicetree/index.rst
index 2edb69572dd..33171aa7011 100644
--- a/doc/develop/devicetree/index.rst
+++ b/doc/develop/devicetree/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Devicetree in U-Boot
 ====================
diff --git a/doc/develop/devicetree/intro.rst b/doc/develop/devicetree/intro.rst
index 36e8cc0d440..fb63269cc3d 100644
--- a/doc/develop/devicetree/intro.rst
+++ b/doc/develop/devicetree/intro.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Devicetree Introduction
 =======================
diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 637bc27fc2d..4faaeb37a60 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Generic Distro Configuration Concept
 ====================================
diff --git a/doc/develop/docstyle.rst b/doc/develop/docstyle.rst
index 50506d68574..62fab10635b 100644
--- a/doc/develop/docstyle.rst
+++ b/doc/develop/docstyle.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Documentation Style
 ===================
diff --git a/doc/develop/driver-model/bind.rst b/doc/develop/driver-model/bind.rst
index 0d0d40734c9..6b65389727a 100644
--- a/doc/develop/driver-model/bind.rst
+++ b/doc/develop/driver-model/bind.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Patrice Chotard <patrice.chotard@foss.st.com>
 
 Binding/unbinding a driver
diff --git a/doc/develop/driver-model/debugging.rst b/doc/develop/driver-model/debugging.rst
index e13abddae66..dd074762906 100644
--- a/doc/develop/driver-model/debugging.rst
+++ b/doc/develop/driver-model/debugging.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
 Debugging driver model
diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 8c2c81d7ac9..5d7e16d5a28 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
 Design Details
diff --git a/doc/develop/driver-model/fdt-fixup.rst b/doc/develop/driver-model/fdt-fixup.rst
index 974c09031ed..c6fefa8e6ef 100644
--- a/doc/develop/driver-model/fdt-fixup.rst
+++ b/doc/develop/driver-model/fdt-fixup.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. 2017-01-06, Mario Six <mario.six@gdsys.cc>
 
 Pre-relocation device tree manipulation
diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/fs_firmware_loader.rst
index 149b8b436ec..711dde4de7c 100644
--- a/doc/develop/driver-model/fs_firmware_loader.rst
+++ b/doc/develop/driver-model/fs_firmware_loader.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
 
 File System Firmware Loader
diff --git a/doc/develop/driver-model/i2c-howto.rst b/doc/develop/driver-model/i2c-howto.rst
index 27e7440cd46..0fd3d94544b 100644
--- a/doc/develop/driver-model/i2c-howto.rst
+++ b/doc/develop/driver-model/i2c-howto.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 How to port an I2C driver to driver model
 =========================================
diff --git a/doc/develop/driver-model/index.rst b/doc/develop/driver-model/index.rst
index 8e12bbd9366..99dd3e43b5f 100644
--- a/doc/develop/driver-model/index.rst
+++ b/doc/develop/driver-model/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Driver Model
 ============
diff --git a/doc/develop/driver-model/livetree.rst b/doc/develop/driver-model/livetree.rst
index 20055d559a6..4e5ffd7afd0 100644
--- a/doc/develop/driver-model/livetree.rst
+++ b/doc/develop/driver-model/livetree.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
 Live Device Tree
diff --git a/doc/develop/driver-model/migration.rst b/doc/develop/driver-model/migration.rst
index b40a6af9d11..a14df4e4b24 100644
--- a/doc/develop/driver-model/migration.rst
+++ b/doc/develop/driver-model/migration.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Migration Schedule
 ==================
diff --git a/doc/develop/driver-model/nvme.rst b/doc/develop/driver-model/nvme.rst
index 75518133121..02cd8ce2745 100644
--- a/doc/develop/driver-model/nvme.rst
+++ b/doc/develop/driver-model/nvme.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2017 NXP Semiconductors
 .. Copyright (C) 2017 Bin Meng <bmeng.cn@gmail.com>
 
diff --git a/doc/develop/driver-model/nvmxip.rst b/doc/develop/driver-model/nvmxip.rst
index 4a7650c8d2f..1d49d78ad17 100644
--- a/doc/develop/driver-model/nvmxip.rst
+++ b/doc/develop/driver-model/nvmxip.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 NVM XIP Block Storage Emulation Driver
 ======================================
diff --git a/doc/develop/driver-model/of-plat.rst b/doc/develop/driver-model/of-plat.rst
index 01724ba72ce..45bf16eb391 100644
--- a/doc/develop/driver-model/of-plat.rst
+++ b/doc/develop/driver-model/of-plat.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Compiled-in Device Tree / Platform Data
 =======================================
diff --git a/doc/develop/driver-model/pci-info.rst b/doc/develop/driver-model/pci-info.rst
index dea595b6cff..cf7da25a26a 100644
--- a/doc/develop/driver-model/pci-info.rst
+++ b/doc/develop/driver-model/pci-info.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 PCI with Driver Model
 =====================
diff --git a/doc/develop/driver-model/pmic-framework.rst b/doc/develop/driver-model/pmic-framework.rst
index d24a1badd64..a1bee805903 100644
--- a/doc/develop/driver-model/pmic-framework.rst
+++ b/doc/develop/driver-model/pmic-framework.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. (C) Copyright 2014-2015 Samsung Electronics
 .. sectionauthor:: Przemyslaw Marczak <p.marczak@samsung.com>
 
diff --git a/doc/develop/driver-model/remoteproc-framework.rst b/doc/develop/driver-model/remoteproc-framework.rst
index 03a0bd0f4b4..97f3e976cfd 100644
--- a/doc/develop/driver-model/remoteproc-framework.rst
+++ b/doc/develop/driver-model/remoteproc-framework.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. (C) Copyright 2015
 .. Texas Instruments Incorporated - https://www.ti.com/
 
diff --git a/doc/develop/driver-model/serial-howto.rst b/doc/develop/driver-model/serial-howto.rst
index 17b53e3cabf..7b973deb16b 100644
--- a/doc/develop/driver-model/serial-howto.rst
+++ b/doc/develop/driver-model/serial-howto.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 How to port a serial driver to driver model
 ===========================================
diff --git a/doc/develop/driver-model/soc-framework.rst b/doc/develop/driver-model/soc-framework.rst
index 357e7fc8c90..daa1198627f 100644
--- a/doc/develop/driver-model/soc-framework.rst
+++ b/doc/develop/driver-model/soc-framework.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. (C) Copyright 2020
 .. Texas Instruments Incorporated - https://www.ti.com/
 
diff --git a/doc/develop/driver-model/spi-howto.rst b/doc/develop/driver-model/spi-howto.rst
index 9dc3b9b4aac..6b2c7d9ca3b 100644
--- a/doc/develop/driver-model/spi-howto.rst
+++ b/doc/develop/driver-model/spi-howto.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 How to port a SPI driver to driver model
 ========================================
diff --git a/doc/develop/driver-model/usb-info.rst b/doc/develop/driver-model/usb-info.rst
index 24d1e81a6c6..20983f9e19c 100644
--- a/doc/develop/driver-model/usb-info.rst
+++ b/doc/develop/driver-model/usb-info.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 How USB works with driver model
 ===============================
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 31b94d04675..06b93f9cbee 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. sectionauthor:: Bin Meng <bmeng.cn@gmail.com>
 
 VirtIO Support
diff --git a/doc/develop/environment.rst b/doc/develop/environment.rst
index e1783462bb0..879f4f50a3c 100644
--- a/doc/develop/environment.rst
+++ b/doc/develop/environment.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Environment implementation
 ==========================
diff --git a/doc/develop/event.rst b/doc/develop/event.rst
index d5043ec4f4c..f597c95ba75 100644
--- a/doc/develop/event.rst
+++ b/doc/develop/event.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Events
 ======
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index cc7c36173db..9ceb31da3ea 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Expo menu
 =========
diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
index 4e359c7f226..3248ea98e4c 100644
--- a/doc/develop/gdb.rst
+++ b/doc/develop/gdb.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2024 Alexander Dahl
 
 Debugging U-Boot with GDB
diff --git a/doc/develop/global_data.rst b/doc/develop/global_data.rst
index 2863154ea42..7d2be931df2 100644
--- a/doc/develop/global_data.rst
+++ b/doc/develop/global_data.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Global data
 ===========
diff --git a/doc/develop/historical/generic_board.rst b/doc/develop/historical/generic_board.rst
index 12550a140e0..ae3de4c2438 100644
--- a/doc/develop/historical/generic_board.rst
+++ b/doc/develop/historical/generic_board.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. (C) Copyright 2014 Google, Inc
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
diff --git a/doc/develop/historical/index.rst b/doc/develop/historical/index.rst
index e4462f5d2a7..775c6eac0bf 100644
--- a/doc/develop/historical/index.rst
+++ b/doc/develop/historical/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Historical Documents
 ====================
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 30f7fdb8847..03a526425d1 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Develop U-Boot
 ==============
diff --git a/doc/develop/init.rst b/doc/develop/init.rst
index ce985781bb4..ea9dec7f2e0 100644
--- a/doc/develop/init.rst
+++ b/doc/develop/init.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Board Initialisation Flow
 -------------------------
diff --git a/doc/develop/logging.rst b/doc/develop/logging.rst
index d7a40c94bf0..6dce4e946d7 100644
--- a/doc/develop/logging.rst
+++ b/doc/develop/logging.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2017 Simon Glass <sjg@chromium.org>
 
 Logging in U-Boot
diff --git a/doc/develop/menus.rst b/doc/develop/menus.rst
index dda8f963fb5..a51de4cf225 100644
--- a/doc/develop/menus.rst
+++ b/doc/develop/menus.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2010-2011 Calxeda, Inc.
 
 Menus
diff --git a/doc/develop/package/index.rst b/doc/develop/package/index.rst
index 4f448313f95..b2d3f64cd60 100644
--- a/doc/develop/package/index.rst
+++ b/doc/develop/package/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Package U-Boot
 ==============
diff --git a/doc/develop/printf.rst b/doc/develop/printf.rst
index 99d05061b14..d68062f910e 100644
--- a/doc/develop/printf.rst
+++ b/doc/develop/printf.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Printf() format codes
 =====================
diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 0c6fb31e87b..ce75473ab6c 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot Development Process
 ==========================
diff --git a/doc/develop/python_cq.rst b/doc/develop/python_cq.rst
index 1e209ff197d..202ef081198 100644
--- a/doc/develop/python_cq.rst
+++ b/doc/develop/python_cq.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Python code quality
 ===================
diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index a18f32470ca..c47ca81b21b 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 qconfig - Querying CONFIG options
 =================================
diff --git a/doc/develop/security.rst b/doc/develop/security.rst
index 84b130646f3..167c7d39e7b 100644
--- a/doc/develop/security.rst
+++ b/doc/develop/security.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Handling of security vulnerabilities
 ====================================
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index e22b5e3e244..8244ad78a84 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sending patches
 ===============
@@ -151,7 +151,7 @@ Attributing Code, Copyrights, Signing
 
    (C) Copyright 2010  Joe Hacker <jh@hackers.paradise.com>
 
-   SPDX-License-Identifier:<TAB>GPL-2.0+
+   SPDX-License-Identifier: GPL-2.0-or-later
 
 * If you are copying or adapting code from other projects, like the Linux
   kernel, or BusyBox, or similar, please make sure to state clearly where you
@@ -308,7 +308,7 @@ Notes
    2022) version 2 of the GPL applies. Please see :download:`Licensing
    <../../Licenses/README>` for details. To allow that later versions of U-Boot
    may be released under a later version of the GPL, all new code that gets
-   added to U-Boot shall use a "GPL-2.0+" SPDX-License-Identifier.
+   added to U-Boot shall use a "GPL-2.0-or-later" SPDX-License-Identifier.
 
 2. All code must follow the :doc:`codingstyle` requirements.
 
diff --git a/doc/develop/smbios.rst b/doc/develop/smbios.rst
index a4efb0a0a38..2cbee915d0a 100644
--- a/doc/develop/smbios.rst
+++ b/doc/develop/smbios.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 SMBIOS tables
 =============
diff --git a/doc/develop/system_configuration.rst b/doc/develop/system_configuration.rst
index 40be46b0823..c64ab9981fb 100644
--- a/doc/develop/system_configuration.rst
+++ b/doc/develop/system_configuration.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 System configuration
 ====================
diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index 9114d11ad26..255e55a5908 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Introduction to testing
 =======================
diff --git a/doc/develop/tests_sandbox.rst b/doc/develop/tests_sandbox.rst
index 0630180bc55..eb3bf4c4275 100644
--- a/doc/develop/tests_sandbox.rst
+++ b/doc/develop/tests_sandbox.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Sandbox tests
 =============
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 54efb7e1b04..82c4f3cd90c 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2021 Google LLC
 .. sectionauthor:: Simon Glass <sjg@chromium.org>
 
diff --git a/doc/develop/trace.rst b/doc/develop/trace.rst
index 546862020b1..78babbe03fd 100644
--- a/doc/develop/trace.rst
+++ b/doc/develop/trace.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2013 The Chromium OS Authors.
 
 Tracing in U-Boot
diff --git a/doc/develop/uefi/fwu_updates.rst b/doc/develop/uefi/fwu_updates.rst
index 51e8a28efe1..3abcf236d60 100644
--- a/doc/develop/uefi/fwu_updates.rst
+++ b/doc/develop/uefi/fwu_updates.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2022 Linaro Limited
 
 FWU Multi Bank Updates in U-Boot
diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
index e26b1fbe05c..1f39ef3a61a 100644
--- a/doc/develop/uefi/index.rst
+++ b/doc/develop/uefi/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Unified Extensible Firmware (UEFI)
 ==================================
diff --git a/doc/develop/uefi/iscsi.rst b/doc/develop/uefi/iscsi.rst
index 51d38cde243..5b8610f3f32 100644
--- a/doc/develop/uefi/iscsi.rst
+++ b/doc/develop/uefi/iscsi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2018 Heinrich Schuchardt
 
 iSCSI booting with U-Boot and iPXE
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 245b4af1fa3..899f17a0417 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2015 Google, Inc
 
 U-Boot on EFI
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 48d6110b2ad..eb626ba6314 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2018 Heinrich Schuchardt
 
 UEFI on U-Boot
diff --git a/doc/develop/vbe.rst b/doc/develop/vbe.rst
index cca193c8fd4..3f8e2dcdbc4 100644
--- a/doc/develop/vbe.rst
+++ b/doc/develop/vbe.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Verified Boot for Embedded (VBE)
 ================================
diff --git a/doc/develop/version.rst b/doc/develop/version.rst
index de11836af45..f36eb4baf32 100644
--- a/doc/develop/version.rst
+++ b/doc/develop/version.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2013 The Chromium OS Authors.
 
 Version information
diff --git a/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
index df976c7ae73..be09a70c430 100644
--- a/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
+++ b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0+)
+# SPDX-License-Identifier: (GPL-2.0-or-later)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/adi/adi,sc5xx.yaml#
diff --git a/doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml b/doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
index 9bbd5467a01..a33d41f55d5 100644
--- a/doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
+++ b/doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0+)
+# SPDX-License-Identifier: (GPL-2.0-or-later)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/clock/adi,sc5xx-clocks.yaml#
diff --git a/doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml b/doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
index 5e313af6fe0..7f2c94c5ac4 100644
--- a/doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
+++ b/doc/device-tree-bindings/timer/adi,sc5xx-gptimer.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: (GPL-2.0+)
+# SPDX-License-Identifier: (GPL-2.0-or-later)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/timer/adi,sc5xx-gptimer.yaml#
diff --git a/doc/index.rst b/doc/index.rst
index 43398627d89..cdde2b06422 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. _u-boot_doc:
 
diff --git a/doc/learn/index.rst b/doc/learn/index.rst
index 8075c01d1df..e4b9bd7c196 100644
--- a/doc/learn/index.rst
+++ b/doc/learn/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Learn about U-Boot
 ==================
diff --git a/doc/learn/talks.rst b/doc/learn/talks.rst
index d65e3b92be1..b34e9969d48 100644
--- a/doc/learn/talks.rst
+++ b/doc/learn/talks.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot Talks
 ============
diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index a726149ba2c..e572a8b8ef1 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -1,4 +1,4 @@
-.\" SPDX-License-Identifier: GPL-2.0+
+.\" SPDX-License-Identifier: GPL-2.0-or-later
 .\" Copyright (c) 2021, Linaro Limited
 .\" 		written by AKASHI Takahiro <takahiro.akashi@linaro.org>
 .TH MAEFICAPSULE 1 "May 2021"
diff --git a/doc/sphinx/parallel-wrapper.sh b/doc/sphinx/parallel-wrapper.sh
index e54c44ce117..aedf306ded7 100644
--- a/doc/sphinx/parallel-wrapper.sh
+++ b/doc/sphinx/parallel-wrapper.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# SPDX-License-Identifier: GPL-2.0+
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Figure out if we should follow a specific parallelism from the make
 # environment (as exported by scripts/jobserver-exec), or fall back to
diff --git a/doc/usage/blkmap.rst b/doc/usage/blkmap.rst
index 75f736c259f..a69a9df81f3 100644
--- a/doc/usage/blkmap.rst
+++ b/doc/usage/blkmap.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 ..
 .. Copyright (c) 2023 Addiva Elektronik
 .. Author: Tobias Waldekranz <tobias@waldekranz.com>
diff --git a/doc/usage/cmd/acpi.rst b/doc/usage/cmd/acpi.rst
index 9f30972fe53..c5dac19c729 100644
--- a/doc/usage/cmd/acpi.rst
+++ b/doc/usage/cmd/acpi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: acpi (command)
diff --git a/doc/usage/cmd/addrmap.rst b/doc/usage/cmd/addrmap.rst
index 6d0dbceefea..27fe7233a8d 100644
--- a/doc/usage/cmd/addrmap.rst
+++ b/doc/usage/cmd/addrmap.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: addrmap (command)
diff --git a/doc/usage/cmd/armffa.rst b/doc/usage/cmd/armffa.rst
index 4f41e3393fd..342fec0abf2 100644
--- a/doc/usage/cmd/armffa.rst
+++ b/doc/usage/cmd/armffa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
 
 .. index::
diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
index e2b3c5379ae..54b784edddd 100644
--- a/doc/usage/cmd/askenv.rst
+++ b/doc/usage/cmd/askenv.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: askenv (command)
diff --git a/doc/usage/cmd/base.rst b/doc/usage/cmd/base.rst
index 0d030a1d1e0..188daddbc17 100644
--- a/doc/usage/cmd/base.rst
+++ b/doc/usage/cmd/base.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: base (command)
diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index a21fbc83ccf..944814631b8 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 
 .. index::
diff --git a/doc/usage/cmd/bind.rst b/doc/usage/cmd/bind.rst
index 67a0405bab5..e47b3491573 100644
--- a/doc/usage/cmd/bind.rst
+++ b/doc/usage/cmd/bind.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: bind (command)
diff --git a/doc/usage/cmd/blkcache.rst b/doc/usage/cmd/blkcache.rst
index 0329261ba9a..50cfd9c3f84 100644
--- a/doc/usage/cmd/blkcache.rst
+++ b/doc/usage/cmd/blkcache.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 
 .. index::
diff --git a/doc/usage/cmd/bootd.rst b/doc/usage/cmd/bootd.rst
index 619cfb601a0..9684ddfcd8c 100644
--- a/doc/usage/cmd/bootd.rst
+++ b/doc/usage/cmd/bootd.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: bootd (command)
diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
index 98a0f43c580..c0147ac784e 100644
--- a/doc/usage/cmd/bootdev.rst
+++ b/doc/usage/cmd/bootdev.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: bootdev (command)
diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 3efe9e9df57..515c17b9d34 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
 .. index::
diff --git a/doc/usage/cmd/bootflow.rst b/doc/usage/cmd/bootflow.rst
index 5d41fe37a7a..7c1a46b6b68 100644
--- a/doc/usage/cmd/bootflow.rst
+++ b/doc/usage/cmd/bootflow.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: bootflow (command)
diff --git a/doc/usage/cmd/booti.rst b/doc/usage/cmd/booti.rst
index 313efb83cc6..47dde93946a 100644
--- a/doc/usage/cmd/booti.rst
+++ b/doc/usage/cmd/booti.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: booti (command)
diff --git a/doc/usage/cmd/bootm.rst b/doc/usage/cmd/bootm.rst
index e409ebc193b..912091d6dc7 100644
--- a/doc/usage/cmd/bootm.rst
+++ b/doc/usage/cmd/bootm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: bootm (command)
diff --git a/doc/usage/cmd/bootmenu.rst b/doc/usage/cmd/bootmenu.rst
index 294cc02b17a..9dd29e41c15 100644
--- a/doc/usage/cmd/bootmenu.rst
+++ b/doc/usage/cmd/bootmenu.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. (C) Copyright 2011-2012 Pali Rohár <pali@kernel.org>
 
 .. index::
diff --git a/doc/usage/cmd/bootmeth.rst b/doc/usage/cmd/bootmeth.rst
index 4f899d92b2e..77c1ab8eee8 100644
--- a/doc/usage/cmd/bootmeth.rst
+++ b/doc/usage/cmd/bootmeth.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: bootmeth (command)
diff --git a/doc/usage/cmd/bootz.rst b/doc/usage/cmd/bootz.rst
index b85875adde3..506ff1759a9 100644
--- a/doc/usage/cmd/bootz.rst
+++ b/doc/usage/cmd/bootz.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: bootz (command)
diff --git a/doc/usage/cmd/button.rst b/doc/usage/cmd/button.rst
index 6c6794f31b8..c06c4a2ffbc 100644
--- a/doc/usage/cmd/button.rst
+++ b/doc/usage/cmd/button.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: button (command)
diff --git a/doc/usage/cmd/cat.rst b/doc/usage/cmd/cat.rst
index b22dc6184a2..22ebdfe5eea 100644
--- a/doc/usage/cmd/cat.rst
+++ b/doc/usage/cmd/cat.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cat (command)
diff --git a/doc/usage/cmd/cbcmos.rst b/doc/usage/cmd/cbcmos.rst
index 9395cf1cbd7..80cba359f76 100644
--- a/doc/usage/cmd/cbcmos.rst
+++ b/doc/usage/cmd/cbcmos.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 cbcmos
 ======
diff --git a/doc/usage/cmd/cbsysinfo.rst b/doc/usage/cmd/cbsysinfo.rst
index 28f61d9c63e..0164590a08c 100644
--- a/doc/usage/cmd/cbsysinfo.rst
+++ b/doc/usage/cmd/cbsysinfo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 cbsysinfo
 =========
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index e54ea204b9f..dcb99fcb46d 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cedit (command)
diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
index 23e5ee7a902..6cc402e9677 100644
--- a/doc/usage/cmd/cli.rst
+++ b/doc/usage/cmd/cli.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cli (command)
diff --git a/doc/usage/cmd/cls.rst b/doc/usage/cmd/cls.rst
index 828276742b9..eb6fc900604 100644
--- a/doc/usage/cmd/cls.rst
+++ b/doc/usage/cmd/cls.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cls (command)
diff --git a/doc/usage/cmd/cmp.rst b/doc/usage/cmd/cmp.rst
index a3830747364..fc4463cf00d 100644
--- a/doc/usage/cmd/cmp.rst
+++ b/doc/usage/cmd/cmp.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cmp (command)
diff --git a/doc/usage/cmd/coninfo.rst b/doc/usage/cmd/coninfo.rst
index a66cf90a27b..e9566ed8024 100644
--- a/doc/usage/cmd/coninfo.rst
+++ b/doc/usage/cmd/coninfo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: coninfo (command)
diff --git a/doc/usage/cmd/cp.rst b/doc/usage/cmd/cp.rst
index 434dfedfc2b..0de15cf5b97 100644
--- a/doc/usage/cmd/cp.rst
+++ b/doc/usage/cmd/cp.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cp (command)
diff --git a/doc/usage/cmd/cpu.rst b/doc/usage/cmd/cpu.rst
index 8b0b7d5a699..d3e491e91de 100644
--- a/doc/usage/cmd/cpu.rst
+++ b/doc/usage/cmd/cpu.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2024 NXP
 
 .. index::
diff --git a/doc/usage/cmd/cpuid.rst b/doc/usage/cmd/cpuid.rst
index cccf9262ed4..0437f046fcc 100644
--- a/doc/usage/cmd/cpuid.rst
+++ b/doc/usage/cmd/cpuid.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cpuid (command)
diff --git a/doc/usage/cmd/cyclic.rst b/doc/usage/cmd/cyclic.rst
index ac1e4c663bf..067cb58f294 100644
--- a/doc/usage/cmd/cyclic.rst
+++ b/doc/usage/cmd/cyclic.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: cyclic (command)
diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
index 196b22d1376..84aca51be64 100644
--- a/doc/usage/cmd/dm.rst
+++ b/doc/usage/cmd/dm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: dm (command)
diff --git a/doc/usage/cmd/ebtupdate.rst b/doc/usage/cmd/ebtupdate.rst
index 22415ee07b4..5c1acd2ab1c 100644
--- a/doc/usage/cmd/ebtupdate.rst
+++ b/doc/usage/cmd/ebtupdate.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: ebtupdate (command)
diff --git a/doc/usage/cmd/efi.rst b/doc/usage/cmd/efi.rst
index b19d36188a9..1ac70ea424c 100644
--- a/doc/usage/cmd/efi.rst
+++ b/doc/usage/cmd/efi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
 .. index::
diff --git a/doc/usage/cmd/eficonfig.rst b/doc/usage/cmd/eficonfig.rst
index 83a3ebf4f0b..a5cc002b6d8 100644
--- a/doc/usage/cmd/eficonfig.rst
+++ b/doc/usage/cmd/eficonfig.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. (C) Copyright 2022, Masahisa Kojima <masahisa.kojima@linaro.org>
 
 .. index::
diff --git a/doc/usage/cmd/event.rst b/doc/usage/cmd/event.rst
index 5c5e3043733..bbb85d8788c 100644
--- a/doc/usage/cmd/event.rst
+++ b/doc/usage/cmd/event.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: event (command)
diff --git a/doc/usage/cmd/extension.rst b/doc/usage/cmd/extension.rst
index 4c261e74951..c6ad9c0ecab 100644
--- a/doc/usage/cmd/extension.rst
+++ b/doc/usage/cmd/extension.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2021, Kory Maincent <kory.maincent@bootlin.com>
 
 .. index::
diff --git a/doc/usage/cmd/fatinfo.rst b/doc/usage/cmd/fatinfo.rst
index 2e05ab8bece..90251efd6c0 100644
--- a/doc/usage/cmd/fatinfo.rst
+++ b/doc/usage/cmd/fatinfo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: fatinfo (command)
diff --git a/doc/usage/cmd/fatload.rst b/doc/usage/cmd/fatload.rst
index 6c048b7bdac..d3512213ccf 100644
--- a/doc/usage/cmd/fatload.rst
+++ b/doc/usage/cmd/fatload.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: fatload (command)
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 71a9fc627e5..daa71176ad8 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: fdt (command)
diff --git a/doc/usage/cmd/font.rst b/doc/usage/cmd/font.rst
index 44a04f5d075..f5f1c312d97 100644
--- a/doc/usage/cmd/font.rst
+++ b/doc/usage/cmd/font.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: font (command)
diff --git a/doc/usage/cmd/fwu_mdata.rst b/doc/usage/cmd/fwu_mdata.rst
index f1bf08fde1d..781735f90bb 100644
--- a/doc/usage/cmd/fwu_mdata.rst
+++ b/doc/usage/cmd/fwu_mdata.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: fwu_mdata_read (command)
diff --git a/doc/usage/cmd/gpio.rst b/doc/usage/cmd/gpio.rst
index 4b0dc2716e5..4659d77fe35 100644
--- a/doc/usage/cmd/gpio.rst
+++ b/doc/usage/cmd/gpio.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: gpio (command)
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index 8534f78cbac..5a8be0c7238 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: gpt (command)
diff --git a/doc/usage/cmd/history.rst b/doc/usage/cmd/history.rst
index b52b5b220ae..53bfbcf30a6 100644
--- a/doc/usage/cmd/history.rst
+++ b/doc/usage/cmd/history.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: history (command)
diff --git a/doc/usage/cmd/host.rst b/doc/usage/cmd/host.rst
index a70a432b6f2..d0d6f99234e 100644
--- a/doc/usage/cmd/host.rst
+++ b/doc/usage/cmd/host.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: host (command)
diff --git a/doc/usage/cmd/imxtract.rst b/doc/usage/cmd/imxtract.rst
index 235d15e445b..f224f862e88 100644
--- a/doc/usage/cmd/imxtract.rst
+++ b/doc/usage/cmd/imxtract.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: imxtract (command)
diff --git a/doc/usage/cmd/itest.rst b/doc/usage/cmd/itest.rst
index adcad05b2d4..ca9aa262747 100644
--- a/doc/usage/cmd/itest.rst
+++ b/doc/usage/cmd/itest.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: itest (command)
diff --git a/doc/usage/cmd/load.rst b/doc/usage/cmd/load.rst
index bfa45c6f36c..212cff7b6e7 100644
--- a/doc/usage/cmd/load.rst
+++ b/doc/usage/cmd/load.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: load (command)
diff --git a/doc/usage/cmd/loadb.rst b/doc/usage/cmd/loadb.rst
index 4f9a52c793f..0a65772fb08 100644
--- a/doc/usage/cmd/loadb.rst
+++ b/doc/usage/cmd/loadb.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: loadb (command)
diff --git a/doc/usage/cmd/loadm.rst b/doc/usage/cmd/loadm.rst
index 005840a27bb..bae5870fb6c 100644
--- a/doc/usage/cmd/loadm.rst
+++ b/doc/usage/cmd/loadm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: loadm (command)
diff --git a/doc/usage/cmd/loads.rst b/doc/usage/cmd/loads.rst
index 0a2ac14acfe..8950b76c292 100644
--- a/doc/usage/cmd/loads.rst
+++ b/doc/usage/cmd/loads.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: loads (command)
diff --git a/doc/usage/cmd/loadx.rst b/doc/usage/cmd/loadx.rst
index 661b36723c3..ef927b655cf 100644
--- a/doc/usage/cmd/loadx.rst
+++ b/doc/usage/cmd/loadx.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: loadx (command)
diff --git a/doc/usage/cmd/loady.rst b/doc/usage/cmd/loady.rst
index 8367759471e..6e31cb22eb0 100644
--- a/doc/usage/cmd/loady.rst
+++ b/doc/usage/cmd/loady.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: loady (command)
diff --git a/doc/usage/cmd/mbr.rst b/doc/usage/cmd/mbr.rst
index 925a1181055..3902ab881a8 100644
--- a/doc/usage/cmd/mbr.rst
+++ b/doc/usage/cmd/mbr.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: mbr (command)
diff --git a/doc/usage/cmd/md.rst b/doc/usage/cmd/md.rst
index 9a9919f9ad0..cc127d9613c 100644
--- a/doc/usage/cmd/md.rst
+++ b/doc/usage/cmd/md.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: md (command)
diff --git a/doc/usage/cmd/meminfo.rst b/doc/usage/cmd/meminfo.rst
index 6c94493cccc..ab2bc5bd8d9 100644
--- a/doc/usage/cmd/meminfo.rst
+++ b/doc/usage/cmd/meminfo.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: meminfo (command)
diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
index 55391fda24c..132a5a237cb 100644
--- a/doc/usage/cmd/mmc.rst
+++ b/doc/usage/cmd/mmc.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: mmc (command)
diff --git a/doc/usage/cmd/msr.rst b/doc/usage/cmd/msr.rst
index 04ee52cc1c7..974d9413562 100644
--- a/doc/usage/cmd/msr.rst
+++ b/doc/usage/cmd/msr.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: msr (command)
diff --git a/doc/usage/cmd/mtest.rst b/doc/usage/cmd/mtest.rst
index e01f2a6d575..a00e06b5333 100644
--- a/doc/usage/cmd/mtest.rst
+++ b/doc/usage/cmd/mtest.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
 .. index::
diff --git a/doc/usage/cmd/mtrr.rst b/doc/usage/cmd/mtrr.rst
index 3c5c3ba3d43..b8fa01b88b0 100644
--- a/doc/usage/cmd/mtrr.rst
+++ b/doc/usage/cmd/mtrr.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: mtrr (command)
diff --git a/doc/usage/cmd/panic.rst b/doc/usage/cmd/panic.rst
index 39d32adbc99..044474e2ca3 100644
--- a/doc/usage/cmd/panic.rst
+++ b/doc/usage/cmd/panic.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: panic (command)
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index e7faeccbb09..54abbf617e2 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: part (command)
diff --git a/doc/usage/cmd/pinmux.rst b/doc/usage/cmd/pinmux.rst
index 30c5eb16a68..6ee800d2885 100644
--- a/doc/usage/cmd/pinmux.rst
+++ b/doc/usage/cmd/pinmux.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: pinmux (command)
diff --git a/doc/usage/cmd/printenv.rst b/doc/usage/cmd/printenv.rst
index dfdb3624934..396b12512b2 100644
--- a/doc/usage/cmd/printenv.rst
+++ b/doc/usage/cmd/printenv.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: printenv (command)
diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
index 63a437135ec..2cfdfc8d82c 100644
--- a/doc/usage/cmd/pstore.rst
+++ b/doc/usage/cmd/pstore.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: pstore (command)
diff --git a/doc/usage/cmd/qfw.rst b/doc/usage/cmd/qfw.rst
index 40770acb3c0..1c7372344f4 100644
--- a/doc/usage/cmd/qfw.rst
+++ b/doc/usage/cmd/qfw.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: qfw (command)
diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 126db21cdb8..34d5202ba2d 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: reset (command)
diff --git a/doc/usage/cmd/rng.rst b/doc/usage/cmd/rng.rst
index 4a61e33d272..be950d87559 100644
--- a/doc/usage/cmd/rng.rst
+++ b/doc/usage/cmd/rng.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: rng (command)
diff --git a/doc/usage/cmd/saves.rst b/doc/usage/cmd/saves.rst
index b380a4feb6f..8359e05c1cb 100644
--- a/doc/usage/cmd/saves.rst
+++ b/doc/usage/cmd/saves.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: saves (command)
diff --git a/doc/usage/cmd/sb.rst b/doc/usage/cmd/sb.rst
index 37431aff7c8..7273e89e271 100644
--- a/doc/usage/cmd/sb.rst
+++ b/doc/usage/cmd/sb.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: sbi (command)
diff --git a/doc/usage/cmd/sbi.rst b/doc/usage/cmd/sbi.rst
index 5492925a8bc..8543c027937 100644
--- a/doc/usage/cmd/sbi.rst
+++ b/doc/usage/cmd/sbi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: sbi (command)
diff --git a/doc/usage/cmd/scmi.rst b/doc/usage/cmd/scmi.rst
index 9591cdc07a5..c5c6ed92540 100644
--- a/doc/usage/cmd/scmi.rst
+++ b/doc/usage/cmd/scmi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: scmi (command)
diff --git a/doc/usage/cmd/scp03.rst b/doc/usage/cmd/scp03.rst
index 5fdddb3e813..f7aaec2e185 100644
--- a/doc/usage/cmd/scp03.rst
+++ b/doc/usage/cmd/scp03.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: scp03 (command)
diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
index 17fd559f485..ace64d1c10a 100644
--- a/doc/usage/cmd/seama.rst
+++ b/doc/usage/cmd/seama.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: seama (command)
diff --git a/doc/usage/cmd/setexpr.rst b/doc/usage/cmd/setexpr.rst
index 593a0ea91e1..6d8d027dc38 100644
--- a/doc/usage/cmd/setexpr.rst
+++ b/doc/usage/cmd/setexpr.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: setexpr (command)
diff --git a/doc/usage/cmd/sf.rst b/doc/usage/cmd/sf.rst
index dfdca46e66c..afa88c6d6f2 100644
--- a/doc/usage/cmd/sf.rst
+++ b/doc/usage/cmd/sf.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: sf (command)
diff --git a/doc/usage/cmd/size.rst b/doc/usage/cmd/size.rst
index 306fcba0ba4..0d9881e5ac6 100644
--- a/doc/usage/cmd/size.rst
+++ b/doc/usage/cmd/size.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: size (command)
diff --git a/doc/usage/cmd/sleep.rst b/doc/usage/cmd/sleep.rst
index a372e4da0e1..32d70d0f220 100644
--- a/doc/usage/cmd/sleep.rst
+++ b/doc/usage/cmd/sleep.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2023, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
 
 .. index::
diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
index e828fddc519..4b1ae6673d1 100644
--- a/doc/usage/cmd/sm.rst
+++ b/doc/usage/cmd/sm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: sm (command)
diff --git a/doc/usage/cmd/sound.rst b/doc/usage/cmd/sound.rst
index 97d610f3745..17f1b4fb7d9 100644
--- a/doc/usage/cmd/sound.rst
+++ b/doc/usage/cmd/sound.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
 .. index::
diff --git a/doc/usage/cmd/source.rst b/doc/usage/cmd/source.rst
index 0de5f33390e..7fc282772d9 100644
--- a/doc/usage/cmd/source.rst
+++ b/doc/usage/cmd/source.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
 
 .. index::
diff --git a/doc/usage/cmd/tcpm.rst b/doc/usage/cmd/tcpm.rst
index eb2c69d0bdb..a15297782c9 100644
--- a/doc/usage/cmd/tcpm.rst
+++ b/doc/usage/cmd/tcpm.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: tcpm (command)
diff --git a/doc/usage/cmd/tftpput.rst b/doc/usage/cmd/tftpput.rst
index 351c9faa38b..7f4de255dda 100644
--- a/doc/usage/cmd/tftpput.rst
+++ b/doc/usage/cmd/tftpput.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: tftpput (command)
diff --git a/doc/usage/cmd/trace.rst b/doc/usage/cmd/trace.rst
index e798b2bbc6b..90979853512 100644
--- a/doc/usage/cmd/trace.rst
+++ b/doc/usage/cmd/trace.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: trace (command)
diff --git a/doc/usage/cmd/ums.rst b/doc/usage/cmd/ums.rst
index e96222785f2..b1416c573b4 100644
--- a/doc/usage/cmd/ums.rst
+++ b/doc/usage/cmd/ums.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: ums (command)
diff --git a/doc/usage/cmd/unbind.rst b/doc/usage/cmd/unbind.rst
index 1ae9c1b172c..641f8e67665 100644
--- a/doc/usage/cmd/unbind.rst
+++ b/doc/usage/cmd/unbind.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: unbind (command)
diff --git a/doc/usage/cmd/upl.rst b/doc/usage/cmd/upl.rst
index 8d6ea5daa37..968793678c9 100644
--- a/doc/usage/cmd/upl.rst
+++ b/doc/usage/cmd/upl.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 upl command
 ===========
diff --git a/doc/usage/cmd/ut.rst b/doc/usage/cmd/ut.rst
index afeafa824d6..b11bd45ddd0 100644
--- a/doc/usage/cmd/ut.rst
+++ b/doc/usage/cmd/ut.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: ut (command)
diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
index f48b8840907..dabf727e5f2 100644
--- a/doc/usage/cmd/wdt.rst
+++ b/doc/usage/cmd/wdt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: wdt (command)
diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index b8ca35bb140..6d01be849f2 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: wget (command)
diff --git a/doc/usage/cmd/xxd.rst b/doc/usage/cmd/xxd.rst
index f010a9dbb4d..031f8164269 100644
--- a/doc/usage/cmd/xxd.rst
+++ b/doc/usage/cmd/xxd.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+:
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 .. index::
    single: xxd (command)
diff --git a/doc/usage/cmdline.rst b/doc/usage/cmdline.rst
index 58240c5279c..e2d0505b737 100644
--- a/doc/usage/cmdline.rst
+++ b/doc/usage/cmdline.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Command-line Parsing
 ====================
diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
index 8cc09c308d8..d47c1d5983b 100644
--- a/doc/usage/dfu.rst
+++ b/doc/usage/dfu.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Device Firmware Upgrade (DFU)
 =============================
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 7bd9ffce8d8..bf29a09f955 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Environment Variables
 =====================
diff --git a/doc/usage/fdt_overlays.rst b/doc/usage/fdt_overlays.rst
index 81d0d37f3f1..5830c79a89a 100644
--- a/doc/usage/fdt_overlays.rst
+++ b/doc/usage/fdt_overlays.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (c) 2017, Pantelis Antoniou <pantelis.antoniou@konsulko.com>
 
 Device Tree Overlays
diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
index 1298ba1ae08..62f3f3f76f1 100644
--- a/doc/usage/fit/beaglebone_vboot.rst
+++ b/doc/usage/fit/beaglebone_vboot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Verified Boot on the Beaglebone Black
 =====================================
diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index 280eff724f6..888c1932e65 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 How to use images in the new image format
 =========================================
diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index a822bf20cb2..6259a87cfd9 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Flat Image Tree (FIT)
 =====================
diff --git a/doc/usage/fit/kernel.rst b/doc/usage/fit/kernel.rst
index e56017985b2..7f4ab8e1dbf 100644
--- a/doc/usage/fit/kernel.rst
+++ b/doc/usage/fit/kernel.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Single kernel
 =============
diff --git a/doc/usage/fit/kernel_fdt.rst b/doc/usage/fit/kernel_fdt.rst
index 9cc26fb7831..58a54396c6e 100644
--- a/doc/usage/fit/kernel_fdt.rst
+++ b/doc/usage/fit/kernel_fdt.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Single kernel and FDT blob
 ==========================
diff --git a/doc/usage/fit/kernel_fdts_compressed.rst b/doc/usage/fit/kernel_fdts_compressed.rst
index b57871da58b..44098d61fc9 100644
--- a/doc/usage/fit/kernel_fdts_compressed.rst
+++ b/doc/usage/fit/kernel_fdts_compressed.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kernel and multiple compressed FDT blobs
 ========================================
diff --git a/doc/usage/fit/multi-with-fpga.rst b/doc/usage/fit/multi-with-fpga.rst
index 4c7f1bebd5a..5025990df8c 100644
--- a/doc/usage/fit/multi-with-fpga.rst
+++ b/doc/usage/fit/multi-with-fpga.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Multiple kernels, ramdisks and FDT blobs with FPGA
 ==================================================
diff --git a/doc/usage/fit/multi-with-loadables.rst b/doc/usage/fit/multi-with-loadables.rst
index 7849cb544f1..dfd9e0d7a91 100644
--- a/doc/usage/fit/multi-with-loadables.rst
+++ b/doc/usage/fit/multi-with-loadables.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Multiple kernels, ramdisks and FDT blobs with Xen
 =================================================
diff --git a/doc/usage/fit/multi.rst b/doc/usage/fit/multi.rst
index e68752b2ad0..9197c097b52 100644
--- a/doc/usage/fit/multi.rst
+++ b/doc/usage/fit/multi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Multiple kernels, ramdisks and FDT blobs
 ========================================
diff --git a/doc/usage/fit/multi_spl.rst b/doc/usage/fit/multi_spl.rst
index 74b6f865abd..71348d68a8e 100644
--- a/doc/usage/fit/multi_spl.rst
+++ b/doc/usage/fit/multi_spl.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Multiple images for SPL
 =======================
diff --git a/doc/usage/fit/overlay-fdt-boot.rst b/doc/usage/fit/overlay-fdt-boot.rst
index a7db1a37f7a..0b77fad9ab5 100644
--- a/doc/usage/fit/overlay-fdt-boot.rst
+++ b/doc/usage/fit/overlay-fdt-boot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot FDT Overlay FIT usage
 ============================
diff --git a/doc/usage/fit/sec_firmware_ppa.rst b/doc/usage/fit/sec_firmware_ppa.rst
index 4cb292cb4ee..b52bc263d07 100644
--- a/doc/usage/fit/sec_firmware_ppa.rst
+++ b/doc/usage/fit/sec_firmware_ppa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 SEC Firmware and multiple loadable images
 =========================================
diff --git a/doc/usage/fit/sign-configs.rst b/doc/usage/fit/sign-configs.rst
index 6d98d44430c..04ea00fada5 100644
--- a/doc/usage/fit/sign-configs.rst
+++ b/doc/usage/fit/sign-configs.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Signed configurations
 =====================
diff --git a/doc/usage/fit/sign-images.rst b/doc/usage/fit/sign-images.rst
index ca7d10fab83..fce6cf140f9 100644
--- a/doc/usage/fit/sign-images.rst
+++ b/doc/usage/fit/sign-images.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Signed Images
 =============
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index b868dcbf9fd..4eea0651a3b 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot FIT Signature Verification
 =================================
diff --git a/doc/usage/fit/uefi.rst b/doc/usage/fit/uefi.rst
index 3bbacb5cad0..2a8c090f056 100644
--- a/doc/usage/fit/uefi.rst
+++ b/doc/usage/fit/uefi.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 UEFI
 ====
diff --git a/doc/usage/fit/update3.rst b/doc/usage/fit/update3.rst
index 24235801470..33dcab8051b 100644
--- a/doc/usage/fit/update3.rst
+++ b/doc/usage/fit/update3.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Automatic software update: multiple files
 =========================================
diff --git a/doc/usage/fit/update_uboot.rst b/doc/usage/fit/update_uboot.rst
index 811d008d13d..32678c46ba2 100644
--- a/doc/usage/fit/update_uboot.rst
+++ b/doc/usage/fit/update_uboot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Automatic software update
 =========================
diff --git a/doc/usage/fit/verified-boot.rst b/doc/usage/fit/verified-boot.rst
index 301207711db..8059998fb36 100644
--- a/doc/usage/fit/verified-boot.rst
+++ b/doc/usage/fit/verified-boot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 U-Boot Verified Boot
 ====================
diff --git a/doc/usage/fit/x86-fit-boot.rst b/doc/usage/fit/x86-fit-boot.rst
index 9e3e32204d5..cf9fe87eb5f 100644
--- a/doc/usage/fit/x86-fit-boot.rst
+++ b/doc/usage/fit/x86-fit-boot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Booting Linux on x86 with FIT
 =============================
diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
index 05c439e9ac6..8ea25cf20f7 100644
--- a/doc/usage/measured_boot.rst
+++ b/doc/usage/measured_boot.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 
 Measured Boot
 =============
diff --git a/doc/usage/os/plan9.rst b/doc/usage/os/plan9.rst
index f91712c0094..4d828289389 100644
--- a/doc/usage/os/plan9.rst
+++ b/doc/usage/os/plan9.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Steven Stallion
 .. June 2013
 
diff --git a/doc/usage/os/vxworks.rst b/doc/usage/os/vxworks.rst
index 0fe33d2d34c..f175804f1ca 100644
--- a/doc/usage/os/vxworks.rst
+++ b/doc/usage/os/vxworks.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright (C) 2013, Miao Yan <miao.yan@windriver.com>
 .. Copyright (C) 2015-2018, Bin Meng <bmeng.cn@gmail.com>
 .. Copyright (C) 2019, Lihua Zhao <lihua.zhao@windriver.com>
diff --git a/doc/usage/partitions.rst b/doc/usage/partitions.rst
index acf4573097d..b8d77800e36 100644
--- a/doc/usage/partitions.rst
+++ b/doc/usage/partitions.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. _partitions:
 
 Partitions
diff --git a/doc/usage/semihosting.rst b/doc/usage/semihosting.rst
index 9303a6364d5..249779e1ce2 100644
--- a/doc/usage/semihosting.rst
+++ b/doc/usage/semihosting.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2014 Broadcom Corporation.
 
 Semihosting
-- 
2.45.2

