Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B6CC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 21:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9D68215E;
	Tue, 28 Jan 2025 22:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="eQux1c2g";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="de4KD5RL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5691481E81; Tue, 28 Jan 2025 22:40:02 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0F381F63
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 22:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=eQux1c2g0vi2gquWgq+jq62gGsNiXinuVTgvVNUAGKqTk/k2DLj0bFN+n0/KUB3rTnZoITGW9xTy9pPtwbsP67OAAwyMFMDkBdseVOhBZs3BVkaWhPkFx48qujWjgiiYZ3HJBOFILhv1OsoAqXKDBYEYB8Zrz3nDps5awoezSLyjAU4A2wfE/Vnu4oz6cXOW8AWlBkNjX7NCe1tIVEz0uHama4QAOkYAVnPim3V4KzX662CaFeB4ol/HHqBxr0xwmgJZy9dXEb/LqOTDQ0fahc8v+U+zwu0ACACTXU9+sKT79m4ci7n+06gdSRwfoGOVLGNs7FbgljxtZjH90vKj5Q==;
 s=purelymail1; d=tidylabs.net; v=1;
 bh=P/TXjQW1Vp6Hj2JXd1gVYb3I/LD8vkXViWbhIFEwytI=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=de4KD5RLI2CID/5VixcEF55UWIV8TcDLwh14liRwUucbGyXCxuz9vpOBZf5d2LlQ42FTOY5yCIMV6kqAvpQ3zkQcvvzFl0aND//urAA2qDVD3I80Zwz+Yqmyc+d/GJF+mxSX2ll4Cssm3b/QcwdALwuDZBGfFBw2V90QdDpdmcFXqMKj+k3tSIH9QWiMWv9F33BKqdXfzxAH+B5Wf06zMARTlb/XsnFFa0pBoExh+IlricYcXDiJmghHPX2JXrsjyNNRqS1ywdB33g2mM0oRo+n9MjziwameFszgrrZEvS3Al3V6smzsmGx8ZSybs2lfDM2HgIgaR6O17SlYF7voOA==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=P/TXjQW1Vp6Hj2JXd1gVYb3I/LD8vkXViWbhIFEwytI=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -499528210; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 28 Jan 2025 21:39:34 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Alexandre Vicenzi <linux@alxd.me>,
 Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Xiaobo Tian <peterwillcn@gmail.com>
Subject: [PATCH v2 5/5] rockchip: rk3399-nanopi-4: Enable IO-domain driver in
 SPL
Date: Tue, 28 Jan 2025 21:37:37 +0000
Message-ID: <20250128213852.465664-6-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250128213852.465664-1-justin@tidylabs.net>
References: <20250128213852.465664-1-justin@tidylabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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

The NanoPi RK3399 boards support UHS-I (up to SDR104) SD cards, however
using any of these 1.8v modes results in a boot failure in SPL upon soft
reboot.

The issue is that the "vcc_sdio" regulator is left at 1.8v on reboot
and the corresponding GPIO defaults to 3.3v. This prevents the SD card
from being reinitialized and read successfully.

This change enables the RK8XX regulators and Rockchip IO-domain drivers
in SPL, which initializes "vcc_sdio" regulator to 3.0v and configures
the GPIO for the correct level on boot.

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
---

Changes in v2:
- Added defconfig changes for all NanoPi RK3399 boards

 arch/arm/dts/rk3399-nanopi4-u-boot.dtsi | 9 +++++++++
 configs/nanopc-t4-rk3399_defconfig      | 7 +++++++
 configs/nanopi-m4-2gb-rk3399_defconfig  | 7 +++++++
 configs/nanopi-m4-rk3399_defconfig      | 7 +++++++
 configs/nanopi-m4b-rk3399_defconfig     | 7 +++++++
 configs/nanopi-neo4-rk3399_defconfig    | 7 +++++++
 configs/nanopi-r4s-rk3399_defconfig     | 7 +++++++
 7 files changed, 51 insertions(+)

diff --git a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi b/arch/arm/dts/rk3399-=
nanopi4-u-boot.dtsi
index ba2b73223d4..62fd21f2ca5 100644
--- a/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-nanopi4-u-boot.dtsi
@@ -9,6 +9,14 @@
 =09bootph-pre-ram;
 };
