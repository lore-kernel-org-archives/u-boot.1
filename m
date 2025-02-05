Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81ABC02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6538880B98;
	Wed,  5 Feb 2025 18:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="QApQfieo";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="O+/1FgR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7872E807E0; Wed,  5 Feb 2025 18:19:04 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11D580836
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=QApQfieo/pMdlMGVN0Bfg8cRChZNCQNNpAl28+Lj1M3RInoAceyMWPgGhnWAX0S+QqLGj6Cd/TppUFhftuag0mY8PN079kwAeoDlcvYf5+T0u6L3k3TFa8L70KwWI+YbbWrU6/+vzqhEeThTr+0mxDjZFi0lQdfQa9SxuCdWOh4wU6MyTEYsgI1EwBOw9CtkXCzRADNlehsY8CMSdK+93EDpW1IDCoAjEo+AOffXXD3evwhU3iVdv1rh0l2mghxZLXmIcxSUnIoGNuEZxu659Gx0bPwxJW2Z/nYdwC1mwRHufaZa8+mwMLpM+3tAHOGvmH8DIL9rDA6grHQUGKs2PQ==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=4x0wpkOFxrxh5xGe2+FSaCTh4A+aIRvkBtKTeQwMqsU=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=O+/1FgR5npSHOUkJkpnS1Ngm/wFEv+zyGLMskmgd8Yne5Sq1w9mToLYY8d0tDrPBpOs2tthPPgxFNHcjswr+exxmSO0mIrCf0od19h331ul6SJpeVVrOEnbAnpPub2eOq92vnzA8xuFFAb6N9S0cRAgwRWcszTSrNMLbXPaxypduPi5I9dJ2qJ9+nZDLUguVrVK5uZLFIN28aT+IbABel1gBMOF42nbgR2M2cnew3LxupY+B9dpF3KV3uU7B5HdVto+OE4Vmaabz6S/zsnSi6cYk8PjFb79pWwyr3d7rcNqYYBkN/a/2VsIkjmY/Mvi97uyPZHZ214faiOTScBOWTA==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=4x0wpkOFxrxh5xGe2+FSaCTh4A+aIRvkBtKTeQwMqsU=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1817051443; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:18:45 +0000 (UTC)
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
Subject: [PATCH v3 5/5] rockchip: rk3399-nanopi-4: Enable IO-domain driver in
 SPL
Date: Wed,  5 Feb 2025 17:16:15 +0000
Message-ID: <20250205171634.826560-6-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250205171634.826560-1-justin@tidylabs.net>
References: <20250205171634.826560-1-justin@tidylabs.net>
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

(no changes since v2)

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

