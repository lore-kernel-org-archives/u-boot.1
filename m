Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD8EC30653
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 09:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F13B8842C;
	Tue, 25 Jun 2024 11:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="taYZc94V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EECDB8844C; Tue, 25 Jun 2024 11:08:52 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400DB88387
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 11:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=899203465=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1719306530; x=1750842530;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BMwMA6th8X0WqvHYfbD7Bav8evE6/Bc9Z7Yqev7DSsg=;
 b=taYZc94VjIoUmthu6uudaAATE7yuHRmDt3ARAzsYBhPLcAHg2pZgmEPh
 Day5OlvlAjzzi3kae13MTF/Zl8KCk9+6YS4xPq8+vpsF1a718fvtx9kT4
 mXSVPlzX2Sx+3cNs22JTJfWmJu5Nm09fGS7mjOJOUIjbfN1JIvmgf+T+t
 6K+8miq7TxaAKJEEo5MFiPpVjs7d1eZr57TnbXSupfjX/JKvCWI4X5ZQJ
 vKvk0LryyhiblFmyVW/8kq9jKCCaDM90ZwDWg7FF+FcdzdbN6fQfbHnKD
 5JQWs/Zj6/cQT18YcyFx/vH1Up+ZqtoCMuE0WlFbIaV9XTvtsMXjBX6st Q==;
X-CSE-ConnectionGUID: 1TAlZiLjSrG2uBOdBv8Y1g==
X-CSE-MsgGUID: /09JQyQ6Qq6ynzU52Q2S7A==
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; d="scan'208";a="259337853"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Jun 2024 02:08:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 02:08:23 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Tue, 25 Jun 2024 02:08:21 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <u-boot@lists.denx.de>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Ivan Griffin
 <ivan.griffin@microchip.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Cyril Jean <cyril.jean@microchip.com>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
Date: Tue, 25 Jun 2024 10:08:06 +0100
Message-ID: <20240625090806.1787287-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The firmware on the Icicle is capable of providing a devicetree in a1 to
U-Boot, but until now the devicetree has been packaged in a "payload" [1]
alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
The address of this appended devicetree is placed in a1 by the firmware.
This meant that the mechanism used by OF_SEPARATE to locate the
devicetree at the end of the image would pick up the one provided by the
firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
when u-boot.bin was.

The firmware is now going to be capable of providing a minimal devicetree
(quite cut down due to severe space constraints), but this devicetree is
linked into the firmware that runs out of the L2 rather than at the end
of the U-Boot image. Implement board_fdt_blob_setup() so that this
devicetree can be optionally used, and the devicetree provided in the
"payload" can be used without relying on "happening" to implement the
same strategy as OF_SEPARATE expects in combination with
u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provided
devicetree is only used when OF_BOARD is set, so that the almost
certainly more complete devicetree in U-Boot will be used unless
explicitly requested otherwise.

Link: https://github.com/polarfire-soc/hart-software-services/blob/master/tools/hss-payload-generator/README.md [1]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Ivan Griffin <ivan.griffin@microchip.com>
CC: Padmarao Begari <padmarao.begari@microchip.com>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Tom Rini <trini@konsulko.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: u-boot@lists.denx.de
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 4d7d843dfa3..2c1f7175f0e 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -9,6 +9,7 @@
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/sections.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *response, u8 response_size)
 		response_buf[idx] = readb(MPFS_SYS_SERVICE_MAILBOX + idx);
 }
 
+void *board_fdt_blob_setup(int *err)
+{
+	*err = 0;
+	/*
+	 * The devicetree provided by the previous stage is very minimal due to
+	 * severe space constraints. The firmware performs no fixups etc.
+	 * U-Boot, if providing a devicetree, almost certainly has a better
+	 * more complete one than the firmware so that provided by the firmware
+	 * is ignored for OF_SEPARATE.
+	 */
+	if (IS_ENABLED(CONFIG_OF_BOARD)) {
+		if (gd->arch.firmware_fdt_addr)
+			return (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
+	}
+
+	return (ulong *)_end;
+}
+
 int board_init(void)
 {
 	/* For now nothing to do here. */
-- 
2.43.2

