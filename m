Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3862C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A1A83249;
	Thu, 31 Jul 2025 01:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MfCwB8+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CC8383257; Thu, 31 Jul 2025 01:53:59 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3217C8313F
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1753919635;
 bh=bfdx38FyYAmBAazLAMfNv4UZc88uNGy57C5+P6g3Zu8=;
 b=MfCwB8+C8Bh/U9QCyTUgXS+q0lbQtzjs/qLMuied7IdFfqTA+USpl8AHtFQOQ6kxj6kvV5cXx
 65LMd61sctmJpxVCloyrFwASU11ibclgKULLc3dC8Hny/RKKLTjKNYR+Gip4WZGpp237RcQP5uf
 zwuJvNF7LWRJGZg8tXf48aZyDgo4zZJKo+w5fcSlgnMq109kRSvySQvJD/MCCmMDf0khqM8y0Xx
 4tvS0IYHSgE/vn52N5wYJIC14X0NEtryePxc/AkA/gXW4Wsup02SEefWgvBOX/sjPaxTg+yuL/1
 oBP9GX2WUbWVDQuBiJjEolmoRu3IePBxXerkmWYU4tTg==
X-Forward-Email-ID: 688ab0621851584377f6205a
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
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/8] rockchip: Fixes and updates for RK3528
Date: Wed, 30 Jul 2025 23:52:41 +0000
Message-ID: <20250730235301.1774089-1-jonas@kwiboo.se>
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

This series fixes a boot loop caused by recent dts/upstream v6.16-dts
sync, include cleanup of sdmmc nodes and add needed init-microvolt props
for pwm-regulatore, changes needed thanks to the same v6.16-dts sync.

It also adds more preparation to support USB features in U-Boot once
pending Linux USB DT nodes lands in a future sync of dts/upstream.

Patch 1-3 includes device tree changes for recent dts/upstream sync.

Patch 4-8 prepare U-Boot for USB host/gadget support on RK3528 after a
future dts/upstream sync.

Jianwei Zheng (1):
  phy: rockchip: naneng-combphy: Add support for RK3528

Jonas Karlman (7):
  rockchip: rk3528-generic: Fix boot after dts/upstream v6.16-dts merge
  arm: dts: rockchip: Use sdmmc node from dts/upstream on RK3528
  arm: dts: rockchip: Set init-microvolt for pwm-regulators on Radxa
    E20C
  rockchip: rk3528: Disable USB3OTG U3 port early
  rockchip: clk: clk_rk3528: Add dummy CLK_REF_PCIE_INNER_PHY support
  usb: dwc3-generic: Use combined glue and ctrl node for RK3528
  rockchip: rk3528-radxa-e20c: Enable USB gadget Kconfig options

 arch/arm/dts/rk3528-generic-u-boot.dtsi       |   9 --
 arch/arm/dts/rk3528-generic.dts               |  17 ++-
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi    |  13 ++-
 arch/arm/dts/rk3528-u-boot.dtsi               |  18 ----
 arch/arm/mach-rockchip/rk3528/rk3528.c        |   6 ++
 configs/radxa-e20c-rk3528_defconfig           |  10 ++
 drivers/clk/rockchip/clk_rk3528.c             |   1 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 102 ++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c               |   1 +
 9 files changed, 142 insertions(+), 35 deletions(-)

-- 
2.50.1

