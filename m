Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DA5D3E773
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83E4891E4;
	Tue,  5 Nov 2024 22:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Eu3oaoZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78919891D7; Tue,  5 Nov 2024 22:52:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 420D98917B
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843563; bh=fR2O0I1RPYhlz9T2FyOEySE4TIM2CPflb+Uh3Tv4Eg8=;
 b=Eu3oaoZTznMwbS1jqGm2Jma3aWNgeKVfTlGj5L1dhCFurSA6hbwHZZ5hNcoHAJQeHQ6Sj+jD9
 e10M4MxN9/1YN7YvwawrlWg7advwBfUdglBSLtBFmKdrCAlVmp2eEijuFIhkQsheYEgCK48Fs6n
 tIMIrhr3F0W/NoSYzIhWgZB2VgIMD1CfrgYCr1cOFkKPdTrwRqT7Ly+puQttiTuHcLvCFizxltV
 rv2GPepKTEZWbz0ZcW8qjpNhOthPD0a0pgErTFzFzUsIz/x0GunYILNNobrthXVDdqynAZWWBay
 nvQEFv1wZWFJQgQammdAiafcyf/kYCcBGmL3lo5NVD8A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/11] rockchip: rk3288-miqi: Drop use of silent console and
 late boardinfo
Date: Tue,  5 Nov 2024 21:51:43 +0000
Message-ID: <20241105215202.1491441-8-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 672a93a8059db14dd83d7b4a
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
 configs/miqi-rk3288_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 87fd256c8a53..678d6fb33716 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -20,8 +20,6 @@ CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-miqi.dtb"
 CONFIG_MISC_INIT_R=y
-CONFIG_SILENT_CONSOLE=y
-CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
-- 
2.46.2

