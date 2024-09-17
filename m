Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A5FC35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D846B88E70;
	Tue, 17 Sep 2024 14:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pLup+ZLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0489188E08; Tue, 17 Sep 2024 14:34:54 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F100E88E53
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cae102702so36013855e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726576491; x=1727181291; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
 b=pLup+ZLhvatoyVx+OYyd4ZFqZLF2JL+GzXR3U4U6DOR0WjGoLBjcZwjdEZA2gpAU6Y
 Tpa2y67Ah+PDIrDiBdDyA5ZJd/rIkMimGwSOcQtm0plaafvOEM5YoqXbKTdFhAJ7F/z6
 jTIWI9jh4LJSI15CkkJ9uW9QfHecakRu7agtjRl2UBUnmGxSBOLrbNXocTsnA/LnwFZ+
 30SDhxNgScJWav3tMQ/YZzI/WrzLlbOVysmoSw7vDecL6kCBjjlqrYiarkp5V8Oi10Y8
 vkaSMUvpYw3BGkhshMT7YRUsb8aQnOyZk1FC41TSDtNsY3Io2CLNkSfxSrgkrC8tnYcJ
 3kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576491; x=1727181291;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
 b=so3UyQT5I63xaymjUgVsBiRACk85Hre+k6gHbGO5npXZ0ilHb1heQuHxSnC1qvPj3v
 gnStVubaAOq4FS3IG5BfbFsHYnQl9Jfq6sjJcuqvaJVmS+LEDD/maDLrzNvrZmj+NL5J
 A2DUdb51RBlVQ1OGjD3C7COkn6YgHGXkbWO+Qucrh4Jrl0ozp4kYPCXtXgvKuHgFq6fi
 YNT8LqGQJcS+Y7AUsuRGf6i88rRo+tZ/kLeJCDRGKcFIEV5HPkKh4iOi/bdxTOzqX0vE
 FSnofJ3pgR+imsOJBoPZqOiSR1m7aZqDYM4xx5SZx8FDuL3FBpQGf7kgg54WbVXgBzSn
 tH5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlxY1mZ85gW/ieyIJQcNug21ALQMAwnXQpadLzgARrEXmDRk4xAhUjGse1ATobxPgYOKTxU5o=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgsj0bvSEeoUs6tMtbXLebh1CI9mDTr8USM+DR6G0gae/U7M6i
 AMtkrVsCNNdaM91n1vEtYUZcUNROAecebjy1qhnbDqH2mVOx+23J9r6U9RgZwtEdkU/rhZ6N2xK
 x
X-Google-Smtp-Source: AGHT+IGAPcu9MP/RJTgChAijBhorhyksjW3VyrvPExXl7X7qlYFTzWCi+zZwYdnHMNNf8XuyxFjPSw==
X-Received: by 2002:a5d:4fc7:0:b0:374:c8dd:ea47 with SMTP id
 ffacd0b85a97d-378d6253618mr7621200f8f.50.1726576491083; 
 Tue, 17 Sep 2024 05:34:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e80eesm9381772f8f.30.2024.09.17.05.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:34:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Sep 2024 14:34:45 +0200
Subject: [PATCH v2 1/2] board: libretech-ac: move board support into
 dedicated directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-u-boot-topic-dynamic-uuid-v2-1-416e39c6e271@linaro.org>
References: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
In-Reply-To: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PkfVFZOTXdUMNl5kZ51pRdlVcMTOlH1wQ6hn+etanQs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm6XdnYz6f82WCIqUbu89MJrFSf11/WQgColC8lCjo
 CopY916JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZul3ZwAKCRB33NvayMhJ0aATD/
 43Fz2mKfTBggMmsmwiyhjlxJWtQYNefpUUz92IJzu/CY4jQTTzXKkUTj/UoP6MyDD5r4cHd9bsiB1i
 cAXSbSuWJRgeDRlENunenlaZLCkjBYB+76Qpj/Kxd281E3VrC42r9RS3UbhaBHrMSKYrywpe1H/wwE
 9o45TwORFuYJZiKwq2sVc6jEfqxtWYWf/NX/cvU7VkA7FUQt6JUMM0x3v2Co0lXfIk1bCk/exepVjl
 md/6SbT00gakp+5XJlAsmbFFSbckJHyp/Jx5cXgT+wTMIslo+AMOmmtj5/OC3fTylQa/PGaNJKjjqA
 tXPngOPiHMmjtcJdJULdh/V7hvCgZCQoREwU1bq7op5FAFLDX/ThtA9M49zyyjm1oyJbBQKajUj17S
 r/f67laF8USdUGAvWtpkIAYcp2ko9/NnhiDmpJvGCQnAV+L6b79+3mkI+g+OQkdzv4CrCZCjHvD2Fe
 0RhoERhOIqTzPwvTIaNjPBZMPCOA17GALhi1Dhbk4/Z+Mnq3oizRxn7V1u1diYJ/PpSixy3F36LtFU
 /J+qN7OGLpqR7ifvyx7g9l9Tl1a5BTpKzifbe99GoCd3whn4vRYeFUH87oyX7ZRPPwcQQwXcPNrM4j
 JMeT7mkP7eDARbq2QQhMheKHXd2dCKsfHMep4uIiNddkeKJvG440733al/1g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The libretech-ac aka aml-s805x-ac supports mainline U-boot
