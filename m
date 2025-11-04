Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7E8CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 483BC83936;
	Tue,  4 Nov 2025 19:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="azZBjoW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D69C8004F; Tue,  4 Nov 2025 19:25:56 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster3-host1-snip4-2.eps.apple.com [57.103.66.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D22D808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-0 (Postfix) with ESMTPS id
 06A8C18001CA; Tue,  4 Nov 2025 18:25:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=+X3Sh3SDZf4gvi+uwz98dBO/TBzDifFh7uXgkDDj+AI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=azZBjoW42A/cWQVzo0DhXmvmT9pCtKh871MWzPLjgU7tMt6m86v6Td54nkIDkSlr3jCDkz+TkB7cv8N5av3RwRkVghJooB7BDpHyaqVUpiF7D6+M3hSC4Ya9B8E8aDTzD6/7xEf1AIoKW74TjEsy7cRz+klAttO96nvZOX7zXeFdGYCi9PQadCg4ie29Umkpyl4OrZLWtuXnSNVOJGDAI3YPiA7FhPjZk+ZAAmltrMZNalnpaZP+Yhe8AZVQ6CTj3o+Shl+fj0HHLi988w6mtXc2Rwh3KnwzFGtf6SgYcnJ6OGlcOXXI2esF+Z0HcVaeWijJW+zxbZC5ez0htplzHw==
mail-alias-created-date: 1643268037438
Received: from localhost (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-0 (Postfix) with ESMTPSA id
 237AF18000B7; Tue,  4 Nov 2025 18:25:50 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH 1/2] configs: Add rock5b_plus-rk3588_defconfig
Date: Tue,  4 Nov 2025 12:25:11 -0600
Message-ID: <20251104182523.2142120-2-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104182523.2142120-1-bryan@bryanhinton.com>
References: <20251104182523.2142120-1-bryan@bryanhinton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vKYScSEmHw3B3-T0tE8NY9GdNcYD8jRo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE1NSBTYWx0ZWRfX8KHmYIEU5jvv
 5w5I9OR4pHzKw9a4B1GTRCyxyy2qoRxNiyJ8af478CeTzk+KgEeYEroXiA3Xd2J04Gvi9/dE0kZ
 4h5MpQiTgoS6GOIrg727GyxTrCeGHKOzRabR9Exd7C+CQhgzwMyWOoe/WcJ3bTkcMUqGdqAGHJf
 dCYEXqfjRS4lygSWsciVj5Ml0ajlLUAo//7CTtiaFPlUbf3ChUL8epqtzTkZKXDXxOH6q76J+2b
 MeGNgnCz/cicYllW1lW10g19K4Sa+q/ctl5kog21t3ulu3PcGlCqe1+VTsa4E9xiJlrNSjAKjBX
 0i52RoHd1GmrVTxwF6X
X-Authority-Info: v=2.4 cv=dI+rWeZb c=1 sm=1 tr=0 ts=690a452f cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=yyIQ4Ub9AAAA:8 a=TfGJXvGM4W_d8lgq_KcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rzDBUVUxiSc7n6oCI6VQ:22
X-Proofpoint-GUID: vKYScSEmHw3B3-T0tE8NY9GdNcYD8jRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2509250000 definitions=main-2511040155
X-JNJ: AAAAAAAB97tNcPyompgMu5vwyNDGa+hIaT/8yPmBWUS8gACmFq6Y7FgSfQKSz+5C7g+kCUwaP7utUqj6eqk1O0+4B7nfUXv3lpbMowf+ldnIMbaPB2lMjJ1ca1DUe6NSgRkaSdTb5n1tMfDY6qtQPji0OEccVrsE6yrQVfDZaR7Vc710UlnEmupGvGeZVNbaqK1A8pPlZXtRgkfWbDZ7SRs4hNzF8ug6Kd+EoEew25mWaMD2qKlaaeo037ZiEWh4YGX14COxBLUYEzF/W6QvnSTY1/1hNXxWmUInT9QpvJs+25qM2+2CzeiS+Rms8udJ0jCNbCqvzclU1rSTI/hkkJ3RFNd/Kk7ZeJztG5k8wtckx+ZtkGo8107vi4x6UEly5/A3EAUGqNCP3gsGx7kiTfjgxn/v/KtAGQAy/yDYTatOu/T40VAYRCFg6NHtOuhJXAvnKXAsVK0bLJzofLGpk2vXhYsro4nMvFUlj/E/eZgWJUihkgjyrUFBJbPMHl45v45pwAqiB2xgXXsAtyugp39sxPyyhnPCQF8dTjnF5FEtt9nDtlMV7yLKRwBJW2/FQPbG7Sp/A8ECpb3GZ3GiwJ4o+fXgJmOgrWFv7WfSWwL0c2hyd+w5re9a10BcG6ugTQBHT9MF7qNEPSze
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:32:08 +0100
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

Add initial defconfig for the Radxa ROCK 5B+ (RK3588), tested on board
revision 1.2 with 32 GB LPDDR5. This mirrors the existing ROCK 5B baseline
and uses the DTS from U-Boot’s vendored Linux snapshot
(rockchip/rk3588-rock-5b-plus).

Build and test details:
  - U-Boot build: 2026.01-rc1-00232-g0673831a738b-dirty (Nov 04 2025 - 21:18:07 -0600)
  - Toolchain: aarch64-linux-gnu-gcc (GCC) 15.1.0
  - DDR TPL: rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
  - BL31: rkbin/bin/rk35/rk3588_bl31_v1.51.elf
  - Boot medium: microSD card (U-Boot image written via dd)
  - SoC: RK3588 (8× Cortex-A76/A55)
  - DRAM: 32 GiB LPDDR5 detected
  - eMMC socket present but module not soldered (controller still detected)
  - Verified: SPL → U-Boot prompt
  - `mmc list` shows SD + eMMC controllers
  - USB EHCI/XHCI enumeration works (`usb tree`)
  - Control FDT present (`fdt addr ${fdtcontroladdr}; fdt print / model`)
  - Default environment: `fdtfile=rockchip/rk3588-rock-5b-plus.dtb`

This configuration reuses the ROCK 5B base defconfig with minimal adjustments
and builds from the upstream DTS snapshot. Follow-up patches will enable
NVMe, Ethernet, and saveenv support.

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 configs/rock5b_plus-rk3588_defconfig | 118 +++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 configs/rock5b_plus-rk3588_defconfig

diff --git a/configs/rock5b_plus-rk3588_defconfig b/configs/rock5b_plus-rk3588_defconfig
new file mode 100644
index 00000000000..be406180b64
--- /dev/null
+++ b/configs/rock5b_plus-rk3588_defconfig
@@ -0,0 +1,118 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_ROCK5B_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_CMD_TCPM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHYLIB=y
+CONFIG_RTL8169=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_TYPEC_TCPM=y
+CONFIG_TYPEC_FUSB302=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_LAN75XX=y
+CONFIG_USB_ETHER_LAN78XX=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_SEPARATE=y
+# CONFIG_MULTI_DTB_FIT is not set
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-rock-5b-plus"
+CONFIG_OF_LIST="rockchip/rk3588-rock-5b-plus"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b-plus.dtb"
+
+# Minimal first version; follow-ups can add NVMe, Ethernet, saveenv
+# CONFIG_CMD_SAVEENV is not set
+# CONFIG_NVME is not set
-- 
2.51.2

