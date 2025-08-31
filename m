Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF519CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 303CE839BB;
	Sun, 31 Aug 2025 18:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RJYfEvDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBC383929; Sun, 31 Aug 2025 18:51:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6A8839BB
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756659079; bh=nTOKgYWh+IeP+sk2JgZK9o/eYdttX6RSes3DTpZU3YU=;
 b=RJYfEvDPY/CuMQO2v6hhxCAdy1Gwp+fv3UP4m1Wt1jurKPtOhsbGiNlVwrviAtwbhMpEPAm4a
 /XH/OzEzBLLFldb+p0yeznpK1nC7PJHgJvAfLCtFvcGwseZiaJRK3g+suEZX9RYLlYTGPyZ6uZm
 3ugFEq1XBCyGVGtqj5bSCSNkjogtX0hlKzZwSSb6ZhLehd8PRjtHjr5HRXI/yYSYU0KDAiY8rL9
 HWkBIOxikK4Oxc056wd9L6a22YGMMB+h3YQ0QjZ9u1SB4mhBiW4F5BWgvvQ4R00+zb+fOhU2bSQ
 fGLhJDQHg6vs9dE0ii56u/QdTVnjyKRxuAMPwehVRCYg==
X-Forward-Email-ID: 68b47d837f68b507ca9c3b4a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
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
Subject: [PATCH v2 14/18] rockchip: odroid-go2: Enable RockUSB, button,
 LED and RNG support
Date: Sun, 31 Aug 2025 16:49:31 +0000
Message-ID: <20250831165001.2749711-15-jonas@kwiboo.se>
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

Enable Kconfig options to support RockUSB, buttons, LEDs and RNG
featured on the board or SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 configs/odroid-go2_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 185d0f1d7c5f..70d74c65a2f3 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SLEEP is not set
@@ -72,12 +73,17 @@ CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_FASTBOOT_BUF_ADDR=0x800800
 CONFIG_FASTBOOT_BUF_SIZE=0x04000000
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_PWM=y
+CONFIG_LED_GPIO=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_MMC_DW=y
@@ -97,6 +103,8 @@ CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_TPL_RAM=y
 CONFIG_ROCKCHIP_SDRAM_COMMON=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_ROCKCHIP=y
 # CONFIG_SPECIFY_CONSOLE_INDEX is not set
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
@@ -109,6 +117,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
-- 
2.51.0

