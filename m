Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92553C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA48C84AC8;
	Mon, 13 Jul 2026 12:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="FQqVK93H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F93C84AC5; Mon, 13 Jul 2026 12:03:08 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7D984AC8
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so2520077f8f.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783936985; x=1784541785; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ceJTMusb1bPYulH+EiBLWCrWhernU9LuI4+y/bPyccc=;
 b=FQqVK93HASWM5rUrUuqUpekMYSqfGsqTWWCw3uv6WKAp6FF5fQ+yndD6MZv47avB8r
 iytSmnAJMk1vGkpTuOS+ofh9pjdY/nQ4Gt/K00MLp15L4ewr+6LfIdCO35q+wAoPPVvC
 PmarmPIZr0mHIuu/jBa045RbDclNGOqZjkkbQe73Fqpuy3dZtoHsrflm85MhEqVs3ZhZ
 mW6NA07TaiDTe2MqcR4yCCW59RyPOs7mZ3ooZymLgV+NYIqn3wdJA14D+k+CRYldBJQK
 pW2Xnp7oneisMjPRHMTCwB/+BQ42jyxna3nnXHsQFcw/cstpA6JTdO30HHpUdoacDO5S
 kTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936985; x=1784541785;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ceJTMusb1bPYulH+EiBLWCrWhernU9LuI4+y/bPyccc=;
 b=XV0XOdQsT6ptegTUFl+6rdoEKsA+q64DdcPd8aaFJviIJTFsVAs6W9oDhgfHBXCfs/
 Xk1kCHoLhKandM7lobMs9KQ9VjkyppE/v/l2mq/JrOAXYgOJ0xWGZLj4rmzwFPJWToXl
 nTsN2s+2swyC2rllcxbZm5EiPuUs4zdVpICQlZfhDZhKiojaPUBz4q1LDuvBxYLbEIO/
 3lBzT8Udylr32MdClPNTGYR27e5i9eT4dORnF5Wz/C5jQZPc9oREj8rDYpzIa+zlape6
 YrdCrhJGe0VsTlWgjVdemLlFOriEpxg07g56OsOWBqtw59LpjhpPSTQCi7OQsM4e0RrK
 81Qw==
X-Gm-Message-State: AOJu0YxbB1hb1QFRnqE4D8n/99npBsGEQ4Tqd9dXPjOJyfMqRMAHNjzw
 CA3smpQeonB9PqgEGjZrEsH+eOwgkhORpdWzmgjcTZMgJU30f8peLWcBqxpmxa/4XJs=
X-Gm-Gg: AfdE7ckP7ZfodwLGTas/JJiOt7zT4uxHP9A2PhNCqQQ1+w6P68QEuKYmKd58DelatOg
 cNuN0jQfuJrT9lHAZwET/zJnx1Zil2dfM55E0SBTF+Fi9Y8Y48UKAxIlPRCh5hC/e8PiOty6ahH
 ZxEEPie068icnBxsBg1HObp6u6a8uTZvWQibosKNxuYdyURaPnVNsPagOwLvNpijA76lIC51+CI
 +/BNcqghPGubyc1bLryvOa6tVlSRx+5Z08P6L5sRfO97x8mxYIe27ARQWyGNW53aKUT6S8LBp3m
 g397n4Xjq5r9K6sy0tA5pT3Z+raW5x4J2U1ww2cZ/im2nCCfMefDxUAp3lA8PG0kU1Y5W6XeOM8
 hMV6RtFwF4yF3EqffDlthOHHh5zM+9kaWDIutYN/bjbDLEh2X28Sck6yuCUmrIn6X5M/J4PtNUl
 pv61hRATyD4Zo0x7CtmzkJG+HKzXAEWAOq5xiB8o7OXvOk5P91ZtARRZyWMZOhvUcu
X-Received: by 2002:a05:6000:2dc9:b0:475:f100:35fe with SMTP id
 ffacd0b85a97d-47f2dd475e0mr8752901f8f.59.1783936984707; 
 Mon, 13 Jul 2026 03:03:04 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f25b23b7esm29135772f8f.18.2026.07.13.03.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:03:04 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 14:02:48 +0400
Subject: [PATCH 7/7] rockchip: mkimage: Add rk3576 align and sd-card workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3576-boost-v1-7-9d23aa08f674@flipper.net>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4352; i=alchark@flipper.net;
 h=from:subject:message-id; bh=eY8ESC1QdW9pThKLCsfb+ur6fauVkWJ3VlWjdHt4SJE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFbD9+40riG2e96i1SXTNdo5YHSzQeP7ZVWXt3gHrG6
 jOFn58t6JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqvVczMswuy5y+r/fk335GvR3rXhu/0N2WFbEwr5t1+6SXlvmmkx8w/M8829F
 2tCfy6I2qqkMGKyK1jQ62vtm9RdW8+322/PQ0Pk4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Jonas Karlman <jonas@kwiboo.se>

