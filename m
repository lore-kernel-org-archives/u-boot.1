Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32435CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA6D848B4;
	Thu, 28 May 2026 19:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RaInZ1v8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982E6848BF; Thu, 28 May 2026 19:11:38 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA2D848AA
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e61d8d9a21so2705278a34.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988295; x=1780593095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfUSGN4yEKNvdEx98sWyDTk6Na9tnZwaaq9qnQmNttk=;
 b=RaInZ1v8stiVY9aoz4KlRX9KfBtSzh90S0HuR7Dg6J5dhK3NOmUazzpj+Wqrk7Qrp1
 h64ZSKh1r3b0D59vLehM/QxZqPYjlRh0zsFjmPF1pZ14tTW4ZSW/mqLD/N63TBmhxmes
 xr6k3VIgDGolkdOmM6YQjXCqC41+ewCXyln/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988295; x=1780593095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EfUSGN4yEKNvdEx98sWyDTk6Na9tnZwaaq9qnQmNttk=;
 b=HBTGRjcfOUe0auFNsCgajbnwci18lNdv6ZRT1dAbB7h78H2B3hTLUruEcHgDlUCsG9
 QToUmRzvr6LrK2J9ydHaudfxpsDeqCBoci6U/26M5d+zKJkVNmGcWpcqv8viYxgHrSgz
 N8f1iRz+9ssutl5ncBd4m92maJMT1mPANfpm/YuvECv9e3vGP82gcL3VPc5VQK4dS3SE
 FgHdZsdqQODCfwnEI26dtbLYIjrPef4EsewLQqTwGGtd3mgYFuJlb4dhT6bvTdPxFIze
 PA/e+vJQfDhlchzp/raYmkRal9H9ozxx4TCuPvzecsho3Oja4C+0O39dEWDSX6TScR3K
 a7Eg==
X-Gm-Message-State: AOJu0Yww3w+a4mYNkE7cJKRiedxXaPGa+HJP5UcSnuYzqLK0vqu1sIuv
 RJ0C2Dazr14WuXo1LrcdTO+63TPWOmFOLMVVhPA8gwgMMzjKZr4NdLBgjnc/2ojNOUxN3TsuJWS
 ddLGsDlniXIM=
X-Gm-Gg: Acq92OGPsakgJfXVR9FviANokWQPakkfCwqqfvOMBAsWN/ieAUYYhly6/2EyWlrCl9e
 8JGRX1UWJxrRNnxWgLb29h4WuQNfMcRc59uqXGSziQ+w47PFRs+Hd6yuK+1hUBK/jC2drezK7EZ
 1dWAZgZY6xOfHomisvIFtUsME03SUxNoX6h1XcVxrzTqYPyMLrYP7SrvtqOwkxx2QOGZoqNYcew
 ZgZmqf1FbaSgWkeavNTR3vbSX3tPHJP/uKX+trQ2DS9iXPDb7qpAuJQ0N1uM+CYdeqduOZXIIVA
 MV/hm+X+vE8fEI8FMFgxC/IgrQYabKQBMvSInIYb70aMaVhtNLZWCqWsOBvVshCHO7PQA2RD/QA
 NuMd+/hM7PPVFfuxjXd/qHoIaPZRntlq/VpTgI7uSeN5+LCLJ05gIeWSypHivJKmSFmQ4k9Pv4K
 BbkmW4IgmVvZUIc1Voa0vQ3AVU4rER
X-Received: by 2002:a05:6830:6f8a:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7e5fe92a20bmr16742856a34.0.1779988295059; 
 Thu, 28 May 2026 10:11:35 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 17/22] rockchip: Add a generic-ddr3 rk3399 board
Date: Thu, 28 May 2026 11:10:24 -0600
Message-ID: <20260528171043.910264-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

This build-target is used to build an image which can run on multiple
rk3399 boards, using VBE to boot.

To use it, the TPL binary for a particular board must be placed into the
first part of the image. The rest of the image (i.e. VPL, SPL and
U-Boot) is largely generic and can work on any supported board.

