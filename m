Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AD6C3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C6B82B63;
	Sun,  6 Apr 2025 02:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ak+RwDos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24E482BD7; Sun,  6 Apr 2025 02:25:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17D282B54
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899132; bh=kA5pZguueH7yrP7Rq2XGpv7EpWt8hZ3Lpmnj22xc+T0=;
 b=ak+RwDoss8YEaQpCc6HQk7vXsyZFvGuqAj+3DyBeXeskJNFud1ly7mwsdxydsicok7sTys+6y
 TVY3HITw/XNx6TZK/woROxaXh52IopQFb4DearspyMda+pziGleCDWGLMVsw75rn57MBpm8VDm+
 b2cxf//XaCgFxhelyTjKWZ9PclrOPceVBvfVNr6H8i3ibsdi3WT+Iy9YbKWgdT3ih88jQCTSCht
 U3rn11RMCu/865WVUIR+W8Dj5OWppIXH1tY5R6EJrwCVjz8n5oYYfpzA0B6lVqcmKLH3HWDruMN
 9xE5to/jFTa/xYNHYUQyCLo3sqiZw6XPaZfjlvQMOAjw==
X-Forward-Email-ID: 67f1c9f8fb2b6fde09d69ff2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 10/11] rockchip: Enable meminfo and rng commands for Generic
 RK3566/RK3568
Date: Sun,  6 Apr 2025 00:24:31 +0000
Message-ID: <20250406002447.1555596-11-jonas@kwiboo.se>
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

The meminfo and rng commands are helpful for testing, enable them.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/generic-rk3568_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index f79f0e84400b..76418ba7032c 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -28,6 +28,8 @@ CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MISC=y
@@ -35,6 +37,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-- 
2.49.0

