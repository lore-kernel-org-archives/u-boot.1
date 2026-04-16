Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD246F8A14D
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0183884105;
	Thu, 16 Apr 2026 11:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="dUg+wul4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736F484285; Thu, 16 Apr 2026 11:40:10 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C0FE84214
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c796163fac5so810345a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332406; x=1776937206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goaQ4vSx4LpV53K9vUM2VBZDCzM4dwgQch9SJiUEP2c=;
 b=dUg+wul4+iP0hIpObYK8uIdnRwZfqBP+hsTZ5gwVaZ7ceJ0l2Wq+yAouAmue93qkT5
 ecGSQeiyXaUkJXO3U2kDoHT6jbMn0u5P6ByNoGNnrjRKkJYrVIjUYsWUcxUQeQyx/Pdi
 eo90ZBcWcAOhXAFjl8OV5aLIZKQZkQ3F3WIfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332406; x=1776937206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=goaQ4vSx4LpV53K9vUM2VBZDCzM4dwgQch9SJiUEP2c=;
 b=TmudyYjDNf3H+kz31qbR5RNHSmydkiQPcL//9r/eAzun019ZaDmhTe1Wg2loOICTHk
 lGAmWpgotsdq8AhQyTxpuxoVQ+Sl5JAMR9EnnDJw58DE2Kw+VFED6ervy2DWc7tF0whn
 mDMgT3L+B4fsAgafKguJp9/wOj9oYQvysuKH4v2hUmUzWnz/a+oDuy87iQxxkbLPv0fZ
 mvigVuITE44EYBHEuQ2tsQR4ZwjhWNzUUrqgZnOKfKvaYHyPZSeLoHTXWTrpTKJNbvsS
 dEp3CsiQRBkD9gmX80VDbaZ+Tw4WNGHxz5GwqcFdMIRX9Gj00hb7q9uJUjUs9NdjDtYc
 vYkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Q1R+2D59TJNUuRnUk1x/P6s/veu8JTxzVWxLq0MvpS/a2yXYHqQyyG18btRwfVtR0mEwUWeA=@lists.denx.de
X-Gm-Message-State: AOJu0YzdIyksUJXnQN7S6ghOCJPd+DyKNhRKYkQwB5dgIE/k+vEqEqDs
 ZBQEQkM7fQJUlV0lufMiY/3JsgqHvAdeDQYP8b4tWc8yVa9CePH1gRCeMkmxIlkzsho=
X-Gm-Gg: AeBDietz+VPqo11uLf0XySws2445c6+v7j6RGHKxBIuCa8D6a9WepbfcfcVqXHGlMbm
 02UWqxyPJsKkduzj/wOhlAxdB/uP+Bq/S+upW3BX/a3GCnNvf7Kel4zomWZEqdGBgVDIwHn2tON
 CaGENvs2YVhMErX1zxbepSe7kF3vh9p/g11972/ZgGqu0Xf6xsSj9CenLPr6cqi5mjYFul4dsPu
 sG8630SIxESH5UqF5b8NQYoXQVDmcwPmBO2ysi43hv9FGVBS9SPunpOWkg1NWW1TOrnX7luJK+r
 /obmF/xEmekyaqi85LtEyl1998+MQym74xTUpSfJxADMThmgaiIv5CM2uwEqfXs5I3FqEYTyk8d
 bNcsp5p6gmgc+q492IFlYGyDtbAVvo0BPZpQArVQZSBdlMalnoTqk5bQ2gM3ngxBF4W7zuXTpay
 7QpQQWy4y7jh3KcQqqPjy272EAV0VZHZDE9x7bYrNkgxw+8GFxymTXHjYfbAxCnE9IuTGAqKHmb
 aJYyk753OWf6A==
X-Received: by 2002:a05:6300:7102:b0:39f:a42:9247 with SMTP id
 adf61e73a8af0-39fe3f5bf14mr20519408637.37.1776332406406; 
 Thu, 16 Apr 2026 02:40:06 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:06 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 4/8] m68k: Fix writew(), writel(), readw(),
 readl() endianness for classic m68k
Date: Thu, 16 Apr 2026 18:39:23 +0900
Message-ID: <20260416093927.602613-5-daniel@thingy.jp>
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

In Linux these are meant to read a little-endian value and swap
to the CPU endian.

In u-boot for m68k this is currently broken and prevents
virtio-mmio from functioning.

This change is only for classic m68k. Coldfire has read big-endian,
no swap for these in u-boot and Linux and existing drivers probably
depend on this.

Tested-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Angelo Dureghello <angelo@kernel-space.org>
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

