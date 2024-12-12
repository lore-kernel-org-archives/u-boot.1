Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD4EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC7A801DA;
	Thu, 12 Dec 2024 23:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KI0ZssN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F90801DA; Thu, 12 Dec 2024 23:10:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD75C801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041438; bh=/fQBdOOmyIIDF12dQXJX/syjnXp1Er4XkLG/RrwGt8g=;
 b=KI0ZssN/vIpviR9tUPe0/rWh18wU8WhEMcSAWkazd+j3dNtozTw5xgoTpuf6O6K5Mrl3f6xWN
 m27gwY2yj5XYL+dGAQM9OSZPKBbyl5dINBoD4N2XTPGatUr9dYfe3+JT7iVSwIlwqMrlQ29g3C3
 fueJOnXGsVdMif4wcg5tJnNiEIf9oVOwB0ov0RaBApXCTLUCe/5z1Xr0Sr7l4M3TdbVr3WqxTj0
 pidWbdKcjWOH6QAYWAdCd+klP+lMRS/eq/zNDr4rLwvUov/8WMBWN8GXQb8GiBWc9c+EI9TDVWW
 FpVo/flhiNkcvMAUXDpwMCRJQcbMvTMy8pXiKB+fmzAQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/11] rockchip: rk3288-firefly: Drop use of silent console
 and late boardinfo
Date: Thu, 12 Dec 2024 22:09:40 +0000
Message-ID: <20241212221000.94501-8-jonas@kwiboo.se>
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
 207.246.76.47
X-ForwardEmail-ID: 675b5f5ca511ed8f0b3fc87a
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

Current use of SILENT_CONSOLE hide valuable information when something
goes wrong during boot, drop this Kconfig option to allow user to see
e.g. from what media U-Boot proper is loaded from.

A second Model line is printed on console due to DISPLAY_BOARDINFO_LATE,
drop this Kconfig option to remove the second redundant line.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/firefly-rk3288_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 2160474fe0f3..6e395f5c450d 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -20,8 +20,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-firefly.dtb"
-CONFIG_SILENT_CONSOLE=y
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_CMD_GPIO=y
-- 
2.47.1

