Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EFACD4F25
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D83E084694;
	Sat, 16 May 2026 09:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="Wkix13CA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074828407D; Sat, 16 May 2026 09:40:49 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A558407D
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36936dcf19dso242228a91.0
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917245; x=1779522045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjZ6QF1XjUpz2TxGoVaH1Y2gkesh2X3YQ5JHHtG5vl0=;
 b=Wkix13CA1+Y3A5tvi39nWQV/eT3rV5KYrNVOl0/38XO2Udpd32P8XzybIZO7X/8rjk
 bdgqG7R7nIt3eG1mJ+e+Y+RFEJEgMrVFutZ/2xSr50sJ2T2+HNYw31qBYu1ptRAp4FTS
 vWmeYpIgg2rwLrwG4WIsd00zzMEUeCIaQRr9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917245; x=1779522045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sjZ6QF1XjUpz2TxGoVaH1Y2gkesh2X3YQ5JHHtG5vl0=;
 b=eMOO2mFB1mQ1Bk2q3s+DA89XjVwLAWqejC2ta7nXhU3G0AOJR3nborUr3LTbe3Ov5S
 Ri30kH6v1wzY5Jr+ZUlVmab1VEiscpdJ2D2Vav8j6imTURdGmCEW3gg0+TPXRCFkCKlq
 WT+Vy/cw1+bvlgYgi/y/6RKvMHlC4pD6Mb7XnT9jMo3rREAx6LkzP5v3QKu1MoJLNvRu
 9rG2uW76OQuI07IvyRq0lTfuUjt134/Ei3HyePwwOL3Ckk6rpBNK3/RxA+cEeFiuuC0s
 YneC2huoBOh89bbeQ4CUcAt/kxJkSzlsWVLB9Y+SpusEqLn0xaZ6iloQC8z7aHKfYar6
 BD5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8DInFq+7h12TdyeAT0kkvNIGB9I65MKrBPWeh724HKS9gQKuo5dy89eFcRq8lVZun96xC1N8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3ky7aek8mdHV5dLjHoOyB13yGX9tpiLY780gnsbnHQJzgI5kl
 mV6iKH8Xem2cG+CYFh/uE58hyYXWtY3E2knYpwStKWusjmDinnnUaf4pVAL8VgYh0JQ=
X-Gm-Gg: Acq92OGHrscBBOpCM0H/07g8+blJIgqi6GiSiIh+TXrOHhgC7YUo5wM8gtM+T9Q7EIS
 +f+x4Qu8nbMiBk7uD0s/qBR5svG9P7OQ4QBZZX3qMrvkvtXVJpUGunSb02xcKovMA+rbIRqKXDm
 SxFEJDfE5UNG52/yKLJ1sTQ4IwPCSZc792nASm+K657FBEcgf8C9LvvoDcxbqSfDDoBj6ImBDY/
 mgzinfSUkmyBwnMn4zq14YRfxONTvvXKd6YO0giQN/BDbPpYXOrK+iPDmZhXwgQIkNQaiZ8HOf8
 0/WF6x6vtp1IA1t9c7IVr43KWyvhTe70e7Tu+90wK7XOwTPh7U0BiH6Wca5HrM4Idc4xYbkiUn6
 P4sqcHn6jly+sMYHrUveQEqgW960baFOOEOyDAynCM6F5FTH2dboosXf+jGa23sLUscWqt6LA30
 DXNm7o03IW8Rw4SIbSKZ5FFZh3b2Nd/qXwvh8VcJVgs/Kf+hSrpfdps2ZFZd8f4hOUlvNNP2mFA
 YEBc5be8fSi33a4o7C3s+5Z
X-Received: by 2002:a17:90b:1d83:b0:367:bb54:8768 with SMTP id
 98e67ed59e1d1-369518970f7mr6953720a91.4.1778917245193; 
 Sat, 16 May 2026 00:40:45 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:44 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 5/9] m68k: Fix writew(), writel(), readw(),
 readl() endianness for classic m68k
Date: Sat, 16 May 2026 16:39:57 +0900
Message-ID: <20260516074016.885146-6-daniel@thingy.jp>
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
2.53.0

