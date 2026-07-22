Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D0DC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 19:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BA7D810A4;
	Wed, 22 Jul 2026 19:47:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49fKX9ns4Jtr; Wed, 22 Jul 2026 19:47:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DECB80FF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784749622;
	bh=6pYeJonY/8MVe3mVI7gzLOlSCBnmvBkxSjS5m3c65wM=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hq0YN6rYQUDtnr1piZThSGhywNtjWold7Znva4fVk+a7itvX5LK6ruWVx/Jz1SMPX
	 9oFiuWDi0NNUv8yQ7sG5aTYfMcqRredtbWIepoeDVBLw/K0vEoNGMvkprvvrvY/R7P
	 3pOcH24YyMtqXFldg557MCux0fEqU7ACZdB+cfif9cNNehZaGy2SrecAh5/iOChb3B
	 q+ChxHgm0t0OfRVclZEXvzoD8GGCBllkh5dxCo2lqug/fuEJHfF34uDCY5ggAQxdej
	 h4EHf6hd+g13Sg2+bGGPOICIUnDUwMUajh5n9c6lZymGEXnQgjP5lPmIlNIfzLLY51
	 yVxgZ8GPeYI/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DECB80FF7;
	Wed, 22 Jul 2026 19:47:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E40C12E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D64D540A91
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J56HMCEbjQ-L for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 19:47:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2856640A3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2856640A3E
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2856640A3E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:59 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so10652827a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784749619; x=1785354419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6pYeJonY/8MVe3mVI7gzLOlSCBnmvBkxSjS5m3c65wM=;
 b=hELggzYttoI2k46nAWGYQ08yBjw5NB7dU/FpgiuuxFw25b2tN5w3OSTeW4d1ns1DXg
 c9slvBXil7SwaA2PmE8lFfuO9+VRe3qxqZ2ofAaVjdyE0sKc2wBk8IMpUXokLxOXLrfr
 eA4bRXL1iJEotIKSbtoByBBzb85Ocu1zhaE/n2LfV5dnOV+MbG2yb/6W1X7kYaR4aQkp
 LMLmLKj5sqqmy8Fku3VAtSWoB+S3m0BOyrb2v2qL2ltpNC+L6LRM1M96BtMc50TF/Na9
 GIf5HrINkk7QiPy38kUKdrmMRimLae9BIgsjgwVvchVl4fbqktEuPTR5A8joXG5EKMwW
 U4cg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpThPoLUaSx/D0Lj9Jl2rQoGdG/kao5t55zXuQJEiD2MJOv3LnC+jLUfUfGbEx88DNTfg4MO50=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx3pg1faXNNdIW6Ysipu+O2xz7rFZzdJ8VvCWwanEAKmmcKGltc
 II+wbWTlNN3Tbf1s4PgPiwZwVBnnZxKd1pV4VBJKxGTfb80TCfB94f1O
X-Gm-Gg: AR+sD11FNxTmr/uXuytDirTHmqljNOKNUOR7Wh+9wAiJoq8bLTJvGDSyLUq0185RC8V
 vKhXzF1VSjd0Ws9NO8SI+nTDIXTAKjZakf/py8LSq1Fw+bQHT3NYzZzHTI577H8yYPMwqVTPWgn
 SLtZqsBl8vYqALkPRu7n3kvt+YSIEjyAkmeS1PrNQ7+iQV1oBWwaPcC0v7m9a9lMmF7I9nsc/fZ
 XTQ18D1wTtZuHGuM1kHJSmz9vl4l+LU03NvoADGlurAp8wRXsicbb/O5ztiqPzZyIP1NCbpk0kK
 vfFNgWu9p5jm0lerqJmW6jY+kRDMJdar2rx0sJGM6I2Xh4Qkk8h6w2O8wjzeVqC89RpA55Ew4WE
 1QkrT928W8qsSCQWdPc7AsxegxCp9xOngIfrmRIsoyU4RdhaLHBl8v6qfCUD3BIna2GTre3E5GS
 ueV/Xr/kQCEZWvD0VJ4vuu5hxst2ijcJebhAkxBUoTem/hNi0=
X-Received: by 2002:a17:90b:5205:b0:38e:e9b:ffa7 with SMTP id
 98e67ed59e1d1-38ec6a51c9dmr48493a91.28.1784749619190; 
 Wed, 22 Jul 2026 12:46:59 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:3a9b:51ad:2c34:1075])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130f42bbsm9287280c88.14.2026.07.22.12.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 12:46:58 -0700 (PDT)
