Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E95C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F126484AC8;
	Fri, 10 Jul 2026 15:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rb2ZA/BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0A984AF6; Fri, 10 Jul 2026 15:39:44 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365B584AC8
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so4339825e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690781; x=1784295581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V1525JbJ9ajeLTK8jjMb3MX0dVcKMzo3XI3cnN/LXrI=;
 b=Rb2ZA/BRBw1TFMi0ksNXWhtkC0wJSVvFg++GUF6gPx8LdbSlQ8mKlfOSg3C1dGtXHL
 bxHjMbD0Gtaa2+I0YrZ9XvIzDKP5mqOjmy8YJbI9Sl+w81rQrmS9otPZU+Gh9qo3WHy6
 83WflPNFtLFt4vfW6eYHvO7Bi9tWTYDdSFlpdhdPDywNvBMghNMuvYlWAHuubq/Uod26
 jhw0eckz09SrqtRRXVizqhY1tiEq7ulgBWOll6RShgBAUbZIA2Zv5AmIo+7ZhlUCctWb
 zHtOAbMilWa2j5p8op3RQshy1QIhbhos6PDFXZ9JtAP2zHQTuALDnoNZaLDrgaltqVYL
 qLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690781; x=1784295581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V1525JbJ9ajeLTK8jjMb3MX0dVcKMzo3XI3cnN/LXrI=;
 b=p7vaeHITAY75lAZN8ZGEyYLPAXFnRUpYemgkAVhUiBWvCtQ9LjGubCIpq9lDFThvTS
 6sXms31c+t/3q2PEaQ7AxFhzeRHaeZ4UEnDVdUb2AjhBADMFThbdSnDpnr2T4yNfo7ly
 Z1fCvCveCJF83r2s4cciFI0KQq0985PG0wwsVm6LK5e0vKqxiWH1vyWPcp7QTo7LxGMx
 bpX9DV/ZmWFcjhk8VSt9a+MLuK+KoUMTwridGdPURNnHS31Ly+QkzjHdbOZW2+iOa5pL
 hLHJDjPDwetfqmu6PKtVfjOurzlA2LEXucaUhVA1DJXLLSZIgnUumzpFMsZRwn8XkGCm
 f8HA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8ALDvS8FN9BHCm19SQP4HhKRJeNfZwMXkNhehUpzTPUMUIJKihW1RYW+8JaV8hknmVl9EiZs=@lists.denx.de
X-Gm-Message-State: AOJu0YwwyRxNibcnHJGkh8fJ+wB7mGjbz+/qe2ofIxcwkvrxn/fxxgXN
 9PWpWHbXlIjG9bGqUOplibjt9KLMONuikmwMhrCBMOQvvfi6wubDTZTu
X-Gm-Gg: AfdE7cnyXtiNAwCWOhpLOxNsXWo9sEEU2eMvwj9vHLdbBLLPaeq8G/WGpdFA7agEOAj
 sAn6neQ2VsNRlC/J6ZI6dj0+Tz3DgZUKx8acCVCvTx8ORe+7PNBSOnMz/dMhoWUKaYl9/egmssO
 GR9wk7Rtc2VEXD/ZkDlDzDCfJoaw4n2/kJplDIQMQHUcvqbIh/jz0Fg+dC49DDRo8M2hRDfuKwa
 8orBRY44dqqkabuUrPrIGx/6vtvtxFzlbJG7oLNw6Po5fYLgyKYRv9/GUvnyoeG8S9XIcq92h3e
 qOfrjFzk/Ayifo7ZBsZOJjHoUBKAE+gwzk3y+APiqblut9ljWhYNgpAsxnqAgG8ybbqdqaobo9n
 Mn8onABfdqH4sYm5xBaPZOTcJSsMov+3KVUFgykNBKxwbVpyC1Zj1xAs0A+Al5AnvTpHs1oYywh
 PFFCY4dyco0u4R20w0a8cwEzTJtgUZ8hqEM28zA5x5IbLvlgRWvIC+q/6Vs5Q+RK5Qrw==
X-Received: by 2002:a05:600c:3e0c:b0:493:c548:87fb with SMTP id
 5b1f17b1804b1-493f536ceb3mr24258695e9.36.1783690780628; 
 Fri, 10 Jul 2026 06:39:40 -0700 (PDT)
