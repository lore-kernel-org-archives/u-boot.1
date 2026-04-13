Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF8EBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10A42841B9;
	Mon, 13 Apr 2026 11:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="hCzldwn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82098841B9; Mon, 13 Apr 2026 11:23:07 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BEC8419C
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d95017a68so2605063a91.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776072183; x=1776676983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=me1vVhPqr1kjIlS8wW0B4mXkU2u+5wAIRtgWgiIVfTo=;
 b=hCzldwn8pyt6piEgkrfl11aEQZeaYPJczMTufYRbiot2E/fJQOneFbhjKSI3sIry9Y
 sDnhikW49IerZ1zeja2VYgjCa7EoKHAQJIAOwqvob8PVKn/o2JqtqANdnEZJi3Snoxxi
 UM4ayMquXrv5l5uYots8IZ1Ws/3B3TAsvQo4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072183; x=1776676983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=me1vVhPqr1kjIlS8wW0B4mXkU2u+5wAIRtgWgiIVfTo=;
 b=hggVwhf0hmmDaqSo0BVItWcpZ+a45VK0lY5QbNWi1E0ZNUflxTKk6XKT8qLdavFx0e
 hDO9QmDRZwcN1QElr4af3tm/PBjKXs/GzW9wI9foyPt1TtufOlG+52TVGGkNT1q8RFki
 BRHbX55EC9dK044mHigtueuNbfG6JfUys1wHJ1kOSe0AK7T5oCBdP17cbDd6doecfOzM
 lc7oJ6fN1WhZnCbUpbxUewWuJf49m6+e0pEvfF17SzYBKD1Z0QixVw7pPWPJd6WKaM/P
 ajRZzB3h3SmsUFZb7v74njEhTZugdqVS/eYkJebpz8OuZ1u9XhkFUhoVzTkFnUFN5NaU
 rFxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tcMkMhbaSilRYfFHGZ+aqx6RGhsij1YjDqfKz4YmYcGoGKIMbiwelnMcMi9bCfYhHivdMchA=@lists.denx.de
X-Gm-Message-State: AOJu0YxRqD2pznlrvp4DAyqqenbSejV7EJ2uCpl2/oD0g/f/vs5gytXe
 ahx6zzdjVf6bkayqJQdCoXVNNfwH+Y4OMyiDV8sC7XbrhW0IOCIzXUSldZVDon3S7VY=
X-Gm-Gg: AeBDietfHf3vKO1XwMkklAVW9WOpsdfHi+YRUuNeeoVT5mqE5W7gzYMNVNT/fD2tExe
 2WoVcWEuL//p2BpZOZlaoWsJatf3GxsmalrN/EqAwckWSXXLTIsInupC47RY8e5/MmouxYN1mZs
 ApzQ+Hn1X8DZ78L48J3v8Pw52mSPFDMwFCd8ZRWXtz8CNAgTZBWucKcb1oKwxoZcS6yJDcbssva
 a8alKelv6WAEcKae+BBUNFLv1f/hM4/vUMZMgYO1W3bm5xY1Z/1eST3JugO7LDpGp8L8vkZlv73
 4HwFAYu6z1rrt8LTpaK24bct1m8bByLhDuQzXFeDXf7hN66JVl/PVFaoslq/rO9y/JnAKIM9Eos
 kzfB8TmDlQV0QfdeA/xj8tQrvtg9S/pE9BOTe7cv12UqPb/h6WaUQG5lhjlsb/hN3Mh0ZOR0NAI
 uQhPJp1mhDspRQ1ZOfPiT+huBe
X-Received: by 2002:a17:90a:dfc7:b0:35b:e52a:6fe5 with SMTP id
 98e67ed59e1d1-35e4274e358mr11940905a91.5.1776072183570; 
 Mon, 13 Apr 2026 02:23:03 -0700 (PDT)
Received: from kinako ([2400:2200:776:9b18:a191:7a74:9fd8:591b])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm1055930a91.1.2026.04.13.02.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:23:03 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v4 2/6] m68k: Fix writew(), writel(), readw(),
 readl() endianness for classic m68k
Date: Mon, 13 Apr 2026 18:22:36 +0900
Message-ID: <20260413092240.3719260-3-daniel@thingy.jp>
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

In Linux these are meant to read a little-endian value and swap
to the CPU endian.

In u-boot for m68k this is currently broken and prevents
virtio-mmio from functioning.

This change is only for classic m68k. Coldfire has read big-endian,
no swap for these in u-boot and Linux and existing drivers probably
depend on this.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
Tested-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

