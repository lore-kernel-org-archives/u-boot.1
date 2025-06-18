Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765BDC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 21:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 944A582C2F;
	Wed, 18 Jun 2025 23:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF4C82CBC; Wed, 18 Jun 2025 23:21:34 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D20F82B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 23:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uS0Dn-007yeJ-J4;
 Wed, 18 Jun 2025 21:21:27 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] add support for gpio-usb-b-connector
Date: Wed, 18 Jun 2025 14:21:18 -0700
Message-Id: <20250618212120.1548575-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Linux has a driver for gpio-usb-b-connector that uses a GPIO to
determine host vs peripheral role. This can be useful for USB Type-B
OTG connectors which have an ID pin that is grounded on OTG-to-host
cables and floating on OTG-to-device cables as well as USB power switch
controllers such as the TPS25821 which manages cc pins and has a SINK#
output.

Both scenarios are used for various imx8mp-venice boards.

This series addes support for usb controllers in otg mode
(dr_mode="otg") which have a remote endpoint connector with compatible
'gpio-usb-b-connector' with an id-gpios property.

The first patch adds this capability to the usb_get_dr_mode() function
and the second disables the workarounds used for various imx8mp-venice
boards to default the usb dual-role controllers to host mode. 

Tim Harvey (2):
  usb: common: allow dr_mode to come from gpio-id based usb-connector
  imx8mp-venice: enable USB device mode

 .../dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi   |  5 -
 .../dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi   |  5 -
 .../dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi   |  5 -
 arch/arm/dts/imx8mp-venice-gw74xx-u-boot.dtsi |  5 -
 configs/imx8mp_venice_defconfig               |  7 ++
 drivers/usb/common/common.c                   | 96 ++++++++++++++++++-
 6 files changed, 102 insertions(+), 21 deletions(-)

-- 
2.25.1