The BootROM on RK3576 has an issue loading boot images from an SD-card.
This issue can be worked around by injecting an initial boot image
before TPL that:

  writel(0x3ffff800, 0x3ff803b0)

Prepend an image containing binary code that does this and return to
BootROM to load next image, TPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
[switch from pre-built binary to from-source build via existing Makefiles,
add commentary on what the magic write does based on JTAG debugging of
the boot process]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/mach-rockchip/rk3576/Makefile       | 10 +++++++++
 arch/arm/mach-rockchip/rk3576/rk3576-boost.c | 31 ++++++++++++++++++++++++++++
 tools/rkcommon.c                             | 22 +++++++++++++++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3576/Makefile b/arch/arm/mach-rockchip/rk3576/Makefile
index cbc58257deba..464def20c17f 100644
--- a/arch/arm/mach-rockchip/rk3576/Makefile
+++ b/arch/arm/mach-rockchip/rk3576/Makefile
@@ -7,3 +7,13 @@
 obj-y += rk3576.o
 obj-y += clk_rk3576.o
 obj-y += syscon_rk3576.o
+
+# BootROM "boost" stub: a freestanding bit of AArch64 code that pokes a fix-up
+# value into SRAM so the ROM can boot from SD/eMMC. mkimage prepends it to the
+# init image, so it must exist in the build dir.
+quiet_cmd_rk3576boost = BOOST   $@
+      cmd_rk3576boost = $(CC) -nostdlib -ffreestanding -Os -c -o $@.o $< && \
+			$(OBJCOPY) -O binary -j .text $@.o $@
+$(obj)/rk3576-boost.bin: $(src)/rk3576-boost.c FORCE
+	$(call if_changed,rk3576boost)
+always-y += rk3576-boost.bin
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576-boost.c b/arch/arm/mach-rockchip/rk3576/rk3576-boost.c
new file mode 100644
index 000000000000..abccf4cb1b9e
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/rk3576-boost.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+/*
+ * Early initialization code to be executed before RAM training on RK3576.
+ * At the moment this only contains a BootROM fixup for booting from an SD card
+ *
+ * Anything in this file is to be compiled into a freestanding raw executable
+ * binary and prepended to the RKNS image by mkimage during build
+ */
+
+#include <stdint.h>
+
+#define SYS_SRAM_BASE	0x3ff80000
+#define OFFSET		0x03b0
+
+int _start(void)
+{
+	uint32_t *sram = (void *)(SYS_SRAM_BASE + OFFSET);
+
+	/*
+	 * Relocate the SDMMC IDMAC DMA descriptor buffer to the (unused) top
+	 * of SRAM instead of the boot ROM default at 0x3ff80160, which sits
+	 * inside the ROM's global state area. This prevents large multi-page
+	 * SDMMC reads from overrunning adjacent ROM state and breaking the
+	 * boot process
+	 */
+	*(sram) = 0x3ffff800;
+
+	return 0;
+}
diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index 81361cde4823..b4654beb659d 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -158,7 +158,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk3506", "RK35", 0xC000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
-	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },
+	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2, 8 },
 	{ "rk3588", "RK35", 0x100000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
@@ -288,6 +288,26 @@ int rkcommon_check_params(struct image_tool_params *params)
 		return EXIT_FAILURE;
 	}
 
+	if (!strcmp(params->imagename, "rk3576")) {
+		char *boost = "arch/arm/mach-rockchip/rk3576/rk3576-boost.bin";
+
+		size = rkcommon_get_aligned_filesize(params, boost);
+		if (size < 0) {
+			fprintf(stderr,
+				"Error: rk3576-boost.bin is required but missing\n");
+			return EXIT_FAILURE;
+		}
+
+		for (i = ARRAY_SIZE(spl_params.images) - 1; i > 0; i--)
+			spl_params.images[i] = spl_params.images[i - 1];
+
+		spl_params.images[0].file = boost;
+		spl_params.images[0].size = size;
+
+		spl_params.images[0].address = 0x3ffc0000;
+		spl_params.images[1].address = 0x3ff81000;
+	}
+
 	return EXIT_SUCCESS;
 
 err_spl_info:

-- 
2.53.0

