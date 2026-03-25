Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0DC109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B08840F1;
	Wed, 25 Mar 2026 23:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rbtw0Cb8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B7C784106; Wed, 25 Mar 2026 23:33:24 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A571A83A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso61432585a.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774478000; x=1775082800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHPc5NA/QKMr8VGpqtQwafSb8Pj/Kr+z0TnVYhIqSvg=;
 b=Rbtw0Cb8aB63T+gKcpBGhDfcyvVx735CuBWYO+aAGtxZ1eYVK4NaJPCBkGP0THPG0Y
 kdLI7RcQagS3+WWKEbYN+aLy42g8mITEoK87OhIzKDMcspd8ABmUYfug5zYnUqg0N1s0
 clz4kr+CjTOEH4otrmv4NFK539xxwEghW8REZOT+V21ohi9dYuXjYJ6q9zdsk8Wfch/c
 RbuBq3alwxzQwqhmMV70uDCsJKEFPX9LBIYlIjhWj9iw7bm2ZDw1i5GCf5BYfI7/Hhss
 +N77vUVXiV22mfEjXjKBe/M1ZWsyIkQ16lYNVXXTmjM/Gq/zHzZBqltovw8tjE85AZxL
 MSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774478000; x=1775082800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KHPc5NA/QKMr8VGpqtQwafSb8Pj/Kr+z0TnVYhIqSvg=;
 b=Vn9Aj1woo8A7+YZujxA70OlgxgOZxLgh7XKxDEfN4KZfNgd/CbV1WgpiZHILbTrdGi
 qCwuryoEm5mC8KkQGxRm7VYiwfJ2P002Q0zoBvhToI72ef7+8D4rTI4veTwCyFOBOzpP
 mfWRK/Nsr2QPOEmf+519GSAbawN1HvupJiUXa7hUsk+kpton1KtEWcZtEwAWVMlwTKju
 OjJGzMCRp4VzTIYwkv6oF3SqJqDdijdpZUIRC8jfoQD5WTPZySRUi5sVXZEW6PD4E6o/
 uFuGIBrt+7TTJR6NCQhVu6ecpst2Zo+00RTV74kI1cDWmLPyzyXJSWBQ7tWvnxcn41PU
 0V5w==
X-Gm-Message-State: AOJu0Yz0bwoQvQXLxopGc5J302nhn8GaCNWufzVsKpG/ktt1WBIXtGrB
 XkbzlHniO5ZejYRA2Xq5oG5oBFp86h1IefhnzTeaYkdDs0mQdNiK7e4ptQpJAvNV
X-Gm-Gg: ATEYQzwiTTreBiyRQYT0amk2Jxp22jGg5aSvEJjslUESJYqAZ4V0/RrjhZCgVxxjWwv
 V+KcLTGCACXMfYgrGrmqgFRyqUpDpozQTPpZc+pyRN23oBDp89WRVqt83BFvXu5FB/cTNGxcigS
 fqoZcORGXSEV81sZxc4mvEXY1hpEadalc15yweZ4LSfWiN735vDX/rtV4EqyeO+MXexPxg5fJ88
 1P4AuotVk6g0TMRiwx4JnTq+oNZnLeTU4BBHH2tv6BLm9//G6S8ZUOfbRCYxZtt71Ks5YelaOK0
 CPvrXV0seKx2i2G98rmoSwNu27KWuH/4aR124f3Is3mcYS99PXG1kl1SOBwLocZHsX70ZQeYVTO
 xL2QNkF9YHtW+9C5OciZlRZBo7vbrI0Lw02mtgi9mvxrBN4cJWlbW8qJjjCexf4dyVE7RbPjsLL
 KksrJnHUwfXvTXPyvRmMseMb1e5UFHOj9OQjkodrhppiBohIC6b9S58kJ8bmAiBXi7tdAAhwaTG
 IfzV8IZtY0=
X-Received: by 2002:a05:620a:f03:b0:8cf:cee2:e400 with SMTP id
 af79cd13be357-8d000f85357mr728006685a.8.1774478000127; 
 Wed, 25 Mar 2026 15:33:20 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:19 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v3 13/16] spacemit: k1: Add DDR firmware support to SPL
