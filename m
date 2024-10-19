Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA38D3C92D
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 22:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231B08918C;
	Sun, 20 Oct 2024 00:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729375428;
	bh=iv0Gv0+gApIvRjXhh/+Z8qChBcq+wHEik8gLo4c79qQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VXl04fFHKiq+cXDUK1vfyjWw8o5nJ6n5NjgPonKqkXorSuf94ZPXZfaZ2B0en5G+5
	 +yBew8bLy9Hn1KoVIhmxzEsg8QLNV0vQgUKXzMX8S6JD9d2p3hUti7oghG/gbIyo4m
	 JNxtwmNR7owgKqcRHzHS8EWb0XqBb24BU5gGA8Cs21dpqkvy/Mn+fcK2BIvmCeIOIL
	 WJQgcZ2rs6b2wnqXq3hrbZ3oApGvl3hUkCiRbjhFfKcNWMMxHLtFZ+WZBsn9iry0+a
	 ja2+3SnfJ9wJN2W7ozDoxi3JGg3dwLBOYjIYfgtsMU6+nYmETbNQV2usJGOJawliTY
	 NORTqle9+mXKQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 694F289018;
 Sun, 20 Oct 2024 00:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729375424;
 bh=iv0Gv0+gApIvRjXhh/+Z8qChBcq+wHEik8gLo4c79qQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m4xFjCFhlaZYsR5/QxSCuiY6N8a788xoT9NgNOm/vlt5I4xTMpfhuwcLSkUZiQ8mS
 Ie77S9XM6416qKCLkEs4lCdtf/ME22ykhy7oNEdnXSETEAetX5N3768rz+YZrbx8Y4
 unVICDloi6GXJlxhHvIg+Yjy1OdTTTa7I71Hzv11Dc8BI6JrEnyUt8KVUiLxazn/vX
 qdkItz2oOmDVo2bPwuv4AlaH8yFELqUEl0SUcj5d6eju/+LztvsOkP27Sw6Z4Ggg1O
 ttCbzQmbYHssIfQ6AF+TE4NsTWLc58jj1bC2AyFDpBDyn6crCwfPs++mTlFWZL4KPH
 x3HHll/kjNGrQ==
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
Subject: [PATCH 2/5] arm64: imx: imx8mp: Disable PCI support on DH i.MX8MP
 DHCOM SoM on DRC02 board
Date: Sun, 20 Oct 2024 00:01:42 +0200
Message-ID: <20241019220322.341324-2-marex@denx.de>
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

