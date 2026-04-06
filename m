Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC6DF46C46
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 14:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17D983F98;
	Mon,  6 Apr 2026 16:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="D3MP9CQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D792A84101; Mon,  6 Apr 2026 16:24:42 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2782D8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso19375295ad.2
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775485478; x=1776090278; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39x2J+ebsoD5FR0CWyPswTrMDeyjPp4g/YXM73sFfFE=;
 b=D3MP9CQqrow1Cq5XSDO0nPo9B1d0PlLRLJ11mRaAboDyT0naJRm20MfsKUtOJ4hAHM
 gvClUtdYMfMZ/o1xildgUUOzzziUuwtuM/W190o1gjiN5d4gTXkZNS8LPwFpIbb8eQzf
 W9s/4aD2v3wJQr09OD4DOotw7ZE6QOe7Lhrdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485478; x=1776090278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=39x2J+ebsoD5FR0CWyPswTrMDeyjPp4g/YXM73sFfFE=;
 b=HWUCKVjioL3eoTl52gG25zJaoT2u0/oyYeHlZholaxy7edMXlEM7NMKjjlQXRWjYgj
 T3eOATOk7zqz6Iba0Lf2fTdl0NVjyFACddWOmeB09OeGPPL3TCywdDIBPVhvLfQtvT5C
 vUcaU1fL0eAAYnj/SV+7tmTyOMMnSVLj8pXgKohIeNG4RBcXdmtuKFCKxxZaA7U7RtTz
 kYY7XV0duLFjiceFgdkzXphdVM6/Oa+JINNGfVf4LQIBhS7iebN8zdgJjNqP4DfrTETA
 Be18Wa1KO3TYg9eca6Cht8bCBwhJb2i35+JpbRgjmtLL8Rj/1SATz6jh6B/BkuWdsr4l
 HYxw==
X-Gm-Message-State: AOJu0YyWgmbEBVBfxogx343BQZqciwBTTXiko71CCdrV6s/SwZX0FhrJ
 j+im0yUk0H9yfVpRaUWay+fnGGWEonJZPaill4ujgXkUOBf7CevLTeaxQ2BkmS0ejeI=
X-Gm-Gg: AeBDieutXutwouYZFQxy/Ei5LDtJs7UrS2onmo3XLhEolHPNvOBAeJiXAjrRGxY0PKS
 wAWsITWmwQUMySaC88VnyyfSPz/70+EoPyUxc4ZMGwgX6iVEVM526w2J9NrJ+E/B5ZIrvKeMceG
 NrsbAxor3FyHvF+jlNGeC5swT89j7ntMXYrp7/mizhZhj6BL62dB5hlw3Z6aWYwdu9cXTjnd4uC
 knb9NERIPQF3u0+N5ESljH8982pFWKyWrkCbcu1MdPTBDQPF4AFXiiILiJ0H7BNWp2ujJiJ1MLr
 DZv0Z/UHmIv5Q0bDFMDAd/N027KSjpUxdOXohqSAKxx85sXqUacqo8gJkVRSY+Ap0t83/9fHSxB
 DZMkR2wlTsVXjfV+NFZ1Tle152lzQ10kIpdrPvwiSOtfAFBo3tNfmS9se7MEvGse2V8VcTRSpPA
 IAIF3vZJmzURTCEapNayFiYGdCT46NN/Fd0d2K6Q00cdwuCu4HTAGv4CHMe9XDEEsNZbMMfLSIS
 fHRVvzRp5I=
X-Received: by 2002:a17:903:22c6:b0:2b2:680c:2193 with SMTP id
 d9443c01a7336-2b2818b3ae8mr136985685ad.31.1775485478609; 
 Mon, 06 Apr 2026 07:24:38 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1866070-ipxg00f01sizuokaden.shizuoka.ocn.ne.jp. [180.1.30.70])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156885295ad.29.2026.04.06.07.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:24:37 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2 5/5] board: qemu: m68k: Create virtio mmio instances
Date: Mon,  6 Apr 2026 23:24:11 +0900
Message-ID: <20260406142411.2992618-6-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406142411.2992618-1-daniel@thingy.jp>
References: <20260406142411.2992618-1-daniel@thingy.jp>
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

