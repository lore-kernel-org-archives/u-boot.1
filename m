Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF84C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 07:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1307D882F5;
	Fri,  3 May 2024 09:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bvlq9r5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B165488321; Fri,  3 May 2024 09:01:05 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A404D882D7
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 09:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1714719661; x=1717311661;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+MWbtwr4iCWQj9NSATDgG45osxI+e/JsmI6YdSteP0o=;
 b=bvlq9r5y5vwS563st7PbZG8FMeH0cdfcFwcZObrQrpmu3XfQEMgKjXLmGHAELAXD
 bM2wxIMIENdzhugiosnWjy7Pw1X4SUf6qfEUxgGlfV31megpAvSiTb5Q9QseYwos
 bOeidNW8pXNSoxZBI/GPyaELVYF+hgUGH7/2vAm4LmM=;
X-AuditID: ac14000a-fbefe7000000290d-60-66348badf45e
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 65.2B.10509.DAB84366;
 Fri,  3 May 2024 09:01:01 +0200 (CEST)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 3 May 2024
 09:01:00 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Fri, 3 May 2024 09:00:38 +0200
Subject: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over all
 PHYTEC boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
X-B4-Tracking: v=1; b=H4sIAJWLNGYC/x3MPQqAMAxA4atIZgOtf6hXEYemRpvBWlpQQby7x
 fEb3nsgcRROMBYPRD4lyeEzdFmAdcZvjLJkQ6WqRrWqxksCkjPOI6Ug+93vWOuhQ6uZFkWGOmM
 h1yHyKvd/nub3/QDT1xomaQAAAA==
To: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>, Tom
 Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>, Martyn Welch
 <martyn.welch@collabora.com>, Parthiban Nallathambi <parthitce@gmail.com>,
 Fabio Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714719660; l=3128;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=+MWbtwr4iCWQj9NSATDgG45osxI+e/JsmI6YdSteP0o=;
 b=soMTc8dHB63gloWvmvj+jyCzt7eofA1Ftx9k1r6Xu/iFscGjncxKHy2osimRxftU8XfbRS2cB
 kXgy08k5xbNBQilayU5LlRU8H1KsxcjosngbRlwRX0tJ7a8VpJeUmmD
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWyRpKBR3dtt0mawcZDHBYPr/pbPLjYxWJx
 Zu0pFoupkzazW7zd28lu0f1O3YHNY8fdJYweO2fdZfd4dWAVu8fZOzsYPfq7W1gDWKO4bFJS
 czLLUov07RK4MhqXrWEt2CVR8bfZo4GxWayLkZNDQsBE4vq35+xdjFwcQgJLmCQmPzkM5Txg
 lOj6uIAFpIpNQE1i15vXrF2MHBwsAioS335zgoSFBaIkvu14DFbCKyAocXLmExaQEmYBTYn1
 u/RBwswC8hLb385hBgnzCnhJzJvMBjJdQmAHo8TeN8eZQRwRgS4miXPTrzJC9EZJvJsYBGJK
 CAhLbNqpBVG/m0ni+ofDbBDxRImdr+VAxgsJyErcPL+FDeIVeYlp514zQ9ihElu/bGeawCg8
 C8lxsxCOm4XkuAWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgmJChIFrB2PfHI9DjEwcjIcY
 JTiYlUR4tScbpwnxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLg
 lGpg3PnVen7y9v5QbW/ZJfNt7Wv4n2u+nixzcHaa0CTjdzdNPJv/lwpW2i1lqW96WPgnQXAq
 u8KW7ozDrbHWX5c38TxoWnRvrez3c+85yy8UpFqqWe1X+bbTvObkHU/588WrA/Y75d3lkdaW
 mHNktvbiY61rgiP43x2x2FDp/PaC4Am53M8P75wNU2Ipzkg01GIuKk4EACwFqfR3AgAA
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

Set CONFIG_USB_GADGET_MANUFACTURER to PHYTEC for all PHYTEC boards.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 configs/phycore-imx8mp_defconfig     | 2 +-
 configs/phycore_am64x_a53_defconfig  | 2 +-
 configs/phycore_am64x_r5_defconfig   | 2 +-
 configs/phycore_pcl063_defconfig     | 2 +-
 configs/phycore_pcl063_ull_defconfig | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index e9a287cb441f..9f42edd72324 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -147,7 +147,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 1a9359773b45..9b52f8ad0644 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -159,7 +159,7 @@ CONFIG_USB_CDNS3=y
 CONFIG_USB_CDNS3_GADGET=y
 CONFIG_USB_CDNS3_HOST=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index 61d784fa17f6..15a7e7089e73 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -171,7 +171,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_SPL_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
index 017054a8e12b..2f6b158a6772 100644
--- a/configs/phycore_pcl063_defconfig
+++ b/configs/phycore_pcl063_defconfig
@@ -62,7 +62,7 @@ CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Phytec"
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
 CONFIG_CI_UDC=y
diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl063_ull_defconfig
index b3da43a5bf1e..b42a410da69c 100644
--- a/configs/phycore_pcl063_ull_defconfig
+++ b/configs/phycore_pcl063_ull_defconfig
@@ -53,7 +53,7 @@ CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Phytec"
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
 CONFIG_CI_UDC=y

---
base-commit: 6fdb021f148f598a67eb3cac5e3eb4a569cdaacd
change-id: 20240503-wip-bhahn-bspimx8m-3196-c1ebd0bab6ac

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

