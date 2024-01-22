Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3DEC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8016879B2;
	Mon, 22 Jan 2024 13:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="Hq+7PmPt";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQxgZEcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F690879B2; Mon, 22 Jan 2024 13:46:30 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B0487812
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id D48AB5C00F8;
 Mon, 22 Jan 2024 07:46:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Mon, 22 Jan 2024 07:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1705927582; x=1706013982; bh=2Ne8UAzm5r
 1mGzhY6AmzMFprZYLOl3p4uaaEzDzbG7s=; b=Hq+7PmPtgGHqm/i4jQu2BQVsab
 Kl1Ysy/PIumoOZVe/u1FLZu7TDRamNZGcMHZMBksRQoT9o4Z54sqO6qb4gq5euE/
 G/H1JUessQn5U85da6t+IVGbzxorgUQjhbi55YS5Xmldv3J9+UxQ6WHqhFIUoLW6
 8Vy43/4GbZ7JoVWMYsaQX8Gt0Qinm0ObMDg+uqSwjdFeI7cxTkr/ODSoUYr31TPn
 Z56Z7il6agC+KRh6ZmtJtFiwgDvbgJsaM6YnkNm4ZQlI9q2t2i7iVF+BR/8K4Uu8
 JhvzmIZ35WAZybitvhNJ2t3LSdLFd7LwHz9BnfWUZUWrefJRp48u/NlqppJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1705927582; x=1706013982; bh=2Ne8UAzm5r1mGzhY6AmzMFprZYLO
 l3p4uaaEzDzbG7s=; b=QQxgZEcrskKnzaXtrhjrWJBXtjKaRKGRwJWPKfJcyu+d
 WEQLf+CtSHh/YfB1QDNTWsdQeGd/oxrnGBesCjfE3+KNaK2r7rBnU1jGX62+WE27
 w7qykxuZlOTpG2PsZx/0m8Rj9ShfWOLWh94b3lK65CCqFWnYvAXulUt2bNIZHaxV
 WKCi2DV+zFnYEZJO3uRKpcSWnjI3zkV15AZ4M0LiSfJLdTC8KTIsdqhEVmuDp2Om
 94WxLF/uSuRCruOW8NqY9twc0GDHqn0F5aRsdRLcbQig7wDkLpM6yJeo/Kdyaa1q
 +9DALBENRbegjeHDtjFfX6lGMPb8s3PTbfvsvHGxjg==
X-ME-Sender: <xms:nWOuZeZHmVX9PrgjT9jPZgCA2AWAwiav65MFq82bt4Xi2xi0kA7HEg>
 <xme:nWOuZRZd2iyXAL1GKpxrDObleeoFH6uoE9k6MalilibGhj_IDJ8yvkA_P6Rh3iVtK
 8Z_plOPhw>
X-ME-Received: <xmr:nWOuZY--QyRP0mxVUK-OTBXmEe7QqXdTDE0BUKd3O6rXmknYRB38ONrg1_R9Ycg0fXyRvHtcQzMr0obMeaN8tPap24ujfFcre9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhimhcunfhu
 nhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrhhnpe
 duhfdtveeujeejjeffieevgfdtudegfeffvedugfetteehudevteehtefgieeitdenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvg
 grthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:nWOuZQoJxEB2warKgHTygp_8VH-P0dgn58YwlRdDPlo0LCLtRntP5Q>
 <xmx:nWOuZZqZEvF9zWeecULzII832JoEL7_JY5gT8sfStyF1lB5pbfiSyg>
 <xmx:nWOuZeReygHwVYkEAgI6Iqeh7aiu7PFGF3S8EwjvWV3oVg2z_1YtMw>
 <xmx:nmOuZaTyBceXFd_8xRj9HBT1R5WwK_dsWTXlrJdqXbRfyBCPHoz26A>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 07:46:15 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Mon, 22 Jan 2024 23:46:11 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] rockchip: Add support for rv1126 based Sonoff iHost
 Gateway
Date: Mon, 22 Jan 2024 23:45:58 +1100
Message-Id: <20240122124603.3341988-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
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


Sonoff iHost is gateway device designed to provide a Smart Home Hub,
it is based on Rockchip RV1126. It features Wifi, BT and Zigbee radios
as required by many smart home devices.

Features:
- Rockchip RV1126
- 4GB DDR4
- 8GB eMMC
- microSD slot
- RMII Ethernet PHY
- 1x USB 2.0 Host
- 1x USB 2.0 OTG
- Realtek RTL8723DS WiFi/BT
- EFR32MG21 Silabs Zigbee radio
- Speaker/Microphone

Sync rv1126 dts from linux v6.8-rc1, add support for ddr4 ram and add
board support for the Sonoff ihost.


Tim Lunn (5):
  arm: dts: rockchip: Sync rv1126 dts from linux 6.8-rc1
  ram: rockchip: Add rv1126 ddr4 support
  board: rockchip: Add Sonoff iHost board
  rockchip: rv1126: select SPL_OPTEE_IMAGE
  rockchip: rv1126: Move RAM disk address

 arch/arm/dts/rv1126-edgeble-neu2-io.dts       |  70 +++
 arch/arm/dts/rv1126-edgeble-neu2.dtsi         |  27 +-
 arch/arm/dts/rv1126-pinctrl.dtsi              | 130 ++++++
 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi  |  13 +
 arch/arm/dts/rv1126-sonoff-ihost.dts          |  29 ++
 arch/arm/dts/rv1126-sonoff-ihost.dtsi         | 404 ++++++++++++++++++
 arch/arm/dts/rv1126.dtsi                      | 185 ++++++++
 arch/arm/mach-rockchip/Kconfig                |   1 +
 arch/arm/mach-rockchip/rv1126/Kconfig         |   8 +
 board/itead/sonoff-ihost/Kconfig              |  16 +
 board/itead/sonoff-ihost/MAINTAINERS          |   6 +
 configs/sonoff-ihost-rv1126_defconfig         |  60 +++
 .../sdram-rv1126-ddr4-detect-1056.inc         |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-328.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-396.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-528.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-664.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-784.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-924.inc |  75 ++++
 drivers/ram/rockchip/sdram_rv1126.c           |   8 +
 include/configs/rv1126_common.h               |   2 +-
 include/configs/sonoff-ihost.h                |  18 +
 22 files changed, 1491 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/dts/rv1126-sonoff-ihost-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dts
 create mode 100644 arch/arm/dts/rv1126-sonoff-ihost.dtsi
 create mode 100644 board/itead/sonoff-ihost/Kconfig
 create mode 100644 board/itead/sonoff-ihost/MAINTAINERS
 create mode 100644 configs/sonoff-ihost-rv1126_defconfig
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-1056.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-328.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-396.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-528.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-664.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-784.inc
 create mode 100644 drivers/ram/rockchip/sdram-rv1126-ddr4-detect-924.inc
 create mode 100644 include/configs/sonoff-ihost.h

-- 
2.40.1

