Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF26CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 16:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C7482E34;
	Mon, 20 Oct 2025 18:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OP0XAgUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 197A4831D5; Mon, 20 Oct 2025 18:19:40 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C716382C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C8D6453E0;
 Mon, 20 Oct 2025 16:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D4BC4CEF9;
 Mon, 20 Oct 2025 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760977176;
 bh=aeeDFGLWPJ7EWcZSj8ULbTvOdW481jI3sZtHv7NB6zo=;
 h=From:To:Cc:Subject:Date:From;
 b=OP0XAgUNJ/PUsj9iGgWCAcxXlgnTFNODpC94Ao6MOrgt7BDnxG26rDvVgKvxSEeL0
 GRO3Ln9VkxZ78l+J+IQV1c0li+QCHm5ltTKMFapanN78imYp1sI8AtdJhBqrlpKyc+
 nzM3ngLnZ1+wRIuPkbuDh1dPZ+LNZBfuR+SAseOsG7pLLIfHLHImG9c8jxxVgr3vrh
 /Gq5k0BmFhIMR1RfHPKE7/K0hTXl9ey+HkddzeBhfvVRYz5EHmCyO1LV2yEF3jZCRe
 p+HAwvEwM4XFt5w7WGjQsyGJ9SkeWJFLMAvjF1zii3AezlBuyZKhRtIdVG2A12xbjz
 5MG5aGYwn71mA==
Received: by wens.tw (Postfix, from userid 1000)
 id 64A745FDC3; Tue, 21 Oct 2025 00:19:33 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: a523: Add OrangePi 4A defconfig
Date: Tue, 21 Oct 2025 00:19:30 +0800
Message-ID: <20251020161930.2761929-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
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

The OrangePi 4A is a typical Raspberry Pi model B sized development
board from Xunlong designed around an Allwinner T527 SoC.

The board has the following features:
- Allwinner T527 SoC
- AXP717B + AXP323 PMICs
- Up to 4GB LPDDR4 DRAM
- micro SD slot
- optional eMMC module
- M.2 slot for PCIe 2.0 x1
- 16 MB SPI-NOR flash
- 4x USB 2.0 type-A ports (one can be used in gadget mode)
- 1x Gigabit ethernet w/ Motorcomm PHY (through yet to be supported GMAC200)
- 3.5mm audio jack via internal audio codec
- HDMI 2.0 output
- eDP, MIPI CSI (2-lane and 4-lane) and MIPI DSI (4-lane) connectors
- USB type-C port purely for power
- AP6256 (Broadcom BCM4345) WiFi 5.0 + BT 5.0
- unsoldered headers for ADC and an additional USB 2.0 host port
- 40-pin GPIO header

Add defconfig for it.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 board/sunxi/MAINTAINERS       |  5 +++++
 configs/orangepi_4a_defconfig | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 configs/orangepi_4a_defconfig

diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index e00b54f45356..897f4009b29d 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -435,6 +435,11 @@ M:	Andre Heider <a.heider@gmail.com>
 S:	Maintained
 F:	configs/orangepi_3_defconfig
 
+ORANGEPI 4A BOARD
+M:	Chen-Yu Tsai <wens@kernel.org>
+S:	Maintained
+F:	configs/orangepi_4a_defconfig
+
 ORANGEPI LITE2 BOARD
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
diff --git a/configs/orangepi_4a_defconfig b/configs/orangepi_4a_defconfig
new file mode 100644
index 000000000000..6a44dd979590
--- /dev/null
+++ b/configs/orangepi_4a_defconfig
@@ -0,0 +1,32 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun55i-t527-orangepi-4a"
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x07070707
+CONFIG_DRAM_SUNXI_DX_DRI=0x0d0d0d0d
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_ODT_EN=0x84848484
+CONFIG_DRAM_SUNXI_TPR0=0x80808080
+CONFIG_DRAM_SUNXI_TPR1=0x06060606
+CONFIG_DRAM_SUNXI_TPR2=0x5f090503
+CONFIG_DRAM_SUNXI_TPR6=0x38000000
+CONFIG_DRAM_SUNXI_TPR10=0x802f3333
+CONFIG_DRAM_SUNXI_TPR11=0xc6c4c2c0
+CONFIG_DRAM_SUNXI_TPR12=0x3a373233
+CONFIG_MACH_SUN55I_A523=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_REGULATOR_AXP=y
+CONFIG_AXP717_POWER=y
+CONFIG_AXP_I2C_ADDRESS=0x35
+CONFIG_AXP_DCDC2_VOLT=920
+CONFIG_AXP_DCDC3_VOLT=1160
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.47.3

