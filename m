Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A12D1AD5A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A1288DB8;
	Wed, 16 Oct 2024 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BDra6dPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8E588FAF; Wed, 16 Oct 2024 12:04:49 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C7988FD2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43055b43604so61545455e9.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073081; x=1729677881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QPpRzjb2b/OGuG7gD3VjQERBdNVdjvohZYi2NpHSpE=;
 b=BDra6dPmqOj9A6ODRTmWEjIYqEHGsZ1zT5CmjkDPRmoTFFc31GIBb0zb7dvIAbM95y
 rQQtpmigpL96H8NuF0Hm1xT23xRp7mdAzwiPXJLLH34ssdNqFgs+FzRfykX5s07skr+X
 utxES2yeMWR5fqEBpY4Yn75LvEDLMRh2lPafNDnRnt0iONJkEJI9ALezrJaPnDOH1aMq
 c7S4aWLVWwiCVwoGb/FvTRpqd5t1DVKhohNKjzp/cgrAmE3Wj7tc32fo1Vx6zhPJzuwB
 vhDCMZzdtCp1mE9NeVT/KIAs+uIQ2a3Bdw+J4NCksH/yKFZNWvFGCxcFa5wdZ2vKk/tp
 1SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073081; x=1729677881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QPpRzjb2b/OGuG7gD3VjQERBdNVdjvohZYi2NpHSpE=;
 b=tnInBmitNNOasTE78IdeIeuGqSN4D5wvmyLGIMaKxe/I+ppeRoRMsdZ6u8+GiUm58j
 B7elvat7WCtjZEwSms7Ny/9DBr2+0OBbKz8TW4RrmvZka14u2Wmqw4nTlkG1pDJmOoFk
 Y5JE71avxFEvdkC6qfGyuPtjLsZhu9xAaUzxFNbT3PWeyT1V0r2w//xXrwEl5E5p9Kb1
 66/uE/BUt4tM1F7Id+Xrrx5kN5V4kpvLFFsb1eeDg69/vFapYLbK3sy8GW8ttBpBWBuq
 pbT/WsaU12trGdUjrE7nugcS+7cslU0u8FJYJu/dR6xPTz5BGAdiNO5kQMFofRxHn7Ck
 fgGQ==
X-Gm-Message-State: AOJu0YwaothR/V7a7+8oqvPW9Kh4UNAf+y6KvZFYovewCLGWDu9xdtto
 EnkPHDFqQ65S53ftYRN43MgSqAROQ0QoN1dAMhGvmOmDiBCmQwZYbmQktjKGzTclFSr3KU0YW5P
 vi73xYm86
X-Google-Smtp-Source: AGHT+IFohzQ9pGiPgqc6E6OlWAoMdqDTXc3qumF1RodCRg1XC7NVAPX72V56Wd4nS3x7+X3Gqi96og==
X-Received: by 2002:a05:600c:1c97:b0:42c:bbd5:af60 with SMTP id
 5b1f17b1804b1-4314a37ee4fmr29243835e9.24.1729073080079; 
 Wed, 16 Oct 2024 03:04:40 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:04:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>, John Keeping <jkeeping@inmusicbrands.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Joshua Watt <jpewhacker@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ion Agorria <ion@agorria.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philip Oberfichtner <pro@denx.de>, Boon Khai Ng <boon.khai.ng@intel.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vitaliy Vasylskyy <vitaliy.vasylskyy@globallogic.com>,
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Alexander Gendin <agendin@matrox.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v13 05/21] net: introduce alternative implementation as
 net/lwip/
Date: Wed, 16 Oct 2024 12:03:59 +0200
Message-Id: <5096b12394071aea85b1ff3c505547efbe301dba.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Oct 2024 15:33:18 +0200
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

Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
adding a new net/lwip/ directory and the NET_LWIP symbol. Network
support is either NO_NET, NET (legacy stack) or NET_LWIP. Subsequent
commits will introduce the lwIP code, re-work the NETDEVICE integration
and port some of the NET commands and features to lwIP.

