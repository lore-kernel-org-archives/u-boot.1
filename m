Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6960C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 22:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06DAC80836;
	Sat,  8 Feb 2025 23:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ss9elT4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845CA80805; Sat,  8 Feb 2025 23:49:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64510807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 23:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1739054994;
 bh=NbfspYkXJ/zxbWo0Y3ml4BSMy0XPNXk+qlZMNyCsczM=;
 b=Ss9elT4G9GaenIgpNyA0WQLV4OXU6446h7xy8Tz97SdsJK8W7WcEQZiYBYNJZzy2A8J+uUMm2
 fuu5DtuXChD/Wzrj8ptZs1hlwTht+mEiqvFYuQjIf/HlyYDfCXprYXSE4MO8QQs2d74mhNRIPKJ
 2AZHlqOokUWmY1DU/KwQNo6pFGGcGAs99s6TeB1VkCCP5kLKPk2OfQyieCMszHCVfMLpQAuI9u5
 wuksWC5bPXqnKZBLDw2O/8KSYW0SXs0wuaM3UaoPZVOGXlPRDemoQYoL5I2AjNBR2ehVKBNIq+A
 CCSGsPhh+zl++XoubFeLJQmVSA5BEb9uQOocd/8pt3Pw==
X-Forward-Email-ID: 67a7df8d771e645baa15e296
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: rk3399-gru: Fix missing TPL and SPL banner on
 debug UART
Date: Sat,  8 Feb 2025 22:49:37 +0000
Message-ID: <20250208224945.2641933-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
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

The PP1500 and PP3000 power rails must be on very early for the U-Boot
TPL and SPL banner to be shown on debug UART for bob and kevin.

This series restore the early power on of these power rails in
board_debug_uart_init() for both TPL and SPL to restore the missing
U-Boot TPL/SPL banner.

The reverted patches was introduced in v2024.04-rc1.

Jonas Karlman (3):
  Revert "rockchip: rk3399: Drop unneeded bob and kevin board specific
    code"
  rockchip: rk3399-gru: Enable TPL_GPIO for bob and kevin
  Revert "rockchip: rk3399: Fix TPL build of bob and kevin"

 arch/arm/mach-rockchip/rk3399/rk3399.c | 23 ++++++++++++++++++++++-
 configs/chromebook_bob_defconfig       |  1 +
 configs/chromebook_kevin_defconfig     |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.48.1

