Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB4ED2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B632891E9;
	Tue,  5 Nov 2024 17:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jbNl7Hx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B158A89211; Tue,  5 Nov 2024 17:01:49 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366EF891F1
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822497; bh=7x28SgYqGkYdb5zFr0QAcYBJ1/f11QpFXDDlB8SzxA0=;
 b=jbNl7Hx4n0UalRLN7rpBCHTAZzbOzpuSkxv2mNGF7q9lTbM4DLzi0EbrlrYKM2ys/gcIKaLCN
 ib+rLgf9PuhtMgKhRQApRW09+tyWP/Mozf7j7/h60O2c9P/B/t/5R3cJLVZPtmXpvK9e0alsmEo
 W1AGLpJ9leru0IcbfZJ2HD2Cr5prdpVfBjjFrQwa4HbXtSqmb72KdhhZ8TPoHONu9zu+fvnUGV3
 YDPNbiPLJ5WTE4IRq1nuhA0MOdnj/wpZUk9gWQ4zX2FrUHY35PRwwJ9geFemguiLimxjubahn1P
 pS+JE4hoHS3MJiIK4o9h68sDicBqKuJom2nkliOY00KA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 10/13] rockchip: rk3288-tinker: Drop USE_PREBOOT Kconfig option
Date: Tue,  5 Nov 2024 16:00:33 +0000
Message-ID: <20241105160054.1373319-11-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 672a4160ff3e144e4725e198
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

After the migration to use standard boot, storage media should
automatically be initialized in the order listed in boot_targets env.

Drop USE_PREBOOT to speed up boot with ~12 seconds when booting from
e.g. SD-card or eMMC.

Before:

  3,048,599      2,056  main_loop
  3,050,717      2,118  usb_start
 15,070,499 12,019,782  cli_loop

After:

  3,058,244      2,054  main_loop
  3,063,260      5,016  cli_loop

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/tinker-rk3288_defconfig   | 1 -
 configs/tinker-s-rk3288_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index fb42b8bcb00d..1007d9ca9e15 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -17,7 +17,6 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-tinker.dtb"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index f3a392688f02..47d089ff4780 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -17,7 +17,6 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
-CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-tinker-s.dtb"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
-- 
2.46.2

