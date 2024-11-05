Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2664FD3E773
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D048913F;
	Tue,  5 Nov 2024 22:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QIM2T6MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D86E89066; Tue,  5 Nov 2024 22:53:08 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B7089208
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843579; bh=dxudhwiyh5js6XxafIEWb+7UP5DrpU6Vq50PVcyphZk=;
 b=QIM2T6MKrhyxjErAP0vgP4+YptsX8cJhP2zXDqz2GH4bSPRNq3tTs7pv6Fyox4E+uMB/76LFH
 QeqTUyz+O+1kCNROekyhxLUUwYoxeb3HJpzFhoqy+rCnPJGUOwO/zZyYPkBbfYtKtMBovHizd9C
 RCCHBgZxwpX7Xwkvy41WwAql+xR0CpheNVEt2inxcnhXn1Ark8djIXiq0fSsh8uUzzC2zXJbuzv
 FdhqcoRcrbuyR3lWUeyVgeJfRrbeWaLGIboFkhXZf5uQJqJZ4JRMvLvJGV9SpvZ43XRtKgPxA8T
 4fX9D0cqur64lDdG4w0MD0BCtKt8wctYkbHYR2MeTLzw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/11] rockchip: rk3288-miqi: Change to use FIT
Date: Tue,  5 Nov 2024 21:51:47 +0000
Message-ID: <20241105215202.1491441-12-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 672a93ba059db14dd83d7bd7
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

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/miqi-rk3288_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 55e8d30f675f..166468fd4e72 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -17,9 +17,15 @@ CONFIG_DEBUG_UART_BASE=0xff690000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-miqi.dtb"
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -89,4 +95,5 @@ CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_HDMI=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_SPL_CRC32=y
 CONFIG_ERRNO_STR=y
-- 
2.46.2

