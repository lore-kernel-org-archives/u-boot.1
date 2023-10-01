Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C828FE78480
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC05F870D5;
	Sun,  1 Oct 2023 21:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WFrgR35d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A034870D5; Sun,  1 Oct 2023 21:17:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4C386D14
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4bc4=FQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1696187856;
 bh=R0IUk03fFsxrSlIjmQNXkV36Ls6mkx/l0s6vSKIfAME=;
 b=WFrgR35d87EbB5n3Wbt5/WioQVZ+tjNTe5YVHaButzt2jL22m4kX+joT4h5diAtZf2MDvtAUG
 gZKychhJcAJdH8HesqOU/w7J5SELcS8TgZz2bQOrawZRbiIQspm9qyGlEqfBVFg5OCsAXowPgtE
 l21E9UU7ws61vTf/Nj32E2QsaVZc6SWY0z3D468DxCl1p+Jc6ZzmvPnQJn+cR+oMwf6nDaXbAHx
 D7+Zj+xDY8PCFgEDNhkBY1ORf2W7tEqT9y5uVOp63r5ZYXRaauJg1ahIzlzOpKngr2UscV2agbV
 LeGpuTX8U6KB5Ap5aOLlqZmkLmPT6BXjHS/4GZzkBn2g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: David Wu <david.wu@rock-chips.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Frank Wunderlich <frank-w@public-files.de>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/7] rockchip: Add GMAC support for RK3568 and RK3588
Date: Sun,  1 Oct 2023 19:17:15 +0000
Message-ID: <20231001191730.4167035-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6519c5cf25909c3c56c79d7c
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

This series adds a glue driver, dwc_eth_qos_rockchip, to support GMAC
on RK356x and RK3588.

rk_gmac_ops used in this series has been ported from mainline linux.

Patch 1-3 does some minor cleanup in dwc_eth_qos driver.
Patch 4 add glue driver with RK3568 support.
Patch 5 add support for RK3588 to glue driver.
Patch 6-7 update defconfigs to enable use of the new driver.

Changes in v2:
- Add comment about ported code intentionally left close to 1:1 with linux
- Add lubancat-2-rk3568_defconfig changes
- Add rock5b-rk3588_defconfig changes
- Collect r-b tags

Dependencies:
- "rockchip: Port IO-domain driver for RK3568 from linux" [1]

dhcp and ping commands has been tested on the followin devices:
- RK3566: Quartz64 Model A and SOQuartz on Blade
- RK3568: ROCK 3 Model A
- RK3588: ROCK 5 Model A

This series can also be found at [2].

[1] https://patchwork.ozlabs.org/cover/1823769/
[2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk35xx-gmac-v2

Jonas Karlman (7):
  net: dwc_eth_qos: Drop unused rx_pkt from eqos_priv
  net: dwc_eth_qos: Return error code when start fails
  net: dwc_eth_qos: Stop spam of RX packet not available message
  net: dwc_eth_qos: Add glue driver for GMAC on Rockchip RK3568
  net: dwc_eth_qos_rockchip: Add support for RK3588
  configs: rockchip: Enable ethernet driver on RK356x boards
  configs: rockchip: Enable ethernet driver on RK3588 boards

 configs/evb-rk3568_defconfig              |   6 +-
 configs/evb-rk3588_defconfig              |   5 +-
 configs/lubancat-2-rk3568_defconfig       |   3 +
 configs/nanopi-r5s-rk3568_defconfig       |   3 +
 configs/neu6a-io-rk3588_defconfig         |   2 -
 configs/neu6b-io-rk3588_defconfig         |   2 -
 configs/odroid-m1-rk3568_defconfig        |   3 +
 configs/quartz64-a-rk3566_defconfig       |   3 +
 configs/quartz64-b-rk3566_defconfig       |   3 +
 configs/radxa-cm3-io-rk3566_defconfig     |   6 +-
 configs/rock-3a-rk3568_defconfig          |   5 +-
 configs/rock5a-rk3588s_defconfig          |   5 +-
 configs/rock5b-rk3588_defconfig           |   3 +-
 configs/soquartz-blade-rk3566_defconfig   |   3 +
 configs/soquartz-cm4-rk3566_defconfig     |   3 +
 configs/soquartz-model-a-rk3566_defconfig |   3 +
 drivers/net/Kconfig                       |   8 +
 drivers/net/Makefile                      |   1 +
 drivers/net/dwc_eth_qos.c                 |  33 +-
 drivers/net/dwc_eth_qos.h                 |   3 +-
 drivers/net/dwc_eth_qos_rockchip.c        | 522 ++++++++++++++++++++++
 21 files changed, 590 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/dwc_eth_qos_rockchip.c

-- 
2.42.0

