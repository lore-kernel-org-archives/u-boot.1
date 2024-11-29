Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4175D70E01
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 00:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C936389504;
	Fri, 29 Nov 2024 01:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732839264;
	bh=iaGGJkWwD8I2xdjBg0aNX3mxtehUM5qvqV9rUWxY/wg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JDbrsmAf4/45hAcC9sYZ9aNOPYFK40ZVW1kk15AkZaaUDt7gfx3ol9mW8GKvzEmfg
	 MnaoaPk5xRMUSuHFYmeO7zMQzJouk5zRnreNEpMh5YMZRFzBIXrbZRkbYCroUK/OqV
	 OizGoFwwnLgeFEg3YmN8b3JXWsxVmUQZ+rFWVoYLN4ci7AvBtu/EuGUyaJRnNfZXIW
	 yeUS9Y5s9MyzT/WVeODOBfFAL8HvaXS4GvQ/Wdthjw5+o0uh/Gicngg1+P578usAs8
	 SrFS6XWvhLRuIWxUwN5YdsSjbPHP0fEo9slhwlovVLyKip/tqw2G/3PoYhl9ckIvp4
	 upYW4IMTDzTFQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C250989430;
 Fri, 29 Nov 2024 01:14:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732839263;
 bh=iaGGJkWwD8I2xdjBg0aNX3mxtehUM5qvqV9rUWxY/wg=;
 h=From:To:Cc:Subject:Date:From;
 b=UAFJzv1zGlakiLCRfvBSSWtV4TtWR+q4P9ZFDfh78orjbN76URBs6SzVXp9Rw5rWK
 0fny7G9x5HUvXv14Yrwt+LhLe7vo7D3+JOYrcMGD7q/bnWJzIp1MR0omelnzlqa/38
 FkqaTbg15eylIp+XPGvqYfPbnrNvUPd6+xHwBpFey83EbWtZB9dKgCPDB4O7f3nno/
 tADvpebh0g5gsJmKgUFcByp5hby97dRJSTm3wxAcQb9UTsiu8+4pGXhKjqj5+6z+gh
 2Qg0ELGthkKLOd5oMunxHEqPOqCNRxlS50SNoxAGS7tK7Mp+Q5vjljghTutHR97CCY
 Qdei52ocea5SQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/4] ARM: dts: imx: Make DRAM coding GPIOs available before
 relocation on Data Modul i.MX8M Mini/Plus eDM SBC
Date: Fri, 29 Nov 2024 01:13:53 +0100
Message-ID: <20241129001409.218850-1-marex@denx.de>
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

The DRAM configuration GPIO straps must be accessible in SPL and before
relocation because the GPIOs are sampled both in U-Boot SPL as well as early
on in U-Boot proper. The already present bootph-pre-ram DT property made the
GPIO controllers available in SPL, but not early on in U-Boot proper, which
made gpio_request_list_by_name_nodev() in board dmo_get_memcfg() fail. Add
missing bootph-some-ram DT property to all GPIO controllers which are
referenced in dmo,ram-coding-gpios DT property to make those GPIO
controllers available early in U-Boot proper as well.

Fixes: 8c103c33fb14 ("dm: dts: Convert driver model tags to use new schema")
Signed-off-by: Marek Vasut <marex@denx.de>
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
NOTE: For v2025.01
---
V2: Switch from bootph-all which covers TPL as well to bootph-some-ram
    which covers only U-Boot pre-reloc phase
---
 arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi | 1 +
 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
index a235e088fa4..fb6951026d9 100644
--- a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
@@ -77,6 +77,7 @@
 
 &gpio2 {
 	bootph-pre-ram;
+	bootph-some-ram;
 
 	dsi-reset-hog {
 		bootph-pre-ram;
diff --git a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
index 805b5f57955..1e82e718b8f 100644
--- a/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi
@@ -64,6 +64,7 @@
 
 &gpio3 {
 	bootph-pre-ram;
+	bootph-some-ram;
 
 	bl-enable-hog {
 		bootph-pre-ram;
@@ -92,6 +93,7 @@
 
 &gpio4 {
 	bootph-pre-ram;
+	bootph-some-ram;
 
 	dsi-reset-hog {
 		bootph-pre-ram;
-- 
2.45.2

