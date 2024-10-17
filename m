Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90773D3C52C
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9159F89068;
	Thu, 17 Oct 2024 22:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EWFfIJbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DBB8909B; Thu, 17 Oct 2024 22:01:02 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4164C88F23
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1729195247;
 bh=2M8GtRGx4IUGeKPeEP6CIOABUZAB5L1Ffm7QOVZhqsk=;
 b=EWFfIJbvLwhs/uVcp08MSHYOLJTQUhcVpRdKFzePWjh+2qxjWznt9r9zL6cVpegntkuRhONmg
 T8Cjc/GDcUqAoWYEorV2Cx438XGTJauAk6s46/KZd/VG4pJbB0dJzfPOuUgbXFmhMJ4Eh4i6PBU
 WPz7VHBerXoJpP58o8GWHMROqvyo/C5Xd59E2iDYRoWyBOB0fVjqrYGTnKxsR/ODip942RW5FeJ
 xkHcVwIC3J6eljOxAfL3Nmoby1Bd88XIXH4T5rKHGcvXuvZDxerg+HTKdX3BVxkj1gRHLQFf1v9
 ZxJdfpBLaT2NKqy4O3nrcZ1esPknzI9FC0ujuq1iK+tg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/8] rockchip: Add support for FriendlyElec NanoPC-T6 LTS
Date: Thu, 17 Oct 2024 20:00:19 +0000
Message-ID: <20241017200039.1235524-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67116ced6385e073f5ab1391
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

This series picks minimum required commits from v6.12-rc1-dts to add
initial support for the FriendlyElec NanoPC-T6 LTS variant.

The adc-uclass and rockchip-saradc drivers are adopted to support cases
when DM_REGULATOR is disabled and using a fallback voltage reference
from the vdd-microvolts prop in DT.

Finally board specific code is added to help detect non-LTS vs LTS
variant at runtime and nanopc-t6-rk3588_defconfig is extended to enable
Kconfig options for updated DTs.

Please note that this has only been runtime tested on a non-LTS variant
of a NanoPC-T6 board.

Jonas Karlman (4):
  rockchip: rk3588-nanopc-t6: Drop upstream props from u-boot.dtsi
  adc: Allow use of adc with DM_REGULATOR disabled
  adc: rockchip-saradc: Use vdd-microvolts prop as fallback
  rockchip: rk3588-nanopc-t6: Add support for NanoPC-T6 LTS

Marcin Juszkiewicz (4):
  arm64: dts: rockchip: prepare NanoPC-T6 for LTS board
  arm64: dts: rockchip: move NanoPC-T6 parts to DTS
  arm64: dts: rockchip: add NanoPC-T6 LTS
  arm64: dts: rockchip: add SPI flash on NanoPC-T6

 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     |  16 +-
 board/friendlyelec/nanopc-t6-rk3588/Makefile  |   3 +
 .../nanopc-t6-rk3588/nanopc-t6-rk3588.c       |  59 ++
 configs/nanopc-t6-rk3588_defconfig            |  12 +
 drivers/adc/adc-uclass.c                      |   4 +-
 drivers/adc/rockchip-saradc.c                 |   9 +-
 .../arm64/rockchip/rk3588-nanopc-t6-lts.dts   |  60 ++
 .../src/arm64/rockchip/rk3588-nanopc-t6.dts   | 909 +----------------
 .../src/arm64/rockchip/rk3588-nanopc-t6.dtsi  | 943 ++++++++++++++++++
 9 files changed, 1092 insertions(+), 923 deletions(-)
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/Makefile
 create mode 100644 board/friendlyelec/nanopc-t6-rk3588/nanopc-t6-rk3588.c
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6-lts.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-nanopc-t6.dtsi

-- 
2.46.2