from a dedicated SPI flash, move the board support into
a dedicated vendor/board subdirectory in order to support
vendor specific customization.

It also aligns with the vendor downstream changes.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/amlogic/p212/MAINTAINERS                   |  2 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS    |  8 ++++
 board/libre-computer/aml-s805x-ac/Makefile       |  6 +++
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 47 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  2 +
 5 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index b2e3205fdf0..e73a4e52c1f 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -5,11 +5,9 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p212/
 F:	include/configs/p212.h
 F:	configs/khadas-vim_defconfig
-F:	configs/libretech-ac_defconfig
 F:	configs/libretech-cc_defconfig
 F:	configs/libretech-cc_v2_defconfig
 F:	configs/p212_defconfig
 F:	doc/board/amlogic/p212.rst
-F:	doc/board/amlogic/libretech-ac.rst
 F:	doc/board/amlogic/libretech-cc.rst
 F:	doc/board/amlogic/khadas-vim.rst
diff --git a/board/libre-computer/aml-s805x-ac/MAINTAINERS b/board/libre-computer/aml-s805x-ac/MAINTAINERS
new file mode 100644
index 00000000000..7cbc08aeb6c
--- /dev/null
+++ b/board/libre-computer/aml-s805x-ac/MAINTAINERS
@@ -0,0 +1,8 @@
+LIBRE-COMPUTER AML-S805X-AC
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/aml-s805x-ac/
+F:	include/configs/libretech-ac.h
+F:	configs/libretech-ac_defconfig
+F:	doc/board/amlogic/libretech-ac.rst
diff --git a/board/libre-computer/aml-s805x-ac/Makefile b/board/libre-computer/aml-s805x-ac/Makefile
new file mode 100644
index 00000000000..b4367ea522b
--- /dev/null
+++ b/board/libre-computer/aml-s805x-ac/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2016 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= aml-s805x-ac.o
diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
new file mode 100644
index 00000000000..ae9834c0bf8
--- /dev/null
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <init.h>
+#include <net.h>
+#include <asm/io.h>
+#include <asm/arch/gx.h>
+#include <asm/arch/sm.h>
+#include <asm/arch/eth.h>
+#include <asm/arch/mem.h>
+
+#define EFUSE_SN_OFFSET		20
+#define EFUSE_SN_SIZE		16
+#define EFUSE_MAC_OFFSET	52
+#define EFUSE_MAC_SIZE		6
+
+int misc_init_r(void)
+{
+	u8 mac_addr[EFUSE_MAC_SIZE + 1];
+	char serial[EFUSE_SN_SIZE + 1];
+	ssize_t len;
+
+	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
+		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
+					  mac_addr, EFUSE_MAC_SIZE);
+		mac_addr[len] = '\0';
+		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
+			eth_env_set_enetaddr("ethaddr", mac_addr);
+		else
+			meson_generate_serial_ethaddr();
+	}
+
+	if (!env_get("serial#")) {
+		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
+			EFUSE_SN_SIZE);
+		serial[len] = '\0';
+		if (len == EFUSE_SN_SIZE)
+			env_set("serial#", serial);
+	}
+
+	return 0;
+}
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 6ad04570022..11d9795e05d 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -1,5 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SYS_CONFIG_NAME="libretech-ac"
+CONFIG_SYS_VENDOR="libre-computer"
+CONFIG_SYS_BOARD="aml-s805x-ac"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1

-- 
2.34.1

