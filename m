Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C886CFD346
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 17:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01EB588FCF;
	Fri, 11 Oct 2024 19:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l53YZuNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD39A88FCF; Fri, 11 Oct 2024 19:06:09 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E8088DFD
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb3da341c9so3152781fa.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728666366; x=1729271166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8mHQGGOzo2lCJRaD5kCiihf8MNTWHveMpTew4vN/AIo=;
 b=l53YZuNgGYPVzmzASj5eyF7/+FoWgP2fhU10VQfTPutjkzlnGXAv4Hc9g4ILxSrUHH
 W7Hs2eWgeBx45ftV2bPVooOJXcyuJ4vW3sd7M39zyRoqKrECIoZQe2i93tpbwfzMiyyw
 wxeLvWNs9REgdQdRRDYvkXHlNp63VQz5ksgovHgma+r128WPfm6rThsvSAvlVNqwo8IT
 aNWpHLzCz+V/81b8opiuHYopRunxFrVXD3F/0M8cSv+PMDinxO64NdP16SUSG/XAjvwO
 bfPjkQozpRhIIu2QAIGq7hGIUGND32m26xQl1FrvqBURAdYuI744FVavf+6JltzTjU29
 Iqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728666366; x=1729271166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mHQGGOzo2lCJRaD5kCiihf8MNTWHveMpTew4vN/AIo=;
 b=QFeKCc6qRqmSy3Vn9PaMNP98SB7EDjHNR+cxgMUSFX64WGQ2z+5ZgUpJidu1//klwy
 xjgYOWaPyMu1vyUi2gpb4znUSl6MUZsSMYpPz6u9OjpVD0Sqfb1w7UHNfoorCxdqhSgV
 p80glAfOauHpRSfFuZBsV5Uaz01ubjJ2/4bXWSWmvpdMEM22TzYiBk7846aj57eRNXDX
 WC/bPDoWpPdw058fc7VFxy7gTE6gA3NOpxFwiXsi52vB9tO4MzBfCvI1Z4d0Xf/LizPO
 14icYUpisiet6rEQt6I0mSWSS/7fVW95Sb4ThJMbtmlc62j5Wp1fifAfpPuerqkiHPrm
 YrQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwWazhqX2lLop7QXhrY4EoVLS2Ig92RFGQ3zFOgj9kvVt6KilvEJeuvPLpW56RIsSlbxZkqpo=@lists.denx.de
X-Gm-Message-State: AOJu0YxF703Bum0G7lIyq6C8xPtx5OdAQqnLN4s++g6VEC4OFjb5hTeg
 XQaCiVhDiK1VWckY26kmCdinIe1NgUezSOzFAvRsXwpHeNbkB6M2
X-Google-Smtp-Source: AGHT+IF+sq8F8x5J8UIqIy0gmJs4ZuUCQM8Sbt3P2FG5ANcaCajk1730XUk5vHgRZ8o2JE5Fxne1+A==
X-Received: by 2002:a2e:bc26:0:b0:2fa:d723:efba with SMTP id
 38308e7fff4ca-2fb3f165028mr2053801fa.8.1728666366081; 
 Fri, 11 Oct 2024 10:06:06 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-430d70b4674sm79553985e9.38.2024.10.11.10.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 10:06:05 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] configs: rockchip: Modernise Geekbox config
Date: Fri, 11 Oct 2024 18:05:57 +0100
Message-ID: <20241011170602.1979605-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.47.0
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

Modernise and move the Geekbox config to use SPL/TPL with
upstream TF-A, enable MMC/USB/Eth to make the device more
useful and work like other Rockchip devices. Update the
readme to reflect the changes to the build process.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

