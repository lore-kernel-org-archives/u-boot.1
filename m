Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B69C561E6
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B7DD404DC;
	Wed,  5 Aug 2026 17:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPwBYjLmHa8R; Wed,  5 Aug 2026 17:51:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08A8D403C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952284;
	bh=o17j/7HwJIBG6qjHriHyzD771L3Q//nXdr0zlyJihD4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IRtuYw1wXiMiiLAP4dH13usG7F5Le98D5Uy+J4/jISvEptpSt6tDvk73RLN7GNE3d
	 KcqyqNzNmRE28bQ3NXldzdJGex8nseb8Abl6dqBxYPmjSibfU1pMD/+rBR3fWH7iPV
	 EK8LYu1c0gGulUwVhPj2CYP6P9SY21yk+AopFuGYthbAlAlc2vpnPCjlcsGsAPQMvF
	 u0dS64r6p7WXinz0P1YHVDM28AMVB+ib6FwsT2g06BT8sAk5/ramOjspyTcaEEKugr
	 tDUo6yIk5uUljuhZ5JL40atzPkQXBBuzY/Oga3ot0OZI4XAze7IeHVG9Qpoq8WgRu9
	 sIZn7cIqJFYPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08A8D403C5;
	Wed,  5 Aug 2026 17:51:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E2AB218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54D6C607B4
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7War7NRJ8kgZ for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4CCF1607CA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CCF1607CA
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CCF1607CA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:51:20 +0000 (UTC)
X-Forward-Email-ID: 6a7376aa5694ca629d62b9b9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/30] rockchip: Add and use rockchip_sysreset_bind() helper
Date: Wed,  5 Aug 2026 17:44:31 +0000
Message-ID: <20260805174509.2968252-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785952279;
 bh=o17j/7HwJIBG6qjHriHyzD771L3Q//nXdr0zlyJihD4=;
 b=dLVjBHBSqdoWTsNaCcxCgG0KA5M7Ige5PbKStJYHDZG7n1ejh0CSeK0s+wgwP6vBwbZ+xxMWk
 krATUAG2sBAzU8x+QySolj887a54UEG/RdgzjZ70PV09rcPMEjX75k6kkZZ3hdu1mLtHrdbrmKh
 f7A7MY/5ms3qVe5CFBvYdA26tuuNbfusW33tCQLk9eBmA6yiyKV9qUcnCwkp6RjHZoT6S8QuW+C
 H4CpQOqV3EKU2Z2phrR0rTP1oAeSGqQidi4KVo1jD5cHIs68/f+1m4whzqpoguGqjt7wmK2Xdzl
 xXhzze2EPNILj1jfDS5+1A8o48tcIjSI+rd21kKCj99g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=dLVjBHBS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Main goal for this series is to remove uses of rockchip_get_cru() helper
in the rockchip_sysreset driver and from the get_reset_cause() helper.

Use of the rockchip_get_cru() abstraction is limiting future potential
use of a single U-Boot proper build targeting multiple RK SoCs, since a
build only can contain an implementation of rockchip_get_cru() tailored
for a single SoC.

This series instead moves the CRU base address to be part of the driver
private data, meaning the CRU compatible help dictate what base address
is going to be used at runtime in the sysreset driver.

It also implements the sysreset get_status() ops to similarly drop the
dependency on rockchip_get_cru() from the cpuinfo get_reset_cause()
helper.

With these changes it should also be possible to use DISPLAY_CPUINFO=y
on most RK SoCs, however because sysreset get_status() ops are now
implemented the print_resetinfo initcall already prints the reset reason
so use of DISPLAY_CPUINFO=y to print reset reason may become obsolete.

Finally, it also fully removes the now unused rockchip_get_cru() helpers
for RK35xx SoCs. A future series should expand this to fully cover
removal for all RK SoCs.

This depends on the following series for a clean apply:
- rockchip: Always init clocks in SPL build for RK35xx [1]
- rockchip: Remove unneeded syscon driver for RK35xx [2]
- rockchip: Remove unused rockchip_get_clk() helpers for RK35xx [3]
and a branch for this series with all depends can be found at [4]

[1] https://patchwork.ozlabs.org/cover/2280555/
[2] https://patchwork.ozlabs.org/cover/2280781/
[3] https://patchwork.ozlabs.org/cover/2281097/
[4] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/sysreset-bind

