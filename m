Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A216C83F17
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4278D83061;
	Mon, 14 Jul 2025 01:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lLTiEEj4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF26983045; Mon, 14 Jul 2025 01:35:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D1482F00
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449703; bh=v6uQFXLF/7hro5Hja0kqAG+5qXqQsfFFkpDphDUGNPs=;
 b=lLTiEEj4xoUxPZmw5sqQ8OmzroNBGxed4bRq6Rx4nq/Fv7kE35SrSJrYTKD0GDp6cVUwz8SGs
 AHHN2XNHZuPmj9ItmIEEHGAp/NY8WuGMIOvxvtF7aT6niwjevshDVjf9OgwAcg2OwbLCTpQzSNZ
 cmep4v58H8F6C3vZX9cJZ+NjvEBDO1jnUhHz3QmKHICCdEK3bcsG4EUZ9cVqlA+qPw+qwMUK7MX
 PtAb+uUDsABbVfGPRbhg84smMRHO2/bb+yAoubiI+Lwgj2wX+9wiKzTAVxwlbt/FdHwf03SZLhj
 f9JzMXJNN84dJGIN3llmXlrHNvQlIrHeQG1OiUL48Myg==
X-Forward-Email-ID: 687442a35c59ddd2f404fe54
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
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
Subject: [PATCH 06/17] rockchip: odroid-go2: Remove unsupported Kconfig options
Date: Sun, 13 Jul 2025 23:33:54 +0000
Message-ID: <20250713233429.1376172-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

The handheld gaming devices that this defconfig tagets does not contain
an Ethernet port, remove Ethernet related Kconfig options.

They also do not contain any pwm-regulator in their DTs, remove the
PWM regulator related Kconfig option.

Display/video is not supported in U-Boot, remove all display/video
related Kconfig options.

There is no real functional change expected with these options removed.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/odroid-go2_defconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 698aad59dec8..d6a63bd3a4cd 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -21,9 +21,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3326-odroid-go2.dtb"
-# CONFIG_CONSOLE_MUX is not set
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
@@ -69,15 +67,11 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_SPL_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
@@ -96,10 +90,7 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
-CONFIG_VIDEO=y
-CONFIG_DISPLAY=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
-CONFIG_OPTEE_LIB=y
-- 
2.49.0

