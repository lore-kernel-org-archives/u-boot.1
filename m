Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182DEC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 700F484ABE;
	Fri, 10 Jul 2026 15:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cgmuokc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B6584ADB; Fri, 10 Jul 2026 15:39:42 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4F084ABE
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so7967105e9.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690779; x=1784295579; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X2aqdwY9uH2xM9PpR/dGbMIwzhsoFWQgBHsDNyHLmZc=;
 b=cgmuokc1423BAzR5FcM9taG287krOAvrbVyGZBLIyNc92s1kiHG3G7dTJu35lYBS0t
 qqqBI+Tvr7jw3mALwiGJMPBmKbBWC/y0BZxLULtuVEv8UoSqsc7Ko5qBi3Ck/Cp75L2t
 orzII9gzMM6iVbyJRYf27fElEeK1jYsE/HuGUp5FkaKnNIxtnA2TE4/uIqfYgxM4OET4
 Hs+NmK9W2nKsDvJZlJHjjvthnCvLKEBmPCjmcPbHMBviiN9zzQ+CioiwFw1cv1Z/WmV9
 m+ehC0O16F9A07R4/W20nsIiNWo5NORBXtoYaRGe9aMkwCIFVx96aocvN6w3TcL/vHCb
 ZkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690779; x=1784295579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X2aqdwY9uH2xM9PpR/dGbMIwzhsoFWQgBHsDNyHLmZc=;
 b=okFB6xcQsfpZlGlVu67lF6i2YdC1pT8oO1KEoWQuFYCADt3DGqACGk50BjCEsQGGxL
 XX6tucEgxWDNjhsZ9ntL1jKaoeK5LmRVokX7mqmx+cz7NSN60n7Gn7SW76R5zMoq+pVv
 eblo56neMZIq67mWgb1E4gfNXbtzWoT+TA72AbAfIpaPRHqX0VUQTjWl6oro2+DVWnVX
 MlGRGKlFNTuw+ulTLEnvnplc11dMVz28lK6OCZXjcHciYDzd4NdTWNq0DVl6mGQpbETD
 RZnhqYWI9o1lN9r7twtF6bNiqkvvKsYvCRem2LeHGFddDNJR5qEdtTe9TT4r2cdQiuPD
 WHew==
X-Forwarded-Encrypted: i=1;
 AHgh+RqymYPgJVwGV4jFgyfCTHmud867iU6LDZYi79RQtNvq//9nSvUyCxKavARkVddQlUQ4rqVHDpg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8+kjXAZhWOwoROxWlqbnuD0BRQ2FfroaigYn0DW0z8qHfj2mm
 9pzAKyoeXnm9F3RsINIqEGFRqndD5MDDTvrbGrg6EzB0WsWTcIrsUViE
X-Gm-Gg: AfdE7clfRPSCT+DMIan2A7ZtUJXZbnrr5JqYXJZaAueOYNVRYM/Dtd/5JLIpewiTxS4
 WUpEhCqLzxgZ/lk8MhellbuSL8uaP3yBys52Hxdo6UPL6ND/GN7FskLlo3B33Q7IMorGrJryrXZ
 N2TSu+vy2jnlJ/rOtQglzKH2KyTOyqdNq64w0fW6yVF8p2wYWZJ5i1mOmQZ/A1CjabVqifiZ2tf
 0ul1Wig2jyL1/chDFI2v+7IJILu4eAW7hqCh4fTCSk1giQQBN4IC/QM6PFbx11xBGd7XXM4qa2M
 7k7VfZ0yCnEyI7L8n8E/UO0tFsjVg3sYTqm0oXq5fe1GEajF6tavl16pFE/HQMjuJHaZTRVe6up
 6ZdrLjlIEbyCFT8UEcy9sqQkmDf7gFPGHVHMDEHd+xRRNVizbPCl/DGnZr6euAu/x5N02Cok+fF
 W1sN7FoPpbyk0KiuHvxbcCkvJ+xzY9BZetdXr5IFraE3s51U28/UOEytLlAlTdteoLd3Rg0q47Y
 rm4
X-Received: by 2002:a05:600c:6096:b0:492:5bb6:6d4b with SMTP id
 5b1f17b1804b1-493e68ef28bmr123095765e9.34.1783690778955; 
 Fri, 10 Jul 2026 06:39:38 -0700 (PDT)
Received: from emanueleg-nb.. (host-87-5-34-196.retail.telecomitalia.it.
 [87.5.34.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e714a3sm39801495e9.2.2026.07.10.06.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:39:38 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: "Francesco Dolcini" <francesco.dolcini@toradex.com>,
 "Tom Rini" <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Stefano Babic" <sbabic@nabladev.com>,
 "Fabio Estevam" <festevam@gmail.com>, "Peng Fan" <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/2] board: toradex: smarc-imx95: detect RAM sizes
Date: Fri, 10 Jul 2026 15:39:08 +0200
Message-ID: <20260710133913.388770-2-ghidoliemanuele@gmail.com>
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
on Toradex SMARC iMX95. The address wrap-around is not linear: address
bits above the module capacity alias back with some low address bits
XORed (bit 32 -> XOR 0xc000), as measured on 4GB and 8GB modules.

During probing, skip the first 256MB, since that region is reserved.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/smarc-imx95/smarc-imx95.c | 23 ++++++++++++++++++++++-
 include/configs/toradex-smarc-imx95.h   | 15 +++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/board/toradex/smarc-imx95/smarc-imx95.c b/board/toradex/smarc-imx95/smarc-imx95.c
index 6040c49975a3..d09ce8a52abe 100644
--- a/board/toradex/smarc-imx95/smarc-imx95.c
+++ b/board/toradex/smarc-imx95/smarc-imx95.c
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
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
index 8a880b965038..97e3322ac282 100644
--- a/include/configs/toradex-smarc-imx95.h
+++ b/include/configs/toradex-smarc-imx95.h
@@ -7,16 +7,19 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
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
 
 #endif
-- 
2.43.0

