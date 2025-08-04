Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A629DC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 18:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51DA82B07;
	Mon,  4 Aug 2025 20:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cKmNjwSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D806C8317B; Mon,  4 Aug 2025 20:17:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3E980FA1
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 20:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4ce3=2R=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754331462;
 bh=PO4mKjX5U/2fDZQ0p3gnvtMR2jDUkAG9gZyfqsDDCWc=;
 b=cKmNjwSjbJNIkoAq/rVbfJ2unTGMzYoBdOygXIvm2/WAKtJlEVHM6CfCnQIFabyEW3+CtSh6b
 ucZjaOYbxBXP0e2ISnfB8+ACNblK5xJDn6KP/wTPLtq65THSPvro4rLqp9p+f/1y6Wd4x2raxGc
 I5K5y/J2anZRSVo6I0vMwT7l0AmpHnGKUoqsXWhK1QHKiyY4RgmrGN0xFzO2Fi/knOLI6ao7ZRD
 lP91jZLomKkg//6T3Z5s59/sH8Q1qvqOBqcnMNsUJwnF+H2nS8dZrOvor+JVxVyTslglXmDnsxp
 uw2mjZ4IkIC3Duay1tfmYRcQUPnHQhakwgpy54ThkwCQ==
X-Forward-Email-ID: 6890f90d8f6d45d450a4a07c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] rockchip: Add initial RK3582 support
Date: Mon,  4 Aug 2025 18:16:29 +0000
Message-ID: <20250804181638.3855760-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
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

This series add initial support for RK3582 support. The RK3582 is a
variant of the RK3588S with a few ip blocks disabled. What blocks are
disabled/non-working is indicated by the ip-state in OTP.

Compared to the vendor U-Boot variant, this mark cpu and gpu with
status=fail instead of removing nodes during DT fixup. Linux skip cpu
cores marked as failed staring from v5.17-rc1, however the GIC driver
will generate a harmless WARN_ON that safely can be ignored. A patch for
Linux will be sent to skip the WARN_ON for failed/disabled cpu cores.

Changes in v2:
- Refactor code to first apply policy to ip-state and then fail cores
  based on the updated ip-state
- Add support for failing rkvdec and rkvenc cores
- Append soc compatible to board model
- Add patch to add support for ROCK 5C Lite variant

Jonas Karlman (3):
  rockchip: Add initial RK3582 support
  rockchip: rk3588-generic: Enable support for RK3582
  rockchip: rk3588s-rock-5c: Add support for ROCK 5C Lite variant

 arch/arm/dts/rk3588-generic.dts        |   4 +-
 arch/arm/mach-rockchip/rk3588/Kconfig  |   9 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c | 221 +++++++++++++++++++++++++
 configs/generic-rk3588_defconfig       |   1 +
 configs/rock-5c-rk3588s_defconfig      |   1 +
 doc/board/rockchip/rockchip.rst        |   4 +-
 6 files changed, 232 insertions(+), 8 deletions(-)

-- 
2.50.1

