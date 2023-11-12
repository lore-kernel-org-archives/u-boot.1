Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6715AC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 17:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B94686FBF;
	Sun, 12 Nov 2023 18:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kmjf/c+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 776D186DCE; Sun, 12 Nov 2023 18:49:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4C0C86F26
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 18:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4dd=G2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1699811349;
 bh=4LjvOV2bZT7eLCUAp5HoKih04rL1pkEqcEOd8OCKiZA=;
 b=kmjf/c+RIXG6zOET4Ki3H1kGVjJr4YB8y0dkatwUKwG5gfeOEk2s1mRZxO9vdOrz3hu7znGZd
 Uo0TnE0umGRhpjM7QrhrQz077rp8ifPuIw+FKwtrhVMWgsNE1WpOYhvbU9WAfBXOJ0/PQQGpH7f
 HFEBdb1MSCsHf+jjNGxSUao2que4keEchytHctNOvhpBavJOaDhQoIE1tp7H3gQ3SnW4A7XkUnG
 qKOu2tmrQKz2DYcqfa/PCoRhMRMs+93dCgTLZ/31BhB4oLBs/IEQpgtCUidYTp13kjHRUFskB1X
 xsoEXoQ/8Y0/42lCl9/aV6KPBmQdej4iZ63em+6yzitw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] rockchip: Use dwc3-generic driver on RK3328 and RK3399
Date: Sun, 12 Nov 2023 17:48:56 +0000
Message-ID: <20231112174904.1581187-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6551101533f2b3120541d691
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

Changes in v2:
- Drop DM_USB_GADGET related changes from first patch
- Add DM_USB_GADGET condition to arch Kconfig

Jonas Karlman (2):
  configs: rockchip: Use dwc3-generic driver on RK3328 and RK3399
  rockchip: board: Remove dwc3 usb init and gadget handler functions

 arch/arm/Kconfig                              |  1 +
 arch/arm/mach-rockchip/board.c                | 30 +------------------
 configs/chromebook_bob_defconfig              |  2 +-
 configs/chromebook_kevin_defconfig            |  2 +-
 configs/eaidk-610-rk3399_defconfig            |  4 ++-
 configs/evb-rk3399_defconfig                  |  1 -
 configs/firefly-rk3399_defconfig              |  1 -
 configs/khadas-edge-captain-rk3399_defconfig  |  4 ++-
 configs/khadas-edge-rk3399_defconfig          |  4 ++-
 configs/khadas-edge-v-rk3399_defconfig        |  4 ++-
 configs/leez-rk3399_defconfig                 |  4 ++-
 configs/nanopc-t4-rk3399_defconfig            |  3 +-
 configs/nanopc-t6-rk3588_defconfig            |  1 -
 configs/nanopi-m4-2gb-rk3399_defconfig        |  4 ++-
 configs/nanopi-m4-rk3399_defconfig            |  4 ++-
 configs/nanopi-m4b-rk3399_defconfig           |  4 ++-
 configs/nanopi-neo4-rk3399_defconfig          |  4 ++-
 configs/nanopi-r4s-rk3399_defconfig           |  3 +-
 configs/orangepi-5-plus-rk3588_defconfig      |  1 -
 configs/orangepi-5-rk3588s_defconfig          |  1 -
 configs/orangepi-r1-plus-lts-rk3328_defconfig |  3 +-
 configs/orangepi-r1-plus-rk3328_defconfig     |  3 +-
 configs/orangepi-rk3399_defconfig             |  4 ++-
 configs/pinebook-pro-rk3399_defconfig         |  1 -
 configs/pinephone-pro-rk3399_defconfig        |  1 -
 configs/puma-rk3399_defconfig                 |  1 -
 configs/roc-pc-mezzanine-rk3399_defconfig     |  1 -
 configs/roc-pc-rk3399_defconfig               |  1 -
 configs/rock-4c-plus-rk3399_defconfig         |  1 -
 configs/rock-4se-rk3399_defconfig             |  1 -
 configs/rock-pi-4-rk3399_defconfig            |  1 -
 configs/rock-pi-4c-rk3399_defconfig           |  1 -
 configs/rock-pi-n10-rk3399pro_defconfig       |  1 -
 configs/rock5a-rk3588s_defconfig              |  1 -
 configs/rock5b-rk3588_defconfig               |  1 -
 configs/rock960-rk3399_defconfig              |  3 +-
 configs/rockpro64-rk3399_defconfig            |  1 -
 drivers/usb/host/Kconfig                      |  1 -
 38 files changed, 44 insertions(+), 65 deletions(-)

-- 
2.42.0

