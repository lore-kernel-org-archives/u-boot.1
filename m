Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BD5CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F370A848FD;
	Tue, 26 May 2026 16:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ViYXebQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CCCB848B4; Tue, 26 May 2026 16:47:32 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064438490B
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b9ea536877so70453435ad.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779806848; x=1780411648;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Crv4nThtJ2Fx2x07YcHk3iUQT6wGdm0cZLm9VhMojW4=;
 b=ViYXebQtMcK3dhyQLJt64PY2Q2J7w0qwvCOulBdy3oysFH5AWGmshtCeSpUVLXnmwy
 ngX8+KC1ffXYWQyJiUU2teHzgydKMqEsl9k9K6/V81YZnUpgV+SDjA3yM7mi6rSWoigJ
 XdMC9uzkF3my+Ur2S2qAr+LcX5qbj7XVgWT6E3at8xNrtf3CAKC5JXbE/CX5AipBmvMx
 LbsefBmVsDRTUeCIA0OP5J7Qq/ucSNeh13AC3Lr+hxXZclCMFVh7wxCAf2tkGT6TEraC
 4s43a7KM7VtUzM/mOzzN4YM6XMzir026ptTels4eaJwiWFkXcygTIVGDJdHY6eWUcXhH
 i5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806848; x=1780411648;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Crv4nThtJ2Fx2x07YcHk3iUQT6wGdm0cZLm9VhMojW4=;
 b=DmMXV9DEurGyCfdsU95W8tkGso/bRxKs+Nnv7I33gxAerqfZ1hu1z5dbVBja42NPO6
 ObGp+DGN1y4gE2vJ2/qGVufU+Gh48ArFAQJWji6uEZajSAXDEClNi8eZIh3VaZdE3iYd
 HXBK2cogTdqNuZbDIRGDnwMAwaq70TLeftKEqZMZHXN8UhpSLqqosp9cNcxXXXms24eI
 87eMP2gaSvDc7UZI3qkk7A55S6+t/9MbeNAt69K5aXRsIeUjn/MYN7/UxG2BjV7RJQET
 5N5ykwR/HsYqQBeu+iUcxuIiDTRQqBNw+KG9VQh3AnPqgNTA91xuUUJSAFSL6VL70Xzq
 HQQg==
X-Gm-Message-State: AOJu0Yw0wR9pOE5doHK301i+0BpD4OBkNj+Rev0Sb37VCUoY2TsKuOsE
 9NKbt+TdydqxaH16y9Td8UcrW3AlBLF146WJu3gatYaii6RHR5ni6wOKHZ4gZcMIKeI=
X-Gm-Gg: Acq92OHKEc7LRSIumJvl6iF3yBfDeA157D7gMF5QRiz6vqko75607sthO1ySKSzi4/8
 Akc8XNwGKJ/YpObZF5TPTmkK5TyZJ6CXAZs9pJY0OwVlEU40Dkb7hPd0TEXzttoLEPoHSkKg8gG
 y0fJ9ac+Z+NUDoSmIbBsqRfCMBAZlRy3RiiKBl8CrDY6Bq1XpEpLm8UD47kq3JiIzjWy/eSZmHF
 3wM/PqJvGfVKP2B3X5trG8B+GM4qgBiwWDlLVsyxxIFdNg8PY3dThXKQaIUATYMAdyNC4V38np8
 6gvALbMKsPOXpc96YPS9U+zqgfYYWWKdK3r6sQQhNI1xPl4mq5JpcdRGDfdWY2EH3m9OHtiGTzB
 sEg4sjtCmPSwgzID1e/cCzcITPT/8hB5XpAn+bo4Zgqd5ASeGWD+0/0JJNhaqE8F3vecE0Jyoeb
 EJ4sA7dd/1w4xkm8toJRhx8nZ7utBjd3yGvgP+tctVOlBno7XZP+Gxzw==
X-Received: by 2002:a17:902:c946:b0:2bc:e299:4b3f with SMTP id
 d9443c01a7336-2beb085f3d0mr178695315ad.10.1779806848367; 
 Tue, 26 May 2026 07:47:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f4343sm169559915ad.36.2026.05.26.07.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:47:28 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 26 May 2026 22:45:45 -0400
Subject: [PATCH v2 5/8] dts: k1: switch BPI-F3 build to upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-k1-clk-reset-upstream-dts-v2-5-af815e362b0c@riscstar.com>
References: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
In-Reply-To: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
To: u-boot@lists.denx.de
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
 Vincent Legoll <legoll@online.fr>, Guodong Xu <docularxu@outlook.com>, 
 Guodong Xu <guodong@riscstar.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

Adopt the kernel device tree directly from
dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts instead of carrying
a forked copy under arch/riscv/dts/.

The U-Boot-only overlay k1-bananapi-f3-u-boot.dtsi carries the binman
description and a memory@0 node, since the upstream kernel DT has no
memory node (RAM is filled in by the bootloader).

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
Changes in v2:
- Drop the helper clocks/clock-names from &syscon_mpmu and &syscon_apbc;
- Reword the commit message.
---
 arch/riscv/dts/Makefile                   |  1 -
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 13 +++++++++++++
 configs/bananapi-f3_defconfig             |  3 ++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8e591cb7aa9..71c5c13d221 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -2,7 +2,6 @@
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
-dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
new file mode 100644
index 00000000000..5c8789efddb
--- /dev/null
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 RISCstar Ltd.
+ */
+
+#include "binman.dtsi"
+
+/ {
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
+	};
+};
diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
index 9f9424adc9f..b9a2ee19f53 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/bananapi-f3_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
-CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
+CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_TARGET_BANANAPI_F3=y
@@ -16,6 +16,7 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y

-- 
2.43.0

