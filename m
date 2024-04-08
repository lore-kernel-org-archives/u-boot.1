Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B3FC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3B188124;
	Mon,  8 Apr 2024 20:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gOPaMxqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E961987C7F; Mon,  8 Apr 2024 20:14:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0445D878ED
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600085; bh=aryRwAwyZK/S8kdJdvKeJuz3wW2c4HbrLo3PTuvFa6U=;
 b=gOPaMxqwf0CeKh/ur0hOYma9PpQsRR9xKxSLoV5VQI5tAKG9BesIT4tHy7n3BE9SRvC/jOZB5
 qdmoObS//PO3flmbA3m2wFa4pSyxlyw9IOXlaqTWrM8HwZmThkuyZFu/R0870L/BigiXicKTppV
 Ikm2kAMXEmSM6a1FZVnjIkWzd2KuqvSqHPjA9Q0MiUbL1YqZVbEKo3v4HdDzA3vVsNmK1VtW4j7
 NGe9AfdFhRGEGCry2T/I+LeiDY8BMDTCwtgcI5OpKu8qLNzoVItVbya5PgbiwSnHZqCwlEaGxSA
 3Tcaydd66unrC1HEGUkpd3xidAJ2x3ppRJYysP5mNo5Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 03/14] rockchip: rk3308: Enable ARMv8 crypto and FIT
 checksum validation
Date: Mon,  8 Apr 2024 18:14:00 +0000
Message-ID: <20240408181429.3676856-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6614341445fff4c2aa5b4a1f
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

The RK3308 SoC support ARMv8 Cryptography Extensions and use of the
ARMv8 crypto extensions help speed up FIT checksum validation in SPL.

Imply ARMV8_SET_SMPEN and ARMV8_CRYPTO to take advantage of the crypto
extensions for SHA256 when validating checksum of FIT images.

Imply SPL_FIT_SIGNATURE and LEGACY_IMAGE_FORMAT to enable FIT checksum
validation on all RK3308 boards.

Also disable CONFIG_SPL_RAW_IMAGE_SUPPORT in board defconfigs to ensure
SPL does not try to jump to code that failed checksum validation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/mach-rockchip/Kconfig     | 4 ++++
 configs/evb-rk3308_defconfig       | 1 +
 configs/roc-cc-rk3308_defconfig    | 1 +
 configs/rock-pi-s-rk3308_defconfig | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 2fde8655d18a..71c5945b5742 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -160,8 +160,12 @@ config ROCKCHIP_RK3308
 	select SPL_ATF
 	select SPL_ATF_NO_PLATFORM_PARAM
 	select SPL_LOAD_FIT
+	imply ARMV8_CRYPTO
+	imply ARMV8_SET_SMPEN
+	imply LEGACY_IMAGE_FORMAT
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_CLK
+	imply SPL_FIT_SIGNATURE
 	imply SPL_RAM
 	imply SPL_REGMAP
 	imply SPL_ROCKCHIP_COMMON_BOARD
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index d57b2f6b8e55..6a6d2540317d 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_ELF is not set
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 5e8f51ec01e3..2f4a160acc24 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_ELF is not set
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 1e9cd2c0fc7e..b0ad4d6ce354 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_ELF is not set
-- 
2.43.2

