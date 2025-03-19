Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7011C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409848193A;
	Wed, 19 Mar 2025 04:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354358;
	bh=UUcYhguK2AblyKsR3SDsIulXvIr8Aw9493rhtxOSoU8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=REewGtYTW8byc558uCVUL/1lL74/9K4Bb5f3lgHtayXJ+YL1JfgW+WAZBvcyFmUTe
	 lEHWAbIh9Q1RLJYYgylSPaNPafBs4Uy12ealvQ50NqLO6a4txDn0MIYAkPOmyQ4aHE
	 yX3C86xcmHhtJHxs+fbRBB+sMNlWqPSXEamGvA8BJP67SGypR4/42vS782iYOCQ6s4
	 qMm7z7RgySxXIACUCIvz3MW+Ndc9LzSeEKHXK/JTsEt2uyJXd4N0sUsUEm+oR2sUds
	 nlj07joV3uDFe2jgMZ6Kr1zNBp41wTS+1WdQxw/IgTwX0jL2lvxws1Onyts3B5+ujh
	 ykMvn5kEDcRZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C80481A0C; Wed, 19 Mar 2025 04:19:17 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C54681026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Vp38BFQC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F16B101F63AB; Wed, 19 Mar 2025 04:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354353; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=UUcYhguK2AblyKsR3SDsIulXvIr8Aw9493rhtxOSoU8=;
 b=Vp38BFQCI4Irwh7L+Nh2RTjbSWdHb98s8Cp1t4eyVvL1utj/WgncLsR5e9g7cV+GkhEJaQ
 yJRqiVVICEdADixRv9hutNtHgScR/XCTzUXBeA7bakaw+rGqAOP9EP4DOZIo+w7u7oaZEE
 KLRXFEic74o/9t0gPJV1FhcKX8hW4+B5CalitLn4SkIkZDBa6DUHyZqg10BpgvKIGafpjz
 I1f6+/34iD3pQ61+mvf0rZv6SAN1ou0BFwRojYi+YDrrP2+4m4TG2pvSbPeTe9RHpYUqEY
 OE6y+ENn7LIDhWQLuQd7iTDwwWG8FEIwa911yB1/3e7UTyE1SDl/zpUbayXwnQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 00/24] clk: Add clk_resolve_parent_clk() and fix up iMX clock
 drivers
Date: Wed, 19 Mar 2025 04:17:10 +0100
Message-ID: <20250319031852.233537-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add clk_resolve_parent_clk() to resolve parent clock udevice name
based on clock-names DT property. This is used in SoC clock drivers
to look up the clock name in clock tables, which matches a clock
name in DT clock-names property, and convert it into udevice name
which is used by U-Boot clock framework to look up parent clock in
e.g. clk_register() using uclass_get_device_by_name(UCLASS_CLK,
parent_name, &parent);

Pass struct udevice pointer through the various iMX clock drivers.

Marek Vasut (24):
  clk: Add clk_resolve_parent_clk()
  clk: clk-mux: Fold clk_register_mux()
  clk: clk-mux: Use struct udevice instead of struct device
  clk: clk-mux: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_mux*()
  clk: imx: Pass struct udevice to clk_register_mux()
  clk: clk-gate: Use struct udevice instead of struct device
  clk: clk-gate: Resolve parent clock by name
  clk: imx: gate2: Use struct udevice instead of struct device
  clk: imx: gate2: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_gate*()
  clk: imx: Pass struct udevice to clk_register_gate*()
  clk: clk-composite: Use struct udevice instead of struct device
  clk: clk-composite: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_composite*()
  clk: imx: Convert clock-osc-* back to osc_*
  clk: imx: Pass struct udevice into imx_clk_pllv3*()
  clk: imx: pllv3: Resolve parent clock by name
  clk: clk-divider: Use struct udevice instead of struct device
  clk: imx: Pass struct udevice into imx_clk_divider*()
  clk: clk-divider: Resolve parent clock by name
  clk: clk-fixed-factor: Use struct udevice instead of struct device
  clk: clk-fixed-factor: Resolve parent clock by name
  clk: imx: Pass struct udevice into imx_clk_fixed_factor*()

 drivers/clk/clk-composite.c        |   4 +-
 drivers/clk/clk-divider.c          |   7 +-
 drivers/clk/clk-fixed-factor.c     |   6 +-
 drivers/clk/clk-gate.c             |   5 +-
 drivers/clk/clk-mux.c              |  47 +---
 drivers/clk/clk-uclass.c           |  18 ++
 drivers/clk/imx/clk-composite-8m.c |   4 +-
 drivers/clk/imx/clk-gate2.c        |   5 +-
 drivers/clk/imx/clk-imx6q.c        |  66 +++---
 drivers/clk/imx/clk-imx8mm.c       | 236 +++++++++----------
 drivers/clk/imx/clk-imx8mn.c       | 230 +++++++++----------
 drivers/clk/imx/clk-imx8mp.c       | 348 ++++++++++++++---------------
 drivers/clk/imx/clk-imx8mq.c       | 226 +++++++++----------
 drivers/clk/imx/clk-imx93.c        |   8 +-
 drivers/clk/imx/clk-imxrt1020.c    |  38 ++--
 drivers/clk/imx/clk-imxrt1050.c    |  70 +++---
 drivers/clk/imx/clk-imxrt1170.c    |  30 +--
 drivers/clk/imx/clk-pllv3.c        |   9 +-
 drivers/clk/imx/clk.h              | 116 +++++-----
 include/clk.h                      |   9 +
 include/linux/clk-provider.h       |  10 +-
 21 files changed, 754 insertions(+), 738 deletions(-)

---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com

-- 
2.47.2

