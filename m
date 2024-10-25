Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769A8D149F7
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 22:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756158901D;
	Sat, 26 Oct 2024 00:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729896983;
	bh=/SpKiwa/39Rk9vz2LwhI3nZ1L5N6uYGafrFpl/rbJh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I3b2pofHoyaVsrqTOwBJQTd/m8821NVptEd14NB4rj0RmU5C96YDNpR3wRSZ4Uoce
	 Z5FFyLjiuDLhGMat5NjqFRKqHeecg5CY3MVKiBy1rmons0RxMxG4PENtpoi9QuSFGc
	 DSt1m3ehFyDuGb5AMNlFymYS9PVhLhjhtevfqEI00ysaced/oeaJiw0cIhChaaQfFC
	 YVxDSIXIqBa5EypXAy23OlEfFakKH34geyJoyL47teg3HQ9bZqVII303pA7KO+bahJ
	 YsR7VeNwXZvlFWEaeQWYTrxuulQcknMmLzwS9paGC77nir1s/rhSmFE49uOJiDbL+X
	 K0cehewVQHgIw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F008288DF8;
 Sat, 26 Oct 2024 00:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729896982;
 bh=/SpKiwa/39Rk9vz2LwhI3nZ1L5N6uYGafrFpl/rbJh8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ip+huQ1+HIwz5IREB5pO/YNtvBC8B/pSlzMZEKse+gJGrt8Divsn8lvXVzGQfUKLc
 e89vuFp45TKZKsnz95lEvFJrqAGS+jPfZM2untNtmrXZQPhzpZhmG9Tv3jNqmYYtKK
 jUWfJyv0IWOE9xNBQHjVOqNakoAhuBhuojtV9/ovKtXTOVn0tqCMhSknIpqOC1e/S9
 GIIjBOJmR2YMj/mYx2LcHBWv/eXD4CDc694oYd0bIiifjXJq3GAXs8ssaOkVNnqqAw
 bsXOcvkty/puflx0RL2WE8cbGyRp7WsdXofLXAQvmkthKFiIFIW8yoSykR2SwlfPUG
 S9hgbleBX7smA==
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
Subject: [PATCH v2 2/5] arm64: imx: imx8mp: Disable PCI support on DH i.MX8MP
 DHCOM SoM on DRC02 board
Date: Sat, 26 Oct 2024 00:55:03 +0200
Message-ID: <20241025225602.114784-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025225602.114784-1-marex@denx.de>
References: <20241025225602.114784-1-marex@denx.de>
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

The DRC02 carrier board does not expose PCIe in any way, disable PCIe support.

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
V2: No change
---
 configs/imx8mp_dhcom_drc02_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configs/imx8mp_dhcom_drc02_defconfig b/configs/imx8mp_dhcom_drc02_defconfig
index ffc9bf0e1c2..366e5bbbb74 100644
--- a/configs/imx8mp_dhcom_drc02_defconfig
+++ b/configs/imx8mp_dhcom_drc02_defconfig
@@ -35,7 +35,6 @@ CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_ENV_OFFSET_REDUND=0xFF0000
 CONFIG_IMX_BOOTAUX=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
-CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_FIT=y
@@ -105,7 +104,6 @@ CONFIG_CMD_BKOPS_ENABLE=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PART=y
-CONFIG_CMD_PCI=y
 CONFIG_CMD_READ=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -220,10 +218,7 @@ CONFIG_DWC_ETH_QOS_IMX=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
-CONFIG_NVME_PCI=y
-CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY_IMX8MQ_USB=y
-CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-- 
2.45.2

