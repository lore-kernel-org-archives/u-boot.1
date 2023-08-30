Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F476C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BD786529;
	Wed, 30 Aug 2023 20:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="Q2JKwdCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E8E86526; Wed, 30 Aug 2023 16:04:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621C580770
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RbQyQ2hgtz9stG;
 Wed, 30 Aug 2023 16:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1693404254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K9npzBtOTLP3UHbd/kmY4M5Hqk4WQ6OWNaam7npif2g=;
 b=Q2JKwdCsv9+l+FkdZrGyTpDktvdX+HszOLcKSiGvAxoAqgNDuJx1E3YfjVNGwTwrCnD/tu
 POCr0UvhVYZsGwhoq1jDVbLehUmHmKCiy/EZOypLGQcUbSk0xBy2Ye8huUrhxAT3hIyXkM
 3xUiWGmPDkfOaTB8MPeQjO0CPPymYy8/wwCktfxhaplSyVwFIl+agGIdNw2HxubCNnTxl4
 ajOkSdHd4LrlQTUBdBiYCq4DcSU5gDiSOo2RnfntI6f2YrdVYHr+fonq0ZJ+chWhyh41T+
 ezaEGpPYs2ervaU0WLGk0wYmutocOWz0oCmAR0iZrX19FcLJqDsnQaWHBSBK+A==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chris Packham <judge.packham@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Sergei Antonov <saproj@gmail.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/5] board: xilinx: zyqmp: add Beckhoff CX8200
Date: Wed, 30 Aug 2023 16:03:29 +0200
Message-ID: <20230830140349.10801-1-lists@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RbQyQ2hgtz9stG
X-Mailman-Approved-At: Wed, 30 Aug 2023 20:15:48 +0200
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>


This adds support for the Beckhoff CX8200 series of industrial embedded PCs.
There is some information about the device and features here:
https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-cortex-a53/

We also add the rtc rv3032 driver from linux, as it is required for
mac address loading, fix usb without reset gpios on zynqmp and move the
fdt loadaddr to be compatible with less memory.


Steffen Dirkwinkel (5):
  drivers: rtc: add rv3032 driver
  drivers/usb/dwc3: zynqmp: only free reset gpio if we have one
  xilinx: zynqmp: move fdt_addr so we can use devices with less memory
  xilinx: zynqmp: add Beckhoff CX8200
  xilinx: zynqmp: beckhoff cx8200: setup inner cache broadcasting

 arch/arm/dts/Makefile                         |    1 +
 arch/arm/dts/zynqmp-beckhoff-cx8200.dts       |  247 +++
 .../zynqmp-beckhoff-cx8200/psu_init_gpl.c     | 1960 +++++++++++++++++
 .../zynqmp/zynqmp-beckhoff-cx8200/regs.init   |    1 +
 configs/xilinx_zynqmp_virt_defconfig          |    2 +-
 drivers/rtc/Kconfig                           |   10 +
 drivers/rtc/Makefile                          |    1 +
 drivers/rtc/rv3032.c                          |  334 +++
 drivers/usb/dwc3/dwc3-generic.c               |    4 +-
 include/configs/xilinx_zynqmp.h               |    2 +-
 10 files changed, 2559 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/zynqmp-beckhoff-cx8200.dts
 create mode 100644 board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/psu_init_gpl.c
 create mode 100644 board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/regs.init
 create mode 100644 drivers/rtc/rv3032.c

-- 
2.42.0

