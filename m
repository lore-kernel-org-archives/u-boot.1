Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0BFC4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E3987E51;
	Thu,  8 Feb 2024 13:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fqx+4V/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49FA187E37; Thu,  8 Feb 2024 13:03:26 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91E387E4C
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1707393800; x=1709985800;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pC2aqOGQjcXUBUu0U2ik6UHuCXn2Fs0fhyVtRc9Y4JA=;
 b=fqx+4V/frjE/suamCn7Zv+4wTQ2CKTl+dePo/zaPLxISwV8HwlNfkNmAOvHHrFdN
 O/EgNyJJ0Mm5aDavr5dq3pdObTqVnhIpG41Xl5iF0Iw5DeCnZEqq64jLEJ+jgQSN
 Q1BLkT4b9dhk6L/sA5Xo0LqWaBkPUZiqHiejXxC/Okw=;
X-AuditID: ac14000a-fadff7000000290d-7d-65c4c308520a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2F.80.10509.803C4C56;
 Thu,  8 Feb 2024 13:03:20 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Feb 2024
 13:03:20 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Thu, 8 Feb 2024 13:03:10 +0100
Subject: [PATCH v3 3/4] phycore-imx8mp: add USB mass storage support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240208-usb_support-v3-3-e605efd50512@phytec.de>
References: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
In-Reply-To: <20240208-usb_support-v3-0-e605efd50512@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Dan Carpenter
 <dan.carpenter@linaro.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707393799; l=1653;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=pC2aqOGQjcXUBUu0U2ik6UHuCXn2Fs0fhyVtRc9Y4JA=;
 b=FOxdW8d9iR2zExNcolL8ChU/kaN4mP2CkgfZjxVIedzevCcpRFRY68GdtO3/SfJkk8G3yF5Ya
 jjf5ynhRcehBUFi/LkBWwGm1fpglcvhK1VinYi3iy/Ad1N+/tmHCYSB
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42JZI8nAo8tx+EiqwY+3shYf5rWyWzy86m/R
 fsrHYuqkzewWb/d2sltMebye3aL7nboDu8e8WSdYPHbOusvu8erAKnaPO9f2sHmcvbOD0aO/
 u4XVY+O7HUwB7FFcNimpOZllqUX6dglcGZc6mtkLvvNUPF28irGBcTJ3FyMnh4SAicTCR1uZ
 uhi5OIQEFjNJPJ/2iBnCecAoMeXBLRaQKjYBNYldb16zgtgsAioS5x+0gMWFBVwkbr/8xwRi
 8woISpyc+QQozsHBLKApsX6XPkiYWUBeYvvbOcwQJXYSG6c+B2sVArKXNewEszkF7CX2HHnJ
 BrJXRGA7o8S1xb8YQRxmgRZGiUn/uxhBhkoICEts2qkFEpcQ2M0k0b9yNitEPFFi52s5iKGy
 EjfPb2GD+ExeYtq518wQdqjE1i/bmSYwisxCcuoshFNnITl1ASPzKkah3Mzk7NSizGy9gozK
 ktRkvZTUTYygeBJh4NrB2DfH4xAjEwfjIUYJDmYlEd6QJUdShXhTEiurUovy44tKc1KLDzFK
 c7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTB6r3tV8u0Ww6F3vbVzzy45+FLPpugG++e1
 a5Y66rbOe5bGbVywv5f7ac+jCRv02gNXa609ozPt667A3b9Wrj0ZJi/2ZumPONa1Ds0LT2e+
 PH24193/vGXt/WSF+u1bF4ovMBWfeFbTx+WC0DWDCeE+C51Dkk99f/F/19W82UpWZ9jqel43
 a/pqKbEUZyQaajEXFScCAEQpYWmVAgAA
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
 arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi | 4 ++++
 configs/phycore-imx8mp_defconfig                    | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
index 1c7b250549..b4efff27a7 100644
--- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
@@ -70,6 +70,10 @@
 	bootph-pre-ram;
 };
 
+&usb_dwc3_0 {
+	dr_mode = "peripheral";
+};
+
 &usdhc2 {
 	bootph-pre-ram;
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

