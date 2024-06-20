Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2BDC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 10:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A6788535;
	Thu, 20 Jun 2024 12:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A118852E; Thu, 20 Jun 2024 12:25:02 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50F087C7E
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W4c7J35DWzC6W;
 Thu, 20 Jun 2024 12:25:00 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W4c7H2KQgzpl7; Thu, 20 Jun 2024 12:24:59 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/2] rockchip: theobroma: use HTTPS for git URLs and
 drop RK3368 Lion support
Date: Thu, 20 Jun 2024 12:24:49 +0200
Message-Id: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEDdGYC/x3MQQqDMBBG4avIrB1I01bQqxQXafJXB0qUZJBA8
 O4Gl9/ivUoZSZBp6iolHJJliw2PviO/uriAJTSTNfZlBmtYc+BVdedFlP1/i+D30xu4YXThC2r
 hnvCTck8/FFGU5vO8AFyirSlqAAAA
To: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
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

Nobody at Theobroma has booted Lion since at least July 2021 and the
last meaningful changes were made in February 2021.
The product isn't listed on our website anymore.

Therefore let's remove its support.

Additionally, migrate git URLs in MAINTAINERS to use https:// instead of
git:// as it's more user-friendly (and also that git:// was only
supported for Puma repo until yesterday).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      rockchip: theobroma-systems: migrate git URLs to HTTPS
      rockchip: remove support for Theobroma Systems RK3368 Lion

 arch/arm/dts/rk3368-lion-haikou-u-boot.dtsi       | 119 --------
 arch/arm/dts/rk3368-lion-haikou.dts               | 144 ----------
 arch/arm/dts/rk3368-lion.dtsi                     | 318 ----------------------
 arch/arm/mach-rockchip/rk3368/Kconfig             |  22 --
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS |   2 +-
 board/theobroma-systems/lion_rk3368/Kconfig       |  18 --
 board/theobroma-systems/lion_rk3368/MAINTAINERS   |  10 -
 board/theobroma-systems/lion_rk3368/README        |  78 ------
 board/theobroma-systems/puma_rk3399/MAINTAINERS   |   2 +-
 board/theobroma-systems/ringneck_px30/MAINTAINERS |   2 +-
 board/theobroma-systems/tiger_rk3588/MAINTAINERS  |   2 +-
 configs/lion-rk3368_defconfig                     | 110 --------
 doc/board/rockchip/rockchip.rst                   |   1 -
 include/configs/lion_rk3368.h                     |  16 --
 14 files changed, 4 insertions(+), 840 deletions(-)
---
base-commit: e124e630ad694327e33d6513e43951793e827d3a
change-id: 20240620-tsd-http-git-clone-53c0ea69adbe

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

