Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC50C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5C582BA1;
	Sun,  6 Apr 2025 02:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hilyj2TF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4E282B9D; Sun,  6 Apr 2025 02:25:22 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE7482B63
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899117; bh=UGNFe/HfGUbfjinp+xEg1sA98zA9roP+7MiyrXClzQ0=;
 b=hilyj2TFIHYpoPxGcchEXAMxbsN8IO2sCJL4PI1x2ZPRtRI52j8FNBoQR7OaOpK3OnblzF5ET
 qgTSOQeUF2sgStK0bi8lR38Jf7cn1ZUO5b279fwJla0oQyWc1Bpbergcj0IqZUKG4dTIq2DdxFb
 UTqEvIBuiz8UMgWvmc7Rtqajeb3LZQkAwDhyCDlqdJHCPJn7DDrLpeABIviJOFD+YiUQhKJY4tr
 RjuMcEmMK3M98uHu6n2AxIKUtoXlXNPHzFfM3p8WnOxgi27mICJfQlATrZQ9k0NFocEmYiy0E8j
 4mT4EjVvZYF9lZN5DF36vuffDAf6+DXuf/exZ1EY61BQ==
X-Forward-Email-ID: 67f1c9eafb2b6fde09d69f9e
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
Subject: [PATCH 06/11] rockchip: Use rk3568_common.h by default for RK356x
 boards
Date: Sun,  6 Apr 2025 00:24:27 +0000
Message-ID: <20250406002447.1555596-7-jonas@kwiboo.se>
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

Ensure rk3568_common.h can be used by boards directly by defining a
blank ROCKCHIP_DEVICE_SETTINGS unless it already is defined.

Add a default SYS_CONFIG_NAME to include rk3568_common.h unless a board
target overrides it in its board Kconfig.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3568/Kconfig | 3 +++
 include/configs/rk3568_common.h       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index a271782fac5c..8cad77890f13 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -81,4 +81,7 @@ source "board/qnap/ts433/Kconfig"
 source "board/radxa/zero3-rk3566/Kconfig"
 source "board/xunlong/orangepi-3b-rk3566/Kconfig"
 
+config SYS_CONFIG_NAME
+	default "rk3568_common"
+
 endif
diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
index a68ca381db57..b2a35db0b949 100644
--- a/include/configs/rk3568_common.h
+++ b/include/configs/rk3568_common.h
@@ -15,6 +15,10 @@
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

