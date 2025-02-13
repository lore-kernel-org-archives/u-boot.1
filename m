Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9196DC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 19:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F170080EBD;
	Thu, 13 Feb 2025 20:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m83zfxDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121A280F6A; Thu, 13 Feb 2025 20:54:35 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46965800C2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 20:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51DJsHaU4181473
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Feb 2025 13:54:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739476457;
 bh=mmn2FKBptEU2wqVQUqG7M1bMd3pGiuHjXvprexEP5gM=;
 h=From:To:CC:Subject:Date;
 b=m83zfxDYRA2iAnlf/cVYnmDuaAjdwEPCKA5YXe6ag438uAKXmQAX5DnSnBsskLGTo
 p10bjK3t/7kV28YsYbYqp2VC6oOJPEBW4ppBf+YWO1L4LPl4DYiSKuUWZDjuxP39J9
 SHYqK46UdF2LcGWlKFZGKMuyaEckahXB0q/W+C2I=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51DJsHMX043527;
 Thu, 13 Feb 2025 13:54:17 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 13:54:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 13:54:16 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51DJsG5e071088;
 Thu, 13 Feb 2025 13:54:16 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Raymond Mao <raymond.mao@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Neil Armstrong <neil.armstrong@linaro.org>, Aashvij
 Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, Jonathan
 Humphreys <j-humphreys@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim
 Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski
 <lukma@denx.de>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 0/3] EFI Capsule update explicitly sets dfu_alt_info
Date: Thu, 13 Feb 2025 13:53:48 -0600
Message-ID: <20250213195351.3518305-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
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

For capsule update, explicitly set the dfu_alt_info environment variable
before the DFU operation, and then restore it to the original value.
Previously, the dfu_alt_info environment variable was set with the
set_dfu_alt_info() function.

The problem with setting the capsule update's dfu_alt_info setting in
set_dfu_alt_info() is that set_dfu_alt_info() lacks the context of what DFU
operation is being performed (eg, capsule update, DFU boot, listing the
alt_info, etc) so the capsule update setting was overwriting the setting
for other DFU operations.

Changes from v1:
- use log_err() instead of pr_err()
- create a local copy of the original dfu_alt_info environment variable to
  be used to later restore it, rather than just a pointer to the stored
  value, because changing its value to the EFI capsule update setting will
  cause the original string location to be freed.
- even in the case of a DFU operation error, restore the dfu_alt_info
  environment variable to its original value.
- return EFI_EXIT based error codes if setting environment variables fails
Link to v1: https://lore.kernel.org/r/20250203215351.2840144-1-j-humphreys@ti.com

Changes from v2:
- add patch for xilinx boards to set the dfu_string member with the created
  dfu_alt_info string for capsule updates
Link to v2: https://lore.kernel.org/r/20250206154719.3032322-1-j-humphreys@ti.com

Jonathan Humphreys (2):
  efi_firmware: set EFI capsule dfu_alt_info env explicitly
  board: remove capsule update support in set_dfu_alt_info()

Michal Simek (1):
  xilinx: dfu: Fill directly update_info.dfu_string

 board/beagle/beagleboneai64/beagleboneai64.c  |  8 ----
 board/beagle/beagleplay/beagleplay.c          |  8 ----
 .../aml-a311d-cc/aml-a311d-cc.c               |  2 -
 .../aml-s805x-ac/aml-s805x-ac.c               |  2 -
 .../aml-s905d3-cc/aml-s905d3-cc.c             |  2 -
 board/phytec/common/k3/board.c                |  8 ----
 board/ti/am62px/evm.c                         |  8 ----
 board/ti/am62x/evm.c                          |  8 ----
 board/ti/am64x/evm.c                          |  8 ----
 board/ti/j721e/evm.c                          |  8 ----
 board/ti/j784s4/evm.c                         |  8 ----
 board/xilinx/common/board.h                   |  3 ++
 board/xilinx/versal/board.c                   | 16 +++----
 board/xilinx/zynq/board.c                     | 16 +++----
 board/xilinx/zynqmp/zynqmp.c                  | 16 +++----
 lib/efi_loader/Kconfig                        |  2 -
 lib/efi_loader/efi_firmware.c                 | 44 +++++++++++++++----
 17 files changed, 60 insertions(+), 107 deletions(-)

-- 
2.34.1

