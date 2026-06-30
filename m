Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EECC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E83884AE9;
	Tue, 30 Jun 2026 03:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="i6aF5Q44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D1C84AF2; Tue, 30 Jun 2026 03:20:21 +0200 (CEST)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABEC84A6D
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-139f1dfc9faso3417610c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782417; x=1783387217;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=009+70DDjJEFXiOHuT0KFkP6/nXuWllGDPXYfPVQwLM=;
 b=i6aF5Q44dmXhgWWaTVeex8ekVa+zbt7iKmSeGg4GpzsrxlStdIXAzal93PvICxUl5R
 igGCiQFPRqIQ6QuNZ97M/RnBu3Pk6x3KqZGnq+H9mOl6OVkst++wUWmKyaRyNBRevVUS
 dP6wcI4x9xrznk7gDQQoBtzPiUyjuNRneyHE1C1G5KAjX0JsDylIN1K7Y+6OsDvZcXIW
 TYDo4jjPMq8BBW0rsZ3/+1YA8i2uBhHKWftcOh35Agi/wOUBn4wmgmd6LQkf8AZWlgIG
 aSsin1HigkAJt7oOkT6X1PnYkZM3xt1QN3rk9dA8tydk3CVipV9iP/I9qQYVyXTvNRNe
 g7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782417; x=1783387217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=009+70DDjJEFXiOHuT0KFkP6/nXuWllGDPXYfPVQwLM=;
 b=WSfKW6JlXPOG34bIz75ecL8hlpdiCpaMBZ+aUbqSzozy265Okjgld4x26R/6+dY+I/
 z07TD1MOW5aWsdP6IBjdM2UZmM35JTi25VirfYZ5km/dOVJEOoj001+qk2Nr/QN6j4h2
 7AHlOAFHp6BhZ3Iv8/jeaBOyCGGyg8ygJC/uEts3C21Xa73h01baRLB1itPaR02A2RYe
 I0N88RHwMKAMDq77iJWTVsJnaSqH4nWckGcygWUmVsyPCuh2T+uq+Samvbd5yPAOE2F4
 JqSt6cE++/n+aWJaChkfUaisQAUtNEmUe2DKnn6PLRi4dx1cGYfnj1ZlxWkapL1sZ8wu
 PPow==
X-Gm-Message-State: AOJu0YxSXKdAfaDX4s9w78SMStlaRzWa/UV1lvEwbkmy2R+kePeytSoX
 e6f6yCSFkDEO0viwvKuDdn5Iz5Rgaauz05fsItDGb5Te86FQaPjUiYbozJOVdWwF+gs=
X-Gm-Gg: AfdE7cnfw079q8bN3iHsO4L2njrzBj90KSMGdE2xOc4heBfowF22ZlIzWbRtr/1cWmP
 Oz1wICjYIigYk3EY2POxxq89MMX/OHXe5Y0viV8w0Q9CJqVs+WOKK0cL79H+QRRiJkGyazmLRsx
 zXZdK32Hz87tNSQPjf0r4SP/xPAqTUWzvPFMuJW9cysrcMZ9W5nZRJoXAiX2jNKJ+ZU5HAHJYgJ
 yFy9VVHIAwmE/PfSrou1CeDmUZxUwCRh9Mk/pWIWV0mPsC1+AX0g0bOe3/2T6vC0pwWuTvUWe4p
 aW6PZO1cv8Y2+uvbYXtMIT5UCkjQqsQgiVNnJm7iwion+/2iVLBqolDAN4OVhZN1J4ViEW706fU
 99qr4m1b3CUY07BxtwBmMYWOkCn5E9+OJpdbmlTEbaDxFgZhamCnGlAZyDnYePwE0u55ov7fAs4
 Q6+2/V0X1NUQeN30tSLqNHzPxAa/qSO8TNR0uImF/FSvY7cnnGcIIEIUNCX/c1fMwLWEo8kxQbH
 KqhsTCR6b8/1e6EIJo36KBvY9+/H77J7HCjLogHl+CvPhibv1ucJg==
X-Received: by 2002:a05:7022:923:b0:139:ed5d:5c9f with SMTP id
 a92af1059eb24-13b2a1c08bamr1045661c88.40.1782782416774; 
 Mon, 29 Jun 2026 18:20:16 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:20:16 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:11 +0800
Subject: [PATCH v5 10/14] spacemit: k1: Add DDR firmware support to SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-10-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  23 ++++++
 board/spacemit/k1/Makefile                |  21 +++++
 board/spacemit/k1/spl.c                   | 127 ++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 231e98d206a..b97bea7fd32 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -56,3 +56,26 @@
 		bootph-pre-ram;
 	};
 };
+
+&binman {
+	u-boot-spl-ddr {
+		type = "section";
+		filename = "u-boot-spl-ddr.bin";
+		pad-byte = <0xff>;
+
+		u-boot-spl {
+		};
+
+		ddr-fw {
+			type = "blob";
+			filename = "ddr_fw.bin";
+			align = <64>;
+		};
+
+		u-boot-any {
+			type = "section";
+			size = <0>;
+			offset = <0>;
+		};
+	};
+};
diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
index f9cbf4b0e06..a57af2e1f08 100644
--- a/board/spacemit/k1/Makefile
+++ b/board/spacemit/k1/Makefile
@@ -5,3 +5,24 @@
 
 obj-y := board.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
+
+DDR_FW_SRC ?= $(DDR_FW_FILE)
+FW_TARGET = $(objtree)/ddr_fw.bin
+
+$(obj)/spl.o: $(FW_TARGET)
+
+$(FW_TARGET): FORCE
+	@if [ -n "$(DDR_FW_SRC)" ] && [ -f "$(DDR_FW_SRC)" ]; then \
+		if ! cmp -s "$(DDR_FW_SRC)" $@ 2>/dev/null; then \
+			echo "  Copying DDR firmware from: $(DDR_FW_SRC)"; \
+			cp "$(DDR_FW_SRC)" $@; \
+		fi; \
+	elif [ -s $@ ]; then \
+		: ; \
+	else \
+		echo "  Note: No DDR firmware found, creating empty placeholder"; \
+		echo "  (Set DDR_FW_FILE to specify firmware location)"; \
+		touch $@; \
+	fi
+
+clean-files += $(FW_TARGET)
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index e862548f980..bab4fac3a13 100644
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
 static void i2c_early_init(void)
 {
 	struct udevice *bus;
@@ -109,6 +136,105 @@ void serial_early_init(void)
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
+	/*
+	 * Ensure the just-written DDR firmware bytes are observable in the
+	 * instruction stream. RISC-V's fence.i alone is sufficient for the
+	 * single-hart SPL case; skip flush_dcache_range as cbo.flush may
+	 * trap on our current privilege state.
+	 */
+	asm volatile ("fence.i" ::: "memory");
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
+		log_info("DDR is not ready\n");
+}
+
 void board_init_f(ulong dummy)
 {
 	u8 i2c_buf[I2C_BUF_SIZE] = { 0 };
@@ -131,6 +257,7 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", (char *)i2c_buf);
+	ddr_early_init();
 }
 
 u32 spl_boot_device(void)

-- 
2.51.0

