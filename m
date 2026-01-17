Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87313C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9AD583956;
	Sun, 18 Jan 2026 14:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jg8vOPOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBEA833C6; Sat, 17 Jan 2026 20:11:40 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5A082BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-502acd495feso14363671cf.2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768677096; x=1769281896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2JY5oYmBvPSgzwnwtdVV78e5iC4pUpMy5H5YEnXsYI=;
 b=Jg8vOPOl4UP/KBIV7nidAEoOZZY8kN8fxiV3kioRsfYJAfbkWJZruf4IT0aC0fxRx2
 9hatphzkSsM9gXP+lm2DVQtfz23XT2rxYlLyQKbPDpTA0NjnzgKYC8E2iCToljL9v6DD
 sqjE9GT5c0NjDTSC5/JSsWNSeuNtlma0bYlZu4azAq4BtRzkmjyeiUYeZVrUwkXxMwQN
 MCG1kzeSASwfYm+Bl9Oq7fI+KAQLU7EuA9F+FqFJjLO+TgGTUWu4MtywWpj/SSDHuUHv
 H9xyan0FJ5yFfq2CkKqDyTjkeTeE4uMgyU/jN3jQEvtJ2/PRo6FBB7YqY99lTgAgV4ti
 X7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768677096; x=1769281896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F2JY5oYmBvPSgzwnwtdVV78e5iC4pUpMy5H5YEnXsYI=;
 b=YIEMU1AUtvoVxjjJjRJ993HMNUjvnA4tUksquSw0zwJF9ihxgRkNYr5bOX5WEPL9vb
 l3DAitPRZj/UGaQVPum4aDyphaekmwCVqWgtwh2pdYr9Y3actkm9eRfY+HQjbvddrdQU
 vQao9zw72N5FWo/p8Mru3nWYKs7F48ywuQ55VMXoIuvpuuGKZNCST001mPIsODDuw94D
 XXAUFIWgsi8j2sz9XUIcxSoLUFwMLpvQdBWrkPX79W+oxKAVoY1DwLux7Du3edADRd8r
 mAMCl4XMJ4Oen8NF2DG8dzGcE7RxrqhYRltkdVhGQGSt5DTHGivitKz2FgirfpidsUeQ
 Mo3g==
X-Gm-Message-State: AOJu0YwNjlWx0bspzXdq8bLhinQ7vXlvEEoTpGSZiXI79kHBwNtD4hqd
 z94W1mmTEioF8ogcUbYMab6RtitCZ1hjyFRUwgi40DsHvdeNEtBtSwmxA5uu4A==
X-Gm-Gg: AY/fxX7v/aZBrtpzycAtMTPPZpng11tCqdIlH9mZmcotPIZaagcdD7gRWHCOi/1E2Y3
 eViOskw+07FMHWuASDDMC39QoHrtbX5DqXOPeDKM3gK7s02w2QwrH2c2rVmCO4Xs1U3TFDyIcz/
 E0U4wIWUrI6MKD4pqQ0b728kHs4AwJiFd39dvTdDMtijHW8SU57y7pv/L500fcRK9QJ/LeOvHqU
 ynkhn4cs0QegxpVSQ7hWuKCzYPwGCunu5illlMQEX62egiMN/Xm8Y0bzyvHuRdJujqkp2XAXMSb
 Mg7WOB+NI/E8Snub7PzAWGJqUssH5VzbQ/QH3bPh1XF9fktJdUqpuYYnnrLuZ4IS4kmxpnTZOH6
 zOAsjHfvWrpMe+A44BsPRMiwckBKxR33B2DxuvhBZESift8s10hMOzAF9ye/8eauMd3N73a+JHn
 ibK1HEMOVIxZ48TcXjUpXXgzL7UFb2vvKUhLYr7UuLDlfuTzU7ODUdh2gJ8ukmtaSaUsoApFI=
X-Received: by 2002:a05:622a:1a9b:b0:501:4cd0:a486 with SMTP id
 d75a77b69052e-502a1f2e0aemr100863401cf.54.1768677096358; 
 Sat, 17 Jan 2026 11:11:36 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:11:35 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Samuel Holland <samuel@sholland.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 14/17] spacemit: k1: Add DDR firmware support to SPL
Date: Sat, 17 Jan 2026 14:01:48 -0500
Message-Id: <20260117190231.977686-15-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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
---
 arch/riscv/dts/k1-spl.dts      |  34 ++++++++++++++++++++++++++++++++-
 board/spacemit/k1/Kconfig      |   8 ++++++++
 board/spacemit/k1/Makefile     |  19 ++++++++++++++++++
 board/spacemit/k1/spl.c        |  30 +++++++++++++++++++++++++++++
 include/configs/k1.h           |   3 +++
 lib/vendor/spacemit/ddr_fw.bin | Bin 0 -> 19416 bytes
 6 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 lib/vendor/spacemit/ddr_fw.bin

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index cd7875f3e35..f8b280fa96f 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -7,7 +7,6 @@
 /dts-v1/;
 
 #include "k1.dtsi"
-#include "binman.dtsi"
 
 / {
 	model = "spacemit k1 spl";
@@ -21,6 +20,39 @@
 		stdout-path = "serial0:115200n8";
 		bootph-all;
 	};
