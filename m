Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5B8C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7144C87D99;
	Mon, 29 Jan 2024 13:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="E9Y9Jm5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D40D8078B; Mon, 29 Jan 2024 08:56:10 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E2F87CBC
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 08:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706514965; x=1709106965;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7S+M/N/BxFsrshrahpyf+sK2gLdYo+jpgmoSf2KI05Y=;
 b=E9Y9Jm5csOnNDzmYOL3mxdiliwuciAj/FqFlnI2tNKJHRYQy0egSHbup6knSch37
 4W1mK45lOL4zzJ9FgdQd/FkheLao3qLZ+lOXzjtKtd+TVPNv0L2CjXHooWXotQF6
 JBjVHztspxDotkXoCZPLzsmhok75Jx4Z4mr/o04KZZA=;
X-AuditID: ac14000a-fadff7000000290d-ce-65b75a155356
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F5.E1.10509.51A57B56;
 Mon, 29 Jan 2024 08:56:05 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 29 Jan
 2024 08:56:04 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 29 Jan 2024 08:55:52 +0100
Subject: [PATCH 2/3] phycore-imx8mp: add USB mass storage support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240129-usb_support-v1-2-8bd2fe84005b@phytec.de>
References: <20240129-usb_support-v1-0-8bd2fe84005b@phytec.de>
In-Reply-To: <20240129-usb_support-v1-0-8bd2fe84005b@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706514964; l=1877;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=7S+M/N/BxFsrshrahpyf+sK2gLdYo+jpgmoSf2KI05Y=;
 b=poWC5UDRZwfjexmaG9dibr5Opyv/VIMlWC4qgnGvfMC7z2+rRb3Wln1R3YP8YJmS4pKV0xEek
 NW1akzJfHrKBmcfIj7ZlSFUOK6Z+YUtHYrtgQnSdyRji1lAEZSHby1z
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWyRpKBR1c0anuqwZsV/BYPr/pbtJ/ysZg6
 aTO7xdu9newWUx6vZ3dg9Zg36wSLx85Zd9k9Xh1Yxe5x9s4ORo+N73YwBbBGcdmkpOZklqUW
 6dslcGV8/GFccJ2vYt6tJvYGxrU8XYycHBICJhIP91xh62Lk4hASWMwkce3mCXYI5yGjxItV
 z9hBqtgE1CR2vXnNCmKzCKhKrP/4mRHEFhZwlJizbwETiM0rIChxcuYTli5GDg5mAU2J9bv0
 QcLMAvIS29/OYYYosZNo7doPNkYIyD62bg8biM0pYC/xrOETC8heEYHtjBLXFv9ihJhjIzH9
 aACIKSEgLLFppxZIiYTAbiaJiYseMULEEyV2vpaDGCkrcfP8FjaIv+Qlpp17zQxhh0ps/bKd
 aQKjyCwkh85COHQWkkMXMDKvYhTKzUzOTi3KzNYryKgsSU3WS0ndxAiKEREGrh2MfXM8DjEy
 cTAeYpTgYFYS4f2puTVViDclsbIqtSg/vqg0J7X4EKM0B4uSOO/qjuBUIYH0xJLU7NTUgtQi
 mCwTB6dUA6P83CvdAtu/Z4odf+O9v7Cs05X9RIKO1qYVqwuX7dTu7n86z5vrmfCngxpLEu9k
 /j5zKaZgz5XNTDU8V9jn+dZNTBZbGPbm4+6iF/u577BM6qr8qvOlbWp4ia5Z4Hvr131qJddO
 dp8ILi2LEXrnLXV2yryplxZN+/c9Q0+I/XKnafBGxqbYBx+UWIozEg21mIuKEwEU1ofVfwIA
 AA==
X-Mailman-Approved-At: Mon, 29 Jan 2024 13:53:59 +0100
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

add support for USB mass storage to USB0 port of phyBOARD Pollux.

tested with "ums 0 mmc 2"

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 13 +++++++++++++
 configs/phycore-imx8mp_defconfig                    |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
index 5d6974f8fa..dcef4d4c2a 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
@@ -70,15 +70,28 @@
 	bootph-pre-ram;
 };
 
+&usb3_0 {
+	status = "okay";
+	dr_mode = "peripheral";
+};
+
 &usb3_1 {
 	status = "okay";
 	dr_mode = "host";
 };
 
+&usb_dwc3_0 {
+	status = "okay";
+};
+
 &usb_dwc3_1 {
 	status = "okay";
 };
 
+&usb3_phy0 {
+	status = "okay";
+};
+
 &usb3_phy1 {
 	status = "okay";
 };
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 74450b957b..e3fe4ed94e 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -123,6 +124,7 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
@@ -130,4 +132,9 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.34.1

