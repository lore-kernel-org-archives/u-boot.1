Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAEDC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 14:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC68787E1C;
	Sat,  2 Mar 2024 15:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MijhFMbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E38687D37; Sat,  2 Mar 2024 15:34:34 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF2748759C
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 15:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709390070;
 bh=kXnMSVZcexM3sFz73ppC61WNTUoqFg2IC94mCgSKGnw=;
 h=From:To:Cc:Subject:Date:From;
 b=MijhFMbHd79tTkB4jsUumuHhbCwuj5Jfoy8rJh18b5UuuVLcLOQ2vJkI7tB6kpJWU
 gCulvTxUJCQhzPZpJp9r9tW187nuq2TnG5UpS/NAoSMzW/W6gBd2li7kMAAFEH4SEz
 Bm6bPHAXRtet2U7NL4bP3JxafHAqZvpvK9s0kc47qTIgAWA6tGnVquVQFfKJQhI7KK
 7fy7eseQ4q/IA7pwcLk9vjDhJfhEnu2eTcXBMjEni7LxoIfMoMr9O9x9IxpHKQ5uGc
 1NBQLgwEFhQ9o+jqWTwq5WbYkXDSuJCuDcyIJCGNKHV/qcprjUAO1OiIumy/S/A9n1
 Smcbnmr9XBdzA==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 465BE3780016;
 Sat,  2 Mar 2024 14:34:30 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] Enable booting from SPI flash on ROCK Pi 4
Date: Sat,  2 Mar 2024 14:34:09 +0000
Message-ID: <20240302143417.164560-1-chris.obbard@collabora.com>
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

[0]: https://gitlab.collabora.com/obbardc/u-boot/-/tree/wip/obbardc/rockchip-rock4-enable-spi-boot-v1


Christopher Obbard (2):
  arm: rockchip: sync ROCK Pi 4A DTS from Linux
  rockchip: rock-pi-4-rk3399: Enable booting from SPI flash

 arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi | 12 ++++++++++++
 arch/arm/dts/rk3399-rock-pi-4a.dts         | 10 ++++++++++
 configs/rock-pi-4-rk3399_defconfig         | 15 +++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.43.0

