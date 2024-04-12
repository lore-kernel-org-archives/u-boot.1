Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51951C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A658803B;
	Fri, 12 Apr 2024 11:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mwUSAnN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB3088011; Fri, 12 Apr 2024 11:55:27 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3942A881FC
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5a9df87e7bbso528063eaf.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915724; x=1713520524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JN0+5Bb4OHcxDdT0YeF0RVWaUWAh30NJq196W3nUn4=;
 b=mwUSAnN26Cwhggs0MWSaTXWxGGOZLZz7WFdAz4w5wJ0tADrsNMTjDtG4VCbv5KiyJk
 fFqDCWtMITbJKbYPJIiZCEIzVYXC9mBoNYu89+lnzAHvdGN7m1EBIIXONbJh+pnwfdQc
 2Uf1Ls4aauNem580n71xvZf8LvKBXQCedRMArPrHGA+HCkNnDeNeNwHNoEhTsWeX2hgH
 LDRbwkORznIj1MOIJy5fXA8rZSCXIXwc1gnARtF6oIwM+Rrdb444EwmiW4dQpJ8MYjAB
 +l7P4/ABViyu5u4V+YureiooGVUQD7ds2/IQ2T1L0pakT1hH6leHT+ei2ZZGGWTTEIZ0
 eTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915724; x=1713520524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/JN0+5Bb4OHcxDdT0YeF0RVWaUWAh30NJq196W3nUn4=;
 b=YmGsoj2yKEiijOmdlKodzPHCv/Ex/RZtQSSdzE26lo19OQgdPx5u5CqezIVPThyjdj
 P23bRru7Jr+z7mZQldYUqMxrRKjqb1hooAwjKL1GAoiSg4n6Ij0aT0OPb6q+nrQyD5OR
 Ido0O86OWJmzQv2YhVnwGUaPKkXty1MnF9BUyjsHqI0ClZS6BXp221IXN2RPPqFdDrmf
 IECd0dHxjB5vRcvdrJgHLMHB/4lCnGkyARtrDOgpel6sb5Sjl+Rn9bKhV0prmap+o4Oh
 LO8ORRnH7Frw/0V8aBpumKQJiRovJIe29wRh/9clw79htpMnbhttCxjnlSZCeuHG5z0y
 DCIw==
X-Gm-Message-State: AOJu0Yw6cNUhRJHmcw2/i52ifKDqstYdDZ3qtj6zT+VLuURlvYql4ZfD
 ZVnOAMElJj/EvM7lhEZnuY2AEzObH2WJ1WjNv10RqpALGV+r9m1b+VxteGSjxvgER13SVJQfm4u
 t
X-Google-Smtp-Source: AGHT+IHMA3LAtvJyXAzt2CogXGB5ntFkbhTirCkXVDP7zLna+2+cYWFGnpEfuIoOWCNMMxS6lMlAgg==
X-Received: by 2002:a05:6870:9122:b0:22a:28b3:3e9c with SMTP id
 o34-20020a056870912200b0022a28b33e9cmr2129437oae.18.1712915723811; 
 Fri, 12 Apr 2024 02:55:23 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:55:23 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 7/7] board: add support for Schneider HMIBSC board
Date: Fri, 12 Apr 2024 15:24:38 +0530
Message-Id: <20240412095438.410570-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
References: <20240412095438.410570-1-sumit.garg@linaro.org>
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

Support for Schneider Electric HMIBSC. Features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 2GiB RAM
- 64GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI

Features enabled in U-Boot:
- RAUC updates
- Environment protection
- USB based ethernet adaptors

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 board/schneider/hmibsc/MAINTAINERS |  6 +++
 board/schneider/hmibsc/hmibsc.env  | 40 ++++++++++++++
 configs/hmibsc_defconfig           | 87 ++++++++++++++++++++++++++++++
 doc/board/index.rst                |  1 +
 doc/board/schneider/hmibsc.rst     | 45 ++++++++++++++++
 doc/board/schneider/index.rst      |  9 ++++
 include/configs/hmibsc.h           | 16 ++++++
 7 files changed, 204 insertions(+)
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 board/schneider/hmibsc/hmibsc.env
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 doc/board/schneider/hmibsc.rst
 create mode 100644 doc/board/schneider/index.rst
 create mode 100644 include/configs/hmibsc.h

