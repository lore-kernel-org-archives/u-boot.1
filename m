Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA454D2D10F
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 14:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6DB800AB;
	Tue, 13 Jan 2026 15:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aNjtFdXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0419800B6; Tue, 13 Jan 2026 15:31:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7183A80050
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 15:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c169=7T=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1768314708;
 bh=r+Pn+GgW7Su3CoarW3ZEa+lRhtCeu8tbcWhR3+sCZ4A=;
 b=aNjtFdXP3uBfUCx0c+TDzd+KeALks3aPNXA5QviXpGa4hYSkNykeM5XASc+quXyPU28kFjthk
 ACW/NjC8EmGT7StLZyZF08UEFkQCae1C6Z+qf/n647IDRauAb9bEQtKbcp3BzcZrvZ4SpYP8h6b
 TxouOuGhX9GNelTWoUsNmoufG0HQPJOK5AApBrjMKB3Fe9kqfDXut4QwcJns27CLPfsY6Y1Npw8
 mWM/mB9L0+dBp4jTx1/3FM6uLjBxonC+/oaZoQ7HoEBSd9K2LZVhZuSHNjFYP1SbwZbcT/cTMYY
 TzDqKVDWKw8mgiklw8EM+iiPfY/jpZhlfLNY9TSMF/Zw==
X-Forward-Email-ID: 69665750b51c02680f8a5ebe
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: Reduce size of ramboot usb472 payload
Date: Tue, 13 Jan 2026 14:31:30 +0000
Message-ID: <20260113143132.3401001-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

Booting into SPL using ramboot can take several seconds on some SoCs due
to the large size of the usb472 payload sent over USB to BootROM.

A large chunk of the usb472 payload, around 1-2 MiB, is padding used to
avoid overlapping when loading e.g. TF-A to 0x40000.

BootROM is likely wasting unnecessary time crc16 validating the padding
of the payload.

Place the FIT payload directly after SPL and memmove it to the expected
memory location, SPL_LOAD_FIT_ADDRESS, to avoid excessive padding and
help speed up ramboot.

Binman symbols are used to get the position and size of the FIT payload
that is initially loaded into DRAM by the BootROM.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rockchip-u-boot.dtsi |  7 +++--
 arch/arm/mach-rockchip/spl.c      | 51 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 71d7623fe2ca..9fb1abd27fa0 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -244,18 +244,21 @@
 	simple-bin-usb472 {
 		filename = "u-boot-rockchip-usb472.bin";
 		pad-byte = <0x00>;
+		skip-at-start = <CFG_SYS_SDRAM_BASE>;
 
 		u-boot-spl {
-			no-write-symbols;
 		};
 
+		payload {
+			type = "section";
+			align = <CONFIG_SYS_CACHELINE_SIZE>;
 #ifdef HAS_FIT
 		fit {
 			insert-template = <&fit_template>;
 #else
 		u-boot-img {
 #endif
-			offset = <(CONFIG_SPL_LOAD_FIT_ADDRESS - CFG_SYS_SDRAM_BASE)>;
+		};
 		};
 	};
 #endif /* CONFIG_ROCKCHIP_MASKROM_IMAGE */
diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index 1ce3a3b05547..a9155dceedb4 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd
  */
 
+#include <binman_sym.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <dm.h>
@@ -10,6 +11,7 @@
 #include <image.h>
 #include <init.h>
 #include <log.h>
+#include <mapmem.h>
 #include <ram.h>
 #include <spl.h>
 #include <asm/arch-rockchip/bootrom.h>
@@ -140,3 +142,52 @@ void spl_board_prepare_for_boot(void)
 
 	cleanup_before_linux();
 }
+
+#if CONFIG_IS_ENABLED(RAM_DEVICE) && IS_ENABLED(CONFIG_SPL_LOAD_FIT)
+binman_sym_declare_optional(ulong, payload, image_pos);
+binman_sym_declare_optional(ulong, payload, size);
+
+static ulong ramboot_load_read(struct spl_load_info *load, ulong sector,
+			       ulong count, void *buf)
+{
+	ulong addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
+				    CONFIG_SPL_LOAD_FIT_ADDRESS);
+
+	memcpy(buf, map_sysmem(addr + sector, 0), count);
+	return count;
+}
+
+static int ramboot_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	struct legacy_img_hdr *header;
+	ulong addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
+				    CONFIG_SPL_LOAD_FIT_ADDRESS);
+	ulong image_pos = binman_sym(ulong, payload, image_pos);
+	ulong size = binman_sym(ulong, payload, size);
+
+	if (addr == CFG_SYS_SDRAM_BASE || addr == CONFIG_SPL_TEXT_BASE)
+		return -ENODEV;
+
+	if (image_pos != BINMAN_SYM_MISSING && size != BINMAN_SYM_MISSING) {
+		header = map_sysmem(image_pos, 0);
+		if (image_get_magic(header) == FDT_MAGIC) {
+			memmove(map_sysmem(addr, 0), header, size);
+			memset(header, 0, sizeof(*header));
+		}
+	}
+
+	header = map_sysmem(addr, 0);
+	if (image_get_magic(header) == FDT_MAGIC) {
+		struct spl_load_info load;
+
+		spl_load_init(&load, ramboot_load_read, NULL, 1);
+		return spl_load_simple_fit(spl_image, &load, 0, header);
+	}
+
+	return -ENODEV;
+}
+
+/* Use priority and method name that sort before default spl_ram_load_image */
+SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, ramboot_load_image);
+#endif
-- 
2.52.0

