Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C310C47DA9
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 23:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A550287DBB;
	Sat, 27 Jan 2024 00:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XPo4SR4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C6CA87DC1; Sat, 27 Jan 2024 00:26:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7C187DAE
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 00:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706311591; bh=pEmjbBnF9SqAV+2I2IPPDAocPSqsv85fiqyHp4b1yB0=;
 b=XPo4SR4UHTeLYrKBBrSYMFT8TZ+ubh9sMXg7OwpBwXLnUvZBgWfY72mtNHhkXVwuYAyIY1pkF
 FT8U+cEmf2QSXe/GOv2M18sV4JGdsWtHYTxOyEUDUF3/OYu+oWY8VoUVNcJToQj5WMl+hP4Da8l
 BiH14sz5MVhAphBRNBn71Ouoz7/FfuGrHBC8X3EOedndUtkPUxWeRZiEqTsYLnCYmTYb/empKlW
 imXjudDT1ouUvoFrtwr1i1bjSOFAWxnRAibGHnffYioQDbI4hzskPEylgB/WsIPRd3sqAgUFK6e
 FaH51CQhO82Y4o0nl56yth2ixuBFZ2zZvZQ1hTo4kfQQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>, Frank Wunderlich
 <frank-w@public-files.de>, Joseph Chen <chenjh@rock-chips.com>, Andy Yan
 <andyshrk@163.com>, Jonas Karlman <jonas@kwiboo.se>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/3] rockchip: rk356x: Enable eMMC HS200 mode
Date: Fri, 26 Jan 2024 23:26:08 +0000
Message-ID: <20240126232615.6826-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232615.6826-1-jonas@kwiboo.se>
References: <20240126232615.6826-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b43fa659c89db01a285ffa
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

Enable MMC_HS200_SUPPORT Kconfig option to prefer use of HS200 mode.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/anbernic-rgxx3-rk3566_defconfig   | 2 ++
 configs/bpi-r2-pro-rk3568_defconfig       | 2 ++
 configs/evb-rk3568_defconfig              | 2 ++
 configs/lubancat-2-rk3568_defconfig       | 2 ++
 configs/odroid-m1-rk3568_defconfig        | 2 ++
 configs/quartz64-a-rk3566_defconfig       | 2 ++
 configs/quartz64-b-rk3566_defconfig       | 2 ++
 configs/radxa-cm3-io-rk3566_defconfig     | 2 ++
 configs/rock-3a-rk3568_defconfig          | 2 ++
 configs/soquartz-blade-rk3566_defconfig   | 2 ++
 configs/soquartz-cm4-rk3566_defconfig     | 2 ++
 configs/soquartz-model-a-rk3566_defconfig | 2 ++
 12 files changed, 24 insertions(+)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index ed6643d9d4fa..295c0bd3fc61 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -61,6 +61,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index e6e0e6fc6fa6..c9e1cd2c2c85 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -60,6 +60,8 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index cb9b87ff12cb..19eab9bf00ac 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -54,6 +54,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 80ae6ec3a2e9..c06a447fda26 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -55,6 +55,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index 3130e341e776..7fed6e7da597 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -72,6 +72,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index ade08867f60f..fd6b0e528834 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -71,6 +71,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index 8d01db54407d..ec7a677fd3d3 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -69,6 +69,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 4b606dcb8e94..10626acfdea2 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -55,6 +55,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 18372a570eb7..2b944163f5a9 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -68,6 +68,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index 9693cc2f9eb9..af04dccf4923 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -62,6 +62,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index 9c6b12d23028..e669ca14c1cc 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -62,6 +62,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index fd72d78a47a8..3beeab1dbba8 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -63,6 +63,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.43.0