SPL_NET cannot be enabled when NET_LWIP=y. SPL_NET pulls some symbols
that are part of NET (such as arp_init(), arp_timeout_check(),
arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
added later.

Similarly, DFU_TFTP and FASTBOOT are not compatible with NET_LWIP
because of dependencies on net_loop(), tftp_timeout_ms,
tftp_timeout_count_max and other NET things. Let's add a dependency on
!NET_LWIP for now.

SANDBOX can select NET_LWIP but doing so will currently disable the eth
dm tests as well as the wget tests which have strong dependencies on the
NET code.

Other adjustments to Kconfig files are made to fix "unmet direct
dependencies detected" for USB_FUNCTION_SDP and CMD_FASTBOOT when
the default networking stack is set to NET_LWIP ("default NET_LWIP"
instead of "default NET" in Kconfig).

The networking stack is now a choice between NO_NET,
NET and NET_LWIP. Therefore '# CONFIG_NET is not set' should be
'CONFIG_NO_NET=y'. Adjust the defconfigs accordingly.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig                                       | 29 +++++++++
 Makefile                                      |  2 +-
 boot/Kconfig                                  |  4 +-
 cmd/Kconfig                                   |  1 +
 common/Kconfig                                |  2 +-
 common/spl/Kconfig                            |  1 +
 configs/LicheePi_Zero_defconfig               |  2 +-
 configs/M5249EVB_defconfig                    |  2 +-
 configs/am335x_pdu001_defconfig               |  2 +-
 configs/am62ax_evm_r5_defconfig               |  2 +-
 configs/am62px_evm_r5_defconfig               |  2 +-
 configs/am62x_beagleplay_r5_defconfig         |  2 +-
 configs/amcore_defconfig                      |  2 +-
 configs/amd_versal2_mini_defconfig            |  2 +-
 configs/amd_versal2_mini_emmc_defconfig       |  2 +-
 configs/amd_versal2_mini_ospi_defconfig       |  2 +-
 configs/amd_versal2_mini_qspi_defconfig       |  2 +-
 configs/anbernic-rgxx3-rk3566_defconfig       |  2 +-
 configs/ap143_defconfig                       |  2 +-
 configs/ap152_defconfig                       |  2 +-
 configs/apple_m1_defconfig                    |  2 +-
 configs/astro_mcf5373l_defconfig              |  2 +-
 configs/at91sam9rlek_dataflash_defconfig      |  2 +-
 configs/at91sam9rlek_mmc_defconfig            |  2 +-
 configs/at91sam9rlek_nandflash_defconfig      |  2 +-
 configs/bcm7260_defconfig                     |  2 +-
 configs/bcm7445_defconfig                     |  2 +-
 configs/bcm968380gerg_ram_defconfig           |  2 +-
 configs/bcmns_defconfig                       |  2 +-
 configs/chromebook_samus_tpl_defconfig        |  2 +-
 configs/cortina_presidio-asic-base_defconfig  |  2 +-
 configs/cortina_presidio-asic-pnand_defconfig |  2 +-
 configs/durian_defconfig                      |  2 +-
 configs/e850-96_defconfig                     |  2 +-
 configs/ea-lpc3250devkitv2_defconfig          |  2 +-
 configs/efi-x86_app32_defconfig               |  2 +-
 configs/efi-x86_app64_defconfig               |  2 +-
 configs/emsdp_defconfig                       |  2 +-
 configs/evb-px5_defconfig                     |  2 +-
 configs/generic-rk3568_defconfig              |  2 +-
 configs/generic-rk3588_defconfig              |  2 +-
 configs/hc2910_2aghd05_defconfig              |  2 +-
 configs/igep00x0_defconfig                    |  2 +-
 configs/imx6q_bosch_acc_defconfig             |  2 +-
 configs/imx6ulz_smm_m2_defconfig              |  2 +-
 configs/iot_devkit_defconfig                  |  2 +-
 configs/j722s_evm_r5_defconfig                |  2 +-
 configs/legoev3_defconfig                     |  2 +-
 configs/mk808_defconfig                       |  2 +-
 configs/mx23evk_defconfig                     |  2 +-
 configs/mx28evk_defconfig                     |  2 +-
 configs/mx6memcal_defconfig                   |  2 +-
 configs/mx6ulz_14x14_evk_defconfig            |  2 +-
 configs/mx7ulp_com_defconfig                  |  2 +-
 configs/mx7ulp_evk_defconfig                  |  2 +-
 configs/mx7ulp_evk_plugin_defconfig           |  2 +-
 configs/netgear_cg3100d_ram_defconfig         |  2 +-
 configs/nsim_700_defconfig                    |  2 +-
 configs/nsim_700be_defconfig                  |  2 +-
 configs/nsim_hs38be_defconfig                 |  2 +-
 configs/openpiton_riscv64_defconfig           |  2 +-
 configs/openpiton_riscv64_spl_defconfig       |  2 +-
 configs/origen_defconfig                      |  2 +-
 configs/pe2201_defconfig                      |  2 +-
 configs/pinecube_defconfig                    |  2 +-
 configs/pm9261_defconfig                      |  2 +-
 configs/s5p4418_nanopi2_defconfig             |  2 +-
 configs/s5p_goni_defconfig                    |  2 +-
 configs/s5pc210_universal_defconfig           |  2 +-
 configs/sama5d27_giantboard_defconfig         |  2 +-
 configs/sama5d29_curiosity_mmc1_defconfig     |  2 +-
 configs/sama5d29_curiosity_mmc_defconfig      |  2 +-
 .../sama5d29_curiosity_qspiflash_defconfig    |  2 +-
 configs/sama7g54_curiosity_mmc_defconfig      |  2 +-
 .../sama7g54_curiosity_nandflash_defconfig    |  2 +-
 .../sama7g54_curiosity_qspiflash_defconfig    |  2 +-
 configs/sipeed_maix_bitm_defconfig            |  2 +-
 configs/sipeed_maix_smode_defconfig           |  2 +-
 configs/stemmy_defconfig                      |  2 +-
 configs/stm32f429-discovery_defconfig         |  2 +-
 configs/stm32f429-evaluation_defconfig        |  2 +-
 configs/stm32f469-discovery_defconfig         |  2 +-
 configs/stm32h743-disco_defconfig             |  2 +-
 configs/stm32h743-eval_defconfig              |  2 +-
 configs/stm32h750-art-pi_defconfig            |  2 +-
 configs/stm32mp25_defconfig                   |  2 +-
 configs/stmark2_defconfig                     |  2 +-
 configs/th1520_lpi4a_defconfig                |  2 +-
 configs/thunderx_88xx_defconfig               |  2 +-
 configs/tools-only_defconfig                  |  2 +-
 configs/topic_miami_defconfig                 |  2 +-
 configs/topic_miamilite_defconfig             |  2 +-
 configs/topic_miamiplus_defconfig             |  2 +-
 configs/total_compute_defconfig               |  2 +-
 configs/trats2_defconfig                      |  2 +-
 configs/trats_defconfig                       |  2 +-
 configs/xenguest_arm64_defconfig              |  2 +-
 configs/xenguest_arm64_virtio_defconfig       |  2 +-
 configs/xilinx_versal_mini_defconfig          |  2 +-
 configs/xilinx_versal_mini_emmc0_defconfig    |  2 +-
 configs/xilinx_versal_mini_emmc1_defconfig    |  2 +-
 configs/xilinx_versal_mini_ospi_defconfig     |  2 +-
 configs/xilinx_versal_mini_qspi_defconfig     |  2 +-
 configs/xilinx_versal_net_mini_defconfig      |  2 +-
 configs/xilinx_versal_net_mini_emmc_defconfig |  2 +-
 configs/xilinx_versal_net_mini_ospi_defconfig |  2 +-
 configs/xilinx_versal_net_mini_qspi_defconfig |  2 +-
 configs/xilinx_zynqmp_mini_defconfig          |  2 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |  2 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |  2 +-
 configs/xilinx_zynqmp_mini_nand_defconfig     |  2 +-
 .../xilinx_zynqmp_mini_nand_single_defconfig  |  2 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig     |  2 +-
 configs/zynq_cse_nand_defconfig               |  2 +-
 configs/zynq_cse_nor_defconfig                |  2 +-
 configs/zynq_cse_qspi_defconfig               |  2 +-
 drivers/dfu/Kconfig                           |  1 +
 drivers/fastboot/Kconfig                      |  1 +
 drivers/net/Kconfig                           |  3 +
 drivers/net/phy/Kconfig                       |  2 +-
 drivers/usb/gadget/Kconfig                    |  2 +-
 net/Kconfig                                   | 61 ++++++++++---------
 net/Makefile                                  |  4 ++
 net/lwip/Kconfig                              | 49 +++++++++++++++
 test/cmd/Makefile                             |  2 +
 test/dm/Makefile                              |  2 +
 126 files changed, 241 insertions(+), 145 deletions(-)
 create mode 100644 net/lwip/Kconfig

diff --git a/Kconfig b/Kconfig
index 74e8ce5edfd..a206d1f8124 100644
--- a/Kconfig
+++ b/Kconfig
@@ -758,8 +758,37 @@ source "dts/Kconfig"
 
 source "env/Kconfig"
 
+menu Networking
+
+choice
+	prompt "Networking stack"
+	default NET
+
+config NO_NET
+	bool "No networking support"
+
+config NET
+	bool "Legacy U-Boot networking stack"
+	imply NETDEVICES
+
+config NET_LWIP
+	bool "Use lwIP for networking stack"
+	imply NETDEVICES
+	help
+	  Include networking support based on the lwIP (lightweight IP)
+	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
+	  the default U-Boot network stack and applications located in net/
+	  and enabled via CONFIG_NET as well as other pieces of code that
+	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
+	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
+	  exclusive.
+
+endchoice
+
 source "net/Kconfig"
 
+endmenu
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/Makefile b/Makefile
index 3267fb1c469..f203a4f59e0 100644
--- a/Makefile
+++ b/Makefile
@@ -865,7 +865,7 @@ libs-$(CONFIG_OF_EMBED) += dts/
 libs-y += env/
 libs-y += lib/
 libs-y += fs/
-libs-y += net/
+libs-$(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)) += net/
 libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