Date: Wed, 25 Mar 2026 18:32:29 -0400
Message-Id: <20260325223232.1553212-14-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Include DDR initialization firmware in the SPL image. The firmware
path can be specified via the DDR_FW_FILE environment variable. If
the firmware is not found, an empty placeholder file is created to
allow the build to proceed without DDR initialization support.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong.xu@riscstar.com>
---
Changes in v3:
- None.

 arch/riscv/dts/k1-spl.dts  |  24 +++++++-
 board/spacemit/k1/Makefile |  20 ++++++
 board/spacemit/k1/spl.c    | 122 +++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index 74e9957b83a..e118767e6db 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -7,7 +7,6 @@
 /dts-v1/;
 
 #include "k1.dtsi"
-#include "binman.dtsi"
 
 / {
 	model = "spacemit k1 spl";
@@ -20,6 +19,29 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	binman {
+		u-boot-spl-ddr {
+			type = "section";
+			filename = "u-boot-spl-ddr.bin";
+			pad-byte = <0xff>;
+
+			u-boot-spl {
+			};
+
+			ddr-fw {
+				type = "blob";
+				filename = "ddr_fw.bin";
+				align = <64>;
+			};
+
+			u-boot-any {
+				type = "section";
+				size = <0>;
+				offset = <0>;
+			};
+		};
+	};
 };
 
 &vctcxo_1m {
diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
index f9cbf4b0e06..827b1e507c7 100644
--- a/board/spacemit/k1/Makefile
+++ b/board/spacemit/k1/Makefile
@@ -5,3 +5,23 @@
 
 obj-y := board.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
+
+DDR_FW_SRC ?= $(DDR_FW_FILE)
+FW_TARGET = $(objtree)/ddr_fw.bin
+
+$(obj)/spl.o: $(FW_TARGET)
+
+$(FW_TARGET):
+	@echo "Preparing DDR firmware..."
+	@if [ -n "$(DDR_FW_SRC)" ] && [ -f "$(DDR_FW_SRC)" ]; then \
+		echo "  Copying from: $(DDR_FW_SRC)"; \
+		cp "$(DDR_FW_SRC)" $@; \
+	elif [ -f $@ ]; then \
+		echo "  Using existing $@"; \
+	else \
+		echo "  Note: No firmware found, creating empty file"; \
+		echo "  (Set DDR_FW_FILE to specify firmware location)"; \
+		touch $@; \
+	fi
+
+clean-files += $(FW_TARGET)
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 182e833849d..95b61f5aa90 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -4,8 +4,11 @@
  */
 
 #include <asm/io.h>
+#include <binman.h>
+#include <binman_sym.h>
 #include <clk.h>
 #include <clk-uclass.h>
+#include <cpu_func.h>
 #include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
@@ -14,6 +17,7 @@
 #include <log.h>
 #include <spl.h>
 #include <tlv_eeprom.h>
+#include "tlv_codes.h"
 
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
@@ -26,6 +30,29 @@
 #define MFP_GPIO_84		0xd401e154
 #define MFP_GPIO_85		0xd401e158
 
+#define DDR_FIRMWARE_BASE	0xc082d000
+
+#define DDR_DEFAULT_CS_NUM      2
+#define DDR_DEFAULT_TYPE        "LPDDR4X"
+#define DDR_DEFAULT_TX_ODT      80
+#define DDR_DEFAULT_DATA_RATE   2400
+
+#define MAGIC_NUM		0xaa55aa55
+
+typedef void (*puts_func_t)(const char *s);
+typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
+			       puts_func_t puts);
+
+struct ddr_cfg {
+	u32     data_rate;
+	u32     cs_num;
+	u32     tx_odt;
+	u8      type[I2C_BUF_SIZE];
+};
+
+binman_sym_declare(ulong, ddr_fw, image_pos);
+binman_sym_declare(ulong, ddr_fw, size);
+
 static void reset_early_init(void)
 {
 	struct udevice *dev;
@@ -119,6 +146,100 @@ void serial_early_init(void)
 		panic("Serial uclass init failed: %d\n", ret);
 }
 
