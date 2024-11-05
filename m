Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A8AD3E773
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB93A891A4;
	Tue,  5 Nov 2024 22:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sPETLCSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD34891A4; Tue,  5 Nov 2024 22:52:37 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09EC48917B
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843547; bh=CITIaU9L1wja8axtm34N9glSekanUQz2thC2Zaqyuvk=;
 b=sPETLCSiz1dhw5sTOxwr7H8pOCb7jtnco7TlDqS9aSu6KHkBYQV8aSeYd/5F86umblmu6hcy3
 oTUPThWpUBbVw4FnDoITs+Met/VIc2sebvdX31F3Taiw0FqvKZDRJrBc6peruNIQnzflIUAUtvs
 dS8BbcRcAkDuPSDpXViNcuWVhraN8WhVTwNYWFdU0mn2TCjUN9C76ACkGFvK+0+29dNiM5zNrok
 RODnrPmlsM/YgAOZ47uzzsCj6OZrh+/YJRCJhRvrLgBMpToSR7jGKheu5J1X5brurvLh1G7vzI7
 /BZTrzkEwOd1V+NLqKHhzC13ayFSoyWCN2jDNktbUEog==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/11] rockchip: rk3288-miqi: Set ethaddr env based on cpuid
Date: Tue,  5 Nov 2024 21:51:39 +0000
Message-ID: <20241105215202.1491441-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105215202.1491441-1-jonas@kwiboo.se>
References: <20241105215202.1491441-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a9397059db14dd83d7afc
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

Enable Kconfig options to read cpuid from efuse and set cpuid#, serial#
and ethaddr env vars based on the value read from efuse.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/miqi-rk3288_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 5595352f03aa..764b4351e94c 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -27,6 +27,7 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-miqi.dtb"
+CONFIG_MISC_INIT_R=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
@@ -50,7 +51,6 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
@@ -61,6 +61,8 @@ CONFIG_SPL_CLK=y
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.46.2

