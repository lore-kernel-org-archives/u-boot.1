Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E92C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE9F82B8E;
	Sun,  6 Apr 2025 02:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h+/0t5Y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A190882B4A; Sun,  6 Apr 2025 02:25:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C520D82B72
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899122; bh=l5mKf/Mbo3GJeLJl1b+5+95cYJERGVYxpYCMaJSAq68=;
 b=h+/0t5Y0GHwSMMYMe7GaGOU/qABNsaLA3/yMEen0YXRRm4SOwZO1JSwtN7VO2IPGiUrmvmi3D
 PlJaZZ5jQCrFpyZy/FWH2O+016ZC5Ae3MfZe7JbER8tNc+sUk9sLoZytNwzxTj4DFu/duRZNBYI
 U2bmiQALO0fvNlRwAeBoqTcdfzm5qEbj9WR94nn3GrZLiOkTbdUzqVLxocvzHPoQri2YEyHP4qt
 cdNTMZMxkws1z/DN2I1LYXz8s32D5nr6PSA/LHzukn5aUB/2oLSg/n3UYlcH2h3O9RjtZBshLC1
 Q9xw2Gnfw7zWVYe31xSACD07VZuPFE4KhQ045M5/e1zg==
X-Forward-Email-ID: 67f1c9edfb2b6fde09d69fb3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/11] rockchip: Use rk3588_common.h by default for RK3588
 boards
Date: Sun,  6 Apr 2025 00:24:28 +0000
Message-ID: <20250406002447.1555596-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406002447.1555596-1-jonas@kwiboo.se>
References: <20250406002447.1555596-1-jonas@kwiboo.se>
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

Ensure rk3588_common.h can be used by boards directly by defining a
blank ROCKCHIP_DEVICE_SETTINGS unless it already is defined.

Add a default SYS_CONFIG_NAME to include rk3588_common.h unless a board
target overrides it in its board Kconfig.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3588/Kconfig | 3 +++
 include/configs/rk3588_common.h       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 1c6a85d07394..8acb6618718f 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -441,4 +441,7 @@ source "board/rockchip/toybrick_rk3588/Kconfig"
 source "board/theobroma-systems/jaguar_rk3588/Kconfig"
 source "board/theobroma-systems/tiger_rk3588/Kconfig"
 
+config SYS_CONFIG_NAME
+	default "rk3588_common"
+
 endif
diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
index 7b02560971ad..2f0d40deb640 100644
--- a/include/configs/rk3588_common.h
+++ b/include/configs/rk3588_common.h
@@ -14,6 +14,10 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf0000000
 
+#ifndef ROCKCHIP_DEVICE_SETTINGS
+#define ROCKCHIP_DEVICE_SETTINGS
+#endif
+
 #define ENV_MEM_LAYOUT_SETTINGS		\
 	"scriptaddr=0x00c00000\0"	\
 	"script_offset_f=0xffe000\0"	\
-- 
2.49.0

