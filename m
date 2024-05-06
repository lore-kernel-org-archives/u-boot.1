Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6252DC25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8335D885F7;
	Mon,  6 May 2024 16:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="5TYSMmrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2904885F4; Mon,  6 May 2024 16:39:03 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5BF87EDC
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 16:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715006341;
 bh=AZr0E2HmvRF6aJsvNwD22wdDWpoNXxrDSQYGFwALVfI=;
 h=From:To:Cc:Subject:Date:From;
 b=5TYSMmrAZoQzX6ik+rZDXW20CGcoifMu+9l+xOKs2H2ma/tV4O8C+Jeg/OU1cA6wq
 6NYyXac7ydpySPcY/uupqlJ29S10uXinqx/Vzs4+ybWE+KmnJBMA8Uc+JpUsHYfFXm
 CnZDPThskinRFur4ec9sqgqSqKZQB3guaxbNBqiFqQ1eTKY9SCTZ2E//QgLxRQHjoC
 +IFdvTBSRfMHoy0unEmEsB9PAANQtBdkS7E4gm66suOrgjEp8eizNOQRZTnluUJB6u
 UsKScl2t64uR8hAImNxhs6nldSoBywqkqHsrK40V6RNxbVMuTVCC93bSVHPGl1FZXL
 8me4GQc2l1/4g==
Received: from pan.lan (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com
 [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C848D3782112;
 Mon,  6 May 2024 14:39:00 +0000 (UTC)
From: Martyn Welch <martyn.welch@collabora.com>
To: Dave Gerlach <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH v5 0/6] Add DFU and usb boot for TI am62x SK and beagleplay
Date: Mon,  6 May 2024 15:38:40 +0100
Message-ID: <20240506143846.1252377-1-martyn.welch@collabora.com>
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

This series adds DFU support for TI AM62 SK and beagleplay boards.

I have picked this series up from Sjoerd due to time constraints.

Since the last revision:
* Removed dwc3 mode setting in favour of reinstating forced peripheral
  mode for usb0
* Use of config fragments for both r5 and a53 DFU configuration to
  reduce duplication
* Typographical improvements to documentation

We plan to also submit the dts changes to linux so that those can be
dropped again in the near future (hopefully)

Changes in v5:
- Forcing usb0 into peripheral mode reinstated
- Switch to config fragment for a53 DFU configuration
- Use existing config fragment for a53 DFU configuration
- Typographical corrections

Changes in v4:
- Add config dependency on SYSCON
- Move defines and constants outside out of function scope
- Don't force usb0 into peripheral mode
- Move R5 dfu config to a config fragment rather then a full defconfig
- Don't enable XHCI for the R5 SPL, unneeded

Change in v3:
- Add dfu via environment rather then config headers
- Enable usb nodes in all boot phases
- Run savedefconfig to adjust to more recent u-boot

Changes in v2:
- Switch dwc3 glue to a seperate driver rather then in dwc-generic
- Minimize config changes to just DFU configuration
- Only enable usb port 0 DFU in SPL
- Create a seperate defconfig for R5

Sjoerd Simons (6):
  usb: dwc3: Add dwc3 glue driver for am62
  board: ti: am62x: am62x: include env for DFU
  arm: dts: k3-am625-sk: Enable usb port in u-boot
  configs: am62x_evm_*: Enable USB and DFU support
  beagleplay: Add DFU support
  doc: board: Add document for DFU boot on am62x SoCs

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |   9 ++
 arch/arm/dts/k3-am625-sk-u-boot.dtsi         |   9 ++
 board/beagle/beagleplay/beagleplay.env       |   1 +
 board/ti/am62x/am62x.env                     |   1 +
 configs/am62x_a53_usbdfu.config              |  29 +++++
 configs/am62x_beagleplay_a53_defconfig       |   2 +
 configs/am62x_evm_a53_defconfig              |   3 +
 configs/am62x_r5_usbdfu.config               |  28 +++++
 doc/board/beagle/am62x_beagleplay.rst        |  14 ++-
 doc/board/ti/am62x_sk.rst                    |  37 ++++++
 drivers/usb/dwc3/Kconfig                     |  14 +++
 drivers/usb/dwc3/Makefile                    |   1 +
 drivers/usb/dwc3/dwc3-am62.c                 | 125 +++++++++++++++++++
 13 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 configs/am62x_a53_usbdfu.config
 create mode 100644 configs/am62x_r5_usbdfu.config
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

-- 
2.43.0