With VBE, memory-init happens in SPL so that this code is updatable in
the field. Due to size constraints, the type of memory on the board is
defined at build-time. So it is not possible to use the same VBE image
on boards with different SDRAM (DDR3 vs LPDDR4 for example). This may
become possible with newer boards with more SRAM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Add value for CONFIG_SPL_STACK_R_ADDR

Changes in v4:
- Drop SPL_PAD_TO value since the default is fine
- Drop ROCKCHIP_IODOMAIN since it is the default
- Add SPL_LIBCOMMON_SUPPORT and SPL_LIBGENERIC_SUPPORT

Changes in v2:
- Rename to rk3399-generic-ddr3
- Update devicetree to match firefly-rk3399
- Use the firefly devicetree as the default for this board

 board/rockchip/evb_rk3399/MAINTAINERS |   6 ++
 configs/rk3399-generic-ddr3_defconfig | 126 ++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 configs/rk3399-generic-ddr3_defconfig

diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
index 8319db2e976..e2149e579f1 100644
--- a/board/rockchip/evb_rk3399/MAINTAINERS
+++ b/board/rockchip/evb_rk3399/MAINTAINERS
@@ -95,3 +95,9 @@ M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/rock-pi-n10-rk3399pro_defconfig
 F:	arch/arm/dts/rk3399pro-rock-pi-n10*
+
+RK3399-GENERIC-DDR3
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	configs/rk3399-generic-ddr3_defconfig
+F:	arch/arm/dts/rockchip-vpl-u-boot.dtsi
diff --git a/configs/rk3399-generic-ddr3_defconfig b/configs/rk3399-generic-ddr3_defconfig
new file mode 100644
index 00000000000..0a6337f8d57
--- /dev/null
+++ b/configs/rk3399-generic-ddr3_defconfig
@@ -0,0 +1,126 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00200000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x3f00000
+CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-firefly"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3399=y
+CONFIG_SPL_STACK_R_ADDR=0x04000000
+CONFIG_TARGET_EVB_RK3399=y
+CONFIG_SPL_STACK=0xff8eff00
+CONFIG_SPL_TEXT_BASE=0xff8c2000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x30000
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_DEBUG_UART_BASE=0xFF1A0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
+CONFIG_VPL_LOAD_FIT_FULL=y
+# CONFIG_VPL_FIT_PRINT is not set
+# CONFIG_VPL_FIT_SIGNATURE is not set
+# CONFIG_VPL_BOOTSTD is not set
+# CONFIG_BOOTMETH_VBE_SIMPLE is not set
+CONFIG_BOOTMETH_VBE_ABREC=y
+CONFIG_BOOTSTAGE=y
+CONFIG_BOOTSTAGE_REPORT=y
+CONFIG_USE_PREBOOT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-generic.dtb"
+CONFIG_LOG=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_FIXED=y
+CONFIG_BLOBLIST_ADDR=0xff8eff00
+CONFIG_BLOBLIST_SIZE=0x100
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1000
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
+CONFIG_TPL_RELOC_LOADER=y
+CONFIG_VPL=y
+CONFIG_VPL_RELOC_LOADER=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_BOOTSTAGE=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIST="rockchip/rk3399-nanopc-t4 rockchip/rk3399-nanopi-m4 rockchip/rk3399-nanopi-m4b rockchip/rk3399-nanopi-neo4 rockchip/rk3399-evb rockchip/rk3399-ficus rockchip/rk3399-firefly rockchip/rk3399-orangepi rockchip/rk3399-puma-haikou"
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_TPL_DM_SEQ_ALIAS=y
+CONFIG_VPL_REGMAP=y
+CONFIG_VPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
+# CONFIG_SPL_DM_PMIC is not set
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+# CONFIG_VPL_SYSRESET is not set
+CONFIG_USB=y
+# CONFIG_SPL_DM_USB is not set
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_VPL_USE_TINY_PRINTF=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_CMD_DHRYSTONE=y
+# CONFIG_SPL_SHA1 is not set
+# CONFIG_VPL_SHA1 is not set
+# CONFIG_VPL_SHA256 is not set
+CONFIG_TPL_CRC8=y
+CONFIG_TPL_LZ4=y
+CONFIG_VPL_LZ4=y
+# CONFIG_VPL_LZMA is not set
+CONFIG_ERRNO_STR=y
-- 
2.43.0

