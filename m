Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0221E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DB2801DA;
	Thu, 12 Dec 2024 23:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="A7F9QNrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5732801ED; Thu, 12 Dec 2024 23:10:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4762801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1734041410;
 bh=Xba3ZEyU44MOA1fDQgtKwHECJa9rMJC/xBDoR8A6n2U=;
 b=A7F9QNrHMNqQJd5D87eKLpVR/1CnAZlhvpSTRVpzBqfUv1XwlW3k/5pTT/zWIydmllkVh1I93
 CrR98I8XegvKDBBJk8na6NZA1pQVvtasPxjCciHhixhrnEWqlR/FWFiHtaZCrUfer2v0gNzK1Ja
 bxflW0cIUn/xFm7eIyqX1rj1QAS3y3iSg+J9Hkv8CUoUqYckQoT67Zixx523VJmah0npSuuKoVK
 V+Uef8TcS16BsUVl3vonDvZpVj4gEa/Xc8UU1gtALOImqWRHcCU+LrZB6fPIenO58ppUu1upWV1
 BvJmQbiS5fbsRsIr7weIH/HnOeJPUTwozT6pc2zDMqww==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/11] rockchip: rk3288-firefly: Migrate to OF_UPSTREAM
Date: Thu, 12 Dec 2024 22:09:33 +0000
Message-ID: <20241212221000.94501-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b5f3fa511ed8f0b3fc7d5
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

This series migrate Firefly-RK3288 to use OF_UPSTREAM, ensure devices
and pinctrl is included in xPL control FDT, set ethaddr based on cpuid
and finally change to use FIT with checksum validation.

I do not have a Firefly-RK3288 board and have only done limited runtime
test, with adjusted sdram props, on a Tinker Board.

This series have a loose dependency on the "rockchip: rk3288-tinker:
Migrate to OF_UPSTREAM" series. Specifically that series change of
SYS_MALLOC_F_LEN and its TPL variant in Kconfig.

Jonas Karlman (11):
  rockchip: rk3288-firefly: Drop unused SPL_LED related code
  rockchip: rk3288-firefly: Sort u-boot.dtsi nodes alphabetically
  rockchip: rk3288-firefly: Set ethaddr env based on cpuid
  rockchip: rk3288-firefly: Use common bss and stack addresses
  rockchip: rk3288-firefly: Include required DT nodes in xPL
  rockchip: rk3288-firefly: Include sdmmc regulator in SPL
  rockchip: rk3288-firefly: Drop use of silent console and late
    boardinfo
  rockchip: rk3288-firefly: Drop USE_PREBOOT Kconfig option
  rockchip: rk3288-firefly: Migrate to OF_UPSTREAM
  rockchip: rk3288-firefly: Fix slow Ethernet initializion
  rockchip: rk3288-firefly: Change to use FIT

 arch/arm/dts/Makefile                         |   1 -
 arch/arm/dts/rk3288-firefly-u-boot.dtsi       |  91 +++-
 arch/arm/dts/rk3288-firefly.dts               |  43 --
 arch/arm/dts/rk3288-firefly.dtsi              | 491 ------------------
 arch/arm/mach-rockchip/rk3288/Kconfig         |   2 +-
 board/firefly/firefly-rk3288/MAINTAINERS      |   1 +
 board/firefly/firefly-rk3288/Makefile         |   7 -
 board/firefly/firefly-rk3288/firefly-rk3288.c |  46 --
 configs/firefly-rk3288_defconfig              |  39 +-
 9 files changed, 89 insertions(+), 632 deletions(-)
 delete mode 100644 arch/arm/dts/rk3288-firefly.dts
 delete mode 100644 arch/arm/dts/rk3288-firefly.dtsi
 delete mode 100644 board/firefly/firefly-rk3288/Makefile
 delete mode 100644 board/firefly/firefly-rk3288/firefly-rk3288.c

-- 
2.47.1