Jonas Karlman (30):
  sysreset: rockchip: Add rockchip_sysreset_bind() helper
  clk: rockchip: rk3588: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3576: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3568: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3528: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3506: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3399: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3368: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3328: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3308: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3288: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk322x: Use rockchip_sysreset_bind() helper
  clk: rockchip: px30: Use rockchip_sysreset_bind() helper
  clk: rockchip: rv1126: Use rockchip_sysreset_bind() helper
  clk: rockchip: rv1108: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3188: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3128: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3066: Use rockchip_sysreset_bind() helper
  clk: rockchip: rk3036: Use rockchip_sysreset_bind() helper
  sysreset: rockchip: Remove use of rockchip_get_cru()
  sysreset: rockchip: Implement get_status() ops
  rockchip: rk3399-roc-pc: Drop get_reset_cause() call
  rockchip: cpuinfo: Use sysreset_get_status() helper
  rockchip: rk3588: Remove unneeded rockchip_cru alias
  rockchip: rk3568: Remove unneeded rockchip_cru alias
  rockchip: rk3568: Remove unused rockchip_get_cru() helper
  rockchip: rk3588: Remove unused rockchip_get_cru() helper
  rockchip: rk3576: Remove unused rockchip_get_cru() helper
  rockchip: rk3528: Remove unused rockchip_get_cru() helper
  rockchip: rk3506: Remove unused rockchip_get_cru() helper

 arch/arm/include/asm/arch-rockchip/clock.h    |  20 +++-
 arch/arm/include/asm/arch-rockchip/cru.h      |  17 ---
 arch/arm/include/asm/arch-rockchip/cru_px30.h |   3 +
 .../include/asm/arch-rockchip/cru_rk3036.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk3066.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk3128.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk3188.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk322x.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk3288.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk3308.h    |   1 +
 .../include/asm/arch-rockchip/cru_rk3328.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk3368.h    |   2 +
 .../include/asm/arch-rockchip/cru_rk3399.h    |   3 +
 .../include/asm/arch-rockchip/cru_rk3506.h    |   1 +
 .../include/asm/arch-rockchip/cru_rk3568.h    |   4 +-
 .../include/asm/arch-rockchip/cru_rk3576.h    |   2 +-
 .../include/asm/arch-rockchip/cru_rk3588.h    |   4 +-
 .../include/asm/arch-rockchip/cru_rv1108.h    |   2 +
 .../include/asm/arch-rockchip/cru_rv1126.h    |   2 +
 arch/arm/mach-rockchip/cpu-info.c             |  50 +++------
 arch/arm/mach-rockchip/rk3506/Makefile        |   1 -
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |  10 --
 arch/arm/mach-rockchip/rk3528/Makefile        |   1 -
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c    |  10 --
 arch/arm/mach-rockchip/rk3568/Makefile        |   1 -
 arch/arm/mach-rockchip/rk3568/clk_rk3568.c    |  12 --
 arch/arm/mach-rockchip/rk3576/Makefile        |   1 -
 arch/arm/mach-rockchip/rk3576/clk_rk3576.c    |  12 --
 arch/arm/mach-rockchip/rk3588/Makefile        |   1 -
 arch/arm/mach-rockchip/rk3588/clk_rk3588.c    |  12 --
 board/firefly/roc-pc-rk3399/roc-pc-rk3399.c   |   7 +-
 drivers/clk/rockchip/clk_px30.c               |  18 +--
 drivers/clk/rockchip/clk_rk3036.c             |  18 +--
 drivers/clk/rockchip/clk_rk3066.c             |  17 +--
 drivers/clk/rockchip/clk_rk3128.c             |  18 +--
 drivers/clk/rockchip/clk_rk3188.c             |  17 +--
 drivers/clk/rockchip/clk_rk322x.c             |  18 +--
 drivers/clk/rockchip/clk_rk3288.c             |  18 +--
 drivers/clk/rockchip/clk_rk3308.c             |  18 +--
 drivers/clk/rockchip/clk_rk3328.c             |  18 +--
 drivers/clk/rockchip/clk_rk3368.c             |  18 +--
 drivers/clk/rockchip/clk_rk3399.c             |  18 +--
 drivers/clk/rockchip/clk_rk3506.c             |  14 +--
 drivers/clk/rockchip/clk_rk3528.c             |  18 +--
 drivers/clk/rockchip/clk_rk3568.c             |  18 +--
 drivers/clk/rockchip/clk_rk3576.c             |  18 +--
 drivers/clk/rockchip/clk_rk3588.c             |  18 +--
 drivers/clk/rockchip/clk_rv1108.c             |  18 +--
 drivers/clk/rockchip/clk_rv1126.c             |  18 +--
 drivers/sysreset/sysreset_rockchip.c          | 104 ++++++++++++++++--
 50 files changed, 244 insertions(+), 371 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3506/clk_rk3506.c
 delete mode 100644 arch/arm/mach-rockchip/rk3528/clk_rk3528.c
 delete mode 100644 arch/arm/mach-rockchip/rk3568/clk_rk3568.c
 delete mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c
 delete mode 100644 arch/arm/mach-rockchip/rk3588/clk_rk3588.c

-- 
2.54.0

