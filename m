Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3298EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FED80842;
	Tue, 22 Aug 2023 14:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s0wE8oBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B49846B8; Tue, 22 Aug 2023 14:14:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D5F280750
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A715865550;
 Tue, 22 Aug 2023 12:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834B2C433C8;
 Tue, 22 Aug 2023 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692706438;
 bh=FCvMRuuVt6nHGplce6lG57MOqZGYaehcaQztX2B9eAg=;
 h=From:To:Cc:Subject:Date:From;
 b=s0wE8oBjssLbp3AnV0JJUNPo5jSW18wt7hkQxxORJ7WKcj0llA81cjd0331BZ/afu
 t8wGgHEOOLovTDGwTYVnkhD5oZsF4uu+hCWKZJv7WlsRxplQdFwyVQDsW558ivnxLd
 xlXK2SBX7xUbX2T1WXCHYlAlJNc3KBYMF6/a//3NFg4UaKuwObqAVw+71Ic6i6TKjR
 ArcRhAP6/7zbGyoKRuYnV9ZqLKIlcEMj/Mz/bO0dlJIkK1ndzrw65OB4XvasfJLBj3
 /5NKOKkuoSRuIB6dnBbMWhkehzU7sdwKY7T1OBucH9eHu3vxyycRBcQCMRgNaUWknd
 XdZ2fIxaQKOAA==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	joe.hershberger@ni.com
Cc: robertcnelson@gmail.com, jkridner@beagleboard.org, r-gunasekaran@ti.com,
 s-vadapalli@ti.com, srk@ti.com, trini@konsulko.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] net: Fix Ethernet PHY detection on Beagleplay
Date: Tue, 22 Aug 2023 15:13:48 +0300
Message-Id: <20230822121350.51324-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Beagleplay has a buggy Ethernet PHY implementation for the Gigabit
PHY in the sense that it is non responsive over MDIO immediately
after power-up/reset.

We need to either try multiple times or wait sufficiently long enough
(couple of 10s of ms?) before the PHY begins to respond correctly.

One theory is that the PHY is configured to operate on MDIO address 0
which it treats as a special broadcast address.

Datasheet states:
"PHYAD (config pins) sets the PHY address for the device.
The RTL8211F(I)/RTL8211FD(I) supports PHY addresses from 0x01 to 0x07.
Note 1: An MDIO command with PHY address=0 is a broadcast from the MAC;
each PHY device should respond."

This issue is not seen with the other PHY (different make) on the board
which is configured for address 0x1.

As a woraround we try to probe the PHY multiple times instead of giving
up on the first attempt.

cheers,
-roger

Roger Quadros (2):
  net: ti: am65-cpsw-nuss: Workaround for buggy PHY/Board
  net: phy: Change "PHY not found" message to debug()

 drivers/net/phy/phy.c           |  2 +-
 drivers/net/ti/am65-cpsw-nuss.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)


base-commit: a169438411f9277cc689c14078151aa1d1caae3c
-- 
2.34.1

