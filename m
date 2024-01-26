Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C023DC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1913687C3A;
	Fri, 26 Jan 2024 13:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="z44wQZiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E129086784; Fri, 26 Jan 2024 10:26:01 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B15987BBC
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 10:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e80046264so6879515e9.0
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 01:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1706261157; x=1706865957;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDYhtER7RlyO9guzzjTVVkdGeo4U6W9MLQ+Ub4xhNYM=;
 b=z44wQZivrb2NW+kbNltVM56ihcwJf/GrlsqPJXDcPTYJEF/Fj2K2py3s2oCnLQDdX3
 xjtw/70Fgdw2BZUit6Siopey9eQuMuGj3um4HaaykfBMby5daCLQS1IAV3+xK1DhaijK
 WLADjSjiOsh6IYr5uLfykahRfiyuV53mk17yoVkWJRPzzX35eMiZ6SeTzcwYDCUMKPt6
 uMR9dX8UaUnAxfo6nCq7kwB+BnQxIrapWIt733wDWIAVjfkOZrjwWFF5vloRZIfuvuVM
 FbIGHON3RbTWVaAEaal7+OsHAouADffSWS8gjwfv5ijffpKFLVOtTEEFBN9mR2/3eVwo
 S0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706261157; x=1706865957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDYhtER7RlyO9guzzjTVVkdGeo4U6W9MLQ+Ub4xhNYM=;
 b=DenW63cCC8yjhQYTc/lvVga47AdABBKhdFnFhVqBuOQoPM0tc27BPOk53q9sTUhWPo
 tvxjE78KxOap5FF3TOaoO+UQi7prjk2Ij37t+0Fk/rfiZzzQuUZ2jwmCLgpq1WDLUvbH
 fmop3Wz126eSIxZzXBChILh62bGSNGYQTIQlZ8JjnkPxWv1h/tIbQi9luuelxMP2UWnm
 MbcIAYB/eMzRdak6ad1Eo9PTQRFEyN65n/uApqWRJj05YkP1PLlTvJJkLWXqwQqn2Cv/
 kjuOzU1FzMeeJ2y7xd1ADmnls4QnnkUctqjS+l9sSScOqvekOnqJVbk7ifDh3bSh0cYI
 DWaA==
X-Gm-Message-State: AOJu0Yzp6SvTjYkNO0u+kceDMu5s/+gwAGw5W25k6NtePgyZBc7WMIsx
 XTT2pH8jShxtmAfVWlI9afQBpNECDGRoq7eqq50gGom1NGGKqMukJjgOPf5oVP/WtrjEH446cI+
 ae+0=
X-Google-Smtp-Source: AGHT+IFknMD3E4bEZ1K0Wy5Z6mOpUUuEfnX7TlpqkdvH8RGJ/rGYT7dHFQKMsGU0xVNwmsXvAYnsPw==
X-Received: by 2002:a7b:cb48:0:b0:40e:73fb:17 with SMTP id
 v8-20020a7bcb48000000b0040e73fb0017mr688043wmj.154.1706261157537; 
 Fri, 26 Jan 2024 01:25:57 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1709064f1800b00a349a5f9f77sm416208eju.47.2024.01.26.01.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 01:25:57 -0800 (PST)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>, Heiko Schocher <hs@denx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH 3/5] lpc32xx: Build firmware files using binman instead a rule
 in Makefile
Date: Fri, 26 Jan 2024 10:25:30 +0100
Message-Id: <20240126092533.20709-3-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
References: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jan 2024 13:24:57 +0100
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

Also fixed rounding up in the header verification function. Previously
Makefile was showing the header verification error but it was ignored.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 Makefile                         |   2 +-
 arch/arm/Kconfig                 |   1 +
 arch/arm/dts/lpc32xx-u-boot.dtsi | 127 +++++++++++++++++++++++++++++++
 tools/lpc32xximage.c             |   3 +-
 4 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/lpc32xx-u-boot.dtsi

diff --git a/Makefile b/Makefile
index 7a3209bd9e..9bc6fe41e0 100644
--- a/Makefile
+++ b/Makefile
@@ -1481,7 +1481,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
 u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
 	$(call if_changed,pad_cat)
 
-ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
+ifeq ($(CONFIG_ARCH_LPC32XX)_$(CONFIG_SPL)_$(CONFIG_BINMAN),y_y_)
 MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
 
 lpc32xx-spl.img: spl/u-boot-spl.bin FORCE
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index abd7c6c79a..95d8952e09 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -848,6 +848,7 @@ config ARCH_LPC32XX
 	select GPIO_EXTRA_HEADER
 	select SPL_DM if SPL
 	select SUPPORT_SPL
+	select BINMAN if SPL && OF_CONTROL
 	imply CMD_DM
 
 config ARCH_IMX8
