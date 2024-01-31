Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AF5C48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA3887C13;
	Wed, 31 Jan 2024 09:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gWimMaBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1247987BA1; Wed, 31 Jan 2024 09:46:06 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE73087BDA
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1706690761; x=1709282761;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pC2aqOGQjcXUBUu0U2ik6UHuCXn2Fs0fhyVtRc9Y4JA=;
 b=gWimMaBvfR+qX+uB1rCBAEjqb9wQECTLaoEDgnnh++1dCFDqLEK21HVORyn08RNu
 rQkEdX/wvrb2QBixEcQI9odDcmU+LwRxOtR8K2aZO817dAk1z6CWeXK3wP2D1AT8
 bEFJf4cR/ulemwLnG5Ej5KyhsK8P9XLdaI8euEur59U=;
X-AuditID: ac14000a-fadff7000000290d-ac-65ba08c9baa1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CB.0E.10509.9C80AB56;
 Wed, 31 Jan 2024 09:46:01 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jan
 2024 09:46:01 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 31 Jan 2024 09:45:39 +0100
Subject: [PATCH v2 3/4] phycore-imx8mp: add USB mass storage support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-usb_support-v2-3-7521c554b597@phytec.de>
References: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
In-Reply-To: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706690760; l=1653;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=pC2aqOGQjcXUBUu0U2ik6UHuCXn2Fs0fhyVtRc9Y4JA=;
 b=B9pvWiBDYk4h0boRpn6sYAzLK/gOnLb6pziV3e7jHI8WDZ01BpTL5OyyAPkyIac4DD2ijTLZD
 nh8dgwpddfkCqdxow/htdg9PG5SVcIMUrZF4R6bV3e4bhd1GKGGU4sE
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWyRpKBR/ckx65Ug4tT9C0eXvW3aD/lYzF1
 0mZ2i7d7O9ktpjxez27R/U7dgc1j3qwTLB47Z91l93h1YBW7x9k7Oxg9+rtbWD02vtvBFMAW
 xWWTkpqTWZZapG+XwJVxqaOZveA7T8XTxasYGxgnc3cxcnBICJhITNri2sXIxSEksJhJ4uKP
 NnYI5yGjxPbT/SxdjJwcbAJqErvevGYFsVkEVCU+zjrLDGILC7hI/N97BszmFRCUODnzCQvI
 UGYBTYn1u/RBwswC8hLb386BKrGTOH73OBtIiRCQvet+LEiYU8Be4veXg2BrRQS2M0pcW/yL
 EWJMlMS7iUEQZwpLbNqpBVIuIbCbSWJyRwxEOFFi52s5kLCQgKzEzfNb2CBK5CWmnXvNDGGH
 ShzZtJppAqPILCRnzkI4cxaSMxcwMq9iFMrNTM5OLcrM1ivIqCxJTdZLSd3ECIoYEQauHYx9
 czwOMTJxMB5ilOBgVhLhXSm3M1WINyWxsiq1KD++qDQntfgQozQHi5I47+qO4FQhgfTEktTs
 1NSC1CKYLBMHp1QDI4vj9pvnP27Y0PypxuenlNLflXXC5tEVTm/Xnmz+4+W20app1p33njYf
 FDY+Xsbp19is/igu7S3DHas9GiyxEx/NvhZyVb5myf+ymZzchRPdi430ElO3POatunXsJv96
 jhn2TmyXP877UqH+tJFf8qsbV+vbo7MWx7f9e7BPwldytob5genlfEosxRmJhlrMRcWJALLQ
 BxaGAgAA
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

