Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6919DF8A152
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD928429E;
	Thu, 16 Apr 2026 11:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="O97ExSMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1022E8424E; Thu, 16 Apr 2026 11:40:18 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B073884285
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c796163fac5so810424a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332414; x=1776937214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9gevuHtm9cnK6KGw9LP5ZE84A0qzge01tLT5MS8zJY=;
 b=O97ExSMjCWjuP1ry0OCpc5+GB1vPUVm0jfMOiBPch8mtg3HCVnGqOXsfXa1c6hA4Vn
 a1/eXFinGOSeN3r/U3llj6BSrt1/o8WVS0mGWYyo9idpE8yJar+d7JqDoL0QLvDxwW1O
 ICUBl0m84L+V27JVtDsr3UZMbtYyeNs3HHOmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332414; x=1776937214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n9gevuHtm9cnK6KGw9LP5ZE84A0qzge01tLT5MS8zJY=;
 b=kArJLrOrsavkHcwkCxo/BSGrTUDHFaJbKFGmNt/KOh/gAD34H7BmFsBaUcl+XSQwML
 nFLcDZE/vAagT2CZWOn+QEK6JaKRKvVg82ccpSGLU2OGjw/XiKPZfWgxS1ykxzhFaRw6
 s/Ihv9HnwOZoqq+v5g/D0pALGmpU6mUElCqdtQoPs5ZzwgFfc+zp7vfHyFamtz9e2oFq
 X3LgCg20ozoxIfq3dwZM6IYxFjuc8vBW7x+JTJvtKXvdgXXbgqL35qR1QWiQEbPoviDM
 5UMpTebB7LCGPG3Ufk69/sIhWTODH9JLiQO0OtVpTb7RVkyjDYb/XxWtFWGj9JUpE+l1
 jiIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MRVBC6CsNZDs+gjRavO6/GBuVsLrpyGugWW7RxbiNHKuKYry2iWcJjUGnn7jiuOBt1ziEbrg=@lists.denx.de
X-Gm-Message-State: AOJu0YxLdPB5zTvUuYGbNHN8YDS/hL1qgJu70kyRrmw5p3Umdu4JIJ7s
 nfyl/kx0R9J3bqn7a580FwlnpzM4HNwcTvBR/5Quxe1S8Z1OU4zUkTy0vIsy9fNwi11vuIHkeG1
 SGBVP
X-Gm-Gg: AeBDievebuJC4fy59H4nGoz2FIyienhUfTel1vtn0Jxp/L9MRbLa6mlQpa4vMoMFJlF
 5PXE47ynjxDD2FACiQhhy9GQ5rxJQqY5eyZL5UEV9c5g+iAbJl1iUb2okQyktNPl2/96I1e57zp
 FurvIVxIUkTJ5mfgwdptpDdLB6zy1tNROpIEXx3/gwGk54A+E/pM5nx0II3oVKJC9uV/yd7Kz7t
 MYmZzUmq4w7II1iKSPYoqpw/+2e5k3fVa0K5n2QLnRle+CiPnOMxpc3i3uHnrSV2bkYxMJDl9kj
 Dx318Lrx+4q4B71Ykqtf0bOsY/bMpXj2Gxagqtvro4NpN5n/7oGngNS3Wo/hxm1QpjW1+qSpr1l
 Mj7J6UojQlQfexpP4KnSDNWCpw/zKAMrz0cjNvxEtTbOX6Kl7q3L9PXveTMx4+2cRr/o8E5dIAm
 RA7mt7FHTlo51w7aB/9mA3XcMcBWh5m6fP2KdkxrpzW4bFdVhN8WY4EZrAzF3FWBU3vTM9T0RuM
 rn3OggFbqjdIA==
X-Received: by 2002:a05:6300:615:20b0:3a0:cd5:82b7 with SMTP id
 adf61e73a8af0-3a00cd5a76bmr15811768637.55.1776332414112; 
 Thu, 16 Apr 2026 02:40:14 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:13 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 8/8] board: qemu: m68k: Create virtio mmio instances
Date: Thu, 16 Apr 2026 18:39:27 +0900
Message-ID: <20260416093927.602613-9-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
References: <20260416093927.602613-1-daniel@thingy.jp>
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

Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/Kconfig                     | 14 +++++----
 board/emulation/qemu-m68k/qemu-m68k.c | 45 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 6 deletions(-)

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
index d3527aee1128..a19b23a28ce3 100644
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
+static int create_virtio_mmios(void)
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
@@ -80,6 +120,11 @@ int board_early_init_f(void)
 	return 0;
 }
 
+int board_early_init_r(void)
+{
+	return create_virtio_mmios();
+}
+
 int checkboard(void)
 {
 	puts("Board: QEMU m68k virt\n");
-- 
2.51.0

