Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D72CD4F25
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C302D846A4;
	Sat, 16 May 2026 09:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="LC7+ho1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82E88469F; Sat, 16 May 2026 09:40:58 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A728468B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-368f25ff4c4so252099a91.2
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917255; x=1779522055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kOOY1YpvBngPt4VvNcMb9VAmhpDXi50gZpCwLkasnk=;
 b=LC7+ho1PB2a1SZcY55J6e3B2cv4vIPt/XBwNl6arJRSIuZsGG3rhoSyFu59RBS1DtZ
 GjhxD/+LwbrdCyitHUyl9NsymXGyUIs1I6rLKHuCIPoGj5KGfxbiVdp18yAHSItkH5ul
 lVGw7ylsC0EwxZK7wgg6klTzuZh6Erl+SeayM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917255; x=1779522055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1kOOY1YpvBngPt4VvNcMb9VAmhpDXi50gZpCwLkasnk=;
 b=RFZcnhj35YImmxSdNzqrOoaWUfUnYKU06GCOWoJPjiAk+fpdGzSuRxXkZ7l1gsm7+K
 yUy6JH6z5Xx/hx76D69HucIXKT4y3qDghxxJEyoWzWniY+ehiIdIWOCWwMYc5j6iHvVZ
 EDN8YaQZqFi4U2LjyZSv3Ukn/y1bIjIcjbJFsDVchI3UGMtY9fClBxyYZbnG4g53ylmG
 CckfE13gmgENMoxyLsJ1N8szMArmtY2LJP8ccr0SEEGpBAAvOkUcwWtjkT2Ka5uHoCdl
 VG78TKRwTJZXGxwnPsJsUTsl5p39N3/EAvgNKkhSZJefHUkaqsgNwDWU/dp71Q0MPRG4
 tEFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ88NI8Nf0RMBm5vt/8k5nAeJaUxcLkqeRjCytbBeehO2POxEvJ+FZS6SwCjlN9bJ645f1vzk7s=@lists.denx.de
X-Gm-Message-State: AOJu0Yxfpg/UP1xCmiSPPCd/6ivJaopyh3/CxG1VEiO4GRHzX2zNMXec
 XIDBnMMbEddCk9wmx2GcdLAk27T4qe2AwTw5ymCw/OLdfIrLVzc9aCl9B+3SjMLC2JI=
X-Gm-Gg: Acq92OFNmtyFGYAHWb1Etz1Eww/YXbGt8AIeFLm/rx/fs+Rrk4o1rNkoMDYZ6aOc8Ey
 9UXnenW+FMRWC3XZrhl54bMgE9hM4tmLwMRcIyjigVSkyS5bImaeDWum85wdHPkYxofsmvju2vP
 Aq+p+MX6ibe7irYIKsr4nS3QJBDBB+xiDXU68Uz37UoxY23Az9DZvcz2Ce/MvZtxaw/Kv05YVtS
 l4Oi2eOxJDHALARWx2YKnb42Vc6Zq/mQ2CqRDxXA1/dO3Vwar1v8OrRLnqalHwbed2YhmMilFQf
 YGMG9Nj12IM+dkSb0ZVeYN/+I0SZAcU0qC2xplgPV2x7R5Cj6ev8ycoyWcTDsJ23djGbOhhlcf8
 zixDYm5jeeSMnrYfAqIC4W6+IA3bKk4OVseCLVm1xfV4bdAC+sMf/XeYrqeHy/pmAAWnSBvuKZ3
 MvGYYhmshdC3PdP5ljELh8Pwl2UZT832B4N2CfnB/qyupFWhBnnErgUySzRTav4S4LOcX2FwM4r
 mw6/RZrb1wb2g==
X-Received: by 2002:a17:90b:4d0e:b0:368:6a6e:94dd with SMTP id
 98e67ed59e1d1-36951ca31d6mr7608046a91.24.1778917255172; 
 Sat, 16 May 2026 00:40:55 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:54 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 9/9] board: qemu: m68k: Create virtio mmio instances
Date: Sat, 16 May 2026 16:40:01 +0900
Message-ID: <20260516074016.885146-10-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
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
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
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