diff --git a/boot/Kconfig b/boot/Kconfig
index 925afe06a19..1d50a83a2d2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -503,7 +503,8 @@ config BOOTMETH_ANDROID
 	select ANDROID_AB
 	select ANDROID_BOOT_IMAGE
 	select CMD_BCB
-	select CMD_FASTBOOT
+	imply CMD_FASTBOOT
+	imply FASTBOOT if !NET_LWIP
 	select PARTITION_TYPE_GUID
 	select PARTITION_UUIDS
 	help
@@ -559,6 +560,7 @@ config BOOTMETH_EXTLINUX_PXE
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
+	imply CMD_TFTPBOOT if CMD_NET
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 37894eb80d6..6d20d7597cb 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1653,6 +1653,7 @@ config CMD_USB
 
 config CMD_USB_SDP
 	bool "sdp"
+	depends on USB_GADGET_DOWNLOAD
 	select USB_FUNCTION_SDP
 	help
 	  Enables the command "sdp" which is used to have U-Boot emulating the
diff --git a/common/Kconfig b/common/Kconfig
index 957de0c5c02..0339b9e4c84 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -424,7 +424,7 @@ config LOGF_FUNC_PAD
 
 config LOG_SYSLOG
 	bool "Log output to syslog server"
-	depends on NET
+	depends on NET || NET_LWIP
 	help
 	  Enables a log driver which broadcasts log records via UDP port 514
 	  to syslog servers.
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 2baf2ba7ccb..9a27eabd741 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1083,6 +1083,7 @@ config SPL_DM_SPI_FLASH
 
 config SPL_NET
 	bool "Support networking"
+	depends on !NET_LWIP
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
 	  This permits SPL to load U-Boot over a network link rather than
diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
index 009384eaf1b..c37c49ccbb1 100644
--- a/configs/LicheePi_Zero_defconfig
+++ b/configs/LicheePi_Zero_defconfig
@@ -5,4 +5,4 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
 CONFIG_DRAM_CLK=360
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
diff --git a/configs/M5249EVB_defconfig b/configs/M5249EVB_defconfig
index eac85b9c2d5..ed1446d81cb 100644
--- a/configs/M5249EVB_defconfig
+++ b/configs/M5249EVB_defconfig
@@ -22,7 +22,7 @@ CONFIG_CMD_MX_CYCLIC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/am335x_pdu001_defconfig b/configs/am335x_pdu001_defconfig
index 54da31f45f7..09753fdbd06 100644
--- a/configs/am335x_pdu001_defconfig
+++ b/configs/am335x_pdu001_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_OF_TRANSLATE=y
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 2fe6c49b80f..f386875a89f 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -66,7 +66,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 0cdbd30a760..5fed277d59d 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -70,7 +70,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index 0038747155e..9daee2a38bb 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -67,7 +67,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
diff --git a/configs/amcore_defconfig b/configs/amcore_defconfig
index f1f5201b30a..94c5379590d 100644
--- a/configs/amcore_defconfig
+++ b/configs/amcore_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_DIAG=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="AMCORE"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
 CONFIG_FLASH_CFI_DRIVER=y
diff --git a/configs/amd_versal2_mini_defconfig b/configs/amd_versal2_mini_defconfig
index d4760e40223..ec1921aac39 100644
--- a/configs/amd_versal2_mini_defconfig
+++ b/configs/amd_versal2_mini_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/amd_versal2_mini_emmc_defconfig b/configs/amd_versal2_mini_emmc_defconfig
index d2de379d07c..6d4b261606f 100644
--- a/configs/amd_versal2_mini_emmc_defconfig
+++ b/configs/amd_versal2_mini_emmc_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/amd_versal2_mini_ospi_defconfig b/configs/amd_versal2_mini_ospi_defconfig
index 22a8bfa8511..6c394432f5b 100644
--- a/configs/amd_versal2_mini_ospi_defconfig
+++ b/configs/amd_versal2_mini_ospi_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
index de404b0f658..5c770a7530a 100644
--- a/configs/amd_versal2_mini_qspi_defconfig
+++ b/configs/amd_versal2_mini_qspi_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index 83337d68cc0..4dcf18e22ca 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/ap143_defconfig b/configs/ap143_defconfig
index 9d503bdf61f..9083bf293f5 100644
--- a/configs/ap143_defconfig
+++ b/configs/ap143_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:256k(u-boot),64k(u-boot-env),6336k
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=25000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/configs/ap152_defconfig b/configs/ap152_defconfig
index d830a85be69..0864bf46d54 100644
--- a/configs/ap152_defconfig
+++ b/configs/ap152_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:256k(u-boot),64k(u-boot-env),6336k
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=25000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_BAR=y
diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
index 6a5affcaca9..2d685da8c9e 100644
--- a/configs/apple_m1_defconfig
+++ b/configs/apple_m1_defconfig
@@ -11,7 +11,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_CMD_SELECT_FONT=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_APPLE_SPI_KEYB=y
 # CONFIG_MMC is not set
