Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE76D32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DCF89426;
	Tue, 12 Nov 2024 19:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dfSWkNM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDFD88DFE; Tue, 12 Nov 2024 15:57:53 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67AF88927A
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A576A40002;
 Tue, 12 Nov 2024 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1731423470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/E7V204FS1dHJ2GmL5kT0cSExoGHkI+QgIZyng2Jrc=;
 b=dfSWkNM9fT4VX4D9HHxqILSJRcd+YjVWg8M8hnXM9AJ0oEsf8rqLIP8/sqj/kPBrot2cka
 ue3YtiwwOk038ch4XQzb85FlkCFRzGno4z57ll4jj7dNrm/L4NVHXGLirv80K1EMWpqbsJ
 y1fmitUThj6n0uKtNvLyWXyBT1+laFjseQw2g2qPKu1fN1vrmmRcflQb0f3zR6EbKI4wsb
 60tBmFtJr/j2oZ7n8zVBOllfCTw11YzYI8yPK9/DbXf9f94gehJGqJxZxhCSj2eOxOUZ88
 eCYhAiutePAMZBHeMDdLtMHrN+q6EOvoTQonf9ExbYSazuaSFf59okvbW+eMuQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 12 Nov 2024 15:57:36 +0100
Subject: [PATCH 1/3] doc: add LicheeRV Nano and SG2002 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-licheerv-nano-v1-1-bf75d1eb560e@bootlin.com>
References: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
In-Reply-To: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: thomas.bonnefille@bootlin.com
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

Provide a page describing the usage of U-Boot on the LicheeRV Nano and a
description of the board.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 doc/board/sophgo/licheerv_nano.rst | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/doc/board/sophgo/licheerv_nano.rst b/doc/board/sophgo/licheerv_nano.rst
new file mode 100644
index 0000000000000000000000000000000000000000..70401e295c4a56845353c3a92ab4ec98678a1180
--- /dev/null
+++ b/doc/board/sophgo/licheerv_nano.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+LicheeRV Nano
+==========
+
+SG2002 RISC-V SoC
+------------------
+The SG2002 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
+
+Mainline support
+----------------
+The support for following drivers are already enabled:
+1. ns16550 UART Driver.
+2. Synopsys Designware MSHC Driver
+
+Building
+~~~~~~~~
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: console
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+   cd <U-Boot-dir>
+   make licheerv_nano_defconfig
+   make
+
+This will generate u-boot.bin
+
+Booting
+~~~~~~~
+Currently, we rely on vendor FSBL (First Stage Boot Loader) to initialize the
+clock and load the u-boot image, then bootup from it.
+
+To run u-boot.bin on top of FSBL, follow these steps:
+
+1. Use mainline OpenSBI with a newer version than 1.5 to generate fw_dynamic.
+
+2. Generate a compatible u-boot.bin using U-Boot with the LicheeRV Nano default
+   configuration.
+
+3. Use the vendor-provided tool [1] to create a unified fip.bin file containing
+   FSBL, OpenSBI, and U-Boot.
+   Note that you will have to use the file cv181x.bin as the FSBL.
+
+2. Place the generated fip.bin file into the FAT partition of the SD card.
+
+3. Insert the SD card into the board and power it on.
+
+The board will automatically execute the FSBL from the fip.bin file.
+Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
+U-Boot.
+
+[1]: https://github.com/sophgo/fiptool
+
+
+Sample boot log from LicheeRV Nano board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. code-block:: none
+
+   U-Boot 2024.10 (Oct 24 2024 - 15:00:20 +0200)licheerv_nano
+
+   DRAM:  256 MiB
+   Core:  19 devices, 11 uclasses, devicetree: separate
+   MMC:   mmc@4310000: 0
+   Loading Environment from nowhere... OK
+   In:    serial@4140000
+   Out:   serial@4140000
+   Err:   serial@4140000
+   Net:   No ethernet found.
+   Hit any key to stop autoboot:  0 
+   licheerv_nano# 

-- 
2.47.0

