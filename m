Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF147CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 21:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 254E186F5D;
	Tue, 17 Oct 2023 23:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="eT7axV0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2187B86F5D; Tue, 17 Oct 2023 23:40:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED7F86F07
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 23:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=165c=GA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1697578847;
 bh=yoAZYiAIPdi7CoL7HIAAf4auyRsZpWwDPU+/jQIQMyM=;
 b=eT7axV0D+BrYkg0CL5LYOcG7BkWDFMUv5UZTQ/yySksngKLXq0VRyHnAGc8JICccOBLjBqjmA
 nAm+yWYfWbWzzSi8cuZIorfkOXa/nNfR73COwlQfRHm77gpnDOTSp+Fe+rMmtRetevL0qHQ9Fql
 6zoh/kJMOJoMnRjxm3/Fxy56Ccn5jbJ3XiVxelVUDpkdduWBk5zfmlRQp7ZnPcEnK6WArLBoJHC
 CYXGx97hvVpyiKk5LV0rUtAK2xZghm9jvzPh8GFsEykQVcJxt4h9JFBFrZOdphcO/vWe8/BsWeD
 IH4+iSnUXhJlI672zfeauLIo1MQ/V0hqXhN9zScxgPgw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: Add Xunlong Orange Pi 5 and 5 Plus boards
Date: Tue, 17 Oct 2023 21:40:19 +0000
Message-ID: <20231017214031.1704250-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 652eff5f8bd555e0b7613258
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

This series add support for Xunlong Orange Pi 5 and 5 Plus boards.

First patch add support for the SPI NOR Flash used on the two boards.
Second patch add support for the Xunlong Orange Pi 5 RK3588S board.
Third patch add support for the Xunlong Orange Pi 5 Plus RK3588 board.

This series depends on the following series for a clean apply:
- rockchip: rk3588: Sync pcie and usb3 nodes from linux [1]
- board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board [2]

[1] https://patchwork.ozlabs.org/cover/1850311/
[2] https://patchwork.ozlabs.org/patch/1847842/

Jonas Karlman (2):
  board: rockchip: Add Xunlong Orange Pi 5
  board: rockchip: Add Xunlong Orange Pi 5 Plus

Ricardo Pardini (1):
  mtd: spi-nor: Add support for XMC XM25QU128C

 arch/arm/dts/Makefile                         |   2 +
 .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |  27 +
 arch/arm/dts/rk3588-orangepi-5-plus.dts       | 848 ++++++++++++++++++
 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |  22 +
 arch/arm/dts/rk3588s-orangepi-5.dts           | 662 ++++++++++++++
 board/rockchip/evb_rk3588/MAINTAINERS         |  14 +
 configs/orangepi-5-plus-rk3588_defconfig      | 105 +++
 configs/orangepi-5-rk3588s_defconfig          | 102 +++
 doc/board/rockchip/rockchip.rst               |   2 +
 drivers/mtd/spi/spi-nor-ids.c                 |   1 +
 10 files changed, 1785 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-orangepi-5-plus-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-orangepi-5-plus.dts
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5.dts
 create mode 100644 configs/orangepi-5-plus-rk3588_defconfig
 create mode 100644 configs/orangepi-5-rk3588s_defconfig

-- 
2.42.0

