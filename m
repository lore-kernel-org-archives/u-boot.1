Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE1CD70E01
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 00:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C288935C;
	Fri, 29 Nov 2024 01:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732839428;
	bh=d2XvrIjLJnWCIr/IbV4ncyiJZpC7RsECuGJBndwb6k0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m8KMv053lnlZkjaP9EWu9QV+HFOQ+1fl32V3Fi4c1BadOdw8XCXKhfirvSgoBLyhu
	 TZmvY79grdDeDIo8Sjd+czhNGbUfBFW0wYG33rxGLNQLEkz41JWNODWsV12+ZfmBps
	 VpHJ0fADVhtCplWWqpZXD5WPrZbEvH+3HTBhhgZjEEM4wr/IkW71Hdqunyg4cgn03A
	 juAg5704FedMdPlIeQR4Hqu/EH0eULFHA6QHz7uKCuLItSmV17jhgut/Kr1yDqQRhi
	 VyMIIa4cWcevEMFbE6Rh91gTAtkh79x/p4NSfs2jyqs03ExwqE9YbRWQW73ntQ1zmB
	 s0A2ZTgi4+cNg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 491D789430;
 Fri, 29 Nov 2024 01:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732839426;
 bh=d2XvrIjLJnWCIr/IbV4ncyiJZpC7RsECuGJBndwb6k0=;
 h=From:To:Cc:Subject:Date:From;
 b=tNaa6/BTZX9uvAJJ9fHBxH0KtBja9dVhHA79AiV53h3smFKkTUT4mwYo6pHDoOoAo
 gkbr01Evfrywl98IALsputwuJIT6wPOIZ6eBggAfLEWi1+jeLFdI02qhU0aQsvj8ce
 JmVPlm0i9j+UmhNW1cE0wvBZwyT52Ujm9MZ0zBiw+jHMWuSRAn8+d/j9HtFMWypZtk
 isrxJxzgIyRos4lIzZd1QHNao4sIwgy2xKayq9KJkuEjmr7hJNj+RawBpQR7S3TTsw
 qYb140GNiWIBLn7MQp/j3FqcibxUPWhNIp+7XPmJhwtQ6xmeUP5MJ2OZt62kbUJDs1
 mBcaKJJJ6a6tw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: imx: Replace YModem with SDP on Data Modul i.MX8M Mini
 eDM SBC SPL
Date: Fri, 29 Nov 2024 01:16:33 +0100
Message-ID: <20241129001657.219101-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

The YModem support in SPL was never really used on this device,
the SDP support is much more convenient on i.MX8M Mini based
hardware. Replace the YModem support with SDP support.

The SDP can be utilized by forcing the board into SDP boot mode
by grounding test point right next to silkscreen label U30, and
then by using mfgtools 'uuu -brun spl flash.bin' once the device
enumerates on host system USB bus. The SDP capable USB port is
available on the USB micro-B port on the base board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: Would be nice to have in v2025.01
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi | 9 +++++++++
 board/data_modul/imx8mm_edm_sbc/spl.c              | 6 ++++--
 configs/imx8mm_data_modul_edm_sbc_defconfig        | 6 ++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
index fb6951026d9..f5e98bf7487 100644
--- a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
@@ -145,8 +145,17 @@
 	bootph-pre-ram;
 };
 
+&usbmisc1 {
+	bootph-pre-ram;
+};
+
+&usbphynop1 {
+	bootph-pre-ram;
+};
+
 &usbotg1 {
 	dr_mode = "peripheral";
+	bootph-pre-ram;
 };
 
 &usdhc2 {
diff --git a/board/data_modul/imx8mm_edm_sbc/spl.c b/board/data_modul/imx8mm_edm_sbc/spl.c
index 17aafd719c9..a9ef049652a 100644
--- a/board/data_modul/imx8mm_edm_sbc/spl.c
+++ b/board/data_modul/imx8mm_edm_sbc/spl.c
@@ -61,8 +61,10 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	if (boot_dev_spl == MMC3_BOOT)
 		return BOOT_DEVICE_MMC2;	/* eMMC */
-	else
+	else if (boot_dev_spl == MMC2_BOOT)
 		return BOOT_DEVICE_MMC1;	/* SD */
+	else
+		return BOOT_DEVICE_BOARD;
 }
 
 void board_boot_order(u32 *spl_boot_list)
@@ -76,7 +78,7 @@ void board_boot_order(u32 *spl_boot_list)
 	else
 		spl_boot_list[1] = BOOT_DEVICE_MMC1;	/* SD */
 
-	spl_boot_list[2] = BOOT_DEVICE_UART;	/* YModem */
+	spl_boot_list[2] = BOOT_DEVICE_BOARD;	/* SDP */
 	spl_boot_list[3] = BOOT_DEVICE_NONE;
 }
 
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index 7c9d4ee1844..260cdd4a5e3 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -12,17 +12,23 @@ CONFIG_DM_REGULATOR_BD71837=y
 CONFIG_IMX_CONFIG="board/data_modul/imx8mm_edm_sbc/imximage.cfg"
 CONFIG_PHYLIB=y
 CONFIG_PREBOOT="run dmo_preboot"
+CONFIG_SDP_LOADADDR=0x60000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL_BSS_START_ADDR=0x910000
+CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SPL_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_REGULATOR_BD71837=y
+CONFIG_SPL_DM_USB=y
 CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_STACK=0x920000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_TEXT_BASE=0x7E1000
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
-- 
2.45.2

