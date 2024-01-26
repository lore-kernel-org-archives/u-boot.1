Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484E3C47DA9
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 23:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7542687DC4;
	Sat, 27 Jan 2024 00:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="m6qzgwd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B64E87DC3; Sat, 27 Jan 2024 00:27:03 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6A787DC4
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 00:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0bb9=JF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1706311595; bh=3TgQJ2uyOl+2uJtIsLE+PrckA/iCg00Ko/j+bwQTSJM=;
 b=m6qzgwd3jrqM5wxjYpiXYUE7zdGvJzxwftsxthSr//PPMyi1vrAjvs4bj1Ayrl09DmwrQSXcZ
 vi+QQhgbkHSNKYRyTPcZNaCzLMoSWoSgB/bQAVBYfOGTFmEM2E2+HB0Ws0H3MdjgusLzyU0lImu
 faJISTpaIFifLnQXrSDlxhGHuQkHrEVqR5lTqe7y64ro6mtTGZbF0K32eH7yc5aredmgab07Hzp
 kNxXlNwKK9GZG3Jh69WsVf3hZTr6RA+pVWHdr3SzaWZNFLar++xuCFai+4GtFdfIrq12Pn6ZDXh
 4PVYfsDoFOWmYRJFpv+pbw4yTt5QAAamoPD9xi6egJhA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Jagan
 Teki <jagan@edgeble.ai>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Eugen
 Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH 3/3] rockchip: rk3588: Enable eMMC HS200 mode
Date: Fri, 26 Jan 2024 23:26:09 +0000
Message-ID: <20240126232615.6826-4-jonas@kwiboo.se>
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
 167.172.40.54
X-ForwardEmail-ID: 65b43faa59c89db01a286008
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
RK3588 boards.

Enable MMC_HS200_SUPPORT Kconfig option to prefer use of HS200 mode.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/evb-rk3588_defconfig             | 2 ++
 configs/nanopc-t6-rk3588_defconfig       | 2 ++
 configs/neu6a-io-rk3588_defconfig        | 2 ++
 configs/neu6b-io-rk3588_defconfig        | 2 ++
 configs/orangepi-5-plus-rk3588_defconfig | 2 ++
 configs/quartzpro64-rk3588_defconfig     | 2 ++
 configs/rock5a-rk3588s_defconfig         | 2 ++
 configs/rock5b-rk3588_defconfig          | 2 ++
 configs/turing-rk1-rk3588_defconfig      | 2 ++
 9 files changed, 18 insertions(+)

diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 0b7b4f2f627a..2dfdc71259f7 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -53,6 +53,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 760993220929..26dcf3aae21c 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -66,6 +66,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index d5301c630b2a..a6549420c01e 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -48,6 +48,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index b13c9b5db1b0..b5739de147d8 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -48,6 +48,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index a58f96d57798..e5325158d2af 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -69,6 +69,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index 85af4c4ff955..fd8304debdbb 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -53,6 +53,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index efa7bcbdcda6..10d6f6580490 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -56,6 +56,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index a0678ff1290c..76f57340df5a 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -71,6 +71,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 289f2da775c5..0d6c34d468e3 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -75,6 +75,8 @@ CONFIG_ROCKCHIP_GPIO=y
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