diff --git a/configs/astro_mcf5373l_defconfig b/configs/astro_mcf5373l_defconfig
index d1942c28971..8dd369d68a1 100644
--- a/configs/astro_mcf5373l_defconfig
+++ b/configs/astro_mcf5373l_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_I2C=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_JFFS2=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_FPGA_ALTERA=y
 CONFIG_FPGA_CYCLON2=y
 CONFIG_FPGA_XILINX=y
diff --git a/configs/at91sam9rlek_dataflash_defconfig b/configs/at91sam9rlek_dataflash_defconfig
index 141e83fe5fd..9ebe2de1f2c 100644
--- a/configs/at91sam9rlek_dataflash_defconfig
+++ b/configs/at91sam9rlek_dataflash_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=15000000
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9rlek_mmc_defconfig b/configs/at91sam9rlek_mmc_defconfig
index d497d59a073..0fef493164e 100644
--- a/configs/at91sam9rlek_mmc_defconfig
+++ b/configs/at91sam9rlek_mmc_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/at91sam9rlek_nandflash_defconfig b/configs/at91sam9rlek_nandflash_defconfig
index 1bcdab8e5aa..c40e99817b9 100644
--- a/configs/at91sam9rlek_nandflash_defconfig
+++ b/configs/at91sam9rlek_nandflash_defconfig
@@ -40,7 +40,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/bcm7260_defconfig b/configs/bcm7260_defconfig
index aeb1f907199..ed026e58617 100644
--- a/configs/bcm7260_defconfig
+++ b/configs/bcm7260_defconfig
@@ -36,7 +36,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCMSTB=y
 CONFIG_MTD=y
diff --git a/configs/bcm7445_defconfig b/configs/bcm7445_defconfig
index 03012056fbb..07294451100 100644
--- a/configs/bcm7445_defconfig
+++ b/configs/bcm7445_defconfig
@@ -38,7 +38,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_BCMSTB=y
 CONFIG_MTD=y
diff --git a/configs/bcm968380gerg_ram_defconfig b/configs/bcm968380gerg_ram_defconfig
index 6c119eb42a6..053c459e05c 100644
--- a/configs/bcm968380gerg_ram_defconfig
+++ b/configs/bcm968380gerg_ram_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_NAND=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
diff --git a/configs/bcmns_defconfig b/configs/bcmns_defconfig
index 989017b96d9..c53c6fffbc4 100644
--- a/configs/bcmns_defconfig
+++ b/configs/bcmns_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="NS"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 1be57560f89..075e3f192a3 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -74,7 +74,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_ACPIGEN is not set
diff --git a/configs/cortina_presidio-asic-base_defconfig b/configs/cortina_presidio-asic-base_defconfig
index 0cb33996fe7..d779e7d8e58 100644
--- a/configs/cortina_presidio-asic-base_defconfig
+++ b/configs/cortina_presidio-asic-base_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CORTINA_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_DM_SERIAL=y
diff --git a/configs/cortina_presidio-asic-pnand_defconfig b/configs/cortina_presidio-asic-pnand_defconfig
index 093874d3023..cdb9681b32b 100644
--- a/configs/cortina_presidio-asic-pnand_defconfig
+++ b/configs/cortina_presidio-asic-pnand_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CORTINA_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/durian_defconfig b/configs/durian_defconfig
index 7765fe3a6a2..ea1d37e9db6 100644
--- a/configs/durian_defconfig
+++ b/configs/durian_defconfig
@@ -28,7 +28,7 @@ CONFIG_SYS_PROMPT="durian#"
 CONFIG_CMD_PCI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 # CONFIG_MMC is not set
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index e5d90996234..5797c6cb1f9 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -20,7 +20,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
 CONFIG_MMC_DW=y
 CONFIG_SOC_SAMSUNG=y
diff --git a/configs/ea-lpc3250devkitv2_defconfig b/configs/ea-lpc3250devkitv2_defconfig
index af9fc5f2f5c..c3af7afced1 100644
--- a/configs/ea-lpc3250devkitv2_defconfig
+++ b/configs/ea-lpc3250devkitv2_defconfig
@@ -25,7 +25,7 @@ CONFIG_SYS_PROMPT="EA-LPC3250v2=> "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_OF_CONTROL=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_LPC32XX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_LPC32XX=y
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 0025e56b5d7..c730945f4f9 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -36,7 +36,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_GZIP is not set
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 1cc50b689c9..1831fb2d5a7 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -40,7 +40,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CONSOLE_SCROLL_LINES=5
diff --git a/configs/emsdp_defconfig b/configs/emsdp_defconfig
index efa5eecad0d..376862ad300 100644
--- a/configs/emsdp_defconfig
+++ b/configs/emsdp_defconfig
@@ -30,7 +30,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="app.bin"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_SNPS=y
diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
index 48f5b90a7dc..b08714437fd 100644
--- a/configs/evb-px5_defconfig
+++ b/configs/evb-px5_defconfig
@@ -57,7 +57,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent"
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_TPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 9b9eab6bad1..1d06f3411fe 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index f22277f935d..ebe883ed597 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -35,7 +35,7 @@ CONFIG_OF_LIVE=y
 # CONFIG_OF_UPSTREAM is not set
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
diff --git a/configs/hc2910_2aghd05_defconfig b/configs/hc2910_2aghd05_defconfig
index d06f922ba57..d7cc7d18ed8 100644
--- a/configs/hc2910_2aghd05_defconfig
+++ b/configs/hc2910_2aghd05_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index f1d9bb34aba..51c825d3fbe 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -60,7 +60,7 @@ CONFIG_ENV_UBI_VOLUME="config"
 CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 354b73752ad..a46b3250b2e 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -82,7 +82,7 @@ CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 93ead4c373b..c2adff17abf 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
diff --git a/configs/iot_devkit_defconfig b/configs/iot_devkit_defconfig
index ba275d04a11..5b7e131c9ac 100644
--- a/configs/iot_devkit_defconfig
+++ b/configs/iot_devkit_defconfig
@@ -34,7 +34,7 @@ CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="app.bin"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_SNPS=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 74fbe52e588..e6a573d599d 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -70,7 +70,7 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=1
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/legoev3_defconfig b/configs/legoev3_defconfig
index 34ef3493cac..60b7a84205c 100644
--- a/configs/legoev3_defconfig
+++ b/configs/legoev3_defconfig
@@ -44,7 +44,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DAVINCI=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index 0610b51748e..dc9b12e5d8c 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -68,7 +68,7 @@ CONFIG_OF_DTB_PROPS_REMOVE=y
 CONFIG_SPL_OF_PLATDATA=y
 CONFIG_TPL_OF_PLATDATA=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_TPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
