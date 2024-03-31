Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293A8CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF8787F2A;
	Sun, 31 Mar 2024 22:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fScPwdSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB46687FE3; Sun, 31 Mar 2024 22:30:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADA687F2A
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917000; bh=t/VoG5QDQaFb7ZH81kdJDhJUuzwXheTd70j73v2lvbc=;
 b=fScPwdSdRp/rrM5hj+FMi+JTjAlA1SQr0et/HYA9OYdzTYQRujPtK3I1JwcNBW4EbKkJDqbJZ
 dhl4/GzJQuV0K9AyFa5PAp+t94hSY8JQw52Oboi6ORD474uqRd92WzjvFqDyR1VzcKwKgc3SiDk
 x2iY9y5WpbErTmNee0O2C6vKU9ptSttFBrpcaMkmErg3aiaQWJzHYqw9BXQTTEsath1/3QFno66
 Jj6QB2O/7YaOktCBGs30AFQ79G9NzSNUOye84z24VvhJf7r6ciF8ggMsVe3asKeR5/QaA4ks/3l
 abVnqGXyWNfR94YZ2s4/inkhENXYGCsOyS7Q54Bqj+cA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Christopher Obbard <chris.obbard@collabora.com>, Jagan Teki
 <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 07/31] rockchip: rk3399: Enable DT overlay support on all
 boards
Date: Sun, 31 Mar 2024 20:28:13 +0000
Message-ID: <20240331202921.262323-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7c68fc6b45ed44f72ca
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

Imply OF_LIBFDT_OVERLAY Kconfig options to add device tree overlay
support on all RK3399 boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig        | 1 +
 configs/rock-4c-plus-rk3399_defconfig | 1 -
 configs/rock-4se-rk3399_defconfig     | 1 -
 configs/rock-pi-4-rk3399_defconfig    | 1 -
 configs/rock-pi-4c-rk3399_defconfig   | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a07ad38f2efc..8dca9d2853b4 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -268,6 +268,7 @@ config ROCKCHIP_RK3399
 	imply LEGACY_IMAGE_FORMAT
 	imply MISC
 	imply MISC_INIT_R
+	imply OF_LIBFDT_OVERLAY
 	imply OF_LIVE
 	imply PARTITION_TYPE_GUID
 	imply PHY_GIGE if GMAC_ROCKCHIP
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index bebea4fd0691..6c69e8bdcb92 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4c-plus"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 04622df3c0a0..e5ed81022bd6 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-4se"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 9036c51de421..2801becedb4b 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -6,7 +6,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4a"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index e1adec600174..72d37bff9e9a 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rock-pi-4c"
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
-- 
2.43.2