diff --git a/arch/arm/dts/lpc32xx-u-boot.dtsi b/arch/arm/dts/lpc32xx-u-boot.dtsi
new file mode 100644
index 0000000000..1df71d16a3
--- /dev/null
+++ b/arch/arm/dts/lpc32xx-u-boot.dtsi
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2023 Timesys
+ * Author: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+ */
+
+#include <config.h>
+
+#ifdef CONFIG_SPL
+/ {
+	binman: binman {
+		multiple-images;
+
+		/* SPL U-boot format for SPI NOR flash */
+		lpc32xx-spl-spi {
+			filename = "lpc32xx-spl-spi.bin";
+			pad-byte = <0xff>;
+			int32 {
+				value = <0x13579BDF>;
+			};
+			file_size {
+				filename = "spl/u-boot-spl.bin";
+			};
+			blob {
+				filename = "spl/u-boot-spl.bin";
+			};
+		};
+
+		/* Full U-boot format for SPI NOR flash */
+		lpc32xx-full-spi {
+			filename = "lpc32xx-full-spi.bin";
+			pad-byte = <0xff>;
+			int32 {
+				value = <0x13579BDF>;
+			};
+			file_size {
+				filename = "spl/u-boot-spl.bin";
+			};
+			blob@0 {
+				filename = "spl/u-boot-spl.bin";
+				size = <CONFIG_SPL_PAD_TO>;
+			};
+			blob@1 {
+				filename = "u-boot.img";
+			};
+		};
+
+		/* U-boot format for external, 32bit wide, static memory */
+		lpc32xx-full-emc-32b {
+			filename = "lpc32xx-full-emc-32b.bin";
+			pad-byte = <0xff>;
+			int32 {
+				value = <0x13579BD2>;
+			};
+			blob@0 {
+				filename = "spl/u-boot-spl.bin";
+				size = <CONFIG_SPL_PAD_TO>;
+			};
+			blob@1 {
+				filename = "u-boot.img";
+			};
+		};
+
+		/* U-boot format for external, 16bit wide, static memory */
+		lpc32xx-full-emc-16b {
+			filename = "lpc32xx-full-emc-16b.bin";
+			pad-byte = <0xff>;
+			int32 {
+				value = <0x13579BD1>;
+			};
+			blob@0 {
+				filename = "spl/u-boot-spl.bin";
+				size = <CONFIG_SPL_PAD_TO>;
+			};
+			blob@1 {
+				filename = "u-boot.img";
+			};
+		};
+
+		/* U-boot format for external, 8bit wide, static memory */
+		lpc32xx-full-emc-8b {
+			filename = "lpc32xx-full-emc-8b.bin";
+			pad-byte = <0xff>;
+			int32 {
+				value = <0x13579BD0>;
+			};
+			blob@0 {
+				filename = "spl/u-boot-spl.bin";
+				size = <CONFIG_SPL_PAD_TO>;
+			};
+			blob@1 {
+				filename = "u-boot.img";
+			};
+		};
+
+		/* SPL U-boot format for NAND flash */
+		lpc32xx-spl {
+			filename = "lpc32xx-spl.img";
+			mkimage {
+				args = "-T lpc32xximage -a 0x0";
+				blob {
+					filename = "spl/u-boot-spl.bin";
+				};
+			};
+		};
+
+		/* Full U-boot format for NAND flash */
+		/* CONFIG_SPL_PAD_TO should be set to NAND block size */
+		lpc32xx-full {
+			filename = "lpc32xx-full.bin";
+			pad-byte = <0xff>;
+			blob@0 {
+				filename = "lpc32xx-spl.img";
+				size = <CONFIG_SPL_PAD_TO>;
+			};
+			blob@1 {
+				filename = "lpc32xx-spl.img";
+				size = <CONFIG_SPL_PAD_TO>;
+			};
+			blob@2 {
+				filename = "u-boot.img";
+			};
+		};
+
+	};
+};
+#endif
diff --git a/tools/lpc32xximage.c b/tools/lpc32xximage.c
index 715a55a5b5..33f1a39174 100644
--- a/tools/lpc32xximage.c
+++ b/tools/lpc32xximage.c
@@ -86,7 +86,8 @@ static int lpc32xximage_verify_header(unsigned char *ptr, int image_size,
 		(struct nand_page_0_boot_header *)ptr;
 
 	/* turn image size from bytes to NAND pages, page 0 included */
-	int image_size_in_pages = ((image_size - 1)
+	int image_size_in_pages = ((image_size
+				  + LPC32XX_BOOT_NAND_PAGESIZE - 1)
 				  / LPC32XX_BOOT_NAND_PAGESIZE);
 
 	if (hdr->data[0] != (0xff & LPC32XX_BOOT_ICR))
-- 
2.25.1

