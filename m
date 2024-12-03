Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D58D4979A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB16189653;
	Tue,  3 Dec 2024 10:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="emqs9fBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C347F8962E; Tue,  3 Dec 2024 10:38:04 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7626E89666
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B39bsaD094151;
 Tue, 3 Dec 2024 03:37:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733218674;
 bh=2Isne2Z/w+IDGC5+Wmf0skrjmBib9PHa4sox17rAFVM=;
 h=From:To:CC:Subject:Date;
 b=emqs9fBtPYo1WsBhWrEzNvdeQsIyAzwoE+fqlhSeZyxQ1Qk5A2g7DVhTuWqFjwaBV
 1j7cO8vE34c8oK9B8kzyYTZRt5kL/OnnTeKgnfCtFFQSJGuw55kUpoawjnc/0oQM9a
 3Ci9NntWzqS950CSZ+LPxij10V7RuSKwM/ePSO8k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B39brZJ073001
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Dec 2024 03:37:54 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 03:37:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 03:37:53 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B39bnbq032386;
 Tue, 3 Dec 2024 03:37:49 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <marex@denx.de>,
 <hnagalla@ti.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <jan.kiszka@siemens.com>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] AM62A DWC3: Add support for USB DFU boot in OTG mode
Date: Tue, 3 Dec 2024 15:07:43 +0530
Message-ID: <20241203093748.138260-1-s-vadapalli@ti.com>
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

This series adds support for USB DFU boot on TI's AM62A SoC which has
two instances of DWC3 USB Controllers namely USB0 and USB1. The USB0
instance of the USB Controller supports USB DFU boot:
ROM => tiboot3.bin => tispl.bin => u-boot.img

USB DFU Boot requires the USB Controller to be configured for Gadget
mode of operation. Since the USB0 instance of the DWC3 USB Controller
supports both Host and Gadget modes of operation via the Type-C interface
on the AM62A7-SK board, the device-tree specifies the "dr_mode" as "OTG".

The function dwc3_generic_probe() is invoked by either of:
1. dwc3_generic_peripheral_probe()
2. dwc3_generic_host_probe()
on the basis of the command executed by the user for either device or
host mode of operation respectively. Currently, dwc3_generic_probe()
sets the mode based on the device-tree rather than setting it on the
basis of the caller. While this might be correct when the mode is "host"
or "peripheral" in the device-tree, it is wrong when the mode is "otg"
in the device-tree. It is wrong because of two reasons:
1. There is no OTG state machine in U-Boot. Hence the role will never
switch to the correct one eventually among host or peripheral.
2. dr_mode = "otg" results in the "PRTCAPDIR" field of the "GCTL"
register of the USB Controller being set to 11b. According to the
datasheet of the Designware USB Dual Role Controller, "PRTCAPDIR"
should never be set to any value other than 01b (Host) and 10b (Device).
Quoting the datasheet:
"Programming this field with random data causes the controller
to keep toggling between the host mode and the device mode."

Therefore, in order to avoid programming 11b in "PRTCAPDIR", and, given
that the caller specifies the intended role, rather than simply using
the "dr_mode" property to set the role, set the role on the basis of the
caller (intended role) and the device-tree (platform support).

This could be extended further to utilize the USB ID pin to determine
the expected role, but that can be implemented as an incremental
feature.

v1:
https://patchwork.ozlabs.org/project/uboot/list/?series=434253&state=%2A&archive=both
Changes since v1:
- Rebased series on commit
  acab6e78aca common: relocate fdt_blob in global_data for FDTSRC_EMBED case
  of the master branch of U-Boot.
- Based on the feedback received on the v1 series, the device-tree
  specified role is also taken into account in dwc3_generic_probe(), in
  addition to the caller of dwc3_generic_probe().

In addition to the patches in this series, the following device-tree
changes will be required to test USB DFU on AM62A (bootph-all property
to be added to ensure that USB Controller is present at all stages
for DFU Boot):
https://gist.github.com/Siddharth-Vadapalli-at-TI/53ba02cb0ff4a09c47e920d08247065f
The above device-tree changes will be made to the Linux device-tree,
which shall ensure that the same shall be a part of U-Boot device-tree
eventually.

The USB DFU config fragments for AM62x have been used for enabling
USB DFU boot on AM62a as follows:
R5  => am62ax_evm_r5_defconfig + am62x_r5_usbdfu.config
A53 => am62ax_evm_a53_defconfig + am62x_a53_usbdfu.config

Logs validating USB DFU boot with this series on AM62A7-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/13f9a539ef3297ab2822bc1bc1976a7f

Regards,
Siddharth.

Siddharth Vadapalli (2):
  usb: dwc3-generic: set "mode" based on caller of dwc3_generic_probe()
  board: ti: am62ax: env: include environment for DFU

 board/ti/am62ax/am62ax.env      |  1 +
 drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.43.0