=20
+&i2c0_xfer {
+=09bootph-pre-ram;
+};
+
+&io_domains {
+=09bootph-pre-ram;
+};
+
 &sdmmc {
 =09pinctrl-0 =3D <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_cd>;
 };
@@ -23,6 +31,7 @@
 };
=20
 &vcc_sdio {
+=09bootph-pre-ram;
 =09/delete-property/ regulator-always-on;
 =09/delete-property/ regulator-boot-on;
 =09regulator-init-microvolt =3D <3000000>;
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_=
defconfig
index 26c12c51078..89987e4ff36 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=3D0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-nanopc-t4"
 CONFIG_DM_RESET=3Dy
 CONFIG_ROCKCHIP_RK3399=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_EVB_RK3399=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x800800
 CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
@@ -19,6 +20,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x40000
 CONFIG_SPL_PAD_TO=3D0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=3Dy
+CONFIG_SPL_POWER=3Dy
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
 CONFIG_TPL=3Dy
 CONFIG_CMD_BOOTZ=3Dy
@@ -35,6 +38,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_ROCKCHIP_GPIO=3Dy
 CONFIG_SYS_I2C_ROCKCHIP=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
+CONFIG_SPL_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_MMC_DW=3Dy
 CONFIG_MMC_DW_ROCKCHIP=3Dy
 CONFIG_MMC_SDHCI=3Dy
@@ -48,8 +52,11 @@ CONFIG_NVME_PCI=3Dy
 CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
 CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_SPL_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
 CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_SPL_REGULATOR_RK8XX=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_BAUDRATE=3D1500000
 CONFIG_DEBUG_UART_SHIFT=3D2
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb=
-rk3399_defconfig
index d24b7bc6d17..3b17623b3ae 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=3D0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE=3D"rk3399-nanopi-m4-2gb"
 CONFIG_DM_RESET=3Dy
 CONFIG_ROCKCHIP_RK3399=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_EVB_RK3399=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x800800
 CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
@@ -20,6 +21,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x40000
 CONFIG_SPL_PAD_TO=3D0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=3Dy
+CONFIG_SPL_POWER=3Dy
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
 CONFIG_TPL=3Dy
 CONFIG_CMD_BOOTZ=3Dy
@@ -39,6 +42,7 @@ CONFIG_AHCI_PCI=3Dy
 CONFIG_ROCKCHIP_GPIO=3Dy
 CONFIG_SYS_I2C_ROCKCHIP=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
+CONFIG_SPL_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_MMC_DW=3Dy
 CONFIG_MMC_DW_ROCKCHIP=3Dy
 CONFIG_MMC_SDHCI=3Dy
@@ -52,8 +56,11 @@ CONFIG_NVME_PCI=3Dy
 CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
 CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_SPL_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
 CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_SPL_REGULATOR_RK8XX=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_SCSI=3Dy
 CONFIG_BAUDRATE=3D1500000
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_=
defconfig
index da3e44af841..cfdb81577a2 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=3D0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-nanopi-m4"
 CONFIG_DM_RESET=3Dy
 CONFIG_ROCKCHIP_RK3399=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_EVB_RK3399=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x800800
 CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
@@ -20,6 +21,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x40000
 CONFIG_SPL_PAD_TO=3D0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=3Dy
+CONFIG_SPL_POWER=3Dy
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
 CONFIG_TPL=3Dy
 CONFIG_CMD_BOOTZ=3Dy
@@ -38,6 +41,7 @@ CONFIG_AHCI_PCI=3Dy
 CONFIG_ROCKCHIP_GPIO=3Dy
 CONFIG_SYS_I2C_ROCKCHIP=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
+CONFIG_SPL_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_MMC_DW=3Dy
 CONFIG_MMC_DW_ROCKCHIP=3Dy
 CONFIG_MMC_SDHCI=3Dy
@@ -51,8 +55,11 @@ CONFIG_NVME_PCI=3Dy
 CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
 CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_SPL_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
 CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_SPL_REGULATOR_RK8XX=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_SCSI=3Dy
 CONFIG_BAUDRATE=3D1500000
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk339=
9_defconfig
index 247056ab58b..802e6e54f46 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=3D0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-nanopi-m4b"
 CONFIG_DM_RESET=3Dy
 CONFIG_ROCKCHIP_RK3399=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_EVB_RK3399=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x800800
 CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
@@ -20,6 +21,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x40000
 CONFIG_SPL_PAD_TO=3D0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=3Dy
+CONFIG_SPL_POWER=3Dy
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
 CONFIG_TPL=3Dy
 CONFIG_CMD_BOOTZ=3Dy
@@ -38,6 +41,7 @@ CONFIG_AHCI_PCI=3Dy
 CONFIG_ROCKCHIP_GPIO=3Dy
 CONFIG_SYS_I2C_ROCKCHIP=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
+CONFIG_SPL_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_MMC_DW=3Dy
 CONFIG_MMC_DW_ROCKCHIP=3Dy
 CONFIG_MMC_SDHCI=3Dy
@@ -51,8 +55,11 @@ CONFIG_NVME_PCI=3Dy
 CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
 CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_SPL_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
 CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_SPL_REGULATOR_RK8XX=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_SCSI=3Dy
 CONFIG_BAUDRATE=3D1500000
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3=
399_defconfig
index 305877d2079..ac88466d3be 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=3D0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-nanopi-neo4"
 CONFIG_DM_RESET=3Dy
 CONFIG_ROCKCHIP_RK3399=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_EVB_RK3399=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x800800
 CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
@@ -18,6 +19,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x40000
 CONFIG_SPL_PAD_TO=3D0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=3Dy
+CONFIG_SPL_POWER=3Dy
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
 CONFIG_TPL=3Dy
 CONFIG_CMD_BOOTZ=3Dy
@@ -33,6 +36,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_ROCKCHIP_GPIO=3Dy
 CONFIG_SYS_I2C_ROCKCHIP=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
+CONFIG_SPL_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_MMC_DW=3Dy
 CONFIG_MMC_DW_ROCKCHIP=3Dy
 CONFIG_MMC_SDHCI=3Dy
@@ -45,8 +49,11 @@ CONFIG_GMAC_ROCKCHIP=3Dy
 CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
 CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_SPL_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
 CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_SPL_REGULATOR_RK8XX=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_BAUDRATE=3D1500000
 CONFIG_DEBUG_UART_SHIFT=3D2
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk339=
9_defconfig
index a6dafe3d9eb..905de05026f 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=3D0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-nanopi-r4s"
 CONFIG_DM_RESET=3Dy
 CONFIG_ROCKCHIP_RK3399=3Dy
+CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_TARGET_EVB_RK3399=3Dy
 CONFIG_SYS_LOAD_ADDR=3D0x800800
 CONFIG_DEBUG_UART_BASE=3D0xFF1A0000
@@ -18,6 +19,8 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
 CONFIG_SPL_MAX_SIZE=3D0x40000
 CONFIG_SPL_PAD_TO=3D0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=3Dy
+CONFIG_SPL_POWER=3Dy
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=3Dy
 CONFIG_TPL=3Dy
 CONFIG_CMD_BOOTZ=3Dy
@@ -33,6 +36,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_ROCKCHIP_GPIO=3Dy
 CONFIG_SYS_I2C_ROCKCHIP=3Dy
 CONFIG_ROCKCHIP_IODOMAIN=3Dy
+CONFIG_SPL_ROCKCHIP_IODOMAIN=3Dy
 CONFIG_MMC_DW=3Dy
 CONFIG_MMC_DW_ROCKCHIP=3Dy
 CONFIG_MMC_SDHCI=3Dy
@@ -45,8 +49,11 @@ CONFIG_GMAC_ROCKCHIP=3Dy
 CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
 CONFIG_PHY_ROCKCHIP_TYPEC=3Dy
 CONFIG_PMIC_RK8XX=3Dy
+CONFIG_SPL_PMIC_RK8XX=3Dy
+CONFIG_SPL_DM_REGULATOR=3Dy
 CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
 CONFIG_REGULATOR_RK8XX=3Dy
+CONFIG_SPL_REGULATOR_RK8XX=3Dy
 CONFIG_PWM_ROCKCHIP=3Dy
 CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
 CONFIG_BAUDRATE=3D1500000
--=20
2.45.3

