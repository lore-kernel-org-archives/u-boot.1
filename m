Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8DCC10DCE
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 19:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E4DD87683;
	Wed,  6 Dec 2023 20:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RX9SdLor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937D7876E5; Wed,  6 Dec 2023 20:06:57 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C02A87683
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 20:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50bdec453c8so130214e87.3
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701889614; x=1702494414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xc1f66X9oEti4B7JfBPEHxGwLWVPZS3s7259aXcj8nA=;
 b=RX9SdLorRDH29FtVTHTLGdYp8bT4V6XV7VEZORZkg0ZMsBz3QiPZE4/8fN4OAtkY6d
 7356qzXL67Xrs9+2FYCpr4Kxhz+bEeKrAvyXjeT3QspzUozX5t9Ntats4NDsFVP1iVh9
 Tx0qXDIoDgpf7RRtRr31QSSu6yPSxKhNLHxwPC0x95apYUm/4/kI17J061OmJ7R15tsP
 fzN2xcAvi4eeE4hcNbF5nD5cDbPqrRFcIgnYyJ9lTcmqYCQ+xNmhOmAfuEMl7UQf2Rwl
 ZiwmyfulU5fn2YtZZc5TlT9oSv/rl29Cp0bWyFDYs/xI0w//77knUmZKKTh8x+m/o+cp
 2fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701889614; x=1702494414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xc1f66X9oEti4B7JfBPEHxGwLWVPZS3s7259aXcj8nA=;
 b=Ecu24QKoUynXP4mhNoqdyCr8E5IKZyKGzOJreGGh6tuK9AgWeXW5B4NEQ/xbZc4DAl
 4JzlRscIo58vXKOilbV3YnKt4cnto6E60r/n3uBeOgFxYof2xPb6mqdU0jduajDFenWH
 mjrNvq9HjemJg+ZmLzcYueqlmeRtGIjAFBHwFEUOc/3Wyqy8p6nIOOnVJILsBW3s0ZVt
 l+5P1A0OaC5LNR3WsWbvXF+t7HqA69FOsdPIYyFEExBWUFrznZe8BwxjuSyfvriwQHOA
 3WYlcqB2vdCpBpKwySPeudPfc1E5zaFTkpO0AatBp+LAoMIYMAIOSwq7UHgUwMB6Fr6w
 vllw==
X-Gm-Message-State: AOJu0YylU4im9X7QvC3Igdp14Dhu1fYdQXnDY3SbDZiq0/58GQa3LTAk
 MJPQh9RugvPKrzs2mMOzhpI=
X-Google-Smtp-Source: AGHT+IEfTvwd0qO5ZwnRlDAHMi3ztbTEU0nSCp9dPBVTwo/rkixH8n57A0Tvs3krqoHj/v08TL39kg==
X-Received: by 2002:a19:ad06:0:b0:50b:ec6b:77cc with SMTP id
 t6-20020a19ad06000000b0050bec6b77ccmr761137lfc.54.1701889614454; 
 Wed, 06 Dec 2023 11:06:54 -0800 (PST)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 q9-20020ac24a69000000b0050befd41477sm1230370lfp.273.2023.12.06.11.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 11:06:54 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 2/2] sunxi: reorganize mctl_mem_matches_* functions
Date: Wed,  6 Dec 2023 22:06:33 +0300
Message-ID: <20231206190633.131346-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206190633.131346-1-andrej.skvortzov@gmail.com>
References: <20231206190633.131346-1-andrej.skvortzov@gmail.com>
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
 arch/arm/mach-sunxi/dram_helpers.c     | 26 +++++++++++++++++---------
 arch/arm/mach-sunxi/dram_sunxi_dw.c    | 25 -------------------------
 3 files changed, 18 insertions(+), 34 deletions(-)

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
index 61a6da84e3..c86d20d22b 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -25,31 +25,39 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
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
 	u32 val_base;
 	u32 val_offset;
 	bool ret;
 
 	/* Save original values */
-	val_base = readl(CFG_SYS_SDRAM_BASE);
-	val_offset = readl((ulong)CFG_SYS_SDRAM_BASE + offset);
+	val_base = readl(base);
+	val_offset = readl((ulong)base + offset);
 
 	/* Try to write different values to RAM at two addresses */
-	writel(0, CFG_SYS_SDRAM_BASE);
-	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
+	writel(0, base);
+	writel(0xaa55aa55, base + offset);
 	dsb();
 	/* Check if the same value is actually observed when reading back */
-	ret = readl(CFG_SYS_SDRAM_BASE) == readl((ulong)CFG_SYS_SDRAM_BASE + offset);
+	ret = readl(base) == readl(base + offset);
 
 	/* Restore original values */
-	writel(val_base, CFG_SYS_SDRAM_BASE);
-	writel(val_offset, (ulong)CFG_SYS_SDRAM_BASE + offset);
+	writel(val_base, base);
+	writel(val_offset, (ulong)base + offset);
 	return ret;
 }
+
+/*
+ * Test if memory at offset matches memory at begin of DRAM
+ */
+bool mctl_mem_matches(u32 offset)
+{
+	return mctl_mem_matches_base(offset, CFG_SYS_SDRAM_BASE);
+}
 #endif
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index 905a43c918..2e8dd40b97 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -652,31 +652,6 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 	return 0;
 }
 
-/*
- * Test if memory at offset offset matches memory at a certain base
- */
-static bool mctl_mem_matches_base(u32 offset, ulong base)
-{
-	u32 val_base;
-	u32 val_offset;
-	bool ret;
-
-	/* Save original values */
-	val_base = readl(base);
-	val_offset = readl((ulong)base + offset);
-
-	/* Try to write different values to RAM at two addresses */
-	writel(0, base);
-	writel(0xaa55aa55, base + offset);
-	dsb();
-	/* Check if the same value is actually observed when reading back */
-	ret = readl(base) == readl(base + offset);
-
-	/* Restore original values */
-	writel(val_base, base);
-	writel(val_offset, (ulong)base + offset);
-	return ret;
-}
 
 static void mctl_auto_detect_dram_size_rank(uint16_t socid, struct dram_para *para, ulong base, struct rank_para *rank)
 {
-- 
2.42.0

