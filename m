Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB9C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC8987622;
	Tue, 21 Nov 2023 16:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YtbTBJ6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 540FB8760E; Tue, 21 Nov 2023 16:28:11 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F8D87605
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D076B4351E; 
 Tue, 21 Nov 2023 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700580486;
 bh=LrqAR12w4GPfBV8CMiMg/kJ9RL+x/zFiriETJOdXfqE=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=YtbTBJ6ckUxq1NMn663QMwYC/lXXpCFX9AgeA44A3jE6p7hVZNk+kZXAX6RON86us
 SjVfgti4ss29lz9lhZj99KyAmDiLFwJtig+xPXN5s53SMnaUH3jHAJbmLBGLTf372P
 Oyofh8NmQ7tS+oorMK06VqKL262MOwgLp7+wSGKUjLwNslZzNpK9Wnp5MkD/BLTkbE
 Z+rloqmb9SM6ldGq4aj7Q9qaMINYlS++Gv4oiwxPYVzR/dmcplkNywc9LFRTZMuEv0
 Vm73gqCoQ6t0Gq8I4MX+1ITwSEDW5HKOXc/ytvj6Jz1ydLfOBt8M4JDBs2KX3yJq5V
 KG5XNyhrlWtfA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 5/7] riscv: qemu: copy ACPI tables from QEMU
Date: Tue, 21 Nov 2023 16:27:38 +0100
Message-Id: <20231121152740.24783-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
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

If CONFIG_GENERATE_ACPI_TABLES=y, read the ACPI tables provided by QEMU
and make them available to U-Boot.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 board/emulation/qemu-riscv/qemu-riscv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index 181abbbf97..2cebce2128 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -4,17 +4,20 @@
  */
 
 #include <common.h>
+#include <acpi/acpi_table.h>
 #include <dm.h>
 #include <dm/ofnode.h>
 #include <env.h>
 #include <fdtdec.h>
 #include <image.h>
 #include <log.h>
+#include <malloc.h>
 #include <spl.h>
 #include <init.h>
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -46,6 +49,20 @@ int board_late_init(void)
 	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
 		usb_init();
 
+	if (IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
+		uintptr_t addr;
+		void *ptr;
+
+		/* Reserve 64K for ACPI tables, aligned to a 4K boundary */
+		ptr = memalign(SZ_4K, SZ_64K);
+		addr = (uintptr_t)ptr;
+
+		/* Generate ACPI tables */
+		write_acpi_tables(addr);
+		gd->arch.table_start = addr;
+		gd->arch.table_end = addr;
+	}
+
 	return 0;
 }
 
-- 
2.40.1

