Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C551C47077
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19EB987A0E;
	Thu, 18 Jan 2024 08:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GFGp6qw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D69F87B7A; Thu, 18 Jan 2024 08:20:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3E887A00
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9c3f=I4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1705562402; bh=W716/TgkAI8SN22heLdqWdng7TFuxsL8zFIOvZotFkU=;
 b=GFGp6qw0e9WIOGE7EuPKm326k7z0vFbkRwDgZb3Y4bu+cnH3GjV5t/poIrAdqLYxp3j0tSInM
 +mwn4ylLbQWhkiksnsog+6reyCrxDFuAHtAawin9BxXHeQJOKsnxApmc7iy52qYoPzINDXlyv9m
 DgWYYyvMPUDiZJWiZyUXghKq8gTyCQoV4Rx9bfrDX2E6ERUPwLcDwk1V7CWclBa0VzjiaSib5MB
 kQJ2KfSL+Bvp7IVPRcYpcyclxUVF/IjBJdgdz4QvaQ1ZZs/aIFe9bsDs5Oa1/3vweeDmLtbfw8G
 yAgrHOIYExP4rWx8iiJWFBSgzfRUUyhOE8ZiaQ48hkWw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Simon
 Glass <sjg@chromium.org>, Banglang Huang <banglang.huang@foxmail.com>
Cc: Trevor Woerner <twoerner@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] rockchip: rk3328-rock-pi-e: Enable DM_ETH_PHY and
 PHY_REALTEK
Date: Thu, 18 Jan 2024 07:19:46 +0000
Message-ID: <20240118071949.927089-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118071949.927089-1-jonas@kwiboo.se>
References: <20240118071949.927089-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65a8d121d66eecd94fbb6928
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

Enable the DM_ETH_PHY and PHY_REALTEK now that the designware ethernet
driver call eth_phy_set_mdio_bus() to assist with resetting the eth PHY
during probe.

Fixes ethernet on the v1.21 hw revision of Radxa ROCK Pi E:

  => mdio list
  ethernet@ff540000:
  1 - RealTek RTL8211F <--> ethernet@ff540000
  => net list
  eth0 : ethernet@ff540000 86:e0:c0:ea:fa:a9 active
  eth1 : ethernet@ff550000 86:e0:c0:ea:fa:a8
  => dhcp
  Speed: 1000, full duplex
  BOOTP broadcast 1
  BOOTP broadcast 2
  BOOTP broadcast 3
  DHCP client bound to address 192.168.1.114 (1004 ms)

Reported-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/rock-pi-e-rk3328_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index c0375beffec3..6dda900a9b42 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -76,6 +76,8 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-- 
2.43.0

