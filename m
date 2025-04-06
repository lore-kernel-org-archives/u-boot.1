Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E71C36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09FE382B27;
	Sun,  6 Apr 2025 02:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="KG7UVYLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AC782B1F; Sun,  6 Apr 2025 02:25:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05BED82AAF
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1743899099;
 bh=iTt6jSkcaSkpAIwsyf74QKsMxutp5cTCD7V7Jsc36Ps=;
 b=KG7UVYLL7O4XJk9/ztPx4pkAWiTsv+O4IvuoojlAHQDaH9tvjvQBErvSJLdM23yPWDtssba85
 7hEhuGHQ7ckLzkiGHDaGN9JtphKDytlEbzjGq8lmeNZTrW4oR4VOE2Y00aD5at956BcUhxFeBVK
 aWeGtkiWMy9wL4mUicmY0lAyfYJd90yQichCuLqSVwgyCvpBaPxd8rn/zYc5wPKyteAIiBoNZS8
 UQqxUE2OyHj3UdC3p6JslWB2Nj62RuOdlXBaVijD6Y6R8PO//qvUgXBGgXh1l/FbV4PC56pbide
 CHmOrw/SDz+d50rSpbFdG3WQoDocDxg0Id0zHvIHUZVQ==
X-Forward-Email-ID: 67f1c9d5fb2b6fde09d69f00
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/11] rockchip: Small cleanups for RK356x and RK3588
Date: Sun,  6 Apr 2025 00:24:21 +0000
Message-ID: <20250406002447.1555596-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

This series add small cleanups for RK356x and RK3588.

These are small changes that was implemented while working on RK3528 [1]
and future RK3506 [2] support. Similar changes has also been recommended
for a v2 of the RK3576 series.

This also add the meminfo and rng commands to the generic-rk3568/rk3588
board targets.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506

Jonas Karlman (11):
  rockchip: rk3588: Use hptimer reg names in rockchip_stimer_init
  rockchip: Remove partitions env variable for RK356x
  rockchip: Remove partitions env variable for RK3588
  rockchip: Ensure device settings is defined before rk3568_common.h
  rockchip: Ensure device settings is defined before rk3588_common.h
  rockchip: Use rk3568_common.h by default for RK356x boards
  rockchip: Use rk3588_common.h by default for RK3588 boards
  rockchip: rk3568: Drop BOARD_LATE_INIT from target config
  rockchip: rk3588: Drop BOARD_LATE_INIT from target config
  rockchip: Enable meminfo and rng commands for Generic RK3566/RK3568
  rockchip: Enable meminfo and rng commands for Generic RK3588

 arch/arm/mach-rockchip/rk3568/Kconfig   |  4 +++-
 arch/arm/mach-rockchip/rk3588/Kconfig   | 23 +++--------------------
 arch/arm/mach-rockchip/rk3588/rk3588.c  | 19 +++++++++++++------
 configs/generic-rk3568_defconfig        |  3 +++
 configs/generic-rk3588_defconfig        |  3 +++
 include/configs/anbernic-rgxx3-rk3566.h |  4 ++--
 include/configs/evb_rk3568.h            |  4 ++--
 include/configs/evb_rk3588.h            |  4 ++--
 include/configs/khadas-edge2-rk3588s.h  |  4 ++--
 include/configs/powkiddy-x55-rk3566.h   |  4 ++--
 include/configs/rk3568_common.h         |  5 ++++-
 include/configs/rk3588_common.h         |  5 ++++-
 include/configs/toybrick_rk3588.h       |  4 ++--
 13 files changed, 45 insertions(+), 41 deletions(-)

-- 
2.49.0

