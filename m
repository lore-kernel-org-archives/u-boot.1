Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D4CFD2D9A
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D57E84057;
	Tue, 10 Mar 2026 15:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="VT31HA9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9F884057; Tue, 10 Mar 2026 15:01:39 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC7683FDE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3598cab697eso6016686a91.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1773151295; x=1773756095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pStcdp/c48u+uWS79A5Bot7Ja3xLon/4/iZUhujIsDY=;
 b=VT31HA9BwO1LhtQuxKhxM/d+DDfabP9GH9FS30n3dHdEo0juvtnxXjCaeYKDt9B1hz
 sOe6JUP9BhQF82yluiffMOX6EmBI3f5JA7Gh+I4Mql5/41Scnb+7bQ2xl3MpnfhPMQD3
 Wf/rI2pNlshlGUpZc3gztlyDqOjORbsdA33Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773151295; x=1773756095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pStcdp/c48u+uWS79A5Bot7Ja3xLon/4/iZUhujIsDY=;
 b=TccJ+tvFQIGJzx9V7udA1tMmkNpRLpiQvwig8nEkvr3X1C42pHxTEtC+usht92G0OC
 vyHXhtHl24YjsjUPKEHmn31+R/0cnjI6gyybKjMlNGvWR0RZoRUCBhWndMoLh5KjKbDn
 xBfNI4l7/yRsijYYYE3zOYACRyhZtaAwKdpKanbBJjZ27wz/CXvZedsgfTIBrR4WfrH8
 /O4oIopOz1McIC29A+WvRHqT9l+2+z60b1BLf4kOCbRZGAf+Eu8OT2GLEg8AvnMdRNBk
 1RLSJPU3AzIdeIRm9UpcNKrGFUkgpuM4gQtpjsFQehHVYSgktl1O9yDU4ORIBfs8oSx1
 3vTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4qiYlSMsS/iKNZC99MrpqYwHwDzc3a9ANnqCgsIASGqOIPEGoVuW4ZyJ9NAcHYWKAxRce7Io=@lists.denx.de
X-Gm-Message-State: AOJu0Yxrikf1XZNejeLCY1pwkx/Ah+O1mNozBU2lrJZhHa20ykwv47Ka
 /hhS41+3fuY58HLT25vXGy7yT/T2BejFMmjXlF/4umu9FGOgFacdAo04+V4O2zhIfqI=
X-Gm-Gg: ATEYQzyf4Y2FSM7m40Uew7HyElOqyiGCIMsq/MOVIQaAV+vZwjeos3OrWRX3Yqtb5EV
 KTcY0APexw58Ruuiy8pwcd4LMFZAFTeXG25O9kCOKrEtC1z8nFzc02JJsti27ofmGp1HIh/m4U+
 Tvob+86CIfRR4nzuCrypcuMX26rYQhwtba/K5Z7VBdHGy/yPjlvj+soXdKe5Z9w7pNyR/FfDdlu
 5A0vL1SsYDJA5bIwIPTtikI0nBvvaRG5cheDjQzopg1GpfHosoRMt5aXGGCj0CURoBrGy4iv2Xu
 pT9EE8OFu1i5b+5TyxGbYW3O6OtZCS3wKWW6saLQ2Uub2W92no5GLtm2d3dnMEw9c00JWJBnicD
 SxV8MC+I9Vzy+6kyWwdBXXGD4ebiwkJcVZqGg2C9xIH1fYhTjGS/DVZl6qPCr75rbw1LP9v6IAO
 r7HIJu4APxcsl6nouQiGIS9Ic6lOSWsvdU2YXJLi7bxaFapFlN7L2wk6w7CgBzNnJrn5rbTc+La
 hWWmYKkKIO7
X-Received: by 2002:a17:90b:3e50:b0:356:7025:56c7 with SMTP id
 98e67ed59e1d1-359f012c6c8mr2703914a91.5.1773151290048; 
 Tue, 10 Mar 2026 07:01:30 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.167.218.150])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bc9bd61fsm7863531a91.3.2026.03.10.07.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:01:28 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: laurent@vivier.eu, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 3/3] board: qemu: m68k: Create virtio mmio instances
Date: Tue, 10 Mar 2026 22:59:40 +0900
Message-ID: <20260310135940.1756141-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310135940.1756141-1-daniel@thingy.jp>
References: <20260310135940.1756141-1-daniel@thingy.jp>
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
 board/emulation/qemu-m68k/qemu-m68k.c | 46 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 6 deletions(-)

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
index d3527aee1128..2517ecf1bb8c 100644
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
 
@@ -25,6 +30,37 @@ static struct goldfish_rtc_plat rtc_plat;
 static struct goldfish_timer_plat timer_plat;
 static struct qemu_virt_ctrl_plat reset_plat;
 
+#define VIRTIO_MMIO_NUM	128
+#define VIRTIO_MMIO_SZ	0x200
+
+static struct virtio_mmio_plat virtio_mmio_plat[VIRTIO_MMIO_NUM] = { 0 };
+static char virtio_mmio_names[VIRTIO_MMIO_NUM][11] = { 0 };
+static phys_addr_t virtio_mmio_base = 0;
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
+		ret = device_bind(dm_root(), drv, virtio_mmio_names[i], &virtio_mmio_plat[i], ofnode_null(), NULL);
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
@@ -65,6 +101,9 @@ static void parse_bootinfo(void)
 		case BI_VIRT_CTRL_BASE:
 			reset_plat.reg = base;
 			break;
+		case BI_VIRT_VIRTIO_BASE:
+			virtio_mmio_base = base;
+			break;
 		case BI_MEMCHUNK:
 			gd->ram_size = record->data[1];
 			break;
@@ -80,6 +119,13 @@ int board_early_init_f(void)
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

