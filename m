Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B83D2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37B3589220;
	Tue,  5 Nov 2024 17:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="g4aCBOI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D321789231; Tue,  5 Nov 2024 17:01:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CC34891E8
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822507; bh=va8u4iOXtwIFenOVtk0x5WwtKF0n3zJalAJOINOi7uk=;
 b=g4aCBOI5F2K9fZeKSwDshe7q3ozreV5msG8tyBvNHSpC1O1sNNLQNB+EZX2Rqw+nFq6TsGoW7
 KlFPOQdwzm5fO8MEP4pJrdLrmterR0rFx9MUO9cU1LGPZ7ZpdTTI/Tabx8v0lpaJRCkuRJ/p7s5
 oNLW7FBijjtj427A86qL1IMCPkW+AOuLzENV9ZbiLQAnvk3ZCpbYCQOktQblCP6BYoM8mhzFeFH
 pr6TVJpTFD5ORYF50PYIzd1gjrDB3mWpW6Oa2zSftI3HpfvJEbkgXm5mw0P64ljLeC7hR1IEBRA
 8yJ+0l9g3BU7YGWU9/C5QE2HseYDEdtNcl6yLH2eTBZw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 13/13] rockchip: rk3288-tinker: Change to use FIT
Date: Tue,  5 Nov 2024 16:00:36 +0000
Message-ID: <20241105160054.1373319-14-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672a416bff3e144e4725e1d6
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

Change to use FIT and FIT_SIGNATURE when loading U-Boot proper in SPL to
allow checksum validation and fallback loading of FIT from a different
mmc device.

Checksum validation of FIT adds around 140 ms to boot time:

Before:

       Mark    Elapsed  Stage
          0          0  reset
         13         13  TPL
      6,957      6,944  end tpl
     25,102     18,145  SPL
    131,932    106,830  end phase
    132,137        205  board_init_f
    444,277    312,140  board_init_r
  1,404,987    960,710  eth_common_init
  1,519,110    114,123  eth_initialize
  1,524,734      5,624  main_loop
  1,525,452        718  cli_loop

After:

       Mark    Elapsed  Stage
          0          0  reset
         13         13  TPL
      6,957      6,944  end tpl
     35,744     28,787  SPL
    271,220    235,476  end phase
    271,420        200  board_init_f
    588,474    317,054  board_init_r
  1,548,950    960,476  eth_common_init
  1,663,105    114,155  eth_initialize
  1,668,734      5,629  main_loop
  1,669,417        683  cli_loop

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/tinker-rk3288_defconfig   | 7 +++++++
 configs/tinker-s-rk3288_defconfig | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 05dca105d609..bc5379d43430 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -17,9 +17,15 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker.dtb"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -91,4 +97,5 @@ CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_SPL_CRC32=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 1bee0d094c8d..f0c8cc5bbc1b 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -17,9 +17,15 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker-s.dtb"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -91,4 +97,5 @@ CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_SPL_CRC32=y
 CONFIG_ERRNO_STR=y
-- 
2.46.2

