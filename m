Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC92E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 343388021D;
	Tue, 17 Dec 2024 14:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LNzV/UIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3227801CF; Tue, 17 Dec 2024 14:17:27 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D99801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHDH5Wu3970125
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 07:17:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734441425;
 bh=WutxAz3kRhV6Qe9emgdyGlbuk8gwLCdmA03ocHtdo/Y=;
 h=From:To:CC:Subject:Date;
 b=LNzV/UIuKz91WS+yK2s5j7ByeoJJw+wREUWzXTNssuhIOweS79Cnox4Bs0JpwJo3J
 szrn+6ZorDQRHS/yDwI8hJf7s8TT5Nd0XzsOcfFNKlhcO7lnamzTQm+0RS5ujJecLa
 4HmVDnORejdrUlbSQUR5+gOXo3y+xZ54GsBSQlkA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHDH5g1065750
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 07:17:05 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 07:17:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 07:17:04 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHDGxZL085338;
 Tue, 17 Dec 2024 07:17:00 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/4] Add support for USB DFU boot on AM62Px
Date: Tue, 17 Dec 2024 18:46:28 +0530
Message-ID: <20241217131658.2920799-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello,

This series add support for USB DFU boot on TI's AM62Px SoC which has
two instances of USB Controllers, of which the USB0 instance of USB
which is a DWC3 USB Controller is used for USB DFU Boot:
ROM => tiboot3.bin => tispl.bin => u-boot.img

The first patch of this series is based on the suggestion of
Jonathan Humphreys <j-humpreys@ti.com>
at:
https://patchwork.ozlabs.org/project/uboot/cover/20241124070828.617558-1-s-vadapalli@ti.com/#3419733
which prevents overwriting the "dfu_alt_info" environment variable which
is set by "spl_dfu_cmd()" for USB DFU boot.

The second patch adds USB DFU environment for AM62Px.

The third patch extends "am62x_r5_usbdfu.config" config fragment for
being re-used by AM62Px SoC by dropping configs which aren't required
for USB DFU boot. This is necessary to reduce the size of R5 SPL
(tiboot3.bin) built for USB DFU boot.

The fourth patch enables USB device-tree nodes for USB DFU functionality
on AM62Px. Since CONFIG_OF_UPSTREAM is not yet supported for AM62Px, the
changes are being made in arch/arm/dts/k3-am62p5-sk-u-boot.dtsi at the
moment, with the intent of making the same changes in the Linux
device-tree and eventually enabling CONFIG_OF_UPSTREAM to drop the
changes made in "k3-am62p5-sk-u-boot.dtsi".

Series is based on commit
3b3c7280b82 smbios: address build warning
of the next branch of U-Boot.

The USB DFU config fragments for AM62x are to be re-used for enabling
USB DFU boot on AM62Px as follows:
R5  => am62px_evm_r5_defconfig + am62x_r5_usbdfu.config
A53 => am62px_evm_a53_defconfig + am62x_a53_usbdfu.config

Series has been tested on AM62P5-SK. Logs validating USB DFU boot on
AM62P5-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/50198ee3348c2db73e0dbd3a14cb0f8b

Series has also been validated on AM625-SK to ensure that the changes
made to "am62x_r5_usbdfu.config" config fragment being used by AM625-SK
for USB DFU boot do not cause a regression on AM625-SK w.r.t. USB DFU
boot. Logs validating USB DFU Boot on AM625-SK with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/85a7579ed2c95330ac71ee3a832cadfb

Regards,
Siddharth.

Jonathan Humphreys (1):
  dfu: do not overwrite "dfu_alt_info"

Siddharth Vadapalli (3):
  board: ti: am62px: env: include environment for DFU Boot
  configs: am62x_r5_usbdfu: extend for AM62Px
  arm: dts: k3-am62p5-sk-u-boot: enable USB0 for USB DFU boot

 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 ++++++++++
 board/ti/am62px/am62px.env            |  5 +++--
 configs/am62x_r5_usbdfu.config        |  3 +++
 drivers/dfu/dfu.c                     |  7 +++++--
 4 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.43.0

