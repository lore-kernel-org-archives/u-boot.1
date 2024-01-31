Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE84CC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 22:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D181A87889;
	Wed, 31 Jan 2024 23:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ESKH1zOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7F687776; Wed, 31 Jan 2024 23:07:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503738760D
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 23:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8890=JK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706738842;
 bh=AzFolPQgZKJMEQCUvjVO5ELZK5Qi6Wx2mYhCNcyU8BI=;
 b=ESKH1zOLbHJtf4o2cmf1TQHmfmqRL1vkkP+XUsOgM0KPzGPHqtpFJNcdy+7J/21gYnNIsfCPP
 D1TruNXj+utWRpI+XrH+FD/7+TK+RVXnare5qxMKgqJsDGyhOCjmz36mGyqs+ZIdkNzRW8yOvlb
 LoGgkh6NbNifVwMQnJ2w3nKuVO/dQdU/GXprQGHSU62THLhfumXX5u/V1QShawZg+1aHLnxNjL4
 3+/8MHur9lvPnnaQuWtWzAlAfLAkL8viQbBu3CrujbPZdKthyDeOEICuZajo1nLthKh9wGyMLsE
 jlaPUG8FHEH3FPekmHD0bQWcFrf4sHctiURGGLLzXvGQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3568-generic: Enable eMMC HS200 mode
Date: Wed, 31 Jan 2024 22:07:14 +0000
Message-ID: <20240131220716.117135-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bac49aa5651f9f845fb2e6
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

Writing to eMMC using HS200 mode work more reliably then other modes on
RK356x boards.

Add device tree props and enable Kconfig options for eMMC HS200 mode on
the generic RK3566/RK3568 board. Also enable the pinctrl driver in SPL
and add missing rk3568-generic.dtb to Makefile.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This patch depends on the following series:
- rockchip: rk35xx: Sync device tree with linux v6.8-rc1 [1]
- rockchip: rk35xx: Fix writing to eMMC [2]

[1] https://patchwork.ozlabs.org/cover/1891669/
[2] https://patchwork.ozlabs.org/cover/1891692/
---
 arch/arm/dts/Makefile            |  1 +
 arch/arm/dts/rk3568-generic.dts  | 12 +++++++++++-
 configs/generic-rk3568_defconfig |  5 ++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 50f35e3db3f0..0fcae77cefe3 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -181,6 +181,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
 	rk3566-soquartz-model-a.dtb \
 	rk3568-bpi-r2-pro.dtb \
 	rk3568-evb.dtb \
+	rk3568-generic.dtb \
 	rk3568-lubancat-2.dtb \
 	rk3568-nanopi-r5c.dtb \
 	rk3568-nanopi-r5s.dtb \
diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
index 1006ea55bb98..88eb1bfd2aab 100644
--- a/arch/arm/dts/rk3568-generic.dts
+++ b/arch/arm/dts/rk3568-generic.dts
@@ -10,7 +10,12 @@
 	model = "Generic RK3566/RK3568";
 	compatible = "rockchip,rk3568";
 
-	chosen: chosen {
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 };
@@ -18,6 +23,9 @@
 &sdhci {
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
@@ -28,6 +36,8 @@
 	bus-width = <4>;
 	cap-sd-highspeed;
 	disable-wp;
+	no-mmc;
+	no-sdio;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
 	status = "okay";
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 8f0a9c8c449f..18a62b0033a0 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -42,7 +42,7 @@ CONFIG_CMD_MMC=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
@@ -51,11 +51,14 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
-- 
2.43.0

