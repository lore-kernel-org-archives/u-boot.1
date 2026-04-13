Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0569AEBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA7B84201;
	Mon, 13 Apr 2026 11:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="cq47j6n1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2514841CD; Mon, 13 Apr 2026 11:23:24 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4964E836AC
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so4217607a91.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776072199; x=1776676999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvffEMejxyaQs4cvL62eu2mn+EsjXjaofemNueGsB/U=;
 b=cq47j6n1DMeulPCWJJOHrF4uJRJWWF6MXpaXUyoOAyX2+crFakM6O3eraUUEL5QQ50
 votsThCvgR7jZG0i+qAeC658A7HNduPdI3zTu1GojdpqZqVkvU4lwGb4U0YZV6CpTE9I
 4QwM3yq2a0eV2c+H9WT8K/DR8w91AG7/W1L0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072199; x=1776676999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vvffEMejxyaQs4cvL62eu2mn+EsjXjaofemNueGsB/U=;
 b=R/v7uD1nkYvzWuwcz54eK0BPvO2AX001yKI1d+QvFxPO2qEk9jkFar0qxfGToGWZjS
 NEryCy2pKH2JQ3o9nFqJxEXJR8+Q2Flkolwtmyu0dAV+RYQkIl/pYZB8MVEln9DKoeDM
 MaWcsQirjP1PmvYVLox9DQSnfdvlvunTlFiHnegBLtvWjToTLRowdiED+21MtowrjE/W
 mjUrflRPcWmZEIKisVUaTnx6vW0VbP4bL4XSII0nF4oAj4VLqRVWM+2gpf3wPPBLNaH1
 vkVFMnsUaB+tha8ZWSI7R+Nftg/Qg2Z8pIltwl8mT2VFzsbVwC9u0EHPTTlblQZ0pQOJ
 sBGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GjKu4xnEPHzzbZIIMEgk9vDjr3T/OopFiDKCV73j0b3iBe+S9T9oMAmOioVX1+8ILjQeAFhM=@lists.denx.de
X-Gm-Message-State: AOJu0YwPKaQg2VNj/J9S0oRvLhls5TqnzWAFvRc/9xpEi9IoPm5Ry7cf
 Rh9DpOwp9wR8vDatKrBqL9ZbS7rkLlUqZfOr3aofBQYsFJWY1uDVI1Kx4QcN3EWLblw=
X-Gm-Gg: AeBDiev1Hm4k6jPVOAsTk+whNIHEYi8W6wSLovetMQXSncnlEnHnlz7zeIM4C32H6zd
 bqhE1qOiHFSIsZeX2ByMUp5F/WRTd1SdzPtmCvRdXPZMMtO41LrIUq/29CQ9T6L1LgwCYM6N88k
 wqXGDCw9QinB+Iu0MeX4I3OG06yc4PMXkvTVuFQh6ttfZ9BglXT0lZsj7iBJnGVCe1wg3tpU0o7
 YOlVUj1HI9SFkqoLi/1gOUYOKZDvhbEN/bKFkyauNYFDS3Vqmwsh0QrwYcxEoCBR3p6/CQiaL5G
 5bvEY7FWPceh+LohyI7thrDZv3OaZ8NPChdMtcGbDaSj5PIHe2QbBG16IGxGYS+B7g7nw6YFWWU
 rP3gs0O4iYdnGOIZ+UfvCIZcp4rUdQao3ls3OkIR/+4zXljk19BKtm/mUNLJ/1ywgGiBs/ooAxO
 INJLfu60huv0+VGA==
X-Received: by 2002:a17:90b:3d48:b0:35d:93ff:284f with SMTP id
 98e67ed59e1d1-35e4282bdabmr12959241a91.15.1776072198672; 
 Mon, 13 Apr 2026 02:23:18 -0700 (PDT)
Received: from kinako ([2400:2200:776:9b18:a191:7a74:9fd8:591b])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm1055930a91.1.2026.04.13.02.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:23:18 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v4 6/6] board: qemu: m68k: Create virtio mmio instances
Date: Mon, 13 Apr 2026 18:22:40 +0900
Message-ID: <20260413092240.3719260-7-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413092240.3719260-1-daniel@thingy.jp>
References: <20260413092240.3719260-1-daniel@thingy.jp>
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

