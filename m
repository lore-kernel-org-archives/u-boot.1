Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7489C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F92887FBF;
	Fri, 15 Mar 2024 13:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YfwRX0xn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE0487FC2; Fri, 15 Mar 2024 13:01:35 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF5687CF0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710504091;
 bh=dCc+NppgoNjxnRaAw10p3LG/2li5hB/cXi7QGNm+0cs=;
 h=From:To:Cc:Subject:Date:From;
 b=YfwRX0xn5BsVI3JWpsWuzzzPa7HAjhEpFZ7RAjIqGyOTLI0Yx5AgLKiINY7k5xiSr
 zDu3Dr2H4310V3dcvuiGcZxm+8ScG1jZ4u85myPwCq8bDq6Nd861g7qOiV+R5KqOBx
 HMMLuzyYi/+Cynje+ychNNUmsUnMv2ybneAhzwCUKF2dd6ABnElzFK25masvrapfVW
 26PvfvXEMALnJazr0X1tAF4EXTt3iQ79JB30TJFkgmIdJ3af+BsafPTgFpelCfIvH3
 0CT0+5MigOYETtYCz7OxlwuGXkdMMmngxQg+dSYqGKPa78rMRaUW4GBU04cDQOxYkb
 ljKq6qPtnhAEQ==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA4C2378105A;
 Fri, 15 Mar 2024 12:01:30 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/2] Enable booting from SPI flash on ROCK Pi 4
Date: Fri, 15 Mar 2024 12:01:17 +0000
Message-ID: <20240315120126.75424-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
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

This series brings up and enables booting from the SPI flash present on
some variants of the ROCK Pi 4 in U-Boot.

The first patch syncs the ROCK Pi 4A devicetree from Linux, which contains
the SPI flash node.

The second patch enables support in U-Boot for the SPI flash chip and
booting U-Boot from the SPI flash on the Radxa ROCK Pi 4.

This series may be found at [0].

[0]: https://gitlab.collabora.com/obbardc/u-boot/-/tree/wip/obbardc/rockchip-rock4-enable-spi-boot-v2

Changes in v2:
- Collect Reviewed-by tags.
- Rebase on top of rockchip/for-next.
- Sync configuration changes with savedefconfig.
- Remove GigaDevice SPI flash chip support (suggested by Kever Y).
- Re-enable CONFIG_SPL_FIT_SIGNATURE=y (fixed in rockchip/for-next, solves
  multiple problems mentioned in v1. Thanks Jonas!).
- Remove spl-boot-order from rk3399-rock-pi-4a-u-boot.dtsi (suggested by
  Jonas K).
- Enable CONFIG_SPI_FLASH_SFDP_SUPPORT=y (suggested by Jonas K).
- v1: https://lists.denx.de/pipermail/u-boot/2024-March/547173.html

Christopher Obbard (2):
  arm: rockchip: sync ROCK Pi 4A DTS from Linux
  rockchip: rock-pi-4-rk3399: enable booting from SPI flash

 arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi |  7 +++++++
 arch/arm/dts/rk3399-rock-pi-4a.dts         | 10 ++++++++++
 configs/rock-pi-4-rk3399_defconfig         | 17 ++++++++++++++---
 3 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.43.0

