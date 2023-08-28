Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD047C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9734C86481;
	Mon, 28 Aug 2023 23:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550BA8647F; Mon, 28 Aug 2023 23:38:18 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C8186481
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([84.226.64.168]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N8Won-1pfUT93Su9-014Pbx; Mon, 28 Aug 2023 23:38:07 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1] board: toradex: verdin-imx8mp: enable usb device and
 fastboot support
Date: Mon, 28 Aug 2023 23:38:02 +0200
Message-Id: <20230828213803.454303-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OXhhtmv1PS/DhdckW9Q1FFct1xpc5ghk0hAZpbWultDO2ggx6Ip
 ttnVPM5rvOP72OaquRIHGTfMrLqWFOURy4Ja7Ns6FVdFnfBjaggBDUUsOZRM99T3S511FdB
 /5bGJ2TBptaigKJGtlQAtK5ejNX3Qsi9yuA/3/X9xjHW0c1wRehZESCXVJ9ASZOn8mPSVc5
 WeIe3WUTYU3a52F4grAEw==
UI-OutboundReport: notjunk:1;M01:P0:9Ssy278VjDM=;0rU1bK58LtUyStpEJjWJkmmWSWy
 1gap0WQy6sOLQZbn3HO8CC/afyG4BSuxOsvaXl38DwNQMexWXBJhRYhuMmmrfA80mfbL2C4z3
 wPDRDnLQKLJvVSMpC3Y0dlCJ33CsaglY94zrE8LXv57WnbDyK6Vekyg3M1RcuaetMzjlPh6Ln
 I7NNx0Uzx/lfXpgBliXO3C8ryo+pu+Zbmk140TuDixN36buJjJP829yBKzH9EjngIQLhTzwWj
 8Dm2ovz0oCmzq/OOUM8ywYUS3pErKlJl4Zzx8kJ3KKxPOweU+V0i55GEgDP/cOGr32XWg3yQd
 +ZwoDno7jOL1+ryD4GScZStl1hf30vi14FpRBi9t5QW3d+HikYX6Z7hBAt36uyVLs0V45MrJ7
 5T9MmGc5OPq2WxLiDmMz9YlLHqfGi0LqWEPTfELq2ZVZMlLWndtLWB7l/pHc/L2+Co4kfZL3I
 Xb9YfcUWW35dlOY9MQ3g54ZmH94/wRvIX7LMrjIoiRhzsCqGkBm/QH+FtxFaOCGyxjD2aBq1g
 SaireE1p3Yu6DLMMbPvtwA2u8hbn7K0yr9PNG2OSAtpTc1q+2QYNVNuuTrsn1v5aOaG9JhT8z
 WvGJioGApcNhPR0hE3SJdFz7bK4cjfjmdubegM/2KwLd/5Wzp9aYT9TLI3Yk8UyaJRQ21ze4h
 cItrgnnCW80g+4THgI19j7YafbYrRi/dyVQjXL2SOu8zl14iD2oHk9LnpuOggQgGY9/mO3u5i
 IwyEd9wWSGksuTF6bJHjweFZsyWpERan87Hp7e7wSTr/Zkb/fsUP/SQMnBCGkrrWH6MjbjfO9
 HsRUgIJzyUzBjZYsiSZfq437gN3O+a4q+xqz6h4cux54NIUCTn84bZRxthoYL6zJRu3IC2t3d
 MniYWAgxQbz1Usw==
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable USB device and fastboot support which may be used to load the
Toradex Easy Installer FIT image.

While at it also enable USB mass storage aka UMS support.

Note that the i.MX 8M Plus recovery mode support is based on the USB
boot stage of the BOOTROM and does NOT require USB SDP SPL aka serial
downloader support.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 configs/verdin-imx8mp_defconfig | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 2df0f4f3443..4c6650c3453 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -79,6 +79,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_READ=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
@@ -108,6 +109,12 @@ CONFIG_BOOTCOUNT_ENV=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_FSL_CAAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x40000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
@@ -138,6 +145,7 @@ CONFIG_DWC_ETH_QOS_IMX=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_PHY=y
 CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
@@ -160,14 +168,20 @@ CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
 CONFIG_USB=y
+# CONFIG_SPL_DM_USB is not set
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_MXC_USB_OTG_HACTIVE=y
+# CONFIG_USB_EHCI_MX7 is not set
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
 CONFIG_IMX_WATCHDOG=y
 CONFIG_HEXDUMP=y
-- 
2.36.1

