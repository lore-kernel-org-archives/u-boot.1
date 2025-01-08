Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9083CE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80DF380609;
	Wed,  8 Jan 2025 16:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="vnqzJGoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265EC801E8; Wed,  8 Jan 2025 09:50:26 +0100 (CET)
Received: from mail.per1cycle.org (mail.per1cycle.org [188.245.231.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C548006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 09:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9121A3F699; Wed,  8 Jan 2025 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1736326222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PDooda27VV4iq4Pj+w+cKgYrjosjQl+j65osKW0MlWQ=;
 b=vnqzJGoPQz7jXdI5Ipb9SWggjckT25vXyQJZIcggnYYE2zgz5KNbm0o3gS8ZF0oB1JDon4
 ZD26HFAv23uI3/U3xsN3iKbwWn5lqXfpWW5ZC45/uRQ0zebvTghQ23Sv4Rm+E+E3wyOQge
 CXlUdx76j5NkDfD020EsawqAHza5Kb25tOJkA2nHpV8mMh7FPZX4TinqlEoy7Y94RgZNpK
 14/23H0y2mgIrQqHAltOmh3kIGFqmWu//J/R7BKMZtfp6vDA2u0KucBOjozL7TG3pMcrg4
 mYY4J6SpFUa8L1lwCClJKzap7wiJKKK8i7zaUR6rTYqhThX9pwu88Z7Tq+CKeg==
From: Huan Zhou <me@per1cycle.org>
Date: Wed, 08 Jan 2025 16:49:58 +0800
Subject: [PATCH] riscv: spacemit: k1: probe dram size during boot phase.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
X-B4-Tracking: v=1; b=H4sIADU8fmcC/x3MQQqAIBBA0avErBtQwaiuEi1ER5tFFhoRiXdPW
 r7F/wUyJaYMc1cg0c2Zj9gg+w7sZmIgZNcMSigtpBgx0IUumR0zv4SDtl5PRmolJLTmTOT5+X/
 LWusHGWYxdV8AAAA=
X-Change-ID: 20250108-get-dram-size-65cf59a15201
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736326200; l=1817;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=GdV7T5Tdccu3YJaHO9VIlHvhxUQMs403VwJI3hEOGCA=;
 b=0hppDzsf5tBNWJMEivU8Y67FVGB/AB0eWuS1jI6drtkVUh5kjIyjNagFjz9g8f6Vog9NASSd+
 dScjPJOeuNyDLdmMRXJyflf/dyC+2SmTqFEvr9Sxy2boUAolZOUVQpa
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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



---
This patch introduce improvement for get dram size on bananapi BPI-F3,
retrieving the dram size dynamically.
Have tested on bananapi BPIF3 4G and jupiter 8G.

Signed-off-by: Huan Zhou <me@per1cycle.org>
---
 arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f7477d62c0776bcb51e623db47 100644
--- a/arch/riscv/cpu/k1/dram.c
+++ b/arch/riscv/cpu/k1/dram.c
@@ -4,17 +4,53 @@
  */
 
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <config.h>
+#include <bitfield.h>
 #include <fdt_support.h>
 #include <linux/sizes.h>
 
+#define DDR_BASE 0xC0000000
 DECLARE_GLOBAL_DATA_PTR;
 
+static inline u32 map_format_size(u32 val)
+{
+	u32 tmp;
+
+	if (val & 0x1 == 0)
+		return 0;
+
+	tmp = bitfield_extract(val, 16, 5);
+	switch (tmp) {
+	case 0xd:
+		return 512;
+	case 0xe:
+		return 1024;
+	case 0xf:
+		return 2048;
+	case 0x10:
+		return 4096;
+	case 0x11:
+		return 8192;
+	default:
+		pr_info("Invalid DRAM density %x\n", val);
+		return 0;
+	}
+}
+
+u32 ddr_get_density(void)
+{
+	u32 cs0_size = map_format_size(readl((void *)DDR_BASE + 0x200));
+	u32 cs1_size = map_format_size(readl((void *)DDR_BASE + 0x208));
+	u32 ddr_size = cs0_size + cs1_size;
+
+	return ddr_size;
+}
+
 int dram_init(void)
 {
 	gd->ram_base = CFG_SYS_SDRAM_BASE;
-	/* TODO get ram size from ddr controller */
-	gd->ram_size = SZ_4G;
+	gd->ram_size = (u64)ddr_get_density() * SZ_1M;
 	return 0;
 }
 

---
base-commit: 19fc0b7f7d907119a13e9c207991899f0817f8fc
change-id: 20250108-get-dram-size-65cf59a15201

Best regards,
-- 
Huan Zhou <me@per1cycle.org>

