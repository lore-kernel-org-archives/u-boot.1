Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0975EE67814
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 21:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4621989080;
	Sat,  2 Nov 2024 22:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FgR7snfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0DC4890B1; Sat,  2 Nov 2024 22:30:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F1A89066
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 22:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4e10=R6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730583013;
 bh=b9Y0kRvW1k1Fj2IwMJZMARKZAPTv6OSwb9eaW3UWlJM=;
 b=FgR7snfNSk5VHAAv4IQbLUXOfRTp7ZJ1vLMkNtzhLb7F48qMDsGnhHith3qhmXyozGBY3UKIC
 VEPaaQKnOQXaRvuHOzyJciE315phtVcrRqFxe+1l4n6hy+fC5wJBiFYIOH22ui/Os/qcnSTlT4N
 Eo/ULrsYwTFAhzI7jK0r2P/w2mrAyb25qX/i+shDXmB+A7cJXaezIoOTYImnpbGkR/qFg+5khTr
 GMBxYrci6s98hBLCn+PF3/CBk7+CqIYJ4M5W3sMqCFTpvMw/iLivkhAo7qTBXRAqzJ1m/pTZKGt
 t24j5uTLObDbIuwpodlPIAGTHu1o4FyJwNxJTMYkbHOg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk35xx-generic: Disable late boardinfo
Date: Sat,  2 Nov 2024 21:30:01 +0000
Message-ID: <20241102213004.3644543-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672699e2922720f2eae90bdf
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

Disable DISPLAY_BOARDINFO_LATE as the early boardinfo print of Model
should be enough.

  U-Boot 2025.01-rc1 (Nov 02 2024 - 16:04:16 +0000)

  Model: Generic RK3566/RK3568
  DRAM:  8 GiB (effective 7.7 GiB)
  Core:  250 devices, 24 uclasses, devicetree: separate
  MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
  Loading Environment from nowhere... OK
  In:    serial@fe660000
  Out:   serial@fe660000
  Err:   serial@fe660000
  Model: Generic RK3566/RK3568
  Hit any key to stop autoboot:  0
  =>

Enable CMD_MISC to make it easier to inspect data in OTP.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/generic-rk3568_defconfig | 2 +-
 configs/generic-rk3588_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 1d06f3411fe0..f79f0e84400b 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
@@ -31,6 +30,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index ebe883ed5972..51e31dce3a96 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -18,13 +18,13 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-- 
2.46.2

