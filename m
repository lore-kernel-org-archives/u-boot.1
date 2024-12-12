Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D10E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA7E80212;
	Thu, 12 Dec 2024 23:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OQIRzZMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9885B801B0; Thu, 12 Dec 2024 23:10:28 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B758022B
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041420; bh=qsuomsibYPecQn7qOOBMjFXibhlycxirG1xWhB1t6/U=;
 b=OQIRzZMDnY33Wl37J87J/AMZmh/jzhJFP7xGME53mO6IbZD27VTSE8qeHYfIss7CeKpmCuan0
 0iDi0TKDDi4TynVWWThY3LJ1TojVJJtZ1VwGtzfPDRnCmt0AMVOG2BTMDiMVk7vqZvxnNk/9RnW
 rq/0lATP3iioaV66T8sLLxbpzvzHOIJvp8QguUVOZ4yv309DFoia+pcVr+iILIOOwzsZjlfPm+x
 5sM6fP+uOcguyl8AOmaEwNzsWz18JeVJY5l7pB+sAofxhbyW2FcPPigkLpigp/Zo9J1l+YIFBHd
 OpRUJxWrZf3VkQ4oquyGtO5gPNR96BN12swFknV2DruA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 03/11] rockchip: rk3288-firefly: Set ethaddr env based on cpuid
Date: Thu, 12 Dec 2024 22:09:36 +0000
Message-ID: <20241212221000.94501-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212221000.94501-1-jonas@kwiboo.se>
References: <20241212221000.94501-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b5f4ba511ed8f0b3fc815
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
 configs/firefly-rk3288_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 00f23174210f..eed0806b2321 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -29,6 +29,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-firefly.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
@@ -50,7 +51,6 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
@@ -63,6 +63,8 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.47.1