diff --git a/configs/mx23evk_defconfig b/configs/mx23evk_defconfig
index 793ba6add55..6152d930e3a 100644
--- a/configs/mx23evk_defconfig
+++ b/configs/mx23evk_defconfig
@@ -41,7 +41,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_MXS_GPIO=y
 CONFIG_MMC_MXS=y
 CONFIG_PINCTRL=y
diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index a94d34d2c4c..951d506cec2 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -47,7 +47,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_MXS_GPIO=y
 CONFIG_MMC_MXS=y
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index 0c98c685565..bfde8b0cfb3 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CACHE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 # CONFIG_MMC is not set
 CONFIG_FSL_USDHC=y
diff --git a/configs/mx6ulz_14x14_evk_defconfig b/configs/mx6ulz_14x14_evk_defconfig
index d57b47ef47a..2c13dd4dbc3 100644
--- a/configs/mx6ulz_14x14_evk_defconfig
+++ b/configs/mx6ulz_14x14_evk_defconfig
@@ -36,7 +36,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DM_74X164=y
 CONFIG_DM_I2C=y
diff --git a/configs/mx7ulp_com_defconfig b/configs/mx7ulp_com_defconfig
index eba57dd5fb1..a49cb2a728f 100644
--- a/configs/mx7ulp_com_defconfig
+++ b/configs/mx7ulp_com_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
 # CONFIG_MXC_GPIO is not set
diff --git a/configs/mx7ulp_evk_defconfig b/configs/mx7ulp_evk_defconfig
index 262ee671fa0..12f13112b63 100644
--- a/configs/mx7ulp_evk_defconfig
+++ b/configs/mx7ulp_evk_defconfig
@@ -33,7 +33,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
 # CONFIG_MXC_GPIO is not set
diff --git a/configs/mx7ulp_evk_plugin_defconfig b/configs/mx7ulp_evk_plugin_defconfig
index dc9fc50e150..8e05d394335 100644
--- a/configs/mx7ulp_evk_plugin_defconfig
+++ b/configs/mx7ulp_evk_plugin_defconfig
@@ -31,7 +31,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_IMX_RGPIO2P=y
 # CONFIG_MXC_GPIO is not set
diff --git a/configs/netgear_cg3100d_ram_defconfig b/configs/netgear_cg3100d_ram_defconfig
index 352b98fc0a5..377cc26f937 100644
--- a/configs/netgear_cg3100d_ram_defconfig
+++ b/configs/netgear_cg3100d_ram_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_BCM6345_GPIO=y
 CONFIG_LED=y
diff --git a/configs/nsim_700_defconfig b/configs/nsim_700_defconfig
index a46d2ee232a..d50e85a93fa 100644
--- a/configs/nsim_700_defconfig
+++ b/configs/nsim_700_defconfig
@@ -25,7 +25,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
diff --git a/configs/nsim_700be_defconfig b/configs/nsim_700be_defconfig
index 8dc31819fa1..4832195f6b4 100644
--- a/configs/nsim_700be_defconfig
+++ b/configs/nsim_700be_defconfig
@@ -26,7 +26,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
diff --git a/configs/nsim_hs38be_defconfig b/configs/nsim_hs38be_defconfig
index 5f21b31c84a..67de123d16b 100644
--- a/configs/nsim_hs38be_defconfig
+++ b/configs/nsim_hs38be_defconfig
@@ -27,7 +27,7 @@ CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550=y
diff --git a/configs/openpiton_riscv64_defconfig b/configs/openpiton_riscv64_defconfig
index a47214b0a42..1e693c621eb 100644
--- a/configs/openpiton_riscv64_defconfig
+++ b/configs/openpiton_riscv64_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_OF_EMBED=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CPU=y
 CONFIG_MMC=y
 # CONFIG_MMC_WRITE is not set
diff --git a/configs/openpiton_riscv64_spl_defconfig b/configs/openpiton_riscv64_spl_defconfig
index d2eb891d69e..09054d93047 100644
--- a/configs/openpiton_riscv64_spl_defconfig
+++ b/configs/openpiton_riscv64_spl_defconfig
@@ -78,7 +78,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_DOS_PARTITION is not set
 # CONFIG_SPL_PARTITION_UUIDS is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CPU=y
 CONFIG_MMC=y
 # CONFIG_MMC_WRITE is not set
diff --git a/configs/origen_defconfig b/configs/origen_defconfig
index 9fd7bc103c7..c6cc17a0e03 100644
--- a/configs/origen_defconfig
+++ b/configs/origen_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_MMC_DW=y
diff --git a/configs/pe2201_defconfig b/configs/pe2201_defconfig
index c28ceac0d45..72f6274ec41 100644
--- a/configs/pe2201_defconfig
+++ b/configs/pe2201_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_PCI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 # CONFIG_MMC is not set
diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 7cc0a862949..7567a6aa739 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -9,7 +9,7 @@ CONFIG_DRAM_ODT_EN=y
 CONFIG_I2C0_ENABLE=y
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_SPL_I2C=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
diff --git a/configs/pm9261_defconfig b/configs/pm9261_defconfig
index 9f4d434f3e2..026c6de3109 100644
--- a/configs/pm9261_defconfig
+++ b/configs/pm9261_defconfig
@@ -37,7 +37,7 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=physmap-flash.0:256k(u-boot)ro,64k(u-boot-env)
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_GPIO=y
diff --git a/configs/s5p4418_nanopi2_defconfig b/configs/s5p4418_nanopi2_defconfig
index 23862090df7..548963c933f 100644
--- a/configs/s5p4418_nanopi2_defconfig
+++ b/configs/s5p4418_nanopi2_defconfig
@@ -49,7 +49,7 @@ CONFIG_CMD_FAT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_DEV=2
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_NEXELL=y
 CONFIG_MMC_DW=y
