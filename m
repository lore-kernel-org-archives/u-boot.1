Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BDDCD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F986846F9;
	Tue,  5 May 2026 09:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="Q0Ig5mg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A0484867; Tue,  5 May 2026 09:50:12 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B6B846F4
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b9fcf7c91bso23248015ad.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967408; x=1778572208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jndIn+4A7KdbivqHWcDepFFYPNsgpk+Rn9R2scjCMbI=;
 b=Q0Ig5mg6UsFwjuiir0Nb8IV9hAmNENe1pKBTrMKWRDcBdmTSRkSMKOl/lG65Le1zwB
 4lsh4ssoI26CrM0Wg78vHJ9cgFFIDjgboIM1iQsKOTe5WQoAZlpboMihY59BghQDaPRD
 NZ2THZN55fAhNG5uqxgYsrm1tY+BzZJk+8+0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967408; x=1778572208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jndIn+4A7KdbivqHWcDepFFYPNsgpk+Rn9R2scjCMbI=;
 b=ghojwcL/sQSXLZ2jSLiMGcZuN3E0sjLK1oDF6z1d5ONaKKoClk+sY4m51fPfN2nAR/
 1df7X0nlZDQPYLzFKmGggZZvhW1RSkVsvtSRmykLQdIpu7oXDshQe/66nIDKYdhsYNo/
 NGBfc1SFVWTVMmv5uNXWEJZAR3//uhEEwgGHBG3pS+y+3dMERWn1rEagZSOsiem+0PD3
 /ht5tyYZ6hNwqOYxnk76ndzb7jfMahmRyjAH/hbV+ex5t0ByCxlb384NguyFV0wHuFt/
 sdov7Sq/pyQUP/zh/FD/TIbhTBLA1Sn0kSMyBlITDuJHP3cOmZQ85D7ZZR9MwhXsE+kJ
 XQKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1hF6+PwtorcTj0wvDpdNgrzZx81hvBL2xd11HEH2yDvOZ5ta2P59AC1IFDHuUHmInOld7bqo=@lists.denx.de
X-Gm-Message-State: AOJu0YyTdmgzK8Zpai3aXHfXyCPk8zupP2GPYVg/8vqHZyyyGPVDZ3EA
 cf797x2+Gtz0lZ0XlLvZqMceEJJDPCtx61Tp4CMRoTUjqyhjDJ0tZTeZIpKlY19yU3A=
X-Gm-Gg: AeBDieuRtGl08eHoc2fzEAtm3Pkcbx89u4VvVCR1A+o8Gmou2NtFtuDe6fdLt563G6d
 ErG6FnljZ8R26UKjkdMgC7bhpeD+y6lrHq6OFSgLXYq9gLajs7tfV+VBSM4cc6+BJmAcGpBG3DS
 hOVqkiIRPm6OoRqKyhPhh/yuYz9ASkA2g+74Sv8U6TA34zZ9QLAwwPPlZpB4tF00Jo2ZY8Izr/5
 yNUIy2qYMqKQf5Gqv7yc0yDZrEGHsk0SAo1nosDz76l0eHwdUeRQ0d0h5ytEvdIsaYodavf40mr
 F8LSz5TR6Q4p4IlQguVOIPzWhQRSkMzvAhjfPy6VeqzS8jd0ElgvWXFRC73Zh9Ic56rj4NYmaXH
 gkibBTJPqTxumBK02ltQ2u3z7fcKgs7T5P38Hepk3Viufm7ypAHSVedZyl1waUk2Y0fpsP5z+RP
 rOgkDDdU0Yof/iTNHKh0jthTLwJI7sEPyUvsr5AQHm/snZk3LRwsx1HLuVq8IEnRSjfKN5fJwSY
 ycfPzbZIOH4+7fzJB/27YPCL8o=
X-Received: by 2002:a17:903:48b:b0:2b2:eaec:c810 with SMTP id
 d9443c01a7336-2b9f2533763mr77364465ad.8.1777967408596; 
 Tue, 05 May 2026 00:50:08 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:50:08 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 8/8] board: qemu: m68k: Create virtio mmio instances
Date: Tue,  5 May 2026 16:49:41 +0900
Message-ID: <20260505074948.2603870-9-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505074948.2603870-1-daniel@thingy.jp>
References: <20260505074948.2603870-1-daniel@thingy.jp>
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
index 00e89bd0a625..8bebf0ea3e13 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -196,12 +196,14 @@ config TARGET_STMARK2
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
2.53.0

