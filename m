Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8671D3C92E
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 22:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78AA9891E7;
	Sun, 20 Oct 2024 00:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729375428;
	bh=BEKCFtycBvwBLNgLkheSmUdJQxfo9aRza6e/65QHb9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j05QrVCvxuhNVLn9wYm/U0hIoxlDhzhZxXm9qyla7LQ0RMpLzYza1DoQzazHVym5u
	 pDU3TmeNawRVYPstHw0JvRsBtNRAI7TBGoPbpjL9F3lhHwAKPASO0nWfT2rqLg6sNN
	 p+IKv4G9otwXjg/4ZD/ObjciY5ewYDsXdUQTbnVUZBL/LzP857T38GYiJWwfUQ2K4+
	 T81lfi7QlVqU4rApEFCHNgzxmrUUcUPiuV1RXlfzi4c1nkwKcsrLD1DN4AzJ0rJClV
	 vkq9iSv8Az0fDZnrctKeF6+SHIRerGpzLsneznS8H7kXjpigt516BjNnXGvCakza82
	 JW2p3Z4biqf+g==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 04B728903C;
 Sun, 20 Oct 2024 00:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729375425;
 bh=BEKCFtycBvwBLNgLkheSmUdJQxfo9aRza6e/65QHb9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eSxNFIU6kmABz3Hsb+BHDew4ugQx0iCJ1b593ThFMIxj1AoIFjDJMm2+GrPIDLH1z
 f9p3B/mP9CZ+37pZLOWyOBfvOGoRZNjuWgpDX2OVEO84PtKMDDehHRuwPALyBOoYuC
 AkxnqUMV8NsCuN0cdLbp/unYzxAuZIGSZtUALAd/792kbUoCItcvvPFhD6G+LjSQwu
 QmfF/rze8j4tnMZDHYyBbE7yOXMcmmWDQlXvRh8dDiy1PokeBAhZdU+Vpur3LujDEW
 CbUwonwdwo+nFo+yJXxS6Ac0y9CcGwL+iGiKl7BjJFFiiGWk0wLpMGB7DX/H1nGTx7
 6GKiSc42PDWJQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 3/5] arm64: imx: imx8mp: Disable PCA954x I2C mux on DH i.MX8MP
 DRC02 and PicoITX
Date: Sun, 20 Oct 2024 00:01:43 +0200
Message-ID: <20241019220322.341324-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019220322.341324-1-marex@denx.de>
References: <20241019220322.341324-1-marex@denx.de>
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

Neither the DRC02 nor PicoITX carrier board contains the PCA954x I2C mux
chip, the chip is only present on PDK3 carrier board. Disable support for
the PCA954x mux chip and I2C mux altogether on both i.MX8MP DHCOM DRC02 and
PicoITX.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/imx8mp_dhcom_drc02_defconfig   | 2 --
 configs/imx8mp_dhcom_picoitx_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/configs/imx8mp_dhcom_drc02_defconfig b/configs/imx8mp_dhcom_drc02_defconfig
index 366e5bbbb74..c6e3c1b9a8a 100644
--- a/configs/imx8mp_dhcom_drc02_defconfig
+++ b/configs/imx8mp_dhcom_drc02_defconfig
@@ -184,8 +184,6 @@ CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_MUX_PCA954x=y
 # CONFIG_INPUT is not set
 CONFIG_LED=y
 CONFIG_LED_BLINK=y
diff --git a/configs/imx8mp_dhcom_picoitx_defconfig b/configs/imx8mp_dhcom_picoitx_defconfig
index 7cefe9ae821..f4e9ba91bcf 100644
--- a/configs/imx8mp_dhcom_picoitx_defconfig
+++ b/configs/imx8mp_dhcom_picoitx_defconfig
@@ -184,8 +184,6 @@ CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_MUX_PCA954x=y
 # CONFIG_INPUT is not set
 CONFIG_LED=y
 CONFIG_LED_BLINK=y
-- 
2.45.2

