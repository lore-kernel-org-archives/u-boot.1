Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B27CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 22:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016A886FFA;
	Thu, 19 Oct 2023 00:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iyfqWj+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A2D86EE0; Thu, 19 Oct 2023 00:31:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979AC86E7E
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 00:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bda0=GB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1697668263;
 bh=60qF6fXCfhls2jHzAlDJ6Us0agVRW/crXtXHn4ZWooQ=;
 b=iyfqWj+cGBJeJYcgk76YMB+m80Ph7M0KBK0UgiqxkCaSK5MKLEhhZFQrqemVmPQTBZPCKst9d
 iW7Acj5HFzTNTeeVz6QrQtqTcf/AFQgwwCIaIWgJHcSE4GTYNrVwvDc1xWrU6tZbToYwkG0vvto
 VS+WcBz7TK3zqwJbjpc/w/tfAJ2NgPIlPkOjxGgx+zdwMTWoF0NlvM7a36eyQZi2nLNhEv9clUI
 E5BpWPck6eYzvKr0hDTSn2ly57svyrLpc3FL0acrxwfegJyEF7FNQIvB19wXJd8yWZHhOO9tH/V
 kkXwlSgxM4vgRmYoYnXWGaGTfjl+vNBr4ZFFwMRS2zcw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: Use dwc3-generic driver on RK3328 and RK3399
Date: Wed, 18 Oct 2023 22:30:50 +0000
Message-ID: <20231018223058.2081052-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65305ca753b629052bafed6c
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

This series change to use the dwc3-generic driver on all RK3328 and
RK3399 boards. Also switch to use DM_USB_GADGET and remove then obsolete
board_usb_init() and dm_usb_gadget_handle_interrupts() functions.

First patch change all RK33xx boards to use dwc3-generic driver.
Second patch remove obsolete rk3399 usb gadget functions.

This has been tested and validated on rockpro64 and rock-pi-4 boards.

Jonas Karlman (2):
  configs: rockchip: Use dwc3-generic driver on RK3328 and RK3399
  rockchip: board: Remove dwc3 usb init and gadget handler functions

 arch/arm/mach-rockchip/board.c                | 24 -------------------
 configs/chromebook_bob_defconfig              |  2 +-
 configs/chromebook_kevin_defconfig            |  2 +-
 configs/eaidk-610-rk3399_defconfig            |  4 +++-
 configs/evb-rk3399_defconfig                  |  1 -
 configs/firefly-rk3399_defconfig              |  1 -
 configs/khadas-edge-captain-rk3399_defconfig  |  4 +++-
 configs/khadas-edge-rk3399_defconfig          |  4 +++-
 configs/khadas-edge-v-rk3399_defconfig        |  4 +++-
 configs/leez-rk3399_defconfig                 |  4 +++-
 configs/nanopc-t4-rk3399_defconfig            |  4 +++-
 configs/nanopi-m4-2gb-rk3399_defconfig        |  4 +++-
 configs/nanopi-m4-rk3399_defconfig            |  4 +++-
 configs/nanopi-m4b-rk3399_defconfig           |  4 +++-
 configs/nanopi-neo4-rk3399_defconfig          |  4 +++-
 configs/nanopi-r4s-rk3399_defconfig           |  3 ++-
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  3 ++-
 configs/orangepi-r1-plus-rk3328_defconfig     |  3 ++-
 configs/orangepi-rk3399_defconfig             |  4 +++-
 configs/pinebook-pro-rk3399_defconfig         |  1 -
 configs/pinephone-pro-rk3399_defconfig        |  1 -
 configs/puma-rk3399_defconfig                 |  1 -
 configs/roc-pc-mezzanine-rk3399_defconfig     |  2 +-
 configs/roc-pc-rk3399_defconfig               |  2 +-
 configs/rock-4c-plus-rk3399_defconfig         |  2 +-
 configs/rock-4se-rk3399_defconfig             |  2 +-
 configs/rock-pi-4-rk3399_defconfig            |  2 +-
 configs/rock-pi-4c-rk3399_defconfig           |  2 +-
 configs/rock-pi-n10-rk3399pro_defconfig       |  2 +-
 configs/rock960-rk3399_defconfig              |  3 ++-
 configs/rockpro64-rk3399_defconfig            |  1 -
 drivers/usb/host/Kconfig                      |  1 -
 32 files changed, 50 insertions(+), 55 deletions(-)

-- 
2.42.0