diff --git a/configs/s5p_goni_defconfig b/configs/s5p_goni_defconfig
index 4316510541c..084e19e1258 100644
--- a/configs/s5p_goni_defconfig
+++ b/configs/s5p_goni_defconfig
@@ -44,7 +44,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/s5pc210_universal_defconfig b/configs/s5pc210_universal_defconfig
index 1607a31ce09..190ec961b97 100644
--- a/configs/s5pc210_universal_defconfig
+++ b/configs/s5pc210_universal_defconfig
@@ -41,7 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_SYS_I2C_S3C24X0=y
diff --git a/configs/sama5d27_giantboard_defconfig b/configs/sama5d27_giantboard_defconfig
index 4b29891d7d6..7cde865a12b 100644
--- a/configs/sama5d27_giantboard_defconfig
+++ b/configs/sama5d27_giantboard_defconfig
@@ -64,7 +64,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
 CONFIG_ENV_IS_IN_FAT=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_CLK=y
diff --git a/configs/sama5d29_curiosity_mmc1_defconfig b/configs/sama5d29_curiosity_mmc1_defconfig
index 25ff38c94f3..c8976eec02d 100644
--- a/configs/sama5d29_curiosity_mmc1_defconfig
+++ b/configs/sama5d29_curiosity_mmc1_defconfig
@@ -72,7 +72,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama5d29_curiosity_mmc_defconfig b/configs/sama5d29_curiosity_mmc_defconfig
index e691839d1b9..7fe1a5b7552 100644
--- a/configs/sama5d29_curiosity_mmc_defconfig
+++ b/configs/sama5d29_curiosity_mmc_defconfig
@@ -71,7 +71,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama5d29_curiosity_qspiflash_defconfig b/configs/sama5d29_curiosity_qspiflash_defconfig
index f340423a46f..fd3551131db 100644
--- a/configs/sama5d29_curiosity_qspiflash_defconfig
+++ b/configs/sama5d29_curiosity_qspiflash_defconfig
@@ -71,7 +71,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA5D29"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_AT91=y
 CONFIG_AT91_UTMI=y
diff --git a/configs/sama7g54_curiosity_mmc_defconfig b/configs/sama7g54_curiosity_mmc_defconfig
index 41c18452f9e..fec883e3c17 100644
--- a/configs/sama7g54_curiosity_mmc_defconfig
+++ b/configs/sama7g54_curiosity_mmc_defconfig
@@ -75,7 +75,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama7g54_curiosity_nandflash_defconfig b/configs/sama7g54_curiosity_nandflash_defconfig
index 59e8189287b..7a4cdb0d2ab 100644
--- a/configs/sama7g54_curiosity_nandflash_defconfig
+++ b/configs/sama7g54_curiosity_nandflash_defconfig
@@ -73,7 +73,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sama7g54_curiosity_qspiflash_defconfig b/configs/sama7g54_curiosity_qspiflash_defconfig
index 20cd7143cb8..adf5f558e2e 100644
--- a/configs/sama7g54_curiosity_qspiflash_defconfig
+++ b/configs/sama7g54_curiosity_qspiflash_defconfig
@@ -74,7 +74,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="SAMA7G54"
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
diff --git a/configs/sipeed_maix_bitm_defconfig b/configs/sipeed_maix_bitm_defconfig
index 0d74d63786d..b2e21c7d7ae 100644
--- a/configs/sipeed_maix_bitm_defconfig
+++ b/configs/sipeed_maix_bitm_defconfig
@@ -19,7 +19,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi3:0"
 CONFIG_MTDPARTS_DEFAULT="nor0:1M(u-boot),0x1000@0xfff000(env)"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK_K210_SET_RATE=y
 # CONFIG_INPUT is not set
 CONFIG_FS_EXT4=y
diff --git a/configs/sipeed_maix_smode_defconfig b/configs/sipeed_maix_smode_defconfig
index 4af6e3428ba..d838b252d53 100644
--- a/configs/sipeed_maix_smode_defconfig
+++ b/configs/sipeed_maix_smode_defconfig
@@ -20,7 +20,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi3:0"
 CONFIG_MTDPARTS_DEFAULT="nor0:1M(u-boot),0x1000@0xfff000(env)"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_INPUT is not set
 CONFIG_FS_EXT4=y
 CONFIG_FS_FAT=y
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 88e76087a69..631ccababf1 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_GETTIME=y
 CONFIG_EFI_PARTITION=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x18100000
 CONFIG_FASTBOOT_FLASH=y
diff --git a/configs/stm32f429-discovery_defconfig b/configs/stm32f429-discovery_defconfig
index 5199e542208..77889336147 100644
--- a/configs/stm32f429-discovery_defconfig
+++ b/configs/stm32f429-discovery_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_IMLS=y
 CONFIG_CMD_TIMER=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/stm32f429-evaluation_defconfig b/configs/stm32f429-evaluation_defconfig
index 412533e64f4..2fa8dc9faad 100644
--- a/configs/stm32f429-evaluation_defconfig
+++ b/configs/stm32f429-evaluation_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_ARM_PL180_MMCI=y
 CONFIG_MTD=y
 CONFIG_MTD_NOR_FLASH=y
diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
index 93420cb5bb1..98399416fa5 100644
--- a/configs/stm32f469-discovery_defconfig
+++ b/configs/stm32f469-discovery_defconfig
@@ -26,7 +26,7 @@ CONFIG_CMD_TIMER=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_ARM_PL180_MMCI=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
diff --git a/configs/stm32h743-disco_defconfig b/configs/stm32h743-disco_defconfig
index 376edc271a1..40fc9383aee 100644
--- a/configs/stm32h743-disco_defconfig
+++ b/configs/stm32h743-disco_defconfig
@@ -30,6 +30,6 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32h743-eval_defconfig b/configs/stm32h743-eval_defconfig
index c249c4dd3d4..953e67e75bb 100644
--- a/configs/stm32h743-eval_defconfig
+++ b/configs/stm32h743-eval_defconfig
@@ -30,6 +30,6 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32h750-art-pi_defconfig b/configs/stm32h750-art-pi_defconfig
index d66f440fdb7..4ca2d30e44c 100644
--- a/configs/stm32h750-art-pi_defconfig
+++ b/configs/stm32h750-art-pi_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_DMA=y
 CONFIG_STM32_SDMMC2=y
 # CONFIG_PINCTRL_FULL is not set
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 85e6830d74e..d3f0c088157 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
diff --git a/configs/stmark2_defconfig b/configs/stmark2_defconfig
index f43a24c5b5e..79b21acd032 100644
--- a/configs/stmark2_defconfig
+++ b/configs/stmark2_defconfig
@@ -39,7 +39,7 @@ CONFIG_ENV_SPI_CS=1
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="stmark2"
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
 CONFIG_MTD=y
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 98bcb220392..a57cedbfd11 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -59,7 +59,7 @@ CONFIG_CMD_BOOTMENU=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_BLOCK_CACHE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/thunderx_88xx_defconfig b/configs/thunderx_88xx_defconfig
index 3cc04afe69b..24ad84bd114 100644
--- a/configs/thunderx_88xx_defconfig
+++ b/configs/thunderx_88xx_defconfig
@@ -33,7 +33,7 @@ CONFIG_SYS_PROMPT="ThunderX_88XX> "
 # CONFIG_CMD_SAVEENV is not set
 # CONFIG_CMD_ENV_EXISTS is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index 29554be7a65..8925e37e02a 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -23,7 +23,7 @@ CONFIG_CMD_EXTENSION=n
 CONFIG_CMD_DATE=n
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET=n
+CONFIG_NO_NET=y
 CONFIG_ACPIGEN=n
 CONFIG_AXI=y
 CONFIG_AXI_SANDBOX=y
