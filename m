Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906CA10FC454
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 22:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A56C8414B;
	Thu,  9 Apr 2026 00:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="XGU6WXUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7D083DC9; Thu,  9 Apr 2026 00:09:58 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D162C84142
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 00:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82a7539851fso167136b3a.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775686194; x=1776290994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h50cw41BtUAEcCIxmSMdICAf/4B9jb1hBvtV0/DAO68=;
 b=XGU6WXUMTDyZA+LRQlpKDPyGed4cEdMBcDll8pt/lLZgHWa2Apj1vSrwlVzhUJSZ3y
 oeG8pHdTr/CELQI6DO8Q+ZUcYuowzN5qD2Ij3cbh084sYSHlRcbX6QSj5P0UgEbbK8Vr
 GAEme46uBeJgvUPL36a74w7a4qKnCBeIdmO2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686194; x=1776290994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h50cw41BtUAEcCIxmSMdICAf/4B9jb1hBvtV0/DAO68=;
 b=Wmox+PtpAS3YQkJR9adRUyujgr/bPGuwFy2AFLrT1rFOTLvmgHuf2u9AX41l+WNS32
 WD4dOi0191d1fd4xH4quqqBstvHP4+leQqmaF2ns7RYQ/mRXglKHkDrdFz6zFefKmxIT
 0OLUmUXTZSd3g0T3YzMCNOIFnTsEkvzGaW/be18YSdgjJyZ4czn3KodEDxy2kDg6VhCq
 L+yZv1WXjPqfBFPawhrptpMNyRtp4sX0Ipm1SrLdRkNrzhqMR2tUEq+8nE+RiDFJmZYA
 bbh2E9A5rP42RoOG4TCWXMVfHThUu0wxrZTvJ/j5uLa4HpLLMChby2fbg2Fza/+I/jFc
 mErQ==
X-Gm-Message-State: AOJu0YyyOoZhrRd0uI+N7HKqJIt9PHsBU1Lv6t0n57Wh1XEtuQthVqHJ
 97haKEUzmfdJDK73veezPAtuoLoudbHejPuSN3V7E8087kIluqbQNh2Pelyv9y4Jhvg=
X-Gm-Gg: AeBDievnBx8pYjiUPZR0xmR/SLs39iNF3uJ43VgOjqnRCCazx0GX9txoDgHQAYKSmZF
 Jsn0qTTb5uxiSWUEx8+4knrcDwPGgEp2Lx9mK6lNdtyx21a/fwgwiLpOKSwExvX530DTKf+QuU0
 56BUzFNz89GA6SDORmRWpCYU31hCEDc0MEZYXSuf5zwn+viOUNN9rWeqn5C/roXPSEdOvam7HMn
 mqGUlu/La7/Zu1Em9CW9Q9D8bKJ+2qJsvUnDp+kIyzuIRWSSksE1MJCIT473WZzvOGHQ4h1F4/W
 +C8GUvY1YCJ7yS7KFQjQ9mNWSMW7Yw6MiAwrR7RL8X9WFy/FJRYebXHJV4a6K01AlYmflPV2D4d
 5BP0lIGhPx12FbSTIocukHXemcJ86mffzYorlSScVOvYv5mjEpoWmj5Xgrp3HZdXHAKHnPDlL2I
 gW4J866wMoHxvi
X-Received: by 2002:a05:6a00:1ac9:b0:81e:b2ba:5b3a with SMTP id
 d2e1a72fcca58-82d0da464cemr20602395b3a.8.1775686194218; 
 Wed, 08 Apr 2026 15:09:54 -0700 (PDT)
Received: from kinako ([2400:2200:7f0:5ee8:dac6:2cde:760c:93f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm19877723b3a.25.2026.04.08.15.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 15:09:53 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v3 2/5] m68k: Fix writew(), writel(), readw(),
 readl() endianness for classic m68k
Date: Thu,  9 Apr 2026 07:09:25 +0900
Message-ID: <20260408220928.3328551-3-daniel@thingy.jp>
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

In Linux these are meant to read a little-endian value and swap
to the CPU endian.

In u-boot for m68k this is currently broken and prevents
virtio-mmio from functioning.

This change is only for classic m68k. Coldfire has read big-endian,
no swap for these in u-boot and Linux and existing drivers probably
depend on this.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 arch/m68k/include/asm/io.h | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
index 35ad4a1c0444..2577081d8363 100644
--- a/arch/m68k/include/asm/io.h
+++ b/arch/m68k/include/asm/io.h
@@ -23,18 +23,27 @@
 #define __raw_writew(w,addr) ((*(volatile u16 *) (addr)) = (w))
 #define __raw_writel(l,addr) ((*(volatile u32 *) (addr)) = (l))
 
-#define readb(addr)		in_8((volatile u8 *)(addr))
-#define writeb(b,addr)		out_8((volatile u8 *)(addr), (b))
-#if !defined(__BIG_ENDIAN)
-#define readw(addr)		(*(volatile u16 *) (addr))
-#define readl(addr)		(*(volatile u32 *) (addr))
-#define writew(b,addr)		((*(volatile u16 *) (addr)) = (b))
-#define writel(b,addr)		((*(volatile u32 *) (addr)) = (b))
+#define readb(addr)	in_8((volatile u8 *)(addr))
+#define writeb(b, addr)	out_8((volatile u8 *)(addr), (b))
+#ifdef CONFIG_M680x0
+/*
+ * For classic m68k these work the same way as Linux:
+ * Read a little endian value, swap to the CPU endian.
+ */
+#define readw(addr)	in_le16((volatile u16 *)(addr))
+#define readl(addr)	in_le32((volatile u32 *)(addr))
+#define writew(b, addr)	out_le16((volatile u16 *)(addr), (b))
+#define writel(b, addr)	out_le32((volatile u32 *)(addr), (b))
 #else
-#define readw(addr)		in_be16((volatile u16 *)(addr))
-#define readl(addr)		in_be32((volatile u32 *)(addr))
-#define writew(b,addr)		out_be16((volatile u16 *)(addr),(b))
-#define writel(b,addr)		out_be32((volatile u32 *)(addr),(b))
+/*
+ * For coldfire these read a big endian value and use it
+ * as-is. This means that for little endian devices on the
+ * bus like PCI device these won't work as expected currently.
+ */
+#define readw(addr)	in_be16((volatile u16 *)(addr))
+#define readl(addr)	in_be32((volatile u32 *)(addr))
+#define writew(b, addr)	out_be16((volatile u16 *)(addr), (b))
+#define writel(b, addr)	out_be32((volatile u32 *)(addr), (b))
 #endif
 
 /*
-- 
2.51.0