+
+	binman {
+		section {
+			filename = "u-boot-spl-ddr.bin";
+			pad-byte = <0xff>;
+			align-size = <4>;
+			align = <4>;
+
+			spl_section: section {
+				type = "section";
+				size = <CONFIG_SPL_DDR_FIRMWARE_OFFSET>;
+
+				u-boot-spl-nodtb {
+					type = "blob";
+					filename = "spl/u-boot-spl.bin";
+					align-end = <4>;
+				};
+
+				u-boot-spl-dtb {
+					type = "blob";
+					filename = "spl/u-boot-spl.dtb";
+					align-end = <4>;
+				};
+			};
+
+			ddr_fw: ddr-firmware {
+				type = "blob";
+				offset = <CONFIG_SPL_DDR_FIRMWARE_OFFSET>;
+				filename = "lib/vendor/spacemit/ddr_fw.bin";
+				align-end = <4>;
+			};
+		};
+	};
 };
 
 &vctcxo_1m {
diff --git a/board/spacemit/k1/Kconfig b/board/spacemit/k1/Kconfig
index 9f9c806d00d..a5fa788f660 100644
--- a/board/spacemit/k1/Kconfig
+++ b/board/spacemit/k1/Kconfig
@@ -15,6 +15,14 @@ config SYS_CONFIG_NAME
 config TEXT_BASE
 	default 0x00200000
 
+config SPL_DDR_FIRMWARE_OFFSET
+	hex "DDR firmware offset in SPL image"
+	depends on SPL
+	default 0x20000
+	help
+	  Offset where DDR firmware should be placed in the SPL
+	  image.
+
 config SPL_OPENSBI_LOAD_ADDR
 	default 0x00000000
 
diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
index 7bce47bac8c..ebe6e55867c 100644
--- a/board/spacemit/k1/Makefile
+++ b/board/spacemit/k1/Makefile
@@ -5,3 +5,22 @@
 
 obj-y := board.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
+
+DDR_FW_SRC ?= $(DDR_FW_FILE)
+FW_TARGET = $(srctree)/lib/vendor/spacemit/ddr_fw.bin
+
+DDR_FW_HEADER = $(objtree)/include/generated/ddr_fw_info.h
+
+$(obj)/spl.o: $(DDR_FW_HEADER)
+
+$(DDR_FW_HEADER): $(FW_TARGET)
+	@echo "/* DDR firmware info - $$(date) */" > $@
+	@if [ -f "$(FW_TARGET)" ]; then \
+		SIZE=$$(stat -c%s "$(FW_TARGET)" 2>/dev/null || echo 0); \
+	else \
+		SIZE=0; \
+	fi; \
+	echo "#define DDR_FW_FILE_SIZE	$$SIZE" >> $@
+	@echo "/* Note: Update ADDR if binman layout changes */" >> $@
+
+clean-files += $(FW_TARGET) $(DDR_FW_HEADER)
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 6fe064bd430..54bad9000fe 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -6,10 +6,12 @@
 #include <asm/io.h>
 #include <clk.h>
 #include <clk-uclass.h>
+#include <cpu_func.h>
 #include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <dt-bindings/pinctrl/k1-pinctrl.h>
+#include <generated/ddr_fw_info.h>
 #include <i2c.h>
 #include <linux/delay.h>
 #include <log.h>
@@ -115,6 +117,33 @@ void serial_early_init(void)
 		panic("Serial uclass init failed: %d\n", ret);
 }
 
+/* Load DDR training firmware */
+int init_ddr_firmware(void)
+{
+	void __iomem *src, *dst;
+	unsigned long size;
+
+	src = (void __iomem *)(CONFIG_SPL_TEXT_BASE +
+			       CONFIG_SPL_DDR_FIRMWARE_OFFSET);
+	dst = (void __iomem *)(DDR_TRAINING_DATA_BASE);
+	memcpy(dst, src, DDR_FW_FILE_SIZE);
+	size = round_up(DDR_FW_FILE_SIZE, 64);
+	flush_dcache_range((u32)(u64)dst, (u32)(u64)dst + size);
+	return 0;
+}
+
+void ddr_early_init(void)
+{
+	void __iomem *addr;
+
+	init_ddr_firmware();
+	addr = (void __iomem *)(CONFIG_SPL_TEXT_BASE +
+				CONFIG_SPL_DDR_FIRMWARE_OFFSET);
+	// verify DDR firmware header
+	log_info("[0x%x]:0x%x, firmware size:%d\n",
+		 (uint)(u64)addr, readl(addr), DDR_FW_FILE_SIZE);
+}
+
 void board_init_f(ulong dummy)
 {
 	u8 i2c_buf[I2C_BUF_SIZE];
@@ -138,6 +167,7 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", (char *)i2c_buf);
+	ddr_early_init();
 }
 
 u32 spl_boot_device(void)
diff --git a/include/configs/k1.h b/include/configs/k1.h
index d46fec8b251..4cefdf7c725 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -16,4 +16,7 @@
 #define RISCV_MMODE_TIMER_FREQ	    24000000
 #define RISCV_SMODE_TIMER_FREQ	    24000000
 
+#define DDR_TRAINING_DATA_BASE	    0xC0832000
+#define DDR_TRAINING_INFO_BUFF	    0xC0800000
+
 #endif /* __CONFIG_H */
diff --git a/lib/vendor/spacemit/ddr_fw.bin b/lib/vendor/spacemit/ddr_fw.bin
new file mode 100644
index 0000000000000000000000000000000000000000..cefecae24977ee76c74e6f3b658adc6a81984640
GIT binary patch
literal 19416
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

literal 0
HcmV?d00001

-- 
2.25.1

