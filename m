Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFBFE668A0
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 07:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4723189916;
	Sun, 24 Nov 2024 08:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wDIiuuwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D2589920; Sun, 24 Nov 2024 08:08:42 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E1189507
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 08:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AO78YEF479808
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 24 Nov 2024 01:08:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732432114;
 bh=CJ+wCtCPn8PORclWY1sPDexcLEOFyxyg6z3QY9jJd0k=;
 h=From:To:CC:Subject:Date;
 b=wDIiuuwkB0uekGx0YjZz6TTGp6cimjrseMgorP9638hWGPX2h2ZNN+9mMcY/0l2by
 cZ/VKU0snl4v16hwkFKp3Ea7L/Ya1SQpNUx5rc9BMYBi+sCb+x+t601Z98P1FB8EIw
 J1HvKfO/ApaE2b2aC28txPtQ6g930cvH975DoWbA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AO78Y7v080265
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 24 Nov 2024 01:08:34 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Nov 2024 01:08:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Nov 2024 01:08:33 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AO78Tf4107079;
 Sun, 24 Nov 2024 01:08:29 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>,
 <m-chawdhry@ti.com>, <rogerq@kernel.org>, <nm@ti.com>,
 <sjg@chromium.org>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <afd@ti.com>, <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 0/5] EFI Capsule "dfu_alt_info" fixes for TI Boards
Date: Sun, 24 Nov 2024 12:37:54 +0530
Message-ID: <20241124070828.617558-1-s-vadapalli@ti.com>
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

This series fixes the commits which introduced EFI Capsule support. The
blamed commits unconditionally updated "dfu_alt_info" with the
"dfu_string" corresponding to Serial Flash and therefore its associated
partitions. While this addresses use-cases where the interface is indeed
Serial Flash ("sf"), it breaks use-cases such as USB DFU Boot where the
interface is RAM ("ram").

As of commit
52c0e5f8a3 Merge branch '2024-11-22-assorted-fixes'
of the master branch of U-Boot, USB DFU Boot on AM625-SK is
non-functional. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/726854b49eb199f4acf79028212fabdc

In order to fix this, update "dfu_alt_info" only if the interface is "sf".

The patch for AM62x in this series has been tested and it fixes USB DFU
Boot on AM625-SK. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/feaed5b0a30aff752306d370531a4e10

Series is based on commit
52c0e5f8a3 Merge branch '2024-11-22-assorted-fixes'
of the master branch of U-Boot.

v1 of this series is at:
https://patchwork.ozlabs.org/project/uboot/list/?series=433959&state=%2A&archive=both
Changes since v1:
- Replaced "SPI Flash" with "Serial Flash" everywhere.

Regards,
Siddharth.

Siddharth Vadapalli (5):
  board: ti: am64x: evm: Set "dfu_alt_info" only if interface is Serial
    Flash
  board: ti: j721e: evm: Set "dfu_alt_info" only if interface is Serial
    Flash
  board: ti: am62x: evm: Set "dfu_alt_info" only if interface is Serial
    Flash
  board: ti: am62px: evm: Set "dfu_alt_info" only if interface is Serial
    Flash
  board: ti: j784s4: evm: Set "dfu_alt_info" only if interface is Serial
    Flash

 board/ti/am62px/evm.c | 8 +++++++-
 board/ti/am62x/evm.c  | 8 +++++++-
 board/ti/am64x/evm.c  | 8 +++++++-
 board/ti/j721e/evm.c  | 8 +++++++-
 board/ti/j784s4/evm.c | 8 +++++++-
 5 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.43.0

