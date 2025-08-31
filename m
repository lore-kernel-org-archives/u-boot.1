Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FC7CA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512FE83984;
	Sun, 31 Aug 2025 18:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="v75NvquA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1248397A; Sun, 31 Aug 2025 18:51:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA1E8399B
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659056; bh=LJREvt1DJMVgDzaJVZ36wjKxXI01d7b846ngSlBLgnA=;
 b=v75NvquAFH+c+KJcjHqxGiz6mfa/AVBg957XSMl0NdEVE6OLkfB9zkTcpSUdskTvyzzakYBHe
 cd0VIZhiHQ9nI7MPb3n2L/vQ8N8CMRu0V3DegX0nR4M+3WQr8tUN0U9zq7MO9m1TdH3mKZYKpph
 PFCOftjZ6UIdSz/poW4MrT2asEeOxUHOaFmUydDciPnZteq47LET2cYZeP7IxfZcfUY9uinZsV4
 zgzmMPzumDTzxwxJqC7d0r0JzvEBxL5ISV6V9ovdJXpq8iqZ8dvgWEzXlM1eOc3Y0CXsB4Am5dE
 c31kTScVx4mw0ygOmYAVXmRuylFedcN6BUNB3s0g/lTg==
X-Forward-Email-ID: 68b47d6c7f68b507ca9c3a6e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 08/18] rockchip: odroid-go2: Update Kconfig options for SPL
Date: Sun, 31 Aug 2025 16:49:25 +0000
Message-ID: <20250831165001.2749711-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831165001.2749711-1-jonas@kwiboo.se>
References: <20250831165001.2749711-1-jonas@kwiboo.se>
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

Drop SPL_DRIVERS_MISC, it is not needed/used on these devices.

Enable SPL_FIT_SIGNATURE to ensure the integrity of the FIT images
that are loaded into memory.

Change SPL_MAX_SIZE to 256 KiB, similar to other SoCs where TF-A is
loaded at 0x40000 offset from start of DRAM.

Enable SPL_DM_SEQ_ALIAS to ensure device aliases are applied in SPL.

Drop use of SPL_TINY_MEMSET, there is plenty room for the normal memset.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
---
 configs/odroid-go2_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index d6a63bd3a4cd..6bc0d12440c9 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -10,7 +10,6 @@ CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_ODROID_GO2=y
 CONFIG_DEBUG_UART_CHANNEL=1
-CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xFF160000
 CONFIG_DEBUG_UART_CLOCK=24000000
@@ -19,12 +18,13 @@ CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3326-odroid-go2.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_MISC_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
@@ -53,6 +53,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
@@ -90,7 +91,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
-- 
2.51.0

