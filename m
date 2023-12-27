Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DE7C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 21:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08B1879C0;
	Wed, 27 Dec 2023 22:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6qCIucC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DF7879A3; Wed, 27 Dec 2023 22:29:12 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D88E487976
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cca5d81826so58332551fa.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703712550; x=1704317350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXheynh+rtq1ZuRV/ZfYoUKFTc6+qujZAUIJQaGSA74=;
 b=W6qCIucCyBT0vcYsWI5B+sgUJ1VTb7U6IHBql0OwMR0Ts7FQtU484CeXKT4SVmnasI
 UBWzRi52nfv7gNgmLZjdubRZBu7aE3J6DT97Qtg2n42FdCNG3HG8UBAmg3159+MWqlZN
 65a2W+r04OFxVDf8rWEuiyX4B3gPu/x6siJeR/63VKlZJs5gnHImVHkhjSDseHgbnaxv
 ajMSegVH/xgC7kuojHVe6sENIc8wX9rjNXBeKDxVfF/sSEEfhpuK6Ih1b0Y5s6U3FkrH
 OGc2VvSznJNEzQq8pRvBXrWAJHNlSz8hqxAfJJnPEeIEqlQw45XiO8GbsP1uMy930WXh
 Lwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703712550; x=1704317350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXheynh+rtq1ZuRV/ZfYoUKFTc6+qujZAUIJQaGSA74=;
 b=f4B6xbGf9IQu47h5aWSm7vCgx8yNfsFS5JhKAkPww9jmNMjfNhpaxmj9tUZcqJvNOk
 o0rkuw/UZTWkQzGq4GS18e/ZvdQMA/U8pUMqUQTKDCo40UAbzlASTBisGTL/GCdh9TSl
 Uq6EL+KT3Fp2hx5LL4a3+7Y/g0Bc2CgjIP7G16lTqnScXqaPDbGe42mHI2YUhPnrbojO
 VfykrSzs/7agTib/4VzudzU1N47qHHfUcG3NUMcFj/iRKPRMv/E+HRjEuBQgMi7Xa+6j
 e3mBpbTCJLiFuuMUoszv1pD4VTJJzSEgdvWqOyC30AwZbvWBI3SoHTgL4GG0uK/Drvqk
 ufbw==
X-Gm-Message-State: AOJu0YzYGThV1c9V72o1zG6H9ONYut8kU8J7vqoyZtIuqe1cy1tegL/X
 MhJnI7EREgNJxrqI7advaow=
X-Google-Smtp-Source: AGHT+IFASLYMz0pp2onjMfh9Pa26S7KPp4wBGUI0teWHQqaHivOSYuQlJ9jVcoGBIP/ckzHgq6KBhQ==
X-Received: by 2002:a2e:3514:0:b0:2cc:609d:eeaf with SMTP id
 z20-20020a2e3514000000b002cc609deeafmr4274283ljz.36.1703712549888; 
 Wed, 27 Dec 2023 13:29:09 -0800 (PST)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c01:1b6d:df4d:cbec:e4a2])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a2e90c8000000b002cc565cc5e3sm2559531ljg.68.2023.12.27.13.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 13:29:09 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v3 1/2] sunxi: reorganize mctl_mem_matches_* functions
Date: Thu, 28 Dec 2023 00:28:42 +0300
Message-ID: <20231227212843.397349-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231227212843.397349-1-andrej.skvortzov@gmail.com>
References: <20231227212843.397349-1-andrej.skvortzov@gmail.com>
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

mctl_mem_matches and mctl_mem_matches_base identical functions. To
avoid code duplication move them to dram_helpers and make
mctl_mem_matches use generic mctl_mem_matches_base.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 arch/arm/include/asm/arch-sunxi/dram.h |  1 +
 arch/arm/mach-sunxi/dram_helpers.c     | 20 ++++++++++++++------
 arch/arm/mach-sunxi/dram_sunxi_dw.c    | 13 -------------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/asm/arch-sunxi/dram.h
index 682daae6b1..9d21b49241 100644
--- a/arch/arm/include/asm/arch-sunxi/dram.h
+++ b/arch/arm/include/asm/arch-sunxi/dram.h
@@ -40,5 +40,6 @@
 unsigned long sunxi_dram_init(void);
 void mctl_await_completion(u32 *reg, u32 mask, u32 val);
 bool mctl_mem_matches(u32 offset);
+bool mctl_mem_matches_base(u32 offset, ulong base);
 
 #endif /* _SUNXI_DRAM_H */
diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
index cdf2750f1c..661186b648 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -25,19 +25,27 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
 }
 
 /*
- * Test if memory at offset offset matches memory at begin of DRAM
+ * Test if memory at offset matches memory at a certain base
  *
  * Note: dsb() is not available on ARMv5 in Thumb mode
  */
 #ifndef CONFIG_MACH_SUNIV
-bool mctl_mem_matches(u32 offset)
+bool mctl_mem_matches_base(u32 offset, ulong base)
 {
 	/* Try to write different values to RAM at two addresses */
-	writel(0, CFG_SYS_SDRAM_BASE);
-	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
+	writel(0, base);
+	writel(0xaa55aa55, base + offset);
 	dsb();
 	/* Check if the same value is actually observed when reading back */
-	return readl(CFG_SYS_SDRAM_BASE) ==
-	       readl((ulong)CFG_SYS_SDRAM_BASE + offset);
+	return readl(base) ==
+	       readl(base + offset);
+}
+
+/*
+ * Test if memory at offset matches memory at begin of DRAM
+ */
+bool mctl_mem_matches(u32 offset)
+{
+	return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
 }
 #endif
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index 9382d3d0be..2e8dd40b97 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -652,19 +652,6 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 	return 0;
 }
 
-/*
- * Test if memory at offset offset matches memory at a certain base
- */
-static bool mctl_mem_matches_base(u32 offset, ulong base)
-{
-	/* Try to write different values to RAM at two addresses */
-	writel(0, base);
-	writel(0xaa55aa55, base + offset);
-	dsb();
-	/* Check if the same value is actually observed when reading back */
-	return readl(base) ==
-	       readl(base + offset);
-}
 
 static void mctl_auto_detect_dram_size_rank(uint16_t socid, struct dram_para *para, ulong base, struct rank_para *rank)
 {
-- 
2.42.0