diff --git a/board/schneider/hmibsc/MAINTAINERS b/board/schneider/hmibsc/MAINTAINERS
new file mode 100644
index 00000000000..0f31bbda966
--- /dev/null
+++ b/board/schneider/hmibsc/MAINTAINERS
@@ -0,0 +1,6 @@
+HMIBSC BOARD
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	board/schneider/hmibsc/
+F:	include/configs/hmibsc.h
+F:	configs/hmibsc_defconfig
diff --git a/board/schneider/hmibsc/hmibsc.env b/board/schneider/hmibsc/hmibsc.env
new file mode 100644
index 00000000000..da3d892f91d
--- /dev/null
+++ b/board/schneider/hmibsc/hmibsc.env
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+loadaddr=0x90000000
+bootcmd=
+	echo "Booting RAUC A/B system";
+	setenv devtype mmc; setenv devnum 0;
+	test -n "${BOOT_ORDER}" || setenv BOOT_ORDER "A B";
+	test -n "${BOOT_A_LEFT}" || setenv BOOT_A_LEFT 3;
+	test -n "${BOOT_B_LEFT}" || setenv BOOT_B_LEFT 3;
+	setenv raucslot;
+	for BOOT_SLOT in "${BOOT_ORDER}"; do
+		if test "x${raucslot}" != "x"; then
+			echo "skip remaining slots...";
+		elif test "x${BOOT_SLOT}" = "xA"; then
+			if test ${BOOT_A_LEFT} -gt 0; then
+				setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1;
+				echo "Found valid RAUC slot A";
+				setenv raucslot "rauc.slot=A";
+				setenv raucpart A; setenv distro_bootpart 6;
+			fi;
+		elif test "x${BOOT_SLOT}" = "xB"; then
+			if test ${BOOT_B_LEFT} -gt 0; then
+				setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1;
+				echo "Found valid RAUC slot B";
+				setenv raucslot "rauc.slot=B";
+				setenv raucpart B; setenv distro_bootpart 7;
+			fi;
+		fi;
+	done;
+	if test -n "${raucslot}"; then
+		setenv bootargs console=ttyMSM1 root=PARTLABEL=rootfs_${raucpart} rw rootwait ${raucslot};
+		saveenv;
+	else
+		echo "No valid RAUC slot found. Resetting tries to 3";
+		setenv BOOT_A_LEFT 3;
+		setenv BOOT_B_LEFT 3;
+		saveenv;
+		reset;
+	fi;
+	load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm;
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
new file mode 100644
index 00000000000..a07689894ef
--- /dev/null
+++ b/configs/hmibsc_defconfig
@@ -0,0 +1,87 @@
+CONFIG_ARM=y
+CONFIG_SYS_VENDOR="schneider"
+CONFIG_SYS_BOARD="hmibsc"
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x8f600000
+CONFIG_SYS_MALLOC_LEN=0x802000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x0
+CONFIG_DEFAULT_DEVICE_TREE="apq8016-schneider-hmibsc"
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_IDENT_STRING="\nSchneider Electric-HMIBSC"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_CBSIZE=2048
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_SYS_PROMPT="hmibsc => "
+CONFIG_SYS_MAXARGS=64
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_FS_GENERIC=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_MD5SUM=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_USB=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_ENV_FLAGS=y
+CONFIG_CMD_ENV_EXISTS=y
+CONFIG_CMD_NVEDIT_INFO=y
+CONFIG_ENV_WRITEABLE_LIST=y
+CONFIG_ENV_ACCESS_IGNORE_FORCE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON_QCOM_PMIC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_APQ8016=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_MSM_GPIO=y
+CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_APQ8016=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_QCOM=y
+CONFIG_MSM_SERIAL=y
+CONFIG_SPMI_MSM=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_PHYLIB=y
+CONFIG_USB_ETHER_LAN75XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
+CONFIG_CI_UDC=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index f0a11f84ccc..428faa810be 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -42,6 +42,7 @@ Board-specific doc
    renesas/index
    rockchip/index
    samsung/index
+   schneider/index
    sielaff/index
    siemens/index
    sifive/index
diff --git a/doc/board/schneider/hmibsc.rst b/doc/board/schneider/hmibsc.rst
new file mode 100644
index 00000000000..f09fb5af1b3
--- /dev/null
+++ b/doc/board/schneider/hmibsc.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Sumit Garg <sumit.garg@linaro.org>
+
+HMIBSC
+======
+
+The HMIBSC is an IIoT Edge Box Core board based on the Qualcomm APQ8016E SoC.
+More information can be found on the `SE product page`_.
+
+U-Boot can be used as a replacement for Qualcomm's original Android bootloader
+(a fork of Little Kernel/LK). Like LK, it is installed directly into the ``aboot``
+partition. Note that the U-Boot port used to be loaded as an Android boot image
+through LK. This is no longer the case, now U-Boot can replace LK entirely.
+
+.. _SE product page: https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
+
+Build steps
+-----------
+
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``hmibsc``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make hmibsc_defconfig
+  $ make
+
+This will build ``u-boot.elf`` in the configured output directory.
+
+Installation
+------------
+
+Although the HMIBSC does not have secure boot set up by default, the firmware
+still expects firmware ELF images to be "signed". The signature does not provide
+any security in this case, but it provides the firmware with some required
+metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ ./qtestsign.py aboot u-boot.elf
+
+Then install the resulting ``u-boot-test-signed.mbn`` to the ``aboot`` partition
+on your device, e.g. with ``fastboot flash aboot u-boot-test-signed.mbn``.
+
+U-Boot should be running after a reboot (``fastboot reboot``).
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
diff --git a/doc/board/schneider/index.rst b/doc/board/schneider/index.rst
new file mode 100644
index 00000000000..55792ed3100
--- /dev/null
+++ b/doc/board/schneider/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Schneider Electric
+==================
+
+.. toctree::
+   :maxdepth: 2
+
+   hmibsc
diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
new file mode 100644
index 00000000000..27404c80fdf
--- /dev/null
+++ b/include/configs/hmibsc.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Board configuration file for HMIBSC
+ *
+ * (C) Copyright 2024 Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef __CONFIGS_HMIBSC_H
+#define __CONFIGS_HMIBSC_H
+
+/* PHY needs a longer aneg time */
+#define PHY_ANEG_TIMEOUT		8000
+
+#define CFG_ENV_FLAGS_LIST_STATIC "BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw"
+
+#endif
-- 
2.34.1

