Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B01DCDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6B284A3E;
	Thu, 25 Jun 2026 14:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRXCBDyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB6484704; Thu, 25 Jun 2026 14:58:39 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55E818460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjm2473@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84538597e1fso1541536b3a.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782392315; x=1782997115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELKxifi+KVbWCmmdkz4tw5ypqh+7oGoZNaa1kb8dA58=;
 b=BRXCBDypbfEW3PJLEfBL9emv6+zpBtxsdt0LtlSanR9126Fp5cX8nD2OrqqAtMEKMH
 1K/XZ+hy+IFf7EMnIQQpJOWJvY5YVbhnBLrR/ECJJ63Ssc1bbTzw6voUJzm6aB0OrRx2
 o1MdWlq+VMv+gVsKXBVMuS2FMfVXiOyLoj6vG//x6TiUS9ieItJnF1SFbw9VAhLtAo8C
 3YBhAoA/d3bttvKHzwEJye5sGnhxBPDd+9Ubol2vY9Io39yGoLrgwKQ9hGZCX4nGK0IM
 2uJAAWdIhv3S1UrUzGjtMXv8DcF7Tze8DOznmZ8xFGJ9HCm9Fpe9MStWuAaJZH1kbSsA
 C29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782392315; x=1782997115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELKxifi+KVbWCmmdkz4tw5ypqh+7oGoZNaa1kb8dA58=;
 b=DCPjG9AEbeirod8+nDN2yeTHQhcQKkebGwHgalHWpNzKwVmsbcMftEZ/+/WRZiBA1T
 2yl22pAJ3uxFkxOWvN0mBa2By2/VNoeNPGatMT/bcP5Dd46YoKcDDhQGhIMvmRrO6RVq
 QRxPXkoXYjRXzzCHdBZL2hH+Z9JJBETzDdZhzIAKQcYZKj437lf7P+bH7LzXTVcYMZM4
 19vhyPFHiPMBtwoQkUhwv0Gn2H/EZT4l30tMiNUyTVmR0xgY0BVQ89ms6gKv+GL67wjC
 GacNHDJCxwbSgF5L6ch4AYjMNLB6afin/WPOM0iQGv1UISVHbgD1wSL9zJalTc4xe8Ug
 QxMw==
X-Gm-Message-State: AOJu0Yw3H0HWkxURVLqByQyDUFGi10EQ9w7IU1p0tHyqlX8YovYlgiS+
 XcR14LyvIvUkH8jufgGB8nZsjQfNtynwxzvKd1KpbM/F6BafJkRHnkAF
X-Gm-Gg: AfdE7clu4h4SjsuoQURe+SRx4n+qGZSyqxZr6e8EhZZ1i+CLPMaCG339FuvlAU9TiSf
 G6sCl7n8jXNkSr6QS3gciAKtKVyKMpsR28M9RExboIqLSupLSnUWXKX+AV5QGNf2SOAJGEk4bPw
 cs5uaamcmu4TU4BES5sYDUcpExaaXbBVjyfnpVs6qsSyMVVwSV8zlG9NANijWEwL8olO8CsDjRD
 3CQqV5+TzlH96bp0PswcNZlyIZ2dCXhBsVgsirTixOf398mImPGdIzvPh3+Im8soU7XG5GdJyaF
 +lznF3GpBrC6wnXYwDOZuLYU888rOn2DRDO316iKGmCNCuzcNZsw4597ctRMif2p8r+vyMby9fz
 dx5cG7GfcpArBRnpW7pfr1cbZWdc2ErtcuWN5UPMG11vT0OtF7yIr8WTL4wYBCAVycSV1HSFLMT
 8xEw==
X-Received: by 2002:a05:6a00:7492:b0:845:b735:5ae with SMTP id
 d2e1a72fcca58-845b73509dcmr1909484b3a.48.1782392314752; 
 Thu, 25 Jun 2026 05:58:34 -0700 (PDT)
Received: from jjmdeMac-mini.lan ([2a09:bac5:3981:e6::17:359])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fedaefsm5439730b3a.23.2026.06.25.05.58.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 05:58:34 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Liangbin Lian <jjm2473@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joseph Chen <chenjh@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
Date: Thu, 25 Jun 2026 20:58:18 +0800
Message-ID: <20260625125818.18914-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125818.18914-1-jjm2473@gmail.com>
References: <20260625125818.18914-1-jjm2473@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:59:14 +0200
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

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 board/rockchip/evb_rk3568/MAINTAINERS |  5 ++
 configs/easepi-r1-rk3568_defconfig    | 82 +++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst       |  1 +
 3 files changed, 88 insertions(+)
 create mode 100644 configs/easepi-r1-rk3568_defconfig

diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 7e17a6a98..c3d4e5df2 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -4,6 +4,11 @@ S:	Maintained
 F:	configs/bpi-r2-pro-rk3568_defconfig
 F:	arch/arm/dts/rk3568-bpi-r2-pro*
 
+EASEPI-R1
+M:	Liangbin Lian <jjm2473@gmail.com>
+S:	Maintained
+F:	configs/easepi-r1-rk3568_defconfig
+
 EVB-RK3568
 M:	Joseph Chen <chenjh@rock-chips.com>
 S:	Maintained
diff --git a/configs/easepi-r1-rk3568_defconfig b/configs/easepi-r1-rk3568_defconfig
new file mode 100644
index 000000000..fa400956b
--- /dev/null
+++ b/configs/easepi-r1-rk3568_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-easepi-r1"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-easepi-r1.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_RTL8169=y
+CONFIG_PHY_REALTEK=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
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
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index a31ee7100..54bd8b81a 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -133,6 +133,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
      - Generic RK3566/RK3568 (generic-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
+     - LinkEase EasePi R1 (easepi-r1-rk3568)
      - Lunzn FastRhino R66S (fastrhino-r66s-rk3568)
      - QNAP TS-433 (qnap-ts433-rk3568)
      - Radxa E25 Carrier Board (radxa-e25-rk3568)
-- 
2.54.0

