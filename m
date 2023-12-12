Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E7CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 21:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 035B58746A;
	Tue, 12 Dec 2023 22:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qY178sah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D6AC871BB; Tue, 12 Dec 2023 22:02:38 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E0F86FB0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 22:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1702414955;
 bh=gitE+h0RB6PXYgRTei0t+vQKRC76YhAVMKGrEQJCDUg=;
 h=From:To:Cc:Subject:Date:From;
 b=qY178sah0u4H8LKqrvN9tzNNPWGPnVlu0UXH01RpWmHuLw/JBrJMIcgKE6RfkperP
 1sDITdYtuUGyRBafxptPO+6wneHw4XS/fsn5DIh1m3o5law+vYzB3zQaVHBIlUMORH
 ylUdqq1qjUD2OD3bcnE66ZEb0cnmEGac6fU4ykw/iZ284Yu0fhGxa8e5apqAeGFnpc
 PLv9hQPCjYV/CmVUMwhsIKRcJQDKwB/HPgFQBmCw4NoJRQbjYxnVQxc6IJu4PJPrbe
 YarEIJUVSY7leYPF9V0NpSCM04BhqfabAdhgTJN5E5+ikqzMNw5JdVPqo6rXvlvjF5
 qdu/ZF6JOdAiw==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E44193781475;
 Tue, 12 Dec 2023 21:02:34 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 7688E984A53D; Tue, 12 Dec 2023 22:02:34 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Martyn Welch <martyn.welch@collabora.com>,
 Bryan Brattlof <bb@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/4] Add DFU and usb boot for TI am62x
Date: Tue, 12 Dec 2023 22:02:20 +0100
Message-ID: <20231212210234.509309-1-sjoerd@collabora.com>
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


Previous version of this patchset went out back in April and got delayed
for various reasons. As some parts were merge this is a somewhat smaller
set then before.

Patches against u-boot/next to take advantage of the latest dts sync
from linux v6.7-rc1

0: https://lists.denx.de/pipermail/u-boot/2023-April/514642.html

Changes in v3:
- Add dfu via environment rather then config headers
- Enable usb nodes in all boot phases
- Run savedefconfig to adjust to more recent u-boot

Changes in v2:
- Switch dwc3 glue to a seperate driver rather then in dwc-generic
- Minimize config changes to just DFU configuration
- Only enable usb port 0 DFU in SPL
- Create a seperate defconfig for R5

Sjoerd Simons (4):
  usb: dwc3: Add dwc3 glue driver for am62
  board: ti: am62x: am62x: include env for DFU
  arm: dts: k3-am625-sk: Enable usb ports in u-boot
  configs: am62x_evm_*: Enable USB and DFU support

 arch/arm/dts/k3-am625-sk-u-boot.dtsi  |   9 ++
 board/ti/am62x/am62x.env              |   1 +
 configs/am62x_evm_a53_defconfig       |  31 ++++++-
 configs/am62x_evm_r5_usbdfu_defconfig | 111 +++++++++++++++++++++++
 drivers/usb/dwc3/Kconfig              |  14 +++
 drivers/usb/dwc3/Makefile             |   1 +
 drivers/usb/dwc3/dwc3-am62.c          | 125 ++++++++++++++++++++++++++
 7 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 configs/am62x_evm_r5_usbdfu_defconfig
 create mode 100644 drivers/usb/dwc3/dwc3-am62.c

-- 
2.43.0

