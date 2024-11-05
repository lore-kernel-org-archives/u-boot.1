Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF6ED2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09C38920A;
	Tue,  5 Nov 2024 17:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="SCRoAN1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBC789209; Tue,  5 Nov 2024 17:01:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFF90891D0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822495; bh=XTIHpyFSVuK5ys3vm5qq0JDcyWuh+fSqP/2W4+oaBnA=;
 b=SCRoAN1xjXq7OnI64AQA6TBX3dvLm3YhryMA2w4LrImrFbqvlbfOEJhdW/oReRQe+6w1WwUn0
 9R0I4a+Wbn+oYMnR3R4iUk0xPNPcexK/ao04w56t5q9WaDnVnzi1yW/SMuMUyyKTNbLY2nVuaqn
 qZ6N38OefBEofwELcwDH0HFrgKCu+oCb3hfPbGoKrd3FYcOQWGOPe0jwRfuBJAjbCTNcpIsM/CG
 0OzYCtrbEdSJhaMG5wkh2Q/LsXVlJ728Vlf3leHRqqI0qmkNrnlW8ecCc0D9Cd2CIues8x0iz5I
 0Umn751o5PiI8dulubUmogI2mcHM9ekJcGCpl1TCUeVw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 09/13] rockchip: rk3288-tinker: Drop use of silent console and
 late boardinfo
Date: Tue,  5 Nov 2024 16:00:32 +0000
Message-ID: <20241105160054.1373319-10-jonas@kwiboo.se>
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
 207.246.76.47
X-ForwardEmail-ID: 672a415dff3e144e4725e186
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
 configs/tinker-rk3288_defconfig   | 2 --
 configs/tinker-s-rk3288_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 0f3d47e1a4fc..fb42b8bcb00d 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -19,8 +19,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-tinker.dtb"
-CONFIG_SILENT_CONSOLE=y
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_CMD_GPIO=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index a013571b2575..f3a392688f02 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -19,8 +19,6 @@ CONFIG_DEBUG_UART=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-tinker-s.dtb"
-CONFIG_SILENT_CONSOLE=y
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_CMD_GPIO=y
-- 
2.46.2

