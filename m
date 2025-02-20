Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78FBC021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB9680F7B;
	Thu, 20 Feb 2025 22:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Fe4w1IQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC5980F53; Thu, 20 Feb 2025 22:58:54 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197CE80077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1740088730;
 bh=dcpQkM4NuGWsl3Oy8zfz3wrgbcWQEY1ERiERASwwOWE=;
 b=Fe4w1IQO4imQP08avksLkFLfoLPW643mINrfvcA+q2M2OcOvzYbf6QRZtETzslZI6v0m8Et5i
 djOoTVOfqIqzzGZxcBEJJwLET1DrOM2BxKLsnPuXLMDjbcuGoN1F4OfLqB+8nhaZ3c+9HyAkSLa
 w2VS3kDU5VXYjJq5uiKjQ7Au1j9hi/mJB3nhiLE5rwC39X+38JSLh/eguUnB9RxLluq9ohBNrcq
 ZJGD02sbikI9SjOTI8frBQxtf2hpRXdnm3gip6tFlzrvfS33NyuvaSvkooV/XFV8Tc+ymO1a6/G
 3ub2HZJLQJctTAzwQu5ZOVUpMYIV9EGgoQv66ZQPkj0g==
X-Forward-Email-ID: 67b7a59363718a8557eae0ea
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
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
Subject: [PATCH v2 0/6] rockchip: ROCKCHIP_COMMON_STACK_ADDR improvements
Date: Thu, 20 Feb 2025 21:56:54 +0000
Message-ID: <20250220215709.407413-1-jonas@kwiboo.se>
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

The stack-pointer addresses used with ROCKCHIP_COMMON_STACK_ADDR expect
that DRAM is initialized by TPL or ROCKCHIP_EXTERNAL_TPL and that SPL is
loaded to start of DRAM. This series also adds a depend on TPL to ensure
accidental enable of the symbol does not break boards not using TPL+SPL.

Changes in v2:
- Add patch to make ROCKCHIP_COMMON_STACK_ADDR depend on TPL

Jonas Karlman (6):
  rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under SoC Kconfig
    symbol
  rockchip: Make ROCKCHIP_COMMON_STACK_ADDR depend on TPL
  rockchip: Improve ARMv7 support for ROCKCHIP_COMMON_STACK_ADDR
  rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under SoC Kconfig
    symbol
  rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol
  rockchip: Add RK3576 support for ROCKCHIP_COMMON_STACK_ADDR

 arch/arm/mach-rockchip/Kconfig        | 68 ++++++++++++++++++++-------
 arch/arm/mach-rockchip/px30/Kconfig   |  3 --
 arch/arm/mach-rockchip/rk3308/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3328/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3399/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3568/Kconfig |  3 --
 arch/arm/mach-rockchip/rk3588/Kconfig |  3 --
 7 files changed, 51 insertions(+), 35 deletions(-)

-- 
2.48.1

