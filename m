Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C58CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A48F38470E;
	Tue, 19 May 2026 00:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="EDqyocl6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5916B846A4; Tue, 19 May 2026 00:31:52 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12268465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ba21d32776so20143235ad.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143508; x=1779748308;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=By/eQRsG23oWxwM6wcGxUm5gbx9Ukd3/F6Gm+tZjj5Q=;
 b=EDqyocl6vqq/6NzhwxqYc7c1jNq7zj7TF2oqYWt0mpRVl0SqQr5KDVhHOb1fh0lz5k
 sGky3Gzn1QIE1A5K0DfKNE7stBLY6pBjuCn03/PzAEWMldra1WCM5q7eyHi6NZX5EIdN
 hpDfiZGuXh65LN8DyPP7mF7lzfd0OHI2nX4k323m3EI2GjE7yspJEUsqlHijkUReVDpv
 BOiDMUMePQ5eP2AzB090jmb8gc5lE8mTSmtJTlK5IOk5iXifOpRTB84Rn8cNNAhA9P/x
 JZPbzzVElNRQBk+2m/1xZOSF8tinG0CvOs4XQ/DEeym+rTZqFtItrTX8+oBmlB9n3OpN
 wYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143508; x=1779748308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=By/eQRsG23oWxwM6wcGxUm5gbx9Ukd3/F6Gm+tZjj5Q=;
 b=sY9KP/cqNXk4MwzfNFaKKOKgD0IG0HCe1bx2/K0dUKzk8PJhyS1QRN1HfQWefjx4ZK
 LZn5u95+yA9n9i3g/6ke/seEUoOpowz2bWlU9URx6JDw0Xet3EtPqAM+HWyUTX0VzE84
 yI/kz78HKjAkppDA3N9HuQ3c69Xu2F8HomaI2biLnOgm6oW+rQ8L2hsfEDebitLArsL4
 DEbqugLLlTyCvg8dzh277lg9Inogq+pbCh5djbJqigvLdTNslybrcA4dG++srOKb6vSB
 gbEO6FtXKsJ9YkkF2GZjF0Cne/1ttQqCFyL2i0/PVCUh4HE6z25iHQncL5bPE1B3koiU
 I9yA==
X-Gm-Message-State: AOJu0YyfbO0qe3cpGvkuDFKToj4AJiVnxj/Sshg+ILiuqVF9iqdid/cK
 +sADfFX9b81840+aoPGcCXxevOIt8jZzD4cIJoLW4AmCIb/saO5B52bm4oc3ItlFXBc=
X-Gm-Gg: Acq92OE+QYNi51mO4u2ZgQDVqJzP0eFiVB7TMu1DlV74Noo9ZYmmCMWVQ/Pu9mcnlfF
 wuvL64l8rU5uwdOgxsVFo3l5zYtWej0PV/gptsqOvP4Mz/tbb0J4uGtzEwDvDRNQGMIevH5OFwv
 ZsdtMXZXfeND8vL/QUqvQgIgq0bnyG+ks+OWoe6mDhU7G745N8IcoIgw+v+Id+/IvQOJBiX5y8a
 l3aEGghgbbWrz2rYxMiW8v5vS5vgPQSkKmA3iGLb+ATOLGPqSQo8DaeDPU89//sT/wVNwPi1ZFB
 IZKERPHod5PSkgDPNKe6NBtaFVdFau3wXxNyj6zFLkfS2YPbmXwoPkJLjZgePylQloby1+d16Uq
 zczba3PLRfAhZj25gse+OZ+Ap0Cp74ez/W8xkgpjhFtwz4CirjGDEddkdusB8Et6lBHshqhdefw
 nA8g+rpcjfKru43By9PUuKqBc56fuqYHCgu0lzf4AK66iw16fDDf8/hg==
X-Received: by 2002:a17:903:46cb:b0:2bd:2de3:51b1 with SMTP id
 d9443c01a7336-2bd7e8fa67emr189469125ad.32.1779143508295; 
 Mon, 18 May 2026 15:31:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:31:47 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:28 -0400
Subject: [PATCH v4 10/14] spacemit: k1: Add DDR firmware support to SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-10-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

---
v4:
- DT: binman u-boot-spl-ddr moves into k1-bananapi-f3-u-boot.dtsi.
- fence.i instead of flush_dcache_range() after firmware copy.
- Log fix: "DDR isn't invalid" -> "DDR is not ready".
- Makefile: FORCE, cmp -s, clean-files.
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  23 ++++++
 board/spacemit/k1/Makefile                |  21 +++++
 board/spacemit/k1/spl.c                   | 127 ++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index ac56bf512ad..1a6240a9725 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -73,3 +73,26 @@
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
2.43.0

