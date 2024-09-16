Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD53C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E9E88ED2;
	Mon, 16 Sep 2024 11:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OJq+ODCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C5488EB8; Mon, 16 Sep 2024 11:41:59 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0EDE88EC0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cba8340beso32542085e9.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726479714; x=1727084514; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
 b=OJq+ODCiVTTFb9yIQtL528oyN4yx93ZuUlGu3ZlwFhzbMUgLMgAHyvNkVQ621fGxn+
 tdx3KeXBfjbvjQhLofIgdFaeUVkc3GtFeH/2G5Vi3camenAzfQSGHQcQXkkNiQkB/fb4
 iriLoblZBH+HZIJp+AwsGcEbx6MYqY3kQ3WLj0YcbL+BOUNC9LXFmhmKFyXIFHNWUjLS
 CwTdRfVUHzWye/yqtwrSXthWuZR5MqLNhM0Spwl7/ZdUq1lw5mbocqYbncTUuky4T1UQ
 3eGZSykb5ZecwfzUMsxKHcBCD+j52KuNOfHRxZFlSmxXT+e/rkaPejF9W7tiWrwHGAyw
 Op5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726479714; x=1727084514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isM0wkxM75qh7yVsSrZ/ILYNAN2B3+md2rez5tZORVY=;
 b=TW/ZK/gejszX4KAeE32sK/WKG3lj6zodGjIGKhk1IjEiYMxOQAMaxYOCAi4zy+k/0u
 Mx8A0I6BsOSMW6riI93qu/ryQXviv3Ta+Raj6vLMpk/oOJlKvc4Q6CrBk8KBUWdmNG65
 9yE6dGkfnBcl9vZrsnZnQpBneNVKyAWfTxH99x8F+1UAasbo2E8UaVrReAHto2ZXBbPm
 lvA7R8lhCZAXkzd7Jm+7kxUiPkVFxUzTch26SB+x9FRwJ2thbSCcYhcrFtWteD9Ad0K+
 Ue4v3wgDygmat+r4EitL2qWK9MwGVkS9XuzT/ynzgJTxppqD5BFE+rQe5CJJh4W/+yd7
 vBKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVefRYE+SKmTMfCCjXao7lhl9Kdg2cWRP1UbwseFJqeP3KQXgqObHCr8Vt7KOJoatmdvDuTkO0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7U62AbHPlYzXe2LzwNw4EF/VlrzT6AB5029Yc4RlQXdPywWUG
 paGG840a/LrIVHLz8FhgxsMGdUw8hmT2IrId/W7JwOADtNsWrIwHaA7w9N7bRpU=
X-Google-Smtp-Source: AGHT+IHuQii3EgUXYI2mGoZJ2CkIGFLYqdQgScbm2KR9vg1CPOy5mwIYZ/BO/tUnqDphivsIC6HhzA==
X-Received: by 2002:a05:600c:4e87:b0:426:6fb1:6b64 with SMTP id
 5b1f17b1804b1-42cbddcefd1mr132381365e9.7.1726479713594; 
 Mon, 16 Sep 2024 02:41:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05d4e1sm106398555e9.12.2024.09.16.02.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:41:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 11:41:48 +0200
Subject: [PATCH 1/2] board: libretech-ac: move board support into dedicated
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-u-boot-topic-dynamic-uuid-v1-1-7e4f48542a0f@linaro.org>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4053;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PkfVFZOTXdUMNl5kZ51pRdlVcMTOlH1wQ6hn+etanQs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5/1f6aRlN14iJL7c1sDv5qCCyozqru4Q5zrm6+23
 bhtieFGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuf9XwAKCRB33NvayMhJ0QmiD/
 0cQGOKPkqX6cU0x9QJJO5kgeLxEWNCMmiaXRq+A2aNCQ+fs8HZdkCoeFGXp0G1UfOml8WdHK5x6lOi
 5OffvM9k6XMNZAeHIE2hnoVEB44DlwfS3vOF1TA/YZF34KOmaCXetlguh1CCe5fmsPYHioItcckNK9
 6fZd6LZ926SYgSZ0hoMkDNVehzNWM4x1za8B55gfVGlZ1G7eyz1NL3mQB2dwApKBGB8Z8Qk+KXkdvr
 m1w90E1RJD8rDrR65439Ile8kz6hWKqKSKCbQcXbyAEo/5YwHGTHGoVQ0P+V5/2SY5quPuoK1XaE5F
 wOXiNhhLzKCJm1ZFi1JC8ThN2n0wFCAvg3bv/NjQejJ1icKzhFD8EmYZH/N5wAVRC6O9rcnnSTzEv7
 rMbgJ6gUDhcHWYa+0qtUPwaD98HrpbedfOyvdHvQhkpUKyAQb6TeduMIdmwnn8MdyxGetcR/14gWiP
 FKXMC/AZ7mmvBa2Vi60qtMoOkbepcYH+o8W9JTCaYfct9gVcKVxNbyLYBnWTny7rmXbO92CfHm1jf0
 J/9/w90cslrXf/oB3/OdQ8MbQhgWwlNKs41cq2nlbmc+Nmp1uM0PNY84db/3brrA1WLJyHvALwpT3Y
 n/1/jzeknh4zYPpP+G2RQ5h3Pz6hbmV0dyG4mI915l8LKYgzL9j7EmAuIh/w==
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

