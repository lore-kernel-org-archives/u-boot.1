Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3FDC48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 19:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E93487B9D;
	Mon,  5 Feb 2024 20:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C736C8798F; Mon,  5 Feb 2024 20:09:10 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DCAC87A00
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 20:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rX4Ky-00BXW2-ET;
 Mon, 05 Feb 2024 19:09:00 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 0/5] update venice dts
Date: Mon,  5 Feb 2024 11:08:53 -0800
Message-Id: <20240205190858.3076363-1-tharvey@gateworks.com>
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

This series brings some recent upstream Linux dt updates into U-Boot for
the Gateworks Venice family.

Tim Harvey (5):
  arm: dts: imx8mm-venice-gw7901: add digital I/O direction control GPIO's
  arm: dts: imx8mm-venice-gw7901: add TPM device
  arm: dts: imx8mm-venice-gw71xx: fix USB OTG VBUS
  arm: dts: imx8mm-venice-gw71xx: add TPM device
  arm: dts: imx8mp-venice-gw71xx: add TPM device

 .../dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi   |  7 ++++
 arch/arm/dts/imx8mm-venice-gw71xx.dtsi        | 40 +++++++++----------
 arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi | 14 +++++++
 arch/arm/dts/imx8mm-venice-gw7901.dts         | 14 ++++++-
 .../dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi   |  9 +++++
 arch/arm/dts/imx8mp-venice-gw71xx.dtsi        | 10 ++++-
 6 files changed, 69 insertions(+), 25 deletions(-)

-- 
2.25.1

