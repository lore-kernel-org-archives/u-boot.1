Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE7FC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 18:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA17140A27;
	Wed, 22 Jul 2026 18:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nV3-_2I0x7Rs; Wed, 22 Jul 2026 18:40:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 690B1409F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784745642;
	bh=u2MT+i3AxMzy8jE9Rb7sRisAqDWVReJFEKzIGyd0MJg=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=PVBPx/JWUNF/YlI27JFG8RZChNgUhVufXDTSWcHV29dmh8te44wpQvzEF1zIeOHRu
	 xhqml6xvVUILWv/c8l0jwMNIhYE31F/WWTn64RwVBvrxKmFtQE7jShjbWyiwTdxK0E
	 jdlaWd8ECwgZhPNoGR55uDmMxhoNhEzh0yu/LXopon5dwp7NAWQ2HBGoab/AGLxhwM
	 E39t1LYuXZjBXMZSRY5b8fHdI5JfTXNpqKVIWitDaFh7scQUm7gUibR0gepEDgA7k4
	 qRvgJvGm21sahio+o9+CeDmdyTpM3nx7uoYyKLSj790mbVUOHWrtVhU6BOrEgCYAti
	 RI7QOYnorxDOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 690B1409F9;
	Wed, 22 Jul 2026 18:40:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E3A3A224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C906440115
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dG6EVzQb4yuY for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 18:40:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C3D7940057
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C3D7940057
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3D7940057
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:40:40 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6682259cb3dso8402797d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 11:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745639; x=1785350439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u2MT+i3AxMzy8jE9Rb7sRisAqDWVReJFEKzIGyd0MJg=;
 b=TtfXaiTZMyXnPZ2NrgUDDCSdU3s2WE3ohXmf8iN4rKpgvyAJICAJE+KJSeoySw1nPb
 7h+O+vDsS4WEp8oXzfdty+IVhEO0EaxAjx1xdu0Wkpt2MJS2/jDJmyDTpuCuLj/xveHG
 1I18PPjvN3kBWZg2W8e3WqA07MprpAygLMjXBhFiNY22zUgErW5GmRQ03Sg+Ln1tzqky
 o2ZeuyrbX2+5iMC/Y7429h7Bb8f1XIu8270cElesREVJ8f+4+j/3skvi/QibDenve2YT
 Up3G/ue1abdXVw9i7Xs+sHIZT+biBHBa0MqeJce3LKMdt/Th66oppaPbeO9svRTyFvPM
 KeiA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7TfJRyQWwWFKhjIyviZ0ocbhe05j/5MG1A2+8iAX1cZ9WRW91X5PGeTcO7isR3TUob/GfEoU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxWj5oedUvE2Phm2jEKjEHR2ORFl+8GaCPkMs5g6hcqw1F0WtN1
 vEQiiewGh2wwoI8RKuMM4/Kfbl7WcG7PTmdW/o8u0TDsVPCfE9lwWshi
X-Gm-Gg: AR+sD135U9IWeZLPntNjD9VRG5JDiMX9pzF+hJyrtMHfGUmRSQrkRbxu2I3R85v3KCz
 3iKILd0azqPqIJeJXrLDlUEY6BiEtgJQ6RVC9M5FB/XORVZuuWsXCpHfJnzxgjJt7aRd9MrGt8h
 WxZ5clzqX4imGGbjQdEHHBRkw4YKwqayRwuwATylKqL5NjeJeCBGU+rmwFv1h2kWhIh5l35ERGZ
 KiILFwww5yzuOl2z+vxWqOrIgKlLSX3SuRK7kuJceSV4ppgi7IF8AUn4uH/hPTU3uob14ffTaoH
 zWPEAQ/mNbOjr/cWeFaXOnDdxYk6+UPyfp8k6Tt8K7/HhsTJVlL1zDbhegOrASNeI3+EsYKY2lT
 9fsTqzaJOEItgjUcb+Cj1bsOM3vRhufGgNa6aEKueGTnTdBKOQMVablzGRt6zX3JDgP1V2H2f0V
 Bu7ejtsTcKUvl471BNJDmcggEdQsPOD+hvC6k2k2Bikb8B4fg=
X-Received: by 2002:a53:d058:0:10b0:668:8410:2e0c with SMTP id
 956f58d0204a3-6688ee4d7a4mr1230351d50.47.1784745639426; 
 Wed, 22 Jul 2026 11:40:39 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:3a9b:51ad:2c34:1075])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66890521642sm1808508d50.3.2026.07.22.11.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:40:38 -0700 (PDT)
