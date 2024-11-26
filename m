Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D54DD3B988
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 12:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A656989C6B;
	Tue, 26 Nov 2024 13:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GPlEGeHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CBB89C4E; Tue, 26 Nov 2024 13:03:41 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEAEB89C4E
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 13:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQC3TpG824001
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 Nov 2024 06:03:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732622609;
 bh=xMe9sLVZ7MkfawZQu55NuF3wEs99GKuvmnkzJX4720U=;
 h=From:To:CC:Subject:Date;
 b=GPlEGeHhcm2beog4fuTo/+1VRoCJXwJAdABnhGtsyvedrCcLFVPZM6oYZdopSxGUY
 HSR/SCLv74owbteq9UczvzMw8ZVkxzIKrB1k0LpGev1Pf37n8jQwuv5eHJOqib0cJp
 MS0RW9XCBQATrR8+ZqHbFtKIcAnX6e/kUQeowyzc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQC3TRK000684;
 Tue, 26 Nov 2024 06:03:29 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 06:03:28 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 06:03:28 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQC3N2s051888;
 Tue, 26 Nov 2024 06:03:23 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <marex@denx.de>,
 <hnagalla@ti.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <jan.kiszka@siemens.com>, <jonas@kwiboo.se>, <j-humphreys@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/2] AM62A DWC3: Add support for USB DFU boot in OTG mode
Date: Tue, 26 Nov 2024 17:33:17 +0530
Message-ID: <20241126120322.1760862-1-s-vadapalli@ti.com>
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
However, there is currently no support for dynamically switching the "mode"
from Host to Gadget and vice-versa with the help of a state-machine.
The OTG mode is treated as a separate mode in itself rather than being
treated as an intermediate stage before assuming the Host/Gadget mode.
Due to this, USB DFU boot via the Type-C interface doesn't work as the
USB Controller hasn't been appropriately configured for Device/Gadget
mode of operation. One option is to change the device-tree to specify
"dr_mode" as "peripheral" and force the controller to assume the Device
role. This will imply that the U-Boot device-tree for AM62A diverges
from its Linux counterpart. Therefore, with the intent of keeping the
device-tree uniform across Linux and U-Boot, and at the same time, in
order to enable USB DFU boot in "OTG" mode with the DWC3 Controller,
the first patch in this series sets the "mode" on the basis of the
caller function, rather than using the "dr_mode" property in the
device-tree. There are only two callers of "dwc3_generic_probe()",
each of which clearly specify the expected mode of configuration.
This will enable both Host and Device mode of operation based on the
command executed by the user, thereby truly supporting "OTG"
functionality when the USB Controller supports it.

The second patch in this series adds USB DFU environment for AM62A,
enabling USB DFU Boot and USB DFU flash on AM62A.

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

Logs validating USB DFU boot with this series:
https://gist.github.com/Siddharth-Vadapalli-at-TI/daa71da1b0e478a51afea42605fb2d2c

Series is based on commit
3073246d1be Prepare v2025.01-rc3
of the master branch of U-Boot.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  usb: dwc3-generic: set "mode" based on caller of dwc3_generic_probe()
  board: ti: am62ax: env: include environment for DFU

 board/ti/am62ax/am62ax.env      | 1 +
 drivers/usb/dwc3/dwc3-generic.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.43.0

