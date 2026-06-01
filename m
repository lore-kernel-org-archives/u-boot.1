Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6818CCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEAE848EE;
	Mon,  1 Jun 2026 14:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="ZhLfLdf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6482846D3; Mon,  1 Jun 2026 10:04:37 +0200 (CEST)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch
 [79.135.106.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE8DF846F8
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301074; x=1780560274;
 bh=sYia5TxFQI8Qx7SZaoXGdf5CIVug++xEBJsYo0MEeBc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ZhLfLdf4XSskVxTPNikuh51dx06X48pouU8zEmlNbup51eaztQp8NykDPHZXIdWlU
 wAPrFqI/dr5xqjPzoVzr0UJLpfYbajlo/BJ8+8gxtiCR+hJwa6ykneLsxAWzEGimcs
 TnSRAXB3PH5SuHXaCO6mL9Wg6OpT1qrr4zIgs3RfurWXdmNVb9pA5xzrsugbOsZd90
 kulcvBp97NOhrkukgoM4OHLFth9N7OHshJEKPngz+GF0qEnAQvxQjizMIZ79zFTTMR
 dJk4i6+bRFU046dOvhKzd5zIo8ifVqx5abWov+zWOraSjIjaFvwGsxzyi3IOsejb+9
 8DMFbhGJSIQFw==
Date: Mon, 01 Jun 2026 08:04:30 +0000
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
Subject: [PATCH 07/16] configs: introduce qcom_armv7_defconfig
Message-ID: <20260601-qcom-armv7-v1-7-c4b7f7aae1eb@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
References: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: b935c6590a1897e5baf2b3fed3e023b73ad8b229
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

This new config aims to be analogous to qcom_defconfig, but for armv7
devices. It can compose with qcom-phone.config.

Signed-off-by: Sam Day <me@samcday.com>
---
 configs/qcom_armv7_defconfig | 59 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 59 insertions(+)

diff --git a/configs/qcom_armv7_defconfig b/configs/qcom_armv7_defconfig
new file mode 100644
index 00000000000..7d64ee68ecd
--- /dev/null
+++ b/configs/qcom_armv7_defconfig
@@ -0,0 +1,59 @@
+CONFIG_ARM=3Dy
+CONFIG_SKIP_LOWLEVEL_INIT=3Dy
+CONFIG_SYS_ICACHE_OFF=3Dy
+CONFIG_SYS_DCACHE_OFF=3Dy
+CONFIG_ARCH_SNAPDRAGON=3Dy
+CONFIG_TEXT_BASE=3D0x80208000
+CONFIG_NR_DRAM_BANKS=3D24
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x88FE0000
+CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/qcom-msm8960-cdp"
+CONFIG_SYS_LOAD_ADDR=3D0x82000000
+CONFIG_ARCH_SNAPDRAGON_ARM32=3Dy
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=3Dy
+CONFIG_EFI_CAPSULE_ON_DISK=3Dy
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_BOOTSTD_FULL=3Dy
+CONFIG_BOOTDELAY=3D1
+CONFIG_SYS_CBSIZE=3D512
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
+CONFIG_CMD_BOOTMENU=3Dy
+CONFIG_CMD_MEMINFO=3Dy
+CONFIG_CMD_MEMINFO_MAP=3Dy
+# CONFIG_CMD_BIND is not set
+CONFIG_CMD_CLK=3Dy
+CONFIG_CMD_GPIO=3Dy
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_USB_MASS_STORAGE=3Dy
+CONFIG_CMD_CAT=3Dy
+CONFIG_CMD_BMP=3Dy
+CONFIG_CMD_LOG=3Dy
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=3Dy
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=3Dy
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE=3D"board/qualcomm/default.env"
+CONFIG_CLK=3Dy
+CONFIG_USB_FUNCTION_FASTBOOT=3Dy
+CONFIG_FASTBOOT_BUF_ADDR=3D0x0
+CONFIG_FASTBOOT_FLASH=3Dy
+CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=3Dy
+CONFIG_MSM_GPIO=3Dy
+CONFIG_DM_KEYBOARD=3Dy
+CONFIG_BUTTON_KEYBOARD=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_MSM_SERIAL=3Dy
+CONFIG_SYSRESET_QCOM_PSHOLD=3Dy
+CONFIG_TIMER=3Dy
+CONFIG_QCOM_KPSS_TIMER=3Dy
+CONFIG_USB=3Dy
+# CONFIG_DM_USB_GADGET is not set
+CONFIG_USB_EHCI_HCD=3Dy
+CONFIG_USB_EHCI_MSM=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_CI_UDC=3Dy
+CONFIG_VIDEO=3Dy
+CONFIG_SYS_WHITE_ON_BLACK=3Dy
+CONFIG_NO_FB_CLEAR=3Dy
+CONFIG_VIDEO_SIMPLE=3Dy

--=20
2.54.0


