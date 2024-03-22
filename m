Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DF9C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 20:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA37C88159;
	Fri, 22 Mar 2024 21:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Sc4QILvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497FD87FA3; Fri, 22 Mar 2024 21:50:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC24C87D87
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 21:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b79c=K5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1711140633;
 bh=dvkR7IY6w2JMkoOfrrLhRAzQB9cyAgblmh2srpRl1Eg=;
 b=Sc4QILvqbUoEp36YP3jIK8F5+VOe9vsjrc2uF1yz1Yh2Isopyyob+61DZQfCUxkUdqHvHr81m
 mC6aqbwws3eI6zhM6jl2FfmbpoO7dFykmKhTbeJy3shXzn8tJGknNdezfGAwtWPjILBIumYsrlX
 USyhzrX5JbjXvCBbzUK7rzW+VILhiB+JTOKbPOTfA4fUz8URevvtQTbqZc/ea5LgTdGmaILaaJ6
 U+Gg96kYG3j6UFpxoEJXJo/YTfSrxazTyq+KBYpQ1qCik1IB8XsQdv2NIoP7Qdrm6LvXAg119ha
 L2J9uIk/uFl08klQtLJdIyDeSJPnMro+xUAc8lzq3tkQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>, Dragan Simic
 <dsimic@manjaro.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] rockchip: spl: Cache boot source id for later use
Date: Fri, 22 Mar 2024 20:50:19 +0000
Message-ID: <20240322205027.3860170-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65fdef191b2ab365f8308afa
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

This series fixes an issue where /chosen/u-boot,spl-boot-device prop
cannot be resolved to the SPI flash node path in spl_perform_fixups() if
the affected device was booted from SPI flash.

Changes in v2:
- Add patch that sync boot source id enum with bootrom
- Add patch that adds missing SPI flash node path for SoCs with DTs
  having a jedec,spi-nor compatible flash@0 node.
- Only cache boot source id that can be resolved to a node path
- Make use of synced BROM_BOOTSOURCE_UNKNOWN enum value
- Update commit message
- Add fixes tag
- Collect r-b tag

Jason Zhu (1):
  rockchip: bootrom: Sync bootsource id enum from bootrom

Jonas Karlman (2):
  rockchip: spl: Cache boot source id for later use
  rockchip: spl: Add SPI NOR flash to boot_devices array

 arch/arm/include/asm/arch-rockchip/bootrom.h |  3 +++
 arch/arm/mach-rockchip/px30/px30.c           |  1 +
 arch/arm/mach-rockchip/rk3288/rk3288.c       |  1 +
 arch/arm/mach-rockchip/rk3308/rk3308.c       |  1 +
 arch/arm/mach-rockchip/rk3368/rk3368.c       |  1 +
 arch/arm/mach-rockchip/rv1126/rv1126.c       |  1 +
 arch/arm/mach-rockchip/spl.c                 | 14 +++++++++++---
 7 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.43.2