I've not moved this to upstream DT as yet because there's some
further issues I need to debug but this moves this platform
forward.

 arch/arm/dts/rk3368-geekbox-u-boot.dtsi | 10 ++++
 board/geekbuying/geekbox/README         | 40 +++++++++++++-
 configs/geekbox_defconfig               | 71 ++++++++++++++++++++++++-
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3368-geekbox-u-boot.dtsi b/arch/arm/dts/rk3368-geekbox-u-boot.dtsi
index cfc8b9340a8..55d007f7ab8 100644
--- a/arch/arm/dts/rk3368-geekbox-u-boot.dtsi
+++ b/arch/arm/dts/rk3368-geekbox-u-boot.dtsi
@@ -26,6 +26,16 @@
 	bootph-all;
 };
 
+&dmc {
+	bootph-all;
+
+	rockchip,memory-schedule = <DMC_MSCH_CBDR>;
+	rockchip,ddr-frequency = <800000000>;
+	rockchip,ddr-speed-bin = <DDR3_1600K>;
+
+	status = "okay";
+};
+
 &grf {
 	bootph-all;
 };
diff --git a/board/geekbuying/geekbox/README b/board/geekbuying/geekbox/README
index de980f2f233..bd4d8cdd084 100644
--- a/board/geekbuying/geekbox/README
+++ b/board/geekbuying/geekbox/README
@@ -1 +1,39 @@
-see board/rockchip/sheep_rk3368/README
+Here is the step-by-step to boot to U-Boot on the Geekbox
+
+Get the Source and build ATF
+============================
+
+  > git clone https://github.com/TrustedFirmware-A/trusted-firmware-a.git
+  > cd arm-trusted-firmware
+  > make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3368 bl31
+
+Configure U-Boot
+================
+
+  > cd ../u-boot
+  > export BL31=../arm-trusted-firmware/build/rk3368/release/bl31.bin
+  > make geekbox_defconfig
+
+Build the full U-Boot/ATF firmware stack
+========================================
+
+  > make CROSS_COMPILE=aarch64-unknown-elf-
+
+Flash the image
+===============
+
+Copy the SPL to offset 32k and the FIT image containing the payloads
+(U-Boot proper, ATF, devicetree) to offset 256k card.
+
+eMMC
+----
+
+rkdeveloptool allows to flash the on-board eMMC via the USB OTG interface with
+help of the Rockchip loader binary.
+
+  > git clone https://github.com/rockchip-linux/rkdeveloptool
+  > cd rkdeveloptool
+  > autoreconf -i && && ./configure && make
+  > git clone https://github.com/rockchip-linux/rkbin.git
+  > ./rkdeveloptool db rkbin/rk33/rk3368_loader_v2.00.256.bin
+  > ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
index 8f4be79831a..1b116fa8602 100644
--- a/configs/geekbox_defconfig
+++ b/configs/geekbox_defconfig
@@ -3,29 +3,96 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_DEFAULT_DEVICE_TREE="rk3368-geekbox"
+CONFIG_SPL_TEXT_BASE=0x00000000
 CONFIG_ROCKCHIP_RK3368=y
+CONFIG_TPL_LIBCOMMON_SUPPORT=y
+CONFIG_TPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x188000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x400000
+CONFIG_SPL_BSS_MAX_SIZE=0x20000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
+CONFIG_SPL=y
 CONFIG_TARGET_GEEKBOX=y
 CONFIG_DEBUG_UART_BASE=0xFF690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-geekbox.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_BOOTROM_SUPPORT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
+CONFIG_SPL_ATF=y
+CONFIG_TPL=y
+CONFIG_TPL_SYS_MALLOC_SIMPLE=y
+CONFIG_TPL_DRIVERS_MISC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_USB=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_TPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent"
+CONFIG_TPL_OF_PLATDATA=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_TPL_DM=y
 CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_TPL_REGMAP=y
 CONFIG_SYSCON=y
-CONFIG_BOUNCE_BUFFER=y
+CONFIG_SPL_SYSCON=y
+CONFIG_TPL_SYSCON=y
 CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_TPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PINCTRL=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_RGMII=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_RK8XX=y
 CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_TPL_RAM=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
-- 
2.47.0

