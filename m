Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DFAC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 09:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0317082A8D;
	Tue, 20 May 2025 11:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gqYq9TtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1DAD82B18; Tue, 20 May 2025 11:09:43 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E0F829F5
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 11:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6020053cbd5so1681439a12.3
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747732181; x=1748336981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dEdM7mHVCBJct/b5Rd7DhUxXG2+9TuMXTHJtjcZhkGg=;
 b=gqYq9TtCgKwGDiVaD1F1zmPcG/fkQVjpslJrzeVLFzHc3edJ+dd2OnavTfmqv5a1fU
 Nj39aOsEm65vjV/IYxyRkQUD8i3Zzvg5swYN7pyuSvCf9wepAgzQrDV8w+PmQ2MFywaG
 5Tw1s4T9UTBY4WULpCVrD9RwXhm4xPIHK8mpDRFK6SVzD77BOVpagCcAI0mAsHoeybZu
 f4ROkxFy9RsW3F2CxKW2uyXnrdpVCCL9/7yyjY6nt8Icr4kEg0RHZbFybS0MCuoo8dvy
 KFgV2B/j4uejwHE7i0BoBkVbG5PugaQrZmqtXxJypMA3j5qzUiPTsmAceuexMQ9mUUp/
 eaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747732181; x=1748336981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEdM7mHVCBJct/b5Rd7DhUxXG2+9TuMXTHJtjcZhkGg=;
 b=CbBdPlBpbzIh/9ulskrOA+K0FHRKAFeZ38/7+5r4Vu583Ri1hJIeisk/4Aa/7VfcTO
 vW1SG8GCo27/yOCwYF/n6iyhRPjenU0ZWiG60rY7gjh8oM7Lw7FDFjyH0Jbpbot38uuY
 2stexs1py59mwgGuexFcFcsjngqCMk60MXX0yhob5xa/w0q1dBh6CVAi1WJlPd9QijuF
 FHRLeyU6yt8ibcEngJ6EpPrPWAP09srEvwnMExsLwjWxZgAN6u+ghTwYNYrz3LXzlL95
 irp/GTEFeWy8y6/fnDhNHmBVnJn82VuvNJ+VRZ4mCqYLSTTAVig0F/V5vepd+pvqxq/u
 sqaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPkrfeE2xmXZoX6thqGTUG+QDJk2RqSI/kuqvDJyGKmnNDGOjEliv8Atp+wD4g9+SzCQm+h78=@lists.denx.de
X-Gm-Message-State: AOJu0YySCJCEuGAblNY26AV2LQKd5VXZ5SX14NkF8wMEIPN6W+vC/5e8
 UEpq42S2AssYHZQ3RHpuAXYMOY7RAE2FNyJV5jUM9yiA6Rx46f/EISSH
X-Gm-Gg: ASbGncsH0GcSLX8p3aYc2XLDKgufVYjisKjERh8QPhGytClItxm0gBoGPxfBsZttzdv
 wMecKsaO+oqn4RXC+SdfEs40f5alKQN8xCzjZibd0uwt86YpIy7Yl9HOuAkJacucWFXdB18TI23
 KA+vEUVdbV61wbgnBLVqDrwyBs+agO5R249oEDQH1rzeoknFbxjHH9cbnYNj/eLz+RH+M3VEOj/
 fCpLY+x5Pj6gNQWM4KBgtvdzMCitoCTIlqEg8SpUJcVBwETNSqs+ZAhud5GOPLSTEWuKhOcs3tI
 5jxem+CBt0PczWLHMi95QYPSkT3EcjV06umIfI8WibZ4Ga9DNWk7igM86f4XuXGE3WQIPtGpgwk
 KC6IB9O1x0J4gyOdoi0MQbxioTS/U3dnnD3bame/wOdyNRH/UDCQjT5Z2rGhMNsIcN+w=
X-Google-Smtp-Source: AGHT+IFr2qfI4wZ1IK/QR3OhmH3xbno5nRTtiTHGnLIucP1OFqEOExm46RdS4j6p8hxyCYQaxhnC0w==
X-Received: by 2002:a17:907:2d2a:b0:ad5:1e70:7145 with SMTP id
 a640c23a62f3a-ad52d4e746dmr1516197266b.22.1747732180647; 
 Tue, 20 May 2025 02:09:40 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04af40sm703515366b.34.2025.05.20.02.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 02:09:39 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH v1] linux/sizes.h: sync from kernel
Date: Tue, 20 May 2025 11:09:17 +0200
Message-ID: <20250520090924.2638187-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The kernel added new size definitions and substituted the
boilerplate/reference to the license with a SPDX identifier.

Drop a local SZ_8G definition in MediaTek MT7988 SoC board file.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm/mach-mediatek/mt7988/init.c |  3 +--
 include/linux/sizes.h                | 28 ++++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 2efc8c6a88fe..8bdd3848d261 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -6,14 +6,13 @@
 
 #include <fdtdec.h>
 #include <init.h>
+#include <linux/sizes.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define SZ_8G				_AC(0x200000000, ULL)
-
 int dram_init(void)
 {
 	int ret;
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index fbde0bc7e882..49039494076f 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * include/linux/sizes.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef __LINUX_SIZES_H__
 #define __LINUX_SIZES_H__
@@ -26,17 +23,25 @@
 #define SZ_4K				0x00001000
 #define SZ_8K				0x00002000
 #define SZ_16K				0x00004000
+#define SZ_24K				0x00006000
 #define SZ_32K				0x00008000
 #define SZ_64K				0x00010000
 #define SZ_128K				0x00020000
+#define SZ_192K				0x00030000
 #define SZ_256K				0x00040000
+#define SZ_384K				0x00060000
 #define SZ_512K				0x00080000
 
 #define SZ_1M				0x00100000
 #define SZ_2M				0x00200000
+#define SZ_3M				0x00300000
 #define SZ_4M				0x00400000
+#define SZ_6M				0x00600000
 #define SZ_8M				0x00800000
+#define SZ_12M				0x00c00000
 #define SZ_16M				0x01000000
+#define SZ_18M				0x01200000
+#define SZ_24M				0x01800000
 #define SZ_32M				0x02000000
 #define SZ_64M				0x04000000
 #define SZ_128M				0x08000000
@@ -47,5 +52,20 @@
 #define SZ_2G				0x80000000
 
 #define SZ_4G				_AC(0x100000000, ULL)
+#define SZ_8G				_AC(0x200000000, ULL)
+#define SZ_16G				_AC(0x400000000, ULL)
+#define SZ_32G				_AC(0x800000000, ULL)
+#define SZ_64G				_AC(0x1000000000, ULL)
+#define SZ_128G				_AC(0x2000000000, ULL)
+#define SZ_256G				_AC(0x4000000000, ULL)
+#define SZ_512G				_AC(0x8000000000, ULL)
+
+#define SZ_1T				_AC(0x10000000000, ULL)
+#define SZ_2T				_AC(0x20000000000, ULL)
+#define SZ_4T				_AC(0x40000000000, ULL)
+#define SZ_8T				_AC(0x80000000000, ULL)
+#define SZ_16T				_AC(0x100000000000, ULL)
+#define SZ_32T				_AC(0x200000000000, ULL)
+#define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.43.0

