Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F73EF8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45898840A9;
	Tue, 21 Apr 2026 17:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZRP1E0r0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B4284359; Tue, 21 Apr 2026 17:16:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74F9840A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so34104945e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776784573; x=1777389373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9p2KzsZY9SIDA8sbG7RF3nRF06ShKZTDnqcgc/hbfAU=;
 b=ZRP1E0r0Ih8BkG0w1xmV1bXgISdhX45jT9GxkYv2MpyrNd2xIs+JxFuYs/wU1FRNAN
 jomnTOdGA8edbOY61zmUAV2cs/FWle3/Bhd3SnNGcs6nmN9kbXeZXmGPAj+N0/NYoJ/8
 IpHOYtv0hd0zgSWmG0aP85vMmM36XLjuK7kbrf2AR38k/U6kN2cZRlkscYQRy0HJeO7t
 f83x9AIObL7IbdPlPmQdWYofyXWFPskUmjGC1FxK5NgN//6bQ6nOKIf1PCJcFaELmmRf
 iCDKZdgN9X2gI5malpYRb0NJIvO3zX8HHnU1vd9r0w0UtTX17bzqf2DgPpJ2OQyKTWBu
 4aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776784573; x=1777389373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9p2KzsZY9SIDA8sbG7RF3nRF06ShKZTDnqcgc/hbfAU=;
 b=LH3GklF9vMjXxDKoEsAf/ilMvIbAo1dg9Bsc3uZWa6Dj7t1bmk2mhx7SPMx/5CdnZ+
 6O5aT6JjMrRGTmpqzHXR668TfBdu2kLHJCJAXhJtxv1Vhyqdwh9cH26IvaV0AJs+ffOr
 7rqc9SnVeeVTMxv1+wNl75zMW55gEHmdpe/Bw2pYbSZ2b4i2M2FoFsKPPUvqaWBX0WF/
 3o/jWXzau4Z6j6pdgh+d8grwKWInxQeDZkvisdapAI6zSdVANy4VCyik7qj7RpWsqKz+
 po65ddKLvUgUWOtKkPvl1z6eJWlMbzjq5xJUQLRlI+RkDZPChaCJdA/ivQyESSUiyMPG
 +fPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0cP2+Eaz8w6mhNHThvY5h1L6rvnDPtT9vY58Ol48G29nf7sysB82EU1N8n95QxhcOMB7gjp0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzy9MzEGFdlybdBuCXBBAtbu+Ar+AiRduAU69Fx69qdPDBNic7G
 bMXMsLSbYkgOFqS12W0TKLybTJ0AezX9ztan/HOChZ37yWAFWIbXlCb3JHQYsrEK
X-Gm-Gg: AeBDievww1r2e1moSre06dz8gTtriwOzxpsRwszm+9yxG5NYioRiRSezp791P3x43oT
 MF6oE/zUIeCiF2U3EAu/w51vfgL6LU8vDu3+03XV/94jkC+EoX9F1QlGjT9V0i10EAlWeHOO9E3
 Nle8HnhxzYGhCBFWVSpZKtxUztHMV5PVdRXVL2zZ+xpzJHkfyU+D3ZDVSykn/15szQKvQN6Q9T7
 Hw+7Yn/bk1KFJwfomjYx/lqWIRBRztdwzIlfXlaNP28h49sJX4DlEDeVwOFC27vebLRCdKLTemF
 ZLa3djcqwG5S5i3vBEDj+5VdfLduh4y7MJz/PDwgs9pXNcXERfvClNcSw/tO/5mtZu3AvfVoIjK
 S8lZZPwmZt5xR65J19y9DLuQdt3LoMnVsgnU6PoBzULXqjShIGWiX3IOo1LFoSzSGG8Y8ZIIeYB
 oSXndCCHLTZAdyryJCf2wex18OUnuGEChIKq9+yoec9YyuMG7WKYmASEFSMPG9oZ7DT/eQwQVu1
 Jso9EdpSILUTVu/RsPOX5B/rriINd3uF4Arzz8uhZSzjGO/+A1AhlU=
X-Received: by 2002:a05:600c:8587:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-488fb7856b9mr198668755e9.20.1776784572981; 
 Tue, 21 Apr 2026 08:16:12 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm361416995e9.0.2026.04.21.08.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:16:11 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] board: toradex: aquila-am69: Fix memory size setup
 logic
Date: Tue, 21 Apr 2026 17:15:56 +0200
Message-ID: <20260421151604.1141082-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
References: <20260421151604.1141082-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

The hardware configuration pins are used both to select the DDR
configuration and to determine the installed memory size.

On Aquila AM69, the DDR timing patch is applied in the R5 SPL, while the
memory size fixup for the next-stage U-Boot DT is done later in the A72
SPL path.
The previous immplementation was not taking in account that the hw_cfg
value is lost both during SPL execution (board_init_f and board_init_r)
and between SPL and U-Boot proper.

Fix this by reading the hardware configuration pins when the memory size
is actually needed:
- in the R5 SPL, to select the correct DDR configuration
- in the A72 SPL, to fix up the U-Boot DT memory size and bank layout

Fixes: 3f0528882c0d ("board: toradex: add aquila am69 support")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/aquila-am69/aquila-am69.c | 90 +++++++++++++++----------
 1 file changed, 54 insertions(+), 36 deletions(-)

diff --git a/board/toradex/aquila-am69/aquila-am69.c b/board/toradex/aquila-am69/aquila-am69.c
index 0c7123a059e4..45fba1bbfe80 100644
--- a/board/toradex/aquila-am69/aquila-am69.c
+++ b/board/toradex/aquila-am69/aquila-am69.c
@@ -15,6 +15,7 @@
 #include <i2c.h>
 #include <linux/sizes.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/tdx-common.h"
 #include "aquila_ddrs.h"
