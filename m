Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F54C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9FD8875F;
	Mon,  8 Jul 2024 14:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yvu+HgZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A7E88444; Mon,  8 Jul 2024 09:52:33 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4C688444
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-kochidanadu@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4687qAJj002483;
 Mon, 8 Jul 2024 02:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720425130;
 bh=fNQPm0i8rmwy37WHSMXEjfDA3lDQYk9GKmhTEqkvkyM=;
 h=From:To:CC:Subject:Date;
 b=Yvu+HgZ4Xi+1py/PCJS5BYGQbrbO0ghBDSrpyki3EaJiJi3jPjWycZjCxCZbnFp8u
 oo4+ePiOK0ppDJkfZ0DR495+UtonL7rlUVh3S+nHqzkqfQlRPVnYLngiQTp2HdLhXL
 h8xW45ilqFlEI2K3ZyvhERC20gx+7RIV+9S9XjEA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4687qAoH010752
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 02:52:10 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 02:52:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 02:52:09 -0500
Received: from localhost (scaria-hp-zbook-15-g5.dhcp.ti.com [172.24.31.134])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4687q8pT048191;
 Mon, 8 Jul 2024 02:52:09 -0500
From: Scaria Kochidanadu <s-kochidanadu@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <abdellatif.elkhlifi@arm.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <semen.protsenko@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <nathan.morrison@timesys.com>, <s-kochidanadu@ti.com>,
 <devarsht@ti.com>, <j-luthra@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <nm@ti.com>, <khasim@ti.com>, <rogerq@kernel.org>,
 <francesco.dolcini@toradex.com>, <afd@ti.com>, <jan.kiszka@siemens.com>
Subject: [PATCH 0/6] Enable audio playback in AM62x SoC
Date: Mon, 8 Jul 2024 13:22:01 +0530
Message-ID: <20240708075207.37207-1-s-kochidanadu@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

This series enables audio playback over u-boot for TI AM62x SoC.
It ports MCASP driver which acts as I2S audio signal generator and
TLV320AIC3106 which converts the digital audio to analog.
Lastly, this also adds sound driver to complete the audio graph and enables
audio playback using u-boot command.

Audio can be played over at u-boot prompt using below command :
sound play <duration in ms> <frequency>
This plays a beep sound for the given duration and of the given frequency.

Scaria Kochidanadu (6):
  sound: ti: Add sound support for am625 board in Uboot
  sound: ti: Add TLV320AIC3106 Codec
  sound: ti: Add MCASP driver for transfer of Audio data to sound codec
  arm: dts: k3-am625-sk-u-boot.dtsi: Add sound driver nodes
  configs: am62x_evm_a53_defconfig: Enable sound and I2C commands
  linux: bitmap.h: Add for_each_set_bit_from() function

 MAINTAINERS                          |    5 +
 arch/arm/dts/k3-am625-sk-u-boot.dtsi |   85 ++
 configs/am62x_evm_a53_defconfig      |    9 +
 drivers/sound/Kconfig                |   18 +
 drivers/sound/Makefile               |    3 +
 drivers/sound/davinci-mcasp.h        |  413 ++++++++++
 drivers/sound/mcasp_i2s.c            | 1123 ++++++++++++++++++++++++++
 drivers/sound/ti_sound.c             |  119 +++
 drivers/sound/tlv320aic3106.c        |  758 +++++++++++++++++
 drivers/sound/tlv320aic3106.h        |  336 ++++++++
 include/linux/bitmap.h               |    5 +
 11 files changed, 2874 insertions(+)
 create mode 100644 drivers/sound/davinci-mcasp.h
 create mode 100644 drivers/sound/mcasp_i2s.c
 create mode 100644 drivers/sound/ti_sound.c
 create mode 100644 drivers/sound/tlv320aic3106.c
 create mode 100644 drivers/sound/tlv320aic3106.h

-- 
2.34.1

