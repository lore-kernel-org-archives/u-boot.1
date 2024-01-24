Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D206C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 03:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7844F87B63;
	Wed, 24 Jan 2024 04:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="XsCEM60f";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="H37CriM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2491B87B6C; Wed, 24 Jan 2024 04:26:22 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B63CD870B5
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 04:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id B05C73200AC5;
 Tue, 23 Jan 2024 22:26:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 23 Jan 2024 22:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1706066773; x=1706153173; bh=QDBLFqY7QJ
 qXP25Yh0OfqlL/5e6bvpXZD+QZfam26xE=; b=XsCEM60f55IG43igNTYU5yqGMp
 msZtHtpmOLM9aMs8VgWkmnMr1ZaaOgJsfj391nuucTcdQw6wt7litos5TKObRQAi
 XtA6SE+hhwAeHgxSmmsv/O07/JL/Ytl5ezGnuFrK10xBgKvmzVBwoBd4PmkAP1aD
 RM5XNz5YS5yk+tcOxfRow1CG4D5Pbsute5LZqMuRFxyxmU3TNXF9Xl973PbwwRwn
 t94uCx4MkYc0QRvZ0Jfw5e5SjMWIflNaLyIG/MObNzBRgOt8rC32QasMQBHJ2tE2
 as+TZ6fJdjhhuTXRNoExxNkyKCb1ia5Xf24oFYGWUkgOGM4V9EmqJ6qGDJLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1706066773; x=1706153173; bh=QDBLFqY7QJqXP25Yh0OfqlL/5e6b
 vpXZD+QZfam26xE=; b=H37CriM8/3S6geefDPiGx4AYv4C3ElW3rDzm+W32fDVj
 GZdgSPFY7u66VMJ/ZUOXpjxE3w2iOBCraQ8KUnTNdHucKK5wgixbNM4pFd6SMubJ
 mR5S3Hkvm7eRXFJMkqDO6TegMo9q3Igmvsed14WIB8wsvxpHd6byX5AUdVOBtE//
 hHnPOJR5EVi2T3yEub7IOVn0mrp9y0ccXdwiuRJwJX5bxTv71Mc5BylB+G3lwhkB
 sTjvau8JPlxsnrF8cKi1RIUUmMbaXOP5cG3oHpikBzTLFtuzzaNSVj4xb5Kq7+qs
 tP+EyqD1AwcmnoQw64z4rSF2mZnmzYr5F/9j+APBhg==
X-ME-Sender: <xms:VIOwZVd-dTnpBlqNL6ciSVR7HaZxYWidh5RqRSQt6pRjPeSwTqjT0w>
 <xme:VIOwZTMRszi0DbtoGie5rZ8GYGHKBDMswVAv-CUE-G1yghMcusBAsUl3F3i8xXORQ
 1Zd5sQLUg>
X-ME-Received: <xmr:VIOwZeh8FhLgEnCZ3Bx_U0Nq3HTGJnKyN8DXrlF-sMMLBAtPeoqJ8EjiLkzfXQWazhS4-m7ubljE-0Ka5XPZo8LPlYT3wH-2wVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhimhcunfhu
 nhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrhhnpe
 duhfdtveeujeejjeffieevgfdtudegfeffvedugfetteehudevteehtefgieeitdenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvg
 grthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:VIOwZe8Kj4JYAN2FrF1-7sxsF4boS57RHBM0RevRgojF6tnLGWFVjQ>
 <xmx:VIOwZRsmUq3PsxIHjhPMEc8gtT7OB2mXuHU3Ti9glIGgHf-B0Emlyg>
 <xmx:VIOwZdEXAaZOi-sLJSi9O-2WofSvcpFt6mWOaiuVnYzj-oAstpRtcg>
 <xmx:VYOwZRGiKnVAw-hdqNft3qNp8xyYCguMFZjn9Xja5l9PuFc5LtFm_Q>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 22:26:06 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Wed, 24 Jan 2024 14:26:03 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Chris Morgan <macromorgan@hotmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, John Keeping <john@metanate.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/6] rockchip: Add support for rv1126 based Sonoff iHost
 Gateway
Date: Wed, 24 Jan 2024 14:25:56 +1100
Message-Id: <20240124032602.126059-1-tim@feathertop.org>
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

Changes in v2:
- New patch to clean up distro boot from rv1126_common.h
- Remove board config not required with standard boot

Tim Lunn (6):
  arm: dts: rockchip: Sync rv1126 dts from linux 6.8-rc1
  ram: rockchip: Add rv1126 ddr4 support
  rockchip: Convert rv1126 to standard boot
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
 doc/board/rockchip/rockchip.rst               |   1 +
 .../sdram-rv1126-ddr4-detect-1056.inc         |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-328.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-396.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-528.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-664.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-784.inc |  75 ++++
 .../rockchip/sdram-rv1126-ddr4-detect-924.inc |  75 ++++
 drivers/ram/rockchip/sdram_rv1126.c           |   8 +
 include/configs/neural-compute-module-2.h     |   6 -
 include/configs/rv1126_common.h               |   5 +-
 include/configs/sonoff-ihost.h                |  10 +
 24 files changed, 1485 insertions(+), 19 deletions(-)
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

