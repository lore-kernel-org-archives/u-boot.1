Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46078FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:50:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A1248483A;
	Tue,  5 May 2026 09:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="Hiq/Fbv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FC784713; Tue,  5 May 2026 09:50:07 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F716846E7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-364ff382b0bso3637028a91.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967402; x=1778572202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjZ6QF1XjUpz2TxGoVaH1Y2gkesh2X3YQ5JHHtG5vl0=;
 b=Hiq/Fbv508TYJUjB1UCiX4YUxzqG8FQNTEmq1MIVCTS04kcuQXf32LTAbUu3w9y/Cb
 nX7RdYvl2pY3F+837PE9nEuVjecufpfD3seoXdPCKnUkL2c+kNgjFw2lgipLTLeHJifP
 DxCIQD+oh+bTQIED3wsJhs+93ju1z5zCpFCH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967402; x=1778572202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sjZ6QF1XjUpz2TxGoVaH1Y2gkesh2X3YQ5JHHtG5vl0=;
 b=sQc2B1S+shHyqvu1DLxZVuM4QlF/zSeanZYJseZvyYA/VS9R7Qjv3zEJjBM+Xen6SF
 9LYWVj5KImayDft6FM+tm8VXYqc4/56WI7LfumLHZJtvqvDO952QvkICfx4Z26n4zaoj
 MoBVYGg1BOaV9T23V93dn4zC3S2CN1517gsoG4DhHUUd6YYTkOgay03Ro2hxiolU+j7W
 7XoSEzWcbHu1X1lxobSSCVCtAyUy65H+PQ/rji6gkO03nzJICLLIWi6yqezJvQ3SjKGV
 guv/E9RL2+/EBj8JP6iQW/6nnhJodfVL2GCFIIn4I+kKwrsc9tgQ0/lbuHAPVdFfsNTG
 yVFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hcsdGXAwhaIAUNzPWR1Q3mh2/yYo7D30aOkMmzlRYVQYbxnCz2pG/BF2pfbQkK7wD63Xfnmg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi9+NgXshiNnJuNJwnIvx9+vVzTgnIKwLXhTw1wXnyBD30aMcm
 OI2/r4Y1IxsR7urV3l7VMiFu/W22C6W7hGIJ11eV459ji4mm2SlB4TgA1PWfrpbONkk=
X-Gm-Gg: AeBDies3fyICquJGttTx8SiLXQGS6ErOLn+en6jEf5e6SIWXbZ6aHJUTy16bTgtZ/9o
 xRT/sZY9BWnJOI8W+6MQpXvyvqhc3vuK44hJh0az/tC1Km6gu3nJ9BaC0rV9G/LUp8QVD/wHhVP
 pbLQP3oihr6kRsAQwpFPPZyQM14Y3xRpXszd0pE05sXROiCiBQ5tGn++ZLX3Wefcns9IUsyVSYj
 87HUXYzo3w8sdxsrtLU8Q3pE1saSTJts82S1wVMku2J/t4BJvDrph76gHavpbbBpuqevf9lVgk4
 xi12cWVptetOKKYnt7F0fzleydd5Gd9B/BdKUsWd0TSi8NC1IpFmAlXFLsuOxlYNF7Ln8c0+x8u
 ScfV8drpiHbNn0evd04iCmduZ82Zhko8yVbgUYUmemhAXn0fSKQSQsoskNLylY2Lc92LcJB5Z3y
 S2Sts9w+cpWkZPsr93C8Biw6HAHfzdBJXh0vGEmkLln9JFUSnlk0vWz0mS5AklTH6LFaoUifqB5
 JcPqlGwTRggC4jUFOMIVZnrcue3AsjyFRgh+A==
X-Received: by 2002:a17:90b:224f:b0:364:b4e7:6709 with SMTP id
 98e67ed59e1d1-3650cd83468mr12083732a91.6.1777967401764; 
 Tue, 05 May 2026 00:50:01 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:50:01 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 4/8] m68k: Fix writew(), writel(), readw(),
 readl() endianness for classic m68k
Date: Tue,  5 May 2026 16:49:37 +0900
Message-ID: <20260505074948.2603870-5-daniel@thingy.jp>
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