@@ -30,46 +31,24 @@
 #define HW_CFG_MEM_CFG_MASK		0x03
 
 DECLARE_GLOBAL_DATA_PTR;
-static u8 hw_cfg;
 
-static u8 aquila_am69_memory_cfg(void)
-{
-	return hw_cfg & HW_CFG_MEM_CFG_MASK;
-}
-
-static u64 aquila_am69_memory_size(void)
-{
-	switch (aquila_am69_memory_cfg()) {
-	case HW_CFG_MEM_SZ_32GB:
-		return SZ_32G;
-	case HW_CFG_MEM_SZ_16GB_RANK_2:
-	case HW_CFG_MEM_SZ_16GB:
-		return SZ_16G;
-	case HW_CFG_MEM_SZ_8GB:
-		return SZ_8G;
-	default:
-		puts("Invalid memory size configuration\n");
-		return -EINVAL;
-	}
-}
-
-static void read_hw_cfg(void)
+static u8 get_hw_cfg(void)
 {
 	struct gpio_desc gpio_hw_cfg;
 	char gpio_name[20];
+	u8 hw_cfg = 0;
 	int i;
 
-	printf("HW CFG: ");
 	for (i = 0; i < 5; i++) {
 		sprintf(gpio_name, "gpio@42110000_%d", 82 + i);
 		if (dm_gpio_lookup_name(gpio_name, &gpio_hw_cfg) < 0) {
 			printf("Lookup named gpio error\n");
-			return;
+			return 0;
 		}
 
 		if (dm_gpio_request(&gpio_hw_cfg, "hw_cfg")) {
 			printf("gpio request error\n");
-			return;
+			return 0;
 		}
 
 		if (dm_gpio_get_value(&gpio_hw_cfg) == 1)
@@ -77,15 +56,34 @@ static void read_hw_cfg(void)
 
 		dm_gpio_free(NULL, &gpio_hw_cfg);
 	}
-	printf("0x%02x\n", hw_cfg);
+	return hw_cfg;
 }
 
-static void update_ddr_timings(void)
+static u64 aquila_am69_memory_size(void)
+{
+	u8 hw_cfg = get_hw_cfg();
+
+	switch (hw_cfg & HW_CFG_MEM_CFG_MASK) {
+	case HW_CFG_MEM_SZ_32GB:
+		return SZ_32G;
+	case HW_CFG_MEM_SZ_16GB_RANK_2:
+	case HW_CFG_MEM_SZ_16GB:
+		return SZ_16G;
+	case HW_CFG_MEM_SZ_8GB:
+		return SZ_8G;
+	default:
+		puts("Invalid memory size configuration\n");
+		return -EINVAL;
+	}
+}
+
+#if defined(CONFIG_TARGET_AQUILA_AM69_R5)
+static void update_ddr_timings(u8 hw_cfg)
 {
 	int ret = 0;
 	void *fdt = (void *)gd->fdt_blob;
 
-	switch (aquila_am69_memory_cfg()) {
+	switch (hw_cfg & HW_CFG_MEM_CFG_MASK) {
 	case HW_CFG_MEM_SZ_8GB:
 		ret = aquila_am69_fdt_apply_ddr_patch(fdt, aquila_am69_ddrss_patch_8GB,
 						      MULTI_DDR_CFG_INTRLV_SIZE_8GB);
@@ -103,6 +101,7 @@ static void update_ddr_timings(void)
 	if (ret)
 		printf("Applying DDR patch error: %d\n", ret);
 }
+#endif
 
 static int aquila_am69_fdt_fixup_memory_size(u64 total_sz)
 {
@@ -121,21 +120,33 @@ static int aquila_am69_fdt_fixup_memory_size(u64 total_sz)
 	return fdt_fixup_memory_banks(blob, s, e, CONFIG_NR_DRAM_BANKS);
 }
 
+#if defined(CONFIG_TARGET_AQUILA_AM69_R5)
 void do_board_detect(void)
 {
+	u8 hw_cfg;
+
 	/* MCU_ADC1 pins used as General Purpose Inputs */
 	writel(readl(CTRL_MMR_CFG0_MCU_ADC1_CTRL) | BIT(16),
 	       CTRL_MMR_CFG0_MCU_ADC1_CTRL);
 
-	read_hw_cfg();
+	hw_cfg = get_hw_cfg();
+	printf("HW CFG: 0x%02x\n", hw_cfg);
 
 	if (IS_ENABLED(CONFIG_K3_DDRSS))
-		update_ddr_timings();
+		update_ddr_timings(hw_cfg);
 }
+#endif
+
+#if defined(CONFIG_XPL_BUILD)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
+{
+	fixup_memory_node(spl_image);
+}
+#endif
 
 int dram_init(void)
 {
-	s32 ret;
+	int ret;
 
 	ret = fdtdec_setup_mem_size_base_lowest();
 	if (ret)
@@ -146,11 +157,18 @@ int dram_init(void)
 
 int dram_init_banksize(void)
 {
-	s32 ret;
+	int ret;
 
-	ret = aquila_am69_fdt_fixup_memory_size(aquila_am69_memory_size());
-	if (ret)
-		printf("Error setting memory size. %d\n", ret);
+	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	    IS_ENABLED(CONFIG_TARGET_AQUILA_AM69_A72)) {
+		u64 mem_sz = aquila_am69_memory_size();
+
+		ret = aquila_am69_fdt_fixup_memory_size(mem_sz);
+		if (ret)
+			printf("Error setting memory size. %d\n", ret);
+	} else {
+		fdtdec_setup_mem_size_base();
+	}
 
 	ret = fdtdec_setup_memory_banksize();
 	if (ret)
-- 
2.43.0

