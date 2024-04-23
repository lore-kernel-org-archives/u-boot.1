Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDEFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 23:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 470D388BC1;
	Wed, 24 Apr 2024 01:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713914138;
	bh=lOKiL0/22evEKYRhSUuqDmCZKJVFvGXPtOx/wRpV/1g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N7oStP2RL6D7Cb3IPAnaiRg0a5PLCUHaLVlf87lhNGEd3oYC6auak7dXuvk6NBO75
	 h1aol6Qu5kYzw64s5tKwvswFOv+wk/akHkicWKHtJUWMLMP8YoBq79B1xruiUI1Rhi
	 OLyLzvm+8KmYH/N2Hx7TftuethCDej66O2Vei52ojn0gXQ/GC3eLjQ1hVQW5KPfVSD
	 m4a5hA8fLOPvcONoXdix3S6gsRizJTBZe2owe2PdOGp/pFGm4TtJaEHdU1AaSnxlKM
	 pq3U38iSAv8NW2XlMWjIQjq3NkmYDt70R9wITXJnfRzyzqF5vskWubIYGgK5LHj9vu
	 hWw1MNuoqhhqQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2D10688359;
 Wed, 24 Apr 2024 01:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713914137;
 bh=lOKiL0/22evEKYRhSUuqDmCZKJVFvGXPtOx/wRpV/1g=;
 h=From:To:Cc:Subject:Date:From;
 b=odMnFQp+JusdPQ4evJGHKqd38R4uEma9vwXZ9QiubqZauYa62SBu+wMr6z/+tlXFd
 zqalXm/yACLJXCJEdL8IQWQULe4N2/Kj07HTY9M6yPhWetLbX0FdndDvZ2ZG7PaffT
 3AKi/5gT1qinItNCajI0/yQjOnh4TyQBY6oXrF49VRtIQ9fnpLB1yhImkGLhjs4Vmv
 8xdPKfe271lj4KWEi1OisXSmNu0VmgTLDWP//GZvyTv1r1tqzX0MTH9br18h8DPKSt
 C9t46Zwitzx+y18ldTSTkPHN+xR97d3Tl9HK95exfol+CvjN7fNK318fPv5crjiaw7
 jnSopV3jVxFKg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: dts: imx: Enable PCIe and NVMe on DH i.MX8M Plus DHCOM
 PDK3
Date: Wed, 24 Apr 2024 01:15:18 +0200
Message-ID: <20240423231526.536883-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Enable PCIe/NVMe support on DH i.MX8M Plus DHCOM PDK3. Except for
the configuration options which are enabled, add slight adjustment
to board u-boot.dtsi, which is necessary as there is currently no
driver for the I2C PCIe clock generator. Since the generator is
strapped to be always on, it is possible to supplant the generator
functionality by fixed-clock.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/imx8mp-dhcom-pdk3-u-boot.dtsi | 12 ++++++++++++
 configs/imx8mp_dhcom_pdk3_defconfig        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-pdk3-u-boot.dtsi
index 040f333c52d..b0b99d51856 100644
--- a/arch/arm/dts/imx8mp-dhcom-pdk3-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-pdk3-u-boot.dtsi
@@ -4,3 +4,15 @@
  */
 
 #include "imx8mp-dhcom-u-boot.dtsi"
+
+/ {
+	clk_pcie100: clk-pcie100 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+};
+
+&pcie_phy {
+	clocks = <&clk_pcie100>;
+};
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index a42dc27aff8..019595edda8 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -31,6 +31,7 @@ CONFIG_ENV_OFFSET_REDUND=0xFF0000
 CONFIG_IMX_BOOTAUX=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x50000000
+CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_FIT=y
@@ -104,6 +105,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_BKOPS_ENABLE=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_READ=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -218,7 +220,10 @@ CONFIG_DWC_ETH_QOS_IMX=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-- 
2.43.0