+/* Set default value for DDR chips */
+static void ddr_cfg_init(struct ddr_cfg *cfg)
+{
+	memset(cfg, 0, sizeof(struct ddr_cfg));
+	cfg->data_rate = DDR_DEFAULT_DATA_RATE;
+	cfg->cs_num = DDR_DEFAULT_CS_NUM;
+	cfg->tx_odt = DDR_DEFAULT_TX_ODT;
+	strcpy(cfg->type, DDR_DEFAULT_TYPE);
+}
+
+int read_ddr_info(struct ddr_cfg *cfg)
+{
+	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
+	struct tlvinfo_header *tlv_hdr;
+	struct tlvinfo_tlv *tlv_entry;
+	u32 size, entry_size;
+	int ret, i;
+	bool found = false;
+
+	if (!cfg)
+		return -EINVAL;
+	ddr_cfg_init(cfg);
+	ret = read_tlvinfo_tlv_eeprom(eeprom_data, &tlv_hdr,
+				      &tlv_entry, i);
+	if (ret)
+		return ret;
+	p = (u8 *)tlv_entry;
+	for (i = 0; i < tlv_hdr->totallen; ) {
+		switch (tlv_entry->type) {
+		case TLV_CODE_DDR_CSNUM:
+			memcpy(&cfg->cs_num, &tlv_entry->value[0], 1);
+			found = true;
+			break;
+		case TLV_CODE_DDR_TYPE:
+			size = min((u32)tlv_entry->length, (u32)I2C_BUF_SIZE);
+			memcpy(&cfg->type[0], &tlv_entry->value[0], size);
+			found = true;
+			break;
+		case TLV_CODE_DDR_DATARATE:
+			memcpy(&cfg->data_rate, &tlv_entry->value[0], 2);
+			found = true;
+			break;
+		case TLV_CODE_DDR_TX_ODT:
+			memcpy(&cfg->tx_odt, &tlv_entry->value[0], 1);
+			found = true;
+			break;
+		case TLV_CODE_CRC_32:
+			if (!found)
+				return -ENOENT;
+			return 0;
+		}
+		entry_size = tlv_entry->length + sizeof(struct tlvinfo_tlv);
+		i += entry_size;
+		p += entry_size;
+		tlv_entry = (struct tlvinfo_tlv *)p;
+	}
+	if (!found)
+		return -ENOENT;
+	return 0;
+}
+
+/* Load DDR firmware */
+void ddr_early_init(void)
+{
+	void __iomem *src, *dst;
+	ulong pos, size;
+	struct ddr_cfg cfg;
+	ddr_init_func_t ddr_init;
+
+	pos = binman_sym(ulong, ddr_fw, image_pos);
+	size = binman_sym(ulong, ddr_fw, size);
+	src = (void __iomem *)pos;
+	dst = (void __iomem *)(DDR_FIRMWARE_BASE);
+	log_info("DDR firmware: [0x%lx]:0x%x, size:0x%lx\n", pos, readl(src), size);
+	memcpy((u8 *)dst, (u8 *)src, size);
+	size = round_up(size, 64);
+	flush_dcache_range((u32)(u64)dst, (u32)(u64)dst + size);
+
+	read_ddr_info(&cfg);
+	ddr_init = (ddr_init_func_t)DDR_FIRMWARE_BASE;
+#ifdef DEBUG
+	ddr_init(0xc0000000, cfg.cs_num, cfg.data_rate, puts);
+#else
+	ddr_init(0xc0000000, cfg.cs_num, cfg.data_rate, NULL);
+#endif
+	writel(MAGIC_NUM, (void __iomem *)0x00000000);
+	flush_dcache_range(0, 64);
+	invalidate_dcache_range(0, 64);
+	if (readl((void __iomem *)0x00000000) == MAGIC_NUM)
+		log_info("DDR is ready\n");
+	else
+		log_info("DDR isn't invalid\n");
+}
+
 void board_init_f(ulong dummy)
 {
 	u8 i2c_buf[I2C_BUF_SIZE];
@@ -142,6 +263,7 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", (char *)i2c_buf);
+	ddr_early_init();
 }
 
 u32 spl_boot_device(void)
-- 
2.25.1

