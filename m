Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620BC10FC459
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 22:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C3678418C;
	Thu,  9 Apr 2026 00:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="OD4OxNP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB0B78407E; Thu,  9 Apr 2026 00:10:07 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813C384189
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 00:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso157300b3a.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775686204; x=1776291004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39x2J+ebsoD5FR0CWyPswTrMDeyjPp4g/YXM73sFfFE=;
 b=OD4OxNP1Ezp1/bfFGHN8QVbPHHXmPmq8Sf6Jyi/lcD0C3AAcX92NmymVpUlsjQH4th
 ENC61Pcyr+PQAf1S3FzKdBjKmK/NNVysx/7OciYws1k+Zcorh+WHvIcLkbcC0bJ9oG1A
 648sPxjxTfTWN2x7NeaRFtH414e9wGpxBhlqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686204; x=1776291004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=39x2J+ebsoD5FR0CWyPswTrMDeyjPp4g/YXM73sFfFE=;
 b=ceD/G/R7yh704OFtzOWe9njS6s/tV2R1TqLZksN98n47DKhqtbJt1cW+so+AIQ5dkT
 RGadWM9glsNZv1uVXl/ELcEeOLL0Q9UlCgY199U1CT1xZ686Q9olrmZs2HBITwIIb/zX
 sPyin+ugrUilOwgqur8lJDFJogeJZXT4oHe81Ds7Aent0ehO2Sc0SX8GJ7ZS0ZjsCsY1
 0kj8zYeqWiOVNPV2qe8k819U//V03Zgn4YjvWvySq/1Uydf9ywkUdlYAsU8ykOCPs0RO
 hysa9+FArOx/6O8rcjxFLZnnafpbild9Z8LeTyKUIJgyyTUJ9b+kDHJ8dSqy712C7UmW
 +UVw==
X-Gm-Message-State: AOJu0Yyfj7IE9SxxDAv6UbBe1nDN7GFt6lulgeiIYyRgbfyVxn58uE8U
 8CDjRQPOZag/l2nTzZ96lg4ZtO5vHdVkKfvxYWPtnxjRceXoWTVElipBJvDGr798EZU=
X-Gm-Gg: AeBDievWN/SimnL5M+syK7iWzf6RDeBEe0FBnpvpAQ0mz0KrWsUBv2upNFX2y6nBhrX
 AibsaS2RZxZqKhf6+5D90+IbwfHvYknALfPMXSPibt/DRf0hhjbE0Q7HLA3JkxJRdgJ6bN6sB//
 Gq216lIepofnfVV+rZ4kWS5kn8ARVZSD0ZaoTDNVcQ3AbRejx6virju6KX4qe8BS2j2zVR90JaW
 SBQMFJ6grcpKj6aiEjowfCvC5dlB5M3/omGvQU9avdiGl7eb4vlZ7JBFbQarLI2cQD+cnB0+euK
 vQa4qF1aO/CcNZ4R1+mLKCIF9HIkoE3CWFpZKOfd9RGBl+/b9euXmHqc59mE1lcH0S2wfrT2U52
 BNHMIiX9LOCx3w3aG8SBWG/DLtoGUVYZCJIuyeRgGIrh4LnaKabCsVqAGQgXL5gpI8QSBAdDsrC
 5+/5qLQrzS/+acYtpb6nD66NU=
X-Received: by 2002:a05:6a00:4c95:b0:7e8:3fcb:9b06 with SMTP id
 d2e1a72fcca58-82dd8b5eb79mr931375b3a.28.1775686203856; 
 Wed, 08 Apr 2026 15:10:03 -0700 (PDT)
Received: from kinako ([2400:2200:7f0:5ee8:dac6:2cde:760c:93f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm19877723b3a.25.2026.04.08.15.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 15:10:03 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v3 5/5] board: qemu: m68k: Create virtio mmio instances
Date: Thu,  9 Apr 2026 07:09:28 +0900
Message-ID: <20260408220928.3328551-6-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408220928.3328551-1-daniel@thingy.jp>
References: <20260408220928.3328551-1-daniel@thingy.jp>
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

So that you can use virtio network, block etc create the virtio mmio
instances. There are 128 of these even if they are not all used, a
single mmio base value is passed via bootinfo.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/Kconfig                     | 14 ++++----
 board/emulation/qemu-m68k/qemu-m68k.c | 47 +++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 6ce8f577e3a1..20a112880c87 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -195,12 +195,14 @@ config TARGET_STMARK2
         select M54418
 
 config TARGET_QEMU_M68K
-    bool "Support QEMU m68k virt"
-    select M68040
-    imply CMD_DM
-    help
-      This target supports the QEMU m68k virtual machine (-M virt).
-      It simulates a Motorola 68040 CPU with Goldfish peripherals.
+	bool "Support QEMU m68k virt"
+	select M68040
+	select BOARD_EARLY_INIT_R
+	select VIRTIO_MMIO
+	imply CMD_DM
+	help
+	  This target supports the QEMU m68k virtual machine (-M virt).
+	  It simulates a Motorola 68040 CPU with Goldfish peripherals.
 
 endchoice
 
diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
index d3527aee1128..3617c61b5c1f 100644
--- a/board/emulation/qemu-m68k/qemu-m68k.c
+++ b/board/emulation/qemu-m68k/qemu-m68k.c
@@ -14,9 +14,14 @@
 #include <asm/bootinfo.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/platdata.h>
+#include <dm/root.h>
 #include <linux/errno.h>
 #include <linux/sizes.h>
+#include <virtio_mmio.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -25,6 +30,38 @@ static struct goldfish_rtc_plat rtc_plat;
 static struct goldfish_timer_plat timer_plat;
 static struct qemu_virt_ctrl_plat reset_plat;
 
+#define VIRTIO_MMIO_NUM	128
+#define VIRTIO_MMIO_SZ	0x200
+
+static struct virtio_mmio_plat virtio_mmio_plat[VIRTIO_MMIO_NUM];
+static char virtio_mmio_names[VIRTIO_MMIO_NUM][11];
+static phys_addr_t virtio_mmio_base;
+
+static inline int create_virtio_mmios(void)
+{
+	struct driver *drv;
+	int i, ret;
+
+	if (!virtio_mmio_base)
+		return -ENODEV;
+
+	drv = lists_driver_lookup_name("virtio-mmio");
+	if (!drv)
+		return -ENOENT;
+
+	for (i = 0; i < VIRTIO_MMIO_NUM; i++) {
+		virtio_mmio_plat[i].base = virtio_mmio_base + (VIRTIO_MMIO_SZ * i);
+		sprintf(virtio_mmio_names[i], "virtio-%d", i);
+
+		ret = device_bind(dm_root(), drv, virtio_mmio_names[i],
+				  &virtio_mmio_plat[i], ofnode_null(), NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Theoretical limit derivation:
  * Max Bootinfo Size (Standard Page) = 4096 bytes
@@ -65,6 +102,9 @@ static void parse_bootinfo(void)
 		case BI_VIRT_CTRL_BASE:
 			reset_plat.reg = base;
 			break;
+		case BI_VIRT_VIRTIO_BASE:
+			virtio_mmio_base = base;
+			break;
 		case BI_MEMCHUNK:
 			gd->ram_size = record->data[1];
 			break;
@@ -80,6 +120,13 @@ int board_early_init_f(void)
 	return 0;
 }
 
+int board_early_init_r(void)
+{
+	create_virtio_mmios();
+
+	return 0;
+}
+
 int checkboard(void)
 {
 	puts("Board: QEMU m68k virt\n");
-- 
2.51.0