To: u-boot@0leil.net
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v3] rockchip: rk3588s: Add support for ROC-PC-RK3588S
Date: Wed, 22 Jul 2026 15:40:24 -0300
Message-ID: <20260722184024.1210447-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784745639; x=1785350439;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u2MT+i3AxMzy8jE9Rb7sRisAqDWVReJFEKzIGyd0MJg=;
 b=AQ6hAhKN6SQAB8ZLI1jBybLOkgFBWl+t1yC9YjSlVtP1QNR6ozePYSPDIEMRQ4CnCD
 80ho110lixCMhDlHq6la6QgWEe79XjU8tiIamnbIuaatw/X3Fl7ltH/Iq0//8ydgPJy+
 6K7IpJLcTdNl18LA8GpyyfdjuENTGADwnVgOp2a5/T2l6LP6VDfuXiTHgpQM4kh+fNXl
 F1k5iR2NcvMIgHKAXKvz46Nh9GBYGTWhQwDjx5OXpWSQBEwU2oX2Xif2GVHsUHP+pjle
 3gjzod5lbsqX/BEadd1+pn3epG/jYKiEV3mve2m4XFx2sakm7/jNpmq6L6ULYxq7oyJd
 UBqw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AQ6hAhKN
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
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

The ROC-PC-RK3588S board is an SBC made by Firefly, based on the RK3588S
SoC.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v2:
- Drop the USB device-mode DT changes until they are available through
  devicetree-rebasing.
- Drop the corresponding USBDP, DWC3, gadget and UMS options.
- Run savedefconfig, which drops CONFIG_SYS_HAS_NONCACHED_MEMORY and
  CONFIG_ENV_OFFSET, as 0x3f8000 is already the Rockchip default.

 arch/arm/mach-rockchip/rk3588/Kconfig    |  7 ++
 board/firefly/roc-pc-rk3588s/Kconfig     | 12 ++++
 board/firefly/roc-pc-rk3588s/MAINTAINERS |  6 ++
 configs/roc-pc-rk3588s_defconfig         | 81 ++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst          |  1 +
 include/configs/roc-pc-rk3588s.h         |  8 +++
 6 files changed, 115 insertions(+)
 create mode 100644 board/firefly/roc-pc-rk3588s/Kconfig
 create mode 100644 board/firefly/roc-pc-rk3588s/MAINTAINERS
 create mode 100644 configs/roc-pc-rk3588s_defconfig
 create mode 100644 include/configs/roc-pc-rk3588s.h

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 675f13ab66d7..841ae490e85a 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -208,6 +208,12 @@ config TARGET_RK3588_NEU6
 	  IO board and Neu6a needs to mount on top of this IO board in order to
 	  create complete Edgeble Neural Compute Module 6B(Neu6B) IO platform.
 
+config TARGET_ROC_PC_RK3588S
+	bool "Firefly ROC PC RK3588S"
+	help
+	  ROC-PC-RK3588S is a single board computer from Firefly
+	  using the Rockchip RK3588S.
+
 config TARGET_ROCK5A_RK3588
 	bool "Radxa ROCK5A RK3588 board"
 	help
@@ -421,6 +427,7 @@ config SYS_SOC
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/coolpi/genbook_cm5_rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
+source "board/firefly/roc-pc-rk3588s/Kconfig"
 source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
 source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
 source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
diff --git a/board/firefly/roc-pc-rk3588s/Kconfig b/board/firefly/roc-pc-rk3588s/Kconfig
new file mode 100644
index 000000000000..bded7a2fcba1
--- /dev/null
+++ b/board/firefly/roc-pc-rk3588s/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_ROC_PC_RK3588S
+
+config SYS_BOARD
+	default "roc-pc-rk3588s"
+
+config SYS_VENDOR
+	default "firefly"
+
+config SYS_CONFIG_NAME
+	default "roc-pc-rk3588s"
+
+endif
diff --git a/board/firefly/roc-pc-rk3588s/MAINTAINERS b/board/firefly/roc-pc-rk3588s/MAINTAINERS
new file mode 100644
index 000000000000..a0316cab1b92
--- /dev/null
+++ b/board/firefly/roc-pc-rk3588s/MAINTAINERS
@@ -0,0 +1,6 @@
+ROC-PC-RK3588S
+M:	Fabio Estevam <festevam@nabladev.com>
+S:	Maintained
+F:	board/firefly/roc-pc-rk3588s/
+F:	configs/roc-pc-rk3588s_defconfig
+F:	include/configs/roc-pc-rk3588s.h
diff --git a/configs/roc-pc-rk3588s_defconfig b/configs/roc-pc-rk3588s_defconfig
new file mode 100644
index 000000000000..226243d79772
--- /dev/null
+++ b/configs/roc-pc-rk3588s_defconfig
@@ -0,0 +1,81 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-roc-pc"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_ROC_PC_RK3588S=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x400000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-roc-pc.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b565aea311e9..d56d245dc114 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -155,6 +155,7 @@ List of mainline supported Rockchip boards:
      - Rockchip EVB (evb-rk3588)
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
+     - Firefly ROC-PC-RK3588S (roc-pc-rk3588s)
      - FriendlyElec CM3588 NAS (cm3588-nas-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
diff --git a/include/configs/roc-pc-rk3588s.h b/include/configs/roc-pc-rk3588s.h
new file mode 100644
index 000000000000..c9316687c38f
--- /dev/null
+++ b/include/configs/roc-pc-rk3588s.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ROC_PC_RK3588S_H
+#define __ROC_PC_RK3588S_H
+
+#include <configs/rk3588_common.h>
+
+#endif /* __ROC_PC_RK3588S_H */
-- 
2.43.0

