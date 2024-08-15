Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C1C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 08:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8604888A37;
	Thu, 15 Aug 2024 10:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723711522;
	bh=SLTpSUCzGQ+nHiUszSqYZHLQl0HUKc7yxs1KnQmw534=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GI2dlRVHTpAxmZuTe1Dh1QqPDaOQTna/sOkui8LWpfV+9xNJ4DOzsnyHhRbU/RKgU
	 wz7FnYM1Ny5wPNQIiRnodJDzI3raiDnnknvmhDjtVHJaYsS0ZJUpGbSKaRk3FEonEO
	 TeYfEAMZwEbjpSqLBeTNEuL8456IerqlcbaxEZYvo8G/LgLlw4PXHqvEkQ6PlfttTy
	 Aqj9G/RHZuPkDP9eIKYKc2Ov2m0DO/HP4E+Mwd2vgMCzNAJgKe8hEOTgsJyu6DoM4J
	 Ww5FHYRhv9/GRCfydn3jiABm79oDWmD0sqj/zra/ckKof7MMY8arBydgrBuECD9LFX
	 M2tzOqeNfVayA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DC79C889C9;
 Thu, 15 Aug 2024 10:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723711521;
 bh=SLTpSUCzGQ+nHiUszSqYZHLQl0HUKc7yxs1KnQmw534=;
 h=From:To:Cc:Subject:Date:From;
 b=guCutt8zFuOBK/QHyeEgnwohDJRgvBrZATcFGkyLvmCXR5IyB91yWcRaULJFOiwo1
 qi7NfuEeIH+lFKI/5XLNY76YZ1UgWUF6HozU4mnxeo3l+CCxzN+2FUkzuf/BzSWu8V
 Pd2ZzCVHDtupgisM0OKXFCVhIdn7Cv7SHUiQg8du1HjAwDJwkBxa2vO3XKbCX8DFKr
 3ljlAUP1cqR4O9lONxSu+cYaMdiSedqmk88UtNPsrPa/jvKVxC3h7iLtAIx/d9dFve
 ZhlO3CeXm0vv6+K3JVB0lQ5rOFfl/e1CH6negHc42s8m08Drn04MhHT3rdm/y1ZxmJ
 9vEyFmxPq7tww==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Cem Tenruh <c.tenruh@phytec.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] config: imx: Add support for Phytec's phycore imx8mm running
 SDP gadget
Date: Thu, 15 Aug 2024 10:45:04 +0200
Message-Id: <20240815084504.479112-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

After this change it would be possible to boot SDP gadget when Phytec's
Phycore imx8mm module has USB ROM boot selected.

With this change it shall be possible to flash eMMC/SD card content with
uuu program.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 configs/phycore-imx8mm_defconfig | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 6748e6fafb..beb2f1e9f0 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -25,6 +25,7 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3E0000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_PCI=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -57,6 +58,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_SIZE=4096
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+# CONFIG_CMD_BIND is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
@@ -86,6 +88,10 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_MISC=y
@@ -116,7 +122,6 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_IMX=y
-CONFIG_PHY=y
 CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
@@ -136,4 +141,15 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_MXC_USB_OTG_HACTIVE=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x40400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
-- 
2.39.2

