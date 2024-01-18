Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1807C47077
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B8C87B42;
	Thu, 18 Jan 2024 08:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="G6D7cybA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B5E287A0E; Thu, 18 Jan 2024 08:20:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06FD687B43
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9c3f=I4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1705562395;
 bh=jG0lLnG7r5c7H7n+/bIx5wmEtbnPVvHx+hzf+Ymuee4=;
 b=G6D7cybAzl00Iny9KsTGcnsUWZWrmYgIfhgDtfejp26APMq3wlAOENZl8gESSfY+73fl+Sh5r
 8nbuVCFk/B+AqPWQE9srJ5+M2djyjQlhItLDiGLztq84OL6rzu9ng3wD9MsL2b1EkqTu05DkXnF
 buwhR+yphG7Aii8b6mxzklAw7pv6qzw8N1gs/6fBD7glh3aknxDPWEDNRtwmGakbCtAoWb3OIRF
 og9MEE7QP/WKfzDeYdVTP0AvtGGsPTPtAiWXv0ydNZRooQYgRIAKX7BGb8nmvf+92BR4t7pWvXw
 bHxgDPX6Q1Pe9Fc9X1sT0wffefNvx6pgq+Zv6c7ORqvg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Simon
 Glass <sjg@chromium.org>, Banglang Huang <banglang.huang@foxmail.com>
Cc: Trevor Woerner <twoerner@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: Fix ethernet on Radxa ROCK Pi E v1.21
Date: Thu, 18 Jan 2024 07:19:44 +0000
Message-ID: <20240118071949.927089-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65a8d11bd66eecd94fbb690c
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

Ethernet on a Radxa ROCK Pi E v1.21 with a RTL8211F ethernet PHY
currently fails with the following message:

  Could not get PHY for ethernet@ff540000: addr -1

This happens because the ethernet PHY is never reset before a phy-id is
read back from the MDIO bus.

This series fixes this issue by calling eth_phy_set_mdio_bus() from the
designware ethernet driver to issue a PHY reset before the phy_connect()
call.

With the driver change and DM_ETH_PHY and PHY_REALTEK enabled the PHY
can be identified and etherent works:

  => mdio list
  ethernet@ff540000:
  1 - RealTek RTL8211F <--> ethernet@ff540000

This was tested with and without the DM_MDIO option enabled. Decided to
leave it disabled in this series.

Jonas Karlman (2):
  net: designware: Reset eth phy before phy connect
  rockchip: rk3328-rock-pi-e: Enable DM_ETH_PHY and PHY_REALTEK

 configs/rock-pi-e-rk3328_defconfig | 2 ++
 drivers/net/designware.c           | 7 +++++++
 2 files changed, 9 insertions(+)

-- 
2.43.0

