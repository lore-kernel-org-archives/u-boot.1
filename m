Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2582DC48286
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 20:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EA387BD0;
	Sun,  4 Feb 2024 21:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="HRWfGHqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C8E8796B; Sun,  4 Feb 2024 21:53:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A54087BDC
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 21:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbd4=JO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707080007; bh=U+GMoqw9ptejZOFFHgbazJ899EReGQUy0CqItWLAVNQ=;
 b=HRWfGHqQSUxg2mHPW01FTDid3wkKKO4jdHN/vyQsC9cn201DTkKSsC8H3hTGJDUT3AoFevqYe
 ARtmOFaZmGY/i7q6SKC5re3LGK9vZnOy3LHWc/AIzVbEMugQGgc6ckEvPN7Ca6njPjcl7Zic8xS
 fy3MNgurG3GiUAGLHBzBKqsbCHneZzhp4bPPJYdh6SmdHlvQiclasJBhZUFU42dhtTMfM9RK05u
 aVtxe+7cjrmyaXLy3pTsZlQu8sRrIykHofNL6Vuh5ewg0D9OIy62PiN2tJ1XwIUZnc93jYjAK8U
 8tB7fL2758oIhykKwO5BP00fnnSg/15zfDcnNpr78pbg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Weizhao Ouyang
 <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/3] rockchip: rk35xx: Enable eMMC HS200 mode by default
Date: Sun,  4 Feb 2024 20:53:06 +0000
Message-ID: <20240204205312.2342868-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204205312.2342868-1-jonas@kwiboo.se>
References: <20240204205312.2342868-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bff9466f7b756870de3904
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

Testing has shown that writing to eMMC using a slower mode then HS200
typically generate an ERROR on first attempt on RK3588.

  # Rescan using MMC legacy mode
  => mmc rescan 0

  # Write a single block to sector 0x4000 fails with ERROR
  => mmc write 20000000 4000 1

  # Write a single block to sector 0x4000 now works
  => mmc write 20000000 4000 1

With the MMC_SPEED_MODE_SET Kconfig option enabled.

Writing to eMMC using HS200 mode work more reliably than slower modes on
RK35xx boards. Enable MMC_HS200_SUPPORT Kconfig option by default to
prefer use of HS200 mode on RK356x and RK3588.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Imply MMC_HS200_SUPPORT and SPL_MMC_HS200_SUPPORT in arch Kconfig
  instead of adding to each boards defconfig
- R-b tags not collected because of above change
- Combine changes for rk356x and rk3588 in one patch
- Update commit message

Link to v1: https://patchwork.ozlabs.org/patch/1891693/
---
 arch/arm/mach-rockchip/Kconfig      | 4 ++++
 configs/nanopi-r5c-rk3568_defconfig | 2 --
 configs/nanopi-r5s-rk3568_defconfig | 2 --
 configs/radxa-e25-rk3568_defconfig  | 2 --
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 6ff0aa6911e2..946ef5d7023d 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -292,6 +292,8 @@ config ROCKCHIP_RK3568
 	imply OF_LIBFDT_OVERLAY
 	imply ROCKCHIP_OTP
 	imply MISC_INIT_R
+	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
+	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
 	help
 	  The Rockchip RK3568 is a ARM-based SoC with quad-core Cortex-A55,
 	  including NEON and GPU, 512K L3 cache, Mali-G52 based graphics,
@@ -317,6 +319,8 @@ config ROCKCHIP_RK3588
 	imply OF_LIBFDT_OVERLAY
 	imply ROCKCHIP_OTP
 	imply MISC_INIT_R
+	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
+	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
 	imply CLK_SCMI
 	imply SCMI_FIRMWARE
 	help
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index 833cff0e457d..f5a472d03d78 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -58,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index 2736d382a352..99692d341f44 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -58,8 +58,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index 5a613abe0d2d..fedb137877ab 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -60,8 +60,6 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.43.0