diff --git a/configs/topic_miami_defconfig b/configs/topic_miami_defconfig
index accdfe9a2ab..039ac710b38 100644
--- a/configs/topic_miami_defconfig
+++ b/configs/topic_miami_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x600000
diff --git a/configs/topic_miamilite_defconfig b/configs/topic_miamilite_defconfig
index 1c65f6ef632..b53f3a7150e 100644
--- a/configs/topic_miamilite_defconfig
+++ b/configs/topic_miamilite_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x600000
diff --git a/configs/topic_miamiplus_defconfig b/configs/topic_miamiplus_defconfig
index 53bf0afd4d1..ba7f248db3b 100644
--- a/configs/topic_miamiplus_defconfig
+++ b/configs/topic_miamiplus_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DFU_RAM=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x600000
diff --git a/configs/total_compute_defconfig b/configs/total_compute_defconfig
index 5f21d2e367a..b3d2e5c88a6 100644
--- a/configs/total_compute_defconfig
+++ b/configs/total_compute_defconfig
@@ -43,7 +43,7 @@ CONFIG_CMD_AVB=y
 CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_CLK=y
 # CONFIG_MMC_WRITE is not set
 CONFIG_ARM_PL180_MMCI=y
diff --git a/configs/trats2_defconfig b/configs/trats2_defconfig
index 3796aed1a93..f4afd373653 100644
--- a/configs/trats2_defconfig
+++ b/configs/trats2_defconfig
@@ -43,7 +43,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/trats_defconfig b/configs/trats_defconfig
index 91ad6b52297..14849d0e691 100644
--- a/configs/trats_defconfig
+++ b/configs/trats_defconfig
@@ -42,7 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/xenguest_arm64_defconfig b/configs/xenguest_arm64_defconfig
index 64e8eb2d81f..e9a5219a7c4 100644
--- a/configs/xenguest_arm64_defconfig
+++ b/configs/xenguest_arm64_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_PVBLOCK=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
 CONFIG_DM_SERIAL=y
diff --git a/configs/xenguest_arm64_virtio_defconfig b/configs/xenguest_arm64_virtio_defconfig
index b5e9b390683..acf131fc837 100644
--- a/configs/xenguest_arm64_virtio_defconfig
+++ b/configs/xenguest_arm64_virtio_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_PARTITION_TYPE_GUID=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_MMC is not set
 CONFIG_DM_PCI_COMPAT=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 229a38dc134..7388a787386 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -58,7 +58,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_CMD_SLEEP is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
 CONFIG_ARM_DCC=y
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 8cd24f4ef81..a36e40dfbb3 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index e868d476db5..3ae2115212a 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -56,7 +56,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index eecbc12f809..d0ea2b6aebd 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -52,7 +52,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 3c0adcde34e..ef6eec075d0 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -54,7 +54,7 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index ba656c9441f..1640dfaff9e 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index 61b0b2a1c97..4c6159a4df1 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 6dc82bc0d96..071eeb8197b 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -51,7 +51,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_MMC is not set
 CONFIG_MTD=y
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index 8d05d99a627..227c45df28c 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -53,7 +53,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
 # CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG is not set
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_GPIO is not set
 # CONFIG_I2C is not set
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index 1e76692e4da..7aab69c9e46 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -54,7 +54,7 @@ CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 391b6f4207c..c56b1e830d6 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -65,7 +65,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_DM_MAILBOX is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 132210bee62..a8dbf0056da 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -65,7 +65,7 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_DM_MAILBOX is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index 1de6b00923d..ba8f02c5b11 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -49,7 +49,7 @@ CONFIG_CLOCKS=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index 8c67786f68d..a8a0055f2e5 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -49,7 +49,7 @@ CONFIG_CLOCKS=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 # CONFIG_DM_MAILBOX is not set
 # CONFIG_MMC is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index 1a2dafe4738..c08b10c6944 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -68,7 +68,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_FIRMWARE is not set
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index d95e69712b0..80852f3507d 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -70,7 +70,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index fbec4a6ab25..326e4e3f7d1 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -70,7 +70,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 53c7edf8bb7..cd84df1e290 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -79,7 +79,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-# CONFIG_NET is not set
+CONFIG_NO_NET=y
 # CONFIG_DM_DEVICE_REMOVE is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_MMC is not set
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index aadd7e8cf7f..604386bb734 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -20,6 +20,7 @@ config DFU_WRITE_ALT
 config DFU_TFTP
 	bool "DFU via TFTP"
 	depends on NETDEVICES
+	depends on !NET_LWIP
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
 	help
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 70207573de2..1eb460f5a02 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,6 @@
 menu "Fastboot support"
 	depends on CMDLINE
+	depends on !NET_LWIP
 
 config FASTBOOT
 	bool
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 88ef674cd73..fa6fc1cb8e4 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -48,6 +48,7 @@ config DM_DSA
 	bool "Enable Driver Model for DSA switches"
 	depends on DM_MDIO
 	depends on PHY_FIXED
+	depends on !NET_LWIP
 	help
 	  Enable driver model for DSA switches
 
@@ -342,6 +343,7 @@ config ESSEDMA
 
 config ETH_SANDBOX
 	depends on SANDBOX
+	depends on NET
 	default y
 	bool "Sandbox: Mocked Ethernet driver"
 	help
@@ -363,6 +365,7 @@ config ETH_SANDBOX_LWIP
 
 config ETH_SANDBOX_RAW
 	depends on SANDBOX
