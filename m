Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AFCC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 20:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF6188041;
	Tue, 26 Mar 2024 21:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CDrxctCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F1D88039; Tue, 26 Mar 2024 21:49:55 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA3C8801E
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5a4a2d99598so2759594eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711486191; x=1712090991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Tc4yWUReOiO+2MyYzauXj30qLUPasJ6g7iuz4/r3Tk=;
 b=CDrxctCcdcqvi7HmlwVkijSos5C0gvDcXVZY+kJHCsJc39eW68pufWsM+xewhZUYay
 Uq54YnJTbfVJEuY+80XcLQU1mzrT3vBdKIHczeJH7ACOoN7cdFr5myyiaB6bbfnoGS/j
 cCXmZ8Ruwzjx/RDuzkDuUP+eAbjZxXJk9HfbjQRoVnwzCzosM4vu2/5qD66jmuyYmDtf
 Z4pHgEzi76yCuQNQffziYquCgdKku3tR6UQ6zt+QVj67EOXJAyj2HFVFfkXrvn9Uj4x2
 xVrl3h+nZdIjqzxpkKD6jNDTFmrssA9sw9yiNnlPCpBeih6llYki6bMs9M+RHFc/tHIz
 kcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711486191; x=1712090991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Tc4yWUReOiO+2MyYzauXj30qLUPasJ6g7iuz4/r3Tk=;
 b=YpcbP/Y2n2A3rJW2fDPBdPsMnoKR/byWS9HA/msfQ3FV88Ljpus5Axk0xqR04rSt4l
 9HMSaqnbHazAT+9TZt68C6YvIhIZMGwmP5TYiKeStV8+PxHhIkn0htmRTp5rhOblrvEt
 PG9ilZuOlaf6Lof5XgHjQojd4jUcSWEeHlIgxR0JO7y2FZhjafYF9Qe23CaoMY78reIL
 z/LBFsN6dSeTuz3LVJ1bjUMMKwpbLVhjBhTEgX7X+CfPqAP2qi1GxA0zsuF0X4VTBheC
 1Paxid6ZKaWgHk4WRj0djMHh4W5gXRdvxmes9KziPlA1UbUfYDXzi+HE/gmwNwhaxKhD
 tzIA==
X-Gm-Message-State: AOJu0YzldwsrJek2lCD9ITNx7TK7i4DwF0N5V1lSCc1vhlilZCpuXtJG
 j/kQ3ZKqJsv3bns6b/RFqEr4Zu/WzTA3+RcoQ7pE/42nBniRO0iIjyDyGTtS
X-Google-Smtp-Source: AGHT+IG6fD9G8QnBwIToKxqiLAhMh0UnrRlHVyuM3fLzemYEwnEW2uQ1IhZVLPn7WI/AgFbU9PDgCw==
X-Received: by 2002:a05:6820:2611:b0:5a5:25b9:dec4 with SMTP id
 cy17-20020a056820261100b005a525b9dec4mr1097124oob.3.1711486191452; 
 Tue, 26 Mar 2024 13:49:51 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bw20-20020a056820021400b005a5554a076esm1037399oob.10.2024.03.26.13.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:49:51 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, cym@rock-chips.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/2] rockchip: rk3588: Add Support for RAM Defines from ATAGs
Date: Tue, 26 Mar 2024 15:49:44 -0500
Message-Id: <20240326204944.1572667-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326204944.1572667-1-macroalpha82@gmail.com>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for defining the usable RAM from ATAGs provided by the
Rockchip binary TPL loader. This allows us to automatically account
for necessary memory holes on RK3588 devices with 16GB of RAM or
more, as well as ensure we can use the full amount of RAM available.

In the event we can't cleanly read the ATAG values from RAM or are
not running an RK3588 board, simply fall back to the old method of
detecting the RAM.

Tested on Indiedroid Nova with 4GB and 16GB of RAM.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/sdram.c | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 0d9a0aef6f..58b78466b0 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -10,6 +10,7 @@
 #include <ram.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/arch-rockchip/atags.h>
 #include <asm/arch-rockchip/sdram.h>
 #include <dm/uclass-internal.h>
 
@@ -35,12 +36,69 @@ struct tos_parameter_t {
 	s64 reserve[8];
 };
 
+/*
+ * Read the ATAGs to identify all the memory banks. If we can't do it
+ * cleanly return 1 to note an unsuccessful attempt, otherwise return
+ * 0 for a successful attempt.
+ */
+int rockchip_atag_ram_banks(void)
+{
+	struct tag *t;
+	int bank_cnt;
+	size_t tmp;
+
+	if (!CONFIG_IS_ENABLED(ARM64) && !CONFIG_IS_ENABLED(ROCKCHIP_RK3588))
+		return 1;
+
+	t = atags_get_tag(ATAG_DDR_MEM);
+	if (!t)
+		return 1;
+
+	bank_cnt = t->u.ddr_mem.count;
+
+	/*
+	 * Check to make sure the first bank ends at 0xf0000000, if it
+	 * does not fall back to the other methods of RAM bank
+	 * detection.
+	 */
+	if (t->u.ddr_mem.bank[t->u.ddr_mem.count] != 0xf0000000)
+		return 1;
+
+	/*
+	 * Iterate over the RAM banks. If the start address of bank 0
+	 * is less than or equal to 0x200000, set it to 0x200000 to
+	 * reserve room for A-TF. Make sure the size of bank 0 doesn't
+	 * bleed into the address space for hardware (starting at
+	 * 0xf0000000). Banks 1 and on can be defined as-is.
+	 */
+	for (int i = 0; i < (t->u.ddr_mem.count); i++) {
+		if (i == 0) {
+			if (t->u.ddr_mem.bank[i] <= 0x200000)
+				gd->bd->bi_dram[i].start = 0x200000;
+			else
+				gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
+			tmp = gd->bd->bi_dram[i].start + t->u.ddr_mem.bank[(bank_cnt + i)];
+			if (tmp > 0xf0000000)
+				gd->bd->bi_dram[i].size = 0xf0000000 - gd->bd->bi_dram[i].start;
+			else
+				gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];
+		} else {
+			gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
+			gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];
+		}
+	};
+
+	return 0;
+}
+
 int dram_init_banksize(void)
 {
 	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
 	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
 
 #ifdef CONFIG_ARM64
+	if (!rockchip_atag_ram_banks())
+		return 0;
 	/* Reserve 0x200000 for ATF bl31 */
 	gd->bd->bi_dram[0].start = 0x200000;
 	gd->bd->bi_dram[0].size = top - gd->bd->bi_dram[0].start;
-- 
2.34.1