Received: from emanueleg-nb.. (host-87-5-34-196.retail.telecomitalia.it.
 [87.5.34.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e714a3sm39801495e9.2.2026.07.10.06.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:39:39 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: "Francesco Dolcini" <francesco.dolcini@toradex.com>,
 "Tom Rini" <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Stefano Babic" <sbabic@nabladev.com>,
 "Fabio Estevam" <festevam@gmail.com>, "Peng Fan" <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] board: toradex: aquila-imx95: detect RAM sizes
Date: Fri, 10 Jul 2026 15:39:09 +0200
Message-ID: <20260710133913.388770-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710133913.388770-1-ghidoliemanuele@gmail.com>
References: <20260710133913.388770-1-ghidoliemanuele@gmail.com>
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

Use alias-based RAM probing to detect different memory configurations
on Toradex Aquila iMX95. The address wrap-around is not linear: address
bits above the module capacity alias back with some low address bits
XORed (bit 32 -> XOR 0xc000), as measured on 4GB and 8GB modules.

During probing, skip the first 256MB, since that region is reserved.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/aquila-imx95/aquila-imx95.c | 23 ++++++++++++++++++++++-
 include/configs/aquila-imx95.h            | 15 +++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/board/toradex/aquila-imx95/aquila-imx95.c b/board/toradex/aquila-imx95/aquila-imx95.c
index 0c6473e4b3a5..a5b26ef3dc3b 100644
--- a/board/toradex/aquila-imx95/aquila-imx95.c
+++ b/board/toradex/aquila-imx95/aquila-imx95.c
@@ -3,14 +3,35 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
+#include <errno.h>
 #include <fdt_support.h>
 #include <init.h>
 
 #include "../common/tdx-cfg-block.h"
 
+/*
+ * The address wrap-around is not linear: address bits above the module
+ * capacity alias back to the base with some low address bits XORed, as
+ * measured on 4GB and 8GB modules (bit 32 -> XOR 0xc000, bit 33 -> XOR
+ * 0x2000).
+ */
+static const struct ram_alias_check ram_alias_checks[] = {
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_4G), (void *)((uintptr_t)PHYS_SDRAM + 0xc000), SZ_8G },
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_2G), (void *)(PHYS_SDRAM), SZ_4G },
+	{ NULL }
+};
+
 int board_phys_sdram_size(phys_size_t *size)
 {
-	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+	phys_size_t sz;
+
+	sz = probe_ram_size_by_alias(ram_alias_checks);
+	if (!sz) {
+		puts("## WARNING: Less than 4GB RAM detected\n");
+		return -EINVAL;
+	}
+
+	*size = sz - PHYS_SDRAM_FW_RSVD;
 
 	return 0;
 }
diff --git a/include/configs/aquila-imx95.h b/include/configs/aquila-imx95.h
index 07d09d138cb3..96c11ff2d5bf 100644
--- a/include/configs/aquila-imx95.h
+++ b/include/configs/aquila-imx95.h
@@ -10,16 +10,19 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-/* module has 8GB, 2GB from 0x80000000..0xffffffff, 6GB above */
+/* module has 8GB, 2GB from 0x80000000..0xffffffff, 6GB above.
+ * Actual size is determined at runtime.
+ */
 #define SZ_6G	_AC(0x180000000, ULL)
 
-/* first 256MB reserved for firmware */
-#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+/* The first 256MB of SDRAM is reserved for firmware (Cortex M7) */
+#define PHYS_SDRAM_FW_RSVD	SZ_256M
+#define CFG_SYS_INIT_RAM_ADDR	PHYS_SDRAM
 #define CFG_SYS_INIT_RAM_SIZE	SZ_2M
 
-#define CFG_SYS_SDRAM_BASE	0x90000000
-#define PHYS_SDRAM		0x90000000
-#define PHYS_SDRAM_SIZE		(SZ_2G - SZ_256M)
+#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM
+#define PHYS_SDRAM		(0x80000000 + PHYS_SDRAM_FW_RSVD)
+#define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
 #define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55, SPL could use first 2MB */
-- 
2.43.0

