Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FFDC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D0F82A64;
	Tue, 29 Apr 2025 19:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h4l6D4te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5207E82A80; Tue, 29 Apr 2025 19:41:32 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F318829A1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EC2943C16;
 Tue, 29 Apr 2025 17:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C580C4CEE3;
 Tue, 29 Apr 2025 17:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745948488;
 bh=PKDNQNGIubydIjXa8PuavGhKecv3au6c5LUXcEH4E1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h4l6D4teEOyYBCCQ9d+bbT4db318WB3KBzJCxDaM9fYeKbfmFbA04YEHyi0Pt7DJp
 1Q4UUUiWub1o3hI8Cs9DnC4dKLgnaH29yXRkG0MQFVNUN6IEmgtMRlTBys2o2al8+f
 +SesfYoBfXlvpagH1wCeZcjP7gPDN4+R1gupPw6YqcIOfAqEZ9H5OeOiBdysfH+skz
 VSNN1gr/NpUVOuJSJDb/e7M9I7Vm7eLYp6+eT18qBRMcuoyfeupfKUzxvEJcH6Q0mA
 51VRYg7CHXbwAk0uuEm+Y6IpmMF2leIdqnL4KVMI7mXdfhoFdwH8BuajQiymL+xz7U
 puhJ06oLTeCDA==
Received: by wens.tw (Postfix, from userid 1000)
 id 7F1775FDF8; Wed, 30 Apr 2025 01:41:26 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] mmc: rockchip_sdhci: Enable by default for all supported
 SoCs
Date: Wed, 30 Apr 2025 01:41:25 +0800
Message-Id: <20250429174125.2194499-2-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429174125.2194499-1-wens@kernel.org>
References: <20250429174125.2194499-1-wens@kernel.org>
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

From: Chen-Yu Tsai <wens@csie.org>

The rockchip_sdhci driver supports the alternative MMC controller found
in newer Rockchip SoCs. This controller is used for eMMC. Almost all
defconfigs for Rockchip platforms with this controller have it enabled.

Enable it by default for all supported Rockchip SoCs. Disable it
explicitly in defconfigs that previously didn't have it enabled,
which is only the Orangepi 5.

Series-Version: 2
Series-Changes: 2
- Drop trivial defconfig syncs

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

 configs/orangepi-5-rk3588s_defconfig | 1 +
 drivers/mmc/Kconfig                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index 6e2ff7d338a8..098c0738d7c3 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -56,6 +56,7 @@ CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+# CONFIG_MMC_SDHCI is not set
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_XMC=y
 CONFIG_PHY_MOTORCOMM=y
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index ec9e9d51fbf9..d4d49494fee7 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -482,6 +482,11 @@ config MMC_SANDBOX
 
 config MMC_SDHCI
 	bool "Secure Digital Host Controller Interface support"
+	default y if ROCKCHIP_RK3399
+	default y if ROCKCHIP_RK3528
+	default y if ROCKCHIP_RK3568
+	default y if ROCKCHIP_RK3576
+	default y if ROCKCHIP_RK3588
 	help
 	  This selects the generic Secure Digital Host Controller Interface.
 	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)
@@ -714,6 +719,7 @@ config MMC_SDHCI_ROCKCHIP
 	bool "Arasan SDHCI controller for Rockchip support"
 	depends on ARCH_ROCKCHIP
 	depends on MMC_SDHCI
+	default y
 	help
 	  Support for Arasan SDHCI host controller on Rockchip ARM SoCs platform
 
-- 
2.39.5

