Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B46C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C2E80F9E;
	Mon, 27 Jan 2025 00:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="S4i/mkEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA84080F96; Mon, 27 Jan 2025 00:48:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A779880EF4
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1737935326;
 bh=5c91dgrTSQWGwcuyLS5dQrqJHlQyBusUSwlquu2OsLM=;
 b=S4i/mkEJs1rCPLSIYFBKPxiuR2tBGJK6hCPlO0xxI9/d2UscQ96srInCL+2SM0oMA8oeXhhiY
 onoe0QpshnoM0vB+25i4Rhtim1bzSyo+ynGjuJSSa7Zy0TU3DdoNBu4FquvJjhpvSPOGy3Z67xn
 jiZwjy8z4ZYDttuGMbG3nBWYOLkwFonKYr+gM4dxqH2Gu6KlUMb0t4//IGwAcCe4LJktZoqW4mv
 RVjfKOZ4OQG8wSk2O9vMpGm3iJVYGsWrDQBEvDnBS+XQQzr5c7gqDES9ZbzDIugnKQskFrzqQ5K
 sHH7c7wlf8eoMCpcUwaZGC4GEg+8MJqVvZSjQ7W4uEcw==
X-Forward-Email-ID: 6796c9db4079df9fc6c0dd32
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/5] rockchip: ROCKCHIP_COMMON_STACK_ADDR improvements
Date: Sun, 26 Jan 2025 23:48:25 +0000
Message-ID: <20250126234838.561065-1-jonas@kwiboo.se>
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

Use of the Kconfig symbol ROCKCHIP_COMMON_STACK_ADDR is currently
not working well when a SoC needs to use a custom tpl.c and the default
values are only working when DRAM base address is 0x0.

This series changes to not imply TPL_ROCKCHIP_COMMON_BOARD and instead
let each SoC symbol decide. It also adds default values for the two
other used DRAM base addresses, 0x60000000 and 0x40000000. Finally, it
also moves imply of ROCKCHIP_EXTERNAL_TPL under each SoC symbol.

Jonas Karlman (5):
  rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under SoC Kconfig
    symbol
  rockchip: Improve ARMv7 support for ROCKCHIP_COMMON_STACK_ADDR
  rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under SoC Kconfig
    symbol
  rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol
  rockchip: Add RK3576 support for ROCKCHIP_COMMON_STACK_ADDR

 arch/arm/mach-rockchip/Kconfig        | 67 ++++++++++++++++++++-------
 arch/arm/mach-rockchip/px30/Kconfig   |  3 --
 arch/arm/mach-rockchip/rk3308/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3328/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3399/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3568/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3588/Kconfig |  3 --
 7 files changed, 50 insertions(+), 35 deletions(-)

-- 
2.48.1

