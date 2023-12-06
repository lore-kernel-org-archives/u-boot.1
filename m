Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E19C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 19:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729A787688;
	Wed,  6 Dec 2023 20:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hR29OYM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B90086E73; Wed,  6 Dec 2023 20:06:54 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B767587688
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 20:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50c02628291so164390e87.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 11:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701889611; x=1702494411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+GDuZtlLZvoJ8uiUWSFzKzvzkO0MKEMBpZp+wBD3us=;
 b=hR29OYM30N7bvmYg8fBeXsaYCGYONAT1WpuUA55JbSyrdhOwSGnglchMJbEQu1p0f0
 uem2qP+sihMeU0EQmxXTkBsGcCxCe4FE9RQJCxMYSRkGu21k8/XGx6hEdSsu5U9dETH8
 cht3hafgjEtfsvKD4Dqn0ddnYgZP6xHdCP3pNZE1bzP5JnKwIfJZSNk3bfdIv8O+emCL
 oZc/hxvI9NmnJKixeKEpX4td70D1ERNybaZ8GC/zU3NL0hpvEo2xpJSxsZr8RewsPeTN
 0a31b0WGDmllbYuyFDYPtXbY6cNYn7pZI/Hr3lTZTfk16fQfXvwKV4lmv5U4SyJy+B/e
 DHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701889611; x=1702494411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+GDuZtlLZvoJ8uiUWSFzKzvzkO0MKEMBpZp+wBD3us=;
 b=USdjhnuSLtZBZvru2Rjc3s359x5FmtzEIYJEiO7P/qeXX58riVcWvb3uu4mJCerX7l
 6Ogz2Oy62ZsuTuaXdlFOTO0ccMZP0gAZdIlwSZHpHpBZeza68JqBDZPcvN48csKbUXxl
 YJy+QbyVNdFt2DD9cqoQQs+fCfLJkN5jC3H6nGO6nkL1oE+FvJeWKtu6fNQ5hs9nasOC
 iAzac8pHg6ZktdqRJT8OAuqqsRbiZPhtE29wJ11YtwmL1cSs6nKXjVdGSGUdYsjherDN
 LN/OswQzVwAsal6MVfWsElixV+6erE24kSgAyF+7j6YzuX1JIY/lUSR0U2pd+0kI9W39
 vhTw==
X-Gm-Message-State: AOJu0YwZaq+Y3woLYHZmtYyPSWi4uDNc5Ot25cvtIiZ/wXX5LUVC9WeW
 1Ls1NDD91CvuJXq4MtArD2p3OzQmZek=
X-Google-Smtp-Source: AGHT+IFV3JKTn0HFj/E4BF+zM4XG+DwzDAbl22LykqaOeUUzVPULi04C/Pbq1MnfPgi9NIn+JJLi0Q==
X-Received: by 2002:a05:6512:3695:b0:50b:eedd:edc6 with SMTP id
 d21-20020a056512369500b0050beeddedc6mr738814lfs.42.1701889610728; 
 Wed, 06 Dec 2023 11:06:50 -0800 (PST)
Received: from localhost.localdomain
 ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 q9-20020ac24a69000000b0050befd41477sm1230370lfp.273.2023.12.06.11.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 11:06:50 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 1/2] sunxi: restore modified memory
Date: Wed,  6 Dec 2023 22:06:32 +0300
Message-ID: <20231206190633.131346-2-andrej.skvortzov@gmail.com>
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

On A64 with 2G of RAM words at following addresses were modified with
'aa55aa55' value:
 - 50000000
 - 60000000
 - 84000000
 - 88000000
 - 90000000
 - A0000000
 - A0000200

That made harder to pick memory range for persistent storage in RAM.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 arch/arm/mach-sunxi/dram_helpers.c  | 16 ++++++++++++++--
 arch/arm/mach-sunxi/dram_sunxi_dw.c | 16 ++++++++++++++--
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_helpers.c b/arch/arm/mach-sunxi/dram_helpers.c
index cdf2750f1c..61a6da84e3 100644
--- a/arch/arm/mach-sunxi/dram_helpers.c
+++ b/arch/arm/mach-sunxi/dram_helpers.c
@@ -32,12 +32,24 @@ void mctl_await_completion(u32 *reg, u32 mask, u32 val)
 #ifndef CONFIG_MACH_SUNIV
 bool mctl_mem_matches(u32 offset)
 {
+	u32 val_base;
+	u32 val_offset;
+	bool ret;
+
+	/* Save original values */
+	val_base = readl(CFG_SYS_SDRAM_BASE);
+	val_offset = readl((ulong)CFG_SYS_SDRAM_BASE + offset);
+
 	/* Try to write different values to RAM at two addresses */
 	writel(0, CFG_SYS_SDRAM_BASE);
 	writel(0xaa55aa55, (ulong)CFG_SYS_SDRAM_BASE + offset);
 	dsb();
 	/* Check if the same value is actually observed when reading back */
-	return readl(CFG_SYS_SDRAM_BASE) ==
-	       readl((ulong)CFG_SYS_SDRAM_BASE + offset);
+	ret = readl(CFG_SYS_SDRAM_BASE) == readl((ulong)CFG_SYS_SDRAM_BASE + offset);
+
+	/* Restore original values */
+	writel(val_base, CFG_SYS_SDRAM_BASE);
+	writel(val_offset, (ulong)CFG_SYS_SDRAM_BASE + offset);
+	return ret;
 }
 #endif
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index 9382d3d0be..905a43c918 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -657,13 +657,25 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
  */
 static bool mctl_mem_matches_base(u32 offset, ulong base)
 {
+	u32 val_base;
+	u32 val_offset;
+	bool ret;
+
+	/* Save original values */
+	val_base = readl(base);
+	val_offset = readl((ulong)base + offset);
+
 	/* Try to write different values to RAM at two addresses */
 	writel(0, base);
 	writel(0xaa55aa55, base + offset);
 	dsb();
 	/* Check if the same value is actually observed when reading back */
-	return readl(base) ==
-	       readl(base + offset);
+	ret = readl(base) == readl(base + offset);
+
+	/* Restore original values */
+	writel(val_base, base);
+	writel(val_offset, (ulong)base + offset);
+	return ret;
 }
 
 static void mctl_auto_detect_dram_size_rank(uint16_t socid, struct dram_para *para, ulong base, struct rank_para *rank)
-- 
2.42.0

