Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A5AC48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EB287C00;
	Wed, 31 Jan 2024 09:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qHBoKCuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77ABE879F0; Wed, 31 Jan 2024 09:46:05 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B47087B8F
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
 bh=pW507IJpdbfOaKxIs7bremqN9uX+tsRoDqdsVMZpV80=;
 b=qHBoKCuHRB9kQ+Q+Nyc+qAXEPhKmGnQ12J9SZhegsgCK9CzQoTh/GQ93ZGIwDviz
 8ml8nxA4VTJhVGkBzcYEzm6AYoYZTOygs7az5kPZbdrYVv/s3mPHvKKRWpRPmYQB
 l064U5h9lB3JuAXhfFb6a6Qf49EU9pCvrwQ8IL5g+qM=;
X-AuditID: ac14000a-fbefe7000000290d-a7-65ba08c92526
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1B.0E.10509.9C80AB56;
 Wed, 31 Jan 2024 09:46:01 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jan
 2024 09:46:01 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 31 Jan 2024 09:45:38 +0100
Subject: [PATCH v2 2/4] phycore-imx8mp: add USB host support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240131-usb_support-v2-2-7521c554b597@phytec.de>
References: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
In-Reply-To: <20240131-usb_support-v2-0-7521c554b597@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, NXP
 i.MX U-Boot Team <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706690760; l=1155;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=pW507IJpdbfOaKxIs7bremqN9uX+tsRoDqdsVMZpV80=;
 b=AGfmRzSvnIjNOSh4bltOrsVAgkXCCudILxN1ORkLxM/9Q37CdR98YGNSRgIz2RyyHQeF7ddQZ
 q2aLx2FiKsuCJdaJ8gt/2c6UqvXNdCPnPnlkgX1i6zEYRLcq3Db2hFo
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWyRpKBR/ckx65Ug5mzlSweXvW3aD/lYzF1
 0mZ2i7d7O9ktpjxez27R/U7dgc1j3qwTLB47Z91l93h1YBW7x9k7Oxg9+rtbWD02vtvBFMAW
 xWWTkpqTWZZapG+XwJUx9ccZ1oJWzorzEw+zNTC+Yu9i5OSQEDCRmPN5GUsXIxeHkMBiJonr
 U88wQjgPGSW2n+5nAaliE1CT2PXmNSuIzSKgKvHzzkk2EFtYwEbi/aT7YDW8AoISJ2c+AbI5
 OJgFNCXW79IHCTMLyEtsfzuHGaLETmL/+4lMICVCQPau+7EgYU4Be4nfXw6yg6wVEdjOKHFt
 8S9GiDFREu8mBoGYEgLCEpt2aoGUSAjsZpL4MGU+I0Q8UWLnazmQMUICshI3z29hg3hLXmLa
 udfMEHaoxJFNq5kmMIrMQnLnLIQ7ZyG5cwEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoKgR
 YeDawdg3x+MQIxMH4yFGCQ5mJRHelXI7U4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUS
 SE8sSc1OTS1ILYLJMnFwSjUwNuXFMRZdSUq8UvHCS9KZ79rbDRfyrn2ZeE3jq8fWvqLjznwW
 WZWzFmecCRAu8Xl9+KKEH7NRyN6QXPVZ3XX+V9PimloPPzSwnl34RG+SEd87n11TJ50Mu6wc
 +Wfn6tVHInUmTWzwU3Y9b1D/Mr7YKtUylkeG8bN5QX1qdB67hpTbcweRVk0lluKMREMt5qLi
 RAC3wZTeiAIAAA==
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

The phyBOARD Pollux has two USB ports. Add support for USB host and USB
storage for the USB1 port.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 519e0cfb3d..74450b957b 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -104,6 +105,7 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
@@ -120,4 +122,12 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_STORAGE=y
 CONFIG_IMX_WATCHDOG=y

-- 
2.34.1