+	depends on NET
 	default y
 	bool "Sandbox: Bridge to Linux Raw Sockets"
 	help
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a9efc509814..13e73810ad6 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -11,7 +11,7 @@ config MV88E6352_SWITCH
 
 menuconfig PHYLIB
 	bool "Ethernet PHY (physical media interface) support"
-	depends on NET
+	depends on NET || NET_LWIP
 	help
 	  Enable Ethernet PHY (physical media interface) support.
 
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 1694ad03183..010084ef7f3 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -233,7 +233,7 @@ endif # USB_GADGET_DOWNLOAD
 
 config USB_ETHER
 	bool "USB Ethernet Gadget"
-	depends on NET
+	depends on NET || NET_LWIP
 	default y if ARCH_SUNXI && USB_MUSB_GADGET
 	help
 	  Creates an Ethernet network device through a USB peripheral
diff --git a/net/Kconfig b/net/Kconfig
index 7cb80b880a9..16a9de47e94 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -2,11 +2,6 @@
 # Network configuration
 #
 
-menuconfig NET
-	bool "Networking support"
-	default y
-	imply NETDEVICES
-
 if NET
 
 config ARP_TIMEOUT
@@ -26,15 +21,6 @@ config PROT_UDP
 	  Enable a generic udp framework that allows defining a custom
 	  handler for udp protocol.
 
-config BOOTDEV_ETH
-	bool "Enable bootdev for ethernet"
-	depends on BOOTSTD
-	default y
-	help
-	  Provide a bootdev for ethernet so that is it possible to boot
-	  an operationg system over the network, using the PXE (Preboot
-	  Execution Environment) protocol.
-
 config BOOTP_SEND_HOSTNAME
 	bool "Send hostname to DNS server"
 	help
@@ -45,15 +31,6 @@ config BOOTP_SEND_HOSTNAME
 	  of the "hostname" environment variable is passed as
 	  option 12 to the DHCP server.
 
-config NET_RANDOM_ETHADDR
-	bool "Random ethaddr if unset"
-	help
-	  Selecting this will allow the Ethernet interface to function even
-	  when the ethaddr variable for that interface is unset.  In this case,
-	  a random MAC address in the locally administered address space is
-	  generated. It will be saved to the appropriate environment variable,
-	  too.
-
 config NETCONSOLE
 	bool "NetConsole support"
 	help
@@ -255,11 +232,35 @@ config IPV6
 
 endif   # if NET
 
+source "net/lwip/Kconfig"
+
+if NET || NET_LWIP
+
+config BOOTDEV_ETH
+	bool "Enable bootdev for ethernet"
+	depends on BOOTSTD
+	default y
+	help
+	  Provide a bootdev for ethernet so that is it possible to boot
+	  an operating system over the network, using the PXE (Preboot
+	  Execution Environment) protocol.
+
+config NET_RANDOM_ETHADDR
+	bool "Random ethaddr if unset"
+	help
+	  Selecting this will allow the Ethernet interface to function even
+	  when the ethaddr variable for that interface is unset.  In this case,
+	  a random MAC address in the locally administered address space is
+	  generated. It will be saved to the appropriate environment variable,
+	  too.
+
+endif   # if NET || NET_LWIP
+
 config SYS_RX_ETH_BUFFER
-	int "Number of receive packet buffers"
-	default 4
-	help
-	  Defines the number of Ethernet receive buffers. On some Ethernet
-	  controllers it is recommended to set this value to 8 or even higher,
-	  since all buffers can be full shortly after enabling the interface on
-	  high Ethernet traffic.
+        int "Number of receive packet buffers"
+        default 4
+        help
+          Defines the number of Ethernet receive buffers. On some Ethernet
+          controllers it is recommended to set this value to 8 or even higher,
+          since all buffers can be full shortly after enabling the interface on
+          high Ethernet traffic.
diff --git a/net/Makefile b/net/Makefile
index a7075c36a04..33c82b5d229 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -5,6 +5,8 @@
 
 #ccflags-y += -DDEBUG
 
+ifeq ($(CONFIG_NET),y)
+
 obj-$(CONFIG_NET)      += arp.o
 obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
@@ -38,3 +40,5 @@ obj-$(CONFIG_CMD_WGET) += wget.o
 # sprintf(buf, index ? "foo%d" : "foo", index)
 # and this is intentional usage.
 CFLAGS_eth_common.o += -Wno-format-extra-args
+
+endif
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
new file mode 100644
index 00000000000..8a67de4cf33
--- /dev/null
+++ b/net/lwip/Kconfig
@@ -0,0 +1,49 @@
+#
+# Network configuration (with lwIP stack)
+#
+
+if NET_LWIP
+
+config LWIP_DEBUG
+	bool "Enable debug traces in the lwIP library"
+
+config LWIP_ASSERT
+	bool "Enable assertions in the lwIP library"
+
+config PROT_DHCP_LWIP
+	bool
+	select PROT_UDP_LWIP
+
+config PROT_DNS_LWIP
+	bool
+	select PROT_UDP_LWIP
+
+config PROT_RAW_LWIP
+	bool
+
+config PROT_TCP_LWIP
+	bool
+
+config PROT_TCP_SACK_LWIP
+	bool "TCP SACK support"
+	depends on PROT_TCP_LWIP
+	default y
+	help
+	  TCP protocol with selective acknowledgements. Improves
+	  file transfer speed in wget.
+
+config PROT_UDP_LWIP
+	bool
+
+config LWIP_TCP_WND
+	int "Value of TCP_WND"
+	default 8000 if ARCH_QEMU
+	default 3000000
+	help
+	  Default value for TCP_WND in the lwIP configuration
+	  Lower values result in slower wget transfer speeds in
+	  general, especially when the latency on the network is high,
+	  but QEMU with "-net user" needs no more than a few KB or the
+	  transfer will stall and eventually time out.
+
+endif # NET_LWIP
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8f2134998ad..dbee9b26405 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -30,7 +30,9 @@ ifdef CONFIG_SANDBOX
 obj-$(CONFIG_CMD_MBR) += mbr.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
+ifdef CONFIG_NET
 obj-$(CONFIG_CMD_WGET) += wget.o
+endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 6c9ebb8d07c..bcb52ef1067 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -48,7 +48,9 @@ obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi_host.o
 obj-$(CONFIG_DM_DSA) += dsa.o
 obj-$(CONFIG_ECDSA_VERIFY) += ecdsa.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += efi_media.o
+ifdef CONFIG_NET
 obj-$(CONFIG_DM_ETH) += eth.o
+endif
 obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
-- 
2.40.1