To: u-boot@0leil.net
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v4 3/4] rockchip: rk3399: Add ROC-PC-PLUS board detection
Date: Wed, 22 Jul 2026 16:46:37 -0300
Message-ID: <20260722194638.1285159-3-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722194638.1285159-1-festevam@gmail.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784749619; x=1785354419;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6pYeJonY/8MVe3mVI7gzLOlSCBnmvBkxSjS5m3c65wM=;
 b=XUwDVxgQQerZ0b8e+R62sFOs4JmtmvD27TNfCCeBVVkrH0JnCETp753lQqv6YQrroN
 MXIwZEXfThS8hQoaq12iJG2auiUZdC/N9xg44zfSZrlIEn47L69mnpv3c9WReDTnfIvs
 uuP3CH4r4kfv5YUnue/ulhJi05ox0qcy+37AguzusF1yj1KD1NnLRqIROykzUFTxbNx9
 vCJL/QXiVYniY4vHavB2dmJvRs5gfCPQp1c6HCmRBrfAILBX3PA2ZL6JgGsUZZTloZj4
 hrBjrgpBVwUu+deqPJvWYJtO0ZxVj08S4GXNUXVnOszUgIFJ6pzzO6CB4Lzn6Mhwh4BW
 NMyw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XUwDVxgQ
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

The ROC-RK3399-PC has an MP8859 regulator on I2C7 at address 0x66,
while the ROC-RK3399-PC-PLUS does not. Probe for the regulator in SPL
and use the result to select the matching devicetree from the U-Boot
FIT. Fall back to the original board if the I2C bus cannot be probed.

Build both devicetrees from the existing roc-pc-rk3399_defconfig and
enable the XMC SPI NOR driver used by the Plus variant. Set fdtfile
from the selected U-Boot devicetree so the matching Linux devicetree
is used as well.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v3:
- Explicitly sets fdtfile for both PC and PC-PLUS.

 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi |  3 ++
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi      |  8 +++++
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c | 39 +++++++++++++++++++++
 configs/roc-pc-rk3399_defconfig             |  3 ++
 doc/board/rockchip/rockchip.rst             |  2 +-
 5 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi

diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
new file mode 100644
index 000000000000..c80529a62b97
--- /dev/null
+++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3399-roc-pc-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index a85e9549c83e..e7e4a2c89072 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -12,6 +12,14 @@
 	};
 };
 
+&i2c7 {
+	bootph-pre-ram;
+};
+
+&i2c7_xfer {
+	bootph-pre-ram;
+};
+
 &gpio4 {
 	bootph-pre-ram;
 };
diff --git a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
index 6937a27176f9..a12180e65573 100644
--- a/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
+++ b/board/firefly/roc-pc-rk3399/roc-pc-rk3399.c
@@ -5,14 +5,24 @@
 
 #include <dm.h>
 #include <env.h>
+#include <fdtdec.h>
+#include <i2c.h>
+#include <image.h>
 #include <log.h>
 #include <spl_gpio.h>
+#include <asm/global_data.h>
 #include <asm/io.h>
 
 #include <asm/arch-rockchip/cru.h>
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 
+#define ROC_PC_MP8859_BUS	"i2c@ff160000"
+#define ROC_PC_MP8859_ADDR	0x66
+#define ROC_PC_PLUS_FDTFILE	"rockchip/rk3399-roc-pc-plus.dtb"
+
+DECLARE_GLOBAL_DATA_PTR;
+
 #ifdef CONFIG_XPL_BUILD
 
 #define PMUGRF_BASE	0xff320000
@@ -54,4 +64,33 @@ void led_setup(void)
 	spl_gpio_output(gpio0, GPIO(BANK_B, 5), 1);
 }
 
+static bool is_roc_pc_plus(void)
+{
+	struct udevice *bus, *dev;
+
+	if (uclass_get_device_by_name(UCLASS_I2C, ROC_PC_MP8859_BUS, &bus))
+		return false;
+
+	return dm_i2c_probe(bus, ROC_PC_MP8859_ADDR, 0, &dev);
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	if (is_roc_pc_plus())
+		return strcmp(name, ROC_PC_PLUS_FDTFILE);
+
+	return strcmp(name, CONFIG_DEFAULT_FDT_FILE);
+}
+
 #endif
+
+int rk_board_late_init(void)
+{
+	if (!fdt_node_check_compatible(gd->fdt_blob, 0,
+				       "firefly,roc-rk3399-pc-plus"))
+		env_set("fdtfile", ROC_PC_PLUS_FDTFILE);
+	else
+		env_set("fdtfile", CONFIG_DEFAULT_FDT_FILE);
+
+	return 0;
+}
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 1df5cb03adbb..53182dc8251b 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -26,6 +26,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_I2C=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -37,6 +38,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIST="rockchip/rk3399-roc-pc rockchip/rk3399-roc-pc-plus"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -49,6 +51,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_XMC=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9351a5b8eae7..b565aea311e9 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -81,7 +81,7 @@ List of mainline supported Rockchip boards:
      - 96boards RK3399 Ficus (ficus-rk3399)
      - 96boards Rock960 (rock960-rk3399)
      - Firefly-RK3399 (firefly_rk3399)
-     - Firefly ROC-RK3399-PC
+     - Firefly ROC-RK3399-PC/ROC-RK3399-PC-PLUS (roc-pc-rk3399)
      - FriendlyElec NanoPC-T4 (nanopc-t4-rk3399)
      - FriendlyElec NanoPi M4 (nanopi-m4-rk3399)
      - FriendlyElec NanoPi M4B (nanopi-m4b-rk3399)
-- 
2.43.0

