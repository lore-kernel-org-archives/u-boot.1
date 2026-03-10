Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06CBFCC9A4
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D822D839DF;
	Tue, 10 Mar 2026 01:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UI/Hcb5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DC683F8A; Tue, 10 Mar 2026 01:06:28 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20E783981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1773101185; bh=6wCe6HkiPSJZqUWLIkfLPDOU856lUNYNSbiFJPuu9Zs=;
 b=UI/Hcb5/mtpJor+Y06K+wxnS1WYwKqNd1DxU3JR7hVKGpY+XjsrrUZWKH1PYuGLgOaqwHzIYT
 lUbKIOdUbC6xygZq7KjX/YXoKNfhpaixGIaW2pURT1nTo0579Jjd6gLPuNPJK1L0Gpfha4n+y8Y
 FAvBBrQ/PoTx+rXA6GAI34RclvacNo4+s6NcdFGZxykSH3yPN9jd5lcT4SuA9QjOu97jY4sTMJb
 lC/tt76/q564PLA5V3aZN4Ivo3dJc87SQVdF7+L/NWDZiSXf9PC7ulJFIKhmKhsYyhMc78SDmYp
 rugeYKPqYzqwDLkALgsR34M4XCPldpoPhsyalGjDtilQ==
X-Forward-Email-ID: 69af6080746be01f0a4eb91c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tianling Shen <cnsztl@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] board: rockchip: Add FriendlyElec NanoPi R76S
Date: Tue, 10 Mar 2026 00:06:05 +0000
Message-ID: <20260310000610.592998-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310000610.592998-1-jonas@kwiboo.se>
References: <20260310000610.592998-1-jonas@kwiboo.se>
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

The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
device with two 2.5G, designed and developed by FriendlyElec.

Features tested on a NanoPi R76S 2411:
- SD-card boot
- eMMC boot
- LEDs and button
- PCIe/Ethernet
- USB host

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Remove arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
---
 arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 +++
 configs/nanopi-r76s-rk3576_defconfig      | 60 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 3 files changed, 67 insertions(+)
 create mode 100644 configs/nanopi-r76s-rk3576_defconfig

diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
index 393edd3984ce..79cf9e97f70b 100644
--- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -10,6 +10,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3576-nanopi-m5*
 F:	configs/nanopi-m5-rk3576_defconfig
 
+NANOPI-R76S-RK3576
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3576-nanopi-r76s*
+F:	configs/nanopi-r76s-rk3576_defconfig
+
 OMNI3576-RK3576
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/nanopi-r76s-rk3576_defconfig b/configs/nanopi-r76s-rk3576_defconfig
new file mode 100644
index 000000000000..af149dc4ba56
--- /dev/null
+++ b/configs/nanopi-r76s-rk3576_defconfig
@@ -0,0 +1,60 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-r76s"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-r76s.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_RTL8169=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 7a8532b49fc5..c1683bfe4212 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -140,6 +140,7 @@ List of mainline supported Rockchip boards:
      - ArmSoM Sige5 (sige5-rk3576)
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
      - FriendlyElec NanoPi M5 (nanopi-m5-rk3576)
+     - FriendlyElec NanoPi R76S (nanopi-r76s-rk3576)
      - Generic RK3576 (generic-rk3576)
      - Luckfox Omni3576 (omni3576-rk3576)
      - Radxa ROCK 4D (rock-4d-rk3576)
-- 
2.53.0

